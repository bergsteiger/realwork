unit ExcludedTests;
 {* �����, ������� �� ���� ��������� - [$227477825]. }

// ������: "w:\common\components\rtl\Garant\DUnitTuning\ExcludedTests.pas"
// ���������: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3StringList
;

type
 TExcludedTests = class(Tl3StringList)
  {* �����, ������� �� ���� ��������� - [$227477825]. }
  public
   class function Exists: Boolean;
    {* ���������� ������ �� ��������� ���������� }
   class function Instance: TExcludedTests;
    {* ����� ��������� ���������� ���������� TExcludedTests }
 end;//TExcludedTests
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TExcludedTests: TExcludedTests = nil;
 {* ��������� ���������� TExcludedTests }

procedure TExcludedTestsFree;
 {* ����� ������������ ���������� ���������� TExcludedTests }
begin
 l3Free(g_TExcludedTests);
end;//TExcludedTestsFree

class function TExcludedTests.Exists: Boolean;
 {* ���������� ������ �� ��������� ���������� }
//#UC START# *4C446BAE00A3_4C44675A0269_var*
//#UC END# *4C446BAE00A3_4C44675A0269_var*
begin
//#UC START# *4C446BAE00A3_4C44675A0269_impl*
 Result := (g_TExcludedTests <> nil);
//#UC END# *4C446BAE00A3_4C44675A0269_impl*
end;//TExcludedTests.Exists

class function TExcludedTests.Instance: TExcludedTests;
 {* ����� ��������� ���������� ���������� TExcludedTests }
begin
 if (g_TExcludedTests = nil) then
 begin
  l3System.AddExitProc(TExcludedTestsFree);
  g_TExcludedTests := Create;
 end;
 Result := g_TExcludedTests;
end;//TExcludedTests.Instance
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
