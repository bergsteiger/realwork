unit tfwGlobalKeyWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Core"
// Модуль: "tfwGlobalKeyWord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ClassLikeMapping::TtfwGlobalKeyWord
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwClassLike
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwGlobalKeyWord = {abstract} class(TtfwClassLike)
 protected
 // overridden protected methods
   function BindParams: Boolean; override;
   function StrictChecking: Boolean; override;
 end;//TtfwGlobalKeyWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TtfwGlobalKeyWord

function TtfwGlobalKeyWord.BindParams: Boolean;
//#UC START# *5617C8A30023_561BAC4B0005_var*
//#UC END# *5617C8A30023_561BAC4B0005_var*
begin
//#UC START# *5617C8A30023_561BAC4B0005_impl*
 Result := true;
 //Result := false;
//#UC END# *5617C8A30023_561BAC4B0005_impl*
end;//TtfwGlobalKeyWord.BindParams

function TtfwGlobalKeyWord.StrictChecking: Boolean;
//#UC START# *561916700342_561BAC4B0005_var*
//#UC END# *561916700342_561BAC4B0005_var*
begin
//#UC START# *561916700342_561BAC4B0005_impl*
 Result := false;
//#UC END# *561916700342_561BAC4B0005_impl*
end;//TtfwGlobalKeyWord.StrictChecking

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TtfwGlobalKeyWord
 TtfwGlobalKeyWord.RegisterClass;
{$IfEnd} //not NoScripts

end.