select_min([X],X,[]).
select_min([H|T],H,[M|R]) :-
    select_min(T,M,R),
    M > H.
select_min([H|T],M,[H|R]) :-
    select_min(T,M,R).

sel_sort([],[]).
sel_sort(X,[M|T]) :-
    select_min(X,M,R),
    sel_sort(R,T),!.
