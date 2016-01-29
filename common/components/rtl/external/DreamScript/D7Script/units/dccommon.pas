{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dccommon;

interface
{$I dc.inc}
uses
  {$IFNDEF CLX}
  ActiveX, windows, messages, shellapi, commctrl,
  {$ELSE}
  dcActivex,
  {$ENDIF}

  Classes, Sysutils, IniFiles,
  {$IFDEF WIN}
  {$IFNDEF CLX}
  graphics, forms, controls,
  menus, StdCtrls, buttons, comctrls,
  {$ELSE}
  Qt, QForms, QControls, QGraphics,
  QMenus, QStdCtrls, QButtons, QComctrls,
  {$ENDIF}
  {$ENDIF}

  consts, typinfo, dcsystem, dcdreamlib, dcconsts,

  {$IFDEF D4}
  {$IFDEF CLX}
  QActnList,
  QImgList,
  {$ELSE}
  ActnList,
  imglist,
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF SHELLOBJ}
  filectrl,
  {$ENDIF}
  dcapi
  {$IFDEF DCMBCS}
  , imm
  {$ENDIF}
  ;

type
  TProcessChangesProc = procedure(Sender: TObject; var processed: boolean) of object;

{$IFDEF WIN}
type
  TDCCustomControl = class(TCustomControl)
  private
    FWantTabs: boolean;
    FWantReturns: boolean;
    FKeyboardInit: TKeyboardInitProc;
    FKeyMapping: string;
    FKeyState: integer;
    FKeys: TKeyList;
    {$IFNDEF CLX}
    FOemConvert: boolean;
    {$ENDIF}
    FKeyWasFound: boolean;
    {$IFDEF DCMBCS}
    FImeStr: string;
    fImeCount: integer;
    {$ENDIF}
    procedure SetKeyMapping(const V: string);
  protected
    procedure UpdateKeyMapping; virtual;
    procedure InitDefaultKeyMapping; virtual; abstract;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure ClearKeys;

    {$IFNDEF CLX}
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CNSysKeyDown(var Message: TWMKeyDown); message CN_SysKeyDown;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KeyDown;
    {$ENDIF}
    //procedure CMChildKey(var Message: TCMChildKey); message CM_ChildKey;
    function InsertChar(Ch: Char): Boolean; virtual;

    {$IFDEF DCMBCS}
    function InsertString(const s: string): boolean; virtual;
    procedure WMImeComposition(var Msg: TMessage); message WM_IME_COMPOSITION;
    property ImeCount: integer read FImeCount;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Keys: TKeyList read FKeys;
    property KeyState: Integer read FKeyState write FKeyState;
    property KeyMapping: string read FKeyMapping write SetKeyMapping;
    property WantReturns: boolean read FWantReturns write FWantReturns default True;
    property WantTabs: boolean read FWantTabs write FWantTabs default False;
    {$IFNDEF CLX}
    property OemConvert: boolean read FOemConvert write FOemConvert default false;
    {$ENDIF}
  published
  end;

  {$IFDEF WIN}
  {$IFNDEF CLX}
  THandleObject = class(TObject)
  private
    FWnd: HWnd;
  public
    constructor Create(WndProc: TWndMethod);
    destructor Destroy; override;
    property Handle: HWnd read FWnd;
  end;
  TDCHandleObject = class(THandleObject)
  private
    fObject: TObject;
    procedure WndProc(var Msg: TMessage);
  public
    constructor Create(AObject: TObject);
    procedure PostMsg(Msg, wParam, lParam: integer);
  end;
  {$ENDIF}
  {$ENDIF}

  {$ENDIF WIN}
  {$IFNDEF D3}
  TCustomForm = TForm;
  {$ENDIF}

  TPropStream = class(TMemoryStream)
  private
    FMode: Integer;
    FInstance: TPersistent;
    FPropName: string;
    FPropInfo: PPropInfo;
    FStrings: TStrings;
    FVersion: TDCVersion;
    function GetPropValue: string;
    procedure SetPropValue(const S: string);
    procedure UpdatePropInfo;
    procedure BadPropInfo;
  public
    constructor Create(Instance: TPersistent; const PropName: string; Mode: Integer);
    destructor Destroy; override;
  published
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;

  TPropFileSystem = class(TFileSystem)
  private
    FPropName: string;
    FComponent: TComponent;
    procedure SetComponent(val: TComponent);
    procedure SetComponentPtr(const val: string);
    function GetComponentPtr: string;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function FileExists(const FileName: TFileName): Boolean; override;
    function GetFileStream(const FileName: TFileName; Mode: Integer): TStream; override;
    function GetFileSystemLevel: TFileSystemLevel; override;
    property Component: TComponent read fComponent write SetComponent;
  published
    property ComponentPtr: string read GetComponentPtr write SetComponentPtr;
    property PropName: string read FPropName write FPropName;
  end;

  {$IFDEF WIN}

  TCompFiler = class
  private
    _OldClassNamePtr: Pointer;
    _ClassNameStr: ShortString;
    _OldTable: PMethodTable;
    _S: TMemoryStream;
    FEventID: Integer;
    FEventNames: TStrings;
    FFixList: TStrings;
    fOnReaderError: TReaderError;
    fOnAfterLoad: TNotifyEvent;
    fcname: string;

    fIgnoreDesignedForms: boolean;
    HandledAll: boolean;
    FFilerErrors: boolean;

    procedure CreateMethodTable(S: TStream; OldTable: PMethodTable);
    function DoLoadFromStream(FormStream: TStream; Instance: TComponent): string;
  protected
    procedure CompLoaded;
  public
    Ancestor: TComponent;
    NewFormStyle: TFormStyle;

    function GlobalFindCompWithoutDesigned(const Name: string): TComponent;
    procedure Assign(Source: TCompFiler);
    procedure ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
    procedure ReaderOnMethod(Reader: TReader; const MethodName: string;
      var Address: Pointer; var Error: Boolean);
    function AddEvent(const EvName: string): Integer;
    procedure BeginMethodTrick(OwnerControl: TComponent; SkipMethodsWrite: boolean);
    procedure EndMethodTrick(OwnerControl: TComponent);
    procedure BeginClassNameTrick(OwnerControl: TComponent);
    procedure EndClassNameTrick(OwnerControl: TComponent);

    procedure BeginTrick(OwnerControl: TComponent; SkipMethodsWrite: boolean);
    procedure EndTrick(OwnerControl: TComponent);

    function EventNameByID(ID: integer): string;
    constructor Create;
    destructor Destroy; override;
    function LoadFromStream(FormStream: TStream; Instance: TComponent): string;
    procedure SaveToStream(FormStream: TStream; Instance: TComponent);
    procedure LoadFromFile(const FileName: TFileName; Instance: TComponent);
    procedure SaveToFile(const FileName: TFileName; Instance: TComponent);
    function CreateFromStream(S: TStream; ModuleClass: TComponentClass; SetDesigning: boolean): TComponent;
    function CreateFromFile(const FileName: TFileName; ModuleClass: TComponentClass; SetDesigning: boolean): TComponent;

    property EventNames: TStrings read FEventNames;
    property FilerErrors: boolean read FFilerErrors;
    property IgnoreDesignedForms: boolean read fIgnoreDesignedForms write fIgnoreDesignedForms;
    property CompClassName: string read fcname;
    property OnReaderError: TReaderError read fOnReaderError write fOnReaderError;
    property OnAfterLoad: TNotifyEvent read fOnAfterLoad write fOnAfterLoad;
  end;

  TCustomFormClass = class of TCustomForm;
  TDataModuleClass = class of TDataModule;

  {$IFNDEF CLX}

  TVerbListItem = class;

  TAssignVerbProc = procedure(Comp: TComponent; VerbItem: TVerbListItem);

  TVerbListItem = class(TDCNamedItem)
  private
    FClearHandler: boolean;
    FAssignProc: TAssignVerbProc;
    FVerbStates: TVerbStates;
    FVerbName: string;
    FVerbComp: TComponent;
    FVerbGetState: TGetVerbStateProc;
    FVerbExecute: TExecuteVerbProc;
    FDesignGroup: Integer;
    function OwnerObject: TPersistent;
    procedure SetVerbName(const Value: string);
    procedure SetVerbComp(Value: TComponent);
    procedure UpdateVerbObject;
  protected
    {$IFDEF D3}
    function GetDisplayName: string; override;
    {$ENDIF}
  public
    procedure UpdateControl;
    procedure VerbOnClick(Sender: TObject);
    destructor Destroy; override;
    property VerbStates: TVerbStates read FVerbStates;
    property VerbGetState: TGetVerbStateProc read FVerbGetState;
    property VerbExecute: TExecuteVerbProc read FVerbExecute;
    property ClearHandler: boolean read FClearHandler;
  published
    property VerbComp: TComponent read FVerbComp write SetVerbComp;
    property VerbName: string read FVerbName write SetVerbName;
  end;

  TVerbList = class(TDCNamedItems)
  private
    function GetItem(Index: Integer): TVerbListItem;
    procedure SetItem(Index: Integer; V: TVerbListItem);
  public
    property Items[Index: Integer]: TVerbListItem read GetItem write SetItem; default;
  end;

  TVerbDispatcher = class(TComponent)
  private
    FVerbList: TVerbList;
    FVersion: TDCVersion;
    procedure SetVerbList(Value: TVerbList);
  protected
    procedure CMIDECHANGED(var Message: TMessage); message CM_IDECHANGED;
    procedure CMPROPCHANGED(var Message: TMessage); message CM_PROPCHANGED;
    procedure CMFREEEDITGROUP(var Message: TMessage); message CM_FREEEDITGROUP;
    procedure CMPACKAGELOADED(var Message: TMessage); message CM_PACKAGELOADED;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure UpdateVerbObjects(Group: Integer);
    procedure UpdateControls;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property VerbList: TVerbList read FVerbList write SetVerbList;
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;

  TDCPropStore = class(TComponent)
  private
    fIgnoreErrors: boolean;
    fPropNames: TStringList;
    fKey: string;
    FPropList: TStrings;
    fStorePos: boolean;
    fOldFormClose: TCloseQueryEvent;
    fOldOnDestroy: TNotifyEvent;
    fTmpProps: TList;
    FVersion: TDCVersion;
    FIniFile: string;
    FIniSection: string;
    FUseIniFile: Boolean;

    fOnLoadChanges: TProcessChangesProc;
    fOnSaveChanges: TProcessChangesProc;
    FOnChangesLoaded: TNotifyEvent;
    FOnChangesSaved: TNotifyEvent;

    procedure SetPropList(Value: TStrings);
    procedure ProcessAllProps(Filer: TFiler; WriteMode: boolean);
    procedure HookOnClose;
    procedure MyCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MyOnDestroy(Sender: TObject);
    procedure ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
    function GetKey: string;
    procedure ReadSelectedProps(Instance: TComponent; Reader: TReader; PropNames: TStrings);
    procedure DummySetProc;
    procedure ProcessProp1(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
    procedure ProcessProp2(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToIniFile(const AFileName, ASection: string);
    procedure LoadFromIniFile(const AFileName, ASection: string);
    procedure Load; virtual;
    procedure Save; virtual;
  published
    property IgnoreErrors: boolean read fIgnoreErrors write fIgnoreErrors default true;
    property IniFile: string read FIniFile write FIniFile;
    property IniSection: string read FIniSection write FIniSection;
    property Key: string read GetKey write fkey;
    property PropList: TStrings read FPropList write SetPropList;
    property StorePos: boolean read fStorePos write fStorePos default true;
    property UseIniFile: Boolean read FUseIniFile write FUseIniFile;
    property Version: TDCVersion read FVersion write FVersion stored false;

    property OnLoadChanges: TProcessChangesProc read fOnLoadChanges write fOnLoadChanges;
    property OnSaveChanges: TProcessChangesProc read fOnSaveChanges write fOnSaveChanges;
    property OnChangesLoaded: TNotifyEvent read FOnChangesLoaded write FOnChangesLoaded;
    property OnChangesSaved: TNotifyEvent read FOnChangesSaved write FOnChangesSaved;
  end;

  TDCTabControl = class(TTabControl)
  private
    FVersion: TDCVersion;
    function IsContainedControl: Boolean;
  protected
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  published
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;

  TCustomDCOleControl = class(TCustomControl)
  private
    fOnEvent: TEventHandler;
  protected
    function GetOleName: string; virtual; abstract;
    function GetOleObject: IOleObject; virtual; abstract;
  public
    procedure SetEvent(ID: integer; const HandlerName: string); virtual; abstract;
    function GetEvent(ID: integer): string; virtual; abstract;

    property OleName: string read GetOleName;
    property OnEvent: TEventHandler read fOnEvent write fOnEvent;
    property OleObject: IOleObject read GetOleObject;
  end;

  TDCSpeedButton = class(TSpeedButton)
  private
    {$IFNDEF D3}
    fFlat: boolean;
    {$ENDIF}
    foldOnChange: TNotifyEvent;
    FVersion: TDCVersion;
    procedure GlyphChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    {$IFNDEF D3}
    property Flat: boolean read fFlat write fFlat;
    {$ENDIF}
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;

procedure UpdateParamsWithBorderStyle(var Params: TCreateParams; BorderStyle: TBorderStyle; Ctl3d: boolean);
function GetFontMetrics(Font: TFont): TTextMetric;

function GetScrollPosEx(Wnd: THandle; fnBar: Integer): Integer;
procedure _SetScrollPos(W: HWND; Code, Value: Integer);
procedure _SetScrollSize(W: HWND; Code, MinPos, MaxPos, PageSize: Integer);

{$ENDIF ~CLX}

function GetMaxFontWidth(Font: TFont): Integer;
function GetAveFontWidth(Font: TFont): Integer;
function GetMaxFontHeight(Font: TFont): Integer;
function GetMinFontHeight(Font: TFont): Integer;
function IsFontMonoSpaced(Font: TFont): boolean;

{$ENDIF WIN}

function CheckFileExt(const FileName, FileExt: string): boolean;
function IsStringHot(const s: string): boolean;
function IsWWWString(const s: string): boolean;
function IsEmailString(const s: string): boolean;

{$IFDEF WIN}

function ScreenFormCount: Integer;
function ScreenForms(i: Integer): TCustomForm;
function CreateFormWithClass(FormClass: TComponentClass): TCustomForm;
function CreateDataModuleWithClass(DataModuleClass: TComponentClass): TDataModule;
procedure SetDesign(Instance: TComponent; value: boolean);
function GetTopOwner(c: TPersistent): TComponent;
function GetPForm(c: TPersistent): TCustomForm;
procedure CallCompOnCreate(Comp: TComponent);

{$IFNDEF CLX}
procedure DesignerModified(c: TPersistent);
procedure DesignerSelectComponent(c: TComponent);

function FindFormWithClass(C: TClass): TCustomForm;
function FormIsActive(F: TCustomForm): boolean;
function FindOrCreateFormWithClass(C: TCustomFormClass; Owner: TComponent): TCustomForm;
function GlobalFindObject(const FullName: string): TComponent;
function GetFormResourceHandler(AClass: TClass): THandle;

procedure UpdateEditors(Control: TWinControl);
procedure WriteWinPosToReg(C: TWinControl; const S: string);
procedure ReadWinPosFromReg(C: TWinControl; const S: string);
procedure RegisterAssignVerbProc(CompClass: TComponentClass; AssignVerbProc: TAssignVerbProc);
procedure CalcEditorMinMaxInfo(var Message: TMessage; Form: TCustomForm; MaxToFullScreen: Boolean);
procedure WriteWinPosToIni(C: TWinControl; const S, AFileName, ASection: string);
procedure ReadWinPosFromIni(C: TWinControl; const S, AFileName, ASection: string);

procedure JumpToURL(const s: string);
procedure WriteToUs;
procedure HomePage;
procedure OnlineRegistration;

procedure ChangeTab(TabControl: TTabControl; ANext: Boolean);
procedure AddNewTab(TabControl: TTabControl; const TabCaption: string);
procedure GetLoadedPackagesPaths(Strings: TStrings);
function FindResourceInstance(const ResName: string; ResType: PChar): THandle;
{$ENDIF CLX}

function StreamContainsDataModule(S: TStream): boolean;
procedure ClearMenuSubItems(MenuItem: TMenuItem; DisableItem: boolean);
procedure RemoveExtraMenuSeparators(MenuItem: TMenuItem);

procedure SetFormFont(Form: TCustomForm);
{$ENDIF WIN}

procedure ResModulesToList(List: TList);
procedure ModulesToList(List: TList);
function FileIsPackage(const FileName: string): boolean;

procedure MovePages(Source, Dest: TPageControl);

{$IFDEF WIN}
{$IFNDEF CLX}
procedure ChangeImageList(Image: TCustomImageList; Bitmap: TBitmap; trColor: TColor; index: integer);

procedure CreateBrushPattern(Bitmap: TBitmap);
procedure CreateBrushPatternEx(Bitmap: TBitmap; Color1, Color2: TColor);

procedure StretchBltTransparent(DestDC: THandle; DestLeft, DestTop, DestWidth, DestHeight: Integer;
  SourceDC: THandle; SourceLeft, SourceTop, SourceWidth, SourceHeight: Integer; TransColor: TColor);
procedure DrawImage(Canvas: TCanvas; Image: TPersistent; Color: TColor;
  const ARect: TRect; ImageIndex: integer);
{$ENDIF}
{$ENDIF}

{$IFDEF D4}
procedure SafeRegisterActions(const CategoryName: string; const AClasses: array of TBasicActionClass; Resource: TComponentClass);
{$ENDIF}

const
  {$IFDEF D4}
  cOtherIdentChars = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
  {$ELSE}
  cOtherIdentChars: TCharSet = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
  {$ENDIF}
  StdFontSizes: array[0..15] of integer =
  (8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72);

{$IFDEF WIN}
var
  UseOneFont: boolean = true; // if true then all forms has the same font
{$IFNDEF CLX}
  FMainForm: TCustomForm = nil;

{$IFDEF D4}
type
  TDesigner = {$IFDEF D6}IDesignerHook{$ELSE}IDesigner{$ENDIF};
{$ENDIF}

type
  TGetDesignerProc = function(Instance: TPersistent): TDesigner;

var
  GetDesignerProc: TGetDesignerProc = nil;

function QueryDirectory(const ATitle: string; var ADirectory: string): boolean;
function DropFiles(const Dirs, Multiselect: boolean; DelimiterChar: char;
  var Message: TWMDropFiles): string;
{$ENDIF}
{$ENDIF WIN}

function IsTextStream(S: TStream): boolean;
function GetClassNameFromStream(S: TStream): string;

{$IFDEF WIN}
function GetOptionsFormCaption(OptionsFormClass: TCustomFormClass): string;
procedure RegisterOptionsForm(OptionsFormClass: TCustomFormClass; const ACaption: string);
procedure RegisterOptionsFormOrder(OptionsFormClass: TCustomFormClass; Order: integer; const ACaption: string);
procedure UnregisterOptionsForm(OptionsFormClass: TCustomFormClass);

procedure SetFlatProp(const Ctrls: array of TSpeedButton; V: Boolean);
procedure SetFlatPropToAll(Owner: TComponent; Value: boolean);

function OptionFormClasses: TSortedList;
function OptionFormClass(index: integer): TCustomFormClass;
function OptionFormCaptions: TStringList;

procedure CorrectBitmap(Bitmap: TBitmap);
{$ENDIF}

type
  TReaderErrorHandler = procedure(const Message: string; var Handled, HandledAll: boolean);
  TOnHotStringHandler = function(const s: string): boolean;
var
  ReaderErrorHandler: TReaderErrorHandler;
  OnHotString: TOnHotStringHandler;
  HotCharSet: TCharSet = [];

  {$IFDEF WIN}
  { Instance of this class will be created when user opens form object }
  DefaultFormClassType: TCustomFormClass = TForm;
  {$ENDIF}

function EqualMethodTypeData(td1, td2: PTypeData): boolean;

procedure Register;

type
  TDCInitComponentHandler = procedure(Instance: TComponent; const InstanceClass, InstanceName: string) of object;

var
  DCInitComponentHandler: TDCInitComponentHandler = nil;

const
  {$IFDEF CLX}
  SM_CYBORDER = 1;
  SM_CXHTHUMB = 16;
  NewStyleControls = true;
  VK_UP = Key_Up;
  VK_DOWN = Key_Down;
  VK_RETURN = Key_Return;
  VK_ESCAPE = Key_Escape;
  VK_SPACE = Key_Space;
  VK_LEFT = Key_Left;
  VK_RIGHT = Key_Right;
  VK_NEXT = Key_Next;
  VK_PRIOR = Key_Prior;
  VK_DELETE = Key_Delete;
  VK_BACK = Key_Backspace;
  VK_TAB = Key_Tab;
  VK_HOME = Key_Home;
  VK_END = Key_End;
  VK_INSERT = Key_Insert;
  VK_MULTIPLY = Key_Multiply;
  VK_F3 = Key_F3;
  VK_F5 = Key_F5;
  VK_F6 = Key_F6;
  VK_F10 = Key_F10;
  VK_F9 = Key_F9;
  {$ELSE}
  Key_A = Word('A');
  Key_B = Word('B');
  Key_C = Word('C');
  Key_D = Word('D');
  Key_E = Word('E');
  Key_F = Word('F');
  Key_G = Word('G');
  Key_H = Word('H');
  Key_I = Word('I');
  Key_J = Word('J');
  Key_K = Word('K');
  Key_L = Word('L');
  Key_M = Word('M');
  Key_N = Word('N');
  Key_O = Word('O');
  Key_P = Word('P');
  Key_Q = Word('Q');
  Key_R = Word('R');
  Key_S = Word('S');
  Key_T = Word('T');
  Key_U = Word('U');
  Key_V = Word('V');
  Key_W = Word('W');
  Key_X = Word('X');
  Key_Y = Word('Y');
  Key_Z = Word('Z');
  Key_0 = Word('0');
  Key_1 = Word('1');
  Key_2 = Word('2');
  Key_3 = Word('3');
  Key_4 = Word('4');
  Key_5 = Word('5');
  Key_6 = Word('6');
  Key_7 = Word('7');
  Key_8 = Word('8');
  Key_9 = Word('9');
  Key_QuoteLeft = Word('<');
  Key_BracketLeft = Word('[');
  Key_BracketRight = Word(']');
  {$ENDIF}

var
  SaveFormAsText : boolean = True;

implementation

function IsTextStream(S: TStream): boolean;
var
  buffer: array[1..length('inherited')] of byte;

  function CheckIdent(const Ident: string): boolean;
  begin
    result := CompareMem(@buffer, pointer(Ident), length(Ident));
  end;

var
  savepos: integer;
begin
  savepos := S.Position;
  try
    S.ReadBuffer(buffer, sizeof(buffer));
    result := CheckIdent('object') or CheckIdent('inherited');
  finally
    S.Position := savepos;
  end;
end;

{------------------------------------------------------------------}

function GetClassNameFromStream(S: TStream): string;
const
  buffersize = length('inherited ') + 255 * 2 + 2; // max classname length = 255
var
  savepos: integer;
  i: integer;
  Flags: TFilerFlags;
  buffer: string;
begin
  savepos := S.Position;
  try
    if isTextStream(S) then
    begin
      SetString(buffer, nil, buffersize);
      SetLength(buffer, S.Read(buffer[1], buffersize));
      i := pos(#10, buffer);
      delete(buffer, i, MAXINT);
      i := pos(#13, buffer);
      delete(buffer, i, MAXINT);
      i := pos(':', buffer);
      delete(buffer, 1, i + 1);
      result := buffer;
    end
    else
      with TReader.Create(S, 4096) do
      try
        SmartSkipResHeader(S, False);
        ReadSignature;
        ReadPrefix(Flags, I);
        result := ReadStr;
      finally
        Free;
      end;
  finally
    S.Position := savepos;
  end;
end;

{------------------------------------------------------------------}

{$IFDEF WIN}

procedure CorrectBitmap(Bitmap: TBitmap);
var
  bmp: TBitmap;
begin
  if Bitmap = nil then
    exit;
  Bmp := TBitmap.Create;
  with Bmp, Canvas do
  try
    Width := Bitmap.Width;
    Height := Bitmap.Height;
    Draw(0, 0, Bitmap);
    Bitmap.Assign(Bmp);
  finally
    Bmp.Free;
  end;
end;

type
  TMControl = class(TControl)
  end;

{------------------------------------------------------------------}

procedure SetFormFont(Form: TCustomForm);
begin
  if UseOneFont and TMControl(Form).ParentFont and Assigned(Application.MainForm) then
    Form.Font := Application.MainForm.Font;
end;

{------------------------------------------------------------------}

procedure RemoveExtraMenuSeparators(MenuItem: TMenuItem);
var
  A: Integer;
begin
  with MenuItem do
    if Count > 0 then
    begin
      // Remove all separators from menu top
      while (Count > 0) and (Items[0].Caption = '-') do
        Items[0].Free;

      // Remove all separators from menu bottom
      while (Count > 0) and (Items[Count - 1].Caption = '-') do
        Items[Count - 1].Free;

      // Remove double separators
      a := Count - 2;
      while a >= 0 do
      begin
        if (Items[a].Caption = '-') and (Items[a + 1].Caption = '-') then
          Items[a].Free;
        dec(a);
      end;
    end;
end;

{--------------------------------------------}

procedure ClearMenuSubItems(MenuItem: TMenuItem; DisableItem: boolean);
begin
  if MenuItem = nil then
    exit;
  with MenuItem do
  begin
    while Count > 0 do
      Items[0].Free;
    MenuItem.Enabled := not DisableItem;
  end;
end;

{$IFNDEF CLX}

{------------------------------------------------------------------}

function QueryDirectory(const ATitle: string; var ADirectory: string): boolean;
begin
  {$IFDEF SHELLOBJ}
  result := QueryDir(ATitle, ADirectory, Application.Handle);
  {$ELSE}
  result := SelectDirectory(ADirectory, [], 0);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function GetDesigner(Instance: TPersistent): TDesigner;
var
  f: TCustomForm;
begin
  if Assigned(GetDesignerProc) then
    result := GetDesignerProc(Instance)
  else
  begin
    f := GetPForm(Instance);
    if f <> nil then
      result := f.Designer
    else
      result := nil;
  end;
end;

{--------------------------------------------}

procedure DesignerModified(c: TPersistent);
var
  Designer: TDesigner;
begin
  Designer := GetDesigner(c);
  if Designer <> nil then
    Designer.Modified;
end;

{--------------------------------------------}

procedure DesignerSelectComponent(c: TComponent);
begin

end;

{--------------------------------------------}

procedure UpdateEditors(Control: TWinControl);
var
  i: integer;
begin
  with Control do
    for i := 0 to ControlCount - 1 do
      Controls[I].Perform(CM_UPDATEEDITORS, 0, 0);
end;

{--------------------------------------------}

procedure ChangeTab(TabControl: TTabControl; ANext: boolean);
var
  i: integer;
  TabCount: integer;
begin
  with TabControl do
  begin
    TabCount := Tabs.Count;
    i := TabIndex;
    if ANext then
    begin
      inc(i);
      if i >= TabCount then
        i := 0;
    end
    else
    begin
      dec(i);
      if i < 0 then
        i := TabCount - 1;
    end;

    TabIndex := i;
  end;
end;

{------------------------------------------------------------------}

procedure AddNewTab(TabControl: TTabControl; const TabCaption: string);
var
  i: Integer;
begin
  with TabControl, Tabs do
  begin
    for i := 0 to Count - 1 do
      if CompareText(TabCaption, Strings[i]) = 0 then
      begin
        TabIndex := i;
        exit;
      end;
    TabIndex := Add(TabCaption);
  end;
end;

{--------------------------------------------}

function GlobalFindObject(const FullName: string): TComponent;
var
  i: Integer;
  FormName, CompName: string;
  ownercomp: TComponent;
begin
  Result := nil;
  FormName := ChangeFileExt(FullName, '');
  CompName := RemoveCharSet(['.'], ExtractFileExt(FullName));

  for I := 0 to ScreenFormCount - 1 do
  begin
    ownercomp := ScreenForms(i);
    if CompareText(FullName, ownercomp.Name) = 0 then
    begin
      result := ownercomp;
      exit;
    end
    else if CompareText(FormName, ownercomp.Name) = 0 then
    begin
      Result := ownercomp.FindComponent(CompName);
      exit;
    end;
  end;

  with Screen do
    for i := 0 to DataModuleCount - 1 do
    begin
      ownercomp := DataModules[i];
      if CompareText(FullName, ownercomp.Name) = 0 then
      begin
        result := ownercomp;
        exit;
      end
      else if CompareText(ownercomp.Name, FormName) = 0 then
      begin
        result := ownercomp.FindComponent(CompName);
        exit;
      end;
    end;
end;

{--------------------------------------------}

function GetFormResourceHandler(AClass: TClass): THandle;
var
  s: string;
begin
  S := AClass.ClassName;
  Result := FindResource(GetClassModule(AClass), PChar(S), RT_RCDATA);
end;

{------------------------------------------------------------------}

function FindFormWithClass(C: TClass): TCustomForm;
var
  i: Integer;
begin
  for i := 0 to ScreenFormCount - 1 do
    if ScreenForms(i).InheritsFrom(C) then
    begin
      Result := ScreenForms(i);
      exit;
    end;
  Result := nil;
end;

{--------------------------------------------}

function FormIsActive(F: TCustomForm): boolean;
var
  i: Integer;

  function FormIsOk(QueryForm: TCustomForm): boolean;
  var
    M: TMessage;
  begin
    M.Msg := cm_ToolBarForm;
    M.Result := 0;
    QueryForm.Dispatch(M);
    Result := M.Result = 0;
  end;

begin
  result := (f <> nil) and F.HandleAllocated and IsWindowVisible(F.Handle);
  if not result then
    exit;

  for i := 0 to ScreenFormCount - 1 do
    with ScreenForms(i) do
      if HandleAllocated and
        IsWindowVisible(Handle) and
        ((ScreenForms(i) = F) or
        ((ScreenForms(i) <> Application.MainForm) and (ScreenForms(i) <> FMainForm) and
        FormIsOk(ScreenForms(i)))) then
      begin
        result := ScreenForms(i) = f;
        exit;
      end;

  Result := False;
end;

{--------------------------------------------}

function FindOrCreateFormWithClass(C: TCustomFormClass; Owner: TComponent): TCustomForm;
begin
  result := FindFormWithClass(C);
  if result = nil then
    result := C.Create(Owner);
end;

{--------------------------------------------}

procedure JumpToURL(const s: string);
begin
  ShellExecute(0, nil, PChar(s), nil, nil, SW_SHOW);
end;
{------------------------------------------------------------------}

procedure WriteToUs;
begin
  JumpToURL(WriteToUsURL);
end;

{------------------------------------------------------------------}

procedure HomePage;
begin
  JumpToURL(CompanyURL);
end;

{------------------------------------------------------------------}

procedure OnlineRegistration;
begin
  JumpToURL(RegistrationURL);
end;

{--------------------------------------------}

const
  SWinPosKeyName = 'WinPos'; //don't resource
  SWindowStateKeyName = 'WindowState'; //don't resource

procedure ReadWinPosFromReg(C: TWinControl; const S: string);
var
  KeyStr: string;
  WindowPlacement: TWindowPlacement;
begin
  if c = nil then
    exit;

  KeyStr := SFormRegPrefix + S + '\';
  if ReadBufFromRegistry(KeyStr + SWinPosKeyName, WindowPlacement,
    Sizeof(WindowPlacement)) = 0 then
    exit;

  with WindowPlacement do
  begin
    with rcNormalPosition do
      c.SetBounds(left, top, right - left, bottom - top);

    if c is TCustomForm then
      TCustomForm(c).WindowState := TWindowState(
        ReadFromRegistry(KeyStr + SWindowStateKeyName, Integer(wsnormal)));

  end;
end;

{------------------------------------------------------------------}

procedure ReadWinPosFromIni(C: TWinControl; const S, AFileName, ASection: string);
var
  WindowPlacement: TWindowPlacement;
  AKey: string;
begin
  if c = nil then
    exit;

  with TIniFile.Create(AFileName) do
  try
    AKey := ASection + SWinPosKeyName;
    WindowPlacement.rcNormalPosition := c.BoundsRect;
    with WindowPlacement.rcNormalPosition do
    begin
      Right{used as Width} := ReadInteger(AKey, 'Width', Right - Left);
      Bottom{used as Height} := ReadInteger(AKey, 'Height', Bottom - Top);
      Left := ReadInteger(AKey, 'Left', Left);
      Top := ReadInteger(AKey, 'Top', Top);
      c.SetBounds(left, top, right, bottom);
    end;
    if c is TCustomForm then
      TCustomForm(c).WindowState := TWindowState(
        ReadInteger(AKey, 'WindowState', Integer(TCustomForm(c).WindowState)));
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

procedure WriteWinPosToReg(C: TWinControl; const S: string);
var
  KeyStr: string;
  WindowPlacement: TWindowPlacement;
begin
  if c = nil then
    exit;

  KeyStr := SFormRegPrefix + S + '\';
  if C.HandleAllocated then
  begin
    WindowPlacement.Length := SizeOf(WindowPlacement);
    GetWindowPlacement(C.Handle, @WindowPlacement);
    WriteBufToRegistry(KeyStr + SWinPosKeyName, WindowPlacement, Sizeof(WindowPlacement));

    if c is TCustomForm then
      WriteToRegistry(KeyStr + SWindowStateKeyName, Integer(TCustomForm(c).WindowState));
  end;
end;

{------------------------------------------------------------------}

procedure WriteWinPosToIni(C: TWinControl; const S, AFileName, ASection: string);
var
  WindowPlacement: TWindowPlacement;
  AKey: string;
begin
  if c = nil then
    exit;

  if C.HandleAllocated then
  begin
    WindowPlacement.Length := SizeOf(WindowPlacement);
    GetWindowPlacement(C.Handle, @WindowPlacement);
    with TIniFile.Create(AFileName) do
    try
      AKey := ASection + SWinPosKeyName;
      with WindowPlacement.rcNormalPosition do
      begin
        WriteInteger(AKey, 'Left', Left);
        WriteInteger(AKey, 'Top', Top);
        WriteInteger(AKey, 'Width', Right - Left);
        WriteInteger(AKey, 'Height', Bottom - Top);
      end;
      if c is TCustomForm then
        WriteInteger(AKey, 'WindowState', Integer(TCustomForm(c).WindowState));
    finally
      Free;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure CalcEditorMinMaxInfo(var Message: TMessage; Form: TCustomForm; MaxToFullScreen: Boolean);
const
  MinWindowSizeX = 320;
  MinWindowSizeY = 240;
var
  BorderSizeX: Integer;
  BorderSizeY: Integer;
  FormBottom: Integer;
  DesktopRect: TRect;
  DesktopWidth: Integer;
  DesktopHeight: Integer;
begin
  BorderSizeX := GetSystemMetrics(SM_CXSIZEFRAME);
  BorderSizeY := GetSystemMetrics(SM_CYSIZEFRAME);
  SystemParametersInfo(spi_GetWorkArea, 0, @DesktopRect, 0);
  DesktopWidth := DesktopRect.Right - DesktopRect.Left;
  DesktopHeight := DesktopRect.Bottom - DesktopRect.Top;

  with PMinMaxInfo(Message.lParam)^ do
  begin
    if Form <> nil then
    begin
      ptMaxPosition.X := DesktopRect.Left - BorderSizeX;
      FormBottom := Form.Top + Form.Height;
      if (Form.Top < DesktopHeight - FormBottom) and
        not MaxToFullScreen then
      begin
        ptMaxPosition.y := FormBottom;
        ptMaxSize.y := DesktopHeight + BorderSizeY - FormBottom;
      end
      else
      begin
        ptMaxPosition.Y := DesktopRect.Top - BorderSizeY;
        ptMaxSize.X := DesktopWidth + BorderSizeX * 2;
        ptMaxSize.Y := DesktopHeight + BorderSizeY * 2;
      end;
    end;
    ptMinTrackSize.x := MinWindowSizeX;
    ptMinTrackSize.y := MinWindowSizeY;
  end;
  Message.Result := 0;
end;

{--------------------------------------------}

procedure UpdateParamsWithBorderStyle(var Params: TCreateParams; BorderStyle: TBorderStyle; Ctl3d: boolean);
begin
  with Params do
    if BorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
end;

{--------------------------------------------}

function GetScrollPosEx(Wnd: THandle; fnBar: Integer): Integer;
var
  ScrollInfo: TScrollInfo;
begin
  FillChar(ScrollInfo, SizeOf(ScrollInfo), 0);
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
  ScrollInfo.fMask := SIF_TRACKPOS;
  GetScrollInfo(Wnd, fnBar, ScrollInfo);
  Result := ScrollInfo.nTrackPos;
end;

{------------------------------------------------------------------}
{$ENDIF}
{$ENDIF}

function IsEmailString(const s: string): boolean;
var
  firstpos: integer;
  lastpos: integer;
  pointpos: integer;
  len: integer;
begin
  if s = '' then
  begin
    result := false;
    exit;
  end;

  result := StrLIComp(sUrlMailTo, Pointer(s), length(sUrlMailTo)) = 0;

  if not result then
  begin
    len := length(s);
    firstpos := Pos('@', s);
    lastpos := BackPosEx('@', s, len);
    pointpos := BackPosEx('.', s, len);
    result := (firstpos <> 0) and (firstpos = lastpos) and (pointpos > firstpos) and
      (firstpos <> len) and (s[firstpos + 1] in cOtherIdentChars);
  end;
end;

{------------------------------------------------------------------}

function IsWWWString(const s: string): boolean;
begin
  if s = '' then
  begin
    result := false;
    exit;
  end;
  result := (StrLIComp(sUrlWWW, Pointer(s), length(sUrlWWW)) = 0) or
    (StrLIComp(sUrlHttp, Pointer(s), length(sUrlHttp)) = 0) or
    (StrLIComp(SUrlGopher, Pointer(s), length(SUrlGopher)) = 0) or
    (StrLIComp(SUrlFtp, Pointer(s), length(SUrlFtp)) = 0);
end;

{------------------------------------------------------------------}

function IsStringHot(const s: string): boolean;
begin
  result := IsWWWString(s) or IsEMailString(s);
  if not result and Assigned(OnHotString) then
    result := OnHotString(s);
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

procedure _SetScrollPos(W: HWND; Code: Integer; Value: Integer);
begin
  if GetScrollPos(W, Code) <> Value then
    SetScrollPos(W, Code, Value, True);
end;

{-------------------------------------------------------------------------}

procedure _SetScrollSize(W: HWND; Code, MinPos, MaxPos, PageSize: Integer);
var
  T: TScrollInfo;
begin
  with T do
  begin
    cbSize := SizeOf(T);
    fMask := SIF_PAGE or SIF_RANGE;
    nMin := MinPos;
    nMax := MaxPos;
    nPage := PageSize;
    nPos := 0;
    nTrackPos := 0;
  end;
  SetScrollInfo(W, Code, T, True);
end;
{$ENDIF CLX}
{------------------------------------------------------------------}

{$IFDEF WIN}

function GetMaxFontWidth(Font: TFont): Integer;
{$IFDEF CLX}
var
  Handle: QFontMetricsH;
  {$ENDIF}
begin
  {$IFNDEF CLX}
  Result := GetFontMetrics(Font).tmMaxCharWidth;
  {$ELSE}
  Handle := QFontMetrics_create(Font.Handle);
  result := QFontMetrics_maxWidth(Handle);
  QFontMetrics_Destroy(Handle);
  {$ENDIF}
end;

{-------------------------------------------------------------------------}
const
  CheckString: string = 'Wg'; //don't resource
  CheckMinString: string = 'x'; //don't resource

function GetAveFontWidth(Font: TFont): integer;
{$IFDEF CLX}
var
  Handle: QFontMetricsH;
  {$ENDIF}
begin
  {$IFNDEF CLX}
  Result := GetFontMetrics(Font).tmAveCharWidth;
  {$ELSE}
  Handle := QFontMetrics_create(Font.Handle);
  result := QFontMetrics_width(Handle, @CheckMinString, length(CheckMinString));
  QFontMetrics_destroy(Handle);
  {$ENDIF}
end;

{-------------------------------------------------------------------------}
{$IFNDEF CLX}

function GetMaxFontHeight(Font: TFont): Integer;
var
  dc: THandle;
  oldf: THandle;
  Size: TSize;
begin

  dc := GetDC(0);
  oldf := SelectObject(dc, Font.Handle);
  try
    Size.cX := 0;
    Size.cY := 0;
    Windows.GetTextExtentPoint32(DC, PChar(CheckString), Length(CheckString), Size);
    result := Size.cY;
  finally
    SelectObject(dc, oldf);
    ReleaseDC(0, dc);
  end;
end;
{-------------------------------------------------------------------------}
{$ELSE}

function GetMaxFontHeight(Font: TFont): Integer;
var
  Handle: QFontMetricsH;
  Size: TSize;
begin
  Handle := QFontMetrics_create(Font.Handle);
  result := QFontMetrics_height(Handle);
  QFontMetrics_size(Handle, @Size, 0, @CheckString, Length(CheckString), 0, nil, nil);
  QFontMetrics_destroy(Handle);
  result := Size.cY;
  {
    Handle := QFontMetrics_create(Font.Handle);
    result := QFontMetrics_height(Handle);
    QFontMetrics_destroy(Handle);
    }
end;

{-------------------------------------------------------------------------}
{$ENDIF}

{$IFNDEF CLX}

function GetMinFontHeight(Font: TFont): Integer;
var
  dc: THandle;
  oldf: THandle;
  Size: TSize;
begin

  dc := GetDC(0);
  oldf := SelectObject(dc, Font.Handle);
  try
    Size.cX := 0;
    Size.cY := 0;
    Windows.GetTextExtentPoint32(DC, PChar(CheckMinString), Length(CheckMinString), Size);
    result := Size.cY;
  finally
    SelectObject(dc, oldf);
    ReleaseDC(0, dc);
  end;
end;
{$ELSE}

function GetMinFontHeight(Font: TFont): Integer;
var
  Handle: QFontMetricsH;
  Size: TSize;
begin
  Handle := QFontMetrics_create(Font.Handle);
  result := QFontMetrics_height(Handle);
  QFontMetrics_size(Handle, @Size, 0, @CheckMinString, Length(CheckMinString), 0, nil, nil);
  QFontMetrics_destroy(Handle);
end;
{$ENDIF}
{-------------------------------------------------------------------------}

{$IFNDEF CLX}

function GetFontMetrics(Font: TFont): TTextMetric;
var
  dc: THandle;
  oldf: THandle;
begin
  dc := GetDC(0);
  oldf := SelectObject(dc, Font.Handle);
  try
    GetTextMetrics(dc, result);
  finally
    SelectObject(dc, oldf);
    ReleaseDC(0, dc);
  end;
end;
{$ENDIF}

function IsFontMonoSpaced(Font: TFont): boolean;
begin
  {$IFNDEF CLX}
  result := (GetFontMetrics(Font).tmPitchAndFamily and TMPF_FIXED_PITCH) = 0;
  {$ELSE}
  result := true;
  {$ENDIF}
end;

{---------TDCCustomControl----------------------}

procedure TDCCustomControl.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FKeyWasFound := false;
end;

{----------------------------------------------------}

procedure TDCCustomControl.KeyPress(var Key: Char);
begin
  inherited;
  {
  if FKeyWasFound then
  begin
    FKeyWasFound := false;
    exit;
  end;
  }
  if (csDesigning in ComponentState) or (KeyState <> 0) then
    exit;

  {$IFNDEF CLX}
  if OemConvert then
    CharToOEM(@Key, @Key);
  {$ENDIF}

  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
  begin
    if (fImeCount > 0) then
      Dec(fImeCount);
    if fImeCount = 0 then
    begin
      if FImeStr <> '' then
      begin
        if InsertString(FImeStr) then
          Key := #0;
        FImeStr := '';
        exit;
      end
      else if Key in LeadBytes then
        Key := '?'
    end
    else
      exit;
  end;
  {$ENDIF}
  if InsertChar(Char(Key)) then
    Key := #0;
end;

{-------------------------------------------------------------}
{$IFNDEF CLX}

procedure TDCCustomControl.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  with Msg do
  begin
    Result := DLGC_WANTMESSAGE or
      DLGC_WANTALLKEYS or
      DLGC_WANTARROWS or
      DLGC_WANTCHARS;

    if FWantTabs then Result := Result or DLGC_WANTTAB;
    if not FWantReturns then
      Result := Result and not DLGC_WANTALLKEYS;
  end;
end;

{-------------------------------------------------------------}

procedure TDCCustomControl.CNSysKeyDown(var Message: TWMKeyDown);
begin
  with Message do
  begin
    KeyDown(CharCode, KeysToShift);
    if CharCode = 0 then
      Result := 1
    else
      inherited;
  end;
end;

{-------------------------------------------------------------}

procedure TDCCustomControl.CNKeyDown(var Message: TWMKeyDown);
begin
  if KeyState = 0 then
    inherited
  else
    with Message do
    begin
      KeyDown(CharCode, KeysToShift);
      if CharCode = 0 then
        Result := 1
      else
        inherited;
    end;
end;

{$ENDIF}

{-------------------------------------------------------------}

{$IFDEF DCMBCS}

procedure TDCCustomControl.WMImeComposition(var Msg: TMessage);
var
  imc: HIMC;
begin
  if ((Msg.LParam and GCS_RESULTSTR) <> 0) then
  begin
    imc := ImmGetContext(Handle);
    try
      fImeCount := ImmGetCompositionString(imc, GCS_RESULTSTR, nil, 0);
      SetLength(FImeStr, fImeCount);
      if fImeCount <> 0 then
        ImmGetCompositionString(imc, GCS_RESULTSTR, Pchar(FImeStr), fImeCount);

    finally
      ImmReleaseContext(Handle, imc);
    end;
  end;
  inherited;
end;

{-------------------------------------------------------------}

function TDCCustomControl.InsertString(const s: string): boolean;
begin
  result := false;
end;

{$ENDIF}

function TDCCustomControl.InsertChar(Ch: Char): Boolean;
begin
  result := false;
end;

{-------------------------------------------------------------}

procedure TDCCustomControl.ClearKeys;
begin
  FKeys.Clear;
end;

{-------------------------------------------------------------}

procedure TDCCustomControl.UpdateKeyMapping;
begin
  ClearKeys;
  if Assigned(FKeyBoardInit) then
    FKeyboardInit(Self)
  else
    InitDefaultKeyMapping;
end;

{-------------------------------------------------------------}

procedure TDCCustomControl.SetKeyMapping(const V: string);
begin
  if FKeyMapping <> V then
  begin
    FKeyMapping := V;
    FKeyboardInit := GetKeyboardInitProc(Self.ClassType, V);
    UpdateKeyMapping;
  end;
end;

{-------------------------------------------------------------}

constructor TDCCustomControl.Create(AOwner: TComponent);
begin
  inherited;
  WantReturns := True;
  FKeys := TKeyList.Create;
  KeyMapping := ResStr(SDefault);
end;

{-------------------------------------------------------------}

destructor TDCCustomControl.Destroy;
begin
  FKeys.Free;
  inherited;
end;

{-------------------------------------------------------------}

procedure TDCCustomControl.KeyDown(var Key: Word; Shift: TShiftState);
var
  ResultKeyData: TKeyData;
begin
  inherited;
  FKeyWasFound := false;
  if ((Key = VK_RETURN) and not FWantReturns) or ((Key = VK_TAB) and not FWantTabs) then
  begin
    if ssCtrl in Shift then
      Shift := []
    else
      exit;
  end;

  if (Key = 0) or (csDesigning in ComponentState) then
    exit;

  {  If FKeyState=-2 then
      FKeyState:=0;}
  ResultKeyData := FKeys.FindKeyData(Key, Shift, FKeyState);
  if ResultKeyData <> nil then
    with ResultKeyData do
    begin
      with TMethod(ActionCode) do
        if Code <> nil then
          CallMethod(Data, Code);
      Key := 0;
      FkeyState := LeaveState;
      FKeyWasFound := true;
      {        If FKeyState=0 then
                FKeyState:=-2;}
      exit;
    end;
  FKeyState := 0;
end;
{$ENDIF}

{--------TPropFileSystem----------------------------------------------}

function TPropFileSystem.GetFileStream(const FileName: TFileName; Mode: Integer): TStream;
begin
  if fComponent = nil then
    Error('Component doesn''t exist'); // !!!!!!!
  result := TPropStream.Create(fComponent, FPropName, Mode);
end;

{------------------------------------------------------------------}

function TPropFileSystem.GetFileSystemLevel: TFileSystemLevel;
begin
  Result := flOnlyGetStream;
end;

{------------------------------------------------------------------}

procedure TPropFileSystem.SetComponent(val: TComponent);
begin
  if val <> fcomponent then
  begin
    {$IFDEF D5}
    if fComponent <> nil then
      fComponent.RemoveFreeNotification(self);
    {$ENDIF}
    fComponent := val;
    fComponent.FreeNotification(self);
  end;
end;

{------------------------------------------------------------------}

procedure TPropFileSystem.SetComponentPtr(const val: string);
begin
  Component := TComponent(StrToInt(val));
end;

{------------------------------------------------------------------}

function TPropFileSystem.GetComponentPtr: string;
begin
  result := '$' + IntToHex(integer(fComponent), 8);
end;

{------------------------------------------------------------------}

function TPropFileSystem.FileExists(const FileName: TFileName): Boolean;
var
  PropInfo: PPropInfo;
  TypeInfo: PTypeInfo;
begin
  result := (fComponent <> nil) and (fPropName <> '');

  if not result then
    exit;

  PropInfo := GetPropInfo(fComponent.ClassInfo, FPropName);
  TypeInfo := GetPTypeInfo(PropInfo);
  Result := TypeInfo <> nil;
  if not Result then
    exit;

  Result := ((TypeInfo.Kind = tkClass) and (TObject(GetOrdProp(fComponent, PropInfo)) is TStrings))
    or (TypeInfo.Kind in StringTypes);
end;

{------------------------------------------------------------------}

procedure TPropFileSystem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FComponent) then
  begin
    Component := nil;
    ReleaseFileSystem(Self);
  end;
end;

{-------------------------------------------------------------------------}

function TPropStream.GetPropValue: string;
begin
  UpdatePropInfo;
  if FStrings <> nil then
    Result := FStrings.Text
  else
    Result := GetStrProp(FInstance, FPropInfo);
end;

{------------------------------------------------------------------}

constructor TPropStream.Create(Instance: TPersistent; const PropName: string; Mode: Integer);
var
  PropVal: string;
begin
  inherited Create;
  FInstance := Instance;
  FPropName := PropName;
  FMode := Mode and 3;
  if (FMode = fmOpenRead) or (FMode = fmOpenReadWrite) then
  begin
    PropVal := GetPropValue;
    WriteBuffer(PropVal[1], Length(PropVal));
    Seek(0, SoFromBeginning);
  end;
end;

{------------------------------------------------------------------}

destructor TPropStream.Destroy;
var
  PropVal: string;
begin
  if FMode <> fmOpenRead then
  begin
    SetLength(PropVal, Size);
    Seek(0, soFromBeginning);
    ReadBuffer(PropVal[1], Size);
    SetPropValue(PropVal);
  end;
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TPropStream.SetPropValue(const S: string);
begin
  UpdatePropInfo;
  if FStrings <> nil then
    FStrings.Text := S
  else
    SetStrProp(FInstance, FPropInfo, S);
  {$IFNDEF CLX}
  DesignerModified(FInstance);
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TPropStream.BadPropInfo;
begin
  raise Exception.Create(SErrBadPropStream);
end;

{------------------------------------------------------------------}

procedure TPropStream.UpdatePropInfo;
var
  FObject: TObject;
  TypeInfo: PTypeInfo;
begin
  if (FInstance = nil) or (FPropName = '') then
    BadPropInfo;

  FPropInfo := GetPropInfo(FInstance.ClassInfo, FPropName);
  TypeInfo := GetPTypeInfo(FPropInfo);

  if (FPropInfo = nil) or (TypeInfo = nil) then
    BadPropInfo;

  if TypeInfo.Kind = tkClass then
  begin
    FObject := TObject(GetOrdProp(FInstance, FPropInfo));
    if FObject is TStrings then
      FStrings := TStrings(FObject)
    else
      BadPropInfo;
  end
  else if TypeInfo.Kind in StringTypes then
    FStrings := nil
  else
    BadPropInfo;
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}

{----------------THandleObject-------------------------------------}
var
  ClipWndClass: TWndClass = (
    style: CS_DBLCLKS;
    lpfnWndProc: @DefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'ClipboardClass'); //don't resource

  {------------------------------------------------------------------}

constructor THandleObject.Create(WndProc: TWndMethod);
var
  TempClass: TWndClass;
  ClassRegistered: Boolean;
begin
  inherited Create;
  ClipWndClass.hInstance := HInstance;
  ClassRegistered := GetClassInfo(HInstance, ClipWndClass.lpszClassName, TempClass);
  if not ClassRegistered then
    Windows.RegisterClass(ClipWndClass);
  FWnd := CreateWindowEx(WS_EX_TOPMOST, ClipWndClass.lpszClassName,
    '', WS_POPUP, 0, 0, 1, 1, 0, 0, HInstance, nil);
  SetWindowLong(FWnd, GWL_WNDPROC, Longint({$IFDEF D6}Classes.MakeObjectInstance(WndProc){$ELSE}MakeObjectInstance(WndProc){$ENDIF}));
  SetWindowLong(FWnd, GWL_STYLE, WS_CHILD);
end;

{------------------------------------------------------------------}

destructor THandleObject.Destroy;
begin
  {$IFDEF D6}
  Classes.DeallocateHWnd(FWnd);
  {$ELSE}
  DeallocateHWnd(FWnd);
  {$ENDIF}
  inherited Destroy;
end;

{******************************************************************}

procedure TDCHandleObject.PostMsg(Msg, wParam, lParam: integer);
begin
  PostMessage(Handle, Msg, wParam, lParam);
end;

{------------------------------------------------------------------}

procedure TDCHandleObject.WndProc(var Msg: TMessage);
begin
  if fObject <> nil then
    fObject.Dispatch(Msg);
end;

{------------------------------------------------------------------}

constructor TDCHandleObject.Create(AObject: TObject);
begin
  fObject := AObject;
  inherited Create(WndProc);
end;

{------------------------------------------------------------------}

procedure SetMenuItemParams(Comp: TComponent; VerbItem: TverbListItem);
begin
  with TMenuItem(Comp), VerbItem do
  begin
    if Visible <> (vsVisible in VerbStates) then
      Visible := vsVisible in VerbStates;
    Enabled := vsEnabled in VerbStates;
    Checked := vsChecked in VerbStates;
    if ClearHandler then
      OnClick := nil
    else
      OnClick := VerbOnClick;
  end;
end;

{-------------------------------------------------------------------------}

procedure SetButtonParams(Comp: TComponent; VerbItem: TVerbListItem);
begin
  with TButton(Comp), VerbItem do
  begin
    Visible := vsVisible in VerbStates;
    Enabled := vsEnabled in VerbStates;
    if ClearHandler then
      OnClick := nil
    else
      OnClick := VerbOnClick;
  end;
end;

{-------------------------------------------------------------------------}

procedure SetSpeedButtonParams(Comp: TComponent; VerbItem: TVerbListItem);
begin
  with TSpeedButton(Comp), VerbItem do
  begin
    Visible := vsVisible in VerbStates;
    Enabled := vsEnabled in VerbStates;
    if ClearHandler then
      OnClick := nil
    else
      OnClick := VerbOnClick;
  end;
end;

{------------------------------------------------------------------}

procedure ChangeImageList(Image: TCustomImageList; Bitmap: TBitmap; trColor: TColor; index: integer);
var
  bmp: TBitmap;
  {$IFNDEF D3}
  oldbkcolor: longint;
  {$ENDIF}
begin
  Bmp := TBitmap.Create;
  try
    {$IFDEF D3}
    bmp.Assign(Bitmap);
    bmp.TransparentColor := trColor;
    ImageList_Replace(Image.Handle, Index, Bitmap.Handle, bmp.MaskHandle);
    {$ELSE}
    with Bitmap do
    begin
      Bmp.Monochrome := True;
      Bmp.Width := Width;
      Bmp.Height := Height;
      oldbkcolor := SetBkColor(Canvas.Handle, ColorToRgb(trcolor));
      Bmp.Canvas.Draw(0, 0, Bitmap);
      SetBkColor(Canvas.Handle, oldbkcolor);
      Image.Replace(Index, Bitmap, Bmp);
    end;
    {$ENDIF}
  finally
    bmp.Free;
  end;
end;

var
  RegisterAssignVerbProcsCalled: boolean = false;

procedure RegisterAssignVerbProcs;
begin
  if not RegisterAssignVerbProcsCalled then
  begin
    RegisterAssignVerbProcsCalled := true;
    RegisterAssignVerbProc(TMenuItem, SetMenuItemParams);
    RegisterAssignVerbProc(TSpeedButton, SetSpeedButtonParams);
    RegisterAssignVerbProc(TButton, SetButtonParams);
  end
end;

{---------TVerbDispatcher------------------------------------}

procedure TVerbDispatcher.CMPACKAGELOADED(var Message: TMessage);
begin
  UpdateVerbObjects(-1);
end;

{-------------------------------------------------------------}

procedure TVerbDispatcher.UpdateVerbObjects(Group: Integer);
var
  i: Integer;
begin
  //  SendDebug(IntToStr(Group));
  for i := 0 to FVerbList.Count - 1 do
    with TVerbListItem(FVerbList.Items[i]) do
      if (Group < 0) or (FDesignGroup = Group) then
      begin
        //        SendDebug(VerbName);
        UpdateVerbObject;
      end;
end;

{-------------------------------------------------------------}

procedure TVerbDispatcher.CMFREEEDITGROUP(var Message: TMessage);
begin
  UpdateVerbObjects(Message.wParam);
end;

{-------------------------------------------------------------}

procedure TVerbDispatcher.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: Integer;
begin
  inherited;
  if (Operation = opRemove) and (FVerbList <> nil) then
    with FVerbList do
      for i := Count - 1 downto 0 do
        with Items[i] do
          if VerbComp = AComponent then
            VerbComp := nil;
end;

{-------------------------------------------------------------}

procedure TVerbDispatcher.CMPROPCHANGED(var Message: TMessage);
begin
  UpdateControls;
end;

{-------------------------------------------------------------}

procedure TVerbDispatcher.CMIDECHANGED(var Message: TMessage);
begin
  UpdateControls;
end;

{-------------------------------------------------------------}

procedure TVerbDispatcher.UpdateControls;
var
  i: Integer;
begin
  if (IDEUpdateCount > 0) or ([csDesigning, csLoading, csDestroying, csReading] * ComponentState <> []) then
    exit;
  for i := 0 to FVerbList.Count - 1 do
    TVerbListItem(FVerbList.Items[i]).UpdateControl;
end;

{-------------------------------------------------------------}

procedure TVerbDispatcher.SetVerbList(Value: TVerbList);
begin
  FVerbList.Assign(Value);
end;

{-------------------------------------------------------------}

constructor TVerbDispatcher.Create(AOwner: TComponent);
begin
  inherited;
  RegisterAssignVerbProcs;
  FVerbList := TVerbList.Create(self, TVerbListItem);
  RegisterNotifier(Self);
  InitIDENotifier;
end;

{-------------------------------------------------------------}

destructor TVerbDispatcher.Destroy;
begin
  UnRegisterNotifier(Self);
  FreeObject(FVerbList,FVerbList); //must be FreeObject not .Free
  inherited;
end;

{--------TVerbList--------------------------------------------}

function TVerbList.GetItem(Index: Integer): TVerbListItem;
begin
  Result := TVerbListItem(inherited Items[Index]);
end;

{-------------------------------------------------------------}

procedure TVerbList.SetItem(Index: Integer; V: TVerbListItem);
begin
  inherited Items[Index] := V;
end;

{---------TVerbListItem---------------------------------------}

procedure TVerbListItem.SetVerbName(const Value: string);
begin
  if FVerbName <> Value then
  begin
    FVerbName := Trim(Value);
    UpdateVerbObject;
  end;
end;

{---------------------------------------------------------------}

procedure RegisterAssignVerbProc(CompClass: TComponentClass; AssignVerbProc: TAssignVerbProc);
begin
  RegisterClassExt(CompClass, [SAssignIdent, SAssignVerbProc], ['', Integer(@AssignVerbProc)]);
end;

{-------------------------------------------------------------------------}

{$IFDEF D3}

function TVerbListItem.GetDisplayName: string;
begin
  if VerbComp <> nil then
    Result := VerbComp.Name + ' - '
  else
    Result := '';
  Result := Result + VerbName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;
{$ENDIF}

{-------------------------------------------------------------------------}

function TVerbListItem.OwnerObject: TPersistent;
begin
  Result := TVerbList(Collection).Owner;
end;

{-------------------------------------------------------------------------}

procedure TVerbListItem.UpdateVerbObject;
var
  Item, Item1: TObjectParamListItem;
begin
  if (OwnerObject is TComponent) and (csDesigning in TComponent(OwnerObject).ComponentState) then
    exit;
  FVerbGetState := nil;
  FVerbExecute := nil;
  FAssignProc := nil;
  if (VerbName = '') or (VerbComp = nil) then
    exit;
  Item1 := GetItemInherited(VerbComp.ClassType, [SAssignIdent], [''], []);
  Item := GetVerbProcAddr(FVerbName, FVerbGetState, FVerbExecute);
  if (Item1 <> nil) and (Item <> nil) then
  begin
    FDesignGroup := Item.EditorGroup;
    //    SendDebug(IntToStr(FDesignGroup)+' '+ FVerbName );
    FAssignProc := TAssignVerbProc(Integer(Item1.Params[SAssignVerbProc]));
    UpdateControl;
  end;
end;

{-------------------------------------------------------------------------}

destructor TVerbListItem.Destroy;
begin
  FVerbStates := [];
  FClearHandler := True;
  if (VerbComp <> nil) and not (csDestroying in VerbComp.ComponentState) then
    UpdateControl;
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TVerbListItem.UpdateControl;
var
  FNewStates: TVerbStates;

  procedure InternalUpdate;
  begin
    if (FNewStates <> FVerbStates) then
    begin
      FVerbStates := FNewStates;
      FAssignProc(VerbComp, Self);
    end;
  end;

begin
  if not Assigned(FAssignProc) then
    exit;
  FNewStates := [vsVisible, vsEnabled];
  if Assigned(FVerbGetState) then
    FVerbGetState(FNewStates);
  InternalUpdate;
end;

{-------------------------------------------------------------------------}

procedure TVerbListItem.VerbOnClick(Sender: TObject);
begin
  if Assigned(FverbExecute) then
  begin
    IDEBeginUpdate;
    try
      FVerbExecute;
    finally
      IDEEndUpdate;
    end;
  end;
end;

{-------------------------------------------------------------------------}

procedure TVerbListItem.SetVerbComp(Value: TComponent);
begin
  if FVerbComp <> Value then
  begin
    FVerbComp := Value;
    if (Value <> nil) and (OwnerObject is TComponent) then
      Value.FreeNotification(TComponent(OwnerObject));
    UpdateVerbObject;
  end;
end;

function DropFiles(const Dirs, Multiselect: boolean; DelimiterChar: char;
  var Message: TWMDropFiles): string;
var
  AFileName: array[0..255] of Char;
  FName: string;
  Tempstr: string;
  i: integer;
  Num: integer;
begin
  Message.Result := 0;
  result := '';
  try
    Num := DragQueryFile(Message.Drop, $FFFFFFFF, nil, 0);
    if Num > 0 then
    begin
      for i := 0 to Num - 1 do
      begin
        DragQueryFile(Message.Drop, i, PChar(@AFileName), SizeOf(AFileName) - 1);
        FName := StrPAs(AFileName);
        if Dirs and FileExists(FName) then
          Tempstr := ExtractFilePath(FName)
        else
          Tempstr := FName;
        if (result = '') or not Multiselect then
          result := Tempstr
        else
          result := result + DelimiterChar + Tempstr;
        if not Multiselect then
          Break;
      end;
    end;
  finally
    DragFinish(Message.Drop);
  end;
end;

{******************************************************************}

constructor TDCPropStore.Create(AOwner: TComponent);
begin
  inherited;
  FPropList := TStringList.Create;
  fTmpProps := TList.Create;
  StorePos := true;
  fIgnoreErrors := true;
  fPropNames := TStringList.Create;
  //  HookOnClose;
end;

{------------------------------------------------------------------}

destructor TDCPropStore.Destroy;
begin
  FPropList.Free;
  fTmpProps.Free;
  fPropNames.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.MyOnDestroy(Sender: TObject);
begin
  if LongRec(@fOldOnDestroy).Hi <> 0 then
    fOldOnDestroy(Sender);

  Save;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.MyCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (LongRec(@fOldFormClose).Hi <> 0) and (@fOldFormClose <> @TDCPropStore.MyCloseQuery) then
    fOldFormClose(Sender, CanClose);

  if CanClose and TCustomForm(Owner).HandleAllocated then
    Save;
end;

{------------------------------------------------------------------}

type
  TMCustomForm = class(TCustomForm)
  end;

  {------------------------------------------------------------------}

procedure TDCPropStore.HookOnClose;
var
  p: TCloseQueryEvent;
  pp: TNotifyEvent;
  OwnerForm: TComponent;
begin
  if csDesigning in ComponentState then
    exit;

  if Owner is TDataModule then
  begin
    pp := MyOnDestroy;
    with TDataModule(Owner) do
      if @OnDestroy <> @pp then
      begin
        fOldOnDestroy := OnDestroy;
        OnDestroy := MyOnDestroy;
      end;
  end
  else
  begin
    OwnerForm := Owner;
    while (OwnerForm <> nil) and not (OwnerForm is TCustomForm) do
      OwnerForm := OwnerForm.Owner;

    if OwnerForm <> nil then
    begin
      p := MyCloseQuery;
      with TMCustomForm(OwnerForm) do
        //        If @OnCloseQuery <> @p Then   // Commented because if there would be frame on the
                                                // form and and there would be a propstore in the frame
                                                // then procedure OnClose query can be hooked more than
                                                // one time
      begin
        fOldFormClose := OnCloseQuery;
        OnCloseQuery := MyCloseQuery;
      end
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    HookOnClose;
    BeginGlobalLoading;
    try
      Load;
      NotifyGlobalLoading;
    finally
      EndGlobalLoading;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.SetPropList(Value: TStrings);
begin
  FPropList.Assign(Value);
end;

{------------------------------------------------------------------}

procedure TDCPropStore.DummySetProc;
begin
end;

{------------------------------------------------------------------}

procedure TDCPropStore.ProcessProp1(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
var
  V: DWord;
  p: pointer;
begin
  ftmpProps.Add(PropInfo.SetProc);
  if fPropNames.IndexOf(PropInfo.Name) < 0 then
  begin
    p := Addr(TDCPropStore.DummySetProc);
    WriteProcessMemory(GetCurrentProcess, @(PropInfo.SetProc), @p, 4, V);
  end;
  // PropInfo.SetProc := Addr(TDCPropStore.DummySetProc)

end;

{------------------------------------------------------------------}

procedure TDCPropStore.ProcessProp2(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
var
  P: Pointer;
  V: DWord;
begin
  with ftmpProps do
  begin
    P := First;
    WriteProcessMemory(GetCurrentProcess, @(PropInfo.SetProc), @P, 4, V);
    // PropInfo.SetProc := First;
    Delete(0);
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.ReadSelectedProps(Instance: TComponent; Reader: TReader; PropNames: TStrings);
begin
  fTmpProps.Clear;

  ForEachProp(Instance, ProcessProp1, false, 0);
  try
    Reader.ReadRootComponent(Instance);
  finally
    ForEachProp(Instance, ProcessProp2, false, 0);
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.ProcessAllProps(Filer: TFiler; WriteMode: boolean);
var
  i: integer;
  p: integer;
  inst: TComponent;
  cinst: TComponent;
  size: integer;
  fName: string;
  cinstname: string;
  instname: string;
  buf: pointer;

  procedure getinstprop(const s: string);
  begin
    p := BackPosEx('.', s, length(s));
    if p = 0 then
    begin
      inst := Owner;
      fPropNames.Add(s);
      instname := inst.Name;
    end
    else
    begin
      fPropNames.Add(copy(s, p + 1, length(s) - p));
      instname := copy(s, 1, p - 1);
      inst := Owner.FindComponent(instname);
      if inst = nil then
        inst := GlobalFindObject(Owner.Name + '.' + instname);

      if inst = nil then
        inst := GlobalFindObject(instname);
    end;
  end;

var
  savedprops: TStringList;
  savedname: string;
  needsavedname: boolean;
  _text: string;
  _ntext: string;

const
  InvalidName: string = '0'; //don't resource

begin
  if Owner = nil then
    exit;

  i := 0;
  savedprops := TStringList.Create;
  needsavedname := true;
  try
    with fPropList do
      while i < Count do
      begin
        fPropNames.Clear;
        cinstname := '';
        cinst := nil;
        repeat
          getInstProp(Strings[i]);
          if (instname <> cinstname) and (cinstname <> '') then
          begin
            if fPropNames.Count = 1 then
              inc(i);
            fPropNames.Delete(fPropNames.Count - 1);
            break;
          end
          else
            inc(i);
          cinst := inst;
          cinstname := instname;
        until (i = Count);

        if WriteMode then
        begin
          TWriter(Filer).WriteBoolean(true);
          if cinst <> nil then
          begin
            TWriter(Filer).WriteString(cinstname);
            TWriter(Filer).WriteString(fPropNames.Text);
            _WritePropsToStream(TWriter(Filer), cinst, fPropNames)
          end
          else
            TWriter(Filer).WriteString(InvalidName);
        end
        else
          with TReader(Filer) do
          begin
            if not ReadBoolean then
              break;

            if needsavedname then
              savedname := TReader(Filer).ReadString;

            needsavedname := (savedname = InvalidName) or (savedname = cinstname);

            if not needsavedname or (savedname = InvalidName) then
              continue;

            savedprops.Text := TReader(Filer).ReadString;
            Read(size, sizeof(integer));
            IntersectStrings(savedprops, fPropNames);

            if (fPropNames.count = 0) or (cInst = nil) then
            begin
              GetMem(buf, size);
              try
                Read(buf^, size);
              finally
                FreeMem(buf, size);
              end;
            end
            else
            begin
              fName := cinst.Name;
              if cinst is TControl then
                _text := TMControl(cinst).Text;

              cinst.Name := '';
              try
                ReadSelectedProps(cinst, TReader(Filer), fPropNames);
                //                      ReadRootComponent(cinst);
              finally
                if (cinst is TControl) then
                  with TMControl(cinst) do
                  begin
                    _ntext := Text;

                    if (Name = Text) or (Name + #13#10 = Text) then
                      Text := _text;
                  end;

                cinst.Name := fName;
              end;
            end;
          end;
      end;

    if WriteMode then
      TWriter(Filer).WriteBoolean(false);
  finally
    savedprops.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.SaveToStream(Stream: TStream);
var
  w: TWriter;
begin
  w := TMWriter.Create(Stream, 4096, nil);
  try
    w.IgnoreChildren := true;
    ProcessAllProps(w, true);
  finally
    w.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
begin

  Handled := IgnoreErrors or (MessageBox(0, pchar(Message), PCHar(SErrReadProps),
    MB_OKCANCEL + MB_ICONSTOP + MB_TASKMODAL) = idOk);

end;

{------------------------------------------------------------------}

procedure TDCPropStore.LoadFromStream(Stream: TStream);
var
  r: TReader;
begin
  r := TReader.Create(Stream, 4096);
  try
    r.OnError := ReaderError;
    ProcessAllProps(r, false);
  finally
    r.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.Load;
var
  Stream: TMemoryStream;
  size: integer;
  processed: boolean;
begin
  try
    if Assigned(OnLoadChanges) then
    begin
      processed := false;
      OnLoadChanges(self, processed);
      if processed then
        exit;
    end;

    if UseIniFile then
    begin
      if (IniFile = '') or (IniSection = '') then
        exit;
      LoadFromIniFile(IniFile, IniSection);
      if StorePos and (Owner is TCustomForm) then
        ReadWinPosFromIni(TCustomForm(Owner), key, IniFile, IniSection);
    end
    else
    begin
      size := GetRegBufSize(key);
      if size > 0 then
      begin
        Stream := TMemoryStream.Create;
        try
          Stream.SetSize(Size);
          ReadBufFromRegistry(key, Stream.Memory^, Size);
          LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
      end;

      if StorePos and (Owner is TCustomForm) then
        ReadWinPosFromReg(TCustomForm(Owner), key {TCustomForm(Owner).name});
    end;
  finally
    if Assigned(OnChangesLoaded) then
      OnChangesLoaded(Self);
  end;
end;

{------------------------------------------------------------------}

procedure TDCPropStore.Save;
var
  Stream: TMemoryStream;
  processed: boolean;
begin
  try
    if Assigned(OnSaveChanges) then
    begin
      processed := false;
      OnSaveChanges(self, processed);
      if processed then
        exit;
    end;

    if UseIniFile then
    begin
      if (IniFile = '') or (IniSection = '') then
        exit;
      SaveToIniFile(IniFile, IniSection);
      if StorePos and (Owner is TCustomForm) then
        WriteWinPosToIni(TCustomForm(Owner), key, IniFile, IniSection);
    end
    else
    begin
      Stream := TMemoryStream.Create;
      try
        SaveToStream(Stream);
        WriteBufToRegistry(key, Stream.Memory^, Stream.Size);
        if StorePos and (Owner is TCustomForm) then
          WriteWinPosToReg(TCustomForm(Owner), key {+ TCustomForm(Owner).name});
      finally
        Stream.Free;
      end;
    end;
  finally
    if Assigned(OnChangesSaved) then
      OnChangesSaved(Self);
  end;
end;

{------------------------------------------------------------------}

function TDCPropStore.GetKey: string;
begin
  if fKey = '' then
    result := Owner.Name + Name
  else
    result := fKey;
end;

{--------TDCTabControl---------------------------------------------------}

function TDCTabControl.IsContainedControl: Boolean;
var
  Control: TControl;
begin
  Control := GetParentForm(Self).ActiveControl;
  while (Control <> nil) and (Control <> Self) do
    Control := Control.Parent;
  Result := Control <> nil;
end;

{------------------------------------------------------------------}

procedure TDCTabControl.CMDialogKey(var Message: TCMDialogKey);
var
  ShiftState: TShiftState;
begin
  with Message do
  begin
    ShiftState := KeyDataToShiftState(KeyData);
    if (CharCode = VK_TAB) and (ssCtrl in ShiftState) and IsContainedControl then
    begin
      ChangeTab(Self, not (ssShift in ShiftState));
      Change;
      result := 1;
    end
    else
      inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCSpeedButton.GlyphChanged(Sender: TObject);
begin
  if Assigned(fOldOnChange) then
    fOldOnChange(Sender);
  Glyph.FreeImage;
  Glyph.Dormant;
end;

{-------------------------------------------------------------------------}

constructor TDCSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  fOldOnChange := Glyph.OnChange;
  Glyph.OnChange := GlyphChanged;
end;
{$ENDIF}

function TCompFiler.EventNameByID(ID: integer): string;
var
  index: integer;
begin
  index := FEventNames.IndexOfObject(TObject(ID));
  if index >= 0 then
    result := FEventNames[index]
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TCompFiler.CreateMethodTable(S: TStream; OldTable: PMethodTable);
var
  i: Integer;
  pdef: PMethodDef;
  oldsize: integer;
begin
  if OldTable <> nil then
    oldsize := OldTable^.Size
  else
    oldsize := 0;

  WriteWord(S, oldsize + fEventNames.Count);

  for i := 0 to FEventNames.Count - 1 do
  begin
    WriteWord(S, Length(FEventNames[i]) + sizeof(word) + sizeof(integer) + 1);
    WriteInt(S, Integer(FEventNames.Objects[i]));
    WriteShortStr(S, FEventNames[i]);
  end;

  if OldSize > 0 then
  begin
    pdef := PMethodDef(pchar(OldTable) + 2);

    for i := 0 to OldSize - 1 do
    begin
      S.Write(pdef^, pdef^.size);
      pdef := PMethodDef(pchar(pdef) + pdef^.size);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCompFiler.BeginClassNameTrick(OwnerControl: TComponent);
begin
  if OwnerControl = nil then
    exit;

  _OldClassNamePtr := ClassNamePtr(OwnerControl.ClassType);
  _ClassNameStr := ClassPrefix + OwnerControl.Name;
  SetClassNamePtr(OwnerControl.ClassType, @_ClassNameStr);
end;

{------------------------------------------------------------------}

procedure TCompFiler.EndClassNameTrick(OwnerControl: TComponent);
begin
  if OwnerControl <> nil then
    SetClassNamePtr(OwnerControl.ClassType, _OldClassNamePtr);
end;

{------------------------------------------------------------------}

procedure TCompFiler.BeginTrick(OwnerControl: TComponent; SkipMethodsWrite: boolean);
begin
  BeginMethodTrick(OwnerControl, SkipMethodsWrite);
  BeginClassNameTrick(OwnerControl);
end;

{------------------------------------------------------------------}

procedure TCompFiler.EndTrick(OwnerControl: TComponent);
begin
  EndClassNameTrick(OwnerControl);
  EndMethodTrick(OwnerControl);
end;

{------------------------------------------------------------------}

procedure TCompFiler.BeginMethodTrick(OwnerControl: TComponent; SkipMethodsWrite: boolean);
begin
  if OwnerControl = nil then
    exit;

  _OldTable := MethodTable(OwnerControl.ClassType);

  if fEventNames.Count > 0 then
  begin
    _S := TMemoryStream.Create;
    CreateMethodTable(_S, _OldTable);
    if not SkipMethodsWrite then
      SetMethodTable(OwnerControl.ClassType, _S.Memory);
  end;
end;

{------------------------------------------------------------------}

procedure TCompFiler.EndMethodTrick(OwnerControl: TComponent);
begin
  if OwnerControl = nil then
    exit;

  SetMethodTable(OwnerControl.ClassType, _OldTable);
  FreeObject(_S,_S);
end;

{------------------------------------------------------------------}

function TCompFiler.CreateFromFile(const FileName: TFileName; ModuleClass: TComponentClass; SetDesigning: boolean): TComponent;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, DefaultOpenMode);
  try
    result := CreateFromStream(FileStream, ModuleClass, SetDesigning);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

function TCompFiler.GlobalFindCompWithoutDesigned(const Name: string): TComponent;

  function CompIsOK(comp: TComponent): boolean;
  begin
    result := not (csDesigning in comp.ComponentState) and (CompareText(Name, comp.Name) = 0);
  end;

var
  i: integer;

begin
  for i := 0 to ScreenFormCount - 1 do
  begin
    Result := ScreenForms(i);
    if CompIsOK(result) then
      exit;
  end;

  for i := 0 to Screen.DataModuleCount - 1 do
  begin
    Result := Screen.DataModules[I];
    if CompIsOK(result) then
      exit;
  end;

  Result := nil;
end;

{------------------------------------------------------------------}

function TCompFiler.CreateFromStream(S: TStream; ModuleClass: TComponentClass; SetDesigning: boolean): TComponent;
var
  Hooked: boolean;
begin
  if StreamContainsDataModule(S) then
    Result := CreateDataModuleWithClass(ModuleClass)
  else
    Result := CreateFormWithClass(ModuleClass);

  if SetDesigning then
    SetDesign(Result, true);

  try
    Hooked := false;
    if fIgnoreDesignedForms then
      Hooked := SetFindGlobalCompProc(GlobalFindCompWithoutDesigned);

    try
      Result.Name := LoadFromStream(S, Result);
    finally
      if Hooked then
        RemoveFindGlobalCompProc;
    end;
  except
    FreeObject(Result,Result);
    raise;
  end;

  CompLoaded;
end;

{------------------------------------------------------------------}

function TCompFiler.AddEvent(const EvName: string): integer;
begin
  with fEventNames do
  begin
    result := IndexOf(EvName);
    if result >= 0 then
    begin
      result := integer(Objects[result]);
      exit;
    end;

    AddObject(EvName, pointer(fEventID));
  end;

  result := fEventID;
  inc(fEventID);
end;

{------------------------------------------------------------------}

procedure TCompFiler.ReaderOnMethod(Reader: TReader; const MethodName: string;
  var Address: Pointer; var Error: Boolean);
begin
  if Error then
  begin
    Error := False;
    Address := Pointer(AddEvent(MethodName));
  end;
end;

{------------------------------------------------------------------}

procedure TCompFiler.ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
  if Assigned(fOnReaderError) then
  begin
    fOnReaderError(Reader, Message, Handled);
    exit;
  end;

  FFilerErrors := True;
  Handled := HandledAll;
  if not Handled and Assigned(ReaderErrorHandler) then
    ReaderErrorHandler(Message, Handled, HandledAll);
end;

{--------------------------------------------}

procedure TCompFiler.Assign(Source: TCompFiler);
begin
  if Source <> nil then
  begin
    fEventID := Source.fEventID;
    fEventNames.Assign(Source.fEventNames);
  end;
end;

{--------------------------------------------}

constructor TCompFiler.Create;
begin
  inherited;
  fEventID := 1;
  FEventNames := TStringList.Create;
  FFixList := TStringList.Create;
end;

{--------------------------------------------}

destructor TCompFiler.Destroy;
begin
  FEventNames.Free;
  FFixList.Free;
  inherited;
end;

{--------------------------------------------}

procedure TCompFiler.SaveToStream(FormStream: TStream; Instance: TComponent);
var
  TempStream : TStream;
begin
  if Instance <> nil then
  begin
    BeginTrick(Instance, false);
    try
      if SaveFormAsText then
        begin
          TempStream := TMemoryStream.Create;
          try
            TempStream.WriteComponentRes(ClassPrefix + Instance.Name, Instance);
            TempStream.Seek(0, 0);
            ObjectBinaryToText(TempStream, FormStream);
          finally
            TempStream.Free;
          end;
        end
      else
        FormStream.WriteComponentRes(ClassPrefix + Instance.Name, Instance);
    finally
      EndTrick(Instance);
    end;
  end;
end;

{--------------------------------------------}

procedure TCompFiler.LoadFromFile(const FileName: TFileName; Instance: TComponent);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, DefaultOpenMode);
  try
    LoadFromStream(FileStream, Instance);
  finally
    FileStream.Free;
  end;
end;

{--------------------------------------------}

procedure TCompFiler.SaveToFile(const FileName: TFileName; Instance: TComponent);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(FileStream, Instance);
  finally
    FileStream.Free;
  end;
end;

{--------------------------------------------}

function TCompFiler.LoadFromStream(FormStream: TStream; Instance: TComponent): string;

var
  memstream: TMemoryStream;
begin
  if isTextStream(FormStream) then
  begin
    MemStream := TMemoryStream.Create;
    try
      ObjectTextToBinary(FormStream, MemStream);
      MemStream.Seek(0, 0);
      result := DoLoadFromStream(MemStream, Instance)
    finally
      MemStream.Free;
    end
  end
  else
    result := DoLoadFromStream(FormStream, Instance);
end;

{--------------------------------------------}

function TCompFiler.DoLoadFromStream(FormStream: TStream; Instance: TComponent): string;
var
  FPosition: Integer;
  i: Integer;
  Flags: TFilerFlags;
begin
  FEventID := 1;
  FEventNames.Clear;
  HandledAll := False;
  FFilerErrors := False;
  with TReader.Create(FormStream, 4096) do
  try
    Ancestor := Self.Ancestor;
    SmartSkipResHeader(FormStream, False);
    FPosition := Position;
    //--- read form name here
    ReadSignature;
    ReadPrefix(Flags, I);
    fcName := ReadStr; { class name }
    Result := ReadStr;
    //---
    Position := FPosition;

    OnError := ReaderError;
    OnFindMethod := ReaderOnMethod;
    //ReadComponent(Instance);
    ReadRootComponent(Instance);

    if Assigned(DCInitComponentHandler) then
      DCInitComponentHandler(Instance, fcName, Result);
  finally
    Free;
  end;
  CompLoaded;
end;

{------------------------------------------------------------------}

procedure TCompFiler.CompLoaded;
begin
  if Assigned(OnAfterLoad) then
    OnAfterLoad(self);
end;

{******************************************************************}

{$ENDIF WIN}

const
  StandardPropCount = 5;
  StandardProps: array[1..StandardPropCount] of string = ('Left', 'Top', 'Width', 'Height', 'OldCreateOrder'); //don't resource

function _StreamContainsDataModule(S: TStream): boolean;
var
  savepos: integer;
  i: Integer;
  flags: TFilerFlags;
  propname: string;
  isstandard: boolean;
begin
  savepos := S.Position;
  try
    SmartSkipResHeader(S, False);
    with TReader.Create(S, 64) do
    try
      ReadSignature;
      ReadPrefix(flags, i);
      ReadStr; // Class Name
      ReadStr; // Comp Name
      while not EndOfList do
      begin
        propname := ReadStr;
        isstandard := false;
        if pos('On', propname) = 1 then //don't resource
        begin
          ReadIdent;
          continue;
        end;

        for i := 1 to StandardPropCount do
          if CompareText(propname, StandardProps[i]) = 0 then
          begin
            isstandard := true;
            break;
          end;

        if isstandard then
          if CompareText(propname, 'OldCreateOrder') = 0 then //don't resource
            ReadBoolean
          else
            ReadInteger
        else
        begin
          result := false;
          exit;
        end;
      end;
      result := EndOfList;
    finally
      Free;
    end;
  finally
    S.Position := savepos;
  end;
end;

{-------------------------------------------------------------------------}

function StreamContainsDataModule(S: TStream): boolean;
var
  memstream: TMemoryStream;
  savepos: integer;
begin
  if isTextStream(S) then
  begin
    MemStream := TMemoryStream.Create;
    savepos := S.Position;
    try
      ObjectTextToBinary(S, MemStream);
      MemStream.Seek(0, 0);
      result := _StreamContainsDataModule(MemStream)
    finally
      S.Position := savepos;
      MemStream.Free;
    end
  end
  else
    result := _StreamContainsDataModule(S);
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

function GetModulePath(Module: HModule): string;
begin
  SetLength(Result, 1024);
  Setlength(Result, GetModuleFileName(Module, @Result[1], 1023));
end;

{------------------------------------------------------------------}

procedure GetLoadedPackagesPaths(Strings: TStrings);
var
  List: TList;
  i: Integer;
  Path: string;
begin
  List := TList.Create;
  try
    ModulesToList(List);
    with Strings do
    begin
      BeginUpdate;
      Clear;
      for i := 0 to List.Count - 1 do
      begin
        Path := GetModulePath(Integer(List[i]));
        if FileIsPackage(Path) then
          Add(Path);
      end;
      EndUpdate;
    end;
  finally
    List.Free;
  end;
end;

{$ENDIF}
{------------------------------------------------------------------}

{$IFDEF D3}

function ModulesToListFunc(HInstance: Longint; Data: Pointer): Boolean;
begin
  Result := True;
  TList(Data).Add(Pointer(HInstance));
end;
{$ENDIF}

{------------------------------------------------------------------}

procedure ModulesToList(List: TList);
begin
  List.Clear;
  {$IFDEF D3}
  EnumModules(ModulesToListFunc, List);
  {$ELSE}
  List.Add(Pointer(HInstance));
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure ResModulesToList(List: TList);
begin
  List.Clear;
  {$IFDEF D3}
  EnumResourceModules(ModulesToListFunc, List);
  {$ELSE}
  List.Add(Pointer(HInstance));
  {$ENDIF}
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

function FindResourceInstance(const ResName: string; ResType: PChar): THandle;
var
  PackList: TList;
  i: Integer;
begin
  PackList := TList.Create;
  ResModulesToList(PackList);
  try
    for i := 0 to PackList.Count - 1 do
    begin
      Result := Integer(PackList[i]);
      if (Result > 0) and (FindResource(Result, PChar(ResName), ResType) <> 0) then
        exit;
    end;
    Result := 0;
  finally
    PackList.Free;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------}

function CheckFileExt(const FileName, FileExt: string): boolean;
begin
  Result := CompareText(RemoveCharSet(['.'], ExtractFileExt(FileName)),
    RemoveCharSet(['.'], FileExt)) = 0;
end;

{------------------------------------------------------------------}

function FileIsPackage(const FileName: string): boolean;
begin
  Result := CheckFileExt(FileName, 'BPL') or CheckFileExt(FileName, 'DPL'); //don't resource
end;

{------------------------------------------------------------------}

procedure MovePages(Source, Dest: TPageControl);
begin
  while Source.PageCount > 0 do
    Source.Pages[0].PageControl := Dest;
end;

{------------------------------------------------------------------}

var
  _OptionFormClasses: TSortedList;

type
  TOptionFormItem = class
    Order: integer;
    FormClass: TCustomFormClass;
  end;

  TOptionFormClassList = class(TSortedKeyList)
  protected
    function KeyByItem(Item: Pointer): Pointer; override;
  end;

function TOptionFormClassList.KeyByItem(Item: Pointer): Pointer;
begin
  result := pointer(TOptionFormItem(Item).Order);
end;

{------------------------------------------------------------------}

function OptionFormClass(index: integer): TCustomFormClass;
begin
  result := TOptionFormItem(OptionFormClasses.Items[index]).FormClass;
end;

{------------------------------------------------------------------}

function OptionFormClasses: TSortedList;
begin
  if _OptionFormClasses = nil then
    _OptionFormClasses := TOptionFormClassList.Create;

  result := _OptionFormClasses;
end;

var
  _OptionFormCaptions: TStringList;

function OptionFormCaptions: TStringList;
begin
  if _OptionFormCaptions = nil then
    _OptionFormCaptions := TStringList.Create;

  result := _OptionFormCaptions;
end;

{$IFDEF WIN}

function GetOptionsFormCaption(OptionsFormClass: TCustomFormClass): string;
var
  i: integer;
begin
  with OptionFormCaptions do
  begin
    i := IndexOfObject(TObject(OptionsFormClass));
    result := '';
    if i >= 0 then
      result := OptionFormCaptions[i];
  end;
end;

{------------------------------------------------------------------}

procedure RegisterOptionsFormOrder(OptionsFormClass: TCustomFormClass; Order: integer; const ACaption: string);
var
  ofitem: TOptionFormItem;
begin
  ofitem := TOptionFormItem.Create;
  try
    ofitem.Order := Order;
    ofitem.FormClass := OptionsFormClass;
    OptionFormClasses.Add(ofitem);
  except
    ofitem.Free;
    raise;
  end;
  OptionFormCaptions.AddObject(ACaption, TObject(OptionsFormClass));
end;

{------------------------------------------------------------------}

procedure UnregisterOptionsForm(OptionsFormClass: TCustomFormClass);
var
  i: integer;
  j: integer;
begin
  if _OptionFormClasses <> nil then
    with _OptionFormClasses do
      for i := 0 to Count - 1 do
        if TOptionFormItem(Items[i]).FormClass = OptionsFormClass then
        begin
          Delete(i);
          j := OptionFormCaptions.IndexOfObject(TObject(OptionsFormClass));
          if j >= 0 then
            OptionFormCaptions.Delete(j);
          exit;
        end;
end;

{------------------------------------------------------------------}

procedure RegisterOptionsForm(OptionsFormClass: TCustomFormClass; const ACaption: string);
begin
  RegisterOptionsFormOrder(OptionsFormClass, -1, ACaption);
end;

{------------------------------------------------------------------}

procedure SetFlatPropToAll(Owner: TComponent; Value: boolean);
var
  i: Integer;
begin
  with Owner do
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TSpeedButton then
        SetFlatProp([TSpeedButton(Components[i])], Value);
end;

{--------------------------------------------}

procedure SetFlatProp(const Ctrls: array of TSpeedButton; V: Boolean);
{$IFDEF D3}
var
  i: integer;
begin
  for i := Low(Ctrls) to High(Ctrls) do
    Ctrls[i].flat := V;
end;
{$ELSE}
begin
end;
{$ENDIF}

{-------------------------------------------------------------------------}
{$IFNDEF CLX}

procedure CreateBrushPatternEx(Bitmap: TBitmap; Color1, Color2: TColor);
var
  X, Y: Integer;
begin
  if Bitmap = nil then
    exit;
  with Bitmap, Canvas do
  begin
    Width := 8;
    Height := 8;
    Brush.Style := bsSolid;
    Brush.Color := Color1;
    FillRect(Rect(0, 0, Width, Height));
    for Y := 0 to 7 do
      for X := 0 to 7 do
        if (Y mod 2) = (X mod 2) then
          Pixels[X, Y] := Color2;
  end;
end;

{-----------------------------------------------------------}

procedure CreateBrushPattern(Bitmap: TBitmap);
begin
  CreateBrushPatternEx(Bitmap, clBtnFace, clBtnHighlight);
end;

{-----------------------------------------------------------}

procedure DrawImage(Canvas: TCanvas; Image: TPersistent; Color: TColor;
  const ARect: TRect; ImageIndex: integer);
var
  Bitmap: TBitmap;
begin
  if not ((Image is TImageList) or (Image is TBitmap)) then
    Exit;
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := ARect.Right - ARect.Left;
    Bitmap.Height := ARect.Bottom - ARect.Top;
    Bitmap.Canvas.Brush.Color := Color;
    Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));
    if Image is TImageList then
      TImageList(Image).Draw(Bitmap.Canvas, 0, 0, ImageIndex)
    else if not TBitmap(Image).Empty then
      StretchBltTransparent(Bitmap.Canvas.Handle,
        0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top,
        TBitmap(Image).Canvas.Handle, 0, 0, TBitmap(Image).Width,
        TBitmap(Image).Height, TBitmap(Image).Canvas.Pixels[0, 0]);
    Canvas.Draw(ARect.Left, ARect.Top, Bitmap);
  finally
    Bitmap.Free;
  end;
