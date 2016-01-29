unit K321983051;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K321983051.pas"
// Начат: 20.12.2011 18:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7 Lulin::K321983051
//
// {RequestLink:321983051}
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
  FormulaRender
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK321983051 = class(TFormulaRender)
  {* [RequestLink:321983051] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function GetZoom: Integer; override;
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK321983051
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

// start class TK321983051

function TK321983051.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7 Lulin';
end;//TK321983051.GetFolder

function TK321983051.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4EF0A00F0280';
end;//TK321983051.GetModelElementGUID

function TK321983051.GetZoom: Integer;
//#UC START# *4EF0A04A0286_4EF0A00F0280_var*
//#UC END# *4EF0A04A0286_4EF0A00F0280_var*
begin
//#UC START# *4EF0A04A0286_4EF0A00F0280_impl*
 Result := 80;
//#UC END# *4EF0A04A0286_4EF0A00F0280_impl*
end;//TK321983051.GetZoom

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK321983051.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4EF0A00F0280_var*
//#UC END# *51AF49E5001B_4EF0A00F0280_var*
begin
//#UC START# *51AF49E5001B_4EF0A00F0280_impl*
 Result := true;
//#UC END# *51AF49E5001B_4EF0A00F0280_impl*
end;//TK321983051.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK321983051.Suite);

end.