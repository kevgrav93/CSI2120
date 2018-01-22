sum_int(0,X) :-
    X is 0.

sum_int(N,X) :-
    N > 0,
    N1 is N-1,
    sum_int(N1,X1),
    X is X1+N.
