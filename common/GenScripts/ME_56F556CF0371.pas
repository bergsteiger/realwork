unit tfwDebugScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDebugScriptCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwDebugScriptCaller" MUID: (56F556CF0371)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDefaultScriptCaller
 , l3Interfaces
;

type
 TtfwDebugScriptCaller = class(TtfwDefaultScriptCaller)
  public
   procedure DoPrint(const aStr: Tl3WString); override;
 end;//TtfwDebugScriptCaller
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwDebugService
 , tfwScriptingInterfaces
 , l3String
;

procedure TtfwDebugScriptCaller.DoPrint(const aStr: Tl3WString);
//#UC START# *55C491FC025C_56F556CF0371_var*
var
 l_Caller : ItfwScriptCaller;
//#UC END# *55C491FC025C_56F556CF0371_var*
begin
//#UC START# *55C491FC025C_56F556CF0371_impl*
 l_Caller := TtfwDebugService.Instance.DebugScriptCaller;
 if (l_Caller <> nil) then
  l_Caller.Print(aStr);
//#UC END# *55C491FC025C_56F556CF0371_impl*
end;//TtfwDebugScriptCaller.DoPrint
{$IfEnd} // NOT Defined(NoScripts)

end.
