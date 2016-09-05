unit K621258431;
 {* [Requestlink:621258431] }

// ������: "w:\common\components\rtl\Garant\Daily\K621258431.pas"
// ���������: "TestCase"
// ������� ������: "K621258431" MUID: (570B7FC700ED)
// ��� ����: "TK621258431"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK621258431 = class(TNSRCtoEVDTest)
  {* [Requestlink:621258431] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK621258431
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *570B7FC700EDimpl_uses*
 //#UC END# *570B7FC700EDimpl_uses*
;

function TK621258431.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK621258431.GetFolder

function TK621258431.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '570B7FC700ED';
end;//TK621258431.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK621258431.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
