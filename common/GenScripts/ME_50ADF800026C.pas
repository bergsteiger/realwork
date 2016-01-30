unit K409757935;
 {* [Requestlink:409757935] }

// ������: "w:\archi\source\projects\Archi\Tests\K409757935.pas"
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
 TK409757935 = class(TArchiInsiderTest)
  {* [Requestlink:409757935] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK409757935
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK409757935.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Text2TableTests';
end;//TK409757935.GetFolder

function TK409757935.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50ADF800026C';
end;//TK409757935.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK409757935.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
