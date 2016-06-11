{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Presentation.Win.Style;

interface

{$SCOPEDENUMS ON}

uses
  Winapi.Messages, WinApi.Windows, System.TypInfo, System.Types, System.Classes, System.SysUtils, System.Rtti,
  System.UITypes, System.Math, FMX.Controls.Win, FMX.Zorder.Win, FMX.Types, FMX.Controls.Presentation, FMX.Controls,
  FMX.Presentation.Messages, FMX.Controls.Model, FMX.Graphics, FMX.Platform.Win, FMX.Presentation.Win, FMX.Forms;

type

  TWinStyledPresentation = class;
  TNativeScene = class;

  /// <summary>Helper class used as root for control's style</summary>
  TNativeStyledControl = class(TStyledControl)
  private
    [Weak] FScene: TNativeScene;
  protected
    function GetDefaultStyleLookupName: string; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure AdjustSize; override;
  end;

  /// <summary>Non TControl class that used as container for style to break control parenting</summary>
  TNativeScene = class(TFmxObject, IControl, IScene, IPaintControl)
  private
    [Weak] FPresentation: TWinStyledPresentation;
    FBackground: TBitmap;
    FHandle: TWinWindowHandle;
    FStyledControl: TNativeStyledControl;
    FCanvas: TCanvas;
    FUpdateRects: array of TRectF;
    FContextHandle: THandle;
    FDisableUpdating: Integer;
    { IControl }
    function GetObject: TFmxObject;
    procedure SetFocus;
    function GetIsFocused: boolean;
    function GetCanFocus: Boolean;
    function GetCanParentFocus: Boolean;
    function GetEnabled: Boolean;
    function GetAbsoluteEnabled: Boolean;
    function GetPopupMenu: TCustomPopupMenu;
    function EnterChildren(AObject: IControl): Boolean;
    function ExitChildren(AObject: IControl): Boolean;
    procedure DoEnter;
    procedure DoExit;
    procedure DoActivate;
    procedure DoDeactivate;
    procedure DoMouseEnter;
    procedure DoMouseLeave;
    function ShowContextMenu(const ScreenPosition: TPointF): Boolean;
    function ScreenToLocal(P: TPointF): TPointF;
    function LocalToScreen(P: TPointF): TPointF;
    function ObjectAtPoint(P: TPointF): IControl;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseMove(Shift: TShiftState; X, Y: Single);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure Tap(const Point: TPointF);
    procedure DialogKey(var Key: Word; Shift: TShiftState);
    procedure AfterDialogKey(var Key: Word; Shift: TShiftState);
    function FindTarget(P: TPointF; const Data: TDragObject): IControl;
    procedure DragEnter(const Data: TDragObject; const Point: TPointF);
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
    procedure DragDrop(const Data: TDragObject; const Point: TPointF);
    procedure DragLeave;
    procedure DragEnd;
    function CheckForAllowFocus: Boolean;
    procedure Repaint;
    function GetDragMode: TDragMode;
    procedure SetDragMode(const ADragMode: TDragMode);
    procedure BeginAutoDrag;
    function GetParent: TFmxObject;
    function GetLocked: Boolean;
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    function GetHitTest: Boolean;
    function GetCursor: TCursor;
    function GetInheritedCursor: TCursor;
    function GetDesignInteractive: Boolean;
    function GetAcceptsControls: Boolean;
    procedure SetAcceptsControls(const Value: Boolean);
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetTabStopController: ITabStopController;
    function GetTabStop: Boolean;
    procedure SetTabStop(const TabStop: Boolean);
    /// <summary>Implementation of IControl.HasHint.</summary>
    function HasHint: Boolean; virtual;
    /// <summary>Implementation of IControl.GetHintString.</summary>
    function GetHintString: string; virtual;
    /// <summary>Implementation of IControl.GetHintObject.</summary>
    function GetHintObject: TObject; virtual;
    { IScene }
    function GetStyleBook: TStyleBook;
    procedure SetStyleBook(const Value: TStyleBook);
    procedure AddUpdateRect(R: TRectF);
    function GetUpdateRectsCount: Integer;
    function GetUpdateRect(const Index: Integer): TRectF;
    function GetCanvas: TCanvas;
    function GetSceneScale: Single;
    procedure ChangeScrollingState(const AControl: TControl; const Active: Boolean);
    procedure DisableUpdating;
    procedure EnableUpdating;
    { IPaintControl }
    procedure MergeUpdateRects(const UpdateRects: array of TRectF);
    procedure PaintRects(const UpdateRects: array of TRectF);
    function GetContextHandle: THandle;
    procedure SetContextHandle(const AContextHandle: THandle);
    procedure SetSize(const ASize: TSizeF);
    function GetParentedPosition(const ParentHandle: HWnd): TPointF;
    procedure DrawFMBackground(const ParentHandle: HWnd);
    procedure DrawNativeBackground(const ParentHandle: HWnd);
    procedure DrawBackground(const Handle: HWnd);
  public
    constructor Create(APresentation: TWinStyledPresentation); reintroduce;
    destructor Destroy; override;
    /// <summary>Link to root styled control of the scene</summary>
    property StyledControl: TNativeStyledControl read FStyledControl;
    /// <summary>Link to OS window handle linked with presentation</summary>
    property Handle: TWinWindowHandle read FHandle;
  end;

{ TWinStyledPresentation }

  /// <summary>Basic Win native-styled presentation, which is HWnd.</summary>
  TWinStyledPresentation = class(TWinPresentation)
  public class var
    ///<summary>Atom assosiated with Handle that used as presentation</summary>
    Atom: TAtom;
    ///<summary>String assosiated with Atom</summary>
    AtomString: string;
    ///<summary>Return True Handle not assosiated with object</summary>
    class function IsParentNative(const Handle: HWnd): Boolean;
    ///<summary>Return assosiated with Handle object</summary>
    class function WindowToObject(Handle: HWND): TFmxObject;
  private
    FNativeScene: TNativeScene;
    function GetStyledControl: TNativeStyledControl;
    function GetResourceLink: TFmxObject;
    procedure PMApplyStyleLookup(var AMessage: TDispatchMessage); message PM_APPLY_STYLE_LOOKUP;
    procedure PMNeedStyleLookup(var AMessage: TDispatchMessage); message PM_NEED_STYLE_LOOKUP;
    procedure PMSetStyleLookup(var AMessage: TDispatchMessageWithValue<string>); message PM_SET_STYLE_LOOKUP;
    procedure PMFindStyleResource(var AMessage: TDispatchMessageWithValue<TFindStyleResourceInfo>); message PM_FIND_STYLE_RESOURCE;
    procedure PMRealign(var AMessage: TDispatchMessage); message PM_REALIGN;
    procedure PMGetRecommendSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_GET_RECOMMEND_SIZE;
    procedure PMObjectAtPoint(var AMessage: TDispatchMessageWithValue<TObjectAtPointInfo>); message PM_OBJECT_AT_POINT;
    procedure PMStartTriggerAnimation(var AMessage: TDispatchMessageWithValue<TTriggerInfo>); message PM_START_TRIGGER_ANIMATION;
    procedure PMApplyTriggerEffect(var AMessage: TDispatchMessageWithValue<TTriggerInfo>); message PM_APPLY_TRIGGER_EFFECT;
    procedure PMGetResourceLink(var AMessage: TDispatchMessageWithValue<TFmxObject>); message PM_GET_RESOURCE_LINK;
    procedure PMGetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_GET_ADJUST_SIZE;
    procedure PMSetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_SET_ADJUST_SIZE;
    procedure PMGetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>); message PM_GET_ADJUST_TYPE;
    procedure PMSetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>); message PM_SET_ADJUST_TYPE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    function ExtractPoint(var Message: TWMMouse): TPoint; override;
    procedure Resized; override;
    /// <summary>Bridge from presentation's GetDefaultStyleLookupName to StyledControl.GetDefaultStyleLookupName</summary>
    function GetDefaultStyleLookupName: string; virtual;
    /// <summary>Bridge from presentation's GetParentClassStyleLookupName to StyledControl.GetParentClassStyleLookupName</summary>
    function GetParentClassStyleLookupName: string; virtual;
    /// <summary>Bridge from presentation's ApplyStyle to StyledControl.ApplyStyle</summary>
    procedure ApplyStyle; virtual;
    /// <summary>Bridge from presentation's FreeStyle to StyledControl.FreeStyle</summary>
    procedure FreeStyle; virtual;
    /// <summary>Bridge from presentation's DoApplyStyleLookup to StyledControl.DoApplyStyleLookup</summary>
    procedure DoApplyStyleLookup; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>Link to root styled control of the scene</summary>
    property StyledControl: TNativeStyledControl read GetStyledControl;
    /// <summary>Link to style of presentation</summary>
    property ResourceLink: TFmxObject read GetResourceLink;
  end;

