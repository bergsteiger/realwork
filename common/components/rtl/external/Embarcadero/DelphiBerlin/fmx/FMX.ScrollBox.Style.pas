{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ScrollBox.Style;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.Generics.Collections, System.UITypes, FMX.Types, FMX.Ani, FMX.StdCtrls,
  FMX.Platform, FMX.Controls, FMX.Graphics, FMX.InertialMovement, System.Math.Vectors, FMX.ScrollBox,
  FMX.Presentation.Messages, FMX.Presentation.Style, FMX.Controls.Presentation, FMX.BehaviorManager;

type
  TStyledCustomScrollBox = class;

  ///<summary>Extends <c>TAniCalculations</c> to cooperate with TScrollBox and scrolling features</summary>
  TScrollCalculations = class(TAniCalculations)
  private
    [Weak] FScrollBox: TStyledCustomScrollBox;
  protected
    procedure DoChanged; override;
    procedure DoStart; override;
    procedure DoStop; override;
  public
    constructor Create(AOwner: TPersistent); override;
    ///<summary>Link to the presentation that connected with this movements controller</summary>
    property ScrollBox: TStyledCustomScrollBox read FScrollBox;
  end;

  ///<summary>Styled presentation for <c>TScrollBox</c></summary>
  TStyledCustomScrollBox = class(TStyledPresentation)
  private const
    SmallChangeFraction = 5;
    DesignBorderColor: TAlphaColor = $80A070A0;
  private type
    TScrollInfo = record
      [Weak] Scroll: TScrollBar;
      Align: TAlignLayout;
      Margins: TRectF;
    end;
  private
    FSystemInfoSrv: IFMXSystemInformationService;
    FContent: TScrollContent;
    FLastViewportPosition: TPointF;
    FInInternalAlign: Boolean;
    FCachedContentSize: TSizeF;
    FOriginalContentLayoutSize: TSizeF;
    FHScrollInfo: TScrollInfo;
    FVScrollInfo: TScrollInfo;
    FContentMargins: TRectF;
    FVDisablePaint: Boolean;
    FHDisablePaint: Boolean;
    FGDisablePaint: Boolean;
    FMouseEvents: Boolean;
    FContentCalculated: Boolean;
    FAniCalculations: TScrollCalculations;
    FBackground: TControl;
    FContentLayout: TControl;
    FSizeGripContent: TControl;
    FSizeGripParent: TControl;
    FSizeGrip: TControl;
    function GetScrollingBehaviours: TScrollingBehaviours;
    procedure SetViewportPosition(const Value: TPointF);
    function GetViewportPosition: TPointF;
    function GetHScrollAlign: TAlignLayout;
    function GetVScrollAlign: TAlignLayout;
    function GetHScrollMargins: TRectF;
    function GetVScrollMargins: TRectF;
    function GetSceneScale: Single;
    function GetVScrollBar: TScrollBar;
    function GetHScrollBar: TScrollBar;
    function GetModel: TCustomScrollBoxModel;
    procedure UpdateSizeGrip;
    procedure UpdateVScrollBar(const Value: Single; const ViewportSize: Single);
    procedure UpdateHScrollBar(const Value: Single; const ViewportSize: Single);
    procedure InternalAlign;
    procedure HScrollChangeProc(Sender: TObject);
    procedure VScrollChangeProc(Sender: TObject);
    procedure MousePosToAni(var X, Y: Single);
    procedure SaveDisablePaint;
    procedure RestoreDisablePaint;
    procedure SetDisablePaint;
    procedure StartScrolling;
    procedure StopScrolling;
    procedure UpdateOriginalContentLayoutSize(const Force: Boolean);
    procedure UpdateAutoHide;
    procedure UpdateBounces;
    procedure UpdateTouchTracking;
    procedure UpdateScrollAnimation;
    procedure UpdateScrollBarsEnabled;
    { Messages from model }
    procedure MMAutoHideChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>); message MM_AUTOHIDE_CHANGED;
    procedure MMBouncesChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>); message MM_BOUNCES_CHANGED;
    procedure MMEnabledScrollChanged(var Message: TDispatchMessageWithValue<Boolean>); message MM_ENABLED_SCROLL_CHANGED;
    procedure MMShowScrollBarsChanged(var Message: TDispatchMessageWithValue<Boolean>); message MM_SHOW_SCROLLBAR_CHANGED;
    procedure MMShowSizeGripChanged(var Message: TDispatchMessageWithValue<Boolean>); message MM_SHOW_SIZE_GRIP_CHANGED;
    procedure MMGetViewportPosition(var Message: TDispatchMessageWithValue<TPointF>); message MM_GET_VIEWPORT_POSITION;
    procedure MMSetViewportPosition(var Message: TDispatchMessageWithValue<TPointF>); message MM_SET_VIEWPORT_POSITION;
    procedure MMGetViewportSize(var Message: TDispatchMessageWithValue<TSizeF>); message MM_GET_VIEWPORT_SIZE;
    procedure MMScrollAnimationChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>); message MM_SCROLL_ANIMATION_CHANGED;
    procedure MMScrollDirectionsChanged(var Message: TDispatchMessageWithValue<TScrollDirections>); message MM_SCROLL_DIRECTIONS_CHANGED;
    procedure MMSetContentBounds(var Message: TDispatchMessageWithValue<TRectF>); message MM_SET_CONTENT_BOUNDS;
    procedure MMTouchTrackingChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>); message MM_TOUCH_TRACKING_CHANGED;
    { Messages from presented control }
    procedure PMScrollBy(var Message: TDispatchMessageWithValue<TCustomScrollBoxModel.TScrollByInfo>); message PM_SCROLL_BY;
    procedure PMInit(var Message: TDispatchMessage); message PM_INIT;
    procedure PMSetContent(var Message: TDispatchMessageWithValue<TScrollContent>); message PM_SET_CONTENT;
    procedure PMGetContentLayout(var Message: TDispatchMessageWithValue<TControl>); message PM_GET_CONTENT_LAYOUT;
    procedure PMGetVScrollBar(var Message: TDispatchMessageWithValue<TScrollBar>); message PM_GET_VSCROLLBAR;
    procedure PMGetHScrollBar(var Message: TDispatchMessageWithValue<TScrollBar>); message PM_GET_HSCROLLBAR;
    procedure PMGetAniCalculations(var Message: TDispatchMessageWithValue<TAniCalculations>); message PM_GET_ANICALCULATIONS;
    procedure PMMouseWheel(var Message: TDispatchMessageWithValue<TMouseWheelInfo>); message PM_MOUSE_WHEEL;
    /// <summary>Notification about starting painting children</summary>
    procedure PMBeginPaintChildren(var Message: TDispatchMessage); message PM_BEGIN_PAINT_CHILDREN;
    /// <summary>Notification about ending painting children</summary>
    procedure PMEndPaintChildren(var Message: TDispatchMessage); message PM_END_PAINT_CHILDREN;
    /// <summary>Notification about need to scroll viewport to specified rect</summary>
    procedure PMScrollInRect(var AMessage: TDispatchMessageWithValue<TCustomScrollBoxModel.TInViewRectInfo>); message PM_SCROLL_IN_RECT;
  protected
    //Animation mouse events
    ///<summary>Method that translates MouseDown event to scrolling animation</summary>
    procedure AniMouseDown(const Touch: Boolean; const X, Y: Single); virtual;
    ///<summary>Method that translates MouseMove event to scrolling animation</summary>
    procedure AniMouseMove(const Touch: Boolean; const X, Y: Single); virtual;
    ///<summary>Method that translates MouseUp event to scrolling animation</summary>
    procedure AniMouseUp(const Touch: Boolean; const X, Y: Single); virtual;
    procedure DoRealign; override;
    ///<summary>Called when user changes horisontal scrollbar position</summary>
    procedure DoHScrollChange; virtual;
    ///<summary>Called when user changes vertical scrollbar position</summary>
    procedure DoVScrollChange; virtual;
    ///<summary>Called when scroll position was changed</summary>
    procedure DoViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: boolean); virtual;
    procedure Paint; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    ///<summary>Creates an instance of <c>TScrollCalculations</c> class or its descendant</summary>
    function CreateAniCalculations: TScrollCalculations; virtual;
    ///<summary>Called when size of scrolling content was changed</summary>
    procedure DoRealignContent(ContentRect: TRectF); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseLeave; override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure CMGesture(var EventInfo: TGestureEventInfo); override;
    ///<summary>Reload scrollbars from style based on AutoShowing mode (Small or big scroll bars)</summary>    
    procedure ReloadScrollBars;
    ///<summary>Returns horisontal scrollbar component alignment</summary>
    property HScrollAlign: TAlignLayout read GetHScrollAlign;
    ///<summary>Returns vertical scrollbar component alignment</summary>
    property VScrollAlign: TAlignLayout read GetVScrollAlign;
    ///<summary>Returns margin rectange for horizontal scrollbar</summary>
    property HScrollMargins: TRectF read GetHScrollMargins;
    ///<summary>Returns margin rectange for vertical scrollbar</summary>
    property VScrollMargins: TRectF read GetVScrollMargins;
    ///<summary>Returns True if currently presentation is processing scrolling event or content change event</summary>
    property InInternalAlign: Boolean read FInInternalAlign;
    ///<summary>Returns the current position of viewport rectange</summary>
    property ViewportPosition: TPointF read GetViewportPosition write SetViewportPosition;
    ///<summary>Returns horisontal scrollbar component</summary>
    property HScrollBar: TScrollBar read GetHScrollBar;
    ///<summary>Returns vertical scrollbar component</summary>
    property VScrollBar: TScrollBar read GetVScrollBar;
    ///<summary>Link to the <c>TScrollCalculations</c> that controls view scrolling features</summary>
    property AniCalculations: TScrollCalculations read FAniCalculations;
    /// <summary> This content, which includes all the controls of <b>TStyledCustomScrollBox</b> </summary>
    property Content: TScrollContent read FContent;
    /// <summary> The stylistic element in which the <b>Content</b> is aligned </summary>
    property ContentLayout: TControl read FContentLayout;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    ///<summary>Reset the size of current content. When text time component will process any change event this will
    ///force it to recalculate content size</summary>
    procedure InvalidateContentSize;
    ///<summary>Reset the size of current content and recalculate its size immidiatelly.</summary>
    procedure RealignContent;
    /// <summary>Returns model of <c>TCustomScrollBoxModel</c></summary>
    property Model: TCustomScrollBoxModel read GetModel;
  end;

