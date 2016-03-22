unit TableSelectTest;
 {* ������� ���� ��� ������ � ���������� ������� }

// ������: "w:\common\components\gui\Garant\Daily\TableSelectTest.pas"
// ���������: "TestCase"
// ������� ������: "TTableSelectTest" MUID: (4C382CB00345)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TTableSelectTest = {abstract} class(TTextEditorVisitor)
  {* ������� ���� ��� ������ � ���������� ������� }
  protected
   function GetTablePara(const aDocument: InevParaList): InevParaList; virtual; abstract;
    {* ���������� �������� � �������� }
   function SelectColumn(var aColID: Integer): Boolean; virtual;
    {* �������� ������� aColID }
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTableSelectTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , evOp
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TTableSelectTest.SelectColumn(var aColID: Integer): Boolean;
 {* �������� ������� aColID }
//#UC START# *4C382DC50185_4C382CB00345_var*
//#UC END# *4C382DC50185_4C382CB00345_var*
begin
//#UC START# *4C382DC50185_4C382CB00345_impl*
 Result := False;
 aColID := 0;
//#UC END# *4C382DC50185_4C382CB00345_impl*
end;//TTableSelectTest.SelectColumn

procedure TTableSelectTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4C382CB00345_var*
var
 l_ColID     : Integer;
 l_Selection : InevSelection;
//#UC END# *4BE419AF0217_4C382CB00345_var*
begin
//#UC START# *4BE419AF0217_4C382CB00345_impl*
 l_Selection := aForm.Text.Selection;
 if (l_Selection <> nil) and SelectColumn(l_ColID) then
  evSelectTableColumn(l_Selection, GetTablePara(aForm.Text.Document), l_ColID)
//#UC END# *4BE419AF0217_4C382CB00345_impl*
end;//TTableSelectTest.DoVisit

function TTableSelectTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TTableSelectTest.GetFolder

function TTableSelectTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C382CB00345';
end;//TTableSelectTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
