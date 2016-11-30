stringToList(String, List) :- split_string(String,' ', '', List).


ask(Question, Reply) :- stringToList(Question, Input),
	retract(context(Current)),!,
	find_and_reply(Input, Current, NewContext),
	assert(context(NewContext)),
	atomic_list_concat(NewContext, ' ', Reply).

ruurdToken(Input, L) :-
    string_to_atom(Input,IA),
    tail_not_mark(IA, R, T),
    atomic_list_concat(XL, ',', R),
    maplist(split_atom(' '), XL, S),
    append(S, [T], L).

is_period(.).
is_period(?).
is_period(!).

toSingle(Input, Output) :- tos(Input, Output),!.
tos([X], X).

plak([], []).
plak([Head|Tail], Out) :- 
	toSingle(Tail, STail),
	plak(STail, O),
	toSingle(Head, SHead),
	append(SHead, O, Out).

split_atom(S, A, L) :- atomic_list_concat(XL, S, A), delete(XL, '', L).

%if tale is ? or ! or . then remove
%A:Atom, R:Removed, T:special mark
tail_not_mark(A, R, T) :- atom_concat(R, T, A), is_period(T),!. 
tail_not_mark(A, R, '') :- A = R.