
{*******************************************************}
{                                                       }
{       Turbo Pascal Version 7.0                        }
{       Turbo Vision Unit                               }
{                                                       }
{       Copyright (c) 1992 Borland International        }
{                                                       }
{       Virtual Pascal v2.1                             }
{       Copyright (C) 1996-2000 vpascal.com             }
{                                                       }
{*******************************************************}

unit Views;

{$X+,I-,S-,H-}

interface

uses SysUtils, Use32, Objects, Drivers, Memory;

const

{ TView State masks }

  sfVisible     = $0001;
  sfCursorVis   = $0002;
  sfCursorIns   = $0004;
  sfShadow      = $0008;
  sfActive      = $0010;
  sfSelected    = $0020;
  sfFocused     = $0040;
  sfDragging    = $0080;
  sfDisabled    = $0100;
  sfModal       = $0200;
  sfDefault     = $0400;
  sfExposed     = $0800;

{ TView Option masks }

  ofSelectable  = $0001;
  ofTopSelect   = $0002;
  ofFirstClick  = $0004;
  ofFramed      = $0008;
  ofPreProcess  = $0010;
  ofPostProcess = $0020;
  ofBuffered    = $0040;
  ofTileable    = $0080;
  ofCenterX     = $0100;
  ofCenterY     = $0200;
  ofCentered    = $0300;
  ofValidate    = $0400;
  ofVersion     = $3000;
  ofVersion10   = $0000;
  ofVersion20   = $1000;

{ TView GrowMode masks }

  gfGrowLoX = $01;
  gfGrowLoY = $02;
  gfGrowHiX = $04;
  gfGrowHiY = $08;
  gfGrowAll = $0F;
  gfGrowRel = $10;

{ TView DragMode masks }

  dmDragMove = $01;
  dmDragGrow = $02;
  dmLimitLoX = $10;
  dmLimitLoY = $20;
  dmLimitHiX = $40;
  dmLimitHiY = $80;
  dmLimitAll = $F0;

{ TView Help context codes }

  hcNoContext = 0;
  hcDragging  = 1;

{ TScrollBar part codes }

  sbLeftArrow  = 0;
  sbRightArrow = 1;
  sbPageLeft   = 2;
  sbPageRight  = 3;
  sbUpArrow    = 4;
  sbDownArrow  = 5;
  sbPageUp     = 6;
  sbPageDown   = 7;
  sbIndicator  = 8;

{ TScrollBar options for TWindow.StandardScrollBar }

  sbHorizontal     = $0000;
  sbVertical       = $0001;
  sbHandleKeyboard = $0002;

{ TWindow Flags masks }

  wfMove  = $01;
  wfGrow  = $02;
  wfClose = $04;
  wfZoom  = $08;

{ TWindow number constants }

  wnNoNumber = 0;

{ TWindow palette entries }

  wpBlueWindow = 0;
  wpCyanWindow = 1;
  wpGrayWindow = 2;

{ Standard command codes }

  cmValid   = 0;
  cmQuit    = 1;
  cmError   = 2;
  cmMenu    = 3;
  cmClose   = 4;
  cmZoom    = 5;
  cmResize  = 6;
  cmNext    = 7;
  cmPrev    = 8;
  cmHelp    = 9;

{ Application command codes }

  cmCut     = 20;
  cmCopy    = 21;
  cmPaste   = 22;
  cmUndo    = 23;
  cmClear   = 24;
  cmTile    = 25;
  cmCascade = 26;

{ TDialog standard commands }

  cmOK      = 10;
  cmCancel  = 11;
  cmYes     = 12;
  cmNo      = 13;
  cmDefault = 14;

{ Standard messages }

  cmReceivedFocus     = 50;
  cmReleasedFocus     = 51;
  cmCommandSetChanged = 52;

{ TScrollBar messages }

  cmScrollBarChanged  = 53;
  cmScrollBarClicked  = 54;

{ TWindow select messages }

  cmSelectWindowNum   = 55;

{ TListViewer messages }

  cmListItemSelected  = 56;

{ Color palettes }

  CFrame      = #1#1#2#2#3;
  CScrollBar  = #4#5#5;
  CScroller   = #6#7;
  CListViewer = #26#26#27#28#29;

  CBlueWindow = #8#9#10#11#12#13#14#15;
  CCyanWindow = #16#17#18#19#20#21#22#23;
  CGrayWindow = #24#25#26#27#28#29#30#31;

{ TDrawBuffer maximum view width }

  MaxViewWidth = 255;

type

{ Command sets }

  PCommandSet = ^TCommandSet;
  TCommandSet = set of Byte;

{ Color palette type }

  PPalette = ^TPalette;
  TPalette = String;

{ TDrawBuffer, buffer used by draw methods }

  TDrawBuffer = array[0..MaxViewWidth - 1] of SmallWord;

{ TView object Pointer }

  PView = ^TView;

{ TGroup object Pointer }

  PGroup = ^TGroup;

{ TView object }

  TView = object(TObject)
    Owner: PGroup;
    Next: PView;
    Origin: TPoint;
    Size: TPoint;
    Cursor: TPoint;
    GrowMode: Byte;
    DragMode: Byte;
    HelpCtx: Word;
    State: Word;
    Options: Word;
    EventMask: Word;
    constructor Init(var Bounds: TRect);
    constructor Load(var S: TStream);
    destructor Done; virtual;
    procedure Awaken; virtual;
    procedure BlockCursor;
    procedure CalcBounds(var Bounds: TRect; Delta: TPoint); virtual;
    procedure ChangeBounds(var Bounds: TRect); virtual;
    procedure ClearEvent(var Event: TEvent);
    function CommandEnabled(Command: Word): Boolean;
    function DataSize: Word; virtual;
    procedure DisableCommands(Commands: TCommandSet);
    procedure DragView(Event: TEvent; Mode: Byte;
      var Limits: TRect; MinSize, MaxSize: TPoint);
    procedure Draw; virtual;
    procedure DrawView;
    procedure EnableCommands(Commands: TCommandSet);
    procedure EndModal(Command: Word); virtual;
    function EventAvail: Boolean;
    function Execute: Word; virtual;
    function Exposed: Boolean;
    function Focus: Boolean;
    procedure GetBounds(var Bounds: TRect);
    procedure GetClipRect(var Clip: TRect);
    function GetColor(Color: Word): Word;
    procedure GetCommands(var Commands: TCommandSet);
    procedure GetData(var Rec); virtual;
    procedure GetEvent(var Event: TEvent); virtual;
    procedure GetExtent(var Extent: TRect);
    function GetHelpCtx: Word; virtual;
    function GetPalette: PPalette; virtual;
    procedure GetPeerViewPtr(var S: TStream; var P);
    function GetState(AState: Word): Boolean;
    procedure GrowTo(X, Y: Integer);
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure Hide;
    procedure HideCursor;
    procedure KeyEvent(var Event: TEvent);
    procedure Locate(var Bounds: TRect);
    procedure MakeFirst;
    procedure MakeGlobal(Source: TPoint; var Dest: TPoint);
    procedure MakeLocal(Source: TPoint; var Dest: TPoint);
    function MouseEvent(var Event: TEvent; Mask: Word): Boolean;
    function MouseInView(Mouse: TPoint): Boolean;
    procedure MoveTo(X, Y: Integer);
    function NextView: PView;
    procedure NormalCursor;
    function Prev: PView;
    function PrevView: PView;
    procedure PutEvent(var Event: TEvent); virtual;
    procedure PutInFrontOf(Target: PView);
    procedure PutPeerViewPtr(var S: TStream; P: PView);
    procedure Select;
    procedure SetBounds(var Bounds: TRect);
    procedure SetCommands(Commands: TCommandSet);
    procedure SetCmdState(Commands: TCommandSet; Enable: Boolean);
    procedure SetCursor(X, Y: Integer);
    procedure SetData(var Rec); virtual;
    procedure SetState(AState: Word; Enable: Boolean); virtual;
    procedure Show;
    procedure ShowCursor;
    procedure SizeLimits(var Min, Max: TPoint); virtual;
    procedure Store(var S: TStream);
    function TopView: PView;
    function Valid(Command: Word): Boolean; virtual;
    procedure WriteBuf(X, Y, W, H: Integer; var Buf); pascal;
    procedure WriteChar(X, Y: Integer; C: Char; Color: Byte;
      Count: Integer);
    procedure WriteLine(X, Y, W, H: Integer; var Buf);
    procedure WriteStr(X, Y: Integer; const Str: String; Color: Byte);
  private
    procedure DrawCursor;
    procedure DrawHide(LastView: PView);
    procedure DrawShow(LastView: PView);
    procedure DrawUnderRect(var R: TRect; LastView: PView);
    procedure DrawUnderView(DoShadow: Boolean; LastView: PView);
    procedure ResetCursor; virtual; pascal;
    function do_ExposedRec1(x1, x2: sw_integer; p: PView): boolean;
    function do_ExposedRec2(x1, x2: Sw_integer; p: PView): boolean;
    procedure WriteView(x1, x2, y: Sw_integer; var Buf);
    procedure do_writeViewRec1(x1, x2: Sw_integer; p: PView;
      shadowCounter: Sw_integer);
    procedure do_writeViewRec2(x1, x2: Sw_integer; p: PView;
      shadowCounter: Sw_integer);
    function MapColor(color: Byte): Byte;
  end;

{ TFrame types }

  TTitleStr = string[80];

{ TFrame object }

  { Palette layout }
  { 1 = Passive frame }
  { 2 = Passive title }
  { 3 = Active frame }
  { 4 = Active title }
  { 5 = Icons }

  PFrame = ^TFrame;
  TFrame = object(TView)
    constructor Init(var Bounds: TRect);
    procedure Draw; virtual;
    function GetPalette: PPalette; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure SetState(AState: Word; Enable: Boolean); virtual;
  private
    FrameMode: Word;
    procedure FrameLine(var FrameBuf; Y, N: Integer; Color: Byte); pascal;
  end;

{ ScrollBar characters }

  TScrollChars = array[0..4] of Char;

{ TScrollBar object }

  { Palette layout }
  { 1 = Page areas }
  { 2 = Arrows }
  { 3 = Indicator }

  PScrollBar = ^TScrollBar;
  TScrollBar = object(TView)
    Value: Integer;
    Min: Integer;
    Max: Integer;
    PgStep: Integer;
    ArStep: Integer;
    constructor Init(var Bounds: TRect);
    constructor Load(var S: TStream);
    procedure Draw; virtual;
    function GetPalette: PPalette; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure ScrollDraw; virtual;
    function ScrollStep(Part: Integer): Integer; virtual;
    procedure SetParams(AValue, AMin, AMax, APgStep, AArStep: Integer);
    procedure SetRange(AMin, AMax: Integer);
    procedure SetStep(APgStep, AArStep: Integer);
    procedure SetValue(AValue: Integer);
    procedure Store(var S: TStream);
  private
    Chars: TScrollChars;
    procedure DrawPos(Pos: Integer);
    function GetPos: Integer;
    function GetSize: Integer;
  end;

{ TScroller object }

  { Palette layout }
  { 1 = Normal text }
  { 2 = Selected text }

  PScroller = ^TScroller;
  TScroller = object(TView)
    HScrollBar: PScrollBar;
    VScrollBar: PScrollBar;
    Delta: TPoint;
    Limit: TPoint;
    constructor Init(var Bounds: TRect; AHScrollBar, AVScrollBar: PScrollBar);
    constructor Load(var S: TStream);
    procedure ChangeBounds(var Bounds: TRect); virtual;
    function GetPalette: PPalette; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure ScrollDraw; virtual;
    procedure ScrollTo(X, Y: Integer);
    procedure SetLimit(X, Y: Integer);
    procedure SetState(AState: Word; Enable: Boolean); virtual;
    procedure Store(var S: TStream);
  private
    DrawLock: Byte;
    DrawFlag: Boolean;
    procedure CheckDraw;
  end;

{ TListViewer }

  { Palette layout }
  { 1 = Active }
  { 2 = Inactive }
  { 3 = Focused }
  { 4 = Selected }
  { 5 = Divider }

  PListViewer = ^TListViewer;

  TListViewer = object(TView)
    HScrollBar: PScrollBar;
    VScrollBar: PScrollBar;
    NumCols: Integer;
    TopItem: Integer;
    Focused: Integer;
    Range: Integer;
    constructor Init(var Bounds: TRect; ANumCols: Word;
      AHScrollBar, AVScrollBar: PScrollBar);
    constructor Load(var S: TStream);
    procedure ChangeBounds(var Bounds: TRect); virtual;
    procedure Draw; virtual;
    procedure FocusItem(Item: Integer); virtual;
    function GetPalette: PPalette; virtual;
    function GetText(Item: Integer; MaxLen: Integer): String; virtual;
    function IsSelected(Item: Integer): Boolean; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure SelectItem(Item: Integer); virtual;
    procedure SetRange(ARange: Integer);
    procedure SetState(AState: Word; Enable: Boolean); virtual;
    procedure Store(var S: TStream);
  private
    procedure FocusItemNum(Item: Integer); virtual;
  end;

{ Video buffer }

  PVideoBuf = ^TVideoBuf;
  TVideoBuf = array[0..3999] of SmallWord;

{ Selection modes }

  SelectMode = (NormalSelect, EnterSelect, LeaveSelect);

  TForEachProc = procedure(P: PView);
  TFirstThatFunc = function(P: PView): boolean;

