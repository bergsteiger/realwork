{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Forms.Border;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes,
  System.Types,
  System.UITypes,
  System.Messaging,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics;

type

{ TStyledWindowBorder }

  TStyledWindowBorder = class(TWindowBorder, IRoot, IStyleBookOwner, IScene, IContainerObject, IAlignRoot)
  private
    FNeedStyleLookup: Boolean;
    FLastWidth, FLastHeight: Single;
    FMousePos, FDownPos: TPointF;
    FHovered, FCaptured, FFocused: IControl;
    FStyleChangedId: Integer;
    FWinService: IFMXWindowService;
    FDisableUpdating: Integer;
    function GetStyleObject: TControl;
    { IRoot }
    function GetObject: TFmxObject;
    function GetActiveControl: IControl;
    procedure SetActiveControl(const AControl: IControl);
    procedure SetCaptured(const Value: IControl);
    function NewFocusedControl(const Value: IControl): IControl;
    procedure SetFocused(const Value: IControl);
    procedure SetHovered(const Value: IControl);
    function GetCaptured: IControl;
    function GetFocused: IControl;
    function GetBiDiMode: TBiDiMode;
    function GetHovered: IControl;
    procedure BeginInternalDrag(const Source: TObject; const ABitmap: TObject);
    { IScene }
    procedure AddUpdateRect(R: TRectF);
    function GetUpdateRectsCount: Integer;
    function GetUpdateRect(const Index: Integer): TRectF;
    function LocalToScreen(P: TPointF): TPointF;
    function ScreenToLocal(P: TPointF): TPointF;
    function GetSceneScale: Single;
    procedure ChangeScrollingState(const AControl: TControl; const Active: Boolean);
    procedure DisableUpdating;
    procedure EnableUpdating;
    { IStyleBookOwner }
    function GetStyleBook: TStyleBook;
    procedure SetStyleBook(const Value: TStyleBook);
    { IContainerObject }
    function GetContainerWidth: Single;
    function GetContainerHeight: Single;
    { }
    function GetActive: Boolean;
    procedure StyleChangedHandler(const Sender: TObject; const Msg: System.Messaging.TMessage);
  protected
    FClientObject: TControl;
    FCloseObject: TControl;
    FIconObject: TControl;
    FTitleObject: TControl;
    FMinObject: TControl;
    FMaxObject: TControl;
    FResObject: TControl;
    FMaskObject: TControl;
    FDisableAlign: Boolean;
    FResourceLink: TControl;
    procedure ApplyStyleLookup;
    procedure DoApplyStyle; virtual;
    procedure DoCloseClick(Sender: TObject);
    procedure DoMaxClick(Sender: TObject);
    procedure DoResClick(Sender: TObject);
    procedure DoMinClick(Sender: TObject);
    function GetStyleLookup: string; virtual;
    function GetFormSize: TSizeF; virtual;
  protected
    procedure FreeNotification(AObject: TObject); override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    /// <summary>Sets scene Scene for object AObject. Used internally by DoAddObject and DoRemoveObject.</summary>
    procedure SetScene(const AObject: TFmxObject; const Scene: IScene);
    procedure DoAddUpdateRect(R: TRectF); virtual;
    function GetClientMargins: TRectF; virtual;
    procedure StyleChanged; override;
    procedure ScaleChanged; override;
    procedure Invalidate; virtual;
    { TWindowBorder }
    procedure Resize; override;
    procedure Activate; override;
    procedure Deactivate; override;
    function GetSupported: Boolean; override;
    { IScene }
    function GetCanvas: TCanvas; virtual;
    { IAlignRoot }
    procedure Realign;
    procedure ChildrenAlignChanged;
  public
    constructor Create(const AForm: TCommonCustomForm); override;
    destructor Destroy; override;
    function ObjectAtPoint(P: TPointF): IControl;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseMove(Shift: TShiftState; X, Y: Single);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseLeave;
    property ClientMargins: TRectF read GetClientMargins;
    /// <summary>Form size in unscaled coordinates.</summary>
    property FormSize: TSizeF read GetFormSize;
    property IsActive: Boolean read GetActive;
  end;

implementation

uses
  System.SysUtils, FMX.Styles, FMX.StdCtrls, FMX.Ani, FMX.Platform, FMX.Effects, FMX.Consts;

type
  TOpenFmxObject = class(TFmxObject);
  TOpenControl = class(TControl);

{ TStyledWindowBorder }

constructor TStyledWindowBorder.Create(const AForm: TCommonCustomForm);
begin
  inherited;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXWindowService, FWinService) then
    raise EUnsupportedPlatformService.Create('IFMXWindowService');
  FNeedStyleLookup := True;
  FStyleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TStyleChangedMessage, StyleChangedHandler);
