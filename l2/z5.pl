append([], X, X).
append([H|T], X, [H|Y]):-
    append(T, X, Y).
reverse([],[]).
reverse([H|T], X) :-
    reverse(T,Y),
    append(Y,[H],X).

% a)
head(H, [H|_]).

% b)
last(X, [H|T]) :-
    reverse([H|T], [X|_]).

% c)
tail([H|T],[_,H|T]).

% d)
init([H|T],[H2|T2]) :-
    reverse([H2|T2],X),
    reverse([H|T],[_|X]).

% e)
% Robię tutaj prefix właściwy, ale niżej w komentarzu dorzucam regułę dla 
% zwykłych prefiksów
prefix([],[_|_]).
% 25 linia - głowa jest zawsze pierwszym elementem listy, a jej ogonem jest
% zawsze lista, a więc w szczególności lista pusta.
%%prefix([X],[X]).
prefix([H|PT], [H|T]) :-
   prefix(PT,T). 

% f)
suffix([H|T],[HS|TS]) :-
    reverse([H|T],X),
    reverse([HS|TS],Y),
    prefix(Y,X).
