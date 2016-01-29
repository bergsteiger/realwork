unit tfwMappedArrayView;

interface

uses
 l3IntfUses
 , tfwLambdedArrayView
 , tfwScriptingInterfaces
;

type
 TtfwMapLambda = class(TtfwTwoLambdas)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwMapLambda
 
 TtfwMappedArrayView = class(TtfwLambdedArrayView)
  function TwoLabdasClass: RtfwTwoLambdas;
 end;//TtfwMappedArrayView
 
implementation

uses
 l3ImplUses
;

end.
