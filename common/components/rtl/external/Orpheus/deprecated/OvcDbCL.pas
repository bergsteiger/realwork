{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCDBCL.PAS 2.17                    *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbCL;
  {-Data-aware column list}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Buttons, Classes, Controls, Db, DbCtrls, DbTables, Forms, Graphics,
  StdCtrls, Menus, Messages, SysUtils,
  OvcBase, OvcCmd, OvcConst, OvcData, OvcMisc, OvcColor;

const
  {default property values}
  DefActiveRow       = 0;
  DefAutoRowHeight   = True;
  DefBorderStyle     = bsSingle;
  DefColor           = clWindow;
  DefHeaderBack      = clBtnFace;
  DefHeaderText      = clBtnText;
  DefHeight          = 150;
  DefHideSelection   = True;
  DefHighlightBack   = clHighlight;
  DefHighlightText   = clHighlightText;
  DefIntegralHeight  = True;
  DefIndicatorWidth  = 11;
  DefLineColor       = clSilver;
  DefPageScroll      = False;
  DefParentColor     = False;
  {$IFDEF Win32}
  DefRowHeight       = 17;
  {$ELSE}
  DefRowHeight       = 20;
  {$ENDIF}
  DefScrollBars      = ssVertical;
  DefShowHeader      = False;
  DefShowIndicator   = True;
  DefTabStop         = True;
  DefTextMargin      = 1;
  DefWidth           = 100;

type
  THeaderClickEvent =
    procedure(Sender : TObject; Point : TPoint)
    of object;
    {-event to notify of a mouse click in the header area}
  TIndicatorClickEvent =
    procedure(Sender : TObject; Row : Integer)
    of object;
    {event to notify of a scroll action}

type
  TOvcDbColumnList = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FActiveRow         : Integer;     {selected item}
    FAutoRowHeight     : Boolean;     {true to handle row height calc}
    FBorderStyle       : TBorderStyle;{border style to use}
    FDataLink          : TFieldDataLink;
    FHeader            : string;      {the column header}
    FHeaderColor       : TOvcColors;  {header line colors}
    FHideSelection     : Boolean;     {true to hide selection}
    FHighlightColors   : TOvcColors;  {highlight colors}
    FIntegralHeight    : Boolean;     {adjust height based on font}
    FIndicatorWidth    : Integer;     {width of row indicators}
    FLineColor         : TColor;      {color of row divider lines}
    FPageScroll        : Boolean;     {true to scroll like Delphi's grids}
    FRowHeight         : Integer;     {height of one row}
    FScrollBars        : TScrollStyle;{scroll bar style to use}
    FShowHeader        : Boolean;     {true to use the header}
    FShowIndicator     : Boolean;     {true to show row indicators}
    FTextMargin        : Integer;     {indent from left (right)}

    {event variables}
    FOnClickHeader     : THeaderClickEvent;
    FOnIndicatorClick  : TIndicatorClickEvent;
    FOnUserCommand     : TUserCommandEvent;

    {internal/working variables}
    clHDelta           : Integer;     {horizontal scroll delta}
    clIndicators       : TImageList;  {list of indicators}
    clNumRows          : Integer;     {visible rows in window}
    clPainting         : Boolean;     {True when painting}

    {property methods}
    function GetField : TField;
      {-return the associated field object}
    function GetDataField : string;
      {-return the field name}
    function GetDataSource : TDataSource;
      {-return the datasource}
    procedure SetActiveRow(Value : Integer);
      {-set the active row index}
    procedure SetAutoRowHeight(Value : Boolean);
      {-set use of auto row height calculations}
    procedure SetBorderStyle(const Value : TBorderStyle);
      {-set the style used for the border}
    procedure SetDataField(const Value : string);
      {-set the field name}
    procedure SetDataSource(Value : TDataSource);
      {-set the data source}
    procedure SetHeader(const Value : string);
      {-set the header at top of list box}
    procedure SetIntegralHeight(Value : Boolean);
      {-set use of integral font height adjustment}
    procedure SetIndicatorWidth(Value : Integer);
      {-set the row indicator width}
    procedure SetLineColor(Value : TColor);
      {-set the color used to draw the row divider lines}
    procedure SetRowHeight(Value : Integer);
      {-set height of cell row}
    procedure SetScrollBars(const Value : TScrollStyle);
      {-set use of vertical and horizontal scroll bars}
    procedure SetShowHeader(Value : Boolean);
      {-set the header at top of list box}
    procedure SetShowIndicator(Value : Boolean);
      {-set the show indicator option}
    procedure SetTextMargin(Value : Integer);
      {-set the text margin}

    {internal methods}
    procedure clAdjustIntegralHeight;
      {-adjust height of the list}
    procedure clAdjustRowHeight;
      {-adjust the row height based on the current font}
    procedure clCalcNumRows;
      {-calculate sizes based on font selection}
    procedure clColorChanged(AColor: TObject);
      {-a color has changed, refresh display}
    procedure clDrawHeader;
      {-draw the header and text area}
    procedure clSetHScrollPos;
      {-set the horizontal scroll position}
    procedure clSetHScrollRange;
      {-set the horizontal scroll range}
    procedure clSetVScrollPos;
      {-set the vertical scroll position}
    procedure clSetVScrollRange;
      {-set the vertical scroll range}
    procedure clInitScrollBarInfo;
      {-setup scroll bar range and initial position}
    procedure clUpdateActive;
      {-update the active record number}
    procedure clUpdateNumRows;
      {-update the number of rows}

    {datalink event handlers}
    procedure clActiveChange(Sender : TObject);
    procedure clDataChange(Sender : TObject);
    procedure clEditingChange(Sender : TObject);
    procedure clUpdateData(Sender : TObject);

    {VCL control messages}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage);
      message CM_FONTCHANGED;
    {$IFDEF Win32}
    procedure CMGetDataLink(var Msg : TMessage);
      message CM_GETDATALINK;
    {$ENDIF}

    {windows message methods}
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd);
      message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMGetMinMaxInfo(var Msg : TWMGetMinMaxInfo);
      message WM_GETMINMAXINFO;
    procedure WMHScroll(var Msg : TWMScroll);
      message WM_HSCROLL;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;
    procedure WMVScroll(var Msg : TWMScroll);
      message WM_VSCROLL;

  protected
    procedure ChangeScale(M, D : Integer);
      override;
    procedure CreateParams(var Params: TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure Paint;
      override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;

    {event wrappers}
    procedure DoOnClickHeader(Point : TPoint);
      dynamic;
    procedure DoOnIndicatorClick(Row : Integer);
      dynamic;
    procedure DoOnUserCommand(Command : Word);
      dynamic;

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor  Destroy;
      override;
  {.Z-}

    procedure InvalidateItem(Row : Integer);
      {-invalidate the area for this item}

  {.Z+}
    property ActiveRow : Integer
      read FActiveRow
      write SetActiveRow
      stored False;
  {.Z-}

    {public properties}
    property Canvas;

    property Field : TField
      read GetField;

  published
    {properties}
    property AutoRowHeight : Boolean
      read FAutoRowHeight
      write SetAutoRowHeight
      default DefAutoRowHeight;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default DefBorderStyle;

    property DataField : string
      read GetDataField
      write SetDataField;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;

    property Header : string
      read FHeader
      write SetHeader;

    property HeaderColor : TOvcColors
      read FHeaderColor
      write FHeaderColor;

    property HideSelection : Boolean
      read FHideSelection
      write FHideSelection
      default DefHideSelection;

    property HighlightColors : TOvcColors
      read FHighlightColors
      write FHighlightColors;

    property IntegralHeight : Boolean
      read FIntegralHeight
      write SetIntegralHeight
      default DefIntegralHeight;

    property IndicatorWidth : Integer
      read FIndicatorWidth
      write SetIndicatorWidth
      default DefIndicatorWidth;

    property LineColor : TColor
      read FLineColor
      write SetLineColor
      default DefLineColor;

    property PageScroll : Boolean
      read FPageScroll
      write FPageScroll
      default DefPageScroll;

    property RowHeight : Integer
      read FRowHeight
      write SetRowHeight
      default DefRowHeight;

    property ScrollBars : TScrollStyle
       read FScrollBars
       write SetScrollBars
       default DefScrollBars;

    property ShowHeader : Boolean
      read FShowHeader
      write SetShowHeader
      default DefShowHeader;

    property ShowIndicator : Boolean
      read FShowIndicator
      write SetShowIndicator
      default DefShowIndicator;

    property TextMargin : Integer
      read FTextMargin
      write SetTextMargin
      default DefTextMargin;

    {inherited properties}
    property Align;                                                    {!!.13}
    property Color default DefColor;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property Enabled;
    property Font;
    property ParentColor default DefParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default DefTabStop;
    property Visible;

    {events}
    property OnClickHeader : THeaderClickEvent
      read FOnClickHeader
      write FOnClickHeader;

    property OnIndicatorClick : TIndicatorClickEvent
      read FOnIndicatorClick
      write FOnIndicatorClick;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

{*** TOvcVirtualListbox ***}

procedure TOvcDbColumnList.ChangeScale(M, D : Integer);
begin
  inherited ChangeScale(M, D);

  if M <> D then begin
    {scale row height}
    FRowHeight := MulDiv(FRowHeight, M, D);
    RecreateWnd;
  end;
end;

procedure TOvcDbColumnList.clActiveChange(Sender : TObject);
begin
  clSetHScrollRange;
  clSetVScrollRange;
  Refresh;
end;

procedure TOvcDbColumnList.clAdjustIntegralHeight;
begin
  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    if FIntegralHeight then
      if ClientHeight mod FRowHeight <> 0 then
        ClientHeight := (ClientHeight div FRowHeight) * FRowHeight;
end;

procedure TOvcDbColumnList.clAdjustRowHeight;
  {-adjust the row height based on the current font}
var
  DC         : hDC;
  SaveFont   : hFont;
  H          : Integer;
  SysMetrics : TTextMetric;
  Metrics    : TTextMetric;
begin
  if not FAutoRowHeight then
    Exit;

  if csLoading in ComponentState then
    Exit;

  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;

  if NewStyleControls then
    H := GetSystemMetrics(SM_CYBORDER) * 4
  else begin
    H := SysMetrics.tmHeight;
    if H > Metrics.tmHeight then
      H := Metrics.tmHeight;
    H := H div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;

  FRowHeight := Metrics.tmHeight + H;
end;

procedure TOvcDbColumnList.clCalcNumRows;
begin
  if not HandleAllocated then
    Exit;

  clNumRows := (ClientHeight div FRowHeight)-Ord(FShowHeader);
  if clNumRows < 1 then
    clNumRows := 1;
end;

procedure TOvcDbColumnList.clColorChanged(AColor: TObject);
  {-a color has changed, refresh display}
begin
  Refresh;
end;

procedure TOvcDbColumnList.clDataChange(Sender : TObject);
begin
  if clPainting then
    Exit;

  {set the number of managed items}
  clUpdateNumRows;

  {update the active record number}
  clUpdateActive;

  {update the scroll bar position}
  clSetVScrollPos;

  Invalidate;
end;

procedure TOvcDbColumnList.clDrawHeader;
  {-draw the header and text}
var
  R   : TRect;
  Buf : array[0..255] of AnsiChar;
  X,Y : Integer;
begin
  {get the header text}
  if FHeader = '' then begin
    if (Field <> nil) then
      StrPCopy(Buf, Field.DisplayLabel)
    else
      Buf[0] := #0;
  end else
    StrPLCopy(Buf, FHeader, 255);

  Canvas.Font := Font;
  Canvas.Brush.Color := FHeaderColor.BackColor;
  Canvas.Font.Color := FHeaderColor.TextColor;

  {draw header text}
  with Canvas do begin
    {if showing indicators, need to paint top/left bit}
    if ShowIndicator then begin
      R := Bounds(0, 0, IndicatorWidth, FRowHeight);

      {draw the indicator button face}
      DrawButtonFace(Canvas, R, 1, bsNew, False, False, False);

      {restore right edge}
      R := Bounds(IndicatorWidth, 0, Width-IndicatorWidth, FRowHeight-1);
      X :=  TextMargin + IndicatorWidth;
    end else begin
      R := Bounds(0, 0, Width, FRowHeight-1);
      X := TextMargin;
    end;

    {clear the line}
    Canvas.FillRect(R);

    Y := (FRowHeight - Canvas.TextHeight(GetOrphStr(SCTallLowChars))) div 2;
    if StrLen(Buf) > 0 then
      ExtTextOut(Canvas.Handle, X, Y, {ETO_OPAQUE or }ETO_CLIPPED,     {!!.11}
                 @R, Buf, StrLen(Buf), nil);

    {draw border line}
    Pen.Color := clBlack;
    PolyLine([Point(R.Left, R.Bottom), Point(R.Right, R.Bottom)]);

    {draw ctl3d highlight}
    if Ctl3D then begin
      Pen.Color := clBtnHighlight;
      PolyLine([Point(R.Left, R.Bottom-1),
                Point(R.Left, R.Top),
                Point(R.Right, R.Top)]);
    end;
  end;
end;

procedure TOvcDbColumnList.clEditingChange(Sender : TObject);
begin
  clSetHScrollRange;
  clSetVScrollRange;
end;

procedure TOvcDbColumnList.clInitScrollBarInfo;
  {-setup scroll bar range and initial position}
begin
  if not HandleAllocated then
    Exit;

  {initialize scroll bars, if any}
  clSetVScrollRange;
  clSetVScrollPos;
  clSetHScrollRange;
  clSetHScrollPos;
end;

procedure TOvcDbColumnList.clSetHScrollPos;
begin
  if FScrollBars in [ssHorizontal, ssBoth] then
    SetScrollPos(Handle, SB_HORZ, clHDelta, True);
end;

procedure TOvcDbColumnList.clSetHScrollRange;
begin
  if FScrollBars in [ssHorizontal, ssBoth] then begin
    if Field <> nil then
      SetScrollRange(Handle, SB_HORZ, 0, Field.DisplayWidth, False)
    else
      SetScrollRange(Handle, SB_HORZ, 0, 1, False);
  end;
end;

procedure TOvcDbColumnList.clSetVScrollPos;
var
  V : Integer;
begin
  if not (FScrollBars in [ssVertical, ssBoth]) then
    Exit;

  if (FDataLink = nil) or not FDataLink.Active then
    Exit;

  if csLoading in ComponentState then
    Exit;

  with FDataLink.DataSet do begin
    if BOF then
      V := 0
    else if EOF then
      V := 4
    else
      V := 2;

    if GetScrollPos(Self.Handle, SB_VERT) <> V then
      SetScrollPos(Self.Handle, SB_VERT, V, True);
  end;
end;

procedure TOvcDbColumnList.clSetVScrollRange;
begin
  if csLoading in ComponentState then
    Exit;

  if FScrollBars in [ssVertical, ssBoth] then
    SetScrollRange(Self.Handle, SB_VERT, 0, 4, False);
end;

procedure TOvcDbColumnList.clUpdateActive;
begin
  if csLoading in ComponentState then
    Exit;

  if (FDataLink <> nil) and FDataLink.Active then
    FActiveRow := FDataLink.ActiveRecord;
end;

procedure TOvcDbColumnList.clUpdateData(Sender : TObject);
begin
  {}
end;

procedure TOvcDbColumnList.clUpdateNumRows;
  {-update the number of rows}
begin
  if not HandleAllocated then
    Exit;

  clNumRows := ClientHeight div FRowHeight - Ord(FShowHeader);
  if clNumRows < 1 then
    clNumRows := 1;

  if FDataLink <> nil then
    if FDataLink.Active and (FDataLink.RecordCount > 0) then
      FDataLink.BufferCount := clNumRows;
end;

procedure TOvcDbColumnList.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

procedure TOvcDbColumnList.CMFontChanged(var Message: TMessage);
begin
  inherited;

  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {optionally, adjust the row height}
  clAdjustRowHeight;

  if FIntegralHeight then begin
    {determine the number of rows}
    clCalcNumRows;
    {optionally, adjust list height}
    clAdjustIntegralHeight;
  end;

  {determine the number of rows}
  clCalcNumRows;

  {set the scroll bar range}
  clInitScrollBarInfo;
end;

{$IFDEF Win32}
procedure TOvcDbColumnList.CMGetDataLink(var Msg : TMessage);
begin
  Msg.Result := LongInt(FDataLink);
end;
{$ENDIF}

constructor TOvcDbColumnList.Create(AOwner : TComponent);
var
  Bmp : Graphics.TBitmap;
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := ControlStyle + [csClickEvents]
  else
    ControlStyle := ControlStyle + [csClickEvents, csFramed];
  {$ELSE}
    ControlStyle := ControlStyle + [csClickEvents, csFramed];
  {$ENDIF}

  {set default values for inherited persistent properties}
  Color        := DefColor;
  Height       := DefHeight;
  ParentColor  := DefParentColor;
  TabStop      := DefTabStop;
  Width        := DefWidth;

  {create indicators object and load bitmaps}
  Bmp := Graphics.TBitmap.Create;
  try
    Bmp.Handle := LoadOvcBaseBitmap(MakeIntResource(bmArrow));
    {$IFDEF Win32}
    clIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    {$ELSE}
    clIndicators := TImageList.Create(Bmp.Width, Bmp.Height);
    {$ENDIF}
    clIndicators.AddMasked(Bmp, clWhite);
    Bmp.Handle := LoadOvcBaseBitmap(MakeIntResource(bmEdit));
    clIndicators.AddMasked(Bmp, clWhite);
    Bmp.Handle := LoadOvcBaseBitmap(MakeIntResource(bmInsert));
    clIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;

  {set default values for new persistent properties}
  FActiveRow      := DefActiveRow;
  FAutoRowHeight  := DefAutoRowHeight;
  FBorderStyle    := DefBorderStyle;
  FHeader         := '';
  FHideSelection  := DefHideSelection;
  FIndicatorWidth := DefIndicatorWidth;
  FIntegralHeight := DefIntegralHeight;
  FLineColor      := DefLineColor;
  FPageScroll     := DefPageScroll;
  FRowHeight      := DefRowHeight;
  FScrollBars     := DefScrollBars;
  FShowHeader     := DefShowHeader;
  FShowIndicator  := DefShowIndicator;
  FTextMargin     := DefTextMargin;

  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;

  FDataLink.OnActiveChange  := clActiveChange;
  FDataLink.OnDataChange    := clDataChange;
  FDataLink.OnEditingChange := clEditingChange;
  FDataLink.OnUpdateData    := clUpdateData;

  {set defaults for internal variables}
  clHDelta := 0;

  {create and initialize color objects}
  FHeaderColor  := TOvcColors.Create(DefHeaderText, DefHeaderBack);
  FHeaderColor.OnColorChange := clColorChanged;
  FHighlightColors := TOvcColors.Create(DefHighlightText, DefHighlightBack);
  FHighlightColors.OnColorChange := clColorChanged;
end;

procedure TOvcDbColumnList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
    Style := LongInt(Style) or ScrollBarStyles[FScrollBars]            {!!.D4}
                   or BorderStyles[FBorderStyle];

  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}
