unit K602940462;
 {* [Requestlink:602940462] }

// ������: "w:\common\components\rtl\Garant\Daily\K602940462.pas"
// ���������: "TestCase"
// ������� ������: "K602940462" MUID: (559285D50289)
// ��� ����: "TK602940462"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK602940462 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:602940462] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK602940462
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK602940462.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK602940462.GetFolder

function TK602940462.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '559285D50289';
end;//TK602940462.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602940462.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
