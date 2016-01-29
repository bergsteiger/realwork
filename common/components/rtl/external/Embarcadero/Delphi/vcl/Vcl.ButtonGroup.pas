{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ButtonGroup;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Forms, Winapi.Messages,
  Vcl.Graphics, Vcl.StdCtrls, Vcl.Controls, Vcl.CategoryButtons;

type
  TGrpButtonItem = class;
  TGrpButtonItemClass = class of TGrpButtonItem;
  TGrpButtonItems = class;
  TGrpButtonItemsClass = class of TGrpButtonItems;

  TGrpButtonOptions = set of (gboAllowReorder, gboFullSize, gboGroupStyle,
    gboShowCaptions);

  TGrpButtonEvent = procedure(Sender: TObject; Index: Integer) of object;
  TGrpButtonDrawEvent = procedure(Sender: TObject; Index: Integer;
    Canvas: TCanvas; Rect: TRect; State: TButtonDrawState) of object;
  TGrpButtonDrawIconEvent = procedure(Sender: TObject; Index: Integer;
    Canvas: TCanvas; Rect: TRect; State: TButtonDrawState; var TextOffset: Integer) of object;
  TGrpButtonReorderEvent = procedure(Sender: TObject; OldIndex, NewIndex: Integer) of object;

  { Note: TButtonGroup requires (Win98 | Win NT 4.0) or above }
  TButtonGroup = class(TCustomControl)
  private
    FDownIndex: Integer;
    FDragIndex: Integer;
    FDragStartPos: TPoint;
    FDragStarted: Boolean;
    FDragImageList: TDragImageList;
    FHiddenItems: Integer; { Hidden rows or Hidden columns, depending on the flow }
    FHotIndex: Integer;
    FInsertLeft, FInsertTop, FInsertRight, FInsertBottom: Integer;
    FIgnoreUpdate: Boolean;
    FScrollBarMax: Integer;
    FPageAmount: Integer;
    FButtonItems: TGrpButtonItems;
    FButtonOptions: TGrpButtonOptions;
    FButtonWidth, FButtonHeight: Integer;
    FBorderStyle: TBorderStyle;
    FFocusIndex: Integer;
    FItemIndex: Integer;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FMouseInControl: Boolean;
    FPanPoint: TPoint;
    FOnButtonClicked: TGrpButtonEvent;
    FOnClick: TNotifyEvent;
    FOnHotButton: TGrpButtonEvent;
    FOnDrawIcon: TGrpButtonDrawIconEvent;
    FOnDrawButton: TGrpButtonDrawEvent;
    FOnBeforeDrawButton: TGrpButtonDrawEvent;
    FOnAfterDrawButton: TGrpButtonDrawEvent;
    FOnReorderButton: TGrpButtonReorderEvent;
    FScrollBarShown: Boolean;
    class constructor Create;
    class destructor Destroy;
    procedure AutoScroll(ScrollCode: TScrollCode);
    procedure ImageListChange(Sender: TObject);
    function CalcButtonsPerRow: Integer;
    function CalcRowsSeen: Integer;
    procedure DoFillRect(const Rect: TRect; ACanvas: TCanvas);
    procedure ScrollPosChanged(ScrollCode: TScrollCode;
      ScrollPos: Integer);
    procedure SetOnDrawButton(const Value: TGrpButtonDrawEvent);
    procedure SetOnDrawIcon(const Value: TGrpButtonDrawIconEvent);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SeTGrpButtonItems(const Value: TGrpButtonItems);
    procedure SetButtonHeight(const Value: Integer);
    procedure SetGrpButtonOptions(const Value: TGrpButtonOptions);
    procedure SetButtonWidth(const Value: Integer);
    procedure SetItemIndex(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    function IsStyleEnabled: Boolean;
    procedure ShowScrollBar(const Visible: Boolean);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CNKeydown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetDragIndex(const Value: Integer);
  protected
    function CreateButton: TGrpButtonItem; virtual;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoEndDrag(Target: TObject; X: Integer; Y: Integer); override;
    procedure DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean); override;
    procedure DoHotButton; dynamic;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure DoReorderButton(const OldIndex, NewIndex: Integer);
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DrawButton(Index: Integer; Canvas: TCanvas;
      Rect: TRect; State: TButtonDrawState); virtual;
    procedure DoItemClicked(const Index: Integer); virtual;
    function GetButtonClass: TGrpButtonItemClass; virtual;
    function GetButtonsClass: TGrpButtonItemsClass; virtual;
    function IsTouchPropertyStored(AProperty: TTouchProperty): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure UpdateButton(const Index: Integer);
    procedure UpdateAllButtons;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    { DragIndex: If a drag operation is coming from this control, it is
      because they are dragging the item at DragIndex. Set DragIndex to
      control which item is being dragged before manually calling
      BeginDrag. }
    property DragIndex: Integer read FDragIndex write SetDragIndex;
    property DragImageList: TDragImageList read FDragImageList;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    function GetButtonRect(const Index: Integer): TRect;
    function GetDragImages: TDragImageList; override;
    function IndexOfButtonAt(const X, Y: Integer): Integer;
    { RemoveInsertionPoints: Removes the insertion points added by
      SetInsertionPoints }
    procedure RemoveInsertionPoints;
    procedure ScrollIntoView(const Index: Integer);
    { SetInsertionPoints: Draws an insert line for inserting at
      InsertionIndex. Shows/Hides  }
    procedure SetInsertionPoints(const InsertionIndex: Integer);
    { TargetIndexAt: Gives you the target insertion index given a
      coordinate. If it is above half of a current button, it inserts
      above it. If it is below the half, it inserts after it. }
    function TargetIndexAt(const X, Y: Integer): Integer;
    property Canvas;
  published
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ButtonHeight: Integer read FButtonHeight write SetButtonHeight default 24;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth default 24;
    property ButtonOptions: TGrpButtonOptions read FButtonOptions write SetGrpButtonOptions default [gboShowCaptions];
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Height default 100;
    property Images: TCustomImageList read FImages write SetImages;
    property Items: TGrpButtonItems read FButtonItems write SeTGrpButtonItems;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property ParentDoubleBuffered;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Touch;
    property Width default 100;
    property Visible;
    property StyleElements;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnButtonClicked: TGrpButtonEvent read FOnButtonClicked write FOnButtonClicked;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnHotButton: TGrpButtonEvent read FOnHotButton write FOnHotButton;
    property OnAfterDrawButton: TGrpButtonDrawEvent read FOnAfterDrawButton write FOnAfterDrawButton;
    property OnBeforeDrawButton: TGrpButtonDrawEvent read FOnBeforeDrawButton write FOnBeforeDrawButton;
    property OnDrawButton: TGrpButtonDrawEvent read FOnDrawButton write SetOnDrawButton;
    property OnDrawIcon: TGrpButtonDrawIconEvent read FOnDrawIcon write SetOnDrawIcon;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnReorderButton: TGrpButtonReorderEvent read FOnReorderButton write FOnReorderButton;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TGrpButtonItem = class(TBaseButtonItem)
  protected
    function GetButtonGroup: TButtonGroup;
    function GetCollection: TGrpButtonItems;
    function GetNotifyTarget: TComponent; override;
    procedure SetCollection(const Value: TGrpButtonItems); reintroduce;
  public
    procedure ScrollIntoView; override;
    property Collection: TGrpButtonItems read GetCollection write SetCollection;
  published
    property ButtonGroup: TButtonGroup read GetButtonGroup;
  end;

  TGrpButtonItems = class(TCollection)
  private
    FButtonGroup: TButtonGroup;
    FOriginalID: Integer;
  protected
    function GetItem(Index: Integer): TGrpButtonItem;
    procedure SetItem(Index: Integer; const Value: TGrpButtonItem);
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(const ButtonGroup: TButtonGroup); virtual;
    function Add: TGrpButtonItem;
    function AddItem(Item: TGrpButtonItem; Index: Integer): TGrpButtonItem;
    procedure BeginUpdate; override;
    function Insert(Index: Integer): TGrpButtonItem;
    property ButtonGroup: TButtonGroup read FButtonGroup;
    property Items[Index: Integer]: TGrpButtonItem read GetItem write SetItem; default;
  end;

implementation

uses 
{$IF DEFINED(CLR)}
  System.Security.Permissions, System.Threading, System.Runtime.InteropServices,
{$ENDIF}
  Vcl.Themes, Vcl.GraphUtil, Vcl.ExtCtrls, System.Types, System.UITypes;

{ TButtonGroup }

class constructor TButtonGroup.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TButtonGroup, TScrollingStyleHook);
end;

