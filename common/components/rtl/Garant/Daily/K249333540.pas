unit K249333540;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K249333540.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K249333540
//
// [$249333540]
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
  PreviewWithRowCompare
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK249333540 = class(TPreviewWithRowCompare)
  {* [$249333540] }
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
 end;//TK249333540
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  PrintRowHeightsSpy
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

// start class TK249333540

{$If defined(nsTest) AND not defined(NoVCM)}
function TK249333540.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4D1C43DD0156_var*
//#UC END# *4C07AC6F036D_4D1C43DD0156_var*
begin
//#UC START# *4C07AC6F036D_4D1C43DD0156_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D1C43DD0156_impl*
end;//TK249333540.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK249333540.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK249333540.GetFolder

function TK249333540.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D1C43DD0156';
end;//TK249333540.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK249333540.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D1C43DD0156_var*
//#UC END# *51AF49E5001B_4D1C43DD0156_var*
begin
//#UC START# *51AF49E5001B_4D1C43DD0156_impl*
 Result := true;
//#UC END# *51AF49E5001B_4D1C43DD0156_impl*
end;//TK249333540.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK249333540.Suite);

end.