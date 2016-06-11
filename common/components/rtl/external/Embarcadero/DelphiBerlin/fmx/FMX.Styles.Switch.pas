{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Styles.Switch;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.UIConsts, FMX.Types, FMX.Controls, FMX.Objects, FMX.Graphics,
  FMX.Ani, FMX.Styles.Objects, FMX.Platform;

type
  TSwitchTextKind = (None, IO, IOandOnOff, Localized, Bitmap);

  TSwitchTextKindHelper = record helper for TSwitchTextKind
  const
    stkNone = TSwitchTextKind.None deprecated 'Use TSwitchTextKind.None';
    stkIO = TSwitchTextKind.IO deprecated 'Use TSwitchTextKind.IO';
    stkIOandOnOff = TSwitchTextKind.IOandOnOff deprecated 'Use TSwitchTextKind.IOandOnOff';
    stkLocalized = TSwitchTextKind.Localized deprecated 'Use TSwitchTextKind.Localized';
    stkBitmap = TSwitchTextKind.Bitmap deprecated 'Use TSwitchTextKind.Bitmap';
  end;

  TSwitchTextObject = class(TStyleTextObject)
  public type
    TStatesForLocale = record
      Locale: string;
      OnText: string;
      OffText: string;
    end;
  public const
    // do not localize
    DefaultTexts: TStatesForLocale = (Locale: ''; OnText: 'I'; OffText: 'O');
    LocalizedStates: array [0..6] of TStatesForLocale = (
      (Locale: 'en'; OnText: 'ON'; OffText: 'OFF'),
      (Locale: 'jp'; OnText: 'ON'; OffText: 'OFF'),
      (Locale: 'ja'; OnText: 'ON'; OffText: 'OFF'),
      (Locale: 'ko'; OnText: 'ON'; OffText: 'OFF'),
      (Locale: 'de'; OnText: 'AN'; OffText: 'AUS'),
      (Locale: 'fr'; OnText: 'OUI'; OffText: 'NON'),
      (Locale: 'zh'; OnText: #25171#24320; OffText: #20851#38381)
    );
  private
    FKind: TSwitchTextKind;
    FColorOn: TAlphaColor;
    FValue: Boolean;
    FCurrentLang: string;
    FSavedKind: TSwitchTextKind;
    function GetDefaultText(const Value: Boolean): string;
    function GetTextForLocale(const Locale: string; const Value: Boolean): string;
    function GetTextForKind(const Kind: TSwitchTextKind; const Value: Boolean): string;
    procedure SetColorOn(const Value: TAlphaColor);
    procedure SetValue(const Value: Boolean);
    procedure SetKind(const Value: TSwitchTextKind);
  protected
    function UpdateCurrentProperties: Boolean; override;
    function ConvertText(const Value: string): string; override;
    function SaveState: Boolean; override;
    function RestoreState: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Value: Boolean read FValue write SetValue;
  published
    property ColorOn: TAlphaColor read FColorOn write SetColorOn default claNull;
    property Kind: TSwitchTextKind read FKind write SetKind;
  end;

  TSwitchKind = (ClippingTracks, FadingTracks);

  TSwitchKindHelper = record helper for TSwitchKind
  const
    skClippingTracks = TSwitchKind.ClippingTracks deprecated 'Use TSwitchKind.ClippingTracks';
    skFadingTracks = TSwitchKind.FadingTracks deprecated 'Use TSwitchKind.FadingTracks';
  end;

  TCustomSwitchObject = class(TControl)
  public const
    SwitchAnimationDuration = 0.2;
    TrackingSensitivity = 3;
    TextClipOffset = 4;
  private
    [Weak] FControl: TControl;
    FThumbRect: TBounds;
    FPressed, FTracking, FAnimating: Boolean;
    FPressedThumbPos, FSavedPos: TPointF;
    FClickAnimation: TRectAnimation;
    FValue: Boolean;
    FOnChange: TNotifyEvent;
    FThumbLength: Single;
    FTrackingThumbScale: Single;
    FThumbPadding: TBounds;
    FTrackText: TSwitchTextObject;
    FThumbText: TSwitchTextObject;
    FKind: TSwitchKind;
    procedure DoAnimationEnd(Sender: TObject);
    procedure SetThumbRect(const Value: TBounds);
    procedure DoThumbRectChanged(Sender: TObject);
    procedure SetThumbLength(const Value: Single);
    procedure SetThumbPadding(const Value: TBounds);
    procedure SetTrackingThumbScale(const Value: Single);
    procedure PaintThumb;
    procedure PaintThumbText;
    procedure PaintTrack;
    procedure PaintTrackText;
    function IsTrackTextStored: Boolean;
    function IsThumbTextStored: Boolean;
    procedure PaintClippingTracks;
    procedure PaintFadingTracks;
  protected
    function GetObservers: TObservers; override;
    procedure AnimateTo(const Value: Boolean);
    function GetThumbValue: Single;
    function GetThumbCenter: Single;
    function GetThumbLength: Single;
    function GetThumbRect: TRectF;
    function GetValueByMousePos(const X, Y: Single): Boolean;
    function GetThumbRectByValue(const Value: Boolean): TRectF; virtual;
    procedure DoChange;
    function IsThumbTextVisible: Boolean; virtual;
    function IsTrackTextVisible: Boolean; virtual;
    procedure PaintThumbForValue(const R: TRectF; const Value: Boolean); virtual;
    procedure PaintThumbTextForValue(const R: TRectF; const Value: Boolean); virtual;
    procedure PaintTrackForValue(const R: TRectF; const Value: Boolean); virtual;
    procedure PaintTrackTextForValue(const R: TRectF; const Value: Boolean); virtual;
  protected
    procedure Paint; override;
    procedure DoExit; override;
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    property Pressed: Boolean read FPressed;
    property Tracking: Boolean read FTracking;
    property Animating: Boolean read FAnimating;
    procedure SetValue(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Control: TControl read FControl write FControl;
    property ThumbRect: TBounds read FThumbRect write SetThumbRect;
    property Value: Boolean read FValue write SetValue;
    /// <summary>Notification event called when switch change state</summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default False;
    property Kind: TSwitchKind read FKind write FKind default TSwitchKind.ClippingTracks;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TabOrder;
    property TouchTargetExpansion;
    property TrackText: TSwitchTextObject read FTrackText stored IsTrackTextStored;
    property TrackingThumbScale: Single read FTrackingThumbScale write SetTrackingThumbScale;
    property ThumbLength: Single read FThumbLength write SetThumbLength;
    property ThumbPadding: TBounds read FThumbPadding write SetThumbPadding;
    property ThumbText: TSwitchTextObject read FThumbText stored IsThumbTextStored;
    property Visible default True;
    property Width;
    property OnApplyStyleLookup;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

  TSwitchShape = (Rectangle, RoundRect, Oval);

  TSwitchShapeHelper = record helper for TSwitchShape
  const
    ssRectangle = TSwitchShape.Rectangle deprecated 'Use TSwitchShape.Rectangle';
    ssRoundRect = TSwitchShape.RoundRect deprecated 'Use TSwitchShape.RoundRect';
    ssOval = TSwitchShape.Oval deprecated 'Use TSwitchShape.Oval';
  end;

  TSwitchObject = class(TCustomSwitchObject)
  private
    FFill, FFillOn: TBrush;
    FStroke: TStrokeBrush;
    FShape: TSwitchShape;
    FThumb, FThumbOn: TBrush;
    FThumbStroke: TStrokeBrush;
    procedure SetFill(const Value: TBrush);
    procedure SetFillOn(const Value: TBrush);
    procedure SetStroke(const Value: TStrokeBrush);
    procedure SetShape(const Value: TSwitchShape);
    procedure SetThumb(const Value: TBrush);
    procedure SetThumbOn(const Value: TBrush);
    procedure SetThumbStroke(const Value: TStrokeBrush);
  protected
    procedure PaintThumbForValue(const R: TRectF; const Value: Boolean); override;
    procedure PaintTrackForValue(const R: TRectF; const Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Fill: TBrush read FFill write SetFill;
    property FillOn: TBrush read FFillOn write SetFillOn;
    property Stroke: TStrokeBrush read FStroke write SetStroke;
    property Thumb: TBrush read FThumb write SetThumb;
    property ThumbOn: TBrush read FThumbOn write SetThumbOn;
    property ThumbStroke: TStrokeBrush read FThumbStroke write SetThumbStroke;
    property Shape: TSwitchShape read FShape write SetShape default TSwitchShape.Rectangle;
  end;

  TBitmapSwitchObject = class(TCustomSwitchObject)
  public type
    TSwitchPart = (Track, TrackHot, TrackZoom, Thumb, ThumbPressed, ThumbHot, TextBitmap, TextBitmapEn, TextBitmapJp);
    TSwitchRec = record
      OnObject: TStyleObject;
      OffObject: TStyleObject;
    end;
  private
    FSourceLookup: string;
    FStyleObjects: array [TSwitchPart] of TSwitchRec;
    FLocaleService: IFMXLocaleService;
    function GetOnObject(Index: TSwitchPart): TBitmapLinks;
    procedure SetOnObject(Index: TSwitchPart; const Value: TBitmapLinks);
    function GetOffObject(Index: TSwitchPart): TBitmapLinks;
    procedure SetOffObject(Index: TSwitchPart; const Value: TBitmapLinks);
    function GetSourceLookup: string;
    procedure SetSourceLookup(const Value: string);
    procedure SetWrapMode(const Index: TSwitchPart; const Value: TImageWrapMode);
    function GetCapMode(const Index: TSwitchPart): TCapWrapMode;
    function GetWrapMode(const Index: TSwitchPart): TImageWrapMode;
    procedure SetCapMode(const Index: TSwitchPart; const Value: TCapWrapMode);
    procedure CopyCaps(const Index: TSwitchPart); overload;
    procedure CopyCaps(const Source, Dest: TSwitchPart); overload;
    procedure DefineLinkProperties(const SourceRects, CapInsets: string; const StyleObject: TStyleObject; Filer: TFiler);
  protected
    /// <summary>Return true if specified Part is exists in the style object.</summary>
    function PartExists(const Part: TSwitchPart; const State: Boolean): Boolean;
    function IsThumbTextVisible: Boolean; override;
    function IsTrackTextVisible: Boolean; override;
    procedure PaintThumbForValue(const R: TRectF; const Value: Boolean); override;
    procedure PaintThumbTextForValue(const R: TRectF; const Value: Boolean); override;
    procedure PaintTrackForValue(const R: TRectF; const Value: Boolean); override;
    procedure PaintTrackTextForValue(const R: TRectF; const Value: Boolean); override;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetNewScene(AScene: IScene); override;
  published
    property Track: TBitmapLinks index TSwitchPart.Track read GetOffObject write SetOffObject;
    property TrackZoom: TBitmapLinks index TSwitchPart.TrackZoom read GetOffObject write SetOffObject;
    property TrackOn: TBitmapLinks index TSwitchPart.Track read GetOnObject write SetOnObject;
    /// <summary>Hovered state of the switch track in on state</summary>
    property TrackHot: TBitmapLinks index TSwitchPart.TrackHot read GetOffObject write SetOffObject;
    /// <summary>Hovered state of the switch track in off state</summary>
    property TrackHotOn: TBitmapLinks index TSwitchPart.TrackHot read GetOnObject write SetOnObject;
    property TrackCapMode: TCapWrapMode index TSwitchPart.Track read GetCapMode write SetCapMode default TCapWrapMode.Stretch;
    property TrackWrapMode: TImageWrapMode index TSwitchPart.Track read GetWrapMode write SetWrapMode default TImageWrapMode.Stretch;
    property Thumb: TBitmapLinks index TSwitchPart.Thumb read GetOffObject write SetOffObject;
    property ThumbOn: TBitmapLinks index TSwitchPart.Thumb read GetOnObject write SetOnObject;
    /// <summary>Hovered state of switch thumb in off state</summary>
    property ThumbHot: TBitmapLinks index TSwitchPart.ThumbHot read GetOffObject write SetOffObject;
    /// <summary>Hovered state of switch thumb in on state</summary>
    property ThumbHotOn: TBitmapLinks index TSwitchPart.ThumbHot read GetOnObject write SetOnObject;
    property ThumbPressed: TBitmapLinks index TSwitchPart.ThumbPressed read GetOffObject write SetOffObject;
    property ThumbCapMode: TCapWrapMode index TSwitchPart.Thumb read GetCapMode write SetCapMode default TCapWrapMode.Stretch;
    property ThumbWrapMode: TImageWrapMode index TSwitchPart.Thumb read GetWrapMode write SetWrapMode default TImageWrapMode.Stretch;
    property TextBitmap: TBitmapLinks index TSwitchPart.TextBitmap read GetOffObject write SetOffObject;
    property TextBitmapOn: TBitmapLinks index TSwitchPart.TextBitmap read GetOnObject write SetOnObject;
    property TextBitmapEn: TBitmapLinks index TSwitchPart.TextBitmapEn read GetOffObject write SetOffObject;
    property TextBitmapEnOn: TBitmapLinks index TSwitchPart.TextBitmapEn read GetOnObject write SetOnObject;
    property TextBitmapJp: TBitmapLinks index TSwitchPart.TextBitmapJP read GetOffObject write SetOffObject;
    property TextBitmapJpOn: TBitmapLinks index TSwitchPart.TextBitmapJP read GetOnObject write SetOnObject;
    property SourceLookup: string read GetSourceLookup write SetSourceLookup;
  end;

implementation

uses
  System.SysUtils, System.TypInfo, System.Math;

{ TSwitchTextObject }

constructor TSwitchTextObject.Create(AOwner: TComponent);
var
  Loc: IFMXLocaleService;
begin
  inherited;
  TextSettings.WordWrap := False;
  ColorOn := claNull;
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, Loc) then
    FCurrentLang := Loc.GetCurrentLangID
  else
    FCurrentLang := '';
end;

function TSwitchTextObject.UpdateCurrentProperties: Boolean;
var
  LColor: TAlphaColorRec;
begin
  if Value and (ColorOn <> claNull) then
    LColor.Color := ColorOn
  else
    LColor.Color := TextSettings.FontColor;
  Result := SetCurrentProperties(LColor, Shadow);
end;

function TSwitchTextObject.ConvertText(const Value: string): string;
begin
  Result := GetTextForKind(Self.Kind, Self.Value);
end;

function TSwitchTextObject.GetDefaultText(const Value: Boolean): string;
begin
  if Value then
    Result := DefaultTexts.OnText
  else
    Result := DefaultTexts.OffText;
end;

function TSwitchTextObject.GetTextForKind(const Kind: TSwitchTextKind; const Value: Boolean): string;
begin
  case Kind of
    TSwitchTextKind.IO:
      Result := GetDefaultText(Value);
    TSwitchTextKind.IOandOnOff:
      begin
        if FCurrentLang = 'en' then
          Result := GetTextForLocale('en', Value)
        else
          Result := GetDefaultText(Value)
      end;
    TSwitchTextKind.Localized:
      Result := GetTextForLocale(FCurrentLang, Value);
  else
    Result := '';
  end;
end;

function TSwitchTextObject.GetTextForLocale(const Locale: string; const Value: Boolean): string;
var
  State: TStatesForLocale;
begin
  for State in LocalizedStates do
    if SameText(Locale, State.Locale) then
      if Value then
        Exit(State.OnText)
      else
        Exit(State.OffText);

  Result := GetDefaultText(Value);
end;

function TSwitchTextObject.SaveState: Boolean;
begin
  Result := inherited;
  if Result then
    FSavedKind := Kind;
end;

function TSwitchTextObject.RestoreState: Boolean;
begin
  Result := inherited;
  if Result then
    Kind := FSavedKind;
end;

procedure TSwitchTextObject.SetColorOn(const Value: TAlphaColor);
begin
  if FColorOn <> Value then
  begin
    FColorOn := Value;
    if UpdateCurrentProperties then
      Repaint;
  end;
end;

procedure TSwitchTextObject.SetKind(const Value: TSwitchTextKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    Text := GetTextForKind(FKind, FValue);
  end;
end;

procedure TSwitchTextObject.SetValue(const Value: Boolean);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Text := GetTextForKind(FKind, FValue);
  end;
end;

{ TCustomSwitchObject }

constructor TCustomSwitchObject.Create(AOwner: TComponent);
begin
  inherited;
  FKind := TSwitchKind.ClippingTracks;
  FTrackingThumbScale := 1.0;
  FThumbRect := TBounds.Create(NullRect);
  FThumbRect.OnChange := DoThumbRectChanged;
  FThumbPadding := TBounds.Create(NullRect);
  FTrackText := TSwitchTextObject.Create(nil);
  FTrackText.SetSubComponent(True);
  FThumbText := TSwitchTextObject.Create(nil);
  FThumbText.SetSubComponent(True);
  HitTest := False;
end;

destructor TCustomSwitchObject.Destroy;
begin
  FreeAndNil(FThumbText);
  FreeAndNil(FTrackText);
  FreeAndNil(FThumbPadding);
  FreeAndNil(FThumbRect);
  inherited;
end;

procedure TCustomSwitchObject.DoAnimationEnd(Sender: TObject);
begin
  FreeAndNil(FClickAnimation);
  FAnimating := False;
  Repaint;
end;

procedure TCustomSwitchObject.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
  Repaint;
end;

procedure TCustomSwitchObject.DoExit;
begin
  inherited;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    TLinkObservers.EditLinkUpdate(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(Observers);
end;

procedure TCustomSwitchObject.DoMouseEnter;
begin
  inherited;
  Repaint;
end;

procedure TCustomSwitchObject.DoMouseLeave;
begin
  inherited;
  Repaint;
end;

procedure TCustomSwitchObject.DoThumbRectChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TCustomSwitchObject.AnimateTo(const Value: Boolean);
var
  ElapsedDistance, AnimationDistance: Single;
begin
  FreeAndNil(FClickAnimation);
  if ([csLoading, csReading, csDestroying, csDesigning] * ComponentState <> []) or
     (Parent = nil) or
     (FDisablePaint) or
     (FUpdating > 0) or
     (not Visible) or
     (not ParentedVisible) then
  begin
    Repaint;
  end
  else
  begin
    FAnimating := True;
    FClickAnimation := TRectAnimation.Create(Self);
    FClickAnimation.Parent := Self;
    FClickAnimation.AnimationType := TAnimationType.In;
    FClickAnimation.Interpolation := TInterpolationType.Linear;
    FClickAnimation.PropertyName := 'ThumbRect';
    if FTracking then
      FClickAnimation.StartValue.Rect := ThumbRect.Rect
    else
      FClickAnimation.StartValue.Rect := GetThumbRectByValue(not Value);
    FClickAnimation.StopValue.Rect := GetThumbRectByValue(Value);

    AnimationDistance := Width - FClickAnimation.StopValue.Rect.Width;
    ElapsedDistance := Abs(FClickAnimation.StopValue.Rect.Left - FClickAnimation.StartValue.Rect.Left);

    if AnimationDistance > 0 then
      FClickAnimation.Duration := SwitchAnimationDuration * (ElapsedDistance / AnimationDistance)
    else
      FClickAnimation.Duration := SwitchAnimationDuration;

    FClickAnimation.OnFinish := DoAnimationEnd;
    FClickAnimation.Start;
  end;
end;

function TCustomSwitchObject.GetObservers: TObservers;
begin
  if Control <> nil then
    Result := Control.Observers
  else
    Result := inherited;
end;

function TCustomSwitchObject.GetThumbCenter: Single;
var
  R: TRectF;
begin
  R := GetThumbRect;
  Result := (R.Left + R.Right) / 2;
end;

function TCustomSwitchObject.GetThumbLength: Single;
var
  R: TRectF;
begin
  if SameValue(FThumbLength, 0.0, Epsilon) then
  begin
    R := FThumbPadding.PaddingRect(LocalRect);
    Result := R.Height;
  end else
    Result := FThumbLength;

  if (FPressed or FTracking or FAnimating) and not SameValue(TrackingThumbScale, 1) then
    Result := Round(Result * TrackingThumbScale);
end;

function TCustomSwitchObject.GetThumbRect: TRectF;
begin
  Result := FThumbPadding.PaddingRect(LocalRect);
  if FTracking or FAnimating then
    Result := TRectF.Create(FThumbRect.Rect.Round)
  else
    Result := GetThumbRectByValue(Value);
end;

function TCustomSwitchObject.GetThumbRectByValue(const Value: Boolean): TRectF;
begin
  Result := FThumbPadding.PaddingRect(LocalRect);
  if not Value then
    Result.Right := Result.Left + GetThumbLength
  else
    Result.Left := Result.Right - GetThumbLength;
end;

function TCustomSwitchObject.GetThumbValue: Single;
var
  R: TRectF;
begin
  if FTracking or FAnimating then
  begin
    R := GetThumbRect;
    Result := R.Left / (Width - R.Width);
  end else
  if Value then
    Result := 1.0
  else
    Result := 0.0;
end;

function TCustomSwitchObject.GetValueByMousePos(const X, Y: Single): Boolean;
var
  HalfThumbWidth: Single;
begin
  if not ThumbRect.Empty then
    HalfThumbWidth := ThumbRect.Width / 2
  else
    HalfThumbWidth := 0;

  if (X - FPressedThumbPos.X) + HalfThumbWidth < Width / 2 then
    Result := False
  else
    Result := True;
end;

function TCustomSwitchObject.IsThumbTextStored: Boolean;
begin
  Result := ThumbText.Kind <> TSwitchTextKind.None;
end;

function TCustomSwitchObject.IsThumbTextVisible: Boolean;
begin
  Result := ThumbText.Kind <> TSwitchTextKind.None;
end;

function TCustomSwitchObject.IsTrackTextStored: Boolean;
begin
  Result := TrackText.Kind <> TSwitchTextKind.None;
end;

function TCustomSwitchObject.IsTrackTextVisible: Boolean;
begin
  Result := TrackText.Kind <> TSwitchTextKind.None;
end;

procedure TCustomSwitchObject.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
  if (Button = TMouseButton.mbLeft) then
  begin
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      if TLinkObservers.EditLinkIsReadOnly(Observers) then
        Exit;
    FPressed := True;
    FThumbRect.Rect := GetThumbRectByValue(Value);
    FSavedPos := TPointF.Create(X, Y);
    FPressedThumbPos := FSavedPos - FThumbRect.Rect.TopLeft;
    Repaint;
  end;
end;

procedure TCustomSwitchObject.MouseMove(Shift: TShiftState; X, Y: Single);
var
  NewThumbRect: TRectF;
begin
  inherited;
  if FPressed then
  begin
    if (ssTouch in Shift) and (Abs(X - FSavedPos.X) < TrackingSensitivity) then Exit;

    FTracking := True;

    NewThumbRect := FThumbRect.Rect;
    NewThumbRect.Offset(X - FSavedPos.X, 0);

    if NewThumbRect.Left < 0 then
      NewThumbRect.Offset(-NewThumbRect.Left, 0);
    if NewThumbRect.Right > Width then
      NewThumbRect.Offset(-(NewThumbRect.Right - Width), 0);

    FThumbRect.Rect := NewThumbRect;
    FSavedPos := TPointF.Create(X, Y);
  end;
end;

procedure TCustomSwitchObject.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
var
  LAllowChange: Boolean;
begin
  inherited;
  if FPressed then
  begin
    FPressed := False;

    LAllowChange := True;

    if Observers.IsObserving(TObserverMapping.EditLinkID) then
    begin
      if TLinkObservers.EditLinkEdit(Observers) then
        TLinkObservers.EditLinkModified(Observers)
      else
      begin
        TLinkObservers.EditLinkReset(Observers);
        LAllowChange := False;
      end;
    end;

    if LAllowChange then
    begin
      if not FTracking then
      begin
        SetValue(not Value);
        AnimateTo(Value);
      end else
      begin
        SetValue(GetValueByMousePos(X, Y));
        AnimateTo(Value);
      end;
    end
    else
      AnimateTo(Value);
    FTracking := False;
    Repaint;


    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      TLinkObservers.EditLinkTrackUpdate(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
    begin
      TLinkObservers.ControlValueModified(Observers);
      TLinkObservers.ControlValueTrackUpdate(Observers);
    end;

  end;
end;

procedure TCustomSwitchObject.Paint;
begin
  PaintTrack;
  PaintTrackText;
  PaintThumb;
  PaintThumbText;
end;

procedure TCustomSwitchObject.PaintClippingTracks;
var
  R: TRectF;
  State: TCanvasSaveState;
begin
  State := Canvas.SaveState;
  try
    R := LocalRect;
    R.Left := GetThumbCenter;
    Canvas.IntersectClipRect(R);

    R := LocalRect;
    PaintTrackForValue(R, False);
  finally
    Canvas.RestoreState(State);
  end;

  State := Canvas.SaveState;
  try
    R := LocalRect;
    R.Right := GetThumbCenter;
    Canvas.IntersectClipRect(R);

    R := LocalRect;
    PaintTrackForValue(R, True);
  finally
    Canvas.RestoreState(State);
  end;
end;

procedure TCustomSwitchObject.PaintFadingTracks;
var
  R: TRectF;
begin
  R := LocalRect;
  if GetThumbCenter < Width / 2 then
    PaintTrackForValue(R, False)
  else
    PaintTrackForValue(R, True);
end;

procedure TCustomSwitchObject.PaintTrack;
begin
  case Kind of
    TSwitchKind.ClippingTracks: PaintClippingTracks;
    TSwitchKind.FadingTracks: PaintFadingTracks;
  end;
end;

procedure TCustomSwitchObject.PaintTrackText;
var
  R: TRectF;
  State: TCanvasSaveState;
begin
  if IsTrackTextVisible then
  begin
    State := Canvas.SaveState;
    try
      R := LocalRect;
      R.Inflate(-TextClipOffset, 0);
      Canvas.IntersectClipRect(R);

      R := LocalRect;
      R.Right := R.Right - GetThumbLength;

      R.Offset(Round(GetThumbRect.Right), 0);
      PaintTrackTextForValue(R, False);
      R.Offset(-Width, 0);
      PaintTrackTextForValue(R, True);
    finally
      Canvas.RestoreState(State);
    end;
  end;
end;

procedure TCustomSwitchObject.PaintThumb;
var
  R: TRectF;
begin
  R := GetThumbRect;
  PaintThumbForValue(R, Value);
end;

procedure TCustomSwitchObject.PaintThumbText;
var
  R: TRectF;
begin
  if IsThumbTextVisible then
  begin
    R := TRectF.Create(GetThumbRect.Round);
    if FTracking or FAnimating then
      PaintThumbTextForValue(R, GetThumbValue > 0.5)
    else
      PaintThumbTextForValue(R, Value);
  end;
end;

procedure TCustomSwitchObject.PaintThumbForValue(const R: TRectF;
  const Value: Boolean);
begin

end;

procedure TCustomSwitchObject.PaintThumbTextForValue(const R: TRectF;
  const Value: Boolean);
begin
  FThumbText.Value := Value;
  FThumbText.DrawToCanvas(Canvas, R, AbsoluteOpacity);
end;

procedure TCustomSwitchObject.PaintTrackForValue(const R: TRectF;
  const Value: Boolean);
begin

end;

procedure TCustomSwitchObject.PaintTrackTextForValue(const R: TRectF;
  const Value: Boolean);
begin
  FTrackText.Value := Value;
  FTrackText.DrawToCanvas(Canvas, R, AbsoluteOpacity);
end;

procedure TCustomSwitchObject.SetThumbLength(const Value: Single);
begin
  FThumbLength := Value;
end;

procedure TCustomSwitchObject.SetThumbPadding(const Value: TBounds);
begin
  FThumbPadding.Assign(Value);
end;

procedure TCustomSwitchObject.SetThumbRect(const Value: TBounds);
begin
  FThumbRect.Assign(Value);
end;

procedure TCustomSwitchObject.SetTrackingThumbScale(const Value: Single);
begin
  FTrackingThumbScale := Value;
end;

procedure TCustomSwitchObject.SetValue(const Value: Boolean);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    DoChange;
  end;
end;

{ TSwitchObject }

constructor TSwitchObject.Create(AOwner: TComponent);
begin
  inherited;
  FFill := TBrush.Create(TBrushKind.Solid, claGray);
  FFillOn := TBrush.Create(TBrushKind.None, claWhite);
  FStroke := TStrokeBrush.Create(TBrushKind.Solid, claGray);
  FThumb := TBrush.Create(TBrushKind.Solid, claGray);
  FThumbOn := TBrush.Create(TBrushKind.None, claWhite);
  FThumbStroke := TStrokeBrush.Create(TBrushKind.Solid, claGray);
end;

destructor TSwitchObject.Destroy;
begin
  FreeAndNil(FThumbStroke);
  FreeAndNil(FThumbOn);
  FreeAndNil(FThumb);
  FreeAndNil(FFillOn);
  FreeAndNil(FFill);
  FreeAndNil(FStroke);
  inherited;
end;

procedure TSwitchObject.PaintTrackForValue(const R: TRectF; const Value: Boolean);
var
  Radius: Single;
  FillBrush: TBrush;
begin
  if FStroke.Kind <> TBrushKind.None then
    R.Inflate(-(FStroke.Thickness / 2), -(FStroke.Thickness / 2));

  if Value and (FFillOn.Kind <> TBrushKind.None) then
    FillBrush := FFillOn
  else
    FillBrush := FFill;

  case FShape of
    TSwitchShape.Rectangle:
      begin
        Canvas.FillRect(R, 0, 0, AllCorners, AbsoluteOpacity, FillBrush);
        Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity, FStroke);
      end;
    TSwitchShape.RoundRect:
      begin
        Radius := 3;
        Canvas.FillRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FillBrush);
        Canvas.DrawRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FStroke);
      end;
    TSwitchShape.Oval:
      begin
        Radius := R.Height / 2;
        Canvas.FillRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FillBrush);
        Canvas.DrawRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FStroke);
      end;
  end;
end;

procedure TSwitchObject.PaintThumbForValue(const R: TRectF;
  const Value: Boolean);
var
  Radius: Single;
  FillBrush: TBrush;
begin
  if FThumbStroke.Kind <> TBrushKind.None then
    R.Inflate(-(FThumbStroke.Thickness / 2), -(FThumbStroke.Thickness / 2));

  if Value and (FThumbOn.Kind <> TBrushKind.None) then
    FillBrush := FThumbOn
  else
    FillBrush := FThumb;

  case FShape of
    TSwitchShape.Rectangle:
      begin
        Canvas.FillRect(R, 0, 0, AllCorners, AbsoluteOpacity, FillBrush);
        Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity, FThumbStroke);
      end;
    TSwitchShape.RoundRect:
      begin
        Radius := 3;
        Canvas.FillRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FillBrush);
        Canvas.DrawRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FThumbStroke);
      end;
    TSwitchShape.Oval:
      begin
        Radius := R.Height / 2;
        Canvas.FillRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FillBrush);
        Canvas.DrawRect(R, Radius, Radius, AllCorners, AbsoluteOpacity, FThumbStroke);
      end;
  end;
