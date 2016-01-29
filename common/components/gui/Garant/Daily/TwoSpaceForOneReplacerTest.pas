unit TwoSpaceForOneReplacerTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/TwoSpaceForOneReplacerTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TTwoSpaceForOneReplacerTest
//
// Тест замены одного пробела на один
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
 TTwoSpaceForOneReplacerTest = {abstract} class(TSearchAndReplacePrimTest)
  {* Тест замены одного пробела на один }
 protected
 // realized methods
   function Searcher: IevSearcher; override;
   function Replacer: IevReplacer; override;
   function Options: TevSearchOptionSet; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TTwoSpaceForOneReplacerTest
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

// start class TTwoSpaceForOneReplacerTest

function TTwoSpaceForOneReplacerTest.Searcher: IevSearcher;
//#UC START# *4C288BAA0058_4C3C4853033E_var*
var
 l_Searcher : TevBMTextSearcher;
//#UC END# *4C288BAA0058_4C3C4853033E_var*
begin
//#UC START# *4C288BAA0058_4C3C4853033E_impl*
 l_Searcher := TevBMTextSearcher.Create;
 try
  l_Searcher.Options := Options;
  //l_Searcher.Multiblock := True;
  l_Searcher.Text := '  ';
  Result := l_Searcher;
 finally
  FreeAndNil(l_Searcher);
 end;//try..finally
//#UC END# *4C288BAA0058_4C3C4853033E_impl*
end;//TTwoSpaceForOneReplacerTest.Searcher

function TTwoSpaceForOneReplacerTest.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4C3C4853033E_var*
//#UC END# *4C288BFC002C_4C3C4853033E_var*
begin
//#UC START# *4C288BFC002C_4C3C4853033E_impl*
 Result := TevTextReplacer.Make(' ', Options);
//#UC END# *4C288BFC002C_4C3C4853033E_impl*
end;//TTwoSpaceForOneReplacerTest.Replacer

function TTwoSpaceForOneReplacerTest.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4C3C4853033E_var*
//#UC END# *4C288CC60231_4C3C4853033E_var*
begin
//#UC START# *4C288CC60231_4C3C4853033E_impl*
 Result := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];
//#UC END# *4C288CC60231_4C3C4853033E_impl*
end;//TTwoSpaceForOneReplacerTest.Options

function TTwoSpaceForOneReplacerTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TTwoSpaceForOneReplacerTest.GetFolder

function TTwoSpaceForOneReplacerTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3C4853033E';
end;//TTwoSpaceForOneReplacerTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.