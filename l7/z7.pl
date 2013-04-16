!(0,1):- !.
!(1,1):- !.
!(X,Y):-
    X1 is X - 1,
    !(X1,Y1),
    Y is Y1 * X.
:-arithmetic_function(!/1).
:-op(300, yf, !).
% Jakie problemy to tworzy? Oprócz tego, że trzeba tak dziwacznie wywoływać funkcję
% ( N is 3'!!'), to nie wiem. ;)
'!!'(0,0) :- !.
'!!'(1,1) :- !.
'!!'(X,Y) :-
    Z is X mod 2,
    Z = 0,!,
    X1 is X - 1,
    '!!'(X1,Y).
'!!'(X,Y) :-
    X1 is X - 2,
    '!!'(X1,Y1),
    Y is Y1 * X.
:-arithmetic_function('!!'/1).
:-op(300, yf, '!!').