implementation

uses
  System.Math.Vectors, System.Generics.Collections, FMX.Ani, FMX.Consts, FMX.Presentation.Factory, FMX.Helpers.Win,
  FMX.Utils;

type

{ TViewWindowHandle }

  TViewWindowHandle = class(TWinWindowHandle)
  private
    [Weak] FPresentation: TWinStyledPresentation;
  protected
    function GetTransparency: Boolean; override;
    function GetWndClientSize: TSize; override;
  protected
    constructor Create(const APresentation: TWinStyledPresentation); reintroduce;
    function GetScale: single; override;
  end;

  TOpenControl = class(TControl);
  TOpenStyledControl = class(TStyledControl);

{ TNativeStyledControl }

procedure TNativeStyledControl.AdjustSize;
begin
end;

procedure TNativeStyledControl.ApplyStyle;
begin
  inherited;
  FScene.FPresentation.ApplyStyle;
end;

procedure TNativeStyledControl.FreeStyle;
begin
  FScene.FPresentation.FreeStyle;
  inherited;
end;

function TNativeStyledControl.GetDefaultStyleLookupName: string;
begin
  Result := FScene.FPresentation.GetDefaultStyleLookupName;
end;

{ TViewWindowHandle }

constructor TViewWindowHandle.Create(const APresentation: TWinStyledPresentation);
begin
  FPresentation := APresentation;
  inherited Create(nil, APresentation.Handle);
