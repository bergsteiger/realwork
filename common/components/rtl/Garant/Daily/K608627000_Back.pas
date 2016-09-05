unit K608627000_Back;
 {* [RequestLink:608627000] }

// ������: "w:\common\components\rtl\Garant\Daily\K608627000_Back.pas"
// ���������: "TestCase"
// ������� ������: "K608627000_Back" MUID: (561E75BA011D)
// ��� ����: "TK608627000_Back"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK608627000_Back = class(TNSRCtoEVDTest)
  {* [RequestLink:608627000] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK608627000_Back
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561E75BA011Dimpl_uses*
 //#UC END# *561E75BA011Dimpl_uses*
;

function TK608627000_Back.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK608627000_Back.GetFolder

function TK608627000_Back.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561E75BA011D';
end;//TK608627000_Back.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608627000_Back.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
