unit MouseMoveSelectionTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TMouseMoveSelectionTest = class(TTextViaEditorProcessor)
  {* ��������� � ������� �������� ����. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TMouseMoveSelectionTest
 
implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
;

end.
