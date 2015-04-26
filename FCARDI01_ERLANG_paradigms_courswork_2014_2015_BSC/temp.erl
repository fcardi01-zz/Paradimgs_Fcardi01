%%%-------------------------------------------------------------------
%%% @author Franco Caridnali
%%% @copyright (C) 2015, <Birkbeck 12th April 2015 - Paradigms Course Work -ERLANG MESSAGIN>
%%% @doc
%%%     This temp.erl (stands for Temperature)
%%%      Simply the Function has a static variabla f or c and it accepts also Temperature whihc will change
%%%      Depending on the request. it willl convert to FAHRENHEIT if {f, Temperature} and to CELSIUS
%%%      if {c, Temperature}
%%%      to call teh Function after being compiled :  temp:conv({f,45}).
%%%      or temp:conv({c,45}).
%%% @end
%%% Created : 04. Mar 2015 00:39
%%%-------------------------------------------------------------------
-module(temp).
-export([test/0, conv/1]).


conv({f, Temperature}) ->   5 * (Temperature - 32) / 9;
conv({c, Temperature}) ->   32 + Temperature * 9 / 5.


%Testing The Function
% To Test
% Step 1 --> c.(temp).
% Step 2 --> temp:test().

test() ->

  113.0 = conv ({c,45}),
  7.222222222222222 = conv ({f,45}),

test_worked.



