unit pgTableQueryFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , pgInterfaces
 , pgConnection
 , daTypes
;

type
 TpgTableQueryFactory = class(Tl3ProtoObject, IdaTableQueryFactory)
  procedure Create(const aDataConverter: IpgDataConverter;
   aConnection: TpgConnection);
  function Make(const aDataConverter: IpgDataConverter;
   aConnection: TpgConnection): IdaTableQueryFactory;
  function MakeTabledQuery(const aTable: IdaTableDescription;
   const anAlias: AnsiString): IdaTabledQuery;
  function MakeSelectField(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const anAlias: AnsiString): IdaSelectField;
  function MakeParamsCondition(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   anOperation: TdaCompareOperation;
   const aParamName: AnsiString): IdaCondition;
  function GetUserNameStr(anUserID: LargeInt): AnsiString;
  function DataConverter: IdaDataConverter;
  function MakeLogicCondition(const aLeft: IdaCondition;
   anOperation: TdaLogicOperation;
   const aRight: IdaCondition): IdaCondition;
  function MakeSubQueryCondition(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const aQuery: IdaTabledQuery): IdaCondition;
 end;//TpgTableQueryFactory
 
implementation

uses
 l3ImplUses
 , daSelectField
 , daParamsCondition
 , pgTabledQuery
 , daScheme
 , SysUtils
 , daLogicCondition
 , daSubQueryCondition
;

end.
