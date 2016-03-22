unit K409758383;
 {* [Requestlink:409758383] }

// ������: "w:\archi\source\projects\Archi\Tests\K409758383.pas"
// ���������: "TestCase"
// ������� ������: "K409758383" MUID: (50B86E6202C7)
// ��� ����: "TK409758383"

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
 TK409758383 = class(TArchiInsiderTest)
  {* [Requestlink:409758383] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK409758383
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK409758383.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ColumnResize';
end;//TK409758383.GetFolder

function TK409758383.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50B86E6202C7';
end;//TK409758383.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK409758383.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
