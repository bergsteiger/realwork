unit InsertFormulaTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TInsertFormulaTest = class(TTextViaEditorProcessor)
  {* ���� �� ������� �������. }
  function GetFormulaText: AnsiString;
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TInsertFormulaTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
