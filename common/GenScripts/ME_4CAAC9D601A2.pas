unit InsertRowTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TInsertRowTest = class(TTextViaEditorProcessor)
  {* ���� ������� ������ }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TInsertRowTest
 
implementation

uses
 l3ImplUses
 , evOp
 , TestFrameWork
;

end.
