unit K310673720;
 {* [RequestLink:310673720] }

// ������: "w:\archi\source\projects\Archi\Tests\K310673720.pas"
// ���������: "TestCase"
// ������� ������: "K310673720" MUID: (4ED7818400C7)
// ��� ����: "TK310673720"

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
 TK310673720 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [RequestLink:310673720] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK310673720
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK310673720.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SBSTests';
end;//TK310673720.GetFolder

function TK310673720.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4ED7818400C7';
end;//TK310673720.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK310673720.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