implementation

uses
  System.RTLConsts, System.SysUtils, System.Math, FMX.Presentation.Factory, FMX.Consts, FMX.Styles;

{ TScrollCalculations }

constructor TScrollCalculations.Create(AOwner: TPersistent);
begin
  if not (AOwner is TStyledCustomScrollBox) then
    raise EArgumentException.Create(sArgumentInvalid);
  inherited;
  FScrollBox := TStyledCustomScrollBox(AOwner);
end;

procedure TScrollCalculations.DoChanged;
begin
  if not (csDestroying in FScrollBox.ComponentState) then
    FScrollBox.InternalAlign;
  inherited;
end;

procedure TScrollCalculations.DoStart;
begin
  inherited;
  if not (csDestroying in FScrollBox.ComponentState) then
    FScrollBox.StartScrolling;
end;

procedure TScrollCalculations.DoStop;
begin
  inherited;
  if not (csDestroying in FScrollBox.ComponentState) then
    FScrollBox.StopScrolling;
end;

{ TStyledCustomScrollBox }

type
  TOpenControl = class(TControl);

constructor TStyledCustomScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  FOriginalContentLayoutSize := InvalidSize;
  DisableDisappear := True;
  SupportsPlatformService(IFMXSystemInformationService, FSystemInfoSrv);
  AutoCapture := True;
  FAniCalculations := CreateAniCalculations;
  if FAniCalculations = nil then
    raise EArgumentException.Create(SScrollBoxAniCalculations);
  Touch.DefaultInteractiveGestures := Touch.DefaultInteractiveGestures + [TInteractiveGesture.Pan];
  Touch.InteractiveGestures := Touch.InteractiveGestures + [TInteractiveGesture.Pan];
end;

destructor TStyledCustomScrollBox.Destroy;
begin
  FAniCalculations.Free;
  inherited;
end;

function TStyledCustomScrollBox.CreateAniCalculations: TScrollCalculations;
begin
  Result := TScrollCalculations.Create(self);
end;

procedure TStyledCustomScrollBox.UpdateAutoHide;
begin
  case Model.AutoHide of
    TBehaviorBoolean.True:
      FAniCalculations.AutoShowing := True;
    TBehaviorBoolean.False:
      FAniCalculations.AutoShowing := False;
    TBehaviorBoolean.PlatformDefault:
      FAniCalculations.AutoShowing := TScrollingBehaviour.AutoShowing in GetScrollingBehaviours;
  end;
end;

procedure TStyledCustomScrollBox.UpdateScrollAnimation;
begin
  case Model.ScrollAnimation of
    TBehaviorBoolean.True:
      FAniCalculations.Animation := True;
    TBehaviorBoolean.False:
      FAniCalculations.Animation := False;
    TBehaviorBoolean.PlatformDefault:
      FAniCalculations.Animation := TScrollingBehaviour.Animation in GetScrollingBehaviours;
  end;
