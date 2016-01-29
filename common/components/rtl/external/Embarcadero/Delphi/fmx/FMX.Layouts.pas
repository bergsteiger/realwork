{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Layouts;

interface

uses
  System.Classes, System.Types, System.Generics.Collections, System.UITypes, System.SysUtils,
  FMX.Types, FMX.Ani, FMX.StdCtrls, FMX.Platform, FMX.Controls,
  FMX.InertialMovement;

type

{ TLayout }

  TLayout = class(TControl)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ TScaledLayout }

  TScaledLayout = class(TControl)
  private
    FOriginalWidth: Single;
    FOriginalHeight: Single;
    procedure SetOriginalWidth(const Value: Single);
    procedure SetOriginalHeight(const Value: Single);
  protected
    procedure DoRealign; override;
    function GetChildrenMatrix(var Matrix: TMatrix; var Simple: Boolean): Boolean; override;
    procedure SetHeight(const Value: Single); override;
    procedure SetWidth(const Value: Single); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default False;
    property Padding;
    property Opacity;
    property OriginalWidth: Single read FOriginalWidth write SetOriginalWidth;
    property OriginalHeight: Single read FOriginalHeight write SetOriginalHeight;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

  TScrollBox = class;

{ TScrollContent }

  TScrollContent = class(TContent)
  private
    FScrollBox: TScrollBox;
  protected
    function GetClipRect: TRectF; override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    function GetUpdateRect: TRectF; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure DoRealign; override;
  public
    constructor Create(AOwner: TComponent); override;
    property ScrollBox: TScrollBox read FScrollBox;
  end;

  TScrollCalculations = class (TAniCalculations)
  private
    FScrollBox: TScrollBox;
  protected
    procedure DoChanged; override;
    procedure DoStart; override;
    procedure DoStop; override;
  public
    constructor Create(AOwner: TPersistent); override;
    property ScrollBox: TScrollBox read FScrollBox;
  end;

{ TScrollBox }

  TPositionChangeEvent = procedure (Sender: TObject;
                              const OldViewportPosition, NewViewportPosition: TPointF;
                              const ContentSizeChanged: Boolean) of object;

  TOnCalcContentBoundsEvent = procedure (Sender: TObject;
                                     var ContentBounds: TRectF) of object;

  TScrollBox = class(TStyledControl)
  private
  type
    TPanDirection = (pdUndecided, pdHorizontal, pdVertical,  pdArbitrary);
    TScrollInfo = record
      Scroll: TScrollBar;
      Align: TAlignLayout;
      Margins: TRectF;
    end;
  var
    FSystemInfoSrv: IFMXSystemInformationService;
    FDisableMouseWheel: Boolean;

    FAniCalculations: TScrollCalculations;
    FLastViewportPosition: TPointF;
    FInInternalAlign: Boolean;

    [weak]FBackground: TControl;
    FContent: TScrollContent;
    [weak]FContentLayout: TControl;
    FContentBounds: TRectF;
    FCachedContentSize: TSizeF;

    FShowScrollBars: Boolean;
    FAutoHide: Boolean;
    FHScrollInfo: array of TScrollInfo;
    FVScrollInfo: array of TScrollInfo;
    FContentMargins: TRectF;
    FVDisablePaint: Boolean;
    FHDisablePaint: Boolean;
    FGDisablePaint: Boolean;

    [weak]FSizeGripContent: TControl;
    [weak]FSizeGripParent: TControl;
    [weak]FSizeGrip: TControl;
    FShowSizeGrip: Boolean;
    FOnViewportPositionChange: TPositionChangeEvent;
    FOnHScrollChange: TNotifyEvent;
    FOnVScrollChange: TNotifyEvent;
    FOnCalcContentBounds: TOnCalcContentBoundsEvent;
    FMouseEvents: Boolean;
    function HScrollIndex: Integer;
    function VScrollIndex: Integer;
    function GetHScrollAlign: TAlignLayout;
    function GetVScrollAlign: TAlignLayout;
    function GetHScrollMargins: TRectF;
    function GetVScrollMargins: TRectF;
    function GetSceneScale: Single;
    procedure SetShowScrollBars(const Value: Boolean);
    procedure SetShowSizeGrip(const Value: Boolean);
    function GetVScrollBar: TScrollBar;
    function GetHScrollBar: TScrollBar;
    procedure InternalAlign;
    procedure HScrollChangeProc(Sender: TObject);
    procedure VScrollChangeProc(Sender: TObject);
    procedure MousePosToAni(var X, Y: Single);
    procedure SetAutoHide(const Value: Boolean);
    procedure SaveDisablePaint;
    procedure RestoreDisablePaint;
    procedure SetDisablePaint;
    function GetViewportPosition: TPointF;
    procedure SetViewportPosition(const Value: TPointF);
    procedure StartScrolling;
    procedure StopScrolling;
  protected
    //Animation mouse events
    procedure AniMouseDown(const Touch: Boolean; const X, Y: Single); virtual;
    procedure AniMouseMove(const Touch: Boolean; const X, Y: Single); virtual;
    procedure AniMouseUp(const Touch: Boolean; const X, Y: Single); virtual;

    function GetScrollingBehaviours: TScrollingBehaviours;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRealign; override;
    function IsAddToContent(const AObject: TFmxObject): Boolean; virtual;
    procedure ContentAddObject(const AObject: TFmxObject); virtual;
    procedure ContentInsertObject(Index: Integer; const AObject: TFmxObject); virtual;
    procedure ContentBeforeRemoveObject(AObject: TFmxObject); virtual;
    procedure ContentRemoveObject(const AObject: TFmxObject); virtual;
    procedure HScrollChange; virtual;
    procedure VScrollChange; virtual;
    procedure ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                     const ContentSizeChanged: boolean); virtual;
    procedure Painting; override;
    procedure AfterPaint; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function IsOpaque: Boolean; virtual;
    function ContentRect: TRectF;
    function VScrollBarValue: Single;
    function HScrollBarValue: Single;
    function CreateScrollContent: TScrollContent; virtual;
    function CreateAniCalculations: TScrollCalculations; virtual;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); virtual;
    procedure UpdateAniCalculations;
    function DoCalcContentBounds: TRectF; virtual;
    procedure DoRealignContent(R: TRectF); virtual;
    function GetContentBounds: TRectF;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseLeave; override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    property ContentLayout: TControl read FContentLayout;
    property Content: TScrollContent read FContent;
    procedure AddToTabList(const AObject: TFmxObject); override;
    property HScrollAlign: TAlignLayout read GetHScrollAlign;
    property VScrollAlign: TAlignLayout read GetVScrollAlign;
    property HScrollMargins: TRectF read GetHScrollMargins;
    property VScrollMargins: TRectF read GetVScrollMargins;
    property InInternalAlign: Boolean read FInInternalAlign;
    property HScrollBar: TScrollBar read GetHScrollBar;
    property VScrollBar: TScrollBar read GetVScrollBar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CMGesture(var EventInfo: TGestureEventInfo); override;
    property AniCalculations: TScrollCalculations read FAniCalculations;
    property ViewportPosition: TPointF read GetViewportPosition write SetViewportPosition;
    procedure Sort(Compare: TFmxObjectSortCompare); override;
    procedure Center;
    procedure ScrollTo(const Dx, Dy: Single);
    procedure InViewRect(const Rect: TRectF);
    function ClientWidth: Single;
    function ClientHeight: Single;
    procedure GetTabOrderList(const List: TInterfaceList; AChildren: Boolean); override;
    property ContentBounds: TRectF read GetContentBounds;
    procedure InvalidateContentSize;
    procedure RealignContent;
    property OnViewportPositionChange: TPositionChangeEvent read FOnViewportPositionChange write FOnViewportPositionChange;
    property OnHScrollChange: TNotifyEvent read FOnHScrollChange write FOnHScrollChange;
    property OnVScrollChange: TNotifyEvent read FOnVScrollChange write FOnVScrollChange;
    property OnCalcContentBounds: TOnCalcContentBoundsEvent read FOnCalcContentBounds write FOnCalcContentBounds;
  published
    property Align;
    property Anchors;
    property AutoHide: Boolean read FAutoHide write SetAutoHide default True;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property DisableMouseWheel: Boolean read FDisableMouseWheel write FDisableMouseWheel default False;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowScrollBars: Boolean read FShowScrollBars write SetShowScrollBars default True;
    property ShowSizeGrip: Boolean read FShowSizeGrip write SetShowSizeGrip default False;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ TVertScrollBox }

  TVertScrollBox = class(TScrollBox)
  private
  protected
    function GetDefaultStyleLookupName: string; override;
    function DoCalcContentBounds: TRectF; override;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); override;
  end;

  THorzScrollBox = class(TScrollBox)
  protected
    function GetDefaultStyleLookupName: string; override;
    function DoCalcContentBounds: TRectF; override;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); override;
  end;


