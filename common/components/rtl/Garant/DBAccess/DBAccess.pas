unit DBAccess;

interface
uses
 SysUtils,
 l3Types,
 l3Base,
 l3Interfaces,
 l3ValLst,

 ZPlainPostgreSqlDriver;

type
 TSQLResult = PZPostgreSQLResult;

 TConnectParam = String;

 IdbaQueryResult = interface(Il3Base)
  ['{37F0391B-42D1-4E00-AB38-D768517721E3}']
  function Status : TZPostgreSQLExecStatusType;
  function RowCount : Cardinal;
  function FieldNumByName(const aFldName : String) : Cardinal;

  function GetValue(aField : Cardinal; aRow : Cardinal) : PChar;
  function GetValueAsStr(aField : Cardinal; aRow : Cardinal) : String;
  function GetValueAsPCharLen(aField : Cardinal; aRow : Cardinal) : Tl3PCharLen;
  function GetValueAsInt(aField : Cardinal; aRow : Cardinal) : Int64;
 end;//TdbaQueryResult

 IdbaRecord = interface(Il3Base)
 ['{EC00BD3F-F127-421C-9E51-EB96A5030A8C}']
  procedure AddField(const aName : String; const aValue : string); overload;
  procedure AddField(const aName : String; aValue : Int64); overload;
  procedure AddField(const aName : String; aValue : Boolean); overload;

  function GenDBInsertSQL : string;
  function GenDBUpdateSQL(const aWhereCondition : String) : string;
  function GenDBUpdateParamStr : string;

  procedure DBInsert;
  procedure DBUpdate(const aWhereCondition : String);
 end;

 IdbaConnect = interface(Il3Base)
  ['{20BC62F6-5803-4F5B-8C19-A0B24D3B01B3}']
  function StartTransaction : boolean;
  function CommitTransaction : boolean;
  function RollbackTransaction : boolean;
  function  GetQueryResult(const aSQL : String) : IdbaQueryResult;
  procedure ExecQuery(const aSQL : String);
  function MakeRecord(const aTableName : string) : IdbaRecord;
  procedure AddRecord(const aTableName : string; const  aFldName: array of string; const aFldValue: array of const);
 end;//IdbaConnect

 TdbaConnect = class(Tl3Base, IdbaConnect)
  private
   fConnect : PZPostgreSQLConnect;
  public
   constructor Create(const aConnStr : TConnectParam);
   procedure Cleanup; override;
   class function Make(const aConnStr : TConnectParam) : IdbaConnect; reintroduce;

   function StartTransaction : boolean;
   function CommitTransaction : boolean;
   function RollbackTransaction : boolean;

   procedure CheckResult(aSQLResult: PZPostgreSQLResult);

   function GetQueryResult(const aSQL : String) : IdbaQueryResult;
   procedure ExecQuery(const aSQL : String);

   function MakeRecord(const aTableName : string) : IdbaRecord;

   procedure AddRecord(const aTableName : string; const  aFldName: array of string; const aFldValue: array of const);
 end;

 TdbaRecord = class(Tl3CustomValueList, IdbaRecord)
  private
   fTableName : String;
   fConnect : IdbaConnect;
   procedure AddFieldPrim(const aName : String; const aValue : string);
  public
   constructor Create(const aConnect : IdbaConnect; const aTableName : String);
   procedure AddField(const aName : String; const aValue : string); overload;
   procedure AddField(const aName : String; aValue : Int64); overload;
   procedure AddField(const aName : String; aValue : Boolean); overload;

   function GenDBInsertSQL : string;
   function GenDBUpdateParamStr : string;
   function GenDBUpdateSQL(const aWhereCondition : String) : string;

   procedure DBInsert;
   procedure DBUpdate(const aWhereCondition : String);
 end;

 TdbaQueryResult = class(Tl3Base, IdbaQueryResult)
  private
   fSQLResult : TSQLResult;
   fConnect : IdbaConnect;
  public
   constructor Create(const aConnect : IdbaConnect; aSQLResult : TSQLResult);
   procedure Cleanup; override;

   class function Make(aConnect : TdbaConnect; aSQLResult : TSQLResult): IdbaQueryResult; reintroduce;
   function Status : TZPostgreSQLExecStatusType;
   function RowCount : Cardinal;
   function FieldNumByName(const aFldName : String) : Cardinal;

   function GetValue(aField : Cardinal; aRow : Cardinal) : PChar;
   function GetValueAsStr(aField : Cardinal; aRow : Cardinal) : String;
   function GetValueAsPCharLen(aField : Cardinal; aRow : Cardinal) : Tl3PCharLen;
   function GetValueAsInt(aField : Cardinal; aRow : Cardinal) : Int64;
 end;

 TdbaError = class(Exception);

var
 DBDriver : TZPostgreSQL8PlainDriver;

 function ConnectParamStr(const aHost     : string;
                          const aPort     : string;
                          const aDBName   : string;
                          const aUser     : string;
                          const aPassword : string
                          ) : string;