end;

procedure TStyledCustomScrollBox.UpdateScrollBarsEnabled;
begin
  if HScrollBar <> nil then
    HScrollBar.Enabled := Model.EnabledScroll;

  if VScrollBar <> nil then
    VScrollBar.Enabled := Model.EnabledScroll;
end;

procedure TStyledCustomScrollBox.UpdateBounces;
begin
  case Model.Bounces of
    TBehaviorBoolean.True:
      FAniCalculations.BoundsAnimation := True;
    TBehaviorBoolean.False:
      FAniCalculations.BoundsAnimation := False;
    TBehaviorBoolean.PlatformDefault:
      FAniCalculations.BoundsAnimation := TScrollingBehaviour.BoundsAnimation in GetScrollingBehaviours;
  end;
end;

function TStyledCustomScrollBox.GetSceneScale: Single;
begin
  Result := 0;
  if Scene <> nil then
    Result := Scene.GetSceneScale;
  if Result <= 0 then
    Result := 1;
end;

procedure TStyledCustomScrollBox.UpdateSizeGrip;
var
  TempRect, GripRect: TRectF;
  GripLeft, GripTop, SizeGripVisible, Both: Boolean;
begin
  SizeGripVisible := Model.ShowSizeGrip and (FSizeGrip <> nil) and (FSizeGripParent <> nil) and (FSizeGripContent <> nil);
  Both := (VScrollBar <> nil) and VScrollBar.Visible and (HScrollBar <> nil) and HScrollBar.Visible;
  if Both or (SizeGripVisible and (((VScrollBar <> nil) and VScrollBar.Visible) or
    ((HScrollBar <> nil) and HScrollBar.Visible))) then
  begin
    //size
    GripRect := TRectF.Empty;
    if HScrollBar <> nil then
      GripRect.Height := HScrollBar.Height
    else
      GripRect.Height := VScrollBar.Width;
    if VScrollBar <> nil then
      GripRect.Width := VScrollBar.Width
    else
      GripRect.Width := HScrollBar.Height;
    //vert align
    GripTop := (HScrollBar <> nil) and (not (HScrollAlign in [TAlignLayout.Bottom, TAlignLayout.MostBottom]));
    if FSizeGrip <> nil then
    begin
      if GripTop then
        FSizeGrip.Align := TAlignLayout.Top
      else
        FSizeGrip.Align := TAlignLayout.Bottom;
      FSizeGrip.BoundsRect := GripRect;
    end;
    //horz align
    GripLeft := (VScrollBar <> nil) and (not (VScrollAlign in [TAlignLayout.Right, TAlignLayout.MostRight]));
    if FSizeGripContent <> nil then
      FSizeGripContent.Align := TAlignLayout.Contents;
    if FSizeGripParent <> nil then
    begin
      if GripLeft then
        FSizeGripParent.Align := TAlignLayout.Left
      else
        FSizeGripParent.Align := TAlignLayout.Right;
      FSizeGripParent.Width := GripRect.Width;
    end;
    if (HScrollBar <> nil) and HScrollBar.Visible then
    begin
      TempRect := HScrollMargins;
      if GripLeft then
        TempRect.Left := TempRect.Left + GripRect.Width
      else
        TempRect.Right := TempRect.Right + GripRect.Width;
      HScrollBar.Margins.Rect := TempRect;
      if VScrollBar <> nil then
        VScrollBar.Margins.Rect := VScrollMargins;
    end
    else if (VScrollBar <> nil) and VScrollBar.Visible then
    begin
      TempRect := VScrollMargins;
      if GripTop then
        TempRect.Top := TempRect.Top + GripRect.Height
      else
        TempRect.Bottom := TempRect.Bottom + GripRect.Height;
      VScrollBar.Margins.Rect := TempRect;
    end;
    if FSizeGripParent <> nil then
      FSizeGripParent.Visible := True;
    if FSizeGripContent <> nil then
      FSizeGripContent.Visible := True;
    if FSizeGrip <> nil then
    begin
      FSizeGrip.Opacity := FAniCalculations.Opacity;
      FSizeGrip.Visible := SizeGripVisible;
    end;
  end
  else
  begin
    if FSizeGrip <> nil then
      FSizeGrip.Visible := False;
    if FSizeGripContent <> nil then
      FSizeGrip.Visible := False;
    if (VScrollBar <> nil) and (VScrollBar.Margins <> nil) then
      VScrollBar.Margins.Rect := VScrollMargins;
    if (HScrollBar <> nil) and (HScrollBar.Margins <> nil) then
      HScrollBar.Margins.Rect := HScrollMargins;
  end;
end;

procedure TStyledCustomScrollBox.UpdateTouchTracking;

  function BoolToTouchTracking(const AValue: Boolean): TTouchTracking;
  begin
    if AValue then
      Result := [ttVertical, ttHorizontal]
    else
      Result := [];
  end;

var
  TouchTracking: TTouchTracking;
begin
  TouchTracking := [];
  case Model.TouchTracking of
    TBehaviorBoolean.True:
      TouchTracking := [ttVertical, ttHorizontal];
    TBehaviorBoolean.PlatformDefault:
      TouchTracking := BoolToTouchTracking(TScrollingBehaviour.TouchTracking in GetScrollingBehaviours)
  end;
  case Model.ScrollDirections of
    TScrollDirections.Horizontal:
      Exclude(TouchTracking, ttVertical);
    TScrollDirections.Vertical:
      Exclude(TouchTracking, ttHorizontal);
  end;
  FAniCalculations.TouchTracking := TouchTracking;
end;

procedure TStyledCustomScrollBox.UpdateVScrollBar(const Value: Single; const ViewportSize: Single);
begin
  if VScrollBar <> nil then
  begin
    VScrollBar.ValueRange.BeginUpdate;
    try
      VScrollBar.ValueRange.Min := Min(Value, 0);
      VScrollBar.ValueRange.Max := Max(Value + ViewportSize, Model.ContentSize.Height);
      VScrollBar.ValueRange.ViewportSize := ViewportSize;
      VScrollBar.Value := Value;
    finally
      VScrollBar.ValueRange.EndUpdate;
    end;
    VScrollBar.SmallChange := VScrollBar.ViewportSize / SmallChangeFraction;
  end;
end;

