unit K619577264;
 {* [RequestLink:619577264] }

// ������: "w:\common\components\rtl\Garant\Daily\K619577264.pas"
// ���������: "TestCase"
// ������� ������: "K619577264" MUID: (56E6A57A00E2)
// ��� ����: "TK619577264"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619577264 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619577264] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619577264
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619577264.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619577264.GetFolder

function TK619577264.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E6A57A00E2';
end;//TK619577264.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619577264.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
