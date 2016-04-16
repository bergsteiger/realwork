unit K165512428;
 {* [RequestLink:165512428] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K165512428.pas"
// Стереотип: "TestCase"
// Элемент модели: "K165512428" MUID: (4C29F9B202F8)
// Имя типа: "TK165512428"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , SearchAndReplacePrimTest
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evTypes
;

type
 TK165512428 = class({$If NOT Defined(NoVCM)}
 TSearchAndReplacePrimTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:165512428] }
  protected
   {$If NOT Defined(NoVCM)}
   function Searcher: IevSearcher; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function Replacer: IevReplacer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function Options: TevSearchOptionSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK165512428
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evSearch
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
function TK165512428.Searcher: IevSearcher;
//#UC START# *4C288BAA0058_4C29F9B202F8_var*
//#UC END# *4C288BAA0058_4C29F9B202F8_var*
begin
//#UC START# *4C288BAA0058_4C29F9B202F8_impl*
 Result := TevMorphologySearcher.Make('Приказом Минобороны');
//#UC END# *4C288BAA0058_4C29F9B202F8_impl*
end;//TK165512428.Searcher

function TK165512428.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4C29F9B202F8_var*
//#UC END# *4C288BFC002C_4C29F9B202F8_var*
begin
//#UC START# *4C288BFC002C_4C29F9B202F8_impl*
 Result := TevTextReplacer.Make('$$$', Options);
//#UC END# *4C288BFC002C_4C29F9B202F8_impl*
end;//TK165512428.Replacer

function TK165512428.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4C29F9B202F8_var*
//#UC END# *4C288CC60231_4C29F9B202F8_var*
begin
//#UC START# *4C288CC60231_4C29F9B202F8_impl*
 Result := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];
//#UC END# *4C288CC60231_4C29F9B202F8_impl*
end;//TK165512428.Options

function TK165512428.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK165512428.GetFolder

function TK165512428.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C29F9B202F8';
end;//TK165512428.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK165512428.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
