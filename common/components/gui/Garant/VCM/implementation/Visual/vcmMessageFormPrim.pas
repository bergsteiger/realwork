unit vcmMessageFormPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMessageFormPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VCM$Visual::Visual::TvcmMessageFormPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  vcmEntityForm
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  vg_scene,
  vgVisualObject
  ;
{$IfEnd} //not NoVCM AND not NoVGScene

{$If not defined(NoVCM) AND not defined(NoVGScene)}
type
 TvcmMessageFormPrim = class(TvcmEntityForm)
 private
 // private fields
   f_Scene : TvgScene;
    {* Поле для свойства Scene}
 private
 // private methods
   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
 public
 // overridden public methods
   function NeedSaveInSettings: Boolean; override;
 protected
 // protected fields
   f_HasButtons : Boolean;
   f_CancelButton : TMsgDlgBtn;
   f_DefaultButton : TMsgDlgBtn;
 protected
 // protected properties
   property Scene: TvgScene
     read f_Scene
     write f_Scene;
 end;//TvcmMessageFormPrim
{$IfEnd} //not NoVCM AND not NoVGScene

implementation

{$If not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Windows,
  vg_controls,
  vtDialogsResEx
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM AND not NoVGScene

{$If not defined(NoVCM) AND not defined(NoVGScene)}

type
  TCustomCheckBoxHack = class(TCustomCheckBox)
  end;//TCustomCheckBoxHack

  TvgVisualObjectHack = class(TvgVisualObject)
  end;//TvgVisualObjectHack

// start class TvcmMessageFormPrim

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

{$IfEnd} //not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TvcmMessageFormPrim
 TtfwClassRef.Register(TvcmMessageFormPrim);
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

end.