procedure TStyledCustomScrollBox.UpdateHScrollBar(const Value: Single; const ViewportSize: Single);
begin
  if HScrollBar <> nil then
  begin
    HScrollBar.ValueRange.BeginUpdate;
    try
      HScrollBar.ValueRange.Min := Min(Value, 0);
      HScrollBar.ValueRange.Max := Max(Value + ViewportSize, Model.ContentSize.Width);
      HScrollBar.ValueRange.ViewportSize := ViewportSize;
      HScrollBar.Value := Value;
    finally
      HScrollBar.ValueRange.EndUpdate;
    end;
    HScrollBar.SmallChange := HScrollBar.ViewportSize / SmallChangeFraction;
  end;
end;

procedure TStyledCustomScrollBox.InternalAlign;

  procedure UpdateScrollbarsVisibility(const AContentRect: TRectF);
  begin
    if VScrollBar <> nil then
    begin
      VScrollBar.Opacity := FAniCalculations.Opacity;
      VScrollBar.Enabled := ((Model.ContentSize.Height > AContentRect.Height) or FAniCalculations.AutoShowing)
        and Model.EnabledScroll;
      VScrollBar.Visible := Model.ShowScrollBars and (Model.ContentSize.Height > AContentRect.Height) and
        (FAniCalculations.Opacity > TEpsilon.Position) and (TScrollDirections.Horizontal <> Model.ScrollDirections);
    end;
    if HScrollBar <> nil then
    begin
      HScrollBar.Opacity := FAniCalculations.Opacity;
      HScrollBar.Enabled := ((Model.ContentSize.Width > AContentRect.Width) or FAniCalculations.AutoShowing)
        and Model.EnabledScroll;;
      HScrollBar.Visible := Model.ShowScrollBars and (Model.ContentSize.Width > AContentRect.Width) and
        (FAniCalculations.Opacity > TEpsilon.Position) and (TScrollDirections.Vertical <> Model.ScrollDirections);
    end;
  end;

  procedure UpdateContentLayoutMargins;
  begin
    FContentLayout.Margins.Rect := FContentMargins;
    if (FContentLayout.Align = TAlignLayout.Contents) and (FBackground <> nil) then
      FContentLayout.Margins.Rect.Inflate(-FBackground.Padding.Left, -FBackground.Padding.Top,
        FBackground.Padding.Right, FBackground.Padding.Bottom);
  end;

  function CalcContentLayoutRect: TRectF;
  var
    AlignRoot: IAlignRoot;
  begin
    Result := TRectF.Create(FContentLayout.Position.Point, FContentLayout.Width, FContentLayout.Height);
    UpdateScrollbarsVisibility(Result);
    Result.TopLeft := Result.TopLeft - ViewportPosition;
    if FDisableAlign and Supports(FBackground, IAlignRoot, AlignRoot) then
      AlignRoot.Realign;
    Result.Width := FContentLayout.Width;
    Result.Height := FContentLayout.Height;
  end;

  procedure UpdateAnimationTargets(const ContentLayoutRect: TRectF);
  var
    I, J: Integer;
    LTargets: array of TAniCalculations.TTarget;
    NewTargets: array of TAniCalculations.TTarget;
  begin
    SetLength(LTargets, FAniCalculations.TargetCount);
    FAniCalculations.GetTargets(LTargets);
    SetLength(NewTargets, 2);
    NewTargets[0].TargetType := TAniCalculations.TTargetType.Min;
    NewTargets[0].Point := TPointF.Create(0, 0);
    NewTargets[1].TargetType := TAniCalculations.TTargetType.Max;
    NewTargets[1].Point := TPointD.Create(Max(0, Model.ContentSize.Width - ContentLayoutRect.Width),
      Max(0, Model.ContentSize.Height - ContentLayoutRect.Height));
    for I := 0 to Length(LTargets) - 1 do
      if not (LTargets[I].TargetType in [TAniCalculations.TTargetType.Min, TAniCalculations.TTargetType.Max]) then
      begin
        J := Length(NewTargets);
        SetLength(NewTargets, J + 1);
        NewTargets[J].TargetType := LTargets[I].TargetType;
        NewTargets[J].Point := LTargets[I].Point;
      end;
    FAniCalculations.SetTargets(NewTargets);
  end;

  procedure SaveControlRects(var ControlList: TDictionary<TControl, TRectF>);
  var
    I: Integer;
    R: TRectF;
    Ctrl: TControl;
  begin
    if not FContentCalculated and (FOriginalContentLayoutSize.cx >= 0) and (FOriginalContentLayoutSize.cy >= 0) and (FContent <> nil) then
    begin
      if ControlList = nil then
        for I := 0 to FContent.ControlsCount - 1 do
        begin
          Ctrl := FContent.Controls[I];
          if (Ctrl.Align = TAlignLayout.None) and ([TAnchorKind.akRight, TAnchorKind.akBottom] * Ctrl.Anchors <> []) then
          begin
            if ControlList = nil then
              ControlList := TDictionary<TControl, TRectF>.Create;
            R := Ctrl.BoundsRect;
            ControlList.Add(Ctrl, R);
          end;
        end;
    end;
    if ControlList = nil then
      FContentCalculated := True;
  end;

  procedure RestoreControlRects(var ControlList: TDictionary<TControl, TRectF>);
  var
    I: Integer;
    R: TRectF;
    Ctrl: TControl;
    LParentSize: TSizeF;
    Dx, Dy: Single;
    AlignRoot: IAlignRoot;
  begin
    if (ControlList <> nil) and (FContent <> nil) then
    begin
      LParentSize := FContentLayout.BoundsRect.Size;
      Dx := LParentSize.cx - FOriginalContentLayoutSize.cx;
      Dy := LParentSize.cy - FOriginalContentLayoutSize.cy;
      for I := 0 to FContent.ControlsCount - 1 do
      begin
        Ctrl := FContent.Controls[I];
        if (Ctrl.Align = TAlignLayout.None) and ([TAnchorKind.akRight, TAnchorKind.akBottom] * Ctrl.Anchors <> []) and
          ControlList.TryGetValue(Ctrl, R) then
        begin
          if TAnchorKind.akRight in Ctrl.Anchors then
            if TAnchorKind.akLeft in Ctrl.Anchors then
              R.Right := R.Right + Dx
            else
              R.Offset(Dx, 0);

          if TAnchorKind.akBottom in Ctrl.Anchors then
            if TAnchorKind.akTop in Ctrl.Anchors then
              R.Bottom := R.Bottom + Dy
            else
              R.Offset(0, Dy);

          Ctrl.BoundsRect := R;
          if FContentCalculated then
            TOpenControl(Ctrl).UpdateAnchorRules(True);
        end;
      end;
      if not FContentCalculated then
      begin
        FContentCalculated := True;
        if Supports(FContent, IAlignRoot, AlignRoot) then
          AlignRoot.Realign;
      end
      else
        FreeAndNil(ControlList);
    end;
  end;

