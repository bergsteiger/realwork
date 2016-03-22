unit ScrollByLineTest;
 {* ���� ��������� ���� ��������� }

// ������: "w:\common\components\rtl\Garant\Daily\ScrollByLineTest.pas"
// ���������: "TestCase"
// ������� ������: "TScrollByLineTest" MUID: (4CB6E426014A)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TScrollByLineTest = {abstract} class(TTextEditorVisitor)
  {* ���� ��������� ���� ��������� }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollByLineTest
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
;

{$If NOT Defined(NoVCM)}
procedure TScrollByLineTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4CB6E426014A_var*
//#UC END# *4BE419AF0217_4CB6E426014A_var*
begin
//#UC START# *4BE419AF0217_4CB6E426014A_impl*
 ScrollByLine(aForm, -1, False, False);
//#UC END# *4BE419AF0217_4CB6E426014A_impl*
end;//TScrollByLineTest.DoVisit

function TScrollByLineTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TScrollByLineTest.GetFolder

function TScrollByLineTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CB6E426014A';
end;//TScrollByLineTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
