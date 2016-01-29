unit nscSimpleEditor;

interface

uses
 l3IntfUses
 , evCustomMemo
 , evEditorWithOperations
 , Classes
 , Messages
 , nevBase
;

type
 TBreakingParaEvent = procedure(aSender: TObject;
  out aHandled: Boolean) of object;
 
 TnscSimpleEditor = class(TevCustomMemo)
 end;//TnscSimpleEditor
 
implementation

uses
 l3ImplUses
 , StdCtrls
 , Forms
 , Controls
 , TtfwClassRef_Proxy
;

end.
