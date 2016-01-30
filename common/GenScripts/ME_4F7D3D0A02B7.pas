unit K356063074;
 {* [Requestlink:356063074] }

// ������: "w:\archi\source\projects\Archi\Tests\K356063074.pas"
// ���������: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK356063074 = class(TArchiInsiderTest)
  {* [Requestlink:356063074] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK356063074
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK356063074.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK356063074.GetFolder

function TK356063074.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F7D3D0A02B7';
end;//TK356063074.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK356063074.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
