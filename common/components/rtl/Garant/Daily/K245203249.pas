unit K245203249;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K245203249.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K245203249
//
// [$245203249]
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
  PreviewTestBefore235875079WithRowCmp
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK245203249 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$245203249] }
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
 end;//TK245203249
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

// start class TK245203249

{$If defined(nsTest) AND not defined(NoVCM)}
function TK245203249.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4CFCA34C0058_var*
//#UC END# *4C07AC6F036D_4CFCA34C0058_var*
begin
//#UC START# *4C07AC6F036D_4CFCA34C0058_impl*
 Result := 11;
//#UC END# *4C07AC6F036D_4CFCA34C0058_impl*
end;//TK245203249.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK245203249.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK245203249.GetFolder

function TK245203249.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CFCA34C0058';
end;//TK245203249.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK245203249.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CFCA34C0058_var*
//#UC END# *51AF49E5001B_4CFCA34C0058_var*
begin
//#UC START# *51AF49E5001B_4CFCA34C0058_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CFCA34C0058_impl*
end;//TK245203249.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK245203249.Suite);

end.