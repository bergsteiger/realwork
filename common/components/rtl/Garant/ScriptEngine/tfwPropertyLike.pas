unit tfwPropertyLike;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Core"
// Модуль: "tfwPropertyLike.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ClassLikeMapping::TtfwPropertyLike
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
 TtfwPropertyLike = {abstract} class(TtfwClassLike)
 protected
 // overridden protected methods
   function BindParams: Boolean; override;
   function StrictChecking: Boolean; override;
 end;//TtfwPropertyLike
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TtfwPropertyLike

function TtfwPropertyLike.BindParams: Boolean;
//#UC START# *5617C8A30023_5619169603BE_var*
//#UC END# *5617C8A30023_5619169603BE_var*
begin
//#UC START# *5617C8A30023_5619169603BE_impl*
 Result := true;
//#UC END# *5617C8A30023_5619169603BE_impl*
end;//TtfwPropertyLike.BindParams

function TtfwPropertyLike.StrictChecking: Boolean;
//#UC START# *561916700342_5619169603BE_var*
//#UC END# *561916700342_5619169603BE_var*
begin
//#UC START# *561916700342_5619169603BE_impl*
 Result := true;
//#UC END# *561916700342_5619169603BE_impl*
end;//TtfwPropertyLike.StrictChecking

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TtfwPropertyLike
 TtfwPropertyLike.RegisterClass;
{$IfEnd} //not NoScripts

end.