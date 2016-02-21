unit pgConnection;

// Модуль: "w:\common\components\rtl\Garant\PG\pgConnection.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , LibPQ
 , daTypes
 , daLongProcessSubscriberList
 , pgDataProviderParams
;

type
 TpgLockAction = (
  pg_laLock
  , pg_laUnLock
 );//TpgLockAction

 TpgLockLevel = (
  pg_llShared
  , pg_llExclusive
 );//TpgLockLevel

 TpgConnection = class(Tl3ProtoObject)
  private
   f_InTransaction: Boolean;
   f_TransactionTables: TdaTablesSet;
   f_LongProcessList: TdaLongProcessSubscriberList;
   f_Handle: PPGconn;
    {* Поле для свойства Handle }
  private
   function BuildConnectString(const anUser: AnsiString;
    const aPassword: AnsiString;
    const aDatabase: AnsiString;
    aParams: TpgDataProviderParams): AnsiString;
   function LockAction(Action: TpgLockAction;
    Level: TpgLockLevel;
    LockValue: Integer = -1): Boolean;
   procedure LockTable(aTableID: TdaTables);
   procedure UnlockTable(aTableID: TdaTables);
   procedure UnlockAllTransactionTables;
   procedure ExecSQLCommand(const anSQL: AnsiString);
   procedure DoBeginTransaction(aTables: TdaTablesSet);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function Lock(Level: TpgLockLevel): Boolean;
   procedure Unlock(Level: TpgLockLevel);
   constructor Create(aList: TdaLongProcessSubscriberList); reintroduce;
   procedure ConnectAs(const anUser: AnsiString;
    const aPassword: AnsiString;
    const aDatabase: AnsiString;
    aParams: TpgDataProviderParams);
   procedure Connect(aParams: TpgDataProviderParams);
   procedure Disconnect;
   function Connected: Boolean;
   function BeginTransaction(aTables: TdaTablesSet): Boolean;
   procedure CommitTransaction;
   procedure RollbackTransaction;
  public
   property Handle: PPGconn
    read f_Handle;
 end;//TpgConnection
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , pgInterfaces
 , TypInfo
 , SysUtils
;

function TpgConnection.BuildConnectString(const anUser: AnsiString;
 const aPassword: AnsiString;
 const aDatabase: AnsiString;
 aParams: TpgDataProviderParams): AnsiString;
//#UC START# *55F7BAE0023F_55F6875803A8_var*
//#UC END# *55F7BAE0023F_55F6875803A8_var*
begin
//#UC START# *55F7BAE0023F_55F6875803A8_impl*
 Result := Format('postgresql://postgres:admin@%s:%d/archi?client_encoding=WIN1251', [aParams.DataServerHostName, aParams.DataServerPort]);
//#UC END# *55F7BAE0023F_55F6875803A8_impl*
end;//TpgConnection.BuildConnectString

function TpgConnection.Lock(Level: TpgLockLevel): Boolean;
//#UC START# *564EE49B000D_55F6875803A8_var*
//#UC END# *564EE49B000D_55F6875803A8_var*
begin
//#UC START# *564EE49B000D_55F6875803A8_impl*
 Result := LockAction(pg_laLock, Level);
//#UC END# *564EE49B000D_55F6875803A8_impl*
end;//TpgConnection.Lock

procedure TpgConnection.Unlock(Level: TpgLockLevel);
//#UC START# *564EE4C50158_55F6875803A8_var*
//#UC END# *564EE4C50158_55F6875803A8_var*
begin
//#UC START# *564EE4C50158_55F6875803A8_impl*
 if not LockAction(pg_laUnLock, Level) then
  EPgError.Create('Не удалось отпустить базу');
//#UC END# *564EE4C50158_55F6875803A8_impl*
end;//TpgConnection.Unlock

function TpgConnection.LockAction(Action: TpgLockAction;
 Level: TpgLockLevel;
 LockValue: Integer = -1): Boolean;
//#UC START# *564EE4E40187_55F6875803A8_var*
var
  l_Result: PPGResult;
const
  cMap: array[TpgLockAction, TpgLockLevel] of String = (
   ('pg_try_advisory_lock_shared', 'pg_try_advisory_lock'),  // Lock
   ('pg_advisory_unlock_shared', 'pg_advisory_unlock')   // unLock
  );
//#UC END# *564EE4E40187_55F6875803A8_var*
begin
//#UC START# *564EE4E40187_55F6875803A8_impl*
 if PQstatus(f_Handle) <> CONNECTION_OK then
  raise Exception.Create(PQerrorMessage(f_Handle));

 l_Result := PQExec(f_Handle, PAnsiChar(Format('select %s(%d)', [cMap[Action, Level], LockValue])));
 try
  if not (PQresultStatus(l_Result) in [PGRES_EMPTY_QUERY, PGRES_COMMAND_OK, PGRES_TUPLES_OK]) then
   raise EpgError.Create(PQresultErrorMessage(l_Result));

  Assert(PQntuples(l_Result) = 1);
  Assert(PQnfields(l_Result) = 1);
  Result := AnsiSameText(PQgetvalue(l_Result, 0, 0), 't');
 finally
  PQclear(l_Result);
 end;
