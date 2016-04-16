unit K336137156;
 {* [Requestlink:336137156] }

// ������: "w:\archi\source\projects\Archi\Tests\K336137156.pas"
// ���������: "TestCase"
// ������� ������: "TK336137156" MUID: (4F30E49D0064)

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
 TK336137156 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:336137156] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336137156
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK336137156.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK336137156.GetFolder

function TK336137156.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F30E49D0064';
end;//TK336137156.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336137156.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
