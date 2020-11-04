-module(api_handler).

-export([start_api_listener/0]).
-export([stop_api_listener/0]).



start_api_listener() ->
	Dispatch = cowboy_router:compile([
		{'_', [
				{"/consumer", consumer_handler, []},
				{"/sender", sender_handler, []}
			]}
		
	]),
   
	{ok, _} = cowboy:start_clear(http_listener, 
		[{port, 8080}],
		#{env => #{dispatch => Dispatch}}
	).
		
	

stop_api_listener() ->
    ok = cowboy:stop_listener(http).

