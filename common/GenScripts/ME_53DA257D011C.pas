unit kwMainCodeController;

interface

uses
 l3IntfUses
 , kwMain
 , tfwScriptingInterfaces
;

type
 TkwMainCodeController = class(TkwMain)
  procedure Create(aLambda: TtfwWord;
   aOuterContext: PtfwContext);
 end;//TkwMainCodeController
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
