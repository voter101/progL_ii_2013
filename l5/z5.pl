split([],_,[],[]) :- !.
split([H|T],Med,[H|X],Y) :-
    H < Med,!,
split(T,Med,X,Y).
split([H|T],Med,X,[H|Y]) :-
    split(T,Med,X,Y).

qsort(X,Y) :- qsort(X,Y,[]).
qsort([],X,X).
qsort([H|T],R,A) :-
    split(T,H,S,B),
    qsort(B,A1,A),
    qsort(S,R,[H|A1]).