end;

{---------------------------------------------------------}

procedure StretchBltTransparent(DestDC: THandle; DestLeft, DestTop, DestWidth, DestHeight: Integer;
  SourceDC: THandle; SourceLeft, SourceTop, SourceWidth, SourceHeight: Integer; TransColor: TColor);
var
  ScreenDC: THandle;
  hMaskBitmap: THandle;
  MaskDC: THandle;
  OldBkColor: TColorRef;
  OldTextColor: TColorRef;
  OldBmp: THandle;
begin
  ScreenDC := GetDC(0);
  MaskDC := CreateCompatibleDC(ScreenDC);
  ReleaseDC(0, ScreenDC);

  hMaskBitmap := CreateCompatibleBitmap(MaskDC, DestWidth, DestHeight);
  OldBmp := SelectObject(MaskDC, hMaskBitmap);
  OldBkColor := SetBkColor(SourceDC, ColorToRgb(TransColor));
  BitBlt(MaskDC, 0, 0, DestWidth, DestHeight, SourceDC, SourceLeft, SourceTop, SRCCOPY);
  SetBkColor(SourceDC, OldBkColor);

  OldBkColor := SetBkColor(DestDC, Rgb(255, 255, 255));
  OldTextColor := SetTextColor(DestDC, 0);
  StretchBlt(DestDC, DestLeft, DestTop, DestWidth, DestHeight, SourceDC, SourceLeft, SourceTop,
    SourceWidth, SourceHeight, SRCINVERT);
  BitBlt(DestDC, DestLeft, DestTop, DestWidth, DestHeight, MaskDC, 0, 0, SRCAND);
  StretchBlt(DestDC, DestLeft, DestTop, DestWidth, DestHeight, SourceDC, SourceLeft, SourceTop,
    SourceWidth, SourceHeight, SRCINVERT);
  SelectObject(MaskDC, OldBmp);
  SetBkColor(DestDC, OldBkColor);
  SetTextColor(DestDC, OldTextColor);
  DeleteObject(hMaskBitmap);
  DeleteDC(MaskDC);
