unit K217678457;
 {* [RequestLink:217678457] }

// ������: "w:\common\components\rtl\Garant\Daily\K217678457.pas"
// ���������: "TestCase"
// ������� ������: "K217678457" MUID: (4C2C8BBD0103)
// ��� ����: "TK217678457"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK217678457 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:217678457] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217678457
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217678457.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK217678457.GetFolder

function TK217678457.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C2C8BBD0103';
end;//TK217678457.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217678457.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
