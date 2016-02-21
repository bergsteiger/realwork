unit tfwPropertyLike;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwPropertyLike.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwClassLike
;

type
 TtfwPropertyLike = {abstract} class(TtfwClassLike)
  protected
   function BindParams: Boolean; override;
   function StrictChecking: Boolean; override;
 end;//TtfwPropertyLike
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

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

initialization
 TtfwPropertyLike.RegisterClass;
 {* Регистрация TtfwPropertyLike }
{$IfEnd} // NOT Defined(NoScripts)

end.
