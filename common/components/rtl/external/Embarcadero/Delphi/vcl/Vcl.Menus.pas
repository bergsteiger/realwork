{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Menus;

{$S-,W-,R-,T-,H+,X+}
{$C PRELOAD}

{$IFDEF CPUX64}
  {$DEFINE PUREPASCAL}
{$ENDIF CPUX64}

interface

uses 
{$IF DEFINED(CLR)}
  System.ComponentModel.Design.Serialization,
{$ENDIF}
{$IF DEFINED(LINUX)}
  WinUtils, 
{$ENDIF}
  Winapi.Windows, System.SysUtils, System.Classes, System.Contnrs, Winapi.Messages, Vcl.Graphics, Vcl.ImgList, Vcl.ActnList;

type
  TMenuItem = class;

  EMenuError = class(Exception);
  TMenu = class;
  TMenuBreak = (mbNone, mbBreak, mbBarBreak);
  TMenuChangeEvent = procedure (Sender: TObject; Source: TMenuItem; Rebuild: Boolean) of object;
  TMenuDrawItemEvent = procedure (Sender: TObject; ACanvas: TCanvas;
    ARect: TRect; Selected: Boolean) of object;
  TAdvancedMenuDrawItemEvent = procedure (Sender: TObject; ACanvas: TCanvas;
    ARect: TRect; State: TOwnerDrawState) of object;
  TMenuMeasureItemEvent = procedure (Sender: TObject; ACanvas: TCanvas;
    var Width, Height: Integer) of object;
  TMenuItemAutoFlag = (maAutomatic, maManual, maParent);
  TMenuAutoFlag = maAutomatic..maManual;

{ TMenuActionLink }

  TMenuActionLink = class(TActionLink)
  protected
    FClient: TMenuItem;
    procedure AssignClient(AClient: TObject); override;
    function IsAutoCheckLinked: Boolean; virtual;
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHelpContextLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsGroupIndexLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetAutoCheck(Value: Boolean); override;
    procedure SetCaption(const Value: string); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHelpContext(Value: THelpContext); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  TMenuActionLinkClass = class of TMenuActionLink;

{$IF DEFINED(CLR)}
  TMenuHandle = class
  strict private
    FHandle: HMenu;
  strict protected
    procedure Finalize; override;
  public
    destructor Destroy; override;
    property Value: HMenu read FHandle write FHandle;
  end;
{$ELSE}
  TMenuHandle = HMENU;
{$ENDIF}

{ TMenuItemEnumerator }

  TMenuItemEnumerator = class
  private
    FIndex: Integer;
    FMenuItem: TMenuItem;
  public
    constructor Create(AMenuItem: TMenuItem);
    function GetCurrent: TMenuItem;
    function MoveNext: Boolean;
    property Current: TMenuItem read GetCurrent;
  end;

{ TMenuItem }

{$IF DEFINED(CLR)}
  IMenuItem = interface
    procedure MeasureItem(ACanvas: TCanvas; var Width, Height: Integer);
  end;
{$ENDIF}

{$IF DEFINED(CLR)}
  [RootDesignerSerializerAttribute('', '', False)]
  TMenuItem = class(TComponent, IMenuItem)
{$ELSE}
  TMenuItem = class(TComponent)
{$ENDIF}
  private
    FCaption: string;
    FChecked: Boolean;
    FEnabled: Boolean;
    FDefault: Boolean;
    FAutoHotkeys: TMenuItemAutoFlag;
    FAutoLineReduction: TMenuItemAutoFlag;
    FRadioItem: Boolean;
    FVisible: Boolean;
    FGroupIndex: Byte;
    FImageIndex: TImageIndex;
    FActionLink: TMenuActionLink;
    FBreak: TMenuBreak;
    FBitmap: TBitmap;
    FCommand: Word;
    FHelpContext: THelpContext;
    FHint: string;
    FItems: TList;
    FShortCut: TShortCut;
    FParent: TMenuItem;
    FMerged: TMenuItem;
    FMergedWith: TMenuItem;
    FMenu: TMenu;
    FStreamedRebuild: Boolean;
    FImageChangeLink: TChangeLink;
    FSubMenuImages: TCustomImageList;
    FOnChange: TMenuChangeEvent;
    FOnClick: TNotifyEvent;
    FOnDrawItem: TMenuDrawItemEvent;
    FOnAdvancedDrawItem: TAdvancedMenuDrawItemEvent;
    FOnMeasureItem: TMenuMeasureItemEvent;
    FAutoCheck: Boolean;
    FHandle: TMenuHandle;
    procedure AppendTo(Menu: HMENU; ARightToLeft: Boolean);
    procedure DoActionChange(Sender: TObject);
    procedure ReadShortCutText(Reader: TReader);
    procedure MergeWith(Menu: TMenuItem);
    procedure RebuildHandle;
    procedure PopulateMenu;
    procedure SubItemChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
    procedure TurnSiblingsOff;
    procedure VerifyGroupIndex(Position: Integer; Value: Byte);
    function GetAction: TBasicAction;
    function GetBitmap: TBitmap;
    procedure SetAction(Value: TBasicAction);
    procedure SetBitmap(Value: TBitmap);
    procedure SetSubMenuImages(Value: TCustomImageList);
    procedure ImageListChange(Sender: TObject);
    procedure InitiateActions;
    function IsCaptionStored: Boolean;
    function IsCheckedStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHelpContextStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
    function IsShortCutStored: Boolean;
    function IsVisibleStored: Boolean;
    function InternalRethinkHotkeys(ForceRethink: Boolean): Boolean;
    procedure SetAutoHotkeys(const Value: TMenuItemAutoFlag);
    function InternalRethinkLines(ForceRethink: Boolean): Boolean;
    procedure SetAutoLineReduction(const Value: TMenuItemAutoFlag);
{$IF DEFINED(CLR)}
    function GetParent: TMenuItem;
{$ENDIF}
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    procedure AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
      State: TOwnerDrawState; TopLevel: Boolean); virtual;
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoDrawText(ACanvas: TCanvas; const ACaption: string;
      var Rect: TRect; Selected: Boolean; Flags: Longint);
    procedure DrawItem(ACanvas: TCanvas; ARect: TRect; Selected: Boolean); virtual;
    function GetActionLinkClass: TMenuActionLinkClass; dynamic;
    function GetHandle: HMENU;
    function GetCount: Integer;
    function GetItem(Index: Integer): TMenuItem;
    function GetMenuIndex: Integer;
    function GetAutoHotkeys: Boolean;
    function GetAutoLineReduction: Boolean;
    function InsertNewLine(ABefore: Boolean; AItem: TMenuItem): Integer;
    procedure MeasureItem(ACanvas: TCanvas; var Width, Height: Integer); virtual;
    procedure MenuChanged(Rebuild: Boolean); virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetBreak(Value: TMenuBreak);
    procedure SetCaption(const Value: string);
    procedure SetChecked(Value: Boolean);
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetDefault(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetGroupIndex(Value: Byte);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetMenuIndex(Value: Integer);
    procedure SetRadioItem(Value: Boolean);
    procedure SetShortCut(Value: TShortCut);
    procedure SetVisible(Value: Boolean);
    procedure UpdateItems;
    property ActionLink: TMenuActionLink read FActionLink write FActionLink;
    property Merged: TMenuItem read FMerged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitiateAction; virtual;
    procedure Insert(Index: Integer; Item: TMenuItem);
    procedure Delete(Index: Integer);
    procedure Clear;
    procedure Click; virtual;
    function Find(ACaption: string): TMenuItem;
    function IndexOf(Item: TMenuItem): Integer;
    function IsLine: Boolean;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetEnumerator: TMenuItemEnumerator;
    function GetImageList: TCustomImageList;
    function GetParentComponent: TComponent; override;
    function GetParentMenu: TMenu;
    function HasParent: Boolean; override;
    function NewTopLine: Integer;
    function NewBottomLine: Integer;
    function InsertNewLineBefore(AItem: TMenuItem): Integer;
    function InsertNewLineAfter(AItem: TMenuItem): Integer;
    procedure Add(Item: TMenuItem); overload;
    procedure Add(const AItems: array of TMenuItem); overload;
    procedure Remove(Item: TMenuItem);
    function RethinkHotkeys: Boolean;
    function RethinkLines: Boolean;
    procedure SetParentComponent(Value: TComponent); override;
    property Command: Word read FCommand;
    property Handle: HMENU read GetHandle;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TMenuItem read GetItem; default;
    property MenuIndex: Integer read GetMenuIndex write SetMenuIndex;
{$IF DEFINED(CLR)}
    property Parent: TMenuItem read GetParent;
{$ELSE}
    property Parent: TMenuItem read FParent;
{$ENDIF}
  published
    property Action: TBasicAction read GetAction write SetAction;
    property AutoCheck: Boolean read FAutoCheck write FAutoCheck default False;
    property AutoHotkeys: TMenuItemAutoFlag read FAutoHotkeys write SetAutoHotkeys default maParent;
    property AutoLineReduction: TMenuItemAutoFlag read FAutoLineReduction write SetAutoLineReduction default maParent;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Break: TMenuBreak read FBreak write SetBreak default mbNone;
    property Caption: string read FCaption write SetCaption stored IsCaptionStored;
    property Checked: Boolean read FChecked write SetChecked stored IsCheckedStored default False;
    property SubMenuImages: TCustomImageList read FSubMenuImages write SetSubMenuImages;
    property Default: Boolean read FDefault write SetDefault default False;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored default True;
    property GroupIndex: Byte read FGroupIndex write SetGroupIndex default 0;
    property HelpContext: THelpContext read FHelpContext write FHelpContext stored IsHelpContextStored default 0;
    property Hint: string read FHint write FHint stored IsHintStored;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored default -1;
    property RadioItem: Boolean read FRadioItem write SetRadioItem default False;
    property ShortCut: TShortCut read FShortCut write SetShortCut stored IsShortCutStored default 0;
    property Visible: Boolean read FVisible write SetVisible stored IsVisibleStored default True;
    property OnClick: TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
    property OnDrawItem: TMenuDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnAdvancedDrawItem: TAdvancedMenuDrawItemEvent read FOnAdvancedDrawItem write FOnAdvancedDrawItem;
    property OnMeasureItem: TMenuMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
  end;

  TFindItemKind = (fkCommand, fkHandle, fkShortCut);

  [RootDesignerSerializerAttribute('', '', False)]
  TMenu = class(TComponent)
  private
    FBiDiMode: TBiDiMode;
    FItems: TMenuItem;
    FWindowHandle: HWND;
    FOwnerDraw: Boolean;
    FParentBiDiMode: Boolean;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FOnChange: TMenuChangeEvent;
{$IF DEFINED(CLR)}
    FMenuImage: TBytes;
{$ELSE}
    FMenuImage: string;
{$ENDIF}
    procedure SetBiDiMode(Value: TBiDiMode);
    procedure SetOwnerDraw(Value: Boolean);
    procedure SetImages(Value: TCustomImageList);
    procedure SetParentBiDiMode(Value: Boolean);
    procedure SetWindowHandle(Value: HWND);
    procedure ImageListChange(Sender: TObject);
    function IsBiDiModeStored: Boolean;
    function UpdateImage: Boolean;
    function GetAutoHotkeys: TMenuAutoFlag;
    procedure SetAutoHotkeys(const Value: TMenuAutoFlag);
    function GetAutoLineReduction: TMenuAutoFlag;
    procedure SetAutoLineReduction(const Value: TMenuAutoFlag);
{$IF DEFINED(CLR)}
    function BuildMenuImage(Menu: HMENU): TBytes;
{$ENDIF}
  protected
    procedure AdjustBiDiBehavior;
    procedure DoChange(Source: TMenuItem; Rebuild: Boolean); virtual;
    procedure DoBiDiModeChanged;
    function GetHandle: HMENU; virtual;
    function IsOwnerDraw: Boolean;
    procedure Loaded; override;
    procedure MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure UpdateItems;
{$IF DEFINED(CLR)}
    function DoGetMenuString(Menu: HMENU; ItemID: UINT; Flag: UINT): string;
{$ELSE}
    function DoGetMenuString(Menu: HMENU; ItemID: UINT; Str: PChar;
      MaxCount: Integer; Flag: UINT): Integer;
{$ENDIF}
    property OnChange: TMenuChangeEvent read FOnChange write FOnChange;
  public
    constructor Create(AOwner: TComponent); override;
    function CreateMenuItem: TMenuItem; dynamic;
    destructor Destroy; override;
    function DispatchCommand(ACommand: Word): Boolean;
    function DispatchPopup(AHandle: HMENU): Boolean;
    function FindItem(Value: NativeUInt; Kind: TFindItemKind): TMenuItem;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetHelpContext(Value: NativeUInt; ByCommand: Boolean): THelpContext;
    property Images: TCustomImageList read FImages write SetImages;
    function IsRightToLeft: Boolean;
    function IsShortCut(var Message: TWMKey): Boolean; dynamic;
    procedure ParentBiDiModeChanged; overload;
    procedure ParentBiDiModeChanged(AControl: TObject); overload;
{$IF DEFINED(CLR)}
    procedure ProcessMenuChar(Message: TWMMenuChar);
{$ELSE}
    procedure ProcessMenuChar(var Message: TWMMenuChar);
{$ENDIF}
    property AutoHotkeys: TMenuAutoFlag read GetAutoHotkeys write SetAutoHotkeys default maAutomatic;
    property AutoLineReduction: TMenuAutoFlag read GetAutoLineReduction write SetAutoLineReduction default maAutomatic;
    property BiDiMode: TBiDiMode read FBiDiMode write SetBiDiMode stored IsBiDiModeStored;
    property Handle: HMENU read GetHandle;
    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw default False;
    property ParentBiDiMode: Boolean read FParentBiDiMode write SetParentBiDiMode default True;
    property WindowHandle: HWND read FWindowHandle write SetWindowHandle;
  published
    property Items: TMenuItem read FItems;
  end;

  TMainMenu = class(TMenu)
  private
    FOle2Menu: HMENU;
    FAutoMerge: Boolean;
    procedure ItemChanged;
    procedure SetAutoMerge(Value: Boolean);
  protected
    procedure MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean); override;
    function GetHandle: HMENU; override;
  public
    procedure Merge(Menu: TMainMenu);
    procedure Unmerge(Menu: TMainMenu);
    procedure PopulateOle2Menu(SharedMenu: HMenu; const Groups: array of Integer;
      var Widths: array of Longint);
    procedure GetOle2AcceleratorTable(var AccelTable: HAccel;
      var AccelCount: Integer; const Groups: array of Integer);
    procedure SetOle2MenuHandle(Handle: HMENU);
  published
    property AutoHotkeys;
    property AutoLineReduction;
    property AutoMerge: Boolean read FAutoMerge write SetAutoMerge default False;
    property BiDiMode;
    property Images;
    property OwnerDraw;
    property ParentBiDiMode;
    property OnChange;
  end;

  TPopupAlignment = (paLeft, paRight, paCenter);
  TTrackButton = (tbRightButton, tbLeftButton);
  TMenuAnimations = (maLeftToRight, maRightToLeft, maTopToBottom, maBottomToTop, maNone);
  TMenuAnimation = set of TMenuAnimations;

  TPopupMenu = class(TMenu)
  private
    FPopupPoint: TPoint;
    FAlignment: TPopupAlignment;
    FAutoPopup: Boolean;
    FPopupComponent: TComponent;
    FTrackButton: TTrackButton;
    FMenuAnimation: TMenuAnimation;
    FOnPopup: TNotifyEvent;
    function GetHelpContext: THelpContext;
    procedure SetHelpContext(Value: THelpContext);
    procedure SetBiDiModeFromPopupControl;
  protected
    function UseRightToLeftAlignment: Boolean;
    procedure DoPopup(Sender: TObject); virtual;
    procedure SetPopupPoint(APopupPoint: TPoint);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseMenu; inline;
    procedure Popup(X, Y: Integer); virtual;
    property PopupComponent: TComponent read FPopupComponent write FPopupComponent;
    property PopupPoint: TPoint read FPopupPoint;
  published
    property Alignment: TPopupAlignment read FAlignment write FAlignment default paLeft;
    property AutoHotkeys;
    property AutoLineReduction;
    property AutoPopup: Boolean read FAutoPopup write FAutoPopup default True;
    property BiDiMode;
    property HelpContext: THelpContext read GetHelpContext write SetHelpContext default 0;
    property Images;
    property MenuAnimation: TMenuAnimation read FMenuAnimation write FMenuAnimation default [];
    property OwnerDraw;
    property ParentBiDiMode;
    property TrackButton: TTrackButton read FTrackButton write FTrackButton default tbRightButton;
    property OnChange;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
  end;

  TPopupList = class(TList)
  protected
    FWindow: HWND;
    procedure MainWndProc(var Message: TMessage);
    procedure WndProc(var Message: TMessage); virtual;
  public
    property Window: HWND read FWindow;
    procedure Add(Popup: TPopupMenu);
    procedure Remove(Popup: TPopupMenu);
  end;

{$IF NOT DEFINED(CLR)}
  PMenuItem = ^TMenuItem;
{$ENDIF}

  TMenuItemStack = class(TStack)
  public
    procedure ClearItem(AItem: TMenuItem);
  end;

var
  PopupList: TPopupList;
  ShortCutItems: TMenuItemStack;

function ShortCut(Key: Word; Shift: TShiftState): TShortCut;
procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
function ShortCutToText(ShortCut: TShortCut): string;
function TextToShortCut(Text: string): TShortCut;
function ShortCutFromMessage(Message: TWMKey): TShortCut;

function NewMenu(Owner: TComponent; const AName: string; const Items: array of TMenuItem): TMainMenu;
function NewPopupMenu(Owner: TComponent; const AName: string;
  Alignment: TPopupAlignment; AutoPopup: Boolean; const Items: array of TMenuItem): TPopupMenu;
function NewSubMenu(const ACaption: string; hCtx: THelpContext;
  const AName: string; const Items: array of TMenuItem; AEnabled: Boolean = True): TMenuItem;
function NewItem(const ACaption: string; AShortCut: TShortCut;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: THelpContext;
  const AName: string): TMenuItem;
function NewLine: TMenuItem;

procedure DrawMenuItem(MenuItem: TMenuItem; ACanvas: TCanvas; ARect: TRect;
  State: TOwnerDrawState);

var
  { These are the hotkeys that the auto-hotkey system will pick from.
    Change this global variable at runtime if you want to add or remove
    characters from the available characters.  Notice that by default we
    do not do international characters. }
  ValidMenuHotkeys: string = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ'; { do not localize }

const
  cHotkeyPrefix = '&';
  cLineCaption = '-';
  cDialogSuffix = '...';

{ StripHotkey removes the & escape char that marks the hotkey character(s) in
  the string.  When the current locale is a Far East locale, this function also
  looks for and removes parens around the hotkey, common in Far East locales. }
function StripHotkey(const Text: string): string;

{ GetHotkey will return the last hotkey that StripHotkey would strip. }
function GetHotkey(const Text: string): string;

{ Similar to WideSameText in .NET and AnsiSameText in Win32 but strips hotkeys before comparing }
function SameCaption(const Text1, Text2: string): Boolean;

{$IF NOT DEFINED(CLR)}
{ Similar to AnsiSameText but strips hotkeys before comparing }
function AnsiSameCaption(const Text1, Text2: string): Boolean;

{ If AltGR (RightAlt) key is pressed on AltGR support keyboard layout, return TRUE }
function IsAltGRPressed: boolean;
{$ENDIF}

implementation