{ TFramedScrollBox }

  TFramedScrollBox = class(TScrollBox)
  protected
    function IsOpaque: Boolean; override;
  public
  end;

{ TFramedVertScrollBox }

  TFramedVertScrollBox = class(TVertScrollBox)
  protected
    function IsOpaque: Boolean; override;
    function GetDefaultStyleLookupName: string; override;
  end;

{ TGridLayout }

  TGridLayout = class(TControl)
  private
    FItemWidth: Single;
    FItemHeight: Single;
    FOrientation: TOrientation;
    procedure SetItemHeight(const Value: Single);
    procedure SetItemWidth(const Value: Single);
    procedure SetOrientation(const Value: TOrientation);
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
//    property Hint;
    property HitTest default True;
    property ItemHeight: Single read FItemHeight write SetItemHeight;
    property ItemWidth: Single read FItemWidth write SetItemWidth;
    property Padding;
    property Opacity;
    property Orientation: TOrientation read FOrientation write SetOrientation;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
//    property ShowHint default False;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
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

  TFlowJustify = (fjLeft, fjRight, fjCenter, fjJustify);
  TFlowDirection = (fdLeftToRight, fdRightToLeft);

  TFlowLayoutRules = record
    Justify : TFlowJustify;
    JustifyLast : TFlowJustify;
    Direction : TFlowDirection;
    HorizontalGap : Single;
    VerticalGap : Single;
  end;

  TFlowLayoutBreak = class(TControl)
  private
    FRules : TFlowLayoutRules;
    FChangesRules : Boolean;
  protected
    procedure SetChangesRules(AChangesRules : Boolean);
    procedure Paint; override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property ChangesRules : Boolean read FChangesRules write SetChangesRules;

    property Justify : TFlowJustify read FRules.Justify write FRules.Justify;
    property JustifyLastLine : TFlowJustify read FRules.JustifyLast write FRules.JustifyLast;
    property FlowDirection : TFlowDirection read FRules.Direction write FRules.Direction;
    property HorizontalGap : Single read FRules.HorizontalGap write FRules.HorizontalGap;
    property VerticalGap : Single read FRules.VerticalGap write FRules.VerticalGap;

    property Visible default False;
    property DesignVisible default False;
  end;

  TFlowLayout = class(TControl)
  private
    FRules : TFlowLayoutRules;
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;

    procedure SetJustify(AJustify : TFlowJustify);
    procedure SetJustifyLast(AJustify : TFlowJustify);
    procedure SetFlowDirection(ADirection : TFlowDirection);
    procedure SetHGap(AHGap : Single);
    procedure SetVGap(AVGap : Single);

  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
//    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Mouse events}
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property Justify : TFlowJustify read FRules.Justify write SetJustify;
    property JustifyLastLine : TFlowJustify read FRules.JustifyLast write SetJustifyLast;
    property FlowDirection : TFlowDirection read FRules.Direction write SetFlowDirection;
    property HorizontalGap : Single read FRules.HorizontalGap write SetHGap;
    property VerticalGap : Single read FRules.VerticalGap write SetVGap;
  end;

implementation

uses System.Math, System.SysConst, System.RTLConsts, FMX.Styles, FMX.Consts;

type

TOpenFxmObject = class (TFMXObject)

end;

{ TLayout }

constructor TLayout.Create(AOwner: TComponent);
begin
  inherited;
  CanParentFocus := True;
  HitTest := False;
end;

destructor TLayout.Destroy;
begin
  inherited;
end;

procedure TLayout.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

{ TScrollContent }

constructor TScrollContent.Create(AOwner: TComponent);
begin
  inherited;
  if AOwner is TScrollBox then
    FScrollBox := TScrollBox(AOwner);
  ClipChildren := True;
  SetAcceptsControls(False);
end;

function TScrollContent.GetClipRect: TRectF;
var
  LScrollBox: TScrollBox;
  Done: Boolean;
  LPos: TPointF;
begin
  Done := False;
  if (Owner is TScrollBox) then
  begin
    LScrollBox := TScrollBox(Owner);
    if Assigned(LScrollBox.ContentLayout) and
       Assigned(LScrollBox.AniCalculations) then
    begin
      Result := LScrollBox.ContentLayout.LocalRect;
      LPos := LScrollBox.ViewportPosition;
      Result.Offset(LPos);
      Done := True;
    end;
  end;
  if not Done then
    Result := inherited GetClipRect;
end;

function TScrollContent.ObjectAtPoint(P: TPointF): IControl;
begin
  Result := inherited ObjectAtPoint(P);
  if Assigned(Result) then
  begin
    if Assigned(FScene) then
      P := FScene.ScreenToLocal(P);
    P := AbsoluteToLocal(P);
    if not ClipRect.Contains(P) then
      Result := nil;
  end;
end;

procedure TScrollContent.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if Assigned(Owner) and (Owner is TScrollBox) then
    TScrollBox(Owner).ContentAddObject(AObject);
end;

procedure TScrollContent.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  inherited;
  if Assigned(Owner) and (Owner is TScrollBox) then
    TScrollBox(Owner).ContentInsertObject(Index, AObject);
end;

procedure TScrollContent.DoRealign;
begin
  inherited;
  FLastWidth := Width;
  FLastHeight := Height;
end;

procedure TScrollContent.DoRemoveObject(const AObject: TFmxObject);
begin
  if Assigned(Owner) and (Owner is TScrollBox) then
    TScrollBox(Owner).ContentBeforeRemoveObject(AObject);
  inherited;
  if Assigned(Owner) and (Owner is TScrollBox) then
    TScrollBox(Owner).ContentRemoveObject(AObject);
end;

function TScrollContent.GetUpdateRect: TRectF;
begin
  if FRecalcUpdateRect then
  begin
    if (ParentControl is TScrollBox) then
    begin
      if Assigned(TScrollBox(ParentControl).ContentLayout) then
        FUpdateRect := TScrollBox(ParentControl).ContentLayout.UpdateRect
      else
        FUpdateRect := TScrollBox(ParentControl).UpdateRect;
    end;
    FRecalcUpdateRect := False;
  end;
  Result := FUpdateRect;
end;

{ TScrollCalculations }

constructor TScrollCalculations.Create(AOwner: TPersistent);
begin
  if not (AOwner is TScrollBox) then
    raise EArgumentException.Create(sArgumentInvalid);
  inherited;
  FScrollBox := TScrollBox(AOwner);
end;

procedure TScrollCalculations.DoChanged;
begin
  if Assigned(FScrollBox) and (not (csDestroying in FScrollBox.ComponentState)) then
    FScrollBox.InternalAlign;
  inherited;
end;

procedure TScrollCalculations.DoStart;
begin
  inherited;
  if Assigned(FScrollBox) and (not (csDestroying in FScrollBox.ComponentState)) then
    FScrollBox.StartScrolling;
end;

procedure TScrollCalculations.DoStop;
begin
  inherited;
  if Assigned(FScrollBox) and (not (csDestroying in FScrollBox.ComponentState)) then
    FScrollBox.StopScrolling;
end;

{ TScrollBox }

type
  TOpenScrollBar = class(TScrollBar);
  TOpenControl = class (TControl);

constructor TScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(FHScrollInfo, 2);
  SetLength(FVScrollInfo, 2);
  SupportsPlatformService(IFMXSystemInformationService, IInterface(FSystemInfoSrv));
  AutoCapture := True;
  FAutoHide := True;
  FShowScrollBars := True;
  FContent := CreateScrollContent;
  FContent.Parent := Self;
  FContent.Stored := False;
  FContent.Locked := True;
  FContent.HitTest := False;
  UpdateAniCalculations;
  Touch.DefaultInteractiveGestures := Touch.DefaultInteractiveGestures + [TInteractiveGesture.igPan];
  Touch.InteractiveGestures := Touch.InteractiveGestures + [TInteractiveGesture.igPan];
