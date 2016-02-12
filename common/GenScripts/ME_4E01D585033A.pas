unit vcmUserInteractiveForm;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3Forms
 , vcmGUI
 , vcmExternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , l3CloseFormHelper
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvcmCloseFormHelper = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3CloseFormHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   {$If NOT Defined(NoVCL)}
   function Close(aControl: TWinControl): Boolean;
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvcmCloseFormHelper;
    {* Метод получения экземпляра синглетона TvcmCloseFormHelper }
 end;//TvcmCloseFormHelper

 _vcmUserInteractiveForm_Parent_ = Tl3Form;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.imp.pas}
 TvcmUserInteractiveForm = class(_vcmUserInteractiveForm_)
 end;//TvcmUserInteractiveForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVGScene)}
 , vcmDialogs
 {$IfEnd} // NOT Defined(NoVGScene)
 , vcmMessagesSupport
 , vcmForm
 , SysUtils
 , l3Base
;

var g_TvcmCloseFormHelper: TvcmCloseFormHelper = nil;
 {* Экземпляр синглетона TvcmCloseFormHelper }

procedure TvcmCloseFormHelperFree;
 {* Метод освобождения экземпляра синглетона TvcmCloseFormHelper }
begin
 l3Free(g_TvcmCloseFormHelper);
end;//TvcmCloseFormHelperFree

class function TvcmCloseFormHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmCloseFormHelper <> nil;
end;//TvcmCloseFormHelper.Exists

{$If NOT Defined(NoVCL)}
function TvcmCloseFormHelper.Close(aControl: TWinControl): Boolean;
//#UC START# *A1E64DB467E3_55015117004B_var*
//#UC END# *A1E64DB467E3_55015117004B_var*
begin
//#UC START# *A1E64DB467E3_55015117004B_impl*
 if (aControl Is TvcmInterfacedForm) then
 begin
  TvcmInterfacedForm(aControl).SafeClose;
  Result := true;
 end//aControl Is TvcmInterfacedForm
 else
  Result := false;
//#UC END# *A1E64DB467E3_55015117004B_impl*
end;//TvcmCloseFormHelper.Close
{$IfEnd} // NOT Defined(NoVCL)

class function TvcmCloseFormHelper.Instance: TvcmCloseFormHelper;
 {* Метод получения экземпляра синглетона TvcmCloseFormHelper }
begin
 if (g_TvcmCloseFormHelper = nil) then
 begin
  l3System.AddExitProc(TvcmCloseFormHelperFree);
  g_TvcmCloseFormHelper := Create;
 end;
 Result := g_TvcmCloseFormHelper;
end;//TvcmCloseFormHelper.Instance

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.imp.pas}

initialization
{$If NOT Defined(NoVCL)}
 Tl3CloseFormHelper.Instance.Alien := TvcmCloseFormHelper.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* Регистрация TvcmCloseFormHelper }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmUserInteractiveForm);
 {* Регистрация TvcmUserInteractiveForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