end;

function TViewWindowHandle.GetScale: single;
begin
  Result := FPresentation.Scale;
end;

function TViewWindowHandle.GetTransparency: Boolean;
begin
  Result := True;
end;

function TViewWindowHandle.GetWndClientSize: TSize;
var
  R: TRect;
begin
  GetWindowRect(Wnd, R);
  Result := R.Size;
end;

{ TNativeScene }

constructor TNativeScene.Create(APresentation: TWinStyledPresentation);
begin
  inherited Create(nil);
  FPresentation := APresentation;
  FHandle := TViewWindowHandle.Create(FPresentation);
  FCanvas := TCanvasManager.CreateFromWindow(FHandle, Round(FPresentation.ControlSize.Width),
    Round(APresentation.ControlSize.Height));
  FBackground := TBitmap.Create;
  FStyledControl := TNativeStyledControl.Create(nil);
  FStyledControl.DisableDisappear := True;
  FStyledControl.FScene := Self;
  FStyledControl.SetNewScene(Self);
  FStyledControl.Parent := Self;
  FStyledControl.Lock;
end;

destructor TNativeScene.Destroy;
begin
  FBackground.Free;
  FCanvas.Free;
  FHandle.Free;
  FStyledControl.Free;
  inherited;
end;

{ TNativeScene.IControl }

procedure TNativeScene.AfterDialogKey(var Key: Word; Shift: TShiftState);
begin
  FStyledControl.AfterDialogKey(Key, Shift);
end;

procedure TNativeScene.BeginAutoDrag;
begin
  FStyledControl.BeginAutoDrag;
end;

procedure TNativeScene.BeginUpdate;
begin
  FStyledControl.BeginUpdate;
end;

function TNativeScene.CheckForAllowFocus: Boolean;
begin
  Result := FStyledControl.CheckForAllowFocus;
end;

procedure TNativeScene.DialogKey(var Key: Word; Shift: TShiftState);
begin
  FStyledControl.DialogKey(Key, Shift);
end;

procedure TNativeScene.DoActivate;
begin
  FStyledControl.DoActivate;
end;

procedure TNativeScene.DoDeactivate;
begin
  FStyledControl.DoDeactivate;
end;

procedure TNativeScene.DoEnter;
begin
  FStyledControl.DoEnter;
end;

procedure TNativeScene.DoExit;
begin
  FStyledControl.DoExit;
end;

procedure TNativeScene.DoMouseEnter;
begin
  FStyledControl.DoMouseEnter;
end;

procedure TNativeScene.DoMouseLeave;
begin
  FStyledControl.DoMouseLeave;
end;

procedure TNativeScene.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  FStyledControl.DragDrop(Data, Point);
end;

procedure TNativeScene.DragEnd;
begin
  FStyledControl.DragEnd;
end;

procedure TNativeScene.DragEnter(const Data: TDragObject; const Point: TPointF);
begin
  FStyledControl.DragEnter(Data, Point);
end;

