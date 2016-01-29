unit MoveSubTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorWithNavigate
 , evCustomEditorWindow
 , l3Variant
;

type
 TMoveSubTest = class(TTextViaEditorProcessorWithNavigate)
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* Устанавливает курсор или выделение }
  procedure DoProcess(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
 end;//TMoveSubTest
 
implementation

uses
 l3ImplUses
 , nevTools
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
