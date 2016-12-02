:- use_module(library(http/websocket)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_authenticate)).

:- initialization main.

main :-
	run,
	assert(context([hallo])),
	assert(message(hoi)).

:- http_handler(root(ws), http_upgrade_to_websocket(receiveSocket, []), [spawn([])]).

extract_code(Message, Code) :-
	sub_string(Message, 16, _, 0, Code).

receiveSocket(WebSocket) :-
	ws_receive(WebSocket, Message),
	(	Message.opcode == close
		->	true
		;	M = Message.data,nl, %% Received text in variable
		(	atom_contains('secret_code_here', M) %% If text contains secret code
			->	print(['Message', M]), %% Handle secret code
				extract_code(M, Code),
				print(['de geheime code isss', Code]), %% Handle secret code
				ws_send(WebSocket, text('secret_code_here_succes')),
				assertz(reddit_code(Code))
			;	print([input, M]), %% If text doesnt contain secret code, answer it
				ask(M, Reply),
				print([ouput, Reply]),
				ws_send(WebSocket, text(Reply)),
				receiveSocket(WebSocket)
		)
	).

ask(Question, Reply) :- tokenise_atom(Question, Input),
	retract(context(Current)),!,
	find_and_reply(Input, Current, NewContext),!,
	assert(context(NewContext)),
	atomic_list_concat(NewContext, ' ', Reply).

run :-
	run(3333).

run(Port) :-
	http_server(http_dispatch, [port(Port)]).

stop :-
	stop(3333).

stop(Port) :-
	http_stop_server(Port, []).