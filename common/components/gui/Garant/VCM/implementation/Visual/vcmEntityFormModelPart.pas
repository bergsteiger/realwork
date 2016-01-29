unit vcmEntityFormModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmEntityFormModelPart.pas"
// Начат: 27.01.2012 20:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VCM$Visual::Visual::TvcmEntityFormModelPart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  Messages,
  vcmForm,
  vcmControllers,
  Controls {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _vcmLayout_Parent_ = TvcmForm;
 {$Include ..\Visual\vcmLayout.imp.pas}
 TvcmEntityFormModelPart = class(_vcmLayout_)
 private
 // private fields
   f_ZoneType : TvcmZoneType;
    {* Поле для свойства ZoneType}
 private
 // private methods
   procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
   procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
 protected
 // property methods
   procedure pm_SetZoneType(aValue: TvcmZoneType);
   function pm_GetCaptionForSaving: AnsiString;
 protected
 // overridden protected methods
   procedure ClearModal; override;
     {* Сигнатура метода ClearModal }
 protected
 // protected methods
   procedure FormInsertedIntoContainer; virtual;
   procedure FocusIsSetToUs; virtual;
   procedure BecomeVisible; virtual;
   procedure BecomeInvisible; virtual;
     {* Сигнатура метода BecomeInvisible }
   function DoGetCaptionForSaving: AnsiString; virtual;
 public
 // public methods
   function CanHaveCloseButtonInNavigator: Boolean; virtual;
   function CanHaveOwnCloseButtonInNavigator: Boolean; virtual;
   function IsBaloon: Boolean; virtual;
   function IsMainObjectForm: Boolean;
   function NeedSetMyFocus: Boolean; virtual;
 public
 // public properties
   property ZoneType: TvcmZoneType
     read f_ZoneType
     write pm_SetZoneType;
   property CaptionForSaving: AnsiString
     read pm_GetCaptionForSaving;
 end;//TvcmEntityFormModelPart
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmMainForm,
  afwFacade
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  VCMFormsProcessingPack
  {$IfEnd} //not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = TvcmEntityFormModelPart;

{$Include ..\Visual\vcmLayout.imp.pas}

// start class TvcmEntityFormModelPart

function TvcmEntityFormModelPart.CanHaveCloseButtonInNavigator: Boolean;
//#UC START# *4F619BCE008A_4F22CB1E0009_var*
//#UC END# *4F619BCE008A_4F22CB1E0009_var*
begin
//#UC START# *4F619BCE008A_4F22CB1E0009_impl*
 Result := true;
//#UC END# *4F619BCE008A_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.CanHaveCloseButtonInNavigator

function TvcmEntityFormModelPart.CanHaveOwnCloseButtonInNavigator: Boolean;
//#UC START# *4F6A0EE50047_4F22CB1E0009_var*
//#UC END# *4F6A0EE50047_4F22CB1E0009_var*
begin
//#UC START# *4F6A0EE50047_4F22CB1E0009_impl*
 Result := true;
//#UC END# *4F6A0EE50047_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.CanHaveOwnCloseButtonInNavigator

function TvcmEntityFormModelPart.IsBaloon: Boolean;
//#UC START# *4F748C5A00CB_4F22CB1E0009_var*
//#UC END# *4F748C5A00CB_4F22CB1E0009_var*
begin
//#UC START# *4F748C5A00CB_4F22CB1E0009_impl*
 Result := false;
//#UC END# *4F748C5A00CB_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.IsBaloon

procedure TvcmEntityFormModelPart.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4F22CB1E0009_var*
//#UC END# *4F7C65380244_4F22CB1E0009_var*
begin
//#UC START# *4F7C65380244_4F22CB1E0009_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7C65380244_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.FormInsertedIntoContainer

procedure TvcmEntityFormModelPart.FocusIsSetToUs;
//#UC START# *4F7C6D6801F4_4F22CB1E0009_var*
//#UC END# *4F7C6D6801F4_4F22CB1E0009_var*
begin
//#UC START# *4F7C6D6801F4_4F22CB1E0009_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7C6D6801F4_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.FocusIsSetToUs

procedure TvcmEntityFormModelPart.BecomeVisible;
//#UC START# *4F7C808A0349_4F22CB1E0009_var*
//#UC END# *4F7C808A0349_4F22CB1E0009_var*
begin
//#UC START# *4F7C808A0349_4F22CB1E0009_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7C808A0349_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.BecomeVisible

function TvcmEntityFormModelPart.IsMainObjectForm: Boolean;
//#UC START# *501FF183014D_4F22CB1E0009_var*
var
 l_Form   : TvcmEntityFormModelPart;
 l_Parent : TafwCustomForm;
//#UC END# *501FF183014D_4F22CB1E0009_var*
begin
//#UC START# *501FF183014D_4F22CB1E0009_impl*
 Result := false;
 l_Form := Self;
 while true do
 begin
  if l_Form.GetIsMainObjectForm then
  begin
   l_Parent := afw.GetAnotherParentForm(l_Form);
   if l_Parent Is TvcmMainForm then
   begin
    Result := true;
    break;
   end//l_Parent Is TvcmMainForm
   else
   if (l_Parent Is TvcmEntityFormModelPart) then
    l_Form := TvcmEntityFormModelPart(l_Parent)
   else
    break;
  end//l_Form.GetIsMainObjectForm
  else
   break;
 end;//while true
//#UC END# *501FF183014D_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.IsMainObjectForm

procedure TvcmEntityFormModelPart.BecomeInvisible;
//#UC START# *537C9007038A_4F22CB1E0009_var*
//#UC END# *537C9007038A_4F22CB1E0009_var*
begin
//#UC START# *537C9007038A_4F22CB1E0009_impl*
 // - ничего не делаем, пусть потомки разбираются 
//#UC END# *537C9007038A_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.BecomeInvisible

function TvcmEntityFormModelPart.DoGetCaptionForSaving: AnsiString;
//#UC START# *540953180034_4F22CB1E0009_var*
//#UC END# *540953180034_4F22CB1E0009_var*
begin
//#UC START# *540953180034_4F22CB1E0009_impl*
 Result := Caption;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564737453
//#UC END# *540953180034_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.DoGetCaptionForSaving

procedure TvcmEntityFormModelPart.pm_SetZoneType(aValue: TvcmZoneType);
//#UC START# *501FEC050356_4F22CB1E0009set_var*
//#UC END# *501FEC050356_4F22CB1E0009set_var*
begin
//#UC START# *501FEC050356_4F22CB1E0009set_impl*
 if (f_ZoneType <> aValue) then
 begin
  f_ZoneType := aValue;
  if (f_ZoneType in [vcm_ztModal, vcm_ztManualModal]) then
   RecreateWnd;
 end;//f_ZoneType <> aValue
//#UC END# *501FEC050356_4F22CB1E0009set_impl*
end;//TvcmEntityFormModelPart.pm_SetZoneType

function TvcmEntityFormModelPart.pm_GetCaptionForSaving: AnsiString;
//#UC START# *5409573A01C3_4F22CB1E0009get_var*
//#UC END# *5409573A01C3_4F22CB1E0009get_var*
begin
//#UC START# *5409573A01C3_4F22CB1E0009get_impl*
 Result := DoGetCaptionForSaving;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564737453
//#UC END# *5409573A01C3_4F22CB1E0009get_impl*
end;//TvcmEntityFormModelPart.pm_GetCaptionForSaving

procedure TvcmEntityFormModelPart.WMSetFocus(var Message: TMessage);
//#UC START# *4F7C6D3A0359_4F22CB1E0009_var*
//#UC END# *4F7C6D3A0359_4F22CB1E0009_var*
begin
//#UC START# *4F7C6D3A0359_4F22CB1E0009_impl*
 inherited;
 FocusIsSetToUs;
//#UC END# *4F7C6D3A0359_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.WMSetFocus

procedure TvcmEntityFormModelPart.CMVisibleChanged(var Message: TMessage);
//#UC START# *4F7C806E024A_4F22CB1E0009_var*
//#UC END# *4F7C806E024A_4F22CB1E0009_var*
begin
//#UC START# *4F7C806E024A_4F22CB1E0009_impl*
 inherited;
 if Visible then
  BecomeVisible
 else
  BecomeInvisible;
//#UC END# *4F7C806E024A_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.CMVisibleChanged

function TvcmEntityFormModelPart.NeedSetMyFocus: Boolean;
//#UC START# *4B4F13E80365_4F22CB1E0009_var*
//#UC END# *4B4F13E80365_4F22CB1E0009_var*
begin
//#UC START# *4B4F13E80365_4F22CB1E0009_impl*
 Result := GetIsMainObjectForm;
//#UC END# *4B4F13E80365_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.NeedSetMyFocus

procedure TvcmEntityFormModelPart.ClearModal;
//#UC START# *501FEC7203A5_4F22CB1E0009_var*
//#UC END# *501FEC7203A5_4F22CB1E0009_var*
begin
//#UC START# *501FEC7203A5_4F22CB1E0009_impl*
 f_ZoneType := vcm_ztFloating;
 // - теперь типа просто плаваем
 inherited;
//#UC END# *501FEC7203A5_4F22CB1E0009_impl*
end;//TvcmEntityFormModelPart.ClearModal

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmEntityFormModelPart
 TtfwClassRef.Register(TvcmEntityFormModelPart);
{$IfEnd} //not NoScripts AND not NoVCM

end.