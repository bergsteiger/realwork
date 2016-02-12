unit kwSendInputSupport;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupport.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , Windows
 , tfwScriptingInterfaces
;

type
 _kwSendInputSupportUses_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupportUses.imp.pas}
 TkwSendInputSupport = {abstract} class(_kwSendInputSupportUses_)
  protected
   function GetInputStruct(const aCtx: TtfwContext): TInput; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwSendInputSupport
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupportUses.imp.pas}

procedure TkwSendInputSupport.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F71A8080094_var*
var
 l_Input: TInput;
//#UC END# *4DAEEDE10285_4F71A8080094_var*
begin
//#UC START# *4DAEEDE10285_4F71A8080094_impl*
 l_Input := GetInputStruct(aCtx);
 SendInput(1, l_Input, SizeOf(TInput));
//#UC END# *4DAEEDE10285_4F71A8080094_impl*
end;//TkwSendInputSupport.DoDoIt

initialization
 TkwSendInputSupport.RegisterClass;
 {* Регистрация TkwSendInputSupport }
{$IfEnd} // NOT Defined(NoScripts)

end.
