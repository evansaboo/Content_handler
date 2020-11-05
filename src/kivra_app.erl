%%%-------------------------------------------------------------------
%% @doc kivra public API
%% @end
%%%-------------------------------------------------------------------

-module(kivra_app).

-behaviour(application).

-export([start/2, stop/1]).


%% Function to start the application called by rebar3 at execution time
start(_StartType, _StartArgs) ->

	% Start the cowboy server
	api_handler:start_api_listener(),
	
    kivra_sup:start_link().


%% Function to stop the application called by rebar3 at execution time
stop(_State) ->

	%Stop the cowboy server
	api_handler:stop_api_listener().