uses
{$IF DEFINED(CLR)}
  System.Text, System.Runtime.InteropServices, System.Security,
  System.Security.Permissions, System.Globalization, WinUtils, StrUtils,
{$ELSE}
  System.Win.Registry, System.Character,
{$ENDIF}
  System.Types, System.UITypes, Vcl.Controls, Vcl.Forms, Vcl.Consts, Vcl.Themes, Winapi.UxTheme;

const
  RightToLeftMenuFlag = MFT_RIGHTORDER or MFT_RIGHTJUSTIFY;
  cMenuAutoFlagToItem: array [TMenuAutoFlag] of TMenuItemAutoFlag = (maAutomatic, maManual);
  cItemAutoFlagToMenu: array [TMenuItemAutoFlag] of TMenuAutoFlag = (maAutomatic, maManual, maAutomatic);
  cBooleanToItemAutoFlag: array [Boolean] of TMenuItemAutoFlag = (maManual, maAutomatic);
  cItemAutoFlagToBoolean: array [TMenuItemAutoFlag] of Boolean = (True, False, True);

function FindPopupControl(const Pos: TPoint): TControl;
var
  Window: TWinControl;
begin
  Result := nil;
  Window := FindVCLWindow(Pos);
  if Window <> nil then
  begin
    Result := Window.ControlAtPos(Pos, False);
    if Result = nil then Result := Window;
  end;
end;

{$IF DEFINED(CLR)}
procedure Error(const Value: string);
begin
  raise EMenuError.Create(Value);
end;
{$ELSE}
procedure Error(ResStr: PResStringRec);
begin
  raise EMenuError.CreateRes(ResStr) at ReturnAddress;
end;
{$ENDIF}

{ TShortCut processing routines }

function ShortCut(Key: Word; Shift: TShiftState): TShortCut;
begin
  Result := 0;
  if HiByte(Key) <> 0 then Exit;
  Result := Key;
  if ssShift in Shift then Inc(Result, scShift);
  if ssCtrl in Shift then Inc(Result, scCtrl);
  if ssAlt in Shift then Inc(Result, scAlt);
end;

procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
begin
  Key := ShortCut and not (scShift + scCtrl + scAlt);
  Shift := [];
  if ShortCut and scShift <> 0 then Include(Shift, ssShift);
  if ShortCut and scCtrl <> 0 then Include(Shift, ssCtrl);
  if ShortCut and scAlt <> 0 then Include(Shift, ssAlt);
end;

type
  TMenuKeyCap = (mkcBkSp, mkcTab, mkcEsc, mkcEnter, mkcSpace, mkcPgUp,
    mkcPgDn, mkcEnd, mkcHome, mkcLeft, mkcUp, mkcRight, mkcDown, mkcIns,
    mkcDel, mkcShift, mkcCtrl, mkcAlt);

var
  MenuKeyCaps: array[TMenuKeyCap] of string = (
    SmkcBkSp, SmkcTab, SmkcEsc, SmkcEnter, SmkcSpace, SmkcPgUp,
    SmkcPgDn, SmkcEnd, SmkcHome, SmkcLeft, SmkcUp, SmkcRight,
    SmkcDown, SmkcIns, SmkcDel, SmkcShift, SmkcCtrl, SmkcAlt);

function GetSpecialName(ShortCut: TShortCut): string;
var
  ScanCode: Integer;
{$IF DEFINED(CLR)}
  KeyName: StringBuilder;
{$ELSE}
  KeyName: array[0..255] of Char;
{$ENDIF}
begin
  Result := '';
  ScanCode := MapVirtualKey(LoByte(Word(ShortCut)), 0) shl 16;
  if ScanCode <> 0 then
  begin
{$IF DEFINED(CLR)}
    KeyName := StringBuilder.Create(256);
    GetKeyNameText(ScanCode, KeyName, KeyName.Capacity);
    GetSpecialName := KeyName.ToString;
{$ELSE}
    if GetKeyNameText(ScanCode, KeyName, Length(KeyName)) <> 0 then
      Result := KeyName
    else
      Result := '';
{$ENDIF}
  end;
end;

function ShortCutToText(ShortCut: TShortCut): string;
var
  Name: string;
  Key: Byte;
begin
  Key := LoByte(Word(ShortCut));
  case Key of
    $08, $09:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcBkSp) + Key - $08)];
    $0D: Name := MenuKeyCaps[mkcEnter];
    $1B: Name := MenuKeyCaps[mkcEsc];
    $20..$28:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcSpace) + Key - $20)];
    $2D..$2E:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcIns) + Key - $2D)];
    $30..$39: Name := Chr(Key - $30 + Ord('0'));
    $41..$5A: Name := Chr(Key - $41 + Ord('A'));
    $60..$69: Name := Chr(Key - $60 + Ord('0'));
    $70..$87: Name := 'F' + IntToStr(Key - $6F);
  else
    Name := GetSpecialName(ShortCut);
  end;
  if Name <> '' then
  begin
    Result := '';
    if ShortCut and scShift <> 0 then Result := Result + MenuKeyCaps[mkcShift];
    if ShortCut and scCtrl <> 0 then Result := Result + MenuKeyCaps[mkcCtrl];
    if ShortCut and scAlt <> 0 then Result := Result + MenuKeyCaps[mkcAlt];
    Result := Result + Name;
  end
  else Result := '';
end;

{ This function is *very* slow.  Use sparingly.  Return 0 if no VK code was
  found for the text }

function TextToShortCut(Text: string): TShortCut;

  { If the front of Text is equal to Front then remove the matching piece
    from Text and return True, otherwise return False }

  function CompareFront(var Text: string; const Front: string): Boolean;
  begin
    Result := False;
    if (Length(Text) >= Length(Front)) and
{$IF DEFINED(CLR)}
        StartsText(Front, Text) then
{$ELSE}
      (AnsiStrLIComp(PChar(Text), PChar(Front), Length(Front)) = 0) then
{$ENDIF}
    begin
      Result := True;
      Delete(Text, 1, Length(Front));
    end;
  end;

var
  Key: TShortCut;
  Shift: TShortCut;
begin
  Result := 0;
  Shift := 0;
  while True do
  begin
    if CompareFront(Text, MenuKeyCaps[mkcShift]) then Shift := Shift or scShift
    else if CompareFront(Text, '^') then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcCtrl]) then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcAlt]) then Shift := Shift or scAlt
    else Break;
  end;
  if Text = '' then Exit;
  for Key := $08 to $255 do { Copy range from table in ShortCutToText }
    if AnsiCompareText(Text, ShortCutToText(Key)) = 0 then
    begin
      Result := Key or Shift;
      Exit;
    end;
end;

{ Menu command managment }

var
  CommandPool: TBits;

function UniqueCommand: Word;
begin
  Result := CommandPool.OpenBit;
  CommandPool[Result] := True;
end;

{ Used to populate or merge menus }

{$IFNDEF WIN32}
                                                                                           
// Win64 and CLR both use Iterator objects instead of local procedure for operations which
// require iterating over the menu items.  Calling a local procedure in a class method
// requires special a ASM thunk
{$DEFINE ITERATOR_OBJECTS}
{$ENDIF}

type
  TIterator = function (MenuItem: TMenuItem): Boolean{$IFDEF ITERATOR_OBJECTS} of object{$ENDIF};

procedure IterateMenus(Func: TIterator; Menu1, Menu2: TMenuItem);
var
  IIndex: Integer;

  function Iterate(var I: Integer; MenuItem: TMenuItem; AFunc: TIterator): Boolean;
  var
    Item: TMenuItem;
  begin
    Result := False;
    if MenuItem = nil then Exit;
    while not Result and (I < MenuItem.Count) do
    begin
      Item := MenuItem[I];
      if Item.GroupIndex > IIndex then Break;
{$IFDEF ITERATOR_OBJECTS}
      Result := AFunc(Item);
{$ELSE !ITERATOR_OBJECTS}
{$IFDEF CPUX86}
      // Thunk to to call a local procedure on a class.  Kinda hokey if you ask ME.
      asm
                MOV     EAX,Item
                MOV     EDX,[EBP+8]
                PUSH    DWORD PTR [EDX]
                CALL    DWORD PTR AFunc
                ADD     ESP,4
                MOV     Result,AL
      end;
{$ENDIF CPUX86}
{$ENDIF !ITERATOR_OBJECTS}
      Inc(I);
    end;
  end;

var
  I, J: Integer;
  JIndex: Byte;
  Menu1Size, Menu2Size: Integer;
  Done: Boolean;

begin
  I := 0;
  J := 0;
  Menu1Size := 0;
  Menu2Size := 0;
  if Menu1 <> nil then Menu1Size := Menu1.Count;
  if Menu2 <> nil then Menu2Size := Menu2.Count;
  Done := False;
  while not Done and ((I < Menu1Size) or (J < Menu2Size)) do
  begin
    IIndex := High(Byte);
    JIndex := High(Byte);
    if (I < Menu1Size) then IIndex := Menu1[I].GroupIndex;
    if (J < Menu2Size) then JIndex := Menu2[J].GroupIndex;
    if IIndex <= JIndex then Done := Iterate(I, Menu1, Func)
    else
    begin
      IIndex := JIndex;
      Done := Iterate(J, Menu2, Func);
    end;
    while (I < Menu1Size) and (Menu1[I].GroupIndex <= IIndex) do Inc(I);
    while (J < Menu2Size) and (Menu2[J].GroupIndex <= IIndex) do Inc(J);
  end;
end;

{ TMenuActionLink }

procedure TMenuActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TMenuItem;
end;

function TMenuActionLink.IsAutoCheckLinked: Boolean;
begin
  Result := (Action is TCustomAction) and
   (FClient.AutoCheck = TCustomAction(Action).AutoCheck);
end;

function TMenuActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    SameCaption(FClient.Caption, TCustomAction(Action).Caption);
end;

function TMenuActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Checked = TCustomAction(Action).Checked);
end;

function TMenuActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = TCustomAction(Action).Enabled);
end;

function TMenuActionLink.IsHelpContextLinked: Boolean;
begin
  Result := inherited IsHelpContextLinked and
    (FClient.HelpContext = TCustomAction(Action).HelpContext);
end;

function TMenuActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = TCustomAction(Action).Hint);
end;

function TMenuActionLink.IsGroupIndexLinked: Boolean;
begin
  Result := inherited IsGroupIndexLinked and FClient.RadioItem and
    (FClient.GroupIndex = TCustomAction(Action).GroupIndex);
end;

function TMenuActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = TCustomAction(Action).ImageIndex);
end;

function TMenuActionLink.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = TCustomAction(Action).ShortCut);
end;

function TMenuActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = TCustomAction(Action).Visible);
end;

function TMenuActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
{$IF DEFINED(CLR)}
    (((not Assigned(FClient.OnClick)) and (not Assigned(Action.OnExecute))) or
     (Assigned(FClient.OnClick) and
      DelegatesEqual(@FClient.OnClick, @Action.OnExecute)));
{$ELSE}
    (@FClient.OnClick = @Action.OnExecute);
{$ENDIF}
end;

procedure TMenuActionLink.SetAutoCheck(Value: Boolean);
begin
  if IsAutoCheckLinked then FClient.AutoCheck := Value;
end;

procedure TMenuActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TMenuActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then FClient.Checked := Value;
end;

procedure TMenuActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TMenuActionLink.SetHelpContext(Value: THelpContext);
begin
  if IsHelpContextLinked then FClient.HelpContext := Value;
end;

procedure TMenuActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TMenuActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TMenuActionLink.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.ShortCut := Value;
end;

procedure TMenuActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

procedure TMenuActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

{$IF DEFINED(CLR)}
destructor TMenuHandle.Destroy;
begin
  if FHandle <> 0 then
    DestroyMenu(FHandle);
  FHandle := 0;
  System.GC.SuppressFinalize(self);
  inherited;
end;

procedure TMenuHandle.Finalize;
begin
  if FHandle <> 0 then
    DestroyMenu(FHandle);
  FHandle := 0;
end;
{$ENDIF}

{ TMenuItemEnumerator }

constructor TMenuItemEnumerator.Create(AMenuItem: TMenuItem);
begin
  inherited Create;
  FIndex := -1;
  FMenuItem := AMenuItem;
end;

function TMenuItemEnumerator.GetCurrent: TMenuItem;
begin
  Result := FMenuItem[FIndex];
end;

function TMenuItemEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FMenuItem.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TMenuItem }

constructor TMenuItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisible := True;
  FEnabled := True;
  FAutoHotkeys := maParent;
  FAutoLineReduction := maParent;
  FCommand := UniqueCommand;
  FImageIndex := -1;
  FHint := '';
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
end;

destructor TMenuItem.Destroy;
begin
  ShortCutItems.ClearItem(Self);
  if FParent <> nil then
  begin
    FParent.Remove(Self);
    FParent := nil;
  end;
  while Count > 0 do Items[0].Free;
{$IF DEFINED(CLR)}
  if Assigned(FHandle) and (FHandle.Value <> 0) then
    MergeWith(nil);
  FreeAndNil(FHandle);
{$ELSE}
  if FHandle <> 0 then
  begin
    MergeWith(nil);
    DestroyMenu(FHandle);
  end;
{$ENDIF}
  FreeAndNil(FItems);
  FreeAndNil(FActionLink);
  FreeAndNil(FImageChangeLink);
  if FCommand <> 0 then CommandPool[FCommand] := False;
  FBitmap.Free;
  inherited Destroy;
end;

const
  Checks: array[Boolean] of DWORD = (MF_UNCHECKED, MF_CHECKED);
  Enables: array[Boolean] of DWORD = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
  Breaks: array[TMenuBreak] of DWORD = (0, MF_MENUBREAK, MF_MENUBARBREAK);
  Separators: array[Boolean] of DWORD = (MF_STRING, MF_SEPARATOR);

procedure TMenuItem.AppendTo(Menu: HMENU; ARightToLeft: Boolean);
const
  IBreaks: array[TMenuBreak] of DWORD = (MFT_STRING, MFT_MENUBREAK, MFT_MENUBARBREAK);
  IChecks: array[Boolean] of DWORD = (MFS_UNCHECKED, MFS_CHECKED);
  IDefaults: array[Boolean] of DWORD = (0, MFS_DEFAULT);
  IEnables: array[Boolean] of DWORD = (MFS_DISABLED or MFS_GRAYED, MFS_ENABLED);
  IRadios: array[Boolean] of DWORD = (MFT_STRING, MFT_RADIOCHECK);
  ISeparators: array[Boolean] of DWORD = (MFT_STRING, MFT_SEPARATOR);
  IRTL: array[Boolean] of DWORD = (0, RightToLeftMenuFlag);
  IOwnerDraw: array[Boolean] of DWORD = (MFT_STRING, MFT_OWNERDRAW);
var
  MenuItemInfo: TMenuItemInfo;
  Caption: string;
  NewFlags: Integer;
  IsOwnerDraw: Boolean;
  ParentMenu: TMenu;
  ImageList: TCustomImageList;
{$IF DEFINED(CLR)}
  CaptionData: IntPtr;
{$ENDIF}
begin
  if FVisible then
  begin
    Caption := FCaption;
    if GetCount > 0 then
      MenuItemInfo.hSubMenu := GetHandle
    else if (FShortCut <> scNone) and ((Parent = nil) or
            (Parent.Parent <> nil) or not (Parent.Owner is TMainMenu)) then
      Caption := Caption + #9 + ShortCutToText(FShortCut);
    if Byte(GetVersion) >= 4 then
    begin
{$IF DEFINED(CLR)}
      MenuItemInfo.cbSize := Marshal.SizeOf(TypeOf(TMenuItemInfo));  // Required for XP64
{$ELSE}
      if (Win32Platform <> VER_PLATFORM_WIN32_WINDOWS) or (Win32MajorVersion > 4) then
        MenuItemInfo.cbSize := SizeOf(TMenuItemInfo)
      else
        MenuItemInfo.cbSize := 44; // Required for Windows 95
{$ENDIF}
      MenuItemInfo.fMask := MIIM_CHECKMARKS or MIIM_DATA or MIIM_ID or
        MIIM_STATE or MIIM_SUBMENU or MIIM_TYPE;
      ParentMenu := GetParentMenu;
      ImageList := GetImageList;
      IsOwnerDraw := Assigned(ParentMenu) and
                     (ParentMenu.OwnerDraw or (ImageList <> nil)) or
                     Assigned(FBitmap) and not FBitmap.Empty;
      if (Parent.Owner is TMainMenu) and CheckWin32Version(6, 0) and
         TStyleManager.SystemStyle.Available then // Vista main menu items only
          IsOwnerDraw := IsOwnerDraw and
            (((ImageList <> nil) and (FImageIndex <> -1)) or
            (FBitmap <> nil) or ParentMenu.OwnerDraw);
      MenuItemInfo.fType := IRadios[FRadioItem] or IBreaks[FBreak] or
        ISeparators[FCaption = cLineCaption] or IRTL[ARightToLeft] or
        IOwnerDraw[IsOwnerDraw];
      MenuItemInfo.fState := IChecks[FChecked] or IEnables[FEnabled]
        or IDefaults[FDefault];
      MenuItemInfo.wID := Command;
      MenuItemInfo.hSubMenu := 0;
      MenuItemInfo.hbmpChecked := 0;
      MenuItemInfo.hbmpUnchecked := 0;
      if GetCount > 0 then
        MenuItemInfo.hSubMenu := GetHandle;
{$IF DEFINED(CLR)}
      CaptionData := Marshal.StringToHGlobalAuto(Caption);
      try
        MenuItemInfo.dwTypeData := CaptionData;
        InsertMenuItem(Menu, DWORD(-1), True, MenuItemInfo);
      finally
        Marshal.FreeHGlobal(CaptionData);
      end;
{$ELSE}
      MenuItemInfo.dwTypeData := PChar(Caption);
      InsertMenuItem(Menu, DWORD(-1), True, MenuItemInfo);
{$ENDIF}
    end
    else
    begin
      NewFlags := Breaks[FBreak] or Checks[FChecked] or Enables[FEnabled] or
        Separators[FCaption = cLineCaption] or MF_BYPOSITION;
      if GetCount > 0 then
{$IF DEFINED(CLR)}
        InsertMenu(Menu, DWORD(-1), MF_POPUP or NewFlags, GetHandle, FCaption)
      else
        InsertMenu(Menu, DWORD(-1), NewFlags, Command, Caption);
{$ELSE}
        InsertMenu(Menu, DWORD(-1), MF_POPUP or NewFlags, GetHandle, PChar(FCaption))
      else
        InsertMenu(Menu, DWORD(-1), NewFlags, Command, PChar(Caption));
{$ENDIF}
    end;
  end;
end;

{$IFDEF ITERATOR_OBJECTS}
type
  TMenuPopulator = class
    FHandle: HMENU;
    MenuRightToLeft: Boolean;
    function AddIn(MenuItem: TMenuItem): Boolean;
  end;

function TMenuPopulator.AddIn(MenuItem: TMenuItem): Boolean;
begin
  MenuItem.AppendTo(FHandle, MenuRightToLeft);
  Result := False;
end;
{$ENDIF ITERATOR_OBJECTS}

procedure TMenuItem.PopulateMenu;
var
{$IFDEF ITERATOR_OBJECTS}
  MenuPopulator: TMenuPopulator;
{$ELSE !ITERATOR_OBJECTS}
  MenuRightToLeft: Boolean;

  function AddIn(MenuItem: TMenuItem): Boolean;
  begin
    MenuItem.AppendTo(FHandle, MenuRightToLeft);
    Result := False;
  end;
{$ENDIF !ITERATOR_OBJECTS}

