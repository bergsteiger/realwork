unit K607531290;
 {* [RequestLink:607531290] }

// ������: "w:\common\components\rtl\Garant\Daily\K607531290.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK607531290 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:607531290] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK607531290
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607531290.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK607531290.GetFolder

function TK607531290.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561CFB0102F0';
end;//TK607531290.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607531290.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
