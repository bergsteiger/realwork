unit vcmMessageFormPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageFormPrim.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvcmMessageFormPrim" MUID: (4F91452D0004)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vcmEntityForm
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , vg_scene
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvcmMessageFormPrim = class(TvcmEntityForm)
  private
   f_Scene: TvgScene;
  protected
   f_HasButtons: Boolean;
   f_CancelButton: TMsgDlgBtn;
   f_DefaultButton: TMsgDlgBtn;
  private
   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  public
   function NeedSaveInSettings: Boolean; override;
  protected
   property Scene: TvgScene
    read f_Scene
    write f_Scene;
 end;//TvcmMessageFormPrim
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vgVisualObject
 , Windows
 , vg_controls
 , vtDialogsResEx
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TCustomCheckBoxHack = class({$If NOT Defined(NoVCL)}
 TCustomCheckBox
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//TCustomCheckBoxHack

 TvgVisualObjectHack = class(TvgVisualObject)
 end;//TvgVisualObjectHack

procedure TvcmMessageFormPrim.CMDialogKey(var Message: TCMDialogKey);
//#UC START# *4F9145B5023E_4F91452D0004_var*
var
  l_checkbox: TWinControl;
//#UC END# *4F9145B5023E_4F91452D0004_var*
begin
//#UC START# *4F9145B5023E_4F91452D0004_impl*
 if (Message.CharCode = VK_ESCAPE) AND NOT f_HasButtons then
 begin
  ModalResult := vtGetDlgBtnResult(f_CancelButton);
  Message.Result := 1;
  Exit;
 end;

 if (Message.CharCode = VK_RETURN) then
 begin
  if (f_Scene <> nil) then
  begin
   if (f_Scene.Focused Is TvgButton) then
   begin
    TvgVisualObjectHack(f_Scene.Focused As TvgVisualObject).Click;
    Message.Result := 1;
    Exit;
   end;

   if (f_Scene.Focused Is TvgCheckBox) then
   begin
    (f_Scene.Focused As TvgCheckBox).ToggleChecked;
    Message.Result := 1;
    Exit;
   end;
  end;//(f_Scene <> nil)

  l_checkbox := FindControl(GetFocus);
  if (l_checkbox <> nil) AND (l_checkbox Is TCheckBox) then
  begin
   TCustomCheckBoxHack(l_checkbox).Toggle;
   Message.Result := 1;
   Exit;
  end;
 end;// (Message.CharCode = VK_RETURN)

 inherited;
//#UC END# *4F9145B5023E_4F91452D0004_impl*
end;//TvcmMessageFormPrim.CMDialogKey

function TvcmMessageFormPrim.NeedSaveInSettings: Boolean;
//#UC START# *4FC38C4C0119_4F91452D0004_var*
//#UC END# *4FC38C4C0119_4F91452D0004_var*
begin
//#UC START# *4FC38C4C0119_4F91452D0004_impl*
 Result := False;
//#UC END# *4FC38C4C0119_4F91452D0004_impl*
end;//TvcmMessageFormPrim.NeedSaveInSettings

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmMessageFormPrim);
 {* Регистрация TvcmMessageFormPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)

end.
