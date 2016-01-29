unit pgTableModifier;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daParamList
 , daInterfaces
 , pgConnection
 , daTypes
;

type
 TpgTableModifier = class(Tl3ProtoObject)
  procedure Create(aTableID: TdaTables;
   aConnection: TpgConnection;
   const aDataConverter: IdaDataConverter);
  procedure BuildSQLAndFillParams(aTableID: TdaTables;
   out anSQL: AnsiString;
   aParams: TdaParamList);
  procedure PrepareSQL(aTableID: TdaTables);
  procedure UnPrepareSQL;
  procedure Insert;
  function BeginTransaction: Boolean;
  procedure CommitTransaction;
  procedure RollBackTransaction;
 end;//TpgTableModifier
 
implementation

uses
 l3ImplUses
 , SysUtils
 , LibPQ
 , pgUtils
 , pgInterfaces
 , daScheme
;

end.
