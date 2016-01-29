unit K327822716;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K327822716.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::ScriptTest::K327822716
//
// {Requestlink:327822716}
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
  AutoTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK327822716 = class(TAutoTest)
  {* [Requestlink:327822716] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK327822716
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK327822716

function TK327822716.GetFolder: AnsiString;
 {-}
begin
 Result := 'ScriptTest';
end;//TK327822716.GetFolder

function TK327822716.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4F1D275301BE';
end;//TK327822716.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK327822716.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4F1D275301BE_var*
//#UC END# *51AF49E5001B_4F1D275301BE_var*
begin
//#UC START# *51AF49E5001B_4F1D275301BE_impl*
 Result := true;
//#UC END# *51AF49E5001B_4F1D275301BE_impl*
end;//TK327822716.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK327822716.Suite);

end.