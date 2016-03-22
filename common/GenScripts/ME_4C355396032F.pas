unit K224135562;
 {* [RequestLink:224135562] }

// ������: "w:\common\components\rtl\Garant\Daily\K224135562.pas"
// ���������: "TestCase"
// ������� ������: "K224135562" MUID: (4C355396032F)
// ��� ����: "TK224135562"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK224135562 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:224135562] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK224135562
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK224135562.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK224135562.GetFolder

function TK224135562.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C355396032F';
end;//TK224135562.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224135562.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
