unit K608627000;
 {* [RequestLink:608627000] }

// ������: "w:\common\components\rtl\Garant\Daily\K608627000.pas"
// ���������: "TestCase"
// ������� ������: "K608627000" MUID: (561E6ACA013F)
// ��� ����: "TK608627000"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK608627000 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:608627000] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK608627000
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK608627000.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK608627000.GetFolder

function TK608627000.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561E6ACA013F';
end;//TK608627000.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608627000.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
