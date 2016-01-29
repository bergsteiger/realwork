unit vcmChromeLikeTabbedContainerForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmChromeLikeTabbedContainerForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::TvcmChromeLikeTabbedContainerForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Messages
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  vcmChromeLikeTabbedContainerFormPrim,
  FormFrameDecorator,
  Types,
  Classes,
  Graphics
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Windows,
  ChromeLikeInterfaces,
  ChromeLikeTabSetControlPrim,
  ChromeLikeTabSetControl,
  l3TabbedContainersDispatcher
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 _ChromeLikeTabbedContainerForm_Parent_ = TvcmChromeLikeTabbedContainerFormPrim;
 {$Include w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabbedContainerForm.imp.pas}
 TvcmChromeLikeTabbedContainerForm = {abstract} class(_ChromeLikeTabbedContainerForm_)
 private
 // private fields
   f_Decorator : TFormFrameDecorator;
    {* Поле для свойства Decorator}
 private
 // private methods
   procedure DoOnNeedRecreateButtons(aDecorator: TFormFrameDecorator);
   procedure WMSysCommand(var aMessage: TWMSysCommand); message WM_SYSCOMMAND;
 protected
 // property methods
   function pm_GetDecorator: TFormFrameDecorator; virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   procedure MakeControls; override;
 protected
 // protected methods
   procedure RecreateButtons; virtual;
   function GetClientControl: TWinControl; virtual;
 protected
 // protected properties
   property Decorator: TFormFrameDecorator
     read pm_GetDecorator;
 end;//TvcmChromeLikeTabbedContainerForm
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  SysUtils,
  ChromeLikeTabSetRes,
  vcmEntityForm,
  ChromeLikeFormFramePainter,
  ChromeLikeBaseWindowCaptionButton
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  ChromeLikeTabSetTypes,
  afwFacade
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

{$Include w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabbedContainerForm.imp.pas}

// start class TvcmChromeLikeTabbedContainerForm

procedure TvcmChromeLikeTabbedContainerForm.DoOnNeedRecreateButtons(aDecorator: TFormFrameDecorator);
//#UC START# *54B4B9E2025C_533A9B6A00D9_var*
//#UC END# *54B4B9E2025C_533A9B6A00D9_var*
begin
//#UC START# *54B4B9E2025C_533A9B6A00D9_impl*
 RecreateButtons;
//#UC END# *54B4B9E2025C_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.DoOnNeedRecreateButtons

procedure TvcmChromeLikeTabbedContainerForm.RecreateButtons;
//#UC START# *54B4B92D0212_533A9B6A00D9_var*
var
 l_CloseButton: TChromeLikeBaseWindowCaptionButton;
 l_MaxButton: TChromeLikeBaseWindowCaptionButton;
 l_MinButton: TChromeLikeBaseWindowCaptionButton;
//#UC END# *54B4B92D0212_533A9B6A00D9_var*
begin
//#UC START# *54B4B92D0212_533A9B6A00D9_impl*
 l_CloseButton := f_Decorator.CloseButtonClass.Create(Self);
 l_CloseButton.Parent := f_Decorator;
 l_CloseButton.ShowHint := True;
 f_Decorator.CloseButton := l_CloseButton;

 l_MaxButton := f_Decorator.MaxButtonClass.Create(Self);
 l_MaxButton.Parent := f_Decorator;
 l_MaxButton.ShowHint := True;
 f_Decorator.MaxButton := l_MaxButton;

 l_MinButton := f_Decorator.MinButtonClass.Create(Self);
 l_MinButton.Parent := f_Decorator;
 l_MinButton.ShowHint := True;
 f_Decorator.MinButton := l_MinButton;
//#UC END# *54B4B92D0212_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.RecreateButtons

function TvcmChromeLikeTabbedContainerForm.GetClientControl: TWinControl;
//#UC START# *54B4B94903C5_533A9B6A00D9_var*
//#UC END# *54B4B94903C5_533A9B6A00D9_var*
begin
//#UC START# *54B4B94903C5_533A9B6A00D9_impl*
 Assert(False);
//#UC END# *54B4B94903C5_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.GetClientControl

function TvcmChromeLikeTabbedContainerForm.pm_GetDecorator: TFormFrameDecorator;
//#UC START# *54B4B8D50155_533A9B6A00D9get_var*
//#UC END# *54B4B8D50155_533A9B6A00D9get_var*
begin
//#UC START# *54B4B8D50155_533A9B6A00D9get_impl*
 Result := f_Decorator;
//#UC END# *54B4B8D50155_533A9B6A00D9get_impl*
end;//TvcmChromeLikeTabbedContainerForm.pm_GetDecorator

procedure TvcmChromeLikeTabbedContainerForm.WMSysCommand(var aMessage: TWMSysCommand);
//#UC START# *54B4B8FF023D_533A9B6A00D9_var*
//#UC END# *54B4B8FF023D_533A9B6A00D9_var*
begin
//#UC START# *54B4B8FF023D_533A9B6A00D9_impl*
 if not (csDesigning in ComponentState) then
 begin
  with aMessage do begin
   if (CmdType and $FFF0 = SC_MINIMIZE) AND (Application.MainForm = Self) then
    DefaultHandler(aMessage)
   else
    inherited;
  end;//with Message
 end
 else
  inherited;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565841068
//#UC END# *54B4B8FF023D_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.WMSysCommand

procedure TvcmChromeLikeTabbedContainerForm.Cleanup;
//#UC START# *479731C50290_533A9B6A00D9_var*
//#UC END# *479731C50290_533A9B6A00D9_var*
begin
//#UC START# *479731C50290_533A9B6A00D9_impl*
 inherited;
 FreeAndNil(f_Decorator);
//#UC END# *479731C50290_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.Cleanup

procedure TvcmChromeLikeTabbedContainerForm.InitFields;
//#UC START# *47A042E100E2_533A9B6A00D9_var*
//#UC END# *47A042E100E2_533A9B6A00D9_var*
begin
//#UC START# *47A042E100E2_533A9B6A00D9_impl*
 inherited;
//#UC END# *47A042E100E2_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.InitFields

procedure TvcmChromeLikeTabbedContainerForm.InitControls;
//#UC START# *4A8E8F2E0195_533A9B6A00D9_var*
//#UC END# *4A8E8F2E0195_533A9B6A00D9_var*
begin
//#UC START# *4A8E8F2E0195_533A9B6A00D9_impl*
 inherited;
 f_Decorator.Parent := Self;
 f_Decorator.OnNeedRecreateButtons := DoOnNeedRecreateButtons;
 RecreateButtons;
 MakeTabSet;
 f_Decorator.ClientControl := GetClientControl;
//#UC END# *4A8E8F2E0195_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.InitControls

procedure TvcmChromeLikeTabbedContainerForm.MakeControls;
//#UC START# *500004A60200_533A9B6A00D9_var*
//#UC END# *500004A60200_533A9B6A00D9_var*
begin
//#UC START# *500004A60200_533A9B6A00D9_impl*
 inherited;
 f_Decorator := TFormFrameDecorator.Create(Self);
//#UC END# *500004A60200_533A9B6A00D9_impl*
end;//TvcmChromeLikeTabbedContainerForm.MakeControls

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TvcmChromeLikeTabbedContainerForm
 TtfwClassRef.Register(TvcmChromeLikeTabbedContainerForm);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene

end.