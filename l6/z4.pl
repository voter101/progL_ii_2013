% Zacząłem robić zadanie, jednak z powodu braku czasu musiałem z niego zrezygnować
s(0).
s(2).
s(4).
s(6).
s(8).
c(1).
c(3).
c(5).
c(7).
c(9).
multiply(_,[],X).
multiply(E,[H|T],
checkPattern([],[]) :- !.
checkPattern([H|T],[H1|T1]) :-
    (s(H),s(H1);c(H),c(H1)),
    checkPattern(T,T1).