end;

destructor TScrollBox.Destroy;
begin
  FreeAndNil(FContent);
  FreeAndNil(FAniCalculations);
  inherited;
end;

{$REGION 'animation'}
function TScrollBox.CreateAniCalculations: TScrollCalculations;
begin
  Result := TScrollCalculations.Create(self);
end;

procedure TScrollBox.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  AAniCalculations.Animation := TScrollingBehaviour.sbAnimation in GetScrollingBehaviours;
  if TScrollingBehaviour.sbTouchTracking in GetScrollingBehaviours then
    AAniCalculations.TouchTracking := [ttVertical, ttHorizontal]
  else
    AAniCalculations.TouchTracking := [];
  AAniCalculations.BoundsAnimation := TScrollingBehaviour.sbBoundsAnimation in GetScrollingBehaviours;
  AAniCalculations.AutoShowing := TScrollingBehaviour.sbAutoShowing in GetScrollingBehaviours;
end;

procedure TScrollBox.UpdateAniCalculations;
begin
  if not (csDestroying in ComponentState) then
  begin
    if not Assigned(FAniCalculations) then
      FAniCalculations := CreateAniCalculations;
    DoUpdateAniCalculations(FAniCalculations);
  end;
end;

function TScrollBox.GetSceneScale: Single;
begin
  Result := 0;
  if Assigned(Scene) then
    Result := Scene.GetSceneScale;
  if Result <= 0 then
    Result := 1;
end;

procedure TScrollBox.InternalAlign;
var Point, NewViewportPosition, LViewportPosition: TPointF;
    ContentLayoutSize: TSizeF;
    R: TRectF;
    I: integer;
    Adjust, SizeChanged: Boolean;
    LScale: Single;
    TmpContentBounds: TRectF;
  procedure UpdateVisibleScrollBars;
  begin
    if Assigned(FVScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll) then
      FVScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll.Visible := False;
    if Assigned(FHScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll) then
      FHScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll.Visible := False;
    if Assigned(VScrollBar) then
    begin
      VScrollBar.Opacity := AniCalculations.Opacity;
      VScrollBar.Enabled := (FContentBounds.Height > ContentLayoutSize.Height) or
                            (AniCalculations.AutoShowing);
      VScrollBar.Visible := FShowScrollBars and
                           ((FContentBounds.Height > ContentLayoutSize.Height) or
                            (not FAutoHide));
      VScrollBar.HitTest := not AniCalculations.AutoShowing;
      VScrollBar.Locked := VScrollBar.HitTest;
    end;
    if Assigned(HScrollBar) then
    begin
      HScrollBar.Opacity := AniCalculations.Opacity;
      HScrollBar.Enabled := (FContentBounds.Width > ContentLayoutSize.Width) or
                            (AniCalculations.AutoShowing);
      HScrollBar.Visible := FShowScrollBars and
                           ((FContentBounds.Width > ContentLayoutSize.Width) or
                            (not FAutoHide));
      HScrollBar.HitTest := not AniCalculations.AutoShowing;
      HScrollBar.Locked := HScrollBar.HitTest;
    end;
  end;
  procedure UpdateSizeGrip;
  var R, GripRect: TRectF;
      GripLeft, GripTop, SizeGripVisible, Both: Boolean;

  begin
    SizeGripVisible := ShowSizeGrip and
                       Assigned(FSizeGrip) and
                       Assigned(FSizeGripParent) and
                       Assigned(FSizeGripContent);
    Both := (Assigned(VScrollBar) and VScrollBar.Visible) and
            (Assigned(HScrollBar) and HScrollBar.Visible);
    if Both or
       (SizeGripVisible and
        ((Assigned(VScrollBar) and VScrollBar.Visible) or
         (Assigned(HScrollBar) and HScrollBar.Visible))) then
    begin
      {$REGION 'size'}
      GripRect.Create(0, 0, 0, 0);
      if Assigned(HScrollBar) then
        GripRect.Height := HScrollBar.Height
      else
        GripRect.Height := VScrollBar.Width;
      if Assigned(VScrollBar) then
        GripRect.Width := VScrollBar.Width
      else
        GripRect.Width := HScrollBar.Height;
      {$ENDREGION}
      {$REGION 'vert align'}
      GripTop := Assigned(HScrollBar) and
                  (not (HScrollAlign in [TAlignLayout.alBottom, TAlignLayout.alMostBottom]));
      if Assigned(FSizeGrip) then
      begin
        if GripTop then
          FSizeGrip.Align := TAlignLayout.alTop
        else
          FSizeGrip.Align := TAlignLayout.alBottom;
        FSizeGrip.BoundsRect := GripRect;
      end;
      {$ENDREGION}
      {$REGION 'horz align'}
      GripLeft := Assigned(VScrollBar) and
                  (not (VScrollAlign in [TAlignLayout.alRight, TAlignLayout.alMostRight]));
      if Assigned(FSizeGripContent) then
        FSizeGripContent.Align := TAlignLayout.alContents;
      if Assigned(FSizeGripParent) then
      begin
        if GripLeft then
          FSizeGripParent.Align := TAlignLayout.alLeft
        else
          FSizeGripParent.Align := TAlignLayout.alRight;
        FSizeGripParent.Width := GripRect.Width;
      end;
      {$ENDREGION}
      if Assigned(HScrollBar) and HScrollBar.Visible then
      begin
        R := HScrollMargins;
        if GripLeft then
          R.Left := R.Left + GripRect.Width
        else
          R.Right := R.Right + GripRect.Width;
        HScrollBar.Margins.Rect := R;
        if Assigned(VScrollBar) then
          VScrollBar.Margins.Rect := VScrollMargins;
      end
      else if Assigned(VScrollBar) and VScrollBar.Visible then
      begin
        R := VScrollMargins;
        if GripTop then
          R.Top := R.Top + GripRect.Height
        else
          R.Bottom := R.Bottom + GripRect.Height;
        VScrollBar.Margins.Rect := R;
      end;
      if Assigned(FSizeGripParent) then
        FSizeGripParent.Visible := True;
      if Assigned(FSizeGripContent) then
        FSizeGripContent.Visible := True;
      if Assigned(FSizeGrip) then
      begin
        FSizeGrip.Opacity := AniCalculations.Opacity;
        FSizeGrip.Visible := SizeGripVisible;
        FSizeGrip.Enabled := (Align in [TAlignLayout.alClient, TAlignLayout.alContents]) and
                             (not GripTop) and (not GripLeft);
      end;
    end
    else
    begin
      if Assigned(FSizeGrip) then
        FSizeGrip.Visible := False;
      if Assigned(FSizeGripContent) then
        FSizeGrip.Visible := False;
      if Assigned(VScrollBar) and Assigned(VScrollBar.Margins) then
        VScrollBar.Margins.Rect := VScrollMargins;
      if Assigned(HScrollBar) and Assigned(HScrollBar.Margins) then
        HScrollBar.Margins.Rect := HScrollMargins;
    end;
  end;
  procedure UpdatePosition;
  var
    R: TRectF;
    procedure UpdateContentLayoutSize;
    begin
      ContentLayoutSize.Create(ContentLayout.Width,
                               ContentLayout.Height);
    end;
  begin
    ContentLayout.Margins.Rect := FContentMargins;
    if (ContentLayout.Align = TAlignLayout.alContents) and
       (Assigned(FBackground)) then
    begin
      R := ContentLayout.Margins.Rect;
      R.Left := R.Left + FBackground.Padding.Left;
      R.Top := R.Top + FBackground.Padding.Top;
      R.Right := R.Right + FBackground.Padding.Right;
      R.Bottom := R.Bottom + FBackground.Padding.Bottom;
      ContentLayout.Margins.Rect := R;
    end;
    Point.Create(ContentLayout.Position.Point);
    UpdateContentLayoutSize;
    UpdateVisibleScrollBars;
    if Assigned(AniCalculations) then
      LViewportPosition := ViewportPosition
    else
      LViewportPosition.Create(0, 0);
    Point.Offset(-LViewportPosition.X, -LViewportPosition.Y);
    if (FDisableAlign) and Assigned(FBackground) then
      TOpenControl(FBackground).Realign;
    UpdateContentLayoutSize;
  end;
  procedure UpdateTargets;
  var
    I, J: Integer;
    LTargets: array of TAniCalculations.TTarget;
    NewTargets: array of TAniCalculations.TTarget;
  begin
    if Assigned(AniCalculations) then
    begin
      SetLength(LTargets, AniCalculations.TargetCount);
      AniCalculations.GetTargets(LTargets);
      SetLength(NewTargets, 2);
      NewTargets[0].TargetType := TAniCalculations.TTargetType.ttMin;
      NewTargets[0].Point.X := FContentBounds.Left;
      NewTargets[0].Point.Y := FContentBounds.Top;
      NewTargets[1].TargetType := TAniCalculations.TTargetType.ttMax;
      NewTargets[1].Point.X := Max(FContentBounds.Left, FContentBounds.Right - ContentLayoutSize.Width);
      NewTargets[1].Point.Y := Max(FContentBounds.Top, FContentBounds.Bottom - ContentLayoutSize.Height);
      for I := 0 to Length(LTargets) - 1 do
      if not (LTargets[I].TargetType in [TAniCalculations.TTargetType.ttMin, TAniCalculations.TTargetType.ttMax]) then
      begin
        J := Length(NewTargets);
        SetLength(NewTargets, J + 1);
        NewTargets[J].TargetType := LTargets[I].TargetType;
        NewTargets[J].Point := LTargets[I].Point;
      end;
      AniCalculations.SetTargets(NewTargets);
    end;
  end;
