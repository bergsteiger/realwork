unit AutoBlockTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TAutoBlockTest = class(TTextViaEditorProcessor)
  {* ���� ��������� ��������� �� ����� }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TAutoBlockTest
 
implementation

uses
 l3ImplUses
 , evAutoBlock
 , TestFrameWork
;

end.
