unit K249336513;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K249336513.pas"
// Начат: 11.01.2011 14:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K249336513
//
// {RequestLink:249336513}
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
 TK249336513 = class(TScrollTest)
  {* [RequestLink:249336513] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK249336513
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

// start class TK249336513

{$If defined(nsTest) AND not defined(NoVCM)}
function TK249336513.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4D2C43E601FC_var*
//#UC END# *4C08CF4300BE_4D2C43E601FC_var*
begin
//#UC START# *4C08CF4300BE_4D2C43E601FC_impl*
 Result := false;
//#UC END# *4C08CF4300BE_4D2C43E601FC_impl*
end;//TK249336513.WebStyle
{$IfEnd} //nsTest AND not NoVCM

function TK249336513.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK249336513.GetFolder

function TK249336513.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D2C43E601FC';
end;//TK249336513.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK249336513.Suite);

end.