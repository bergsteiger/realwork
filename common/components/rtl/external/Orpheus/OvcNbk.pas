{*********************************************************}
{*                   OVCNBK.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFDEF Win32}
 {$H+} {Huge strings}
{$ENDIF}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit OvcNbk;
  {-Notebook component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Buttons, Classes, Controls, Forms, Graphics,
  Menus, Messages, SysUtils, StdCtrls,
  OvcBase, OvcCmd, OvcConst, OvcData, OvcExcpt, OvcMisc;

type
  TTabOrientation = (toTop, toRight);

const
  nbDefColor             = clBtnFace;
  nbDefConserveResources = False;
  nbDefCtl3D             = False;
  nbDefEchoPageHint      = False;
  nbDefEchoPageHelp      = False;
  nbDefHeight            = 185;
  nbDefHighlightColor    = clBtnHighlight;
  nbDefHitWidth          = 6;
  nbDefLeftMargin        = 4;
  nbDefMinTabWidth       = 20;
  nbDefPageIndex         = 0;
  nbDefParentColor       = False;
  nbDefParentCtl3D       = False;
  nbDefShadowColor       = clBtnShadow;
  nbDefShadowedText      = False;
  nbDefStyle             = bsAutoDetect;
  nbDefTabAutoHeight     = True;
  nbDefTabHeight         = 20;
  nbDefTabIndent         = 8;
  nbDefTabStop           = True;
  nbDefTabTextColor      = clBtnText;
  nbDefTabWidth          = 65;
  nbDefTabOrientation    = toTop;
  nbDefTabRowCount       = 0;
  nbDefTextShadowColor   = clBtnShadow;
  nbDefTopMargin         = 2;
  nbDefWidth             = 220;

type
  {event types}
  TDrawTabEvent =
    procedure(Sender : TObject; Index : Integer; const Title : AnsiString;
              R : TRect; Enabled, Active : Boolean)
    of object;
  {event generated when drawing the tab text}
  TMouseOverTabEvent =
    procedure(Sender : TObject; Index : Integer)
    of object;
  {event generated when the mouse passes over a tab}
  TPageChangeEvent =
    procedure(Sender : TObject; Index : Integer; var AllowChange : Boolean)
    of object;
  {event generated when the tab is about to be changed}
  TPageChangedEvent =
    procedure(Sender : TObject; Index : Integer)
    of object;
  {event generated after a new tab has been selected}
  TTabClickEvent =
    procedure(Sender : TObject; Index : Integer)
    of object;
  {event generated when a tab is clicked with the left mouse button}

type
  {forward declaration for folder tab pages}
  TOvcNotebookPage = class;

  TOvcNotebook = class(TOvcBase)
  {.Z+}
  protected {private}
    {property varialbes}
    FActiveTabFont     : TFont;        {font for the active tab}
    FConserveResources : Boolean;      {if true, non visual page handles are destroyed}
    FDefaultPageIndex  : Integer;      {page to display when first created}
    FEchoPageHelp      : Boolean;      {echo page help to notebook}
    FEchoPageHint      : Boolean;      {echo page hint to notebook}
    FHighlightColor    : TColor;       {color for border highlight}
    FPageAccess        : TStrings;     {allows acces to tab pages and info}
    FPageIndex         : Integer;      {current notebook page index}
    FShadowColor       : TColor;       {color for tab shadow}
    FShadowedText      : Boolean;      {true to draw shadowed tab text}
    FStyle             : TButtonStyle; {determines how tabs and pages look}
    FTabAutoHeight     : Boolean;      {true to enable height auto adjust}
    FTabHeight         : LongInt;      {the height of each tab}
    FTabIndent         : LongInt;      {pixels to indent each tab row}
    FTabOrientation    : TTabOrientation;
    FTabRowCount       : Integer;      {number of tab rows. 0=autocalc}
    FTabWidth          : LongInt;      {width of notebook tabs}
    FTextShadowColor   : TColor;       {color for text shadowing}
    FAutoTabSize       : Boolean;      {V}

    {event variables}
    FOnDrawTab         : TDrawTabEvent;
    FOnMouseOverTab    : TMouseOverTabEvent;
    FOnPageChange      : TPageChangeEvent;
    FOnPageChanged     : TPageChangedEvent;
    FOnTabClick        : TTabClickEvent;
    FOnUserCommand     : TUserCommandEvent;

    {internal variables}
    nbTabChange   : Boolean;    {flag to indicate the tab is changing}
    nbFocusedRow  : Integer;    {index of the row containing the active tab}
    nbHitTest     : TPoint;     {location of mouse cursor}
    nbLastRow     : Integer;    {the last row index -- nbTotalRows-1}
    nbOverTab     : Boolean;    {true if the mouse os over a tab}
    nbResizeWidth : Boolean;    {true if resizing tab widths}
    nbResizeIndent: Boolean;    {true if resizing tab indents}
    nbPageList    : TList;      {list of TOvcNotebookPage objects}
    nbTabChanging : Boolean;    {flag to indicate the tab is changing} {!!.16}
    nbTabCursor   : HCursor;    {design-time tab slecting cursor handle}
    nbTabSelecting: Boolean;    {true while moving through tabs}
    nbTabsPerRow  : LongInt;    {number of tabs per row}
    nbTotalRows   : LongInt;    {total count of tab rows}
    nbBldWidthsNeed : Boolean;  {V}

    {property methods}
    function GetActivePageName : AnsiString;
    function GetClientHeight : Integer;
    function GetClientWidth : Integer;
    function GetPageEnabled : Boolean;
    function GetPageHelpContext : THelpContext;
    function GetPageHelpContexts(Index : Integer) : THelpContext;
    function GetPageHint : AnsiString;
    function GetPageHints(Index : Integer) : AnsiString;
    function GetPageName : AnsiString;
    function GetPageNames(Index : Integer) : AnsiString;
    function GetPageObjects(Index : Integer) : TOvcNotebookPage;
    function GetPagesEnabled(Index : Integer) : Boolean;
    function GetPagesVisible(Index : Integer) : Boolean;
    function GetTabOrientation : TTabOrientation;
    function GetTabTextColor : TColor;
    function GetTabsTextColor(Index : Integer) : TColor;
    procedure SetActivePageName(const Value : AnsiString);
    procedure SetActiveTabFont(Value : TFont);
    procedure SetConserveResources(Value : Boolean);
    procedure SetDefaultPageIndex(Value : Integer);
    procedure SetHighlightColor(const Value : TColor);
    procedure SetPageEnabled(Value : Boolean);
    procedure SetPageHelpContext(Value : THelpContext);
    procedure SetPageHelpContexts(Index : Integer; Value : THelpContext);
    procedure SetPageHint(const Value : AnsiString);
    procedure SetPageHints(Index : Integer; const Value : AnsiString);
    procedure SetPageIndex(Value : Integer);
    procedure SetPageName(const Value : AnsiString);
    procedure SetPageNames(Index : Integer; const Value : AnsiString);
    procedure SetPages(Strings : TStrings);
    procedure SetPagesEnabled(Index : Integer; Value : Boolean);
    procedure SetPagesVisible(Index : Integer; Value : Boolean);
    procedure SetShadowColor(const Value : TColor);
    procedure SetShadowedText(Value : Boolean);
    procedure SetStyle(Value : TButtonStyle);
    procedure SetTabAutoHeight(Value : Boolean);
    procedure SetTabHeight(Value : LongInt);
    procedure SetTabIndent(Value : LongInt);
    procedure SetTabOrientation(Value : TTabOrientation);
    procedure SetTabRowCount(Value : Integer);
    procedure SetTabsTextColor(Index : Integer; Value : TColor);
    procedure SetTabTextColor(Value : TColor);
    procedure SetTabWidth(Value : LongInt);
    procedure SetTextShadowColor(const Value : TColor);

    {internal methods}
    procedure nbAdjustPageSize;
    procedure nbCalcTabInfo;
    procedure nbDoRefresh;
    procedure nbDrawFocusRect(Index : Integer);
    procedure nbFontChanged(Sender : TObject);
    function nbGetTabRect(Index : Integer) : TRect;
    procedure nbInvalidateTab(Index : Integer);
    function nbIsValidIndex(Index : Integer) : Boolean;
    function nbNextValidIndex(Index : Integer) : Integer;
    procedure nbPaintTopTabs;
    procedure nbPaintRightTabs;
    function nbPrevValidIndex(Index : Integer) : Integer;

    {VCL control methods}
    procedure CMDesignHitTest(var Msg : TCMDesignHitTest);
      message CM_DESIGNHITTEST;
    procedure CMDialogChar(var Msg : TCMDialogChar);
      message CM_DIALOGCHAR;
    procedure CMFontChanged(var Msg : TMessage);
      message CM_FONTCHANGED;
    procedure CMParentColorChanged(var Msg : TMessage);
      message CM_PARENTCOLORCHANGED;
    procedure CMShowHintChanged(var Msg : TMessage);
      message CM_SHOWHINTCHANGED;

    {message response methods}
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;
    procedure WMSetCursor(var Msg : TWMSetCursor);
      message WM_SETCURSOR;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;

  protected
    procedure ChangeScale(M, D : Integer);
      override;
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;
    {$IFDEF Win32}
    function GetChildOwner : TComponent;
      override;
    procedure GetChildren(Proc : TGetChildProc
              {$IFDEF VERSION3}; Root : TComponent {$ENDIF});
      override;
    {$ENDIF}
    procedure Loaded;
      override;
    procedure Paint;
      override;
    procedure ReadState(Reader : TReader);
      override;
    procedure ShowControl(AControl : TControl);
      override;
    {$IFNDEF Win32}
    procedure WriteComponents(Writer : TWriter);
      override;
    {$ENDIF}

    {dynamic event handlers}
    function DoOnDrawTab(Index : Integer; const Title : AnsiString;
             Enabled, Active : Boolean) : Boolean;
      dynamic;
      {-fire the OnDrawTab event if assigned}
    procedure DoOnMouseOverTab(Index : Integer);
      dynamic;
      {-fire the OnMouseOverTab event if assigned}
    procedure DoOnPageChange(Index : Integer; var AllowChange : Boolean);
      dynamic;
      {-fire the OnPageChange event if assigned}
    procedure DoOnPageChanged(Index : Integer);
      dynamic;
      {-fire the OnPageChanged event if assigned}
    procedure DoOnTabClick(Index : Integer);
      dynamic;
      {-fire the OnTabClick event if assigned}
    procedure DoOnUserCommand(Command : Word);
      dynamic;
      {-perform notification of a user command}

    {vcl methods}
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
      override;
    procedure MouseMove(Shift : TShiftState; X, Y: Integer);
      override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
      override;

    function PageChangeAccelCheck(var Msg : TwmKey) : boolean;

    function ItemAtPos(aPt : TPoint) : integer;
  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight : Integer);       {!!.D4}
      override;
  {.Z-}

    procedure BeginUpdate;                                             {!!.11}
      {-suspend window updates}
    procedure EndUpdate;                                               {!!.11}
      {-allow window updates}
    function GetTabRect(Index : Integer) : TRect;
      {-return the area of the specified tab}
    procedure DeletePage(Index : Integer);
      {-delete the specified notebook page}
    function InsertPage(const Name : AnsiString;
                        Index : Integer) : TOvcNotebookPage;
      {-insert a notebook page at the specified location}
    procedure InvalidateTab(Index : Integer);
      {-invalidate the specified tab}
    function IsValid(Index : Integer) : Boolean;
      {-return true if the Index tab is valid}
    procedure NextPage;
      {-display the next valid notebook page}
    procedure PrevPage;
      {-display the previous valid notebook page}
    function PageNameToIndex(const Name : AnsiString) : Integer;
      {-return page index given the page name}

    function MousePointToIndex : integer;

    property Canvas;

    property ClientHeight : Integer
      read GetClientHeight;

    property ClientWidth : Integer
      read GetClientWidth;

    property PageHelpContexts[Index : Integer] : THelpContext
      read GetPageHelpContexts
      write SetPageHelpContexts;

    property PageHints[Index : Integer] : AnsiString
      read GetPageHints
      write SetPageHints;

    property PageNames[Index : Integer] : AnsiString
      read GetPageNames
      write SetPageNames;

    property PageObjects[Index : Integer] : TOvcNotebookPage
      read GetPageObjects;

    property PagesEnabled[Index : Integer] : Boolean
      read GetPagesEnabled
      write SetPagesEnabled;

    property PagesVisible[Index : Integer] : Boolean
      read GetPagesVisible
      write SetPagesVisible;

    property TabsTextColor[Index : Integer] : TColor
      read GetTabsTextColor
      write SetTabsTextColor;

    property PageList : TList Read nbPageList;  {V}

  published
    property ActivePageName : AnsiString
      read GetActivePageName
      write SetActivePageName
      stored False;

    property ActiveTabFont : TFont
      read FActiveTabFont
      write SetActiveTabFont;

    property ConserveResources : Boolean
      read FConserveResources
      write SetConserveResources;

    property DefaultPageIndex : Integer
      read FDefaultPageIndex
      write SetDefaultPageIndex
      default nbDefPageIndex;

    property EchoPageHelp : Boolean
      read FEchoPageHelp
      write FEchoPageHelp
      default nbDefEchoPageHelp;

    property EchoPageHint : Boolean
      read FEchoPageHint
      write FEchoPageHint
      default nbDefEchoPageHint;

    property HighlightColor : TColor
      read FHighlightColor
      write SetHighlightColor
      default nbDefHighlightColor;

  {.Z+}
    property PageEnabled : Boolean
      read GetPageEnabled
      write SetPageEnabled
      stored False;

    property PageHelpContext : THelpContext
      read GetPageHelpContext
      write SetPageHelpContext;

    property PageHint : AnsiString
      read GetPageHint
      write SetPageHint;
  {.Z-}

    property PageIndex : Integer
      read FPageIndex
      write SetPageIndex
      stored False;

    property PageName : AnsiString
      read GetPageName
      write SetPageName
      stored False;

    property Pages : TStrings
      read FPageAccess
      write SetPages
      stored False;

    property ShadowColor : TColor
      read FShadowColor
      write SetShadowColor
      default nbDefShadowColor;

    property ShadowedText : Boolean
      read FShadowedText
      write SetShadowedText
      default nbDefShadowedText;

    property Style : TButtonStyle
      read FStyle
      write SetStyle
      default nbDefStyle;

    property TabAutoHeight : Boolean
      read FTabAutoHeight
      write SetTabAutoHeight
      default nbDefTabAutoHeight;

    property TabHeight : LongInt
      read FTabHeight
      write SetTabHeight
      default nbDefTabHeight;

    property TabIndent : LongInt
      read FTabIndent
      write SetTabIndent
      default nbDefTabIndent;

    property TabOrientation : TTabOrientation
      read GetTabOrientation
      write SetTabOrientation
      default nbDefTabOrientation;

    property TabRowCount : Integer
      read FTabRowCount
      write SetTabRowCount
      default nbDefTabRowCount;

  {.Z+}
    property TabTextColor : TColor
      read GetTabTextColor
      write SetTabTextColor
      stored False;
  {.Z-}

    property TabWidth : LongInt
      read FTabWidth
      write SetTabWidth
      default nbDefTabWidth;

    property TextShadowColor : TColor
      read FTextShadowColor
      write SetTextShadowColor
      default nbDefTextShadowColor;

    {event properties}
    property OnDrawTab : TDrawTabEvent
      read FOnDrawTab
      write FOnDrawTab;

    property OnMouseOverTab : TMouseOverTabEvent
      read FOnMouseOverTab
      write FOnMouseOverTab;

    property OnPageChange : TPageChangeEvent
      read FOnPageChange
      write FOnPageChange;

    property OnPageChanged : TPageChangedEvent
      read FOnPageChanged
      write FOnPageChanged;

    property OnTabClick : TTabClickEvent
      read FOnTabClick
      write FOnTabClick;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

    property AutoTabSize   : Boolean            {V}
      read FAutoTabSize
      write FAutoTabSize;


    {inherited properties}
    property Align;
    property Controller;
    property Color default nbDefColor;
    property Ctl3D default nbDefCtl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default nbDefTabStop;
    property Visible;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
    property OnClick;
    {property OnDblClick;}                                             {!!.17}
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

  {invisible page control to act as parent for other components}
  TOvcNotebookPage = class(TWinControl)
  {.Z+}
  protected {private}
    FArea            : TRect;    {tab dimensions}
    FRow             : Integer;  {row this tab is in}
    FPageEnabled     : Boolean;  {true if tab not disabled}
    FTabTextColor    : TColor;   {text color for tab text}
    FTabVisible      : Boolean;  {true if tab is to be shown}

    procedure CMParentShowHintChanged(var Msg : TMessage);
      message CM_PARENTSHOWHINTCHANGED;
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;

  protected
    procedure ReadState(Reader : TReader);
      override;
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;

    property Area : TRect
      read FArea
      write FArea
      stored False;

  published
    property PageEnabled : Boolean
      read FPageEnabled
      write FPageEnabled
      default True;

    property Row : Integer
      read FRow
      write FRow
      stored False;

    property TabTextColor : TColor
      read FTabTextColor
      write FTabTextColor
      default nbDefTabTextColor;

    property TabVisible : Boolean
      read FTabVisible
      write FTabVisible
      default True;

    property Caption;
    property Height stored False;
    property Left stored False;
    property TabOrder stored False;
    property Top stored False;
    property Visible stored False;
    property Width stored False;
  end;