begin
  if (not FInInternalAlign) and
      Assigned(ContentLayout) and
      Assigned(Content) and
      Assigned(AniCalculations) then
  begin
    LScale := GetSceneScale;
    FInInternalAlign := True;
    try
      if (not AniCalculations.Down) and
         (AniCalculations.LowVelocity) then
        AniCalculations.Shown := False;
      Adjust := False;
      I := 0;
      repeat
        UpdatePosition;
        inc(I);
        SizeChanged := FCachedContentSize <> ContentLayoutSize;
        if SizeChanged then
        begin
          TmpContentBounds := DoCalcContentBounds;
          if Assigned(OnCalcContentBounds) then
            OnCalcContentBounds(self, TmpContentBounds);
          FContentBounds := TmpContentBounds;
          FCachedContentSize := ContentLayoutSize;
          Adjust := True;
        end;
      until (not SizeChanged) or (I > 5);
      if Adjust then
        UpdateTargets;
      R.Create(Point, FContentBounds.Width, FContentBounds.Height);
      DoRealignContent(R);
      {$REGION 'update scroll bar values'}
      if Assigned(VScrollBar) then
      begin
        VScrollBar.ValueRange.BeginUpdate;
        try
          VScrollBar.ValueRange.Min := Min(LViewportPosition.Y, FContentBounds.Top);
          VScrollBar.ValueRange.Max := Max(LViewportPosition.Y + ContentLayoutSize.Height, FContentBounds.Bottom);
          VScrollBar.ValueRange.ViewportSize := ContentLayoutSize.Height;
          VScrollBar.Value := LViewportPosition.Y;
        finally
          VScrollBar.ValueRange.EndUpdate;
        end;
        VScrollBar.SmallChange := VScrollBar.ViewportSize / 5;
      end;
      if Assigned(HScrollBar) then
      begin
        HScrollBar.ValueRange.BeginUpdate;
        try
          HScrollBar.ValueRange.Min := Min(LViewportPosition.X, FContentBounds.Left);
          HScrollBar.ValueRange.Max := Max(LViewportPosition.X + ContentLayoutSize.Width, FContentBounds.Right);
          HScrollBar.ValueRange.ViewportSize := ContentLayoutSize.Width;
          HScrollBar.Value := LViewportPosition.X;
        finally
          HScrollBar.ValueRange.EndUpdate;
        end;
        HScrollBar.SmallChange := HScrollBar.ViewportSize / 5;
      end;
      {$ENDREGION}
      UpdateSizeGrip;
      NewViewportPosition.X := LViewportPosition.X;
      NewViewportPosition.Y := LViewportPosition.Y;
      NewViewportPosition.X := Round(NewViewportPosition.X * LScale) / LScale;
      NewViewportPosition.Y := Round(NewViewportPosition.Y * LScale) / LScale;
      if Adjust or
         (not SameValue(FLastViewportPosition.X, NewViewportPosition.X, Epsilon)) or
         (not SameValue(FLastViewportPosition.Y, NewViewportPosition.Y, Epsilon)) then
      try
        ViewportPositionChange(FLastViewportPosition, NewViewportPosition, Adjust);
      finally
        FLastViewportPosition := NewViewportPosition;
      end;
      if Adjust then
        Repaint;
    finally
      FInInternalAlign := False;
    end;
  end;
end;

{$ENDREGION}

procedure TScrollBox.AddToTabList(const AObject: TFmxObject);
begin
end;

procedure TScrollBox.ApplyStyle;
var
  B: TFmxObject;
  function CheckParent(Control: TControl): boolean;
  begin
    Result := Assigned(Control) and
              (Control.Parent <> FBackground) and
              (Control.Parent <> self) and
              (Control.Parent is TControl)
  end;

  procedure UpdateScroll(AStyleLookup: string;
                         var Info: array of TScrollInfo;
                         Small: Boolean;
                         Proc: TNotifyEvent);
  var
    B: TFmxObject;
  begin
    B := FindStyleResource(AStyleLookup);
    if Assigned(B) and (B is TScrollBar) then
    begin
      Info[Integer(Small)].Scroll := TScrollBar(B);
      Info[Integer(Small)].Scroll.OnChange := Proc;
      Info[Integer(Small)].Scroll.Visible := False;
      Info[Integer(Small)].Scroll.Locked := True;
      Info[Integer(Small)].Align := TScrollBar(B).Align;
      Info[Integer(Small)].Margins := TScrollBar(B).Margins.Rect;
    end
    else
    begin
      Info[Integer(Small)].Scroll := nil;
      Info[Integer(Small)].Align := TAlignLayout.alNone;
      Info[Integer(Small)].Margins.Create(0, 0, 0, 0);
    end;
  end;
begin
  inherited;
  B := FindStyleResource('background');
  if Assigned(B) and (B is TControl) then
  begin
    FBackground := TControl(B);
  end;

  UpdateScroll('vscrollbar', FVScrollInfo, False, VScrollChangeProc);
  UpdateScroll('hscrollbar', FHScrollInfo, False, HScrollChangeProc);
  UpdateScroll('vsmallscrollbar', FVScrollInfo, True, VScrollChangeProc);
  UpdateScroll('hsmallscrollbar', FHScrollInfo, True, HScrollChangeProc);

  B := FindStyleResource('sizegrip');
  if Assigned(B) and (B is TControl) then
  begin
    FSizeGrip := TControl(B);
    FSizeGrip.Visible := False;
    FSizeGrip.Align := TAlignLayout.alBottom;

    if CheckParent(FSizeGrip) then
      FSizeGripParent := TControl(FSizeGrip.Parent);
    if CheckParent(FSizeGripParent) then
      FSizeGripContent := TControl(FSizeGripParent.Parent);

    if Assigned(FSizeGripParent) then
      FSizeGripParent.Align := TAlignLayout.alRight;
    if Assigned(FSizeGripContent) then
    begin
      FSizeGripContent.Visible := False;
      FSizeGripParent.Align := TAlignLayout.alContents;
    end;
  end;

  B := FindStyleResource('content');
  if Assigned(B) and (B is TControl) then
  begin
    FContentLayout := TControl(B);
    FContentMargins := FContentLayout.Margins.Rect;
  end;
  Realign;
end;

procedure TScrollBox.FreeStyle;
var
  I: Integer;
begin
  inherited;
  for I := Low(FHScrollInfo) to High(FHScrollInfo) do
  begin
    FHScrollInfo[I].Scroll := nil;
    FHScrollInfo[I].Margins.Create(0, 0, 0, 0);
  end;
  for I := Low(FVScrollInfo) to High(FVScrollInfo) do
  begin
    FVScrollInfo[I].Scroll := nil;
    FVScrollInfo[I].Margins.Create(0, 0, 0, 0);
  end;
  FSizeGripParent := nil;
  FSizeGripContent := nil;
  FContentLayout := nil;
  FBackground := nil;
  FSizeGrip := nil;
