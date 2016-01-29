unit daParamList;

interface

uses
 l3IntfUses
 , daParamListPrim
 , daInterfaces
 , l3Types
;

type
 TdaParamList = class(TdaParamListPrim, IdaParamListHelper)
  function DoGetParamName(anIndex: Integer): AnsiString;
  function GetParamCode(const aParamName: AnsiString): AnsiString;
 end;//TdaParamList
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
