unit SearchAndReplaceTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/SearchAndReplaceTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TSearchAndReplaceTest
//
// Тест поиска/замены
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
 TSearchAndReplaceTest = {abstract} class(TSearchAndReplacePrimTest)
  {* Тест поиска/замены }
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
 protected
 // protected methods
   function StringForSearch: AnsiString; virtual; abstract;
     {* Строка для поиска }
   function StringForReplace: AnsiString; virtual; abstract;
     {* Строка для замены }
 end;//TSearchAndReplaceTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evSearch,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TSearchAndReplaceTest

function TSearchAndReplaceTest.Searcher: IevSearcher;
//#UC START# *4C288BAA0058_4BE04F030356_var*
//#UC END# *4C288BAA0058_4BE04F030356_var*
begin
//#UC START# *4C288BAA0058_4BE04F030356_impl*
 Result := TevBMTextSearcher.Make(StringForSearch, Options);
//#UC END# *4C288BAA0058_4BE04F030356_impl*
end;//TSearchAndReplaceTest.Searcher

function TSearchAndReplaceTest.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4BE04F030356_var*
//#UC END# *4C288BFC002C_4BE04F030356_var*
begin
//#UC START# *4C288BFC002C_4BE04F030356_impl*
 Result := TevTextReplacer.Make(StringForReplace, Options);
//#UC END# *4C288BFC002C_4BE04F030356_impl*
end;//TSearchAndReplaceTest.Replacer

function TSearchAndReplaceTest.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4BE04F030356_var*
//#UC END# *4C288CC60231_4BE04F030356_var*
begin
//#UC START# *4C288CC60231_4BE04F030356_impl*
 Result := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];
//#UC END# *4C288CC60231_4BE04F030356_impl*
end;//TSearchAndReplaceTest.Options

function TSearchAndReplaceTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TSearchAndReplaceTest.GetFolder

function TSearchAndReplaceTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BE04F030356';
end;//TSearchAndReplaceTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.