end;

function TScrollBox.DoCalcContentBounds: TRectF;
var
  i: Integer;
  R, LocalR: TRectF;
begin
  Result.Create(0, 0, 0, 0);
  if Assigned(FContent) and Assigned(ContentLayout) then
  begin
    R := ContentLayout.LocalRect;
    for i := 0 to FContent.ControlsCount - 1 do
    if FContent.Controls[i].Visible then
    begin
      {$IFDEF MSWINDOWS}
      if (csDesigning in ComponentState)
        and Supports(FContent.Controls[i], IDesignerControl) then Continue;
      {$ENDIF}
      LocalR := FContent.Controls[i].ParentedRect;
      if (FContent.Controls[i].Align in [TAlignLayout.alTop, TAlignLayout.alMostTop, TAlignLayout.alBottom, TAlignLayout.alMostBottom]) or
         (TAnchorKind.akRight in FContent.Controls[i].Anchors) then
        LocalR.Right := R.Right;
      if (FContent.Controls[i].Align in [TAlignLayout.alLeft, TAlignLayout.alMostLeft, TAlignLayout.alRight, TAlignLayout.alMostRight]) or
         (TAnchorKind.akBottom in FContent.Controls[i].Anchors) then
        LocalR.Bottom := R.Bottom;

      Result.Union(LocalR);
    end;
  end;
end;

function TScrollBox.GetContentBounds: TRectF;
begin
  Result := FContentBounds;
end;

function TScrollBox.HScrollIndex: Integer;
var
  B: Boolean;
begin
  B := AniCalculations.AutoShowing;
  if Assigned(FHScrollInfo[Integer(B)].Scroll) then
    Result := Integer(B)
  else
  begin
    B := not B;
    if Assigned(FHScrollInfo[Integer(B)].Scroll) then
      Result := Integer(B)
    else
      Result := -1;
  end;
end;

function TScrollBox.VScrollIndex: Integer;
var
  B: Boolean;
begin
  B := AniCalculations.AutoShowing;
  if Assigned(FVScrollInfo[Integer(B)].Scroll) then
    Result := Integer(B)
  else
  begin
    B := not B;
    if Assigned(FVScrollInfo[Integer(B)].Scroll) then
      Result := Integer(B)
    else
      Result := -1;
  end;
end;

function TScrollBox.GetHScrollAlign: TAlignLayout;
var
  I: Integer;
begin
  I := HScrollIndex;
  if I >= 0 then
    Result := FHScrollInfo[I].Align
  else
    Result := TAlignLayout.alNone;
end;

function TScrollBox.GetHScrollBar: TScrollBar;
var
  I: Integer;
begin
  I := HScrollIndex;
  if I >= 0 then
    Result := FHScrollInfo[I].Scroll
  else
    Result := nil;
end;

function TScrollBox.GetHScrollMargins: TRectF;
var
  I: Integer;
begin
  I := HScrollIndex;
  if I >= 0 then
    Result := FHScrollInfo[I].Margins
  else
    Result.Create(0, 0, 0, 0);
end;

function TScrollBox.GetVScrollAlign: TAlignLayout;
var
  I: Integer;
begin
  I := VScrollIndex;
  if I >= 0 then
    Result := FVScrollInfo[I].Align
  else
    Result := TAlignLayout.alNone;
end;

function TScrollBox.GetVScrollBar: TScrollBar;
var
  I: Integer;
begin
  I := VScrollIndex;
  if I >= 0 then
    Result := FVScrollInfo[I].Scroll
  else
    Result := nil;
end;

function TScrollBox.GetVScrollMargins: TRectF;
var
  I: Integer;
begin
  I := VScrollIndex;
  if I >= 0 then
    Result := FVScrollInfo[I].Margins
  else
    Result.Create(0, 0, 0, 0);
end;

procedure TScrollBox.GetTabOrderList(const List: TInterfaceList;
  AChildren: Boolean);
begin
  if Assigned(FContent) then
    FContent.GetTabOrderList(List, AChildren)
  else
    inherited;
end;

procedure TScrollBox.DoRealignContent(R: TRectF);
begin
  if Assigned(FContent) then
  begin
    FContent.SetBounds(R.Left, R.Top, R.Width, R.Height);
    FContent.FRecalcUpdateRect := True;
    FContent.Realign;
  end;
end;

procedure TScrollBox.DoRealign;
var
  LDisablePaint, NewerMind: Boolean;
begin
  NewerMind := (csDestroying in ComponentState) or
               FDisableAlign or 
              (FUpdating > 0) or
              (csLoading in ComponentState) or
              (not Assigned(ContentLayout)) or
              (not Assigned(Content));
  LDisablePaint := FDisablePaint;
  try
    FDisablePaint := True;
    inherited;
    if not NewerMind then
    begin
      InternalAlign;
    end;
  finally
    FDisablePaint := LDisablePaint;
  end;
end;

function TScrollBox.ContentRect: TRectF;
begin
  if Assigned(ContentLayout) then
    Result := ContentLayout.ParentedRect
  else
    Result := LocalRect;
end;

procedure TScrollBox.ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                            const ContentSizeChanged: boolean);
begin
  if Assigned(FOnViewportPositionChange) then
    FOnViewportPositionChange(self,
                              OldViewportPosition,
                              NewViewportPosition,
                              ContentSizeChanged);
end;

function TScrollBox.VScrollBarValue: Single;
begin
  if Assigned(FAniCalculations) then
    Result := ViewportPosition.Y
  else
    Result := 0;
end;

function TScrollBox.HScrollBarValue: Single;
begin
  if Assigned(FAniCalculations) then
    Result := ViewportPosition.X
  else
    Result := 0;
end;

procedure TScrollBox.HScrollChangeProc(Sender: TObject);
begin
  if (not FInInternalAlign) and Assigned(AniCalculations) then
    HScrollChange;
end;

procedure TScrollBox.VScrollChangeProc(Sender: TObject);
begin
  if (not FInInternalAlign) and Assigned(AniCalculations) then
    VScrollChange;
end;

procedure TScrollBox.HScrollChange;
begin
  ViewportPosition := PointF(HScrollBar.Value, ViewportPosition.Y);
  if not IsOpaque then
    UpdateEffects;
  if Assigned(FOnHScrollChange) then
    FOnHScrollChange(self);
end;

procedure TScrollBox.VScrollChange;
begin
  ViewportPosition := PointF(ViewportPosition.X, VScrollBar.Value);
  if not IsOpaque then
    UpdateEffects;
  if Assigned(FOnVScrollChange) then
    FOnVScrollChange(self);
end;

function TScrollBox.CreateScrollContent: TScrollContent;
begin
  Result := TScrollContent.Create(Self);
end;

function TScrollBox.GetScrollingBehaviours: TScrollingBehaviours;
var
  StyleDescriptor: TStyleDescription;
begin
  if Assigned(Scene) then
    StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(Self)
  else
    StyleDescriptor := nil;
  if (Assigned(StyleDescriptor) and StyleDescriptor.PlatformTarget.Contains('[METROPOLISUI]')) then
    Result := [TScrollingBehaviour.sbAutoShowing]
  else begin
    if Assigned(FSystemInfoSrv) then
      Result := FSystemInfoSrv.GetScrollingBehaviour
    else
      Result := [];
  end;
end;

procedure TScrollBox.MousePosToAni(var X, Y: Single);
var
  LPoint: TPointF;
begin
  LPoint.Create(X, Y);
  if Assigned(ContentLayout) then
  begin
    LPoint := ContentLayout.AbsoluteToLocal(LocalToAbsolute(LPoint));
    X := LPoint.X;
    Y := LPoint.Y;
  end;
end;

procedure TScrollBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if (Button = TMouseButton.mbLeft) then
  begin
    MousePosToAni(X, Y);
    AniMouseDown(ssTouch in Shift, X, Y);
  end;
end;

procedure TScrollBox.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if AniCalculations.Down then
  begin
    MousePosToAni(X, Y);
    AniMouseMove(ssTouch in Shift, X, Y);
  end;
end;

procedure TScrollBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if (Button = TMouseButton.mbLeft) then
  begin
    MousePosToAni(X, Y);
    AniMouseUp(ssTouch in Shift, X, Y);
  end;
