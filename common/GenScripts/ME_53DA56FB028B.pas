unit kwVcmHistoryDeleteForwardItem;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmHistoryDeleteForwardItem = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmHistoryDeleteForwardItem
 
implementation

uses
 l3ImplUses
 , vcmForm
 , Controls
 , StdRes
 , vcmBase
 , afwAnswer
;

end.
