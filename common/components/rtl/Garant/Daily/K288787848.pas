unit K288787848;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K288787848.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K288787848
//
// {Requestlink:288787848}
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
  PreviewTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK288787848 = class(TPreviewTest)
  {* [Requestlink:288787848] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK288787848
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

// start class TK288787848

{$If defined(nsTest) AND not defined(NoVCM)}
function TK288787848.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4E8ED6D1012B_var*
//#UC END# *4C07AC6F036D_4E8ED6D1012B_var*
begin
//#UC START# *4C07AC6F036D_4E8ED6D1012B_impl*
 Result := 30;
//#UC END# *4C07AC6F036D_4E8ED6D1012B_impl*
end;//TK288787848.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK288787848.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK288787848.GetFolder

function TK288787848.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E8ED6D1012B';
end;//TK288787848.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK288787848.Suite);

end.