begin
  if (FMenu <> nil) and
     (FMenu is TMainMenu) then
  begin
    InternalRethinkHotkeys(False);
    InternalRethinkLines(False);
  end;

  // all menu items use BiDiMode of their root menu
{$IFDEF ITERATOR_OBJECTS}
  MenuPopulator := TMenuPopulator.Create;
  try
    MenuPopulator.FHandle := Handle;
    MenuPopulator.MenuRightToLeft := (FMenu <> nil) and FMenu.IsRightToLeft;
    IterateMenus(MenuPopulator.AddIn, FMerged, Self);
  finally
    MenuPopulator.Free;
  end;
{$ELSE !ITERATOR_OBJECTS}
  MenuRightToLeft := (FMenu <> nil) and FMenu.IsRightToLeft;
  IterateMenus(@AddIn, FMerged, Self);
{$ENDIF !ITERATOR_OBJECTS}
end;

procedure TMenuItem.ReadShortCutText(Reader: TReader);
begin
  ShortCut := TextToShortCut(Reader.ReadString);
end;

procedure TMenuItem.MergeWith(Menu: TMenuItem);
begin
  if Assigned(Menu) and (csDestroying in Menu.ComponentState) then exit;
  if FMerged <> Menu then
  begin
    if FMerged <> nil then
      FMerged.FMergedWith := nil;
    FMerged := Menu;
    if FMerged <> nil then
    begin
      FMerged.FMergedWith := Self;
      FMerged.FreeNotification(Self);
    end;
    RebuildHandle;
  end;
end;

procedure TMenuItem.Loaded;
begin
  inherited Loaded;
  if Action <> nil then ActionChange(Action, True);
  if FStreamedRebuild then RebuildHandle;
end;

procedure TMenuItem.RebuildHandle;
var
  I: Integer;
  LRepopulate: Boolean;
begin
  if csDestroying in ComponentState then Exit;
  if csReading in ComponentState then
    FStreamedRebuild := True
  else
  begin
    if FMergedWith <> nil then
      FMergedWith.RebuildHandle
    else
    begin
      I := GetMenuItemCount(Handle);
      LRepopulate := I = 0;
      while I > 0 do
      begin
        if GetMenuState(Handle, I - 1, MF_BYPOSITION) and MF_BITMAP = 0 then
        begin
          RemoveMenu(Handle, I - 1, MF_BYPOSITION);
          LRepopulate := True;
        end;
        Dec(I);
      end;
      if LRepopulate then
      begin
        if (FParent = nil) and (FMenu is TMainMenu) and
           (GetMenuItemCount(Handle) = 0) then
        begin
{$IF DEFINED(CLR)}
          DestroyMenu(FHandle.Value);
          FHandle.Value := 0;
{$ELSE}
          DestroyMenu(FHandle);
          FHandle := 0;
{$ENDIF}
        end
        else
          PopulateMenu;
        MenuChanged(False);
      end;
    end;
  end;
end;

procedure TMenuItem.VerifyGroupIndex(Position: Integer; Value: Byte);
var
  I: Integer;
begin
  for I := 0 to GetCount - 1 do
    if I < Position then
    begin
      if Items[I].GroupIndex > Value then 
        Error({$IFNDEF CLR}@{$ENDIF}SGroupIndexTooLow)
    end
    else
      { Ripple change to menu items at Position and after }
      if Items[I].GroupIndex < Value then Items[I].FGroupIndex := Value;
end;

function TMenuItem.GetHandle: HMENU;
begin
{$IF DEFINED(CLR)}
  if not Assigned(FHandle) then
    FHandle := TMenuHandle.Create;
  if FHandle.Value = 0 then
  begin
    if Owner is TPopupMenu then
      FHandle.Value := CreatePopupMenu
    else
      FHandle.Value := CreateMenu;
    if FHandle.Value = 0 then Error(SOutOfResources);
    PopulateMenu;
  end;
  Result := FHandle.Value;
{$ELSE}
  if FHandle = 0 then
  begin
    if Owner is TPopupMenu then
      FHandle := CreatePopupMenu
    else
      FHandle := CreateMenu;
    if FHandle = 0 then Error(@SOutOfResources);
    PopulateMenu;
  end;
  Result := FHandle;
{$ENDIF}
end;

procedure TMenuItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ShortCutText', ReadShortCutText, nil, False);
end;

procedure TMenuItem.DoDrawText(ACanvas: TCanvas; const ACaption: string;
  var Rect: TRect; Selected: Boolean; Flags: Longint);
var
  Text: string;
  R: TRect;
  ParentMenu: TMenu;
begin
  ParentMenu := GetParentMenu;
  if (ParentMenu <> nil) and (ParentMenu.IsRightToLeft) then
  begin
    if Flags and DT_LEFT = DT_LEFT then
      Flags := Flags and (not DT_LEFT) or DT_RIGHT
    else if Flags and DT_RIGHT = DT_RIGHT then
      Flags := Flags and (not DT_RIGHT) or DT_LEFT;
    Flags := Flags or DT_RTLREADING;
  end;
  Text := ACaption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or
    (Text[1] = cHotkeyPrefix) and (Text[2] = #0)) then Text := Text + ' ';
  with ACanvas do
  begin
    if Text = cLineCaption then
    begin
      if Flags and DT_CALCRECT = 0 then
      begin
        R := Rect;
        Inc(R.Top, 4);
        DrawEdge(Handle, R, EDGE_ETCHED, BF_TOP);
      end;
    end
    else
    begin
      Brush.Style := bsClear;
      if Default then
        Font.Style := Font.Style + [fsBold];
      if not Enabled then
      begin
        if not Selected then
        begin
          OffsetRect(Rect, 1, 1);
          Font.Color := clBtnHighlight;
          DrawText(Handle, Text, Length(Text), Rect, Flags);
          OffsetRect(Rect, -1, -1);
        end;
        if Selected and (ColorToRGB(clHighlight) = ColorToRGB(clBtnShadow)) then
          Font.Color := clBtnHighlight else
          Font.Color := clBtnShadow;
      end;
      DrawText(Handle, Text, Length(Text), Rect, Flags);
    end;
  end;
end;

procedure TMenuItem.DrawItem(ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  if Assigned(FOnDrawItem) then
    FOnDrawItem(Self, ACanvas, ARect, Selected);
end;

procedure DoThemedDrawText(MenuItem: TMenuItem; ACanvas: TCanvas;
  const ACaption: string; var Rect: TRect; Selected: Boolean; Flags: TTextFormat);
const
  MenuStates: array[Boolean] of TThemedMenu = (tmPopupItemDisabled, tmPopupItemNormal);
var
  LCaption: string;
  ParentMenu: TMenu;
begin
  // Adjust flags for BiDi
  ParentMenu := MenuItem.GetParentMenu;
  if (ParentMenu <> nil) and (ParentMenu.IsRightToLeft) then
  begin
    if (tfLeft in Flags) then
      Flags := Flags - [tfLeft] + [tfRight]
    else if (tfRight in Flags) then
      Flags := Flags + [tfLeft] - [tfRight];
    Include(Flags, tfRtlReading);
  end;

  // Tweak menu item text
  LCaption := ACaption;
  if (tfCalcRect in Flags) and ((LCaption = '') or
    (LCaption[1] = cHotkeyPrefix) and (LCaption[2] = #0)) then LCaption := LCaption + ' ';

  // Draw menu item text
  with ACanvas do
  begin
    Brush.Style := bsClear;
    if MenuItem.Default then
      Font.Style := Font.Style + [fsBold];
    TStyleManager.SystemStyle.DrawText(ACanvas.Handle,
      TStyleManager.SystemStyle.GetElementDetails(MenuStates[MenuItem.Enabled]), LCaption, Rect, Flags);
  end;
end;

procedure TMenuItem.AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
  State: TOwnerDrawState; TopLevel: Boolean);
const
  EdgeStyle: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
  Alignment: TPopupAlignment;
  DrawImage, DrawGlyph: Boolean;
  GlyphRect, SaveRect: TRect;
  Glyph: TBitmap;
  OldBrushColor: TColor;
  Selected: Boolean;
  Win98Plus: Boolean;
  Win2K: Boolean;
  WinXP: Boolean;
  WinXPFlatMenus: Boolean;
  WinVista: Boolean;

  procedure ThemedDraw(RightToLeft: Boolean);
  const
    Alignments: array[TPopupAlignment] of TTextFormats = (tfLeft, tfRight, tfCenter);
    MenuBarStates: array[Boolean, Boolean] of TThemedMenu =
      ((tmMenuBarItemNormal, tmMenuBarItemPushed), (tmMenuBarItemHot, tmMenuBarItemPushed));
    MenuBarItemStates: array[Boolean] of TThemedMenu = (tmMenuBarItemDisabled, tmMenuBarItemNormal);
    MenuItemStates: array[Boolean] of TThemedMenu = (tmPopupItemDisabled, tmPopupItemNormal);
    MenuHighlightStates: array[Boolean] of TThemedMenu = (tmPopupItemDisabledHot, tmPopupItemHot);
    CheckMarkBkgStates: array[Boolean] of TThemedMenu = (tmPopupCheckBackgroundDisabled, tmPopupCheckBackgroundNormal);
    CheckMarkStates: array[Boolean {Enabled}, Boolean {RadioItem}] of TThemedMenu =
      ((tmPopupCheckDisabled, tmPopupBulletDisabled), (tmPopupCheckNormal, tmPopupBulletNormal));
    SubMenuStates: array[Boolean] of TThemedMenu = (tmPopupSubMenuDisabled, tmPopupSubMenuNormal);
  var
    LShortCut: string;
    LColor: TColor;
    LSize, LCheckSize: TSize;
    LMargins, LCheckMargins: TElementMargins;
    LGutterRect, LCheckRect, LBitmapRect: TRect;
    DrawStyle: TTextFormat;
    LStyle: TCustomStyleServices;
    LDetails: TThemedElementDetails;
  begin
    LStyle := TStyleManager.SystemStyle;
    if TopLevel then
    begin
      if (odSelected in State) or (odHotLight in State) then
      begin
        LStyle.GetElementColor(LStyle.GetElementDetails(MenuBarItemStates[Enabled]), ecTextColor, LColor);
        ACanvas.Font.Color := LColor;
        LStyle.DrawElement(ACanvas.Handle,
          LStyle.GetElementDetails(MenuBarStates[(odHotLight in State), (odSelected in State)]), ARect);
      end
      else
      begin
        ACanvas.Brush.Color := clMenuBar;
        ACanvas.FillRect(ARect);
      end;
    end
    else
    begin
      LStyle.DrawElement(ACanvas.Handle, LStyle.GetElementDetails(tmPopupBackground), ARect);
      LStyle.GetElementColor(LStyle.GetElementDetails(MenuItemStates[Enabled]), ecTextColor, LColor);
      ACanvas.Font.Color := LColor;
    end;

    // Determine rect for check marks
    LDetails := LStyle.GetElementDetails(CheckMarkStates[Enabled, RadioItem]);
    LStyle.GetElementSize(ACanvas.Handle, LDetails, esActual, LCheckSize);
    LStyle.GetElementMargins(ACanvas.Handle, LDetails, emContent, LCheckMargins);
    with ARect, LCheckMargins do
    if not RightToLeft then
        LCheckRect := Rect(Left, Top,
          Left + LCheckSize.cx + cxRightWidth + cxRightWidth,
          Top + LCheckSize.cy + cyBottomHeight + cyBottomHeight)
    else
        LCheckRect := Rect(Right - LCheckSize.cx - cxRightWidth - cxRightWidth,
          Top, Right, Top + LCheckSize.cy + cyBottomHeight + cyBottomHeight);

    // Calculate glyph rect
    GlyphRect := LCheckRect;
    if Assigned(ImageList) then
    begin
      if ImageList.Height > LCheckSize.cy then
        Inc(GlyphRect.Bottom, ImageList.Height - LCheckSize.cy);
      if ImageList.Width > LCheckSize.cx then
        if not RightToLeft then
          Inc(GlyphRect.Right, ImageList.Width - LCheckSize.cx)
        else
          Dec(GlyphRect.Left, ImageList.Width - LCheckSize.cx);
      OffsetRect(LCheckRect, (GlyphRect.Right - LCheckRect.Right) div 2,
        (GlyphRect.Bottom - LCheckRect.Bottom) div 2);
    end;

    // Calculate rect for gutter and draw it
    LGutterRect := GlyphRect;
    if RightToLeft then
      LGutterRect.Right := GlyphRect.Left;
    LDetails := LStyle.GetElementDetails(tmPopupGutter);
    LStyle.GetElementSize(ACanvas.Handle, LDetails, esActual, LSize);
    LStyle.GetElementMargins(ACanvas.Handle, LDetails, emSizing, LMargins);
    if not RightToLeft then
    begin
      Inc(LGutterRect.Right, LSize.cx + LCheckMargins.cxLeftWidth);
      Inc(LGutterRect.Right, LMargins.cxLeftWidth);
    end
    else
    begin
      Dec(LGutterRect.Left, LSize.cx + LCheckMargins.cxRightWidth);
      Dec(LGutterRect.Right, LMargins.cxRightWidth);
    end;
    if not TopLevel then
      LStyle.DrawElement(ACanvas.Handle, LDetails, LGutterRect, nil);

    if ParentMenu is TMenu then
      Alignment := paLeft
    else if ParentMenu is TPopupMenu then
      Alignment := TPopupMenu(ParentMenu).Alignment
    else
      Alignment := paLeft;


    // Draw menu highlight
    if Selected and not TopLevel then
      LStyle.DrawElement(ACanvas.Handle, LStyle.GetElementDetails(MenuHighlightStates[Enabled]), ARect, nil);

    if Caption <> cLineCaption then
    begin
      DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
        (ImageIndex < ImageList.Count) or Checked and ((FBitmap = nil) or
        FBitmap.Empty));
      if DrawImage or Assigned(FBitmap) and not FBitmap.Empty then
      begin
        if DrawImage then
        begin
          // Draw glyph
          if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
          begin
            if Checked then
              LStyle.DrawElement(ACanvas.Handle, LStyle.GetElementDetails(CheckMarkBkgStates[Enabled]), LCheckRect);
            with GlyphRect do
              ImageList.Draw(ACanvas, Left + ((Right - Left - ImageList.Width) div 2),
                Top + ((Bottom - Top - ImageList.Height) div 2), ImageIndex, Enabled)
          end
          else
          begin
            // Draw check mark
            if not TopLevel then
            begin
              LStyle.DrawElement(ACanvas.Handle, LStyle.GetElementDetails(CheckMarkBkgStates[Enabled]), LCheckRect);
              LStyle.DrawElement(ACanvas.Handle, LStyle.GetElementDetails(CheckMarkStates[Enabled, RadioItem]), LCheckRect);
            end;
          end;
        end
        else
        begin
          // Need to add BitmapWidth/Height properties for TMenuItem if we're to
          // support them. Right now let's hardcode them to 16x16.
          LBitmapRect := Rect(0, 0, 16, 16);
          with GlyphRect do
            OffSetRect(LBitmapRect, Left + ((Right - Left - 16) div 2),
              Top + ((Bottom - Top - 16) div 2));
          // Make sure image is within glyph bounds
          if FBitmap.Width < LCheckSize.cx then
            with LBitmapRect do
            begin
              Left := Left + ((Right - Left) - FBitmap.Width) div 2;
              Right := Left + FBitmap.Width;
            end;
          if FBitmap.Height < LCheckSize.cy then
            with LBitmapRect do
            begin
              Top := Top + ((Bottom - Top) - FBitmap.Height) div 2;
              Bottom := Top + FBitmap.Height;
            end;
          ACanvas.StretchDraw(LBitmapRect, FBitmap);
        end;
      end;
    end;

    // Calculate size of rect for Caption
    LStyle.GetElementMargins(ACanvas.Handle, LStyle.GetElementDetails(tmPopupItemNormal), emSizing, LMargins);
    if not TopLevel then
    begin
      if not RightToLeft then
      begin
        ARect.Left := LGutterRect.Right;
        Inc(ARect.Left, LMargins.cxLeftWidth);
      end
      else
      begin
        ARect.Right := LGutterRect.Left;
        Dec(ARect.Right, LMargins.cxLeftWidth);
      end;

      if Caption <> cLineCaption then
      begin
        LStyle.GetElementSize(ACanvas.Handle, LStyle.GetElementDetails(SubMenuStates[Enabled]), esActual, LSize);
        if not RightToLeft then
          Dec(ARect.Right, LSize.cx)
        else
          Inc(ARect.Left, LSize.cx);
      end;
    end
    else
    begin
      if (Assigned(ImageList) and (FImageIndex <> -1)) or (FBitmap <> nil) then
      begin
        if not RightToLeft then
          Inc(ARect.Left, GlyphRect.Right - GlyphRect.Left)
        else
          Dec(ARect.Right, GlyphRect.Right - GlyphRect.Left);
      end
      else
      begin
        if not RightToLeft then
          Inc(ARect.Left, LMargins.cxLeftWidth + 3)
        else
          Dec(ARect.Right, LMargins.cxLeftWidth + 3);
      end;
    end;

    // Draw Caption + ShortCut or separator line
    if Caption <> cLineCaption then
    begin
      DrawStyle := [tfExpandTabs, tfSingleLine] + [Alignments[Alignment]];
      if (odNoAccel in State) then
        Include(DrawStyle, tfHidePrefix);
      // Calculate vertical layout
      SaveRect := ARect;
      DoThemedDrawText(Self, ACanvas, Caption, ARect, Selected, DrawStyle + [tfCalcRect, tfNoClip]);
      if RightToLeft then
      begin
        // DT_CALCRECT does not take into account alignment
        ARect.Left := SaveRect.Left;
        ARect.Right := SaveRect.Right;
      end;
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);

      DoThemedDrawText(Self, ACanvas, Caption, ARect, Selected, DrawStyle);
      if (ShortCut <> 0) and not TopLevel and (FItems = nil) then
      begin
        LShortCut := ShortCutToText(ShortCut);
        if not RightToLeft then
        begin
          ARect.Left := ARect.Right;
          ARect.Right := SaveRect.Right - LSize.cx - LMargins.cxLeftWidth;
        end
        else
        begin
          with LSize, LMargins do
            ARect.Left := cx + cx + cxLeftWidth + cxRightWidth;
          ARect.Right := ARect.Left + ACanvas.TextWidth(LShortCut);
        end;
        DoDrawText(ACanvas, LShortCut, ARect, Selected, DT_RIGHT);
      end;
    end
    else
    begin
      if not RightToLeft then
        ARect.Left := LGutterRect.Right + 1
      else
        ARect.Right := LGutterRect.Left - 1;
      LDetails := LStyle.GetElementDetails(tmPopupSeparator);
      LStyle.GetElementMargins(ACanvas.Handle, LDetails, emSizing, LMargins);
      Dec(ARect.Bottom, LMargins.cyBottomHeight);
      LStyle.DrawElement(ACanvas.Handle, LDetails, ARect);
    end;
  end;


  procedure NormalDraw;
  const
    Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  var
    DrawStyle: Longint;
  begin
    with ACanvas do
    begin
      if (WinXP and WinXPFlatMenus) or (WinXP and TStyleManager.SystemStyle.Enabled) then
      begin
        if (odSelected in State) or (odHotLight in State) then
        begin
          if TStyleManager.SystemStyle.Enabled then
            Brush.Color := clMenuHighlight
          else
            Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end
        else if TopLevel then
          Brush.Color := clMenuBar
      end;
      //ImageList := GetImageList;
      { With XP, we need to always fill in the rect, even when selected }
      if not Selected or WinXP then
        FillRect(ARect);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      GlyphRect.Left := ARect.Left + 1;
      GlyphRect.Top := ARect.Top + 1;
      if Caption = cLineCaption then
      begin
        FillRect(ARect);
        GlyphRect.Left := 0;
        GlyphRect.Right := -4;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
          (ImageIndex < ImageList.Count) or Checked and ((FBitmap = nil) or
          FBitmap.Empty));
        if DrawImage or Assigned(FBitmap) and not FBitmap.Empty then
        begin
          DrawGlyph := True;

          if DrawImage then
          begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            { Need to add BitmapWidth/Height properties for TMenuItem if we're to
              support them.  Right now let's hardcode them to 16x16. }
            GlyphRect.Right := GlyphRect.Left + 16;
            GlyphRect.Bottom := GlyphRect.Top + 16;
          end;

          { Draw background pattern brush if selected }
          if Checked and not WinXP then
          begin
            Inc(GlyphRect.Right);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Inc(GlyphRect.Left);
            Inc(GlyphRect.Top);
          end;

          if DrawImage then
          begin
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
              ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, ImageIndex,
                Enabled)
            else
            begin
              { Draw a menu check }
              Glyph := TBitmap.Create;
              try
                Glyph.Transparent := True;
{$IF DEFINED(CLR)}
                Glyph.Handle := LoadBitmap(0, OBM_CHECK);
{$ELSE}
                Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
{$ENDIF}
                OldBrushColor := Font.Color;
                Font.Color := clBtnText;
                Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
                  GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
                Font.Color := OldBrushColor;
              finally
                Glyph.Free;
              end;
            end;
          end
          else
          begin
            SaveRect := GlyphRect;
            { Make sure image is within glyph bounds }
            if FBitmap.Width < GlyphRect.Right - GlyphRect.Left then
              with GlyphRect do
              begin
                Left := Left + ((Right - Left) - FBitmap.Width) div 2 + 1;
                Right := Left + FBitmap.Width;
              end;
            if FBitmap.Height < GlyphRect.Bottom - GlyphRect.Top then
              with GlyphRect do
              begin
                Top := Top + ((Bottom - Top) - FBitmap.Height) div 2 + 1;
                Bottom := Top + FBitmap.Height;
              end;
            StretchDraw(GlyphRect, FBitmap);
            GlyphRect := SaveRect;
          end;

          if Checked then
          begin
            Dec(GlyphRect.Right);
            Dec(GlyphRect.Bottom);
          end;
        end
        else
        begin
          if (ImageList <> nil) and not TopLevel then
          begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            GlyphRect.Right := GlyphRect.Left;
            GlyphRect.Bottom := GlyphRect.Top;
          end;
          DrawGlyph := False;
        end;
      end;
      with GlyphRect do
      begin
        Dec(Left);
        Dec(Top);
        Inc(Right, 2);
        Inc(Bottom, 2);
      end;

      if Checked or Selected and DrawGlyph then
        if not WinXP then
          DrawEdge(Handle, GlyphRect, EdgeStyle[Checked], BF_RECT);

      if Selected then
      begin
        if DrawGlyph then ARect.Left := GlyphRect.Right + 1;
        if not (Win98Plus and TopLevel) then
          Brush.Color := clHighlight;
        FillRect(ARect);
      end;
      if TopLevel and Win98Plus and not (WinXP and WinXPFlatMenus) then
      begin
        if Selected then
          DrawEdge(Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
        else if odHotLight in State then
          DrawEdge(Handle, ARect, BDR_RAISEDINNER, BF_RECT);
        if not Selected then
          OffsetRect(ARect, 0, -1);
      end;

      if not (Selected and DrawGlyph) then
        ARect.Left := GlyphRect.Right + 1;
      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);

      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      if Win2K and (odNoAccel in State) then
        DrawStyle := DrawStyle or DT_HIDEPREFIX;
      { Calculate vertical layout }
      SaveRect := ARect;
      if odDefault in State then
        Font.Style := [fsBold];
      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
      if TopLevel and Selected and Win98Plus and not WinXP then
        OffsetRect(ARect, 1, 0);

      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle);
      if (ShortCut <> 0) and not TopLevel and not (WinVista and (FItems <> nil)) then
      begin
        ARect.Left := ARect.Right;
        ARect.Right := SaveRect.Right - 10;
        DoDrawText(ACanvas, ShortCutToText(ShortCut), ARect, Selected, DT_RIGHT);
      end;

    end;
  end;

  procedure BiDiDraw;
  const
    Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  var
    S: string;
    DrawStyle: Longint;
  begin
    with ACanvas do
    begin
      if (WinXP and WinXPFlatMenus) or (WinXP and TStyleManager.SystemStyle.Enabled) then
      begin
        if (odSelected in State) or (odHotLight in State) then
        begin
          if TStyleManager.SystemStyle.Enabled then
            Brush.Color := clMenuHighlight
          else
            Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end
        else if TopLevel then
          Brush.Color := clMenuBar
      end;
      //ImageList := GetImageList;
      { With XP, we need to always fill in the rect, even when selected }
      if not Selected or (WinXP and not Checked) then
        FillRect(ARect);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;    
      GlyphRect.Right := ARect.Right - 1;
      GlyphRect.Top := ARect.Top + 1;
      if Caption = cLineCaption then
      begin
        FillRect(ARect);
        GlyphRect.Left := GlyphRect.Right + 2;
        GlyphRect.Right := 0;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
          (ImageIndex < ImageList.Count) or Checked and ((FBitmap = nil) or
          FBitmap.Empty));
        if DrawImage or Assigned(FBitmap) and not FBitmap.Empty then
        begin
          DrawGlyph := True;    
    
          if DrawImage then
          begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            { Need to add BitmapWidth/Height properties for TMenuItem if we're to
              support them.  Right now let's hardcode them to 16x16. }
            GlyphRect.Left := GlyphRect.Right - 16;
            GlyphRect.Bottom := GlyphRect.Top + 16;
          end;    
    
          { Draw background pattern brush if selected }
          if Checked then
          begin
            Dec(GlyphRect.Left);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Dec(GlyphRect.Right);
            Inc(GlyphRect.Top);
          end;
    
          if DrawImage then
          begin
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
              ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, ImageIndex,
                Enabled)
            else
            begin
              { Draw a menu check }
              Glyph := TBitmap.Create;
              try
                Glyph.Transparent := True;
{$IF DEFINED(CLR)}
                Glyph.Handle := LoadBitmap(0, OBM_CHECK);
{$ELSE}
                Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
{$ENDIF}
                OldBrushColor := Font.Color;
                Font.Color := clBtnText;
                Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
                  GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
                Font.Color := OldBrushColor;
              finally
                Glyph.Free;
              end;
            end;
          end
          else
          begin
            SaveRect := GlyphRect;
            { Make sure image is within glyph bounds }
            if FBitmap.Width < GlyphRect.Right - GlyphRect.Left then
              with GlyphRect do
              begin
                Right := Right - ((Right - Left) - FBitmap.Width) div 2 + 1;
                Left := Right - FBitmap.Width;
              end;
            if FBitmap.Height < GlyphRect.Bottom - GlyphRect.Top then
              with GlyphRect do
              begin
                Top := Top + ((Bottom - Top) - FBitmap.Height) div 2 + 1;
                Bottom := Top + FBitmap.Height;
              end;
            StretchDraw(GlyphRect, FBitmap);
            GlyphRect := SaveRect;
          end;
    
          if Checked then
          begin
            Dec(GlyphRect.Right);    
            Dec(GlyphRect.Bottom);    
          end;    
        end
        else
        begin
          if (ImageList <> nil) and not TopLevel then
          begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            GlyphRect.Left := GlyphRect.Right;
            GlyphRect.Bottom := GlyphRect.Top;
          end;
          DrawGlyph := False;
        end;
      end;
      with GlyphRect do
      begin
        Dec(Left);    
        Dec(Top);    
        Inc(Right, 2);    
        Inc(Bottom, 2);    
      end;    
    
      if Checked or Selected and DrawGlyph and not WinXP then
        DrawEdge(Handle, GlyphRect, EdgeStyle[Checked], BF_RECT);

      if Selected then
      begin
        if DrawGlyph then ARect.Right := GlyphRect.Left - 1;
        if not (Win98Plus and TopLevel) then
          Brush.Color := clHighlight;    
        FillRect(ARect);
      end;
      if TopLevel and Win98Plus and not (WinXP and WinXPFlatMenus) then
      begin
        if Selected then
          DrawEdge(Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
        else if odHotLight in State then
          DrawEdge(Handle, ARect, BDR_RAISEDINNER, BF_RECT);
        if not Selected then
          OffsetRect(ARect, 0, -1);
      end;
      if not (Selected and DrawGlyph) then
        ARect.Right := GlyphRect.Left - 1;
      Inc(ARect.Left, 2);    
      Dec(ARect.Right, 1);    
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      if Win2K and (odNoAccel in State) then
        DrawStyle := DrawStyle or DT_HIDEPREFIX;
      { Calculate vertical layout }
      SaveRect := ARect;    
      if odDefault in State then
        Font.Style := [fsBold];
      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);    
      { the DT_CALCRECT does not take into account alignment }
      ARect.Left := SaveRect.Left;
      ARect.Right := SaveRect.Right;
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);    
      if TopLevel and Selected and Win98Plus then
        OffsetRect(ARect, 1, 0);
      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle);    
      if (ShortCut <> 0) and not TopLevel and not (WinVista and (FItems <> nil)) then
      begin
        S := ShortCutToText(ShortCut);
        ARect.Left := 10;
        ARect.Right := ARect.Left + ACanvas.TextWidth(S);
        DoDrawText(ACanvas, S, ARect, Selected, DT_RIGHT);
      end;
    end;    
  end;

