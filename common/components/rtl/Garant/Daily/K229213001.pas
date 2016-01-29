unit K229213001;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K229213001.pas"
// Начат: 29.07.2010 17:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K229213001
//
// {RequestLink:229213001}
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
  SearchAndReplaceTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK229213001 = class(TSearchAndReplaceTest)
  {* [RequestLink:229213001] }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForSearch: AnsiString; override;
     {* Строка для поиска }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForReplace: AnsiString; override;
     {* Строка для замены }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK229213001
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
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

// start class TK229213001

{$If defined(nsTest) AND not defined(NoVCM)}
function TK229213001.StringForSearch: AnsiString;
//#UC START# *4BE051200169_4C5183260027_var*
//#UC END# *4BE051200169_4C5183260027_var*
begin
//#UC START# *4BE051200169_4C5183260027_impl*
 Result := 'bbb';
//#UC END# *4BE051200169_4C5183260027_impl*
end;//TK229213001.StringForSearch
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK229213001.StringForReplace: AnsiString;
//#UC START# *4BE0513800C9_4C5183260027_var*
//#UC END# *4BE0513800C9_4C5183260027_var*
begin
//#UC START# *4BE0513800C9_4C5183260027_impl*
 Result := #13#10;
//#UC END# *4BE0513800C9_4C5183260027_impl*
end;//TK229213001.StringForReplace
{$IfEnd} //nsTest AND not NoVCM

function TK229213001.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK229213001.GetFolder

function TK229213001.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C5183260027';
end;//TK229213001.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK229213001.Suite);

end.