end;

procedure TScrollBox.DoMouseLeave;
begin
  inherited;
  if FMouseEvents and AniCalculations.Down then
  begin
    AniCalculations.MouseLeave;
    if (AniCalculations.LowVelocity) or
       (not AniCalculations.Animation) then
      AniCalculations.Shown := False;
  end;
end;

procedure TScrollBox.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  Offset: Single;
begin
  inherited;
  if (not (Handled or FDisableMouseWheel)) and Assigned(ContentLayout) then
  begin
  if ssHorizontal in Shift then
    begin
      if FContentBounds.Width > ContentLayout.Width then
      begin
        AniCalculations.Shown := True;
        if Assigned(HScrollBar) then
          Offset := HScrollBar.SmallChange
        else
          Offset := ContentLayout.Width / 5;
        Offset := Offset * -1 * (WheelDelta / 120);
        AniCalculations.MouseWheel(Offset, 0);
        Handled := True;
      end;
    end
    else if FContentBounds.Height > ContentLayout.Height then
    begin
      AniCalculations.Shown := True;
      if Assigned(VScrollBar) then
        Offset := VScrollBar.SmallChange
      else
        Offset := ContentLayout.Height / 5;
      Offset := Offset * -1 * (WheelDelta / 120);
      AniCalculations.MouseWheel(0, Offset);
      Handled := True;
    end
    else if FContentBounds.Width > ContentLayout.Width then
    begin
      AniCalculations.Shown := True;
      if Assigned(HScrollBar) then
        Offset := HScrollBar.SmallChange
      else
        Offset := ContentLayout.Width / 5;
      Offset := Offset * -1 * (WheelDelta / 120);
      AniCalculations.MouseWheel(Offset, 0);
      Handled := True;
    end;
  end;
end;

procedure TScrollBox.SaveDisablePaint;
begin
  FVDisablePaint := False;
  FHDisablePaint := False;
  FGDisablePaint := False;
  if Assigned(VScrollBar) then
  begin
    FVDisablePaint := TOpenControl(VScrollBar).FDisablePaint;
    TOpenControl(VScrollBar).FDisablePaint := True;
  end;
  if Assigned(HScrollBar) then
  begin
    FHDisablePaint := TOpenControl(HScrollBar).FDisablePaint;
    TOpenControl(HScrollBar).FDisablePaint := True;
  end;
  if Assigned(FSizeGrip) then
  begin
    FGDisablePaint := TOpenControl(FSizeGrip).FDisablePaint;
    TOpenControl(FSizeGrip).FDisablePaint := True;
  end;
end;

procedure TScrollBox.SetDisablePaint;
begin
  if Assigned(VScrollBar) then
    TOpenControl(VScrollBar).FDisablePaint := True;
  if Assigned(HScrollBar) then
    TOpenControl(HScrollBar).FDisablePaint := True;
  if Assigned(FSizeGrip) then
    TOpenControl(FSizeGrip).FDisablePaint := True;
end;

procedure TScrollBox.InvalidateContentSize;
begin
  FCachedContentSize.Create(0, 0);
  FContentBounds.Create(0, 0, 0, 0);
end;

procedure TScrollBox.RealignContent;
begin
  InvalidateContentSize;
  Realign;
end;

procedure TScrollBox.RestoreDisablePaint;
begin
  if Assigned(VScrollBar) then
    TOpenControl(VScrollBar).FDisablePaint := FVDisablePaint;
  if Assigned(HScrollBar) then
    TOpenControl(HScrollBar).FDisablePaint := FHDisablePaint;
  if Assigned(FSizeGrip) then
    TOpenControl(FSizeGrip).FDisablePaint := FGDisablePaint;
end;

procedure TScrollBox.Painting;
begin
  inherited;
  SaveDisablePaint;
  try
    SetDisablePaint;
  except
    RestoreDisablePaint;
    raise;
  end;
end;

procedure TScrollBox.AfterPaint;
begin
  try
    RestoreDisablePaint;
    if Assigned(VScrollBar) and
      (VScrollBar.Visible) and
      (VScrollBar.Opacity > 0) then
      TOpenControl(VScrollBar).PaintInternal;
    if Assigned(HScrollBar) and
      (HScrollBar.Visible) and
      (HScrollBar.Opacity > 0) then
      TOpenControl(HScrollBar).PaintInternal;
    if Assigned(FSizeGrip) and
      (FSizeGrip.Visible) and
      (FSizeGrip.Opacity > 0) then
      TOpenControl(FSizeGrip).PaintInternal;
  finally
    inherited;
  end;
end;

procedure TScrollBox.AniMouseDown(const Touch: Boolean; const X, Y: Single);
begin
  AniCalculations.Averaging := Touch;
  AniCalculations.MouseDown(X, Y);
end;

procedure TScrollBox.AniMouseMove(const Touch: Boolean; const X, Y: Single);
begin
  AniCalculations.MouseMove(X, Y);
  if AniCalculations.Moved then
    AniCalculations.Shown := True;
end;

procedure TScrollBox.AniMouseUp(const Touch: Boolean; const X, Y: Single);
begin
  AniCalculations.MouseUp(X, Y);
  if (AniCalculations.LowVelocity) or
     (not AniCalculations.Animation) then
    AniCalculations.Shown := False;
end;

procedure TScrollBox.DoAddObject(const AObject: TFmxObject);
begin
  if IsAddToContent(AObject) then
    FContent.AddObject(AObject)
  else
    inherited;
end;


procedure TScrollBox.Loaded;
begin
  inherited;
  FContent.Loaded; // ensure that FixupTabList is called for FContent
end;

procedure TScrollBox.Center;
begin
  if Assigned(VScrollBar) and (VScrollBar.Visible) then
  begin
    VScrollBar.Value := (VScrollBar.Max - VScrollBar.ViewportSize) / 2;
  end;
  if Assigned(HScrollBar) and (HScrollBar.Visible) then
  begin
    HScrollBar.Value := (HScrollBar.Max - HScrollBar.ViewportSize) / 2;
  end;
end;

procedure TScrollBox.ScrollTo(const Dx, Dy: Single);
begin
  if Assigned(VScrollBar) and (VScrollBar.Visible) then
    VScrollBar.Value := VScrollBar.Value - Dy;
  if Assigned(HScrollBar) and (HScrollBar.Visible) then
    HScrollBar.Value := HScrollBar.Value - Dx;
end;

procedure TScrollBox.InViewRect(const Rect: TRectF);
begin
end;

procedure TScrollBox.SetAutoHide(const Value: Boolean);
begin
  if FAutoHide <> Value then
  begin
    FAutoHide := Value;
    Realign;
  end;
end;

procedure TScrollBox.SetShowScrollBars(const Value: Boolean);
begin
  if FShowScrollBars <> Value then
  begin
    FShowScrollBars := Value;
    Realign;
  end;
end;

procedure TScrollBox.SetShowSizeGrip(const Value: Boolean);
begin
  if FShowSizeGrip <> Value then
  begin
    FShowSizeGrip := Value;
    Realign;
  end;
end;

function TScrollBox.GetViewportPosition: TPointF;
var
  LScale, X, Y: Double;
begin
  LScale := GetSceneScale;
  X := Round(AniCalculations.ViewportPosition.X * LScale) / LScale;
  Y := Round(AniCalculations.ViewportPosition.Y * LScale) / LScale;
  Result.Create(X, Y);
end;

procedure TScrollBox.SetViewportPosition(const Value: TPointF);
var
  LScale, X, Y: Double;
begin
  LScale := GetSceneScale;
  X := Value.X;
  Y := Value.Y;
  AniCalculations.ViewportPosition := TPointD.Create(Round(X * LScale) / LScale,
                                                     Round(Y * LScale) / LScale);
end;

procedure TScrollBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('UseSmallScrollBars', IgnoreBooleanValue, nil, False);
  Filer.DefineProperty('MouseTracking', IgnoreBooleanValue, nil, False);
end;

procedure TScrollBox.Sort(Compare: TFmxObjectSortCompare);
begin
  FContent.Sort(Compare);
end;

procedure TScrollBox.StartScrolling;
begin
  if Assigned(Scene) then
    Scene.ChangeScrollingState(Self, True);
end;

procedure TScrollBox.StopScrolling;
begin
  if Assigned(Scene) then
    Scene.ChangeScrollingState(nil, False);