procedure MakeGlobalConnect(const aHost     : string;
                            const aPort     : string;
                            const aDBName   : string;
                            const aUser     : string;
                            const aPassword : string);

function GConnect : IdbaConnect;

implementation
uses
 l3String;

constructor TdbaConnect.Create(const aConnStr : TConnectParam);
begin
 fConnect := DBDriver.ConnectDatabase(PChar(aConnStr));
end;

procedure TdbaConnect.Cleanup;
begin
 DBDriver.Finish(fConnect);
end;

class function TdbaConnect.Make(const aConnStr : TConnectParam): IdbaConnect;
var
 lConn : TdbaConnect;
begin
 lConn := Create(aConnStr);
 try
  Result := lConn;
 finally
  l3Free(lConn);
 end;//try..finally
end;

function TdbaConnect.StartTransaction : boolean;
begin
 DBDriver.ExecuteQuery(fConnect, 'begin');
end;

function TdbaConnect.CommitTransaction : boolean;
begin
 DBDriver.ExecuteQuery(fConnect, 'commit');
end;

function TdbaConnect.RollbackTransaction : boolean;
begin
 DBDriver.ExecuteQuery(fConnect, 'rollback');
end;

function TdbaConnect.GetQueryResult(const aSQL : String) : IdbaQueryResult;
var
 lSQLResult : TSQLResult;
begin
 lSQLResult := DBDriver.ExecuteQuery(fConnect, PChar(aSQL));
 Result := TdbaQueryResult.Make(Self, lSQLResult);
end;

procedure TdbaConnect.ExecQuery(const aSQL : String);
begin
 with DBDriver do
  CheckResult(ExecuteQuery(fConnect, PChar(aSQL)));
end;

