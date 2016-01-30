unit K235864277;
 {* [$235864277] }

// ������: "w:\common\components\rtl\Garant\Daily\K235864277.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , DeleteSectionBreakTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK235864277 = class(TDeleteSectionBreakTest)
  {* [$235864277] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235864277
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235864277.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235864277.GetFolder

function TK235864277.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CAC43340210';
end;//TK235864277.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235864277.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
