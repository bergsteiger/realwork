unit tfwConsoleScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwConsoleScriptCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwConsoleScriptCaller" MUID: (55C48FCE03AB)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDefaultScriptCaller
 , l3Interfaces
;

type
 TtfwConsoleScriptCaller = class(TtfwDefaultScriptCaller)
  protected
   class function DictPath: AnsiString; override;
  public
   procedure DoPrint(const aStr: Tl3WString); override;
 end;//TtfwConsoleScriptCaller
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , SysUtils
 //#UC START# *55C48FCE03ABimpl_uses*
 //#UC END# *55C48FCE03ABimpl_uses*
;

procedure TtfwConsoleScriptCaller.DoPrint(const aStr: Tl3WString);
//#UC START# *55C491FC025C_55C48FCE03AB_var*
//#UC END# *55C491FC025C_55C48FCE03AB_var*
begin
//#UC START# *55C491FC025C_55C48FCE03AB_impl*
 System.WriteLn(l3Str(aStr));
//#UC END# *55C491FC025C_55C48FCE03AB_impl*
end;//TtfwConsoleScriptCaller.DoPrint

class function TtfwConsoleScriptCaller.DictPath: AnsiString;
//#UC START# *55CC867301F7_55C48FCE03AB_var*
//#UC END# *55CC867301F7_55C48FCE03AB_var*
begin
//#UC START# *55CC867301F7_55C48FCE03AB_impl*
 Result := SysUtils.GetCurrentDir;
//#UC END# *55CC867301F7_55C48FCE03AB_impl*
end;//TtfwConsoleScriptCaller.DictPath
{$IfEnd} // NOT Defined(NoScripts)

end.
