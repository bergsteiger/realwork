{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Touch.GestureCtrls;

interface

uses
  Winapi.Windows, System.Classes, Winapi.Messages,
  Vcl.Controls, Vcl.ComCtrls, Vcl.Graphics, Vcl.GraphUtil, Vcl.Touch.Gestures,
  Vcl.Touch.GestureMgr, Vcl.ExtCtrls, System.Generics.Collections;

type
  TCustomGesturePreview = class;

  TGestureProviderChangeEvent = reference to procedure(Sender: TObject;
    AGesture: TCustomGestureCollectionItem);

  IGestureProvider = interface
    ['{2BBA64C5-CD16-4DF7-A89A-10903F6649BC}']
    procedure ChangeNotification(AComponent: TComponent;
      ASelectionChangeEvent: TGestureProviderChangeEvent);
    procedure RemoveChangeNotification(AComponent: TComponent);
  end;

  TGetGestureGroupEvent = procedure(Sender: TObject;
    Gesture: TCustomGestureCollectionItem; var GroupID: Integer) of object;
  TCreateSubItemsEvent = procedure(Sender: TObject;
    ListItem: TListItem; Gesture: TCustomGestureCollectionItem) of object;

  TCustomGestureListView = class(TCustomListView, IGestureProvider)
  protected type
    TGestureItemData = record
      Gesture: TCustomGestureCollectionItem;
      GroupID: Integer;
    end;
    TGestureItemDataArray = array of TGestureItemData;
  private
    FGestureData: TGestureItemDataArray;
    FGestureManager: TGestureManager;
    FGroupView: Boolean;
    FImages: TImageList;
    FImageSize: Integer;
    FNotifyList: TDictionary<TComponent, TGestureProviderChangeEvent>;
    FUpdateCount: Integer;
    FOnCreateSubItems: TCreateSubItemsEvent;
    FOnGetGestureGroup: TGetGestureGroupEvent;
    procedure AddGestureImage(const Points: array of TPoint);
    procedure RebuildListItem(ItemData: TGestureItemData); overload;
    procedure RebuildListItem(ItemData: TGestureItemData; ListItem: TListItem); overload;
    procedure SetGestureManager(const Value: TGestureManager);
    procedure SetGroupView(const Value: Boolean);
    procedure SetImageSize(const Value: Integer);
    procedure CMCustomGesturesChanged(var Message: TMessage); message CM_CUSTOMGESTURESCHANGED;
  protected
    procedure Change(Item: TListItem; Change: Integer); override;
    procedure CreateColumns; virtual;
    procedure CreateSubItems(ListItem: TListItem; Gesture: TCustomGestureCollectionItem); virtual;
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateGesture(GestureID: TGestureID); virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddGesture(Gesture: TCustomGestureCollectionItem; GroupID: Integer = -1); overload; virtual;
    procedure AddGesture(GestureID: TGestureID; GroupID: Integer = -1); overload; virtual;
    procedure AddGestures(Control: TControl; GroupID: Integer = -1); overload; virtual;
    procedure AddGestures(Gestures: TGestureArray; GroupID: Integer = -1); overload; virtual;
    procedure AddGestures(Gestures: TCustomGestureCollection; GroupID: Integer = -1); overload; virtual;
    procedure BeginUpdate;
    procedure ChangeNotification(AComponent: TComponent; ASelectionChangeEvent: TGestureProviderChangeEvent);
    procedure ClearGestureList;
    procedure EndUpdate;
    function GestureIDFromItem(Item: TListItem): TGestureID; inline;
    function ItemFromGestureID(GestureID: TGestureID): TListItem;
    procedure RefreshList;
    procedure RemoveChangeNotification(AComponent: TComponent);
    procedure RemoveGesture(GestureID: TGestureID); virtual;
    property GestureManager: TGestureManager read FGestureManager write SetGestureManager;
    property GroupView: Boolean read FGroupView write SetGroupView;
    property ImageSize: Integer read FImageSize write SetImageSize default 20;
    property OnCreateSubItems: TCreateSubItemsEvent read FOnCreateSubItems write FOnCreateSubItems;
    property OnGetGestureGroup: TGetGestureGroupEvent read FOnGetGestureGroup write FOnGetGestureGroup;
  end;

  TGestureListView = class(TCustomGestureListView)
  published
    property Align;
    property AllocBy;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Checkboxes;
    property Color;
    property Columns;
    property ColumnClick;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered default True;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property FullDrag;
    property GestureManager;
    property GridLines;
    property Groups;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property IconOptions;
    property MultiSelect;
    property OwnerDraw;
    property GroupHeaderImages;
    property GroupView default False;
    property ReadOnly default True;
    property RowSelect default True;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentDoubleBuffered default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ImageSize;
    property ShowColumnHeaders;
    property ShowWorkAreas;
    property ShowHint;
    property SortType;
    property TabOrder;
    property TabStop default True;
    property Touch;
    property ViewStyle default vsReport;
    property Visible;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnAdvancedCustomDrawSubItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnColumnDragged;
    property OnColumnRightClick;
    property OnCompare;
    property OnContextPopup;
    property OnCreateSubItems;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnCreateItemClass;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDblClick;
    property OnDeletion;
    property OnDrawItem;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetGestureGroup;
    property OnGetImageIndex;
    property OnGetSubItemImage;
    property OnDragDrop;
    property OnDragOver;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnItemChecked;
    property OnStartDock;
    property OnStartDrag;
  end;

  TCustomGesturePreview = class(TCustomControl)
  private type
    TAnimateDirection = (adForward, adBackward);
    TAnimateState = (asAnimating, asCompleted, asPaused, asRestarting);
  public type
    {$SCOPEDENUMS ON}
    TDrawingStyle = (dsNormal, dsGradient);
    {$SCOPEDENUMS OFF}
    TFrameStyle = psSolid..psDot;
    TLegendPosition = (lpNone, lpTop, lpBottom);
  public const
    DefGradientEndColor = $F0E5E6;
    DefGradientStartColor = $FDFDFD;
  private
    FAnimate: Boolean;
    FAnimateIndex: Integer;
    FAnimateDirection: TAnimateDirection;
    FAnimatedPointColor: TColor;
    FAnimateLastIndex: Integer;
    FAnimateLongDelay: Integer;
    FAnimatePoints: TGesturePointArray;
    FAnimateShortDelay: Integer;
    FAnimateState: TAnimateState;
    FAnimateStep: Integer;
    FDrawingStyle: TDrawingStyle;
    FDrawPoints: TGesturePointArray;
    FFrameColor: TColor;
    FFrameGesture: Boolean;
    FFrameStyle: TFrameStyle;
    FGesture: TCustomGestureCollectionItem;
    FGestureProvider: IGestureProvider;
    FGradientDirection: TGradientDirection;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FLegendRect: TRect;
    FLegendPosition: TLegendPosition;
    FMaxPreviewSize: Integer;
    FPreviewEndPointColor: TColor;
    FPreviewLineColor: TColor;
    FTimer: TTimer;
    function AdjustGesturePoint(Point: TPoint): TPoint;
    procedure AnimateGesture(Sender: TObject);
    function InterpolatePoints(const Points: TGesturePointArray): TGesturePointArray;
    procedure SetAnimate(const Value: Boolean);
    procedure SetAnimatedPointColor(const Value: TColor);
    procedure SetAnimateLongDelay(const Value: Integer);
    procedure SetAnimateShortDelay(const Value: Integer);
    procedure SetDrawingStyle(const Value: TDrawingStyle);
    procedure SetFrameColor(const Value: TColor);
    procedure SetFrameGesture(const Value: Boolean);
    procedure SetFrameStyle(const Value: TFrameStyle);
    procedure SetGestureProvider(const Value: IGestureProvider);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetGradientEndColor(const Value: TColor);
    procedure SetGradientStartColor(const Value: TColor);
    procedure SetGesture(const Value: TCustomGestureCollectionItem);
    procedure SetLegendPosition(const Value: TLegendPosition);
    procedure SetMaxPreviewSize(const Value: Integer);
    procedure SetPreviewEndPointColor(const Value: TColor);
    procedure SetPreviewLineColor(const Value: TColor);
  protected
    FInternalPreviewSize: Integer;
    FLegendText: string;
    FOffsetX: Integer;
    FOffsetY: Integer;
    procedure CreateWnd; override;
    procedure DrawBackground; virtual;
    procedure DrawGesturePoints; virtual;
    procedure DrawLegend; virtual;
    procedure DrawPoint(const P: TPoint; AColor: TColor); virtual;
    procedure EraseAnimatePoint(Index: Integer); virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure UpdatePosition; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartAnimation;
    procedure SuspendAnimation;
    property Animate: Boolean read FAnimate write SetAnimate default True;
    property AnimatedPointColor: TColor read FAnimatedPointColor
      write SetAnimatedPointColor default clBlue;
    property AnimateLongDelay: Integer read FAnimateLongDelay
      write SetAnimateLongDelay default 500;
    property AnimateShortDelay: Integer read FAnimateShortDelay
      write SetAnimateShortDelay default 75;
    property DrawingStyle: TDrawingStyle read FDrawingStyle
      write SetDrawingStyle default TDrawingStyle.dsNormal;
    property FrameColor: TColor read FFrameColor write SetFrameColor default clLtGray;
    property FrameGesture: Boolean read FFrameGesture write SetFrameGesture default True;
    property FrameStyle: TFrameStyle read FFrameStyle write SetFrameStyle default psDot;
    property Gesture: TCustomGestureCollectionItem read FGesture write SetGesture;
    property GestureProvider: IGestureProvider read FGestureProvider write SetGestureProvider;
    property GradientDirection: TGradientDirection read FGradientDirection
      write SetGradientDirection default gdVertical;
    property GradientEndColor: TColor read FGradientEndColor
      write SetGradientEndColor default DefGradientEndColor;
    property GradientStartColor: TColor read FGradientStartColor
      write SetGradientStartColor default DefGradientStartColor;
    property LegendPosition: TLegendPosition read FLegendPosition
      write SetLegendPosition default lpBottom;
    property MaxPreviewSize: Integer read FMaxPreviewSize write SetMaxPreviewSize default 0;
    property PreviewEndPointColor: TColor read FPreviewEndPointColor
      write SetPreviewEndPointColor default clGray;
    property PreviewLineColor: TColor read FPreviewLineColor
      write SetPreviewLineColor default clGray;
  end;

  TGesturePreview = class(TCustomGesturePreview)
  published
    property Align;
    property Anchors;
    property Animate;
    property AnimatedPointColor;
    property AnimateLongDelay;
    property AnimateShortDelay;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered default True;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DrawingStyle;
    property Enabled;
    property Font;
    property FrameColor;
    property FrameGesture;
    property FrameStyle;
    property GestureProvider;
    property GradientDirection;
    property GradientEndColor;
    property GradientStartColor;
    property Height default 200;
    property LegendPosition;
    property MaxPreviewSize;
    property ParentBiDiMode;
    property ParentColor;
    property ParentDoubleBuffered default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property PreviewEndPointColor;
    property PreviewLineColor;
    property ShowHint;
    property Touch;
    property Visible;
    property Width default 200;
    property OnClick;
    property OnContextPopup;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnDragDrop;
    property OnDragOver;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  TGestureRecordedEvent = procedure(Sender: TObject;
    RecordedGesture: TGestureCollectionItem) of object;

  TCustomGestureRecorder = class(TCustomControl)
  public const
      DefGradientEndColor = $F0E5E6;
      DefGradientStartColor = $FDFDFD;
  public type
    {$SCOPEDENUMS ON}
    TDrawingStyle = (dsNormal, dsGradient);
    {$SCOPEDENUMS OFF}
  private
    FDrawingStyle: TDrawingStyle;
    FGesture: TGestureCollectionItem;
    FGestureLineColor: TColor;
    FGestureManager: TGestureManager;
    FGesturePointColor: TColor;
    FGradientDirection: TGradientDirection;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FLastDrawnPoint: Integer;
    FPoints: TGesturePointArray;
    FRecordedPoints: TGesturePoints;
    FRecording: Boolean;
    FCaption: string;
    FOnGestureRecorded: TGestureRecordedEvent;
    procedure AddGesturePoint(const LastPoint, NextPoint: TPoint);
    function PointsToArray(Source: TGesturePoints): TGesturePointArray;
    procedure SetCaption(const Value: string);
    procedure SetDrawingStyle(const Value: TDrawingStyle);
    procedure SetGestureLineColor(const Value: TColor);
    procedure SetGesturePointColor(const Value: TColor);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetGradientEndColor(const Value: TColor);
    procedure SetGradientStartColor(const Value: TColor);
    procedure SetGestureManager(const Value: TGestureManager);
  protected
    procedure DrawPoint(const Point: TPoint); virtual;
    function IsTouchPropertyStored(AProperty: TTouchProperty): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Caption: string read FCaption write SetCaption;
    property DrawingStyle: TDrawingStyle read FDrawingStyle
      write SetDrawingStyle default TDrawingStyle.dsNormal;
    property Gesture: TGestureCollectionItem read FGesture write FGesture;
    property GestureManager: TGestureManager read FGestureManager write SetGestureManager;
    property GestureLineColor: TColor read FGestureLineColor
      write SetGestureLineColor default clBlue;
    property GesturePointColor: TColor read FGesturePointColor
      write SetGesturePointColor default clBlue;
    property GradientDirection: TGradientDirection read FGradientDirection
      write SetGradientDirection default gdVertical;
    property GradientEndColor: TColor read FGradientEndColor
      write SetGradientEndColor default DefGradientEndColor;
    property GradientStartColor: TColor read FGradientStartColor
      write SetGradientStartColor default DefGradientStartColor;
    property OnGestureRecorded: TGestureRecordedEvent read FOnGestureRecorded
      write FOnGestureRecorded;
  end;

  TGestureRecorder = class(TCustomGestureRecorder)
  published
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered default True;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DrawingStyle;
    property Enabled;
    property Font;
    property GestureManager;
    property GestureLineColor;
    property GesturePointColor;
    property GradientDirection;
    property GradientEndColor;
    property GradientStartColor;
    property Height default 200;
    property ParentBiDiMode;
    property ParentColor;
    property ParentDoubleBuffered default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Width default 200;
    property OnClick;
    property OnContextPopup;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnGestureRecorded;
    property OnDragDrop;
    property OnDragOver;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure DrawGesture(ACanvas: TCanvas; const APoints: array of TPoint;
  AColor: TColor); overload;
procedure DrawGesture(ACanvas: TCanvas; const APoints: array of TPoint;
  AColor: TColor; const AOffset: TPoint); overload;
procedure DrawGesture(ACanvas: TCanvas; AGesture: TCustomGestureCollectionItem;
  AColor: TColor); overload; inline;
procedure DrawGesture(ACanvas: TCanvas; AGesture: TCustomGestureCollectionItem;
  AColor: TColor; const AOffset: TPoint); overload; inline;
function ScaleGesturePoints(const Points: array of TPoint; Size: Integer): TGesturePointArray;

implementation

uses
  System.Types, System.SysUtils,
  Vcl.Touch.GestureConsts, Winapi.CommCtrl, Vcl.Forms, System.Math;

procedure DrawGesture(ACanvas: TCanvas; const APoints: array of TPoint;
  AColor: TColor);
begin
  DrawGesture(ACanvas, APoints, AColor, Point(0, 0));
end;

procedure DrawGesture(ACanvas: TCanvas; const APoints: array of TPoint;
  AColor: TColor; const AOffset: TPoint);
var
  I: Integer;
  LPoint: TPoint;
begin
  if Length(APoints) > 0 then
  begin
    // Prepare first point
    LPoint := APoints[0];
    ACanvas.Pen.Color := AColor;
    ACanvas.MoveTo(LPoint.X + AOffset.X, LPoint.Y + AOffset.Y);

    // Draw line between remaining points
    for I := 1 to Length(APoints) - 1 do
    begin
      LPoint := APoints[I];
      ACanvas.LineTo(LPoint.X + AOffset.X, LPoint.Y + AOffset.Y);
    end;

    // Fill in final point
    ACanvas.Pixels[APoints[Length(APoints) - 1].X  + AOffset.X,
      APoints[Length(APoints) - 1].Y  + AOffset.Y] := AColor;
  end;
end;

procedure DrawGesture(ACanvas: TCanvas; AGesture: TCustomGestureCollectionItem;
  AColor: TColor);
begin
  DrawGesture(ACanvas, AGesture.Points, AColor, Point(0, 0));
end;

procedure DrawGesture(ACanvas: TCanvas; AGesture: TCustomGestureCollectionItem;
  AColor: TColor; const AOffset: TPoint);
begin
  DrawGesture(ACanvas, AGesture.Points, AColor, AOffset);
end;

function ScaleGesturePoints(const Points: array of TPoint; Size: Integer): TGesturePointArray;
var
  LPoint: TPoint;
  LScale: Double;
  I, MaxX, MaxY: Integer;
  OffsetX, OffsetY: Integer;
begin
  MaxX := 0;
  MaxY := 0;

  for I := 0 to Length(Points) - 1 do
  begin
    if Points[I].X > MaxX then
      MaxX := Points[I].X;
    if Points[I].Y > MaxY then
      MaxY := Points[I].Y;
  end;

  if (MaxX = 0) and (MaxY = 0) then
  begin
    LScale := 1;
    OffsetX := 0;
    OffsetY := 0;
  end
  else
  begin
    if MaxX > MaxY then
      LScale := (Size / MaxX)
    else
      LScale := (Size / MaxY);
    OffsetX := (Size - Round(MaxX * LScale)) div 2;
    OffsetY := (Size - Round(MaxY * LScale)) div 2;
  end;

  SetLength(Result, Length(Points));
  for I := 0 to Length(Result) - 1 do
  begin
    LPoint := Points[I];
    Result[I] := Point(Round(LPoint.X * LScale) + OffsetX,
      Round(LPoint.Y * LScale) + OffsetY);
  end;
end;


{ TCustomGestureListView }

constructor TCustomGestureListView.Create(AOwner: TComponent);
begin
  inherited;
  FImages := TImageList.Create(nil);
  FNotifyList := TDictionary<TComponent, TGestureProviderChangeEvent>.Create;
  SetLength(FGestureData, 0);
  FUpdateCount := 0;
  ImageSize := 24; // call setter to set size of imagelist
  ParentDoubleBuffered := False;
  DoubleBuffered := True;
  ReadOnly := True;
  RowSelect := True;
  LargeImages := FImages;
  SmallImages := FImages;
  ViewStyle := vsReport;
  CreateColumns;
end;

destructor TCustomGestureListView.Destroy;
begin
  ClearGestureList;
  FreeAndNil(FNotifyList);
  FreeAndNil(FImages);
  inherited;
end;

procedure TCustomGestureListView.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    RefreshList;
end;

procedure TCustomGestureListView.AddGesture(Gesture: TCustomGestureCollectionItem;
  GroupID: Integer = -1);
var
  LGesture: TGestureCollectionItem;
begin
  if Gesture <> nil then
  begin
    SetLength(FGestureData, Length(FGestureData) + 1);
    LGesture := TGestureCollectionItem.Create(nil);
    LGesture.Assign(Gesture);
    FGestureData[Length(FGestureData) - 1].Gesture := LGesture;
    FGestureData[Length(FGestureData) - 1].GroupID := GroupID;
    if FUpdateCount = 0 then
      RefreshList;
  end;
end;

procedure TCustomGestureListView.AddGesture(GestureID: TGestureID; GroupID: Integer = -1);
var
  LItem: TGestureCollectionItem;
  LGesture: TCustomGestureCollectionItem;
begin
  case GestureID of
    sgiFirst..sgiLast:
      begin
        LItem := TGestureCollectionItem.Create(nil);
        try
          LItem.GestureID := GestureID;
          AddGesture(LItem, GroupID);
        finally
          LItem.Free;
        end;
      end;
    cgiFirst..cgiLast,
    rgiFirst..rgiLast:
      begin
        LGesture := nil;
        if FGestureManager <> nil then
        begin
          LGesture := FGestureManager.FindCustomGesture(GestureID);
          if LGesture <> nil then
            AddGesture(LGesture, GroupID);
        end;
        if LGesture = nil then
          raise EGestureException.CreateResFmt(@SInvalidGestureID, [GestureID]);
      end;
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureID, [GestureID]);
  end;
