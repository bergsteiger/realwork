unit kwQueryCardSetCanSaveState;
 {* Устанавливает флаг того может ли карточка запроса писать своё состояние }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwQueryCardSetCanSaveState.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "QueryCard_SetCanSaveState" MUID: (4F69AF3E01C0)
// Имя типа: "TkwQueryCardSetCanSaveState"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwQueryCardFormWord
 {$If NOT Defined(Admin)}
 , PrimQueryCard_Form
 {$IfEnd} // NOT Defined(Admin)
 , tfwScriptingInterfaces
;

type
 TkwQueryCardSetCanSaveState = {final} class(TkwQueryCardFormWord)
  {* Устанавливает флаг того может ли карточка запроса писать своё состояние }
  protected
   procedure DoQueryCardForm(aForm: TPrimQueryCardForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwQueryCardSetCanSaveState
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
;

procedure TkwQueryCardSetCanSaveState.DoQueryCardForm(aForm: TPrimQueryCardForm;
 const aCtx: TtfwContext);
//#UC START# *4F69AE600137_4F69AF3E01C0_var*
//#UC END# *4F69AE600137_4F69AF3E01C0_var*
begin
//#UC START# *4F69AE600137_4F69AF3E01C0_impl*
 aForm.CanWriteMgrSettings := aCtx.rEngine.PopBool;
//#UC END# *4F69AE600137_4F69AF3E01C0_impl*
end;//TkwQueryCardSetCanSaveState.DoQueryCardForm

class function TkwQueryCardSetCanSaveState.GetWordNameForRegister: AnsiString;
begin
 Result := 'QueryCard:SetCanSaveState';
end;//TkwQueryCardSetCanSaveState.GetWordNameForRegister

initialization
 TkwQueryCardSetCanSaveState.RegisterInEngine;
 {* Регистрация QueryCard_SetCanSaveState }
{$IfEnd} // NOT Defined(NoScripts)

end.
