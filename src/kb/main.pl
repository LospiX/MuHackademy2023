:- discontiguous(madre/2).
:- discontiguous(padre/2).

padre('Bardock', 'Goku').
padre('Bardock', 'Raditz').
madre('Gine', 'Goku').
madre('Gine', 'Raditz').

padre('Ox King', 'Chi-Chi').

padre('Goku', 'Gohan').
padre('Goku', 'Goten').
madre('Chi-Chi', 'Gohan').
madre('Chi-Chi', 'Goten').
% padre('Goten', 'Xavier').

padre('Mr. Satan', 'Videl').

padre('Gohan', 'Pan').
madre('Videl', 'Pan').

madre('Pan', 'Goku Jr.').

padre('King Vegeta', 'Vegeta').
padre('King Vegeta', 'Tarble').

padre('Vegeta', 'Trunks').
padre('Vegeta', 'Bulla').
madre('Bulma', 'Trunks').
madre('Bulma', 'Bulla').

padre('Dr. Brief', 'Bulma').
padre('Dr. Brief', 'Tights').
madre('Panchy', 'Bulma').
madre('Panchy', 'Tights').

fratelli(X, Y):-
    dif(X, Y),
    padre(P,X),
    padre(P,Y),
    madre(M,X),
    madre(M,Y).

figli(Genitore, Figli):-
    bagof(F, (padre(Genitore, F); madre(Genitore, F)), Figli).

genitore(Genitore, Figlio):-
    madre(Genitore, Figlio)
    ;
    padre(Genitore, Figlio).

zio(Zio, Nipote):-
    genitore(Genitore, Nipote),
    fratelli(Genitore, Zio).

cugino_primo_grado(Cugino0, Cugino1):- 
    genitore(Gen1, Cugino1),
    zio(Gen1, Cugino0).
