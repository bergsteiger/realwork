unit K161121021;
 {* [Requestlink:161121021] }

// ������: "w:\archi\source\projects\Archi\Tests\K161121021.pas"
// ���������: "TestCase"
// ������� ������: "K161121021" MUID: (51F8F9690110)
// ��� ����: "TK161121021"

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
 TK161121021 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:161121021] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK161121021
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK161121021.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK161121021.GetFolder

function TK161121021.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51F8F9690110';
end;//TK161121021.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK161121021.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
