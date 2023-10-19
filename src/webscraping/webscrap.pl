:- use_module(library(http/http_open)).
:- use_module(library(sgml)).
:- use_module(library(xpath)).
:- use_module(library(spawn)).
:- use_module(library(yall)).
:- use_module(library(reif)).
:- use_module(library(csv)).

:- include('./ebay_dcgs.pl').



get_ebay_solditems(NumPages, SoldedObjects, FileName):-
    numlist(0, NumPages, PagesNumList),
    maplist(
        [PageNumber, Objects, Tk] >> (
            async(fetch_page_objects(PageNumber, Objects), Tk)
        ),
        PagesNumList, 
        PageObjects,
        Tokens
    ),
    maplist(await, Tokens),
    flatten(PageObjects, SoldedObjects),
    maplist(
        [Obj, DataObj] >> (
            Obj= ebay_item(T,P,D),
            DataObj = data(T,P,D)
        ),
        SoldedObjects,
        DataToSave
    ),
    csv_write_file(FileName, DataToSave).

    fetch_page_objects(Page, Elems):-
        process_create(path('node.exe'), ['getRenderedWebPage.js', Page], [stdout(pipe(S))]),
        load_html(stream(S), DOM, []),
        findall(
        E, 
        (
            xpath(DOM, //div(@class='s-item__wrapper clearfix'), Item),
            titolo_oggetto(Item, Titolo),
            prezzo_oggetto(Item, Prezzo),
            data_oggetto(Item, Data), 
            E= ebay_item(Titolo, Prezzo, Data)
        ),
        Elems
    ).

titolo_oggetto(DomElement, Titolo):-
    xpath(
        DomElement,
        //span(@'aria-level'(number)=3),
        element(_,_,[Titolo| _])
    ), 
    atomic(Titolo).
prezzo_oggetto(DomElement, Prezzo):-
    xpath(
        DomElement,
        //span(@'class'='s-item__price'),
        element(_,_,[element(_,_,[Prezzo|_])| _])
    ).
data_oggetto(DomElement, Data):-
    xpath(
        DomElement,
        //div(@'class'='s-item__title--tag'),
        element(_,_,[element(_,_,[Data|_])|_])
    ).
