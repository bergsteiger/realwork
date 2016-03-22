unit K219123621;
 {* [$219123621] }

// ������: "w:\common\components\rtl\Garant\Daily\K219123621.pas"
// ���������: "TestCase"
// ������� ������: "K219123621" MUID: (4C20B38403A7)
// ��� ����: "TK219123621"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK219123621 = class(TPreviewTestBefore235875079)
  {* [$219123621] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK219123621
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
function TK219123621.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C20B38403A7_var*
//#UC END# *4C07AC6F036D_4C20B38403A7_var*
begin
//#UC START# *4C07AC6F036D_4C20B38403A7_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C20B38403A7_impl*
end;//TK219123621.GetNormalFontSize

function TK219123621.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK219123621.GetFolder

function TK219123621.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C20B38403A7';
end;//TK219123621.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK219123621.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C20B38403A7_var*
//#UC END# *51AF49E5001B_4C20B38403A7_var*
begin
//#UC START# *51AF49E5001B_4C20B38403A7_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C20B38403A7_impl*
end;//TK219123621.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK219123621.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
