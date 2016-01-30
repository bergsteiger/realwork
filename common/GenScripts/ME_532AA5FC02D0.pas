unit K522096709;
 {* [Requestlink:522096709] }

// ������: "w:\archi\source\projects\Archi\Tests\K522096709.pas"
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
 TK522096709 = class(TArchiInsiderTest)
  {* [Requestlink:522096709] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK522096709
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK522096709.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ContentsTree';
end;//TK522096709.GetFolder

function TK522096709.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '532AA5FC02D0';
end;//TK522096709.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK522096709.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
