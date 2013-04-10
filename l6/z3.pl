leaf.
insert(E,leaf,node(leaf,E,leaf)):- !.
insert(E,node(L,A,R),node(L1,A,R)) :-
    E < A,!,
    insert(E,L,L1).
insert(E,node(L,A,R),node(L,A,R1)) :-
    E > A,!,
    insert(E,R,R1).
insert(E,node(L,E,R),node(L,E,R)).

find(_,leaf) :- fail.
find(E,node(_,E,_)) :- !.
find(E,node(L,A,_)) :-
    E < A,!,
    find(E,L).
find(E,node(_,_,R)) :-
    find(E,R).

findMax(node(_,M,leaf),M) :- !.
findMax(node(_,_,R), M) :-
    findMax(R,M).

delete(E,node(leaf,E,leaf),leaf) :- !.
delete(E,node(L,X,R),node(L1,X,R)) :-
    E < X, !,
    delete(E,L,L1).
delete(E,node(L,X,R),node(L,X,R1)) :-
    delete(E,R,R1).
delete(E,node(L,E,R),R1) :-
    insertRight(R,L,R1).
insertRight(T,node(L,E,leaf),node(L,E,T)) :- !.
insertRight(T,node(L,E,R), node(L,E,R1)) :-
    insertRight(T,R,R1).

delMax(Source,Result,E) :-
    findMax(Source,E),
    delete(E,Source,Result).

empty(leaf).
