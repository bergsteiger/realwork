unit K249333540;
 {* [$249333540] }

// ������: "w:\common\components\rtl\Garant\Daily\K249333540.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewWithRowCompare
;

type
 TK249333540 = class(TPreviewWithRowCompare)
  {* [$249333540] }
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
 end;//TK249333540
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
function TK249333540.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4D1C43DD0156_var*
//#UC END# *4C07AC6F036D_4D1C43DD0156_var*
begin
//#UC START# *4C07AC6F036D_4D1C43DD0156_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D1C43DD0156_impl*
end;//TK249333540.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK249333540.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK249333540.GetFolder

function TK249333540.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D1C43DD0156';
end;//TK249333540.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK249333540.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D1C43DD0156_var*
//#UC END# *51AF49E5001B_4D1C43DD0156_var*
begin
//#UC START# *51AF49E5001B_4D1C43DD0156_impl*
 Result := true;
//#UC END# *51AF49E5001B_4D1C43DD0156_impl*
end;//TK249333540.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK249333540.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