procedure TdbaConnect.CheckResult(aSQLResult: PZPostgreSQLResult);
begin
 with DBDriver do
 case GetResultStatus(aSQLResult) of
  PGRES_BAD_RESPONSE   : Raise TdbaError.Create('Сервер не отвечает');
  PGRES_NONFATAL_ERROR : Raise TdbaError.Create(format('NONFATAL ERROR : %s', [GetResultErrorMessage(aSQLResult)]));
  PGRES_FATAL_ERROR    : Raise TdbaError.Create(format('FATAL ERROR : %s', [GetResultErrorMessage(aSQLResult)]));
 end;

 (*  TZPostgreSQLExecStatusType = (
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
*)
end;


procedure TdbaConnect.AddRecord(const aTableName : string; const  aFldName: array of string; const aFldValue: array of const);
const
 cBoolStr : array [boolean] of string = ('False', 'True');
var
 I: Integer;
 aAval : String;
 aNameStr : String;
 aValStr : String;
begin
 for I := Low(aFldValue) to High(aFldValue) do
 begin
  with aFldValue[I] do
   case VType of
    vtExtended,
    vtInteger    : aAval := IntToStr(VInteger);
    vtBoolean    : aAval := cBoolStr[VBoolean];
    vtChar       : aAval := '''' + VChar + '''';
    vtString     : aAval := '''' + string(VString) + '''';
    vtAnsiString : aAval := '''' + string(VAnsiString) + '''';

    //vtPointer  :
    //vtPChar    :
    //vtClass    :
    //vtObject   :
    //vtWideChar:        PutWideChar(Args[I].VWideChar);
    //vtCurrency:        PutFloat(Args[I].VCurrency^);
    //vtVariant:         PutString(Args[I].VVariant^);
    end;
  if aValStr = '' then
   aValStr := aAval
  else
   aValStr := aValStr + ', '+aAval;
 end;

 if Length(aFldName) > 0 then
  for I := Low(aFldName) to High(aFldName) do
   if aNameStr = '' then
    aNameStr := aFldName[I]
   else
    aNameStr := aNameStr + ', '+ aFldName[I];

 ExecQuery(format('INSERT INTO %s %s VALUES %s', [aTableName, aNameStr, aValStr]));

end;

function TdbaConnect.MakeRecord(const aTableName : string) : IdbaRecord;
var
 lRecord : TdbaRecord;
begin
 lRecord := TdbaRecord.Create(Self, aTableName);
 try
  Result := lRecord;
 finally
  l3Free(lRecord);
 end;
end;

{TdbaRecord}
constructor TdbaRecord.Create(const aConnect : IdbaConnect; const aTableName : TConnectParam);
begin
 Inherited Create;
 fTableName := aTableName;
 fConnect := aConnect;
end;

procedure TdbaRecord.AddFieldPrim(const aName : String; const aValue : string);
begin
 Values[aName] := aValue;
end;

procedure TdbaRecord.AddField(const aName : String; const aValue : string);
begin
 AddFieldPrim(aName, ''''+aValue+'''');
end;

procedure TdbaRecord.AddField(const aName : String; aValue : Int64);
begin
 AddFieldPrim(aName, IntToStr(aValue));
end;

procedure TdbaRecord.AddField(const aName : String; aValue : Boolean);
const
 cBoolStr : array [boolean] of string = ('False', 'True');
begin
 AddFieldPrim(aName, cBoolStr[aValue]);
end;

function TdbaRecord.GenDBInsertSQL : string;
var
 I : integer;
 lFieldNames : String;
 lValueNames : String;

begin
 if Count = 0 then TdbaError.Create('TdbaRecord.DBInsert error: empty records');

 with Tl3NamedString(Items[0]) do
 begin
  lFieldNames := AsString;
  lValueNames := Value;
 end;

 for I := 1 to pred(Count) do
  with Tl3NamedString(Items[i]) do
  begin
   lFieldNames := lFieldNames + ', ' + AsString;
   lValueNames := lValueNames + ', ' + Value;
  end;

 Result := format('INSERT INTO %s (%s) VALUES (%s);', [fTableName, lFieldNames, lValueNames]);
end;

function TdbaRecord.GenDBUpdateParamStr : string;
var
 I : integer;
begin
 with Tl3NamedString(Items[0]) do
  Result := format('%s = %s', [AsString, Value]);

 for I := 1 to pred(Count) do
  with Tl3NamedString(Items[i]) do
   Result := Result + ', ' + format('%s = %s', [AsString, Value]);
end;

function TdbaRecord.GenDBUpdateSQL(const aWhereCondition : String) : string;
begin
 Result := format('UPDATE %s SET %s WHERE %s;', [fTableName, GenDBUpdateParamStr, aWhereCondition]);
end;

procedure TdbaRecord.DBInsert;
begin
 fConnect.ExecQuery(GenDBInsertSQL);
end;

procedure TdbaRecord.DBUpdate(const aWhereCondition : String);
begin
 fConnect.ExecQuery(GenDBUpdateSQL(aWhereCondition));
end;

{TdbaQueryResult}
constructor TdbaQueryResult.Create(const aConnect : IdbaConnect; aSQLResult : TSQLResult);
begin
 fSQLResult := aSQLResult;
 fConnect := aConnect;
end;

procedure TdbaQueryResult.Cleanup;
begin
 DBDriver.Clear(fSQLResult);
end;

class function TdbaQueryResult.Make(aConnect : TdbaConnect; aSQLResult : TSQLResult): IdbaQueryResult;
var
 lQryResult: TdbaQueryResult;
begin
 lQryResult := Create(aConnect, aSQLResult);
 try
  Result := lQryResult;
 finally
  l3Free(lQryResult);
 end;//try..finally
end;

function TdbaQueryResult.Status : TZPostgreSQLExecStatusType;
begin
 Result := DBDriver.GetResultStatus(fSQLResult);
end;

function TdbaQueryResult.RowCount : Cardinal;
begin
 Result := DBDriver.GetRowCount(fSQLResult);
end;

function TdbaQueryResult.FieldNumByName(const aFldName : String) : Cardinal;
begin
 Result := DBDriver.GetFieldNumber(fSQLResult, PChar(aFldName));
end;

function TdbaQueryResult.GetValue(aField : Cardinal; aRow : Cardinal) : PChar;
begin
 Result := DBDriver.GetValue(fSQLResult, aRow, aField);
end;

function TdbaQueryResult.GetValueAsStr(aField : Cardinal; aRow : Cardinal) : String;
begin
 Result := GetValue(aField, aRow);
end;

function TdbaQueryResult.GetValueAsInt(aField : Cardinal; aRow : Cardinal) : Int64;
begin
 Result := StrToInt64(GetValue(aField, aRow));
end;

function TdbaQueryResult.GetValueAsPCharLen(aField : Cardinal; aRow : Cardinal) : Tl3PCharLen;
begin
 Result := l3PCharLen(GetValue(aField, aRow), DBDriver.GetLength(fSQLResult, aRow, aField));
end;

{---}
function ConnectParamStr(const aHost     : string;
                         const aPort     : string;
                         const aDBName   : string;
                         const aUser     : string;
                         const aPassword : string
                         ) : string;
begin
 Result := format('host=%s port=%s dbname=%s user=%s password=%s', [aHost, aPort, aDBName, aUser, aPassword]);
 //host=localhost port=5432 dbname=archivarius user=postgres password=sysadm
end;

var
 lGConnect : IdbaConnect;

procedure MakeGlobalConnect(const aHost     : string;
                            const aPort     : string;
                            const aDBName   : string;
                            const aUser     : string;
                            const aPassword : string);
begin
 lGConnect := TdbaConnect.Make(ConnectParamStr(aHost, aPort, aDBName, aUser, aPassword));
 //lConnect := TdbaConnect.Make('host=localhost port=5432 dbname=archivarius user=postgres password=sysadm');
end;

function GConnect : IdbaConnect;
begin
 if lGConnect = nil then
  lGConnect := TdbaConnect.Make('host=localhost port=5432 dbname=archivarius user=postgres password=sysadm');
 Result := lGConnect;
end;

Initialization
 DBDriver := TZPostgreSQL9PlainDriver.Create;
 DBDriver.Initialize;

finalization
 FreeAndNil(DBDriver);
 lGConnect := nil;
end.
