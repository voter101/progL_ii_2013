% a)
filter([],[]) :- !.
filter([H|T],[H|T1]) :-
    H > 0, !,
    filter(T,T1).
filter([H|T], T1) :-
    H =< 0,
    filter(T,T1).
% b)
count(_,[],0).
count(X,[X|T],C) :-
    count(X,T,D),
    C is D+1,
    !.
count(X,[H|T],C) :-
    \+X=H,
    count(X,T,C).
% c)
exp(_,0,1) :- !.
exp(X,Y,R) :-
    Y1 is Y - 1,
    exp(X,Y1,R1),
    R is R1 * X.
