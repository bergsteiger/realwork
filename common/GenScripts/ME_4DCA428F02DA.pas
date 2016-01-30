unit K265412031;
 {* [$265412031] }

// ������: "w:\archi\source\projects\Archi\Tests\K265412031.pas"
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
 TK265412031 = class(TArchiInsiderTest)
  {* [$265412031] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK265412031
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK265412031.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Text2TableTests';
end;//TK265412031.GetFolder

function TK265412031.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DCA428F02DA';
end;//TK265412031.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK265412031.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
