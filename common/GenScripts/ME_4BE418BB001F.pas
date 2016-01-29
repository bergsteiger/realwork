unit TextEditorVisitorPrim;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorPrim
 , PrimTextLoad_Form
;

type
 TTextEditorVisitorPrim = class(TTextViaEditorProcessorPrim)
  {* ����, ���������� � ������� ��������� ����� ��������, �� �� ���������� ��� }
  procedure VisitText(const aStr: AnsiString);
   {* ���������� ��������� ��������� ������ }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
  function TreatExceptionAsSuccess: Boolean;
 end;//TTextEditorVisitorPrim
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , k2OperationContainer
;

end.
