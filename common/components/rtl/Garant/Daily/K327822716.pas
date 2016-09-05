unit K327822716;
 {* [Requestlink:327822716] }

// ������: "w:\common\components\rtl\Garant\Daily\K327822716.pas"
// ���������: "TestCase"
// ������� ������: "K327822716" MUID: (4F1D275301BE)
// ��� ����: "TK327822716"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK327822716 = class(TAutoTest)
  {* [Requestlink:327822716] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK327822716
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F1D275301BEimpl_uses*
 //#UC END# *4F1D275301BEimpl_uses*
;

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK327822716.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4F1D275301BE_var*
//#UC END# *51AF49E5001B_4F1D275301BE_var*
begin
//#UC START# *51AF49E5001B_4F1D275301BE_impl*
 Result := true;
//#UC END# *51AF49E5001B_4F1D275301BE_impl*
end;//TK327822716.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK327822716.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScriptTest';
end;//TK327822716.GetFolder

function TK327822716.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F1D275301BE';
end;//TK327822716.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK327822716.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
