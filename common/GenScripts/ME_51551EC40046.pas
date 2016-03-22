unit K444999575;
 {* [Requestlink:444999575] }

// ������: "w:\common\components\rtl\Garant\Daily\K444999575.pas"
// ���������: "TestCase"
// ������� ������: "K444999575" MUID: (51551EC40046)
// ��� ����: "TK444999575"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK444999575 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:444999575] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK444999575
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK444999575.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK444999575.GetFolder

function TK444999575.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51551EC40046';
end;//TK444999575.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK444999575.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
