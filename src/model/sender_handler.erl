-module(sender_handler).

-export([init/2]).


%% Function used by Cowboy endpoint to handle a API call and return a response
init(Req, Opts) ->
	{ok, _, Req2} = cowboy_req:read_part(Req),
	
	% Get the data from the binary file from the API call
	{ok, Data, Req3} = cowboy_req:read_part_body(Req2),
	
	% Parse thr data and store it in the database
	parse_data(Data),
	
	% Build a status code 200 response and return it
	Req4 = cowboy_req:reply(200, Req3),
	{ok, Req4, Opts}.
	
%% Parses the given data by extracting all the neccesary values and stores the in the database
parse_data(Data) ->
	% TODO: Implement try catch if the data is not correct
	
	% Decode the json object in the binary data and convert it into a Map
	Map = jsone:decode(Data),
	{ok, Sender_id} = maps:find(<<"sender_id">>, Map),
	{ok, Receiver_id} = maps:find(<<"receiver_id">>, Map),
	{ok, File_type} = maps:find(<<"file_type">>, Map),
	{ok, Is_payable} = maps:find(<<"is_payable">>, Map),
	Converted_file_type = binary_to_list(File_type),
	
	contentDAO:insert_into_table(Sender_id, Receiver_id, Converted_file_type, Is_payable).
