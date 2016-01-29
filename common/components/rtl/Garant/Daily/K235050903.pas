unit K235050903;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K235050903.pas"
// Начат: 16.09.2010 17:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K235050903
//
// {RequestLink:235050903}.
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
  EVDwithFormulasToRTFWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK235050903 = class(TEVDwithFormulasToRTFWriterTest)
  {* [RequestLink:235050903]. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK235050903
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK235050903

function TK235050903.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK235050903.GetFolder

function TK235050903.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C92210103D6';
end;//TK235050903.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK235050903.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C92210103D6_var*
//#UC END# *51AF49E5001B_4C92210103D6_var*
begin
//#UC START# *51AF49E5001B_4C92210103D6_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C92210103D6_impl*
end;//TK235050903.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK235050903.Suite);

end.