unit K217688170;
 {* [$217688170] }

// ������: "w:\common\components\rtl\Garant\Daily\K217688170.pas"
// ���������: "TestCase"
// ������� ������: "K217688170" MUID: (4C20C4B30279)
// ��� ����: "TK217688170"

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
 TK217688170 = class({$If NOT Defined(NoVCM)}
 TPreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$217688170] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217688170
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
 //#UC START# *4C20C4B30279impl_uses*
 //#UC END# *4C20C4B30279impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK217688170.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C20C4B30279_var*
//#UC END# *4C07AC6F036D_4C20C4B30279_var*
begin
//#UC START# *4C07AC6F036D_4C20C4B30279_impl*
 Result := 11;
//#UC END# *4C07AC6F036D_4C20C4B30279_impl*
end;//TK217688170.GetNormalFontSize

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK217688170.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C20C4B30279_var*
//#UC END# *51AF49E5001B_4C20C4B30279_var*
begin
//#UC START# *51AF49E5001B_4C20C4B30279_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C20C4B30279_impl*
end;//TK217688170.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK217688170.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217688170.GetFolder

function TK217688170.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C20C4B30279';
end;//TK217688170.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217688170.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
