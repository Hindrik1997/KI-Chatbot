:- use_module(library('http/http_client')).
:- use_module(library('http/http_open')).
:- use_module(library('http/json')).
:- use_module(library('http/json_convert')).
:- use_module(library('xpath')).
:- use_module(library('sgml')).
:- use_module(library('http/http_dispatch')).
:- use_module(library('random')).


:- dynamic reddit_code/1.
:- dynamic reddit_token/1.
reddit_token(nope).
reddit_code(nope).

acces_token(Code, Token) :- 
	http_post('https://www.reddit.com/api/v1/access_token',
		[
			grant_type(authorization_code),
			code(Code),
			redirect_uri('http://www.ruurdbijlsma.com/prolog')
		], Token, []).
	
get_token(Code, Token) :-
	http_open(
		'https://www.reddit.com/api/v1/access_token',
		Token, 
		[
			post(
				form([
					grant_type(authorization_code),
					code(Code),
					redirect_uri('http://www.ruurdbijlsma.com/prolog')
				])
			),
			authorzation(
				basic('8MKVSb9CStTzqg', 'orM09nyTv7x0nD947-CbtgHrDWo')
			)
		]
	).



get_state(State) :- random(0, 10000000000000000, State).

state_link(Link) :- 
	get_state(State),
	atom_concat('https://www.reddit.com/api/v1/authorize?client_id=aVosq81QzYxVxA&response_type=code&state=', State, First),
	atom_concat(First, '&redirect_uri=http://www.ruurdbijlsma.com/prolog&duration=permanent&scope=identity edit flair history modconfig modflair modlog modposts modwiki mysubreddits privatemessages read report save submit subscribe vote wikiedit wikiread', Link).

authorize :- 
	state_link(Link),
	atom_concat('sensible-browser "', Link, First),
	atom_concat(First, '"&', Command),
	shell(Command).