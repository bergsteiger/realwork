unit TableSelectTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TTableSelectTest = class(TTextEditorVisitor)
  {* ������� ���� ��� ������ � ���������� ������� }
  function GetTablePara(const aDocument: InevParaList): InevParaList;
   {* ���������� �������� � �������� }
  function SelectColumn(var aColID: Integer): Boolean;
   {* �������� ������� aColID }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TTableSelectTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , evOp
 , TestFrameWork
;

end.