end;

procedure TOvcDbColumnList.CreateWnd;
begin
  inherited CreateWnd;

  {optionally, adjust the row height}
  clAdjustRowHeight;

  if FIntegralHeight then begin
    {determine the number of rows}
    clCalcNumRows;
    {optionally, adjust list height}
    clAdjustIntegralHeight;
  end;

  {determine the number of rows}
  clCalcNumRows;

  {set the number of managed items}
  clUpdateNumRows;

  {set the scroll bars}
  clInitScrollBarInfo;
end;

destructor  TOvcDbColumnList.Destroy;
begin
  {dispose of the color objects}
  FHeaderColor.Free;
  FHeaderColor := nil;
  FHighlightColors.Free;
  FHighlightColors := nil;

  FDataLink.Free;
  FDataLink := nil;

  clIndicators.Free;                                                   {!!.11}
  clIndicators := nil;                                                 {!!.11}

  inherited Destroy;
end;

procedure TOvcDbColumnList.DoOnClickHeader(Point : TPoint);
begin
  if Assigned(FOnClickHeader) then
    FOnClickHeader(Self, Point);
end;

procedure TOvcDbColumnList.DoOnIndicatorClick(Row : Integer);
  {-perform indicator click notification}
begin
  if not (csDesigning in ComponentState) and Assigned(FOnIndicatorClick) then
    FOnIndicatorClick(Self, Row);