end;

{$ENDIF}
{$ENDIF WIN}
{$IFDEF D4}

procedure SafeRegisterActions(const CategoryName: string; const AClasses: array of TBasicActionClass; Resource: TComponentClass);
begin
  if Assigned(RegisterActionsProc) then
    RegisterActions(CategoryName, AClasses, Resource);
end;
{$ENDIF}

type
  TDComponent = class(TComponent)
  end;

procedure SetDesign(Instance: TComponent; value: boolean);
begin
  TDComponent(Instance).SetDesigning(value);
end;

{------------------------------------------------------------------}

function ScreenFormCount: Integer;
begin
  {$IFDEF D3}
  Result := Screen.CustomFormCount;
  {$ELSE}
  Result := Screen.FormCount;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function ScreenForms(i: Integer): TCustomForm;
begin
  {$IFDEF D3}
  Result := Screen.CustomForms[i];
  {$ELSE}
  Result := Screen.Forms[i];
  {$ENDIF}
end;

{--------------------------------------------}

function CreateDataModuleWithClass(DataModuleClass: TComponentClass): TDataModule;
begin
  if not DataModuleClass.InheritsFrom(TDataModule) then
    DataModuleClass := TDataModule;

  {$IFNDEF CLX}
  if GetFormResourceHandler(DataModuleClass) <> 0 then
    Result := TDataModuleClass(DataModuleClass).Create(nil)
  else
    {$IFDEF VER93}
    Result := TDataModuleClass(DataModuleClass).CreateNew(nil, 0);
  {$ELSE}
    Result := TDataModuleClass(DataModuleClass).CreateNew(nil);
  {$ENDIF}
  {$ELSE}
  Result := TDataModuleClass(DataModuleClass).CreateNew(nil);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function CreateFormWithClass(FormClass: TComponentClass): TCustomForm;
