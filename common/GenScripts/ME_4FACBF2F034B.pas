unit K360481669;
 {* [Requestlink:360481669] }

// ������: "w:\archi\source\projects\Archi\Tests\K360481669.pas"
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
 TK360481669 = class(TArchiInsiderTest)
  {* [Requestlink:360481669] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK360481669
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK360481669.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Text2TableTests';
end;//TK360481669.GetFolder

function TK360481669.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FACBF2F034B';
end;//TK360481669.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK360481669.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
