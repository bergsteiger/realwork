unit fcOutlookList;
{
//
// Components : TfcOutlookList
//
// Copyright (c) 1999 by Woll2Woll Software
// 6/18/99 - Add DitherColor property for selected item.
// 7/27/99 - PYW - Added GlyphOffset and Alignment support for OutlookItems
// 9/10/99 - Make certain that selected color is the same as the hottracktextcolor.
}

interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, fcCustomDraw, fcCommon, CommCtrl, Buttons, fcCollection, fcClearPanel,
  fcimager,
  {$ifdef fcDelphi4Up}
  ImgList,
  {$endif}
  ExtCtrls;

type
  TfcCustomOutlookList = class;
  TfcOutlookListItem = class;

  TfcScrollButtonStyle = (sbNone, sbUp, sbDown);

  TfcOutlookPanel = class(TCustomControl)
  private
    FAnimating: Boolean;
    FTransparent: Boolean;
    FInEraseBkGnd: Boolean;
    FOutlookPage: TPersistent;

    procedure SetTransparent(Value: Boolean);

    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
  public
    FPreventUpdate: Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Animating: Boolean read FAnimating write FAnimating;
    property OutlookPage: TPersistent read FOutlookPage write FOutlookPage;
    property Transparent: Boolean read FTransparent write SetTransparent;
  end;

  TfcCustomOutlookListItemEvent = procedure(OutlookList: TfcCustomOutlookList; Item: TfcOutlookListItem) of object;
  TfcOutlookListDrawItemEvent = procedure(OutlookList: TfcCustomOutlookList; Item: TfcOutlookListItem;
    var GlyphPos, TextPos: TPoint; var DefaultDrawing: Boolean) of object;

  TfcOutlookListItem = class(TfcCollectionItem)
  private
    // Property Storage Variables
    FButtonRect: TRect;
    FItemRect: TRect;
    FImageIndex: Integer;
    FMouseDownOnItem: Boolean;
    FMouseOnItem: Boolean;
    FSelected: Boolean;
    FSeparation: Integer;
    FText: string;
    {$ifdef fcDelphi4Up}
    FTextAlignment: TAlignment;
    FGlyphOffset: integer;
    {$endif}
    FOnClick: TfcCustomOutlookListItemEvent;

    // Property Access methods
    function GetSelected: Boolean;
    function GetOutlookList: TfcCustomOutlookList;
    procedure SetImageIndex(Value: Integer);
    procedure SetMouseDownOnItem(Value: Boolean);
    procedure SetMouseOnItem(Value: Boolean);
    procedure SetSeparation(Value: Integer);
    procedure SetSelected(Value: Boolean);
    procedure SetText(Value: string);
    {$ifdef fcDelphi4Up}
    procedure SetGlyphOffset(Value: Integer);
    procedure SetTextAlignment(Value: TAlignment);
    {$endif}
  protected
    function GetItemSize(IncludePadding: Boolean): TSize;
    function IsVisible(Completely: Boolean): Boolean; virtual;
    function SpacingSize: Integer; virtual;
    procedure Paint; virtual;
    procedure PaintButton(IconRect: TRect); virtual;
    function GetDisplayName: string; override;

    property ButtonRect: TRect read FButtonRect;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function DisplayRect(Code: TDisplayCode; AStartPos: Integer): TRect;
    function IsDown: Boolean; virtual;
    procedure Invalidate(Erase: Boolean); virtual;
    property ItemRect: TRect read FItemRect;
    property MouseDownOnItem: Boolean read FMouseDownOnItem write SetMouseDownOnItem;
    property MouseOnItem: Boolean read FMouseOnItem write SetMouseOnItem;
    property OutlookList: TfcCustomOutlookList read GetOutlookList;
  published
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Selected: Boolean read GetSelected write SetSelected;
    property Separation: Integer read FSeparation write SetSeparation;
    property Tag;
    property Text: string read FText write SetText;
    property OnClick: TfcCustomOutlookListItemEvent read FOnClick write FOnClick;

    {$ifdef fcDelphi4Up}
    property TextAlignment: TAlignment read FTextAlignment write SetTextAlignment default taCenter;
    property GlyphOffset: integer read FGlyphOffset write SetGlyphOffset default 0;
    {$endif}
  end;

  TfcOutlookListItemClass = class of TfcOutlookListItem;

  TfcOutlookListItems = class(TfcCollection)
  private
    FOutlookList: TfcCustomOutlookList;
  protected
    // Overriden methods
    function GetOwner: TPersistent; override;

    // Property access methods
    function GetItems(Index: Integer): TfcOutlookListItem;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOutlookList: TfcCustomOutlookList; ACollectionItemClass: TfcOutlookListItemClass); virtual;

    function Add: TfcOutlookListItem;
    function AddItem: TfcCollectionItem; override;

    property OutlookList: TfcCustomOutlookList read FOutlookList;
    property Items[Index: Integer]: TfcOutlookListItem read GetItems; default;
  end;

  TfcOutlookHotTrackStyle = (hsIconHilite, hsItemHilite);
  TfcCustomOutlookListClickStyle = (csClick, csSelect);

  TfcCustomOutlookList = class(TfcOutlookPanel)
  private
    // Property Storage Variables
    FBorderStyle: TBorderStyle;
    FClickStyle: TfcCustomOutlookListClickStyle;
    FHotTrackStyle: TfcOutlookHotTrackStyle;
    FHotTrackTextColor: TColor;
    FImageList: TCustomImageList;
    FItemLayout: TButtonLayout;
    FItemHighlightColor: TColor;
    FItemHotTrackColor: TColor;
    FItemShadowColor: TColor;
    FItems: TfcOutlookListItems;
    FItemSpacing: Integer;
    FItemsWidth: Integer;
    FLayout: TfcLayout;
    FPaintBitmap: TBitmap;
    FScrollInterval: Integer;
    FOnItemClick: TfcCustomOutlookListItemEvent;
    FOnItemChange: TfcCustomOutlookListItemEvent;
    FOnDrawItem: TfcOutlookListDrawItemEvent;
    FTopItem: TfcOutlookListItem;

    FUpButtonRect, FDownButtonRect: TRect;
    FScrollButtonDown: TfcScrollButtonStyle;
    FScrollButtonsVisible: Boolean;
    FMouseInScrollButton: TfcScrollButtonStyle;
    FChangeLink: TChangeLink;
    FOldCapture: HWND;
    FOutlookPage: TPersistent;
    {$ifdef fcDelphi4Up}
    FItemSelectedDitherColor: TColor;
    {$endif}

    // Property Access methods
    function GetListItems(Index: Integer): TfcOutlookListItem;
    function GetBottomItem: TfcOutlookListItem;
    function GetPaintCanvas: TCanvas;
    function GetSelected: TfcOutlookListItem;
    function GetTopItem: TfcOutlookListItem;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetClickStyle(Value: TfcCustomOutlookListClickStyle);
    procedure SetImageList(Value: TCustomImageList);
    procedure SetItemHighlightColor(Value: TColor);
    procedure SetItemLayout(Value: TButtonLayout);
    procedure SetItemShadowColor(Value: TColor);
    procedure SetItems(Value: TfcOutlookListItems);
    procedure SetItemSpacing(Value: Integer);
    procedure SetItemsWidth(Value: Integer);
    procedure SetLayout(Value: TfcLayout);
    procedure SetMouseInScrollButton(Value: TfcScrollButtonStyle);
    procedure SetScrollButtonsVisible(Value: Boolean);
    procedure SetTopItem(Value: TfcOutlookListItem);
    Function GetImager: TfcCustomImager;
    Function IsEffectiveItemHilite: boolean;

    // Message Handlers
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMEraseBkgnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
  protected
    // Overridden Methods
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure UpdateButtonRects; virtual;
    procedure ValidateInsert(AComponent: TComponent); override;

    // Virtual Methods
    function ScrollButtonVisible(Button: TfcScrollButtonStyle): Boolean; virtual;
    procedure DoDrawItem(Item: TfcOutlookListItem; var GlyphPos, TextPos: TPoint; var DefaultDrawing: Boolean); virtual;
    procedure ImageListChange(Sender: TObject); virtual;
    procedure InvalidateScrollButton(Button: TfcScrollButtonStyle); virtual;
    procedure ItemClick(Item: TfcOutlookListItem); virtual;
    procedure ScrollButtonClick; virtual;
    procedure UpdateMouseOnItem; virtual;
    procedure UpdateScrollButtonsRect; virtual;

    property MouseInScrollButton: TfcScrollButtonStyle read FMouseInScrollButton write SetMouseInScrollButton;
  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetItemAt(x, y: Integer): TfcOutlookListItem; virtual;
    procedure PaintScrollButton(Button: TfcScrollButtonStyle); virtual;

    property ListItems[Index: Integer]: TfcOutlookListItem read GetListItems;
    property BottomItem: TfcOutlookListItem read GetBottomItem;
    property Selected: TfcOutlookListItem read GetSelected;
    property TopItem: TfcOutlookListItem read GetTopItem write SetTopItem;

    property PaintCanvas: TCanvas read GetPaintCanvas;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property ClickStyle: TfcCustomOutlookListClickStyle read FClickStyle write SetClickStyle;
    property HotTrackStyle: TfcOutlookHotTrackStyle read FHotTrackStyle write FHotTrackStyle;
    property HotTrackTextColor: TColor read FHotTrackTextColor write FHotTrackTextColor;
    property Images: TCustomImageList read FImageList write SetImageList;
    property ItemHighlightColor: TColor read FItemHighlightColor write SetItemHighlightColor;
    property ItemHotTrackColor: TColor read FItemHotTrackColor write FItemHotTrackColor;
    property ItemLayout: TButtonLayout read FItemLayout write SetItemLayout;
    property ItemShadowColor: TColor read FItemShadowColor write SetItemShadowColor;
    property Items: TfcOutlookListItems read FItems write SetItems;
    property ItemSpacing: Integer read FItemSpacing write SetItemSpacing;
    property ItemsWidth: Integer read FItemsWidth write SetItemsWidth;
    property Layout: TfcLayout read FLayout write SetLayout;
    property OutlookPage: TPersistent read FOutlookPage write FOutlookPage;
    property ScrollButtonsVisible: Boolean read FScrollButtonsVisible write SetScrollButtonsVisible;
    property ScrollInterval: Integer read FScrollInterval write FScrollInterval;
    { RSW - 6/18/99 }
    {$ifdef fcDelphi4Up}
    property ItemSelectedDitherColor: TColor read FItemSelectedDitherColor write FItemSelectedDitherColor;
    {$endif}

    property OnDrawItem: TfcOutlookListDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnItemClick: TfcCustomOutlookListItemEvent read FOnItemClick write FOnItemClick;
    property OnItemChange: TfcCustomOutlookListItemEvent read FOnItemChange write FOnItemChange;
  end;

  TfcOutlookList = class(TfcCustomOutlookList)
  published
    property Align;
    property BorderStyle;
    property ClickStyle;
    property Color;
    property DragCursor;
    property DragMode;
    property Font;
    property HotTrackStyle;
    property Images;
    property ItemHighlightColor;
    property ItemHotTrackColor;
    property ItemLayout;
    property ItemShadowColor;
    {$ifdef fcDelphi4Up}
    property ItemSelectedDitherColor;
    {$endif}
    property Items;
    property ItemSpacing;
    property ItemsWidth;
    property Layout;
    property PopupMenu;
    property ScrollButtonsVisible;
    property ScrollInterval;
    property ShowHint;
    property Transparent;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDrag;
    property OnItemClick;
    property OnItemChange;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnStartDrag;
  end;

