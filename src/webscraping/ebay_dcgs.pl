:- set_prolog_flag(double_quotes, chars).
seq([]) --> [].
seq([L|Ls]) --> [L], seq(Ls).

% ?- phrase(seq("abc"), L).
% ?- phrase((seq("abc"), seq("def"), L).
% ?- phrase((seq(Xs), seq(Ys), L).
%
% --> Concatenation of any number of lists
seqq([]) --> [].
seqq([Ls| Lss]) --> seq(Ls), seqq(Lss).
% ?- phrase(seqq(["ab", "bc", "de"]), X).

% --> Reverse of a list
qes([]) --> [].
qes([L|Ls]) --> qes(Ls), [L].

% --> ... describe any sequence
... --> [] | [_], ... .
% Last element of a list
% ?- phrase((..., [Last]), "asbdsx").
% ?- phrase((..., "b", ...), "asbdsx").
% ?- length(Ls,_), phrase((..., "b", ...), Ls).
% ?- phrase((..., [X,X], ...), "helloo!oo!").

word([C|Cs]) --> [C], {char_type(C, alpha) }, word(Cs).
word([]) --> [].

words([]) --> [].
words([W | Ws]) --> ws, word(W), ws, words(Ws).

ws --> [W], {char_type(W, space)}, ws | [].

integer(I)--> digits(Ds), {number_chars(I, Ds)}.

digits([D|Ds]) --> digit(D), digits_r(Ds).
digits_r([D|Ds]) --> digit(D), digits_r(Ds). 
digits_r([]) --> [].
digit(D) --> [D], {char_type(D, digit)}.

decimal(I)--> 
    digits(Int), dec_part(Dec), 
    {
        append(Int, Dec, Ds), 
        select(',', Ds,'.',IC),
        number_chars(I, IC)
    }.
decimal(I)--> integer(I).
%dec_part([H|Dp])--> [H], {H='.'}, digits_r(Dp).
dec_part([H|Dp])--> [H], {H=','}, digits_r(Dp).

price(P) --> ..., "EUR", ...,decimal(P), ... .
apple_item --> ..., apple, ... .
apple --> 
    (['A'];['a']),
    (['P'];['p']),
    (['P'];['p']),
    (['L'];['l']),
    (['E'];['e']).
%atom_chars(' the appLe is ', C), phrase((apple_item), C).

same_char(C1, C2):-
    C1=C2.
same_char(C1, C2):-
    catch(char_code(C1, CC1), _, fail),
    CC2 is CC1 + 32, 
    char_code(C2, CC2),
    char_type(C1, alpha), 
    char_type(C2, alpha).
same_char(C1, C2):-
    catch(char_code(C1, CC1), _, fail),
    CC2 is CC1 - 32, 
    char_code(C2, CC2),
    char_type(C1, alpha), 
    char_type(C2, alpha).

same_chars(S1, S2):-
    (
    catch(maplist(same_char, S2, S1), _, fail)
        ;
    catch(maplist(same_char, S1, S2), _, fail)
    ).
string_upper([], []).
string_upper([C|T], [C1|T1]):-
    (upcase_atom(C, C1); downcase_atom(C1, C)),
    string_upper(T, T1).
case_insensitive_compare(String1, String2) :-
    atom_string(Atom1, String1), % Convert String1 to an atom
    atom_string(Atom2, String2), % Convert String2 to an atom
    downcase_atom(Atom1, Lower1),   % Convert Atom1 to lowercase
    downcase_atom(Atom2, Lower2),   % Convert Atom2 to lowercase
    Lower1 = Lower2.        

'Ast'(X, Y):-
    X > Y.

filtered_maplist(_, [], [], [], []).
filtered_maplist(P, [X1|Xs1], [X2|Xs2], IncludedX1, IncludedX2) :-
    (   call(P, X1, X2)
    ->  
        IncludedX1 = [X1|Included1],
        IncludedX2 = [X2|Included2]
    ;   
        IncludedX1 = Included1,
        IncludedX2 = Included2
    ),
    filtered_maplist(P, Xs1, Xs2, Included1, Included2).

% ?- A=['EUR 5,2' ,'EUr 4', ' EUR 8', 'EUR 4,123', 'EUR 1,23'], filtered_maplist([X, Y]>>(atom_chars(X, Cs), phrase((price(Y)), Cs)), A, _, H, K).

