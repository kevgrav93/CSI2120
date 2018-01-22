% Lab 2: Quiz 2 (from. Exercise 4)
% Francisco Trindade - 7791605
% ftrin010@uottawa.ca

seriesNM(0,_,0).

seriesNM(1,M,Y) :-
    Y is 3*M.

seriesNM(N,M,Y) :-
    N > 1,
    N1 is N-1,
    N2 is N1-1,
    seriesNM(N1,M,Y1),
    seriesNM(N2,M,Y2),
    Y is 3*Y1+2*Y2.
