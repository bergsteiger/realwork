unit LibPQ;

interface

{$Include ..\PG\pgDefine.inc}

{$If defined(UsePostgres)}
type
 TPGconn = record end;
 PPGconn = ^TPGconn;

 TPGresult = record end;
 PPGresult = ^TPGresult;

 POid = ^Oid;
 Oid = Integer;

 TPQparamTypes = {array of }POid;
 TPQparamValues = array of PAnsichar;
 TPQparamLengths = array of Integer;
 TPQparamFormats = array of Integer;

 TpgConnectStatusType = (
  CONNECTION_OK,
  CONNECTION_BAD,

  (* Non-blocking mode only below here *)

  (*
    The existence of these should never be relied upon - they should only
    be used for user feedback or similar purposes.
   *)
  CONNECTION_STARTED,		//* Waiting for connection to be made. */
  CONNECTION_MADE,		//* Connection OK; waiting to send. */
  CONNECTION_AWAITING_RESPONSE,	//* Waiting for a response from the postmaster. */
  CONNECTION_AUTH_OK,		//* Received authentication; waiting for backend startup. */
  CONNECTION_SETENV,		//* Negotiating environment. */
  CONNECTION_SSL_STARTUP,	//* Negotiating SSL. */
  CONNECTION_NEEDED		//* Internal state: connect() needed */
 );

 TpgExecStatusType = (
  PGRES_EMPTY_QUERY,
  PGRES_COMMAND_OK,		{ a query command that doesn't return anything
                                was executed properly by the backend }
  PGRES_TUPLES_OK,		{ a query command that returns tuples
                                was executed properly by the backend,
                                PGresult contains the result tuples }
  PGRES_COPY_OUT,		{ Copy Out data transfer in progress }
  PGRES_COPY_IN,		{ Copy In data transfer in progress }
  PGRES_BAD_RESPONSE,		{ an unexpected response was recv'd from
                                the backend }
  PGRES_NONFATAL_ERROR,
  PGRES_FATAL_ERROR
 );

function PQconnectdb(ConnInfo: PAnsiChar): PPGconn; cdecl;

procedure PQfinish(Handle: PPGconn); cdecl

function PQstatus(Handle: PPGconn): TpgConnectStatusType; cdecl;

function PQerrorMessage(Handle: PPGconn): PAnsiChar; cdecl;


function PQprepare(Handle: PPGconn; stmtName: PAnsichar;
        query: PAnsiChar; nParams: Integer; paramTypes: TPQparamTypes): PPGresult; cdecl;
function PQexecPrepared(Handle: PPGconn; stmtName: PAnsichar;
        nParams: Integer; paramValues: TPQparamValues; paramLengths: TPQparamLengths;
        paramFormats: TPQparamFormats; resultFormat: Integer): PPGresult; cdecl;
function PQdescribePrepared(Handle: PPGconn; const stmt: PAnsiChar): PPGresult; cdecl;
function PQexec(Handle: PPGconn; Query: PAnsiChar): PPGresult; cdecl;
function PQexecParams(Handle: PPGconn; command: PAnsichar;
        nParams: Integer; paramTypes: TPQparamTypes; paramValues: TPQparamValues;
        paramLengths: TPQparamLengths; paramFormats: TPQparamFormats;
        resultFormat: Integer): PPGresult; cdecl;

function PQsetSingleRowMode(Handle: PPGconn): Integer; cdecl;

function PQsendQuery(Handle: PPGconn; query: PAnsiChar): Integer; cdecl;

function PQgetResult(Handle: PPGconn): PPGresult; cdecl;
function PQresultStatus(Result: PPGresult): TpgExecStatusType; cdecl;
function PQresultErrorMessage(Result: PPGresult): PAnsiChar; cdecl;
function PQcmdTuples(Result: PPGresult): PAnsiChar; cdecl;
function PQntuples(Result: PPGresult): Integer; cdecl;

function PQnfields(Result: PPGresult): Integer; cdecl;
function PQfname(Result: PPGresult; field_num: Integer): PAnsiChar; cdecl;
function PQftype(Result: PPGresult; field_num: Integer): Oid; cdecl;
function PQgetvalue(Result: PPGresult; tup_num, field_num: Integer): PAnsiChar; cdecl;

procedure PQclear(Result: PPGresult); cdecl;

function PQconsumeInput(Handle: PPGconn): Integer; cdecl;
{$IfEnd defined(UsePostgres)}

implementation

{$If defined(UsePostgres)}
const
  LibPQDll = 'libpq.dll';

function PQconnectdb(ConnInfo: PAnsiChar): PPGconn; external LibPQDll name 'PQconnectdb';
procedure PQfinish(Handle: PPGconn); cdecl; external LibPQDll name 'PQfinish';
function PQstatus(Handle: PPGconn): TpgConnectStatusType; external LibPQDll name 'PQstatus';
function PQerrorMessage(Handle: PPGconn): PAnsiChar; external LibPQDll name 'PQerrorMessage';
function PQprepare(Handle: PPGconn; stmtName: PAnsichar;
        query: PAnsiChar; nParams: Integer; paramTypes: TPQparamTypes): PPGresult; external LibPQDll name 'PQprepare';
function PQexecPrepared(Handle: PPGconn; stmtName: PAnsichar;
        nParams: Integer; paramValues: TPQparamValues; paramLengths: TPQparamLengths;
        paramFormats: TPQparamFormats; resultFormat: Integer): PPGresult; external LibPQDll name 'PQexecPrepared';
function PQdescribePrepared(Handle: PPGconn; const stmt: PAnsiChar): PPGresult; external LibPQDll name 'PQdescribePrepared';
function PQexec(Handle: PPGconn; Query: PAnsiChar): PPGresult; external LibPQDll name 'PQexec';
function PQexecParams(Handle: PPGconn; command: PAnsichar;
        nParams: Integer; paramTypes: TPQparamTypes; paramValues: TPQparamValues;
        paramLengths: TPQparamLengths; paramFormats: TPQparamFormats;
        resultFormat: Integer): PPGresult; external LibPQDll name 'PQexecParams';
function PQsetSingleRowMode(Handle: PPGconn): Integer; external LibPQDll name 'PQsetSingleRowMode';
function PQsendQuery(Handle: PPGconn; query: PAnsiChar): Integer; external LibPQDll name 'PQsendQuery';
function PQgetResult(Handle: PPGconn): PPGresult; external LibPQDll name 'PQgetResult';
function PQresultStatus(Result: PPGresult): TpgExecStatusType; external LibPQDll name 'PQresultStatus';
function PQresultErrorMessage(Result: PPGresult): PAnsiChar; external LibPQDll name 'PQresultErrorMessage';
function PQcmdTuples(Result: PPGresult): PAnsiChar; external LibPQDll name 'PQcmdTuples';
function PQntuples(Result: PPGresult): Integer; external LibPQDll name 'PQntuples';
function PQnfields(Result: PPGresult): Integer; external LibPQDll name 'PQnfields';
function PQfname(Result: PPGresult; field_num: Integer): PAnsiChar; external LibPQDll name 'PQfname';
function PQftype(Result: PPGresult; field_num: Integer): Oid; external LibPQDll name 'PQftype';
function PQgetvalue(Result: PPGresult; tup_num, field_num: Integer): PAnsiChar; external LibPQDll name 'PQgetvalue';
procedure PQclear(Result: PPGresult); external LibPQDll name 'PQclear';
function PQconsumeInput(Handle: PPGconn): Integer; external LibPQDll name 'PQconsumeInput';
{$IfEnd defined(UsePostgres)}

end.
