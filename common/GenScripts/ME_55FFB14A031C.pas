unit daFromTable;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TdaFromTable = class(Tl3ProtoObject, IdaFromTable)
  procedure Create(const aTable: IdaTableDescription;
   const anAlias: AnsiString);
  function Make(const aTable: IdaTableDescription;
   const anAlias: AnsiString): IdaFromTable;
  function TableAlias: AnsiString;
  function Table: IdaTableDescription;
  function BuildSQLValue: AnsiString;
 end;//TdaFromTable
 
implementation

uses
 l3ImplUses
 , daScheme
 , SysUtils
;

end.
