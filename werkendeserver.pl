:- use_module(library(http/websocket)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_authenticate)).

:- initialization main.

main :-
    run,
    assert(context([hallo])).

:- http_handler(root(ws), http_upgrade_to_websocket(receiveSocket, []), [spawn([])]).

receiveSocket(WebSocket) :-
    ws_receive(WebSocket, Message),
    (   Message.opcode == close
    ->  true
    ;   handleMessage(Message, Reply),
        ws_send(WebSocket, Reply),
        receiveSocket(WebSocket)
    ).

handleMessage(Message, Reply) :- find_and_reply([Message], [hallo], Reply).

run :-
    run(3333).

run(Port) :-
    http_server(http_dispatch, [port(Port)]).

stop :-
    stop(3333).

stop(Port) :-
    http_stop_server(Port, []).