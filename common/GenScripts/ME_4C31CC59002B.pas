unit TwoEmptyParaForOneReplacerTest;
 {* Тест замены двух пустых абзацев на один }

// Модуль: "w:\common\components\gui\Garant\Daily\TwoEmptyParaForOneReplacerTest.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , SearchAndReplacePrimTest
 , nevTools
 , evTypes
;

type
 TTwoEmptyParaForOneReplacerTest = {abstract} class(TSearchAndReplacePrimTest)
  {* Тест замены двух пустых абзацев на один }
  protected
   function Searcher: IevSearcher; override;
   function Replacer: IevReplacer; override;
   function Options: TevSearchOptionSet; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTwoEmptyParaForOneReplacerTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , evSearch
 , TestFrameWork
 , vcmBase
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

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
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TTwoEmptyParaForOneReplacerTest.GetFolder

function TTwoEmptyParaForOneReplacerTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C31CC59002B';
end;//TTwoEmptyParaForOneReplacerTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