implementation

uses fcOutlookBar;

const ScrollTimerID = 100;

constructor TfcOutlookPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls];
  Transparent := True; { RSW - 3/19/99 (Necessary to paint imager }
end;

destructor TfcOutlookPanel.Destroy;
begin
   inherited;
end;

procedure TfcOutlookPanel.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    if Parent <> nil then Parent.Invalidate;
  end;
end;

procedure TfcOutlookPanel.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TfcOutlookPanel.AlignControls(AControl: TControl; var Rect: TRect);
//var OutlookBar: TfcCustomOutlookBar;
begin
  {  4/14/99 - RSW - During animating do not align controls }
{  if (Parent is TfcCustomOutlookBar) then
  begin
     OutlookBar:=TfcCustomOutlookBar(Parent);
     if OutlookBar.AnimatingControls then exit;
  end;}
  inherited;
  if AControl is TGraphicControl then Invalidate;
end;

procedure TfcOutlookPanel.Paint;
var FPaintImageBitmap: TBitmap;
    OutlookBar: TfcCustomOutlookBar;
    OffsetClipRect: TRect;
//    curPanel: TfcOutlookPanel;
    r, r1, ir: TRect;
    j: integer;
begin
  { 4/10/99 - RSW - Paint imager area for ClipRect area }
  if (Parent is TfcCustomOutlookBar) then
  begin
     OutlookBar:=TfcCustomOutlookBar(Parent);
     if Transparent and (not OutlookBar.AnimatingControls) and
       (OutLookBar.Imager <> nil) then
     begin
        FPaintImageBitmap := TBitmap.Create;
        FPaintImageBitmap.Width := OutlookBar.Width;
        FPaintImageBitmap.Height := OutlookBar.Height;

        if OutlookBar.Imager.DrawStyle=dsTile then
           OutlookBar.Imager.WorkBitmap.TileDraw(
             FPaintImageBitmap.Canvas, Rect(0,0,OutlookBar.Width, OutlookBar.Height))
        else
          FPaintImageBitmap.Canvas.StretchDraw(
             Rect(0,0,OutlookBar.Width, OutlookBar.Height),
             OutlookBar.Imager.WorkBitmap);

        with Canvas.ClipRect do
          OffsetClipRect:= Rect(Left + BoundsRect.Left, Top + BoundsRect.Top,
                                Right+ BoundsRect.Left, Bottom+BoundsRect.Top);
        Canvas.CopyRect(Canvas.ClipRect, FPaintImageBitmap.Canvas, OffsetClipRect);
        FPaintImageBitmap.Free;
     end;

  end;

  if GetWindowLong(Parent.Handle, GWL_STYLE) and WS_CLIPCHILDREN = WS_CLIPCHILDREN then
  begin
    SetWindowLong(Parent.Handle, GWL_STYLE,
      GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
    Invalidate;
  end;

  { 4/15/99 - RSW - only invalidate controls that intersect with cliprect.
    Neccesary when controls alClient }
  if (Parent is TfcCustomOutlookBar) then
  begin
     if not TfcCustomOutlookBar(Parent).InAnimation then exit;
     for j := 0 to ControlCount - 1 do if Controls[j] is TWinControl then
     begin
        r := Controls[j].BoundsRect;
        offsetRect(r, left, top); { Adjust to outlookbar coordinates }

        r1:= TfcOutlookBar(parent).canvas.cliprect;
        if IntersectRect(ir, r1, r) then begin
           offsetRect(r, -left, -top); { Adjust to outlookbar coordinates }
           offsetRect(r, -Controls[j].BoundsRect.Left, -Controls[j].BoundsRect.top);
           InvalidateRect((Controls[j] as TWinControl).Handle, @r, False);
        end
     end;
  end;

{  for i := 0 to ControlCount - 1 do
    if Controls[i] is TWinControl then
      InvalidateRect((Controls[i] as TWinControl).Handle, nil, False);}
end;

procedure TfcOutlookPanel.CMControlListChange(var Message: TCMControlListChange);
begin
  inherited;
  if (Message.Inserting = False) and (Message.Control is TfcCustomOutlookList) then Invalidate;
end;

procedure TfcOutlookPanel.WMEraseBkgnd(var Message: TWMEraseBkGnd);
var  j: integer;
//var Rgn, TmpRgn: HRGN;
begin
  for j := 0 to ControlCount - 1 do // RSW - 3/19/99 - If contain outlooklist then don't erase
    if Controls[j] is TfcOutlookList then
      if not (Controls[j] as TfcOutlookList).Transparent then
      begin
        Message.result:=1;
        exit;
      end;

  if not Transparent or not Animating and ((Parent is TfcCustomOutlookBar) and ((Parent as TfcCustomOutlookBar).Imager = nil)) then
  begin
    inherited;
    Exit;
  end;

  if FInEraseBkGnd then Exit;
  if not TfcOutlookPage(OutlookPage).OutlookBar.AnimatingControls then exit; { RSW }
{  FInEraseBkGnd := True;
  Message.result := 1;

  if FPreventUpdate then Exit;
  if Parent <> nil then
  begin
    Rgn := CreateRectRgn(0, 0, Width, Height);
    TmpRgn := CreateRectRgn(0, 0, 0, 0);
    fcGetChildRegions(self, True, TmpRgn, Point(0, 0), RGN_OR);
    CombineRgn(Rgn, Rgn, TmpRgn, RGN_DIFF);
    DeleteObject(TmpRgn);
    OffsetRgn(Rgn, Left, Top);

    InvalidateRgn(Parent.Handle, Rgn, False);
    Parent.Update;

    DeleteObject(Rgn);
  end;
  FInEraseBkGnd := False;}
end;

constructor TfcOutlookListItem.Create(Collection: TCollection);
begin
  inherited;
  FSeparation := 10;
  {$ifdef fcDelphi4Up}
  FTextAlignment:= taCenter;
  {$endif}
end;

destructor TfcOutlookListItem.Destroy;
begin
  if OutlookList.FTopItem = self then OutlookList.TopItem := nil;

  inherited;
end;

function TfcOutlookListItem.GetDisplayName: string; { 4/26/99 - RSW }
begin
  Result := Text;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TfcOutlookListItem.GetSelected: Boolean;
begin
  if OutlookList.ClickStyle = csSelect then result := FSelected else result := False;
end;

function TfcOutlookListItem.GetOutlookList: TfcCustomOutlookList;
begin
  result := (Collection as TfcOutlookListItems).OutlookList;
end;

procedure TfcOutlookListItem.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Invalidate(True);
  end;
end;

procedure TfcOutlookListItem.SetMouseDownOnItem(Value: Boolean);
begin
  if FMouseDownOnItem <> Value then
  begin
    FMouseDownOnItem := Value;
    if not Selected then Invalidate(False);
  end;
end;

procedure TfcOutlookListItem.SetMouseOnItem(Value: Boolean);
begin
  if not (csDesigning in Outlooklist.ComponentState) and ((FMouseOnItem <> Value) or (Value and (GetCapture <> OutlookList.Handle))) then
  begin
    FMouseOnItem := Value;
    if not FMouseOnItem then MouseDownOnItem := False;
    //9/10/99 - Make certain that Button is always invalidated 
{    if not Selected then }Invalidate(False);
    if Value and (GetCapture <> OutlookList.Handle) then SetCapture(OutlookList.Handle);
  end;
end;

procedure TfcOutlookListItem.SetSelected(Value: Boolean);
var i: Integer;
begin
  if FSelected <> Value then
  begin
    if Value then for i := 0 to OutlookList.Items.Count - 1 do
      if OutlookList.Items[i] <> self then
        OutlookList.Items[i].Selected := False;
    FSelected := Value;
    Invalidate(not FSelected);
  end;
end;

procedure TfcOutlookListItem.SetSeparation(Value: Integer);
begin
  if FSeparation <> Value then
  begin
    FSeparation := Value;
    Invalidate(True);
  end;
end;

function TfcOutlookListItem.DisplayRect(Code: TDisplayCode; AStartPos: Integer): TRect;
var i: Integer;
    ItemSize, ItemSizeNoPad: TSize;
    Offset: Integer;
    TextSize: TSize;
    tempRect: TRect;
  function ImageListSize: TSize;
  begin
    result := fcSize(0, 0);
    if OutlookList.Images <> nil then with TImageList(OutlookList.Images) do
      result := fcSize(Width, Height);
  end;
begin
  SetRectEmpty(result);

  if IsVisible(False) then
    with OutlookList do
    begin
      ItemSize := GetItemSize(True);
      ItemSizeNoPad := GetItemSize(False);

      Offset := 0;
      if AStartPos = -1 then
      begin
        for i := TopItem.Index to BottomItem.Index do
          if Index = Items[i].Index then Break else inc(Offset, Items[i].SpacingSize);
      end else Offset := AStartPos;

      if Layout = loVertical then
      begin
        result.Top := Offset;
        result.Bottom := result.Top + ItemSize.cy;
        result.Right := ClientWidth;
      end else begin
        inc(result.Left, Offset);
        result.Right := result.Left + ItemSize.cx;
        result.Bottom := ClientHeight;
      end;

      tempRect:= Result; { 7/9/99 - PYW -Compute height and consider carrige returns }
      if (ImageListSize.cx > 0) and {7/9/99 - Adjust based on ItemLayout and glyph}
         (OutlookList.ItemLayout=blglyphLeft) then
         tempRect.Left := {$ifdef fcDelphi4Up}GlyphOffset+{$endif}tempRect.Left+Separation + ImageListSize.cx + 4;

      TextSize.cy:= DrawText(PaintCanvas.Handle, PChar(self.Text), Length(self.Text), TempRect, DT_CALCRECT or DT_CENTER or DT_END_ELLIPSIS or DT_WORDBREAK);
      TextSize.cx:= TempRect.Right-TempRect.Left;

      case Code of
        drBounds, drSelectBounds: ;
        drIcon: begin
          fcCalcButtonLayout(Point(result.Left + fcRectWidth(result) div 2, result.Top + fcRectHeight(result) div 2),
            nil, @result, TextSize, ImageListSize, ItemLayout, self.Separation);
          InflateRect(result, 2, 2);
        end;
        drLabel: begin
          fcCalcButtonLayout(Point(result.Left + fcRectWidth(result) div 2, result.Top + fcRectHeight(result) div 2),
            @result, nil, TextSize, ImageListSize, ItemLayout, self.Separation);
        end;
      end;
    end;
end;

{$ifdef fcDelphi4Up}
procedure TfcOutlookListItem.SetTextAlignment(Value: TAlignment);
begin
  if FTextAlignment <> Value then
  begin
    FTextAlignment := Value;
    RefreshDesign;
    Invalidate(True);
  end;
end;

procedure TfcOutlookListItem.SetGlyphOffset(Value: integer);
begin
  if FGlyphOffset <> Value then
  begin
    FGlyphOffset := Value;
    RefreshDesign;
    Invalidate(True);
  end;
end;
{$endif}

procedure TfcOutlookListItem.SetText(Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    RefreshDesign;
    Invalidate(True);
  end;
end;

function TfcOutlookListItem.GetItemSize(IncludePadding: Boolean): TSize;
var Padding: Integer;
begin
  result := OutlookList.PaintCanvas.TextExtent(Text);
  Padding := 0;
  if IncludePadding then inc(Padding, OutlookList.ItemSpacing);
  if OutlookList.Layout = loVertical then inc(result.cy, Padding) else inc(result.cx, Padding);
  if OutlookList.Images <> nil then
  begin
    if OutlookList.ItemLayout in [blGlyphTop, blGlyphBottom] then
      inc(result.cy, TImageList(OutlookList.Images).Height + Separation)
    else
      {$ifdef fcDelphi4Up} //7/27/99-PYW-Added extra padding for textrect
      inc(result.cx,8+GlyphOffset+TImageList(OutlookList.Images).Width + Separation);
      {$else}
      inc(result.cx,TImageList(OutlookList.Images).Width + Separation);
      {$endif}
  end;
  if (OutlookList.Layout = loHorizontal) and (OutlookList.ItemsWidth > 0) then result.cx := OutlookList.ItemsWidth;
end;

function TfcOutlookListItem.SpacingSize: Integer;
begin
  if OutlookList.Layout = loVertical then result := GetItemSize(True).cy
  else result := GetItemSize(True).cx;
end;

function TfcOutlookListItem.IsVisible(Completely: Boolean): Boolean;
begin
  result := False;
  if OutlookList.TopItem = nil then Exit;
  result := (Index >= OutlookList.TopItem.Index) and (Index <= OutlookList.BottomItem.Index);
  if result and Completely then with OutlookList do
    result := (ItemRect.Right <= Width) and (ItemRect.Bottom <= Height);
end;

procedure TfcOutlookListItem.Paint;
var BoundsRect, TextRect, IconRect, TempIconRect: TRect;
    StartBounds: PInteger;
    DefaultDrawing: Boolean;
    GlyphPos, TextPos: TPoint;
    Flags: integer;
    r: TRect;
begin
  GetUpdateRect(OutlookList.handle, r, False);
  GetUpdateRect(OutlookList.parent.handle, r, False);
  if OutlookList.Layout = loVertical then StartBounds := @BoundsRect.Top else StartBounds := @BoundsRect.Left;
  BoundsRect := DisplayRect(drBounds, -1);
  TextRect := DisplayRect(drLabel, StartBounds^);
  IconRect := DisplayRect(drIcon, StartBounds^);

  FItemRect := BoundsRect;

  with OutlookList do
  begin
    PaintCanvas.Brush.Color := Color;
    PaintCanvas.Font.Color := Font.Color;
    if IsEffectiveItemHilite and MouseOnItem then PaintCanvas.Font.Color := HotTrackTextColor;
    //9/10/99 - Make certain that selected color is the same as the hottracktextcolor.
    if self.Selected then PaintCanvas.Font.Color := HotTrackTextColor;
    if IsEffectiveItemHilite and IsDown then OffsetRect(TextRect, 1, 1);
  end;

  DefaultDrawing := True;
  GlyphPos := IconRect.TopLeft;
  TextPos := TextRect.TopLeft;
  {$ifdef fcDelphi4Up}
  if (GlyphOffset>0) and (OutlookList.Images <> nil) then
  begin //7/9/99 - PYW - Adjust based on ItemLayout
     if (OutlookList.ItemLayout = blGlyphLeft) then begin
        TextPos.X := FItemRect.Left+4+TImageList(OutlookList.Images).Width + GlyphOffset + Separation;
        if OutlookList.IsEffectiveItemHilite and IsDown then inc(TextPos.X);
        GlyphPos.X:= FItemRect.Left+GlyphOffset;
     end
     else if (OutlookList.ItemLayout = blGlyphRight) then begin
        TextPos.X := FItemRect.Left+3;
        if OutlookList.IsEffectiveItemHilite and IsDown then inc(TextPos.X);
        GlyphPos.X := FItemRect.Right - TImageList(OutlookList.Images).Width - GlyphOffset - 1;
     end;
  end;
  {$endif}

  OutlookList.DoDrawItem(self, GlyphPos, TextPos, DefaultDrawing);

  OffsetRect(IconRect, GlyphPos.x - IconRect.Left, GlyphPos.y - IconRect.Top);
  OffsetRect(TextRect, TextPos.x - TextRect.Left, TextPos.y - TextRect.Top);
  TempIconRect := IconRect;

 {$ifdef fcDelphi4Up}
  if OutlookList.Layout = loVertical then begin
 {$endif}
     if not OutlookList.IsEffectiveItemHilite then
       UnionRect(FButtonRect, IconRect, TextRect);
 {$ifdef fcDelphi4Up}
  end;
 {$endif}
  if OutlookList.IsEffectiveItemHilite then FButtonRect := BoundsRect;

  if DefaultDrawing then
    with OutlookList do
  begin
    PaintButton(TempIconRect);
    SetBkMode(PaintCanvas.Handle, Windows.TRANSPARENT);
    SetTextColor(PaintCanvas.Handle, PaintCanvas.Font.Color);
    Flags:= DT_END_ELLIPSIS or DT_WORDBREAK;
    {$ifdef fcDelphi4Up}
    case TextAlignment of
      taLeftJustify : Flags:= Flags or DT_LEFT;
      taCenter : Flags:= Flags or DT_CENTER;
      taRightJustify : Flags := Flags or DT_RIGHT;
    end;
    //7/27/99 - PYW - Added GlyphOffset and Alignment support
    if (GlyphOffset > 0) and
       ((OutlookList.ItemLayout=blGlyphLeft) or (OutlookList.ItemLayout=blGlyphRight)) then begin
       TextRect.Left := FItemRect.Left+3;
       TextRect.Right := FItemRect.Right-4;

       if (OutlookList.ItemLayout=blGlyphLeft) then begin
           if (OutlookList.Images <> nil) then
              TextRect.Left:= IconRect.Right+Separation;
       end
       else begin
          if (OutlookList.Images <> nil) then
             TextRect.Right := IconRect.Left-Separation;
       end;

       if OutlookList.IsEffectiveItemHilite and IsDown then begin
          inc(TextRect.Left);
          inc(TextRect.Right);
       end;
    end;
    {$else}
    Flags:= Flags or DT_CENTER;
    {$endif}

    //7/27/99-PYW- Moved this portion here in the Horizontal layout case, because
    //             TextRect Width has changed and the ButtonRect needs to be updated
    //             for the control.
    {$ifdef fcDelphi4Up}
    if OutlookList.Layout = loHorizontal then begin
      if not OutlookList.IsEffectiveItemHilite then
        UnionRect(FButtonRect, IconRect, TextRect);
    end;
    {$endif}

    DrawText(PaintCanvas.Handle, PChar(self.Text), Length(self.Text), TextRect, Flags);
  end;

end;


function TfcOutlookListItem.IsDown: Boolean;
begin
  result := (MouseOnItem and MouseDownOnItem) or Selected;
end;

procedure TfcOutlookListItem.PaintButton(IconRect: TRect);
var Down: Boolean;
    Offset: TPoint;
    PaintRect: TRect;
  function ImageListSize: TSize;
  begin
    result := fcSize(0, 0);
    if OutlookList.Images <> nil then with TImageList(OutlookList.Images) do
      result := fcSize(Width, Height);
  end;
var OldBrush, OldPen: TColor;
begin
  with Outlooklist do
  begin
    Down := IsDown;

    OldBrush := PaintCanvas.Brush.Color;
    OldPen := PaintCanvas.Pen.Color;

    if not OutlookList.IsEffectiveItemHilite then
       PaintRect:= IconRect
    else
       PaintRect:= ButtonRect;

    { 6/18/99 }
    {$ifdef fcDelphi4Up}
    if self.Selected and (FItemSelectedDitherColor<>clNone) then
       fcDither(PaintCanvas, PaintRect, PaintCanvas.Brush.Color, FItemSelectedDitherColor)
    {$else}
    if self.Selected then fcDither(PaintCanvas, PaintRect, PaintCanvas.Brush.Color, clBtnHighlight)
    {$endif}
    else if (ItemHotTrackColor <> Color) and (ItemHotTrackColor <> clNone) and MouseOnItem then
    begin
      PaintCanvas.Brush.Color := ItemHotTrackColor;
      PaintCanvas.FillRect(PaintRect);
    end;

    PaintCanvas.Pen.Color := Color;
    if self.Selected or (MouseOnItem and Down) then
       PaintCanvas.Pen.Color := FItemShadowColor
    else if MouseOnItem then
       PaintCanvas.Pen.Color := FItemHighlightColor else PaintCanvas.Pen.Color := clNone;

    if PaintCanvas.Pen.Color <> clNone then
       with PaintRect do PaintCanvas.PolyLine([Point(Left, Bottom - 1), Point(Left, Top), Point(Right - 1, Top)]);

    if self.Selected or (MouseOnItem and Down) then
       PaintCanvas.Pen.Color := FItemHighlightColor
    else if MouseOnItem then
       PaintCanvas.Pen.Color := FItemShadowColor else PaintCanvas.Pen.Color := clNone;

    if PaintCanvas.Pen.Color <> clNone then with PaintRect do
       PaintCanvas.PolyLine([Point(Left, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Top)]);

    with ImageListSize do
      Offset := Point(IconRect.Left + (fcRectWidth(IconRect) div 2 - cx div 2), IconRect.Top + (fcRectHeight(IconRect) div 2 - cy div 2));
    if IsEffectiveItemHilite and Down then Offset := Point(Offset.x + 1, Offset.y + 1);
    if Images <> nil then fcImageListDraw(Images, ImageIndex, PaintCanvas, Offset.x, Offset.y, ILD_NORMAL, True);
    if self = TopItem then PaintScrollButton(sbUp);
    if self = BottomItem then PaintScrollButton(sbDown);

    PaintCanvas.Brush.Color := OldBrush;
    PaintCanvas.Pen.Color := OldPen;
  end;
end;

procedure TfcOutlookListItem.Invalidate(Erase: Boolean);
var r: TRect;
begin
  r := DisplayRect(drBounds, -1);
  r.Top:= r.Top -1;
  InvalidateRect(OutlookList.Handle, @r, Erase);
end;

constructor TfcOutlookListItems.Create(AOutlookList: TfcCustomOutlookList; ACollectionItemClass: TfcOutlookListItemClass);
begin
  inherited Create(ACollectionItemClass);
  FOutlookList := AOutlookList;
end;

function TfcOutlookListItems.GetOwner: TPersistent;
begin
  result := OutlookList;
end;

function TfcOutlookListItems.GetItems(Index: Integer): TfcOutlookListItem;
begin
  result := inherited Items[Index] as TfcOutlookListItem;
end;

procedure TfcOutlookListItems.Update(Item: TCollectionItem);
begin
  OutlookList.Invalidate;
end;

function TfcOutlookListItems.Add: TfcOutlookListItem;
begin
  result := inherited Add as TfcOutlookListItem;
end;

function TfcOutlookListItems.AddItem: TfcCollectionItem;
begin
  result := Add;
end;

constructor TfcCustomOutlookList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReflector, csAcceptsControls] - [csCaptureMouse];
  Color := clBtnShadow;
  FBorderStyle := bsSingle;
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := ImageListChange;
  FItems := TfcOutlookListItems.Create(self, TfcOutlookListItem);
  FItemLayout := blGlyphTop;
  FItemHotTrackColor := Color;
  FItemSpacing := 20;
  FItemHighlightColor := clBtnFace;
  FItemShadowColor := clBtnText;
  FPaintBitmap := TBitmap.Create;
  FPaintBitmap.Width := Width;
  FPaintBitmap.Height := Height;
  FScrollButtonsVisible := True;
  FScrollInterval := 250;

  {$ifdef fcDelphi4Up}
  FItemSelectedDitherColor:= clBtnHighlight;
  {$endif}

  Font.Color := clWhite;
  Transparent := False;
end;

destructor TfcCustomOutlookList.Destroy;
begin
  FPaintBitmap.Free;
  FChangeLink.Free;
  FItems.Free;
  inherited;
end;

procedure TfcCustomOutlookList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if BorderStyle = bsSingle then with Params do
  begin
    Style := Style and not WS_BORDER;
    ExStyle := ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

procedure TfcCustomOutlookList.Loaded;
begin
  inherited;
  ClickStyle := ClickStyle;
  UpdateScrollButtonsRect;
end;

procedure TfcCustomOutlookList.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i: Integer;
    pt: TPoint;
begin
  inherited;
  if Button <> mbLeft then Exit;

  pt := Point(x, y);

  if PtInRect(FUpButtonRect, pt) then FScrollButtonDown := sbUp
  else if PtInRect(FDownButtonRect, pt) then FScrollButtonDown := sbDown
  else FScrollButtonDown := sbNone;
  if (FScrollButtonDown <> sbNone) and ScrollButtonVisible(FScrollButtonDown) then
  begin
    FOldCapture := GetCapture;
    SetCapture(Handle);
    InvalidateScrollButton(FScrollButtonDown);
    SetTimer(Handle, ScrollTimerID, ScrollInterval, nil);
  end else
    if (TopItem <> nil) then for i := TopItem.Index to BottomItem.Index do
      if PtInRect(Items[i].ButtonRect, pt) then
      begin
        Items[i].MouseDownOnItem := True;
        Break;
      end;
end;

Function TfcCustomOutlookList.GetImager: TfcCustomImager;
begin
   result:=nil;
   if OutlookPage=nil then exit;
   if TfcOutlookPage(OutlookPage).OutlookBar=nil then exit;
   result:= TfcOutlookPage(OutlookPage).OutlookBar.Imager;
end;

procedure TfcCustomOutlookList.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var OldScrollButtonDown: TfcScrollButtonStyle;
    i: Integer;
    pt: TPoint;
begin
  inherited;
  if Button <> mbLeft then Exit;

  pt := Point(x, y);

  if TopItem <> nil then for i := TopItem.Index to BottomItem.Index do
  begin
    if Items[i].MouseDownOnItem and PtInRect(Items[i].ButtonRect, pt) then ItemClick(Items[i]);
    Items[i].MouseDownOnItem := False;
  end;

  OldScrollButtonDown := FScrollButtonDown;
  if ScrollButtonVisible(FScrollButtonDown) then case FScrollButtonDown of
    sbUp: if PtInRect(FUpButtonRect, pt) then ScrollButtonClick;
    sbDown: if PtInRect(FDownButtonRect, pt) then ScrollButtonClick;
  end;
  if (FScrollButtonDown <> sbNone) then
  begin
    KillTimer(Handle, ScrollTimerID);
    ReleaseCapture;
    SetCapture(FOldCapture);
    FScrollButtonDown := sbNone;
    InvalidateScrollButton(OldScrollButtonDown);
  end;
end;

procedure TfcCustomOutlookList.MouseMove(Shift: TShiftState; X, Y: Integer);
var pt: TPoint;
    i: Integer;
    DoReleaseCapture: Boolean;
begin

  inherited;

  pt := Point(x, y);

  DoReleaseCapture := True;
  if TopItem <> nil then for i := TopItem.Index to BottomItem.Index do
  begin
    if PtInRect(Items[i].ButtonRect, pt) and (pt.x < Width) and (pt.y < Height) then Items[i].MouseOnItem := True
    else Items[i].MouseOnItem := False;
    if Items[i].MouseOnItem then DoReleaseCapture := False;
  end;
  if DoReleaseCapture and (GetCapture = Handle) then
    ReleaseCapture;

  if PtInRect(FUpButtonRect, pt) then MouseInScrollButton := sbUp
  else if PtInRect(FDownButtonRect, pt) then MouseInScrollButton := sbDown
  else MouseInScrollButton := sbNone;
end;

procedure TfcCustomOutlookList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FImageList) then
  begin
    FImageList := nil; // So UnRegisterChanges in .SetImageList will not be called
    Images := nil;  // So Invalidate will be called
  end;
end;

procedure TfcCustomOutlookList.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  inherited;
  if PtInRect(FUpButtonRect, SmallPointToPoint(Message.Pos)) or
     PtInRect(FDownButtonRect, SmallPointToPoint(Message.Pos)) then
    Message.Result := 1;
end;

procedure TfcCustomOutlookList.WMEraseBkgnd(var Message: TWMEraseBkGnd);
begin
//  inherited;
  Message.result := 1;  { 3/19/99 - RSW Prevents flicker when animating.  If
                          this is a problem, may want to add flag so that this
                          code will only execute during animation, and call inherited otherwise}
end;

procedure TfcCustomOutlookList.WMSize(var Message: TWMSize);
begin
  inherited;
  FPaintBitmap.Free;
  FPaintBitmap := TBitmap.Create;
  FPaintBitmap.Width := ClientWidth;
  FPaintBitmap.Height := ClientHeight;
  UpdateScrollButtonsRect;
end;

procedure TfcCustomOutlookList.WMTimer(var Message: TWMTimer);
begin
  inherited;
  if (Message.TimerID = ScrollTimerId) then
    with ScreenToClient(fcGetCursorPos) do
        if ScrollButtonVisible(FScrollButtonDown) then 
      case FScrollButtonDown of
        sbUp: if PtInRect(FUpButtonRect, Point(x, y)) then ScrollButtonClick;
        sbDown: if PtInRect(FDownButtonRect, Point(x, y)) then ScrollButtonClick;
      end;
end;

procedure TfcCustomOutlookList.DoDrawItem(Item: TfcOutlookListItem; var GlyphPos, TextPos: TPoint; var DefaultDrawing: Boolean);
begin
  if Assigned(FOnDrawItem) then FOnDrawItem(self, Item, GlyphPos, TextPos, DefaultDrawing);
end;

procedure TfcCustomOutlookList.ImageListChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TfcCustomOutlookList.InvalidateScrollButton(Button: TfcScrollButtonStyle);
begin
  case Button of
    sbUp: InvalidateRect(Handle, @FUpButtonRect, False);
    sbDown: InvalidateRect(Handle, @FDownButtonRect, False);
  end;
end;

function TfcCustomOutlookList.GetBottomItem: TfcOutlookListItem;
var i: Integer;
    Total: Integer;
begin
  result := nil;
  if TopItem = nil then Exit;
  result := TopItem;
  Total := 0;
  for i := TopItem.Index to Items.Count - 1 do
  begin
    result := Items[i];
    inc(Total, Items[i].SpacingSize);
    if ((Layout = loVertical) and (Total > ClientHeight)) or
       ((Layout = loHorizontal) and (Total > ClientWidth)) then Break;
  end;
end;

function TfcCustomOutlookList.GetPaintCanvas: TCanvas;
begin
  result := FPaintBitmap.Canvas;
end;

function TfcCustomOutlookList.GetSelected: TfcOutlookListItem;
var i: Integer;
begin
  result := nil;
  for i := 0 to Items.Count - 1 do
  begin
    if Items[i].Selected then
    begin
      result := Items[i];
      Break;
    end;
  end;
end;

function TfcCustomOutlookList.GetListItems(Index: Integer): TfcOutlookListItem;
begin
  result := Items[Index] as TfcOutlookListItem;
end;

function TfcCustomOutlookList.GetTopItem: TfcOutlookListItem;
begin
  if (FTopItem = nil) and (Items.Count > 0) then FTopItem := Items[0];
  result := FTopItem;
end;

procedure TfcCustomOutlookList.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TfcCustomOutlookList.SetClickStyle(Value: TfcCustomOutlookListClickStyle);
begin
  FClickStyle := Value;
end;

procedure TfcCustomOutlookList.SetImageList(Value: TCustomImageList);
begin
  if (FImageList <> nil) then FImageList.UnregisterChanges(FChangeLink);
  FImageList := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(self);
    Value.RegisterChanges(FChangeLink);
  end;
  Invalidate;
end;

procedure TfcCustomOutlookList.SetItemLayout(Value: TButtonLayout);
begin
  if FItemLayout <> Value then
  begin
    FItemLayout := Value;
    Invalidate;
  end;
end;

procedure TfcCustomOutlookList.SetItemHighlightColor(Value: TColor);
begin
  if FItemHighlightColor <> Value then
  begin
    FItemHighlightColor := Value;
    Invalidate;
  end;
end;

procedure TfcCustomOutlookList.SetItemShadowColor(Value: TColor);
begin
  if FItemShadowColor <> Value then
  begin
    FItemShadowColor := Value;
    Invalidate;
  end;
end;

procedure TfcCustomOutlookList.SetItems(Value: TfcOutlookListItems);
begin
  FItems.Assign(Value);
end;

procedure TfcCustomOutlookList.SetItemSpacing(Value: Integer);
begin
  if FItemSpacing <> Value then
  begin
    FItemSpacing := Value;
    if Odd(FItemSpacing) then inc(FItemSpacing);
    Invalidate;
  end;
end;

procedure TfcCustomOutlookList.SetItemsWidth(Value: Integer);
begin
  if FItemsWidth <> Value then
  begin
    FItemsWidth := Value;
    Invalidate;
  end;
end;

procedure TfcCustomOutlookList.SetLayout(Value: TfcLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TfcCustomOutlookList.SetMouseInScrollButton(Value: TfcScrollButtonStyle);
begin
  if (FMouseInScrollButton <> Value) and ScrollButtonVisible(Value) then
  begin
    InvalidateScrollButton(FMouseInScrollButton);
    FMouseInScrollButton := Value;
    InvalidateScrollButton(Value);
  end;
end;

procedure TfcCustomOutlookList.SetScrollButtonsVisible(Value: Boolean);
begin
  if FScrollButtonsVisible <> Value then
  begin
    FScrollButtonsVisible := Value;
    Invalidate;
  end;
end;

procedure TfcCustomOutlookList.SetTopItem(Value: TfcOutlookListItem);
begin
  if FTopItem <> Value then
  begin
    FTopItem := Value;
    Invalidate;
  end;
end;

function TfcCustomOutlookList.ScrollButtonVisible(Button: TfcScrollButtonStyle): Boolean;
var ABottomItem: TfcOutlookListItem;
begin
  result := False;
  case Button of
    sbUp: result := not ((TopItem = nil) or (TopItem = Items[0]));
    sbDown: begin
      ABottomItem := BottomItem;
      if (ABottomItem <> TopItem) and (not ABottomItem.IsVisible(True)) then
        ABottomItem := Items[ABottomItem.Index - 1];
      with ABottomItem do result := (TopItem <> nil) and ((Index < Items.Count - 1));
    end;
  end;
end;

function TfcCustomOutlookList.GetItemAt(x, y: Integer): TfcOutlookListItem;
var i: Integer;
begin
  result := nil;
  for i := 0 to Items.Count - 1 do
    if PtInRect(Items[i].ItemRect, Point(x, y)) then
    begin
      result := Items[i];
      Break;
    end;
end;

procedure TfcCustomOutlookList.PaintScrollButton(Button: TfcScrollButtonStyle);
const ButtonStates: array[Boolean] of Integer = (0, DFCS_PUSHED);
var bm: TBitmap;
    resName: string;
    Down: Boolean;
    Offset: TPoint;
    r: TRect;
begin
  if not ScrollButtonVisible(Button) or not ScrollButtonsVisible then Exit;

  if Button = sbUp then r := FUpButtonRect else r := FDownButtonRect;

  Down := (MouseInScrollButton = Button) and (FScrollButtonDown = Button);
  DrawFrameControl(PaintCanvas.Handle, r, DFC_BUTTON, DFCS_BUTTONPUSH or ButtonStates[Down]);
  case Button of
    sbUp: if Layout = loVertical then resName := 'FCDROPUP' else resName := 'FCDROPLEFT';
    sbDown: if Layout = loVertical then resName := 'FCDROPDOWN' else resName := 'FCDROPRIGHT';
  end;
  bm := TBitmap.Create;
  bm.Transparent := True;
  bm.LoadFromResourceName(HINSTANCE, resName);
  if Layout = loVertical then Offset := Point(r.Left + 2, r.Top + 5)
  else Offset := Point(r.Left + 5, r.Top + 3);
  if Down then with Offset do Offset := Point(x + 1, y + 1);
  PaintCanvas.Draw(Offset.x, Offset.y, bm);
  bm.Free;
end;

procedure TfcCustomOutlookList.ItemClick(Item: TfcOutlookListItem);
begin
  if (ClickStyle = csSelect) and not Item.Selected then
  begin
    Item.Selected := True;
    if Assigned(FOnItemChange) then FOnItemChange(self, Item);
  end;
  if Assigned(FOnItemClick) then FOnItemClick(self, Item);

  { 4/14/99 - RSW - Added following 2 lines }
  if Assigned(Item.FOnClick) then Item.FOnClick(self, Item);
  UpdateMouseOnItem;

end;

procedure TfcCustomOutlookList.ScrollButtonClick;
begin
  case FScrollButtonDown of
    sbUp: if (TopItem <> nil) and (TopItem.Index > 0) then TopItem := Items[TopItem.Index - 1];
    sbDown: if (TopItem <> nil) and (TopItem.Index < Items.Count - 1) then TopItem := Items[TopItem.Index + 1];
  end;
  UpdateButtonRects;  // Moved, Insures that the hotrack rect is on the correct item; previously prevented OnDrawText from working properly -ksw (4/30/99)
  UpdateMouseOnItem;
end;

procedure TfcCustomOutlookList.UpdateMouseOnItem;
var i: Integer;
    pt: TPoint;
begin
  pt := ScreenToClient(fcGetCursorPos);
  if TopItem <> nil then for i := TopItem.Index to BottomItem.Index do
    Items[i].MouseOnItem := PtInRect(Items[i].ButtonRect, pt);
end;

procedure TfcCustomOutlookList.UpdateScrollButtonsRect;
begin
  if Layout = loVertical then
  begin
    FUpButtonRect := Rect(Width - 25, 10, Width - 10, 25);
    FDownButtonRect := Rect(Width - 25, Height - 25, Width - 10, Height - 10);
  end else begin
    FUpButtonRect := Rect(10, 10, 25, 25);
    FDownButtonRect := Rect(Width - 25, 10, Width - 10, 25);
  end;
end;

procedure TfcCustomOutlookList.Paint;
var i: Integer;
begin
  inherited;

  if not Transparent then { 5/2/99 - Transparent fills in with parent outlookbar color }
  begin
    PaintCanvas.Brush.Color := Color;
    PaintCanvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
  end else begin
     if GetImager<>nil then
     begin
        if GetImager.DrawStyle=dsTile then
           GetImager.WorkBitmap.TileDraw(PaintCanvas, Parent.BoundsRect)
        else
           PaintCanvas.StretchDraw(Parent.ClientRect, GetImager.WorkBitmap);
     end
     else begin
        PaintCanvas.Brush.Color := TfcOutlookPage(OutlookPage).OutlookBar.Color;
        PaintCanvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
     end
  end;

  PaintCanvas.Font.Assign(Font);

  if TopItem <> nil then
  begin
    for i := TopItem.Index to BottomItem.Index do
      Items[i].Paint;
    PaintScrollButton(sbUp);
    PaintScrollButton(sbDown);
  end;
  Canvas.CopyRect(Rect(0, 0, ClientWidth, ClientHeight), PaintCanvas, Rect(0, 0, ClientWidth, ClientHeight));
end;

procedure TfcCustomOutlookList.UpdateButtonRects;
var i: Integer;
begin
  for i := TopItem.Index to BottomItem.Index do
    if not IsEffectiveItemHilite then Items[i].FButtonRect := Items[i].DisplayRect(drIcon, -1)
    else Items[i].FButtonRect := Items[i].DisplayRect(drBounds, -1);
end;

procedure TfcCustomOutlookList.ValidateInsert(AComponent: TComponent);
begin
  raise EInvalidOperation.Create('TfcCustomOutlookList does not accept child controls.  Delete ' +
    'TfcCustomOutlookList and/or set the options property of the TfcControlBar, "cboAutoCreateOutlookList", to False');
end;

function TfcCustomOutlookList.IsEffectiveItemHilite: boolean;
begin
   result:= (HotTrackStyle=hsItemHilite) or (Images=nil)
end;

initialization
  RegisterClasses([TfcOutlookList]);
end.
