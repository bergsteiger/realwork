unit ScrollByLineTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TScrollByLineTest = class(TTextEditorVisitor)
  {* ���� ��������� ���� ��������� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TScrollByLineTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
