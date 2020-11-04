# Content_handler

## Build tool:
Rebar3

## HTTP Server:
Cowboy

## External library:
Jsone

## Run:
Build and start application:  
rebar3 shell  

Process payment (API calls):  
> curl -i "http://localhost:8080/consumer?&sender_id=1"  
  
Send data:
> cd src/misc  
> curl -v -F inputfile=@testdata http://localhost:8080/sender  

## TODO:
- Add comments
- Implement Units tests
- Implement cuncurrency for faster db calls
