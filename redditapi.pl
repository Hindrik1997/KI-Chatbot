:- use_module(library('http/http_client')).
:- use_module(library('http/http_open')).
:- use_module(library('http/json')).
:- use_module(library('xpath')).
:- use_module(library('sgml')).
:- use_module(library('http/http_dispatch')).
:- use_module(library('random')).


% http://openweathermap.org/
authorize(State) :-
 format(atom(HREF),'https://www.reddit.com/api/v1/authorize?client_id=aVosq81QzYxVxA&response_type=code&state=~s&redirect_uri=http://www.ruurdbijlsma.com&duration=permanent&scope=identity edit flair history modconfig modflair modlog modposts modwiki mysubreddits privatemessages read report save submit subscribe vote wikiedit wikiread',[State]),
 http_get(HREF,Json,[]),
 atom_json_term(Json,json(R),[]),
 member(main=json(W),R),
 member(temp=T,W),
 Temp is round(T - 273.15).