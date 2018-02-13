absDiffA([],[],[]).

absDiffA([H|T],[],A):-
    absDiffA(T,[],AA),
    append([H],AA,A).

absDiffA([],[H|T],A):-
    absDiffA([],T,AA),
    append([H],AA,A).

absDiffA([H1|T1],[H2|T2],A):-
    absDiffA(T1,T2,AA),
    H3 is abs(H1-H2),
    append([H3],AA,A).

absDiffB([],[],[]).
absDiffB([H|T],[],[]).
absDiffB([],[H|T],[]).
absDiffB([H1|T1],[H2|T2],A):-
    absDiffB(T1,T2,AA),
    H3 is abs(H1-H2),
    append([H3],AA,A).
