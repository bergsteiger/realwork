unit K330704233;
 {* [Requestlink:330704233] }

// ������: "w:\archi\source\projects\Archi\Tests\K330704233.pas"
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
 TK330704233 = class(TArchiInsiderTest)
  {* [Requestlink:330704233] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK330704233
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK330704233.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK330704233.GetFolder

function TK330704233.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F2636EE02C7';
end;//TK330704233.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK330704233.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
