unit K382420133;
 {* [Requestlink:382420133] }

// ������: "w:\archi\source\projects\Archi\Tests\K382420133.pas"
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
 TK382420133 = class(TArchiInsiderTest)
  {* [Requestlink:382420133] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK382420133
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK382420133.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Drawing Tests';
end;//TK382420133.GetFolder

function TK382420133.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5029F7BC03A6';
end;//TK382420133.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382420133.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
