unit K207388924;
 {* [RequestLink:207388924] }

// ������: "w:\common\components\rtl\Garant\Daily\K207388924.pas"
// ���������: "TestCase"
// ������� ������: "K207388924" MUID: (4BD83715018F)
// ��� ����: "TK207388924"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK207388924 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:207388924] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK207388924
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK207388924.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK207388924.GetFolder

function TK207388924.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BD83715018F';
end;//TK207388924.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK207388924.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
