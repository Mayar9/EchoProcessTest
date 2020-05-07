-module(echoProcess).

-export([start/0,init/0]).

start() ->
    spawn(echoProcess,init,[]).

init() ->
    loop().

loop() ->
    receive
	stop ->
	    true;
	{Pid,Msg} ->
	    Pid ! {self(),Msg},
	    io:format("Recieved msg: ~p~n",[Msg]),
	    loop()
    end.
