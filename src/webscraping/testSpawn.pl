:- use_module(library(spawn)).
:- use_module(library(yall)).

pred(A, B):-
    sleep(A), 
    B is A.

te(Lis):-
    numlist(0,10,L),
    maplist(
        [Number, Res, Tk] >> (
            async(pred(Number, Res), Tk)
        ),
        L, 
        Lis,
        Tokens
    ),
    maplist(await, Tokens).