end;

function TScrollBox.ClientHeight: Single;
begin
  if Assigned(ContentLayout) then
    Result := ContentLayout.Height
  else
    Result := Height;
end;

function TScrollBox.ClientWidth: Single;
begin
  if Assigned(ContentLayout) then
    Result := ContentLayout.Width
  else
    Result := Width;
end;

procedure TScrollBox.CMGesture(var EventInfo: TGestureEventInfo);
var
  LP: TPointF;
begin
  if EventInfo.GestureID = igiPan then
  begin
    FMouseEvents := False;
    LP := ContentLayout.AbsoluteToLocal(EventInfo.Location);
    if TInteractiveGestureFlag.gfBegin in EventInfo.Flags then
      AniMouseDown(True, LP.X, LP.Y)
    else
      if EventInfo.Flags = [] then
        AniMouseMove(True, LP.X, LP.Y)
      else
      if AniCalculations.Down then
        AniMouseUp(True, LP.X, LP.Y);
  end
  else
    inherited;
end;

function TScrollBox.IsAddToContent(const AObject: TFmxObject): Boolean;
begin
  Result := Assigned(FContent)
    and (AObject <> FContent)
    and (AObject <> ResourceLink)
    and not (AObject is TEffect)
    and not (AObject is TAnimation)
    and not ((AObject = FVScrollInfo[0].Scroll) or
             (AObject = FVScrollInfo[1].Scroll) or
             (AObject = FHScrollInfo[0].Scroll) or
             (AObject = FHScrollInfo[1].Scroll) or
             (AObject = FSizeGrip));
end;

function TScrollBox.IsOpaque: Boolean;
begin
  Result := False;
end;

procedure TScrollBox.ContentAddObject(const AObject: TFmxObject);
begin
  RealignContent;
end;

procedure TScrollBox.ContentInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  RealignContent;
end;

procedure TScrollBox.ContentRemoveObject(const AObject: TFmxObject);
begin
  RealignContent;
end;

procedure TScrollBox.ContentBeforeRemoveObject(AObject: TFmxObject);
begin
end;

{ TGridLayout }

procedure TGridLayout.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

procedure TGridLayout.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

constructor TGridLayout.Create(AOwner: TComponent);
begin
  inherited;
  FItemHeight := 64;
  FItemWidth := 64;
end;

procedure TGridLayout.DoRealign;
var
  I: Integer;
  CurPos: TPointF;
  LControl: TControl;
  LItemWidth, LItemHeight: Single;
begin
  if FDisableAlign then
    Exit;
  FDisableAlign := True;
  { content }
  CurPos := PointF(Padding.Left, Padding.Top);

  LItemWidth := FItemWidth;
  LItemHeight := FItemHeight;
  if (Orientation = TOrientation.orHorizontal)
    and (LItemWidth < 0) and (ControlsCount > 0) then
  begin
    LItemWidth := (Width - Padding.Left - Padding.Right) / ControlsCount;
    LItemHeight := Height - Padding.Top - Padding.Bottom;
  end
  else if (Orientation = TOrientation.orVertical)
    and (LItemHeight < 0) and (ControlsCount > 0) then
  begin
    LItemWidth := Width - Padding.Left - Padding.Right;
    LItemHeight := (Height - Padding.Top - Padding.Bottom) / ControlsCount;
  end;

  for I := 0 to ControlsCount - 1 do
  begin
    LControl := Controls[I];
    // Avoid realigning designer "things" like grab handles
    {$IFDEF MSWINDOWS}
    if (csDesigning in ComponentState)
      and Supports(LControl, IDesignerControl) then Continue;
    {$ENDIF}

    LControl.SetBounds(CurPos.X + LControl.Margins.Left, CurPos.Y + LControl.Margins.Top,
      LItemWidth - LControl.Margins.Left - LControl.Margins.Right, LItemHeight - LControl.Margins.Top -
      LControl.Margins.Bottom);
    if Orientation = TOrientation.orHorizontal then
    begin
      CurPos.X := CurPos.X + LItemWidth;
      if CurPos.X + LItemWidth > Self.Width - Self.Padding.Left -
        Self.Padding.Right then
      begin
        CurPos.X := Self.Padding.Left;
        CurPos.Y := CurPos.Y + LItemHeight;
      end;
    end
    else
    begin
      CurPos.Y := CurPos.Y + LItemHeight;
      if CurPos.Y + LItemHeight > Self.Height - Self.Padding.Top -
        Self.Padding.Bottom then
      begin
        CurPos.Y := Self.Padding.Top;
        CurPos.X := CurPos.X + LItemWidth;
      end;
    end;
  end;
  FDisableAlign := False;
end;

procedure TGridLayout.SetItemHeight(const Value: Single);
begin
  if FItemHeight <> Value then
  begin
    FItemHeight := Value;
    Realign;
  end;
end;

procedure TGridLayout.SetItemWidth(const Value: Single);
begin
  if FItemWidth <> Value then
  begin
    FItemWidth := Value;
    Realign;
  end;
end;

