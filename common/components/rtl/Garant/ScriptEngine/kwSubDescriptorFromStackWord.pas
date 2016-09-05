unit kwSubDescriptorFromStackWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubDescriptorFromStackWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwSubDescriptorFromStackWord" MUID: (52D65E6902A8)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwObjectFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubDescriptorFromStackWord = {abstract} class(TkwObjectFromStackWord)
  protected
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoObject(anObject: TObject;
    const aCtx: TtfwContext); override;
 end;//TkwSubDescriptorFromStackWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52D65E6902A8impl_uses*
 //#UC END# *52D65E6902A8impl_uses*
;

procedure TkwSubDescriptorFromStackWord.DoObject(anObject: TObject;
 const aCtx: TtfwContext);
//#UC START# *4F212BD5010E_52D65E6902A8_var*
//#UC END# *4F212BD5010E_52D65E6902A8_var*
begin
//#UC START# *4F212BD5010E_52D65E6902A8_impl*
 DoWithSubDescriptor(anObject as TevSubDescriptor, aCtx);
//#UC END# *4F212BD5010E_52D65E6902A8_impl*
end;//TkwSubDescriptorFromStackWord.DoObject

initialization
 TkwSubDescriptorFromStackWord.RegisterClass;
 {* Регистрация TkwSubDescriptorFromStackWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
