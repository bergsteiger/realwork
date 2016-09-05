unit K238420075;
 {* [$238420075] }

// ������: "w:\common\components\rtl\Garant\Daily\K238420075.pas"
// ���������: "TestCase"
// ������� ������: "K238420075" MUID: (4CC924C2000B)
// ��� ����: "TK238420075"

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
 TK238420075 = class({$If NOT Defined(NoVCM)}
 TPreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$238420075] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK238420075
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
 //#UC START# *4CC924C2000Bimpl_uses*
 //#UC END# *4CC924C2000Bimpl_uses*
;

{$If NOT Defined(NoVCM)}
{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK238420075.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CC924C2000B_var*
//#UC END# *51AF49E5001B_4CC924C2000B_var*
begin
//#UC START# *51AF49E5001B_4CC924C2000B_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CC924C2000B_impl*
end;//TK238420075.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK238420075.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK238420075.GetFolder

function TK238420075.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CC924C2000B';
end;//TK238420075.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK238420075.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