end;

procedure TSwitchObject.SetFill(const Value: TBrush);
begin
  FFill.Assign(Value);
end;

procedure TSwitchObject.SetFillOn(const Value: TBrush);
begin
  FFillOn.Assign(Value);
end;

procedure TSwitchObject.SetStroke(const Value: TStrokeBrush);
begin
  FStroke.Assign(Value);
end;

procedure TSwitchObject.SetThumb(const Value: TBrush);
begin
  FThumb.Assign(Value);
end;

procedure TSwitchObject.SetThumbOn(const Value: TBrush);
begin
  FThumbOn.Assign(Value);
end;

procedure TSwitchObject.SetThumbStroke(const Value: TStrokeBrush);
begin
  FThumbStroke.Assign(Value);
end;

procedure TSwitchObject.SetShape(const Value: TSwitchShape);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    Repaint;
  end;
end;

{ TBitmapSwitchObject }

constructor TBitmapSwitchObject.Create(AOwner: TComponent);
var
  I: TSwitchPart;
begin
  inherited;
  for I := Low(TSwitchPart) to High(TSwitchPart) do
  begin
    FStyleObjects[I].OnObject := TStyleObject.Create(nil);
    FStyleObjects[I].OffObject := TStyleObject.Create(nil);
  end;
  FStyleObjects[TSwitchPart.TextBitmap].OnObject.WrapMode := TImageWrapMode.Center;
  FStyleObjects[TSwitchPart.TextBitmap].OffObject.WrapMode := TImageWrapMode.Center;
  FStyleObjects[TSwitchPart.TextBitmapEn].OnObject.WrapMode := TImageWrapMode.Center;
  FStyleObjects[TSwitchPart.TextBitmapEn].OffObject.WrapMode := TImageWrapMode.Center;
  FStyleObjects[TSwitchPart.TextBitmapJp].OnObject.WrapMode := TImageWrapMode.Center;
  FStyleObjects[TSwitchPart.TextBitmapJp].OffObject.WrapMode := TImageWrapMode.Center;
  TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, FLocaleService);