end;

procedure TOvcDbColumnList.DoOnUserCommand(Command : Word);
  {-perform notification of a user command}
begin
  if Assigned(FOnUserCommand) then
    FOnUserCommand(Self, Command);
end;

function TOvcDbColumnList.GetField : TField;
begin
  Result := FDataLink.Field;

  {Result will be nil if the datasource is not active. At design-time}
  {the field information can be obtained if a corresponding field    }
  {component has been added to the form (by using the Fields Editor).}
  if (Result = nil) and (csDesigning in ComponentState) then
    if (DataSource <> nil) and (DataSource.DataSet <> nil) then
      if not DataSource.DataSet.DefaultFields then
        Result := DataSource.DataSet.FindField(FDataLink.FieldName);
end;

function TOvcDbColumnList.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TOvcDbColumnList.GetDataSource : TDataSource;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

procedure TOvcDbColumnList.InvalidateItem(Row : Integer);
  {-invalidate the area for this item}
var
  CR : TRect;
begin
  if (Row >= 0) and (Row < clNumRows) then begin
    CR := Rect(0, (Row+Ord(FShowHeader))*FRowHeight, ClientWidth, 0);
    CR.Bottom := CR.Top+FRowHeight;
    InvalidateRect(Handle, @CR, True);
  end;