begin
  ParentMenu := GetParentMenu;
  ImageList := GetImageList;
  Selected := odSelected in State;
  Win98Plus := (Win32MajorVersion > 4) or
    ((Win32MajorVersion = 4) and (Win32MinorVersion > 0));
  Win2K := (Win32MajorVersion > 4) and (Win32Platform = VER_PLATFORM_WIN32_NT);
  WinXP := CheckWin32Version(5, 1);
  if WinXP and TStyleManager.SystemStyle.Available then
    WinXPFlatMenus := GetThemeSysBool(0, TMT_FLATMENUS)
  else
    WinXPFlatMenus := False;
  if (ParentMenu <> nil) and (ParentMenu.OwnerDraw or (ImageList <> nil)) and
    (Assigned(FOnAdvancedDrawItem) or Assigned(FOnDrawItem)) then
  begin
    DrawItem(ACanvas, ARect, Selected);
    if Assigned(FOnAdvancedDrawItem) then
      FOnAdvancedDrawItem(Self, ACanvas, ARect, State);
  end else
  begin
    // Detect if we're running on Vista (or later), and if a menu theme is available
    WinVista := CheckWin32Version(6, 0);
    if WinVista and (TStyleManager.SystemStyle.Theme[teMenu] <> 0) then
      ThemedDraw((ParentMenu <> nil) and (ParentMenu.IsRightToLeft))
    else
      if (ParentMenu <> nil) and (not ParentMenu.IsRightToLeft) then
        NormalDraw
      else
        BiDiDraw;
  end;
end;

function TMenuItem.GetEnumerator: TMenuItemEnumerator;
begin
  Result := TMenuItemEnumerator.Create(Self);
end;

function TMenuItem.GetImageList: TCustomImageList;
var
  LItem: TMenuItem;
  LMenu: TMenu;
begin
  Result := nil;
  LItem := Parent;
  while (LItem <> nil) and (LItem.SubMenuImages = nil) do
    LItem := LItem.Parent;
  if LItem <> nil then
    Result := LItem.SubMenuImages
  else
  begin
    LMenu := GetParentMenu;
    if LMenu <> nil then
      Result := LMenu.Images;
  end;
end;

procedure TMenuItem.MeasureItem(ACanvas: TCanvas; var Width, Height: Integer);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Alignment: TPopupAlignment;
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
  DrawGlyph: Boolean;
  TopLevel: Boolean;
  DrawStyle: Integer;
  Text: string;
  R: TRect;

  procedure GetMenuSize;
  var
    NonClientMetrics: TNonClientMetrics;
  begin
{$IF DEFINED(CLR)}
    NonClientMetrics.cbSize := Marshal.SizeOf(TypeOf(TNonClientMetrics));
{$ELSE}
    NonClientMetrics.cbSize := NonClientMetrics.SizeOf;
{$ENDIF}
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, {$IFNDEF CLR}@{$ENDIF}NonClientMetrics, 0) then
    begin
      Width := NonClientMetrics.iMenuWidth;
      Height := NonClientMetrics.iMenuHeight;
    end;
  end;

  procedure MeasureThemedMenuItem;
  const
    CheckMarkStates: array[Boolean {Enabled}, Boolean {RadioItem}] of TThemedMenu =
      ((tmPopupCheckDisabled, tmPopupBulletDisabled), (tmPopupCheckNormal, tmPopupBulletNormal));
    CAlignments: array[TPopupAlignment] of TTextFormats = (tfLeft, tfRight, tfCenter);
  var
    LMargins: TElementMargins;
    LSize, GlyphSize: TSize;
    LDrawStyle: TTextFormat;
  begin
    Height := 0;
    Width := 0;

    with TStyleManager.SystemStyle do
    begin
      // Calculate check/glyph size
      GetElementSize(Handle, GetElementDetails(CheckMarkStates[Enabled, RadioItem]),
        esActual, GlyphSize);
      if Assigned(ImageList) and (ImageList.Height > GlyphSize.cy) then
        GlyphSize.cy := ImageList.Height;
      if Assigned(ImageList) and (ImageList.Width > GlyphSize.cx) then
        GlyphSize.cx := ImageList.Width;

      if TopLevel then
      begin
        // Add space for glyph if assigned
        if (Assigned(ImageList) and (FImageIndex <> -1)) or (FBitmap <> nil) then
          Inc(Width, GlyphSize.cx);

        // Add size of main menu item
        GetElementSize(Handle, GetElementDetails(tmMenuBarItemNormal), esActual, LSize);
        Inc(Height, LSize.cy);
      end
      else
      begin
        Inc(Height, GlyphSize.cy);
        Inc(Width, GlyphSize.cx);

        // Add margins for check/glyph
        GetElementMargins(Handle, GetElementDetails(CheckMarkStates[Enabled, RadioItem]),
          emContent, LMargins);
        Inc(Height, LMargins.cyTopHeight + LMargins.cyBottomHeight);
        Inc(Width, LMargins.cxLeftWidth + LMargins.cxRightWidth);

        // Add size and margins for gutter
        GetElementSize(Handle, GetElementDetails(tmPopupGutter), esActual, LSize);
        Inc(Width, LSize.cx);
        GetElementMargins(Handle, GetElementDetails(tmPopupGutter), emSizing, LMargins);
        Inc(Width, LMargins.cxLeftWidth + LMargins.cxRightWidth);

        // Add margins for menu item
        GetElementMargins(Handle, GetElementDetails(tmPopupItemNormal), emSizing, LMargins);
        Inc(Width, LMargins.cxLeftWidth + LMargins.cxRightWidth);

        // Add size of potential submenu glyph
        GetElementSize(Handle, GetElementDetails(tmPopupSubMenuNormal), esActual, LSize);
        Inc(Width, LSize.cx);

        // Adjust size if separator
        if Caption = cLineCaption then
        begin
          GetElementSize(Handle, GetElementDetails(tmPopupSeparator), esActual, LSize);
          GetElementMargins(Handle, GetElementDetails(tmPopupSeparator), emSizing, LMargins);
          Height := LSize.cy + LMargins.cyBottomHeight;
          Inc(Width, LSize.cx);
        end
      end;

      R := Rect(0, 0, 0, 0);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      if ShortCut <> 0 then
        Text := Concat(Caption, ShortCutToText(ShortCut))
      else
        Text := Caption;
      LDrawStyle := [CAlignments[Alignment]] + [tfExpandTabs, tfSingleLine, tfNoClip, tfCalcRect];
      DoThemedDrawText(Self, ACanvas, Text, R, False, LDrawStyle);
      Inc(Width, R.Right - R.Left);
    end;
  end;

begin
  if GetParentComponent is TMainMenu then
  begin
    TopLevel := True;
    GetMenuSize;
  end
  else TopLevel := False;

  ImageList := GetImageList;
  ParentMenu := GetParentMenu;
  // Detect if we're running on Vista (or later), and if a menu theme is available
  if CheckWin32Version(6, 0) and (TStyleManager.SystemStyle.Theme[teMenu] <> 0) then
    MeasureThemedMenuItem
  else
  begin
    if Caption = cLineCaption then
    begin
      Height := 5;
      Width := -2;
      DrawGlyph := False;
    end
    else if Assigned(ImageList) and ((ImageIndex > -1) or not TopLevel) then
    begin
      Width := ImageList.Width;
      if not TopLevel then
        Height := ImageList.Height;
      DrawGlyph := True;
    end
    else if Assigned(FBitmap) and not FBitmap.Empty then
    begin
      Width := 16;
      if not TopLevel then
        Height := 16;
      DrawGlyph := True;
    end
    else
    begin
      Width := -7;
      DrawGlyph := False;
    end;
    if DrawGlyph and not TopLevel then
      Inc(Width, 15);
    if not TopLevel then
      Inc(Height, 3);
    R := Rect(0, 0, 0, 0);
    if ParentMenu is TMenu then
      Alignment := paLeft
    else if ParentMenu is TPopupMenu then
      Alignment := TPopupMenu(ParentMenu).Alignment
    else
      Alignment := paLeft;
    if ShortCut <> 0 then
      Text := Concat(Caption, ShortCutToText(ShortCut)) else
      Text := Caption;
    DrawStyle := Alignments[Alignment] or DT_EXPANDTABS or DT_SINGLELINE or
      DT_NOCLIP or DT_CALCRECT;
    DoDrawText(ACanvas, Text, R, False, DrawStyle);
    Inc(Width, R.Right - R.Left + 7);
  end;

  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, ACanvas, Width, Height);
end;

function TMenuItem.HasParent: Boolean;
begin
  Result := True;
end;

procedure TMenuItem.SetBreak(Value: TMenuBreak);
begin
  if FBreak <> Value then
  begin
    FBreak := Value;
    MenuChanged(True);
  end;
end;

procedure TMenuItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    MenuChanged(True);
  end;
end;

procedure TMenuItem.TurnSiblingsOff;
var
  I: Integer;
  Item: TMenuItem;
begin
  if FParent <> nil then
    for I := 0 to FParent.Count - 1 do
    begin
      Item := FParent[I];
      if (Item <> Self) and Item.FRadioItem and (Item.GroupIndex = GroupIndex) then
        Item.SetChecked(False);
    end;
end;

procedure TMenuItem.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    if (FParent <> nil) and not (csReading in ComponentState) then
      CheckMenuItem(FParent.Handle, FCommand, MF_BYCOMMAND or Checks[Value]);
    if Value and FRadioItem then
      TurnSiblingsOff;
  end;
end;

procedure TMenuItem.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Count <> 0)) or
      ((Parent <> nil) and Assigned(Parent.FMergedWith)) then
      MenuChanged(True)
    else
    begin
      if (FParent <> nil) and not (csReading in ComponentState) then
        EnableMenuItem(FParent.Handle, FCommand, MF_BYCOMMAND or Enables[Value]);
      MenuChanged(False);
    end;
  end;
end;

procedure TMenuItem.SetGroupIndex(Value: Byte);
begin
  if FGroupIndex <> Value then
  begin
    if Parent <> nil then Parent.VerifyGroupIndex(Parent.IndexOf(Self), Value);
    FGroupIndex := Value;
    if FChecked and FRadioItem then
      TurnSiblingsOff;
  end;
end;