type
  TPageAccess = class(TStrings)
  {.Z+}
  protected {private}
    paPageList  : TList;
    paNotebook  : TOvcNotebook;

  protected
    function GetCount : Integer;
      override;
    function Get(Index : Integer) : String;
      override;
    procedure Put(Index : Integer; const S : String);
      override;
    function GetObject(Index : Integer) : TObject;
      override;
    procedure SetUpdateState(Updating : Boolean);
      override;
  {.Z-}

  public
    constructor Create(APageList : TList; ANotebook : TOvcNotebook);
    procedure Clear;
      override;
    procedure Delete(Index : Integer);
      override;
    procedure Insert(Index : Integer; const S : String);
      override;
    procedure Move(CurIndex, NewIndex : Integer);
      override;
    procedure Exchange(Index1, Index2 : Integer);
      override;
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


type
  {provide access to protected TControl methods and properties}
  TLocalControl = class(TControl);


Function Max(V1, V2 : Longint) : Longint;
 Begin
  If V1 > V2
   then Result := V1
   else Result := V2;
 end;
  

{*** TPageAccess ***}

procedure TPageAccess.Clear;
var
  I: Integer;
begin
  for I := 0 to paPageList.Count - 1 do
    TOvcNotebookPage(paPageList[I]).Free;
  paPageList.Clear;
end;

constructor TPageAccess.Create(APageList : TList; ANotebook : TOvcNotebook);
begin
  inherited Create;
  paPageList := APageList;
  paNotebook := ANotebook;
end;

procedure TPageAccess.Delete(Index : Integer);
begin
  TOvcNotebookPage(paPageList[Index]).Free;
  paPageList.Delete(Index);
  {paNoteBook.PageIndex := 0;}                                         {!!.01}
end;

procedure TPageAccess.Exchange(Index1, Index2 : Integer);
begin
  Move(Index1, Index2);
end;

function TPageAccess.Get(Index : Integer): String;
begin
  Result := TOvcNotebookPage(paPageList[Index]).Caption;
end;

function TPageAccess.GetCount : Integer;
begin
  Result := paPageList.Count;
end;

function TPageAccess.GetObject(Index : Integer) : TObject;
begin
  Result := paPageList[Index];
end;

procedure TPageAccess.Insert(Index : Integer; const S : String);
var
  Page : TOvcNotebookPage;
begin
  Page := TOvcNotebookPage.Create(paNotebook);
  with Page do begin
    Parent := paNotebook;
    Caption := S;
  end;
  paPageList.Insert(Index, Page);
end;

procedure TPageAccess.Move(CurIndex, NewIndex : Integer);
var
  AObject : TObject;
begin
  if CurIndex <> NewIndex then begin
    AObject := paPageList[CurIndex];
    paPageList[CurIndex] := paPageList[NewIndex];
    paPageList[NewIndex] := AObject;
  end;
end;

procedure TPageAccess.Put(Index : Integer; const S : String);
begin
  TOvcNotebookPage(paPageList[Index]).Caption := S;
  paNotebook.nbInvalidateTab(Index);
end;

procedure TPageAccess.SetUpdateState(Updating : Boolean);
begin
  {ovridden, but do nothing}
end;


{*** TOvcNotebookPage ***}

constructor TOvcNotebookPage.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle +
    [csFramed, csAcceptsControls, csCaptureMouse, csClickEvents];

  FPageEnabled   := True;
  FTabTextColor  := nbDefTabTextColor;
  FTabVisible    := True;
  Visible        := False;

  Ctl3D          := False;
  ParentCtl3D    := True;

  ShowHint       := (Owner as TOvcNotebook).ShowHint;
  ParentShowHint := (Owner as TOvcNotebook).ParentShowHint;
end;

procedure TOvcNotebookPage.ReadState(Reader : TReader);
{$IFNDEF Win32}
var
  OldOwner : TComponent;
{$ENDIF}
begin
  if Reader.Parent is TOvcNotebook then
    TOvcNotebook(Reader.Parent).nbPageList.Add(Self);

  {$IFDEF Win32}
  inherited ReadState(Reader);
  {$ELSE}

  {change reader so the parent form is the owner of the contained controls}
  OldOwner := Reader.Owner;
  Reader.Owner := Reader.Root;
  try
    inherited ReadState(Reader);
  finally
    Reader.Owner := OldOwner;
  end;
  {$ENDIF}
end;

procedure TOvcNotebookPage.CMParentShowHintChanged(var Msg : TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ParentShowHint := (Owner as TOvcNotebook).ParentShowHint;
end;

procedure TOvcNotebookPage.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  if not (csDesigning in ComponentState) then
    Msg.Result := HTTRANSPARENT
  else
    inherited;
end;


{*** TOvcNotebook ***}

{!!.11}
procedure TOvcNotebook.BeginUpdate;
  {-suspend window updates}
begin
  Perform(WM_SETREDRAW, 0, 0);
end;

procedure TOvcNotebook.CMDesignHitTest(var Msg : TCMDesignHitTest);
begin
  Msg.Result := LongInt(nbResizeWidth or nbResizeIndent or nbOverTab);
end;

procedure TOvcNotebook.CMDialogChar(var Msg : TCMDialogChar);
 begin
  if not PageChangeAccelCheck(Msg) then
    inherited
  else
    Msg.Result := 1;
 end;

function TOvcNotebook.PageChangeAccelCheck(var Msg : TwmKey) : boolean;
var
  Idx, I      : Integer;
  TP          : TOvcNotebookPage;
  C           : TWinControl;
  lShiftState : TShiftState;
begin
  Result := False;
  lShiftState := KeyDataToShiftState(Msg.KeyData);

  if Enabled and (ssShift in lShiftState) then begin
    {remember where to stop}
    Idx := PageIndex;
    I := Idx;

    if {(Focused or Windows.IsChild(Handle, Windows.GetFocus)) and}
       (Msg.CharCode = VK_TAB) and (ssCtrl in lShiftState) then
    begin
     If ssShift in lShiftState then
      PrevPage
     else
      NextPage;
    end
    else
     If (ssShift in lShiftState) then
      repeat
        Inc(I);
        if I > nbPageList.Count-1 then
          I := 0;
        TP := TOvcNotebookPage(nbPageList[I]);
        if ISAccel(Msg.CharCode, TP.Caption) then begin
          if nbIsValidIndex(I) and CanFocus then begin
            Result := True;

            {if were already on the selected page, give tab focus}
            if I = PageIndex then
              SetFocus
            else begin {otherwise, change to it}
              PageIndex := I;

              {move focus to first control on the page}
              C := TOvcNotebookPage(nbPageList[PageIndex]).
                     FindNextControl(nil, True, True, False);            {!!.12}
              if Assigned(C) then
                C.SetFocus
              else  {set the focus to the tab}
                SetFocus;

              if PageIndex = I then                                      {!!.13}
                DoOnTabClick(I);                                         {!!.13}
            end;
            Break;
          end;
          Break;
        end;
      until I = Idx;
  end;
end;

procedure TOvcNotebook.CMFontChanged(var Msg : TMessage);
var
  TM : TTextMetric;
begin
  inherited;
  nbBldWidthsNeed := True;  {V}

  if csLoading in ComponentState then
    Exit;

  if not HandleAllocated then
    Exit;

  {check if the new font can be rotated}
  if FTabOrientation = toRight then begin
    {test primary tab font}
    Canvas.Font := Self.Font;
    GetTextMetrics(Canvas.Handle, TM);
    if (TM.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then begin
      {force "Courier New" font}
      Font.Name := 'Courier New';
      raise EInvalidTabFont.Create;
    end;

    {test active tab font}
    Canvas.Font := ActiveTabFont;
    GetTextMetrics(Canvas.Handle, TM);
    if (TM.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then begin
      {force "Courier New" font}
      ActiveTabFont.Name := 'Courier New';
      raise EInvalidTabFont.Create;
    end;

  end;

  {redraw the notebook}
  Refresh;
end;

procedure TOvcNotebook.CMParentColorChanged(var Msg : TMessage);
begin
  inherited;

  if csLoading in ComponentState then
    Exit;

  {redraw the notebook}
  Refresh;
end;

procedure TOvcNotebook.CMShowHintChanged(var Msg : TMessage);
var
  I : Integer;
begin
  inherited;

  if csLoading in ComponentState then
    Exit;

  for I := 0 to nbPageList.Count - 1 do
    TOvcNotebookPage(nbPageList[I]).ShowHint := ShowHint;
end;

constructor TOvcNotebook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csOpaque];

  nbPageList              := TList.Create;
  nbTabSelecting          := False;

  {create font for the active tab and set the default}
  FActiveTabFont          := TFont.Create;
  {default to courier new}
  FActiveTabFont.Name     := 'Courier New';
  FActiveTabFont.Style    := [fsBold];
  FActiveTabFont.OnChange := nbFontChanged;

  FConserveResources      := nbDefConserveResources;
  FDefaultPageIndex       := nbDefPageIndex;
  FEchoPageHelp           := nbDefEchoPageHelp;
  FEchoPageHint           := nbDefEchoPageHint;
  FHighlightColor         := nbDefHighlightColor;
  FPageAccess             := TPageAccess.Create(nbPageList, Self);
  FPageIndex              := nbDefPageIndex;
  FShadowColor            := nbDefShadowColor;
  FShadowedText           := nbDefShadowedText;
  FTabAutoHeight          := nbDefTabAutoHeight;
  FTabHeight              := nbDefTabHeight;
  FTabIndent              := nbDefTabIndent;
  FTabRowcount            := nbDefTabRowCount;
  FTabWidth               := nbDefTabWidth;
  FTextShadowColor        := nbDefTextShadowColor;

  Color                   := nbDefColor;
  Ctl3D                   := nbDefCtl3D;
  Height                  := nbDefHeight;
  ParentColor             := nbDefParentColor;
  ParentCtl3D             := nbDefParentCtl3D;
  TabStop                 := nbDefTabStop;
  Width                   := nbDefWidth;

  {$IFDEF Win32}                                                       {!!.14}
  Exclude(FComponentStyle, csInheritable);                             {!!.14}
  {$ENDIF}                                                             {!!.14}

  if Classes.GetClass(TOvcNotebookPage.ClassName) = nil then
    Classes.RegisterClass(TOvcNotebookPage);

  {add default tabs}
  FPageAccess.Add('&First');
  FPageAccess.Add('&Second');
  FPageAccess.Add('&Third');

  {load design-time cursor}
  if csDesigning in ComponentState then
    nbTabCursor := LoadCursor(HInstance, MakeIntResource(crTabCursor));
end;

procedure TOvcNotebook.ChangeScale(M, D : Integer);
begin
  inherited ChangeScale(M, D);

  if M <> D then begin
    {scale the tab width and height}
    TabWidth := MulDiv(FTabWidth, M, D);
    TabHeight := MulDiv(FTabHeight, M, D);

    {scale the active tab font. "inherited" scales normal font}
    ActiveTabFont.Size := MulDiv(ActiveTabFont.Size, M, D);
  end;
end;

procedure TOvcNotebook.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do begin
    Style := Style or WS_CLIPCHILDREN;
    if not (csDesigning in ComponentState) then
      WindowClass.Style := WindowClass.Style and not CS_DBLCLKS;
  end;
end;

procedure TOvcNotebook.CreateWnd;
begin
  inherited CreateWnd;

  {force the defalut "first page" to be TopMost}
  if csDesigning in ComponentState then begin
    if nbIsValidIndex(PageIndex) then
      with TOvcNotebookPage(nbPageList[PageIndex]) do begin
        Visible := True;
        BringToFront;
      end;
  end;
end;

destructor TOvcNotebook.Destroy;
begin
  FPageAccess.Free;
  FPageAccess := nil;

  nbPageList.Free;
  nbPageList := nil;

  FActiveTabFont.Free;
  FActiveTabFont := nil;

  {destroy design-time cursor}
  if (csDesigning in ComponentState) and (nbTabCursor <> 0) then
    DestroyCursor(nbTabCursor);

  inherited Destroy;
end;

function TOvcNotebook.DoOnDrawTab(Index : Integer; const Title : AnsiString;
         Enabled, Active : Boolean) : Boolean;
var
  R : TRect;
begin
  Result := Assigned(FOnDrawTab) and                                   {!!.13}
            (Index > -1) and (Index < nbPageList.Count);               {!!.13}
  if Result then begin
    R := nbGetTabRect(Index);
    FOnDrawTab(Self, Index, Title, R, Enabled, Active);
  end;
end;

procedure TOvcNotebook.DoOnMouseOverTab(Index : Integer);
begin
  if Assigned(FOnMouseOverTab) then
    FOnMouseOverTab(Self, Index);
end;

procedure TOvcNotebook.DoOnPageChange(Index : Integer; var AllowChange : Boolean);
begin
 if Assigned(FOnPageChange) then
   FOnPageChange(Self, Index, AllowChange);
end;

procedure TOvcNotebook.DoOnPageChanged(Index : Integer);
begin
  if Assigned(FOnPageChanged) then
    FOnPageChanged(Self, Index);
end;

procedure TOvcNotebook.DoOnTabClick(Index : Integer);
begin
  if Assigned(FOnTabClick) then
    FOnTabClick(Self, Index);
end;

procedure TOvcNotebook.DoOnUserCommand(Command : Word);
  {-perform notification of a user command}
begin
  if Assigned(FOnUserCommand) then
    FOnUserCommand(Self, Command);
end;

{!!.11}
procedure TOvcNotebook.EndUpdate;
  {-allow window updates}
begin
  Perform(WM_SETREDRAW, 1, 0);
  Invalidate;
end;

function TOvcNotebook.GetActivePageName : AnsiString;
begin
  if nbIsValidIndex(PageIndex) then
    Result := TOvcNotebookPage(nbPageList[PageIndex]).Caption
  else
    Result := '';
end;

{$IFDEF Win32}
function TOvcNotebook.GetChildOwner : TComponent;
begin
  Result := Self;
end;

procedure TOvcNotebook.GetChildren(Proc : TGetChildProc
          {$IFDEF VERSION3}; Root : TComponent {$ENDIF});
var
  I : Integer;
begin
  for I := 0 to nbPageList.Count - 1 do
    Proc(TControl(nbPageList[I]));
end;
{$ENDIF}

function TOvcNotebook.GetPageHelpContext : THelpContext;
begin
  Result := GetPageHelpContexts(PageIndex);
end;

function TOvcNotebook.GetPageHelpContexts(Index : Integer) : THelpContext;
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index]).HelpContext
  else
    Result := 0;
