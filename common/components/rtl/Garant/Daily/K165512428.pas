unit K165512428;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K165512428.pas"
// Начат: 29.06.2010 17:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K165512428
//
// {RequestLink:165512428}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  SearchAndReplacePrimTest
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevTools,
  evTypes
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK165512428 = class(TSearchAndReplacePrimTest)
  {* [RequestLink:165512428] }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function Searcher: IevSearcher; override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function Replacer: IevReplacer; override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function Options: TevSearchOptionSet; override;
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK165512428
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evSearch,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK165512428

{$If defined(nsTest) AND not defined(NoVCM)}
function TK165512428.Searcher: IevSearcher;
//#UC START# *4C288BAA0058_4C29F9B202F8_var*
//#UC END# *4C288BAA0058_4C29F9B202F8_var*
begin
//#UC START# *4C288BAA0058_4C29F9B202F8_impl*
 Result := TevMorphologySearcher.Make('Приказом Минобороны');
//#UC END# *4C288BAA0058_4C29F9B202F8_impl*
end;//TK165512428.Searcher
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK165512428.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4C29F9B202F8_var*
//#UC END# *4C288BFC002C_4C29F9B202F8_var*
begin
//#UC START# *4C288BFC002C_4C29F9B202F8_impl*
 Result := TevTextReplacer.Make('$$$', Options);
//#UC END# *4C288BFC002C_4C29F9B202F8_impl*
end;//TK165512428.Replacer
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK165512428.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4C29F9B202F8_var*
//#UC END# *4C288CC60231_4C29F9B202F8_var*
begin
//#UC START# *4C288CC60231_4C29F9B202F8_impl*
 Result := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];
//#UC END# *4C288CC60231_4C29F9B202F8_impl*
end;//TK165512428.Options
{$IfEnd} //nsTest AND not NoVCM

function TK165512428.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK165512428.GetFolder

function TK165512428.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C29F9B202F8';
end;//TK165512428.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK165512428.Suite);

end.