const
  MaxAlignIterations = 5;
var
  LViewportPosition: TPointF;
  ContentLayoutRect: TRectF;
  Adjust, ContentSizeChanged: Boolean;
  LScale, LEpsilon: Single;
  AlignCount: Integer;
  ControlList: TDictionary<TControl, TRectF>;
begin
  if not FInInternalAlign and (FContentLayout <> nil) and (FContent <> nil) then
  begin
    ControlList := nil;
    LScale := GetSceneScale;
    LEpsilon := 1 / Max(2, LScale * Max(GetAbsoluteScale.X, GetAbsoluteScale.Y));
    FInInternalAlign := True;
    try
      if not FAniCalculations.Down and FAniCalculations.LowVelocity then
        FAniCalculations.Shown := False;
      Adjust := False;
      try
        repeat
          if not FContentCalculated then
            SaveControlRects(ControlList);
          for AlignCount := 0 to MaxAlignIterations - 1 do
          begin
            UpdateContentLayoutMargins;
            ContentLayoutRect := CalcContentLayoutRect;
            if not TPointF(FCachedContentSize).EqualsTo(TPointF(ContentLayoutRect.Size)) then
            begin
              FCachedContentSize := ContentLayoutRect.Size;
              Adjust := True;
            end
            else
              Break;
          end;
          if Adjust then
            UpdateAnimationTargets(ContentLayoutRect);
          ContentSizeChanged := not SameValue(FContent.Width, ContentLayoutRect.Width, TEpsilon.Position) or
            not SameValue(FContent.Height, ContentLayoutRect.Height, TEpsilon.Position);
          if TOpenControl(FContent).FRecalcUpdateRect or ContentSizeChanged then
            DoRealignContent(ContentLayoutRect)
          else if Adjust or not SameValue(FContent.Position.X, ContentLayoutRect.Left, LEpsilon)
             or not SameValue(FContent.Position.Point.Y, ContentLayoutRect.Top, LEpsilon) then
          begin
            FContent.Position.Point := ContentLayoutRect.TopLeft;
          end
          else if FContentCalculated then
            Exit;
          RestoreControlRects(ControlList);
        until ControlList = nil;
      finally
        FContentCalculated := True;
        ControlList.Free;
      end;
      LViewportPosition := ViewportPosition;
      UpdateVScrollBar(LViewportPosition.Y, ContentLayoutRect.Height);
      UpdateHScrollBar(LViewportPosition.X, ContentLayoutRect.Width);
      UpdateSizeGrip;
    finally
      FInInternalAlign := False;
    end;
    LViewportPosition := TPointF.Create((LViewportPosition * LScale).Round) / LScale;
    if ContentSizeChanged or (not SameValue(FLastViewportPosition.X, LViewportPosition.X, TEpsilon.Position)) or
      (not SameValue(FLastViewportPosition.Y, LViewportPosition.Y, TEpsilon.Position)) then
      try
        DoViewportPositionChange(FLastViewportPosition, LViewportPosition, ContentSizeChanged);
      finally
        FLastViewportPosition := LViewportPosition;
      end;
    if Adjust then
    begin
      if not (csDesigning in ComponentState) and not FAniCalculations.Animation then
        FAniCalculations.UpdatePosImmediately(True);
      Repaint;
    end;
  end;
end;

procedure TStyledCustomScrollBox.ApplyStyle;

  function CheckParent(Control: TControl): Boolean;
  begin
    Result := (Control <> nil) and (Control.ParentControl <> nil) and (Control.ParentControl <> FBackground) and
      (Control.ParentControl <> Self);
  end;

  procedure HideScrollBar(const AStyleLookup: string);
  var
    ScrollBar: TScrollBar;
  begin
    if FindStyleResource<TScrollBar>(AStyleLookup, ScrollBar) then
      ScrollBar.Visible := False;
  end;

begin
  FindStyleResource<TControl>('background', FBackground);

  { Scroll bars }
  HideScrollBar('vscrollbar');
  HideScrollBar('hscrollbar');
  HideScrollBar('vsmallscrollbar');
  HideScrollBar('hsmallscrollbar');
  ReloadScrollBars;

  { Size grip }
  if FindStyleResource<TControl>('sizegrip', FSizeGrip) then
  begin
    FSizeGrip.Visible := False;
    FSizeGrip.Align := TAlignLayout.Bottom;
    FSizeGrip.Enabled := True;

    if CheckParent(FSizeGrip) then
    begin
      FSizeGripParent := FSizeGrip.ParentControl;
      FSizeGripParent.Align := TAlignLayout.Right;
    end;
    if CheckParent(FSizeGripParent) then
    begin
      FSizeGripContent := FSizeGripParent.ParentControl;
      FSizeGripContent.Visible := False;
      FSizeGripParent.Align := TAlignLayout.Contents;
    end;
  end;

  { Content layout }
  if FindStyleResource<TControl>('content', FContentLayout) then
  begin
    FContentMargins := FContentLayout.Margins.Rect;
    FContentLayout.DisableDisappear := True;
  end;
  if ResourceControl <> nil then
    ResourceControl.DisableDisappear := True;

  RealignContent;
  // Very important invoke inherited implementation after all.
  inherited;
end;

procedure TStyledCustomScrollBox.FreeStyle;
begin
  inherited;
  FHScrollInfo.Scroll := nil;
  FHScrollInfo.Margins := TRectF.Empty;
  FVScrollInfo.Scroll := nil;
  FVScrollInfo.Margins := TRectF.Empty;
  UpdateOriginalContentLayoutSize(True);
  FContentCalculated := False;
  FSizeGripParent := nil;
  FSizeGripContent := nil;
  FContentLayout := nil;
  FBackground := nil;
  FSizeGrip := nil;
end;

function TStyledCustomScrollBox.GetHScrollAlign: TAlignLayout;
begin
  if HScrollBar <> nil then
    Result := FHScrollInfo.Align
  else
    Result := TAlignLayout.None;
end;

function TStyledCustomScrollBox.GetHScrollBar: TScrollBar;
begin
  Result := FHScrollInfo.Scroll;
end;

function TStyledCustomScrollBox.GetHScrollMargins: TRectF;
begin
  if HScrollBar <> nil then
    Result := FHScrollInfo.Margins
  else
    Result := TRectF.Empty;
end;

function TStyledCustomScrollBox.GetModel: TCustomScrollBoxModel;
begin
  Result := inherited GetModel<TCustomScrollBoxModel>;
end;

function TStyledCustomScrollBox.GetViewportPosition: TPointF;
var
  LScale, X, Y: Double;