end;

procedure TOvcDbColumnList.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TOvcDbColumnList.Paint;
var
  CR          : TRect;
  IR, Clip    : TRect;
  I           : Integer;
  X, Y        : Integer;
  SaveActive  : Integer;
  Left        : Integer;
  Indicator   : Integer;
  P           : PAnsiChar;
  Buf         : array[0..255] of Char;
begin
  {get the client area}
  CR := ClientRect;

  {get the cliping region}
  if csDesigning in ComponentState then
    Clip := CR
  else
    GetClipBox(Canvas.Handle, Clip);

  {do we have a header?}
  if FShowHeader then
    if Bool(IntersectRect(IR, Clip, Rect(CR.Left, CR.Top, CR.Right, FRowHeight))) then
      clDrawHeader;

  {set up the proper font and colors}
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  if not Enabled and (Color <> clGrayText) then
    Canvas.Font.Color := clGrayText;

  {starting offset for text}
  X := FTextMargin;

  {remember the active row}
  SaveActive := FActiveRow;

  clPainting := True;
  try
    for I := 0 to Pred(clNumRows) do begin
      CR.Top := (I+Ord(FShowHeader))*FRowHeight;
      CR.Bottom := CR.Top+FRowHeight-1;
      if I = Pred(clNumRows) then
        CR.Bottom := ClientHeight;
      Y := CR.Top;

      if Bool(IntersectRect(IR, CR, Clip)) then begin

        {display row indicator if enabled}
        if FShowIndicator then begin
          CR.Left := FIndicatorWidth;
          DrawButtonFace(Canvas, Rect(0, CR.Top, FIndicatorWidth, CR.Bottom+1),
                         1, bsNew, False, False, False);
          Canvas.Brush.Color := Color;

          if (FDataLink <> nil) and FDataLink.Active and (I = SaveActive) then begin
            Indicator := 0;
            if FDataLink.DataSet <> nil then
              case FDataLink.DataSet.State of
                dsEdit   : Indicator := 1;
                dsInsert : Indicator := 2;
              end;
            {$IFDEF Win32}
            clIndicators.BkColor := clBtnFace;
            {$ENDIF}
            clIndicators.Draw(Canvas, FIndicatorWidth-clIndicators.Width-3,
              (CR.Top + CR.Bottom - clIndicators.Height) shr 1, Indicator);
          end;
        end;

        if (FDataLink <> nil) and FDataLink.Active and (Field <> nil)  {!!.14}
            and (I < FDataLink.RecordCount) then begin                 {!!.14}
          {change active db record}
          FDataLink.ActiveRecord := I;

          {get text to display}
          StrPCopy(Buf, Field.DisplayText);
        end else
          Buf[0] := #0;

        if Field <> nil then begin
          case Field.Alignment of
            taLeftJustify  : Left := X + CR.Left;
            taRightJustify : Left := ClientWidth - Canvas.TextWidth(StrPas(Buf)) - X;
          else
            Left := (ClientWidth - Canvas.TextWidth(StrPas(Buf))) div 2;
          end;
        end else
          Left := X + CR.Left;

        {change colors for active item}
        if (I = ActiveRow) and (Focused or not HideSelection) then begin
          Canvas.Brush.Color := HighlightColors.BackColor;
          Canvas.Font.Color := HighlightColors.TextColor;
        end;

        {adjust display string for horizontal scroll}
        P := @Buf[0];
        if clHDelta > 0 then begin
          if clHDelta < LongInt(StrLen(Buf)) then                      {!!.D4}
            P := @Buf[clHDelta]
          else
            P := '';
        end;

        {paint the string}
        Canvas.FillRect(CR);                                           {!!.11}
        ExtTextOut(Canvas.Handle, Left, Y, ETO_CLIPPED,                {!!.11}
                   @CR, P, StrLen(P), nil);

        {restore colors for active items}
        if I = ActiveRow then begin
          Canvas.Brush.Color := Color;
          if not Enabled and (Color <> clGrayText) then                {!!.16}
            Canvas.Font.Color := clGrayText                            {!!.16}
          else                                                         {!!.16}
            Canvas.Font.Color := Font.Color;
        end;
      end;
    end;

  finally
    {restore active record}
    if (FDataLink <> nil) and FDataLink.Active then
      FDataLink.ActiveRecord := SaveActive;

    {clear painting flag}
    clPainting := False;
  end;

  {paint any blank area below the last item}
  CR.Top := FRowHeight * (clNumRows+Ord(FShowHeader));
  if CR.Top < ClientHeight then begin
    CR.Bottom := ClientHeight;
    {clear the area}
    Canvas.FillRect(CR);
  end;

  {draw cell divider lines}
  if FShowIndicator then
    X := FIndicatorWidth
  else
    X := 0;
  Y := Ord(FShowHeader)*FRowHeight - 1;
  Canvas.Pen.Color := LineColor;
  {$IFDEF WIN32}                                                       {!!.15}
  if LineColor = clNone then                                           {!!.15}
    Canvas.Pen.Color := Canvas.Brush.Color;                            {!!.15}
  {$ENDIF WIN32}                                                       {!!.15}
  for I := 0 to Pred(clNumRows)-1 do begin
    Inc(Y, FRowHeight);
    Canvas.PolyLine([Point(X, Y), Point(ClientWidth, Y)]);
  end;
