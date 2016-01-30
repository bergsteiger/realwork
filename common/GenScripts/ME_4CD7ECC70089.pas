unit K239372528;
 {* [$239372528] }

// ������: "w:\common\components\rtl\Garant\Daily\K239372528.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertBreakInTextTableTest
;

type
 TK239372528 = class(TInsertBreakInTextTableTest)
  {* [$239372528] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK239372528
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK239372528.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK239372528.GetFolder

function TK239372528.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CD7ECC70089';
end;//TK239372528.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK239372528.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