{ TGroup object }
  TGroup = object(TView)
    Last: PView;
    Current: PView;
    Phase: (phFocused, phPreProcess, phPostProcess);
    Buffer: PVideoBuf;
    EndState: Word;
    constructor Init(var Bounds: TRect);
    constructor Load(var S: TStream);
    destructor Done; virtual;
    procedure Awaken; virtual;
    procedure ChangeBounds(var Bounds: TRect); virtual;
    function DataSize: Word; virtual;
    procedure Delete(P: PView);
    procedure Draw; virtual;
    procedure EndModal(Command: Word); virtual;
    procedure EventError(var Event: TEvent); virtual;
    function ExecView(P: PView): Word;
    function Execute: Word; virtual;
    function First: PView;
    function FirstThat(P: TMethod): PView;
    function FocusNext(Forwards: Boolean): Boolean;
    procedure ForEach(P: TMethod);
    procedure GetData(var Rec); virtual;
    function GetHelpCtx: Word; virtual;
    procedure GetSubViewPtr(var S: TStream; var P);
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure Insert(P: PView);
    procedure InsertBefore(P, Target: PView);
    procedure Lock;
    procedure PutSubViewPtr(var S: TStream; P: PView);
    procedure Redraw;
    procedure SelectNext(Forwards: Boolean);
    procedure SetData(var Rec); virtual;
    procedure SetState(AState: Word; Enable: Boolean); virtual;
    procedure Store(var S: TStream);
    procedure Unlock;
    function Valid(Command: Word): Boolean; virtual;
  private
    Clip: TRect;
    LockFlag: Byte;
    function At(Index: Integer): PView;
    procedure DrawSubViews(P, Bottom: PView);
    function FirstMatch(AState: Word; AOptions: Word): PView;
    function FindNext(Forwards: Boolean): PView;
    procedure FreeBuffer;
    procedure GetBuffer;
    function IndexOf(P: PView): Integer;
    procedure InsertView(P, Target: PView);
    procedure RemoveView(P: PView);
    procedure ResetCurrent;
    procedure ResetCursor; virtual; pascal;
    procedure SetCurrent(P: PView; Mode: SelectMode);
  end;

{ TWindow object }

  { Palette layout }
  { 1 = Frame passive }
  { 2 = Frame active }
  { 3 = Frame icon }
  { 4 = ScrollBar page area }
  { 5 = ScrollBar controls }
  { 6 = Scroller normal text }
  { 7 = Scroller selected text }
  { 8 = Reserved }

  PWindow = ^TWindow;
  TWindow = object(TGroup)
    Flags: Byte;
    ZoomRect: TRect;
    Number: Integer;
    Palette: Integer;
    Frame: PFrame;
    Title: PString;
    constructor Init(var Bounds: TRect; ATitle: TTitleStr; ANumber: Integer);
    constructor Load(var S: TStream);
    destructor Done; virtual;
    procedure Close; virtual;
    function GetPalette: PPalette; virtual;
    function GetTitle(MaxSize: Integer): TTitleStr; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure InitFrame; virtual;
    procedure SetState(AState: Word; Enable: Boolean); virtual;
    procedure SizeLimits(var Min, Max: TPoint); virtual;
    function StandardScrollBar(AOptions: Word): PScrollBar;
    procedure Store(var S: TStream);
    procedure Zoom; virtual;
  end;

{ Message dispatch function }

function Message(Receiver: PView; What, Command: Word;
  InfoPtr: Pointer): Pointer;

{ Views registration procedure }

procedure RegisterViews;

const

{ Event masks }

  PositionalEvents: Word = evMouse;
  FocusedEvents: Word = evKeyboard + evCommand;

{ Minimum window size }

  MinWinSize: TPoint = (X: 16; Y: 6);

{ Shadow definitions }

  ShadowSize: TPoint = (X: 2; Y: 1);
  ShadowAttr: Byte = $08;

{ Markers control }

  ShowMarkers: Boolean = False;

{ MapColor error return value }

  ErrorAttr: Byte = $CF;

{ Stream Registration Records }

const
  RView: TStreamRec = (
     ObjType: 1;
     VmtLink: TypeOf(TView);
     Load:    @TView.Load;
     Store:   @TView.Store
  );

const
  RFrame: TStreamRec = (
     ObjType: 2;
     VmtLink: TypeOf(TFrame);
     Load:    @TFrame.Load;
     Store:   @TFrame.Store
  );

const
  RScrollBar: TStreamRec = (
     ObjType: 3;
     VmtLink: TypeOf(TScrollBar);
     Load:    @TScrollBar.Load;
     Store:   @TScrollBar.Store
  );

const
  RScroller: TStreamRec = (
     ObjType: 4;
     VmtLink: TypeOf(TScroller);
     Load:    @TScroller.Load;
     Store:   @TScroller.Store
  );

const
  RListViewer: TStreamRec = (
     ObjType: 5;
     VmtLink: TypeOf(TListViewer);
     Load:    @TListViewer.Load;
     Store:   @TLIstViewer.Store
  );

const
  RGroup: TStreamRec = (
     ObjType: 6;
     VmtLink: TypeOf(TGroup);
     Load:    @TGroup.Load;
     Store:   @TGroup.Store
  );

const
  RWindow: TStreamRec = (
     ObjType: 7;
     VmtLink: TypeOf(TWindow);
     Load:    @TWindow.Load;
     Store:   @TWindow.Store
  );

