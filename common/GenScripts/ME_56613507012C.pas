unit pgFunctionFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , pgConnection
 , pgFunction
 , pgParamDecsriptionList
;

type
 TpgFunctionFactory = class(Tl3ProtoObject)
  procedure Create(aConnection: TpgConnection);
  procedure FillParamDescriptions(aList: TpgParamDecsriptionList;
   const aFunctionName: AnsiString;
   const aSchemeName: AnsiString);
  function MakeFunction(const aFunctionName: AnsiString;
   const aSchemeName: AnsiString): TpgFunction;
 end;//TpgFunctionFactory
 
implementation

uses
 l3ImplUses
 , LibPQ
 , SysUtils
 , daScheme
 , pgInterfaces
;

end.
