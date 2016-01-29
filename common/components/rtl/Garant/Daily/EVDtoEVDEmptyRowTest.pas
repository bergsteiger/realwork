unit EVDtoEVDEmptyRowTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoEVDEmptyRowTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDtoEVDEmptyRowTest
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
 TEVDtoEVDEmptyRowTest = {abstract} class(TEVDtoEVDWriterTest)
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoEVDEmptyRowTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evdEmptyRowFilter,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoEVDEmptyRowTest

procedure TEVDtoEVDEmptyRowTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C07BE700180_var*
//#UC END# *4C07BCBE01F2_4C07BE700180_var*
begin
//#UC START# *4C07BCBE01F2_4C07BE700180_impl*
 TevdEmptyRowFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C07BE700180_impl*
end;//TEVDtoEVDEmptyRowTest.SetFilters

function TEVDtoEVDEmptyRowTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDtoEVDEmptyRowTest.GetFolder

function TEVDtoEVDEmptyRowTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C07BE700180';
end;//TEVDtoEVDEmptyRowTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.