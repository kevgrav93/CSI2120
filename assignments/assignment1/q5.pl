flower(rose,red).
flower(marigold,yellow).
flower(tulip,red).
flower(daffodil,yellow).
flower(rose,yellow).
flower(marigold,red).
flower(rose,white).
flower(cornflower,purple).

% Note this will return the "same" set of flowers
% eg. will return both `[(rose,red), (marigold,red), (tulip, yellow)]` and
% `[(marigold,red), (rose,red), (tulip, yellow)]`
bouquet(A):-
    setof([(F,C),(F1,C1),(F2,C2)],
        (
            flower(F,C),
            flower(F1,C1),
            flower(F2,C2),
            (
                (
                    C = red,
                    C1 = C,
                    not(C2 = C1)
                );
                (
                    not(C = C1),
                    not(C1 = C2),
                    not(C = C2),
                    not(C = red),
                    not(C1 = red),
                    not(C2 = red)
                )
            ),
            not(F = F1),
            not(F = F2),
            not(F1 = F2),
            writeln([(F,C),(F1,C1),(F2,C2)])
        ),
    A).
