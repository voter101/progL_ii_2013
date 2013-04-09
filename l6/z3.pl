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

delete(E,node(leaf,E,leaf),leaf).

delMax(Source,Result,E) :-
    findMax(Source,E),
    delete(E,Source,Result).

empty(leaf).
