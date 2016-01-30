unit K111739572;
 {* [$111739572] }

// ������: "w:\common\components\rtl\Garant\Daily\K111739572.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CellMouseSelectionTest
;

type
 TK111739572 = class(TCellMouseSelectionTest)
  {* [$111739572] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK111739572
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK111739572.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK111739572.GetFolder

function TK111739572.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CED114A005A';
end;//TK111739572.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK111739572.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
