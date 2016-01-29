unit K201493907;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K201493907.pas"
// Начат: 03.06.2010 17:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K201493907
//
// {RequestLink:201493907}
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
  ScrollTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK201493907 = class(TScrollTest)
  {* [RequestLink:201493907] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function ScrollByPage: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK201493907
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

// start class TK201493907

{$If defined(nsTest) AND not defined(NoVCM)}
function TK201493907.ScrollByPage: Boolean;
//#UC START# *4BEBFE020080_4C07A89B0179_var*
//#UC END# *4BEBFE020080_4C07A89B0179_var*
begin
//#UC START# *4BEBFE020080_4C07A89B0179_impl*
 Result := false;
//#UC END# *4BEBFE020080_4C07A89B0179_impl*
end;//TK201493907.ScrollByPage
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK201493907.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C07A89B0179_var*
//#UC END# *4C07AC6F036D_4C07A89B0179_var*
begin
//#UC START# *4C07AC6F036D_4C07A89B0179_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C07A89B0179_impl*
end;//TK201493907.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK201493907.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK201493907.GetFolder

function TK201493907.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C07A89B0179';
end;//TK201493907.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK201493907.Suite);

end.