unit vcmGlassFrame;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmGlassFrame.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::TvcmGlassFrame
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
  Types,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  vcmEntityForm
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TvcmGlassFrameNeedUpdateGlassFrameControls = procedure (const aRect: TRect) of object;

 TvcmGlassFrame = class
 private
 // private fields
   f_Left : Integer;
    {* Поле для свойства Left}
   f_Top : Integer;
    {* Поле для свойства Top}
   f_Right : Integer;
    {* Поле для свойства Right}
   f_Bottom : Integer;
    {* Поле для свойства Bottom}
   f_Enabled : Boolean;
    {* Поле для свойства Enabled}
   f_SheetOfGlass : Boolean;
    {* Поле для свойства SheetOfGlass}
   f_OnChange : TNotifyEvent;
    {* Поле для свойства OnChange}
   f_OnNeedUpdateGlassFrameControls : TvcmGlassFrameNeedUpdateGlassFrameControls;
    {* Поле для свойства OnNeedUpdateGlassFrameControls}
   f_ClientForm : TvcmEntityForm;
    {* Поле для свойства ClientForm}
 protected
 // property methods
   procedure pm_SetLeft(aValue: Integer); virtual;
   procedure pm_SetTop(aValue: Integer); virtual;
   procedure pm_SetRight(aValue: Integer); virtual;
   procedure pm_SetBottom(aValue: Integer); virtual;
   procedure pm_SetEnabled(aValue: Boolean); virtual;
   procedure pm_SetSheetOfGlass(aValue: Boolean); virtual;
   function pm_GetExtraRect: TRect; virtual;
   function pm_GetBoundsRect: TRect; virtual;
   procedure pm_SetBoundsRect(const aValue: TRect); virtual;
 public
 // public methods
   function FrameExtended: Boolean;
   function IntersectsControl(aControl: TControl): Boolean;
   constructor Create(aForm: TvcmEntityForm); reintroduce;
   procedure Assign(aSource: TvcmGlassFrame);
   procedure Changed;
 public
 // public properties
   property Left: Integer
     read f_Left
     write pm_SetLeft;
   property Top: Integer
     read f_Top
     write pm_SetTop;
   property Right: Integer
     read f_Right
     write pm_SetRight;
   property Bottom: Integer
     read f_Bottom
     write pm_SetBottom;
   property Enabled: Boolean
     read f_Enabled
     write pm_SetEnabled;
   property SheetOfGlass: Boolean
     read f_SheetOfGlass
     write pm_SetSheetOfGlass;
   property ExtraRect: TRect
     read pm_GetExtraRect;
   property BoundsRect: TRect
     read pm_GetBoundsRect
     write pm_SetBoundsRect;
   property OnChange: TNotifyEvent
     read f_OnChange
     write f_OnChange;
   property OnNeedUpdateGlassFrameControls: TvcmGlassFrameNeedUpdateGlassFrameControls
     read f_OnNeedUpdateGlassFrameControls
     write f_OnNeedUpdateGlassFrameControls;
   property ClientForm: TvcmEntityForm
     read f_ClientForm;
 end;//TvcmGlassFrame
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3DwmApi
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TvcmGlassFrame

function TvcmGlassFrame.FrameExtended: Boolean;
//#UC START# *533924CE0094_533921E6004B_var*
//#UC END# *533924CE0094_533921E6004B_var*
begin
//#UC START# *533924CE0094_533921E6004B_impl*
 Result := (f_Enabled and DwmCompositionEnabled and
  (f_SheetOfGlass or (Left <> 0) or (Top <> 0) or (Right <> 0) or (Bottom <> 0)));
//#UC END# *533924CE0094_533921E6004B_impl*
end;//TvcmGlassFrame.FrameExtended

function TvcmGlassFrame.IntersectsControl(aControl: TControl): Boolean;
//#UC START# *533924F50094_533921E6004B_var*
var
 l_ControlRect: TRect;
 l_NonGlassRect: TRect;
