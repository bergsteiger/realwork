unit K392695706;
 {* [Requestlink:392695706] }

// ������: "w:\archi\source\projects\Archi\Tests\K392695706.pas"
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
 TK392695706 = class(TArchiInsiderTest)
  {* [Requestlink:392695706] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK392695706
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK392695706.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK392695706.GetFolder

function TK392695706.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '504F49F40264';
end;//TK392695706.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK392695706.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
