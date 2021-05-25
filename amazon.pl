:- dynamic(bloqueado/1).

lista([1, 2, 3]).

estado_inicial(e(p1(0, 0), p2(2, 2), [((0, 0), 0), ((0, 1), 0), ((0, 2), 0), ((1, 0), 0), ((1, 1), 0), ((1, 2), 0), ((2, 0), 0), ((2, 1), 0), ((2, 2), 0)], p1)).

terminal(E):- \+op1(E, _, _).


%diagonal p1
op1(e(p1(X0, Y0), p2(Xp, Yp), Bloqueados, p1), a(move(X, Y)), e(p1(X1, Y1), p2(Xp, Yp), Bloqueados, p2)):- lista(L),
																														   member(NX, [-1, 1]),
																														   member(NY, [-1, 1]), 
																							  							   lista(L),
																												  	       member(X2, L),
																												  	       member(Y2, L),
																												  	       X is X2 * NX,
																												  	       Y is Y2 * NY,
																												  	       X1 is X0 + X,
																												  	       Y1 is Y0 + Y,
																												  	       (X1, Y1) \= (Xp, Yp),
																												  	       limites(X1, Y1),
																												  	       bloquear(X1, Y1, Xp, Yp, Bloqueados).

%diagonal p2
op1(e(p1(Xp, Yp), p2(X0, Y0), Bloqueados, p2), a(move(X, Y)), e(p1(Xp, Yp), p2(X1, Y1), Bloqueados, p1)):- lista(L),
																								   member(NX, [-1, 1]),
																								   member(NY, [-1, 1]), 
																							  	   lista(L),
																							  	   member(X2, L),
																							  	   member(Y2, L),
																							  	   X is X2 * NX,
																							  	   Y is Y2 * NY,
																							  	   X1 is X0 + X,
																							  	   Y1 is Y0 + Y,
																							  	   (X1, Y1) \= (Xp, Yp),
																							  	   limites(X1, Y1),
																							  	   bloquear(X1, Y1, Xp, Yp, Bloqueados).																							  	   

%horizontal p1
op1(e(p1(X0, Y0), p2(Xp, Yp), Bloqueados, p1), a(move(X, 0)), e(p1(X1, Y0), p2(Xp, Yp), Bloqueados, p2)):- lista(L),
																								   member(NX, [-1, 1]),
																								   lista(L),
																								   member(X2, L),
																								   X is X2 * NX,
																								   X1 is X0 + X,
																								   (X1, Y0) \= (Xp, Yp),
																								   limites(X1, Y0),
																								   bloquear(X1, Y0, Xp, Yp, Bloqueados).

%horizontal p2
op1(e(p1(Xp, Yp), p2(X0, Y0), Bloqueados, p2), a(move(X, 0)), e(p1(Xp, Yp), p2(X1, Y0), Bloqueados, p1)):- lista(L),
																								   member(NX, [-1, 1]),
																								   lista(L),
																								   member(X2, L),
																								   X is X2 * NX,
																								   X1 is X0 + X,
																								   (X1, Y0) \= (Xp, Yp),
																								   limites(X1, Y0),
																								   bloquear(X1, Y0, Xp, Yp, Bloqueados).
%vertical p1
op1(e(p1(X0, Y0), p2(Xp, Yp), Bloqueados, p1), a(move(0, Y)), e(p1(X0, Y1), p2(Xp, Yp), Bloqueados, p2)):- lista(L),
																								   member(NY, [-1, 1]),
																								   lista(L),
																								   member(Y2, L),
																								   Y is Y2 * NY,
																								   Y1 is Y0 + Y,
																								   (X0, Y1) \= (Xp, Yp),
																								   limites(X0, Y1),
																								   bloquear(X0, Y1, Xp, Yp, Bloqueados).

%vertical p2
op1(e(p1(Xp, Yp), p2(X0, Y0), Bloqueados, p2), a(move(0, Y)), e(p1(Xp, Yp), p2(X0, Y1), Bloqueados, p1)):- lista(L),
																								   member(NY, [-1, 1]),
																								   member(Y2, L),
																								   Y is Y2 * NY,
																								   Y1 is Y0 + Y,
																								   (X0, Y1) \= (Xp, Yp),
																								   limites(X0, Y1),
																								   bloquear(X0, Y1, Xp, Yp, Bloqueados).				   


limites(X, Y):- X >= 0,
				X =< 2,
				Y >= 0,
				Y =< 2.


bloquear(X1, Y1, Xp, Yp, []).

bloquear(X1, Y1, Xp, Yp, [((BX, BY), BB)| R]):- BX = X1,
												BY = Y1,
											 	(BB = 0,
													(member(A, [0, 1, 2]),
													 member(B, [0, 1, 2]),
													 (A, B) \= (X1, Y1),
													 (A, B) \= (Xp, Yp),
													 BB is 1
													)
												);
												bloquear(X1, Y1, Xp, Yp, R).


														 
												 		
											 


valor(E,-1,P):- terminal(E),
				R is P mod 2,
				R=1.

valor(E,1,P):- terminal(E),
			   R is P mod 2,
			   R=0.