unit K233734230;
 {* [Requestlink:233734230] }

// ������: "w:\archi\source\projects\Archi\Tests\K233734230.pas"
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
 TK233734230 = class(TArchiInsiderTest)
  {* [Requestlink:233734230] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK233734230
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK233734230.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK233734230.GetFolder

function TK233734230.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F5F329B005B';
end;//TK233734230.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233734230.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
