insert([],X,[X]) :- !.
insert([H|T],X,[X,H|T]) :-
    H >= X,!.
insert([H|T],X,[H|R]) :-
    H < X,
    insert(T,X,R).
    
ins_sort([],[]).
ins_sort([H|T],X) :-
    ins_sort(T,L1),
    insert(L1,H,L).
