unit tfwScriptingExceptions;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingExceptions.pas"
// Стереотип: "InternalInterfaces"
// Элемент модели: "tfwScriptingExceptions" MUID: (55BB9712001F)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SysUtils
;

type
 EtfwException = class(Exception)
 end;//EtfwException

 EtfwCheckPrim = class(EtfwException)
  public
   class procedure IsTrue(aCondition: Boolean;
    const aMessage: AnsiString);
   class procedure Fail(const aMessage: AnsiString);
 end;//EtfwCheckPrim

 EtfwCheck = class(EtfwCheckPrim)
 end;//EtfwCheck
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class procedure EtfwCheckPrim.IsTrue(aCondition: Boolean;
 const aMessage: AnsiString);
//#UC START# *54F8741B021E_54F873F5009A_var*
//#UC END# *54F8741B021E_54F873F5009A_var*
begin
//#UC START# *54F8741B021E_54F873F5009A_impl*
 if not aCondition then
  raise Self.Create(aMessage);
//#UC END# *54F8741B021E_54F873F5009A_impl*
end;//EtfwCheckPrim.IsTrue

class procedure EtfwCheckPrim.Fail(const aMessage: AnsiString);
//#UC START# *550C432A0223_54F873F5009A_var*
//#UC END# *550C432A0223_54F873F5009A_var*
begin
//#UC START# *550C432A0223_54F873F5009A_impl*
 IsTrue(false, aMessage);
//#UC END# *550C432A0223_54F873F5009A_impl*
end;//EtfwCheckPrim.Fail
{$IfEnd} // NOT Defined(NoScripts)

end.
