unit K255956509;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K255956509.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K255956509
//
// [$255956509]
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
  ScrollParamsTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK255956509 = class(TScrollParamsTest)
  {* [$255956509] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetSubNumber: Integer; override;
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK255956509
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

// start class TK255956509

function TK255956509.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK255956509.GetFolder

function TK255956509.GetSubNumber: Integer;
//#UC START# *4D7211F7018C_4D720C39027F_var*
//#UC END# *4D7211F7018C_4D720C39027F_var*
begin
//#UC START# *4D7211F7018C_4D720C39027F_impl*
 Result := 20021;
//#UC END# *4D7211F7018C_4D720C39027F_impl*
end;//TK255956509.GetSubNumber

function TK255956509.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D720C39027F';
end;//TK255956509.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK255956509.Suite);

end.