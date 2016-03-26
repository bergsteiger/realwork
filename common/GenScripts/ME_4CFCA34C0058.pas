unit K245203249;
 {* [$245203249] }

// ������: "w:\common\components\rtl\Garant\Daily\K245203249.pas"
// ���������: "TestCase"
// ������� ������: "K245203249" MUID: (4CFCA34C0058)
// ��� ����: "TK245203249"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewTestBefore235875079WithRowCmp
;

type
 TK245203249 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$245203249] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK245203249
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , PrintRowHeightsSpy
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
function TK245203249.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4CFCA34C0058_var*
//#UC END# *4C07AC6F036D_4CFCA34C0058_var*
begin
//#UC START# *4C07AC6F036D_4CFCA34C0058_impl*
 Result := 11;
//#UC END# *4C07AC6F036D_4CFCA34C0058_impl*
end;//TK245203249.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK245203249.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK245203249.GetFolder

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK245203249.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CFCA34C0058_var*
//#UC END# *51AF49E5001B_4CFCA34C0058_var*
begin
//#UC START# *51AF49E5001B_4CFCA34C0058_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CFCA34C0058_impl*
end;//TK245203249.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK245203249.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CFCA34C0058';
end;//TK245203249.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK245203249.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