//#UC END# *533924F50094_533921E6004B_var*
begin
//#UC START# *533924F50094_533921E6004B_impl*
 Result := False;
 if (f_Enabled and DwmCompositionEnabled) then
 begin
  Result := f_SheetOfGlass;
  if (not Result) then
  begin
   l_ControlRect := aControl.ClientRect;
   l_ControlRect.TopLeft := aControl.ClientToParent(l_ControlRect.TopLeft,
    f_ClientForm);
   l_ControlRect.BottomRight := aControl.ClientToParent(l_ControlRect.BottomRight,
    f_ClientForm);
   l_NonGlassRect := f_ClientForm.ClientRect;
   l_NonGlassRect := Rect(f_Left, f_Top, l_NonGlassRect.Right - f_Right,
   l_NonGlassRect.Bottom - f_Bottom);
   Result := not (PtInRect(l_NonGlassRect, l_ControlRect.TopLeft)) and
    (PtInRect(l_NonGlassRect, l_ControlRect.BottomRight));
  end;//if not Result
 end;//if (f_Enabled and DwmCompositionEnabled)
//#UC END# *533924F50094_533921E6004B_impl*
end;//TvcmGlassFrame.IntersectsControl

constructor TvcmGlassFrame.Create(aForm: TvcmEntityForm);
//#UC START# *53392681029D_533921E6004B_var*
//#UC END# *53392681029D_533921E6004B_var*
begin
//#UC START# *53392681029D_533921E6004B_impl*
 inherited Create;
 f_ClientForm := aForm;
 f_Left := 0;
 f_Top := 0;
 f_Right := 0;
 f_Bottom := 0;
 f_SheetOfGlass := False;
//#UC END# *53392681029D_533921E6004B_impl*
end;//TvcmGlassFrame.Create

procedure TvcmGlassFrame.Assign(aSource: TvcmGlassFrame);
//#UC START# *5339262F006E_533921E6004B_var*
//#UC END# *5339262F006E_533921E6004B_var*
begin
//#UC START# *5339262F006E_533921E6004B_impl*
 Assert(aSource <> nil);
 f_Enabled := aSource.Enabled;
 f_Left := aSource.Left;
 f_Top := aSource.Top;
 f_Right := aSource.Right;
 f_Bottom := aSource.Bottom;
 f_SheetOfGlass := aSource.SheetOfGlass;
 Changed;
//#UC END# *5339262F006E_533921E6004B_impl*
end;//TvcmGlassFrame.Assign

procedure TvcmGlassFrame.Changed;
//#UC START# *533949B70034_533921E6004B_var*
var
 l_RectToUpdate: TRect;
//#UC END# *533949B70034_533921E6004B_var*
begin
//#UC START# *533949B70034_533921E6004B_impl*
 if not (csLoading in f_ClientForm.ComponentState) then
 begin
  if Assigned(f_OnChange) then
   f_OnChange(Self);
  l_RectToUpdate := Rect(Left, Top, f_ClientForm.ClientWidth - Right,
   f_ClientForm.ClientHeight - Bottom);
  if Assigned(Self.f_OnNeedUpdateGlassFrameControls) then
   f_OnNeedUpdateGlassFrameControls(l_RectToUpdate);
 end;//if not csLoading...
//#UC END# *533949B70034_533921E6004B_impl*
end;//TvcmGlassFrame.Changed

procedure TvcmGlassFrame.pm_SetLeft(aValue: Integer);
//#UC START# *5339228C03CE_533921E6004Bset_var*
//#UC END# *5339228C03CE_533921E6004Bset_var*
begin
//#UC START# *5339228C03CE_533921E6004Bset_impl*
 if (aValue <> f_Left) then
 begin
  f_Left := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Changed;
 end;//if (aValue <> f_Left)
//#UC END# *5339228C03CE_533921E6004Bset_impl*
end;//TvcmGlassFrame.pm_SetLeft

procedure TvcmGlassFrame.pm_SetTop(aValue: Integer);
//#UC START# *533922DE0125_533921E6004Bset_var*
//#UC END# *533922DE0125_533921E6004Bset_var*
begin
//#UC START# *533922DE0125_533921E6004Bset_impl*
 if (aValue <> f_Top) then
 begin
  f_Top := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Changed;
 end;//if (aValue <> f_Top)