end;

function TOvcNotebook.GetPageHint : AnsiString;
begin
  Result := GetPageHints(PageIndex);
end;

function TOvcNotebook.GetPageHints(Index : Integer) : AnsiString;
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index]).Hint
  else
    Result := '';
end;

function TOvcNotebook.GetClientHeight : Integer;
begin
  if nbIsValidIndex(PageIndex) then
    Result := TOvcNotebookPage(nbPageList[PageIndex]).Height
  else
    Result := 0;
end;

function TOvcNotebook.GetClientWidth : Integer;
begin
  if nbIsValidIndex(PageIndex) then
    Result := TOvcNotebookPage(nbPageList[PageIndex]).Width
  else
    Result := 0;
end;

function TOvcNotebook.GetPageEnabled : Boolean;
begin
  if nbIsValidIndex(PageIndex) then
    Result := TOvcNotebookPage(nbPageList[PageIndex]).PageEnabled
  else
    Result := False;
end;

function TOvcNotebook.GetPageName : AnsiString;
begin
  if nbIsValidIndex(PageIndex) then
    Result := TOvcNotebookPage(nbPageList[PageIndex]).Caption
  else
    Result := '';
end;

function TOvcNotebook.GetPageNames(Index : Integer) : AnsiString;
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index]).Caption
  else
    Result := '';
end;

function TOvcNotebook.GetTabOrientation : TTabOrientation;
begin
  Result := FTabOrientation;
end;

function TOvcNotebook.GetTabRect(Index : Integer) : TRect;
  {-return the area of the specified tab}
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index]).Area
  else
    Result := Rect(0, 0, 0, 0);
end;

function TOvcNotebook.GetPageObjects(Index : Integer) : TOvcNotebookPage;
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index])
  else
    raise EInvalidPageIndex.Create;
end;

function TOvcNotebook.GetPagesEnabled(Index : Integer) : Boolean;
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index]).PageEnabled
  else
    raise EInvalidPageIndex.Create;
end;

function TOvcNotebook.GetPagesVisible(Index : Integer) : Boolean;
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index]).TabVisible
  else
    raise EInvalidPageIndex.Create;
end;

function TOvcNotebook.GetTabTextColor : TColor;
begin
  if nbIsValidIndex(PageIndex) then
    Result := TOvcNotebookPage(nbPageList[PageIndex]).TabTextColor
  else
    Result := Font.Color;
end;

function TOvcNotebook.GetTabsTextColor(Index : Integer) : TColor;
begin
  if (Index > -1) and (Index < nbPageList.Count) then
    Result := TOvcNotebookPage(nbPageList[Index]).TabTextColor
  else
    Result := Font.Color;
end;

procedure TOvcNotebook.DeletePage(Index : Integer);
  {-delete the specified notebook page}
var
  CurIndex : Integer;                                                  {!!.01}
begin
  if (Index > -1) and (Index < nbPageList.Count) and
     (nbPageList.Count > 1) then begin

    {hide the currently active page}                                   {!!.01}
    CurIndex := PageIndex;                                             {!!.01}
    TOvcNotebookPage(nbPageList[CurIndex]).Visible := False;           {!!.01}

    {delete the requested page}
    FPageAccess.Delete(Index);

    if nbIsValidIndex(CurIndex) then begin                             {!!.01}
      with TOvcNotebookPage(nbPageList[CurIndex]) do begin             {!!.01}
        Visible := True;                                               {!!.01}
        BringToFront;                                                  {!!.01}
      end;                                                             {!!.01}
    end else                                                           {!!.01}
      PageIndex := 0;                                                  {!!.01}

    {force recalculation for alignment settings}                       {!!.01}
    if Align <> alNone then begin                                      {!!.01}
      nbCalcTabInfo;                                                   {!!.01}
      SetBounds(Left, Top, Width, Height);                             {!!.01}
    end;                                                               {!!.01}

    Invalidate;
  end else
    raise EInvalidPageIndex.Create;
end;

function TOvcNotebook.InsertPage(const Name : AnsiString;
                                 Index : Integer) : TOvcNotebookPage;
var
  Idx : Integer;                                                       {!!.14}
  {-insert a notebook page at the specified location}
begin
  if (Index > -1) and (Index <= nbPageList.Count) then begin
    FPageAccess.Insert(Index, Name);
    Result := TOvcNotebookPage(FPageAccess.Objects[Index]);

    {force recalculation for alignment settings}                       {!!.01}
    if Align <> alNone then begin                                      {!!.01}
      nbCalcTabInfo;                                                   {!!.01}
      SetBounds(Left, Top, Width, Height);                             {!!.01}
    end;                                                               {!!.01}

    {see if we need to shift the active page}                          {!!.14}
    if Index <= FPageIndex then begin                                  {!!.14}
      Idx := FPageIndex+1;                                             {!!.14}
      FPageIndex := -1;                                                {!!.14}
      SetPageIndex(Idx);                                               {!!.14}
    end;                                                               {!!.14}

    Invalidate;
  end else
    raise EInvalidPageIndex.Create;
end;

procedure TOvcNotebook.InvalidateTab(Index : Integer);
  {-invalidate the specified tab}
begin
  nbInvalidateTab(Index);
end;

function TOvcNotebook.IsValid(Index : Integer) : Boolean;
  {-return true if the Index tab is valid}
begin
  Result := nbIsValidIndex(Index);
end;

procedure TOvcNotebook.Loaded;
var
  I : Integer;
begin
  inherited Loaded;

  {hide all tab pages except the active one}
  for I := 0 to nbPageList.Count - 1 do
    if I <> PageIndex then begin
      TOvcNotebookPage(nbPageList[I]).Visible := False;

      {destroy handles of hidden page and contents}
      if ConserveResources and not (csDesigning in ComponentState) then
        TOvcNotebookPage(nbPageList[I]).DestroyHandle;
    end;

  {conditionally change notebooks hint and help context}
  if EchoPageHelp then
    HelpContext := TOvcNotebookPage(nbPageList[PageIndex]).HelpContext;
  if EchoPageHint then
    Hint := TOvcNotebookPage(nbPageList[PageIndex]).Hint;

  nbCalcTabInfo;

  {force recalculation for alignment settings}
  SetBounds(Left, Top, Width, Height);
end;

function TOvcNotebook.MousePointToIndex : integer;
var
 lPt : TPoint;
begin
 GetCursorPos(lPt);
 lPt := ScreenToClient(lPt);
 Result := ItemAtPos(lPt);
end;

function TOvcNotebook.ItemAtPos(aPt : TPoint) : integer;
var
 TP : TOvcNotebookPage;
 I  : Integer;
begin
 Result := -1;

 for I := 0 to Pred(nbPageList.Count) do
 begin
  TP := TOvcNotebookPage(nbPageList[I]);
  if (TP.PageEnabled or (csDesigning in ComponentState)) and
              PtInRect(TP.Area, aPt) then
   begin
    Result := I;
    Break;
   end;
 end;
end;

procedure TOvcNotebook.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
var
  lPageIndex  : Integer;
  {C  : TWinControl;}
  //TP : TOvcNotebookPage;
  PF : TForm;
