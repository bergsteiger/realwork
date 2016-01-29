unit tfwTruncatedArrayView;

interface

uses
 l3IntfUses
 , tfwLambdedArrayView
 , tfwScriptingInterfaces
;

type
 TtfwTruncLambda = class(TtfwTwoLambdas)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwTruncLambda
 
 TtfwTruncatedArrayView = class(TtfwLambdedArrayView)
  function TwoLabdasClass: RtfwTwoLambdas;
 end;//TtfwTruncatedArrayView
 
implementation

uses
 l3ImplUses
;

end.
