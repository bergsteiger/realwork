unit K375849907;
 {* [Requestlink:375849907] }

// ������: "w:\archi\source\projects\Archi\Tests\K375849907.pas"
// ���������: "TestCase"
// ������� ������: "K375849907" MUID: (4FFBD3B40165)
// ��� ����: "TK375849907"

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
 TK375849907 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:375849907] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK375849907
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK375849907.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Drawing Tests';
end;//TK375849907.GetFolder

function TK375849907.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FFBD3B40165';
end;//TK375849907.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK375849907.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