procedure TNativeScene.DragLeave;
begin
  FStyledControl.DragLeave;
end;

procedure TNativeScene.DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
  FStyledControl.DragOver(Data, Point, Operation);
end;

procedure TNativeScene.EnableUpdating;
begin
  Dec(FDisableUpdating);
  if FDisableUpdating < 0 then
    raise EInvalidSceneUpdatingPairCall.Create(SInvalidSceneUpdatingPairCall);
end;

procedure TNativeScene.EndUpdate;
begin
  FStyledControl.EndUpdate;
end;

function TNativeScene.EnterChildren(AObject: IControl): Boolean;
begin
  Result := FStyledControl.EnterChildren(AObject);
end;

function TNativeScene.ExitChildren(AObject: IControl): Boolean;
begin
  Result := FStyledControl.ExitChildren(AObject);
end;

function TNativeScene.FindTarget(P: TPointF; const Data: TDragObject): IControl;
begin
  Result := FStyledControl.FindTarget(P, Data);
end;

function TNativeScene.GetAbsoluteEnabled: Boolean;
begin
  Result := FStyledControl.AbsoluteEnabled;
end;

function TNativeScene.GetAcceptsControls: Boolean;
begin
  Result := FStyledControl.GetAcceptsControls;
end;

function TNativeScene.GetCanFocus: Boolean;
begin
  Result := FStyledControl.GetCanFocus;
end;

function TNativeScene.GetCanParentFocus: Boolean;
begin
  Result := FStyledControl.GetCanParentFocus;
end;

function TNativeScene.GetCursor: TCursor;
begin
  Result := FStyledControl.Cursor;
end;

function TNativeScene.GetDesignInteractive: Boolean;
begin
  Result := FStyledControl.GetDesignInteractive;
end;

function TNativeScene.GetDragMode: TDragMode;
begin
  Result := FStyledControl.DragMode;
end;

function TNativeScene.GetEnabled: Boolean;
begin
  Result := True;
end;

function TNativeScene.GetHitTest: Boolean;
begin
  Result := True;
end;

function TNativeScene.GetInheritedCursor: TCursor;
begin
  Result := FStyledControl.InheritedCursor;
end;

function TNativeScene.GetIsFocused: boolean;
begin
  Result := FStyledControl.IsFocused;
end;

function TNativeScene.GetLocked: Boolean;
begin
  Result := False;
end;

function TNativeScene.GetObject: TFmxObject;
begin
  Result := Self;
end;

function TNativeScene.GetParent: TFmxObject;
begin
  Result := Parent;
end;

function TNativeScene.GetPopupMenu: TCustomPopupMenu;
begin
  Result := FStyledControl.PopupMenu;
end;

function TNativeScene.GetTabStop: Boolean;
begin
  Result := FStyledControl.TabStop;
end;

function TNativeScene.GetTabStopController: ITabStopController;
begin
  Result := FStyledControl.GetTabStopController;
end;

function TNativeScene.GetVisible: Boolean;
begin
  Result := True;
end;

procedure TNativeScene.KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  FStyledControl.KeyDown(Key, KeyChar, Shift);
end;

procedure TNativeScene.KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  FStyledControl.KeyUp(Key, KeyChar, Shift);
end;

function TNativeScene.LocalToScreen(P: TPointF): TPointF;
var
  LPoint: TPoint;
begin
  LPoint := (P * Handle.Scale).Round;
  Winapi.Windows.ClientToScreen(FPresentation.Handle, LPoint);
  Result := TPointF.Create(LPoint);
end;

function TNativeScene.ScreenToLocal(P: TPointF): TPointF;
var
  LPoint: TPoint;
begin
  LPoint := P.Round;
  Winapi.Windows.ScreenToClient(FPresentation.Handle, LPoint);
  Result := TPointF.Create(LPoint) / Handle.Scale;
end;

procedure TNativeScene.MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
end;

procedure TNativeScene.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
end;

procedure TNativeScene.MouseMove(Shift: TShiftState; X, Y: Single);
begin
end;

procedure TNativeScene.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
end;

procedure TNativeScene.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
end;

function TNativeScene.ObjectAtPoint(P: TPointF): IControl;
begin
  Result := FStyledControl.ObjectAtPoint(P);
  if (Result <> nil) and (Result.GetObject = FStyledControl) then
    Result := nil;
end;

procedure TNativeScene.Repaint;
begin
  InvalidateRect(FPresentation.Handle, nil, True);
end;

