degToRad(A,B) :-
    B is pi*(A/180).

distance(Lat1,Lon1,Lat2,Lon2,D) :-
    degToRad(Lat1,LatR1),
    degToRad(Lon1,LonR1),
    degToRad(Lat2,LatR2),
    degToRad(Lon2,LonR2),
    A is (sin((LatR1-LatR2)/2))^2,
    B is cos(LatR1)*cos(LatR2)*(sin((LonR1-LonR2)/2))^2,
    C is 2*asin(sqrt(A+B)),
    D is C*6371.0.