procedure TGridLayout.SetOrientation(const Value: TOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    Realign;
  end;
end;

{ TScaledLayout }

constructor TScaledLayout.Create(AOwner: TComponent);
begin
  inherited;
  HitTest := False;
  FOriginalWidth := Width;
  FOriginalHeight := Height;
end;

destructor TScaledLayout.Destroy;
begin
  inherited;
end;

procedure TScaledLayout.DoRealign;
begin
  if Assigned(Parent) and (Parent is TScrollBox) and
    (TScrollBox(Parent).FUpdating > 0) then
    Exit;

  if csDesigning in ComponentState then
    inherited DoRealign
  else
  begin
    if FNeedAlign then
      AlignObjects(Self, Padding, FOriginalWidth, FOriginalHeight, FLastWidth, FLastHeight, FDisableAlign);

    RecalcAbsolute;
    FRecalcUpdateRect := True;
  end;
end;

function TScaledLayout.GetChildrenMatrix(var Matrix: TMatrix; var Simple: Boolean): Boolean;
begin
  Result := True;
  if ((csDesigning in ComponentState)) then
  begin
    OriginalHeight := Height;
    OriginalWidth := Width;
  end;
  Matrix := IdentityMatrix;
  Matrix.m11 := Width / FOriginalWidth;
  Matrix.m22 := Height / FOriginalHeight;
  Simple := SameValue(Matrix.m11, 1.0, Epsilon) and SameValue(Matrix.m22, 1.0, Epsilon);
end;

procedure TScaledLayout.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
  inherited;
end;

procedure TScaledLayout.SetOriginalHeight(const Value: Single);
begin
  if FOriginalHeight <> Value then
  begin
    FOriginalHeight := Value;
    if FOriginalHeight < 1 then
      FOriginalHeight := 1;
    RecalcAbsolute;
  end;
end;

procedure TScaledLayout.SetOriginalWidth(const Value: Single);
begin
  if FOriginalWidth <> Value then
  begin
    FOriginalWidth := Value;
    if FOriginalWidth < 1 then
      FOriginalWidth := 1;
    RecalcAbsolute;
  end;
end;

procedure TScaledLayout.SetHeight(const Value: Single);
begin
  inherited;
  if (csDesigning in ComponentState) then
    OriginalHeight := Height
  else
    RecalcAbsolute;
end;

procedure TScaledLayout.SetWidth(const Value: Single);
begin
  inherited;
  if (csDesigning in ComponentState) then
    OriginalWidth := Width
  else
    RecalcAbsolute;
end;

{ TVertScrollBox }

function TVertScrollBox.DoCalcContentBounds: TRectF;
begin
  if Assigned(FContent) and Assigned(ContentLayout) then
  begin
    FContent.Width := ContentLayout.Width;
  end;
  Result := inherited DoCalcContentBounds;
end;

procedure TVertScrollBox.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  inherited DoUpdateAniCalculations(AAniCalculations);
  AAniCalculations.TouchTracking := AAniCalculations.TouchTracking - [ttHorizontal];
end;


function TVertScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := 'scrollboxstyle';
end;

{ THorzScrollBox }

function THorzScrollBox.DoCalcContentBounds: TRectF;
begin
  if Assigned(FContent) and Assigned(ContentLayout) then
  begin
    FContent.Height := ContentLayout.Height;
  end;
  Result := inherited DoCalcContentBounds;
end;

procedure THorzScrollBox.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  inherited DoUpdateAniCalculations(AAniCalculations);
  AAniCalculations.TouchTracking := AAniCalculations.TouchTracking - [ttVertical];
end;


function THorzScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := 'scrollboxstyle';
end;

{ TFramedVertScrollBox }

function TFramedVertScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := 'framedscrollboxstyle';
end;

function TFramedVertScrollBox.IsOpaque: Boolean;
begin
  Result := True;
end;

{ TFlowLayout }

procedure TFlowLayout.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

procedure TFlowLayout.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

constructor TFlowLayout.Create(AOwner: TComponent);
begin
  inherited;
  FRules.Justify := TFlowJustify.fjLeft;
  FRules.JustifyLast := TFlowJustify.fjLeft;
  FRules.Direction := TFlowDirection.fdLeftToRight;
  FRules.HorizontalGap := 0;
  FRules.VerticalGap := 0;
end;

procedure TFlowLayout.DoRealign;
  function ControlWidth(Control : TControl) : Single;
  begin
    if Control.Visible then
      Result := Control.Width + Control.Padding.Left + Control.Padding.Right
    else
      Result := 0;
  end;

  function ControlHeight(Control : TControl; const Rules: TFlowLayoutRules) : Single;
  begin
    if Control.Visible then
      Result := Control.Height
              + Control.Padding.Top + Control.Padding.Bottom
              + Rules.VerticalGap
    else
      Result := 0;
  end;

  function GetJustify(LastLine : Boolean; const Rules : TFlowLayoutRules) : TFlowJustify;
  begin
    if LastLine then
      Result := Rules.JustifyLast
    else
      Result := Rules.Justify;
  end;

  function Gap(first : Boolean) : Single;
  begin
    if first then
      Result := 0
    else
      Result := FRules.HorizontalGap;
  end;

type
  TState = (sNewLine, sMeasure, sPreLayout, sLayout, sEnd);
const
  InitialState: array [False..True] of TState = (sEnd, sNewLine);
var
  i : Integer;
  State : TState;
  CurPos : TPointF;
  Control : TControl;
  ControlBounds : TRectF;
  LineStartIdx, LineEndIdx : Integer;
  WidthAccu : Single;
  LineHeight : Single;
  ClientWidth : Single;
  Add : Single;
  NextWidth : Single;

  NextRules : TFlowLayoutRules;
  CurrentRules : TFlowLayoutRules;

begin
  if FDisableAlign or (Controls = nil) then
    Exit;

  FDisableAlign := true;

  CurPos := PointF(Margins.Left, Margins.Top);
  ClientWidth := Self.Width - Self.Margins.Left - Self.Margins.Right;
  LineHeight := 0;

  CurrentRules := Self.FRules;
  NextRules := Self.FRules;

  i := 0;
  LineStartIdx := i;
  LineEndIdx := i;
  WidthAccu := Margins.Left;
  Add := 0;
  State := InitialState[Controls.Count <> 0];
  while State <> sEnd do
  begin
    Control := TControl(Controls[i]);

    case State of
      sNewLine:
        begin
          CurrentRules := NextRules;

          LineStartIdx := i;
          LineEndIdx := i;
          WidthAccu := Margins.Left;
          CurPos.Y := CurPos.Y + LineHeight;
          LineHeight := ControlHeight(Control, CurrentRules);
          State := sMeasure;
        end;

      sMeasure:
        begin
          NextWidth := WidthAccu + Gap(i = LineStartIdx) + ControlWidth(Control);
          if Control is TFlowLayoutBreak then
          begin
            if TFlowLayoutBreak(Control).ChangesRules then
              NextRules := TFlowLayoutBreak(Control).FRules;
            i := LineStartIdx;
            State := sPreLayout;
          end
          else if (NextWidth > ClientWidth) then
          begin
            // width overflow, layout the line

            // update WidthAccu if the line has only 1 control
            if i = LineStartIdx then
              WidthAccu := NextWidth;

            i := LineStartIdx;
            State := sPreLayout;
          end
          else if i = Controls.Count - 1 then
          begin
            // no more controls, layout the line and done
            WidthAccu := NextWidth;
            LineHeight := Max(LineHeight, ControlHeight(Control, CurrentRules));
            LineEndIdx := i;
            i := LineStartIdx;
            State := sPreLayout;
          end
          else begin
            // keep counting width
            WidthAccu := NextWidth;
            LineEndIdx := i;
            LineHeight := Max(LineHeight, ControlHeight(Control, CurrentRules));
            Inc(i);
          end;
        end;

    sPreLayout:
      begin
        // Prepare to layout the line
        Add := 0;

        case GetJustify(LineEndIdx = (Controls.Count - 1), CurrentRules) of
          fjLeft:
            CurPos.X := Margins.Left;
          fjRight:
            CurPos.X := ClientWidth - WidthAccu;
          fjCenter:
            CurPos.X := Margins.Left + ClientWidth/2 - WidthAccu/2;
          fjJustify:
            begin
              CurPos.X := Margins.Left;
              if LineEndIdx - LineStartIdx > 0 then
                Add := (ClientWidth - WidthAccu) / (LineEndIdx - LineStartIdx);
            end;
        end;

        case CurrentRules.Direction of
          fdLeftToRight: i := LineStartIdx;
          fdRightToLeft: i := LineEndIdx;
        end;

        State := sLayout;
      end;

    sLayout:
      begin
        ControlBounds := Control.BoundsRect;
        ControlBounds.SetLocation(CurPos.X + Control.Padding.Left,
                                  CurPos.Y + Control.Padding.Top);

        if not ((csDesigning in ComponentState)
          and Supports(TControl(Self.Children[i]), IDesignerControl)) then
        begin
          Control.BoundsRect := ControlBounds;
          CurPos.X := CurPos.X + ControlWidth(Control) + Add + CurrentRules.HorizontalGap;
        end;

        // advance to the next control in line
        case CurrentRules.Direction of
          fdLeftToRight:
            begin
              if i = Controls.Count - 1 then
                State := sEnd
              else if i = LineEndIdx then
                State := sNewLine;

              Inc(i);
            end;
          fdRightToLeft:
            begin
              if i = LineStartIdx then
              begin
                i := LineEndIdx + 1;

                if LineEndIdx = Controls.Count - 1 then
                  State := sEnd
                else
                  State := sNewLine;
              end
              else
                Dec(i);
            end;
        end;
      end;
    end;
  end;
  FDisableAlign := false;
end;

procedure TFlowLayout.SetFlowDirection(ADirection: TFlowDirection);
begin
  FRules.Direction := ADirection;
  Realign;
end;

procedure TFlowLayout.SetJustify(AJustify: TFlowJustify);
begin
  FRules.Justify := AJustify;
  Realign;
end;

procedure TFlowLayout.SetJustifyLast(AJustify: TFlowJustify);
begin
  FRules.JustifyLast := AJustify;
  Realign;
end;

procedure TFlowLayout.SetHGap(AHGap: Single);
begin
  FRules.HorizontalGap := AHGap;
  Realign;
end;

procedure TFlowLayout.SetVGap(AVGap: Single);
begin
  FRules.VerticalGap := AVGap;
  Realign;
end;

{ TFlowLayoutBreak }

constructor TFlowLayoutBreak.Create(AOwner: TComponent);
begin
  inherited;
  Width := 4;
  Height := 15;
  Visible := False;
end;

procedure TFlowLayoutBreak.Paint;
begin
  Canvas.FillRect(LocalRect, 0, 0, [], AbsoluteOpacity, TCornerType.ctInnerLine);
  Canvas.DrawRect(LocalRect, 0, 0, [], AbsoluteOpacity, TCornerType.ctInnerLine);
end;

procedure TFlowLayoutBreak.SetChangesRules(AChangesRules: Boolean);
begin
  FChangesRules := AChangesRules;
end;

{ TFramedScrollBox }

function TFramedScrollBox.IsOpaque: Boolean;
begin
  Result := True;
end;

initialization
  RegisterFmxClasses([TLayout, TScaledLayout, TGridLayout,
    TFlowLayout, TFlowLayoutBreak, TScrollBox, TVertScrollBox, THorzScrollBox,
    TFramedScrollBox, TFramedVertScrollBox]);
end.
