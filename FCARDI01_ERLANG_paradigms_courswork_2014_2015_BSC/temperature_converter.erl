%%%-------------------------------------------------------------------
%%% @author Franco Caridnali
%%% @copyright (C) 2015, <Birkbeck 12th April 2015 - Paradigms Course Work -ERLANG MESSAGIN>

% Path To the File in My Project
% cd ("C:/Users/Franco/IdeaProjects/Messaging/src").

% Compile The erl FIle
% c(temperature_converter).

% Process Created Ready Client/Server
% Control = temperature_converter:start().


% Some Examples To Run
% temperature_converter:temp(Control , {c, 45}).
% temperature_converter:temp(Control , {c, 113}).
% temperature_converter:temp(Control , {f, 113}).
% temperature_converter:temp(Control , {f, 235.4}).

%%%-------------------------------------------------------------------

-module(temperature_converter).
-export([start/0 ,temp/2, loop/0 ]).




start() -> spawn(temperature_converter , loop, []).


temp (Pid, What)->
  rpc(Pid, What).


rpc(Pid, Request) ->

  Pid ! {self(), Request},

  receive

    {Pid, Response} ->

      Response
  end.

loop() ->
  receive

    {From, {f, Temperature}} ->
      From ! {self(), 5 * (Temperature - 32) / 9},
      loop();

      % Celsius To F
    {From, {c, Temperature}} ->
      From ! {self(), 32 + Temperature * 9 / 5},
      loop();


    {From,Other} ->
      From! {self(), {error, Other}},
      loop()

  end.




