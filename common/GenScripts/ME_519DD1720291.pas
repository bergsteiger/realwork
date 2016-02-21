unit K448463392;
 {* [Requestlink:448463392] }

// ������: "w:\archi\source\projects\Archi\Tests\K448463392.pas"
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
 TK448463392 = class(TArchiInsiderTest)
  {* [Requestlink:448463392] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK448463392
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK448463392.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK448463392.GetFolder

function TK448463392.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '519DD1720291';
end;//TK448463392.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK448463392.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
