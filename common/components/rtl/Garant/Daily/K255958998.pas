unit K255958998;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K255958998.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K255958998
//
// [$255958998]
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
  ComplexScrollParams
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK255958998 = class(TComplexScrollParams)
  {* [$255958998] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetSubNumber(aFirst: Boolean): Integer; override;
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK255958998
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

// start class TK255958998

function TK255958998.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK255958998.GetFolder

function TK255958998.GetSubNumber(aFirst: Boolean): Integer;
//#UC START# *4D7779F503A4_4D7776F00162_var*
//#UC END# *4D7779F503A4_4D7776F00162_var*
begin
//#UC START# *4D7779F503A4_4D7776F00162_impl*
 if aFirst then
  Result := 20021
 else
  Result := 10002
//#UC END# *4D7779F503A4_4D7776F00162_impl*
end;//TK255958998.GetSubNumber

function TK255958998.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D7776F00162';
end;//TK255958998.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK255958998.Suite);

end.