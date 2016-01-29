unit vcmAeroForm;

{ Класс формы с поддержкой оформления Aero }

{ Библиотека "vcm"        }
{ Автор: Морозов В.Л.     }
{ Модуль: vcmAeroForm   - }
{ Начат: 07.03.2014 09:05 }

interface
uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Forms,
  Controls,
  UxTheme;

type
 TElementMargins = UxTheme.TMargins;

 TvcmAeroForm = class;

 TvcmGlassFrame = class(TPersistent)
 private
  f_Client: TvcmAeroForm;
  f_Enabled: Boolean;
  f_Left: Integer;
  f_Top: Integer;
  f_Right: Integer;
  f_Bottom: Integer;
  f_OnChange: TNotifyEvent;
  f_SheetOfGlass: Boolean;
  procedure pm_SetEnabled(aValue: Boolean);
  procedure pm_SetSheetOfGlass(aValue: Boolean);
  procedure pm_SetLeft(aValue: Integer);
  procedure pm_SetTop(aValue: Integer);
  procedure pm_SetRight(aValue: Integer);
  procedure pm_SetBottom(aValue: Integer);
  function pm_GetExtraRect: TRect;
  function pm_GetBoundsRect: TRect;
  procedure pm_SetBoundsRect(const aValue: TRect);
 protected
  procedure Change; virtual;
 public
  constructor Create(aClient: TvcmAeroForm);
  destructor Destroy; override;
  procedure Assign(Source: TPersistent); override;
  function FrameExtended: Boolean;
  function IntersectsControl(aControl: TControl): Boolean;
  property OnChange: TNotifyEvent read f_OnChange write f_OnChange;
 published
  property Enabled: Boolean read f_Enabled write pm_SetEnabled default False;
  property Left: Integer read f_Left write pm_SetLeft default 0;
  property Top: Integer read f_Top write pm_SetTop default 0;
  property Right: Integer read f_Right write pm_SetRight default 0;
  property Bottom: Integer read f_Bottom write pm_SetBottom default 0;
  property ExtraRect: TRect read pm_GetExtraRect;
  property SheetOfGlass: Boolean read f_SheetOfGlass write pm_SetSheetOfGlass default False;
  property BoundsRect: TRect read pm_GetBoundsRect write pm_SetBoundsRect;
 end;

 TvcmAeroForm = class(TForm)
 private
  f_GlassFrame: TvcmGlassFrame;
  f_GlassFramePainting: Boolean;
 protected
  procedure pm_SetGlassFrame(const aValue: TvcmGlassFrame);
  procedure UpdateGlassFrame(aSender: TObject);
  procedure UpdateGlassFrameControls(const aRect: TRect);
  procedure AlignControls(Control: TControl; var Rect: TRect); override;
  property GlassFramePainting: Boolean
   read f_GlassFramePainting
   write f_GlassFramePainting;
 public
  constructor Create(aOwner: TComponent); override;
  destructor Destroy; override;
  property GlassFrame: TvcmGlassFrame
   read f_GlassFrame
   write pm_SetGlassFrame;
 end;

implementation
uses
 Types,
 l3DwmApi;

{ TvcmGlassFrame }

constructor TvcmGlassFrame.Create(aClient: TvcmAeroForm);
begin
 inherited Create;
 f_Client := aClient;
 f_Left := 0;
 f_Top := 0;
 f_Right := 0;
 f_Bottom := 0;
 f_SheetOfGlass := False;
end;//Create

procedure TvcmGlassFrame.Assign(Source: TPersistent);
var
 l_Source: TvcmGlassFrame;
begin
 if Source is TvcmGlassFrame then
 begin
  l_Source := TvcmGlassFrame(Source);
  f_Enabled := l_Source.Enabled;
  f_Left := l_Source.Left;
  f_Top := l_Source.Top;
  f_Right := l_Source.Right;
  f_Bottom := l_Source.Bottom;
  f_SheetOfGlass := l_Source.SheetOfGlass;
  Change;
 end
 else
  inherited Assign(Source);
end;//Assign

procedure TvcmGlassFrame.Change;
var
 l_RectToUpdate: TRect;
begin
 if not (csLoading in f_Client.ComponentState) then
 begin
  if Assigned(f_OnChange) then
   f_OnChange(Self);
  l_RectToUpdate := Rect(Left, Top, f_Client.ClientWidth - Right,
   f_Client.ClientHeight - Bottom);
  f_Client.UpdateGlassFrameControls(l_RectToUpdate);
 end;//if not csLoading...