begin
  LScale := GetSceneScale;
  X := Round(FAniCalculations.ViewportPosition.X * LScale) / LScale;
  Y := Round(FAniCalculations.ViewportPosition.Y * LScale) / LScale;
  Result := TPointF.Create(X, Y);
end;

function TStyledCustomScrollBox.GetVScrollAlign: TAlignLayout;
begin
  if VScrollBar <> nil then
    Result := FVScrollInfo.Align
  else
    Result := TAlignLayout.None;
end;

function TStyledCustomScrollBox.GetVScrollBar: TScrollBar;
begin
  Result := FVScrollInfo.Scroll;
end;

function TStyledCustomScrollBox.GetVScrollMargins: TRectF;
begin
  if VScrollBar <> nil then
    Result := FVScrollInfo.Margins
  else
    Result := TRectF.Empty;
end;

procedure TStyledCustomScrollBox.DoRealign;
var
  LDisablePaint, LDisableInternalAlign: Boolean;
begin
  LDisableInternalAlign := (csDestroying in ComponentState) or FDisableAlign or (FUpdating > 0) or
    (csLoading in ComponentState) or (FContentLayout = nil);
  LDisablePaint := FDisablePaint;
  try
    FDisablePaint := True;
    inherited;
    if not LDisableInternalAlign then
      InternalAlign;
  finally
    FDisablePaint := LDisablePaint;
  end;
end;

procedure TStyledCustomScrollBox.DoRealignContent(ContentRect: TRectF);
var
  AlignRoot: IAlignRoot;
begin
  if Supports(FContent, IAlignRoot, AlignRoot) then
  begin
    FContent.SetBounds(ContentRect.Left, ContentRect.Top, ContentRect.Width, ContentRect.Height);
    TOpenControl(FContent).FRecalcUpdateRect := True;
    AlignRoot.Realign;
  end;
end;

procedure TStyledCustomScrollBox.DoViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: boolean);
begin
  Model.DoViewportPositionChange(OldViewportPosition, NewViewportPosition, ContentSizeChanged);
end;

procedure TStyledCustomScrollBox.HScrollChangeProc(Sender: TObject);
begin
  if not FInInternalAlign then
    DoHScrollChange;
end;

procedure TStyledCustomScrollBox.VScrollChangeProc(Sender: TObject);
begin
  if not FInInternalAlign then
    DoVScrollChange;
end;

procedure TStyledCustomScrollBox.DoHScrollChange;
begin
  ViewportPosition := TPointF.Create(HScrollBar.Value, ViewportPosition.Y);
  if not Model.IsOpaque then
    UpdateEffects;
  FAniCalculations.Shown := True;
end;

procedure TStyledCustomScrollBox.DoVScrollChange;
begin
  ViewportPosition := TPointF.Create(ViewportPosition.X, VScrollBar.Value);
  if not Model.IsOpaque then
    UpdateEffects;
  FAniCalculations.Shown := True;
end;

function TStyledCustomScrollBox.GetScrollingBehaviours: TScrollingBehaviours;
var
  StyleDescriptor: TStyleDescription;
begin
  if Scene <> nil then
    StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(Self)
  else
    StyleDescriptor := nil;
  if (StyleDescriptor <> nil) and StyleDescriptor.PlatformTarget.Contains('[METROPOLISUI]') then
    Result := [TScrollingBehaviour.AutoShowing]
  else
  begin
    if FSystemInfoSrv <> nil then
      Result := FSystemInfoSrv.GetScrollingBehaviour
    else
      Result := [];
  end;
end;

procedure TStyledCustomScrollBox.MousePosToAni(var X, Y: Single);
var
  LPoint: TPointF;
begin
  LPoint := TPointF.Create(X, Y);
  if FContentLayout <> nil then
  begin
    LPoint := FContentLayout.AbsoluteToLocal(LocalToAbsolute(LPoint));
    X := LPoint.X;
    Y := LPoint.Y;
  end;
end;

procedure TStyledCustomScrollBox.MMAutoHideChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>);
begin
  UpdateAutoHide;
  ReloadScrollBars;
  Realign;
end;

procedure TStyledCustomScrollBox.MMBouncesChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>);
begin
  UpdateBounces;
end;

procedure TStyledCustomScrollBox.MMEnabledScrollChanged(var Message: TDispatchMessageWithValue<Boolean>);
begin
  FAniCalculations.Enabled := Message.Value;
  UpdateScrollBarsEnabled;
end;

procedure TStyledCustomScrollBox.MMGetViewportPosition(var Message: TDispatchMessageWithValue<TPointF>);
begin
  Message.Value := ViewportPosition;
end;

procedure TStyledCustomScrollBox.MMGetViewportSize(var Message: TDispatchMessageWithValue<TSizeF>);
var
  Rect: TRectF;
  AlignRoot: IAlignRoot;
begin
  if FContentLayout <> nil then
  begin
    Rect := TRectF.Create(FContentLayout.Position.Point, FContentLayout.Width, FContentLayout.Height);
    Rect.TopLeft := Rect.TopLeft - ViewportPosition;
    if FDisableAlign and Supports(FBackground, IAlignRoot, AlignRoot) then
      AlignRoot.Realign;
    Rect.Width := FContentLayout.Width;
    Rect.Height := FContentLayout.Height;
  end
  else
  begin
    Rect := TRectF.Create(0, 0, Width, Height);
    Rect.Offset(ViewportPosition);
  end;
  Message.Value := Rect.Size;
end;

procedure TStyledCustomScrollBox.MMScrollAnimationChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>);
begin
  UpdateScrollAnimation;
end;

procedure TStyledCustomScrollBox.MMScrollDirectionsChanged(var Message: TDispatchMessageWithValue<TScrollDirections>);
begin
  UpdateTouchTracking;
  RealignContent;
end;

procedure TStyledCustomScrollBox.MMSetContentBounds(var Message: TDispatchMessageWithValue<TRectF>);
begin
  if not InInternalAlign then
  begin
    UpdateOriginalContentLayoutSize(False);
    RealignContent;
  end;
end;

procedure TStyledCustomScrollBox.MMSetViewportPosition(var Message: TDispatchMessageWithValue<TPointF>);
begin
  ViewportPosition := Message.Value;
end;

procedure TStyledCustomScrollBox.MMShowScrollBarsChanged(var Message: TDispatchMessageWithValue<Boolean>);
begin
  Realign;
end;

procedure TStyledCustomScrollBox.MMShowSizeGripChanged(var Message: TDispatchMessageWithValue<Boolean>);
begin
  UpdateSizeGrip;
  Realign;
end;

procedure TStyledCustomScrollBox.MMTouchTrackingChanged(var Message: TDispatchMessageWithValue<TBehaviorBoolean>);
begin
  UpdateTouchTracking;
