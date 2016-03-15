unit K619320841;
 {* [Requestlink:618678791]. ������� ������������. }

// ������: "w:\common\components\rtl\Garant\Daily\K619320841.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619320841 = class(THTMLtoEVDFull)
  {* [Requestlink:618678791]. ������� ������������. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619320841
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619320841.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619320841.GetFolder

function TK619320841.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E26DA00141';
end;//TK619320841.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619320841.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
