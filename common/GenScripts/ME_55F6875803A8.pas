unit pgConnection;

interface

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
  function BuildConnectString(aParams: TpgDataProviderParams): AnsiString;
  function Lock(Level: TpgLockLevel): Boolean;
  procedure Unlock(Level: TpgLockLevel);
  function LockAction(Action: TpgLockAction;
   Level: TpgLockLevel;
   LockValue: Integer): Boolean;
  procedure LockTable(aTableID: TdaTables);
  procedure UnlockTable(aTableID: TdaTables);
  procedure UnlockAllTransactionTables;
  procedure ExecSQLCommand(const anSQL: AnsiString);
  procedure DoBeginTransaction(aTables: TdaTablesSet);
  procedure Create(aList: TdaLongProcessSubscriberList);
  procedure Connect(aParams: TpgDataProviderParams);
  procedure Disconnect;
  function Connected: Boolean;
  function BeginTransaction(aTables: TdaTablesSet): Boolean;
  procedure CommitTransaction;
  procedure RollbackTransaction;
 end;//TpgConnection
 
implementation

uses
 l3ImplUses
 , pgInterfaces
 , TypInfo
 , SysUtils
;

end.
