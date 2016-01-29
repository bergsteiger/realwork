unit EVDtoEVDEmptyRowAndEmptyTableTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoEVDEmptyRowAndEmptyTableTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDtoEVDEmptyRowAndEmptyTableTest
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
  EVDtoEVDEmptyRowTest,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoEVDEmptyRowAndEmptyTableTest = {abstract} class(TEVDtoEVDEmptyRowTest)
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoEVDEmptyRowAndEmptyTableTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evEmptyTableEliminator,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoEVDEmptyRowAndEmptyTableTest

procedure TEVDtoEVDEmptyRowAndEmptyTableTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_51C8347903A2_var*
//#UC END# *4C07BCBE01F2_51C8347903A2_var*
begin
//#UC START# *4C07BCBE01F2_51C8347903A2_impl*
 inherited;
 TevEmptyTableEliminator.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_51C8347903A2_impl*
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.SetFilters

function TEVDtoEVDEmptyRowAndEmptyTableTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.GetFolder

function TEVDtoEVDEmptyRowAndEmptyTableTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51C8347903A2';
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.