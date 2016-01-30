unit K211878862;
 {* [$211878862] }

// ������: "w:\common\components\rtl\Garant\Daily\K211878862.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK211878862 = class(TEVDtoNSRCOldWriterTest)
  {* [$211878862] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK211878862
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK211878862.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK211878862.GetFolder

function TK211878862.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BEBDEBA0161';
end;//TK211878862.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211878862.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