begin
  if not FormClass.InheritsFrom(TCustomForm) then
    FormClass := TCustomForm;

  {$IFNDEF CLX}
  if GetFormResourceHandler(FormClass) <> 0 then
    Result := TCustomFormClass(FormClass).Create(nil)
  else
    {$IFDEF VER93}
    Result := TCustomFormClass(FormClass).CreateNew(nil, 0);
  {$ELSE}
    Result := TCustomFormClass(FormClass).CreateNew(nil);
  {$ENDIF}
  {$ELSE}
  Result := TCustomFormClass(FormClass).CreateNew(nil);
  ;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function GetTopOwner(c: TPersistent): TComponent;
var
  pform: TCustomForm;
begin
  pform := GetPForm(c);
  while (c <> nil) and not (c is TDataModule) do
    c := GetOwner(c);
  if c = nil then
    result := pform
  else
    result := TComponent(c);
end;

{--------------------------------------------}

function GetPForm(c: TPersistent): TCustomForm;

  function _getpform(c: TControl): TCustomForm;
  begin
    while not ((c = nil) or (c is TCustomForm)) do
      c := TControl(c).Parent;

    result := TCustomForm(c);
  end;

begin
  if c is TControl then
  begin
    result := _getpform(TControl(c));

    if result <> nil then
      exit;
  end;

  {$IFNDEF D3}
  if not (c is TComponent) then
  begin
    result := nil;
    exit;
  end;
  {$ENDIF}

  while (c <> nil) and not (c is TCustomForm) do
    c := GetOwner(c);

  result := TCustomForm(c);
