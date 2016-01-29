unit ComplexScrollByLines;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TComplexScrollByLines = class(TTextEditorVisitor)
  {* ���� ���� - ���������� �� ��������� ����� ����, � ����� �� ��������� �����. }
  function GetScrollLineCount2Down: Integer;
   {* ���������� ����� ��� ��������� ���� }
  function GetScrollLineCount2Up: Integer;
   {* ���������� ����� ��� ��������� ����� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TComplexScrollByLines
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