//#UC END# *533922DE0125_533921E6004Bset_impl*
end;//TvcmGlassFrame.pm_SetTop

procedure TvcmGlassFrame.pm_SetRight(aValue: Integer);
//#UC START# *533922EC00ED_533921E6004Bset_var*
//#UC END# *533922EC00ED_533921E6004Bset_var*
begin
//#UC START# *533922EC00ED_533921E6004Bset_impl*
 if (aValue <> f_Right) then
 begin
  f_Right := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Changed;
 end;//if (aValue <> f_Right)
//#UC END# *533922EC00ED_533921E6004Bset_impl*
end;//TvcmGlassFrame.pm_SetRight

procedure TvcmGlassFrame.pm_SetBottom(aValue: Integer);
//#UC START# *533922F9032E_533921E6004Bset_var*
//#UC END# *533922F9032E_533921E6004Bset_var*
begin
//#UC START# *533922F9032E_533921E6004Bset_impl*
 if (aValue <> f_Bottom) then
 begin
  f_Bottom := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Changed;
 end;//if (aValue <> f_Bottom)
//#UC END# *533922F9032E_533921E6004Bset_impl*
end;//TvcmGlassFrame.pm_SetBottom

procedure TvcmGlassFrame.pm_SetEnabled(aValue: Boolean);
//#UC START# *53392364001E_533921E6004Bset_var*
//#UC END# *53392364001E_533921E6004Bset_var*
begin
//#UC START# *53392364001E_533921E6004Bset_impl*
 if (aValue <> f_Enabled) then
 begin
  f_Enabled := aValue;
  if (f_Enabled and f_ClientForm.TransparentColor) then
   f_ClientForm.TransparentColor := False;
  Changed;
 end;//if (aValue <> f_Enabled)
//#UC END# *53392364001E_533921E6004Bset_impl*
end;//TvcmGlassFrame.pm_SetEnabled

procedure TvcmGlassFrame.pm_SetSheetOfGlass(aValue: Boolean);
//#UC START# *5339239E01DD_533921E6004Bset_var*
//#UC END# *5339239E01DD_533921E6004Bset_var*
begin
//#UC START# *5339239E01DD_533921E6004Bset_impl*
 if (aValue <> f_SheetOfGlass) and not
  (f_SheetOfGlass and ((f_Left = -1) or (f_Top = -1) or (f_Right = -1) or (f_Bottom = -1))) then
 begin
  f_SheetOfGlass := aValue;
  Changed;
 end;
//#UC END# *5339239E01DD_533921E6004Bset_impl*
end;//TvcmGlassFrame.pm_SetSheetOfGlass

function TvcmGlassFrame.pm_GetExtraRect: TRect;
//#UC START# *533923CF00FD_533921E6004Bget_var*
//#UC END# *533923CF00FD_533921E6004Bget_var*
begin
//#UC START# *533923CF00FD_533921E6004Bget_impl*
 Result := f_ClientForm.ClientRect;
 Result.Bottom := Result.Top + Top;
//#UC END# *533923CF00FD_533921E6004Bget_impl*
end;//TvcmGlassFrame.pm_GetExtraRect

function TvcmGlassFrame.pm_GetBoundsRect: TRect;
//#UC START# *533923E10265_533921E6004Bget_var*
//#UC END# *533923E10265_533921E6004Bget_var*
begin
//#UC START# *533923E10265_533921E6004Bget_impl*
 Result.Top := Top;
 Result.Left := Left;
 Result.Right := Right;
 Result.Bottom := Bottom;
//#UC END# *533923E10265_533921E6004Bget_impl*
end;//TvcmGlassFrame.pm_GetBoundsRect

procedure TvcmGlassFrame.pm_SetBoundsRect(const aValue: TRect);
//#UC START# *533923E10265_533921E6004Bset_var*
//#UC END# *533923E10265_533921E6004Bset_var*
begin
//#UC START# *533923E10265_533921E6004Bset_impl*
 Left := aValue.Left;
 Top := aValue.Top;
 Right := aValue.Top;
 Bottom := aValue.Bottom;
//#UC END# *533923E10265_533921E6004Bset_impl*
end;//TvcmGlassFrame.pm_SetBoundsRect

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.