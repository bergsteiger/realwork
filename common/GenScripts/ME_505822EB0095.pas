unit K395647218;
 {* [Requestlink:395647218] }

// ������: "w:\archi\source\projects\Archi\Tests\K395647218.pas"
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
 TK395647218 = class(TArchiInsiderTest)
  {* [Requestlink:395647218] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK395647218
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK395647218.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK395647218.GetFolder

function TK395647218.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '505822EB0095';
end;//TK395647218.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK395647218.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