end;//Change

function TvcmGlassFrame.FrameExtended: Boolean;
begin
 Result := (f_Enabled and DwmCompositionEnabled and
  (f_SheetOfGlass or (Left <> 0) or (Top <> 0) or (Right <> 0) or (Bottom <> 0)));
end;//FrameExtended

function TvcmGlassFrame.IntersectsControl(aControl: TControl): Boolean;
var
 l_ControlRect: TRect;
 l_NonGlassRect: TRect;
begin
 Result := False;
 if (f_Enabled and DwmCompositionEnabled) then
 begin
  Result := f_SheetOfGlass;
  if (not Result) then
  begin
   l_ControlRect := aControl.ClientRect;
   l_ControlRect.TopLeft := aControl.ClientToParent(l_ControlRect.TopLeft,
    f_Client);
   l_ControlRect.BottomRight := aControl.ClientToParent(l_ControlRect.BottomRight,
    f_Client);
   l_NonGlassRect := f_Client.ClientRect;
   l_NonGlassRect := Rect(f_Left, f_Top, l_NonGlassRect.Right - f_Right,
   l_NonGlassRect.Bottom - f_Bottom);
   Result := not (PtInRect(l_NonGlassRect, l_ControlRect.TopLeft)) and
    (PtInRect(l_NonGlassRect, l_ControlRect.BottomRight));
  end;//if not Result
 end;//if (f_Enabled and DwmCompositionEnabled)
end;//IntersectsControl

procedure TvcmGlassFrame.pm_SetEnabled(aValue: Boolean);
begin
 if (aValue <> f_Enabled) then
 begin
  f_Enabled := aValue;
  if (f_Enabled and f_Client.TransparentColor) then
   f_Client.TransparentColor := False;
  Change;
 end;//if (aValue <> f_Enabled)
end;//SetEnabled

procedure TvcmGlassFrame.pm_SetSheetOfGlass(aValue: Boolean);
begin
 if (aValue <> f_SheetOfGlass) and not
  (f_SheetOfGlass and ((f_Left = -1) or (f_Top = -1) or (f_Right = -1) or (f_Bottom = -1))) then
 begin
  f_SheetOfGlass := aValue;
  Change;
 end;
end;//SetSheetOfGlass

procedure TvcmGlassFrame.pm_SetBottom(aValue: Integer);
begin
 if (aValue <> f_Bottom) then
 begin
  f_Bottom := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Change;
 end;//if (aValue <> f_Bottom)
end;//pm_SetBottom

procedure TvcmGlassFrame.pm_SetLeft(aValue: Integer);
begin
 if (aValue <> f_Left) then
 begin
  f_Left := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Change;
 end;//if (aValue <> f_Left)
end;//pm_SetLeft

procedure TvcmGlassFrame.pm_SetRight(aValue: Integer);
begin
 if (aValue <> f_Right) then
 begin
  f_Right := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Change;
 end;//if (aValue <> f_Right)
end;//pm_SetRight

procedure TvcmGlassFrame.pm_SetTop(aValue: Integer);
begin
 if (aValue <> f_Top) then
 begin
  f_Top := aValue;
  if (aValue = -1) then
   f_SheetOfGlass := True;
  Change;
 end;//if (aValue <> f_Top)
end;//pm_SetTop


function TvcmGlassFrame.pm_GetExtraRect: TRect;
begin
  Result := f_Client.ClientRect;
  Result.Bottom := Result.Top + Top;
end;

function TvcmGlassFrame.pm_GetBoundsRect: TRect;
begin
 Result.Top := Top;
 Result.Left := Left;
 Result.Right := Right;
 Result.Bottom := Bottom;
end;

procedure TvcmGlassFrame.pm_SetBoundsRect(const aValue: TRect);
begin
 Left := aValue.Left;
 Top := aValue.Top;
 Right := aValue.Top;
 Bottom := aValue.Bottom;
end;

destructor TvcmGlassFrame.Destroy;
begin
  inherited;
end;

{ TvcmAeroForm }

procedure TvcmAeroForm.AlignControls(Control: TControl;
  var Rect: TRect);
var
 l_RectToUpdate: TRect;