procedure TNativeScene.SetAcceptsControls(const Value: Boolean);
begin

end;

procedure TNativeScene.DisableUpdating;
begin
  Inc(FDisableUpdating);
end;

procedure TNativeScene.SetDragMode(const ADragMode: TDragMode);
begin

end;

procedure TNativeScene.SetFocus;
begin

end;

procedure TNativeScene.SetTabStop(const TabStop: Boolean);
begin

end;

function TNativeScene.HasHint: Boolean;
begin
  Result := False;
end;

function TNativeScene.GetHintString: string;
begin
  Result := string.Empty;
end;

function TNativeScene.GetHintObject: TObject;
begin
  Result := nil;
end;

procedure TNativeScene.SetVisible(const Value: Boolean);
begin

end;

function TNativeScene.ShowContextMenu(const ScreenPosition: TPointF): Boolean;
begin
  Result := False;
end;

procedure TNativeScene.Tap(const Point: TPointF);
begin
end;

{ TNativeScene.IScene }

procedure TNativeScene.AddUpdateRect(R: TRectF);
var
  LRect: TRect;
begin
  if not (csDestroying in ComponentState) and (FDisableUpdating = 0) then
  begin
    R := FHandle.FormToWnd(R);
    R := TRectF.Create(R.TopLeft.Truncate, R.BottomRight.Ceiling);
    if IntersectRect(R, TRectF.Create(0, 0, FPresentation.Size.Width, FPresentation.Size.Height)) then
    begin
      LRect := R.Round;
      InvalidateRect(FPresentation.Handle, @LRect, True);
    end;
  end;
end;

procedure TNativeScene.ChangeScrollingState(const AControl: TControl; const Active: Boolean);
begin
end;

function TNativeScene.GetCanvas: TCanvas;
begin
  Result := FCanvas;
end;

function TNativeScene.GetSceneScale: Single;
begin
  Result := FHandle.Scale;
end;

function TNativeScene.GetStyleBook: TStyleBook;
begin
  if (FPresentation.Control <> nil) and (FPresentation.Control.Scene <> nil) then
    Result := FPresentation.Control.Scene.StyleBook
  else
    Result := nil;
end;

function TNativeScene.GetUpdateRect(const Index: Integer): TRectF;
begin
  Result := FUpdateRects[Index];
end;

function TNativeScene.GetUpdateRectsCount: Integer;
begin
  Result := Length(FUpdateRects);
end;

procedure TNativeScene.MergeUpdateRects(const UpdateRects: array of TRectF);
var
  I: Integer;
begin
  if Length(UpdateRects) > 0 then
  begin
    if TCanvasStyle.SupportClipRects in TCanvasManager.DefaultCanvas.GetCanvasStyle then
    begin
      SetLength(FUpdateRects, Length(FUpdateRects) + Length(UpdateRects));
      for I := 0 to Length(UpdateRects) - 1 do
        FUpdateRects[Length(FUpdateRects) - Length(UpdateRects) + I] := UpdateRects[I];
    end
    else
    begin
      SetLength(FUpdateRects, 1);
      FUpdateRects[0] := TRectF.Create(0, 0, FPresentation.ControlSize.Width, FPresentation.ControlSize.Height);
    end;
  end;
end;

{ IPaintControl }

procedure TNativeScene.DrawFMBackground(const ParentHandle: HWnd);
var
  I: Integer;
  Control: TOpenControl;
  ParentObject: TFmxObject;
begin
  ParentObject := FPresentation.WindowToObject(ParentHandle);
  if ParentObject <> nil then
  begin
    with GetParentedPosition(ParentHandle) do
      FBackground.Canvas.Offset := TPointF.Create(-X, -Y);
    try
      if ParentObject.ChildrenCount > 0 then
        for I := 0 to ParentObject.Children.Count - 1 do
          if ParentObject.Children[I] is TControl then
          begin
            Control := TOpenControl(ParentObject.Children[I]);
            if not Control.Visible then
              Continue;
            if Control.Scene = nil then
              Continue;
            if not Control.InPaintTo and Control.UpdateRect.IsEmpty then
              Continue;

            Control.TempCanvas := FBackground.Canvas;
            try
              Control.PaintInternal;
            finally
              Control.TempCanvas := nil;
            end;
          end;
    finally
      FBackground.Canvas.Offset := TPointF.Zero;
    end;
  end;
end;

