unit TwoEmptyParaForOneReplacerTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Daily/TwoEmptyParaForOneReplacerTest.pas"
// �����: 05.07.2010 16:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TTwoEmptyParaForOneReplacerTest
//
// ���� ������ ���� ������ ������� �� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  SearchAndReplacePrimTest,
  nevTools,
  evTypes
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TTwoEmptyParaForOneReplacerTest = {abstract} class(TSearchAndReplacePrimTest)
  {* ���� ������ ���� ������ ������� �� ���� }
 protected
 // realized methods
   function Searcher: IevSearcher; override;
   function Replacer: IevReplacer; override;
   function Options: TevSearchOptionSet; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTwoEmptyParaForOneReplacerTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  SysUtils,
  evSearch,
  TestFrameWork,
  vcmBase
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TTwoEmptyParaForOneReplacerTest

function TTwoEmptyParaForOneReplacerTest.Searcher: IevSearcher;
//#UC START# *4C288BAA0058_4C31CC59002B_var*
var
 l_Searcher : TevRegExpMultipartSearcher;
//#UC END# *4C288BAA0058_4C31CC59002B_var*
begin
//#UC START# *4C288BAA0058_4C31CC59002B_impl*
 l_Searcher := TevRegExpMultipartSearcher.Create;
 try
  l_Searcher.Options := Options;
  //l_Searcher.Multiblock := True;
  l_Searcher.Text := '$$';
  Result := l_Searcher;
 finally
  FreeAndNil(l_Searcher);
 end;//try..finally
//#UC END# *4C288BAA0058_4C31CC59002B_impl*
end;//TTwoEmptyParaForOneReplacerTest.Searcher

function TTwoEmptyParaForOneReplacerTest.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4C31CC59002B_var*
//#UC END# *4C288BFC002C_4C31CC59002B_var*
begin
//#UC START# *4C288BFC002C_4C31CC59002B_impl*
 Result := TevTextReplacer.Make(#13#10, Options);
//#UC END# *4C288BFC002C_4C31CC59002B_impl*
end;//TTwoEmptyParaForOneReplacerTest.Replacer

function TTwoEmptyParaForOneReplacerTest.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4C31CC59002B_var*
//#UC END# *4C288CC60231_4C31CC59002B_var*
begin
//#UC START# *4C288CC60231_4C31CC59002B_impl*
 Result := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];
//#UC END# *4C288CC60231_4C31CC59002B_impl*
end;//TTwoEmptyParaForOneReplacerTest.Options

function TTwoEmptyParaForOneReplacerTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TTwoEmptyParaForOneReplacerTest.GetFolder

function TTwoEmptyParaForOneReplacerTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C31CC59002B';
end;//TTwoEmptyParaForOneReplacerTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.