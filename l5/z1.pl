flatten(X,Y) :- flatten(X,Y,[]).
flatten([],X,X) :- !.
flatten([H|T],L,A) :-
    is_list(H),!,
    flatten(T,A1,A),
    flatten(H,L,A1).
flatten([H|T],[H|L],A) :- flatten(T,L,A).
