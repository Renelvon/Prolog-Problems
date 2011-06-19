% 1.01
my_last([X], X).
my_last([_ | T], X) :- my_last(T, X).

% 1.02
my_last_but_one([X, _], X).
my_last_but_one([_ | T], X) :- my_last_but_one(T, X).

% 1.03
element_at(X, [X | _], 1).
element_at(X, [_ | T], N) :- N > 1, NewN is N - 1, element_at(X, T, NewN).

% 1.04
my_length(List, N) :- my_length_TR(List, 0, N).

my_length_TR([], Acc, Acc).
my_length_TR([_ | T], Acc, N) :- NewAcc is Acc + 1, my_length_TR(T, NewAcc, N).

% 1.05
my_reverse(List, RList) :- my_reverse_TR(List, [], RList).

my_reverse_TR([], Acc, Acc).
my_reverse_TR([H | T], Acc, RList) :- my_reverse_TR(T, [H | Acc], RList).

% 1.06
palindrome(X) :- reverse(X, X).

% 1.07
my_flatten(List, FlatList) :- my_flatten_TR(List, [], FlatList).

my_flatten_TR([], Acc, RList) :- reverse(Acc, RList).
my_flatten_TR([[] | T], Acc, RList) :-
	!, my_flatten_TR(T, Acc, RList).
my_flatten_TR([[A | B] | T], Acc, RList) :-
	!, my_flatten_TR([A | [B | T]], Acc, RList).
my_flatten_TR([Atom | T], Acc, RList) :- my_flatten_TR(T, [Atom | Acc], RList).
									  
% 1.08
compress([], []).
compress([H | T], CompList) :- compress_TR(T, H, [], CompList).

compress_TR([], H, Acc, RAcc) :- reverse([H | Acc], RAcc).
compress_TR([H | T], H, Acc, RList) :- !, compress_TR(T, H, Acc, RList).
compress_TR([X | T], H, Acc, RList) :- compress_TR(T, X, [H | Acc], RList).

% 1.09
pack([], []).
pack([H | T], PackList) :- pack_TR(T, H, [], [], PackList).

pack_TR([], H, CurrAcc, TotalAcc, PackList) :-
	reverse([[H | CurrAcc] | TotalAcc], PackList).
pack_TR([H | T], H, CurrAcc, TotalAcc, PackList) :-
	!, pack_TR(T, H, [H | CurrAcc], TotalAcc, PackList).
pack_TR([X | T], H, CurrAcc, TotalAcc, PackList) :-
	pack_TR(T, X, [], [[H | CurrAcc] | TotalAcc], PackList).
	
% 1.10
encode(InList, EncList) :-
	pack(InList, PackList), encode_TR(PackList, [], EncList).

encode_TR([], Acc, EncList) :- reverse(Acc, EncList).
encode_TR([L | T], Acc, EncList) :-
	L = [Elem | _], length(L, Ln), encode_TR(T, [[Ln, Elem] | Acc], EncList).
	
% 1.11
encode_modified(InList, EncList) :-
	pack(InList, PackList), encode_modified_TR(PackList, [], EncList).

encode_modified_TR([], Acc, EncList) :- reverse(Acc, EncList).
encode_modified_TR([[Elem] | T], Acc, EncList) :-
	!, encode_modified_TR(T, [Elem | Acc], EncList).
encode_modified_TR([L | T], Acc, EncList) :-
	L = [Elem | _], length(L, Ln),
	encode_modified_TR(T, [[Ln, Elem] | Acc], EncList).
	
% 1.14	
dupli(InList, DupList) :- dupli_TR(InList, [], DupList).

dupli_TR([], Acc, DupList) :- reverse(Acc, DupList).
dupli_TR([H | T], Acc, DupList) :- dupli_TR(T, [H, H | Acc], DupList).

% 1.15
dupli([], N, []) :- integer(N).
dupli([H | T], Times, DupList) :-
	integer(Times), dupli_TR(T, H, Times, Times, [], DupList).

dupli_TR([], _, 0, _, Acc, DupList) :- reverse(Acc, DupList).
dupli_TR([H | T], _, 0, N, Acc, RepList) :-
	!, dupli_TR(T, H, N, N, Acc, RepList).
dupli_TR(T, CurrElem, CurrN, N, Acc, RepList) :-
	CurrN > 0, NewCurrN is CurrN - 1,
	dupli_TR(T, CurrElem, NewCurrN, N, [CurrElem | Acc], RepList).
	
% 1.16
drop(InList, N, DropList) :-
	integer(N), N > 0, drop_TR(InList, N, N, [], DropList). 

drop_TR([], _, _, Acc, DropList) :- reverse(Acc, DropList).
drop_TR([_ | T], 1, N, Acc, DropList) :- drop_TR(T, N, N, Acc, DropList).
drop_TR([H | T], CurrN, N, Acc, DropList) :-
	CurrN > 1, NewCurrN is CurrN - 1,
	drop_TR(T, NewCurrN, N, [H | Acc], DropList).

% 1.17
split(InList, N, SList1, SList2) :- 
	integer(N), N >= 0, split_TR(InList, N, [], SList1, SList2).
	
split_TR(SList2, 0, Acc, SList1, SList2) :- reverse(Acc, SList1).
split_TR([], _, Acc, SList1, []) :- reverse(Acc, SList1).
split_TR([H | T], N, Acc, SList1, SList2) :- 
	N > 0, NewN is N - 1, split_TR(T, NewN, [H | Acc], SList1, SList2).



% auxilliaries	
	
my_repeat(E, N, RepList) :- integer(N), my_repeat_TR(E, N, [], RepList).

my_repeat_TR(_, 0, RepList, RepList).
my_repeat_TR(E, N, Acc, RepList) :-
	N > 0, NewN is N - 1, my_repeat_TR(E, NewN, [E | Acc], RepList).