//#UC END# *564EE4E40187_55F6875803A8_impl*
end;//TpgConnection.LockAction

procedure TpgConnection.LockTable(aTableID: TdaTables);
//#UC START# *565D75C902C3_55F6875803A8_var*
//#UC END# *565D75C902C3_55F6875803A8_var*
begin
//#UC START# *565D75C902C3_55F6875803A8_impl*
 if not LockAction(pg_laLock, pg_llExclusive, Ord(aTableID)) then
  raise EpgLockError.CreateFmt('Can''t lock table %s', [GetEnumName(TypeInfo(TdaTables), ord(aTableID))]);
//#UC END# *565D75C902C3_55F6875803A8_impl*
end;//TpgConnection.LockTable

procedure TpgConnection.UnlockTable(aTableID: TdaTables);
//#UC START# *565D75E80254_55F6875803A8_var*
//#UC END# *565D75E80254_55F6875803A8_var*
begin
//#UC START# *565D75E80254_55F6875803A8_impl*
 LockAction(pg_laUnLock, pg_llExclusive, Ord(aTableID));
//#UC END# *565D75E80254_55F6875803A8_impl*
end;//TpgConnection.UnlockTable

procedure TpgConnection.UnlockAllTransactionTables;
//#UC START# *565D9862017B_55F6875803A8_var*
var
 l_IDX: TdaTables;
//#UC END# *565D9862017B_55F6875803A8_var*
begin
//#UC START# *565D9862017B_55F6875803A8_impl*
 for l_IDX := Low(TdaTables) to High(TdaTables) do
  if l_IDX in f_TransactionTables then
   UnlockTable(l_IDX);
 f_TransactionTables := [];
//#UC END# *565D9862017B_55F6875803A8_impl*
end;//TpgConnection.UnlockAllTransactionTables

procedure TpgConnection.ExecSQLCommand(const anSQL: AnsiString);
//#UC START# *565D98760004_55F6875803A8_var*
var
  l_Result: PPGResult;
//#UC END# *565D98760004_55F6875803A8_var*
begin
//#UC START# *565D98760004_55F6875803A8_impl*
 l_Result := PQExec(f_Handle, PAnsiChar(anSQL));
 try
  if not (PQresultStatus(l_Result) in [PGRES_EMPTY_QUERY, PGRES_COMMAND_OK, PGRES_TUPLES_OK]) then
   raise EpgError.Create(PQresultErrorMessage(l_Result));
 finally
  PQclear(l_Result);
 end;
//#UC END# *565D98760004_55F6875803A8_impl*
end;//TpgConnection.ExecSQLCommand

procedure TpgConnection.DoBeginTransaction(aTables: TdaTablesSet);
//#UC START# *565D9EA2007D_55F6875803A8_var*
var
 l_IDX: TdaTables;
//#UC END# *565D9EA2007D_55F6875803A8_var*
begin
//#UC START# *565D9EA2007D_55F6875803A8_impl*
 Assert(not f_InTransaction);
 try
  for l_IDX := Low(TdaTables) to High(TdaTables) do
   if l_IDX in aTables then
   begin
    LockTable(l_IDX);
    Include(f_TransactionTables, l_IDX)
   end;
 except
  on EpgLockError do
  begin
   UnlockAllTransactionTables;
   raise;
  end;
 end;
 ExecSQLCommand('START TRANSACTION');
 f_InTransaction := True;
//#UC END# *565D9EA2007D_55F6875803A8_impl*
end;//TpgConnection.DoBeginTransaction

constructor TpgConnection.Create(aList: TdaLongProcessSubscriberList);
//#UC START# *565EA7B30042_55F6875803A8_var*
//#UC END# *565EA7B30042_55F6875803A8_var*
begin
//#UC START# *565EA7B30042_55F6875803A8_impl*
 inherited Create;
 aList.SetRefTo(f_LongProcessList);
//#UC END# *565EA7B30042_55F6875803A8_impl*
end;//TpgConnection.Create

procedure TpgConnection.ConnectAs(const anUser: AnsiString;
 const aPassword: AnsiString;
 const aDatabase: AnsiString;
 aParams: TpgDataProviderParams);
//#UC START# *569636A400D9_55F6875803A8_var*
var
 l_Message: AnsiString;
