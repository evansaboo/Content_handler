-module(sender_handler).

-export([init/2]).

init(Req, Opts) ->
	
	{ok, _, Req2} = cowboy_req:read_part(Req),
	{ok, Data, Req3} = cowboy_req:read_part_body(Req2),
	parse_data(Data),

	{ok, Req3, Opts}.
	

parse_data(Data) ->
	Map = jsone:decode(Data),
	{ok, Sender_id} = maps:find(<<"sender_id">>, Map),
	{ok, Receiver_id} = maps:find(<<"receiver_id">>, Map),
	{ok, File_type} = maps:find(<<"file_type">>, Map),
	{ok, Is_payable} = maps:find(<<"is_payable">>, Map),
	Converted_file_type = binary_to_list(File_type),

	contentDAO:insert_into_table(Sender_id, Receiver_id, Converted_file_type, Is_payable).