end;

procedure TCustomGestureListView.AddGestureImage(const Points: array of TPoint);
var
  I: Integer;
  LPoints: TGesturePointArray;
  LBitmap, LMask: TBitmap;
begin
  LBitmap := TBitmap.Create;
  try
    LBitmap.SetSize(FImages.Width, FImages.Height);
    LBitmap.Canvas.Brush.Color := Color;
    LBitmap.Canvas.FillRect(Rect(0, 0, LBitmap.Width, LBitmap.Height));

    LMask := TBitmap.Create;
    try
      LMask.Assign(LBitmap);
      LPoints := ScaleGesturePoints(Points, FImageSize - 4);

      LBitmap.Canvas.Pen.Color := clGray;
      LBitmap.Canvas.Pen.Style := psSolid;
      LBitmap.Canvas.MoveTo(LPoints[0].X + 2, LPoints[0].Y + 2);

      LMask.Canvas.Pen.Color := clBlack;
      LMask.Canvas.Pen.Style := psSolid;
      LMask.Canvas.MoveTo(LPoints[0].X + 2, LPoints[0].Y + 2);

      for I := 0 to Length(LPoints) - 1 do
      begin
        LBitmap.Canvas.LineTo(LPoints[I].X + 2, LPoints[I].Y + 2);
        LMask.Canvas.LineTo(LPoints[I].X + 2, LPoints[I].Y + 2);
      end;

      FImages.Add(LBitmap, LMask);
    finally
      LMask.Free;
    end;
  finally
    LBitmap.Free;
  end;
