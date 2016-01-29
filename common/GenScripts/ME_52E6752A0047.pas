unit tfwFilteredArrayView;

interface

uses
 l3IntfUses
 , tfwLambdedArrayView
 , tfwScriptingInterfaces
;

type
 TtfwFilterLambda = class(TtfwTwoLambdas)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwFilterLambda
 
 TtfwFilteredArrayView = class(TtfwLambdedArrayView)
  function TwoLabdasClass: RtfwTwoLambdas;
 end;//TtfwFilteredArrayView
 
implementation

uses
 l3ImplUses
;

end.