end;

procedure TStyledCustomScrollBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    MousePosToAni(X, Y);
    AniMouseDown(ssTouch in Shift, X, Y);
  end;
end;

procedure TStyledCustomScrollBox.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if FAniCalculations.Down then
  begin
    MousePosToAni(X, Y);
    AniMouseMove(ssTouch in Shift, X, Y);
  end;
end;

procedure TStyledCustomScrollBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    MousePosToAni(X, Y);
    AniMouseUp(ssTouch in Shift, X, Y);
  end;
end;

procedure TStyledCustomScrollBox.DoMouseLeave;
begin
  inherited;
  if FMouseEvents and FAniCalculations.Down then
  begin
    FAniCalculations.MouseLeave;
    if (FAniCalculations.LowVelocity) or not FAniCalculations.Animation then
      FAniCalculations.Shown := False;
  end;
end;

procedure TStyledCustomScrollBox.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
const
  ScrollBigStepsDivider = 5;
  WheelDeltaDivider = -120;

   function CanVerticalScroll: Boolean;
   begin
     Result := (Model.ContentSize.Height > FContentLayout.Height) and
       (Model.ScrollDirections <> TScrollDirections.Horizontal) and ([ssHorizontal, ssShift] * Shift = []);
   end;

   function CanHorizontalScroll: Boolean;
   begin
     Result := (Model.ContentSize.Width > FContentLayout.Width) and
       (Model.ScrollDirections <> TScrollDirections.Vertical) and not ([ssHorizontal, ssShift] * Shift = []);
   end;

var
  Offset: Single;
begin
  inherited;
  if not (Handled or Model.DisableMouseWheel) and (FContentLayout <> nil) and Model.EnabledScroll then
    if CanHorizontalScroll then
    begin
      FAniCalculations.Shown := True;
      if HScrollBar <> nil then
        Offset := HScrollBar.SmallChange
      else
        Offset := FContentLayout.Width / ScrollBigStepsDivider;
      Offset := Offset * WheelDelta / WheelDeltaDivider;
      FAniCalculations.MouseWheel(Offset, 0);
      Handled := True;
    end
    else if CanVerticalScroll then
    begin
      FAniCalculations.Shown := True;
      if VScrollBar <> nil then
        Offset := VScrollBar.SmallChange
      else
        Offset := FContentLayout.Height / ScrollBigStepsDivider;
      Offset := Offset * WheelDelta / WheelDeltaDivider;
      FAniCalculations.MouseWheel(0, Offset);
      Handled := True;
    end;
end;

procedure TStyledCustomScrollBox.SaveDisablePaint;
begin
  FVDisablePaint := False;
  FHDisablePaint := False;
  FGDisablePaint := False;
  if VScrollBar <> nil then
    FVDisablePaint := TOpenControl(VScrollBar).FDisablePaint;
  if HScrollBar <> nil then
    FHDisablePaint := TOpenControl(HScrollBar).FDisablePaint;
  if FSizeGrip <> nil then
    FGDisablePaint := TOpenControl(FSizeGrip).FDisablePaint;
end;

procedure TStyledCustomScrollBox.SetDisablePaint;
begin
  if VScrollBar <> nil then
    TOpenControl(VScrollBar).FDisablePaint := True;
  if HScrollBar <> nil then
    TOpenControl(HScrollBar).FDisablePaint := True;
  if FSizeGrip <> nil then
    TOpenControl(FSizeGrip).FDisablePaint := True;
end;

procedure TStyledCustomScrollBox.RestoreDisablePaint;
begin
  if VScrollBar <> nil then
    TOpenControl(VScrollBar).FDisablePaint := FVDisablePaint;
  if HScrollBar <> nil then
    TOpenControl(HScrollBar).FDisablePaint := FHDisablePaint;
  if FSizeGrip <> nil then
    TOpenControl(FSizeGrip).FDisablePaint := FGDisablePaint;
end;

procedure TStyledCustomScrollBox.SetViewportPosition(const Value: TPointF);
var
  LScale, X, Y: Double;
begin
  LScale := GetSceneScale;
  X := Value.X;
  Y := Value.Y;
  FAniCalculations.ViewportPosition := TPointD.Create(Round(X * LScale) / LScale, Round(Y * LScale) / LScale);
end;

procedure TStyledCustomScrollBox.InvalidateContentSize;
begin
  FCachedContentSize := TSizeF.Create(0, 0);
end;

procedure TStyledCustomScrollBox.RealignContent;
begin
  InvalidateContentSize;
  if FContent <> nil then
    FContent.RecalcSize;
  Realign;
end;

procedure TStyledCustomScrollBox.ReloadScrollBars;

  procedure ExtractScrollBarInformation(const AStyleLookup: string; var Info: TScrollInfo; Proc: TNotifyEvent);
  var
    ScrollBar: TScrollBar;
  begin
    if Info.Scroll <> nil then
      Info.Scroll.Visible := False;

    if FindStyleResource<TScrollBar>(AStyleLookup, ScrollBar) then
    begin
      Info.Scroll := ScrollBar;
      Info.Scroll.OnChange := Proc;
      Info.Scroll.Visible := False;
      Info.Scroll.Locked := True;
      Info.Align := ScrollBar.Align;
      Info.Margins := ScrollBar.Margins.Rect;
    end
    else
    begin
      Info.Scroll := nil;
      Info.Align := TAlignLayout.None;
      Info.Margins := TRectF.Empty;
    end;
  end;

begin
  if AniCalculations.AutoShowing then
  begin
    ExtractScrollBarInformation('vsmallscrollbar', FVScrollInfo, VScrollChangeProc);
    ExtractScrollBarInformation('hsmallscrollbar', FHScrollInfo, HScrollChangeProc);
  end
  else
  begin
    ExtractScrollBarInformation('vscrollbar', FVScrollInfo, VScrollChangeProc);
    ExtractScrollBarInformation('hscrollbar', FHScrollInfo, HScrollChangeProc);
  end;
end;

procedure TStyledCustomScrollBox.Paint;
var
  VertColor: TAlphaColor;
  HorzColor: TAlphaColor;
begin
  inherited;
  if csDesigning in ComponentState then
  begin
    VertColor := DesignBorderColor;
    HorzColor := DesignBorderColor;
    case Model.ScrollDirections of
      TScrollDirections.Horizontal: VertColor := VertColor or TAlphaColorRec.Alpha;
      TScrollDirections.Vertical: HorzColor := HorzColor or TAlphaColorRec.Alpha;
    end;
    DrawDesignBorder(HorzColor, VertColor);
  end;
end;

