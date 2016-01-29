unit K283149108;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K283149108.pas"
// Начат: 09.09.2011 15:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K283149108
//
// {RequestLink:283149108}
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
 TK283149108 = class(TPreviewTest)
  {* [RequestLink:283149108] }
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
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK283149108
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

// start class TK283149108

{$If defined(nsTest) AND not defined(NoVCM)}
function TK283149108.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4E69FCE30379_var*
//#UC END# *4C07AC6F036D_4E69FCE30379_var*
begin
//#UC START# *4C07AC6F036D_4E69FCE30379_impl*
 Result := 30;
//#UC END# *4C07AC6F036D_4E69FCE30379_impl*
end;//TK283149108.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK283149108.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK283149108.GetFolder

function TK283149108.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E69FCE30379';
end;//TK283149108.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK283149108.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4E69FCE30379_var*
//#UC END# *51AF49E5001B_4E69FCE30379_var*
begin
//#UC START# *51AF49E5001B_4E69FCE30379_impl*
 Result := true;
//#UC END# *51AF49E5001B_4E69FCE30379_impl*
end;//TK283149108.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK283149108.Suite);

end.