end;

procedure TCustomGestureListView.AddGestures(Control: TControl; GroupID: Integer);
begin
  AddGestures(Control.Touch.GestureList);
end;

procedure TCustomGestureListView.AddGestures(Gestures: TCustomGestureCollection;
  GroupID: Integer);
var
  LItem: TCollectionItem;
begin
  if Gestures <> nil then
  begin
    BeginUpdate;
    try
      for LItem in Gestures do
        AddGesture(TCustomGestureCollectionItem(LItem), GroupID);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomGestureListView.AddGestures(Gestures: TGestureArray;
  GroupID: Integer = -1);
var
  LItem: TCustomGestureCollectionItem;
begin
  BeginUpdate;
  try
    for LItem in Gestures do
      AddGesture(LItem, GroupID);
  finally
    EndUpdate;
  end;
end;

procedure TCustomGestureListView.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TCustomGestureListView.Change(Item: TListItem; Change: Integer);
var
  P: TPair<TComponent, TGestureProviderChangeEvent>;
begin
  inherited;
  if (Change = LVIF_STATE) and (Selected <> nil) then
    for P in FNotifyList do
      P.Value(Self, TCustomGestureCollectionItem(Selected.Data));
end;

procedure TCustomGestureListView.ChangeNotification(AComponent: TComponent;
  ASelectionChangeEvent: TGestureProviderChangeEvent);
