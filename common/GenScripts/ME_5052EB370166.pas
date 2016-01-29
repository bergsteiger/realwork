unit tfwClipboardFormatWord;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , evTypes
 , tfwScriptingInterfaces
;

type
 TtfwClipboardFormatWord = class(TtfwRegisterableWord)
  function GetFormat: TevFormat;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwClipboardFormatWord
 
implementation

uses
 l3ImplUses
;

end.
