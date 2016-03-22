unit kwObjectFromStackWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwObjectFromStackWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwObjectFromStackWord" MUID: (4F212BA80137)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwObjectFromStackWord = {abstract} class(TtfwRegisterableWord)
  protected
   procedure DoObject(anObject: TObject;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwObjectFromStackWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwObjectFromStackWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F212BA80137_var*
//#UC END# *4DAEEDE10285_4F212BA80137_var*
begin
//#UC START# *4DAEEDE10285_4F212BA80137_impl*
 DoObject(aCtx.rEngine.PopObj, aCtx);
//#UC END# *4DAEEDE10285_4F212BA80137_impl*
end;//TkwObjectFromStackWord.DoDoIt

initialization
 TkwObjectFromStackWord.RegisterClass;
 {* Регистрация TkwObjectFromStackWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
