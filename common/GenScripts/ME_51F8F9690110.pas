unit K161121021;
 {* [Requestlink:161121021] }

// ������: "w:\archi\source\projects\Archi\Tests\K161121021.pas"
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
 TK161121021 = class(TArchiInsiderTest)
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
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