constructor TButtonGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 100;
  ControlStyle := [csDoubleClicks, csCaptureMouse, csDisplayDragImage, csPannable];
  FButtonItems := GetButtonsClass.Create(Self);
  FButtonOptions := [gboShowCaptions];
  FBorderStyle := bsSingle;
  FButtonWidth := 24;
  FButtonHeight := 24;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FDoubleBuffered := True;
  FHotIndex := -1;
  FDownIndex := -1;
  FItemIndex := -1;
  FDragIndex := -1;
  FInsertBottom := -1;
  FInsertTop := -1;
  FInsertLeft := -1;
  FInsertRight := -1;
  FDragImageList := TDragImageList.Create(nil);
  FFocusIndex := -1;
  TabStop := True;
  Touch.InteractiveGestures := [igPan, igPressAndTap];
  Touch.InteractiveGestureOptions := [igoPanInertia, igoPanSingleFingerHorizontal,
    igoPanSingleFingerVertical, igoPanGutter, igoParentPassthrough];
end;

class destructor TButtonGroup.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TButtonGroup, TScrollingStyleHook);
end;

destructor TButtonGroup.Destroy;
begin
  FDragImageList.Free;
  FButtonItems.Free;
  FImageChangeLink.Free;
  inherited;
end;

function TButtonGroup.IsStyleEnabled: Boolean;
begin
  Result := StyleServices.Enabled;
  if Result and TStyleManager.IsCustomStyleActive and not (seClient in StyleElements) then
    Result := False;
end;

function TButtonGroup.CreateButton: TGrpButtonItem;
begin
  Result := GetButtonClass.Create(FButtonItems);
end;

procedure TButtonGroup.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (FBorderStyle = bsSingle) then
  begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  with Params do
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

function TButtonGroup.GetButtonClass: TGrpButtonItemClass;
begin
  Result := TGrpButtonItem;
end;

function TButtonGroup.GetButtonRect(const Index: Integer): TRect;
var
  ButtonsPerRow: Integer;
  HiddenCount: Integer;
  Item: Integer;
  Row, Col: Integer;