end;

destructor TBitmapSwitchObject.Destroy;
var
  Item: TSwitchRec;
  I: TSwitchPart;
begin
  for I := Low(TSwitchPart) to High(TSwitchPart) do
  begin
    Item := FStyleObjects[I];
    FStyleObjects[I].OnObject := nil;
    FStyleObjects[I].OffObject := nil;
    Item.OnObject.Free;
    Item.OffObject.Free;
  end;
  inherited;
end;

procedure TBitmapSwitchObject.DefineLinkProperties(const SourceRects, CapInsets: string; const StyleObject: TStyleObject; Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  if not CapInsets.IsEmpty then
  begin
    BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(StyleObject.SourceLink, Filer, CapInsets);
    try
      BitmapLinksLoader.ReadCapInsets;
    finally
      BitmapLinksLoader.Free;
    end;
  end;
  if not SourceRects.IsEmpty then
  begin
    BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(StyleObject.SourceLink, Filer, SourceRects);
    try
      BitmapLinksLoader.ReadSourceRects;
    finally
      BitmapLinksLoader.Free;
    end;
  end;
end;

procedure TBitmapSwitchObject.DefineProperties(Filer: TFiler);
begin
  inherited;
  DefineLinkProperties('TrackRect', 'TrackMargins', FStyleObjects[TSwitchPart.Track].OffObject, Filer);
  DefineLinkProperties('TrackOnRect', '', FStyleObjects[TSwitchPart.Track].OnObject, Filer);
  DefineLinkProperties('TrackHotRect', '', FStyleObjects[TSwitchPart.TrackHot].OffObject, Filer);
  DefineLinkProperties('TrackHotOnRect', '', FStyleObjects[TSwitchPart.TrackHot].OnObject, Filer);
  DefineLinkProperties('TrackZoomRect', '', FStyleObjects[TSwitchPart.TrackZoom].OffObject, Filer);
  DefineLinkProperties('ThumbRect', 'ThumbMargins', FStyleObjects[TSwitchPart.Thumb].OffObject, Filer);
  DefineLinkProperties('ThumbOnRect', '', FStyleObjects[TSwitchPart.Thumb].OnObject, Filer);
  DefineLinkProperties('ThumbPressedRect', '', FStyleObjects[TSwitchPart.ThumbPressed].OffObject, Filer);
  DefineLinkProperties('ThumbHotRect', '', FStyleObjects[TSwitchPart.ThumbHot].OffObject, Filer);
  DefineLinkProperties('ThumbHotOnRect', '', FStyleObjects[TSwitchPart.ThumbHot].OnObject, Filer);

  DefineLinkProperties('TextBitmapRect', '', FStyleObjects[TSwitchPart.TextBitmap].OffObject, Filer);
  DefineLinkProperties('TextBitmapOnRect', '', FStyleObjects[TSwitchPart.TextBitmap].OnObject, Filer);
  DefineLinkProperties('TextBitmapEnRect', '', FStyleObjects[TSwitchPart.TextBitmapEn].OffObject, Filer);
  DefineLinkProperties('TextBitmapEnOnRect', '', FStyleObjects[TSwitchPart.TextBitmapEn].OnObject, Filer);
  DefineLinkProperties('TextBitmapJpRect', '', FStyleObjects[TSwitchPart.TextBitmapJp].OffObject, Filer);
  DefineLinkProperties('TextBitmapJpOnRect', '', FStyleObjects[TSwitchPart.TextBitmapJp].OnObject, Filer);
end;

function TBitmapSwitchObject.GetCapMode(const Index: TSwitchPart): TCapWrapMode;
begin
  Result := FStyleObjects[Index].OffObject.CapMode;
end;

function TBitmapSwitchObject.GetOffObject(Index: TSwitchPart): TBitmapLinks;
begin
  Result := FStyleObjects[Index].OffObject.SourceLink;
end;

function TBitmapSwitchObject.GetOnObject(Index: TSwitchPart): TBitmapLinks;
begin
  Result := FStyleObjects[Index].OnObject.SourceLink;
end;

function TBitmapSwitchObject.GetSourceLookup: string;
begin
  Result := FSourceLookup;
end;

function TBitmapSwitchObject.GetWrapMode(const Index: TSwitchPart): TImageWrapMode;
begin
  Result := FStyleObjects[Index].OffObject.WrapMode;
end;

function TBitmapSwitchObject.IsThumbTextVisible: Boolean;
begin
  Result := inherited IsThumbTextVisible;
end;

function TBitmapSwitchObject.IsTrackTextVisible: Boolean;
begin
  Result := inherited IsTrackTextVisible or not FStyleObjects[TSwitchPart.TextBitmap].OffObject.IsEmpty;
end;

procedure TBitmapSwitchObject.Loaded;
begin
  inherited;
  CopyCaps(TSwitchPart.Track);
  CopyCaps(TSwitchPart.Track, TSwitchPart.TrackHot);
  CopyCaps(TSwitchPart.Thumb);
  CopyCaps(TSwitchPart.Thumb, TSwitchPart.ThumbPressed);
  CopyCaps(TSwitchPart.Thumb, TSwitchPart.ThumbHot);
end;

procedure TBitmapSwitchObject.SetNewScene(AScene: IScene);
var
  Item: TSwitchRec;
begin
  inherited ;
  for Item in FStyleObjects do
  begin
    Item.OnObject.SetNewScene(Scene);
    Item.OffObject.SetNewScene(Scene);
  end;
end;

procedure TBitmapSwitchObject.CopyCaps(const Index: TSwitchPart);
var
  I: Integer;
  OnObject, OffObject: TStyleObject;
begin
  OnObject := FStyleObjects[Index].OnObject;
  OffObject := FStyleObjects[Index].OffObject;
  if OnObject.SourceLink.Count = OffObject.SourceLink.Count then
    for I := 0 to OffObject.SourceLink.Count - 1 do
      if not OnObject.SourceLink.Links[I].CapInsetsChanged then
        OnObject.SourceLink.Links[I].CapInsets := OffObject.SourceLink.Links[I].CapInsets;
end;

procedure TBitmapSwitchObject.CopyCaps(const Source, Dest: TSwitchPart);
var
  I: Integer;
  SourceObject, DestObject: TStyleObject;
begin
  SourceObject := FStyleObjects[Source].OffObject;
  DestObject := FStyleObjects[Dest].OffObject;
  if SourceObject.SourceLink.Count = DestObject.SourceLink.Count then
    for I := 0 to SourceObject.SourceLink.Count - 1 do
      if not DestObject.SourceLink.Links[I].CapInsetsChanged then
        DestObject.SourceLink.Links[I].CapInsets := SourceObject.SourceLink.Links[I].CapInsets;
  CopyCaps(Dest);
end;

procedure TBitmapSwitchObject.PaintThumbForValue(const R: TRectF;
  const Value: Boolean);
begin
  if IsMouseOver and not Value and PartExists(TSwitchPart.ThumbHot, Value) then
    FStyleObjects[TSwitchPart.ThumbHot].OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity)
  else if IsMouseOver and Value and PartExists(TSwitchPart.ThumbHot, Value) then
    FStyleObjects[TSwitchPart.ThumbHot].OnObject.DrawToCanvas(Canvas, R, AbsoluteOpacity)
  else if Pressed and PartExists(TSwitchPart.ThumbPressed, False) then
    FStyleObjects[TSwitchPart.ThumbPressed].OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity)
  else if Value and PartExists(TSwitchPart.Thumb, Value) then
    FStyleObjects[TSwitchPart.Thumb].OnObject.DrawToCanvas(Canvas, R, AbsoluteOpacity)
  else
    FStyleObjects[TSwitchPart.Thumb].OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