end;

destructor TStyledWindowBorder.Destroy;
var
  I: Integer;
begin
  for I := ChildrenCount - 1 downto 0 do
    SetScene(Children[I], nil);
  TMessageManager.DefaultManager.Unsubscribe(TStyleChangedMessage, FStyleChangedId);
  inherited;
end;

procedure TStyledWindowBorder.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  SetScene(AObject, Self);
  Realign;
  if (AObject is TControl) then
  begin
    TOpenControl(AObject).RecalcOpacity;
    TOpenControl(AObject).RecalcAbsolute;
    TOpenControl(AObject).RecalcUpdateRect;
    TOpenControl(AObject).RecalcHasClipParent;
    TOpenControl(AObject).RecalcEnabled;
  end;
end;

procedure TStyledWindowBorder.DoRemoveObject(const AObject: TFmxObject);
begin
  SetScene(AObject, nil);
  inherited;
end;

procedure TStyledWindowBorder.FreeNotification(AObject: TObject);
begin
  inherited;
  if (FHovered <> nil) and (FHovered.GetObject = AObject) then
    FHovered := nil;
  if (FCaptured <> nil) and (FCaptured.GetObject = AObject) then
    FCaptured := nil;
  if (FFocused <> nil) and (FFocused.GetObject = AObject) then
    FFocused := nil;
end;

function TStyledWindowBorder.GetStyleObject: TControl;
var
  Obj: TFmxObject;
begin
  Obj := TStyledControl.LookupStyleObject(Self, Self, Self, GetStyleLookup, '', '', True, False);
  if Obj is TControl then
    Result := TControl(Obj)
  else
    Result := nil;
end;

function TStyledWindowBorder.GetSupported: Boolean;
begin
  if (not (TFmxFormState.WasNotShown in Form.FormState)) or
     (TFmxFormState.Showing in Form.FormState) then
    ApplyStyleLookup;
  Result := (Form <> nil) and (FResourceLink <> nil) and (Form.BorderStyle <> TFmxFormBorderStyle.None);
end;

procedure TStyledWindowBorder.DoApplyStyle;
begin
  FClientObject := TControl(FResourceLink.FindStyleResource('client'));
  FTitleObject := TControl(FResourceLink.FindStyleResource('title'));
  FCloseObject := TControl(FResourceLink.FindStyleResource('close'));
  if FCloseObject is TCustomButton then
  begin
    TCustomButton(FCloseObject).Enabled := TBorderIcon.biSystemMenu in Form.BorderIcons;
    TCustomButton(FCloseObject).OnClick := DoCloseClick;
  end;
  FMaxObject := TControl(FResourceLink.FindStyleResource('max'));
  if FMaxObject is TCustomButton then
  begin
    TCustomButton(FMaxObject).Enabled := TBorderIcon.biMaximize in Form.BorderIcons;
    TCustomButton(FMaxObject).OnClick := DoMaxClick;
  end;
  FMinObject := TControl(FResourceLink.FindStyleResource('min'));
  if FMinObject is TCustomButton then
  begin
    TCustomButton(FMinObject).Enabled := TBorderIcon.biMinimize in Form.BorderIcons;
    TCustomButton(FMinObject).OnClick := DoMinClick;
  end;

  if (FCloseObject is TCustomButton) and (FMaxObject is TCustomButton) and (FMinObject is TCustomButton) then
  begin
    if not TCustomButton(FCloseObject).Enabled and not TCustomButton(FMinObject).Enabled and not TCustomButton(FMaxObject).Enabled then
    begin
      TCustomButton(FCloseObject).Visible := False;
      TCustomButton(FMinObject).Visible := False;
      TCustomButton(FMaxObject).Visible := False;
    end
    else
    begin
      TCustomButton(FCloseObject).Visible := True;
      TCustomButton(FMinObject).Visible := True;
      TCustomButton(FMaxObject).Visible := True;
    end;
  end;

  FResObject := TControl(FResourceLink.FindStyleResource('Res'));
  if FResObject is TCustomButton then
    TCustomButton(FResObject).OnClick := DoResClick;
  FIconObject := TControl(FResourceLink.FindStyleResource('icon'));
  FMaskObject := TControl(FResourceLink.FindStyleResource('mask'));
