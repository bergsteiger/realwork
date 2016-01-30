unit K395662507;
 {* [Requestlink:395662507] }

// ������: "w:\archi\source\projects\Archi\Tests\K395662507.pas"
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
 TK395662507 = class(TArchiInsiderTest)
  {* [Requestlink:395662507] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK395662507
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK395662507.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK395662507.GetFolder

function TK395662507.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '505C667503B3';
end;//TK395662507.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK395662507.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
