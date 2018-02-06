oddEven([H|T], L) :-
    oddEven([H|T], [], L).

oddEven([], L, L).

oddEven([H|T], L1, L) :-
    H mod 2 =:= 0,
    append(L1,[even],L2),
    oddEven(T,L2,L).

oddEven([H|T], L1, L) :-
    H mod 2 =:= 1,
    append(L1,[odd],L2),
    oddEven(T, L2, L).