#include "../input.lp".

%#const horizon=1.
time(1..horizon).

% - Original --- direction((X,Y)) :- X=-1..1, Y=-1..1, |X+Y|=1.
% possibilities (1,0)(-1,0)(0,1)(0,-1) expand (1,1) (1,-1),(-1,-1)(-1,1)
direction((X,Y)) :- X=-1..1, Y=-1..1, |X+Y|=1.
direction((X,Y)) :- X=-1..1, Y=-1..1, |X|+|Y|=2.


nextto((X,Y),(DX,DY),(X',Y')) :- direction((DX,DY)), position((X,Y)), position((X',Y')),
                                 (X,Y)=(X'-DX,Y'-DY), (X',Y')=(X+DX,Y+DY).

{ move(R,D,T) : direction(D) } 1 :- isRobot(R), time(T).

% - move/3 ----------------------------------------------------------------------
position(R,C,T) :- move(R,D,T), position(R,C',T-1),     nextto(C',D,C).
                :- move(R,D,T), position(R,C ,T-1), not nextto(C ,D,_).

% - inertia ---------------------------------------------------------------------
position(R,C,T) :- position(R,C,T-1), not move(R,_,T), isRobot(R), time(T).

% - edge collision --------------------------------------------------------------
moveto(C',C,T) :- nextto(C',D,C), position(R,C',T-1), move(R,D,T).
 :- moveto(C',C,T), moveto(C,C',T), C < C'.
 % see Colutions_and_Comments
             crossFront() :- isRobot(R), isRobot(R'), R < R', X=1, Y=1, X'=-1, move(R,(X,Y), T), move(R',(X',Y),T).
             crossRear() :- isRobot(R), isRobot(R'), R < R', X=1, Y=-1, X'=-1, move(R,(X,Y), T), move(R',(X',Y),T).
             crossRight() :- isRobot(R), isRobot(R'), R < R', Y=1, Y'=-1, X=-1, move(R,(X,Y'), T), move(R',(X,Y),T).
             crossLeft() :- isRobot(R), isRobot(R'), R < R', Y=1, Y'=-1, X=1, move(R,(X,Y'), T), move(R',(X,Y),T).
             :- not crossFront().
             :- not crossRear().
             :- not crossRight().
             :- not crossLeft().

% - vertex collision ------------------------------------------------------------
 :- { position(R,C,T) : isRobot(R) }  > 1, position(C), time(T).

% - auxiliaries -----------------------------------------------------------------
 :- { position(R,C,T) } != 1, isRobot(R), time(T).    % REDUNDANT but PERFORMANT?
