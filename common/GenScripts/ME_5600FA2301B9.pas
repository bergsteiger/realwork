unit daTabledQuery;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daSelectFieldList
 , daParamList
 , daTypes
;

type
 TdaTabledQuery = class(Tl3ProtoObject, IdaTabledQuery)
  procedure Create(const aDataConverter: IdaDataConverter;
   const aTable: IdaTableDescription;
   const anAlias: AnsiString);
  procedure AddParam(const aParamDesc: IdaParamDescription;
   aParamType: TdaParamType);
  function MakeFromTable(const aTable: IdaTableDescription;
   const anAlias: AnsiString): IdaFromTable;
  function MakeResultSet(Unidirectional: Boolean): IdaResultSet;
  procedure PrepareTable;
  procedure UnprepareTable;
  function MakeParamList: TdaParamList;
  function BuildFromClause: AnsiString;
  function BuildSelectClause: AnsiString;
  function BuildWhereClause(const aHelper: IdaParamListHelper): AnsiString;
  function OpenResultSet(Unidirectional: Boolean): IdaResultSet;
  procedure Prepare;
  function Param: IdaParam;
  procedure AddSelectField(const aField: IdaSelectField);
  procedure UnPrepare;
  function WhereCondition: IdaCondition;
  function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
  function Table: IdaFromTable;
 end;//TdaTabledQuery
 
implementation

uses
 l3ImplUses
 , SysUtils
 , daParam
;

end.
