unit DrawLineTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TDrawLineTest = class(TTextViaEditorProcessor)
  {* ���� ��������� ����� � ��������� }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TDrawLineTest
 
implementation

uses
 l3ImplUses
 , evOp
 , nevBase
 , evMsgCode
 , TestFrameWork
;

end.