end;

procedure TOvcDbColumnList.SetActiveRow(Value : Integer);
  {-set the currently selected item}
begin
  if (FDataLink = nil) or not FDataLink.Active then
    Exit;

  if Value < 0 then
    Value := 0;
  if Value > Pred(clNumRows) then
    Value := Pred(clNumRows);

  if Value <> FActiveRow then
    FDataLink.DataSet.MoveBy(Value-FActiveRow);
end;

procedure TOvcDbColumnList.SetAutoRowHeight(Value : Boolean);
  {-set use of auto row height calculations}
begin
  if Value <> FAutoRowHeight then begin
    FAutoRowHeight := Value;
    if FAutoRowHeight then
      RecreateWnd;
  end;
end;

procedure TOvcDbColumnList.SetBorderStyle(const Value : TBorderStyle);
  {-set the style used for the border}
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TOvcDbColumnList.SetDataField(const Value : string);
begin
  try
    FDataLink.FieldName := Value;
  except
    FDataLink.FieldName := '';
    raise;
  end;
  Refresh;

  if csDesigning in ComponentState then
    RecreateWnd;
end;

procedure TOvcDbColumnList.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}
  Refresh;
end;

procedure TOvcDbColumnList.SetHeader(const Value : string);
  {-set the header at top of list box}