function TMenuItem.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action else
    Result := nil;
end;

function TMenuItem.GetActionLinkClass: TMenuActionLinkClass;
begin
  Result := TMenuActionLink;
end;

function TMenuItem.GetCount: Integer;
begin
  if FItems = nil then Result := 0
  else Result := FItems.Count;
end;

function TMenuItem.GetItem(Index: Integer): TMenuItem;
begin
  if FItems = nil then 
    Error({$IFNDEF CLR}@{$ENDIF}SMenuIndexError);
  Result := TMenuItem(FItems[Index]);
end;

procedure TMenuItem.SetShortCut(Value: TShortCut);
begin
  if FShortCut <> Value then
  begin
    FShortCut := Value;
    MenuChanged(True);
  end;
end;

procedure TMenuItem.SetVisible(Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    MenuChanged(True);
  end;
end;

procedure TMenuItem.SetImageIndex(Value: TImageIndex);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    MenuChanged(True);
  end;
end;

function TMenuItem.GetMenuIndex: Integer;
begin
  Result := -1;
  if FParent <> nil then Result := FParent.IndexOf(Self);
end;

procedure TMenuItem.SetMenuIndex(Value: Integer);
var
  Parent: TMenuItem;
  Count: Integer;
begin
  if FParent <> nil then
  begin
    Count := FParent.Count;
    if Value < 0 then Value := 0;
    if Value >= Count then Value := Count - 1;
    if Value <> MenuIndex then
    begin
      Parent := FParent;
      Parent.Remove(Self);
      Parent.Insert(Value, Self);
    end;
  end;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TMenuItem.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Proc(Items[I]);
end;

procedure TMenuItem.SetChildOrder(Child: TComponent; Order: Integer);
begin
  (Child as TMenuItem).MenuIndex := Order;
end;

procedure TMenuItem.SetDefault(Value: Boolean);
var
  I: Integer;
begin
  if FDefault <> Value then
  begin
    if Value and (FParent <> nil) then
      for I := 0 to FParent.Count - 1 do
        if FParent[I].Default then FParent[I].FDefault := False;
    FDefault := Value;
    MenuChanged(True);
  end;
end;

procedure TMenuItem.InitiateAction;
begin
  if FActionLink <> nil then FActionLink.Update;
end;

procedure TMenuItem.Insert(Index: Integer; Item: TMenuItem);
begin
  if Item.FParent <> nil then 
    Error({$IFNDEF CLR}@{$ENDIF}SMenuReinserted);
  if FItems = nil then FItems := TList.Create;
  if (Index - 1 >= 0) and (Index - 1 < FItems.Count) then
    if Item.GroupIndex < TMenuItem(FItems[Index - 1]).GroupIndex then
      Item.GroupIndex := TMenuItem(FItems[Index - 1]).GroupIndex;
  VerifyGroupIndex(Index, Item.GroupIndex);
  FItems.Insert(Index, Item);
  Item.FParent := Self;
  Item.FOnChange := SubItemChanged;
{$IF DEFINED(CLR)}
  if Assigned(FHandle) and (FHandle.Value <> 0) then
{$ELSE}
  if FHandle <> 0 then
{$ENDIF}
    RebuildHandle;
  MenuChanged(Count = 1);
end;

procedure TMenuItem.Delete(Index: Integer);
var
  Cur: TMenuItem;
begin
  if (Index < 0) or (FItems = nil) or (Index >= GetCount) then 
    Error({$IFNDEF CLR}@{$ENDIF}SMenuIndexError);
  Cur := TMenuItem(FItems[Index]);
  FItems.Delete(Index);
  Cur.FParent := nil;
  Cur.FOnChange := nil;
{$IF DEFINED(CLR)}
  if Assigned(FHandle) and (FHandle.Value <> 0) then
{$ELSE}
  if FHandle <> 0 then 
{$ENDIF}
    RebuildHandle;
  MenuChanged(Count = 0);
end;

procedure TMenuItem.Click;
begin
  if Enabled then
  begin
    if (not Assigned(ActionLink) and AutoCheck) or (Assigned(ActionLink) and
        not (ActionLink.IsAutoCheckLinked) and AutoCheck) then
      Checked := not Checked;
    { Call OnClick if assigned and not equal to associated action's OnExecute.
      If associated action's OnExecute assigned then call it, otherwise, call
      OnClick. }
{$IF DEFINED(CLR)}
    if Assigned(FOnClick) and (Action <> nil) and
      not (TObject(@FOnClick).Equals(TObject(@Action.OnExecute))) then
{$ELSE}
    if Assigned(FOnClick) and (Action <> nil) and (@FOnClick <> @Action.OnExecute) then
{$ENDIF}
      FOnClick(Self)
    else if not (csDesigning in ComponentState) and (ActionLink <> nil) then
      FActionLink.Execute(Self)
    else if Assigned(FOnClick) then
      FOnClick(Self);
  end;
end;

function TMenuItem.IndexOf(Item: TMenuItem): Integer;
begin
  Result := -1;
  if FItems <> nil then Result := FItems.IndexOf(Item);
end;

procedure TMenuItem.Add(Item: TMenuItem);
begin
  Insert(GetCount, Item);
end;

procedure TMenuItem.Remove(Item: TMenuItem);
var
  I: Integer;
begin
  I := IndexOf(Item);
  if I = -1 then 
    Error({$IFNDEF CLR}@{$ENDIF}SMenuNotFound);
  Delete(I);
end;

procedure TMenuItem.MenuChanged(Rebuild: Boolean);
var
  Source: TMenuItem;
begin
  if (Parent = nil) and (Owner is TMenu) then
    Source := nil else
    Source := Self;
  if Assigned(FOnChange) then FOnChange(Self, Source, Rebuild);
end;

procedure TMenuItem.SubItemChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
begin
{$IF DEFINED(CLR)}
  if Rebuild and
    ((Assigned(FHandle) and (FHandle.Value <> 0)) or Assigned(FMergedWith)) then
{$ELSE}
  if Rebuild and ((FHandle <> 0) or Assigned(FMergedWith)) then
{$ENDIF}
    RebuildHandle;
  if Parent <> nil then Parent.SubItemChanged(Self, Source, False)
  else if Owner is TMainMenu then TMainMenu(Owner).ItemChanged;
end;

function TMenuItem.GetBitmap: TBitmap;
begin
  if FBitmap = nil then FBitmap := TBitmap.Create;
  FBitmap.Transparent := True;
  Result := FBitmap;
end;

{$IF DEFINED(CLR)}
[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TMenuItem.GetParent: TMenuItem;
begin
  Result := FParent;
end;
{$ENDIF}

procedure TMenuItem.SetAction(Value: TBasicAction);
begin
  if Value = nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if FActionLink = nil then
      FActionLink := GetActionLinkClass.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Self);
  end;
end;

procedure TMenuItem.SetBitmap(Value: TBitmap);
begin
  if FBitmap = nil then FBitmap := TBitmap.Create;
  FBitmap.Assign(Value);
  MenuChanged(True);
end;

procedure TMenuItem.InitiateActions;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].InitiateAction;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TMenuItem.GetParentComponent: TComponent;
begin
  if (FParent <> nil) and (FParent.FMenu <> nil) then
    Result := FParent.FMenu else
    Result := FParent;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TMenuItem.SetParentComponent(Value: TComponent);
begin
  if FParent <> nil then FParent.Remove(Self);
  if Value <> nil then
    if Value is TMenu then
      TMenu(Value).Items.Add(Self)
    else if Value is TMenuItem then
      TMenuItem(Value).Add(Self);
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TMenuItem.GetParentMenu: TMenu;
var
  MenuItem: TMenuItem;
begin
  MenuItem := Self;
  while Assigned(MenuItem.FParent) do MenuItem := MenuItem.FParent;
  Result := MenuItem.FMenu
end;

procedure TMenuItem.SetRadioItem(Value: Boolean);
begin
  if FRadioItem <> Value then
  begin
    FRadioItem := Value;
    if FChecked and FRadioItem then
      TurnSiblingsOff;
    MenuChanged(True);
  end;
end;

procedure TMenuItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.AutoCheck = False) then
        Self.AutoCheck := AutoCheck;
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if RadioItem and (not CheckDefaults or (Self.GroupIndex = 0)) then
        Self.GroupIndex := GroupIndex;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.ShortCut = scNone) then
        Self.ShortCut := ShortCut;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
      if not CheckDefaults or (@Self.OnClick = nil) then
        Self.OnClick := OnExecute;
    end;
end;

procedure TMenuItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TMenuItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

function TMenuItem.IsCheckedStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCheckedLinked;
end;

function TMenuItem.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TMenuItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TMenuItem.IsHelpContextStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHelpContextLinked;
end;

function TMenuItem.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

function TMenuItem.IsShortCutStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsShortCutLinked;
end;

function TMenuItem.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

function TMenuItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsOnExecuteLinked;
end;

procedure TMenuItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TCustomAction then
    with TCustomAction(Dest) do
    begin
      Enabled := Self.Enabled;
      HelpContext := Self.HelpContext;
      Hint := Self.Hint;
      ImageIndex := Self.ImageIndex;
      Caption := Self.Caption;
      Visible := Self.Visible;
      OnExecute := Self.OnClick;
    end
  else inherited AssignTo(Dest);
end;

procedure TMenuItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = Action then
      Action := nil
    else if AComponent = FSubMenuImages then
      SubMenuImages := nil
    else if AComponent = FMerged then
      MergeWith(nil);
end;

procedure TMenuItem.SetSubMenuImages(Value: TCustomImageList);
begin
  if FSubMenuImages <> nil then FSubMenuImages.UnRegisterChanges(FImageChangeLink);
  FSubMenuImages := Value;
  if FSubMenuImages <> nil then
  begin
    FSubMenuImages.RegisterChanges(FImageChangeLink);
    FSubMenuImages.FreeNotification(Self);
  end;
  UpdateItems;
end;

procedure TMenuItem.ImageListChange(Sender: TObject);
begin
  if Sender = SubMenuImages then UpdateItems;
end;

type
  TMenuUpdater = class
{$IFDEF ITERATOR_OBJECTS}
    function UpdateItem(MenuItem: TMenuItem): Boolean;
{$ENDIF ITERATOR_OBJECTS}
    class procedure DoIterateMenus(Menu1, Menu2: TMenuItem);
  end;

{$IFDEF ITERATOR_OBJECTS}
function TMenuUpdater.UpdateItem(MenuItem: TMenuItem): Boolean;
begin
  Result := False;
  IterateMenus(Self.UpdateItem, MenuItem.FMerged, MenuItem);
  MenuItem.SubItemChanged(MenuItem, MenuItem, True);
end;
{$ELSE !ITERATOR_OBJECTS}
function UpdateItem(MenuItem: TMenuItem): Boolean;
begin
  Result := False;
  IterateMenus(UpdateItem, MenuItem.FMerged, MenuItem);
  MenuItem.SubItemChanged(MenuItem, MenuItem, True);
end;
{$ENDIF !ITERATOR_OBJECTS}

class procedure TMenuUpdater.DoIterateMenus(Menu1, Menu2: TMenuItem);
{$IFDEF ITERATOR_OBJECTS}
var
  MenuUpdater: TMenuUpdater;
begin
  MenuUpdater := TMenuUpdater.Create;
  try
    IterateMenus(MenuUpdater.UpdateItem, Menu1, Menu2);
  finally
    MenuUpdater.Free;
  end;
end;
{$ELSE !ITERATOR_OBJECTS}
begin
  IterateMenus(@UpdateItem, Menu1, Menu2);
end;
{$ENDIF !ITERATOR_OBJECTS}

procedure TMenuItem.UpdateItems;
begin
//  IterateMenus({$IFNDEF CLR}@{$ENDIF}UpdateItem, FMerged, Self);
  TMenuUpdater.DoIterateMenus(FMerged, Self);
end;

procedure TMenuItem.Add(const AItems: array of TMenuItem);
var
  I: Integer;
begin
  for I := Low(AItems) to High(AItems) do
    Add(AItems[I]);
end;

procedure TMenuItem.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Free;
end;

{$IF DEFINED (CLR)}
type
  TUnicodeCategory = System.Globalization.UnicodeCategory;
{$ENDIF}

function TMenuItem.InternalRethinkHotkeys(ForceRethink: Boolean): Boolean;
var
  LDid, LDoing, LToDo, LBest: TStringList;
  I, LIteration, LColumn, LAt, LBestCount: Integer;
  LChar, LCaption, LOrigAvailable, LAvailable, LBestAvailable: string;

  function IfHotkeyAvailable(const AHotkey: string): Boolean;
  var
    At: Integer;
  begin
    At := Pos(AHotkey, LAvailable);
    Result := At <> 0;
    if Result then
{$IF DEFINED(CLR)}
      Borland.Delphi.System.Delete(LAvailable, At, 1);
{$ELSE}
      System.Delete(LAvailable, At, 1);
{$ENDIF}
  end;

  procedure CopyToBest;
  var
    I: Integer;
  begin
    LBest.Assign(LDid);
    LBestCount := LDid.Count;
    for I := 0 to LDoing.Count - 1 do
      LBest.AddObject(TMenuItem(LDoing.Objects[I]).FCaption, LDoing.Objects[I]);
    LBestAvailable := LAvailable;
  end;

  procedure InsertHotkeyFarEastFormat(var ACaption: string; const AHotKey: string; AColumn: Integer);
  var
    LMBCSFlag: Boolean;
    I: Integer;
    LCategory: TUnicodeCategory;
  begin
    LMBCSFlag := False;
    for I := 1 to Length(ACaption) do
    begin
{$IF NOT DEFINED(UNICODE)}
      if IsLeadChar(ACaption[I]) then
{$ELSEIF DEFINED(CLR)}
      LCategory := System.Char.GetUnicodeCategory(ACaption[I]);
      if (LCategory = TUnicodeCategory.OtherLetter) or
         (LCategory = TUnicodeCategory.OtherNumber) then
{$ELSE}
      LCategory := ACaption[I].GetUnicodeCategory;
      if (LCategory = TUnicodeCategory.ucOtherLetter) or
         (LCategory = TUnicodeCategory.ucOtherNumber) then
{$ENDIF}
      begin
        LMBCSFlag := True;
{$IF DEFINED(CLR)}
        Borland.Delphi.System.Break;
{$ELSE}
        System.Break;
{$ENDIF}
      end;
    end;
    if LMBCSFlag then
    begin
      if Copy(ACaption, (Length(ACaption) - Length(cDialogSuffix)) + 1, Length(cDialogSuffix)) = cDialogSuffix then
        ACaption := Copy(ACaption, 1, Length(ACaption) - Length(cDialogSuffix)) +
          '(' + cHotkeyPrefix + AHotKey + ')' + cDialogSuffix
      else
        ACaption := ACaption + '(' + cHotkeyPrefix + AHotKey + ')';
    end
    else
      if AColumn <> 0 then
{$IF DEFINED(CLR)}
        Borland.Delphi.System.Insert(cHotkeyPrefix, ACaption, AColumn);
{$ELSE}
        System.Insert(cHotkeyPrefix, ACaption, AColumn);
{$ENDIF}
  end;

begin
  Result := False;
  if ForceRethink or
     (not (csDesigning in ComponentState) and GetAutoHotkeys) then
  begin
    LAvailable := ValidMenuHotkeys;
{$IF NOT DEFINED(CLR)}
    LDid := nil;
    LDoing := nil;
    LToDo := nil;
    LBest := nil;
{$ENDIF}
    LBestCount := 0;
    try
      LDid := TStringList.Create;
      LDoing := TStringList.Create;
      LToDo := TStringList.Create;
      LBest := TStringList.Create;
      for I := 0 to Count - 1 do
        if Items[I].Visible and
           (Items[I].FCaption <> cLineCaption) and
           (Items[I].FCaption <> '') then
        begin
          LChar := Uppercase(GetHotkey(Items[I].FCaption));
          if LChar = '' then
            LToDo.InsertObject(0, Items[I].FCaption, Items[I])
          else if (AnsiPos(LChar, ValidMenuHotkeys) <> 0) and
                  not IfHotkeyAvailable(LChar) then
          begin
            Items[I].FCaption := StripHotkey(Items[I].FCaption);
            LToDo.InsertObject(0, Items[I].FCaption, Items[I]);
          end;
        end;
      LOrigAvailable := LAvailable;
      for LIteration := 0 to LToDo.Count - 1 do
      begin
        LAvailable := LOrigAvailable;
        LDoing.Assign(LToDo);
        LDid.Clear;
        for I := LDoing.Count - 1 downto 0 do
        begin
          LCaption := LDoing[I];
          LColumn := 1;
          while LColumn <= Length(LCaption) do
          begin
{$IF NOT DEFINED(CLR)}
            if IsLeadChar(LCaption[LColumn]) then
              Inc(LColumn)
            else
{$ENDIF}
            begin
            LChar := Uppercase(Copy(LCaption, LColumn, 1));
            if IfHotkeyAvailable(LChar) then
            begin
              if SysLocale.FarEast then
                InsertHotkeyFarEastFormat(LCaption, LChar, LColumn)
              else
{$IF DEFINED(CLR)}
                Borland.Delphi.System.Insert(cHotkeyPrefix, LCaption, LColumn);
{$ELSE}
                System.Insert(cHotkeyPrefix, LCaption, LColumn);
{$ENDIF}
              LDid.AddObject(LCaption, LDoing.Objects[I]);
              LDoing.Delete(I);
{$IF DEFINED(CLR)}
              Borland.Delphi.System.Break;
{$ELSE}
              System.Break;
{$ENDIF}
            end;
            end;
            Inc(LColumn);
          end;
        end;
        if LDid.Count > LBestCount then
          CopyToBest;
        if LDoing.Count > 0 then
          for I := 0 to LDoing.Count - 1 do
          begin
            LAt := LToDo.IndexOfObject(LDoing.Objects[I]);
            LToDo.Move(LAt, LToDo.Count - 1);
          end
        else
{$IF DEFINED(CLR)}
          Borland.Delphi.System.Break;
{$ELSE}
          System.Break;
{$ENDIF}
      end;
      if LBestCount = 0 then
        CopyToBest;
      Result := LBest.Count > 0;
      for I := 0 to LBest.Count - 1 do
      begin
        LCaption := LBest[I];
        if SysLocale.FarEast and (AnsiPos(cHotkeyPrefix, LCaption) = 0)
          and (LBestAvailable <> '') then
        begin
          if AnsiPos(cHotkeyPrefix, LCaption) = 0 then
          begin
            InsertHotkeyFarEastFormat(LCaption, Copy(LBestAvailable, Length(LBestAvailable), 1), 0);
{$IF DEFINED(CLR)}
            Borland.Delphi.System.Delete(LBestAvailable, length(LBestAvailable), 1);
{$ELSE}
            System.Delete(LBestAvailable, length(LBestAvailable), 1);
{$ENDIF}
          end;
        end;
        TMenuItem(LBest.Objects[I]).FCaption := LCaption;
      end;
    finally
{$IF NOT DEFINED(CLR)}
      LBest.Free;
      LToDo.Free;
      LDoing.Free;
      LDid.Free;
{$ENDIF}
    end;
  end;
end;

function TMenuItem.RethinkHotkeys: Boolean;
begin
  Result := InternalRethinkHotkeys(True);
  if Result then
    MenuChanged(True);
end;

procedure TMenuItem.SetAutoHotkeys(const Value: TMenuItemAutoFlag);
begin
  if Value <> FAutoHotkeys then
  begin
    FAutoHotkeys := Value;
    MenuChanged(True);
  end;
end;

function TMenuItem.IsLine: Boolean;
begin
  Result := FCaption = cLineCaption;
