flower(rose,red).
flower(marigold,yellow).
flower(tulip,red).
flower(daffodil,yellow).
flower(rose,yellow).
flower(maigold,red).
flower(rose,white).
flower(cornflower,purple).

bouquet(A):-
    findall([(F,C)],(flower(F,C),,A).
