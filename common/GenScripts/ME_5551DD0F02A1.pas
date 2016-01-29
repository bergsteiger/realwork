unit daParamsCondition;

interface

uses
 l3IntfUses
 , daCondition
 , daInterfaces
 , daTypes
;

type
 TdaParamsCondition = class(TdaCondition, IdaFieldFromTable, IdaParamDescription, IdaAtomicCondition)
  procedure Create(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   anOperation: TdaCompareOperation;
   const aParamName: AnsiString);
  function Make(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   anOperation: TdaCompareOperation;
   const aParamName: AnsiString): IdaCondition;
  function AddCaseInsensetive(const aStr: AnsiString): AnsiString;
  function TableAlias: AnsiString;
  function Field: IdaFieldDescription;
  function Name: AnsiString;
  function DataType: TdaDataType;
  function Size: Integer;
  function Operation: TdaCompareOperation;
  function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
 end;//TdaParamsCondition
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
