unit InsertBreakInTextTableTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorWithNavigate
 , evCustomEditorWindow
 , l3Variant
;

type
 TInsertBreakInTextTableTest = class(TTextViaEditorProcessorWithNavigate)
  {* ������� ������ � ������������ ������� � ������ ��������� ������. }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* ������������� ������ ��� ��������� }
  procedure DoProcess(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
 end;//TInsertBreakInTextTableTest
 
implementation

uses
 l3ImplUses
 , nevBase
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