end;

procedure TBitmapSwitchObject.PaintThumbTextForValue(const R: TRectF; const Value: Boolean);
var
  OnObject, OffObject: TStyleObject;
begin
  if ThumbText.Kind = TSwitchTextKind.Bitmap then
  begin
    OnObject := nil;
    OffObject := nil;
    if FLocaleService <> nil then
    begin
      if FLocaleService.GetCurrentLangID = 'en' then
      begin
        if Value then
          OnObject := FStyleObjects[TSwitchPart.TextBitmapEn].OnObject
        else
          OffObject := FStyleObjects[TSwitchPart.TextBitmapEn].OffObject
      end;
      if (FLocaleService.GetCurrentLangID = 'jp') or (FLocaleService.GetCurrentLangID = 'ja') then
      begin
        if Value then
          OnObject := FStyleObjects[TSwitchPart.TextBitmapJp].OnObject
        else
          OffObject := FStyleObjects[TSwitchPart.TextBitmapJp].OffObject
      end;
    end;

    if Value and ((OnObject = nil) or OnObject.IsEmpty) then
      OnObject := FStyleObjects[TSwitchPart.TextBitmap].OnObject
    else if not Value and ((OffObject = nil) or OffObject.IsEmpty) then
      OffObject := FStyleObjects[TSwitchPart.TextBitmap].OffObject;

    if Value and (OnObject <> nil) then
      OnObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
    if not Value and (OffObject <> nil) then
      OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
  end else
    inherited ;
