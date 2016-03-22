unit tfwClipboardFormatWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwClipboardFormatWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwClipboardFormatWord" MUID: (5052EB370166)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , evTypes
 , tfwScriptingInterfaces
;

type
 TtfwClipboardFormatWord = {abstract} class(TtfwRegisterableWord)
  protected
   function GetFormat: TevFormat; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TtfwClipboardFormatWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TtfwClipboardFormatWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5052EB370166_var*
//#UC END# *4DAEEDE10285_5052EB370166_var*
begin
//#UC START# *4DAEEDE10285_5052EB370166_impl*
 aCtx.rEngine.PushInt(GetFormat);
//#UC END# *4DAEEDE10285_5052EB370166_impl*
end;//TtfwClipboardFormatWord.DoDoIt

initialization
 TtfwClipboardFormatWord.RegisterClass;
 {* Регистрация TtfwClipboardFormatWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
