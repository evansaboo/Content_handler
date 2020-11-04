-module(contentDAO).

-export([start_db_connection/0]).
-export([start_odbc/0]).
-export([insert_into_table/4]).
-export([select_is_payable/1]).
-export([update_is_payable/1]).

get_dns_name() ->
	"odbc_conn".
	
get_db_user_id() ->
	"user".
	
get_db_user_pwd() ->
	"1594826e".
	
start_odbc() ->
	odbc:start().
	
start_db_connection() ->
	Connection_string = "DSN=" ++ get_dns_name() ++
						";" ++
						"UID=" ++ get_db_user_id() ++
						";" ++
						"PWD=" ++ get_db_user_pwd(),

	{ok, Db_reference} = odbc:connect(Connection_string, []),
	
	Db_reference.
	
insert_into_table(Sender_id, Receiver_id, File_type, Is_payable) ->
	Db_reference = start_db_connection(),
	
	Params = [{sql_integer, [Sender_id]}, 
			{sql_integer, [Receiver_id]}, 
			{{sql_varchar, 100}, [File_type]}, 
			{sql_integer, [Is_payable]}],  
			
	odbc:param_query(Db_reference, "INSERT INTO CONTENT 
					(SENDER_ID, RECEIVER_ID, FILE_TYPE, IS_PAYABLE)
					VALUES (?, ?, ?, ?);", Params).
					

select_is_payable(Sender_id) ->
	Db_reference = start_db_connection(),

	Params = [{sql_integer, [Sender_id]}],  
	{selected, _, [{Is_payable} | _]} = 
			odbc:param_query(Db_reference, 
			"SELECT IS_PAYABLE FROM CONTENT WHERE SENDER_ID = ? ", Params),
	Is_payable.


update_is_payable(Sender_id) ->
	Db_reference = start_db_connection(),

	Params = [{sql_integer, [Sender_id]}],
	odbc:param_query(Db_reference, 
			"UPDATE CONTENT SET IS_PAYABLE = 0 WHERE SENDER_ID = ? ", Params).
			
	
	
	