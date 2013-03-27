split([],_,[],[]) :- !.
split([H|T],Med,[H|X],Y) :-
    H < Med,!,
    split(T,Med,X,Y).
split([H|T],Med,X,[H|Y]) :-
    split(T,Med,X,Y).
