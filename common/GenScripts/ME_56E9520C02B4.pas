unit K619944727_H11000224_1;
 {* [RequestLink:619944727] }

// ������: "w:\common\components\rtl\Garant\Daily\K619944727_H11000224_1.pas"
// ���������: "TestCase"
// ������� ������: "K619944727_H11000224_1" MUID: (56E9520C02B4)
// ��� ����: "TK619944727_H11000224_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619944727_H11000224_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619944727] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619944727_H11000224_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619944727_H11000224_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK619944727_H11000224_1.GetFolder

function TK619944727_H11000224_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E9520C02B4';
end;//TK619944727_H11000224_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619944727_H11000224_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
