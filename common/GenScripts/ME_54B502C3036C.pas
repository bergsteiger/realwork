unit K585940693;
 {* [RequestLink:585940693] }

// ������: "w:\common\components\rtl\Garant\Daily\K585940693.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK585940693 = class(THTMLtoEVDTest)
  {* [RequestLink:585940693] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK585940693
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK585940693.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK585940693.GetFolder

function TK585940693.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54B502C3036C';
end;//TK585940693.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK585940693.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
