unit K235050903;
 {* [RequestLink:235050903]. }

// ������: "w:\common\components\rtl\Garant\Daily\K235050903.pas"
// ���������: "TestCase"
// ������� ������: "K235050903" MUID: (4C92210103D6)
// ��� ����: "TK235050903"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDwithFormulasToRTFWriterTest
;

type
 TK235050903 = class(TEVDwithFormulasToRTFWriterTest)
  {* [RequestLink:235050903]. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK235050903
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235050903.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235050903.GetFolder

function TK235050903.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C92210103D6';
end;//TK235050903.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK235050903.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C92210103D6_var*
//#UC END# *51AF49E5001B_4C92210103D6_var*
begin
//#UC START# *51AF49E5001B_4C92210103D6_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C92210103D6_impl*
end;//TK235050903.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK235050903.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
