select_min([],_) :-
select_min([X],X).
select_min([H|T],M) :-
    select_min(T,M1),
    H<M1,
    M is H.
select_min([H|T],M) :-
    select_min(T,M1),
    H>=M1,
    M is M1.
select_min(L,X,R) :-
    select_min(L,X).
    select(X,L,R).

sel_sort([],[]).
sel_sort(X,[M|T]) :-
    select_min(X,M,R),
    sel_sort(R,T),!.
