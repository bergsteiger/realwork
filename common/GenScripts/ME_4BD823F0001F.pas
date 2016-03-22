unit K207013375;
 {* [RequestLink:207013375] }

// ������: "w:\common\components\rtl\Garant\Daily\K207013375.pas"
// ���������: "TestCase"
// ������� ������: "K207013375" MUID: (4BD823F0001F)
// ��� ����: "TK207013375"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK207013375 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:207013375] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK207013375
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK207013375.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK207013375.GetFolder

function TK207013375.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BD823F0001F';
end;//TK207013375.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK207013375.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
