unit K227972911;
 {* [$227972911] }

// ������: "w:\common\components\rtl\Garant\Daily\K227972911.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
;

type
 TK227972911 = class(TMergeCellsTest)
  {* [$227972911] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK227972911
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK227972911.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK227972911.GetFolder

function TK227972911.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C4944510282';
end;//TK227972911.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227972911.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
