unit pgTabledQuery;

interface

uses
 l3IntfUses
 , daTabledQuery
 , pgConnection
 , pgInterfaces
 , daInterfaces
 , daParamList
;

type
 TpgTabledQuery = class(TdaTabledQuery)
  procedure Create(const aDataConverter: IpgDataConverter;
   const aTable: IdaTableDescription;
   aConnection: TpgConnection;
   const anAlias: AnsiString);
  function Make(const aDataConverter: IpgDataConverter;
   const aTable: IdaTableDescription;
   aConnection: TpgConnection;
   const anAlias: AnsiString): IdaTabledQuery;
  function BuildSQL: AnsiString;
  function MakeFromTable(const aTable: IdaTableDescription;
   const anAlias: AnsiString): IdaFromTable;
  function MakeResultSet(Unidirectional: Boolean): IdaResultSet;
  procedure PrepareTable;
  procedure UnprepareTable;
 end;//TpgTabledQuery
 
implementation

uses
 l3ImplUses
 , pgFromTable
 , SysUtils
 , LibPQ
 , pgUtils
 , pgParamList
 , pgResultSet
;

end.