end;

function TMenuItem.Find(ACaption: string): TMenuItem;
var
  I: Integer;
begin
  Result := nil;
  ACaption := StripHotkey(ACaption);
  for I := 0 to Count - 1 do
    if AnsiSameText(ACaption, StripHotkey(Items[I].Caption)) then
    begin
      Result := Items[I];
{$IF DEFINED(CLR)}
      Borland.Delphi.System.Break;
{$ELSE}
      System.Break;
{$ENDIF}
    end;
end;

function TMenuItem.InsertNewLine(ABefore: Boolean; AItem: TMenuItem): Integer;
begin
  if AItem.Parent <> Self then
     Error({$IFNDEF CLR}@{$ENDIF}SMenuNotFound);
  if ABefore then
  begin
    if (AItem.MenuIndex > 0) and
       Items[AItem.MenuIndex - 1].IsLine then
    begin
      Result := AItem.MenuIndex - 1;
      Items[AItem.MenuIndex - 1].Visible := True;
    end
    else
    begin
      Result := AItem.MenuIndex;
      Insert(AItem.MenuIndex, NewLine);
    end;
  end
  else
  begin
    if (AItem.MenuIndex < Count - 1) and
       Items[AItem.MenuIndex + 1].IsLine then
    begin
      Result := AItem.MenuIndex + 2;
      Items[AItem.MenuIndex + 1].Visible := True;
    end
    else
    begin
      Result := AItem.MenuIndex + 2;
      Insert(AItem.MenuIndex + 1, NewLine);
    end;
  end;
end;

function TMenuItem.InsertNewLineAfter(AItem: TMenuItem): Integer;
begin
  Result := InsertNewLine(False, AItem);
end;

function TMenuItem.InsertNewLineBefore(AItem: TMenuItem): Integer;
begin
  Result := InsertNewLine(True, AItem);
end;

function TMenuItem.NewBottomLine: Integer;
begin
  Result := 0;
  if Count = 0 then
    Add(NewLine)
  else
    Result := InsertNewLine(False, Items[Count - 1]);
end;

function TMenuItem.NewTopLine: Integer;
begin
  Result := 0;
  if Count = 0 then
    Add(NewLine)
  else
    Result := InsertNewLine(True, Items[0]);
end;

function TMenuItem.InternalRethinkLines(ForceRethink: Boolean): Boolean;
var
  I, LLastAt: Integer;
  LLastBar: TMenuItem;
begin
  Result := False;
  if ForceRethink or
     (not (csDesigning in ComponentState) and GetAutoLineReduction) then
  begin
    LLastAt := 0;
    LLastBar := nil;
    for I := LLastAt to Count - 1 do
      if Items[I].FVisible then
        if Items[I].IsLine then
        begin
          Items[I].FVisible := False;
          Result := True;
        end
        else
        begin
          LLastAt := I;
{$IF DEFINED(CLR)}
          Borland.Delphi.System.Break;
{$ELSE}
          System.Break;
{$ENDIF}
        end;
    for I := LLastAt to Count - 1 do
      if Items[I].IsLine then
      begin
        if (LLastBar <> nil) and (LLastBar.FVisible) then
        begin
          LLastBar.FVisible := False;
          Result := True;
        end;
        LLastBar := Items[I];
      end
      else if Items[I].FVisible then
      begin
        if (LLastBar <> nil) and (not LLastBar.FVisible) then
        begin
          LLastBar.FVisible := True;
          Result := True;
        end;
        LLastBar := nil;
        LLastAt := I;
      end;
    for I := Count - 1 downto LLastAt do
      if Items[I].FVisible then
        if Items[I].IsLine then
        begin
          Items[I].FVisible := False;
          Result := True;
        end
        else
{$IF DEFINED(CLR)}
          Borland.Delphi.System.Break;
{$ELSE}
          System.Break;
{$ENDIF}
  end;
end;

procedure TMenuItem.SetAutoLineReduction(const Value: TMenuItemAutoFlag);
begin
  if Value <> FAutoLineReduction then
  begin
    FAutoLineReduction := Value;
    MenuChanged(True);
  end;
end;

function TMenuItem.RethinkLines: Boolean;
begin
  Result := InternalRethinkLines(True);
  if Result then
    MenuChanged(True);
end;

function TMenuItem.GetAutoHotkeys: Boolean;
var
  LAuto: TMenuItemAutoFlag;
begin
  LAuto := FAutoHotkeys;
  if (LAuto = maParent) and
     (Parent <> nil) then
    LAuto := cBooleanToItemAutoFlag[Parent.GetAutoHotkeys];
  Result := cItemAutoFlagToBoolean[LAuto];
end;

function TMenuItem.GetAutoLineReduction: Boolean;
var
  LAuto: TMenuItemAutoFlag;
begin
  LAuto := FAutoLineReduction;
  if (LAuto = maParent) and
     (Parent <> nil) then
    LAuto := cBooleanToItemAutoFlag[Parent.GetAutoLineReduction];
  Result := cItemAutoFlagToBoolean[LAuto];
end;

{ TMenu }

constructor TMenu.Create(AOwner: TComponent);
begin
                          
{$IF DEFINED(CLR)}
  inherited Create(AOwner);
  FItems := TMenuItem.Create(Self);
  FItems.FOnChange := MenuChanged;
  FItems.FMenu := Self;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FParentBiDiMode := True;
{$ELSE}
  FItems := TMenuItem.Create(Self);
  FItems.FOnChange := MenuChanged;
  FItems.FMenu := Self;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FParentBiDiMode := True;
  inherited Create(AOwner);
{$ENDIF}
  FItems.FAutoHotkeys := maAutomatic;
  FItems.FAutoLineReduction := maAutomatic;
  ParentBiDiModeChanged;
end;

function TMenu.CreateMenuItem: TMenuItem;
begin
  Result := TMenuItem.Create(Self);
end;

destructor TMenu.Destroy;
begin
  FItems.Free;
  FImageChangeLink.Free;
  inherited Destroy;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TMenu.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  FItems.GetChildren(Proc, Root);
end;

function TMenu.GetHandle: HMENU;
begin
{$IF DEFINED(CLR)}
  if FItems = nil then   // this can happen within the constructor
    Result := 0
  else
{$ENDIF}
    Result := FItems.GetHandle;
end;

procedure TMenu.SetChildOrder(Child: TComponent; Order: Integer);
begin
  FItems.SetChildOrder(Child, Order);
end;

procedure TMenu.UpdateItems;
begin
//  IterateMenus({$IFNDEF CLR}@{$ENDIF}UpdateItem, Items.FMerged, Items);
  TMenuUpdater.DoIterateMenus(Items.FMerged, Items);
end;

{$IFDEF ITERATOR_OBJECTS}
type
  TMenuFinder = class
    Value: NativeUInt;
    Kind: TFindItemKind;
    FoundItem: TMenuItem;
    function Find(Item: TMenuItem): Boolean;
  end;

function HandleEquals(Handle: TMenuHandle; Value: NativeUInt): Boolean;
begin
{$IFDEF CLR}
  Result := Assigned(Handle) and  (Handle.Value = THandle(Value));
{$ELSE}
  Result := Handle = THandle(Value);
{$ENDIF}
end;

function TMenuFinder.Find(Item: TMenuItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ((Kind = fkCommand) and (Value = Item.Command)) or
    ((Kind = fkHandle) and HandleEquals(Item.FHandle, Value)) or
    ((Kind = fkShortCut) and (Value = Item.ShortCut)) then
  begin
    FoundItem := Item;
    Result := True;
    Exit;
  end
  else
    for I := 0 to Item.GetCount - 1 do
      if Find(Item[I]) then
      begin
        Result := True;
        Exit;
      end;
end;

function TMenu.FindItem(Value: NativeUInt; Kind: TFindItemKind): TMenuItem;
var
  Finder: TMenuFinder;
begin
  Finder := TMenuFinder.Create;
  try
    Finder.Value := Value;
    Finder.Kind := Kind;
    IterateMenus(Finder.Find, Items.FMerged, Items);
    Result := Finder.FoundItem;
  finally
    Finder.Free;
  end;
end;
{$ELSE !ITERATOR_OBJECTS}
function TMenu.FindItem(Value: NativeUInt; Kind: TFindItemKind): TMenuItem;
var
  FoundItem: TMenuItem;

  function Find(Item: TMenuItem): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if ((Kind = fkCommand) and (Value = Item.Command)) or
      ((Kind = fkHandle) and (Value = UIntPtr(Item.FHandle))) or
      ((Kind = fkShortCut) and (Value = Item.ShortCut)) then
    begin
      FoundItem := Item;
      Result := True;
      Exit;
    end
    else
      for I := 0 to Item.GetCount - 1 do
        if Find(Item[I]) then
        begin
          Result := True;
          Exit;
        end;
  end;

begin
  FoundItem := nil;
  IterateMenus(@Find, Items.FMerged, Items);
  Result := FoundItem;
end;
{$ENDIF !ITERATOR_OBJECTS}

function TMenu.GetHelpContext(Value: NativeUInt; ByCommand: Boolean): THelpContext;
var
  Item: TMenuItem;
  Kind: TFindItemKind;
begin
  Result := 0;
  Kind := fkHandle;
  if ByCommand then Kind := fkCommand;
  if (Kind = fkHandle) and (Self is TPopupMenu) and
    (UIntPtr(TPopupMenu(Self).Handle) = Value) then
    Result := TPopupMenu(Self).HelpContext
  else
  begin
    Item := FindItem(Value, Kind);
    while (Item <> nil) and (Item.FHelpContext = 0) do
      Item := Item.FParent;
    if Item <> nil then Result := Item.FHelpContext;
  end;
end;

function TMenu.DispatchCommand(ACommand: Word): Boolean;
var
  Item: TMenuItem;
begin
  Result := False;
  Item := FindItem(ACommand, fkCommand);
  if Item <> nil then
  begin
    Item.Click;
    Result := True;
  end;
end;

function TMenu.DispatchPopup(AHandle: HMENU): Boolean;
var
  Item: TMenuItem;
  LRebuild: Boolean;
begin
  Result := False;
  Item := FindItem(AHandle, fkHandle);
  if Item <> nil then
  begin
    if not (csDesigning in Item.ComponentState) then
      Item.InitiateActions;
    Item.Click;
    LRebuild := Item.InternalRethinkHotkeys(False);
    LRebuild := Item.InternalRethinkLines(False) or LRebuild;
    if LRebuild then
      Item.RebuildHandle;
    if Assigned(Application.MainForm) then
      with Application.MainForm do
        if (FormStyle = fsMDIForm) and
           (WindowMenu = Item) and
           (SendMessage(ClientHandle, WM_MDIREFRESHMENU, 0, 0) <> 0) then
          DrawMenuBar(Handle);
    Result := True;
  end
  else if not (csDesigning in ComponentState) and (Self is TPopupMenu) then
    Items.InitiateActions;
end;

function TMenu.IsOwnerDraw: Boolean;
begin
  Result := OwnerDraw or (Images <> nil);
end;

{$IF NOT DEFINED(CLR)}
var
  CurrentKeyboardLayout: HKL = 0;
  IsAltGRKeyLayout: Boolean = False;

function IsAltGRPressed: Boolean;

  function IsWOW64: BOOL;
  begin
    Result := False;
    if GetProcAddress(GetModuleHandle(kernel32), 'IsWow64Process') <> nil then
      IsWow64Process(GetCurrentProcess, Result);
  end;

  procedure GetAltGRStatus;
  type
    PKBDTABLES = ^TKBDTABLES;
    TKBDTABLES = record
      pCharModifiers: pointer;
      pVkToWcharTable: pointer;
      pDeadKey: pointer;
      pKeyNames: Pointer;
      pKeyNamesExt: Pointer;
      pKeyNamesDead: PWideChar;
      pusVSCtoVK: Pointer;
      bMaxVSCtoVK: BYTE;
      pVSCtoVK_E0: Pointer;
      pVSCtoVK_E1: Pointer;
      fLocaleFlags: DWORD;
      nLgMax: Byte;
      cbLgEntry: Byte;
      pLigature: Pointer;
    end;
    PKBDTABLESWOW64 = ^TKBDTABLESWOW64;
    TKBDTABLESWOW64 = record
      pCharModifiers: UInt64;
      pVkToWcharTable: UInt64;
      pDeadKey: UInt64;
      pKeyNames: UInt64;
      pKeyNamesExt: UInt64;
      pKeyNamesDead: UInt64;
      pusVSCtoVK: UInt64;
      bMaxVSCtoVK: BYTE;
      pVSCtoVK_E0: UInt64;
      pVSCtoVK_E1: UInt64;
      fLocaleFlags: DWORD;
      nLgMax: Byte;
      cbLgEntry: Byte;
      pLigature: UInt64;
    end;
    TFNKbdLayerDescriptor = function: Pointer;
  const
    KLLF_ALTGR = $0001;
    LayoutsListRegKey = '\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\';
  var
    DLLName: string;
    DLLHandle: HModule;
    R: TRegistry;
    LayoutName: array[0..KL_NAMELENGTH] of char;
    LocaleFlags: DWORD;
    KbdTablePtr: Pointer;
    KbdLayerDescriptor: TFNKbdLayerDescriptor;
  begin
    IsAltGRKeyLayout := False;
    LayoutName[0] := #0;
    GetKeyboardLayoutName(LayoutName);
    R := TRegistry.Create;
    try
      R.RootKey := HKEY_LOCAL_MACHINE;
      if R.OpenKeyReadOnly(LayoutsListRegKey + LayoutName) then
      begin
        DLLName := R.ReadString('Layout File');
        DLLHandle := SafeLoadLibrary(DLLName);
        if DLLHandle <> 0 then
          try
            KbdLayerDescriptor := GetProcAddress(DLLHandle, 'KbdLayerDescriptor');
            if Assigned(KbdLayerDescriptor) then
            begin
              KbdTablePtr := KbdLayerDescriptor;
              if KbdTablePtr <> nil then
              begin
                if IsWOW64 then
                  LocaleFlags := PKBDTABLESWOW64(KbdTablePtr).fLocaleFlags
                else
                  LocaleFlags := PKBDTABLES(KbdTablePtr).fLocaleFlags;
                IsAltGRKeyLayout := (LocaleFlags and KLLF_ALTGR) = KLLF_ALTGR;
              end;
            end;
          finally
            FreeLibrary(DLLHandle);
          end;
      end;
    finally
      R.Free;
    end;
  end;

var
  KeyboardLayout: HKL;
begin
  Result := False;
  if GetKeyState(VK_RMENU) < 0 then
  begin
    KeyboardLayout := GetKeyboardLayout(0);
    if KeyboardLayout <> CurrentKeyboardLayout then
    begin
      GetAltGRStatus;
      CurrentKeyboardLayout := KeyboardLayout;
    end;
    Result := IsAltGRKeyLayout;
  end;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
type
  TMenuItemHolder = class
    Value: TMenuItem;
    constructor Create(AValue: TMenuItem);
  end;

constructor TMenuItemHolder.Create(AValue: TMenuItem);
begin
  inherited Create;
  Value := AValue;
end;
{$ENDIF}

function ShortCutFromMessage(Message: TWMKey): TShortCut;
const
  AltMask = $20000000;
{$IFDEF LINUX}
  CtrlMask = $10000000;
  ShiftMask = $08000000;
{$ENDIF}
begin
  Result := Byte(Message.CharCode);
  if Result = 0 then
    Exit;
  if GetKeyState(VK_SHIFT) < 0 then Inc(Result, scShift);
  if GetKeyState(VK_CONTROL) < 0 then Inc(Result, scCtrl);
  if Message.KeyData and AltMask <> 0 then Inc(Result, scAlt);
{$IFDEF LINUX}
  if Message.KeyData and CtrlMask <> 0 then Inc(Result, scCtrl);
  if Message.KeyData and ShiftMask <> 0 then Inc(Result, scShift);
{$ENDIF}
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TMenu.IsShortCut(var Message: TWMKey): Boolean;
type
  TClickResult = (crDisabled, crClicked, crShortCutMoved, crShortCutFreed);
var
  ShortCut: TShortCut;
  ClickResult: TClickResult;
{$IF DEFINED(CLR)}
  MyItems: TMenuItemHolder;
  ShortCutItem: TMenuItemHolder;
{$ELSE}
  MyItems: TMenuItem;
  ShortCutItem: TMenuItem;
{$ENDIF}

  function NthParentOf(Item: TMenuItem; N: Integer): TMenuItem;
  begin
    Result := Item;
    while (N > 0) and (Result <> nil) do
    begin
      Result := Result.Parent;
      Dec(N);
    end;
  end;

  function DoClick(var Item: TMenuItem; Level: Integer): TClickResult;
  var
    ItemParent: TMenuItem;
  begin
    Result := crClicked;
    ItemParent := Item.Parent;
    if ItemParent <> nil then
      Result := DoClick(ItemParent, Level + 1);
    if Result in [crDisabled, crShortCutFreed] then
      Exit;
    if Result = crShortCutMoved then
    begin
      // Shortcut moved, we need to refind the shortcut and restore Item
      // to point to the parent at the right level, if possible
{$IF DEFINED(CLR)}
      if (ShortCutItem.Value = nil) or (ShortCutItem.Value.ShortCut <> ShortCut) then
      begin
        ShortCutItem.Value := FindItem(ShortCut, fkShortCut);
        if ShortCutItem.Value = nil then
        begin
          Result := crShortCutFreed;
          Exit; // Shortcut item could not be found
        end;
      end;
      Item := NthParentOf(ShortCutItem.Value, Level);
{$ELSE}
      if (ShortCutItem = nil) or (ShortCutItem.ShortCut <> ShortCut) then
      begin
        ShortCutItem := FindItem(ShortCut, fkShortCut);
        if ShortCutItem = nil then
        begin
          Result := crShortCutFreed;
          Exit; // Shortcut item could not be found
        end;
      end;
      Item := NthParentOf(ShortCutItem, Level);
{$ENDIF}
      if (Item = nil) or (Item.Parent <> ItemParent) then
        Exit; // Shortcut moved in structure, level not correct
      if Level = 0 then Result := crClicked;
    end;
    if Item.Enabled then
      try
        if not (csDesigning in ComponentState) then Item.InitiateActions;
        Item.Click;
{$IF DEFINED(CLR)}
        if (ShortCutItem.Value = nil) or
          ((Item <> ShortCutItem.Value) and (ShortCutItem.Value.ShortCut <> ShortCut)) then
{$ELSE}
        if (ShortCutItem = nil) or
          ((Item <> ShortCutItem) and (ShortCutItem.ShortCut <> ShortCut)) then
{$ENDIF}
          Result := crShortCutMoved;
      except
        Application.HandleException(Self);
      end
    else Result := crDisabled;
  end;

begin
{$IF DEFINED(CLR)}
  ShortCut := ShortCutFromMessage(Message);
  MyItems := TMenuItemHolder.Create(FItems);
  ShortCutItem := TMenuItemHolder.Create(nil);
  ShortCutItems.Push(MyItems);
  try
    repeat
      ClickResult := crDisabled;
      ShortCutItem.Value := FindItem(ShortCut, fkShortCut);
      if ShortCutItem.Value <> nil then
      begin
        ShortCutItems.Push(ShortCutItem);
        try
          ClickResult := DoClick(ShortCutItem.Value, 0);
        finally
          ShortCutItems.Pop;
        end;
      end;
    until (MyItems.Value = nil) or (ClickResult <> crShortCutMoved);
  finally
    ShortCutItems.Pop;
  end;
  Result := (ShortCutItem.Value <> nil) or (MyItems.Value = nil);
{$ELSE}
  Result := False;
  if IsAltGRPressed then exit;
  ShortCut := ShortCutFromMessage(Message);
  MyItems := FItems;
  ShortCutItems.Push(@MyItems);
  try
    repeat
      ClickResult := crDisabled;
      ShortCutItem := FindItem(ShortCut, fkShortCut);
      if ShortCutItem <> nil then
      begin
        ShortCutItems.Push(@ShortCutItem);
        try
          ClickResult := DoClick(ShortCutItem, 0);
        finally
          ShortCutItems.Pop;
        end;
      end;
    until (MyItems = nil) or (ClickResult <> crShortCutMoved);
  finally
    ShortCutItems.Pop;
  end;
  Result := (ShortCutItem <> nil) or (MyItems = nil);
{$ENDIF}
end;

function TMenu.IsBiDiModeStored: Boolean;
begin
  Result := not FParentBiDiMode;
end;

procedure TMenu.DoBiDiModeChanged;
const
  BufSize = 80;
var
  Menu: HMENU;
  MenuItemInfo: TMenuItemInfo;
{$IF NOT DEFINED(CLR)}
  Buffer: array[0..BufSize - 1] of Char;
{$ENDIF}
begin
  if (not SysLocale.MiddleEast) or (WindowHandle = 0) then Exit;
  Menu := GetHandle;
  MenuItemInfo.fMask := MIIM_TYPE;
  MenuItemInfo.cch := BufSize;
{$IF DEFINED(CLR)}
  MenuItemInfo.cbSize := Marshal.SizeOf(TypeOf(TMenuItemInfo)); // Required for XP64
  MenuItemInfo.dwTypeData := Marshal.AllocHGlobal(BufSize);
{$ELSE}
  if (Win32Platform <> VER_PLATFORM_WIN32_WINDOWS) or (Win32MajorVersion > 4) then
    MenuItemInfo.cbSize := SizeOf(TMenuItemInfo)
  else
    MenuItemInfo.cbSize := 44; // Required for Windows 95
  MenuItemInfo.dwTypeData := Buffer;
{$ENDIF}
  try
    if GetMenuItemInfo(Menu, 0, True, MenuItemInfo) then
    begin
      if LongBool(MenuItemInfo.fType and RightToLeftMenuFlag) = IsRightToLeft then
        Exit;  // Nothing to do
      // clear and set the flag
      MenuItemInfo.fType := (MenuItemInfo.fType and (not RightToLeftMenuFlag))
        or (RightToLeftMenuFlag * DWORD(IsRightToLeft));
      MenuItemInfo.fMask := MIIM_TYPE;
      if SetMenuItemInfo(Menu, 0, True, MenuItemInfo) then
        DrawMenuBar(WindowHandle);
    end;
  finally
{$IF DEFINED(CLR)}
    Marshal.FreeHGlobal(MenuItemInfo.dwTypeData);
{$ENDIF}
  end;
end;

{$IF DEFINED(CLR)}
function ImageEqual(const OldImage, NewImage: array of Byte): Boolean;
var
  I: Integer;
begin
  Result := False;
  if High(OldImage) <> High(NewImage) then Exit;
  for I := 0 to High(OldImage) do
    if OldImage[I] <> NewImage[I] then Exit;
  Result := True;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TMenu.BuildMenuImage(Menu: HMENU): TBytes;
var
  P, I, C, L: Integer;
  State: Word;
  S: string;
  B: TBytes;
  BL: Integer;
begin
  L := 512;
  SetLength(Result, L);
  P := 0;
  C := GetMenuItemCount(Menu);
  I := 0;
  while I < C do
  begin
    S := DoGetMenuString(Menu, I, MF_BYPOSITION);
    B := BytesOf(S);
    BL := Length(B);
    if P + BL + 4 > L then
    begin
      L := L + L;
      SetLength(Result, L);
    end;
    System.Array.Copy(B, 0, Result, P, Length(B));
    Inc(P, Length(B));
    State := GetMenuState(Menu, I, MF_BYPOSITION);
    if State and MF_DISABLED <> 0 then
    begin
      Result[P] := Byte('$');
      Inc(P);
    end;
    if State and MF_MENUBREAK <> 0 then
    begin
      Result[P] := Byte('@');
      Inc(P);
    end;
    if State and MF_GRAYED <> 0 then
    begin
      Result[P] := Byte('#');
      Inc(P);
    end;
    Result[P] := Byte(';');
    Inc(P);
    Inc(I);
  end;
  SetLength(Result, 0);
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TMenu.UpdateImage: Boolean;
var
  Image: TBytes;
begin
  Result := False;
  SetLength(Image, 0);
  if FWindowHandle <> 0 then
    Image := BuildMenuImage(Handle);
  if not ImageEqual(FMenuImage, Image) then
  begin
    Result := True;
    FMenuImage := Image;
  end;
end;
{$ELSE}
function TMenu.UpdateImage: Boolean;
var
  Image: array[0..511] of Char;

  procedure BuildImage(Menu: HMENU);
  var
    P, ImageEnd: PChar;
    I, C: Integer;
    State: Word;
  begin
    C := GetMenuItemCount(Menu);
    P := Image;
    ImageEnd := @Image[Length(Image) - 5];
    I := 0;
    while (I < C) and (P < ImageEnd) do
    begin
      DoGetMenuString(Menu, I, P, ImageEnd - P, MF_BYPOSITION);
      P := StrEnd(P);
      State := GetMenuState(Menu, I, MF_BYPOSITION);
      if State and MF_DISABLED <> 0 then
      begin
        P^ := '$';
        Inc(P);
        P^ := #0;
      end;
      if State and MF_MENUBREAK <> 0 then
      begin
        P^ := '@';
        Inc(P);
        P^ := #0;
      end;
      if State and MF_GRAYED <> 0 then
      begin
        P^ := '#';
        Inc(P);
        P^ := #0;
      end;
      P^ := ';';
      Inc(P);
      P^ := #0;
      Inc(I);
    end;
  end;

begin
  Result := False;
  Image[0] := #0;
  if FWindowHandle <> 0 then BuildImage(Handle);
  if (FMenuImage = '') or (StrComp(PChar(FMenuImage), Image) <> 0) then
  begin
    Result := True;
    FMenuImage := Image;
  end;
end;
{$ENDIF}

procedure TMenu.SetOwnerDraw(Value: Boolean);
begin
  if Value <> FOwnerDraw then
  begin
    FOwnerDraw := Value;
    UpdateItems;
  end;
end;

procedure TMenu.AdjustBiDiBehavior;
var
  SaveBiDi: TBiDiMode;
  SaveParentBiDi: Boolean;
begin
  if not SysLocale.MiddleEast then Exit;
  SaveBiDi := FBiDiMode;
  SaveParentBiDi := FParentBidiMode;
  try
    if BiDiMode = bdLeftToRight then
      BiDiMode := bdRightToLeft { Do not use FBiDiMode }
    else
      BiDiMode := bdLeftToRight; { Do not use FBiDiMode }
  finally
    BiDiMode := SaveBiDi; { Do not use FBiDiMode }
    FParentBidiMode := SaveParentBiDi;
  end;
end;

procedure TMenu.SetWindowHandle(Value: HWND);
begin
  FWindowHandle := Value;
  UpdateImage;
  { When menus are created, if BiDiMode does not follow the parent,
    main menu headers are displayed in reversed order. Changing BiDiMode
    twice fixes this. }
  if (SysLocale.MiddleEast) and (Value <> 0) then
    if FParentBiDiMode then
      ParentBiDiModeChanged
    else
      AdjustBiDiBehavior;
end;

procedure TMenu.DoChange(Source: TMenuItem; Rebuild: Boolean);
begin
  if Assigned(FOnChange) then FOnChange(Self, Source, Rebuild);
end;

procedure TMenu.Loaded;
begin
  inherited Loaded;
  DoChange(nil, False);
end;

procedure TMenu.MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
begin
  if ComponentState * [csLoading, csDestroying] = [] then DoChange(Source, Rebuild);
end;

procedure TMenu.ImageListChange(Sender: TObject);
begin
  if Sender = Images then UpdateItems;
end;

procedure TMenu.SetImages(Value: TCustomImageList);
begin
  if FImages <> nil then FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  UpdateItems;
end;

procedure TMenu.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then Images := nil;
end;

function TMenu.IsRightToLeft: Boolean;
begin
  Result := SysLocale.MiddleEast and (BiDiMode <> bdLeftToRight);
end;

{$IF DEFINED(CLR)}
procedure TMenu.ProcessMenuChar(Message: TWMMenuChar);
{$ELSE}
procedure TMenu.ProcessMenuChar(var Message: TWMMenuChar);
{$ENDIF}
var
  C, I, First, Hilite, Next: Integer;
  State: Word;

  function IsAccelChar(Menu: HMENU; State: Word; I: Integer; C: Char): Boolean;
  var
    Item: TMenuItem;
    Id: UINT;
  begin
    Item := nil;
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, I);
      Item := FindItem(Menu, fkHandle);
    end
    else
    begin
      Id := GetMenuItemID(Menu, I);
      if Id <> $FFFFFFFF then
        Item := FindItem(Id, fkCommand);
    end;
    if Item <> nil then
      Result := IsAccel(Ord(C), Item.Caption) else
      Result := False;
  end;

  function IsInitialChar(Menu: HMENU; State: Word; I: Integer; C: Char): Boolean;
  var
    Item: TMenuItem;
  begin
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, I);
      Item := FindItem(Menu, fkHandle);
    end
    else
    begin
      Item := FindItem(Menu, fkHandle);
      if (Item <> nil) and (I < Item.Count) then
        Item := Item.Items[I];
    end;
    // First char is a valid accelerator only if the caption does not
    // contain an explicit accelerator
    if (Item <> nil) and (Item.Caption <> '') then
      Result := (AnsiCompareText(Item.Caption[1], C) = 0) and
        (GetHotkey(Item.Caption) = '')
    else
      Result := False;
  end;