end;

procedure TBitmapSwitchObject.PaintTrackForValue(const R: TRectF;
  const Value: Boolean);
begin
  if IsMouseOver and Value and PartExists(TSwitchPart.TrackHot, Value) then
    FStyleObjects[TSwitchPart.TrackHot].OnObject.DrawToCanvas(Canvas, R, AbsoluteOpacity)
  else if IsMouseOver and not Value and PartExists(TSwitchPart.TrackHot, Value) then
    FStyleObjects[TSwitchPart.TrackHot].OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity)
  else if Value and not FStyleObjects[TSwitchPart.Track].OnObject.IsEmpty then
  begin
    FStyleObjects[TSwitchPart.Track].OnObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
    if Kind = TSwitchKind.FadingTracks then
    begin
      if not FStyleObjects[TSwitchPart.TrackZoom].OnObject.IsEmpty then
      begin
        if FTracking or FAnimating then
          R.Inflate(-(R.Width * GetThumbValue) / 2, - (R.Height * GetThumbValue) / 2);
        FStyleObjects[TSwitchPart.TrackZoom].OnObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
      end;
    end;
  end
  else begin
    FStyleObjects[TSwitchPart.Track].OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
    if Kind = TSwitchKind.FadingTracks then
    begin
      if not FStyleObjects[TSwitchPart.TrackZoom].OffObject.IsEmpty then
      begin
        if FTracking or FAnimating then
          R.Inflate(-(R.Width * GetThumbValue) / 2, - (R.Height * GetThumbValue) / 2);
        FStyleObjects[TSwitchPart.TrackZoom].OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
      end;
    end;
  end;