{ Characters used for drawing selected and default items in  }
{ monochrome color sets                                      }

  SpecialChars: array[0..5] of Char = (#175, #174, #26, #27, ' ', ' ');

{ True if the command set has changed since being set to false }

  CommandSetChanged: Boolean = False;

{ True if the cursor is currently hidden }

  CursorHidden: Boolean = True;

{ Line drawing characters }

{$IFDEF LINUX}
  // In Linux, do not use high-ascii drawing characters

  ldFrameChars        : array[0..31] of Char = #32#32#32#18#32#20#15#24
                                             + #32#17#19#21#16#23#22#25
                                             + #32#32#32#29#32#31#26#31
                                             + #32#28#30#30#27#31#30#32;
                      { '   A 3UA UéA®'Aè   E ßêß ¨IIØßI '; }

  ldMenuFrameChars    : array[0..19] of Char = #32#15#19#16#32#32#18#19#17#32
                                             + #32#20#32#20#32#32#24#19#23#32;
                      { '  Ué®  AéU  3 3  Aé' '; }

  ldCloseWindow       : array[0..4] of char = '[~'#07'~]';
  ldCloseClicked      : array[0..4] of char = '[~*~]';
  ldMaximize          : array[0..4] of char = '[~'#05'~]';
  ldBottomRight       : array[0..3] of char = '~'#19#17'~';

  ldVerticalScroll    : TScrollChars = #01#02#13#07#14;
  ldHorizontalScroll  : TScrollChars = #03#04#13#07#14;

  ldHistoryDropDown   : array[0..4] of char = #10'~'#02'~'#11;

  ldPathDir           : array[0..2] of char = #18#19#22; // 'AéA'
  ldFirstDir          : array[0..2] of char = #18#22#19; //   'AAé'
  ldMiddleDir         : array[0..2] of char = #32#24#19; //   ' Aé'
  ldLastDir           : array[0..2] of char = #32#18#19; //   ' Aé'
  ldIndentSize        : String[10] = '  ';

  ldDesktopBackground : char = #14;  // ¯
  ldSubMenuArrow      : char = #04;  //

  ldVerticalBar       : char = #20;  // 3
  ldHorizontalBar     : char = #19;  // é
  ldDblHorizontalBar  : char = #30;  // I
  ldBlockFull         : char = #12;  // U
  ldBlockBottom       : char = #08;  // ö
  ldBlockTop          : char = #09;  // ·
  ldRadioSelect       : char = #07;  //
  ldModified          : char = '*';
  ldLeftScroll        : char = #03;
  ldRightScroll       : char = #04;
{$ELSE}
  ldFrameChars        : array[0..31] of Char = '   ¿ ≥⁄√ Ÿƒ¡ø¥¬≈   » ∫…∫ ºÕÕª∫Õ ';
{ Codepage = 437 :                             '   ¿ ≥⁄√ Ÿƒ¡ø¥¬≈   » ∫…« ºÕœª∂— '; }

  ldMenuFrameChars    : array[0..19] of Char = ' ⁄ƒø  ¿ƒŸ  ≥ ≥  √ƒ¥ ';

  ldCloseWindow       : array[0..4] of char = '[~˛~]';
  ldCloseClicked      : array[0..4] of char = '[~'#15'~]';
  ldMaximize          : array[0..4] of char = '[~'#24'~]';
  ldBottomRight       : array[0..3] of char = '~ƒŸ~';

  ldVerticalScroll    : TScrollChars = #30#31#177#254#178;
  ldHorizontalScroll  : TScrollChars = #17#16#177#254#178;

  ldHistoryDropDown   : array[0..4] of char = #222'~'#25'~'#221;

  ldPathDir           : array[0..2] of char = '¿ƒ¬';
  ldFirstDir          : array[0..2] of char =   '¿¬ƒ';
  ldMiddleDir         : array[0..2] of char =   ' √ƒ';
  ldLastDir           : array[0..2] of char =   ' ¿ƒ';
  ldIndentSize        : String[10] = '  ';

  ldDesktopBackground : char = #176; // ∞
  ldSubMenuArrow      : char = #16;  //

  ldVerticalBar       : char = #179; // ≥
  ldHorizontalBar     : char = #196; // ƒ
  ldDblHorizontalBar  : char = #205; // Õ
  ldBlockFull         : char = #219; // €
  ldBlockBottom       : char = #220; // ‹
  ldBlockTop          : char = #223; // ﬂ
  ldRadioSelect       : char = #7;   //
  ldModified          : char = #15;
  ldLeftScroll        : char = #16;
  ldRightScroll       : char = #17;
{$ENDIF}

type
  PDrawBuffer = ^TDrawBuffer;
  TstatVar2 = record
    target : PView;
    offset,y : integer;
  end;
var
  staticVar1 : PDrawBuffer;
  staticVar2 : TstatVar2;

implementation

uses W32SysLow;

type
  PFixupList = ^TFixupList;
  TFixupList = array[1..4096] of Pointer;

const
  OwnerGroup: PGroup = nil;
  FixupList: PFixupList = nil;
  TheTopView: PView = nil;

const

{ Bit flags to determine how to draw the frame icons }

  fmCloseClicked = $0001;
  fmZoomClicked  = $0002;

{ Current command set. All but window commands are active by default }

  CurCommandSet: TCommandSet =
    [0..255] - [cmZoom, cmClose, cmResize, cmNext, cmPrev];

{ Convert color into attribute                          }
{ In    AL = Color                                      }
{ Out   AL = Attribute                                  }

function TView.MapColor (color: Byte): Byte;
var
  cur : PView;
  p   : PPalette;
begin
  if color=0 then
   MapColor:=errorAttr
  else
   begin
     cur:=@Self;
     repeat
       p:=cur^.GetPalette;
       if (p<>Nil) then
        if ord(p^[0])<>0 then
         begin
           if color>ord(p^[0]) then
            begin
              MapColor:=errorAttr;
              Exit;
            end;
           color:=ord(p^[color]);
           if color=0 then
            begin
              MapColor:=errorAttr;
              Exit;
            end;
         end;
       cur:=cur^.Owner;
     until (cur=Nil);
     MapColor:=color;
   end;
end;

procedure TView.do_writeViewRec1(x1,x2:Sw_integer; p:PView; shadowCounter:Sw_integer);
var
  G      : PGroup;
  BufPos,
  SrcPos,
  l,d,dx : Sw_integer;
  TopScr : boolean;
begin
  repeat
    p:=p^.Next;
    if p = nil then
      break;
    if (p=staticVar2.target) then
     begin
       G:=p^.Owner;
       if (G^.buffer<>Nil) then
       begin
          BufPos:=G^.size.x * staticVar2.y + x1;
          SrcPos:=x1 - staticVar2.offset;
          l:=x2-x1;
          TopScr:=(G^.buffer=PVideoBuf(ScreenBuffer));
          if (shadowCounter=0) then
           move(staticVar1^[SrcPos],PVideoBuf(G^.buffer)^[BufPos],l shl 1)
          else
          begin { paint with shadowAttr }
            while (l>0) do
            begin
              d:=staticVar1^[SrcPos] and ($FF or (shadowAttr shl 8));
              PVideoBuf(G^.buffer)^[BufPos]:=d;
              inc(BufPos);
              inc(SrcPos);
              dec(l);
            end;
          end;

          if G^.buffer = ScreenBuffer then
          begin
            ConsoleOutput(x1, x2, staticVar2.y);
          end
       end;
       if G^.lockFlag=0 then
         do_writeViewRec2(x1,x2,G,shadowCounter);
       exit;
     end; { p=staticVar2.target }

    if ((p^.state and sfVisible)<>0) and (staticVar2.y>=p^.Origin.Y) then
     begin
       if staticVar2.y<p^.Origin.Y+p^.size.Y then
        begin
          if x1<p^.origin.x then
           begin
             if x2<=p^.origin.x then
              continue;
             do_writeViewRec1(x1,p^.origin.x,p,shadowCounter);
             x1:=p^.origin.x;
           end;
          dx:=p^.origin.x+p^.size.x;
          if (x2<=dx) then
           exit;
          if (x1<dx) then
           x1:=dx;
          inc(dx,shadowSize.x);
          if ((p^.state and sfShadow)<>0) and (staticVar2.y>=p^.origin.y+shadowSize.y) then
           if (x1>dx) then
            continue
           else
            begin
              inc(shadowCounter);
              if (x2<=dx) then
               continue
              else
               begin
                 do_writeViewRec1(x1,dx,p,shadowCounter);
                 x1:=dx;
                 dec(shadowCounter);
                 continue;
               end;
            end
           else
            continue;
        end;

       if ((p^.state and sfShadow)<>0) and (staticVar2.y<p^.origin.y+p^.size.y+shadowSize.y) then
        begin
          dx:=p^.origin.x+shadowSize.x;
          if x1<dx then
           begin
             if x2<=dx then
              continue;
             do_writeViewRec1(x1,dx,p,shadowCounter);
             x1:=dx;
           end;
          inc(dx,p^.size.x);
          if x1>=dx then
           continue;
          inc(shadowCounter);
          if x2<=dx then
           continue
          else
           begin
             do_writeViewRec1(x1,dx,p,shadowCounter);
             x1:=dx;
             dec(shadowCounter);
           end;
        end;
     end;
  until false;
end;


procedure TView.do_writeViewRec2(x1,x2:Sw_integer; p:PView; shadowCounter:Sw_integer);
var
  savedStatics : TstatVar2;
  dx : Sw_integer;
  G  : PGroup;
begin
  G:=P^.Owner;
  if ((p^.State and sfVisible) <> 0) and (G<>Nil) then
   begin
     savedStatics:=staticVar2;
     inc(staticVar2.y,p^.Origin.Y);
     dx:=p^.Origin.X;
     inc(x1,dx);
     inc(x2,dx);
     inc(staticVar2.offset,dx);
     staticVar2.target:=p;
     if (staticVar2.y >= G^.clip.a.y) and (staticVar2.y < G^.clip.b.y) then
      begin
        if (x1<g^.clip.a.x) then
         x1 := g^.clip.a.x;
        if (x2>g^.clip.b.x) then
         x2 := g^.clip.b.x;
        if x1<x2 then
         do_writeViewRec1(x1,x2,G^.Last,shadowCounter);
      end;
     staticVar2 := savedStatics;
   end;
end;


procedure TView.WriteView(x1,x2,y:Sw_integer; var Buf);
begin
  if (y>=0) and (y<Size.Y) then
   begin
     if x1<0 then
      x1:=0;
     if x2>Size.X then
      x2:=Size.X;
     if x1<x2 then
      begin
        staticVar2.offset:=x1;
        staticVar2.y:=y;
        staticVar1:=@Buf;
        do_writeViewRec2( x1, x2, @Self, 0 );
      end;
   end;
end;


procedure TView.WriteBuf(X, Y, W, H: Sw_Integer; var Buf);
var
  i : Sw_integer;
begin
  if h>0 then
   for i:= 0 to h-1 do
    writeView(X,X+W,Y+i,TVideoBuf(Buf)[W*i]);
end;

procedure TView.WriteChar(X, Y: Integer; C: Char; Color: Byte;
  Count: Integer);
var
  b: array[0..MaxViewWidth] of SmallWord;
  myChar: SmallWord;
  count2: integer;
  p: PSmallWord;
begin
  count2 := count;
  myChar := (MapColor(Color) shl 8) + Ord(C);
  if x<0 then x := 0;
  if x+count>maxViewWidth then exit;
  p := @b;
  while count > 0 do
  begin
    p^ := myChar;
    inc(p);
    dec(count);
  end;
  WriteView(x, x+count2, y, b);
end;

procedure TView.WriteLine(X, Y, W, H: Integer; var Buf);
var
  i: integer;
begin
  if h = 0 then exit;
  for i := 0 to h-1 do
    WriteView(x, x+w, y+i, buf);
end;

procedure TView.WriteStr(X, Y: Integer; const Str: String; Color: Byte);
var
  l, Ind: integer;
  myColor: SmallWord;
  b: array[0..MaxViewWidth] of SmallWord;
  p: PSmallWord;
begin
  l := Length(Str);
  if l = 0 then exit;
  if l > MaxViewWidth then l := MaxViewWidth;
  myColor := MapColor(Color) shl 8;
  p := @b;
  Ind := 1;
  while Ind <= Length(Str) do
  begin
    p^ := (myColor+Ord(Str[Ind]));
    inc(p);
    inc(Ind);
  end;
  WriteView(x, x+12, y, b);
end;

constructor TView.Init(var Bounds: TRect);
begin
  TObject.Init;
  Owner := nil;
  State := sfVisible;
  SetBounds(Bounds);
  DragMode := dmLimitLoY;
  HelpCtx := hcNoContext;
  EventMask := evMouseDown + evKeyDown + evCommand;
end;

constructor TView.Load(var S: TStream);
begin
  TObject.Init;
  S.Read(Origin,
    SizeOf(TPoint) * 3 +
    SizeOf(Byte) * 2 +
    SizeOf(Word) * 4);
end;

destructor TView.Done;
begin
  Hide;
  if Owner <> nil then Owner^.Delete(@Self);
end;

procedure TView.Awaken;
begin
end;

procedure TView.BlockCursor;
begin
  SetState(sfCursorIns, True);
end;

procedure TView.CalcBounds(var Bounds: TRect; Delta: TPoint);
var
  S, D: Integer;
  Min, Max: TPoint;

procedure Grow(var I: Integer);
begin
  if GrowMode and gfGrowRel = 0 then Inc(I, D) else
    I := (I * S + (S - D) shr 1) div (S - D);
end;

function Range(Val, Min, Max: Integer): Integer;
begin
  if Val < Min then Range := Min else
    if Val > Max then Range := Max else
      Range := Val;
end;

begin
  GetBounds(Bounds);
  S := Owner^.Size.X;
  D := Delta.X;
  if GrowMode and gfGrowLoX <> 0 then Grow(Bounds.A.X);
  if GrowMode and gfGrowHiX <> 0 then Grow(Bounds.B.X);
  if Bounds.B.X - Bounds.A.X > MaxViewWidth then
    Bounds.B.X := Bounds.A.X + MaxViewWidth;
  S := Owner^.Size.Y;
  D := Delta.Y;
  if GrowMode and gfGrowLoY <> 0 then Grow(Bounds.A.Y);
  if GrowMode and gfGrowHiY <> 0 then Grow(Bounds.B.Y);
  SizeLimits(Min, Max);
  Bounds.B.X := Bounds.A.X + Range(Bounds.B.X - Bounds.A.X, Min.X, Max.X);
  Bounds.B.Y := Bounds.A.Y + Range(Bounds.B.Y - Bounds.A.Y, Min.Y, Max.Y);
end;

procedure TView.ChangeBounds(var Bounds: TRect);
begin
  SetBounds(Bounds);
  DrawView;
end;

procedure TView.ClearEvent(var Event: TEvent);
begin
  Event.What := evNothing;
  Event.InfoPtr := @Self;
end;

function TView.CommandEnabled(Command: Word): Boolean;
begin
  CommandEnabled := (Command > 255) or (Command in CurCommandSet);
end;

function TView.DataSize: Word;
begin
  DataSize := 0;
end;

procedure TView.DisableCommands(Commands: TCommandSet);
begin
  CommandSetChanged := CommandSetChanged or (CurCommandSet * Commands <> []);
  CurCommandSet := CurCommandSet - Commands;
end;

procedure TView.DragView(Event: TEvent; Mode: Byte;
  var Limits: TRect; MinSize, MaxSize: TPoint);
var
  P, S: TPoint;
  SaveBounds: TRect;

function Min(I, J: Integer): Integer;
begin
  if I < J then Min := I else Min := J;
end;

function Max(I, J: Integer): Integer;
begin
  if I > J then Max := I else Max := J;
end;

procedure MoveGrow(P, S: TPoint);
var
  R: TRect;
begin
  S.X := Min(Max(S.X, MinSize.X), MaxSize.X);
  S.Y := Min(Max(S.Y, MinSize.Y), MaxSize.Y);
  P.X := Min(Max(P.X, Limits.A.X - S.X + 1), Limits.B.X - 1);
  P.Y := Min(Max(P.Y, Limits.A.Y - S.Y + 1), Limits.B.Y - 1);
  if Mode and dmLimitLoX <> 0 then P.X := Max(P.X, Limits.A.X);
  if Mode and dmLimitLoY <> 0 then P.Y := Max(P.Y, Limits.A.Y);
  if Mode and dmLimitHiX <> 0 then P.X := Min(P.X, Limits.B.X - S.X);
  if Mode and dmLimitHiY <> 0 then P.Y := Min(P.Y, Limits.B.Y - S.Y);
  R.Assign(P.X, P.Y, P.X + S.X, P.Y + S.Y);
  Locate(R);
end;

procedure Change(DX, DY: Integer);
begin
  if (Mode and dmDragMove <> 0) and (GetShiftState and $03 = 0) then
  begin
    Inc(P.X, DX);
    Inc(P.Y, DY);
  end else
  if (Mode and dmDragGrow <> 0) and (GetShiftState and $03 <> 0) then
  begin
    Inc(S.X, DX);
    Inc(S.Y, DY);
  end;
end;

procedure Update(X, Y: Integer);
begin
  if Mode and dmDragMove <> 0 then
  begin
    P.X := X;
    P.Y := Y;
  end;
end;

begin
  SetState(sfDragging, True);
  if Event.What = evMouseDown then
  begin
    if Mode and dmDragMove <> 0 then
    begin
      P.X := Origin.X - Event.Where.X;
      P.Y := Origin.Y - Event.Where.Y;
      repeat
        Inc(Event.Where.X, P.X);
        Inc(Event.Where.Y, P.Y);
        MoveGrow(Event.Where, Size);
      until not MouseEvent(Event, evMouseMove);
    end else
    begin
      P.X := Size.X - Event.Where.X;
      P.Y := Size.Y - Event.Where.Y;
      repeat
        Inc(Event.Where.X, P.X);
        Inc(Event.Where.Y, P.Y);
        MoveGrow(Origin, Event.Where);
      until not MouseEvent(Event, evMouseMove);
    end;
  end else
  begin
    GetBounds(SaveBounds);
    repeat
      P := Origin;
      S := Size;
      KeyEvent(Event);
      case Event.KeyCode and $FF00 of
        kbLeft: Change(-1, 0);
        kbRight: Change(1, 0);
        kbUp: Change(0, -1);
        kbDown: Change(0, 1);
        kbCtrlLeft: Change(-8, 0);
        kbCtrlRight: Change(8, 0);
        kbHome: Update(Limits.A.X, P.Y);
        kbEnd: Update(Limits.B.X - S.X, P.Y);
        kbPgUp: Update(P.X, Limits.A.Y);
        kbPgDn: Update(P.X, Limits.B.Y - S.Y);
      end;
      MoveGrow(P, S);
    until (Event.KeyCode = kbEnter) or (Event.KeyCode = kbEsc);
    if Event.KeyCode = kbEsc then Locate(SaveBounds);
  end;
  SetState(sfDragging, False);
end;

procedure TView.Draw;
var
  B: TDrawBuffer;
begin
  MoveChar(B, ' ', GetColor(1), Size.X);
  WriteLine(0, 0, Size.X, Size.Y, B);
end;

procedure TView.DrawCursor;
begin
  if State and sfFocused <> 0 then ResetCursor;
end;

procedure TView.DrawHide(LastView: PView);
begin
  DrawCursor;
  DrawUnderView(State and sfShadow <> 0, LastView);
end;

procedure TView.DrawShow(LastView: PView);
begin
  DrawView;
  if State and sfShadow <> 0 then DrawUnderView(True, LastView);
end;

procedure TView.DrawUnderRect(var R: TRect; LastView: PView);
begin
  Owner^.Clip.Intersect(R);
  Owner^.DrawSubViews(NextView, LastView);
  Owner^.GetExtent(Owner^.Clip);
end;

procedure TView.DrawUnderView(DoShadow: Boolean; LastView: PView);
var
  R: TRect;
begin
  GetBounds(R);
// AM: Always increase to include shadow rect, to make sure it is
// removed if this option is changed.
// if DoShadow then
  begin
    Inc(R.B.X, ShadowSize.X);
    Inc(R.B.Y, ShadowSize.Y);
  end;
  DrawUnderRect(R, LastView);
end;

procedure TView.DrawView;
begin
  if Exposed then
  begin
    Draw;
    DrawCursor;
  end;
end;

procedure TView.EnableCommands(Commands: TCommandSet);
begin
  CommandSetChanged := CommandSetChanged or
    (CurCommandSet * Commands <> Commands);
  CurCommandSet := CurCommandSet + Commands;
end;

procedure TView.EndModal(Command: Word);
var
  P: PView;
begin
  P := TopView;
  if TopView <> nil then TopView^.EndModal(Command);
end;

function TView.EventAvail: Boolean;
var
  Event: TEvent;
begin
  GetEvent(Event);
  if Event.What <> evNothing then PutEvent(Event);
  EventAvail := Event.What <> evNothing;
end;

procedure TView.GetBounds(var Bounds: TRect);
begin
  Bounds.A.X := Origin.X;
  Bounds.A.Y := Origin.Y;
  Bounds.B.X := Origin.X + Size.X;
  Bounds.B.Y := Origin.Y + Size.Y;
end;

function TView.Execute: Word;
begin
  Execute := cmCancel;
end;

function TView.do_ExposedRec1(x1,x2:sw_integer; p:PView):boolean;
var
  G : PGroup;
  dy,dx : sw_integer;
begin
  while true do
   begin
     p:=p^.Next;
     G:=p^.Owner;
     if p=staticVar2.target then
      begin
        do_exposedRec1:=do_exposedRec2(x1,x2,G);
        Exit;
      end;
     dy:=p^.origin.y;
     dx:=p^.origin.x;
     if ((p^.state and sfVisible)<>0) and (staticVar2.y>=dy) then
      begin
        if staticVar2.y<dy+p^.size.y then
         begin
           if x1<dx then
            begin
              if x2<=dx then
               continue;
              if x2>dx+p^.size.x then
               begin
                 if do_exposedRec1(x1,dx,p) then
                  begin
                    do_exposedRec1:=True;
                    Exit;
                  end;
                 x1:=dx+p^.size.x;
               end
              else
               x2:=dx;
           end
          else
           begin
             if x1<dx+p^.size.x then
              x1:=dx+p^.size.x;
             if x1>=x2 then
              begin
                do_exposedRec1:=False;
                Exit;
              end;
           end;
        end;
      end;
   end;
end;


function TView.do_ExposedRec2(x1,x2:Sw_integer; p:PView):boolean;
var
  G : PGroup;
  savedStat : TStatVar2;
begin
  if (p^.state and sfVisible)=0 then
   do_ExposedRec2:=false
  else
   begin
     G:=p^.Owner;
     if (G=Nil) or (G^.Buffer<>Nil) then
      do_ExposedRec2:=true
     else
      begin
        savedStat:=staticVar2;
        inc(staticVar2.y,p^.origin.y);
        inc(x1,p^.origin.x);
        inc(x2,p^.origin.x);
        staticVar2.target:=p;
        if (staticVar2.y<G^.clip.a.y) or (staticVar2.y>=G^.clip.b.y) then
         do_ExposedRec2:=false
        else
         begin
           if (x1<G^.clip.a.x) then
            x1:=G^.clip.a.x;
           if (x2>G^.clip.b.x) then
            x2:=G^.clip.b.x;
           if (x1>=x2) then
            do_ExposedRec2:=false
           else
            do_ExposedRec2:=do_exposedRec1(x1,x2,G^.Last);
         end;
        staticVar2 := savedStat;
      end;
   end;
end;


function TView.Exposed: Boolean;
var
  OK : boolean;
  y  : sw_integer;
begin
  if ((State and sfExposed)<>0) and (Size.X>0) and (Size.Y>0) then
   begin
     OK:=false;
     y:=0;
     while (y<Size.Y) and (not OK) do
      begin
        staticVar2.y:=y;
        OK:=do_ExposedRec2(0,Size.X,@Self);
        inc(y);
      end;
     Exposed:=OK;
   end
  else
   Exposed:=False
end;



function TView.Focus: Boolean;
begin
  Result := True;
  if State and (sfSelected + sfModal) = 0 then
  begin
    if Owner <> nil then
    begin
      Focus := Owner^.Focus;
      if Result then
        if ((Owner^.Current = nil) or
          (Owner^.Current^.Options and ofValidate = 0) or
          (Owner^.Current^.Valid(cmReleasedFocus))) then
          Select
        else
          Result := False;
    end;
  end;
  Focus := Result;
end;

procedure TView.GetClipRect(var Clip: TRect);
begin
  GetBounds(Clip);
  if Owner <> nil then Clip.Intersect(Owner^.Clip);
  Clip.Move(-Origin.X, -Origin.Y);
end;


function TView.GetColor(Color: Word): Word;
var
  h : word;
begin
  h:=Color shr 8;
  if h<>0 then
    h:=MapColor(h);
  GetColor:=(h shl 8) + MapColor(Color and $FF);
end;

procedure TView.GetCommands(var Commands: TCommandSet);
begin
  Commands := CurCommandSet;
end;

procedure TView.GetData(var Rec);
begin
end;

procedure TView.GetEvent(var Event: TEvent);
begin
  if Owner <> nil then Owner^.GetEvent(Event);
end;

procedure TView.GetExtent(var Extent: TRect);
begin
  Extent.A.X := 0;
  Extent.A.Y := 0;
  Extent.B.X := Size.X;
  Extent.B.Y := Size.Y;
end;

function TView.GetHelpCtx: Word;
begin
  if State and sfDragging <> 0 then
    GetHelpCtx := hcDragging else
    GetHelpCtx := HelpCtx;
end;

function TView.GetPalette: PPalette;
begin
  GetPalette := nil;
end;

procedure TView.GetPeerViewPtr(var S: TStream; var P);
var
  Index: Integer;
begin
  S.Read(Index, SizeOf(Word));
  if (Index = 0) or (OwnerGroup = nil) then Pointer(P) := nil
  else
  begin
    Pointer(P) := FixupList^[Index];
    FixupList^[Index] := @P;
  end;
end;

function TView.GetState(AState: Word): Boolean;
begin
  GetState := State and AState = AState;
end;

procedure TView.GrowTo(X, Y: Integer);
var
  R: TRect;
begin
  R.Assign(Origin.X, Origin.Y, Origin.X + X, Origin.Y + Y);
  Locate(R);
end;

procedure TView.HandleEvent(var Event: TEvent);
begin
  if Event.What = evMouseDown then
    if (State and (sfSelected + sfDisabled) = 0) and
       (Options and ofSelectable <> 0) then
      if not Focus or (Options and ofFirstClick = 0) then
        ClearEvent(Event);
end;

procedure TView.Hide;
begin
  if State and sfVisible <> 0 then SetState(sfVisible, False);
end;

procedure TView.HideCursor;
begin
  SetState(sfCursorVis, False);
end;

procedure TView.KeyEvent(var Event: TEvent);
begin
  repeat GetEvent(Event) until Event.What = evKeyDown;
end;

procedure TView.Locate(var Bounds: TRect);
var
  R: TRect;
  Min, Max: TPoint;

function Range(Val, Min, Max: Integer): Integer;
begin
  if Val < Min then Range := Min else
    if Val > Max then Range := Max else
      Range := Val;
end;

begin
  SizeLimits(Min, Max);
  Bounds.B.X := Bounds.A.X + Range(Bounds.B.X - Bounds.A.X, Min.X, Max.X);
  Bounds.B.Y := Bounds.A.Y + Range(Bounds.B.Y - Bounds.A.Y, Min.Y, Max.Y);
  GetBounds(R);
  if not Bounds.Equals(R) then
  begin
    ChangeBounds(Bounds);
    if (Owner <> nil) and (State and sfVisible <> 0) then
    begin
      if State and sfShadow <> 0 then
      begin
        R.Union(Bounds);
        Inc(R.B.X, ShadowSize.X);
        Inc(R.B.Y, ShadowSize.Y);
      end;
      DrawUnderRect(R, nil);
    end;
  end;
end;

procedure TView.MakeFirst;
begin
  PutInFrontOf(Owner^.First);
end;


procedure TPointInc(var A:TPoint; B:TPoint);
begin
  inc(A.X,B.X);
  inc(A.Y,B.Y);
end;

procedure TPointDec(var A:TPoint; B:TPoint);
begin
  dec(A.X,B.X);
  dec(A.Y,B.Y);
end;

procedure TView.MakeGlobal(Source: TPoint; var Dest: TPoint);
var
  cur:PView;
begin
  cur:=@Self; Dest:=Source;
  TPointInc(Dest,Origin);
  while cur^.Owner<>Nil do
   begin
     cur:=cur^.Owner;
     TPointInc(Dest,cur^.Origin);
   end;
end;


procedure TView.MakeLocal(Source: TPoint; var Dest: TPoint);
var
  cur:PView;
begin
  cur:=@Self; Dest:=Source;
  TPointDec(Dest,Origin);
  while cur^.Owner<>Nil do
   begin
     cur:=cur^.Owner;
     TPointDec(Dest,cur^.Origin);
   end;
end;

function TView.MouseEvent(var Event: TEvent; Mask: Word): Boolean;
begin
  repeat GetEvent(Event) until Event.What and (Mask or evMouseUp) <> 0;
  MouseEvent := Event.What <> evMouseUp;
end;

function TView.MouseInView(Mouse: TPoint): Boolean;
var
  Extent: TRect;
begin
  MakeLocal(Mouse, Mouse);
  GetExtent(Extent);
  MouseInView := Extent.Contains(Mouse);
end;

procedure TView.MoveTo(X, Y: Integer);
var
  R: TRect;
begin
  R.Assign(X, Y, X + Size.X, Y + Size.Y);
  Locate(R);
end;

function TView.NextView: PView;
begin
  if @Self = Owner^.Last then NextView := nil else NextView := Next;
end;

procedure TView.NormalCursor;
begin
  SetState(sfCursorIns, False);
end;

{[eax] - self}
function TView.Prev: PView;
begin
  Result := @Self;
  while (Result <> nil) and (Result.Next <> @Self) do
      Result := Result.Next;
end;

function TView.PrevView: PView;
begin
  if @Self = Owner^.First then PrevView := nil else PrevView := Prev;
end;

procedure TView.PutEvent(var Event: TEvent);
begin
  if Owner <> nil then Owner^.PutEvent(Event);
end;

procedure TView.PutInFrontOf(Target: PView);
var
  P, LastView: PView;

procedure MoveView;
begin
  Owner^.RemoveView(@Self);
  Owner^.InsertView(@Self, Target);
end;

begin
  if (Owner <> nil) and (Target <> @Self) and (Target <> NextView) and
    ((Target = nil) or (Target^.Owner = Owner)) then
    if State and sfVisible = 0 then MoveView else
    begin

      LastView := NextView;
      if LastView <> nil then
      begin
        P := Target;
        while (P <> nil) and (P <> LastView) do P := P^.NextView;
        if P = nil then LastView := Target;
      end;
      State := State and not sfVisible;
      if LastView = Target then DrawHide(LastView);
      MoveView;
      State := State or sfVisible;
      if LastView <> Target then DrawShow(LastView);
      if Options and ofSelectable <> 0 then
      begin
        Owner^.ResetCurrent;
        Owner^.ResetCursor;
      end;
    end;
end;

procedure TView.PutPeerViewPtr(var S: TStream; P: PView);
var
  Index: Integer;
begin
  if (P = nil) or (OwnerGroup = nil) then Index := 0
  else Index := OwnerGroup^.IndexOf(P);
  S.Write(Index, SizeOf(Word));
end;

procedure TView.ResetCursor; pascal;
const
  sfV_CV_F:word = sfVisible + sfCursorVis + sfFocused;
var
  p,p2 : PView;
  G : PGroup;
  cur : TPoint;

  function Check0:boolean;
  var
    res : byte;
  begin
    res:=0;
    while res=0 do
     begin
       p:=p^.next;
       if p=p2 then
        begin
          p:=P^.owner;
          res:=1
        end
       else
        if ((p^.state and sfVisible)<>0) and
           (cur.x>=p^.origin.x) and
           (cur.x<p^.size.x+p^.origin.x) and
           (cur.y>=p^.origin.y) and
           (cur.y<p^.size.y+p^.origin.y) then
          res:=2;
     end;
    Check0:=res=2;
  end;

begin
  if (state and sfV_CV_F) = sfV_CV_F then
   begin
     p:=@Self;
     cur:=cursor;
     while true do
      begin
        if (cur.x<0) or (cur.x>=p^.size.x) or
           (cur.y<0) or (cur.y>=p^.size.y) then
          break;
        TPointInc(cur,p^.origin);
        p2:=p;
        G:=p^.owner;
        if G=Nil then { top view }
         begin
           SysTVSetCurPos(cur.x,cur.y);
           if (state and sfCursorIns)<>0 then
            SetCursorType(crBlock)
           else
            SetCursorType(crUnderline);
           exit;
         end;
        if (G^.state and sfVisible)=0 then
         break;
        p:=G^.Last;
        if Check0 then
         break;
      end; { while }
   end; { if }
  SetCursorType(crHidden);
end;

procedure TView.Select;
begin
  if Options and ofSelectable <> 0 then
    if Options and ofTopSelect <> 0 then MakeFirst else
      if Owner <> nil then Owner^.SetCurrent(@Self, NormalSelect);
end;

procedure TView.SetBounds(var Bounds: TRect);
begin
  origin:=bounds.a;
  size:=bounds.b;
  TPointDec(size,origin);
end;

procedure TView.SetCmdState(Commands: TCommandSet; Enable: Boolean);
begin
  if Enable then EnableCommands(Commands)
  else DisableCommands(Commands);
end;

procedure TView.SetCommands(Commands: TCommandSet);
begin
  CommandSetChanged := CommandSetChanged or (CurCommandSet <> Commands);
  CurCommandSet := Commands;
end;

procedure TView.SetCursor(X, Y: Integer);
begin
  Cursor.X := X;
  Cursor.Y := Y;
  DrawCursor;
end;

procedure TView.SetData(var Rec);
begin
end;

procedure TView.SetState(AState: Word; Enable: Boolean);
var
  Command: Word;
begin
  if Enable then
    State := State or AState else
    State := State and not AState;
  if Owner <> nil then
    case AState of
      sfVisible:
        begin
          if Owner^.State and sfExposed <> 0 then
            SetState(sfExposed, Enable);
          if Enable then DrawShow(nil) else DrawHide(nil);
          if Options and ofSelectable <> 0 then Owner^.ResetCurrent;
        end;
      sfCursorVis, sfCursorIns:
        DrawCursor;
      sfShadow:
        DrawUnderView(State and sfShadow <> 0, nil);
      sfFocused:
        begin
          ResetCursor;
          if Enable then
            Command := cmReceivedFocus else
            Command := cmReleasedFocus;
          Message(Owner, evBroadcast, Command, @Self);
        end;
    end;
end;

procedure TView.Show;
begin
  if State and sfVisible = 0 then SetState(sfVisible, True);
end;

procedure TView.ShowCursor;
begin
  SetState(sfCursorVis, True);
end;

procedure TView.SizeLimits(var Min, Max: TPoint);
begin
  Min.X := 0;
  Min.Y := 0;
  if Owner <> nil then Max := Owner^.Size
 else
  begin
    Max.X := MaxLongint;
    Max.Y := MaxLongint;
  end;
end;

procedure TView.Store(var S: TStream);
var
  SaveState: Word;
begin
  SaveState := State;
  State := State and not (sfActive + sfSelected + sfFocused + sfExposed);
  S.Write(Origin,
    SizeOf(TPoint) * 3 +
    SizeOf(Byte) * 2 +
    SizeOf(Word) * 4);
  State := SaveState;
end;

function TView.TopView: PView;
var
  P: PView;
begin
  if TheTopView = nil then
  begin
    P := @Self;
    while (P <> nil) and (P^.State and sfModal = 0) do P := P^.Owner;
    TopView := P;
  end
  else TopView := TheTopView;
end;

function TView.Valid(Command: Word): Boolean;
begin
  Valid := True;
end;

{ TFrame }

constructor TFrame.Init(var Bounds: TRect);
begin
  TView.Init(Bounds);
  GrowMode := gfGrowHiX + gfGrowHiY;
  EventMask := EventMask or evBroadcast;
end;

procedure TFrame.FrameLine(var FrameBuf; Y, N: Integer;
  Color: Byte);
const
  InitFrame: array[0..17] of Byte =
    ($06, $0A, $0C, $05, $00, $05, $03, $0A, $09,
     $16, $1A, $1C, $15, $00, $15, $13, $1A, $19);
var
  FrameMask: array[0..MaxViewWidth-1] of Byte;
asm

                push ebx
                push edi
                push esi
                mov     ebx,Self
                mov     edx,[ebx].TFrame.Size.X
                lea     ecx,[edx-2]
                mov     esi,OFFSET InitFrame
                add     esi,N
                lea     edi,FrameMask
                cld
                movsb
                lodsb
                rep     stosb
                movsb
                mov     ebx,[ebx].TFrame.Owner
                mov     ebx,[ebx].TGroup.Last
                dec     edx
              @@1:
                mov     ebx,[ebx].TView.Next
                cmp     ebx,Self
                je      @@10
              @@2:
                test    [ebx].TView.Options,ofFramed
                je      @@1
                test    [ebx].TView.State,sfVisible
                je      @@1
                mov     eax,Y
                sub     eax,[ebx].TView.Origin.Y
                jl      @@3
                cmp     eax,[ebx].TView.Size.Y
                jg      @@1
                mov     ax,0005h
                jl      @@4
                mov     ax,0A03h
                jmp     @@4
              @@3:
                inc     eax
                jne     @@1
                mov     ax,0A06h
              @@4:
                mov     esi,[ebx].TView.Origin.X
                mov     edi,[ebx].TView.Size.X
                add     edi,esi
                cmp     esi,1
                jg      @@5
                xor     esi,esi
                inc     esi
              @@5:
                cmp     edi,edx
                jl      @@6
                mov     edi,edx
              @@6:
                cmp     esi,edi
                jge     @@1
                or      Byte Ptr FrameMask[esi-1],AL
                xor     al,ah
                or      Byte Ptr FrameMask[edi],AL
                test    ah,ah
                jz      @@1
                mov     ecx,edi
                sub     ecx,esi
              @@8:
                or      Byte Ptr FrameMask[esi],ah
                inc     esi
                loop    @@8
                jmp     @@1
              @@10:
                inc     edx
                mov     ah,Color
                mov     ebx,OFFSET ldFrameChars
                mov     ecx,edx
                lea     esi,FrameMask
                mov     edi,FrameBuf
              @@11:
                lodsb
                xlat
                stosw
                loop    @@11
                pop esi
                pop edi
                pop ebx
end;

procedure TFrame.Draw;
var
  CFrame, CTitle: Word;
  F, I, L, Width: Integer;
  B: TDrawBuffer;
  Title: TTitleStr;
  Min, Max: TPoint;
begin
  if State and sfDragging <> 0 then
  begin
    CFrame := $0505;
    CTitle := $0005;
    F := 0;
  end else if State and sfActive = 0 then
  begin
    CFrame := $0101;
    CTitle := $0002;
    F := 0;
  end else
  begin
    CFrame := $0503;
    CTitle := $0004;
    F := 9;
  end;
  CFrame := GetColor(CFrame);
  CTitle := GetColor(CTitle);
  Width := Size.X;
  L := Width - 10;
  if PWindow(Owner)^.Flags and (wfClose+wfZoom) <> 0 then Dec(L,6);
  FrameLine(B, 0, F, Byte(CFrame));
  if (PWindow(Owner)^.Number <> wnNoNumber) and
     (PWindow(Owner)^.Number < 10) then
  begin
    Dec(L,4);
    if PWindow(Owner)^.Flags and wfZoom <> 0 then I := 7
    else I := 3;
    WordRec(B[Width - I]).Lo := PWindow(Owner)^.Number + $30;
  end;
  if Owner <> nil then Title := PWindow(Owner)^.GetTitle(L)
  else Title := '';
  if Title <> '' then
  begin
    L := Length(Title);
    if L > Width - 10 then L := Width - 10;
    if L < 0 then L := 0;
    I := (Width - L) shr 1;
    MoveChar(B[I - 1], ' ', CTitle, 1);
    MoveBuf(B[I], Title[1], CTitle, L);
    MoveChar(B[I + L], ' ', CTitle, 1);
  end;
  if State and sfActive <> 0 then
  begin
    if PWindow(Owner)^.Flags and wfClose <> 0 then
      if FrameMode and fmCloseClicked = 0 then
        MoveCStr(B[2], ldCloseWindow, CFrame)
      else MoveCStr(B[2], ldCloseClicked, CFrame);
    if PWindow(Owner)^.Flags and wfZoom <> 0 then
    begin
      MoveCStr(B[Width - 5], ldMaximize, CFrame);
      Owner^.SizeLimits(Min, Max);
      if FrameMode and fmZoomClicked <> 0 then
        WordRec(B[Width - 4]).Lo := 15
      else if (Owner^.Size.X = Max.X) and (Owner^.Size.Y = Max.Y) then
        WordRec(B[Width - 4]).Lo := 18;
    end;
  end;
  WriteLine(0, 0, Size.X, 1, B);
  for I := 1 to Size.Y - 2 do
  begin
    FrameLine(B, I, F + 3, Byte(CFrame));
    WriteLine(0, I, Size.X, 1, B);
  end;
  FrameLine(B, Size.Y - 1, F + 6, Byte(CFrame));
  if State and sfActive <> 0 then
    if PWindow(Owner)^.Flags and wfGrow <> 0 then
      MoveCStr(B[Width - 2], ldBottomRight, CFrame);
  WriteLine(0, Size.Y - 1, Size.X, 1, B);
end;

function TFrame.GetPalette: PPalette;
const
  P: String[Length(CFrame)] = CFrame;
begin
  GetPalette := @P;
end;

procedure TFrame.HandleEvent(var Event: TEvent);
var
  Mouse: TPoint;

procedure DragWindow(Mode: Byte);
var
  Limits: TRect;
  Min, Max: TPoint;
begin
  Owner^.Owner^.GetExtent(Limits);
  Owner^.SizeLimits(Min, Max);
  Owner^.DragView(Event, Owner^.DragMode or Mode, Limits, Min, Max);
  ClearEvent(Event);
end;

begin
  TView.HandleEvent(Event);
  if Event.What = evMouseDown then
  begin
    MakeLocal(Event.Where, Mouse);
    if Mouse.Y = 0 then
    begin
      if (PWindow(Owner)^.Flags and wfClose <> 0) and
        (State and sfActive <> 0) and (Mouse.X >= 2) and (Mouse.X <= 4) then
      begin
        repeat
          MakeLocal(Event.Where, Mouse);
          if (Mouse.X >= 2) and (Mouse.X <= 4) and (Mouse.Y = 0) then
            FrameMode := fmCloseClicked
          else FrameMode := 0;
          DrawView;
        until not MouseEvent(Event, evMouseMove + evMouseAuto);
        FrameMode := 0;
        if (Mouse.X >= 2) and (Mouse.X <= 4) and (Mouse.Y = 0) then
        begin
          Event.What := evCommand;
          Event.Command := cmClose;
          Event.InfoPtr := Owner;
          PutEvent(Event);
        end;
        ClearEvent(Event);
        DrawView;
      end else
        if (PWindow(Owner)^.Flags and wfZoom <> 0) and
          (State and sfActive <> 0) and (Event.Double or
          (Mouse.X >= Size.X - 5) and
          (Mouse.X <= Size.X - 3)) then
        begin
          if not Event.Double then
            repeat
              MakeLocal(Event.Where, Mouse);
              if (Mouse.X >= Size.X - 5) and (Mouse.X <= Size.X - 3) and
                (Mouse.Y = 0) then
                FrameMode := fmZoomClicked
              else FrameMode := 0;
              DrawView;
            until not MouseEvent(Event, evMouseMove + evMouseAuto);
          FrameMode := 0;
          if ((Mouse.X >= Size.X - 5) and (Mouse.X <= Size.X - 3) and
              (Mouse.Y = 0)) or Event.Double then
          begin
            Event.What := evCommand;
            Event.Command := cmZoom;
            Event.InfoPtr := Owner;
            PutEvent(Event);
          end;
          ClearEvent(Event);
          DrawView;
        end else
          if PWindow(Owner)^.Flags and wfMove <> 0 then
            DragWindow(dmDragMove);
    end else
      if (State and sfActive <> 0) and (Mouse.X >= Size.X - 2) and
          (Mouse.Y >= Size.Y - 1) then
        if PWindow(Owner)^.Flags and wfGrow <> 0 then
          DragWindow(dmDragGrow);
  end;
end;

procedure TFrame.SetState(AState: Word; Enable: Boolean);
begin
  TView.SetState(AState, Enable);
  if AState and (sfActive + sfDragging) <> 0 then DrawView;
end;

{ TScrollBar }

constructor TScrollBar.Init(var Bounds: TRect);
begin
  TView.Init(Bounds);
  Value := 0;
  Min := 0;
  Max := 0;
  PgStep := 1;
  ArStep := 1;
  if Size.X = 1 then
  begin
    GrowMode := gfGrowLoX + gfGrowHiX + gfGrowHiY;
    Chars := ldVerticalScroll;
  end else
  begin
    GrowMode := gfGrowLoY + gfGrowHiX + gfGrowHiY;
    Chars := ldHorizontalScroll;
  end;
end;

constructor TScrollBar.Load(var S: TStream);
begin
  TView.Load(S);
  S.Read(Value, SizeOf(Integer) * 5 + SizeOf(TScrollChars));
end;

procedure TScrollBar.Draw;
begin
  DrawPos(GetPos);
end;

procedure TScrollBar.DrawPos(Pos: Integer);
var
  S: Integer;
  B: TDrawBuffer;
begin
  S := GetSize - 1;
  MoveChar(B[0], Chars[0], GetColor(2), 1);
  if Max = Min then
    MoveChar(B[1], Chars[4], GetColor(1), S - 1)
  else
  begin
    MoveChar(B[1], Chars[2], GetColor(1), S - 1);
    MoveChar(B[Pos], Chars[3], GetColor(3), 1);
  end;
  MoveChar(B[S], Chars[1], GetColor(2), 1);
  WriteBuf(0, 0, Size.X, Size.Y, B);
end;

function TScrollBar.GetPalette: PPalette;
const
  P: String[Length(CScrollBar)] = CScrollBar;
begin
  GetPalette := @P;
end;

function TScrollBar.GetPos: Integer;
var
  R: Integer;
begin
  R := Max - Min;
  if R = 0 then
    GetPos := 1 else
    GetPos := ((Value - Min) * (GetSize - 3) + R shr 1) div R + 1;
end;

function TScrollBar.GetSize: Integer;
var
  S: Integer;
begin
  if Size.X = 1 then S := Size.Y else S := Size.X;
  if S < 3 then GetSize := 3 else GetSize := S;
end;

procedure TScrollBar.HandleEvent(var Event: TEvent);
var
  Tracking: Boolean;
  I, P, S, ClickPart: Integer;
  Mouse: TPoint;
  Extent: TRect;

function GetPartCode: Integer;
var
  Mark, Part: Integer;
begin
  Part := -1;
  if Extent.Contains(Mouse) then
  begin
    if Size.X = 1 then Mark := Mouse.Y else Mark := Mouse.X;
    if Mark = P then Part := sbIndicator else
    begin
      if Mark < 1 then Part := sbLeftArrow else
        if Mark < P then Part := sbPageLeft else
          if Mark < S then Part := sbPageRight else
            Part := sbRightArrow;
      if Size.X = 1 then Inc(Part, 4);
    end;
  end;
  GetPartCode := Part;
end;

procedure Clicked;
begin
  Message(Owner, evBroadcast, cmScrollBarClicked, @Self);
end;

begin
  TView.HandleEvent(Event);
  case Event.What of
    evMouseDown:
      begin
        Clicked;
        MakeLocal(Event.Where, Mouse);
        GetExtent(Extent);
        Extent.Grow(1, 1);
        P := GetPos;
        S := GetSize - 1;
        ClickPart := GetPartCode;
        if ClickPart <> sbIndicator then
        begin
          repeat
            MakeLocal(Event.Where, Mouse);
            if GetPartCode = ClickPart then
              SetValue(Value + ScrollStep(ClickPart));
          until not MouseEvent(Event, evMouseAuto);
        end else
        begin
          repeat
            MakeLocal(Event.Where, Mouse);
            Tracking := Extent.Contains(Mouse);
            if Tracking then
            begin
              if Size.X = 1 then I := Mouse.Y else I := Mouse.X;
              if I <= 0 then I := 1;
              if I >= S then I := S - 1;
            end else I := GetPos;
            if I <> P then
            begin
              DrawPos(I);
              P := I;
            end;
          until not MouseEvent(Event, evMouseMove);
          if Tracking and (S > 2) then
          begin
            Dec(S, 2);
            SetValue(((P - 1) * (Max - Min) + S shr 1) div S + Min);
          end;
        end;
        ClearEvent(Event);
      end;
    evKeyDown:
      if State and sfVisible <> 0 then
      begin
        ClickPart := sbIndicator;
        if Size.Y = 1 then
          case CtrlToArrow(Event.KeyCode) of
            kbLeft: ClickPart := sbLeftArrow;
            kbRight: ClickPart := sbRightArrow;
            kbCtrlLeft: ClickPart := sbPageLeft;
            kbCtrlRight: ClickPart := sbPageRight;
            kbHome: I := Min;
            kbEnd: I := Max;
          else
            Exit;
          end
        else
          case CtrlToArrow(Event.KeyCode) of
            kbUp: ClickPart := sbUpArrow;
            kbDown: ClickPart := sbDownArrow;
            kbPgUp: ClickPart := sbPageUp;
            kbPgDn: ClickPart := sbPageDown;
            kbCtrlPgUp: I := Min;
            kbCtrlPgDn: I := Max;
          else
            Exit;
          end;
        Clicked;
        if ClickPart <> sbIndicator then I := Value + ScrollStep(ClickPart);
        SetValue(I);
        ClearEvent(Event);
      end;
  end;
end;

procedure TScrollBar.ScrollDraw;
begin
  Message(Owner, evBroadcast, cmScrollBarChanged, @Self);
end;

function TScrollBar.ScrollStep(Part: Integer): Integer;
var
  Step: Integer;
begin
  if Part and 2 = 0 then Step := ArStep else Step := PgStep;
  if Part and 1 = 0 then ScrollStep := -Step else ScrollStep := Step;
end;

procedure TScrollBar.SetParams(AValue, AMin, AMax, APgStep,
  AArStep: Integer);
var
  SValue: Integer;
begin
  if AMax < AMin then AMax := AMin;
  if AValue < AMin then AValue := AMin;
  if AValue > AMax then AValue := AMax;
  SValue := Value;
  if (SValue <> AValue) or (Min <> AMin) or (Max <> AMax) then
  begin
    Value := AValue;
    Min := AMin;
    Max := AMax;
    DrawView;
    if SValue <> AValue then ScrollDraw;
  end;
  PgStep := APgStep;
  ArStep := AArStep;
end;

procedure TScrollBar.SetRange(AMin, AMax: Integer);
begin
  SetParams(Value, AMin, AMax, PgStep, ArStep);
end;

procedure TScrollBar.SetStep(APgStep, AArStep: Integer);
begin
  SetParams(Value, Min, Max, APgStep, AArStep);
end;

procedure TScrollBar.SetValue(AValue: Integer);
begin
  SetParams(AValue, Min, Max, PgStep, ArStep);
end;

procedure TScrollBar.Store(var S: TStream);
begin
  TView.Store(S);
  S.Write(Value, SizeOf(Integer) * 5 + SizeOf(TScrollChars));
end;

{ TScroller }

constructor TScroller.Init(var Bounds: TRect; AHScrollBar,
  AVScrollBar: PScrollBar);
begin
  TView.Init(Bounds);
  Options := Options or ofSelectable;
  EventMask := EventMask or evBroadcast;
  HScrollBar := AHScrollBar;
  VScrollBar := AVScrollBar;
end;

constructor TScroller.Load(var S: TStream);
begin
  TView.Load(S);
  GetPeerViewPtr(S, HScrollBar);
  GetPeerViewPtr(S, VScrollBar);
  S.Read(Delta, SizeOf(TPoint)*2);
end;

procedure TScroller.ChangeBounds(var Bounds: TRect);
begin
  SetBounds(Bounds);
  Inc(DrawLock);
  SetLimit(Limit.X, Limit.Y);
  Dec(DrawLock);
  DrawFlag := False;
  DrawView;
end;

procedure TScroller.CheckDraw;
begin
  if (DrawLock = 0) and DrawFlag then
  begin
    DrawFlag := False;
    DrawView;
  end;
end;

function TScroller.GetPalette: PPalette;
const
  P: String[Length(CScroller)] = CScroller;
begin
  GetPalette := @P;
end;

procedure TScroller.HandleEvent(var Event: TEvent);
begin
  TView.HandleEvent(Event);
  if (Event.What = evBroadcast) and (Event.Command = cmScrollBarChanged) and
     ((Event.InfoPtr = HScrollBar) or (Event.InfoPtr = VScrollBar)) then
      ScrollDraw;
end;

procedure TScroller.ScrollDraw;
var
  D: TPoint;
begin
  if HScrollBar <> nil then D.X := HScrollBar^.Value
  else D.X := 0;
  if VScrollBar <> nil then D.Y := VScrollBar^.Value
  else D.Y := 0;
  if (D.X <> Delta.X) or (D.Y <> Delta.Y) then
  begin
    SetCursor(Cursor.X + Delta.X - D.X, Cursor.Y + Delta.Y - D.Y);
    Delta := D;
    if DrawLock <> 0 then DrawFlag := True else DrawView;
  end;
end;

procedure TScroller.ScrollTo(X, Y: Integer);
begin
  Inc(DrawLock);
  if HScrollBar <> nil then HScrollBar^.SetValue(X);
  if VScrollBar <> nil then VScrollBar^.SetValue(Y);
  Dec(DrawLock);
  CheckDraw;
end;

procedure TScroller.SetLimit(X, Y: Integer);
begin
  Limit.X := X;
  Limit.Y := Y;
  Inc(DrawLock);
  if HScrollBar <> nil then
    HScrollBar^.SetParams(HScrollBar^.Value, 0, X - Size.X, Size.X - 1,
      HScrollBar^.ArStep);
  if VScrollBar <> nil then
    VScrollBar^.SetParams(VScrollBar^.Value, 0, Y - Size.Y, Size.Y - 1,
      VScrollBar^.ArStep);
  Dec(DrawLock);
  CheckDraw;
end;

procedure TScroller.SetState(AState: Word; Enable: Boolean);

procedure ShowSBar(SBar: PScrollBar);
begin
  if (SBar <> nil) then
    if GetState(sfActive + sfSelected) then SBar^.Show
    else SBar^.Hide;
end;

begin
  TView.SetState(AState, Enable);
  if AState and (sfActive + sfSelected) <> 0 then
  begin
    ShowSBar(HScrollBar);
    ShowSBar(VScrollBar);
  end;
end;

procedure TScroller.Store(var S: TStream);
begin
  TView.Store(S);
  PutPeerViewPtr(S, HScrollBar);
  PutPeerViewPtr(S, VScrollBar);
  S.Write(Delta, SizeOf(TPoint)*2);
end;

{ TListViewer }

constructor TListViewer.Init(var Bounds: TRect; ANumCols: Word;
  AHScrollBar, AVScrollBar: PScrollBar);
var
  ArStep, PgStep: Integer;
begin
  TView.Init(Bounds);
  Options := Options or (ofFirstClick + ofSelectable);
  EventMask := EventMask or evBroadcast;
  Range := 0;
  NumCols := ANumCols;
  Focused := 0;
  if AVScrollBar <> nil then
  begin
    if NumCols = 1 then
    begin
      PgStep := Size.Y -1;
      ArStep := 1;
    end else
    begin
      PgStep := Size.Y * NumCols;
      ArStep := Size.Y;
    end;
    AVScrollBar^.SetStep(PgStep, ArStep);
  end;
  if AHScrollBar <> nil then AHScrollBar^.SetStep(Size.X div NumCols, 1);
  HScrollBar := AHScrollBar;
  VScrollBar := AVScrollBar;
end;

constructor TListViewer.Load(var S: TStream);
begin
  TView.Load(S);
  GetPeerViewPtr(S, HScrollBar);
  GetPeerViewPtr(S, VScrollBar);
  S.Read(NumCols, SizeOf(Word) * 4);
end;

procedure TListViewer.ChangeBounds(var Bounds: TRect);
begin
  TView.ChangeBounds(Bounds);
  if HScrollBar <> nil then
    HScrollBar^.SetStep(Size.X div NumCols, 1);
  if VScrollBar <> nil then
    if NumCols > 1 then
      VScrollBar^.SetStep(Size.Y * NumCols, Size.Y)
    else
      VScrollBar^.SetStep(Size.Y - 1, 1);
end;

procedure TListViewer.Draw;
var
  I, J, Item: Integer;
  NormalColor, SelectedColor, FocusedColor, Color: Word;
  ColWidth, CurCol, Indent: Integer;
  B: TDrawBuffer;
  Text: String;
  SCOff: Byte;
begin
  if State and (sfSelected + sfActive) = (sfSelected + sfActive) then
  begin
    NormalColor := GetColor(1);
    FocusedColor := GetColor(3);
    SelectedColor := GetColor(4);
  end else
  begin
    NormalColor := GetColor(2);
    SelectedColor := GetColor(4);
  end;
  if HScrollBar <> nil then Indent := HScrollBar^.Value
  else Indent := 0;
  ColWidth := Size.X div NumCols + 1;
  for I := 0 to Size.Y - 1 do
  begin
    for J := 0 to NumCols-1 do
    begin
      Item := J*Size.Y + I + TopItem;
      CurCol := J*ColWidth;
      if (State and (sfSelected + sfActive) = (sfSelected + sfActive)) and
        (Focused = Item) and (Range > 0) then
      begin
        Color := FocusedColor;
        SetCursor(CurCol+1,I);
        SCOff := 0;
      end
      else if (Item < Range) and IsSelected(Item) then
      begin
        Color := SelectedColor;
        SCOff := 2;
      end
      else
      begin
        Color := NormalColor;
        SCOff := 4;
      end;
      MoveChar(B[CurCol], ' ', Color, ColWidth);
      if Item < Range then
      begin
        Text := GetText(Item, ColWidth + Indent);
        Text := Copy(Text,Indent,ColWidth);
        MoveStr(B[CurCol+1], Text, Color);
        if ShowMarkers then
        begin
          WordRec(B[CurCol]).Lo := Byte(SpecialChars[SCOff]);
          WordRec(B[CurCol+ColWidth-2]).Lo := Byte(SpecialChars[SCOff+1]);
        end;
      end;
      MoveChar(B[CurCol+ColWidth-1], ldVerticalBar, GetColor(5), 1);
    end;
    WriteLine(0, I, Size.X, 1, B);
  end;
end;

procedure TListViewer.FocusItem(Item: Integer);
begin
  Focused := Item;
  if VScrollBar <> nil then VScrollBar^.SetValue(Item);
  if Item < TopItem then
    if NumCols = 1 then TopItem := Item
    else TopItem := Item - Item mod Size.Y
  else if Item >= TopItem + (Size.Y*NumCols) then
    if NumCols = 1 then TopItem := Item - Size.Y + 1
    else TopItem := Item - Item mod Size.Y - (Size.Y*(NumCols - 1));
end;

procedure TListViewer.FocusItemNum(Item: Integer);
begin
  if Item < 0 then Item := 0
  else if (Item >= Range) and (Range > 0) then Item := Range-1;
  if Range <> 0 then FocusItem(Item);
end;

function TListViewer.GetPalette: PPalette;
const
  P: String[Length(CListViewer)] = CListViewer;
begin
  GetPalette := @P;
end;

function TListViewer.GetText(Item: Integer; MaxLen: Integer): String;
begin
  Abstract;
end;

function TListViewer.IsSelected(Item: Integer): Boolean;
begin
  IsSelected := Item = Focused;
end;

procedure TListViewer.HandleEvent(var Event: TEvent);
const
  MouseAutosToSkip = 4;
var
  Mouse: TPoint;
  ColWidth: Word;
  OldItem, NewItem: Integer;
  Count: Word;
begin
  TView.HandleEvent(Event);
  if Event.What = evMouseDown then
  begin
    ColWidth := Size.X div NumCols + 1;
    OldItem := Focused;
    MakeLocal(Event.Where, Mouse);
    if MouseInView(Event.Where) then
      NewItem := Mouse.Y + (Size.Y * (Mouse.X div ColWidth)) + TopItem
    else NewItem := OldItem;
    Count := 0;
    repeat
      if NewItem <> OldItem then
      begin
        FocusItemNum(NewItem);
        DrawView;
      end;
      OldItem := NewItem;
      MakeLocal(Event.Where, Mouse);
      if MouseInView(Event.Where) then
        NewItem := Mouse.Y + (Size.Y * (Mouse.X div ColWidth)) + TopItem
      else
      begin
        if NumCols = 1 then
        begin
          if Event.What = evMouseAuto then Inc(Count);
          if Count = MouseAutosToSkip then
          begin
            Count := 0;
            if Mouse.Y < 0 then NewItem := Focused-1
            else if Mouse.Y >= Size.Y then NewItem := Focused+1;
          end;
        end
        else
        begin
          if Event.What = evMouseAuto then Inc(Count);
          if Count = MouseAutosToSkip then
          begin
            Count := 0;
            if Mouse.X < 0 then NewItem := Focused-Size.Y
            else if Mouse.X >= Size.X then NewItem := Focused+Size.Y
            else if Mouse.Y < 0 then
              NewItem := Focused - Focused mod Size.Y
            else if Mouse.Y > Size.Y then
              NewItem := Focused - Focused mod Size.Y + Size.Y - 1;
          end
        end;
      end;
    until not MouseEvent(Event, evMouseMove + evMouseAuto);
    FocusItemNum(NewItem);
    DrawView;
    if Event.Double and (Range > Focused) then SelectItem(Focused);
    ClearEvent(Event);
  end
  else if Event.What = evKeyDown then
  begin
    if (Event.CharCode = ' ') and (Focused < Range) then
    begin
      SelectItem(Focused);
      NewItem := Focused;
    end
    else case CtrlToArrow(Event.KeyCode) of
      kbUp: NewItem := Focused - 1;
      kbDown: NewItem := Focused + 1;
      kbRight: if NumCols > 1 then NewItem := Focused + Size.Y else Exit;
      kbLeft: if NumCols > 1 then NewItem := Focused - Size.Y else Exit;
      kbPgDn: NewItem := Focused + Size.Y * NumCols;
      kbPgUp: NewItem := Focused - Size.Y * NumCols;
      kbHome: NewItem := TopItem;
      kbEnd: NewItem := TopItem + (Size.Y * NumCols) - 1;
      kbCtrlPgDn: NewItem := Range - 1;
                        kbCtrlPgUp: NewItem := 0;
                else
      Exit;
    end;
    FocusItemNum(NewItem);
    DrawView;
    ClearEvent(Event);
  end else if Event.What = evBroadcast then
    if Options and ofSelectable <> 0 then
      if (Event.Command = cmScrollBarClicked) and
         ((Event.InfoPtr = HScrollBar) or (Event.InfoPtr = VScrollBar)) then
        Select
      else if (Event.Command = cmScrollBarChanged) then
      begin
        if (VScrollBar = Event.InfoPtr) then
        begin
          FocusItemNum(VScrollBar^.Value);
          DrawView;
        end else if (HScrollBar = Event.InfoPtr) then DrawView;
      end;
end;

procedure TListViewer.SelectItem(Item: Integer);
begin
  Message(Owner, evBroadcast, cmListItemSelected, @Self);
end;

procedure TListViewer.SetRange(ARange: Integer);
begin
  Range := ARange;
  if VScrollBar <> nil then
  begin
    if Focused > ARange then Focused := 0;
    VScrollbar^.SetParams(Focused, 0, ARange-1, VScrollBar^.PgStep,
      VScrollBar^.ArStep);
  end;
end;

procedure TListViewer.SetState(AState: Word; Enable: Boolean);

procedure ShowSBar(SBar: PScrollBar);
begin
  if (SBar <> nil) then
    if GetState(sfActive) and GetState(sfVisible) then SBar^.Show
    else SBar^.Hide;
end;

begin
  TView.SetState(AState, Enable);
  if AState and (sfSelected + sfActive + sfVisible) <> 0 then
  begin
    ShowSBar(HScrollBar);
    ShowSBar(VScrollBar);
    DrawView;
  end;
end;

procedure TListViewer.Store(var S: TStream);
begin
  TView.Store(S);
  PutPeerViewPtr(S, HScrollBar);
  PutPeerViewPtr(S, VScrollBar);
  S.Write(NumCols, SizeOf(Word) * 4);
end;

{ TGroup }

constructor TGroup.Init(var Bounds: TRect);
begin
  TView.Init(Bounds);
  Options := Options or (ofSelectable + ofBuffered);
  GetExtent(Clip);
  EventMask := $FFFF;
end;

constructor TGroup.Load(var S: TStream);
var
  FixupSave: PFixupList;
  Count,I,Cnt : Sw_Integer;
  P, Q: ^Pointer;
  V: PView;
  OwnerSave: PGroup;
begin
  TView.Load(S);
  GetExtent(Clip);
  OwnerSave := OwnerGroup;
  OwnerGroup := @Self;
  FixupSave := FixupList;
  S.Read(Count, SizeOf(Sw_Integer));
  Cnt := Count;
  GetMem(FixupList, Count * SizeOf(Pointer));
  FillChar(FixupList^, Count*SizeOf(Pointer), 0);
  for I := 1 to Count do
  begin
    V := PView(S.Get);
    if V <> nil then InsertView(V, nil);
  end;
  V := Last;
  for I := 1 to Count do
  begin
    V := V^.Next;
    P := FixupList^[I];
    while P <> nil do
    begin
      Q := P;
      P := P^;
      Q^ := V;
    end;
  end;
  OwnerGroup := OwnerSave;
  FreeMem(FixupList, Cnt * SizeOf(Pointer));
  FixupList := FixupSave;
  GetSubViewPtr(S, V);
  SetCurrent(V, NormalSelect);
  if OwnerGroup = nil then Awaken;
end;

destructor TGroup.Done;
var
  P, T: PView;
begin
  Hide;
  P := Last;
  if P <> nil then
  begin
    repeat
      P^.Hide;
      P := P^.Prev;
    until P = Last;
    repeat
      T := P^.Prev;
      Dispose(P, Done);
      P := T;
    until Last = nil;
  end;
  FreeBuffer;
  TView.Done;
end;

function TGroup.At(Index: Integer): PView;
var
  temp : PView;
begin
  temp := last;
  while Index>0 do
   begin
     dec(Index);
     temp:=temp^.Next;
   end;
  At:=temp;
end;

procedure TGroup.Awaken;

procedure DoAwaken(P: PView);
begin
  P^.Awaken;
end;

begin
  ForEach(LocalAddr(@DoAwaken));
end;

procedure TGroup.ChangeBounds(var Bounds: TRect);
var
  D: TPoint;

procedure DoCalcChange(P: PView);
var
  R: TRect;
begin
  P^.CalcBounds(R, D);
  P^.ChangeBounds(R);
end;

begin
  D.X := Bounds.B.X - Bounds.A.X - Size.X;
  D.Y := Bounds.B.Y - Bounds.A.Y - Size.Y;
  if (D.X or D.Y) = 0 then
  begin
    SetBounds(Bounds);
    DrawView;
  end else
  begin
    FreeBuffer;
    SetBounds(Bounds);
    GetExtent(Clip);
    GetBuffer;
    Lock;
    ForEach(LocalAddr(@DoCalcChange));
    Unlock;
  end;
end;


function TGroup.DataSize: Word;
var
  T: integer;
  
procedure AddSubviewDataSize(P: PView);
begin
  Inc(T, P^.DataSize);
end;

begin
  T := 0;
  ForEach(LocalAddr(@AddSubviewDataSize));
  DataSize := T;
end;

procedure TGroup.Delete(P: PView);
var
  SaveState: Word;
begin
  SaveState := P^.State;
  P^.Hide;
  RemoveView(P);
  P^.Owner := nil;
  P^.Next := nil;
  if SaveState and sfVisible <> 0 then P^.Show;
end;

procedure TGroup.Draw;
var
  R: TRect;
begin
  if Buffer = nil then
  begin
    GetBuffer;
    if Buffer <> nil then
    begin
      Inc(LockFlag);
      Redraw;
      Dec(LockFlag);
    end;
  end;
  if Buffer <> nil then WriteBuf(0, 0, Size.X, Size.Y, Buffer^) else
  begin
    GetClipRect(Clip);
    Redraw;
    GetExtent(Clip);
  end;
end;

procedure TGroup.DrawSubViews(P, Bottom: PView);
begin
  if P <> nil then
    while P <> Bottom do
    begin
      P^.DrawView;
      P := P^.NextView;
    end;
end;

procedure TGroup.EndModal(Command: Word);
begin
  if State and sfModal <> 0 then EndState := Command
  else TView.EndModal(Command);
end;

procedure TGroup.EventError(var Event: TEvent);
begin
  if Owner <> nil then Owner^.EventError(Event);
end;

function TGroup.Execute: Word;
var
  E: TEvent;
begin
  repeat
    EndState := 0;
    repeat
      GetEvent(E);
      HandleEvent(E);
      if E.What <> evNothing then EventError(E);
    until EndState <> 0;
  until Valid(EndState);
  Execute := EndState;
end;

function TGroup.ExecView(P: PView): Word;
var
  SaveOptions: Word;
  SaveOwner: PGroup;
  SaveTopView: PView;
  SaveCurrent: PView;
  SaveCommands: TCommandSet;
begin
  if P <> nil then
  begin
    SaveOptions := P^.Options;
    SaveOwner := P^.Owner;
    SaveTopView := TheTopView;
    SaveCurrent := Current;
    GetCommands(SaveCommands);
    TheTopView := P;
    P^.Options := P^.Options and not ofSelectable;
    P^.SetState(sfModal, True);
    SetCurrent(P, EnterSelect);
    if SaveOwner = nil then Insert(P);
    ExecView := P^.Execute;
    if SaveOwner = nil then Delete(P);
    SetCurrent(SaveCurrent, LeaveSelect);
    P^.SetState(sfModal, False);
    P^.Options := SaveOptions;
    TheTopView := SaveTopView;
    SetCommands(SaveCommands);
  end else ExecView := cmCancel;
end;

function TGroup.First: PView;
begin
  if Last = nil then First := nil else First := Last^.Next;
end;

var
  _AState, _AOptions: Word;
function Matches(P: PView): Boolean;
begin
  Matches := (P^.State and _AState = _AState) and
    (P^.Options and _AOptions = _AOptions);
end;

function TGroup.FirstMatch(AState: Word; AOptions: Word): PView;
begin
  _AState := AState;
  _AOptions := AOptions;
  FirstMatch := FirstThat(LocalAddr(@Matches));
end;

function TGroup.FirstThat(P: TMethod): PView;
var
  Temp: PView;
  Found: Boolean;
  Tmp: pointer;
begin
    if Last = nil then
      FirstThat := nil
    else
    begin
      Temp := Last;
      Found := FALSE;
      repeat
         Temp := Temp^.Next;
          Tmp := P.Data;
          asm
            push Tmp
          end;
          Found := TFirstThatFunc(P.Code)(Temp);
          asm
            pop ecx
          end;
      until Found or (Temp = Last);
      if Found then
        FirstThat := Temp
      else
        FirstThat := nil
    end;
end;

function TGroup.FindNext(Forwards: Boolean): PView;
var
  P: PView;
begin
  FindNext := nil;
  if Current <> nil then
  begin
    P := Current;
    repeat
      if Forwards then P := P^.Next else P := P^.Prev;
    until ((P^.State and (sfVisible + sfDisabled) = sfVisible) and
      (P^.Options and ofSelectable <> 0)) or (P = Current);
    if P <> Current then FindNext := P;
  end;
end;

function TGroup.FocusNext(Forwards: Boolean): Boolean;
var
  P: PView;
begin
  P := FindNext(Forwards);
  FocusNext := True;
  if P <> nil then FocusNext := P^.Focus;
end;

procedure TGroup.ForEach(P: TMethod);
var
  Temp: PView;
  Tmp: pointer;
begin
    if   Last <> nil
    then
    begin
      Temp := Last;
      repeat
          Temp := Temp^.Next;
          Tmp := P.Data;
          asm
            push Tmp
          end;
          TForEachProc(P.Code)(Temp);
          asm
            pop ecx
          end;
      until (Temp = Last);
    end
end;

procedure TGroup.FreeBuffer;
begin
  if (Options and ofBuffered <> 0) and (Buffer <> nil) then
    DisposeCache(Pointer(Buffer));
end;

{ Allocate a group buffer if the group is exposed and buffered }
procedure TGroup.GetBuffer;
begin
asm
                mov     ecx,Self
                test    [ecx].State,sfExposed
                jz      @@1
                test    [ecx].Options,ofBuffered
                jz      @@1
                cmp     [ecx].Buffer,0
                jnz     @@1
                mov     eax,[ecx].TView.Size.X
                mul     [ecx].TView.Size.Y
                jo      @@1
                shl     eax,1
                jc      @@1
                js      @@1
                lea     ecx,[ecx].TView.Buffer
                push    ecx             { [1]:Pointer = @ of the buffer@ }
                push    eax             { [2]:Pointer = Buffer Size      }
                Call    NewCache
              @@1:
end;
end;

procedure TGroup.GetData(var Rec);
type
  Bytes = array[0..65534] of Byte;
var
  I: Word;
  V: PView;
begin
  I := 0;
  if Last <> nil then
  begin
    V := Last;
    repeat
      V^.GetData(Bytes(Rec)[I]);
      Inc(I, V^.DataSize);
      V := V^.Prev;
    until V = Last;
  end;
end;

function TGroup.GetHelpCtx: Word;
var
  H: Word;
begin
  H:= hcNoContext;
  if Current <> nil then H := Current^.GetHelpCtx;
  if H = hcNoContext then H := TView.GetHelpCtx;
  GetHelpCtx := H;
end;

procedure TGroup.GetSubViewPtr(var S: TStream; var P);
var
  Index: Word;
begin
  S.Read(Index, SizeOf(Word));
  if Index > 0 then
    Pointer(P) := At(Index)
  else
    Pointer(P) := nil;
end;

procedure TGroup.HandleEvent(var Event: TEvent);

procedure DoHandleEvent(P: PView);
begin
  if (P = nil) or ((P^.State and sfDisabled <> 0)
    and (Event.What and (PositionalEvents or FocusedEvents) <> 0)) then Exit;
  case Self.Phase of
    phPreProcess: if P^.Options and ofPreProcess = 0 then Exit;
    phPostProcess: if P^.Options and ofPostProcess = 0 then Exit;
  end;
  if Event.What and P.EventMask <> 0 then
    P.HandleEvent(Event);
end;

function ContainsMouse(P: PView): Boolean;
begin
  ContainsMouse := (P^.State and sfVisible <> 0) and
    P^.MouseInView(Event.Where);
end;

begin
  TView.HandleEvent(Event);
  if Event.What and FocusedEvents <> 0 then
  begin
    Phase := phPreProcess;
    ForEach(LocalAddr(@DoHandleEvent));
    Phase := phFocused;
    DoHandleEvent(Current);
    Phase := phPostProcess;
    ForEach(LocalAddr(@DoHandleEvent));
  end else
  begin
    Phase := phFocused;
    if (Event.What and PositionalEvents <> 0) then
    begin
      DoHandleEvent(FirstThat(LocalAddr(@ContainsMouse)))
    end
    else
    begin
      ForEach(LocalAddr(@DoHandleEvent));
    end;
  end;
end;

function TGroup.IndexOf(P: PView): Integer;
var
  temp : PView;
  index : Sw_integer;
begin
  index:=0;
  if Last<>Nil then
   begin
     temp:=Last;
     repeat
       inc(index);
       temp:=temp^.Next;
     until (temp=P) or (temp=Last);
     if temp<>p then
      index:=0;
   end;
  IndexOf:=index;
end;

procedure TGroup.Insert(P: PView);
begin
  InsertBefore(P, First);
end;

procedure TGroup.InsertBefore(P, Target: PView);
var
  SaveState: Word;
begin
  if (P <> nil) and (P^.Owner = nil) and
    ((Target = nil) or (Target^.Owner = @Self)) then
  begin
    if P^.Options and ofCenterX <> 0 then
      P^.Origin.X := (Size.X - P^.Size.X) div 2;
    if P^.Options and ofCenterY <> 0 then
      P^.Origin.Y := (Size.Y - P^.Size.Y) div 2;
    SaveState := P^.State;
    P^.Hide;
    InsertView(P, Target);
    if SaveState and sfVisible <> 0 then P^.Show;
    if State and sfActive <> 0 then
      P^.SetState(sfActive, True);
  end;
end;

procedure TGroup.InsertView(P, Target: PView);
begin
  P^.Owner := @Self;
  if Target <> nil then
  begin
    Target := Target^.Prev;
    P^.Next := Target^.Next;
    Target^.Next := P;
  end else
  begin
    if Last = nil then P^.Next := P else
    begin
      P^.Next := Last^.Next;
      Last^.Next := P;
    end;
    Last := P;
  end;
end;

procedure TGroup.Lock;
begin
  if (Buffer <> nil) or (LockFlag <> 0) then Inc(LockFlag);
end;

procedure TGroup.PutSubViewPtr(var S: TStream; P: PView);
var
  Index: Word;
begin
  if P = nil then Index := 0
  else Index := IndexOf(P);
  S.Write(Index, SizeOf(Word));
end;

procedure TGroup.Redraw;
begin
  DrawSubViews(First, nil);
end;

procedure TGroup.RemoveView(P: PView);
var
  cur:PView;
begin
  if Last<>Nil then
  begin
    cur:=Last;
    while true do begin
     if p=cur^.Next then begin
      cur^.Next:=P^.Next;
      if Last=P then
       begin if cur^.Next=P then Last:=Nil else Last:=cur; break end;
     end;
     if cur^.next=Last then break;
     cur:=cur^.Next;
    end;
 end
end;

procedure TGroup.ResetCurrent;
begin
  SetCurrent(FirstMatch(sfVisible, ofSelectable), NormalSelect);
end;

procedure TGroup.ResetCursor;
begin
  if Current <> nil then Current^.ResetCursor;
end;

procedure TGroup.SelectNext(Forwards: Boolean);
var
  P: PView;
begin
  P := FindNext(Forwards);
  if P <> nil then P^.Select;
end;

procedure TGroup.SetCurrent(P: PView; Mode: SelectMode);

procedure SelectView(P: PView; Enable: Boolean);
begin
  if P <> nil then P^.SetState(sfSelected, Enable);
end;

procedure FocusView(P: PView; Enable: Boolean);
begin
  if (State and sfFocused <> 0) and (P <> nil) then
    P^.SetState(sfFocused, Enable);
end;

begin
  if Current <> P then
  begin
    Lock;
    FocusView(Current, False);
    if Mode <> EnterSelect then SelectView(Current, False);
    if Mode <> LeaveSelect then SelectView(P, True);
    FocusView(P, True);
    Current := P;
    Unlock;
  end;
end;

procedure TGroup.SetData(var Rec);
type
  Bytes = array[0..65534] of Byte;
var
  I: Word;
  V: PView;
begin
  I := 0;
  if Last <> nil then
  begin
    V := Last;
    repeat
      V^.SetData(Bytes(Rec)[I]);
      Inc(I, V^.DataSize);
      V := V^.Prev;
    until V = Last;
  end;
end;

procedure TGroup.SetState(AState: Word; Enable: Boolean);

procedure DoSetState(P: PView);
begin
  P^.SetState(AState, Enable);
end;

procedure DoExpose(P: PView);
begin
  if P^.State and sfVisible <> 0 then P^.SetState(sfExposed, Enable);
end;

begin
  TView.SetState(AState, Enable);
  case AState of
    sfActive, sfDragging:
      begin
        Lock;
        ForEach(LocalAddr(@DoSetState));
        Unlock;
      end;
    sfFocused:
      if Current <> nil then Current^.SetState(sfFocused, Enable);
    sfExposed:
      begin
        ForEach(LocalAddr(@DoExpose));
        if not Enable then FreeBuffer;
      end;
  end;
end;

procedure TGroup.Store(var S: TStream);

procedure DoPut(P: PView);
begin
  S.Put(P);
end;

var
  Count: Integer;
  OwnerSave: PGroup;
begin
  TView.Store(S);
  OwnerSave := OwnerGroup;
  OwnerGroup := @Self;
  Count := IndexOf(Last);
  S.Write(Count, SizeOf(Word));
  ForEach(LocalAddr(@DoPut));
  PutSubViewPtr(S, Current);
  OwnerGroup := OwnerSave;
end;

procedure TGroup.Unlock;
begin
  if LockFlag <> 0 then
  begin
    Dec(LockFlag);
    if LockFlag = 0 then DrawView;
  end;
end;

var
  _Command: Word;
function IsInvalid(P: PView): Boolean;
begin
  Result := not P^.Valid(_Command);
end;
function TGroup.Valid(Command: Word): Boolean;
begin
  Valid := True;
  if Command = cmReleasedFocus then
  begin
    if (Current <> nil) and (Current^.Options and ofValidate <> 0) then
      Valid := Current^.Valid(Command);
  end
  else
  begin
    _Command := Command;
    Valid := FirstThat(LocalAddr(@IsInvalid)) = nil;
  end;
end;

{ TWindow }

constructor TWindow.Init(var Bounds: TRect; ATitle: TTitleStr;
  ANumber: Integer);
begin
  TGroup.Init(Bounds);
  State := State or sfShadow;
  Options := Options or (ofSelectable + ofTopSelect);
  GrowMode := gfGrowAll + gfGrowRel;
  Flags := wfMove + wfGrow + wfClose + wfZoom;
  Title := NewStr(ATitle);
  Number := ANumber;
  Palette := wpBlueWindow;
  InitFrame;
  if Frame <> nil then Insert(Frame);
  GetBounds(ZoomRect);
end;

constructor TWindow.Load(var S: TStream);
begin
  TGroup.Load(S);
  S.Read(Flags, SizeOf(Byte) + SizeOf(TRect) + 2 * SizeOf(Integer));
  GetSubViewPtr(S, Frame);
  Title := S.ReadStr;
end;

destructor TWindow.Done;
begin
  TGroup.Done;
  DisposeStr(Title);
end;

procedure TWindow.Close;
begin
  if Valid(cmClose) then Free;
end;

function TWindow.GetPalette: PPalette;
const
  P: array[wpBlueWindow..wpGrayWindow] of string[Length(CBlueWindow)] =
    (CBlueWindow, CCyanWindow, CGrayWindow);
begin
  GetPalette := @P[Palette];
end;

function TWindow.GetTitle(MaxSize: Integer): TTitleStr;
begin
  if Title <> nil then GetTitle := Title^
  else GetTitle := '';
end;

procedure TWindow.HandleEvent(var Event: TEvent);
var
  Limits: TRect;
  Min, Max: TPoint;
begin
  TGroup.HandleEvent(Event);
  if (Event.What = evCommand) then
    case Event.Command of
      cmResize:
        if Flags and (wfMove + wfGrow) <> 0 then
        begin
          Owner^.GetExtent(Limits);
          SizeLimits(Min, Max);
          DragView(Event, DragMode or (Flags and (wfMove + wfGrow)),
            Limits, Min, Max);
          ClearEvent(Event);
        end;
      cmClose:
        if (Flags and wfClose <> 0) and
          ((Event.InfoPtr = nil) or (Event.InfoPtr = @Self)) then
        begin
          ClearEvent(Event);
          if State and sfModal = 0 then Close else
          begin
            Event.What := evCommand;
            Event.Command := cmCancel;
            Event.InfoPtr := nil;
            PutEvent(Event);
            ClearEvent(Event);
          end;
        end;
      cmZoom:
        if (Flags and wfZoom <> 0) and
          ((Event.InfoPtr = nil) or (Event.InfoPtr = @Self)) then
        begin
          Zoom;
          ClearEvent(Event);
        end;
    end
  else if Event.What = evKeyDown then
    case Event.KeyCode of
      kbTab:
        begin
          FocusNext(False);
          ClearEvent(Event);
        end;
      kbShiftTab:
        begin
          FocusNext(True);
          ClearEvent(Event);
        end;
    end
  else if (Event.What = evBroadcast) and (Event.Command = cmSelectWindowNum)
         and (Event.InfoInt = Number) and (Options and ofSelectable <> 0) then
  begin
    Select;
    ClearEvent(Event);
  end;
end;

procedure TWindow.InitFrame;
var
  R: TRect;
begin
  GetExtent(R);
  Frame := New(PFrame, Init(R));
end;

procedure TWindow.SetState(AState: Word; Enable: Boolean);
var
  WindowCommands: TCommandSet;
begin
  TGroup.SetState(AState, Enable);
  if AState = sfSelected then
    SetState(sfActive, Enable);
  if (AState = sfSelected) or ((AState = sfExposed) and
    (State and sfSelected <> 0)) then
  begin
    WindowCommands := [cmNext, cmPrev];
    if Flags and (wfGrow + wfMove) <> 0 then
      WindowCommands := WindowCommands + [cmResize];
    if Flags and wfClose <> 0 then
      WindowCommands := WindowCommands + [cmClose];
    if Flags and wfZoom <> 0 then
      WindowCommands := WindowCommands + [cmZoom];
    if Enable then EnableCommands(WindowCommands)
    else DisableCommands(WindowCommands);
  end;
end;

function TWindow.StandardScrollBar(AOptions: Word): PScrollBar;
var
  R: TRect;
  S: PScrollBar;
begin
  GetExtent(R);
  if AOptions and sbVertical = 0 then
    R.Assign(R.A.X + 2, R.B.Y-1, R.B.X-2, R.B.Y) else
    R.Assign(R.B.X-1,R.A.Y+1,R.B.X,R.B.Y-1);
  S := New(PScrollBar, Init(R));
  Insert(S);
  if AOptions and sbHandleKeyboard <> 0 then
    S^.Options := S^.Options or ofPostProcess;
  StandardScrollBar := S;
end;

procedure TWindow.SizeLimits(var Min, Max: TPoint);
begin
  TView.SizeLimits(Min, Max);
  Min.X := MinWinSize.X;
  Min.Y := MinWinSize.Y;
end;

procedure TWindow.Store(var S: TStream);
begin
  TGroup.Store(S);
  S.Write(Flags, SizeOf(Byte) + SizeOf(TRect) + 2 * SizeOf(Integer));
  PutSubViewPtr(S, Frame);
  S.WriteStr(Title);
end;

procedure TWindow.Zoom;
var
  R: TRect;
  Max, Min: TPoint;
begin
  SizeLimits(Min, Max);
  if (Size.X <> Max.X) or (Size.Y <> Max.Y) then
  begin
    GetBounds(ZoomRect);
    R.A.X := 0;
    R.A.Y := 0;
    R.B := Max;
    Locate(R);
  end else Locate(ZoomRect);
end;

{ Message dispatch function }

function Message(Receiver: PView; What, Command: Word;
  InfoPtr: Pointer): Pointer;
var
  Event: TEvent;
begin
  Result := nil;
  if Receiver <> nil then
  begin
    Event.What := What;
    Event.Command := Command;
    Event.InfoPtr := InfoPtr;
    Receiver^.HandleEvent(Event);
    if Event.What = evNothing then Result := Event.InfoPtr;
  end;
end;

{ Views registration procedure }

procedure RegisterViews;
begin
  RegisterType(RView);
  RegisterType(RFrame);
  RegisterType(RScrollBar);
  RegisterType(RScroller);
  RegisterType(RListViewer);
  RegisterType(RGroup);
  RegisterType(RWindow);
end;

end.