begin
  with Message do
  begin
    Result := MNC_IGNORE; { No item found: beep }
    First := -1;
    Hilite := -1;
    Next := -1;
    C := GetMenuItemCount(Menu);
    for I := 0 to C - 1 do
    begin
      State := GetMenuState(Menu, I, MF_BYPOSITION);
      if IsAccelChar(Menu, State, I, Char(User)) then
      begin
        if State and MF_DISABLED <> 0 then
        begin
          { Close the menu if this is the only disabled item to choose from.
            Otherwise, ignore the item. }
          if First < 0 then First := -2;
          Continue;
        end;
        if First < 0 then
        begin
          First := I;
          Result := MNC_EXECUTE;
        end
        else
          Result := MNC_SELECT;
        if State and MF_HILITE <> 0 then
          Hilite := I
        else if Hilite >= 0 then
          Next := I;
      end;
    end;
    { We found a single disabled item. End the selection. }
    if First < -1 then
    begin
      Result := MNC_CLOSE shl 16;
      Exit;
    end;

    { If we can't find accelerators, then look for initial letters }
    if First < 0 then
    for I := 0 to C - 1 do
      begin
        State := GetMenuState(Menu, I, MF_BYPOSITION);
        if IsInitialChar(Menu, State, I, Char(User)) then
        begin
          if State and MF_DISABLED <> 0 then
          begin
            Result := MNC_CLOSE shl 16;
            Exit;
          end;
          if First < 0 then
          begin
            First := I;
            Result := MNC_EXECUTE;
          end
          else
            Result := MNC_SELECT;
          if State and MF_HILITE <> 0 then
            Hilite := I
          else if Hilite >= 0 then
            Next := I;
        end;
      end;

    if (Result = MNC_EXECUTE) then
      Result := Result shl 16 or First
    else if Result = MNC_SELECT then
    begin
      if Next < 0 then
        Next := First;
      Result := Result shl 16 or Next;
    end;
  end;
end;

{ Returns the proper caption for a menu item when the menu is owner-drawn. }
{$IF DEFINED(CLR)}
function TMenu.DoGetMenuString(Menu: HMENU; ItemID: UINT; Flag: UINT): string;
{$ELSE}
function TMenu.DoGetMenuString(Menu: HMENU; ItemID: UINT; Str: PChar;
  MaxCount: Integer; Flag: UINT): Integer;
{$ENDIF}
var
  Item: TMenuItem;
  State: Word;
{$IF DEFINED(CLR)}
  StrValue: StringBuilder;
{$ENDIF}
begin
  if IsOwnerDraw then
  begin
    Item := nil;
    State := GetMenuState(Menu, ItemID, Flag);
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, ItemID);
      Item := FindItem(Menu, fkHandle);
    end
    else
    begin
      ItemID := GetMenuItemID(Menu, ItemID);
      if ItemID <> $FFFFFFFF then
        Item := FindItem(ItemID, fkCommand);
    end;
{$IF DEFINED(CLR)}
    if Item <> nil then
      Result := Item.Caption
    else
      Result := '';
  end
  else
  begin
    StrValue := StringBuilder.Create(1024);
    GetMenuString(Menu, ItemID, StrValue, StrValue.Capacity, Flag);
    Result := StrValue.ToString;
  end;
{$ELSE}
    if Item <> nil then
    begin
      Str[0] := #0;
      StrPLCopy(Str, Item.Caption, MaxCount);
      Result := StrLen(Str);
    end
    else
      Result := 0;
  end
  else
    Result := GetMenuString(Menu, ItemID, Str, MaxCount, Flag);
{$ENDIF}
end;

procedure TMenu.SetBiDiMode(Value: TBiDiMode);
begin
  if FBiDiMode <> Value then
  begin
    FBiDiMode := Value;
    FParentBiDiMode := False;
    DoBiDiModeChanged;
  end;
end;

procedure TMenu.SetParentBiDiMode(Value: Boolean);
begin
  if Value <> FParentBiDiMode then
  begin
    FParentBiDiMode := Value;
    ParentBiDiModeChanged;
  end;
end;

procedure TMenu.ParentBiDiModeChanged;
var
  AForm: TWinControl;
begin
  if FParentBiDiMode then
  begin
    AForm := FindControl(WindowHandle);
    if AForm <> nil then
    begin
      BiDiMode := AForm.BiDiMode;
      FParentBiDiMode := True;
    end;
  end;
end;

procedure TMenu.ParentBiDiModeChanged(AControl: TObject);
begin
  if FParentBiDiMode then
  begin
    BiDiMode := (AControl as TControl).BiDiMode;
    FParentBiDiMode := True;
  end;
end;

function TMenu.GetAutoHotkeys: TMenuAutoFlag;
begin
  Result := cItemAutoFlagToMenu[Items.FAutoHotkeys];
end;

procedure TMenu.SetAutoHotkeys(const Value: TMenuAutoFlag);
begin
  Items.FAutoHotkeys := cMenuAutoFlagToItem[Value];
end;

function TMenu.GetAutoLineReduction: TMenuAutoFlag;
begin
  Result := cItemAutoFlagToMenu[Items.FAutoLineReduction];
end;

procedure TMenu.SetAutoLineReduction(const Value: TMenuAutoFlag);
begin
  Items.FAutoLineReduction := cMenuAutoFlagToItem[Value];
end;

{ TMainMenu }

procedure TMainMenu.SetAutoMerge(Value: Boolean);
begin
  if FAutoMerge <> Value then
  begin
    FAutoMerge := Value;
    if FWindowHandle <> 0 then
      SendMessage(FWindowHandle, CM_MENUCHANGED, 0, 0);
  end;
end;

procedure TMainMenu.MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
var
  NeedUpdate: Boolean;
begin
  if (FWindowHandle <> 0) then
  begin
    NeedUpdate := UpdateImage;  // check for changes before CM_MENUCHANGED does 
    if Source = nil then
      SendMessage(FWindowHandle, CM_MENUCHANGED, 0, 0);
    if NeedUpdate then
      DrawMenuBar(FWindowHandle);
  end;
  inherited MenuChanged(Sender, Source, Rebuild);
end;

procedure TMainMenu.Merge(Menu: TMainMenu);
begin
  if Menu <> nil then
    FItems.MergeWith(Menu.FItems) else
    FItems.MergeWith(nil);
end;

procedure TMainMenu.Unmerge(Menu: TMainMenu);
begin
  if (Menu <> nil) and (FItems.FMerged = Menu.FItems) then
    FItems.MergeWith(nil);
end;

procedure TMainMenu.ItemChanged;
begin
  MenuChanged(nil, nil, False);
  if FWindowHandle <> 0 then
    SendMessage(FWindowHandle, CM_MENUCHANGED, 0, 0);
end;

function TMainMenu.GetHandle: HMENU;
begin
  if FOle2Menu <> 0 then
    Result := FOle2Menu else
    Result := inherited GetHandle;
end;

{$IFDEF ITERATOR_OBJECTS}
type
  TAccelTableBuilder = class
    Groups: TIntegerDynArray;
    NumAccels: Integer;
    AccelList: array of TACCEL;
    AccelIndex: Integer;
    AccelHandle: HACCEL;
    procedure ProcessAccels(Item: TMenuItem);
    function ProcessAccelItems(Item: TMenuItem): Boolean;
    procedure CalcAccel(Items: TMenuItem);
  end;

function CopyIntegerArray(const Items: array of Integer): TIntegerDynArray; overload;
begin
{$IFDEF CLR}
  Result := Items;
{$ELSE !CLR}
  SetLength(Result, Length(Items));
  Move(Items[Low(Items)], Result[0], SizeOf(Items));
{$ENDIF}
end;

procedure TAccelTableBuilder.ProcessAccels(Item: TMenuItem);
var
  I: Integer;
  Virt: Byte;
begin
  if Item.ShortCut <> 0 then
    if AccelIndex >= 0 then
    begin
      Virt := FNOINVERT or FVIRTKEY;
      if Item.ShortCut and scCtrl <> 0 then Virt := Virt or FCONTROL;
      if Item.ShortCut and scAlt <> 0 then Virt := Virt or FALT;
      if Item.ShortCut and scShift <> 0 then Virt := Virt or FSHIFT;
      with AccelList[AccelIndex] do
      begin
        fVirt := Virt;
        key := Item.ShortCut and $FF;
        cmd := Item.Command;
      end;
      Inc(AccelIndex);
    end else
      Inc(NumAccels)
  else
    for I := 0 to Item.GetCount - 1 do ProcessAccels(Item[I]);
end;

function TAccelTableBuilder.ProcessAccelItems(Item: TMenuItem): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(Groups) do
    if Item.GroupIndex = Groups[I] then
    begin
      ProcessAccels(Item);
      Break;
    end;
  Result := False;
end;

procedure TAccelTableBuilder.CalcAccel(Items: TMenuItem);
begin
  NumAccels := 0;
  AccelIndex := -1;
  IterateMenus(ProcessAccelItems, Items.FMerged, Items);
  AccelHandle := 0;
  if NumAccels <> 0 then
  begin
    SetLength(AccelList, NumAccels);
    AccelIndex := 0;
    IterateMenus(ProcessAccelItems, Items.FMerged, Items);
    AccelHandle := CreateAcceleratorTable(AccelList, NumAccels);
  end;
end;
{$ENDIF ITERATOR_OBJECTS}

procedure TMainMenu.GetOle2AcceleratorTable(var AccelTable: HAccel;
  var AccelCount: Integer; const Groups: array of Integer);
{$IFDEF ITERATOR_OBJECTS}
var
  AccelTableBuilder: TAccelTableBuilder;
begin
  AccelTableBuilder := TAccelTableBuilder.Create;
  try
    AccelTableBuilder.Groups := CopyIntegerArray(Groups);
    AccelTableBuilder.CalcAccel(Items);
    AccelCount := AccelTableBuilder.NumAccels;
    AccelTable := AccelTableBuilder.AccelHandle;
  finally
    AccelTableBuilder.Free;
  end;
