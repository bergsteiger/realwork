unit DeleteCharTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorWithNavigate
 , evCustomEditorWindow
 , l3Variant
;

type
 TDeleteCharTest = class(_CursorMover_)
  function CharCount: Integer;
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* ������������� ������ ��� ��������� }
  procedure DoProcess(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
 end;//TDeleteCharTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
