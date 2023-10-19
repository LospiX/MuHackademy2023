:- use_module(library(clpb)).

%%%%%% PUZZLE 1 %%%%%%
%
%   Incontri due abitanti,
%   A dice: 
%       "O io sono un furfante o B è un cavaliere"
%
% ?- sat(~A + B).
% ?- sat(~A + B), labeling([A, B]).
% ?- sat(A =:= ~A + B), labeling([A, B]).


%%%%%% PUZZLE 2 %%%%%%
%
%   Incontri due abitanti,
%   A dice:
%       "Io sono un furfante ma B non lo è"
%
% ?- sat(A =:= (~A * B)).


%%%%%% PUZZLE 3 %%%%%%
%
%   Incontri tre abitanti,
%   A dice:
%       "Siamo tutti furfanti"
%   B dice:
%       "Solo uno di noi è un cavaliere"
%
% ?- sat(A =:= ~A * ~B * ~C), sat(B =:= (A * ~B * ~C) + (~A * B * ~C) +  (~A * ~B * C)).