begin
  if AComponent <> nil then
  begin
    FNotifyList.Add(AComponent, ASelectionChangeEvent);
    AComponent.FreeNotification(Self);
    if HandleAllocated and (Selected <> nil) then
      ASelectionChangeEvent(Self, TCustomGestureCollectionItem(Selected.Data));
  end
end;

procedure TCustomGestureListView.ClearGestureList;
var
  LItem: TGestureItemData;
begin
  for LItem in FGestureData do
    LItem.Gesture.Free;
  SetLength(FGestureData, 0);
end;

procedure TCustomGestureListView.CMCustomGesturesChanged(var Message: TMessage);
begin
  case Message.WParam of
    gcnAdded:
      // Add new gesture
      AddGesture(FGestureManager.FindCustomGesture(Message.LParam));
    gcnRemoved:
      // Remove gesture
      RemoveGesture(Message.LParam);
    gcnModified:
      // Update modified gesture
      UpdateGesture(Message.LParam);
    gcnRefreshAll:
      begin
        // Add all gestures from GestureManager
        SetLength(FGestureData, 0);
        AddGestures(FGestureManager.CustomGestures);
      end;
  end;
end;

procedure TCustomGestureListView.CreateColumns;
begin
  // Create default columns
  with Columns.Add do
  begin
    Caption := SNameColumn;
    AutoSize := True;
  end;
end;

procedure TCustomGestureListView.CreateSubItems(ListItem: TListItem;
  Gesture: TCustomGestureCollectionItem);
begin
  // Overrride or use OnCreateSubItems event to provide subitems
end;

procedure TCustomGestureListView.CreateWnd;
begin
  inherited;
  if not (csLoading in ComponentState) and (Length(FGestureData) > 0) then
    RefreshList;
end;

function TCustomGestureListView.GestureIDFromItem(Item: TListItem): TGestureID;
begin
  Result := TCustomGestureCollectionItem(Item.Data).GestureID;
end;

function TCustomGestureListView.ItemFromGestureID(GestureID: TGestureID): TListItem;
var
  Item: TListItem;
begin
  Result := nil;
  for Item in Items do
    if TCustomGestureCollectionItem(Item.Data).GestureID = GestureID then
    begin
      Result := Item;
      Break;
    end;
end;

procedure TCustomGestureListView.Loaded;
begin
  inherited;
  if HandleAllocated and (Length(FGestureData) > 0) then
    RefreshList;
end;

procedure TCustomGestureListView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = FGestureManager) then
    begin
      FGestureManager := nil;
      if not (csDestroying in ComponentState) then
      begin
        ClearGestureList;
        SetLength(FGestureData, 0);
        RefreshList;
      end;
    end
    else if not (csDestroying in ComponentState) and FNotifyList.ContainsKey(AComponent) then
      FNotifyList.Remove(AComponent);
  end;
end;

procedure TCustomGestureListView.RebuildListItem(ItemData: TGestureItemData);
begin
  RebuildListItem(ItemData, Items.Add);
end;

procedure TCustomGestureListView.RebuildListItem(ItemData: TGestureItemData; ListItem: TListItem);
var
  LGroupID: Integer;
  GestureData: TStandardGestureData;
begin
  ListItem.Caption := ItemData.Gesture.DisplayName;
  ListItem.Data := ItemData.Gesture;

  // Create subitems
  if Assigned(FOnCreateSubItems) then
    FOnCreateSubItems(Self, ListItem, ItemData.Gesture)
  else
    CreateSubItems(ListItem, ItemData.Gesture);

  // Create image from points
  if ItemData.Gesture.GestureType <> gtStandard then
    AddGestureImage(ItemData.Gesture.Points)
  else
  begin
    FindStandardGesture(ItemData.Gesture.GestureID, GestureData);
    AddGestureImage(GestureData.Points);
  end;
  ListItem.ImageIndex := FImages.Count - 1;

  // Set group (if applicable)
  if GroupView then
  begin
    LGroupID := ItemData.GroupID;
    if Assigned(FOnGetGestureGroup) then
      FOnGetGestureGroup(Self, ItemData.Gesture, LGroupID);
    ListItem.GroupID := LGroupID;
  end;
end;

procedure TCustomGestureListView.RefreshList;
var
  ItemData: TGestureItemData;
begin
  if HandleAllocated and (FUpdateCount = 0) then
  begin
    FImages.Clear;
    Items.BeginUpdate;
    try
      Items.Clear;
      for ItemData in FGestureData do
        RebuildListItem(ItemData);
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TCustomGestureListView.RemoveChangeNotification(AComponent: TComponent);
begin
  if FNotifyList.ContainsKey(AComponent) then
  begin
    FNotifyList.Remove(AComponent);
    AComponent.RemoveFreeNotification(Self);
  end;
