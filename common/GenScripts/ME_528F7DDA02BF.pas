unit tfwStackChecking.imp;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
;

type
 _tfwStackChecking_ = class(MtfwWord)
  function StackCheckingMessage: AnsiString;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//_tfwStackChecking_
 
implementation

uses
 l3ImplUses
;

end.