begin
  if (Button = mbLeft) and (ssAlt in Shift) then Exit; {V}

  if (Button = mbLeft) then
  begin
   if (csDesigning in ComponentState) and (nbResizeWidth or nbResizeIndent) then
     SetCapture(Handle)
   else
   begin
    if GetFocus = Handle then                                        {!!.16}
     nbTabSelecting := True                                         {!!.16}
    else                                                             {!!.16}
     nbTabSelecting := False;

    lPageIndex := ItemAtPos(Point(X,Y));
    if lPageIndex < 0 then
      Exit;
      
    {is this a click on the visible tab?}
    if PageIndex <> lPageIndex then
    begin
     {if everything is going well (no errors on page), we should be focused}
     if (GetFocus <> Handle) and not (csDesigning in ComponentState) then
     begin
      {if not, cancel any modes that we might be in and don't change pages}
      Perform(WM_CANCELMODE, 0, 0);
      Exit;
     end;

     PageIndex := lPageIndex;

     {if we couldn't change pages, exit}                        {!!.01}
     if PageIndex <> lPageIndex then                                     {!!.01}
      Exit;                                                    {!!.01}
            (*                                                         {V}
            if not (csDesigning in ComponentState) then begin
              {move focus to first control on the page}
              PF := TForm(GetParentForm(Self));
              if Assigned(PF) then begin
                C := FindNextControl(nil, True, True, False);
                if not Assigned(C) then
                  C := FindNextControl(nil, True, False, False);
                if Assigned(C) and (C <> TOvcNotebookPage(nbPageList[PageIndex])) then
                  PF.ActiveControl := C
                else
                  SetFocus;
              end else
                SetFocus;
            end;
            *)
            {notify the designer of the change}
     if csDesigning in ComponentState then
     begin
      PF := TForm(GetParentForm(Self));
      if Assigned(PF) and (PF.Designer <> nil) then
      PF.Designer.Modified;
     end;

    end
    else //if PageIndex <> lPageIndex then
     SetFocus;
   end;

   DoOnTabClick(lPageIndex);
  end; //if Button <> mbLeft then

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TOvcNotebook.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P      : TPoint;
  I      : LongInt;
  MinPos : Integer;
  MaxPos : Integer;
  TP     : TOvcNotebookPage;
  PF     : TForm;
begin
  for I := 0 to Pred(nbPageList.Count) do begin
    TP := TOvcNotebookPage(nbPageList[I]);
    if PtInRect(TP.Area, Point(X,Y)) then begin
      DoOnMouseOverTab(I);
      Break;
    end;
  end;

  if csDesigning in ComponentState then begin
    if GetCapture = Handle then begin
      P := Point(X, Y);
      if nbResizeWidth then begin
        if FTabOrientation = toTop then begin
          MinPos := nbTabsPerRow*nbDefMinTabWidth + Pred(nbTotalRows)*FTabIndent;
          MaxPos := Width-1;
          if P.X < MinPos then P.X := MinPos;
          if P.X > MaxPos then P.X := MaxPos;
          I := (P.X - Pred(nbTotalRows)*FTabIndent) div nbTabsPerRow;
        end else begin
          MinPos := nbTabsPerRow*nbDefMinTabWidth + Pred(nbTotalRows)*FTabIndent;
          MaxPos := Height-1;
          if P.Y < MinPos then P.Y := MinPos;
          if P.Y > MaxPos then P.Y := MaxPos;
          I := (P.Y - Pred(nbTotalRows)*FTabIndent) div nbTabsPerRow;
        end;
        if I <> FTabWidth then begin
          FTabWidth := I;
          Repaint;

          {notify the designer of the change}
          PF := TForm(GetParentForm(Self));
          if Assigned(PF) and (PF.Designer <> nil) then
            PF.Designer.Modified;
        end;
      end else if nbResizeIndent then begin
        if FTabOrientation = toTop then begin
          MinPos := 0;
          MaxPos := FTabWidth - FTabWidth div 3;
          if P.X < MinPos then P.X := MinPos;
          if P.X > MaxPos then P.X := MaxPos;
          if P.X <> FTabIndent then begin
            FTabIndent := P.X;
            Repaint;

            {notify the designer of the change}
            PF := TForm(GetParentForm(Self));
            if Assigned(PF) and (PF.Designer <> nil) then
              PF.Designer.Modified;
          end;
        end else begin
          MinPos := 0;
          MaxPos := FTabWidth - FTabWidth div 3;
          if P.Y < MinPos then P.Y := MinPos;
          if P.Y > MaxPos then P.Y := MaxPos;
          if P.Y <> FTabIndent then begin
            FTabIndent := P.Y;
            Repaint;

            {notify the designer of the change}
            PF := TForm(GetParentForm(Self));
            if Assigned(PF) and (PF.Designer <> nil) then
              PF.Designer.Modified;
          end;
        end;
      end;
    end;
  end else
    inherited MouseMove(Shift, X, Y);
end;

procedure TOvcNotebook.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  if nbResizeWidth or nbResizeIndent then begin
    ReleaseCapture;
    nbResizeWidth := False;
    nbResizeIndent := False;

    {force re-alignment if align is on}
    if Align <> alNone then begin
      SetBounds(Left, Top, Width, Height);
      Repaint;
    end;
  end else
    inherited MouseUp(Button, Shift, X, Y);
end;

procedure TOvcNotebook.nbAdjustPageSize;
  {-adjust size of all contained pages to fit our client area}
var
  {I    : Integer;}
  T, L : Integer;
  W, H : Integer;
begin
  L := 3;
  if FTabOrientation = toTop then begin
    T := FTabHeight*nbTotalRows+3;
    H := Self.Height-T-2;
    If FAutoTabSize  {V}
     then W := Self.Width - 5
     else W := nbTabsPerRow*FTabWidth-5;
  end else begin
    T := 3;
    If FAutoTabSize  {V}
     then H := Self.Height - 5
     else H := nbTabsPerRow*FTabWidth-5;
    W := Self.Width-(FTabHeight*nbTotalRows+3)-2;
  end;

  {adjust client size for new style tabs}
  if (FStyle = bsNew) or
     ((FStyle = bsAutoDetect) and NewStyleControls) then begin
    if Ctl3D then begin
      Dec(W,1);
      Dec(H,1);
    end else begin
      Dec(L,2);
      Dec(T,2);
      Inc(W,2);
      Inc(H,2);
    end;
  end;

  with TOvcNotebookPage(nbPageList[PageIndex]) do       {V}
    if (L <> Left) or (T <> Top) or (W <> Width) or (H <> Height) then
      SetBounds(L, T, W, H);
  {change the client area size for all tab pages}
  {
  for I := 0 to nbPageList.Count-1 do
    with TOvcNotebookPage(nbPageList[I]) do
      if (L <> Left) or (T <> Top) or (W <> Width) or (H <> Height) then
        SetBounds(L, T, W, H);
  }
end;


procedure TOvcNotebook.nbCalcTabInfo;      {V}
var
  TabsUsed : Integer;
  Row      : Integer;
  I, J     : Integer;
  WH       : Integer;
  PF       : TForm;
  OldTW    : Integer;                                                  {!!.11}
  OldI     : Integer;                                                  {!!.11}
  ThisTabWidth  : Integer;
  SumWidth      : Integer;
  FirstInRow    : Integer;
  AddSize       : Integer;
  NumInRow      : Integer;
  IndentSize    : Integer;
  TP            : TOvcNotebookPage;
  Bnd           : TRect;
begin
  {calculate tab height based on the fonts}
  if FTabAutoHeight and (csDesigning in ComponentState) then begin
    {get height for active tab font}
    Canvas.Font := ActiveTabFont;
    FTabHeight := Canvas.TextHeight(GetOrphStr(SCTallLowChars))+nbDefTopMargin*2;
    {get height for default font}
    Canvas.Font := Self.Font;
    FTabHeight := Max(FTabHeight,Canvas.TextHeight(GetOrphStr(SCTallLowChars))+nbDefTopMargin*2);
    {select lagest height}
  end;

  if FTabOrientation = toTop
   then WH := Self.Width-1
   else WH := Self.Height-1;

  If FAutoTabSize                            {V}
   then
    Begin
     If Not nbBldWidthsNeed then Exit;
     Canvas.Font := Self.Font;
     IndentSize := Canvas.TextHeight(GetOrphStr(SCTallLowChars)) + 2;
     SumWidth   := 0;
     Row        := 0;
     FirstInRow := 0;
     NumInRow   := 0;
     For I:=0 to Pred(nbPageList.Count) do
      Begin
       TP := TOvcNotebookPage(nbPageList[I]);
       If TP.TabVisible
        then
         Begin
          ThisTabWidth := Canvas.TextWidth(TP.Caption) + IndentSize;
          Canvas.Font := ActiveTabFont;
          ThisTabWidth := Max(ThisTabWidth,Canvas.TextWidth(TP.Caption) + IndentSize);

          {record tab area}
          TP.Area := Bounds(0 {XOfs}, 0 {YOfs}, ThisTabWidth, FTabHeight);

          If (ThisTabWidth + SumWidth > WH) {or (I = Pred(nbPageList.Count))}
           then
            Begin
             If I > 0 then
              Begin
               AddSize:= (WH - SumWidth) div NumInRow;
               J := FirstInRow;   {Correction TabWidth on SumWidth - WH}
               While J <= Pred(I) do
                Begin
                 With TOvcNotebookPage(nbPageList[J]) do
                  Begin
                   Bnd:=Area;
                   Inc(Bnd.Right,AddSize);
                   If J = Pred(I) then Inc(Bnd.Right,(WH - SumWidth) mod NumInRow);
                   Area:=Bnd;
                  end;
                 Inc(J);
                end;
               Inc(Row);
              end;
             SumWidth:=Row*FTabIndent + ThisTabWidth;
             FirstInRow:=I;
             NumInRow:=1;
            end
           else
            Begin
             Inc(SumWidth, ThisTabWidth);
             Inc(NumInRow);
            end;

         If I = Pred(nbPageList.Count) then
          Begin
           AddSize:= (WH - SumWidth) div NumInRow;
           J := FirstInRow;
           While J <= I do
            Begin
             With TOvcNotebookPage(nbPageList[J]) do
              Begin
               Bnd:=Area;
               Inc(Bnd.Right,AddSize);
               If J = I then Inc(Bnd.Right,(WH - SumWidth) mod NumInRow);
               Area:=Bnd;
              end;
             Inc(J);
            end;
          end;

         end
        else
         TP.Area := Bounds(0,0,0,0);

       TP.Row := Row;
       if I = PageIndex then nbFocusedRow := Row;
      end;
     nbTotalRows  := Row + 1;
     nbLastRow    := Row;
     {FTabRowCount := Row;}
    end
   else
    Begin
     if FTabRowCount = 0
      then
       begin
        {determine the number of rows and tabs per row}
        nbTotalRows := 1;

        {assume all tabs in one row}
        nbTabsPerRow := nbPageList.Count;

        while (Pred(nbTotalRows)*FTabIndent +
               nbTabsPerRow*FTabWidth > WH) and
              (nbTotalRows < nbPageList.Count) do
         begin
          Inc(nbTotalRows);
          nbTabsPerRow := nbPageList.Count div nbTotalRows;
          if nbPageList.Count mod nbTotalRows <> 0 then Inc(nbTabsPerRow);
         end;
       end
      else
       begin
        OldTW := FTabWidth;                                                {!!.11}
        OldI := FTabIndent;                                                {!!.11}

        {determine the number of tabs per row}
        nbTotalRows := FTabRowCount;
        nbTabsPerRow := nbPageList.Count div nbTotalRows;
        if nbPageList.Count mod nbTotalRows <> 0 then Inc(nbTabsPerRow);

        {see if minimum tab width will work}
        if Pred(nbTotalRows)*FTabIndent >= WH then FTabIndent := 0;

        {adjust tab widths if tabs are too wide to fit}
        while Pred(nbTotalRows)*FTabIndent + nbTabsPerRow*FTabWidth > WH do Dec(FTabWidth);

        {notify the designer of the change}
        if (csDesigning in ComponentState) then
         begin
          if (FTabWidth <> OldTW) or (FTabIndent <> OldI) then begin       {!!.11}
            PF := TForm(GetParentForm(Self));
            if Assigned(PF) and (PF.Designer <> nil) then
              PF.Designer.Modified;
          end;                                                             {!!.11}
         end;
       end;

     while nbTabsPerRow * nbTotalRows < nbPageList.Count do Inc(nbTabsPerRow);

     TabsUsed := 0;
     Row := 0;
     nbFocusedRow := 0;
     nbLastRow := Pred(nbTotalRows);

     for I := 0 to nbPageList.Count-1 do
      begin
       Inc(TabsUsed);
       if TabsUsed > nbTabsPerRow then
        begin
         TabsUsed := 1;
         Inc(Row);
        end;
       TOvcNotebookPage(nbPageList[I]).Row := Row;
       if I = PageIndex then nbFocusedRow := Row;
      end;
    end;
end;

(*
procedure TOvcNotebook.nbCalcTabInfo;
var
  TabsUsed : Integer;
  Row      : Integer;
  I, J     : Integer;
  WH       : Integer;
  PF       : TForm;
  OldTW    : Integer;                                                  {!!.11}
  OldI     : Integer;                                                  {!!.11}
begin
  {calculate tab height based on the fonts}
  if FTabAutoHeight and (csDesigning in ComponentState) then begin
    {get height for active tab font}
    Canvas.Font := ActiveTabFont;
    I := Canvas.TextHeight(GetOrphStr(SCTallLowChars))+nbDefTopMargin*2;

    {get height for default font}
    Canvas.Font := Self.Font;
    J := Canvas.TextHeight(GetOrphStr(SCTallLowChars))+nbDefTopMargin*2;

    {select lagest height}
    if I > J then
      FTabHeight := I
    else
      FTabHeight := J;
  end;

  if FTabOrientation = toTop then
    WH := Self.Width-1
  else
    WH := Self.Height-1;

  if FTabRowCount = 0 then begin
    {determine the number of rows and tabs per row}
    nbTotalRows := 1;

    {assume all tabs in one row}
    nbTabsPerRow := nbPageList.Count;

    while (Pred(nbTotalRows)*FTabIndent +
           nbTabsPerRow*FTabWidth > WH) and
          (nbTotalRows < nbPageList.Count) do begin
      Inc(nbTotalRows);
      nbTabsPerRow := nbPageList.Count div nbTotalRows;
      if nbPageList.Count mod nbTotalRows <> 0 then
        Inc(nbTabsPerRow);
    end;
  end else begin
    OldTW := FTabWidth;                                                {!!.11}
    OldI := FTabIndent;                                                {!!.11}

    {determine the number of tabs per row}
    nbTotalRows := FTabRowCount;
    nbTabsPerRow := nbPageList.Count div nbTotalRows;
    if nbPageList.Count mod nbTotalRows <> 0 then
      Inc(nbTabsPerRow);

    {see if minimum tab width will work}
    if Pred(nbTotalRows)*FTabIndent >= WH then
      FTabIndent := 0;

    {adjust tab widths if tabs are too wide to fit}
    while Pred(nbTotalRows)*FTabIndent + nbTabsPerRow*FTabWidth > WH do
      Dec(FTabWidth);

    {notify the designer of the change}
    if (csDesigning in ComponentState) then begin
      if (FTabWidth <> OldTW) or (FTabIndent <> OldI) then begin       {!!.11}
        PF := TForm(GetParentForm(Self));
        if Assigned(PF) and (PF.Designer <> nil) then
          PF.Designer.Modified;
      end;                                                             {!!.11}
    end;
  end;

  while nbTabsPerRow * nbTotalRows < nbPageList.Count do
    Inc(nbTabsPerRow);

  TabsUsed := 0;
  Row := 0;
  nbFocusedRow := 0;
  nbLastRow := Pred(nbTotalRows);

  for I := 0 to nbPageList.Count-1 do begin
    Inc(TabsUsed);
    if TabsUsed > nbTabsPerRow then begin
      TabsUsed := 1;
      Inc(Row);
    end;
    TOvcNotebookPage(nbPageList[I]).Row := Row;
    if I = PageIndex then
      nbFocusedRow := Row;
  end;
end;
*)
procedure TOvcNotebook.nbDoRefresh;
begin
  {set resizing flag to true to avoid erasing background}
  nbResizeWidth := True;
  Refresh;
  nbResizeWidth := False;
end;

procedure TOvcNotebook.nbDrawFocusRect(Index : Integer);
var
  R : TRect;
begin
  if nbIsValidIndex(Index) then begin
    {force canvas handle update}
    if Canvas.Handle = 0 then {};
    R := nbGetTabRect(Index);
    Canvas.DrawFocusRect(R);
  end;
end;

procedure TOvcNotebook.nbFontChanged(Sender : TObject);
begin
  if csLoading in ComponentState then
    Exit;

  Perform(CM_FONTCHANGED, 0, 0);
end;

function TOvcNotebook.nbGetTabRect(Index : Integer) : TRect;
begin
  Result := TOvcNotebookPage(nbPageList[Index]).Area;
  if FTabOrientation = toTop then begin
    InflateRect(Result, -nbDefLeftMargin, 0);
    if (FStyle = bsNew) or
       ((FStyle = bsAutoDetect) and NewStyleControls) then
      Dec(Result.Left);
    Inc(Result.Top, nbDefTopMargin+1);
  end else begin
    InflateRect(Result, 0, -nbDefLeftMargin);
    if (FStyle = bsNew) or
       ((FStyle = bsAutoDetect) and NewStyleControls) then
      Dec(Result.Top);
    Dec(Result.Right, nbDefTopMargin+1);
  end;
end;

procedure TOvcNotebook.nbInvalidateTab(Index : Integer);
var
  R : TRect;
begin
  if (Index > -1) and (Index < nbPageList.Count) then begin
    R := TOvcNotebookPage(nbPageList[Index]).Area;
    if FTabOrientation = toTop then
      Inc(R.Bottom, 5)  {increase to include top border of pages}
    else
      Dec(R.Left, 5);
    if HandleAllocated then
      InvalidateRect(Handle, @R, False);
  end;
end;

function TOvcNotebook.nbIsValidIndex(Index : Integer) : Boolean;
begin
  Result := (Index > -1) and (Index < nbPageList.Count) and
            ((TOvcNotebookPage(nbPageList[Index]).PageEnabled) or
             (csDesigning in ComponentState)) and
            (TOvcNotebookPage(nbPageList[Index]).TabVisible);
end;

function TOvcNotebook.nbNextValidIndex(Index : Integer) : Integer;
begin
  {insure passed index is in valid range}
  if (Index < 0) or (Index > nbPageList.Count-1) then
    Index := nbPageList.Count-1;

  {search for next valid index}
  Result := Succ(Index);
  while (not nbIsValidIndex(Result)) and (Result <> Index) do begin
    Inc(Result);
    if Result > nbPageList.Count-1 then
      Result := 0;
  end;

  if (not nbIsValidIndex(Result)) or (Result = Index) then
    Result := -1;
end;

procedure TOvcNotebook.nbPaintTopTabs;
var
  TP         : TOvcNotebookPage;
  I          : Integer;
  YOfs       : Integer;
  XOfs       : Integer;
  R          : TRect;
  TextOfs    : Integer;
  Row        : Integer;
  StartRow   : Integer;
  RowCounter : Integer;
  TabsUsed   : Integer;
  PC         : TColor;
  MainFont   : Boolean;

  procedure DrawTabBorder31(TR : TRect; Current : Boolean);
  var
    PW         : Integer;
    L, T, R, B : Integer;
  begin
    with Canvas do begin
      with TR do begin
        L := Left;
        T := Top;
        R := Right;
        B := Bottom;
      end;

      {fill the tab area}
      Brush.Color := Color;
      Pen.Color := Color;
      Polygon([Point(L,       B-1),
               Point(L,       T+4),
               Point(L+4,     T),
               Point(R-4,     T),
               Point(R-1,     T+4),
               Point(R-1,     B-1)]);

      {border}
      Pen.Color := clBlack;
      PolyLine([Point(L,      B-1),
                Point(L,      T+4),
                Point(L+4,    T),
                Point(R-4,    T),
                Point(R,      T+4),
                Point(R,      B)]);

      {highlight}
      Pen.Color := FHighlightColor;
      PolyLine([Point(L+1,    B-1),
                Point(L+1,    T+4),
                Point(L+4,    T+1),
                Point(R-3,    TR.Top+1)]);
      if Current then
        PolyLine([Point(L+2,  B-1),
                  Point(L+2,  T+4),
                  Point(L+4,  T+2),
                  Point(R-4,  T+2)]);

      {shadow}
      Pen.Color := FShadowColor;
      PolyLine([Point(R-4,    T+1),
                Point(R-1,    T+4),
                Point(R-1,    B)]);

      if Current then begin
        PW := nbTabsPerRow*FTabWidth;  {page width}

        {since this tab is the currently focused tab,}
        {draw the complete page boundry}

        {add double width of shadow color}
        PolyLine([Point(R-4,  T+2),
                  Point(R-2,  T+4),
                  Point(R-2,  B)]);

        {since this tab is the currently focused tab,}
        {draw the complete page boundry}

        {clear area directly below the tab}
        Pen.Color := Color;
        PolyLine([Point(L,    B),
                  Point(R,    B)]);
        PolyLine([Point(L,    B+1),
                  Point(R,    B+1)]);
        PolyLine([Point(L,    B+2),
                  Point(R,    B+2)]);

        {highlight}
        Pen.Color := FHighlightColor;
        PolyLine([Point(L+1,  B),
                  Point(L+1,  B+1),
                  Point(1,    B+1),
                  Point(1,    Height-1)]);
        PolyLine([Point(L+2,  B),
                  Point(L+2,  B+2),
                  Point(2,    B+2),
                  Point(2,    Height-2)]);
        PolyLine([Point(R,    B+1),
                  Point(PW,   B+1)]);
        PolyLine([Point(R-1,  B+2),
                  Point(PW-1, B+2)]);

        {shadow}
        Pen.Color := FShadowColor;
        PolyLine([Point(2,    Height-2),
                  Point(PW-1, Height-2),
                  Point(PW-1, B+1)]);
        PolyLine([Point(R-1,  B+1),
                  Point(R-1,  B-1)]);
        PolyLine([Point(3,    Height-3),
                  Point(PW-2, Height-3),
                  Point(PW-2, B+2)]);
        PolyLine([Point(R-2,  B+2),
                  Point(R-2,  B-1)]);

        {border}
        Pen.Color := clBlack;
        PolyLine([Point(L,    B),
                  Point(0,    B),
                  Point(0,    Height-1),
                  Point(PW,   Height-1),
                  Point(PW,   B),
                  Point(R-1,  B)]);
      end;
    end;
  end;

  procedure DrawTabBorder95(TR : TRect; Current : Boolean);
  var
    PW         : Integer;
    L, T, R, B : Integer;
  begin
    with Canvas do begin
      with TR do begin
        L := Left;
        T := Top;
        R := Right;
        B := Bottom;
      end;

      {fill the tab area}
      Brush.Color := Color;
      Pen.Color := Color;
      Polygon([Point(L,       B-1),
               Point(L,       T+2),
               Point(L+2,     T),
               Point(R-4,     T),
               Point(R-2,     T+2),
               Point(R-2,     B-1)]);

      {highlight}
      Pen.Color := FHighlightColor;
      PolyLine([Point(L,      B-1),
                Point(L,      T+2),
                Point(L+2,    T),
                Point(R-2,    T)]);

      {border}
      Pen.Color := clBlack;
      PolyLine([Point(R-2,    T+1),
                Point(R-1,    T+2),
                Point(R-1,    B)]);

      {shadow}
      Pen.Color := FShadowColor;
      PolyLine([Point(R-2,    T+2),
                Point(R-2,    B)]);

      if Current then begin
       If FAutoTabSize  {V}
         then PW := Width
         else PW := nbTabsPerRow*FTabWidth;

        {PW := nbTabsPerRow*FTabWidth;}  {page width}

        {since this tab is the currently focused tab,}
        {draw the complete page boundry}

        {clear area directly below the tab}
        Pen.Color := Color;
        Rectangle(L, B, R, B+1);

        {highlight}
        Pen.Color := FHighlightColor;
        PolyLine([Point(L,    B),
                  Point(0,    B),
                  Point(0,    Height-1)]);
        PolyLine([Point(R-1,  B),
                  Point(PW-2, B)]);

        {border}
        Pen.Color := clBlack;
        PolyLine([Point(0,    Height-1),
                  Point(PW-1, Height-1),
                  Point(PW-1, B-1)]);

        {shadow}
        Pen.Color := FShadowColor;
        PolyLine([Point(1,    Height-2),
                  Point(PW-2, Height-2),
                  Point(PW-2, B-1)]);
      end;
    end;
  end;

  procedure DrawTab(Index : Integer; Title : AnsiString; IsEnabled,
                    IsTabActive : Boolean;
                    XPos, YPos, TxtOfs, TabV, TabH : Integer);
  var
    HoldColor : TColor;
    Buf       : array[0..255] of AnsiChar;
  begin
    StrPLCopy(Buf, Title, 255);

    {draw the tab and borders}
    R := Rect(XPos, YPos, XPos + TabH, YPos + TabV);
    if (R.Right >= Width) then R.Right := Width-1;
    if (FStyle = bsNew) or
       ((FStyle = bsAutoDetect) and NewStyleControls) then
      DrawTabBorder95(R, IsTabActive)
    else
      DrawTabBorder31(R, IsTabActive);

    with Canvas do begin
      {get text bounding rectangle}
      R := Bounds(XPos+nbDefLeftMargin, YPos+TxtOfs, TabH - nbDefLeftMargin*2, TabV-TxtOfs);
      if (R.Right > Width) then R.Right := Width-nbDefLeftMargin*2;

      {exit if user has drawn the tab}
      if DoOnDrawTab(Index, Title, IsEnabled, IsTabActive) then
        Exit;

      HoldColor := Canvas.Font.Color;
      if IsEnabled then begin
        {draw shadow first, if selected}
        if FShadowedText then begin
          Canvas.Font.Color := FTextShadowColor;
          SetBkMode(Canvas.Handle, OPAQUE);
          DrawTextA(Canvas.Handle, @Buf, -1, R, DT_CENTER or DT_SINGLELINE);
          Canvas.Font.Color := HoldColor;
          SetBkMode(Canvas.Handle, TRANSPARENT);
          OffsetRect(R, -2, -1);
          DrawTextA(Canvas.Handle, @Buf, -1, R, DT_CENTER or DT_SINGLELINE);
        end else begin
          {draw the text}
          SetBkMode(Canvas.Handle, OPAQUE);
          DrawTextA(Canvas.Handle, @Buf, -1, R, DT_CENTER or DT_SINGLELINE);
        end;
      end else begin
        {use shadow text for inactive tabs}
        Canvas.Font.Color := FHighlightColor;
        SetBkMode(Canvas.Handle, OPAQUE);
        DrawTextA(Canvas.Handle, @Buf, -1, R, DT_CENTER or DT_SINGLELINE);
        SetBkMode(Canvas.Handle, TRANSPARENT);
        Canvas.Font.Color := FShadowColor;
        OffsetRect(R, -2, -1);
        DrawTextA(Canvas.Handle, @Buf, -1, R, DT_CENTER or DT_SINGLELINE);
      end;
      Canvas.Font.Color := HoldColor;
    end;
  end;

  procedure DrawBoundary(X, Y, Y2 : Integer);
  begin
    with Canvas do begin
      Brush.Color := Color;
      Pen.Color := Color;

      if (FStyle = bsNew) or
         ((FStyle = bsAutoDetect) and NewStyleControls) then begin
        {paint visible area under right-most tab}
        Rectangle(X-FTabIndent, Y, X-2, Y2-1);

        {draw the shadow}
        Pen.Color := FShadowColor;
        PolyLine([Point(X-2, Y),
                  Point(X-2, Y2-1),
                  Point(X-FTabIndent-1, Y2-1)]);

        {draw the boundry}
        Pen.Color := clBlack;
        PolyLine([Point(X-1, Y),
                  Point(X-1, Y2),
                  Point(X-FTabIndent-1, Y2)]);
       end else begin
        {paint visible area under right-most tab}
        Rectangle(X-FTabIndent+1, Y, X-1, Y2-1);
        {draw the shadow}
        Pen.Color := FShadowColor;
        PolyLine([Point(X-1, Y),
                  Point(X-1, Y2-1),
                  Point(X-FTabIndent, Y2-1)]);

        {draw the boundry}
        Pen.Color := clBlack;
        PolyLine([Point(X, Y),
                  Point(X, Y2),
                  Point(X-FTabIndent, Y2)]);
      end;
    end;
  end;

  procedure DrawTriangle(X, Y : Integer; Left : Boolean);
  begin
    if (FStyle = bsNew) or ((FStyle = bsAutoDetect) and NewStyleControls) then begin
      if Left then
        Canvas.Polygon([Point(X,Y), Point(X+1,Y), Point(X,Y+1)])
      else
        Canvas.Polygon([Point(X,Y), Point(X-2,Y), Point(X,Y+2)]);
    end else begin
      if Left then
        Canvas.Polygon([Point(X,Y), Point(X+3,Y), Point(X,Y+3)])
      else
        Canvas.Polygon([Point(X,Y), Point(X-3,Y), Point(X,Y+3)]);
    end;
  end;

Var            {V}
 ThisTabWidth : Integer;

begin
  {set the font to use}
  Canvas.Font := Font;
  MainFont := True;

  {get current parent color}
  if Parent is TControl then
    PC := TLocalControl(Parent).Color
  else
    PC := Color;

  with Canvas do begin
    {calculate starting position of text}
    TextOfs := (FTabHeight - TextHeight(GetOrphStr(SCTallLowChars)) + 2) div 2;

    {top of tab row}
    YOfs := 0;

    {start with the row after the row containing the focused tab}
    Row := Succ(nbFocusedRow);
    if Row > nbLastRow then
      Row := 0;
    StartRow := Row;
    RowCounter := 0;
    repeat
      XOfs := FTabIndent*(nbLastRow-RowCounter); {left of first tab}
      TabsUsed := 0;
      for I := 0 to nbPageList.Count-1 do begin
        TP := TOvcNotebookPage(nbPageList[I]);
        if (TP.Row = Row) and TP.TabVisible then begin
          If FAutoTabSize  {V}
           then ThisTabWidth := TP.Area.Right - TP.Area.Left
           else ThisTabWidth := FTabWidth;

          {record tab area}
          {TP.Area := Bounds(XOfs, YOfs, FTabWidth, FTabHeight);}
          TP.Area := Bounds(XOfs, YOfs, ThisTabWidth, FTabHeight);
          Canvas.Font.Color := TP.TabTextColor;

          {select the font to use}
          if I = PageIndex then begin
            Canvas.Font := ActiveTabFont;
            MainFont := False;

            {calculate starting position of text}
            TextOfs := (FTabHeight - TextHeight(GetOrphStr(SCTallLowChars)) + 2) div 2;
          end else begin
            if not MainFont then begin
              Canvas.Font := Self.Font;
              Canvas.Font.Color := TP.TabTextColor;
              MainFont := True;

              {calculate starting position of text}
              TextOfs := (FTabHeight - TextHeight(GetOrphStr(SCTallLowChars)) + 2) div 2;
            end;
          end;

          {draw the tab}
          DrawTab(I, TP.Caption, TP.PageEnabled, (I = PageIndex),
                  XOfs, YOfs, TextOfs, FTabHeight, ThisTabWidth);

          Brush.Color := PC;
          Pen.Color := PC;

          {paint corners to match parent color}
          if Row = StartRow then begin
            DrawTriangle(XOfs, YOfs, True);  {left}
            DrawTriangle(XOfs+FTabWidth, YOfs, False);  {right} {V}
          end else begin
            if TabsUsed = 0 then begin
              {for the first tab in a row}
              DrawTriangle(XOfs, YOfs, True);  {left}
              Brush.Color := Color;
              Pen.Color := Color;
            end else begin
              Brush.Color := Color;
              Pen.Color := Color;
              DrawTriangle(XOfs, YOfs, True);  {left}
            end;

            {use parent color for triangle at right edge of tab}
            if (FTabIndent = 0) and (Succ(TabsUsed) = nbTabsPerRow) then begin
              Brush.Color := PC;
              Pen.Color := PC;
            end;

            DrawTriangle(XOfs+ThisTabWidth, YOfs, False);  {right}
          end;

          Inc(TabsUsed);
          Inc(XOfs, ThisTabWidth);
        end;
      end;

      {draw blank tabs for any incomplete rows}
      If not FAutoTabSize then {V}
      for I := 1 to nbTabsPerRow-TabsUsed do begin
        DrawTab(-1, ' ', False, False,
                XOfs, YOfs, TextOfs, FTabHeight, FTabWidth);

        Brush.Color := PC;
        Pen.Color := PC;

        {paint corners to match parent color}
        if Row = StartRow then begin
          DrawTriangle(XOfs, YOfs, True);  {left}
          DrawTriangle(XOfs+FTabWidth, YOfs, False);  {right}
        end else begin
          if TabsUsed = 0 then begin
            {for the first tab in a row}
            DrawTriangle(XOfs, YOfs, True);  {left}
            Brush.Color := Color;
            Pen.Color := Color;
          end else begin
            Brush.Color := Color;
            Pen.Color := Color;
            DrawTriangle(XOfs, YOfs, True);  {left}
          end;

          {use parent color for triangle at right edge of tab}
          if (FTabIndent = 0) and (I = nbTabsPerRow-TabsUsed) then begin
            Brush.Color := PC;
            Pen.Color := PC;
          end;

          DrawTriangle(XOfs+FTabWidth, YOfs, False);  {right}
        end;

        Inc(XOfs, FTabWidth);
      end;

      {draw partial boundry and paint blank areas for the last tab}
      {in a row for all rows except the focused row}
      if Row <> nbFocusedRow then begin
        DrawBoundary(XOfs, YOfs+FTabHeight, Height-(nbLastRow-RowCounter)*FTabHeight);

        {paint area to left of first tab in all rows except the focused row}
        Brush.Color := PC;
        Pen.Color := PC;
        Rectangle(0, YOfs, (nbLastRow-RowCounter)*FTabIndent, YOfs+FTabHeight);
      end;

      Brush.Color := PC;
      Pen.Color := PC;
      If not FAutoTabSize then{V}

      if Row = StartRow then begin
        {paint area to the right of the tab page}
        if (FStyle = bsNew) or
           ((FStyle = bsAutoDetect) and NewStyleControls) then
          Rectangle(XOfs, 0, Width+1, Height+1)
        else
          Rectangle(XOfs+1, 0, Width, Height);
      end else
       //If Not FAutoTabSize then
        begin
         {paint B/R corner area for other than the top-most row}
         if (FStyle = bsNew) or ((FStyle = bsAutoDetect) and NewStyleControls) then
           Rectangle(XOfs, Height-(nbLastRow-RowCounter+1)*FTabHeight+1,
                     XOfs+FTabIndent+2, Height)
         else
           Rectangle(XOfs+1, Height-(nbLastRow-RowCounter+1)*FTabHeight+1,
                     XOfs+FTabIndent+1, Height);
        end;

      Inc(YOfs, FTabHeight);
      Inc(RowCounter);
      Inc(Row);
      if Row > nbLastRow then Row := 0;
    until Row = StartRow;

    {reset to default font and colors so focus rect is drawn properly}
    Canvas.Font := Self.Font;
    Canvas.Brush.Color := Color;
    Canvas.Pen.Color := Color;

    {draw the focus rect if the tab has the focus}
    if Focused then
      nbDrawFocusRect(PageIndex);
  end;
end;

procedure TOvcNotebook.nbPaintRightTabs;
var
  TP         : TOvcNotebookPage;
  I          : Integer;
  YOfs       : Integer;
  XOfs       : Integer;
  R          : TRect;
  TextOfs    : Integer;
  Row        : Integer;
  StartRow   : Integer;
  RowCounter : Integer;
  TabsUsed   : Integer;
  PC         : TColor;
  MainFont   : Boolean;

  procedure DrawTabBorder31(TR : TRect; Current : Boolean);
  var
    PH         : Integer;
    L, T, R, B : Integer;
  begin
    with Canvas do begin
      with TR do begin
        L := Left;
        T := Top;
        R := Right;
        B := Bottom;
      end;

      {fill the tab area}
      Brush.Color := Color;
      Pen.Color := Color;
      Polygon([Point(L+1,      T+1),
               Point(R-4,      T+1),
               Point(R-1,      T+4),
               Point(R-1,      B-4),
               Point(R-4,      B-1),
               Point(L+1,      B-1)]);

      {draw border around tab}
      Pen.Color := clBlack;
      PolyLine([Point(L,       T),
                Point(R-4,     T),
                Point(R,       T+4),
                Point(R,       B-4),
                Point(R-4,     B),
                Point(L-1,     B)]);

      {draw highlight around tab, inside of the border}
      Pen.Color := FHighlightColor;
      PolyLine([Point(L+1,     T+1),
                Point(R-4+1,   T+1)]);

      {draw a second line of highlight for the current tab}
      if Current then
        PolyLine([Point(L-1,   T+2),
                  Point(R-4+1, T+2)]);

      {draw shadow around tab, inside of the border}
      Pen.Color := FShadowColor;
      PolyLine([Point(R-4-1,   T+1),
                Point(R-4,     T+1),
                Point(R-1,     T+4),
                Point(R-1,     B-4),
                Point(R-4,     B-1),
                Point(L,       B-1)]);

      {draw second line of shadow for the current tab}
      if Current then
        PolyLine([Point(R-4,     T+2),
                  Point(R-2,     T+4),
                  Point(R-2,     B-4),
                  Point(R-4,     B-2),
                  Point(L,       B-2)]);

      if Current then begin
        PH := nbTabsPerRow*FTabWidth;  {page height}

        {since this tab is the currently focused tab,}
        {draw the complete page boundry}

        {clear area directly below the tab}
        Pen.Color := Color;
        Rectangle(L-2, T+3, L+1, B-2);

        {border}
        Pen.Color := clBlack;
        PolyLine([Point(L,    T),
                  Point(L,    0),
                  Point(0,    0),
                  Point(0,    PH),
                  Point(L,    PH),
                  Point(L,    B)]);

        {shadow}
        Pen.Color := FShadowColor;
        PolyLine([Point(L-1,  T+1),
                  Point(L-1,  1)]);
        PolyLine([Point(L-2,  T+2),
                  Point(L-2,  2)]);
        PolyLine([Point(2,    PH-1),
                  Point(L-1,  PH-1),
                  Point(L-1,  B-3)]);
        PolyLine([Point(3,    PH-2),
                  Point(L-2,  PH-2),
                  Point(L-2,  B-2)]);

        {fix ups}
        Pixels[L-2,B-2] := FShadowColor;
        Pen.Color := FShadowColor;
        PolyLine([Point(L,    B-1),
                  Point(L,    B-3)]);

        {highlight}
        Pen.Color := FHighlightColor;
        PolyLine([Point(L-1,  1),
                  Point(1,    1),
                  Point(1,    PH)]);
        PolyLine([Point(L-2,  2),
                  Point(2,    2),
                  Point(2,    PH-1)]);

        {fix up}
        Pixels[L, T+1] := FHighlightColor;
      end;
    end;
  end;

  procedure DrawTabBorder95(TR : TRect; Current : Boolean);
  var
    PH         : Integer;
    L, T, R, B : Integer;
  begin
    with Canvas do begin
      with TR do begin
        L := Left;
        T := Top;
        R := Right;
        B := Bottom;
      end;

      {fill the tab area}
      Brush.Color := Color;
      Pen.Color := Color;
      Polygon([Point(L+1,      T),
               Point(R-2,      T),
               Point(R-1,      T+2),
               Point(R-1,      B-3),
               Point(R-2,      B-1),
               Point(L+1,      B-1)]);

      {highlight}
      Pen.Color := FHighlightColor;
      PolyLine([Point(L+1,     T),
                Point(R-2,     T),
                Point(R,       T+2)]);

      {border}
      Pen.Color := clBlack;
      PolyLine([Point(R,       T+2),
                Point(R,       B-2),
                Point(R-1,     B-2),
                Point(R-2,     B-1),
                Point(L,       B-1)]);

      {shadow}
      Pen.Color := FShadowColor;
      PolyLine([Point(R-1,     T+2),
                Point(R-1,     B-3),
                Point(R-2,     B-2),
                Point(L,       B-2)]);

      if Current then begin
        PH := nbTabsPerRow*FTabWidth;  {page height}

        {since this tab is the currently focused tab,}
        {draw the complete page boundry}

        {clear area directly below the tab}
        Pen.Color := Color;
        Rectangle(L+1, T, L-1, B);
        Pixels[L,T] := Color;

        {border}
        Pen.Color := clBlack;
        PolyLine([Point(L,    0),
                  Point(L,    T)]);
        PolyLine([Point(L,    B-1),
                  Point(L,    PH)]);
        PolyLine([Point(0,    PH-1),
                  Point(L,    PH-1)]);
        Pixels[L,T] := Color; {fixup}

        {highlight}
        Pen.Color := FHighlightColor;
        PolyLine([Point(0,    PH-1),
                  Point(0,    0),
                  Point(L+1,  0)]);

        {shadow}
        Pen.Color := FShadowColor;
        PolyLine([Point(L-1,  0),
                  Point(L-1,  T-1)]);
        PolyLine([Point(L-1,  B),
                  Point(L-1,  PH-1)]);
        PolyLine([Point(1,    PH-2),
                  Point(L+1,  PH-2)]);
        Pixels[L-1, 0] := FHighlightColor; {fixup}
      end;
    end;
  end;

  procedure DrawTab(Index : Integer; Title : AnsiString; IsEnabled,
                    IsTabActive : Boolean;
                    XPos, YPos, TxtOfs, TabH : Integer);
  var
    UIndent   : Integer;
    CTIndent  : Integer;
    WD        : Integer;
    TW        : Integer;
    TH        : Integer;
    HoldColor : TColor;
    UPos      : Integer;
    P         : Integer;
  begin
    {draw the tab and borders}
    R := Rect(XPos-TabH, YPos, XPos, YPos+FTabWidth);
    if (R.Bottom >= Height) then R.Bottom := Height-1;
    if (FStyle = bsNew) or
       ((FStyle = bsAutoDetect) and NewStyleControls) then
      DrawTabBorder95(R, IsTabActive)
    else
      DrawTabBorder31(R, IsTabActive);

    with Canvas do begin
      {get text bounding rectangle}
      R := Bounds(XPos-TabH+1, YPos+nbDefLeftMargin, TabH-nbDefTopMargin*2,
                  FTabWidth-nbDefLeftMargin*2);
      if (R.Bottom >= Height) then R.Bottom := Height-nbDefLeftMargin;

      {exit if user has drawn the tab}
      if DoOnDrawTab(Index, Title, IsEnabled, IsTabActive) then
        Exit;

      {find location for underlined character}
      UPos := Pos('&', Title);
      if UPos > 0 then begin
        Delete(Title, UPos, 1);

        {was the '&' escaped?}
        P := Pos('&', Title);
        if (P > 0) and (P = UPos) then
          UPos := 0;
      end;
      if Title = '' then
        Title := ' ';

      {convert UPos to pixel position within the title}
      if UPos > 0 then
        UIndent := TextWidth(Copy(Title, 1, UPos-1))
      else
        UIndent := 0;

      {calc indent needed to center}
      CTIndent := 0;
      TW := TextWidth(Title);
      WD := R.Bottom - R.Top;
      if TW < WD then
        CTIndent := (WD - TW) div 2;

      HoldColor := Canvas.Font.Color;
      if IsEnabled then begin
        {draw shadow first, if selected}
        if FShadowedText then begin
          {draw the shadow text first}
          Canvas.Font.Color := FTextShadowColor;
          SetBkMode(Canvas.Handle, OPAQUE);
          if Canvas.Handle <> 0 then {force handle update after SetBkMode call};
          TextOut(XPos-TxtOfs, YPos+nbDefLeftMargin+CTIndent, Title);

          {draw normal text}
          Canvas.Font.Color := HoldColor;
          SetBkMode(Canvas.Handle, TRANSPARENT);
          if Canvas.Handle <> 0 then {force handle update after SetBkMode call};
          TextOut(XPos-TxtOfs-1, YPos+nbDefLeftMargin+CTIndent-2, Title);

          {draw underline character, if any}
          if UPos > 0 then begin
            TH := TextHeight(Title)-1;
            Pen.Color := Canvas.Font.Color;
            MoveTo(XPos-TxtOfs-TH-1, YPos+nbDefLeftMargin+UIndent+CTIndent-1);
            LineTo(XPos-TxtOfs-TH-1, YPos+nbDefLeftMargin+UIndent+CTIndent+
                   TextWidth(Title[UPos])-1);
          end;
        end else begin  {normal tab}
          {draw the text}
          SetBkMode(Canvas.Handle, OPAQUE);
          if Canvas.Handle <> 0 then {force handle update after SetBkMode call};
          TextOut(XPos-TxtOfs, YPos+nbDefLeftMargin+CTIndent, Title);

          {draw underline character, if any}
          if UPos > 0 then begin
            TH := TextHeight(Title)-1;
            Pen.Color := Canvas.Font.Color;
            MoveTo(XPos-TxtOfs-TH, YPos+nbDefLeftMargin+UIndent+CTIndent);
            LineTo(XPos-TxtOfs-TH, YPos+nbDefLeftMargin+UIndent+CTIndent+
                   TextWidth(Title[UPos]));
          end;
        end;
      end else begin  {inactive tab}
        {draw the highlight text first}
        Canvas.Font.Color := FHighlightColor;
        SetBkMode(Canvas.Handle, OPAQUE);
        if Canvas.Handle <> 0 then {force handle update after SetBkMode call};
        TextOut(XPos-TxtOfs+1, YPos+nbDefLeftMargin+CTIndent, Title);

        {draw shadow text for inactive tab}
        SetBkMode(Canvas.Handle, TRANSPARENT);
        if Canvas.Handle <> 0 then {force handle update after SetBkMode call};
        Canvas.Font.Color := FShadowColor;
        TextOut(XPos-TxtOfs, YPos+nbDefLeftMargin+CTIndent-2, Title);

        {draw underline character, if any}
        if UPos > 0 then begin
          TH := TextHeight(Title)-1;
          Pen.Color := Canvas.Font.Color;
          MoveTo(XPos-TxtOfs-TH-1, YPos+nbDefLeftMargin+UIndent+CTIndent-1);
          LineTo(XPos-TxtOfs-TH-1, YPos+nbDefLeftMargin+UIndent+CTIndent+
                 TextWidth(Title[UPos])-1);
        end;

        {restore font color}
        Canvas.Font.Color := HoldColor;
      end;

    end;
  end;

  procedure DrawBoundary(X, Y, X2 : Integer);
  begin
    with Canvas do begin
      Brush.Color := Color;
      Pen.Color := Color;
      if (FStyle = bsNew) or
         ((FStyle = bsAutoDetect) and NewStyleControls) then begin

        {paint visible area under right-most tab}
        Rectangle(X2+2, Y-FTabIndent, X, Y-2);

        {draw the boundry}
        Pen.Color := clBlack;
        PolyLine([Point(X-1, Y-1),
                  Point(X2, Y-1),
                  Point(X2, Y-FTabIndent-1)]);

        {shadow on the bottom}
        Pen.Color := FShadowColor;
        PolyLine([Point(X-1, Y-2),
                  Point(X2+1, Y-2)]);

        {single line of highlight on the left edge}
        Pen.Color := FHighlightColor;
        PolyLine([Point(X2+1, Y-2),
                  Point(X2+1, Y-FTabIndent-1)]);
      end else begin
        {paint visible area under right-most tab}
        Rectangle(X2+2, Y-FTabIndent+1, X, Y-1);

        {draw the boundry}
        Pen.Color := clBlack;
        PolyLine([Point(X-1, Y),
                  Point(X2, Y),
                  Point(X2, Y-FTabIndent)]);

        {shadow on the bottom}
        Pen.Color := FShadowColor;
        PolyLine([Point(X-1, Y-1),
                  Point(X2+1, Y-1)]);

        {single line of highlight on the left edge}
        Pen.Color := FHighlightColor;
        PolyLine([Point(X2+1, Y-1),
                  Point(X2+1, Y-FTabIndent)]);
      end;
    end;
  end;

  procedure DrawTriangle(X, Y : Integer; Left : Boolean);
  begin
    if (FStyle = bsNew) or ((FStyle = bsAutoDetect) and NewStyleControls) then begin
      if Left then
        Canvas.Polygon([Point(X,Y), Point(X-1,Y), Point(X,Y+1)])
      else
        Canvas.Polygon([Point(X,Y), Point(X,Y-2), Point(X-2,Y)]);
    end else begin
      if Left then
        Canvas.Polygon([Point(X,Y), Point(X-3,Y), Point(X,Y+3)])
      else
        Canvas.Polygon([Point(X,Y), Point(X,Y-3), Point(X-3,Y)]);
    end;
  end;

begin
  {set the font to use}
  Canvas.Font := Self.Font;
  Canvas.Font.Handle := CreateRotatedFont(Canvas.Font, 270);
  MainFont := True;

  {get current parent color}
  if Parent is TControl then
    PC := TLocalControl(Parent).Color
  else
    PC := Color;

  with Canvas do begin
    {calculate starting position of text}
    TextOfs := (FTabHeight - TextHeight(GetOrphStr(SCTallLowChars)) + 1) div 2;

    {right side (top) of tab row}
    XOfs := Width-1;

    {start with the row after the row containing the focused tab}
    Row := Succ(nbFocusedRow);
    if Row > nbLastRow then Row := 0;

    StartRow := Row;
    RowCounter := 0;
    repeat
      YOfs := FTabIndent*(nbLastRow-RowCounter);  {top (left edge) of first tab}
      TabsUsed := 0;

      for I := 0 to nbPageList.Count-1 do begin
        TP := TOvcNotebookPage(nbPageList[I]);
        if (TP.Row = Row) and TP.TabVisible then begin
          {record tab area}
          TP.Area := Bounds(XOfs-FTabHeight, YOfs, FTabHeight, FTabWidth);
          Canvas.Font.Color := TP.TabTextColor;

          {select the font to use}
          if I = PageIndex then begin
            Canvas.Font := ActiveTabFont;
            Canvas.Font.Handle := CreateRotatedFont(Canvas.Font, 270);
            MainFont := False;

            {calculate starting position of text}
            TextOfs := (FTabHeight - TextHeight(GetOrphStr(SCTallLowChars)) + 1) div 2;
          end else begin
            if not MainFont then begin
              Canvas.Font := Self.Font;
              Canvas.Font.Handle := CreateRotatedFont(Canvas.Font, 270);
              Canvas.Font.Color := TP.TabTextColor;
              MainFont := True;

              {calculate starting position of text}
              TextOfs := (FTabHeight - TextHeight(GetOrphStr(SCTallLowChars)) + 1) div 2;
            end;
          end;

          {draw the tab}
          DrawTab(I, TP.Caption, TP.PageEnabled, (I = PageIndex),
                  XOfs, YOfs, TextOfs, FTabHeight);

          Brush.Color := PC;
          Pen.Color := PC;

          {paint corners to match parent color}
          if Row = StartRow then begin
            DrawTriangle(XOfs, YOfs, True);  {top}
            DrawTriangle(XOfs, YOfs+FTabWidth, False);  {bottom}
          end else begin
            if TabsUsed = 0 then begin
              {for the first tab in a row}
              DrawTriangle(XOfs, YOfs, True);  {top}
              Brush.Color := Color;
              Pen.Color := Color;
            end else begin
              Brush.Color := Color;
              Pen.Color := Color;
              DrawTriangle(XOfs, YOfs, True);  {top}
            end;

            {use parent color for triangle at bottom edge of tab}
            if (FTabIndent = 0) and (Succ(TabsUsed) = nbTabsPerRow) then begin
              Brush.Color := PC;
              Pen.Color := PC;
            end;

            DrawTriangle(XOfs, YOfs+FTabWidth, False);  {bottom}
          end;

          Inc(TabsUsed);
          Inc(YOfs, FTabWidth);  {next tab in row}
        end;
      end;

      {draw blank tabs for any incomplete rows}
      for I := 1 to nbTabsPerRow-TabsUsed do begin
        DrawTab(-1, ' ', False, False, XOfs,
                YOfs, TextOfs, FTabHeight);

        Brush.Color := PC;
        Pen.Color := PC;

        {paint corners to match parent color}
        if Row = StartRow then begin
          DrawTriangle(XOfs, YOfs, True);  {top}
          DrawTriangle(XOfs, YOfs+FTabWidth, False);  {bottom}
        end else begin
          if TabsUsed = 0 then begin
            {for the first tab in a row}
            DrawTriangle(XOfs, YOfs, True);  {top}
            Brush.Color := Color;
            Pen.Color := Color;
          end else begin
            Brush.Color := Color;
            Pen.Color := Color;
            DrawTriangle(XOfs, YOfs, True);  {left}
          end;

          {use parent color for triangle at bottom edge of tab}
          if (FTabIndent = 0) and (I = nbTabsPerRow-TabsUsed) then begin
            Brush.Color := PC;
            Pen.Color := PC;
          end;

          DrawTriangle(XOfs, YOfs+FTabWidth, False);  {bottom}
        end;

        Inc(YOfs, FTabWidth);  {next tab in row}
      end;

      {draw partial boundry and paint blank areas for the last control}
      {in a row for all rows except the focused row}
      if Row <> nbFocusedRow then begin
        DrawBoundary(XOfs-FTabHeight+1, YOfs, (nbLastRow-RowCounter)*FTabHeight);
        Brush.Color := PC;
        Pen.Color := PC;

        {paint area above first tab in all rows except the focused row}
        Rectangle(XOfs-FTabHeight+1, 0, XOfs+1, (nbLastRow-RowCounter)*FTabIndent);
      end;

      Brush.Color := PC;
      Pen.Color := PC;
      if Row = StartRow then begin
        {paint area below the bottom-most tab page}
        if (FStyle = bsNew) or
           ((FStyle = bsAutoDetect) and NewStyleControls) then
          Rectangle(0, YOfs, Width, Height)
        else
          Rectangle(0, YOfs+1, Width, Height);
      end else begin
        {paint B/L corner area for other than the top-most row}
        if (FStyle = bsNew) or
           ((FStyle = bsAutoDetect) and NewStyleControls) then
          Rectangle(0, YOfs, (nbLastRow-RowCounter+1)*FTabHeight,
                    YOfs+FTabIndent+1)
        else
          Rectangle(0, YOfs+1, (nbLastRow-RowCounter+1)*FTabHeight,
                    YOfs+FTabIndent+1);
      end;

      Dec(XOfs, FTabHeight);
      Inc(RowCounter);
      Inc(Row);
      if Row > nbLastRow then Row := 0;
    until Row = StartRow;

    {reset to default font and colors so focus rect is drawn properly}
    Canvas.Font := Self.Font;
    Canvas.Brush.Color := Color;
    Canvas.Pen.Color := Color;

    {draw the focus rect if the tab has the focus}
    if Focused then
      nbDrawFocusRect(PageIndex);
  end;
end;

function TOvcNotebook.nbPrevValidIndex(Index : Integer) : Integer;
begin
  {insure passed index is in valid range}
  if (Index < 0) or (Index > nbPageList.Count-1) then
    Index := 0;

  {search for next valid index}
  Result := Pred(Index);
  while (not nbIsValidIndex(Result)) and (Result <> Index) do begin
    Dec(Result);
    if Result < 0  then
      Result := nbPageList.Count-1;
  end;

  if (not nbIsValidIndex(Result)) or (Result = Index) then
    Result := -1;
end;

procedure TOvcNotebook.NextPage;
  {-display the next valid notebook page}
var
  I : Integer;
begin
  I := nbNextValidIndex(PageIndex);
  if I > -1 then
    PageIndex := I;
end;

procedure TOvcNotebook.PrevPage;
  {-display the previous valid notebook page}
var
  I : Integer;
begin
  I := nbPrevValidIndex(PageIndex);
  if I > -1 then
    PageIndex := I;
end;

function TOvcNotebook.PageNameToIndex(const Name : AnsiString) : Integer;
  {-return page index given the page name}
begin
  Result := FPageAccess.IndexOf(Name);
end;

procedure TOvcNotebook.Paint;
begin
  inherited Paint;

  if nbPageList.Count > 0 then begin
    nbCalcTabInfo;
    nbAdjustPageSize;
    if FTabOrientation = toTop then
      nbPaintTopTabs
    else
      nbPaintRightTabs;
  end else begin
    {if no tabs defined, just paint the whole client area}
    Canvas.Brush.Color := Color;
    Canvas.Pen.Color := Color;
    Canvas.Rectangle(0, 0, Width, Height);
  end;
end;

procedure TOvcNotebook.ReadState(Reader : TReader);
{$IFNDEF Win32}
var
  OldOwner : TComponent;
{$ENDIF}
begin
  Pages.Clear;

  {$IFDEF Win32}
  inherited ReadState(Reader);
  {$ELSE}
  {change reader owner so the pages are owned by the notebook}
  OldOwner := Reader.Owner;
  Reader.Owner := Self;
  try
    inherited ReadState(Reader);
  finally
    Reader.Owner := OldOwner;
  end;
  {$ENDIF}

  {if the current tab index is invalid, try to find the next valid one}
  if not nbIsValidIndex(FPageIndex) then
    FPageIndex := nbNextValidIndex(FPageIndex);

  if nbIsValidIndex(FPageIndex) then
    with TOvcNotebookPage(nbPageList[FPageIndex]) do begin
      BringToFront;
      Visible := True;
    end
  else
    FPageIndex := -1;
end;

procedure TOvcNotebook.SetActivePageName(const Value: AnsiString);
var
  I  : Integer;
begin
  {find page corresponding to the value passed}
  I := FPageAccess.IndexOf(Value);
  if I > -1 then
    PageIndex := I;
end;

procedure TOvcNotebook.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
var
  MinPos : Integer;

  procedure AdjustTabSize;
  begin
    if FTabOrientation = toRight then begin
      MinPos := nbTabsPerRow*nbDefMinTabWidth + Pred(nbTotalRows)*FTabIndent;
      if AHeight < MinPos then AHeight := MinPos;
      FTabWidth := (AHeight -1 - Pred(nbTotalRows)*FTabIndent) div nbTabsPerRow;
    end;

    if FTabOrientation = toTop then begin
      MinPos := nbTabsPerRow*nbDefMinTabWidth + Pred(nbTotalRows)*FTabIndent;
      if AWidth < MinPos then AWidth := MinPos;
      If Not FAutoTabSize   {V}
       then
        FTabWidth := (AWidth -1 - Pred(nbTotalRows)*FTabIndent) div nbTabsPerRow;
    end;
  end;

begin
  if not (csLoading in ComponentState) then begin

    {auto-adjust tab size if any of the align options are on}
    if Align <> alNone then
      AdjustTabSize;

    {restrict width so at least one tab per row is visible}
    if FTabOrientation = toTop then begin
      {restrict width so at least one tab per row is visible}
      if AWidth < FTabWidth + nbLastRow*FTabIndent then
        AWidth := FTabWidth + nbLastRow*FTabIndent;
    end else
      {restrict height so at least one tab per row is visible}
      if AHeight < FTabWidth + nbLastRow*FTabIndent then
        AHeight := FTabWidth + nbLastRow*FTabIndent;
  end;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TOvcNotebook.SetActiveTabFont(Value : TFont);
begin
  FActiveTabFont.Assign(Value);
  nbBldWidthsNeed := True;
end;

procedure TOvcNotebook.SetConserveResources(Value : Boolean);
var
  I : Integer;
begin
  if Value <> FConserveResources then begin
    FConserveResources := Value;
    if Value and not (csDesigning in ComponentState) then
      for I := 0 to nbPageList.Count - 1 do
        if I <> PageIndex then
          {destroy handles of hidden pages and their components}
          TOvcNotebookPage(nbPageList[I]).DestroyHandle;
  end;
end;

procedure TOvcNotebook.SetDefaultPageIndex(Value : Integer);
begin
  FDefaultPageIndex := Value;
  if (csLoading in ComponentState) and not (csDesigning in ComponentState) then
    PageIndex := FDefaultPageIndex;
end;

procedure TOvcNotebook.SetHighlightColor(const Value : TColor);
begin
  if Value <> FHighlightColor then begin
    FHighlightColor := Value;
    Refresh;
  end;
end;

procedure TOvcNotebook.SetPageEnabled(Value : Boolean);
var
  TP : TOvcNotebookPage;
  I  : Integer;
begin
  if nbIsValidIndex(PageIndex) then begin
    TP := TOvcNotebookPage(nbPageList[PageIndex]);

    if TP.PageEnabled <> Value then begin
      TP.PageEnabled := Value;
      nbInvalidateTab(PageIndex);
    end;

    {if not designing or loading, change the active tab}
    if not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      if not nbIsValidIndex(PageIndex) then begin
        I := nbPrevValidIndex(PageIndex);
        if I > -1 then
          PageIndex := I
        else begin
          {at least one page must be enabled. revert and raise exception}
          TP.PageEnabled := True;
          nbInvalidateTab(PageIndex);
          raise EInvalidPageIndex.Create;
        end;
      end;

  end;
end;

procedure TOvcNotebook.SetPageHelpContext(Value : THelpContext);
begin
  SetPageHelpContexts(PageIndex, Value);
end;

procedure TOvcNotebook.SetPageHelpContexts(Index : Integer; Value : THelpContext);
var
  TP : TOvcNotebookPage;
begin
  if (Index > -1) and (Index < nbPageList.Count) then begin
    TP := TOvcNotebookPage(nbPageList[Index]);
    if TP.HelpContext <> Value then
      TP.HelpContext := Value;
  end;
end;

procedure TOvcNotebook.SetPageHint(const Value : AnsiString);
begin
  SetPageHints(PageIndex, Value);
end;

procedure TOvcNotebook.SetPageHints(Index : Integer; const Value : AnsiString);
var
  TP : TOvcNotebookPage;
begin
  if (Index > -1) and (Index < nbPageList.Count) then begin
    TP := TOvcNotebookPage(nbPageList[Index]);
    if TP.Hint <> Value then
      TP.Hint := Value;
  end;
end;

procedure TOvcNotebook.SetPageIndex(Value : Integer);
var
  PrevIndex  : Integer;
  PF         : TForm;
  OkToChange : Boolean;
begin
  if (csLoading in ComponentState) then begin
    {PageIndex is no longer stored, so set the default page index}
    FDefaultPageIndex := Value;
    FPageIndex := Value;
    Exit;
  end;
  PrevIndex := FPageIndex;
  if (Value <> FPageIndex) and nbIsValidIndex(Value) then begin
    if nbTabChanging then                                                {!!.16}
      Exit;                                                              {!!.16}
    nbTabChanging := True;                                               {!!.16}
    try                                                                  {!!.16}
      if not (csDesigning in ComponentState) then begin
        OkToChange := True;
        {ask user if this is ok}
        DoOnPageChange(Value, OkToChange);
        if not OkToChange then
          Exit;
      end;

      with TOvcNotebookPage(nbPageList[Value]) do begin
        Visible := True;
        BringToFront;
      end;

      PF := TForm(GetParentForm(Self));
      if nbIsValidIndex(FPageIndex) then begin

        {are we a parent of the active control}
        if ContainsControl(PF.ActiveControl) then
          PF.ActiveControl := nil;

        {hide the current page}
        TOvcNotebookPage(nbPageList[FPageIndex]).Visible := False;

        {destroy handles of hidden page and contents}
  {V}   {if ConserveResources and not (csDesigning in ComponentState) then
          TOvcNotebookPage(nbPageList[FPageIndex]).DestroyHandle;}
      end;

      {PrevIndex := FPageIndex;}
      FPageIndex := Value;
      nbFocusedRow := TOvcNotebookPage(nbPageList[FPageIndex]).Row;

      {conditionally change notebooks hint and help context}
      if EchoPageHelp then
        HelpContext := TOvcNotebookPage(nbPageList[FPageIndex]).HelpContext;
      if EchoPageHint then
        Hint := TOvcNotebookPage(nbPageList[FPageIndex]).Hint;

      {if we are selecting the tab using the arrow keys}
      if nbTabSelecting then
        SetFocus;

      {invalidate old and new tab if they are in the same row}
      if nbIsValidIndex(PrevIndex) and (TOvcNotebookPage(nbPageList[PrevIndex]).Row =
         TOvcNotebookPage(nbPageList[FPageIndex]).Row) then begin
        nbInvalidateTab(PrevIndex);
        nbInvalidateTab(FPageIndex);
        Update;
      end else  {otherwise, force repaint of all tabs}
        nbDoRefresh;

      {report page change}
      if not (csDesigning in ComponentState) then
        DoOnPageChanged(PageIndex);
    finally                                                            {!!.16}
      nbTabChanging := False;                                          {!!.16}
    end;                                                               {!!.16}
  end else if not nbIsValidIndex(Value) then
    raise EInvalidPageIndex.Create;

  if not nbIsValidIndex(FPageIndex) then
    raise EInvalidPageIndex.Create;

  if ConserveResources and     {V}
     not (csDesigning in ComponentState) and
     nbIsValidIndex(PrevIndex) and
     Not TOvcNotebookPage(nbPageList[PrevIndex{FPageIndex}]).Visible then
    Begin
     //Application.ProcessMessages;
     TOvcNotebookPage(nbPageList[PrevIndex]).DestroyHandle;
    end;
end;

procedure TOvcNotebook.SetPageName(const Value : AnsiString);
var
  TP : TOvcNotebookPage;
begin
  if nbIsValidIndex(PageIndex) then begin
    TP := TOvcNotebookPage(nbPageList[PageIndex]);

    if TP.Caption <> Value then begin
      TP.Caption := Value;
      nbInvalidateTab(PageIndex);
    end;

  end;
end;

procedure TOvcNotebook.SetPageNames(Index : Integer; const Value : AnsiString);
var
  TP : TOvcNotebookPage;
begin
  if (Index > -1) and (Index < nbPageList.Count) then begin
    TP := TOvcNotebookPage(nbPageList[Index]);
    if TP.Caption <> Value then begin
      TP.Caption := Value;
      nbInvalidateTab(Index);
    end;
  end;
end;

procedure TOvcNotebook.SetPages(Strings : TStrings);
var
  I, J    : Integer;
  TP      : TOvcNotebookPage;
  NewList : TList;
  Found   : Boolean;
begin
  {cycle through the AnsiString list adding new entries and copying}
  {data for existing entries in the page list as required}

  NewList := TList.Create;

  {delete any tab pages not in the new AnsiString list}
  I := nbPageList.Count - 1;
  while I >= 0 do begin
    TP := TOvcNotebookPage(nbPageList[I]);
    Found := False;

    for J := 0 to Strings.Count - 1 do begin
      Found := CompareText(Strings[J], TP.Caption) = 0;
      if Found then Break;
    end;

    if not Found then begin  {remove from our page list}
      TP.Free;
      nbPageList.Delete(I);
    end;
    Dec(I);
  end;

  {create new pages for any additional tab names in the AnsiString list}
  for I := 0 to Strings.Count-1 do begin
    Found := False;

    {cycle through the page list looking for a match}
    TP := nil;
    for J := 0 to nbPageList.Count - 1 do begin
      TP := TOvcNotebookPage(nbPageList[J]);
      Found := CompareText(Strings[I], TP.Caption) = 0;
      if Found then Break;
    end;

    if not Found then begin
      {add a new tab page}
      TP := TOvcNotebookPage.Create(Self);
      TP.Parent := Self;
      TP.Caption := Strings[I];
    end;

    if Assigned(TP) then
      NewList.Add(TP);
  end;

  nbPageList.Free;
  nbPageList := NewList;

  {force tab update}
  I := PageIndex;
  FPageIndex := -1;
  if nbPageList.Count > 0 then
    if nbIsValidIndex(I) then
      PageIndex := I
    else
      PageIndex := 0;
end;

procedure TOvcNotebook.SetPagesEnabled(Index : Integer; Value : Boolean);
var
  TP : TOvcNotebookPage;
  I  : Integer;
begin
  if (Index > -1) and (Index < nbPageList.Count) then begin

    {!!.11} {added}
    {is this the active page?}
    if not Value and (PageIndex = Index) then begin                    {!!.12}
      {find another valid page}
      I := nbPrevValidIndex(PageIndex);
      if I > -1 then
        PageIndex := I
      else
        raise EInvalidPageIndex.Create;
    end;

    TP := TOvcNotebookPage(nbPageList[Index]);
    TP.PageEnabled := Value;
    nbInvalidateTab(Index);
    nbDoRefresh;

    {see if the current page is still valid}
    if not nbIsValidIndex(PageIndex) then begin
      I := nbPrevValidIndex(PageIndex);
      if I > -1 then
        PageIndex := I
      else begin
        {at least one page must be enabled. revert and raise exception}
        TP.PageEnabled := True;
        nbInvalidateTab(PageIndex);
        raise EInvalidPageIndex.Create;
      end;
    end;

  end else
    raise EInvalidPageIndex.Create;
end;

procedure TOvcNotebook.SetPagesVisible(Index : Integer; Value : Boolean);
var
  TP : TOvcNotebookPage;
  I  : Integer;
begin
  nbBldWidthsNeed := True;  {V}
  if (Index > -1) and (Index < nbPageList.Count) then begin
    TP := TOvcNotebookPage(nbPageList[Index]);
    TP.TabVisible := Value;
    TP.Area := Bounds(0,0,0,0);
    Refresh;

    {see if the current tab is still valid}
    if not nbIsValidIndex(PageIndex) then begin
      I := nbPrevValidIndex(PageIndex);
      if I > -1 then
        PageIndex := I;
    end;

  end else
    raise EInvalidPageIndex.Create;
end;

procedure TOvcNotebook.SetShadowColor(const Value : TColor);
begin
  if Value <> FShadowColor then begin
    FShadowColor := Value;
    Refresh;
  end;
end;

procedure TOvcNotebook.SetShadowedText(Value : Boolean);
begin
  if Value <> FShadowedText then begin
    FShadowedText := Value;
    nbDoRefresh;
  end;
end;

procedure TOvcNotebook.SetStyle(Value : TButtonStyle);
begin
  if Value <> FStyle then begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TOvcNotebook.SetTabAutoHeight(Value : Boolean);
begin
  if Value <> FTabAutoHeight then begin
    FTabAutoHeight := Value;
    if FTabAutoHeight then
      nbDoRefresh;
  end;
end;

procedure TOvcNotebook.SetTabHeight(Value : LongInt);
begin
  if (Value <> FTabHeight) and (Value >= 0) then begin
    FTabHeight := Value;
    if not (csLoading in ComponentState) then
      TabAutoHeight := False;
    nbDoRefresh;
  end;
end;

procedure TOvcNotebook.SetTabIndent(Value : LongInt);
begin
  if (Value <> FTabIndent) and (Value >= 0) and
     (Value <= FTabWidth - FTabWidth div 2) then begin
    FTabIndent := Value;
    nbDoRefresh;
  end;
end;

procedure TOvcNotebook.SetTabOrientation(Value : TTabOrientation);
var
  TM : TTextMetric;
begin
  if Value <> FTabOrientation then begin

    {check if the current font can be rotated}
    if (not (csLoading in ComponentState)) and (Value = toRight) then begin
      {test primary tab font}
      Canvas.Font := Self.Font;
      GetTextMetrics(Canvas.Handle, TM);
      if (TM.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then
        if not (csLoading in ComponentState) then
          if csDesigning in ComponentState then begin
            {force "Courier New" font}
            Font.Name := 'Courier New';
          end else
            raise EInvalidTabFont.Create;

      {test active tab font}
      Canvas.Font := ActiveTabFont;
      GetTextMetrics(Canvas.Handle, TM);
      if (TM.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then
        if not (csLoading in ComponentState) then
          if csDesigning in ComponentState then begin
            {force "Courier New" font}
            ActiveTabFont.Name := 'Courier New';
          end else
            raise EInvalidTabFont.Create;
    end;

    FTabOrientation := Value;

    {force recalculation for alignment settings}
    SetBounds(Left, Top, Width, Height);
    Refresh;
  end;
end;

procedure TOvcNotebook.SetTabRowCount(Value : Integer);
begin
  if csLoading in ComponentState then begin
    FTabRowCount := Value;
    Exit;
  end;

  if (Value <> FTabRowCount) and
     (Value >= 0) and
     (Value <= nbPageList.Count) then
    FTabRowCount := Value;

  nbCalcTabInfo;

  {force recalculation for alignment settings}
  SetBounds(Left, Top, Width, Height);
  Refresh;
end;

procedure TOvcNotebook.SetTabsTextColor(Index : Integer; Value : TColor);
var
  TP : TOvcNotebookPage;
begin
  if (Index > -1) and (Index < nbPageList.Count) then begin
    TP := TOvcNotebookPage(nbPageList[Index]);

    if TP.TabTextColor <> Value then begin
      TP.TabTextColor := Value;
      nbInvalidateTab(Index);
    end;

  end;
end;

procedure TOvcNotebook.SetTabTextColor(Value : TColor);
var
  TP : TOvcNotebookPage;
begin
  if nbIsValidIndex(PageIndex) then begin
    TP := TOvcNotebookPage(nbPageList[PageIndex]);

    if TP.TabTextColor <> Value then begin
      TP.TabTextColor := Value;
      nbInvalidateTab(PageIndex);
    end;

  end;
end;

procedure TOvcNotebook.SetTabWidth(Value : LongInt);
begin
  if (Value <> FTabWidth) and (Value >= 0) then begin
    FTabWidth := Value;
    nbDoRefresh;
  end;
end;

procedure TOvcNotebook.SetTextShadowColor(const Value : TColor);
begin
  if Value <> FTextShadowColor then begin
    FTextShadowColor := Value;
    Refresh;
  end;
end;

procedure TOvcNotebook.ShowControl(AControl : TControl);
var
  I  : Integer;
begin
  for I := 0 to nbPageList.Count - 1 do
    if nbPageList[I] = AControl then begin
      {show the page this control is on}
      PageIndex := I;
      Break;
    end;

  inherited ShowControl(AControl);
end;

procedure TOvcNotebook.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  if nbResizeWidth or nbResizeIndent then
    Msg.Result := 1  {don't erase background}
  else
    inherited;
end;

procedure TOvcNotebook.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;

  if csDesigning in ComponentState then
    Msg.Result := DLGC_STATIC
  else
    Msg.Result := Msg.Result or DLGC_WANTARROWS;
end;

procedure TOvcNotebook.WMKeyDown(var Msg : TWMKeyDown);
var
  I   : LongInt;
  Cmd : Word;
begin
  {translate the key to a command}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg), GetTickCount);

  if Cmd <> ccNone
   then
    begin
     if Cmd in [ccLeft, ccRight, ccUp, ccDown, ccHome, ccEnd]
      then
       begin
        nbTabSelecting := True;

        I := -1;
        if FTabOrientation = toTop
         then
          begin
           case Cmd of
            ccLeft  : I := nbPrevValidIndex(PageIndex);
            ccRight : I := nbNextValidIndex(PageIndex);
            ccUp    :
              if nbTotalRows > 1
               then
                begin
                 if nbIsValidIndex(PageIndex - nbTabsPerRow)
                  then I := PageIndex - nbTabsPerRow
                  else
                   if nbIsValidIndex(PageIndex + nbTabsPerRow * Pred(nbTotalRows))
                    then I := PageIndex +nbTabsPerRow * Pred(nbTotalRows);
                end;
            ccHome  : I := nbNextValidIndex(nbPageList.Count-1);
            ccEnd   : I := nbPrevValidIndex(0);
          end;
       end
      else
       begin
        case Cmd of
          ccUp    : I := nbPrevValidIndex(PageIndex);
          ccDown  : I := nbNextValidIndex(PageIndex);
          ccRight :
            if nbTotalRows > 1 then begin
              if nbIsValidIndex(PageIndex - nbTabsPerRow) then
                I := PageIndex - nbTabsPerRow
              else if nbIsValidIndex(PageIndex +
                      nbTabsPerRow * Pred(nbTotalRows)) then
                I := PageIndex +nbTabsPerRow * Pred(nbTotalRows);
            end;
          ccHome  : I := nbNextValidIndex(nbPageList.Count-1);
          ccEnd   : I := nbPrevValidIndex(0);
        end;
       end;

       {set new page index}
     if I > -1 then PageIndex := I;

    end
   else
    {do user command notification for user commands}
    if Cmd >= ccUserFirst
     then DoOnUserCommand(Cmd)
     else PageChangeAccelCheck(Msg);

    {indicate that this message was processed}
    Msg.Result := 0;
  end;
  inherited;
end;

procedure TOvcNotebook.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  inherited;
  nbHitTest.X := Msg.Pos.X;
  nbHitTest.Y := Msg.Pos.Y;
end;

procedure TOvcNotebook.WMSetCursor(var Msg : TWMSetCursor);
var
  X1, X2, Y1, Y2 : Integer;
  TP  : TOvcNotebookPage;
  I   : Integer;

  procedure SetNewCursor(C : HCursor);
  begin
    SetCursor(C);
    Msg.Result := Ord(True);
  end;

begin
  if csDesigning in ComponentState then begin
    if (Msg.HitTest = HTCLIENT) then begin
      nbResizeWidth := False;
      nbResizeIndent := False;
      nbOverTab := False;
      nbHitTest := ScreenToClient(nbHitTest);

      if FTabOrientation = toTop then begin
        {see if the mouse is over the tab width sizing area}
        X1 := nbTabsPerRow*FTabWidth+Pred(nbTotalRows)*FTabIndent;
        Y1 := Height - FTabHeight*Pred(nbTotalRows);

        {anywhere along the right edge of the notebook}
        nbResizeWidth := (Abs(X1 - nbHitTest.X) < nbDefHitWidth) and (nbHitTest.Y < Y1);

        {see if the mouse is over the tab indent sizing area}
        X1 := FTabIndent;
        Y1 := (nbTotalRows-2)*FTabHeight;
        Y2 := Y1+FTabHeight;

        {left edge of the bottom-most tab}
        nbResizeIndent := (X1 >= 0) and (Abs(X1 - nbHitTest.X) < nbDefHitWidth) and
                          (nbHitTest.Y > Y1) and (nbHitTest.Y < Y2);
      end else begin
        {see if the mouse is over the tab width sizing area}
        Y1 := nbTabsPerRow*FTabWidth+Pred(nbTotalRows)*FTabIndent;
        X1 := FTabHeight*Pred(nbTotalRows);

        {anywhere along the bottom edge of the notebook}
        nbResizeWidth := (Abs(Y1 - nbHitTest.Y) < nbDefHitWidth) and (nbHitTest.X > X1);

        {see if the mouse is over the tab indent sizing area}
        Y1 := FTabIndent;
        X1 := Width-(nbTotalRows-2)*FTabHeight;
        X2 := X1-FTabHeight;
        nbResizeIndent := (X1 <= Width) and (Abs(Y1 - nbHitTest.Y) < nbDefHitWidth) and
                          (nbHitTest.X < X1) and (nbHitTest.X > X2);
      end;

      {if not sizing, check if mouse is over a tab}
      if not (nbResizeWidth or nbResizeIndent) then begin
        for I := 0 to nbPageList.Count-1 do begin
          TP := TOvcNotebookPage(nbPageList[I]);
          if PtInRect(TP.Area, nbHitTest) then begin
            nbOverTab := True;
            Break;
          end;
        end;
      end;

      {set appropriate cursor}
      if nbResizeWidth or nbResizeIndent then begin
        if FTabOrientation = toTop then
          SetNewCursor(Screen.Cursors[crHSplit])
        else
          SetNewCursor(Screen.Cursors[crVSplit]);
      end else if nbOverTab then
        SetNewCursor(nbTabCursor)
      else
        inherited;

    end;
  end else
    inherited;
end;

procedure TOvcNotebook.WMKillFocus(var Msg : TWMKillFocus);
begin
  {re-draw the tab--erasing the focus rectangle, if any}
  nbInvalidateTab(PageIndex);

  {release the mouse}
  if GetCapture = Handle then
    ReleaseCapture;

  inherited;
end;

procedure TOvcNotebook.WMMouseActivate(var Msg : TWMMouseActivate);
var
  TP         : TOvcNotebookPage;
  I          : Integer;
  P          : TPoint;
begin
  if csDesigning in ComponentState then
    Exit;

  inherited;

  {see if the tab should be given the focus}
  if Msg.MouseMsg = WM_LBUTTONDOWN then begin
    GetCursorPos(P);
    P := ScreenToClient(P);

    for I := 0 to Pred(nbPageList.Count) do begin
      TP := TOvcNotebookPage(nbPageList[I]);
      if TP.PageEnabled and PtInRect(TP.Area, Point(P.X, P.Y)) then begin
        SetFocus;
        Break;
      end;
    end;

  end;
end;

procedure TOvcNotebook.WMSetFocus(var Msg : TWMSetFocus);
begin
  inherited;

  {force repaint of tab and drawing of focus rect}
  nbInvalidateTab(PageIndex);
end;

{$IFNDEF Win32}
procedure TOvcNotebook.WriteComponents(Writer : TWriter);
var
  I : Integer;
begin
  for I := 0 to ControlCount-1 do
    Writer.WriteComponent(nbPageList[I]);
end;
{$ENDIF}



end.