unit K217678468;
 {* [RequestLink:217678468]. }

// ������: "w:\common\components\rtl\Garant\Daily\K217678468.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK217678468 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:217678468]. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217678468
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217678468.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217678468.GetFolder

function TK217678468.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C1A41370283';
end;//TK217678468.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217678468.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
