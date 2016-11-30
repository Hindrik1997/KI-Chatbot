:- use_module(library('http/thread_httpd')).
:- use_module(library('http/http_dispatch')).
server(Port) :-
	http_server(http_dispatch, [port(Port)]).

getFirstChar(File, A) :- 
	open(File, read, Stream),
	get_char(Stream, A),
	close(Stream).

say_hi(_Request) :-
	format('Content-type: text/html~n~n'),
	format('Hello World!~n').

:- http_handler(/, say_hi, []).



@hasdfhasdfhsahdfhsadfhf

:- use_module(library(pio)).

lines([])           --> call(eos), !.
lines([Line|Lines]) --> line(Line), lines(Lines).

eos([], []).

line([])     --> ( "\n" ; call(eos) ), !.
line([L|Ls]) --> [L], line(Ls).