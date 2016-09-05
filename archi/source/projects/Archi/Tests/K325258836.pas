unit K325258836;
 {* [Requestlink:325258836] }

// ������: "w:\archi\source\projects\Archi\Tests\K325258836.pas"
// ���������: "TestCase"
// ������� ������: "K325258836" MUID: (4EFB1B6F03CD)
// ��� ����: "TK325258836"

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
 TK325258836 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:325258836] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK325258836
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4EFB1B6F03CDimpl_uses*
 //#UC END# *4EFB1B6F03CDimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK325258836.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK325258836.GetFolder

function TK325258836.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EFB1B6F03CD';
end;//TK325258836.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK325258836.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