end;

procedure TCustomGestureListView.RemoveGesture(GestureID: TGestureID);
var
  I: Integer;
  LItem: TGestureItemData;
  LGesture: TCustomGestureCollectionItem;
begin
  for I := 0 to Items.Count - 1 do
  begin
    LGesture := TCustomGestureCollectionItem(Items[I].Data);
    if (LGesture <> nil) and (LGesture.GestureID = GestureID) then
    begin
      for LItem in FGestureData do
        if LItem.Gesture = LGesture then
        begin
          LItem.Gesture.Free;
          Break;
        end;
      Items[I].Delete;
      Break;
    end;
  end;
end;

procedure TCustomGestureListView.SetGestureManager(const Value: TGestureManager);
begin
  if Value <> FGestureManager then
  begin
    if FGestureManager <> nil then
    begin
      FGestureManager.RemoveChangeNotification(Self);
      FGestureManager.RemoveFreeNotification(Self);
    end;

    FGestureManager := Value;
    SetLength(FGestureData, 0);
    if FGestureManager <> nil then
    begin
      FGestureManager.ChangeNotification(Self);
      FGestureManager.FreeNotification(Self);

      // Add gestures from GestureManager
      AddGestures(FGestureManager.CustomGestures);
    end
    else
      RefreshList;
  end;
end;

procedure TCustomGestureListView.SetGroupView(const Value: Boolean);
begin
  if Value <> FGroupView then
  begin
    FGroupView := Value;
    if not (csDesigning in ComponentState) then
    begin
      inherited GroupView := Value;
      RefreshList;
    end;
  end;
end;

procedure TCustomGestureListView.SetImageSize(const Value: Integer);
begin
  if Value <> FImageSize then
  begin
    FImageSize := Value;
    FImages.Height := FImageSize;
    FImages.Width := FImageSize;
    if HandleAllocated and not (csLoading in ComponentState) then
    begin
      // Force update of imagelists
      SmallImages := nil;
      SmallImages := FImages;
      LargeImages := nil;
      LargeImages := FImages;
      // Regenerate preview images and list items
      RefreshList;
    end;
  end;
end;

procedure TCustomGestureListView.UpdateGesture(GestureID: TGestureID);
var
  I: Integer;
  LItem: TGestureItemData;
  LGesture: TCustomGestureCollectionItem;
begin
  LGesture := FGestureManager.FindCustomGesture(GestureID);
  if LGesture <> nil then
    for LItem in FGestureData do
      if LItem.Gesture.GestureID = LGesture.GestureID then
      begin
        LItem.Gesture.Assign(LGesture);
        for I := 0 to Items.Count - 1 do
          if TCustomGestureCollectionItem(Items[I].Data).GestureID = LGesture.GestureID then
          begin
            RebuildListItem(LItem, Items[I]);
            Break;
          end;
        Break;
      end;
end;

procedure TCustomGestureListView.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

{ TCustomGesturePreview }

constructor TCustomGesturePreview.Create;
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls];
  DoubleBuffered := True;
  ParentDoubleBuffered := False;
  Height := 200;
  Width := 200;
  FAnimateState := asCompleted;
  FAnimatedPointColor := clBlue;
  FAnimateLongDelay := 500;
  FAnimateShortDelay := 75;
  FDrawingStyle := TDrawingStyle.dsNormal;
  FFrameColor := clLtGray;
  FFrameGesture := True;
  FFrameStyle := psDot;
  FGesture := TGestureCollectionItem.Create(nil);
  FGradientDirection := gdVertical;
  FGradientEndColor := DefGradientEndColor;
  FGradientStartColor := DefGradientStartColor;
  FLegendPosition := lpBottom;
  FMaxPreviewSize := 0;
  FPreviewEndPointColor := clGray;
  FPreviewLineColor := clGray;
  FAnimate := True;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.OnTimer := AnimateGesture;
  FTimer.Interval := FAnimateLongDelay;
end;

procedure TCustomGesturePreview.CreateWnd;
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    UpdatePosition;
    if FAnimate then
      StartAnimation;
  end;
end;

destructor TCustomGesturePreview.Destroy;
begin
  FreeAndNil(FGesture);
  FreeAndNil(FTimer);
  inherited;
end;

function TCustomGesturePreview.AdjustGesturePoint(Point: TPoint): TPoint;
begin
  Result := Point;
  Inc(Result.X, FOffsetX + 5);
  Inc(Result.Y, FOffsetY + 5);
end;

procedure TCustomGesturePreview.AnimateGesture(Sender: TObject);
var
  LPoint: TPoint;
begin
  case FAnimateState of
    asAnimating:
      begin
        // Erase current animation point
        EraseAnimatePoint(FAnimateIndex);

        // Advance to next animation point
        Inc(FAnimateIndex, FAnimateStep);
        if ((FAnimateDirection = adForward) and (FAnimateIndex > FAnimateLastIndex)) or
           ((FAnimateDirection = adBackward) and (FAnimateIndex < FAnimateLastIndex)) then
          FAnimateIndex := FAnimateLastIndex;

        if FAnimateIndex = FAnimateLastIndex then
        begin
          if not (goUniDirectional in FGesture.Options) then
          begin
            FAnimateStep := -FAnimateStep;
            case FAnimateDirection of
              adForward:
                begin
                  FAnimateDirection := adBackward;
                  FAnimateLastIndex := 0;
                end;
              adBackward:
                begin
                  FAnimateDirection := adForward;
                  FAnimateLastIndex := Length(FAnimatePoints) - 1;
                end;
            end;
          end;
          FTimer.Interval := FAnimateLongDelay;
          FAnimateState := asCompleted;
        end;
        LPoint := AdjustGesturePoint(FAnimatePoints[FAnimateIndex]);
        DrawPoint(LPoint, FAnimatedPointColor);
      end;
    asCompleted:
      begin
        EraseAnimatePoint(FAnimateIndex);
        if FAnimateDirection = adForward then
          FAnimateIndex := 0
        else
          FAnimateIndex := Length(FAnimatePoints) - 1;
        FAnimateState := asPaused;
      end;
    asPaused:
      begin
        DrawPoint(AdjustGesturePoint(FAnimatePoints[FAnimateIndex]), FAnimatedPointColor);
        FAnimateState := asRestarting;
      end;
    asRestarting:
      begin
        EraseAnimatePoint(FAnimateIndex);
        FAnimateState := asAnimating;
        FTimer.Interval := FAnimateShortDelay;
      end;
  end;
end;

procedure TCustomGesturePreview.DrawBackground;
var
  LRect: TRect;
begin
  // Fill background
  if FDrawingStyle = TDrawingStyle.dsGradient then
    GradientFillCanvas(Canvas, FGradientStartColor, FGradientEndColor,
      ClientRect, FGradientDirection)
  else
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  end;

  // Draw bounding box for gesture preview
  if FFrameGesture then
  begin
    LRect := Rect(FOffsetX, FOffsetY,
      FInternalPreviewSize + FOffsetX, FInternalPreviewSize + FOffsetY);
    Canvas.Pen.Color := FFrameColor;
    Canvas.Pen.Style := FFrameStyle;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(LRect);
  end;

