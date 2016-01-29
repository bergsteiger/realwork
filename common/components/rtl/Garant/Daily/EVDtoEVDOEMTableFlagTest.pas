unit EVDtoEVDOEMTableFlagTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoEVDOEMTableFlagTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDtoEVDOEMTableFlagTest
//
// ���� �������"'�������� � �������������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  EVDtoEVDWriterTest,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoEVDOEMTableFlagTest = {abstract} class(TEVDtoEVDWriterTest)
  {* ���� �������"'�������� � �������������" }
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoEVDOEMTableFlagTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evOEMTableFlagFilter,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoEVDOEMTableFlagTest

procedure TEVDtoEVDOEMTableFlagTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C3FEDDA034A_var*
//#UC END# *4C07BCBE01F2_4C3FEDDA034A_var*
begin
//#UC START# *4C07BCBE01F2_4C3FEDDA034A_impl*
 TevOEMTableFlagFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C3FEDDA034A_impl*
end;//TEVDtoEVDOEMTableFlagTest.SetFilters

function TEVDtoEVDOEMTableFlagTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDtoEVDOEMTableFlagTest.GetFolder

function TEVDtoEVDOEMTableFlagTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3FEDDA034A';
end;//TEVDtoEVDOEMTableFlagTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.