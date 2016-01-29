unit htTableQueryFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , htInterfaces
 , daTypes
;

type
 ThtTableQueryFactory = class(Tl3ProtoObject, IdaTableQueryFactory)
  procedure Create(const aDataConverter: IhtDataConverter;
   const aHelper: IhtDataSchemeHelper);
  function Make(const aDataConverter: IhtDataConverter;
   const aHelper: IhtDataSchemeHelper): IdaTableQueryFactory;
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
 end;//ThtTableQueryFactory
 
implementation

uses
 l3ImplUses
 , htTabledQuery
 , daParamsCondition
 , daSelectField
 , dt_User
 , daLogicCondition
 , daSubQueryCondition
;

end.
