unit LibPQ;

interface

uses
 l3IntfUses
;

type
 TpgConnectStatusType = (
  CONNECTION_OK
  , CONNECTION_BAD
  , CONNECTION_STARTED
   {* Waiting for connection to be made. }
  , CONNECTION_MADE
   {* Connection OK; waiting to send. }
  , CONNECTION_AWAITING_RESPONSE
   {* Waiting for a response from the postmaster. }
  , CONNECTION_AUTH_OK
   {* Received authentication; waiting for backend startup. }
  , CONNECTION_SETENV
   {* Negotiating environment. }
  , CONNECTION_SSL_STARTUP
   {* Negotiating SSL. }
  , CONNECTION_NEEDED
   {* Internal state: connect() needed }
 );//TpgConnectStatusType
 
 TPGconn = record
 end;//TPGconn
 
 PPGconn = ^TPGconn;
 
 TPGresult = record
 end;//TPGresult
 
 PPGresult = ^TPGresult;
 
 TpgExecStatusType = (
  PGRES_EMPTY_QUERY
  , PGRES_COMMAND_OK
   {* a query command that doesn't return anything
was executed properly by the backend }
  , PGRES_TUPLES_OK
   {* a query command that returns tuples
was executed properly by the backend,
PGresult contains the result tuples }
  , PGRES_COPY_OUT
   {* Copy Out data transfer in progress }
  , PGRES_COPY_IN
   {* Copy In data transfer in progress }
  , PGRES_BAD_RESPONSE
   {* an unexpected response was recv'd from the backend }
  , PGRES_NONFATAL_ERROR
  , PGRES_FATAL_ERROR
 );//TpgExecStatusType
 
implementation

uses
 l3ImplUses
;

end.
