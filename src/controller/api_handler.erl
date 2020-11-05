-module(api_handler).

-export([start_api_listener/0]).
-export([stop_api_listener/0]).

%% Function to start the Cowboy server, 
%% add two endpoints and listen on port 8080
start_api_listener() ->
	
	% Declare two API endpoints. Send incoming API calls to
	% its corresponding module handler.
	Dispatch = cowboy_router:compile([
		{'_', [
				{"/consumer", consumer_handler, []},
				{"/sender", sender_handler, []}
			]}
		
	]),
   
	% Start the server and listen to port 8080
	{ok, _} = cowboy:start_clear(http_listener, 
		[{port, 8080}],
		#{env => #{dispatch => Dispatch}}
	).
		
	
%% Function to stop the Cowboy server
stop_api_listener() ->
    ok = cowboy:stop_listener(http).

