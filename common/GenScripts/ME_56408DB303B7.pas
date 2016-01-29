unit daCondition;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TdaCondition = class(Tl3ProtoObject, IdaCondition)
  function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
  function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
  procedure Iterate;
 end;//TdaCondition
 
implementation

uses
 l3ImplUses
;

end.