end;
{$ELSE !ITERATOR_OBJECTS}
var
  NumAccels: Integer;
  AccelList, AccelPtr: PAccel;

  procedure ProcessAccels(Item: TMenuItem);
  var
    I: Integer;
    Virt: Byte;
  begin
    if Item.ShortCut <> 0 then
      if AccelPtr <> nil then
      begin
        Virt := FNOINVERT or FVIRTKEY;
        if Item.ShortCut and scCtrl <> 0 then Virt := Virt or FCONTROL;
        if Item.ShortCut and scAlt <> 0 then Virt := Virt or FALT;
        if Item.ShortCut and scShift <> 0 then Virt := Virt or FSHIFT;
        AccelPtr^.fVirt := Virt;
        AccelPtr^.key := Item.ShortCut and $FF;
        AccelPtr^.cmd := Item.Command;
        Inc(AccelPtr);
      end else
        Inc(NumAccels)
    else
      for I := 0 to Item.GetCount - 1 do ProcessAccels(Item[I]);
  end;

  function ProcessAccelItems(Item: TMenuItem): Boolean;
  var
    I: Integer;
  begin
    for I := 0 to High(Groups) do
      if Item.GroupIndex = Groups[I] then
      begin
        ProcessAccels(Item);
        Break;
      end;
    Result := False;
  end;

begin
  NumAccels := 0;
  AccelPtr := nil;
  IterateMenus(@ProcessAccelItems, Items.FMerged, Items);
  AccelTable := 0;
  if NumAccels <> 0 then
  begin
    GetMem(AccelList, NumAccels * SizeOf(TAccel));
    AccelPtr := AccelList;
    IterateMenus(@ProcessAccelItems, Items.FMerged, Items);
    AccelTable := CreateAcceleratorTable(AccelList^, NumAccels);
    FreeMem(AccelList);
  end;
  AccelCount := NumAccels;
end;
{$ENDIF !ITERATOR_OBJECTS}

{ Similar to regular TMenuItem.PopulateMenus except that it only adds
  the specified groups to the menu handle }

{$IFDEF ITERATOR_OBJECTS}
type
  TOleMenuPopulator = class
    SharedMenu: HMENU;
    Groups: TIntegerDynArray;
    Widths: TIntegerDynArray;
    MenuRightToLeft: Boolean;
    function AddOle2(Item: TMenuItem): Boolean;
  end;

function TOleMenuPopulator.AddOle2(Item: TMenuItem): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(Groups) do
  begin
    if Item.GroupIndex = Groups[I] then
    begin
      Inc(Widths[Item.GroupIndex]);
      Item.AppendTo(SharedMenu, MenuRightToLeft);
    end;
  end;
  Result := False;
end;
{$ENDIF !ITERATOR_OBJECTS}

procedure TMainMenu.PopulateOle2Menu(SharedMenu: HMENU;
  const Groups: array of Integer; var Widths: array of Longint);
{$IFDEF ITERATOR_OBJECTS}
var
  J: Integer;
  OleMenuPopulator: TOleMenuPopulator;
begin
  for J := 0 to High(Widths) do Widths[J] := 0;
  OleMenuPopulator := TOleMenuPopulator.Create;
  try
    OleMenuPopulator.SharedMenu := SharedMenu;
    OleMenuPopulator.Groups := CopyIntegerArray(Groups);
    OleMenuPopulator.Widths := CopyIntegerArray(Widths);
    OleMenuPopulator.MenuRightToLeft := IsRightToLeft;
    IterateMenus(OleMenuPopulator.AddOle2, Items.FMerged, Items);
    for J := Low(Widths) to High(Widths) do
      Widths[J] := OleMenuPopulator.Widths[J];
  finally
    OleMenuPopulator.Free;
  end;
end;
{$ELSE !ITERATOR_OBJECTS}
var
  NumGroups: Integer;
  J: Integer;
  MenuRightToLeft: Boolean;

  function AddOle2(Item: TMenuItem): Boolean;
  var
    I: Integer;
  begin
    for I := 0 to NumGroups do
    begin
      if Item.GroupIndex = Groups[I] then
      begin
        Inc(Widths[Item.GroupIndex]);
        Item.AppendTo(SharedMenu, MenuRightToLeft);
      end;
    end;
    Result := False;
  end;

begin
  MenuRightToLeft := IsRightToLeft;
  NumGroups := High(Groups);
  for J := 0 to High(Widths) do Widths[J] := 0;
  IterateMenus(@AddOle2, Items.FMerged, Items);
end;
{$ENDIF !ITERATOR_OBJECTS}

procedure TMainMenu.SetOle2MenuHandle(Handle: HMENU);
begin
  FOle2Menu := Handle;
  ItemChanged;
end;

{ TPopupList }

procedure TPopupList.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

[SecurityPermission(SecurityAction.InheritanceDemand, UnmanagedCode=True)]
procedure TPopupList.WndProc(var Message: TMessage);
var
  I, Item: Integer;
  MenuItem: TMenuItem;
  FindKind: TFindItemKind;
  ContextID: Integer;
  Canvas: TCanvas;
  SaveIndex: Integer;
  DC: HDC;
  LWidth, LHeight: Integer;
{$IF DEFINED(CLR)}
  LMeasureMsg: TWMMeasureItem;
  LMeasureItemStruct: TMeasureItemStruct;
{$ENDIF}
begin
  case Message.Msg of
    WM_COMMAND:
      for I := 0 to Count - 1 do
        if TPopupMenu(Items[I]).DispatchCommand(Message.wParam) then Exit;
    WM_INITMENUPOPUP:
      with TWMInitMenuPopup(Message) do
        for I := 0 to Self.Count - 1 do
          if TPopupMenu(Items[I]).DispatchPopup(MenuPopup) then Exit;
    WM_MENUSELECT:
      with TWMMenuSelect(Message) do
      begin
        FindKind := fkCommand;
        if MenuFlag and MF_POPUP <> 0 then FindKind := fkHandle;
        for I := 0 to Count - 1 do
        begin
          if FindKind = fkHandle then
          begin
            if Menu <> 0 then
              Item := GetSubMenu(Menu, IDItem) else
              Item := -1;
          end
          else
            Item := IDItem;
          MenuItem := TPopupMenu(Items[I]).FindItem(Item, FindKind);
          if MenuItem <> nil then
          begin
            Application.Hint := GetLongHint(MenuItem.Hint);
            Exit;
          end;
        end;
        Application.Hint := '';
      end;
    WM_HELP:
{$IF DEFINED(CLR)}
      with TWMHelp.Create(Message).HelpInfo do
{$ELSE}
      with PHelpInfo(Message.LParam)^ do
{$ENDIF}
      begin
        for I := 0 to Count - 1 do
        begin
          if HMENU(hItemHandle) = TMenu(Items[I]).Handle then
            MenuItem := TMenu(Items[I]).Items
          else
            MenuItem := TPopupMenu(Items[I]).FindItem(hItemHandle, fkHandle);
          if MenuItem <> nil then
          begin
            ContextID := TMenu(Items[I]).GetHelpContext(iCtrlID, True);
            if ContextID = 0 then
              ContextID := TMenu(Items[I]).GetHelpContext(hItemHandle, False);
            if Screen.ActiveForm = nil then Exit;
            if (ContextID = 0) then
              ContextID := Screen.ActiveForm.HelpContext;
            if (biHelp in Screen.ActiveForm.BorderIcons) then
              Application.HelpCommand(HELP_CONTEXTPOPUP, ContextID)
            else
              Application.HelpContext(ContextID);
            Exit;
          end;
        end;
      end;
    WM_DRAWITEM:
{$IF DEFINED(CLR)}
      with TWMDrawItem.Create(Message).DrawItemStruct do
{$ELSE}
      with PDrawItemStruct(Message.LParam)^ do
{$ENDIF}
      begin
        for I := 0 to Count - 1 do
        begin
          MenuItem := TPopupMenu(Items[I]).FindItem(itemID, fkCommand);
          if MenuItem <> nil then
          begin
            Canvas := TControlCanvas.Create;
            with Canvas do
            try
              SaveIndex := SaveDC(hDC);
              try
                Handle := hDC;
                Font := Screen.MenuFont;
                DrawMenuItem(MenuItem, Canvas, rcItem, TOwnerDrawState(LoWord(itemState)));
              finally
                Handle := 0;
                RestoreDC(hDC, SaveIndex);
              end;
            finally
              Canvas.Free;
            end;
            Exit;
          end;
        end;
      end;
    WM_MEASUREITEM:
    begin
{$IF DEFINED(CLR)}
      LMeasureMsg := TWMMeasureItem.Create(Message);
      LMeasureItemStruct := LMeasureMsg.MeasureItemStruct;
      with LMeasureItemStruct do
{$ELSE}
      with PMeasureItemStruct(Message.LParam)^ do
{$ENDIF}
      begin
        for I := 0 to Count - 1 do
        begin
          MenuItem := TPopupMenu(Items[I]).FindItem(itemID, fkCommand);
          if MenuItem <> nil then
          begin
            DC := GetWindowDC(Window);
            try
              Canvas := TControlCanvas.Create;
              with Canvas do
              try
                SaveIndex := SaveDC(DC);
                try
                  Handle := DC;
                  Font := Screen.MenuFont;
                  LWidth := itemWidth;
                  LHeight := itemHeight;
                  MenuItem.MeasureItem(Canvas, LWidth, LHeight);
                  itemWidth := LWidth;
                  itemHeight := LHeight;
                finally
                  Handle := 0;
                  RestoreDC(DC, SaveIndex);
                end;
              finally
                Canvas.Free;
              end;
            finally
              ReleaseDC(Window, DC);
            end;
{$IF DEFINED(CLR)}
            LMeasureMsg.MeasureItemStruct := LMeasureItemStruct;
{$ENDIF}
            Exit;
          end;
        end;
      end;
    end;
    WM_MENUCHAR:
      for I := 0 to Count - 1 do
        with TPopupMenu(Items[I]) do
          if (Handle = HMENU(Message.LParam)) or
            (FindItem(Message.LParam, fkHandle) <> nil) then
          begin
{$IF DEFINED(CLR)}
            ProcessMenuChar(TWMMenuChar.Create(Message));
{$ELSE}
            ProcessMenuChar(TWMMenuChar(Message));
{$ENDIF}
            Exit;
          end;
  end;
  with Message do Result := DefWindowProc(Window, Msg, wParam, lParam);
end;

procedure TPopupList.Add(Popup: TPopupMenu);
begin
  if Count = 0 then FWindow := AllocateHWnd(MainWndProc);
  inherited Add(Popup);
end;

procedure TPopupList.Remove(Popup: TPopupMenu);
begin
  inherited Remove(Popup);
  if Count = 0 then DeallocateHWnd(FWindow);
end;

{ TPopupMenu }

constructor TPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPopupPoint.X := -1;
  FPopupPoint.Y := -1;
  FItems.OnClick := DoPopup;
  FWindowHandle := Application.Handle;
  FAutoPopup := True;
  PopupList.Add(Self);
end;

destructor TPopupMenu.Destroy;
begin
  PopupList.Remove(Self);
  inherited Destroy;
end;

procedure TPopupMenu.CloseMenu;
begin
  Winapi.Windows.EndMenu;
end;

procedure TPopupMenu.DoPopup(Sender: TObject);
begin
  if Assigned(FOnPopup) then FOnPopup(Sender);
end;

function TPopupMenu.GetHelpContext: THelpContext;
begin
  Result := FItems.HelpContext;
end;

procedure TPopupMenu.SetHelpContext(Value: THelpContext);
begin
  FItems.HelpContext := Value;
end;

procedure TPopupMenu.SetBiDiModeFromPopupControl;
var
  AControl: TControl;
begin
  if not SysLocale.MiddleEast then Exit;
  if FParentBiDiMode then
  begin
    { Use the setting from the control that activated the popup.
      If there is no control, then use Application }
    AControl := FindPopupControl(FPopupPoint);
    if AControl <> nil then
    begin
      BiDiMode := AControl.BiDiMode;
      FParentBiDiMode := True;
    end
    else
    begin
      BiDiMode := Application.BiDiMode;
      FParentBiDiMode := True;
    end;
  end;
end;

function TPopupMenu.UseRightToLeftAlignment: Boolean;
var
  AControl: TControl;
begin
  Result := False;
  if not SysLocale.MiddleEast then Exit;
  if FParentBiDiMode then
  begin
    { Use the setting from the control that activated the popup.
      If there is no control, then use Application }
    AControl := FindPopupControl(FPopupPoint);
    if AControl <> nil then
      Result := AControl.UseRightToLeftAlignment
    else
      Result := Application.UseRightToLeftAlignment;
  end
  else
    Result := (FBiDiMode = bdRightToLeft);
end;

procedure TPopupMenu.Popup(X, Y: Integer);
const
  Flags: array[Boolean, TPopupAlignment] of Word =
    ((TPM_LEFTALIGN, TPM_RIGHTALIGN, TPM_CENTERALIGN),
     (TPM_RIGHTALIGN, TPM_LEFTALIGN, TPM_CENTERALIGN));
  Buttons: array[TTrackButton] of Word = (TPM_RIGHTBUTTON, TPM_LEFTBUTTON);
var
  AFlags: Integer;
begin
  SetPopupPoint(Point(X, Y));
  SetBiDiModeFromPopupControl;
  DoPopup(Self);
  FItems.InternalRethinkHotkeys(False);
  FItems.InternalRethinkLines(False);
  FItems.RebuildHandle;
  AdjustBiDiBehavior;
  AFlags := Flags[UseRightToLeftAlignment, FAlignment] or Buttons[FTrackButton] or
    (Byte(FMenuAnimation) shl 10);
  TrackPopupMenu(FItems.Handle, AFlags, X, Y, 0 { reserved }, PopupList.Window, nil);
end;

procedure TPopupMenu.SetPopupPoint(APopupPoint: TPoint);
begin
  FPopupPoint := APopupPoint;
end;

{ TMenuItemStack }

procedure TMenuItemStack.ClearItem(AItem: TMenuItem);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do
{$IF DEFINED(CLR)}
    with TMenuItemHolder(List[I]) do
      if Value = AItem then
        Value := nil;
{$ELSE}
    if PMenuItem(List[I])^ = AItem then
      PMenuItem(List[I])^ := nil;
{$ENDIF}
end;

{ Menu building functions }

procedure InitMenuItems(AMenu: TMenu; const Items: array of TMenuItem);
var
  I: Integer;

  procedure SetOwner(Item: TMenuItem);
  var
    I: Integer;
  begin
    if Item.Owner = nil then AMenu.Owner.InsertComponent(Item);
    for I := 0 to Item.Count - 1 do
      SetOwner(Item[I]);
  end;

begin
  for I := Low(Items) to High(Items) do
  begin
    SetOwner(Items[I]);
    AMenu.FItems.Add(Items[I]);
  end;
end;

function NewMenu(Owner: TComponent; const AName: string; const Items: array of TMenuItem): TMainMenu;
begin
  Result := TMainMenu.Create(Owner);
  Result.Name := AName;
  InitMenuItems(Result, Items);
end;

function NewPopupMenu(Owner: TComponent; const AName: string;
  Alignment: TPopupAlignment; AutoPopup: Boolean; const Items: array of TMenuItem): TPopupMenu;
begin
  Result := TPopupMenu.Create(Owner);
  Result.Name := AName;
  Result.AutoPopup := AutoPopup;
  Result.Alignment := Alignment;
  InitMenuItems(Result, Items);
end;

function NewSubMenu(const ACaption: string; hCtx: THelpContext;
  const AName: string; const Items: array of TMenuItem; AEnabled: Boolean): TMenuItem;
var
  I: Integer;
begin
  Result := TMenuItem.Create(nil);
  for I := Low(Items) to High(Items) do
    Result.Add(Items[I]);
  Result.Caption := ACaption;
  Result.HelpContext := hCtx;
  Result.Name := AName;
  Result.Enabled := AEnabled;
end;

function NewItem(const ACaption: string; AShortCut: TShortCut;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: THelpContext;
  const AName: string): TMenuItem;
begin
  Result := TMenuItem.Create(nil);
  with Result do
  begin
    Caption := ACaption;
    ShortCut := AShortCut;
    OnClick := AOnClick;
    HelpContext := hCtx;
    Checked := AChecked;
    Enabled := AEnabled;
    Name := AName;
  end;
end;

function NewLine: TMenuItem;
begin
  Result := TMenuItem.Create(nil);
  Result.Caption := cLineCaption;
end;

procedure DrawMenuItem(MenuItem: TMenuItem; ACanvas: TCanvas; ARect: TRect;
  State: TOwnerDrawState);
var
  TopLevel: Boolean;
  Win98Plus: Boolean;
begin
  with ACanvas do
  begin
    Win98Plus := (Win32MajorVersion > 4) or
      ((Win32MajorVersion = 4) and (Win32MinorVersion > 0));
    TopLevel := MenuItem.GetParentComponent is TMainMenu;
    if (odSelected in State) and (not TopLevel or (TopLevel and not Win98Plus)) then
    begin
      Brush.Color := clHighlight;
      Font.Color := clHighlightText;
    end
    else if Win98Plus and (odInactive in State) then
    begin
      Brush.Color := clMenu;
      Font.Color := clGrayText;
    end
    else
    begin
      Brush.Color := clMenu;
      Font.Color := clMenuText;
    end;
    MenuItem.AdvancedDrawItem(ACanvas, ARect, State, TopLevel);
  end;
end;

function StripHotkey(const Text: string): string;
var
  I: Integer;
begin
  Result := Text;
  I := 1;
  while I <= Length(Result) do
  begin
{$IF NOT DEFINED(CLR)}
    if IsLeadChar(Result[I]) then
      Inc(I)
    else
{$ENDIF}
    if Result[I] = cHotkeyPrefix then
      if SysLocale.FarEast and
        ((I > 1) and (Length(Result)-I >= 2) and
         (Result[I-1] = '(') and (Result[I+2] = ')')) then
        Delete(Result, I-1, 4)
      else
        Delete(Result, I, 1);
    Inc(I);
  end;
end;

function GetHotkey(const Text: string): string;
var
  I, L: Integer;
begin
  Result := '';
  I := 1;
  L := Length(Text);
  while I <= L do
  begin
{$IF NOT DEFINED(CLR)}
    if IsLeadChar(Text[I]) then
      Inc(I)
    else 
{$ENDIF}
    if (Text[I] = cHotkeyPrefix) and (L - I >= 1) then
    begin
      Inc(I);
      if Text[I] <> cHotkeyPrefix then
        Result := Text[I]; // keep going there may be another one
    end;
    Inc(I);
  end;
end;

function SameCaption(const Text1, Text2: string): Boolean;
begin
  Result := AnsiSameText(StripHotkey(Text1), StripHotkey(Text2));
end;

{$IF NOT DEFINED(CLR)}
function AnsiSameCaption(const Text1, Text2: string): Boolean;
begin
  Result := AnsiSameText(StripHotkey(Text1), StripHotkey(Text2));
end;
{$ENDIF}

initialization
{$IF NOT DEFINED(CLR)}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TMenuItem, TControl);
  GroupDescendentsWith(TMenu, TControl);
{$ENDIF}
  RegisterClass(TMenuItem);
  CommandPool := TBits.Create;
  PopupList := TPopupList.Create;
  ShortCutItems := TMenuItemStack.Create;
  
{$IF NOT DEFINED(CLR)}
finalization
  ShortCutItems.Free;
  PopupList.Free;
  CommandPool.Free;
{$ENDIF}
  
end.