begin
  ButtonsPerRow := CalcButtonsPerRow;
  HiddenCount := FHiddenItems*ButtonsPerRow;
  { Subtract out what we can't see }
  Item := Index - HiddenCount;

  Row := Item div ButtonsPerRow;
  Result.Top := Row*FButtonHeight;
  if gboFullSize in FButtonOptions then
  begin
    Result.Left := 0;
    Result.Right := ClientWidth;
  end
  else
  begin
    Col := Item mod ButtonsPerRow;
    Result.Left := Col*FButtonWidth;
    Result.Right := Result.Left + FButtonWidth;
  end;
  Result.Bottom := Result.Top + FButtonHeight;
end;

function TButtonGroup.GetButtonsClass: TGrpButtonItemsClass;
begin
  Result := TGrpButtonItems;
end;

procedure TButtonGroup.ImageListChange(Sender: TObject);
begin
  UpdateAllButtons;
end;

procedure TButtonGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = Images then
      Images := nil
    else
      if AComponent is TBasicAction then
        for I := 0 to FButtonItems.Count - 1 do
          if AComponent = FButtonItems[I].Action then
            FButtonItems[I].Action := nil;
  end;
end;

procedure TButtonGroup.Paint;
var
  ButtonCount: Integer;
  RowsSeen, ButtonsPerRow: Integer;
  HiddenCount, VisibleCount: Integer;
  CurOffset: TPoint;
  RowPos: Integer;
  X: Integer;
  ItemRect: TRect;
  ActualWidth, ActualHeight: Integer;
  DrawState: TButtonDrawState;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LCanvas: TCanvas;
  Buffer: TBitmap;
begin
  Buffer := nil;
  try
                                                                   
    if not DoubleBuffered and TStyleManager.IsCustomStyleActive and (seClient in StyleElements) then
    begin
      Buffer := TBitmap.Create;
      Buffer.SetSize(ClientWidth, ClientHeight);
      LCanvas := Buffer.Canvas;
    end
    else
      LCanvas := Canvas;

    LStyle := StyleServices;
    if IsStyleEnabled and
       LStyle.GetElementColor(LStyle.GetElementDetails(tcbBackground), ecFillColor, LColor) and
       (LColor <> clNone) then
      LCanvas.Brush.Color := LColor
    else
      LCanvas.Brush.Color := clBtnFace;

    DoFillRect(Rect(0, 0, ClientWidth, ClientHeight), LCanvas);

    ButtonCount := FButtonItems.Count;
    if ButtonCount > 0 then
    begin
      RowsSeen := CalcRowsSeen;
      ButtonsPerRow := CalcButtonsPerRow;
      HiddenCount := FHiddenItems * ButtonsPerRow;
      VisibleCount := RowsSeen*ButtonsPerRow;
      
      if (HiddenCount + VisibleCount) > ButtonCount then
        VisibleCount := ButtonCount - HiddenCount; { We can see more items than we have }

      CurOffset.X := 0; { Start at the very top left }
      CurOffset.Y := 0;
      RowPos := 0;
      if gboFullSize in ButtonOptions then
        ActualWidth := ClientWidth
      else
        ActualWidth := FButtonWidth;
      ActualHeight := FButtonHeight;

      for X := HiddenCount to HiddenCount + VisibleCount - 1 do
      begin
        ItemRect := Bounds(CurOffset.X, CurOffset.Y, ActualWidth, ActualHeight);
        DrawState := [];
        if X = FHotIndex then
        begin
          Include(DrawState, bdsHot);
          if X = FDownIndex then
            Include(DrawState, bdsDown);
        end;
        if X = FItemIndex then
          Include(DrawState, bdsSelected);

        if X = FInsertTop then
          Include(DrawState, bdsInsertTop)
        else if X = FInsertBottom then
          Include(DrawState, bdsInsertBottom)
        else if X = FInsertRight then
          Include(DrawState, bdsInsertRight)
        else if X = FInsertLeft then
          Include(DrawState, bdsInsertLeft);
        if (X = FFocusIndex) and Focused then
          Include(DrawState, bdsFocused);

        DrawButton(X, LCanvas, ItemRect, DrawState);
        { Restore style color }
        if IsStyleEnabled and (LColor <> clNone) then
          LCanvas.Brush.Color := LColor;
        Inc(RowPos);
        { Should we go to the next line? }
        if RowPos >= ButtonsPerRow then
        begin
          { Erase to the end }
          Inc(CurOffset.X, ActualWidth);
  {        DoFillRect(Rect(CurOffset.X, CurOffset.Y, ClientWidth,
            CurOffset.Y + ActualHeight), LCanvas); }
          RowPos := 0;
          CurOffset.X := 0;
          Inc(CurOffset.Y, ActualHeight);
        end
        else
          Inc(CurOffset.X, ActualWidth);
      end;
      { Erase to the end }
  //   DoFillRect(Rect(CurOffset.X, CurOffset.Y,
  //     ClientWidt, CurOffset.Y + ActualHeight), LCanvas);
      { Erase to the bottom }
  //   DoFillRect(Rect(0, CurOffset.Y + ActualHeight, ClientWidth, ClientHeight), LCanvas);
    end;
  //  else
  //    DoFillRect(ClientRect, LCanvas);
  finally
    if Buffer <> nil then
    begin
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end;
  end;
end;


function TButtonGroup.CalcButtonsPerRow: Integer;
begin
  if gboFullSize in ButtonOptions then
    Result := 1
  else
  begin
    Result := ClientWidth div FButtonWidth;
    if Result = 0 then
      Result := 1;
  end;
end;

function TButtonGroup.CalcRowsSeen: Integer;
begin
  Result := ClientHeight div FButtonHeight
end;

procedure TButtonGroup.Resize;
var
  RowsSeen: Integer;
  ButtonsPerRow: Integer;
  TotalRowsNeeded: Integer;
  ScrollInfo: TScrollInfo;
begin
  inherited;
  { Reset the original position }
  FHiddenItems := 0;

  { How many rows can we show? }
  RowsSeen := CalcRowsSeen;
  ButtonsPerRow := CalcButtonsPerRow;

  { Do we have to take the scrollbar into consideration? }
  if (ButtonsPerRow*RowsSeen < FButtonItems.Count) then
  begin
    TotalRowsNeeded := FButtonItems.Count div ButtonsPerRow;
    if FButtonItems.Count mod ButtonsPerRow <> 0 then
      Inc(TotalRowsNeeded);

    if TotalRowsNeeded > RowsSeen then
      FPageAmount := RowsSeen
    else
      FPageAmount := TotalRowsNeeded;

    { Adjust the max to NOT contain the page amount }
    FScrollBarMax := TotalRowsNeeded - FPageAmount;

{$IF DEFINED(CLR)}
    ScrollInfo.cbSize := Marshal.SizeOf(TypeOf(TScrollInfo));
{$ELSE}
    ScrollInfo.cbSize := SizeOf(TScrollInfo);
{$ENDIF}
    ScrollInfo.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
    ScrollInfo.nMin := 0;
    ScrollInfo.nMax := TotalRowsNeeded - 1;
    ScrollInfo.nPos := 0;
    ScrollInfo.nPage := FPageAmount;

    SetScrollInfo(Handle, SB_VERT, ScrollInfo, False);
    ShowScrollBar(True);
  end
  else
    ShowScrollBar(False);
end;

procedure TButtonGroup.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TButtonGroup.SetButtonHeight(const Value: Integer);
begin
  if (FButtonHeight <> Value) and (Value > 0) then
  begin
    FButtonHeight := Value;
    UpdateAllButtons;
  end;
end;

procedure TButtonGroup.SeTGrpButtonItems(const Value: TGrpButtonItems);
begin
  FButtonItems.Assign(Value);
end;

procedure TButtonGroup.SetGrpButtonOptions(const Value: TGrpButtonOptions);
begin
  if FButtonOptions <> Value then
  begin
    FButtonOptions := Value;
    if not (gboGroupStyle in FButtonOptions) then
      FItemIndex := -1;
    if HandleAllocated then
    begin
      Resize;
      UpdateAllButtons;
    end;
  end;
end;

procedure TButtonGroup.SetButtonWidth(const Value: Integer);
begin
  if (FButtonWidth <> Value) and (Value > 0) then
  begin
    FButtonWidth := Value;
    UpdateAllButtons;
  end;
end;

procedure TButtonGroup.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then
  begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if Images <> nil then
    begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
   end;
   UpdateAllButtons;
  end;
end;

procedure TButtonGroup.SetItemIndex(const Value: Integer);
var
  OldIndex: Integer;
begin
  if (FItemIndex <> Value) and (gboGroupStyle in ButtonOptions) then
  begin
    OldIndex := FItemIndex;
    { Assign the index before painting }
    FItemIndex := Value;
    FFocusIndex := Value; { Assign it to the focus item too }
    UpdateButton(OldIndex);

    UpdateButton(FItemIndex);
  end;
end;

const
  cScrollBarKind = SB_VERT;

procedure TButtonGroup.ShowScrollBar(const Visible: Boolean);
begin
  if Visible <> FScrollBarShown then
  begin
    FScrollBarShown := Visible;
    Winapi.Windows.ShowScrollBar(Handle, cScrollBarKind, Visible);
  end;
end;

procedure TButtonGroup.UpdateAllButtons;
begin
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
end;

procedure TButtonGroup.UpdateButton(const Index: Integer);
var
  R: TRect;
begin
  { Just invalidate one button's rect }
  if Index >= 0 then
  begin
    R := GetButtonRect(Index);
    InvalidateRect(Handle, R, False);
  end;
end;

procedure TButtonGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
end;


procedure TButtonGroup.WMHScroll(var Message: TWMHScroll);
begin
  with Message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TButtonGroup.WMVScroll(var Message: TWMVScroll);
begin
  with Message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TButtonGroup.ScrollPosChanged(ScrollCode: TScrollCode;
  ScrollPos: Integer);
var
  OldPos: Integer;
begin
  OldPos := FHiddenItems;
  if (ScrollCode = scLineUp) and (FHiddenItems > 0) then
    Dec(FHiddenItems)
  else if (ScrollCode = scLineDown) and (FHiddenItems < FScrollBarMax) then
    Inc(FHiddenItems)
  else if (ScrollCode = scPageUp) then
  begin
    Dec(FHiddenItems, FPageAmount);
    if FHiddenItems < 0 then
      FHiddenItems := 0;
  end
  else if ScrollCode = scPageDown then
  begin
    Inc(FHiddenItems, FPageAmount);
    if FHiddenItems > FScrollBarMax then
      FHiddenItems := FScrollBarMax;
  end
  else if ScrollCode in [scPosition, scTrack] then
    FHiddenItems := ScrollPos
  else if ScrollCode = scTop then
    FHiddenItems := 0
  else if ScrollCode = scBottom then
    FHiddenItems := FScrollBarMax;
  if OldPos <> FHiddenItems then
  begin
    SetScrollPos(Handle, cScrollBarKind, FHiddenItems, True);
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  end;
end;

procedure TButtonGroup.DoFillRect(const Rect: TRect; ACanvas: TCanvas);
begin
  if ParentBackground and StyleServices.Enabled then
    StyleServices.DrawParentBackground(Handle, ACanvas.Handle, nil, False, Rect)
  else
    ACanvas.FillRect(Rect);
end;

procedure TButtonGroup.DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = igiPan then
  begin
    Handled := True;
    if gfBegin in EventInfo.Flags then
      FPanPoint := EventInfo.Location
    else if not (gfEnd in EventInfo.Flags) then
    begin
      if (EventInfo.Location.Y - FPanPoint.Y) > 0 then
        ScrollPosChanged(scLineUp, (EventInfo.Location.Y - FPanPoint.Y))
      else
        ScrollPosChanged(scLineDown, (EventInfo.Location.Y - FPanPoint.Y));
      FPanPoint := EventInfo.Location
                                            
    end;
  end;
end;

procedure TButtonGroup.DrawButton(Index: Integer; Canvas: TCanvas;
  Rect: TRect; State: TButtonDrawState);
var
  TextLeft, TextTop: Integer;
  RectHeight: Integer;
  ImgTop: Integer;
  TextOffset: Integer;
  ButtonItem: TGrpButtonItem;
  FillColor: TColor;
  EdgeColor: TColor;
  InsertIndication: TRect;
  TextRect: TRect;
  OrgRect: TRect;
  Text: string;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  SaveIndex: Integer;
  TxtColor: TColor;
begin
  if Assigned(FOnDrawButton) and (not (csDesigning in ComponentState)) then
    FOnDrawButton(Self, Index, Canvas, Rect, State)
  else
  begin
    OrgRect := Rect;
    Canvas.Font := Font;

    LStyle := StyleServices;
    if IsStyleEnabled then
    begin
      if (bdsSelected in State) or (bdsDown in State) then
        LDetails := LStyle.GetElementDetails(tcbButtonSelected)
      else if bdsHot in State then
        LDetails := LStyle.GetElementDetails(tcbButtonHot)
      else
        LDetails := LStyle.GetElementDetails(tcbButtonNormal);

      if not (TStyleManager.IsCustomStyleActive and not (seFont in StyleElements)) and
         LStyle.GetElementColor(LDetails, ecTextColor, LColor) and (LColor <> clNone) then
        Canvas.Font.Color := LColor;
    end
    else
    begin
      if bdsSelected in State then
      begin
        Canvas.Brush.Color := GetShadowColor(clBtnFace, -25);
        Canvas.Font.Color := clBtnText;
      end
      else if bdsDown in State then
      begin
        Canvas.Brush.Color := clBtnShadow;
        Canvas.Font.Color := clBtnFace;
      end
      else
        Canvas.Brush.Color := clBtnFace;
    end;

    if Assigned(FOnBeforeDrawButton) then
      FOnBeforeDrawButton(Self, Index, Canvas, Rect, State);

    FillColor := Canvas.Brush.Color;
    EdgeColor := GetShadowColor(FillColor, -25);

    if TStyleManager.IsCustomStyleActive and (seClient in StyleElements) then
    begin
      InflateRect(Rect, -1, -1);
      SaveIndex := SaveDC(Canvas.Handle);
      try
        LStyle.DrawElement(Canvas.Handle, LDetails, Rect);
      finally
        RestoreDC(Canvas.Handle, SaveIndex);
      end;
    end
    else
    begin
      Canvas.FillRect(Rect);
      InflateRect(Rect, -2, -1)
    end;

    if (bdsHot in State) and not (bdsDown in State) then
      EdgeColor := GetShadowColor(EdgeColor, -50);

    { Draw the edge outline }
    if not (TStyleManager.IsCustomStyleActive and (seClient in StyleElements)) then
    begin
      Canvas.Brush.Color := EdgeColor;
      Canvas.FrameRect(Rect);
      Canvas.Brush.Color := FillColor;
    end;

    { Compute the text location }
    TextLeft := Rect.Left + 4;
    RectHeight := Rect.Bottom - Rect.Top;
     TextTop := Rect.Top + (RectHeight - Canvas.TextHeight('Wg')) div 2; { Do not localize } 
    if TextTop < Rect.Top then
      TextTop := Rect.Top;
    if bdsDown in State then
    begin
      Inc(TextTop);
      Inc(TextLeft);
    end;

    ButtonItem := FButtonItems[Index];
    { Draw the icon - prefer the event }
    TextOffset := 0;
    if Assigned(FOnDrawIcon) then
      FOnDrawIcon(Self, Index, Canvas, OrgRect, State, TextOffset)
    else if (FImages <> nil) and (ButtonItem.ImageIndex > -1) and
        (ButtonItem.ImageIndex < FImages.Count) then
    begin
      ImgTop := Rect.Top + (RectHeight - FImages.Height) div 2;
      if ImgTop < Rect.Top then
        ImgTop := Rect.Top;
      if bdsDown in State then
        Inc(ImgTop);
      FImages.Draw(Canvas, TextLeft - 1, ImgTop, ButtonItem.ImageIndex);
      TextOffset := FImages.Width + 1;
    end;

    { Show insert indications }
    if [bdsInsertLeft, bdsInsertTop, bdsInsertRight, bdsInsertBottom] * State <> [] then
    begin
      Canvas.Brush.Color := GetShadowColor(EdgeColor);
      InsertIndication := Rect;
      if bdsInsertLeft in State then
      begin
        Dec(InsertIndication.Left, 2);
        InsertIndication.Right := InsertIndication.Left + 2;
      end
      else if bdsInsertTop in State then
      begin
        Dec(InsertIndication.Top);
        InsertIndication.Bottom := InsertIndication.Top + 2;
      end
      else if bdsInsertRight in State then
      begin
        Inc(InsertIndication.Right, 2);
        InsertIndication.Left := InsertIndication.Right - 2;
      end
      else if bdsInsertBottom in State then
      begin
        Inc(InsertIndication.Bottom);
        InsertIndication.Top := InsertIndication.Bottom - 2;
      end;
      Canvas.FillRect(InsertIndication);
      Canvas.Brush.Color := FillColor;
    end;

    if gboShowCaptions in FButtonOptions then
    begin
      { Avoid clipping the image }
      Inc(TextLeft, TextOffset);
      TextRect.Left := TextLeft;
      TextRect.Right := Rect.Right - 1;
      TextRect.Top := TextTop;
      TextRect.Bottom := Rect.Bottom -1;
      Text := ButtonItem.Caption;
      if TStyleManager.IsCustomStyleActive and (seClient in StyleElements) then
      begin
        Canvas.Brush.Style := bsClear;
        if (seFont in StyleElements) and LStyle.GetElementColor(LDetails, ecTextColor, TxtColor) then
          Canvas.Font.Color := TxtColor;
        Canvas.TextRect(TextRect, Text, [tfEndEllipsis]);
        Canvas.Brush.Style := bsSolid;
      end
      else
        Canvas.TextRect(TextRect, Text, [tfEndEllipsis]);
    end;

    if (bdsFocused in State) and LStyle.IsSystemStyle then
    begin
      { Draw the focus rect }
      InflateRect(Rect, -2, -2);
      Canvas.DrawFocusRect(Rect);
    end;
    if Assigned(FOnAfterDrawButton) then
      FOnAfterDrawButton(Self, Index, Canvas, OrgRect, State);
  end;
  Canvas.Brush.Color := Color; { Restore the original color }
end;

procedure TButtonGroup.SetOnDrawButton(const Value: TGrpButtonDrawEvent);
begin
  FOnDrawButton := Value;
  Invalidate;
end;

procedure TButtonGroup.SetOnDrawIcon(const Value: TGrpButtonDrawIconEvent);
begin
  FOnDrawIcon := Value;
  Invalidate;
end;

{$IFDEF CLR}
[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
{$ENDIF}
procedure TButtonGroup.CreateHandle;
begin
  inherited CreateHandle;
  { Make sure that we are showing the scroll bars, if needed }
  Resize;
end;

procedure TButtonGroup.WMMouseLeave(var Message: TMessage);
begin
  FMouseInControl := False;
  if FHotIndex <> -1 then
  begin
    UpdateButton(FHotIndex);
    FHotIndex := -1;
    DoHotButton;
  end;
  if FDragImageList.Dragging then
  begin
    FDragImageList.HideDragImage;
    RemoveInsertionPoints;
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
  end;
end;

procedure TButtonGroup.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    { Focus ourselves, when clicked, like a button would }
    if not Focused then
      Winapi.Windows.SetFocus(Handle);

    FDragStarted := False;
    FDownIndex := IndexOfButtonAt(X, Y);
    if FDownIndex <> -1 then
    begin
      if gboAllowReorder in ButtonOptions then
        FDragIndex := FDownIndex;
      FDragStartPos := Point(X, Y);
      { If it is the same as the selected, don't do anything }
      if FDownIndex <> FItemIndex then
        UpdateButton(FDownIndex)
      else
        FDownIndex := -1;
    end;
  end;
end;

procedure TButtonGroup.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewHotIndex, OldHotIndex: Integer;
  EventTrack: TTrackMouseEvent;
  DragThreshold: Integer;
begin
  inherited;
  { Was the drag threshold met? }
  if (gboAllowReorder in ButtonOptions) and (FDragIndex <> -1) then
  begin
    DragThreshold := Mouse.DragThreshold;
    if (Abs(FDragStartPos.X - X) >= DragThreshold) or
        (Abs(FDragStartPos.Y - Y) >= DragThreshold) then
    begin
      FDragStartPos.X := X; { Used in the start of the drag }
      FDragStartPos.Y := Y;
      FDownIndex := -1; { Stops repaints and clicks }
      if FHotIndex <> -1 then
      begin
        OldHotIndex := FHotIndex;
        FHotIndex := -1;
        UpdateButton(OldHotIndex);
        { We must have the window process the paint message before
          the drag operation starts }
        UpdateWindow(Handle);
        DoHotButton;
      end;
      FDragStarted := True;
      BeginDrag(True, -1);
      Exit;
    end;
  end;

  NewHotIndex := IndexOfButtonAt(X, Y);
  if NewHotIndex <> FHotIndex then
  begin
    OldHotIndex := FHotIndex;
    FHotIndex := NewHotIndex;
    UpdateButton(OldHotIndex);
    if FHotIndex <> -1 then
      UpdateButton(FHotIndex);
    DoHotButton;
  end;
  if not FMouseInControl then
  begin
    FMouseInControl := True;
{$IF DEFINED(CLR)}
    EventTrack.cbSize := Marshal.SizeOf(TypeOf(TTrackMouseEvent));
{$ELSE}
    EventTrack.cbSize := SizeOf(TTrackMouseEvent);
{$ENDIF}
    EventTrack.dwFlags := TME_LEAVE;
    EventTrack.hwndTrack := Handle;
    EventTrack.dwHoverTime := 0;
    TrackMouseEvent(EventTrack);
  end;
end;

procedure TButtonGroup.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LastDown: Integer;
begin
  inherited;
  if (Button = mbLeft) and (not FDragStarted) then
  begin
    LastDown := FDownIndex;
    FDownIndex := -1;
    FDragIndex := -1;
    if (LastDown <> -1) and (IndexOfButtonAt(X, Y) = LastDown)
      and (FDragIndex = -1) then
    begin
      UpdateButton(LastDown);
      DoItemClicked(LastDown);
      if gboGroupStyle in ButtonOptions then
        ItemIndex := LastDown;
    end
    else if LastDown <> -1 then
      UpdateButton(LastDown);
    if Assigned(FOnClick) then
      FOnClick(Self);
  end;
  FDragStarted := False;
end;

function TButtonGroup.IndexOfButtonAt(const X, Y: Integer): Integer;
var
  ButtonsPerRow: Integer;
  HiddenCount: Integer;
  Row, Col: Integer;
begin
  Result := -1;
  { Is it within our X and Y bounds first? }
  if (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
  begin
    ButtonsPerRow := CalcButtonsPerRow;
    HiddenCount := FHiddenItems*ButtonsPerRow;
    Row := Y div FButtonHeight;
    if gboFullSize in FButtonOptions then
      Col := 0
    else
      Col := X div FButtonWidth;

    Result := HiddenCount + Row*ButtonsPerRow + Col;
    if Result >= FButtonItems.Count then
      Result := -1
    else if (Row+1)*FButtonHeight > Height then
      Result := -1; { Item is clipped }
  end;
end;

function TButtonGroup.IsTouchPropertyStored(AProperty: TTouchProperty): Boolean;
begin
  Result := inherited IsTouchPropertyStored(AProperty);
  case AProperty of
    tpInteractiveGestures:
      Result := Touch.InteractiveGestures <> [igPan, igPressAndTap];
    tpInteractiveGestureOptions:
      Result := Touch.InteractiveGestureOptions <> [igoPanInertia,
        igoPanSingleFingerHorizontal, igoPanSingleFingerVertical,
        igoPanGutter, igoParentPassthrough];
  end;
end;

procedure TButtonGroup.DoItemClicked(const Index: Integer);
var
  LFocusIndex: Integer;
  LButton: TGrpButtonItem;
  LOnClick: TNotifyEvent;
begin
  if FButtonItems[Index] <> nil then
  begin
    LFocusIndex := FFocusIndex;
    FFocusIndex := Index;
    if FFocusIndex <> -1 then
      UpdateButton(LFocusIndex);
    LButton := TGrpButtonItem(FButtonItems[Index]);
    LOnClick := LButton.OnClick;
    if Assigned(LOnClick) and (LButton.Action <> nil) and
       not DelegatesEqual(@LOnClick, @LButton.Action.OnExecute) then
      LOnClick(Self)
    else if not (csDesigning in ComponentState) and (LButton.ActionLink <> nil) then
      LButton.ActionLink.Execute(Self)
    else if Assigned(LOnClick) then
      LOnClick(Self)
    else if Assigned(FOnButtonClicked) then
      FOnButtonClicked(Self, Index);
  end
  else if Assigned(FOnButtonClicked) then
    FOnButtonClicked(Self, Index);
end;

procedure TButtonGroup.DragDrop(Source: TObject; X, Y: Integer);
var
  TargetIndex: Integer;
begin
  if (Source = Self) and (gboAllowReorder in ButtonOptions) then
  begin
    RemoveInsertionPoints;
    TargetIndex := TargetIndexAt(X, Y);
    if TargetIndex > FDragIndex then
      Dec(TargetIndex); { Account for moving ourselves }
    if TargetIndex <> -1 then
      DoReorderButton(FDragIndex, TargetIndex);
    FDragIndex := -1;
  end
  else
    inherited;
end;

const
  cScrollBuffer = 6;

procedure TButtonGroup.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  OverIndex: Integer;
begin
  if (Source = Self) and (gboAllowReorder in ButtonOptions) then
  begin
    { If the mouse is within the bottom cScrollBuffer pixels,
      then "auto-scroll" }
    if (FHiddenItems < FScrollBarMax) and (Y <= Height) and
         (Y >= Height - cScrollBuffer) and (X >= 0) and (X <= Width) then
      AutoScroll(scLineDown)
    else if (FHiddenItems > 0) and (Y >= 0) and
         (Y <= cScrollBuffer) and (X >= 0) and (X <= Width) then
      AutoScroll(scLineUp);

    OverIndex := TargetIndexAt(X, Y);
    { Don't accept when it is the same as the start or right after us }
    Accept := (OverIndex <> -1) and (OverIndex <> FDragIndex) and
      (OverIndex <> FDragIndex + 1) and (Items.Count > 1);
    FDragImageList.HideDragImage;
    if Accept and (State <> dsDragLeave) then
      SetInsertionPoints(OverIndex)
    else
      RemoveInsertionPoints;
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
  end
  else
    inherited DragOver(Source, X, Y, State, Accept);
end;

procedure TButtonGroup.DoHotButton;
begin
  if Assigned(FOnHotButton) then
    FOnHotButton(Self, FHotIndex);
end;

procedure TButtonGroup.DoStartDrag(var DragObject: TDragObject);
var
  ButtonRect: TRect;
  State: TButtonDrawState;
  DragImage: TBitmap;
begin
  inherited DoStartDrag(DragObject);
  if FDragIndex <> -1 then
  begin
    DragImage := TBitmap.Create;
    try
      ButtonRect := GetButtonRect(FDragIndex);
      DragImage.Width := ButtonRect.Right - ButtonRect.Left;
      DragImage.Height := ButtonRect.Bottom - ButtonRect.Top;
      State := [bdsDragged];
      if FItemIndex = FDragIndex then
        State := State + [bdsSelected];
      DrawButton(FDragIndex, DragImage.Canvas,
        Rect(0, 0, DragImage.Width, DragImage.Height), State);
      FDragImageList.Clear;
      FDragImageList.Width := DragImage.Width;
      FDragImageList.Height := DragImage.Height;
      FDragImageList.Add(DragImage, nil);
      FDragImageList.DragHotspot := TPoint.Create(FDragStartPos.X - ButtonRect.Left - Mouse.DragThreshold,
        FDragStartPos.Y - ButtonRect.Top - Mouse.DragThreshold);
    finally
      DragImage.Free;
    end;
  end
  else
    FDragImageList.Clear; { No drag image } 
end;

function TButtonGroup.GetDragImages: TDragImageList;
begin
  Result := FDragImageList;
end;

procedure TButtonGroup.RemoveInsertionPoints;
  procedure ClearSelection(var Index: Integer);
  var
    OldIndex: Integer;
  begin
    if Index <> -1 then
    begin
      OldIndex := Index;
      Index := -1;
      UpdateButton(OldIndex);
    end;
  end;

begin
  ClearSelection(FInsertTop);
  ClearSelection(FInsertLeft);
  ClearSelection(FInsertRight);
  ClearSelection(FInsertBottom);
end;

procedure TButtonGroup.DoReorderButton(const OldIndex, NewIndex: Integer);
var
  OldIndexID: Integer;
begin
  FIgnoreUpdate := True;
  try
    if FItemIndex <> -1 then
      OldIndexID := Items[FItemIndex].ID
    else
      OldIndexID := -1;
    FButtonItems.Items[OldIndex].Index := NewIndex;
    if OldIndexID <> -1 then
      FItemIndex := Items.FindItemID(OldIndexID).Index;
  finally
    FIgnoreUpdate := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  if Assigned(FOnReorderButton) then
    FOnReorderButton(Self, OldIndex, NewIndex);
end;

procedure TButtonGroup.AutoScroll(ScrollCode: TScrollCode);

  function ShouldContinue(out Delay: Integer): Boolean;
  const
    cMaxDelay = 500;
  begin
    { Are we autoscrolling up or down? }
    if ScrollCode = scLineDown then
    begin
      Result := FHiddenItems < FScrollBarMax;
      if Result then
      begin
        { Is the mouse still in position? }
        with ScreenToClient(Mouse.CursorPos) do
        begin
          if (X < 0) or (X > Width) or
             (Y > Height) or (Y < Height - cScrollBuffer) then
            Result := False
          else if Y < (Height - cScrollBuffer div 2) then
            Delay := cMaxDelay
          else
            Delay := cMaxDelay div 2; { A little faster }
        end
      end;
    end
    else
    begin
      Result := FHiddenItems > 0;
      if Result then
      begin
        with ScreenToClient(Mouse.CursorPos) do
          if (X < 0) or (X > Width) or
             (Y < 0) or (Y > cScrollBuffer) then
            Result := False
        else if Y > (cScrollBuffer div 2) then
          Delay := cMaxDelay
        else
          Delay := cMaxDelay div 2;
      end;
    end;
  end;
var
  CurrentTime, StartTime, ElapsedTime: Longint;
  Delay: Integer;
begin
  FDragImageList.HideDragImage;
  RemoveInsertionPoints;
  FDragImageList.ShowDragImage;

  CurrentTime := 0;
  while (ShouldContinue(Delay)) do
  begin
    StartTime := GetCurrentTime;
    ElapsedTime := StartTime - CurrentTime;
    if ElapsedTime < Delay then
      Sleep(Delay - ElapsedTime);
    CurrentTime := StartTime;

    FDragImageList.HideDragImage;
    ScrollPosChanged(ScrollCode, 0{ Ignored});
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
  end;
end;

function TButtonGroup.TargetIndexAt(const X, Y: Integer): Integer;
var
  ButtonRect: TRect;
  LastRect: TRect;
begin
  Result := IndexOfButtonAt(X, Y);
  if Result = -1 then
  begin
    LastRect := GetButtonRect(Items.Count);
    if (Y >= LastRect.Bottom) then
      Result := Items.Count
    else if (Y >= LastRect.Top) then
      if (gboFullSize in FButtonOptions) or (X >= LastRect.Left) then
        Result := Items.Count; { After the last item }
  end;
  if (Result > -1) and (Result < Items.Count) then
  begin
    { Before the index, or after it? }
    ButtonRect := GetButtonRect(Result);
    if CalcButtonsPerRow = 1 then
    begin
      if Y > (ButtonRect.Top + (ButtonRect.Bottom - ButtonRect.Top) div 2) then
        Inc(Result); { Insert above the item below it (after the index) }
    end
    else
      if X > (ButtonRect.Left + (ButtonRect.Right - ButtonRect.Left) div 2) then
        Inc(Result)
  end;
end;

procedure TButtonGroup.CNKeydown(var Message: TWMKeyDown);
var
  IncAmount: Integer;

  procedure FixIncAmount(const StartValue: Integer);
  begin
    { Keep it within the bounds }
    if StartValue + IncAmount >= FButtonItems.Count then
      IncAmount := FButtonItems.Count - StartValue - 1
    else if StartValue + IncAmount < 0 then
      IncAmount := 0 - StartValue; 
  end;

var
  NewIndex: Integer;

begin
  IncAmount := 0;
  if Message.CharCode = VK_DOWN then
    IncAmount := CalcButtonsPerRow
  else if Message.CharCode = VK_UP then
    IncAmount := -1*CalcButtonsPerRow
  else if Message.CharCode = VK_LEFT then
    IncAmount := -1
  else if Message.CharCode = VK_RIGHT then
    IncAmount := 1
  else if Message.CharCode = VK_NEXT then
    IncAmount := CalcRowsSeen
  else if Message.CharCode = VK_PRIOR then
    IncAmount := -1*CalcRowsSeen
  else if Message.CharCode = VK_HOME then
  begin
    if gboGroupStyle in ButtonOptions then
      IncAmount := -1*FItemIndex
    else
      IncAmount := -1*FFocusIndex;
  end
  else if Message.CharCode = VK_END then
  begin
    if gboGroupStyle in ButtonOptions then
      IncAmount := FButtonItems.Count - FItemIndex
    else
      IncAmount := FButtonItems.Count - FFocusIndex;
  end
  else if (Message.CharCode = VK_RETURN) or (Message.CharCode = VK_SPACE) then
  begin
    if (gboGroupStyle in ButtonOptions) and (FItemIndex <> -1) then
      DoItemClicked(FItemIndex) { Click the current item index }
    else if (gboGroupStyle in ButtonOptions) and
        (FFocusIndex >= 0) and (FFocusIndex < FButtonItems.Count) then
      DoItemClicked(FFocusIndex) { Click the focused index }
    else
      inherited;
  end
  else
    inherited;

  if IncAmount <> 0 then
  begin
    if gboGroupStyle in ButtonOptions then
      FixIncAmount(FItemIndex)
    else
      FixIncAmount(FFocusIndex);
    if IncAmount <> 0 then
    begin
      { Do the actual scrolling work }
      if gboGroupStyle in ButtonOptions then
      begin
        NewIndex := ItemIndex + IncAmount;
        ScrollIntoView(NewIndex);
        ItemIndex := NewIndex;
      end
      else
      begin
        NewIndex := FFocusIndex+ IncAmount;
        ScrollIntoView(NewIndex);
        UpdateButton(FFocusIndex);
        FFocusIndex := NewIndex;
        UpdateButton(FFocusIndex);
      end;
    end;
  end;
end;

procedure TButtonGroup.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  UpdateButton(FFocusIndex)
end;

procedure TButtonGroup.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if (FFocusIndex = -1) and (FButtonItems.Count > 0)  then
    FFocusIndex := 0; { Focus the first item }
  UpdateButton(FFocusIndex)
end;

procedure TButtonGroup.ScrollIntoView(const Index: Integer);
var
  RowsSeen, ButtonsPerRow, HiddenCount, VisibleCount: Integer;
begin
  if (Index >= 0) and (Index < FButtonItems.Count) then
  begin
    ButtonsPerRow := CalcButtonsPerRow;
    HiddenCount := FHiddenItems*ButtonsPerRow;
    if Index < HiddenCount then
    begin
      { We have to scroll above to get the item insight }
      while (Index <= HiddenCount) and (FHiddenItems > 0) do
      begin
        ScrollPosChanged(scLineUp, 0);
        HiddenCount := FHiddenItems*ButtonsPerRow;
      end;
    end
    else
    begin
      RowsSeen := CalcRowsSeen;
      VisibleCount := RowsSeen*ButtonsPerRow;
      { Do we have to scroll down to see the item? }
      while Index >= (HiddenCount + VisibleCount) do
      begin
        ScrollPosChanged(scLineDown, 0);
        HiddenCount := FHiddenItems*ButtonsPerRow;
      end;
    end;
  end;
end;

procedure TButtonGroup.CMHintShow(var Message: TCMHintShow);
var
  ItemIndex: Integer;
{$IF DEFINED(CLR)}
  LHintInfo: THintInfo;
{$ELSE}
  LHintInfo: PHintInfo;
{$ENDIF}
begin
  Message.Result := 1; { Don't show the hint }
  if Message.HintInfo.HintControl = Self then
  begin
    ItemIndex := IndexOfButtonAt(Message.HintInfo.CursorPos.X, Message.HintInfo.CursorPos.Y);
    if (ItemIndex >= 0) and (ItemIndex < Items.Count) then
    begin
      LHintInfo := Message.HintInfo;
      with LHintInfo{$IFNDEF CLR}^{$ENDIF} do
      begin
        { Only show the hint if the item's text is truncated }
        if Items[ItemIndex].Hint <> '' then
          HintStr := Items[ItemIndex].Hint
        else
        begin
          // corbin - finish..
        //  Canvas.TextRect(TextRect, Items[ItemIndex].Caption, [tfEndEllipsis]);
          HintStr := Items[ItemIndex].Caption;
        end;
      end;
      if (Items[ItemIndex].ActionLink <> nil) then
        Items[ItemIndex].ActionLink.DoShowHint(LHintInfo.HintStr);
      LHintInfo.CursorRect := GetButtonRect(ItemIndex);
{$IF DEFINED(CLR)}
      Message.HintInfo := LHintInfo;
{$ENDIF}
      Message.Result := 0; { Show the hint }
    end;
  end;
end;

procedure TButtonGroup.Assign(Source: TPersistent);
begin
  if Source is TButtonGroup then
  begin
    Items := TButtonGroup(Source).Items;
    ButtonHeight := TButtonGroup(Source).ButtonHeight;
    ButtonWidth := TButtonGroup(Source).ButtonWidth;
    ButtonOptions := TButtonGroup(Source).ButtonOptions;
  end
  else
    inherited;
end;

procedure TButtonGroup.SetInsertionPoints(const InsertionIndex: Integer);
begin
  if FInsertTop <> InsertionIndex then 
  begin
    RemoveInsertionPoints;

    if CalcButtonsPerRow = 1 then
    begin
      FInsertTop := InsertionIndex;
      FInsertBottom := InsertionIndex - 1;
    end
    else
    begin
      { More than one button per row, so use Left/Right separators }
      FInsertLeft := InsertionIndex;
      FInsertRight := InsertionIndex - 1;
    end;

    UpdateButton(FInsertTop);
    UpdateButton(FInsertLeft);
    UpdateButton(FInsertBottom);
    UpdateButton(FInsertRight);

    UpdateWindow(Handle);
  end;
end;

procedure TButtonGroup.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FDragIndex := -1;
  RemoveInsertionPoints;
end;

procedure TButtonGroup.SetDragIndex(const Value: Integer);
begin
  FDragIndex := Value;
  FDragStarted := True;
end;

function TButtonGroup.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    UpdateButton(FHotIndex);
    FHotIndex := -1;
    Result := True;
    if (FScrollBarMax > 0) and (Shift = []) then
      ScrollPosChanged(scLineDown, 0)
    else if (FScrollBarMax > 0) and (ssCtrl in Shift) then
      ScrollPosChanged(scPageDown, 0)
{    else if ssShift in Shift then
    begin
      NextButton := GetNextButton(SelectedItem, True);
      if NextButton <> nil then
        SelectedItem := NextButton;
    end;
    }
  end;
end;

function TButtonGroup.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    UpdateButton(FHotIndex);
    FHotIndex := -1;
    Result := True;
    if (FScrollBarMax > 0) and (Shift = []) then
      ScrollPosChanged(scLineUp, 0)
    else if (FScrollBarMax > 0) and (ssCtrl in Shift) then
      ScrollPosChanged(scPageUp, 0)
{    else if ssShift in Shift then
    begin
      NextButton := GetNextButton(SelectedItem, False);
      if NextButton <> nil then
        SelectedItem := NextButton;
    end;
    }
  end;
end;

{ TGrpButtonItem }

function TGrpButtonItem.GetButtonGroup: TButtonGroup;
begin
  Result := Collection.ButtonGroup;
end;

function TGrpButtonItem.GetCollection: TGrpButtonItems;
begin
  Result := TGrpButtonItems(inherited Collection);
end;

function TGrpButtonItem.GetNotifyTarget: TComponent;
begin
  Result := TComponent(ButtonGroup);
end;

procedure TGrpButtonItem.ScrollIntoView;
begin
  TGrpButtonItems(Collection).FButtonGroup.ScrollIntoView(Index);
end;

procedure TGrpButtonItem.SetCollection(const Value: TGrpButtonItems);
begin
  inherited Collection := Value;
end;

{ TGrpButtonItems }

function TGrpButtonItems.Add: TGrpButtonItem;
begin
  Result := TGrpButtonItem(inherited Add);
end;

function TGrpButtonItems.AddItem(Item: TGrpButtonItem;
  Index: Integer): TGrpButtonItem;
begin
  if (Item = nil) and (FButtonGroup <> nil) then
    Result := FButtonGroup.CreateButton
  else
    Result := Item;
  if Assigned(Result) then
  begin
    Result.Collection := Self;
    if Index < 0 then
      Index := Count - 1;
    Result.Index := Index;
  end;
end;

procedure TGrpButtonItems.BeginUpdate;
begin
  if UpdateCount = 0 then
    if FButtonGroup.ItemIndex <> -1 then
      FOriginalID := Items[FButtonGroup.ItemIndex].ID
    else
      FOriginalID := -1;
  inherited;
end;

constructor TGrpButtonItems.Create(const ButtonGroup: TButtonGroup);
begin
  if ButtonGroup <> nil then
    inherited Create(ButtonGroup.GetButtonClass)
  else
    inherited Create(TGrpButtonItem);
  FButtonGroup := ButtonGroup;
  FOriginalID := -1;
end;

function TGrpButtonItems.GetItem(Index: Integer): TGrpButtonItem;
begin
  Result := TGrpButtonItem(inherited GetItem(Index));
end;

function TGrpButtonItems.GetOwner: TPersistent;
begin
  Result := FButtonGroup;
end;

function TGrpButtonItems.Insert(Index: Integer): TGrpButtonItem;
begin
  Result := AddItem(nil, Index);
end;

procedure TGrpButtonItems.SetItem(Index: Integer; const Value: TGrpButtonItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TGrpButtonItems.Update(Item: TCollectionItem);
var
  AItem: TCollectionItem;
begin
  if (UpdateCount = 0) and (not FButtonGroup.FIgnoreUpdate) then
  begin
    if Item <> nil then
      FButtonGroup.UpdateButton(Item.Index)
    else
    begin
      if (FOriginalID <> -1) then
        AItem := FindItemID(FOriginalID)
      else
        AItem := nil;
      if AItem = nil then
      begin
        FButtonGroup.FItemIndex := -1;
        FButtonGroup.FFocusIndex := -1;
      end
      else if gboGroupStyle in FButtonGroup.ButtonOptions then
        FButtonGroup.FItemIndex := AItem.Index;
      FButtonGroup.Resize;
      FButtonGroup.UpdateAllButtons;
    end;
  end;
end;

end.
