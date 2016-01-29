unit K519483189;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K519483189.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.10::K519483189
//
// {Requestlink:519483189}
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
  EVDtoRTFRender
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK519483189 = class(TEVDtoRTFRender)
  {* [Requestlink:519483189] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function NeedEliminateCommentDecorations: Boolean; override;
 end;//TK519483189
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK519483189

function TK519483189.GetFolder: AnsiString;
 {-}
begin
 Result := '7.10';
end;//TK519483189.GetFolder

function TK519483189.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5314649702DB';
end;//TK519483189.GetModelElementGUID

function TK519483189.NeedEliminateCommentDecorations: Boolean;
//#UC START# *530C91FB00BD_5314649702DB_var*
//#UC END# *530C91FB00BD_5314649702DB_var*
begin
//#UC START# *530C91FB00BD_5314649702DB_impl*
 Result := True;
//#UC END# *530C91FB00BD_5314649702DB_impl*
end;//TK519483189.NeedEliminateCommentDecorations

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK519483189.Suite);

end.