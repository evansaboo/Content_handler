-module(consumer_handler).

-export([init/2]).
-export([content_types_provided/2]).
-export([json_response/2]).

%% Function used by Cowboy endpoint to handle a API REST call and return a response
init(Req, State) ->
	% Cowboy swiches to the REST protocol and start executing the state machine.
	{cowboy_rest, Req, State}.

%% Callback used by Cowboy when the cowboy_rest executes	
content_types_provided(Req, State) ->
	{[
		{<<"application/json">>, json_response}
	], Req, State}.

%% Function to handle API calls which contains the sender_id parameter
json_response(Req, State) ->
	% TODO: try catch
	#{sender_id := Sender_id} = cowboy_req:match_qs([{sender_id, int}], Req),
	
	% TODO: try catch
	Transaction_success = contentDAO:select_is_payable(Sender_id),
	
	% Check if the payment has been processed and return a success json response the API caller
	if 
      Transaction_success == true -> 
	  contentDAO:update_is_payable(Sender_id),
		Body = <<"{\"message\":\"The payment has been processed\"}">>;

      true -> 
		Body = <<"{\"message\":\"The payment has already been processed\"}">>
	end,

	{Body, Req, State}.