begin
  if Value <> FHeader then begin
    FHeader := Value;
    Repaint;
  end;
end;

procedure TOvcDbColumnList.SetIndicatorWidth(Value : Integer);
  {-set the row indicator width}
begin
  if (Value <> FIndicatorWidth) and (Value >= 0) then begin
    FIndicatorWidth := Value;

    {at design-time, automatically toggle the show state}
    if csDesigning in ComponentState then begin
      if FIndicatorWidth = 0 then
        FShowIndicator := False
      else
        FShowIndicator := True;
    end;

    Refresh;
  end;
end;

procedure TOvcDbColumnList.SetIntegralHeight(Value : Boolean);
  {-set use of integral font height adjustment}
begin
  if (Value <> FIntegralHeight) then begin
    FIntegralHeight := Value;
    RecreateWnd;
  end;
end;

procedure TOvcDbColumnList.SetLineColor(Value : TColor);
  {-set the color used to draw the row divider lines}
begin
  if Value <> FLineColor then begin
    FLineColor := Value;
    Refresh;
  end;
end;

procedure TOvcDbColumnList.SetRowHeight(Value : Integer);
  {-set height of cell row}
begin
  if (Value <> FRowHeight) and (Value > 0) then begin
    FRowHeight := Value;
    if not (csLoading in ComponentState) then
      FAutoRowHeight := False;
    RecreateWnd;
  end;
