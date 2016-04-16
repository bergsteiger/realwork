unit K344138247;
 {* [Requestlink:344138247] }

// ������: "w:\archi\source\projects\Archi\Tests\K344138247.pas"
// ���������: "TestCase"
// ������� ������: "K344138247" MUID: (4F6086480381)
// ��� ����: "TK344138247"

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
 TK344138247 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:344138247] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK344138247
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK344138247.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Drawing Tests';
end;//TK344138247.GetFolder

function TK344138247.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F6086480381';
end;//TK344138247.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK344138247.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
