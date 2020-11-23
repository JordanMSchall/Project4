#include "../abc/action-MPP.lp".


% Determine left/right x-coordinates
side(X, left) :- SX = #max{ X' : position((X',_)) },  X<=(SX+1)/2, position((X,_)).
side(X, right) :- SX = #max{ X' : position((X',_)) }, X> (SX+1)/2, position((X,_)).

% Group robots into left/rigth side wrt their initial position
isRight(R,T):- position(R,(X,Y),T), side(X,right), isRobot(R).
isLeft(R,T):- position(R,(X,Y),T), side(X,left), isRobot(R).

% Forbid robots to occupy a position on the other side
:- isRobot(R), isRight(R,T), isLeft(R,T-1).
:- isRobot(R), isRight(R,T-1), isLeft(R,T).
