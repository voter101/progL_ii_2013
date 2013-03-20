leaf.
insert(I,leaf,node(leaf,I,leaf)) :- !.
insert(I,node(L,E,P),node(L1,E,P)) :-
    I < E,!,
    insert(I,L,L1).
insert(I,node(L,E,P),node(L,E,P1)) :-
    insert(I,P,P1).

treeSort(X,Y) :-
    createTree(X,Z,leaf),
    flatten(Z,Y).
createTree([],X,X).
createTree([H|T],X,Y) :-
    insert(H,Y,Y1),
    createTree(T,X,Y1).
