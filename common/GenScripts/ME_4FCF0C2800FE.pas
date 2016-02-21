unit K370384889;
 {* [Requestlink:370384889] }

// ������: "w:\archi\source\projects\Archi\Tests\K370384889.pas"
// ���������: "TestCase"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK370384889 = class(TArchiInsiderTest)
  {* [Requestlink:370384889] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK370384889
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK370384889.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'OEMTextTests';
end;//TK370384889.GetFolder

function TK370384889.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FCF0C2800FE';
end;//TK370384889.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370384889.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
