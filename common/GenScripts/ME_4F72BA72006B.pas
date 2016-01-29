unit kwEndWaitPrint;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEndWaitPrint = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEndWaitPrint
 
implementation

uses
 l3ImplUses
 , kwPrintDataSaver
;

end.
