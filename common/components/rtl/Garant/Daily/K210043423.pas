unit K210043423;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K210043423.pas"
// Начат: 03.06.2010 15:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K210043423
//
// {RequestLink:210043423}
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
 TK210043423 = class(TScrollBackTest)
  {* [RequestLink:210043423] }
 protected
 // overridden protected methods
   function GetEnabled: Boolean; override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK210043423
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

// start class TK210043423

function TK210043423.GetEnabled: Boolean;
//#UC START# *4C07996901BE_4C0795E9018D_var*
//#UC END# *4C07996901BE_4C0795E9018D_var*
begin
//#UC START# *4C07996901BE_4C0795E9018D_impl*
 Result := inherited GetEnabled{false};
 // http://mdp.garant.ru/pages/viewpage.action?pageId=217679801
 // - обратно включил Люлин А.В. т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=217679801&focusedCommentId=217681122#comment-217681122
//#UC END# *4C07996901BE_4C0795E9018D_impl*
end;//TK210043423.GetEnabled

function TK210043423.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK210043423.GetFolder

function TK210043423.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C0795E9018D';
end;//TK210043423.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK210043423.Suite);

end.