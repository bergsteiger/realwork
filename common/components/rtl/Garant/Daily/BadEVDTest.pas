unit BadEVDTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/BadEVDTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::BadEVD::TBadEVDTest
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
 TBadEVDTest = {abstract} class(TEVDtoEVDWriterTest)
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TBadEVDTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evdBadEVDToEmptyDocumentTranslator,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TBadEVDTest

procedure TBadEVDTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_53BC0D3900DF_var*
//#UC END# *4C07BCBE01F2_53BC0D3900DF_var*
begin
//#UC START# *4C07BCBE01F2_53BC0D3900DF_impl*
 TevdBadEVDToEmptyDocumentTranslator.SetTo(theGenerator, nil, 0);
//#UC END# *4C07BCBE01F2_53BC0D3900DF_impl*
end;//TBadEVDTest.SetFilters

function TBadEVDTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'BadEVD';
end;//TBadEVDTest.GetFolder

function TBadEVDTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53BC0D3900DF';
end;//TBadEVDTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.