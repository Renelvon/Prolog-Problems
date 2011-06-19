% 2.07
% Generalised for negative numbers.
% Implementation as arithmetic function pending...
gcd(N, M, G) :-
	integer(N), integer(M),
	Nabs is abs(N), Mabs is abs(M),
	(Nabs > Mabs -> gcd_P(Nabs, Mabs, G) ; gcd_P(Mabs, Nabs, G)).

gcd_P(X, 0, X) :- !.
gcd_P(X, Y, G) :- Z is X mod Y, gcd_P(Y, Z, G).

% 2.08
coprime(X, Y) :- gcd(X, Y, F), !, F is 1.
