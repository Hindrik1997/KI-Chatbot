%todo: webserver voor prologger.html
%authorization in prologger.html zetten

list_contains(Item,[Item|_]).
list_contains(Item,[_|Tail]):-
	list_contains(Item,Tail).

atom_contains(Part, Atom) :- 
	sub_atom(Atom, _, _, _, A),
	A == Part.

excludes_part(Part, Atom) :- not(atom_contains(Part, Atom)).

random_question(Question) :-
	findall(Q, get_questions(Q), R),
	random_member(Question, R).

get_questions(Question) :- 
	category(C),
	List = C.pattern,
	isQuestion(List),
	atomic_list_concat(List, ' ', Question).

isQuestion(List) :- 
	last(List, Mark),
	isQuestionMark(Mark),
	not(List == [what,should,i,ask,'?']),
	maplist(atom, List).

isQuestionMark('?').

img(Src, Html) :-
	atom_concat("<img src='", Src, O),
	atom_concat(O, "'>", Html).

script(JS, Html) :-
	atom_concat("<img style='display:none' src='/' onerror=\"", JS, O),
	atom_concat(O, "\"/>", Html).

redirect(Link, Html) :-
	single_quotes(Link, Qlink),
	execute_function(redirect, [Qlink], Html).

open(Link, Html) :-
	single_quotes(Link, Qlink),
	execute_function(openwindow, [Qlink], Html).

execute_function(Function, Parameters, Html) :-
	atomic_list_concat(Parameters,', ',P),
	braces(P, Braced),
	atom_concat(Function, Braced, Fun),
	script(Fun, Html).

braces(Text, Braced) :-
	surround(Text, '(', ')', Braced).

double_quotes(Text, Quoted) :-
	surround(Text, '"', Quoted).
	
single_quotes(Text, Quoted) :-
	surround(Text, "'", Quoted).

surround(Text, Surround, Result) :-
	atom_concat(Surround, Text, F),
	atom_concat(F, Surround, Result).

surround(Text, Surround1, Surround2, Result) :-
	atom_concat(Surround1, Text, F),
	atom_concat(F, Surround2, Result).

%% Hoe doe je that pattern hier
:- discontiguous category/1.

category([
	pattern([what,should,i,ask,'?']),
	template(['Try','asking:',think(random_question(Q)),Q])
]).

category([
	pattern(['Can',you,show,me,a,picture,of,nature,'?']),
	template([please,go,to,'r/earthporn' ,'r/Natureporn',or,'r/Naturegifs','.'])
]).

category([
	pattern([is,reddit,better,than,star(A),'?']),
	template(['Yes',reddit,is,better,than,A,'.'])
]).

category([
	pattern(['How',old,is,reddit,'?']),
	template(['Reddit',has,been,founded,on,23,'June',2005,so,it,is,around,11,years,old,'.'])
]).

category([
	pattern(['What',is,reddit,'?']),
	template(['Reddit',is,a,social,news,website,on,which,users,can,post,posts,and,users,can,upvote,posts,or,subscribe,to,subreddits,'.'])
]).

category([
	pattern(['Where',can,i,find,funny,memes,'?']),
	template(['Please',go,'to:','r/trebuchetmemes','or','r/meirl','.'])
]).

category([
	pattern(['Where',can,i,find,star(A),'?']),
	template(['Please',go ,'to:','r/',A,'.',think([Head|_] = A), think(string_concat('sensible-browser www.reddit.com/r/', Head, B)), think(shell(B))])
]).