unit K598136171;
 {* [RequestLink:598136171] }

// ������: "w:\common\components\rtl\Garant\Daily\K598136171.pas"
// ���������: "TestCase"
// ������� ������: "K598136171" MUID: (561CF15C039F)
// ��� ����: "TK598136171"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK598136171 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:598136171] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK598136171
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK598136171.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK598136171.GetFolder

function TK598136171.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561CF15C039F';
end;//TK598136171.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598136171.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
