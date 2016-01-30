unit K219124086;
 {* [$219124086] }

// ������: "w:\common\components\rtl\Garant\Daily\K219124086.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK219124086 = class(TScrollTest)
  {* [$219124086] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK219124086
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK219124086.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK219124086.GetFolder

function TK219124086.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C2461E602E1';
end;//TK219124086.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK219124086.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
