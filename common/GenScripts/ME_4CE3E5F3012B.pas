unit SelectRowAndDeleteTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TSelectRowAndDeleteTest = class(TTextViaEditorProcessor)
  {* �������� ������ � �������. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TSelectRowAndDeleteTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evOp
 , evCursorTools
;

end.
