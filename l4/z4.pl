leaf.
% Nieprzetestowane
mirror(leaf,leaf).
mirror(node(TL,E,TR),node(TL1,E,TR1)) :-
    mirror(TL,TR1),
    mirror(TR,TL1).