begin
 inherited;
 if (GlassFramePainting and not (csLoading in ComponentState)) then
 begin
  l_RectToUpdate := Types.Rect(f_GlassFrame.Left, f_GlassFrame.Top,
   ClientWidth - f_GlassFrame.Right, ClientHeight - f_GlassFrame.Bottom);
  UpdateGlassFrameControls(l_RectToUpdate);
 end;//if (GlassFramePainting...
end;//AlignControls

constructor TvcmAeroForm.Create(aOwner: TComponent);
begin
 inherited;
 f_GlassFrame := TvcmGlassFrame.Create(Self);
 f_GlassFrame.OnChange := UpdateGlassFrame;
 f_GlassFrame.OnNeedUpdateGlassFrameControls := UpdateGlassFrameControls;
end;//Create

destructor TvcmAeroForm.Destroy;
begin
 FreeAndNil(f_GlassFrame);
 inherited;
end;//Destroy

procedure TvcmAeroForm.pm_SetGlassFrame(const aValue: TvcmGlassFrame);
begin
 f_GlassFrame.Assign(aValue);
end;//pm_SetGlassFrame

procedure TvcmAeroForm.UpdateGlassFrame(aSender: TObject);
const
 cSheetOfGlassMarginsSize = -1;
 cSheetOfGlassMargins: TElementMargins = (cxLeftWidth: -1; cxRightWidth: -1; cyTopHeight: -1; cyBottomHeight: -1);

 procedure lp_AdjustMargins(var aMargins: TElementMargins);
 begin
  if (not f_GlassFrame.SheetOfGlass) then
  begin
   aMargins.cxLeftWidth := f_GlassFrame.Left;
   aMargins.cxRightWidth := f_GlassFrame.Right;
   aMargins.cyTopHeight := f_GlassFrame.Top;
   aMargins.cyBottomHeight := f_GlassFrame.Bottom;
  end
  else
   aMargins := cSheetOfGlassMargins;
 end;//lp_AdjustMargins;

var
 l_Margins: TElementMargins;
begin
 if DwmCompositionEnabled and HandleAllocated then
 begin
  lp_AdjustMargins(l_Margins);
  if not (csDesigning in ComponentState) then
   GlassFramePainting := True
  else
  begin
   GlassFramePainting := False;
   FillChar(l_Margins, SizeOf(l_Margins), 0);
  end;//if Enabled
  if (csDesigning in ComponentState) then
   InvalidateRect(Handle, nil, True)
  else
  begin
   DwmExtendFrameIntoClientArea(Handle, l_Margins);
   Invalidate;
  end;
 end
 else
 begin
  GlassFramePainting := False;
  if (csDesigning in ComponentState) then
   InvalidateRect(Handle, nil, True)
 end;//if DwmCompositionEnabled and HandleAllocated
end;//UpdateGlassFrame

function ContainsRect(const anOuterRect: TRect; const anInnerRect: TRect): Boolean;
begin
 with anInnerRect do
  Result := (Left >= anOuterRect.Left) and (Right <= anOuterRect.Right) and
   (Top >= anOuterRect.Top) and (Bottom <= anOuterRect.Bottom);
end;//ContainsRect

procedure TvcmAeroForm.UpdateGlassFrameControls(const aRect: TRect);

 procedure lp_DoUpdateControls(aControl: TWinControl);
 var
  l_Index: Integer;
  l_Rect: TRect;
  l_Control: TControl;
 begin
  for l_Index := 0 to aControl.ControlCount - 1 do
  begin
   l_Control := aControl.Controls[l_Index];
   if (not f_GlassFrame.SheetOfGlass) then
   begin
    l_Rect := l_Control.ClientRect;
    l_Rect.TopLeft := l_Control.ClientToParent(l_Rect.TopLeft, Self);
    l_Rect.BottomRight := l_Control.ClientToParent(l_Rect.BottomRight, Self);
   end;//if (not f_GlassFrame.SheetOfGlass)
   if (f_GlassFrame.SheetOfGlass) or (not ContainsRect(aRect, l_Rect)) then
   begin
    if (not GlassFramePainting) then
     GlassFramePainting := True;
   end
   else
   if GlassFramePainting then
    GlassFramePainting := False;
   if l_Control is TWinControl then
    lp_DoUpdateControls(TWinControl(l_Control));
  end;//for l_Index := 0
 end;//lp_DoUpdateControls

begin
 if ((not (csDesigning in ComponentState)) and DwmCompositionEnabled) then
  lp_DoUpdateControls(Self);
end;//UpdateGlassFrameControls
                       
end.