end;

{--------------------------------------------}

type
  TMForm = class(TCustomForm);

procedure CallCompOnCreate(Comp: TComponent);
begin
  try
    if Comp is TDataModule then
    begin
      with TDataModule(Comp) do
        if Assigned(OnCreate) then
          OnCreate(Comp);
    end
    else if Comp is TCustomForm then
      with TMForm(Comp) do
        if Assigned(OnCreate) then
          OnCreate(Comp);
  except
    Application.HandleException(Comp);
  end;
end;

{------------------------------------------------------------------}

function EqualMethodTypeData(td1, td2: PTypeData): boolean;
var
  p1: pchar;
  p2: pchar;
  Flags1: TParamFlags;
  Flags2: TParamFlags;
  i: integer;
  ParamName1: string;
  ParamName2: string;
  TypeName1: string;
  TypeName2: string;
begin
  result := (td1 <> nil) and (td2 <> nil) and
    (td1^.MethodKind = td2^.MethodKind) and
    (td1^.ParamCount = td2^.ParamCount);

  if result then
  begin
    p1 := @td1^.ParamList;
    p2 := @td2^.ParamList;

    for i := 1 to td1^.ParamCount do
    begin
      Flags1 := TParamFlags(p1^);
      inc(p1);
      Flags2 := TParamFlags(p2^);
      inc(p2);

      if Flags1 <> Flags2 then
      begin
        result := false;
        exit;
      end;

      ParamName1 := PReadShortStr(p1);
      TypeName1 := PReadShortStr(p1);

      ParamName2 := PReadShortStr(p2);
      TypeName2 := PReadShortStr(p2);

      if CompareText(TypeName1, TypeName2) <> 0 then
      begin
        result := false;
        exit;
      end;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure Register;
