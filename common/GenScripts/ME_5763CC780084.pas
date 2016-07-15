unit K624709249;
 {* [Requestlink:624709249] }

// ������: "w:\common\components\rtl\Garant\Daily\K624709249.pas"
// ���������: "TestCase"
// ������� ������: "K624709249" MUID: (5763CC780084)
// ��� ����: "TK624709249"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK624709249 = class(THTMLtoEVDFull)
  {* [Requestlink:624709249] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK624709249
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK624709249.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK624709249.GetFolder

function TK624709249.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5763CC780084';
end;//TK624709249.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624709249.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
