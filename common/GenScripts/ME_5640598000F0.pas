unit daLogicCondition;

interface

uses
 l3IntfUses
 , daCondition
 , daInterfaces
 , daTypes
;

type
 TdaLogicCondition = class(TdaCondition, IdaCondition)
  procedure Create(const aLeft: IdaCondition;
   anOperation: TdaLogicOperation;
   const aRight: IdaCondition);
  function Make(const aLeft: IdaCondition;
   anOperation: TdaLogicOperation;
   const aRight: IdaCondition): IdaCondition;
  procedure IterateX;
  function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
 end;//TdaLogicCondition
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
