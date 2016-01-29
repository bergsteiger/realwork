unit K217688170;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K217688170.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K217688170
//
// [$217688170]
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
  PreviewTestBefore235875079
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK217688170 = class(TPreviewTestBefore235875079)
  {* [$217688170] }
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
 end;//TK217688170
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

// start class TK217688170

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217688170.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C20C4B30279_var*
//#UC END# *4C07AC6F036D_4C20C4B30279_var*
begin
//#UC START# *4C07AC6F036D_4C20C4B30279_impl*
 Result := 11;
//#UC END# *4C07AC6F036D_4C20C4B30279_impl*
end;//TK217688170.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK217688170.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK217688170.GetFolder

function TK217688170.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C20C4B30279';
end;//TK217688170.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK217688170.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C20C4B30279_var*
//#UC END# *51AF49E5001B_4C20C4B30279_var*
begin
//#UC START# *51AF49E5001B_4C20C4B30279_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C20C4B30279_impl*
end;//TK217688170.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK217688170.Suite);

end.