% Cukier syntaktyczny
word --> "".
word --> "a", word, "b".
% Ile program robi nawrótów?
% "" - 0
% "aabb" - 1 (? - do czasu zwrócenia true, robi tylko 1 nawrót)
% "aba" - 3
word2(X) --> word2(0,X).
word2(X,X) --> [].
word2(X,Y) --> [a],word2(X1,Y),{X is X1+2},[b].