end;

procedure TBitmapSwitchObject.PaintTrackTextForValue(const R: TRectF;
  const Value: Boolean);
var
  OnObject, OffObject: TStyleObject;
begin
  if TrackText.Kind = TSwitchTextKind.Bitmap then
  begin
    OnObject := nil;
    OffObject := nil;
    if FLocaleService <> nil then
    begin
      if FLocaleService.GetCurrentLangID = 'en' then
      begin
        if Value then
          OnObject := FStyleObjects[TSwitchPart.TextBitmapEn].OnObject
        else
          OffObject := FStyleObjects[TSwitchPart.TextBitmapEn].OffObject
      end;
      if (FLocaleService.GetCurrentLangID = 'jp') or (FLocaleService.GetCurrentLangID = 'ja') then
      begin
        if Value then
          OnObject := FStyleObjects[TSwitchPart.TextBitmapJp].OnObject
        else
          OffObject := FStyleObjects[TSwitchPart.TextBitmapJp].OffObject
      end;
    end;

    if Value and ((OnObject = nil) or OnObject.IsEmpty) then
      OnObject := FStyleObjects[TSwitchPart.TextBitmap].OnObject
    else if not Value and ((OffObject = nil) or OffObject.IsEmpty) then
      OffObject := FStyleObjects[TSwitchPart.TextBitmap].OffObject;

    if Value and (OnObject <> nil) then
      OnObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
    if not Value and (OffObject <> nil) then
      OffObject.DrawToCanvas(Canvas, R, AbsoluteOpacity);
  end else
    inherited ;
