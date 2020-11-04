%%%-------------------------------------------------------------------
%% @doc kivra public API
%% @end
%%%-------------------------------------------------------------------

-module(kivra_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
	api_handler:start_api_listener(),
	

	
    kivra_sup:start_link().

stop(_State) ->
	api_handler:stop_api_listener().