end;

procedure TOvcDbColumnList.SetScrollBars(const Value : TScrollStyle);
  {-set use of vertical and horizontal scroll bars}
begin
  if Value <> FScrollBars then begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TOvcDbColumnList.SetShowHeader(Value : Boolean);
  {-set show flag for the header}
begin
  if Value <> FShowHeader then begin
    FShowHeader := Value;
    Refresh;
  end;
end;

procedure TOvcDbColumnList.SetShowIndicator(Value : Boolean);
  {-set the show indicators option}
begin
  if Value <> FShowIndicator then begin
    FShowIndicator := Value;
    if FShowIndicator then begin
      {at design-time, automatically set width}
      if (csDesigning in ComponentState) and (FIndicatorWidth = 0) then
        FIndicatorWidth := DefIndicatorWidth;
    end;

    Refresh;
  end;
end;

procedure TOvcDbColumnList.SetTextMargin(Value : Integer);
  {-set the text margin}
begin
  if (Value <> FTextMargin) and (Value >= 0) then begin
    FTextMargin := Value;

    Refresh;
  end;
end;

procedure TOvcDbColumnList.WMEraseBkgnd(var Msg : TWMEraseBkGnd);
begin
  {indicate that we have processed this message}
  Msg.Result := 1;
end;

procedure TOvcDbColumnList.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;

  Msg.Result := Msg.Result or DLGC_WANTARROWS;
end;

procedure TOvcDbColumnList.WMGetMinMaxInfo(var Msg : TWMGetMinMaxInfo);
begin
  Msg.MinMaxInfo^.ptMinTrackSize.Y := FRowHeight;
  Msg.Result := 0;
end;

procedure TOvcDbColumnList.WMHScroll(var Msg : TWMHScroll);

  procedure HScrollPrim(Delta : Integer);
  var
    SaveD : Integer;
  begin
    SaveD := clHDelta;
    if Delta < 0 then
      if Abs(Delta) > clHDelta then
        clHDelta := 0
      else
        Inc(clHDelta, Delta)
    else
      if clHDelta+Delta > Field.DisplayWidth then
        clHDelta := Field.DisplayWidth
      else
        Inc(clHDelta, Delta);

    if clHDelta <> SaveD then begin
      clSetHScrollPos;
      Refresh;
    end;
  end;

begin
  if (Field = nil) then
    Exit;

  case Msg.ScrollCode of
    SB_LINERIGHT : HScrollPrim(+1);
    SB_LINELEFT  : HScrollPrim(-1);
    SB_PAGERIGHT : HScrollPrim(+10);
    SB_PAGELEFT  : HScrollPrim(-10);
    SB_THUMBPOSITION, SB_THUMBTRACK :
      if clHDelta <> Msg.Pos then begin
        clHDelta := Msg.Pos;
        clSetHScrollPos;
        Refresh;
      end;
  end;
end;

