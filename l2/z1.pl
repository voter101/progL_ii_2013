% Predykat z zadania
append([], X, X).
append([H|T], X, [H|Y]):-
    append(T, X, Y).