end;

function TBitmapSwitchObject.PartExists(const Part: TSwitchPart; const State: Boolean): Boolean;
var
  PartObject: TStyleObject;
  ScreenScale: Single;
  Link: TBitmapLink;
begin
  if State then
    PartObject := FStyleObjects[Part].OnObject
  else
    PartObject := FStyleObjects[Part].OffObject;

  Result := not PartObject.IsEmpty;
  if Result then
  begin
    if Scene <> nil then
      ScreenScale := Scene.GetSceneScale
    else
      ScreenScale := Canvas.Scale;

    Link := PartObject.SourceLink.LinkByScale(ScreenScale, False);
    if Link <> nil then
      Result := not Link.SourceRect.Rect.IsEmpty
    else
      Result := False;
  end;
end;

procedure TBitmapSwitchObject.SetCapMode(const Index: TSwitchPart; const Value: TCapWrapMode);
begin
  FStyleObjects[Index].OnObject.CapMode := Value;
  FStyleObjects[Index].OffObject.CapMode := Value;
  if Index = TSwitchPart.Thumb then
  begin
    FStyleObjects[TSwitchPart.ThumbPressed].OnObject.CapMode := Value;
    FStyleObjects[TSwitchPart.ThumbPressed].OffObject.CapMode := Value;
  end;
