unit K619577264_1;
 {* [RequestLink:619577264] }

// ������: "w:\common\components\rtl\Garant\Daily\K619577264_1.pas"
// ���������: "TestCase"
// ������� ������: "K619577264_1" MUID: (56E6B4AB03CF)
// ��� ����: "TK619577264_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619577264_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619577264] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619577264_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619577264_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619577264_1.GetFolder

function TK619577264_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E6B4AB03CF';
end;//TK619577264_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619577264_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