end;

procedure CallLoaded(const Obj: TFmxObject);
var
  I: Integer;
begin
  TOpenFmxObject(Obj).Loaded;
  for I := 0 to Obj.ChildrenCount - 1 do
    CallLoaded(Obj.Children[I]);
end;

procedure TStyledWindowBorder.ApplyStyleLookup;
var
  ResourceObject: TControl;
begin
  if FNeedStyleLookup then
  begin
    FNeedStyleLookup := False;
    ResourceObject := GetStyleObject;
    if ResourceObject <> nil then
    begin
      if csLoading in ResourceObject.ComponentState then
        CallLoaded(ResourceObject);
      FClientObject := nil;
      FCloseObject := nil;
      FreeAndNil(FResourceLink);
      ResourceObject.Visible := True;
      ResourceObject.Align := TAlignLayout.Contents;
      AddObject(ResourceObject);
      FResourceLink := ResourceObject;
      { bring to front }
      RemoveObject(ResourceObject);
      InsertObject(0, ResourceObject);
      Realign;
      { set fields }
      DoApplyStyle;
      { }
      ResourceObject.Stored := False;
      ResourceObject.Lock;
    end
    else
    begin
      FClientObject := nil;
      FCloseObject := nil;
      FreeAndNil(FResourceLink);
    end;
  end;
end;

procedure TStyledWindowBorder.DoCloseClick(Sender: TObject);
begin
  Form.Close;
end;

procedure TStyledWindowBorder.DoMaxClick(Sender: TObject);
begin
  Form.WindowState := TWindowState.wsMaximized;
end;

procedure TStyledWindowBorder.DoMinClick(Sender: TObject);
begin
  Form.WindowState := TWindowState.wsMinimized;
end;

procedure TStyledWindowBorder.DoResClick(Sender: TObject);
begin
  Form.WindowState := TWindowState.wsNormal;
end;

function TStyledWindowBorder.GetClientMargins: TRectF;
var
  R: TRectF;
begin
  ApplyStyleLookup;
  if FClientObject <> nil then
  begin
    FResourceLink.Position.Point := TPointF.Zero;
    R := FClientObject.AbsoluteRect;
    Result := TRectF.Create(R.Left, R.Top, FResourceLink.Width - R.Right, FResourceLink.Height - R.Bottom);
  end
  else
    Result := TRectF.Empty;
end;

function TStyledWindowBorder.ObjectAtPoint(P: TPointF): IControl;
var
  i: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
begin
  Result := nil;
  if IsSupported then
  begin
    for i := ChildrenCount - 1 downto 0 do
    begin
      Obj := Children[i];
      if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
        Continue;
      if not NewObj.GetVisible and not(csDesigning in ComponentState) then
        Continue;
      NewObj := NewObj.ObjectAtPoint(P);
      if NewObj <> nil then
      begin
        Result := NewObj;
        Exit;
      end;
    end;
  end;
end;

procedure TStyledWindowBorder.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  Obj: IControl;
begin
  FMousePos := PointF(X, Y);
  FDownPos := FMousePos;
  Obj := ObjectAtPoint(FMousePos);
  if Obj <> nil then
  begin
    P := Obj.ScreenToLocal(PointF(FMousePos.X, FMousePos.Y));
    Obj.MouseDown(Button, Shift, P.X, P.Y);
  end;
end;

