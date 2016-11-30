% chatbot.pl

:- use_module(library('http/http_client')).
:- use_module(library('http/json')).
:- use_module(library('www_browser')).

:- consult([alice]).
:- include(reddit).

category([
	pattern([can,you,star(A),'?']),
	template(['I', 'don''t', really, know, if,'I','can', A,
		but,'I''m',very,good,at,browsing,meems,all,day,long,'.'])
]).

category([
	pattern([yes]),
	that([do, you, like, trebuchetmemes,'?']),
	template(['What', is, your, favourite, meem, '?'])
]).

category([
	pattern([star(_),always,star(_)]),
	template(['Can',you,think,of,a,specific,example,'?'])
]).

category([
	pattern([are,you,afraid,of,syntax(np,NP),'?']),
	template(['Why',would,'I',be,afraid,of,NP,'?!',',','I',am,a,'digital chatbot!'])
]).



category([
	pattern(['Do you think you are',star(A),'?']),
	template(['I am a chatbot, ofcourse i am',A,'!?'])
]).

category([
	pattern([star(_)]),
	template([random([
		['So what is your favorite type of meem','?'],
		['How often do you browse reddit','?'],
		['What is the best subreddit in the world','?']])
	])
]).

/*


category([
	pattern([who,is,alan,turing,'?']),
	template(['Alan Mathison Turing',was,a,'British',mathematician,',',logician,',',cryptanalyst,',',philosopher,',',computer,scientist,',',mathematical,biologist,',',and,marathon,and,ultra,distance,runner,'.'])
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
	pattern([star(_),temperature,star(_),in,star([City]),'?']),
	template([think(temperature(City,Temp)),
	    'The',temperature,in,City,is,Temp,degrees,celcius,'.'])
]).

category([
	pattern([is,star([Person]),female,'?']),
	template([think(female(Person)),'Yes, ',she,is,'!'])
]).

category([
	pattern([is,star([Person]),female,'?']),
	template([think(not(female(Person))),'No, ',Person,is,not,female])
]).

category([
	pattern([who,is,the,father,of,star([Person]),'?']),
	template([think(father_of(Father,Person)),Father,is,the,father,of,Person])
]).

category([
	pattern([star(_),sound,star(_)]),
	template(['Okay!',
		think(process_create(path(play), ['emergency.mp3'], [stderr(null)]))])
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
*/
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
