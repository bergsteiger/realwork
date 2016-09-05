unit kwComponentFromStackWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwComponentFromStackWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwComponentFromStackWord" MUID: (4F2148300318)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwObjectFromStackWord
 , Classes
 , tfwScriptingInterfaces
;

type
 _SystemWord_Parent_ = TkwObjectFromStackWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SystemWord.imp.pas}
 TkwComponentFromStackWord = {abstract} class(_SystemWord_)
  protected
   procedure DoComponent(aComponent: TComponent;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoObject(anObject: TObject;
    const aCtx: TtfwContext); override;
 end;//TkwComponentFromStackWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4F2148300318impl_uses*
 //#UC END# *4F2148300318impl_uses*
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\SystemWord.imp.pas}

procedure TkwComponentFromStackWord.DoObject(anObject: TObject;
 const aCtx: TtfwContext);
//#UC START# *4F212BD5010E_4F2148300318_var*
//#UC END# *4F212BD5010E_4F2148300318_var*
begin
//#UC START# *4F212BD5010E_4F2148300318_impl*
 DoComponent(anObject As TComponent, aCtx);
//#UC END# *4F212BD5010E_4F2148300318_impl*
end;//TkwComponentFromStackWord.DoObject

initialization
 TkwComponentFromStackWord.RegisterClass;
 {* Регистрация TkwComponentFromStackWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
