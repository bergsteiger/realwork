unit K447393371;
 {* [Requestlink:447393371] }

// ������: "w:\archi\source\projects\Archi\Tests\K447393371.pas"
// ���������: "TestCase"
// ������� ������: "K447393371" MUID: (5162771D0104)
// ��� ����: "TK447393371"

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
 TK447393371 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:447393371] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK447393371
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK447393371.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'MacrosTest';
end;//TK447393371.GetFolder

function TK447393371.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5162771D0104';
end;//TK447393371.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK447393371.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
