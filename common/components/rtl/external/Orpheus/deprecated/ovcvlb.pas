{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}
{$Q-} {Arithmatic-Overflow Checking}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCVLB.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcVlb;
  {-Virtual list box component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, StdCtrls,
  Menus, Messages, SysUtils,
  OvcBase, OvcCmd, OvcConst, OvcData, OvcMisc, OvcExcpt, OvcColor;

const
  MaxItems    = MaxLongInt;      {maximum items managed}
  MaxTabStops = 128;             {maximum number of tab stops}

const
  {default property values}
  vlDefAutoRowHeight   = True;
  vlDefAlign           = alNone;
  vlDefBorderStyle     = bsSingle;
  vlDefColor           = clWindow;
  vlDefColumns         = 255;
  vlDefCtl3D           = True;
  vlDefHeaderBack      = clBtnFace;
  vlDefHeaderText      = clBtnText;
  vlDefHeight          = 150;
  vlDefIntegralHeight  = True;
  vlDefItemIndex       = -1;
  vlDefMultiSelect     = False;
  vlDefNumItems        = MaxItems;
  vlDefOwnerDraw       = False;
  vlDefParentColor     = False;
  vlDefParentCtl3D     = True;
  vlDefParentFont      = True;
  vlDefProtectBack     = clRed;
  vlDefProtectText     = clWhite;
  {$IFDEF Win32}
  vlDefRowHeight       = 17;
  {$ELSE}
  vlDefRowHeight       = 20;
  {$ENDIF}
  vlDefScrollBars      = ssVertical;
  vlDefSelectBack      = clHighlight;
  vlDefSelectText      = clHighlightText;
  vlDefShowHeader      = False;
  vlDefTopIndex        = 0;
  vlDefTabStop         = True;
  vlDefUseTabStops     = False;
  vlDefWidth           = 100;

type
  TCharToItemEvent =
    procedure(Sender : TObject; Ch : Char; var Index : LongInt)
    of object;
    {-event to notify caller of a key press and return new item index}
  TDrawItemEvent =
    procedure(Sender : TObject; Index : LongInt; Rect : TRect; const S : string)
    of object;
    {-event to allow user to draw the cell items}
  TGetItemEvent =
    procedure(Sender : TObject; Index : LongInt; var ItemString : string)
    of object;
    {-event to get string to display}
  TGetItemColorEvent =
    procedure(Sender : TObject; Index : LongInt; var FG, BG : TColor)
    of object;
    {-event to get color of the item cell}
  TGetItemStatusEvent =
    procedure(Sender : TObject; Index : LongInt; var Protect : Boolean)
    of object;
    {-event to get the protected status item cell}
  THeaderClickEvent =
    procedure(Sender : TObject; Point : TPoint)
    of object;
    {-event to notify of a mouse click in the header area}
  TIsSelectedEvent =
    procedure(Sender : TObject; Index : LongInt; var Selected : Boolean)
    of object;
    {-event to get the current selection status from the user}
  TSelectEvent =
    procedure(Sender : TObject; Index : LongInt; Selected : Boolean)
    of object;
    {-event to notify of a selection change}
  TTopIndexChanged =
    procedure(Sender : TObject; NewTopIndex : LongInt)
    of object;
    {-event to notify when the top index changes}

type
  TTabStopArray = array[0..MaxTabStops] of Integer;
  TBuffer = array[0..255] of AnsiChar;

type
  TOvcCustomVirtualListBox = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FItemIndex         : LongInt;     {selected item}
    FAutoRowHeight     : Boolean;     {true to handle row height calc}
    FBorderStyle       : TBorderStyle;{border style to use}
    FColumns           : Byte;        {number of char columns}
    FHeader            : string;      {the column header}
    FHeaderColor       : TOvcColors;  {header line colors}
    FIntegralHeight    : Boolean;     {adjust height based on font}
    FMultiSelect       : Boolean;     {allow multiple selections}
    FNumItems          : LongInt;     {total number of items}
    FOwnerDraw         : Boolean;     {true if user will draw rows}
    FProtectColor      : TOvcColors;  {protected item colors}
    FRowHeight         : Integer;     {height of one row}
    FScrollBars        : TScrollStyle;{scroll bar style to use}
    FSelectColor       : TOvcColors;  {selected item color}
    FShowHeader        : Boolean;     {true to use the header}
    FTopIndex          : LongInt;     {item at top of window}
    FUseTabStops       : Boolean;     {true to use tab stops}

    {event variables}
    FOnCharToItem      : TCharToItemEvent;
    FOnClickHeader     : THeaderClickEvent;
    FOnDrawItem        : TDrawItemEvent;
    FOnGetItem         : TGetItemEvent;
    FOnGetItemColor    : TGetItemColorEvent;
    FOnGetItemStatus   : TGetItemStatusEvent;
    FOnIsSelected      : TIsSelectedEvent;
    FOnSelect          : TSelectEvent;
    FOnTopIndexChanged : TTopIndexChanged;
    FOnUserCommand     : TUserCommandEvent;

    {internal/working variables}
    lAnchor            : LongInt;   {anchor point for extended selections}
    lDivisor           : LongInt;   {divisor for scroll bars}
    lDlgUnits          : Integer;   {used for tab spacing}
    lFocusedIndex      : LongInt;   {index of the focused item}
    lHaveHS            : Boolean;   {if True, we have a horizontal scroll bar}
    lHaveVS            : Boolean;   {if True, we have a vertical scroll bar}
    lHDelta            : Integer;   {horizontal scroll delta}
    lHighIndex         : LongInt;   {highest allowable index}
    lNumTabStops       : 0..MaxTabStops; {number of tab stops in tabstop array}
    lRows              : Integer;   {number of rows in window}
    lString            : TBuffer;   {temp item string buffer}
    lTabs              : TTabStopArray;
    lUpdating          : Boolean;   {user updating flag}
    lVSHigh            : Integer;   {vertical scroll limit}

    {property methods}
    procedure SetAutoRowHeight(Value : Boolean);
      {-set use of auto row height calculations}
    procedure SetBorderStyle(const Value : TBorderStyle);
      {-set the style used for the border}
    procedure SetHeader(const Value : string);
      {-set the header at top of list box}
    procedure SetIntegralHeight(Value : Boolean);
      {-set use of integral font height adjustment}
    procedure SetMultiSelect(Value : Boolean);
      {-set ability to select multiple items}
    procedure SetNumItems(Value : LongInt);
      {-set the number of items in the list box}
    procedure SetRowHeight(Value : Integer);
      {-set height of cell row}
    procedure SetScrollBars(const Value : TScrollStyle);
      {-set use of vertical and horizontal scroll bars}
    procedure SetShowHeader(Value : Boolean);
      {-set the header at top of list box}

    {internal methods}
    procedure vlbAdjustIntegralHeight;
      {-adjust height of the list box}
    procedure vlbCalcFontFields;
      {-calculate sizes based on font selection}
    procedure vlbClearAllItems;
      {-clear the highlight from all items}
    procedure vlbClearSelRange(First, Last : LongInt);
      {-clear the selection for the given range of indexes}
    procedure vlbColorChanged(AColor: TObject);
      {-a color has changed, refresh display}
    procedure vlbDragSelection(First, Last : LongInt);
      {-drag the selection}
    procedure vlbDrawFocusRect(Index : LongInt);
      {-draw the focus rectangle}
    procedure vlbDrawHeader;
      {-draw the header and text area}
    procedure vlbExtendSelection(Index : LongInt);
      {-process Shift-LMouseBtn}
    procedure vlbHScrollPrim(Delta : Integer);
      {-scroll horizontally}
    procedure vlbInitScrollInfo;
      {-setup scroll bar range and initial position}
    procedure vlbMakeItemVisible(Index : LongInt);
      {-make sure the item is visible}
    procedure vlbNewActiveItem(Index : LongInt);
      {-set the currently selected item}
    function  vlbScaleDown(N : LongInt) : Integer;
      {-scale down index for scroll bar use}
    function  vlbScaleUp(N : LongInt) : LongInt;
      {-scale up scroll index to our index}
    procedure vlbSelectRangePrim(First, Last : LongInt; Select : Boolean);
      {-change the selection for the given range of indexes}
    procedure vlbSetAllItemsPrim(Select : Boolean);
      {-primitive routine thats acts on all items}
    procedure vlbSetFocusedIndex(Index : LongInt);
      {-set focus to this item. invalidate previous}
    procedure vlbSetHScrollPos;
      {-set the horizontal scroll position}
    procedure vlbSetHScrollRange;
      {-set the horizontal scroll range}
    procedure vlbSetSelRange(First, Last : LongInt);
      {-set the selection on for the given range of indexes}
    procedure vlbSetVScrollPos;
      {-set the vertical scroll position}
    procedure vlbSetVScrollRange;
      {-set the vertical scroll range}
    procedure vlbToggleSelection(Index : LongInt);
      {-process Ctrl-LMouseBtn}
    procedure vlbValidateItem(Index : LongInt);
      {-validate the area for this item}
    procedure vlbVScrollPrim(Delta : Integer);
      {-scroll vertically}

    {VCL control messages}
    procedure CMCtl3DChanged(var Message: TMessage);
      message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage);
      message CM_FONTCHANGED;

    {windows message methods}
    procedure WMChar(var Msg : TWMChar);
      message WM_CHAR;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd);
      message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMHScroll(var Msg : TWMScroll);
      message WM_HSCROLL;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Msg : TWMLButtonDblClk);
      message WM_LBUTTONDBLCLK;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;
    procedure WMVScroll(var Msg : TWMScroll);
      message WM_VSCROLL;

    {list box messages}
    procedure LBGetCaretIndex(var Msg : TMessage);
      message LB_GETCARETINDEX;
    procedure LBGetCount(var Msg : TMessage);
      message LB_GETCOUNT;
    procedure LBGetCurSel(var Msg : TMessage);
      message LB_GETCURSEL;
    procedure LBGetItemHeight(var Msg : TMessage);
      message LB_GETITEMHEIGHT;
    procedure LBGetItemRect(var Msg : TMessage);
      message LB_GETITEMRECT;
    procedure LBGetSel(var Msg : TMessage);
      message LB_GETSEL;
    procedure LBGetTopIndex(var Msg : TMessage);
      message LB_GETTOPINDEX;
    procedure LBResetContent(var Msg : TMessage);
      message LB_RESETCONTENT;
    procedure LBSelItemRange(var Msg : TMessage);
      message LB_SELITEMRANGE;
    procedure LBSetCurSel(var Msg : TMessage);
      message LB_SETCURSEL;
    procedure LBSetSel(var Msg : TMessage);
      message LB_SETSEL;
    procedure LBSetTabStops(var Msg : TMessage);
      message LB_SETTABSTOPS;
    procedure LBSetTopIndex(var Msg : TMessage);
      message LB_SETTOPINDEX;

  protected
    procedure ChangeScale(M, D : Integer);
      override;
    procedure CreateParams(var Params: TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure Paint;
      override;

    {event wrappers}
    function DoOnCharToItem(Ch : AnsiChar) : LongInt;
      dynamic;
      {-call the OnCharToItem event, if assigned}
    procedure DoOnClickHeader(Point : TPoint);
      dynamic;
      {-call the OnClickHeader event, if assigned}
    procedure DoOnDrawItem(Index : LongInt; Rect : TRect; const S : string);
      virtual;
      {-call the OnDrawItem event, if assigned}
    function DoOnGetItem(Index : LongInt) : PAnsiChar;
      virtual;
      {-call the OnGetItem event, if assigned}
    procedure DoOnGetItemColor(Index : LongInt; var FG, BG : TColor);
      virtual;
      {-call the OnGetItemColor event, if assigned}
    function DoOnGetItemStatus(Index : LongInt) : Boolean;
      virtual;
      {-call the OnGetItemStatus event, if assigned}
    function DoOnIsSelected(Index : LongInt) : Boolean;
      virtual;
      {-call the OnIsSelected event, if assigned}
    procedure DoOnSelect(Index : LongInt; Selected : Boolean);
      dynamic;
      {-call the OnSelect event, if assigned}
    procedure DoOnTopIndexChanged(NewTopIndex : LongInt);
      dynamic;
      {-call the OnTopIndexChanged event, if assigned}
    procedure DoOnUserCommand(Command : Word);
      dynamic;
      {-perform notification of a user command}

    {virtual property methods}
    procedure SetItemIndex(Index : LongInt);
      virtual;
      {-change the currently selected item}
    procedure SetTopIndex(Index : LongInt);
      virtual;
      {-set the index of the first visible entry in the list}
  {.Z-}

    {protected properties}
    property AutoRowHeight : Boolean
      read FAutoRowHeight
      write SetAutoRowHeight
      default vlDefAutoRowHeight;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default vlDefBorderStyle;

    property Columns : Byte
      read FColumns
      write FColumns
      default vlDefColumns;

    property Header : string
      read FHeader
      write SetHeader;

    property HeaderColor : TOvcColors
      read FHeaderColor
      write FHeaderColor;

    property IntegralHeight : Boolean
      read FIntegralHeight
      write SetIntegralHeight
      default vlDefIntegralHeight;

    property MultiSelect : Boolean
      read FMultiSelect
      write SetMultiSelect
      default vlDefMultiSelect;

    property NumItems : LongInt
      read FNumItems
      write SetNumItems
      default vlDefNumItems;

    property OwnerDraw : Boolean
      read FOwnerDraw
      write FOwnerDraw
      default vlDefOwnerDraw;

    property ProtectColor : TOvcColors
      read FProtectColor
      write FProtectColor;

    property RowHeight : Integer
      read FRowHeight
      write SetRowHeight
      default vlDefRowHeight;

    property ScrollBars : TScrollStyle
       read FScrollBars
       write SetScrollBars
       default vlDefScrollBars;

    property SelectColor : TOvcColors
      read FSelectColor
      write FSelectColor;

    property ShowHeader : Boolean
      read FShowHeader
      write SetShowHeader
      default vlDefShowHeader;

    property UseTabStops : Boolean
      read FUseTabStops
      write FUseTabStops
      default vlDefUseTabStops;

    {protected events}
    property OnCharToItem : TCharToItemEvent
      read FOnCharToItem
      write FOnCharToItem;

    property OnClickHeader : THeaderClickEvent
      read FOnClickHeader
      write FOnClickHeader;

    property OnDrawItem : TDrawItemEvent
      read FOnDrawItem
      write FOnDrawItem;

    property OnGetItem : TGetItemEvent
      read FOnGetItem
      write FOnGetItem;

    property OnGetItemColor : TGetItemColorEvent
      read FOnGetItemColor
      write FOnGetItemColor;

    property OnGetItemStatus : TGetItemStatusEvent
      read FOnGetItemStatus
      write FOnGetItemStatus;

    property OnIsSelected : TIsSelectedEvent
      read FOnIsSelected
      write FOnIsSelected;

    property OnSelect : TSelectEvent
      read FOnSelect
      write FOnSelect;

    property OnTopIndexChanged : TTopIndexChanged
      read FOnTopIndexChanged
      write FOnTopIndexChanged;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

  public
  {.Z+}
    constructor Create(AOwner : TComponent);
      override;
    destructor  Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight : Integer);       {!!.D4}
      override;
  {.Z-}

    procedure BeginUpdate;
      {-user is updating the list items--don't paint}
    procedure DeselectAll;                                             {!!.13}
      {-deselect all items}
    procedure DrawItem(Index : LongInt);
      {-invalidate and update the area for this item}
    procedure EndUpdate;
      {-user is done updating the list items--force repaint}
    procedure InvalidateItem(Index : LongInt);
      {-invalidate the area for this item}
    function ItemAtPos(Pos : TPoint; Existing : Boolean) : LongInt;
      {-return the index of the cell that contains the point Pos}
    procedure Scroll(HDelta, VDelta : Integer);                        {!!.10}
      {-scroll the list by the give delta amount}
    procedure SelectAll;                                               {!!.13}
      {-select all items}
    procedure SetTabStops(Tabs : array of Integer);
      {-set tab stop positions}

    {public properties}
    property Canvas;

    property ItemIndex : LongInt
      read FItemIndex
      write SetItemIndex;

    property TopIndex : LongInt
      read FTopIndex
      write SetTopIndex;
  end;

  TOvcVirtualListbox = class(TOvcCustomVirtualListBox)
  published
    property AutoRowHeight;
    property BorderStyle;
    property Columns;
    property Header;
    property HeaderColor;
    property IntegralHeight;
    property MultiSelect;
    property NumItems;
    property OwnerDraw;
    property ProtectColor;
    property RowHeight;
    property ScrollBars;
    property SelectColor;
    property ShowHeader;
    property UseTabStops;

    property OnCharToItem;
    property OnClickHeader;
    property OnDrawItem;
    property OnGetItem;
    property OnGetItemColor;
    property OnGetItemStatus;
    property OnIsSelected;
    property OnSelect;
    property OnTopIndexChanged;
    property OnUserCommand;

    {inherited properties}
    property Align;
    property Color;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property Enabled;
    property Font;
    property ParentColor default vlDefParentColor;
    property ParentCtl3D default vlDefParentCtl3D;
    property ParentFont default vlDefParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default vlDefTabStop;
    property Visible;

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

procedure TOvcCustomVirtualListbox.BeginUpdate;
  {-user is updating the list items--don't paint}
begin
  lUpdating := True;
end;

procedure TOvcCustomVirtualListbox.ChangeScale(M, D : Integer);
begin
  inherited ChangeScale(M, D);

  if M <> D then begin
    {scale row height}
    FRowHeight := MulDiv(FRowHeight, M, D);

    vlbCalcFontFields;
    vlbAdjustIntegralHeight;
    vlbCalcFontFields;
    vlbInitScrollInfo;
    Refresh;
  end;
end;

procedure TOvcCustomVirtualListbox.CMCtl3DChanged(var Message: TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

procedure TOvcCustomVirtualListbox.CMFontChanged(var Message: TMessage);
begin
  inherited;

  if (csLoading in ComponentState) then
    Exit;

  if not HandleAllocated then
    Exit;

  {reset internal size variables}
  if FIntegralHeight then begin
    vlbCalcFontFields;
    vlbAdjustIntegralHeight;
  end;

  vlbCalcFontFields;
  vlbInitScrollInfo;
end;

constructor TOvcCustomVirtualListbox.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := ControlStyle + [csClickEvents, csCaptureMouse, csOpaque]
  else
    ControlStyle := ControlStyle + [csClickEvents, csCaptureMouse, csOpaque, csFramed];
  {$ELSE}
    ControlStyle := ControlStyle + [csClickEvents, csCaptureMouse, csOpaque, csFramed];
  {$ENDIF}

  {set default values for inherited persistent properties}
  Align        := vlDefAlign;
  Color        := vlDefColor;
  Ctl3D        := vlDefCtl3D;
  Height       := vlDefHeight;
  ParentColor  := vlDefParentColor;
  ParentCtl3D  := vlDefParentCtl3D;
  ParentFont   := vlDefParentFont;
  TabStop      := vlDefTabStop;
  Width        := vlDefWidth;

  {set default values for new persistent properties}
  FAutoRowHeight  := vlDefAutoRowHeight;
  FBorderStyle    := vlDefBorderStyle;
  FColumns        := vlDefColumns;
  FHeader         := '';
  FIntegralHeight := vlDefIntegralHeight;
  FItemIndex      := vlDefItemIndex;
  FMultiSelect    := vlDefMultiSelect;
  FNumItems       := vlDefNumItems;
  FOwnerDraw      := vlDefOwnerDraw;
  FRowHeight      := vlDefRowHeight;
  FScrollBars     := vlDefScrollBars;
  FShowHeader     := vlDefShowHeader;
  FTopIndex       := vlDefTopIndex;
  FUseTabStops    := vlDefUseTabStops;

  {set defaults for internal variables}
  lHDelta         := 0;
  lHaveHS         := False;
  lHaveVS         := False;

  lAnchor         := 0;
  lFocusedIndex   := 0;

  lNumTabStops    := 0;
  FillChar(lTabs, SizeOf(lTabs), #0);

  {create and initialize color objects}
  FHeaderColor  := TOvcColors.Create(vlDefHeaderText, vlDefHeaderBack);
  FHeaderColor.OnColorChange := vlbColorChanged;
  FProtectColor := TOvcColors.Create(vlDefProtectText, vlDefProtectBack);
  FProtectColor.OnColorChange := vlbColorChanged;
  FSelectColor  := TOvcColors.Create(vlDefSelectText, vlDefSelectBack);
  FSelectColor.OnColorChange := vlbColorChanged;
end;

procedure TOvcCustomVirtualListbox.CreateParams(var Params: TCreateParams);
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

procedure TOvcCustomVirtualListbox.CreateWnd;
begin
  inherited CreateWnd;

  {do we have scroll bars}
  lHaveVS := FScrollBars in [ssVertical, ssBoth];
  lHaveHS := FScrollBars in [ssHorizontal, ssBoth];
  lHighIndex := Pred(FNumItems);

  lFocusedIndex := 0;

  {determine the height of one row and number of rows}
  vlbCalcFontFields;
  vlbAdjustIntegralHeight;

  {setup scroll bar info}
  vlbInitScrollInfo;
end;

function TOvcCustomVirtualListbox.DoOnCharToItem(Ch : AnsiChar) : LongInt;
begin
  Result := FItemIndex;
  if Assigned(FOnCharToItem) then
    FOnCharToItem(Self, Ch, Result);
end;

procedure TOvcCustomVirtualListbox.DoOnClickHeader(Point : TPoint);
begin
  if Assigned(FOnClickHeader) then
    FOnClickHeader(Self, Point);
end;

procedure TOvcCustomVirtualListbox.DoOnDrawItem(Index : LongInt; Rect : TRect;
  const S : string);
begin
  if Assigned(FOnDrawItem) then
    FOnDrawItem(Self, Index, Rect, S);
end;

function TOvcCustomVirtualListbox.DoOnGetItem(Index : LongInt) : PAnsiChar;
  {-returns the string representing Nth item}
var
  S : string;
begin
  if Assigned(FOnGetItem) then begin
    S := '';
    FOnGetItem(Self, Index, S);
    StrPCopy(lString, S);
    Result := @lString[0];
  end else if csDesigning in ComponentState then begin
    StrPCopy(lString, Format(GetOrphStr(SCSampleListItem), [Index]));
    Result := @lString[0];
  end else
    Result := StrPCopy(lString, Format(GetOrphStr(SCGotItemWarning), [Index]));
end;

procedure TOvcCustomVirtualListbox.DoOnGetItemColor(Index : LongInt; var FG, BG : TColor);
begin
  if Assigned(FOnGetItemColor) then
    FOnGetItemColor(Self, Index, FG, BG);
end;

function TOvcCustomVirtualListbox.DoOnGetItemStatus(Index : LongInt) : Boolean;
begin
  Result := False;
  if Assigned(FOnGetItemStatus) then
    FOnGetItemStatus(Self, Index, Result);
end;

function TOvcCustomVirtualListbox.DoOnIsSelected(Index : LongInt) : Boolean;
  {-returns the selected status for the "Index" item}
begin
  if csDesigning in ComponentState then
    Result := Index = 0
  else begin
    Result := (Index = FItemIndex);
    if FMultiSelect then begin
      if Assigned(FOnIsSelected) then
        FOnIsSelected(Self, Index, Result)
      else
        raise EOnIsSelectedNotAssigned.Create;
    end;
  end;
end;

procedure TOvcCustomVirtualListbox.DoOnSelect(Index : LongInt; Selected : Boolean);
  {-notify of selection change}
begin
  if csDesigning in ComponentState then
    Exit;

  if FMultiSelect then begin
    if Assigned(FOnSelect) then begin
      {select if not protected-deselect always}
      if (not Selected) or (not DoOnGetItemStatus(Index)) then
        FOnSelect(Self, Index, Selected);
    end else
      raise EOnSelectNotAssigned.Create;
  end;
end;

procedure TOvcCustomVirtualListbox.DoOnTopIndexChanged(NewTopIndex : LongInt);
  {-call the OnTopIndexChanged event, if assigned}
begin
  if Assigned(FOnTopIndexChanged) then
    FOnTopIndexChanged(Self, NewTopIndex);
end;

procedure TOvcCustomVirtualListbox.DoOnUserCommand(Command : Word);
  {-perform notification of a user command}
begin
  if Assigned(FOnUserCommand) then
    FOnUserCommand(Self, Command);
end;

{!!.13} {added}
procedure TOvcCustomVirtualListbox.DeselectAll;
  {-deselect all items}
begin
  vlbSetAllItemsPrim(False {deselect});
end;

procedure TOvcCustomVirtualListbox.DrawItem(Index : LongInt);
  {-invalidate and update the area for this item}
begin
  InvalidateItem(Index);
  Update;
end;

destructor  TOvcCustomVirtualListbox.Destroy;
begin
  FHeaderColor.Free;
  FProtectColor.Free;
  FSelectColor.Free;

  inherited Destroy;
end;

procedure TOvcCustomVirtualListbox.EndUpdate;
 {-user is done updating the list items--force repaint}
begin
  lUpdating := False;
  Invalidate;
end;

procedure TOvcCustomVirtualListbox.InvalidateItem(Index : LongInt);
  {-invalidate the area for this item}
var
  CR : TRect;
begin
  if (Index >= FTopIndex) and (Index-FTopIndex < lRows) then begin  {visible?}
    CR := Rect(0, (Index-FTopIndex+Ord(FShowHeader))*FRowHeight, ClientWidth, 0);
    CR.Bottom := CR.Top+FRowHeight;
    InvalidateRect(Handle, @CR, True);
  end;
end;

function TOvcCustomVirtualListbox.ItemAtPos(Pos : TPoint;
         Existing : Boolean) : LongInt;
  {-return the index of the cell that contains the point Pos}
begin
  if (Pos.Y < Ord(FShowHeader)*FRowHeight) then begin
    if Existing then
      Result := -1
    else
      Result := 0;
  end else if (Pos.Y >= ClientHeight) then begin
    if Existing then
      Result := -1
    else
      Result := lHighIndex;
  end else begin {convert to an index}
    Result := FTopIndex-Ord(FShowHeader)+(Pos.Y div FRowHeight);
    {test for click below last item (IntegralHeight not set)}
    if ClientHeight mod FRowHeight > 0 then
      if Result > FTopIndex+lRows-1 then
        Result := FTopIndex+lRows-1;
  end;
end;

procedure TOvcCustomVirtualListbox.LBGetCaretIndex(var Msg : TMessage);
begin
  Msg.Result := lFocusedIndex;
end;

procedure TOvcCustomVirtualListbox.LBGetCount(var Msg : TMessage);
begin
  Msg.Result := FNumItems;
end;

procedure TOvcCustomVirtualListbox.LBGetCurSel(var Msg : TMessage);
begin
  Msg.Result := FItemIndex;
end;

procedure TOvcCustomVirtualListbox.LBGetItemHeight(var Msg : TMessage);
begin
  Msg.Result := FRowHeight;
end;

procedure TOvcCustomVirtualListbox.LBGetItemRect(var Msg : TMessage);
begin
  PRect(Msg.Result)^ := Rect(0, 0, ClientWidth, FRowHeight);
end;

procedure TOvcCustomVirtualListbox.LBGetSel(var Msg : TMessage);
begin
  if (Msg.wParam >= 0) and (Msg.wParam <= lHighIndex) then
    Msg.Result := Ord(DoOnIsSelected(Msg.wParam))
  else
    Msg.Result := LB_ERR;
end;

procedure TOvcCustomVirtualListbox.LBGetTopIndex(var Msg : TMessage);
begin
  Msg.Result := FTopIndex;
end;

procedure TOvcCustomVirtualListbox.LBResetContent(var Msg : TMessage);
begin
  NumItems := 0;
end;

procedure TOvcCustomVirtualListbox.LBSelItemRange(var Msg : TMessage);
begin
  if FMultiSelect and {(Msg.lParamLo >= 0) and} (Msg.wParamLo <= lHighIndex) {!!.D4}
     and {(Msg.lParamHi >= 0) and} (Msg.wParamHi <= lHighIndex) then begin {!!.D4}
    vlbSelectRangePrim(Msg.lParamLo, Msg.lParamHi, Msg.wParam > 0);
    Msg.Result := 0;
  end else
    Msg.Result := LB_ERR;
end;

procedure TOvcCustomVirtualListbox.LBSetCurSel(var Msg : TMessage);
begin
  if FMultiSelect and (Msg.wParam >= -1) and (Msg.wParam <= lHighIndex) then begin
    SetItemIndex(Msg.wParam);
    if Msg.wParam = $FFFF then
      Msg.Result := LB_ERR
    else
      Msg.Result := 0;
  end else
    Msg.Result := LB_ERR;
end;

procedure TOvcCustomVirtualListbox.LBSetSel(var Msg : TMessage);
begin
  if FMultiSelect and (Msg.lParam >= -1) and (Msg.lParam <= lHighIndex) then begin
    if Msg.lParam = -1 then
      vlbSetAllItemsPrim(Msg.wParam > 0)
    else begin
      DoOnSelect(Msg.lParam, Msg.wParam > 0);
      InvalidateItem(Msg.lParam);
    end;
    Msg.Result := 0;
  end else
    Msg.Result := LB_ERR;
end;

procedure TOvcCustomVirtualListbox.LBSetTabStops(var Msg : TMessage);
type
  IA = TTabStopArray;
  IP = ^IA;
var
  I : Integer;
begin
  lNumTabStops := Msg.wParam;
  if lNumTabStops > MaxTabStops then begin
    lNumTabStops := MaxTabStops;
    Msg.Result := 0;  {didn't set all tabs}
  end else
    Msg.Result := 1;

  for I := 0 to Pred(lNumTabStops) do
    lTabs[I] := IP(Msg.lParam)^[I] * lDlgUnits;
end;

procedure TOvcCustomVirtualListbox.LBSetTopIndex(var Msg : TMessage);
begin
  if (Msg.wParam >= 0) and (Msg.wParam <= lHighIndex) then begin
    SetTopIndex(Msg.wParam);
    Msg.Result := 0;
  end else
    Msg.Result := LB_ERR;
end;

procedure TOvcCustomVirtualListbox.Paint;
var
  I    : Integer;
  ST   : PAnsiChar;
  CR   : TRect;
  IR   : TRect;
  Clip : TRect;
  Last : Integer;

  procedure DrawItem(N : LongInt; Row : Integer);
    {-Draw item N at Row}
  var
    S       : PAnsiChar;
    FGColor : TColor;
    BGColor : TColor;
    DX      : Integer;
  begin
    {get bounding rectangle}
    CR.Top := Pred(Row)*FRowHeight;
    CR.Bottom := CR.Top+FRowHeight;

    {do we have anything to paint}
    if Bool(IntersectRect(IR, Clip, CR)) then begin

      {get colors}
      if DoOnGetItemStatus(N) then begin
        BGColor := FProtectColor.BackColor;
        FGColor := FProtectColor.TextColor;
      end else if DoOnIsSelected(N) and (Row <= lRows+Ord(FShowHeader)) then begin
        BGColor := FSelectColor.BackColor;
        FGColor := FSelectColor.TextColor;
      end else begin
        BGColor := Color;
        FGColor := Font.Color;
        DoOnGetItemColor(N, FGColor, BGColor);
      end;

      {assign colors to our canvas}
      Canvas.Brush.Color := BGColor;
      Canvas.Font.Color := FGColor;

      {clear the line}
      Canvas.FillRect(CR);

      {get the string}
      if N <= lHighIndex then begin
        ST := DoOnGetItem(N);
        if lHDelta >= LongInt(StrLen(ST)) then                         {!!.D4}
          S := nil
        else
          S := @ST[lHDelta];
      end else
        S := nil;

      {draw the string}
      if S <> nil then begin
        if FOwnerDraw then
          DoOnDrawItem(N, CR, StrPas(S))
        else if FUseTabStops then begin
          DX := 0;
          if lHDelta > 0 then begin
            {measure portion of string to the left of the window}
            DX := LOWORD(GetTabbedTextExtent(Canvas.Handle,
                  ST, lHDelta, lNumTabStops, lTabs));
          end;
          TabbedTextOut(Canvas.Handle, CR.Left+2, CR.Top,
                        S, StrLen(S), lNumTabStops, lTabs, -DX)
        end else
          ExtTextOut(Canvas.Handle, CR.Left+2, CR.Top,
                     ETO_CLIPPED + ETO_OPAQUE, @CR, S, StrLen(S), nil);
      end;
    end;
  end;

begin
  {exit if the updating flag is set}
  if lUpdating then
    Exit;

  Canvas.Font := Font;

  {we will erase our own background}
  SetBkMode(Canvas.Handle, TRANSPARENT);

  {get the client rectangle}
  CR := ClientRect;

  {get the clipping region}
  GetClipBox(Canvas.Handle, Clip);

  {do we have a header?}
  if FShowHeader then begin
    if Bool(IntersectRect(IR, Clip, Rect(CR.Left, CR.Top, CR.Right, FRowHeight))) then
      vlbDrawHeader;
  end;

  {calculate last visible item}
  Last := lRows;
  if Last > NumItems then
    Last := NumItems;

  {display each row}
  for I := 1 to Last do
    DrawItem(FTopIndex+Pred(I), I+Ord(FShowHeader));

  {paint any blank area below last item}
  CR.Top := FRowHeight * (Last+Ord(FShowHeader));
  if CR.Top < ClientHeight then begin
    CR.Bottom := ClientHeight;
    {clear the area}
    Canvas.Brush.Color := Color;
    Canvas.FillRect(CR);
  end;

  Canvas.Brush.Color := Color;
  Canvas.Font.Color := Font.Color;
  if Canvas.Handle > 0 then {force colors to be selected into canvas};

  {conditionally, draw the focus rect}
  vlbDrawFocusRect(lFocusedIndex);
end;

{!!.10} {added}
procedure TOvcCustomVirtualListbox.Scroll(HDelta, VDelta : Integer);
  {-scroll the list by the give delta amount}
begin
  if HDelta <> 0 then
    vlbHScrollPrim(HDelta);

  if VDelta <> 0 then
    vlbVScrollPrim(VDelta);
end;

{!!.13} {added}
procedure TOvcCustomVirtualListbox.SelectAll;
  {-select all items}
begin
  vlbSetAllItemsPrim(True {select});
end;

procedure TOvcCustomVirtualListbox.SetAutoRowHeight(Value : Boolean);
  {-set use of auto row height calculations}
begin
  if Value <> FAutoRowHeight then begin
    FAutoRowHeight := Value;
    if FAutoRowHeight then begin
      vlbCalcFontFields;
      vlbAdjustIntegralHeight;
      vlbCalcFontFields;
      vlbInitScrollInfo;
      Refresh;
    end;
  end;
end;

procedure TOvcCustomVirtualListbox.SetBorderStyle(const Value : TBorderStyle);
  {-set the style used for the border}
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TOvcCustomVirtualListbox.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
begin
  if not (Align in [alNone, alTop, alBottom]) then
    FIntegralHeight := False;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TOvcCustomVirtualListbox.SetHeader(const Value : string);
  {-set the header at top of list box}
begin
  if Value <> FHeader then begin
    FHeader := Value;
    {toggle show header flag as appropriate}
    if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      ShowHeader := FHeader <> '';
    Repaint;
  end;
end;

procedure TOvcCustomVirtualListbox.SetIntegralHeight(Value : Boolean);
  {-set use of integral font height adjustment}
begin
  if (Value <> FIntegralHeight) and (Align in [alNone, alTop, alBottom]) then begin
    FIntegralHeight := Value;
    if FIntegralHeight then begin
      vlbCalcFontFields;
      vlbAdjustIntegralHeight;
      vlbCalcFontFields;
      vlbInitScrollInfo;
    end;
  end;
end;

procedure TOvcCustomVirtualListbox.SetItemIndex(Index : LongInt);
  {-change the currently selected item}
begin
  {verify valid index}
  if Index < 0 then
    Index := -1
  else if Index > lHighIndex then
    if lHighIndex < 0 then
      Index := -1
    else
      Index := lHighIndex;

  {do we need to do any more}
  if (Index = FItemIndex) then
    Exit;

  {erase current selection}
  InvalidateItem(FItemIndex);
  DoOnSelect(FItemIndex, False);

  {set the newly selected item index}
  FItemIndex := Index;

  if csDesigning in ComponentState then
    Exit;

  vlbMakeItemVisible(Index);
  DoOnSelect(FItemIndex, True);
  if FItemIndex > -1 then
    vlbSetFocusedIndex(FItemIndex);
  DrawItem(FItemIndex);

  {notify of an index change}
  if not MouseCapture then
    Click;
end;

procedure TOvcCustomVirtualListbox.SetMultiSelect(Value : Boolean);
  {-set ability to select multiple items}
begin
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    if Value <> FMultiSelect then
      FMultiSelect := Value;
end;

procedure TOvcCustomVirtualListbox.SetNumItems(Value : LongInt);
  {-set the number of items in the list box}
begin
  if Value <> FNumItems then begin
    if Value < 0 then
      Value := MaxItems;
    {if Value > MaxItems then}                                         {!!.D4}
    {  Value := MaxItems; }                                            {!!.D4}

    {set new item index}
    FNumItems := Value;

    {reset high index}
    lHighIndex := Pred(FNumItems);
    {reset horizontal offset}
    lHDelta := 0;

    {reset selected item}
    if not (csLoading in ComponentState) then begin
      ItemIndex := 0;
      TopIndex := 0;
    end;
    Repaint;

    vlbInitScrollInfo;
  end;
end;

procedure TOvcCustomVirtualListbox.SetRowHeight(Value : Integer);
  {-set height of cell row}
begin
  if Value <> FRowHeight then begin
    FRowHeight := Value;
    if not (csLoading in ComponentState) then
      AutoRowHeight := False;
    vlbCalcFontFields;
    vlbAdjustIntegralHeight;
    vlbCalcFontFields;
    vlbInitScrollInfo;
    Refresh;
  end;
end;

procedure TOvcCustomVirtualListbox.SetScrollBars(const Value : TScrollStyle);
  {-set use of vertical and horizontal scroll bars}
begin
  if Value <> FScrollBars then begin
    FScrollBars := Value;
    lHaveVS := (FScrollBars = ssVertical) or (FScrollBars = ssBoth);
    lHaveHS := (FScrollBars = ssHorizontal) or (FScrollBars = ssBoth);
    RecreateWnd;
  end;
end;

procedure TOvcCustomVirtualListbox.SetShowHeader(Value : Boolean);
  {-set show flag for the header}
begin
  if Value <> FShowHeader then begin
    FShowHeader := Value;
    Refresh;
  end;
end;

procedure TOvcCustomVirtualListbox.SetTabStops(Tabs : array of Integer);
  {-set tab stop positions}
var
  I : Integer;
begin
  HandleNeeded;
  lNumTabStops := High(Tabs)+1;
  if lNumTabStops > MaxTabStops then
    lNumTabStops := MaxTabStops;
  for I := 0 to Pred(lNumTabStops) do
    lTabs[I] := Tabs[I] * lDlgUnits;
end;

procedure TOvcCustomVirtualListbox.SetTopIndex(Index : LongInt);
  {-set the index of the first visible entry in the list}
var
  DY       : LongInt;
  SaveD    : LongInt;
  ClipArea : TRect;
begin
  if csDesigning in ComponentState then
    Exit;

  if Index <> FTopIndex then begin
    if (Index >= 0) and (Index <= lHighIndex) then begin
      SaveD := FTopIndex;

      {if we can't make the requested item the top one, at least show it}
      if Index + lRows -1 <= lHighIndex then
        FTopIndex := Index
      else
        FTopIndex := lHighIndex - lRows + 1;

      {check for valid index}                                          {!!.01}
      if FTopIndex < 0 then                                            {!!.01}
        FTopIndex := 0;                                                {!!.01}

      if FTopIndex = SaveD then                                        {!!.16}
        Exit;                                                          {!!.16}

      vlbSetVScrollPos;
      ClipArea := ClientRect;
      {adjust top of the clipping region to exclude the header, if any}
      if FShowHeader then with ClipArea do
        Top := Top + FRowHeight;

      {adjust bottom of the clipping region to an even number of rows}
      with ClipArea do
        Bottom := (Bottom div FRowHeight) * FRowHeight;

      DY := (SaveD - Index) * FRowHeight;
      if Abs(DY) < lRows then
        {scroll the window setting up a clipping region}
        ScrollWindow(Handle, 0, SmallInt(LOWORD(DY)), @ClipArea, @ClipArea)
      else
        InvalidateRect(Handle, @ClipArea, True);

      vlbSetFocusedIndex(FItemIndex);

      {notify that top index has changed}
      if SaveD <> FTopIndex then
        DoOnTopIndexChanged(FTopIndex);
    end;
  end;
end;

procedure TOvcCustomVirtualListbox.vlbAdjustIntegralHeight;
begin
  if (csDesigning in ComponentState) and
     not (csLoading in ComponentState) then
    if FIntegralHeight then
      if ClientHeight mod FRowHeight <> 0 then
        ClientHeight := (ClientHeight div FRowHeight) * FRowHeight;
end;

procedure TOvcCustomVirtualListbox.vlbCalcFontFields;
var
  Alpha : string;
begin
  if not HandleAllocated then
    Exit;

  Alpha := GetOrphStr(SCAlphaString);

  {set the canvas font}
  Canvas.Font := Self.Font;

  {determine the height of one row}
  if FAutoRowHeight and not (csLoading in ComponentState) then
    FRowHeight := Canvas.TextHeight(GetOrphStr(SCTallLowChars));
  lRows := (ClientHeight div FRowHeight)-Ord(FShowHeader);
  if lRows < 1 then
    lRows := 1;

  {calculate the base dialog unit for tab spacing}
  lDlgUnits := (Canvas.TextWidth(Alpha) div Length(Alpha)) div 4
end;

procedure TOvcCustomVirtualListbox.vlbClearAllItems;
  {-clear the highlight from all items}
begin
  vlbSetAllItemsPrim(False);
end;

procedure TOvcCustomVirtualListbox.vlbClearSelRange(First, Last : LongInt);
  {-clear the selection for the given range of indexes}
begin
  vlbSelectRangePrim(First, Last, False);
end;

procedure TOvcCustomVirtualListbox.vlbColorChanged(AColor: TObject);
  {-a color has changed, refresh display}
begin
  Refresh;
end;

procedure TOvcCustomVirtualListbox.vlbDrawFocusRect(Index : LongInt);
  {-draw the focus rectangle}
var
  CR : TRect;
begin
  if Index < 0 then Index := 0;
  if Focused then begin
    if (Index >= FTopIndex) and (Index-FTopIndex <= Pred(lRows)) then begin
      CR := ClientRect;
      CR.Top := (Index-FTopIndex+Ord(FShowHeader))*FRowHeight;
      CR.Bottom := CR.Top + FRowHeight;
      Canvas.DrawFocusRect(CR);
    end;
  end;
  lFocusedIndex := Index;
end;

procedure TOvcCustomVirtualListbox.vlbDragSelection(First, Last : LongInt);
  {-drag the selection}
var
  I       : LongInt;
  OutSide : Boolean;
begin
  {Multiselect option requires OnSelect and OnIsSelected to be defined}
  if (not Assigned(FOnSelect)) or (not Assigned(FOnIsSelected)) then
    Exit;

  {set new active item}
  vlbNewActiveItem(Last);

  {remove selection from visible selected items not in range}
  for I := FTopIndex to FTopIndex+Pred(lRows) do begin
    if First <= Last then
      OutSide :=  (I < First) or (I > Last)
    else
      OutSide :=  (I < Last) or (I > First);

    if DoOnIsSelected(I) and OutSide then
        InvalidateItem(I);
  end;

  {deselect all items}
  DoOnSelect(-1, False);

  {select new range}
  vlbSetSelRange(First, Last);
  vlbSetFocusedIndex(Last);
  Update;
end;

procedure TOvcCustomVirtualListbox.vlbDrawHeader;
  {-draw the header and text}
var
  R      : TRect;
  Buf    : array[0..255] of AnsiChar;
  S      : PAnsiChar;
  DX     : Integer;
begin
  {get the printable area of the header text}
  StrPCopy(Buf, FHeader);
  if lHDelta >= LongInt(StrLen(Buf)) then                              {!!.D4}
    S := ' ' {space to erase last character from header}
  else
    S := @Buf[lHDelta];

  Canvas.Font := Font;
  with Canvas do begin
    {draw header text}
    Brush.Color := FHeaderColor.BackColor;
    Font.Color := FHeaderColor.TextColor;

    R := Bounds(0, 0, Width, FRowHeight-1);

    {clear the line}
    Canvas.FillRect(R);

    if S <> nil then
      if FUseTabStops then begin
        DX := 0;
        if lHDelta > 0 then begin
          {measure portion of string to the left of the window}
          DX := LOWORD(GetTabbedTextExtent(Canvas.Handle, Buf, lHDelta,
                lNumTabStops, lTabs));
        end;
        TabbedTextOut(Canvas.Handle, 2, 0,
                      S, StrLen(S), lNumTabStops, lTabs, -DX)
      end else
        ExtTextOut(Canvas.Handle, 2, 0, ETO_OPAQUE + ETO_CLIPPED,
                   @R, S, StrLen(S), nil);

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

procedure TOvcCustomVirtualListbox.vlbExtendSelection(Index : LongInt);
  {-process Shift-LMouseBtn}
begin
  {Multiselect option requires OnSelect and OnIsSelected to be defined}
  if not FMultiSelect or (not Assigned(FOnSelect))
     or (not Assigned(FOnIsSelected)) then
    Exit;

  {verify valid index}
  if Index < 0 then
    Index := 0
  else if Index > lHighIndex then
    Index := lHighIndex;

  {clear current selections}
  vlbClearAllItems;

  {set selection for all items from the active one to the currently selected item}
  vlbSetSelRange(lAnchor, Index);

  {set new active item}
  FItemIndex := Index;
  vlbSetFocusedIndex(FItemIndex);
  Update;
end;

procedure TOvcCustomVirtualListbox.vlbHScrollPrim(Delta : Integer);
var
  SaveD : Integer;
begin
  SaveD := lHDelta;
  if Delta < 0 then
    if Abs(Delta) > lHDelta then
      lHDelta := 0
    else
      Inc(lHDelta, Delta)
  else
    if LongInt(lHDelta)+Delta > LongInt(FColumns) then
      lHDelta := FColumns
    else
      Inc(lHDelta, Delta);

  if lHDelta <> SaveD then begin
    vlbSetHScrollPos;
    Refresh;
  end;
end;

procedure TOvcCustomVirtualListbox.vlbInitScrollInfo;
  {-setup scroll bar range and initial position}
begin
  if not HandleAllocated then
    Exit;

  {initialize scroll bars, if any}
  vlbSetVScrollRange;
  vlbSetVScrollPos;
  vlbSetHScrollRange;
  vlbSetHScrollPos;
end;

procedure TOvcCustomVirtualListbox.vlbMakeItemVisible(Index : LongInt);
  {-make sure the item is visible}
begin
  if Index < FTopIndex then
    TopIndex := Index
  else if Index+LongInt($80000000) >                                   {!!.D4}
          (FTopIndex+Pred(lRows))+LongInt($80000000) then begin        {!!.D4}
    TopIndex := Index-Pred(lRows);
    if FTopIndex < 0 then
      TopIndex := 0;
  end;
end;

procedure TOvcCustomVirtualListbox.vlbNewActiveItem(Index : LongInt);
  {-set the currently selected item}
begin
  {verify valid index}
  if Index < 0 then
    Index := 0
  else if Index > lHighIndex then
    Index := lHighIndex;

  {set the newly selected item index}
  FItemIndex := Index;
  vlbMakeItemVisible(Index);
  DoOnSelect(Index, True);
  InvalidateItem(Index);
end;

function TOvcCustomVirtualListbox.vlbScaleDown(N : LongInt) : Integer;
begin
  Result := N div lDivisor;
end;

function TOvcCustomVirtualListbox.vlbScaleUp(N : LongInt) : LongInt;
begin
  Result := N * lDivisor;
end;

procedure TOvcCustomVirtualListbox.vlbSelectRangePrim(First, Last : LongInt; Select : Boolean);
  {-change the selection for the given range of indexes}
var
  I : LongInt;
begin
  if First <= Last then begin
    for I := First to Last do begin
      DoOnSelect(I, Select);
      InvalidateItem(I);
    end;
  end else begin
    for I := First downto Last do begin
      DoOnSelect(I, Select);
      InvalidateItem(I);
    end;
  end;
end;

{!!.01} {revised}
procedure TOvcCustomVirtualListbox.vlbSetAllItemsPrim(Select : Boolean);
  {-primitive routine thats acts on all items}
var
  I         : LongInt;
  LastIndex : LongInt;
begin
  {determine highest index to test}
  LastIndex := FTopIndex+Pred(lRows);
  if LastIndex > Pred(FNumItems) then
    LastIndex := Pred(FNumItems);

  {invalidate items that require repainting}
  for I := FTopIndex to LastIndex do
    if DoOnIsSelected(I) <> Select then
      InvalidateItem(I);

  {select or deselect all items}
  DoOnSelect(-1, Select);
end;

procedure TOvcCustomVirtualListbox.vlbSetFocusedIndex(Index : LongInt);
  {-set focus index to this item. invalidate previous}
begin
  if Index <> lFocusedIndex then begin
    InvalidateItem(lFocusedIndex);
    lFocusedIndex := Index;
  end;
end;

procedure TOvcCustomVirtualListbox.vlbSetHScrollPos;
begin
  if lHaveHS then
    SetScrollPos(Handle, SB_HORZ, lHDelta, True);
end;

procedure TOvcCustomVirtualListbox.vlbSetHScrollRange;
begin
  if lHaveHS then
    SetScrollRange(Handle, SB_HORZ, 0, FColumns, False);
end;

procedure TOvcCustomVirtualListbox.vlbSetSelRange(First, Last : LongInt);
  {-set the selection on for the given range of indexes}
begin
  vlbSelectRangePrim(First, Last, True);
end;

{!!.12} {revised}
procedure TOvcCustomVirtualListbox.vlbSetVScrollPos;
{$IFDEF Win32}
var
  SI : TScrollInfo;
{$ENDIF}
begin
  if not HandleAllocated then
    Exit;
{$IFDEF Win32}
  with SI do begin
    cbSize := SizeOf(SI);
    fMask := SIF_RANGE or SIF_PAGE or SIF_POS or SIF_DISABLENOSCROLL;
    nMin := 0;
    nMax := Pred(lVSHigh);
    nPage := lRows;
    nPos := vlbScaleDown(FTopIndex);
    nTrackPos := nPos;
  end;
  SetScrollInfo(Handle, SB_VERT, SI, True);
{$ELSE}
  if lHaveVS then
    SetScrollPos(Handle, SB_VERT, vlbScaleDown(FTopIndex), True);
{$ENDIF}
end;

{!!.12} {revised}
procedure TOvcCustomVirtualListbox.vlbSetVScrollRange;
var
  ItemRange : LongInt;
begin
{$IFDEF Win32}
  ItemRange := FNumItems;
  lDivisor := 1;
  if ItemRange < lRows then
    lVSHigh := 1
  else if ItemRange <= High(SmallInt) then
    lVSHigh := ItemRange
  else begin
    lDivisor := 2*(ItemRange div 32768);
    lVSHigh := ItemRange div lDivisor;
  end;
  vlbSetVScrollPos;
{$ELSE}
  ItemRange := FNumItems-lRows;
  lDivisor := 1;
  if ItemRange < lRows then
    lVSHigh := 1
  else if ItemRange <= High(SmallInt) then
    lVSHigh := ItemRange
  else begin
    lDivisor := 2*(ItemRange div 32768);
    lVSHigh := ItemRange div lDivisor;
  end;
  if lHaveVS then
    if (FNumItems > lRows) or (csDesigning in ComponentState) then
      SetScrollRange(Handle, SB_VERT, 0, lVSHigh, False)
    else
      SetScrollRange(Handle, SB_VERT, 0, 0, False);
{$ENDIF}
end;

procedure TOvcCustomVirtualListbox.vlbToggleSelection(Index : LongInt);
  {-process Ctrl-LMouseBtn}
var
  WasSelected : Boolean;
begin
  {Multiselect option requires OnSelect and OnIsSelected to be defined}
  if not FMultiSelect or (not Assigned(FOnSelect))
     or (not Assigned(FOnIsSelected)) then
    Exit;

  {toggle highligt}
  WasSelected := DoOnIsSelected(Index);
  DoOnSelect(Index, not WasSelected);
  vlbSetFocusedIndex(Index);
  DrawItem(Index);
  {set new active item}
  FItemIndex := Index;
  {and anchor point}
  lAnchor := Index;
end;

procedure TOvcCustomVirtualListbox.vlbValidateItem(Index : LongInt);
  {-validate the area for this item}
var
  CR : TRect;
begin
  if (Index >= FTopIndex) and (Index-FTopIndex < lRows) then begin  {visible?}
    CR := Rect(0, (Index-FTopIndex+Ord(FShowHeader))*FRowHeight, ClientWidth, 0);
    CR.Bottom := CR.Top+FRowHeight;
    ValidateRect(Handle, @CR);
  end;
end;

procedure TOvcCustomVirtualListbox.vlbVScrollPrim(Delta : Integer);
var
  I : LongInt;
begin
  I := FTopIndex+Delta;
  if I < 0 then
    if Delta > 0 then
      I := lHighIndex
    else
      I := 0
  else if (I > lHighIndex-Pred(lRows)) then begin
    if lHighIndex > Pred(lRows) then
      I := lHighIndex-Pred(lRows)
    else
      I := 0;
  end;

  SetTopIndex(I);
end;

procedure TOvcCustomVirtualListbox.WMChar(var Msg : TWMChar);
var
  L : LongInt;
begin
  inherited;

  L := DoOnCharToItem(AnsiChar(Msg.CharCode));
  if (L >= 0) and (L <= lHighIndex) then
    SetItemIndex(L);
end;

procedure TOvcCustomVirtualListbox.WMEraseBkgnd(var Msg : TWMEraseBkGnd);
begin
  {indicate that we have processed this message}
  Msg.Result := 1;
end;

procedure TOvcCustomVirtualListbox.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;

  Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS;
end;

procedure TOvcCustomVirtualListbox.WMHScroll(var Msg : TWMHScroll);
begin
  case Msg.ScrollCode of
    SB_LINERIGHT : vlbHScrollPrim(+1);
    SB_LINELEFT  : vlbHScrollPrim(-1);
    SB_PAGERIGHT : vlbHScrollPrim(+10);
    SB_PAGELEFT  : vlbHScrollPrim(-10);
    SB_THUMBPOSITION, SB_THUMBTRACK :
      if lHDelta <> Msg.Pos then begin
        lHDelta := Msg.Pos;
        vlbSetHScrollPos;
        Refresh;
      end;
  end;
end;

procedure TOvcCustomVirtualListbox.WMKeyDown(var Msg : TWMKeyDown);
var
  I   : LongInt;
  Cmd : Word;
begin
  inherited;

  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  if Cmd <> ccNone then begin

    {filter invalid commands}                                          {!!.10}
    case Cmd of                                                        {!!.10}
      ccExtendHome, ccExtendEnd, ccExtendPgUp,                         {!!.10}
      ccExtendPgDn, ccExtendUp, ccExtendDown :                         {!!.10}
        if not FMultiSelect or (not Assigned(FOnSelect))               {!!.10}
         or (not Assigned(FOnIsSelected)) then                         {!!.10}
          Exit;                                                        {!!.10}
    end;                                                               {!!.10}

    case Cmd of
      ccLeft :
        if lHaveHs then begin
          if lHDelta > 0 then begin
            Dec(lHDelta);
            vlbSetHScrollPos;
            Refresh;
          end;
        end else begin
          if FItemIndex > 0 then begin
            vlbClearAllItems;
            SetItemIndex(FItemIndex-1);
            lAnchor := FItemIndex;
          end;
        end;
      ccRight :
        if lHaveHs then begin
          if lHDelta < FColumns then begin
            Inc(lHDelta);
            vlbSetHScrollPos;
            Refresh;
          end;
        end else begin
          if FItemIndex < lHighIndex then begin
            vlbClearAllItems;
            SetItemIndex(FItemIndex+1);
            lAnchor := FItemIndex;
          end;
        end;
      ccUp :
        if FItemIndex > 0 then begin
          vlbClearAllItems;
          SetItemIndex(FItemIndex-1);
          lAnchor := FItemIndex;
        end;
      ccDown :
        if FItemIndex < lHighIndex then begin
          vlbClearAllItems;
          SetItemIndex(FItemIndex+1);
          lAnchor := FItemIndex;
        end;
      ccHome :
        if FItemIndex <> 0 then begin
          vlbClearAllItems;                                            {!!.13}
          SetItemIndex(0);
          lAnchor := FItemIndex;
        end;
      ccEnd :
        if (FNumItems > 0) and (FItemIndex <> lHighIndex) then begin
          vlbClearAllItems;
          SetItemIndex(lHighIndex);
          lAnchor := FItemIndex;
        end;
      ccPrevPage :
        if FNumItems > 0 then begin
          if lRows = 1 then
            I := Pred(FItemIndex)
          else
            I := FItemIndex-Pred(lRows);
          if I < 0 then
            I := 0;
          if I <> FItemIndex then begin
            vlbClearAllItems;
            SetItemIndex(I);
            lAnchor := FItemIndex;
          end;
        end;
      ccNextPage :
        if FNumItems > 0 then begin
          if lRows = 1 then begin
            if FItemIndex < lHighIndex then
              I := Succ(FItemIndex)
            else
              I := lHighIndex;
          end else if FItemIndex <= lHighIndex-Pred(lRows) then
            I := FItemIndex+Pred(lRows)
          else
            I := lHighIndex;
          if I <> FItemIndex then begin
            vlbClearAllItems;
            SetItemIndex(I);
            lAnchor := FItemIndex;
          end;
        end;
      ccExtendHome :
        if FItemIndex > 0 then begin
          vlbNewActiveItem(0);
          vlbExtendSelection(0);
        end;
      ccExtendEnd :
        if FItemIndex < lHighIndex then begin
          vlbNewActiveItem(lHighIndex);
          vlbExtendSelection(lHighIndex);
        end;
      ccExtendPgUp :
       begin
          I := FItemIndex-Pred(lRows);
          vlbNewActiveItem(I);
          vlbExtendSelection(I);
       end;
      ccExtendPgDn :
        begin
          I := FItemIndex+Pred(lRows);
          vlbNewActiveItem(I);
          vlbExtendSelection(I);
        end;
      ccExtendUp :
        begin
          I := FItemIndex-1;
          vlbNewActiveItem(I);
          vlbExtendSelection(I);
        end;
      ccExtendDown :
        begin
          I := FItemIndex+1;
          vlbNewActiveItem(I);
          vlbExtendSelection(I);
        end;
    else
      {do user command notification for user commands}
      if Cmd >= ccUserFirst then
        DoOnUserCommand(Cmd);
    end;

    {indicate that this message was processed}
    Msg.Result := 0;
  end;
end;

procedure TOvcCustomVirtualListbox.WMKillFocus(var Msg : TWMKillFocus);
begin
  inherited;

  {re-draw focused item to erase focus rect}
  DrawItem(lFocusedIndex);
end;

procedure TOvcCustomVirtualListbox.WMLButtonDown(var Msg : TWMLButtonDown);
var
  I            : LongInt;
  LastI        : LongInt;
  LButton      : Byte;
  CtrlKeyDown  : Boolean;
  ShiftKeyDown : Boolean;

  function PointToIndex : LongInt;
  var
    Pt           : TPoint;
  begin
    GetCursorPos(Pt);
    Pt := ScreenToClient(Pt);
    if Pt.Y < Ord(FShowHeader)*FRowHeight then begin
      {speed up as the cursor moves farther away}
      Result := FTopIndex+(Pt.Y div FRowHeight)-1;
      if Result < 0 then
        Result := 0;
    end else if Pt.Y >= ClientHeight then begin
      {speed up as the cursor moves farther away}
      Result := FTopIndex+(Pt.Y div FRowHeight);
      if Result > lHighIndex then
        Result := lHighIndex;
    end else begin
      {convert to an index}
      Result := FTopIndex-Ord(FShowHeader)+(Pt.Y div FRowHeight);
      if ClientHeight mod FRowHeight > 0 then
        if Result > FTopIndex-1{Ord(FShowHeader)}+lRows then
          Result := FTopIndex-1{Ord(FShowHeader)}+lRows;
    end;
  end;

begin
  inherited;

  {!!.01} {added}
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

  if (FNumItems <> 0) then begin
    {get the actual left button}
    LButton := GetLeftButton;

    {get the key state}
    if FMultiSelect then begin
      CtrlKeyDown := GetKeyState(VK_CONTROL) and $8000 <> 0;
      ShiftKeyDown := GetKeyState(VK_SHIFT) and $8000 <> 0;
    end else begin
      CtrlKeyDown := False;
      ShiftKeyDown := False;
    end;

    if CtrlKeyDown then
      vlbToggleSelection(PointToIndex)
    else if ShiftKeyDown then
      vlbExtendSelection(PointToIndex)
    else begin
      vlbClearAllItems;

      {reselect the active item}
      DoOnSelect(FItemIndex, True);
      vlbSetFocusedIndex(FItemIndex);

      {watch the mouse position while the left button is down}
      LastI := -1;
      repeat
        I := PointToIndex;
        if I <= lHighIndex then
          if not FMultiSelect or (LastI = -1) then begin
            SetItemIndex(I);
            lAnchor := I;
            LastI := I;
          end else begin
            {extend/shrink the selection to follow the mouse}
            if I <> LastI then begin
              vlbDragSelection(lAnchor, I);
              LastI := I;
            end;
          end;
        Application.ProcessMessages;  {Gasp}
      until (GetAsyncKeyState(LButton) and $8000 = 0) or Dragging      {!!.13}
            or (GetCapture <> Handle);                                 {!!.13}

    end;
  end;
end;

procedure TOvcCustomVirtualListbox.WMLButtonDblClk(var Msg : TWMLButtonDblClk);
begin
  {is this click below the header, if any}
  if (Msg.YPos > FRowHeight * Ord(FShowHeader)) then
    inherited
  else
    {say we processed this message}
    Msg.Result := 0;
end;

{!!.01} {revised}
procedure TOvcCustomVirtualListbox.WMMouseActivate(var Msg : TWMMouseActivate);
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

procedure TOvcCustomVirtualListbox.WMSetFocus(var Msg : TWMSetFocus);
begin
  inherited;

  Update;
  DrawItem(lFocusedIndex);
end;

procedure TOvcCustomVirtualListbox.WMSize(var Msg : TWMSize);
begin
  if FRowHeight > 0 then begin
    {integral font height adjustment}
    vlbCalcFontFields;
    vlbAdjustIntegralHeight;
    vlbCalcFontFields;
    vlbInitScrollInfo;

    {reposition so that items are displayed at bottom of list}
    if lRows + FTopIndex - 1 >= FNumItems then
      if NumItems-lRows >= 0 then
        TopIndex := NumItems-lRows
      else
        TopIndex := 0;
  end;

  inherited;
end;

procedure TOvcCustomVirtualListbox.WMVScroll(var Msg : TWMVScroll);
var
  I : LongInt;
begin
  case Msg.ScrollCode of
    SB_LINEUP   : vlbVScrollPrim(-1);
    SB_LINEDOWN : vlbVScrollPrim(+1);
    SB_PAGEDOWN : vlbVScrollPrim(+Pred(lRows));
    SB_PAGEUP   : vlbVScrollPrim(-Pred(lRows));
    SB_THUMBPOSITION, SB_THUMBTRACK :
      begin
        if Msg.Pos = 0 then
          I := 0
        else if Msg.Pos = lVSHigh then
          if lRows >= FNumItems then
            I := 0
          else
            I := lHighIndex-Pred(lRows)
        else
          I := vlbScaleUp(Msg.Pos);
        SetTopIndex(I);
      end;
  end;
end;



end.