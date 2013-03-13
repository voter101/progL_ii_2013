abc(X) :-
    X1 is X * 10.
    write X1.
factorial(1,1) :- !.
factorial(X,Y) :-
    X1 is X - 1,
    factorial(X1,Y1),
    Y is Y1 * X.
concat_number([H|T],X) :-
    X1 is X % 10,
    X2 is X1 % 1,
    X3 is X1 - X2,
    H = X3.
    %    concat_number(T,1
