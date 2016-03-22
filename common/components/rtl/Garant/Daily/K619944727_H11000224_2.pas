unit K619944727_H11000224_2;
 {* [RequestLink:619944727] }

// ������: "w:\common\components\rtl\Garant\Daily\K619944727_H11000224_2.pas"
// ���������: "TestCase"
// ������� ������: "K619944727_H11000224_2" MUID: (56E952270231)
// ��� ����: "TK619944727_H11000224_2"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619944727_H11000224_2 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619944727] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619944727_H11000224_2
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619944727_H11000224_2.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK619944727_H11000224_2.GetFolder

function TK619944727_H11000224_2.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E952270231';
end;//TK619944727_H11000224_2.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619944727_H11000224_2.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
