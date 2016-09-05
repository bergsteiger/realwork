unit K200902351;
 {* [$200902351] }

// ������: "w:\common\components\rtl\Garant\Daily\K200902351.pas"
// ���������: "TestCase"
// ������� ������: "K200902351" MUID: (4C383752005F)
// ��� ����: "TK200902351"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TableSelectTest
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK200902351 = class({$If NOT Defined(NoVCM)}
 TTableSelectTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$200902351] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* ���������� �������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SelectColumn(var aColID: Integer): Boolean; override;
    {* �������� ������� aColID }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK200902351
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C383752005Fimpl_uses*
 //#UC END# *4C383752005Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TK200902351.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* ���������� �������� � �������� }
//#UC START# *4C346D4B0351_4C383752005F_var*
//#UC END# *4C346D4B0351_4C383752005F_var*
begin
//#UC START# *4C346D4B0351_4C383752005F_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4C346D4B0351_4C383752005F_impl*
end;//TK200902351.GetTablePara

procedure TK200902351.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4C383752005F_var*
var
 l_Range : InevRange;
//#UC END# *4BE419AF0217_4C383752005F_var*
begin
//#UC START# *4BE419AF0217_4C383752005F_impl*
 inherited DoVisit(aForm);
 l_Range := aForm.Text.View.Control.Selection.GetBlock;
 l_Range := l_Range.GetChildSel(aForm.Text.View, 1, False); // �������...
 l_Range := l_Range.GetChildSel(aForm.Text.View, 1, False); // ������...
 l_Range := l_Range.GetChildSel(aForm.Text.View, 2, False); // ������...
 CheckTrue((l_Range <> nil) and (l_Range.Obj.PID = 2) and (l_Range.Obj^.OwnerObj.PID = 1), '�� �������� ������� ������ � ��������� �������!');
//#UC END# *4BE419AF0217_4C383752005F_impl*
end;//TK200902351.DoVisit

function TK200902351.SelectColumn(var aColID: Integer): Boolean;
 {* �������� ������� aColID }
//#UC START# *4C382DC50185_4C383752005F_var*
//#UC END# *4C382DC50185_4C383752005F_var*
begin
//#UC START# *4C382DC50185_4C383752005F_impl*
 Result := True;
 aColID := 2;
//#UC END# *4C382DC50185_4C383752005F_impl*
end;//TK200902351.SelectColumn

function TK200902351.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK200902351.GetFolder

function TK200902351.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C383752005F';
end;//TK200902351.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK200902351.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
