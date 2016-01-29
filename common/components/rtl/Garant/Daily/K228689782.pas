unit K228689782;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K228689782.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K228689782
//
// [$228689782]
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
 TK228689782 = class(TPreviewTestBefore235875079)
  {* [$228689782] }
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
 end;//TK228689782
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

// start class TK228689782

{$If defined(nsTest) AND not defined(NoVCM)}
function TK228689782.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C5FAB6C00EE_var*
//#UC END# *4C07AC6F036D_4C5FAB6C00EE_var*
begin
//#UC START# *4C07AC6F036D_4C5FAB6C00EE_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C5FAB6C00EE_impl*
end;//TK228689782.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK228689782.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK228689782.GetFolder

function TK228689782.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C5FAB6C00EE';
end;//TK228689782.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK228689782.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C5FAB6C00EE_var*
//#UC END# *51AF49E5001B_4C5FAB6C00EE_var*
begin
//#UC START# *51AF49E5001B_4C5FAB6C00EE_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C5FAB6C00EE_impl*
end;//TK228689782.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK228689782.Suite);

end.