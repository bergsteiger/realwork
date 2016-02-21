unit K367198557;
 {* [$367198557] }

// ������: "w:\archi\source\projects\Archi\Tests\K367198557.pas"
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
 TK367198557 = class(TArchiInsiderTest)
  {* [$367198557] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK367198557
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK367198557.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ContentsTree';
end;//TK367198557.GetFolder

function TK367198557.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FCCBA5201D8';
end;//TK367198557.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK367198557.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