end;

procedure TCustomGesturePreview.DrawGesturePoints;
var
  LPoint: TPoint;
begin
  // Draw line of gesture's points
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  DrawGesture(Canvas, FDrawPoints, FPreviewLineColor, Point(FOffsetX + 5, FOffsetY + 5));

  // Highlight first point
  LPoint := AdjustGesturePoint(FDrawPoints[0]);
  DrawPoint(LPoint, FPreviewEndPointColor);

  // Highlight last point
  if not (goUniDirectional in FGesture.Options) then
  begin
    LPoint := AdjustGesturePoint(FDrawPoints[Length(FDrawPoints) - 1]);
    DrawPoint(LPoint, FPreviewEndPointColor);
  end;
end;

procedure TCustomGesturePreview.DrawLegend;
var
  LPoint: TPoint;
begin
  // Determine label and dimensions
  if FLegendPosition <> lpNone then
  begin
    LPoint.X := FLegendRect.Left;
    LPoint.Y := FLegendRect.Top + ((FLegendRect.Bottom - FLegendRect.Top) div 2);

    // Draw point and label
    DrawPoint(LPoint, FPreviewEndPointColor);
    Canvas.Brush.Style := bsClear;
    Canvas.Font := Font;
    Canvas.TextOut(FLegendRect.Left + 10, FLegendRect.Top, FLegendText);
  end;
end;

procedure TCustomGesturePreview.DrawPoint(const P: TPoint; AColor: TColor);
var
  LRect: TRect;
begin
  LRect := Rect(P.X - 3, P.Y - 3, P.X + 4, P.Y + 4);
  Canvas.Pen.Color := AColor;
  Canvas.Brush.Color := AColor;
  Canvas.Ellipse(LRect);
end;

procedure TCustomGesturePreview.EraseAnimatePoint(Index: Integer);
var
  P: TPoint;
  LRect: TRect;
begin
  if (Index >= 0) and (Index < Length(FAnimatePoints)) then
  begin
    P := AdjustGesturePoint(FAnimatePoints[Index]);
    LRect := Rect(P.X - 3, P.Y - 3, P.X + 4, P.Y + 4);
    InvalidateRect(Handle, LRect, True);
    Application.ProcessMessages;
  end;
end;

function TCustomGesturePreview.InterpolatePoints(
  const Points: TGesturePointArray): TGesturePointArray;
var
  PointList: TGesturePoints;
  StepX, StepY: Single;
  I, J, DeltaX, DeltaY: Integer;
  CountX, CountY, Count: Integer;
begin
  PointList := TGesturePoints.Create;
  try
    for I := 1 to Length(Points) - 1 do
    begin
      // Add previous recorded point
      PointList.Add(Points[I - 1]);

      // Determine distance between current and last points
      DeltaX := Abs(Points[I].X - Points[I - 1].X);
      DeltaY := Abs(Points[I].Y - Points[I - 1].Y);

      // If points are too far apart insert intermediate points
      if (DeltaX > 8) or (DeltaY > 8) then
      begin
        // Determine how many points to insert
        CountX := DeltaX div 5;
        if (DeltaX mod 5) = 0 then
          Dec(CountX);
        CountY := DeltaY div 5;
        if (DeltaY mod 5) = 0 then
          Dec(CountY);
        Count := Max(CountX, CountY);

        // Determine spacing between inserted points
        StepX := (Points[I].X - Points[I - 1].X) / Count;
        StepY := (Points[I].Y - Points[I - 1].Y) / Count;

        // Insert points
        for J := 1 to Count - 1 do
          PointList.Add(Point(Points[I - 1].X + Round(StepX * J),
            Points[I - 1].Y + Round(StepY * J)));
      end;
    end;

    // Add last recorded point
    if Length(Points) > 0 then
      PointList.Add(Points[Length(Points) - 1]);

    // Copy list to result array
    SetLength(Result, PointList.Count);
    for I := 0 to PointList.Count - 1 do
      Result[I] := PointList[I];
  finally
    PointList.Free;
  end;
end;

procedure TCustomGesturePreview.Loaded;
begin
  inherited;
  if HandleAllocated then
  begin
    UpdatePosition;
    if FAnimate then
      StartAnimation;
  end;
end;

procedure TCustomGesturePreview.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = TComponent(FGestureProvider)) then
  begin
    FGestureProvider := nil;
    if not (csDestroying in ComponentState) then
      Gesture := nil;
  end
end;

procedure TCustomGesturePreview.Paint;
begin
  DrawBackground;
  if Length(FDrawPoints) > 0  then
    DrawGesturePoints;
  DrawLegend;
end;

procedure TCustomGesturePreview.Resize;
begin
  inherited;
  if not (csLoading in ComponentState) then
    UpdatePosition;
end;

procedure TCustomGesturePreview.SetAnimatedPointColor(const Value: TColor);
begin
  if Value <> FAnimatedPointColor then
  begin
    FAnimatedPointColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetAnimateLongDelay(const Value: Integer);
begin
  if Value <> FAnimateLongDelay then
    FAnimateLongDelay := Value;
end;

procedure TCustomGesturePreview.SetAnimateShortDelay(const Value: Integer);
begin
  if Value <> FAnimateShortDelay then
    FAnimateShortDelay := Value;
end;

procedure TCustomGesturePreview.SetDrawingStyle(const Value: TDrawingStyle);
begin
  if Value <> FDrawingStyle then
  begin
    FDrawingStyle := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetFrameColor(const Value: TColor);
begin
  if Value <> FFrameColor then
  begin
    FFrameColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetFrameGesture(const Value: Boolean);
begin
  if Value <> FFrameGesture then
  begin
    FFrameGesture := Value;
    UpdatePosition;
  end;
end;

procedure TCustomGesturePreview.SetFrameStyle(const Value: TFrameStyle);
begin
  if Value <> FFrameStyle then
  begin
    FFrameStyle := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetGesture(const Value: TCustomGestureCollectionItem);
var
  LData: TStandardGestureData;
begin
  FTimer.Enabled := False;
  if Value <> nil then
  begin
    // Assign gesture
    FGesture.Assign(Value);
    if (Value.GestureType = gtStandard) and (Length(FGesture.Points) = 0) then
      if FindStandardGesture(Value.GestureID, LData) then
        FGesture.Points := LData.Points
      else
        FGesture.Points := TGesturePointArray.Create();
  end
  else
    // Assign empty points
    FGesture.Points := TGesturePointArray.Create();

  // Update position of gesture preview and rescale points
  if HandleAllocated and not (csLoading in ComponentState) then
  begin
    UpdatePosition;
    if FAnimate then
      StartAnimation;
  end;
end;