end;

procedure TBitmapSwitchObject.SetOffObject(Index: TSwitchPart;
  const Value: TBitmapLinks);
begin
  FStyleObjects[Index].OffObject.SourceLink.Assign(Value);
end;

procedure TBitmapSwitchObject.SetOnObject(Index: TSwitchPart;
  const Value: TBitmapLinks);
begin
  FStyleObjects[Index].OnObject.SourceLink.Assign(Value);
end;

procedure TBitmapSwitchObject.SetSourceLookup(const Value: string);
var
  Item: TSwitchRec;
begin
  FSourceLookup := Value;
  for Item in FStyleObjects do
  begin
    Item.OnObject.SourceLookup := FSourceLookup;
    Item.OffObject.SourceLookup := FSourceLookup;
  end;
end;

procedure TBitmapSwitchObject.SetWrapMode(const Index: TSwitchPart;
  const Value: TImageWrapMode);
begin
  FStyleObjects[Index].OnObject.WrapMode := Value;
  FStyleObjects[Index].OffObject.WrapMode := Value;
  if Index = TSwitchPart.Thumb then
  begin
    FStyleObjects[TSwitchPart.ThumbPressed].OnObject.WrapMode := Value;
    FStyleObjects[TSwitchPart.ThumbPressed].OffObject.WrapMode := Value;
  end;
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TSwitchTextKind), ['stkNone', 'stkIO', 'stkIOandOnOff', 'stkLocalized', 'stkBitmap']);
  AddEnumElementAliases(TypeInfo(TSwitchKind), ['skClippingTracks', 'skFadingTracks']);
  AddEnumElementAliases(TypeInfo(TSwitchShape), ['ssRectangle', 'ssRoundRect', 'ssOval']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TSwitchTextKind));
  RemoveEnumElementAliases(TypeInfo(TSwitchKind));
  RemoveEnumElementAliases(TypeInfo(TSwitchShape));
end;

initialization
  RegisterAliases;
  RegisterFmxClasses([TSwitchObject, TBitmapSwitchObject]);
finalization
  UnregisterAliases;
end.
