% 7.04
operator(X) :- member(X, [+, -, *, /]).

insertSymb([Num], [Num]).
insertSymb([Num | NumRest], [Num, Symb | ArithRest]) :-
   operator(Symb), insertSymb(NumRest, ArithRest).

evalExprAdv([], Num, Num).
evalExprAdv([Operator, Num2 | SymbRest], Num1, ExprResult) :-
   Praxi =.. [Operator, Num1, Num2],
   Result is Praxi,
   evalExprAdv(SymbRest, Result, ExprResult).

evalExpr([Num | NumRest], ExprResult) :-
   evalExprAdv(NumRest, Num, ExprResult).
   
genSolArithm(NumList, SymbSolution) :-
   append(LeftNums, RightNums, NumList),
   insertSymb(LeftNums, LeftExpr),
   insertSymb(RightNums, RightExpr),
   evalExpr(LeftExpr, LeftResult),
   evalExpr(RightExpr, RightResult),
   LeftResult =:= RightResult,
   append(LeftExpr, [=|RightExpr], SymbSolution).