procedure TNativeScene.DrawNativeBackground(const ParentHandle: HWnd);

  procedure MoveWindowOrg(DC: HDC; DX, DY: Integer);
  var
    P: TPoint;
  begin
    GetWindowOrgEx(DC, P);
    SetWindowOrgEx(DC, P.X - DX, P.Y - DY, nil);
  end;

var
  P: TPoint;
  R: TRect;
  I: Integer;
  Data: TBitmapData;
begin
  GetWindowRect(FPresentation.Handle, R);
  ScreenToClient(ParentHandle, R.TopLeft);
  ScreenToClient(ParentHandle, R.BottomRight);
  P := R.TopLeft;

  MoveWindowOrg(FHandle.BufferHandle, -P.X, -P.Y);

  SendMessage(ParentHandle, WM_ERASEBKGND, FHandle.BufferHandle, 0);
  SendMessage(ParentHandle, WM_PAINT, FHandle.BufferHandle, 0);

  MoveWindowOrg(FHandle.BufferHandle, P.X, P.Y);

  if FBackground.Map(TMapAccess.Write, Data) then
  try
    for I := 0 to Data.Height - 1 do
      Move(PAlphaColorArray(FHandle.BufferBits)[I * Data.Width], Data.GetScanline(I)^, Data.Pitch);
  finally
    FBackground.Unmap(Data);
  end;
end;

procedure TNativeScene.DrawBackground(const Handle: HWnd);
var
  ParentWnd, WorkWnd: HWnd;
begin
  ParentWnd := Winapi.Windows.GetParent(Handle);
  WorkWnd := ParentWnd;
  while not FPresentation.IsParentNative(WorkWnd) do
  begin
    DrawBackground(WorkWnd);
    WorkWnd := Winapi.Windows.GetParent(WorkWnd);
  end;

  if (ParentWnd <> 0) and (ParentWnd <> FPresentation.ContainerHandle) then
  begin
    if FPresentation.IsParentNative(ParentWnd) then
      DrawNativeBackground(ParentWnd)
    else
      DrawFMBackground(ParentWnd);
  end;
end;

procedure TNativeScene.PaintRects(const UpdateRects: array of TRectF);
var
  I, J: Integer;
  R: TRectF;
  AllowPaint: Boolean;
  Control: TOpenControl;
begin
  MergeUpdateRects(UpdateRects);
  if Length(FUpdateRects) > 0 then
  begin
    if FBackground.Canvas.BeginScene then
    try
      DrawBackground(FPresentation.Handle);
    finally
      FBackground.Canvas.EndScene;
    end;

    if FCanvas.BeginScene(@FUpdateRects, FContextHandle) then
    try
      FCanvas.Clear(0);
      FCanvas.DrawBitmap(FBackground, TRectF.Create(0, 0, FBackground.Width, FBackground.Height),
        TRectF.Create(0, 0, FBackground.Width / Handle.Scale, FBackground.Height / Handle.Scale), 1, True);

      if ChildrenCount > 0 then
        for I := 0 to Children.Count - 1 do
          if (Children[I] is TControl) then
          begin
            Control := TOpenControl(Children[I]);
            if not Control.Visible then
              Continue;
            if Control.Scene = nil then
              Continue;
            if not Control.InPaintTo and Control.UpdateRect.IsEmpty then
              Continue;

            AllowPaint := False;
            if Control.InPaintTo then
              AllowPaint := True;
            if not AllowPaint then
            begin
              R := UnionRect(Control.ChildrenRect, Control.UpdateRect);
              for J := 0 to Length(FUpdateRects) - 1 do
                if IntersectRect(FUpdateRects[J], R) then
                begin
                  AllowPaint := True;
                  Break;
                end;
            end;

            if AllowPaint then
              Control.PaintInternal;
          end;
    finally
      FCanvas.EndScene;
    end;
    SetLength(FUpdateRects, 0);
  end;
end;

function TNativeScene.GetParentedPosition(const ParentHandle: HWnd): TPointF;
var
  P: TPoint;
begin
  P := TPoint.Zero;
  Winapi.Windows.ClientToScreen(FPresentation.Handle, P);
  Winapi.Windows.ScreenToClient(ParentHandle, P);
  Result := TPointF.Create(P) / Handle.Scale;
end;

function TNativeScene.GetContextHandle: THandle;
begin
  Result := FContextHandle;
end;

procedure TNativeScene.SetContextHandle(const AContextHandle: THandle);
begin
  FContextHandle := AContextHandle;
end;

