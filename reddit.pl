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

youtube(Url) :- atom_contains('youtu.be', Url).
youtube(Url) :- atom_contains('youtube', Url).

image(Url) :- atom_contains('.png', Url).
image(Url) :- atom_contains('.jpg', Url).
image(Url) :- atom_contains('.gif', Url).
image(Url) :- atom_contains('.webp', Url).
image(Url) :- atom_contains('.jpeg', Url).
image(Url) :- atom_contains('i.reddituploads', Url).
image(Url) :- atom_contains('500px', Url).

video(Url) :- atom_contains('.webm', Url).

gfycat(Url) :- atom_contains('://gfycat', Url).

imgur(Url) :- atom_contains('://imgur', Url).

url_to_html(Url, Html) :-
	youtube(Url),
	remove_from_atom(Url, 'https://www.youtube.com/watch?v=', Arg),
	atom_concat('https://www.youtube.com/embed/', Arg, Out),
	format(atom(Html), '<iframe width="560" height="315" src="~s" frameborder="0" allowfullscreen></iframe>', Out),!.

url_to_html(Url, Html) :-
	image(Url),
	format(atom(Html), '<img src="~s"></img>', Url),!.

url_to_html(Url, Html) :-
	video(Url),
	format(atom(Html), '<video autoplay src="~s"></video>', Url),!.

url_to_html(Url, Html) :-
	imgur(Url),
	format(atom(Html), '<img src="~s.png"></img>', Url),!.

url_to_html(Url, Html) :-
	gfycat(Url),
	remove_from_atom(Url, 'https://', Arg),
	atom_concat('https://giant.', Arg, Out),
	format(atom(Html), '<video autoplay src="~s.webm"></video>', Out),!.

url_to_html(Url, Html) :-
	format(atom(Html), '<a href="~s">Link</a>', Url),!.

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

ifelse(Condition, True, False, Out):-
	Condition ->
	Out = True
	;
	Out = False.

remove_from_atom(Atom, Replace, Out) :-
	atomic_list_concat(List, Replace, Atom),
	concat_atom(List, Out).

:- discontiguous category/1.
:- dynamic likes/1.

category([
	pattern([show,me,star(A)]),
	template([srai([can,you,show,me,A,'?'])])
]).

%%---------------------------------------------------------------------------------------------------------------------%%%

category([
	pattern(['How',much,karma,does,star(A),have,'?']),
	template([think(user_karma(A, LinkKarma, CommentKarma)),A,has,LinkKarma,link,karma,and,CommentKarma,comment,karma])
]).

%%---------------------------------------------------------------------------------------------------------------------%%%

category([
	pattern([can,you,show,me,a,random,post]),
	template([srai([can,you,show,me,a,random,post,from,all])])
]).

category([
	pattern([can,you,show,me,a,random,post,syntax(onfromof,_),star(A)]),
	template([think(random_post_html(A, Html, Title)), 'This',looks,like,a,nice,random,'post:',Html,'It\'s',titled,Title])
]).

category([
	pattern([can,you,show,me,a,random,star(A),post]),
	template([think(random_post_html(A, Html, Title)), 'This',looks,like,a,nice,random,'post:',Html,'It\'s',titled,Title])
]).

%%---------------------------------------------------------------------------------------------------------------------%%%

category([
	pattern([can,you,show,me,the,syntax(verygood, Top),post,syntax(onfromof,From),star(A)]),
	template([srai([what,is,the,Top,post,From,A,'?'])])
]).

category([
	pattern([what,is,the,syntax(verygood, _),post,syntax(onfromof,_),star(A),'?']),
	template([think(top_post_html(A, Html, Title)), 'Here',it,'is:',Html,'It\'s',titled,Title])
]).
onfromof --> [on];[from];[of].
verygood --> [top];[best].

%%---------------------------------------------------------------------------------------------------------------------%%%

category([
	pattern(['I',like,star(A)]),
	template(['I',will,remember,that,you,like,A,think(assertz(likes(A)))])
]).

category([
	pattern(['Do','I',like,star(A),'?']),
	template([think(ifelse(likes(A), 'Yes you like', 'No you dont like', Out)),Out,A])
]).

%%---------------------------------------------------------------------------------------------------------------------%%%

category([
	pattern([what,should,i,ask,'?']),
	template(['Try','asking:',think(random_question(Q)),Q])
]).

%%---------------------------------------------------------------------------------------------------------------------%%%

category([
	pattern(['Can',you,show,me,a,picture,of,nature,'?']),
	template([think(random_post_html(natureporn, Html, Title)), 'I',found,this,great,'picture:',Html,'It\'s',titled,Title])
]).

category([
	pattern(['Can',you,show,me,a,picture,of,earth,'?']),
	template([think(random_post_html(earthporn, Html, Title)), 'I',found,this,great,'picture:',Html,'It\'s',titled,Title])
]).

category([
	pattern(['Can',you,show,me,weather,gifs,'?']),
	template([think(random_post_html(weathergifs, Html, Title)), 'I',found,this,'gif:',Html,'It\'s',titled,Title])
]).

%%---------------------------------------------------------------------------------------------------------------------%%%

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