unit K224133899;
 {* [$224133899] }

// ������: "w:\common\components\rtl\Garant\Daily\K224133899.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Translate2TextTest
 , nevTools
;

type
 TK224133899 = class(TTranslate2TextTest)
  {* [$224133899] }
  protected
   function SelectTableWholly: Boolean; override;
    {* ������ ������� ������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* ���������� �������� � �������� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK224133899
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK224133899.SelectTableWholly: Boolean;
 {* ������ ������� ������� }
//#UC START# *4C34625E021F_4C346A9C0180_var*
//#UC END# *4C34625E021F_4C346A9C0180_var*
begin
//#UC START# *4C34625E021F_4C346A9C0180_impl*
 Result := True;
//#UC END# *4C34625E021F_4C346A9C0180_impl*
end;//TK224133899.SelectTableWholly

function TK224133899.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK224133899.GetFolder

function TK224133899.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* ���������� �������� � �������� }
//#UC START# *4CC818F4022D_4C346A9C0180_var*
//#UC END# *4CC818F4022D_4C346A9C0180_var*
begin
//#UC START# *4CC818F4022D_4C346A9C0180_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4C346A9C0180_impl*
end;//TK224133899.GetTablePara

function TK224133899.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C346A9C0180';
end;//TK224133899.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224133899.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