procedure TNativeScene.SetSize(const ASize: TSizeF);
begin
  if not (SameValue(ASize.Width, 0, TEpsilon.Position) or SameValue(ASize.Height, 0, TEpsilon.Position)) then
  begin
    FCanvas.SetSize(Trunc(ASize.Width), Trunc(ASize.Height));
    FBackground.SetSize(FCanvas.Width, FCanvas.Height);
    FBackground.BitmapScale := Handle.Scale;
    FHandle.ResizeBuffer(FCanvas.Width, FCanvas.Height);
    FStyledControl.SetBounds(0, 0, ASize.Width / Handle.Scale, ASize.Height / Handle.Scale);
  end;
end;

procedure TNativeScene.SetStyleBook(const Value: TStyleBook);
begin
end;

{ TWinStyledPresentation }

constructor TWinStyledPresentation.Create(AOwner: TComponent);
begin
  inherited;
  if AtomString.IsEmpty then
  begin
    AtomString := Format('STYLEY%.8X', [GetCurrentProcessID]);
    Atom := GlobalAddAtomW(PChar(AtomString));
  end;
  SetProp(Handle, MakeIntAtom(Atom), THandle(Self));
  FNativeScene := TNativeScene.Create(Self);
  if Control <> nil then
    Control.InsertObject(0, FNativeScene);
end;

destructor TWinStyledPresentation.Destroy;
begin
  FNativeScene.Free;
  inherited;
end;

procedure TWinStyledPresentation.DoApplyStyleLookup;
begin
  FNativeScene.StyledControl.DoApplyStyleLookup;
end;

function TWinStyledPresentation.ExtractPoint(var Message: TWMMouse): TPoint;
begin
  Result := TPoint.Create(Message.XPos, Message.YPos);
  ClientToScreen(Handle, Result);
  if Form <> nil then
  begin
    ScreenToClient(WindowHandleToPlatform(Form.Handle).Wnd, Result);
    Result := TPointF.Create(Result.X / FNativeScene.Handle.Scale, Result.Y / FNativeScene.Handle.Scale).Round;
  end;
end;

procedure TWinStyledPresentation.ApplyStyle;
begin
  if HasControl then
    TOpenStyledControl(Control).ApplyStyle;
end;

procedure TWinStyledPresentation.FreeStyle;
begin
  if HasControl then
    TOpenStyledControl(Control).FreeStyle;
end;

function TWinStyledPresentation.GetDefaultStyleLookupName: string;
begin
  Result := TStyledControl(Control).DefaultStyleLookupName;
end;

function TWinStyledPresentation.GetParentClassStyleLookupName: string;
begin
  Result := TStyledControl(Control).ParentClassStyleLookupName;
end;

function TWinStyledPresentation.GetResourceLink: TFmxObject;
begin
  if StyledControl <> nil then
    Result := StyledControl.ResourceLink
  else
    Result := nil;
end;

procedure TWinStyledPresentation.PMApplyStyleLookup(var AMessage: TDispatchMessage);
begin
  inherited;
  DoApplyStyleLookup;
end;

procedure TWinStyledPresentation.PMFindStyleResource(var AMessage: TDispatchMessageWithValue<TFindStyleResourceInfo>);
begin
  inherited;
  AMessage.Value.Resource := FNativeScene.FStyledControl.FindStyleResource(AMessage.Value.ResourceName, AMessage.Value.Clone);
end;

procedure TWinStyledPresentation.PMNeedStyleLookup(var AMessage: TDispatchMessage);
begin
  inherited;
  FNativeScene.StyledControl.NeedStyleLookup;
end;

procedure TWinStyledPresentation.PMObjectAtPoint(var AMessage: TDispatchMessageWithValue<TObjectAtPointInfo>);
begin
  inherited;
  AMessage.Value.Control := FNativeScene.ObjectAtPoint(AMessage.Value.Point);
end;

procedure TWinStyledPresentation.PMSetStyleLookup(var AMessage: TDispatchMessageWithValue<string>);
begin
  inherited;
  FNativeScene.StyledControl.StyleLookup := AMessage.Value;
end;

procedure TWinStyledPresentation.PMApplyTriggerEffect(var AMessage: TDispatchMessageWithValue<TTriggerInfo>);
begin
  FNativeScene.StyledControl.ApplyTriggerEffect(AMessage.Value.Instance, AMessage.Value.Trigger);
end;