procedure TCustomGesturePreview.SetGestureProvider(const Value: IGestureProvider);
begin
  if Value <> FGestureProvider then
  begin
    if FGestureProvider <> nil then
    begin
      FGestureProvider.RemoveChangeNotification(Self);
      TComponent(FGestureProvider).RemoveFreeNotification(Self);
    end;

    if Value is TComponent then
      FGestureProvider := Value;
    if FGestureProvider <> nil then
    begin
      FGestureProvider.ChangeNotification(Self,
        procedure(Sender: TObject; AGesture: TCustomGestureCollectionItem)
        begin
          SetGesture(AGesture);
        end);
      TComponent(FGestureProvider).FreeNotification(Self);
    end;
  end;
end;

procedure TCustomGesturePreview.SetGradientDirection(const Value: TGradientDirection);
begin
  if Value <> FGradientDirection then
  begin
    FGradientDirection := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetGradientEndColor(const Value: TColor);
begin
  if Value <> FGradientEndColor then
  begin
    FGradientEndColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetGradientStartColor(const Value: TColor);
begin
  if Value <> FGradientStartColor then
  begin
    FGradientStartColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetLegendPosition(const Value: TLegendPosition);
begin
  if Value <> FLegendPosition then
  begin
    FLegendPosition := Value;
    UpdatePosition;
  end;
end;

procedure TCustomGesturePreview.SetMaxPreviewSize(const Value: Integer);
begin
  if Value <> FInternalPreviewSize then
  begin
    FMaxPreviewSize := Value;
    UpdatePosition;
  end;
end;

procedure TCustomGesturePreview.SetPreviewEndPointColor(const Value: TColor);
begin
  if Value <> FPreviewEndPointColor then
  begin
    FPreviewEndPointColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetPreviewLineColor(const Value: TColor);
begin
  if Value <> FPreviewLineColor then
  begin
    FPreviewLineColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.SetAnimate(const Value: Boolean);
begin
  if Value <> FAnimate then
  begin
    FAnimate := Value;
    if FAnimate then
      StartAnimation
    else
      SuspendAnimation;
  end;
end;

procedure TCustomGesturePreview.StartAnimation;
begin
  // Initialize animation
  if (FGesture <> nil) and (Length(FAnimatePoints) > 0) then
  begin
    FAnimateDirection := adForward;
    FAnimateLastIndex := Length(FAnimatePoints) - 1;
    FAnimateIndex := 0;
    FAnimateState := asPaused;
    FAnimateStep := (Length(FAnimatePoints) div 15) + 1;
    FTimer.Interval := FAnimateLongDelay;
    FTimer.Enabled := True;
  end;
end;

procedure TCustomGesturePreview.SuspendAnimation;
begin
  FTimer.Enabled := False;
  Invalidate;
end;

procedure TCustomGesturePreview.UpdatePosition;
const
  CMargin = 8;
  CPointWidth = 10;
  CBoundingBoxMargin  = 10;
var
  LSize: TSize;
  LWidth: Integer;
  LHeight: Integer;
  LPreviewSize: Integer;
begin
  if HandleAllocated then
  begin
    // Determine legend text, dimensions and position
    FOffsetX := 0;
    FOffsetY := 0;
    if FLegendPosition <> lpNone then
    begin
      Canvas.Font := Font;
      if (goUniDirectional in FGesture.Options) then
        FLegendText := SStartPoint
      else
        FLegendText := SStartPoints;
      LSize := Canvas.TextExtent(FLegendText);
      FLegendRect := Rect(0, 0, LSize.cx + 10, LSize.cy);

      case FLegendPosition of
        lpTop:
          begin
            OffsetRect(FLegendRect, (Width - (LSize.cx + CPointWidth)) div 2, CMargin);
            Inc(FOffsetY, LSize.cy + CMargin * 2);
          end;
        lpBottom:
          OffsetRect(FLegendRect, (Width - (LSize.cx + CPointWidth)) div 2,
            Height - LSize.cy - CMargin);
      end;
    end
    else
    begin
      FLegendRect := Rect(0, 0, 0 ,0);
      LSize.cx := 0;
      LSize.cy := 0;
    end;

    // Determine size of gesture preview
    LHeight := Height - LSize.cy - (CMargin * 2);
    LWidth := Width - (CMargin * 2);
    if (FLegendPosition <> lpNone) then
      Dec(LHeight, CMargin);

    if LWidth < LHeight then
      FInternalPreviewSize := LWidth
    else
      FInternalPreviewSize := LHeight;

    // Use the MaxPreviewSize property if it's non zero
    if (FMaxPreviewSize <> 0) and (FInternalPreviewSize > FMaxPreviewSize) then
    begin
      FInternalPreviewSize := FMaxPreviewSize;
      if FLegendPosition <> lpNone then
        Inc(FOffsetY, LSize.cy + CMargin);
    end;

    // Position gesture preview
    Inc(FOffsetX, (Width - FInternalPreviewSize) div 2);
    Inc(FOffsetY, (LHeight - FInternalPreviewSize) div 2);
    if FOffsetY < CMargin then
      FOffsetY := CMargin;

    // Account for bounding box if needed
    LPreviewSize := FInternalPreviewSize;
    Dec(LPreviewSize, CBoundingBoxMargin);

    // Scale gesture points to new size
    FDrawPoints := ScaleGesturePoints(FGesture.Points, LPreviewSize);
    FAnimatePoints := InterpolatePoints(FDrawPoints);

    // Repaint
    Invalidate;
  end;
end;

procedure TCustomGesturePreview.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

{ TCustomGestureRecorder }

constructor TCustomGestureRecorder.Create(AOwner: TComponent);
begin
  inherited;
  FDrawingStyle := TDrawingStyle.dsNormal;
  FGesture := nil;
  FGestureLineColor := clBlue;
  FGesturePointColor := clBlue;
  FGradientDirection := gdVertical;
  FGradientEndColor := DefGradientEndColor;
  FGradientStartColor := DefGradientStartColor;
  FRecordedPoints := TGesturePoints.Create;
  FRecording := False;
  Height := 200;
  Width := 200;
  ControlStyle := ControlStyle - [csGestures];
  DoubleBuffered := True;
  ParentDoubleBuffered := False;
  Touch.InteractiveGestureOptions := [];
  Touch.InteractiveGestures := [];
  Touch.ParentTabletOptions := False;
  Touch.TabletOptions := [];
end;

destructor TCustomGestureRecorder.Destroy;
begin
  FreeAndNil(FGesture);
  FreeAndNil(FRecordedPoints);
  inherited;
end;

procedure TCustomGestureRecorder.AddGesturePoint(const LastPoint, NextPoint: TPoint);
var
  StepX, StepY: Single;
  I, DeltaX, DeltaY: Integer;
  CountX, CountY, Count: Integer;
