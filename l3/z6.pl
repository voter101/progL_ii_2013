reverse(X,Y) :-
    reverse(X,[],Y),!. % To odcięcie w tym mejscu wystarczy

reverse([],A,A).
reverse([H|T],A,Y) :-
    reverse(T,[H|A],Y).