//#UC END# *569636A400D9_55F6875803A8_var*
begin
//#UC START# *569636A400D9_55F6875803A8_impl*
 f_Handle := PQconnectdb(PAnsiChar(BuildConnectString(anUser, aPassword, aDatabase, aParams)));
 if PQstatus(f_Handle) <> CONNECTION_OK then
 begin
  l_Message := PQerrorMessage(f_Handle);
  PQfinish(f_Handle);
  f_Handle := nil;
  raise EPgError.Create(l_Message);
 end;
 if not Lock(pg_llShared) then
  EPgError.Create('Не удалось захватить базу');
//#UC END# *569636A400D9_55F6875803A8_impl*
end;//TpgConnection.ConnectAs

procedure TpgConnection.Connect(aParams: TpgDataProviderParams);
//#UC START# *55F68CE401CB_55F6875803A8_var*
var
 l_Message: AnsiString;
//#UC END# *55F68CE401CB_55F6875803A8_var*
begin
//#UC START# *55F68CE401CB_55F6875803A8_impl*
  f_Handle := PQconnectdb(PAnsiChar(BuildConnectString(aParams)));
  if PQstatus(f_Handle) <> CONNECTION_OK then
  begin
   l_Message := PQerrorMessage(f_Handle);
   PQfinish(f_Handle);
   f_Handle := nil;
   raise EPgError.Create(l_Message);
  end;
//#UC END# *55F68CE401CB_55F6875803A8_impl*
end;//TpgConnection.Connect

procedure TpgConnection.Disconnect;
//#UC START# *55F68CFA009F_55F6875803A8_var*
var
 l_Message: AnsiString;
//#UC END# *55F68CFA009F_55F6875803A8_var*
begin
//#UC START# *55F68CFA009F_55F6875803A8_impl*
 if Assigned(f_Handle) then
 begin
  try
   if PQstatus(f_Handle) <> CONNECTION_OK then
    raise EPgError.Create(PQerrorMessage(f_Handle))
  finally
   PQfinish(f_Handle);
   f_Handle := nil;
  end;
 end;
//#UC END# *55F68CFA009F_55F6875803A8_impl*
end;//TpgConnection.Disconnect

function TpgConnection.Connected: Boolean;
//#UC START# *55F68D160072_55F6875803A8_var*
//#UC END# *55F68D160072_55F6875803A8_var*
begin
//#UC START# *55F68D160072_55F6875803A8_impl*
 Result := Assigned(f_Handle);
//#UC END# *55F68D160072_55F6875803A8_impl*
end;//TpgConnection.Connected

function TpgConnection.BeginTransaction(aTables: TdaTablesSet): Boolean;
//#UC START# *565D75140131_55F6875803A8_var*
//#UC END# *565D75140131_55F6875803A8_var*
begin
//#UC START# *565D75140131_55F6875803A8_impl*
 Result := False;
 try
  DoBeginTransaction(aTables);
  Result := True;
 except
  on EpgLockError do
  begin
   if Assigned(f_LongProcessList) then
    f_LongProcessList.LongProcessNotify(da_psStart);
   try
    repeat
     Sleep(200);
     try
      DoBeginTransaction(aTables);
      Result := True;
      Exit;
     except
      on EpgLockError do
      begin
       if Assigned(f_LongProcessList) and f_LongProcessList.LongProcessNotify(da_psCurrent) then
        Exit;
      end;
     end;
    until False;
   finally
    if Assigned(f_LongProcessList) then
     f_LongProcessList.LongProcessNotify(da_psEnd);
   end;
  end;
 end;
//#UC END# *565D75140131_55F6875803A8_impl*
end;//TpgConnection.BeginTransaction

procedure TpgConnection.CommitTransaction;
//#UC START# *565D753001A0_55F6875803A8_var*
//#UC END# *565D753001A0_55F6875803A8_var*
begin
//#UC START# *565D753001A0_55F6875803A8_impl*
 ExecSQLCommand('COMMIT');
 f_InTransaction := False;
 UnlockAllTransactionTables;
//#UC END# *565D753001A0_55F6875803A8_impl*
end;//TpgConnection.CommitTransaction

procedure TpgConnection.RollbackTransaction;
//#UC START# *565D753C0370_55F6875803A8_var*
//#UC END# *565D753C0370_55F6875803A8_var*
begin
//#UC START# *565D753C0370_55F6875803A8_impl*
 ExecSQLCommand('ROLLBACK');
 f_InTransaction := False;
 UnlockAllTransactionTables;
//#UC END# *565D753C0370_55F6875803A8_impl*
end;//TpgConnection.RollbackTransaction

procedure TpgConnection.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55F6875803A8_var*
//#UC END# *479731C50290_55F6875803A8_var*
begin
//#UC START# *479731C50290_55F6875803A8_impl*
 FreeAndNil(f_LongProcessList);
 inherited;
//#UC END# *479731C50290_55F6875803A8_impl*
end;//TpgConnection.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
