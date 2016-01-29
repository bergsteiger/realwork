unit daSubQueryCondition;

interface

uses
 l3IntfUses
 , daCondition
 , daInterfaces
;

type
 TdaSubQueryCondition = class(TdaCondition)
  procedure Create(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const aQuery: IdaTabledQuery);
  function Make(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const aQuery: IdaTabledQuery): IdaCondition;
  function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
 end;//TdaSubQueryCondition
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