procedure TOvcDbColumnList.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  inherited;

  if (Field = nil) then
    Exit;

  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));

  if Cmd <> ccNone then begin
    case Cmd of
      ccLeft :
        if clHDelta > 0 then begin
          Dec(clHDelta);
          clSetHScrollPos;
          Refresh;
        end;
      ccRight :
        if clHDelta < Field.DisplayWidth then begin
          Inc(clHDelta);
          clSetHScrollPos;
          Refresh;
        end;
      ccHome :
        begin
          clHDelta := 0;
          clSetHScrollPos;
          Refresh;
        end;
      ccEnd :
        begin
          clHDelta := Field.DisplayWidth;
          clSetHScrollPos;
          Refresh;
        end;
      ccUp        :
        Perform(WM_VSCROLL, SB_LINEUP, 0);
      ccDown      :
        Perform(WM_VSCROLL, SB_LINEDOWN, 0);
      {$IFDEF Win32}
      ccFirstPage :
        Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 0), Parent.Handle);
      ccLastPage  :
        Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 4), Parent.Handle);
      {$ELSE}
      ccFirstPage :
        Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(0, Parent.Handle));
      ccLastPage  :
        Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(4, Parent.Handle));
      {$ENDIF}
      ccPrevPage  :
        Perform(WM_VSCROLL, SB_PAGEUP, 0);
      ccNextPage  :
        Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
    else
      {do user command notification for user commands}
      if Cmd >= ccUserFirst then
        DoOnUserCommand(Cmd);
    end;

    {indicate that this message was processed}
    Msg.Result := 0;
  end;
end;

procedure TOvcDbColumnList.WMKillFocus(var Msg : TWMKillFocus);
begin
  inherited;

  {re-draw focused item to erase highlihgt}
  InvalidateItem(ActiveRow);
end;

procedure TOvcDbColumnList.WMLButtonDown(var Msg : TWMLButtonDown);
var
  P   : TPoint;
  Row : Integer;
begin
  inherited;

  {solve problem with minimized modeless dialogs and MDI child windows}
  {that contain virtual listbox components}
  if not Focused and CanFocus then
    {$IFDEF Win32}
    Windows.SetFocus(Handle);
    {$ELSE}
    WinProcs.SetFocus(Handle);
    {$ENDIF}

  {is this click on the header?}
  if FShowHeader and (Msg.YPos < FRowHeight) then begin
    DoOnClickHeader(Point(Msg.XPos, Msg.YPos));
    Exit;
  end;

  {determine which row the click was in}
  P.X := Msg.Pos.X;
  P.Y := Msg.Pos.Y;
  Row := P.Y div FRowHeight - Ord(FShowHeader);

  if (FDataLink <> nil) and FDataLink.Active and (FDataLink.RecordCount > 0) and
     (Row <> FDataLink.ActiveRecord) then begin
    {scroll the database as necessary}
    FDataLink.DataSet.MoveBy(Row - FDataLink.ActiveRecord);

    {update the active record number}
    clUpdateActive;
  end;

  {see if the click was in an indicator region}
  if FShowIndicator and (P.X <= FIndicatorWidth) then
    DoOnIndicatorClick(Row);
end;

procedure TOvcDbColumnList.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  if (csDesigning in ComponentState) or (GetFocus = Handle) then
    inherited
  else begin
    if Controller.ErrorPending then
      Msg.Result := MA_NOACTIVATEANDEAT
    else
      Msg.Result := MA_ACTIVATE;
  end;
end;

procedure TOvcDbColumnList.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  if csDesigning in ComponentState then
    {don't call inherited so we can bypass vcl's attempt}
    {to trap the mouse hit}
    DefaultHandler(Msg)
  else
    inherited;
end;

procedure TOvcDbColumnList.WMSetFocus(var Msg : TWMSetFocus);
begin
  inherited;

  {re-draw focused item to erase highlihgt}
  InvalidateItem(ActiveRow);
end;

procedure TOvcDbColumnList.WMSize(var Msg : TWMSize);
begin
  inherited;

  {optionally, adjust list height}
  clAdjustIntegralHeight;
  {determine the number of rows}
  clCalcNumRows;

  {set the number of managed items}
  clUpdateNumRows;

  {update the active record number}
  clUpdateActive;

  {set the scroll bar range}
  clInitScrollBarInfo;
end;

procedure TOvcDbColumnList.WMVScroll(var Msg : TWMVScroll);
begin
  if (FDataLink <> nil) and FDataLink.Active then with FDataLink do begin
    case Msg.ScrollCode of
      SB_LINEUP        :
        if FPageScroll then
          DataSet.MoveBy(-FActiveRow-1)
        else
          DataSet.MoveBy(-1);
      SB_LINEDOWN      :
        if FPageScroll then
          DataSet.MoveBy(clNumRows-FActiveRow)
        else
          DataSet.MoveBy(+1);
      SB_PAGEUP        :
        DataSet.MoveBy(-clNumRows);
      SB_PAGEDOWN      :
        DataSet.MoveBy(+clNumRows);
      SB_THUMBPOSITION :
        begin
          case Msg.Pos of
            0: DataSet.First;
            1: DataSet.MoveBy(-clNumRows);
            2: Exit;
            3: DataSet.MoveBy(clNumRows);
            4: DataSet.Last;
          end;
        end;
      SB_BOTTOM : DataSet.Last;
      SB_TOP    : DataSet.First;
    end;

    {update the active record number}
    clUpdateActive;
  end;

  Update;
end;


end.