begin
  // Determine distance between points
  DeltaX := Abs(NextPoint.X - LastPoint.X);
  DeltaY := Abs(NextPoint.Y - LastPoint.Y);

  // If points are too close together discard the new point
  if (DeltaX < 4) and (DeltaY < 4) then
    Exit;

  // If points are too far apart insert intermediate points
  if (DeltaX > 8) or (DeltaY > 8) then
  begin
    // Determine how many points to insert
    CountX := DeltaX div 5;
    if (DeltaX mod 5) = 0 then
      Dec(CountX);
    CountY := DeltaY div 5;
    if (DeltaY mod 5) = 0 then
      Dec(CountY);
    Count := Max(CountX, CountY);

    // Determine spacing between inserted points
    StepX := (NextPoint.X - LastPoint.X) / Count;
    StepY := (NextPoint.Y - LastPoint.Y) / Count;

    // Insert points
    for I := 1 to Count - 1 do
      FRecordedPoints.Add(Point(LastPoint.X + Round(StepX * I),
        LastPoint.Y + Round(StepY * I)));
  end;

  // Add captured point
  FRecordedPoints.Add(NextPoint);
end;

procedure TCustomGestureRecorder.DrawPoint(const Point: TPoint);
begin
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := FGesturePointColor;
  Canvas.Ellipse(Point.X - 2, Point.Y - 2, Point.X + 3, Point.Y + 3);

  Canvas.Pen.Color := FGestureLineColor;
  if FRecordedPoints.Count = 1 then
    Canvas.MoveTo(Point.X, Point.Y)
  else
    Canvas.LineTo(Point.X, Point.Y);
end;

function TCustomGestureRecorder.IsTouchPropertyStored(
  AProperty: TTouchProperty): Boolean;
begin
  Result := inherited IsTouchPropertyStored(AProperty);
  case AProperty of
    tpInteractiveGestureOptions: Result := Touch.InteractiveGestureOptions <> [];
    tpInteractiveGestures: Result := Touch.InteractiveGestures <> [];
    tpParentTabletOptions: Result := Touch.ParentTabletOptions;
  end;
end;

procedure TCustomGestureRecorder.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // Set recording mode
  FRecording := True;
  Invalidate;

  // Clear list of points
  FRecordedPoints.Clear;
  FRecordedPoints.Add(Point(X, Y));
  DrawPoint(FRecordedPoints[0]);
  FLastDrawnPoint := 0;
end;

procedure TCustomGestureRecorder.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  if FRecording then
  begin
    // Add new gesture point
    AddGesturePoint(FRecordedPoints[FRecordedPoints.Count - 1], Point(X, Y));
    for I := FLastDrawnPoint to FRecordedPoints.Count - 1 do
      DrawPoint(FRecordedPoints[I]);
    FLastDrawnPoint := FRecordedPoints.Count - 1;
  end
  else
    // Multi-touch drivers won't send mouse down in the expected
    // order but the fiirst mouse down from a touch source will
    // be our signal to start recording
    if ssTouch in Shift then
    begin
      // Set recording mode
      FRecording := True;
      Invalidate;

      // Clear list of points
      FRecordedPoints.Clear;
      FRecordedPoints.Add(Point(X, Y));
      DrawPoint(FRecordedPoints[0]);
      FLastDrawnPoint := 0;
    end;
end;

procedure TCustomGestureRecorder.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  LGesture: TGestureCollectionItem;
begin
  if FRecording then
  begin
    FRecording := False;

    // Add new gesture point
    AddGesturePoint(FRecordedPoints[FRecordedPoints.Count - 1], Point(X, Y));

    // Normalize list of points
    FPoints := TGestureEngine.Recognizer.NormalizePoints(PointsToArray(FRecordedPoints));

    // Create gesture from points
    if FGesture <> nil then
      FGesture.Free;
    FGesture := TGestureCollectionItem.Create(nil);
    FGesture.Points := FPoints;

    // Trigger OnRecorded event if more than 1 point was recorded
    if (Length(FPoints) > 1) then
    begin
      if FGestureManager <> nil then
      begin
        FGesture.GestureID := FGestureManager.AddRecordedGesture(FGesture);
        LGesture := TGestureCollectionItem(FGestureManager.FindCustomGesture(FGesture.GestureID));
      end
      else
        LGesture := FGesture;
      if Assigned(FOnGestureRecorded) then
        FOnGestureRecorded(Self, LGesture);
    end;

    // Force repaint
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FGestureManager) then
    FGestureManager := nil;
end;

procedure TCustomGestureRecorder.Paint;
var
  LRect: TRect;
  LText: string;
  I, LTextHeight: Integer;
begin
  LRect := ClientRect;
  if FDrawingStyle = TDrawingStyle.dsNormal then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(LRect);
  end
  else
    GradientFillCanvas(Canvas, FGradientStartColor, FGradientEndColor, LRect, FGradientDirection);

  if not FRecording then
  begin
    // Draw instructions
    Canvas.Font := Self.Font;
    Canvas.Brush.Style := bsClear;

    LText := FCaption;
    if (csDesigning in ComponentState) and (LText = '') then
      LText := Name;

    InflateRect(LRect, -25, 0);
    LRect.Top := 0;
    LRect.Bottom := 0;
    Canvas.TextRect(LRect, LText, [tfCalcRect, tfWordBreak]);
    LRect.Right := Width - 25;
    LTextHeight := LRect.Bottom - LRect.Top;
    LRect.Top := (Height - LTextHeight) div 2;
    Inc(LRect.Bottom, LRect.Top);
    Canvas.TextRect(LRect, LText, [tfCenter, tfWordBreak]);
  end
  else
  begin
    // Draw points
    for I := 0 to FRecordedPoints.Count - 1 do
      DrawPoint(FRecordedPoints[I])
  end;
end;

function TCustomGestureRecorder.PointsToArray(Source: TGesturePoints): TGesturePointArray;
var
  I: Integer;
begin
  SetLength(Result, Source.Count);
  for I := 0 to Source.Count - 1 do
    Result[I] := Source[I];
end;

procedure TCustomGestureRecorder.SetCaption(const Value: string);
begin
  if Value <> FCaption then
  begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.SetDrawingStyle(const Value: TDrawingStyle);
begin
  if Value <> FDrawingStyle then
  begin
    FDrawingStyle := Value;
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.SetGestureLineColor(const Value: TColor);
begin
  if Value <> FGestureLineColor then
  begin
    FGestureLineColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.SetGestureManager(const Value: TGestureManager);
begin
  if Value <> FGestureManager then
  begin
    if FGestureManager <> nil then
      FGestureManager.RemoveFreeNotification(Self);

    FGestureManager := Value;
    if FGestureManager <> nil then
      FGestureManager.FreeNotification(Self);
  end;
end;

procedure TCustomGestureRecorder.SetGesturePointColor(const Value: TColor);
begin
  if Value <> FGesturePointColor then
  begin
    FGesturePointColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.SetGradientDirection(const Value: TGradientDirection);
begin
  if Value <> FGradientDirection then
  begin
    FGradientDirection := Value;
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.SetGradientEndColor(const Value: TColor);
begin
  if Value <> FGradientEndColor then
  begin
    FGradientEndColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.SetGradientStartColor(const Value: TColor);
begin
  if Value <> FGradientStartColor then
  begin
    FGradientStartColor := Value;
    Invalidate;
  end;
end;

procedure TCustomGestureRecorder.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

end.
