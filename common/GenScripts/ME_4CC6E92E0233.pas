unit DeleteColumnToolTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TDeleteColumnToolTest = class(TTextViaEditorProcessor)
  {* ���� �������� ������� ����� �������� }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TDeleteColumnToolTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , nevTools
 , TestFrameWork
;

end.
