unit K382407838;
 {* [Requestlink:382407838] }

// ������: "w:\archi\source\projects\Archi\Tests\K382407838.pas"
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
 TK382407838 = class(TArchiInsiderTest)
  {* [Requestlink:382407838] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK382407838
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK382407838.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK382407838.GetFolder

function TK382407838.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '502A4778025B';
end;//TK382407838.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382407838.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