begin
  {$IFDEF WIN}
  {$IFNDEF CLX}
  RegisterComponents(SPalDream, [TDCPropStore, TDCTabControl, TDCSpeedButton]);
  {$ENDIF}
  {$ENDIF}
end;

type
  ByteArray = array[0..0] of byte;

procedure TDCPropStore.SaveToIniFile(const AFileName, ASection: string);
var
  BinStream: TMemoryStream;
  Data: string;
begin
  BinStream := TMemoryStream.Create;
  try
    SaveToStream(BinStream);
    Data := BufferToText(BinStream.Memory, BinStream.Size);
    if WritePrivateProfileSection(PChar(ASection), nil, PChar(AFileName)) then
      WritePrivateProfileSection(PChar(ASection), PChar(Data), PChar(AFileName));
  finally
    BinStream.Free;
  end;
end;

procedure TDCPropStore.LoadFromIniFile(const AFileName, ASection: string);
const
  MaxSectionSize = 32767;
var
  BinStream: TMemoryStream;
  Data: string;
begin
  BinStream := TMemoryStream.Create;
  try
    SetLength(Data, MaxSectionSize); //allocate memory
    SetLength(Data, GetPrivateProfileSection(PChar(ASection), PChar(Data),
      MaxSectionSize, PChar(AFileName)));
    if Length(Data) = 0 then
      exit;
    TextToStream(Data, BinStream);
    BinStream.Position := 0;
    LoadFromStream(BinStream);
  finally
    BinStream.Free;
  end;
end;

initialization

finalization
  FreeSortedList(_OptionFormClasses,_OptionFormClasses);
  _OptionFormCaptions.Free;
end.
