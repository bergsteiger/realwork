unit K228688660;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K228688660.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K228688660
//
// [$228688660]
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
  ScrollTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK228688660 = class(TScrollTest)
  {* [$228688660] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function ScrollByPage: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK228688660
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

// start class TK228688660

{$If defined(nsTest) AND not defined(NoVCM)}
function TK228688660.ScrollByPage: Boolean;
//#UC START# *4BEBFE020080_4C5FEA950080_var*
//#UC END# *4BEBFE020080_4C5FEA950080_var*
begin
//#UC START# *4BEBFE020080_4C5FEA950080_impl*
 Result := False;
//#UC END# *4BEBFE020080_4C5FEA950080_impl*
end;//TK228688660.ScrollByPage
{$IfEnd} //nsTest AND not NoVCM

function TK228688660.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK228688660.GetFolder

function TK228688660.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C5FEA950080';
end;//TK228688660.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK228688660.Suite);

end.