unit kwBeginWaitPrint;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwBeginWaitPrint = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBeginWaitPrint
 
implementation

uses
 l3ImplUses
 , kwPrintDataSaver
;

end.
