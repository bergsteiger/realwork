unit K403079732;
 {* [Requestlink:403079732] }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K403079732.pas"
// ���������: "TestCase"
// ������� ������: "K403079732" MUID: (524146DB01BA)
// ��� ����: "TK403079732"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK403079732 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:403079732] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK403079732
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *524146DB01BAimpl_uses*
 //#UC END# *524146DB01BAimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK403079732.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FileFormatTests';
end;//TK403079732.GetFolder

function TK403079732.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '524146DB01BA';
end;//TK403079732.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK403079732.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
