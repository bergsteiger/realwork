unit EVDtoEVDSectionRepairTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoEVDSectionRepairTest.pas"
// �����: 10.06.2010 16:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDtoEVDSectionRepairTest
//
// ���� ��� {IconForPage:175539595} [$175539595]
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
 TEVDtoEVDSectionRepairTest = {abstract} class(TEVDtoEVDWriterTest)
  {* ���� ��� [IconForPage:175539595] [$175539595] }
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoEVDSectionRepairTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ddSectionRepair,
  ddSectionWithSub2Para,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoEVDSectionRepairTest

procedure TEVDtoEVDSectionRepairTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C10D6820047_var*
//#UC END# *4C07BCBE01F2_4C10D6820047_var*
begin
//#UC START# *4C07BCBE01F2_4C10D6820047_impl*
 TddSectionRepairFilter.SetTo(theGenerator);
 TddSectionWithSub2ParaFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C10D6820047_impl*
end;//TEVDtoEVDSectionRepairTest.SetFilters

function TEVDtoEVDSectionRepairTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDtoEVDSectionRepairTest.GetFolder

function TEVDtoEVDSectionRepairTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C10D6820047';
end;//TEVDtoEVDSectionRepairTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.