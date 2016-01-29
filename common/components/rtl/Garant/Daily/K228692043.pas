unit K228692043;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K228692043.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K228692043
//
// {RequestLink:228692043}
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
 TK228692043 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:228692043] }
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK228692043
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evUnblockEmptyParaFilter,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK228692043

procedure TK228692043.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C56D8F602AF_var*
//#UC END# *4C07BCBE01F2_4C56D8F602AF_var*
begin
//#UC START# *4C07BCBE01F2_4C56D8F602AF_impl*
 TevUnblockEmptyParaFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C56D8F602AF_impl*
end;//TK228692043.SetFilters

function TK228692043.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK228692043.GetFolder

function TK228692043.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C56D8F602AF';
end;//TK228692043.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK228692043.Suite);

end.