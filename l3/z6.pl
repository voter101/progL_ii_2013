reverse(X,Y) :-
    reverse(X,[],Y),!.

reverse([],A,A).
reverse([H|T],A,Y) :-
    reverse(T,[H|A],Y).
