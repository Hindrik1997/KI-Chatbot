% chatbot.pl

:- use_module(library('http/http_client')).
:- use_module(library('http/json')).
:- use_module(library('www_browser')).
:- use_module(library('random')).

:- consult([alice]).
:- include(reddit).
:- include(redditapi).
:- include(redditauthorization).
:- include(reddit_api_predicates).
:- include(alice_server).
:- include(webapi).

:- discontiguous category/1.

category([
	pattern([yea]),
	template([srai([yes])])
]).

category([
	pattern([yep]),
	template([srai([yes])])
]).

category([
	pattern(['Can',you,star(A),'?']),
	template(['I', 'don''t', really, know, if,'I','can', A,
		but,'I''m',very,good,at,browsing,memes,all,day,long,'.'])
]).

category([
	pattern([yes]),
	that([do, you, like, trebuchetmemes,'?']),
	template(['What', is, your, favourite, meme, '?'])
]).

category([
	pattern([star(_),always,star(_)]),
	template(['Can',you,think,of,a,specific,example,'?'])
]).

category([
	pattern([are,you,afraid,of,syntax(np,NP),'?']),
	template(['Why',would,'I',be,afraid,of,NP,'?!',',','I',am,a,digital,'chatbot!'])
]).

category([
	pattern([who,is,alan,turing,'?']),
	template(['Alan',turing,is,a,user,on,reddit,think(user_karma(alanturing, L, C)),with,L,link,karma,and,C,comment,karma,'.','He',is,also,a,famous,'British',mathematician,with,a,subreddit,dedicated,to,him,'.','Here',is,a,post,from,'/r/alanturing',think(random_post_html(alanturing, Html, Title)),Html,'It\'s','titled:',Title])
]).

category([
	pattern([do,you,know,who,star(A),is,'?']),
	template([srai([who,is,A,'?'])])
]).

category([
	pattern([how,much,is,star([A]),plus,star([B]),'?']),
	template([think((C is A + B)),A,plus,B,is,C])
]).

category([
	pattern([star(_),'?']),
	template([think(random_question(Q)), random([
		['What',is,your,favorite,type,of,post,'?'],
		['Did',you,know,you,can,ask,'me:',Q],
		['What',is,the,best,subreddit,in,the,world,'?']])
	])
]).

category([
	pattern([star(A)]),
	template([srai([A, '?'])])
]).

% Family tree
female(helen).
female(ruth).
female(petunia).
female(lili).

male(paul).
male(albert).
male(vernon).
male(james).
male(dudley).
male(harry).

parent_of(paul,petunia).
parent_of(helen,petunia).
parent_of(paul,lili).
parent_of(helen,lili).
parent_of(albert,james).
parent_of(ruth,james).
parent_of(petunia,dudley).
parent_of(vernon,dudley).
parent_of(lili,harry).
parent_of(james,harry).

% Fathers are male parent and mothers are female parents.
father_of(X,Y) :- male(X),
                  parent_of(X,Y).
mother_of(X,Y) :- female(X),
                  parent_of(X,Y).

% http://openweathermap.org/
%temperature(City,Temp) :-
%	format(atom(HREF),'http://api.openweathermap.org/data/2.5/weather?q=~q',[City]),
%	http_get(HREF,Json,[]),
%	atom_json_term(Json,json(R),[]),
%	member(main=json(W),R),
%	member(temp=T,W),
%	Temp is round(T - 273.15).

np --> art, noun.

art --> [the];[a];[an].
noun --> [cat];[dog];[mouse];[rat];[table].
