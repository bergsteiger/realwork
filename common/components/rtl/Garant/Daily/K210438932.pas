unit K210438932;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K210438932.pas"
// Начат: 13.05.2010 16:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K210438932
//
// {RequestLink:210438932}
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
 TK210438932 = class(TScrollTest)
  {* [RequestLink:210438932] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function ScrollByPage: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK210438932
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

// start class TK210438932

{$If defined(nsTest) AND not defined(NoVCM)}
function TK210438932.ScrollByPage: Boolean;
//#UC START# *4BEBFE020080_4BEBF26700DA_var*
//#UC END# *4BEBFE020080_4BEBF26700DA_var*
begin
//#UC START# *4BEBFE020080_4BEBF26700DA_impl*
 Result := false;
//#UC END# *4BEBFE020080_4BEBF26700DA_impl*
end;//TK210438932.ScrollByPage
{$IfEnd} //nsTest AND not NoVCM

function TK210438932.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK210438932.GetFolder

function TK210438932.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BEBF26700DA';
end;//TK210438932.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK210438932.Suite);

end.