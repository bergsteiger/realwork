unit K282693895;
 {* [RequestLink:282693895] }

// ������: "w:\common\components\rtl\Garant\Daily\K282693895.pas"
// ���������: "TestCase"
// ������� ������: "K282693895" MUID: (4EEF59E700E3)
// ��� ����: "TK282693895"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , FormulaRender
;

type
 TK282693895 = class(TFormulaRender)
  {* [RequestLink:282693895] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK282693895
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

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK282693895.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4EEF59E700E3_var*
//#UC END# *51AF49E5001B_4EEF59E700E3_var*
begin
//#UC START# *51AF49E5001B_4EEF59E700E3_impl*
 Result := true;
//#UC END# *51AF49E5001B_4EEF59E700E3_impl*
end;//TK282693895.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK282693895.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK282693895.GetFolder

function TK282693895.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EEF59E700E3';
end;//TK282693895.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK282693895.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
