unit TwoSpaceForOneReplacerTest;
 {* Тест замены одного пробела на один }

// Модуль: "w:\common\components\gui\Garant\Daily\TwoSpaceForOneReplacerTest.pas"
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
 TTwoSpaceForOneReplacerTest = {abstract} class(TSearchAndReplacePrimTest)
  {* Тест замены одного пробела на один }
  protected
   function Searcher: IevSearcher; override;
   function Replacer: IevReplacer; override;
   function Options: TevSearchOptionSet; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTwoSpaceForOneReplacerTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , evSearch
 , TestFrameWork
;

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
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TTwoSpaceForOneReplacerTest.GetFolder

function TTwoSpaceForOneReplacerTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3C4853033E';
end;//TTwoSpaceForOneReplacerTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