procedure TWinStyledPresentation.PMStartTriggerAnimation(var AMessage: TDispatchMessageWithValue<TTriggerInfo>);
begin
  if AMessage.Value.Wait then
    FNativeScene.StyledControl.StartTriggerAnimationWait(AMessage.Value.Instance, AMessage.Value.Trigger)
  else
    FNativeScene.StyledControl.StartTriggerAnimation(AMessage.Value.Instance, AMessage.Value.Trigger);
end;

procedure TWinStyledPresentation.Resized;
begin
  inherited;
  if FNativeScene <> nil then
    FNativeScene.SetSize(Size);
end;

procedure TWinStyledPresentation.PMRealign(var AMessage: TDispatchMessage);
begin
  inherited;
  FNativeScene.StyledControl.Realign;
end;

procedure TWinStyledPresentation.PMSetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
  FNativeScene.StyledControl.SetAdjustSizeValue(AMessage.Value);
end;

procedure TWinStyledPresentation.PMSetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>);
begin
  FNativeScene.StyledControl.SetAdjustType(AMessage.Value);
end;

function TWinStyledPresentation.GetStyledControl: TNativeStyledControl;
begin
  Result := FNativeScene.StyledControl;
end;

class function TWinStyledPresentation.IsParentNative(const Handle: HWnd): Boolean;
begin
  Result := (GetProp(Handle, MakeIntAtom(Atom)) = 0) and (FindWindow(Handle) = nil);
end;

procedure TWinStyledPresentation.PMGetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
  AMessage.Value := FNativeScene.StyledControl.AdjustSizeValue;
end;

procedure TWinStyledPresentation.PMGetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>);
begin
  AMessage.Value := FNativeScene.StyledControl.AdjustType;
end;

procedure TWinStyledPresentation.PMGetRecommendSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
end;

procedure TWinStyledPresentation.PMGetResourceLink(var AMessage: TDispatchMessageWithValue<TFmxObject>);
begin
  AMessage.Value := FNativeScene.StyledControl.ResourceLink;
end;

class function TWinStyledPresentation.WindowToObject(Handle: HWND): TFmxObject;
begin
  Result := FindWindow(Handle);
  if (Result = nil) and (GetProp(Handle, MakeIntAtom(Atom)) <> 0) then
    Result := TWinStyledPresentation(GetProp(Handle, MakeIntAtom(Atom))).Control;
end;

procedure TWinStyledPresentation.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TWinStyledPresentation.WMPaint(var Message: TWMPaint);
var
  I, RgnStatus: Integer;
  Region: HRgn;
  RegionSize: Integer;
  RegionData: PRgnData;
  R: TRect;
  UpdateRects: TUpdateRects;
  PS: TPaintStruct;
  PaintControl: IPaintControl;
begin
  Winapi.Windows.GetUpdateRect(Handle, R, False);
  Region := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
  if Region <> 0 then
  try
    RgnStatus := GetUpdateRgn(Handle, Region, False);
    if (RgnStatus = 2) or (RgnStatus = 3) then
    begin
      RegionSize := GetRegionData(Region, $FFFF, nil);
      if RegionSize > 0 then
      begin
        GetMem(RegionData, RegionSize);
        try
          GetRegionData(Region, RegionSize, RegionData);
          SetLength(UpdateRects, RegionData.rdh.nCount);
          for I := 0 to RegionData.rdh.nCount - 1 do
          begin
            R := PRgnRects(@RegionData.buffer[0])[I];
            UpdateRects[I] := FNativeScene.Handle.WndToForm(TRectF.Create(R.Left, R.Top, R.Right, R.Bottom));
          end;
        finally
          FreeMem(RegionData, RegionSize);
        end;
        if Supports(FNativeScene, IPaintControl, PaintControl) then
        begin
          PaintControl.ContextHandle := BeginPaint(Handle, PS);
          try
            PaintControl.PaintRects(UpdateRects);
            BitBlt(PS.hdc, 0, 0, Size.Width, Size.Height, WindowHandleToPlatform(FNativeScene.FHandle).BufferHandle,
              0, 0, SRCCOPY);
            PaintControl.ContextHandle := 0;
          finally
            EndPaint(Handle, PS);
          end;
        end;
      end;
    end;
  finally
    DeleteObject(Region);
  end;
  inherited;
end;

initialization
  TPresentationProxyFactory.Current.Register('default-native', TWinPresentationProxy<TWinStyledPresentation>);
finalization
  TPresentationProxyFactory.Current.Unregister('default-native', TWinPresentationProxy<TWinStyledPresentation>);
end.