procedure TStyledWindowBorder.MouseMove(Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  Obj: IControl;
  SG: ISizeGrip;
  NewCursor: TCursor;
  CursorService: IFMXCursorService;
begin
  NewCursor := crDefault;
  TPlatformServices.Current.SupportsPlatformService(IFMXCursorService, CursorService);
  FMousePos := PointF(X, Y);
  if FCaptured <> nil then
  begin
    if CursorService <> nil then
    begin
      if (FCaptured.QueryInterface(ISizeGrip, SG) = 0) and (SG <> nil) then
        CursorService.SetCursor(crSizeNWSE)
      else
        CursorService.SetCursor(FCaptured.Cursor);
    end;
    P := FCaptured.ScreenToLocal(PointF(FMousePos.X, FMousePos.Y));
    FCaptured.MouseMove(Shift, P.X, P.Y);
    Exit;
  end;

  Obj := ObjectAtPoint(FMousePos);
  if Obj <> nil then
  begin
    SetHovered(Obj);
    P := Obj.ScreenToLocal(PointF(FMousePos.X, FMousePos.Y));
    Obj.MouseMove(Shift, P.X, P.Y);
    if (Obj.QueryInterface(ISizeGrip, SG) = 0) and (SG <> nil) then
      NewCursor := crSizeNWSE
    else
      NewCursor := Obj.Cursor;
  end
  else
    SetHovered(nil);
  // set cursor
  if CursorService <> nil then
    CursorService.SetCursor(NewCursor);
  FDownPos := FMousePos;
end;

procedure TStyledWindowBorder.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  Obj: IControl;
begin
  if FCaptured <> nil then
  begin
    P := FCaptured.ScreenToLocal(PointF(FMousePos.X, FMousePos.Y));
    FCaptured.MouseClick(Button, Shift, P.X, P.Y);
    FCaptured.MouseUp(Button, Shift, P.X, P.Y);
    SetCaptured(nil);
    Exit;
  end;
  Obj := ObjectAtPoint(FMousePos);
  if Obj <> nil then
  begin
    P := Obj.ScreenToLocal(PointF(FMousePos.X, FMousePos.Y));
    Obj.MouseClick(Button, Shift, P.X, P.Y);
    Obj.MouseUp(Button, Shift, P.X, P.Y);
  end;
end;

procedure TStyledWindowBorder.MouseLeave;
begin
  SetHovered(nil);
end;

{ IRoot }

function TStyledWindowBorder.GetObject: TFmxObject;
begin
  Result := Self;
end;

function TStyledWindowBorder.GetActive: Boolean;
begin
  Result := Form.Active
end;

function TStyledWindowBorder.GetActiveControl: IControl;
begin
  Result := nil;
end;

procedure TStyledWindowBorder.SetActiveControl(const AControl: IControl);
begin
end;

procedure TStyledWindowBorder.SetCaptured(const Value: IControl);
begin
  if FCaptured <> Value then
  begin
    if FCaptured <> nil then
    begin
      Form.ReleaseCapture;
      FCaptured.RemoveFreeNotify(Self);
    end;
    FCaptured := Value;
    if FCaptured <> nil then
    begin
      Form.MouseCapture;
      FCaptured.AddFreeNotify(Self);
    end;
  end;
end;

function TStyledWindowBorder.NewFocusedControl(const Value: IControl): IControl;
begin
end;

procedure TStyledWindowBorder.SetFocused(const Value: IControl);
begin
end;

procedure TStyledWindowBorder.SetHovered(const Value: IControl);
begin
  if (Value <> FHovered) then
  begin
    if FHovered <> nil then
    begin
      FHovered.DoMouseLeave;
      FHovered.RemoveFreeNotify(Self);
    end;
    FHovered := Value;
    if FHovered <> nil then
    begin
      FHovered.AddFreeNotify(Self);
      FHovered.DoMouseEnter;
    end;
  end;
end;

procedure TStyledWindowBorder.SetScene(const AObject: TFmxObject; const Scene: IScene);
begin
  if AObject is TControl then
    TControl(AObject).SetNewScene(Scene);
end;

procedure TStyledWindowBorder.SetStyleBook(const Value: TStyleBook);
begin
end;

procedure TStyledWindowBorder.StyleChangedHandler(const Sender: TObject; const Msg: System.Messaging.TMessage);
begin
  if (TStyleChangedMessage(Msg).Value <> nil) and (GetStyleBook <> TStyleChangedMessage(Msg).Value) then Exit;
  StyleChanged;
end;

function TStyledWindowBorder.GetCaptured: IControl;
begin
  Result := nil;
end;

function TStyledWindowBorder.GetFocused: IControl;
begin
  Result := nil;
end;

function TStyledWindowBorder.GetFormSize: TSizeF;
begin
  Result := TSizeF.Create(Form.Width, Form.Height);
end;

function TStyledWindowBorder.GetBiDiMode: TBiDiMode;
begin
  Result := TBiDiMode.bdLeftToRight;
end;

function TStyledWindowBorder.GetHovered: IControl;
begin
  Result := nil;
end;

procedure TStyledWindowBorder.BeginInternalDrag(const Source: TObject; const ABitmap: TObject);
begin
end;

procedure TStyledWindowBorder.Deactivate;
begin
  TAnimator.StartTriggerAnimation(Self, Self, 'IsActive');
  TEffectAnimator.ApplyTriggerEffect(Self, Self, 'IsActive');
end;

procedure TStyledWindowBorder.Activate;
begin
  TAnimator.StartTriggerAnimation(Self, Self, 'IsActive');
  TEffectAnimator.ApplyTriggerEffect(Self, Self, 'IsActive');
end;

procedure TStyledWindowBorder.AddUpdateRect(R: TRectF);
begin
  if FDisableUpdating = 0 then
    DoAddUpdateRect(R);
end;

function TStyledWindowBorder.GetCanvas: TCanvas;
begin
  Result := nil;
end;

function TStyledWindowBorder.GetSceneScale: Single;
begin
  if Form <> nil then
    Result := Form.Handle.Scale
  else
    Result := 1;
end;

function TStyledWindowBorder.GetStyleBook: TStyleBook;
begin
  if Form <> nil then
    Result := (Form as IStyleBookOwner).StyleBook
  else
    Result := nil;
end;

function TStyledWindowBorder.GetStyleLookup: string;
begin
  Result := 'windowborderstyle';
end;

function TStyledWindowBorder.GetUpdateRect(const Index: Integer): TRectF;
begin
  Result := TRectF.Create(0, 0, Form.Width, Form.Height);
end;

function TStyledWindowBorder.GetUpdateRectsCount: Integer;
begin
  Result := 1;
end;

procedure TStyledWindowBorder.DoAddUpdateRect(R: TRectF);
begin
  if IsSupported then
    if not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
      Invalidate;
end;

procedure TStyledWindowBorder.Invalidate;
begin
end;

function TStyledWindowBorder.LocalToScreen(P: TPointF): TPointF;
begin
  Result := FWinService.ClientToScreen(Form, P - ClientMargins.TopLeft);
end;

procedure TStyledWindowBorder.ScaleChanged;
begin
  Resize;
  StyleChanged;
end;

function TStyledWindowBorder.ScreenToLocal(P: TPointF): TPointF;
begin
  Result := FWinService.ScreenToClient(Form, P) + ClientMargins.TopLeft;
end;

procedure TStyledWindowBorder.StyleChanged;
begin
  if csLoading in ComponentState then
    Exit;
  if csDestroying in ComponentState then
    Exit;
  FNeedStyleLookup := True;
  ApplyStyleLookup;
  if IsSupported then
  begin
    TAnimator.StartTriggerAnimation(Self, Self, 'IsActive');
    TEffectAnimator.ApplyTriggerEffect(Self, Self, 'IsActive');
  end;
end;

procedure TStyledWindowBorder.DisableUpdating;
begin
  Inc(FDisableUpdating);
end;

procedure TStyledWindowBorder.EnableUpdating;
begin
  Dec(FDisableUpdating);
  if FDisableUpdating < 0 then
    raise EInvalidSceneUpdatingPairCall.Create(SInvalidSceneUpdatingPairCall);
end;

{ IContainerObject }

function TStyledWindowBorder.GetContainerHeight: Single;
begin
  Result := Form.Width;
end;

function TStyledWindowBorder.GetContainerWidth: Single;
begin
  Result := Form.Height;
end;

{ IAlignRoot }

procedure TStyledWindowBorder.ChangeScrollingState(const AControl: TControl; const Active: Boolean);
begin
end;

procedure TStyledWindowBorder.ChildrenAlignChanged;
begin
  Realign;
end;

procedure TStyledWindowBorder.Realign;
var
  Padding: TBounds;
begin
  if (FResourceLink <> nil) and (Form.BorderStyle <> TFmxFormBorderStyle.None) then
  begin
    Padding := TBounds.Create(TRectF.Empty);
    try
      AlignObjects(Self, Padding, FormSize.Width, FormSize.Height, FLastWidth, FLastHeight, FDisableAlign);
    finally
      Padding.Free;
    end;
  end;
end;

procedure TStyledWindowBorder.Resize;
begin
  Realign;
end;

end.

