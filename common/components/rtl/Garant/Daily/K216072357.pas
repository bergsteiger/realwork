unit K216072357;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K216072357.pas"
// Начат: 25.05.2010 18:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K216072357
//
// {RequestLink:216072357}
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
  ScrollBackTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK216072357 = class(TScrollBackTest)
  {* [RequestLink:216072357] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function TreatExceptionAsSuccess: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK216072357
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

// start class TK216072357

{$If defined(nsTest) AND not defined(NoVCM)}
function TK216072357.TreatExceptionAsSuccess: Boolean;
//#UC START# *4BFD1B5A0200_4BFBDF0E01A4_var*
//#UC END# *4BFD1B5A0200_4BFBDF0E01A4_var*
begin
//#UC START# *4BFD1B5A0200_4BFBDF0E01A4_impl*
 Result := false{true};
//#UC END# *4BFD1B5A0200_4BFBDF0E01A4_impl*
end;//TK216072357.TreatExceptionAsSuccess
{$IfEnd} //nsTest AND not NoVCM

function TK216072357.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK216072357.GetFolder

function TK216072357.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BFBDF0E01A4';
end;//TK216072357.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK216072357.Suite);

end.