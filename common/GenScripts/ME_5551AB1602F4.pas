unit htTabledQuery;

interface

uses
 l3IntfUses
 , daTabledQuery
 , htInterfaces
 , daInterfaces
;

type
 ThtTabledQuery = class(TdaTabledQuery)
  procedure Create(const aDataConverter: IhtDataConverter;
   const aHelper: IhtDataSchemeHelper;
   const aTable: IdaTableDescription;
   const anAlias: AnsiString);
  function Make(const aDataConverter: IhtDataConverter;
   const aHelper: IhtDataSchemeHelper;
   const aTable: IdaTableDescription;
   const anAlias: AnsiString): IdaTabledQuery;
  function FindTable(const anAlias: AnsiString): IhtFromTable;
  function MakeFromTable(const aTable: IdaTableDescription;
   const anAlias: AnsiString): IdaFromTable;
  function MakeResultSet(Unidirectional: Boolean): IdaResultSet;
  procedure PrepareTable;
  procedure UnprepareTable;
 end;//ThtTabledQuery
 
implementation

uses
 l3ImplUses
 , htFromTable
 , daTypes
 , HT_Const
 , htResultSet
 , l3Base
 , HT_DLL
 , SysUtils
;

end.
