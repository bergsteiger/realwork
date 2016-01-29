unit ExcludedTests;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DUnitTuning"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/DUnitTuning/ExcludedTests.pas"
// �����: 19.0.2010 18:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnitTuning::Source::TExcludedTests
//
// �����, ������� �� ���� ��������� - [$227477825].
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3StringList
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TExcludedTests = class(Tl3StringList)
  {* �����, ������� �� ���� ��������� - [$227477825]. }
 public
 // public methods
   class function Exists: Boolean;
     {* ���������� ������ �� ��������� ���������� }
 public
 // singleton factory method
   class function Instance: TExcludedTests;
    {- ���������� ��������� ����������. }
 end;//TExcludedTests
{$IfEnd} //nsTest AND not NotTunedDUnit

implementation

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3Base {a}
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}


// start class TExcludedTests

var g_TExcludedTests : TExcludedTests = nil;

procedure TExcludedTestsFree;
begin
 l3Free(g_TExcludedTests);
end;

class function TExcludedTests.Instance: TExcludedTests;
begin
 if (g_TExcludedTests = nil) then
 begin
  l3System.AddExitProc(TExcludedTestsFree);
  g_TExcludedTests := Create;
 end;
 Result := g_TExcludedTests;
end;


class function TExcludedTests.Exists: Boolean;
//#UC START# *4C446BAE00A3_4C44675A0269_var*
//#UC END# *4C446BAE00A3_4C44675A0269_var*
begin
//#UC START# *4C446BAE00A3_4C44675A0269_impl*
 Result := (g_TExcludedTests <> nil);
//#UC END# *4C446BAE00A3_4C44675A0269_impl*
end;//TExcludedTests.Exists

{$IfEnd} //nsTest AND not NotTunedDUnit

end.