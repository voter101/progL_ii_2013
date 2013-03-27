halve(X,L,R) :- halve(X,X,L,R).
halve(R,[],[],R) :- !.
halve(R,[_],[],R) :- !.
halve([H|T],[_,_|X],[H|L],R) :- halve(T,X,L,R).
