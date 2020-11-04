-module(consumer_handler).

-export([init/2]).
-export([content_types_provided/2]).
-export([json_response/2]).

init(Req, State) ->
io:format("test\n"),
	{cowboy_rest, Req, State}.
	
content_types_provided(Req, State) ->
	{[
		{<<"application/json">>, json_response}
	], Req, State}.
	
json_response(Req, State) ->

	#{sender_id := Sender_id} = cowboy_req:match_qs([{sender_id, int}], Req),
	Is_Payable = contentDAO:select_is_payable(Sender_id),
	
	if 
      Is_Payable == true -> 
	  contentDAO:update_is_payable(Sender_id),
		io:fwrite("Success"); 
      true -> 
         io:fwrite("False") 
	end,

	Body = <<"{\"rest\": \"Success!\"}">>,
	{Body, Req, State}.