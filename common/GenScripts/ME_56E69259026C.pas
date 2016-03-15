unit K619724818;
 {* [Requestlink:619724818] }

// ������: "w:\common\components\rtl\Garant\Daily\K619724818.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619724818 = class(THTMLtoEVDFull)
  {* [Requestlink:619724818] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619724818
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619724818.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619724818.GetFolder

function TK619724818.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E69259026C';
end;//TK619724818.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619724818.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
