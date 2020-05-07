-module(echoTestProcess).

-export([start/1,init/1]).

start(N) ->
    spawn(echoTestProcess,init,[N]).

init(N) ->
    Pid = echoProcess:start(),
    loop(N,Pid).


loop(0,Pid) ->
    Pid ! stop,
    io:format("Echo test is done successfully",[]);
    
loop(N,Pid) ->
    Pid ! {self(),N},
    io:format("number of echo is: ~p~n",[N]),
    receive
	stop ->
	    true;
	{Pid,N} ->
	    loop(N-1,Pid)
    end.
