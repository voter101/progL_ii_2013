% Predykat z zadania
select(H, [H|T], T).
select(X, [H|T], [H|S]) :-
    select(X, T, S).