procedure TStyledCustomScrollBox.PMBeginPaintChildren(var Message: TDispatchMessage);
begin
  SaveDisablePaint;
  SetDisablePaint;
end;

procedure TStyledCustomScrollBox.PMEndPaintChildren(var Message: TDispatchMessage);
begin
  RestoreDisablePaint;
  if (VScrollBar <> nil) and VScrollBar.Visible and (VScrollBar.Opacity > 0) then
    TOpenControl(VScrollBar).PaintInternal;
  if (HScrollBar <> nil) and HScrollBar.Visible and (HScrollBar.Opacity > 0) then
    TOpenControl(HScrollBar).PaintInternal;
  if (FSizeGrip <> nil) and FSizeGrip.Visible and (FSizeGrip.Opacity > 0) then
    TOpenControl(FSizeGrip).PaintInternal;
end;

procedure TStyledCustomScrollBox.PMGetAniCalculations(var Message: TDispatchMessageWithValue<TAniCalculations>);
begin
  Message.Value := FAniCalculations;
end;

procedure TStyledCustomScrollBox.PMGetContentLayout(var Message: TDispatchMessageWithValue<TControl>);
begin
  Message.Value := FContentLayout;
end;

procedure TStyledCustomScrollBox.PMGetHScrollBar(var Message: TDispatchMessageWithValue<TScrollBar>);
begin
  Message.Value := HScrollBar;
end;

procedure TStyledCustomScrollBox.PMGetVScrollBar(var Message: TDispatchMessageWithValue<TScrollBar>);
begin
  Message.Value := VScrollBar;
end;

procedure TStyledCustomScrollBox.PMInit(var Message: TDispatchMessage);
begin
  inherited;
  UpdateAutoHide;
  UpdateBounces;
  UpdateTouchTracking;
  UpdateScrollAnimation;
  UpdateScrollBarsEnabled;
end;

procedure TStyledCustomScrollBox.PMMouseWheel(var Message: TDispatchMessageWithValue<TMouseWheelInfo>);
begin
  MouseWheel(Message.Value.Shift, Message.Value.WheelDelta, Message.Value.Handled);
end;

procedure TStyledCustomScrollBox.PMScrollBy(var Message: TDispatchMessageWithValue<TCustomScrollBoxModel.TScrollByInfo>);
begin
                                       
//  if Message.Value.Animated then
    FAniCalculations.MouseWheel(Message.Value.Vector.X, Message.Value.Vector.Y);
//  else
//  begin
//    if (VScrollBar <> nil) and (VScrollBar.Visible) then
//      VScrollBar.Value := VScrollBar.Value + Message.Value.Vector.Y;
//    if (HScrollBar <> nil) and (HScrollBar.Visible) then
//      HScrollBar.Value := HScrollBar.Value + Message.Value.Vector.X;
//  end;
end;

procedure TStyledCustomScrollBox.PMScrollInRect(
  var AMessage: TDispatchMessageWithValue<TCustomScrollBoxModel.TInViewRectInfo>);
var
  NewViewportRect: TRectF;
  Offset: TPointF;
begin
  NewViewportRect := NormalizeInViewRect(TRectF.Create(TPointF.Zero, Model.ContentSize.Size), Model.ViewportSize,
    AMessage.Value.Rect);

  Offset := NewViewportRect.TopLeft - ViewportPosition;

  FAniCalculations.MouseWheel(Offset.X, Offset.Y);
end;

procedure TStyledCustomScrollBox.PMSetContent(var Message: TDispatchMessageWithValue<TScrollContent>);
begin
  if Message.Value = nil then
                           
    raise EArgumentNilException.CreateFmt(SWrongParameter, ['Content']);
  FContent := Message.Value;
end;

procedure TStyledCustomScrollBox.AniMouseDown(const Touch: Boolean; const X, Y: Single);
begin
  if Model.EnabledScroll then
  begin
    FAniCalculations.Averaging := Touch;
    FAniCalculations.MouseDown(X, Y);
  end;
end;

procedure TStyledCustomScrollBox.AniMouseMove(const Touch: Boolean; const X, Y: Single);
begin
  if Model.EnabledScroll then
  begin
    FAniCalculations.MouseMove(X, Y);
    if FAniCalculations.Moved then
      FAniCalculations.Shown := True;
  end;
end;

procedure TStyledCustomScrollBox.AniMouseUp(const Touch: Boolean; const X, Y: Single);
begin
  if Model.EnabledScroll then
  begin
    FAniCalculations.MouseUp(X, Y);
    if FAniCalculations.LowVelocity or not FAniCalculations.Animation then
      FAniCalculations.Shown := False;
  end;
end;

procedure TStyledCustomScrollBox.UpdateOriginalContentLayoutSize(const Force: Boolean);
begin
  if Force or (FOriginalContentLayoutSize.cx < 0) then
    if FContentLayout <> nil then
      FOriginalContentLayoutSize.cx := FContentLayout.LocalRect.Width
    else
      FOriginalContentLayoutSize.cx := LocalRect.Width;
  if Force or (FOriginalContentLayoutSize.cy < 0) then
    if FContentLayout <> nil then
      FOriginalContentLayoutSize.cy := FContentLayout.LocalRect.Height
    else
      FOriginalContentLayoutSize.cy := LocalRect.Height;
end;

procedure TStyledCustomScrollBox.StartScrolling;
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(Self, True);
end;

procedure TStyledCustomScrollBox.StopScrolling;
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(nil, False);
end;

procedure TStyledCustomScrollBox.CMGesture(var EventInfo: TGestureEventInfo);
var
  LP: TPointF;
begin
  //This is used when scrolling with the finger on top of a control (like a TButton on a TListItem).
  if EventInfo.GestureID = igiPan then
  begin
    FMouseEvents := False;
    LP := FContentLayout.AbsoluteToLocal(EventInfo.Location);
    if TInteractiveGestureFlag.gfBegin in EventInfo.Flags then
      AniMouseDown(True, LP.X, LP.Y)
    else if EventInfo.Flags = [] then
      AniMouseMove(True, LP.X, LP.Y)
    else if FAniCalculations.Down then
      AniMouseUp(True, LP.X, LP.Y);
  end
  else
    inherited;
end;

initialization
  TPresentationProxyFactory.Current.Register(TPresentedScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedHorzScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedVertScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedFramedScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Register(TPresentedFramedVertScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
finalization
  TPresentationProxyFactory.Current.Unregister(TPresentedScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedHorzScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedVertScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedFramedScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Unregister(TPresentedFramedVertScrollBox, TControlType.Styled, TStyledPresentationProxy<TStyledCustomScrollBox>);
end.
