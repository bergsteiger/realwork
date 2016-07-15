unit K624690924;
 {* [Requestlink:624690924] }

// ������: "w:\common\components\rtl\Garant\Daily\K624690924.pas"
// ���������: "TestCase"
// ������� ������: "K624690924" MUID: (57613E800272)
// ��� ����: "TK624690924"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLwoCSS
;

type
 TK624690924 = class(TEVDtoHTMLwoCSS)
  {* [Requestlink:624690924] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK624690924
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK624690924.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK624690924.GetFolder

function TK624690924.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '57613E800272';
end;//TK624690924.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624690924.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
