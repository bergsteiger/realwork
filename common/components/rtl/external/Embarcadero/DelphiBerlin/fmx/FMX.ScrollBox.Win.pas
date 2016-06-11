{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ScrollBox.Win;

interface

uses
  System.Types, System.Classes, Winapi.Messages, Winapi.Windows, FMX.Presentation.Win, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Presentation.Messages, FMX.StdActns, FMX.Controls.Model, FMX.Controls.Win;

type

{ TWinScrollBox }

  TWinScrollBox = class(TWinPresentation)
  protected type
    /// <summary>Structure for temporary storing a old and new position of Viewport. It's used for passing these values
    /// in event OnViewportPositionChanged.</summary>
    TViewportSaveState = record
      OldPosition: TPointF;
      NewPosition: TPointF;
      ContentSizeChanged: Boolean;
    end;
  public const
    SmallIncrement = 20;
    LargeIncrement = 30;
  private
    [Weak] FModel: TCustomScrollBoxModel;
    [Weak] FContent: TScrollContent;
    FHScrollBarInfo: TValueRange;
    FVScrollBarInfo: TValueRange;
    FChanging: Integer;
    FNeedCallViewPortPositionChanged: Boolean;
    FSavedState: TViewportSaveState;
    function GetViewPortSize: TSizeF;
    procedure ScrollBarsChanged(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    { Works with native scroll bars }
    /// <summary>Updates range of native scroll bars (Horizontal and vertical)</summary>
    procedure UpdateScrollBarsRange; virtual;
    /// <summary>Updates visible of native scroll bars</summary>
    procedure UpdateScrollBarsVisibile; virtual;
    /// <summary>Updates position of native scroll bars</summary>
    procedure UpdateScrollBarsPosition; virtual;
    /// <summary>Updates page size of native scroll bars</summary>
    procedure UpdateScrollBarsPageSize; virtual;
    /// <summary>Updates enable of native scroll bars</summary>
    procedure UpdateScrollBarsEnabled; virtual;
    /// <summary>Specified required model class of <c>TPresentedScrollBox</c></summary>
    function DefineModelClass: TDataModelClass; override;

    { Messages from Model }
    /// <summary>Notification about changing visibility of Scroll Bars <c>TCustomScrollBoxModel.ShowScrollBar</c>
    /// from PresentedControl</summary>
    procedure MMShowScrollBarChanged(var AMessage: TDispatchMessageWithValue<Boolean>); message MM_SHOW_SCROLLBAR_CHANGED;
    /// <summary>Notification about need to set new content size from PresentedControl</summary>
    procedure MMSetContentBounds(var AMessage: TDispatchMessageWithValue<TRectF>); message MM_SET_CONTENT_BOUNDS;
    /// <summary>Notification about changes of scroll direction in Model.ScrollDirection</summary>
    procedure MMScrollDirectionChanged(var AMessage: TDispatchMessageWithValue<TScrollDirections>); message MM_SCROLL_DIRECTIONS_CHANGED;
    /// <summary>Notification about changing <c>TCustomScrollBoxModel.EnabledScroll</c> from PresentedControl</summary>
    procedure MMEnabledScrollChanged(var AMessage: TDispatchMessageWithValue<Boolean>); message MM_ENABLED_SCROLL_CHANGED;

    { Messages from PresentationProxy }
    /// <summary>Notification about initialization of presentation</summary>
    procedure PMInit(var AMessage: TDispatchMessage); message PM_INIT;
    /// <summary>Settings scontent (<c>TScrollContent</c>) of TScrollBox</summary>
    procedure PMSetContent(var AMessage: TDispatchMessageWithValue<TScrollContent>); message PM_SET_CONTENT;
    /// <summary>Notification about need to scroll viewport to specified rect</summary>
    procedure PMScrollInRect(var AMessage: TDispatchMessageWithValue<TCustomScrollBoxModel.TInViewRectInfo>); message PM_SCROLL_IN_RECT;
    /// <summary>Notification about need to scroll viewport by specified vector</summary>
    procedure PMScrollBy(var AMessage: TDispatchMessageWithValue<TCustomScrollBoxModel.TScrollByInfo>); message PM_SCROLL_BY;
    /// <summary>Notification about need to set new viewport position</summary>
    procedure PMSetViewPortPosition(var AMessage: TDispatchMessageWithValue<TPointF>); message MM_SET_VIEWPORT_POSITION;
    /// <summary>Getter of viewport position from presentation (native control)</summary>
    procedure PMGetViewPortPosition(var AMessage: TDispatchMessageWithValue<TPointF>); message MM_GET_VIEWPORT_POSITION;
    /// <summary>Getter of viewport size from presentation (native control)</summary>
    procedure PMGetViewPortSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message MM_GET_VIEWPORT_SIZE;

    { Messages from OS Windows }
    /// <summary>Notifies about changing of ScrollBar size</summary>
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    /// <summary>Notifies about scrolling of horizontal scroll bar</summary>
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    /// <summary>Notifies about scrolling of vertical scroll bar</summary>
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    /// <summary>Notifies about scrolling mouse wheel</summary>
    procedure WMMouseWheel(var Message: TWMMouseWheel) ; message WM_MOUSEWHEEL;

    { Scrolling }
    /// <summary>Process winapi messages about scrolling. Calculates new position of scroll bars</summary>
    procedure DoScroll(const Message: TWMScroll; var AScrollValueRange: TValueRange); virtual;
    /// <summary>Ivokes <c>Model.OnViewportPositionChange</c></summary>
    procedure DoViewportPositionChanged(const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean); virtual;
    /// <summary>Should invoke <c>Model.OnViewportPositionChange</c>, when changing of viewport position will
    /// finished</summary>
    property NeedCallViewPortPositionChanged: Boolean read FNeedCallViewPortPositionChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>Starts changing viewport position of ScrollBars. It's used for avoiding multiple invoking of
    /// events</summary>
    procedure BeginChanging;
    /// <summary>Ends changing viewport position of ScrollBars. It's used for avoiding multiple invoking of
    /// events</summary>
    procedure EndChanging;
    /// <summary>Are we changing viewport position of ScrollBars. It's used for avoiding multiple invoking of
    /// events</summary>
    function IsChanging: Boolean;
  public
    /// <summary>Content of <c>TScrollBox</c>. Content can be nil</summary>
    property Content: TScrollContent read FContent write FContent;
    /// <summary>Model of <c>TScrollBox</c></summary>
    property Model: TCustomScrollBoxModel read FModel;
    /// <summary>Returns client size of native scroll box without scroll bars</summary>
    property ViewPortSize: TSizeF read GetViewPortSize;
    /// <summary>Access to information about horizontal scroll bar</summary>
    property HScrollBarInfo: TValueRange read FHScrollBarInfo;
    /// <summary>Access to information about vertical scroll bar</summary>
    property VScrollBarInfo: TValueRange read FVScrollBarInfo;
  end;

implementation

uses
  System.SysUtils, System.UITypes, System.Math.Vectors, System.Math, FMX.Presentation.Factory, FMX.Controls, FMX.Consts;

{ TWinScrollBox }

procedure TWinScrollBox.BeginChanging;
begin
  Inc(FChanging);
end;

constructor TWinScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  FModel := TCustomScrollBoxModel(inherited Model);
  FChanging := 0;
  FNeedCallViewPortPositionChanged := False;
  FSavedState.OldPosition := TPointF.Zero;
  FSavedState.NewPosition := TPointF.Zero;
  FSavedState.ContentSizeChanged := False;
  FHScrollBarInfo := TValueRange.Create(Self);
  FHScrollBarInfo.Increment := SmallIncrement;
  FHScrollBarInfo.OnChanged := ScrollBarsChanged;
  FVScrollBarInfo := TValueRange.Create(Self);
  FVScrollBarInfo.Increment := SmallIncrement;
  FVScrollBarInfo.OnChanged := ScrollBarsChanged;
end;

procedure TWinScrollBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WindowClass.hbrBackground := GetStockObject(WHITE_BRUSH);
end;

function TWinScrollBox.DefineModelClass: TDataModelClass;
begin
  Result := TCustomScrollBoxModel;
end;

destructor TWinScrollBox.Destroy;
begin
  FHScrollBarInfo.Free;
  FVScrollBarInfo.Free;
  inherited;
end;

procedure TWinScrollBox.DoScroll(const Message: TWMScroll; var AScrollValueRange: TValueRange);

  function IsHorizontalScrollBar: Boolean;
  begin
    Result := AScrollValueRange = FHScrollBarInfo;
  end;

  function GetScrollTrackPos: Integer;
  var
    BarFlag: Integer;
    ScrollInfo: TScrollInfo;
  begin
    FillChar(ScrollInfo, SizeOf(TScrollInfo), 0);
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.fMask := SIF_ALL;
    if IsHorizontalScrollBar then
      BarFlag := SB_HORZ
    else
      BarFlag := SB_VERT;
    if GetScrollInfo(Handle, BarFlag, ScrollInfo) then
      Result := ScrollInfo.nTrackPos
    else
      Result := Round(AScrollValueRange.Value);
  end;

begin
  if not Model.EnabledScroll then
    Exit;

  with Message do
  begin
    case TScrollCode(ScrollCode) of
      TScrollCode.scLineUp:
        AScrollValueRange.Dec;
      TScrollCode.scLineDown:
        AScrollValueRange.Inc;
      TScrollCode.scPageUp:
        AScrollValueRange.Value := AScrollValueRange.Value - LargeIncrement;
      TScrollCode.scPageDown:
        AScrollValueRange.Value := AScrollValueRange.Value + LargeIncrement;
      TScrollCode.scPosition, TScrollCode.scTrack:
        AScrollValueRange.Value := GetScrollTrackPos;
      TScrollCode.scTop:
        AScrollValueRange.Value := AScrollValueRange.Min;
      TScrollCode.scBottom:
        AScrollValueRange.Value := AScrollValueRange.Max;
    end;
  end;
end;

procedure TWinScrollBox.DoViewportPositionChanged(const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
  Model.DoViewportPositionChange(OldViewportPosition, NewViewportPosition, ContentSizeChanged);
end;

procedure TWinScrollBox.EndChanging;
begin
  if FChanging > 0 then
    Dec(FChanging);

  if not IsChanging and FNeedCallViewPortPositionChanged then
  begin
    FNeedCallViewPortPositionChanged := False;
    DoViewportPositionChanged(FSavedState.OldPosition, FSavedState.NewPosition, FSavedState.ContentSizeChanged);
  end;
end;

function TWinScrollBox.GetViewPortSize: TSizeF;
var
  ClientRect: TRect;
begin
  if GetClientRect(Handle, ClientRect) then
    Result := TSizeF.Create(ClientRect.Size)
  else
    Result := TSizeF.Create(0, 0);
end;

function TWinScrollBox.IsChanging: Boolean;
begin
  Result := FChanging > 0;
end;

procedure TWinScrollBox.MMEnabledScrollChanged(var AMessage: TDispatchMessageWithValue<Boolean>);
begin
  UpdateScrollBarsEnabled;
end;

procedure TWinScrollBox.MMScrollDirectionChanged(var AMessage: TDispatchMessageWithValue<TScrollDirections>);
begin
  UpdateScrollBarsVisibile;
end;

procedure TWinScrollBox.MMSetContentBounds(var AMessage: TDispatchMessageWithValue<TRectF>);
begin
  BeginChanging;
  try
    FHScrollBarInfo.Max := AMessage.Value.Width;
    FVScrollBarInfo.Max := AMessage.Value.Height;
  finally
    EndChanging;
  end;
  UpdateScrollBarsVisibile;
end;

procedure TWinScrollBox.MMShowScrollBarChanged(var AMessage: TDispatchMessageWithValue<Boolean>);
begin
  UpdateScrollBarsVisibile;
end;

procedure TWinScrollBox.PMGetViewPortPosition(var AMessage: TDispatchMessageWithValue<TPointF>);
begin
  AMessage.Value := TPointF.Create(FHScrollBarInfo.Value, FVScrollBarInfo.Value);
end;

procedure TWinScrollBox.PMGetViewPortSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
  AMessage.Value := ViewPortSize;
end;

procedure TWinScrollBox.PMInit(var AMessage: TDispatchMessage);
begin
  inherited;
  BeginChanging;
  try
    FHScrollBarInfo.Max := Model.ContentSize.Width;
    FVScrollBarInfo.Max := Model.ContentSize.Height;
    UpdateScrollBarsRange;
    UpdateScrollBarsVisibile;
    UpdateScrollBarsPosition;
    UpdateScrollBarsPageSize;
    UpdateScrollBarsEnabled;
  finally
    EndChanging;
  end;
end;

procedure TWinScrollBox.PMScrollBy(var AMessage: TDispatchMessageWithValue<TCustomScrollBoxModel.TScrollByInfo>);
begin
  BeginChanging;
  try
    FHScrollBarInfo.Value := FHScrollBarInfo.Value + AMessage.Value.Vector.X;
    FVScrollBarInfo.Value := FVScrollBarInfo.Value + AMessage.Value.Vector.Y;
  finally
    EndChanging;
  end;
end;

procedure TWinScrollBox.PMScrollInRect(var AMessage: TDispatchMessageWithValue<TCustomScrollBoxModel.TInViewRectInfo>);
var
  NewViewportRect: TRectF;
begin
  NewViewportRect := NormalizeInViewRect(TRectF.Create(TPointF.Zero, Model.ContentSize.Size), ViewPortSize,
    AMessage.Value.Rect);

  BeginChanging;
  try
    FHScrollBarInfo.Value := NewViewportRect.Left;
    FVScrollBarInfo.Value := NewViewportRect.Top;
  finally
    EndChanging;
  end;
end;

procedure TWinScrollBox.PMSetContent(var AMessage: TDispatchMessageWithValue<TScrollContent>);
begin
  if AMessage.Value = nil then
    raise EArgumentException.Create(SContentCannotBeNil);
  FContent := AMessage.Value;
end;

procedure TWinScrollBox.PMSetViewPortPosition(var AMessage: TDispatchMessageWithValue<TPointF>);
begin
  BeginChanging;
  try
    FHScrollBarInfo.Value := AMessage.Value.X;
    FVScrollBarInfo.Value := AMessage.Value.Y;
  finally
    EndChanging;
  end;
end;

procedure TWinScrollBox.ScrollBarsChanged(Sender: TObject);

  procedure UpdateContentPosition;
  begin
    if Content <> nil then
      Content.Position.Point := -TPointF.Create(FHScrollBarInfo.Value, FVScrollBarInfo.Value);
  end;

  function ExtractContentPos: TPointF;
  begin
    if Content <> nil then
      Result := -Content.Position.Point
    else
      Result := TPointF.Create(FHScrollBarInfo.Value, FVScrollBarInfo.Value);
  end;

var
  OldContentPos: TPointF;
  NewContentPos: TPointF;
begin
  OldContentPos := ExtractContentPos;

  UpdateContentPosition;
  UpdateScrollBarsRange;
  UpdateScrollBarsPosition;

  NewContentPos := TPointF.Create(FHScrollBarInfo.Value, FVScrollBarInfo.Value);
  if OldContentPos <> NewContentPos then
    if IsChanging then
    begin
      FSavedState.OldPosition := OldContentPos;
      FSavedState.NewPosition := NewContentPos;
      FSavedState.ContentSizeChanged := False;
      FNeedCallViewPortPositionChanged := True;
    end
    else
      DoViewportPositionChanged(-OldContentPos,  NewContentPos, False)
end;

procedure TWinScrollBox.UpdateScrollBarsEnabled;
begin
  if Model.EnabledScroll then
    EnableScrollBar(Handle, SB_BOTH, ESB_ENABLE_BOTH)
  else
    EnableScrollBar(Handle, SB_BOTH, ESB_DISABLE_BOTH);
end;

procedure TWinScrollBox.UpdateScrollBarsPageSize;
var
  ScrollInfo: TScrollInfo;
begin
  FHScrollBarInfo.ViewportSize := ViewPortSize.Width;
  FVScrollBarInfo.ViewportSize := ViewPortSize.Height;

  FillChar(ScrollInfo, SizeOf(TScrollInfo), 0);
  ScrollInfo.fMask := SIF_PAGE;

  ScrollInfo.nPage := Round(ViewPortSize.Width);
  SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);

  ScrollInfo.nPage := Round(ViewPortSize.Height);
  SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
end;

procedure TWinScrollBox.UpdateScrollBarsPosition;
begin
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);

  SetScrollPos(Handle, SB_HORZ, Round(FHScrollBarInfo.Value), True);
  SetScrollPos(Handle, SB_VERT, Round(FVScrollBarInfo.Value), True);
end;

procedure TWinScrollBox.UpdateScrollBarsRange;
begin
  SetScrollRange(Handle, SB_VERT, Round(FVScrollBarInfo.Min), Round(FVScrollBarInfo.Max), False);
  SetScrollRange(Handle, SB_HORZ, Round(FHScrollBarInfo.Min), Round(FHScrollBarInfo.Max), False);
end;

procedure TWinScrollBox.UpdateScrollBarsVisibile;
var
  ContentSizeTmp: TSizeF;
  ViewPortSizeTmp: TSizeF;
  VertVisible: Boolean;
  HorzVisible: Boolean;
  WindowStyle: NativeInt;
begin
  ContentSizeTmp := Model.ContentSize.Size;
  ViewPortSizeTmp := ViewPortSize;

  if (ContentSizeTmp.Width > ViewPortSizeTmp.Width) and (ContentSizeTmp.Height > ViewPortSizeTmp.Height) then
  begin
    VertVisible := True;
    HorzVisible := True;
  end
  else if (ContentSizeTmp.Width > ViewPortSizeTmp.Width) and (ContentSizeTmp.Height <= ViewPortSizeTmp.Height) then
  begin
    VertVisible := False;
    HorzVisible := True;
  end
  else if (ContentSizeTmp.Width <= ViewPortSizeTmp.Width) and (ContentSizeTmp.Height > ViewPortSizeTmp.Height) then
  begin
    VertVisible := True;
    HorzVisible := False;
  end
  else
  begin
    VertVisible := False;
    HorzVisible := False;
  end;

  HorzVisible := HorzVisible and (Model.ScrollDirections in [TScrollDirections.Both, TScrollDirections.Horizontal])
    and Model.ShowScrollBars;
  VertVisible := VertVisible and (Model.ScrollDirections in [TScrollDirections.Both, TScrollDirections.Vertical])
    and Model.ShowScrollBars;
  WindowStyle := GetWindowLong(Handle, GWL_STYLE);
  if (WindowStyle and WS_VSCROLL <> 0) <> VertVisible then
    ShowScrollBar(Handle, SB_VERT, VertVisible);
  if (WindowStyle and WS_HSCROLL <> 0) <> HorzVisible then
    ShowScrollBar(Handle, SB_HORZ, HorzVisible);
end;

procedure TWinScrollBox.WMHScroll(var Message: TWMHScroll);
begin
  DoScroll(Message, FHScrollBarInfo);
end;

procedure TWinScrollBox.WMMouseWheel(var Message: TWMMouseWheel);

  function ShiftPressed: Boolean;
  begin
    Result := (GetAsyncKeyState(VK_LSHIFT) <> 0) or (GetAsyncKeyState(VK_RSHIFT) <> 0);
  end;

  function CanScroll: Boolean;
  begin
    Result := (not ShiftPressed and (Model.ScrollDirections in [TScrollDirections.Both, TScrollDirections.Vertical])) or
      ShiftPressed and (Model.ScrollDirections in [TScrollDirections.Both, TScrollDirections.Horizontal])
  end;

var
  ScrollBarValueRange: TValueRange;
begin
  if Model.DisableMouseWheel or not Model.EnabledScroll then
    Exit;

  if ShiftPressed then
    ScrollBarValueRange := FHScrollBarInfo
  else
    ScrollBarValueRange := FVScrollBarInfo;

  if CanScroll then
    if Message.WheelDelta > 0 then
      ScrollBarValueRange.Dec
    else
      ScrollBarValueRange.Inc;
end;

procedure TWinScrollBox.WMVScroll(var Message: TWMVScroll);
begin
  DoScroll(Message, FVScrollBarInfo);
end;

procedure TWinScrollBox.WMSize(var Message: TWMSize);
begin
  UpdateScrollBarsRange;
  UpdateScrollBarsVisibile;
  UpdateScrollBarsPageSize;
end;

initialization
  TPresentationProxyFactory.Current.Register(TPresentedScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedHorzScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedVertScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedFramedScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedFramedVertScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
finalization
  TPresentationProxyFactory.Current.Unregister(TPresentedScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedHorzScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedVertScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedFramedScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedFramedVertScrollBox, TControlType.Platform, TWinPresentationProxy<TWinScrollBox>);
end.
