flatten(T, L) :-
     flatten(T,[],L).
flatten(leaf,A,A).
flatten(node(L,E,R),A,X) :-
    flatten(R,A,A1),
    flatten(L,[E|A1],X).
