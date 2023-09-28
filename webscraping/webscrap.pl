:- use_module(library(http/http_open)).
:- use_module(library(sgml)).
:- use_module(library(xpath)).
:- use_module(library(spawn)).

run(DOM):-
    process_create(path('node.exe'), ['getRenderedWebPage.js'], [stdout(pipe(S))]),
    load_html(stream(S), DOM, []).
