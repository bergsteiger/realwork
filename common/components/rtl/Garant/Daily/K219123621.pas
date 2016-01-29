unit K219123621;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K219123621.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K219123621
//
// [$219123621]
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
 TK219123621 = class(TPreviewTestBefore235875079)
  {* [$219123621] }
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
 end;//TK219123621
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

// start class TK219123621

{$If defined(nsTest) AND not defined(NoVCM)}
function TK219123621.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C20B38403A7_var*
//#UC END# *4C07AC6F036D_4C20B38403A7_var*
begin
//#UC START# *4C07AC6F036D_4C20B38403A7_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C20B38403A7_impl*
end;//TK219123621.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK219123621.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK219123621.GetFolder

function TK219123621.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C20B38403A7';
end;//TK219123621.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK219123621.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C20B38403A7_var*
//#UC END# *51AF49E5001B_4C20B38403A7_var*
begin
//#UC START# *51AF49E5001B_4C20B38403A7_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C20B38403A7_impl*
end;//TK219123621.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK219123621.Suite);

end.