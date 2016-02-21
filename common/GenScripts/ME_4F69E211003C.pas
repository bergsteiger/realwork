unit K349118532;
 {* [Requestlink:349118532] }

// ������: "w:\archi\source\projects\Archi\Tests\K349118532.pas"
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
 TK349118532 = class(TArchiInsiderTest)
  {* [Requestlink:349118532] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK349118532
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK349118532.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK349118532.GetFolder

function TK349118532.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F69E211003C';
end;//TK349118532.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK349118532.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
