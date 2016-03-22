unit kwFormFromControlWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwFormFromControlWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwFormFromControlWord" MUID: (4EB25D530395)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwControlWord
 , Forms
 , tfwScriptingInterfaces
 , Controls
;

type
 TkwFormFromControlWord = {abstract} class(TkwControlWord)
  protected
   procedure DoForm(aForm: TForm;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
 end;//TkwFormFromControlWord
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , SysUtils
 , l3FormsService
 , Windows
;

procedure TkwFormFromControlWord.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4DB98B990054_4EB25D530395_var*
var
 l_F : TCustomForm;
//#UC END# *4DB98B990054_4EB25D530395_var*
begin
//#UC START# *4DB98B990054_4EB25D530395_impl*
 l_F := Tl3FormsService.Instance.GetParentForm(aControl);
 RunnerAssert(l_F <> nil, 'Не найдена родительская форма для ' + aControl.Name, aCtx);
 DoForm(TForm(l_F), aCtx);
//#UC END# *4DB98B990054_4EB25D530395_impl*
end;//TkwFormFromControlWord.DoControl

initialization
 TkwFormFromControlWord.RegisterClass;
 {* Регистрация TkwFormFromControlWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
