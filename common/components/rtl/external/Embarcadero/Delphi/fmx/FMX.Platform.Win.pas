{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Platform.Win;

(*$HPPEMIT '#if defined(WIN32) && defined(CreateWindow)'*)
(*$HPPEMIT '  #define __SAVE_CREATEWINDOW CreateWindow'*)
(*$HPPEMIT '  #undef  CreateWindow'*)
(*$HPPEMIT '#endif'*)

(*$HPPEMIT END '#if defined(__SAVE_CREATEWINDOW)'*)
(*$HPPEMIT END '  #define CreateWindow __SAVE_CREATEWINDOW'*)
(*$HPPEMIT END '  #undef  __SAVE_CREATEWINDOW'*)
(*$HPPEMIT END '#endif'*)

(*$HPPEMIT '#define NO_USING_NAMESPACE_FMX.PLATFORM_WIN' *)
{$R-}
interface

uses
  Winapi.Windows, System.Types, System.Classes, System.UITypes, System.UIConsts,
  FMX.Forms, FMX.Platform, FMX.Types;

type

  TWinWindowHandle = class(TWindowHandle)
  private
    FWnd: HWnd;
    FBufferBitmap: THandle;
    FBitmapInfo: TBitmapInfo;
    FBufferBits: Pointer;
    FBufferHandle: THandle;
    FBufferSize: TSize;
    FForm: TCommonCustomForm;
    procedure UpdateLayer;
  public
    constructor Create(const AForm: TCommonCustomForm; const AWnd: HWnd);
    destructor Destroy; override;
    procedure CreateBuffer(const Width, Height: Integer);
    procedure ResizeBuffer(const Width, Height: Integer);
    procedure FreeBuffer;
    property Wnd: HWnd read FWnd;
    property Form: TCommonCustomForm read FForm;
    property BufferBits: Pointer read FBufferBits;
    property BufferHandle: THandle read FBufferHandle;
  end;

function FindWindow(Handle: HWND): TCommonCustomForm;
function WindowHandleToPlatform(const AHandle: TWindowHandle): TWinWindowHandle;

function FmxHandleToHWND(const FmxHandle: TWindowHandle): HWND; deprecated 'Use WindowHandleToPlatform instead';

procedure SetScreenScale(ScreenScale: Single); // for Style Viewer

procedure RegisterCorePlatformServices;
procedure UnregisterCorePlatformServices;

function KeysToShiftState(Keys: Word): TShiftState;

procedure Wow64DisableRedirection(var EnableRedirection: boolean);
procedure Wow64EnableRedirection(var EnableRedirection: boolean);

implementation

uses
  FMX.Messages,
  Winapi.CommDlg, Winapi.Messages, Winapi.ActiveX, Winapi.ShlObj,
  Winapi.MMSystem, Winapi.ShellAPI, Winapi.MultiMon, Winapi.Imm, Winapi.UxTheme,
  System.Variants, System.SysUtils, System.Math, System.StrUtils, System.RTLConsts,
  System.SyncObjs, System.Rtti, System.Generics.Collections,
  FMX.Consts,
  FMX.Menus,
  FMX.Dialogs, FMX.Dialogs.Default,
  FMX.Printer, FMX.Printer.Win,
  FMX.Canvas.GDIP, FMX.Canvas.D2D,
  FMX.Context.DX9, FMX.Context.DX10,
  FMX.Canvas.GPU,
  FMX.Forms.Border.Win,
  FMX.Controls.Win,
  FMX.Gestures.Win, FMX.PixelFormats,
  FMX.TextLayout, FMX.Text, FMX.Types3D,
  FMX.VirtualKeyboard, FMX.Controls;

type

  TOpenMenuItem = class(TMenuItem);
  TOpenCustomForm = class(TCommonCustomForm);

  MySTGMEDIUM = record // for compatibility
    Tymed: DWORD;
    Case Integer Of
      0:
        (HBITMAP: HBITMAP; UnkForRelease: Pointer { IUnknown } );
      1:
        (HMETAFILEPICT: THandle);
      2:
        (HENHMETAFILE: THandle);
      3:
        (HGLOBAL: HGLOBAL);
      4:
        (lpszFileName: POleStr);
      5:
        (stm: Pointer { IStream } );
      6:
        (stg: Pointer { IStorage } );
  end;

{ TDropTarget }

  TDropTarget = class(TComponent, IDropTarget)
  private
    Form: TCommonCustomForm;
    function GetDataObject: TDragObject;
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    function DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
  end;

{ TDropSource }

  TDataObjectInfo = record
    FormatEtc: TFormatEtc;
    StgMedium: TStgMedium;
    OwnedByDataObject: Boolean;
  end;

  TDataObjectInfoArray = array of TDataObjectInfo;

  TDropSource = class(TComponent, IDataObject, IDropSource)
  private
    Data: TDragObject;
    Formats: TDataObjectInfoArray;
    { IDropSource }
    function QueryContinueDrag(fEscapePressed: bool; grfKeyState: Longint): HResult; stdcall;
    function GiveFeedback(dwEffect: Longint): HResult; stdcall;
    { IDataObject }
    function GetData(const FormatEtcIn: TFormatEtc; out Medium: TStgMedium): HResult; stdcall;
    function GetDataHere(const FormatEtc: TFormatEtc; out Medium: TStgMedium): HResult; stdcall;
    function QueryGetData(const FormatEtc: TFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const FormatEtc: TFormatEtc; out FormatEtcout: TFormatEtc): HResult; stdcall;
    function SetData(const FormatEtc: TFormatEtc; var Medium: TStgMedium; fRelease: Bool): HRESULT; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out EnumFormatEtc: IEnumFormatEtc): HResult; stdcall;
    function dAdvise(const FormatEtc: TFormatEtc; advf: Longint; const advsink: IAdviseSink;
      out dwConnection: Longint): HResult; stdcall;
    function dUnadvise(dwConnection: Longint): HResult; stdcall;
    function EnumdAdvise(out EnumAdvise: IEnumStatData): HResult; stdcall;
    { For IDropSourceHelper }
    function FindFormatEtc(TestFormatEtc: TFormatEtc): Integer;
    function EqualFormatEtc(FormatEtc1, FormatEtc2: TFormatEtc): Boolean;
    function HGlobalClone(HGLOBAL: THandle): THandle;
    function RetrieveOwnedStgMedium(Format: TFormatEtc; var StgMedium: TStgMedium): HResult;
    function StgMediumIncRef(const InStgMedium: TStgMedium; var OutStgMedium: TStgMedium;
      CopyInMedium: Boolean): HResult;
    function CanonicalIUnknown(const TestUnknown: IUnknown): IUnknown;
  end;

type
  TWin32Timerinfo = record
    TimerID: UINT;           // the Windows timer ID for this timer
    TimerHandle: TFmxHandle; // the unique FMX Handle for this timer
    TimerFunc: TTimerProc;   // owner function to handle timer
  end;

  TNoStaysOpenList = class (TComponent)
  private
    FNoStaysOpenList: TList<Pointer>;
    function GetCount: Integer;
    function GetItem(const Index: Integer): TCommonCustomForm;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Item[const Index: Integer]: TCommonCustomForm read GetItem; default;
    procedure Add(const Item: TCommonCustomForm);
    procedure Remove(const Item: TCommonCustomForm);
    function Contains(const Item: TCommonCustomForm): Boolean;
  end;

{ TNoStaysOpenList }

constructor TNoStaysOpenList.Create(AOwner: TComponent);
begin
  inherited;
  FNoStaysOpenList := TList<Pointer>.Create;
end;

destructor TNoStaysOpenList.Destroy;
begin
  FreeAndNil(FNoStaysOpenList);
  inherited;
end;

function TNoStaysOpenList.GetCount: Integer;
begin
  if Assigned(FNoStaysOpenList) then
    Result := FNoStaysOpenList.Count
  else
    Result := 0;
end;

procedure TNoStaysOpenList.Add(const Item: TCommonCustomForm);
begin
  if (not (csDestroying in ComponentState)) and
     (Assigned(Item)) and
     (Assigned(FNoStaysOpenList)) then
  begin
    if not FNoStaysOpenList.Contains(Item) then
    begin
      TComponent(Item).FreeNotification(self);
      FNoStaysOpenList.Add(Item);
    end;
  end;
end;

function TNoStaysOpenList.GetItem(const Index: Integer): TCommonCustomForm;
begin
  if (Index >= 0) and (Index < Count) then
  begin
    Result := TCommonCustomForm(FNoStaysOpenList[Index]);
  end
  else
    raise EListError.CreateFMT(sArgumentOutOfRange_Index, [Index, Count]);
end;

procedure TNoStaysOpenList.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    if Assigned(FNoStaysOpenList) then
    begin
      I := FNoStaysOpenList.IndexOf(AComponent);
      if I >= 0 then
        FNoStaysOpenList.Delete(I);
    end;
  end;
end;

procedure TNoStaysOpenList.Remove(const Item: TCommonCustomForm);
var
  I: Integer;
  Instance: TCommonCustomForm;
begin
  if Assigned(Item) and Assigned(FNoStaysOpenList) then
  begin
    I := FNoStaysOpenList.IndexOf(Item);
    if I >= 0 then
    begin
      Instance := TCommonCustomForm(FNoStaysOpenList[I]);
      FNoStaysOpenList.Delete(I);
      if Assigned(Instance) then
        RemoveFreeNotification(Instance);
    end;
  end;
end;

function TNoStaysOpenList.Contains(const Item: TCommonCustomForm): Boolean;
begin
  if Assigned(FNoStaysOpenList) then
    Result := FNoStaysOpenList.Contains(Item)
  else
    Result := False;
end;

type
{ TPlatformWin }

  TUpdateRects = array of TRectF;
  TFullScreenParams = record
    BorderStyle : TFmxFormBorderStyle;
    WindowState : TWindowState;
    Position : TPoint;
    Size : TPoint;
  public
    function IsFullScreen : Boolean;
    procedure Clean;
  end;

  TPlatformWin = class(TInterfacedObject, IFMXApplicationService, IFMXSystemFontService,
    IFMXTimerService, IFMXWindowService, IFMXMenuService, IFMXDragDropService, IFMXClipboardService,
    IFMXCursorService, IFMXMouseService, IFMXScreenService, IFMXLocaleService, IFMXDialogService,
    IFMXTextService, IFMXContextService, IFMXCanvasService, IFMXStyleService, IFMXWindowBorderService,
    IFMXSystemInformationService, IFMXLoggingService)
  private
    FTitle : string;
    FApplicationHWND : HWND;
    FFullScreenSupport : TDictionary<TCommonCustomForm, TFullScreenParams>;
    FHandleCounter: TFmxHandle;
    FHMenuMap: TDictionary<TFmxHandle, TMenuItem>;
    FNoStaysOpenList: TNoStaysOpenList;
    FTimerData: TList<TWin32TimerInfo>;
    FDiableUpdateState: Boolean;
    FThreadSyncHandle: HWND;
    FCreateOSMenu: Boolean;
    FCurrentScreenScale: Single;
    FInDestroyMenuItem: Boolean;
    FInPaintUpdateRects: TDictionary<TWindowHandle, TUpdateRects>;
    FTerminating: Boolean;
    FCursor: TCursor;
    procedure ThreadSync(var Msg: TMessage);
    procedure WakeMainThread(Sender: TObject);
    procedure RemoveChildHandles(const AMenu: IItemsContainer);
    procedure CreateAppHandle ;
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXApplicationService }
    procedure Run;
    procedure Terminate;
    function HandleMessage: Boolean;
    procedure WaitMessage;
    function GetTitle: string;
    function Terminating: Boolean;
    { IFMXSystemFontService }
    function GetDefaultFontFamilyName: string;
    { IFMXTimerService }
    function CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
    function DestroyTimer(Timer: TFmxHandle): Boolean;
    function GetTick: Extended;
    { IFMXWindowService }
    function FindForm(const AHandle: TWindowHandle): TCommonCustomForm;
    function CreateWindow(const AForm: TCommonCustomForm): TWindowHandle;
    procedure DestroyWindow(const AForm: TCommonCustomForm);
    procedure ReleaseWindow(const AForm: TCommonCustomForm);
    procedure SetWindowState(const AForm: TCommonCustomForm; const AState: TWindowState);
    procedure ShowWindow(const AForm: TCommonCustomForm);
    procedure HideWindow(const AForm: TCommonCustomForm);
    procedure BringToFront(const AForm: TCommonCustomForm);
    procedure SendToBack(const AForm: TCommonCustomForm);
    procedure Activate(const AForm: TCommonCustomForm);
    function ShowWindowModal(const AForm: TCommonCustomForm): TModalResult;
    procedure InvalidateWindowRect(const AForm: TCommonCustomForm; R: TRectF);
    procedure InvalidateImmediately(const AForm: TCommonCustomForm);
    procedure SetWindowRect(const AForm: TCommonCustomForm; ARect: TRectF);
    function GetWindowRect(const AForm: TCommonCustomForm): TRectF;
    function GetClientSize(const AForm: TCommonCustomForm): TPointF;
    procedure SetClientSize(const AForm: TCommonCustomForm; const ASize: TPointF);
    procedure SetWindowCaption(const AForm: TCommonCustomForm; const ACaption: string);
    procedure SetCapture(const AForm: TCommonCustomForm);
    procedure ReleaseCapture(const AForm: TCommonCustomForm);
    function ClientToScreen(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
    function ScreenToClient(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
    function GetWindowScale(const AForm: TCommonCustomForm): Single;
    property CurrentScreenScale: Single read FCurrentScreenScale write FCurrentScreenScale; // for desingtime and testing only
    procedure SetFullScreen(const AForm: TCommonCustomForm; const AValue: Boolean);
    function GetFullScreen(const AForm: TCommonCustomForm): Boolean;
    procedure SetShowFullScreenIcon(const AForm: TCommonCustomForm; const AValue: Boolean);
    { IFMXWindowBorderService }
    function CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
    { IFMXMenuService }
    procedure StartMenuLoop(const AView: IMenuView);
    function ShortCutToText(ShortCut: TShortCut): string;
    procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
    function TextToShortCut(Text: string):integer;
    procedure CreateOSMenu(AForm: TCommonCustomForm; const AMenu: IItemsContainer);
    procedure UpdateMenuItem(const AItem: IItemsContainer; AChange: TMenuItemChanges);
    procedure DestroyMenuItem(const AItem: IItemsContainer);
    function IsMenuBarOnWindowBorder: boolean;
    procedure UpdateMenuBar;
    { IFMXDragDropService }
    procedure BeginDragDrop(AForm: TCommonCustomForm; const Data: TDragObject; ABitmap: TBitmap);
    { IFMXClipboardService }
    procedure SetClipboard(Value: TValue);
    function GetClipboard: TValue;
    { IFMXCursorService }
    procedure SetCursor(const ACursor: TCursor);
    function GetCursor: TCursor;
    { IFMXMouseService }
    function GetMousePos: TPointF;
    { IFMXScreenService }
    function GetScreenSize: TPointF;
    function GetScreenScale: Single;
    function GetScreenOrientation: TScreenOrientation;
    { IFMXLocaleService }
    function GetCurrentLangID: string;
    function GetLocaleFirstDayOfWeek: string;
    { IFMXDialogService }
    function DialogOpenFiles(var FileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
      var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
    function DialogPrint(var ACollate, APrintToFile: Boolean;
      var AFromPage, AToPage, ACopies: Integer; AMinPage, AMaxPage: Integer; var APrintRange: TPrintRange;
      AOptions: TPrintDialogOptions): Boolean;
    function PageSetupGetDefaults(var AMargin, AMinMargin: TRect; var APaperSize: TPointF;
      AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
    function DialogPageSetup(var AMargin, AMinMargin :TRect; var APaperSize: TPointF;
      var AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
    function DialogSaveFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
      var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
    function DialogPrinterSetup: Boolean;
    function MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
      DefaultButton: TMsgDlgBtn; X, Y: Integer; HelpCtx: Longint; const HelpFileName: string): Integer;
    function InputQuery(const ACaption: string; const APrompts: array of string;
      var AValues: array of string; CloseQueryFunc: TInputCloseQueryFunc = nil): Boolean;
    { IFMXTextService }
    function GetTextServiceClass: TTextServiceClass;
    { IFMXContextService }
    procedure RegisterContextClasses;
    procedure UnregisterContextClasses;
    { IFMXCanvasService }
    procedure RegisterCanvasClasses;
    procedure UnregisterCanvasClasses;
    { IFMXStyleService }
    function GetSystemStyle: TFmxObject;
    { IFMXSystemInformationService }
    function GetScrollingBehaviour: TScrollingBehaviours;
    function GetMinScrollThumbSize: Single;
    function GetCaretWidth: Integer;
    procedure Log(Fmt: String; Params: array of const);
  end;

  TVirtualKeyboardWin = class(TInterfacedObject, IFMXVirtualKeyboardService)
  private type
    TvkbState = (vkbsNone, vkbsHide, vkbsVisible);
  private
    FEnableRedirection: boolean;
    FPath: string;
    FExeName: string;
    FWndClassName: string;
    FHTmerLang: TFmxHandle;
    FHTmerVisible: TFmxHandle;
    FKBPresent: boolean;
    FFormHandle: HWND;
    FInst: HINST;
    FError: boolean;
    FLastvkbState: TvkbState;
    FLastHandle: HWND;
    FLastTime: TDateTime;
    FNewvkbState: TvkbState;
    FWait: boolean;
    FStepActivate: integer;
    FVersion: integer;
    FCodeKeyboard: HKL;
    FTimerService: IFMXTimerService;

    procedure KillTimerLang;
    procedure TimerLangProc;
    procedure StartTimerLang;


    procedure KillTimerVisible;
    procedure TimerVisibleProc;
    procedure StartTimerVisible;
    function FindKeyValue(const Key: HKey; const Name, Value, SubKeyName,
      SubValueName: string): string;
    procedure DisableRedirection;
    procedure EnableRedirection;
    function GetVirtualKeyBoardState: TVirtualKeyBoardState;
    procedure vkbExecute(FormHandle: HWND);
    function vkbHandle: HWND;
    function vkbState: TvkbState;
    function GetVKBounds: TRect;
  protected
    procedure Clear;
    function IsAutoShow: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function ShowVirtualKeyboard(const AControl: TFmxObject): boolean;
    function HideVirtualKeyboard: boolean;
    property VirtualKeyBoardState: TVirtualKeyBoardState read GetVirtualKeyBoardState;
    property ExeName: string read FExeName write FExeName;
    property Path: string read FPath write FPath;
    property WndClassName: string read FWndClassName write FWndClassName;
  end;

var
  VirtualKeyboardWin: TVirtualKeyboardWin;
  
const
  WM_ADDUPDATERECT = WM_USER + 123;
  WM_RELEASEFORM = WM_USER + 125;

var
  WindowAtom: TAtom;
  WindowAtomString: string;
  DropAtom: TAtom;
  DropAtomString: string;
  CF_OBJECT: Longint;
  PlatformWin: TPlatformWin;
  CapturedGestureControl : TFmxObject;

procedure RegisterCorePlatformServices;
begin
  PlatformWin := TPlatformWin.Create;
  TPlatformServices.Current.AddPlatformService(IFMXApplicationService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXSystemFontService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXTimerService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXWindowService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXMenuService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXDragDropService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXClipboardService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXCursorService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXMouseService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXScreenService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXLocaleService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXDialogService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXTextService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXContextService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXCanvasService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXStyleService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXWindowBorderService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXSystemInformationService, PlatformWin);
  TPlatformServices.Current.AddPlatformService(IFMXLoggingService, PlatformWin);

  VirtualKeyboardWin := TVirtualKeyboardWin.Create;
  TPlatformServices.Current.AddPlatformService(IFMXVirtualKeyboardService, VirtualKeyboardWin);
end;

procedure UnregisterCorePlatformServices;
begin

  TPlatformServices.Current.RemovePlatformService(IFMXApplicationService);
  TPlatformServices.Current.RemovePlatformService(IFMXSystemFontService);
  TPlatformServices.Current.RemovePlatformService(IFMXTimerService);
  TPlatformServices.Current.RemovePlatformService(IFMXWindowService);
  TPlatformServices.Current.RemovePlatformService(IFMXMenuService);
  TPlatformServices.Current.RemovePlatformService(IFMXDragDropService);
  TPlatformServices.Current.RemovePlatformService(IFMXClipboardService);
  TPlatformServices.Current.RemovePlatformService(IFMXCursorService);
  TPlatformServices.Current.RemovePlatformService(IFMXMouseService);
  TPlatformServices.Current.RemovePlatformService(IFMXScreenService);
  TPlatformServices.Current.RemovePlatformService(IFMXLocaleService);
  TPlatformServices.Current.RemovePlatformService(IFMXDialogService);
  TPlatformServices.Current.RemovePlatformService(IFMXTextService);
  TPlatformServices.Current.RemovePlatformService(IFMXContextService);
  TPlatformServices.Current.RemovePlatformService(IFMXCanvasService);
  TPlatformServices.Current.RemovePlatformService(IFMXStyleService);
  TPlatformServices.Current.RemovePlatformService(IFMXWindowBorderService);
  TPlatformServices.Current.RemovePlatformService(IFMXSystemInformationService);

  TPlatformServices.Current.RemovePlatformService(IFMXVirtualKeyboardService);
end;

function HBmpFromBitmap(const Bitmap: TBitmap): THandle;
var
  BitmapInfo: TBitmapInfo;
  BitmapBits: Pointer;
  M: TBitmapData;
  I: Integer;
begin
  FillChar(BitmapInfo, SizeOf(BitmapInfo), 0);
  BitmapInfo.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  BitmapInfo.bmiHeader.biPlanes := 1;
  BitmapInfo.bmiHeader.biBitCount := 32;
  BitmapInfo.bmiHeader.biCompression := BI_RGB;
  BitmapInfo.bmiHeader.biWidth := Bitmap.Width;
  if BitmapInfo.bmiHeader.biWidth <= 0 then
    BitmapInfo.bmiHeader.biWidth := 1;
  BitmapInfo.bmiHeader.biHeight := -Bitmap.Height;
  if BitmapInfo.bmiHeader.biHeight >= 0 then
    BitmapInfo.bmiHeader.biHeight := -1;
  Result := CreateDIBSection(0, BitmapInfo, DIB_RGB_COLORS, Pointer(BitmapBits), 0, 0);
  if BitmapBits <> nil then
  begin
    if Bitmap.Map(TMapAccess.maRead, M) then
    try
      for I := 0 to Bitmap.Height - 1 do
        Move(PAlphaColorArray(M.Data)[I * (M.Pitch div 4)],
             PAlphaColorArray(BitmapBits)[I * Bitmap.Width],
             Bitmap.Width * 4);
    finally
      Bitmap.Unmap(M);
    end;
  end;
end;

function FindTopMostWindow(ActiveWindow: HWnd): HWnd; forward;

procedure SetScreenScale(ScreenScale: Single);
begin
  PlatformWin.CurrentScreenScale := ScreenScale;
end;

{ TPlatformWin }

constructor TPlatformWin.Create;
begin
  inherited;
  FCurrentScreenScale := 1;
  WindowAtomString := Format('FIREMONKEY%.8X', [GetCurrentProcessID]);
  WindowAtom := GlobalAddAtomW(PChar(WindowAtomString));
  DropAtomString := Format('FIREMONKEYDROP%.8X', [GetCurrentProcessID]);
  DropAtom := GlobalAddAtomW(PChar(DropAtomString));
  CF_OBJECT := RegisterClipBoardFormatW(PChar('WindowAtomString'));
  FNoStaysOpenList := TNoStaysOpenList.Create(nil);
  FTimerData := TList<TWin32TimerInfo>.Create;
  FHMenuMap := TDictionary<TFmxHandle, TMenuItem>.Create;
  FFullScreenSupport := TDictionary<TCommonCustomForm, TFullScreenParams>.Create;
  FInPaintUpdateRects := TDictionary<TWindowHandle, TUpdateRects>.Create;
  FHandleCounter := 128; // Start counting handles at 128. All valid handles have lower nibble = 0;
  FThreadSyncHandle := AllocateHWnd(ThreadSync);
  System.Classes.WakeMainThread := WakeMainThread;
  Application := TApplication.Create(nil);
end;

var
  FMAppClass: TWndClass = (
    style: 0;
    lpfnWndProc: @DefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'TFMAppClass');

procedure TPlatformWin.CreateAppHandle;
var
  TempClass: TWndClass;
  P: PChar;
  ClassRegistered: Boolean;
  ModuleName: array[0..255] of Char;
  AtomName : string;
  AppAtom : Word;
begin
  GetModuleFileName(MainInstance, ModuleName, Length(ModuleName));
  P := AnsiStrRScan(ModuleName, '\');
  if P <> nil then
    StrCopy(ModuleName, P + 1);
  P := AnsiStrScan(ModuleName, '.');
  if P <> nil then
    P^ := #0;
  AtomName := ModuleName;
  AppAtom := GlobalFindAtom(PChar(AtomName));
  if AppAtom>0 then
    FApplicationHWND := 0
  else
  begin
    CharLower(CharNext(ModuleName));
    FTitle := ModuleName;
    FMAppClass.hInstance := HInstance;
    ClassRegistered := GetClassInfo(HInstance, FMAppClass.lpszClassName,
      TempClass);
    FMAppClass.hIcon := LoadIconW(MainInstance, PChar('MAINICON'));
    if not ClassRegistered or (TempClass.lpfnWndProc <> @DefWindowProc) then
    begin
      if ClassRegistered then
        Winapi.Windows.UnregisterClass(FMAppClass.lpszClassName, HInstance);
      Winapi.Windows.RegisterClass(FMAppClass);
    end;
    FApplicationHWND := CreateWindowEx(0, FMAppClass.lpszClassName,
      PChar(FTitle),
      WS_POPUP ,
      0,0,0,0, GetDesktopWindow, 0, HInstance, nil);
    Winapi.Windows.ShowWindow(FApplicationHWND, SW_SHOWNORMAL);
  end;
end;

destructor TPlatformWin.Destroy;
begin
  FreeAndNil(Application);
  FInPaintUpdateRects.Free;
  FHMenuMap.Free;
  FFullScreenSupport.Free;
  FTimerData.Free;
  FNoStaysOpenList.Free;
  if FThreadSyncHandle <> 0 then
    DeallocateHWnd(FThreadSyncHandle);
  inherited;
end;

{ App }

procedure TPlatformWin.Run;
begin
  Application.RealCreateForms;
  repeat
    try
      Application.HandleMessage;
    except
      Application.HandleException(Self);
    end;
  until Application.Terminated;
end;

procedure TPlatformWin.Terminate;
var
  D: TWin32TimerInfo;
  L: TList<TFmxHandle>;
  I: Integer;
begin
  FTerminating := True;
  L := TList<TFmxHandle>.Create;
  try
    for D in FTimerData do
      if D.TimerHandle <> 0 then
        L.Add(D.TimerHandle);
    for I := L.Count - 1 downto 0 do
    try
      DestroyTimer(L[I]);
    except
      Continue;
    end;
  finally
    FreeAndNil(L);
  end;
  PostQuitMessage(0);
end;

function TPlatformWin.Terminating: boolean;
begin
  Result := FTerminating;
end;

function TPlatformWin.HandleMessage: Boolean;
var
  Msg: TMsg;
begin
  Result := False;
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
  begin
    Result := True;
    if Msg.Message <> WM_QUIT then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end
    else
      Application.Terminated := True;
  end;
end;

procedure TPlatformWin.WaitMessage;
begin
  Winapi.Windows.WaitMessage;
end;

function TPlatformWin.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TPlatformWin.WakeMainThread(Sender: TObject);
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    PostMessage(FThreadSyncHandle, WM_NULL, 0, 0);
end;

{ Timer }

procedure TimerCallBackProc(window_hwnd: hwnd; Msg: Longint; idEvent: UINT; dwTime: Longint); stdcall;
var
  Index: Integer;
begin
  try
    Index := PlatformWin.FTimerData.Count;
    while (Index > 0) do
    begin
      Dec(Index);
      if PlatformWin.FTimerData[Index].TimerID = idEvent then
      begin
        PlatformWin.FTimerData[Index].TimerFunc;
        Break;
      end;
    end;
  except
    on E: Exception do
    begin
      if Assigned(Application) then
        Application.HandleException(nil)
      else
        Raise;
    end;
  end;
end;

function TPlatformWin.CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
var
  TimerInfo: TWin32TimerInfo;
begin
  Result := 0;
  if (not FTerminating) and (Interval > 0) and (Assigned(TimerFunc)) then
  begin
    TimerInfo.TimerFunc := TimerFunc;
    TimerInfo.TimerID := Winapi.Windows.SetTimer(0, 0, Interval, @TimerCallBackProc);
    if TimerInfo.TimerID <> 0 then
    begin
      {$IFDEF CPUX64}
      TimerInfo.TimerHandle := TInterlocked.Add(Int64(FHandleCounter), 16);
      {$ENDIF}
      {$IFDEF CPUX86}
      TimerInfo.TimerHandle := TInterlocked.Add(Integer(FHandleCounter), 16);
      {$ENDIF}
      FTimerData.Add(TimerInfo);
      Result := TimerInfo.TimerHandle;
    end;
  end;
end;

function TPlatformWin.DestroyTimer(Timer: TFmxHandle): Boolean;
var
  Index: Integer;
begin
  Result := False;
  Index := FTimerData.Count;
  while (Index > 0) do
  begin
    Dec(Index);
    if FTimerData[Index].TimerHandle = Timer then
    begin
      Result := Winapi.Windows.KillTimer(0, FTimerData[Index].TimerID);
      FTimerData.Delete(Index);
    end;
  end;
end;

function TPlatformWin.GetTick: Extended;
begin
  Result := timeGetTime / 1000;
end;

{ Text Service }

// Missing API.
{$WARNINGS OFF}
// Here we ignore the warning E1002, because this code runs only on Windows.
function ImmAssociateContextEx(hWnd: HWND; hImc: HIMC; dwFlag: DWORD): HIMC; stdcall;
  external imm32 name 'ImmAssociateContextEx' delayed;
{$WARNINGS ON}

const
  IACE_CHILDREN        = $0001;
  IACE_DEFAULT         = $0010;
  IACE_IGNORENOCONTEXT = $0020;

type
  TTextServiceWin = class(TTextService)
  private
    FCaretPosition: TPoint;
    FText : string;
    FMarkedText : string;
    FImeMode: TImeMode;
    FWorking: Boolean;
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
    function GetCaretPostion: TPoint; override;
    procedure SetCaretPosition(const Value: TPoint); override;

  public
    CompAttrBuf: Array of Byte;
    ImmCompCursorPos: Integer;
    CompClauseBuf: Array of DWORD;

    procedure InternalSetMarkedText( const AMarkedText: string ); override;
    function InternalGetMarkedText: string; override;
    procedure InternalStartIMEInput;
    procedure InternalBreakIMEInput;
    procedure InternalEndIMEInput;

    function CombinedText: string; override;
    function TargetClausePosition: TPoint; override;

    procedure EnterControl(const FormHandle: TWindowHandle); override;
    procedure ExitControl(const FormHandle: TWindowHandle); override;

    procedure DrawSingleLine( const Canvas: TCanvas;
      const ARect: TRectF; const FirstVisibleChar: integer; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False); overload; override;

    procedure DrawSingleLine( const Canvas: TCanvas; const S: string;
      const ARect: TRectF; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False); overload; override;

    function HasMarkedText: boolean; override;

    function GetImeMode: TImeMode; override;
    procedure SetImeMode(const Value: TImeMode); override;

    { Windows }
    constructor Create(const Owner: IControl; SupportMultiLine: Boolean); override;
    destructor Destroy; override;

  end;

{ Text Service }

constructor TTextServiceWin.Create(const Owner: IControl; SupportMultiLine: Boolean);
begin
  inherited;
end;

destructor TTextServiceWin.Destroy;
begin
  inherited;
end;

function TTextServiceWin.GetText: string;
begin
  Result := FText;
end;

procedure TTextServiceWin.SetText(const Value: string);
begin
  FText := Value;
end;

function TTextServiceWin.GetCaretPostion: TPoint;
begin
  Result := FCaretPosition;
end;

procedure TTextServiceWin.SetCaretPosition(const Value: TPoint);
begin
  FCaretPosition := Value;
end;

procedure TTextServiceWin.InternalSetMarkedText( const AMarkedText: string );
begin
  if not FWorking then
    Exit;
  FMarkedText := AMarkedText;
  // Need update.
  (FOwner as ITextInput).UpdateCaretPoint;
end;

procedure TTextServiceWin.InternalStartIMEInput;
begin
  if FWorking then
    Exit;
  FWorking := True;
  (FOwner as ITextInput).StartIMEInput;
end;

function TTextServiceWin.InternalGetMarkedText: string;
begin
  Result := FMarkedText;
end;

procedure TTextServiceWin.InternalBreakIMEInput;
begin
  if not FWorking then
    Exit;
  FMarkedText := EmptyStr;
  ImmCompCursorPos := 0;
  (FOwner as ITextInput).UpdateCaretPoint;
  FWorking := False;
end;

function TTextServiceWin.CombinedText: string;
begin
  if FMarkedText <> '' then
    Result := FText.Substring(0, FCaretPosition.X) + FMarkedText + FText.Substring(FCaretPosition.X, MaxInt)
  else
    Result := FText;
end;

function TTextServiceWin.TargetClausePosition: TPoint;
begin
  Result := FCaretPosition;
  Result.X := Result.X + ImmCompCursorPos;
end;

procedure TTextServiceWin.InternalEndIMEInput;
begin
  if not FWorking then
    Exit;
  (FOwner as ITextInput).EndIMEInput;
  FMarkedText := EmptyStr;
  ImmCompCursorPos := 0;
  FWorking := False;
end;

procedure TTextServiceWin.EnterControl(const FormHandle: TWindowHandle);
var
  wHandle: HWND;
  CForm: TCompositionForm;
  H : HIMC;
begin
  wHandle := WindowHandleToPlatform(FormHandle).Wnd;
  ImmAssociateContextEx(wHandle, 0, IACE_DEFAULT);
  H := ImmGetContext(wHandle);
  if H <> 0 then
  begin
    CForm.dwStyle := CFS_POINT;
    CForm.ptCurrentPos := (FOwner as ITextInput).GetTargetClausePointF.Round;
    ImmSetCompositionWindow(H, @CForm);
  end;
end;

procedure TTextServiceWin.ExitControl(const FormHandle: TWindowHandle);
begin
  ImmAssociateContextEx(WindowHandleToPlatform(FormHandle).Wnd, 0, IACE_IGNORENOCONTEXT);
end;

procedure TTextServiceWin.DrawSingleLine( const Canvas: TCanvas;
      const ARect: TRectF; const FirstVisibleChar: integer; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False);
var
  I, J: Integer;
  S: string;
  Layout: TTextLayout;
  Region: TRegion;
begin
  Layout := TTextLayoutManager.TextLayoutByCanvas(Canvas.ClassType).Create;
  try
    Layout.BeginUpdate;
    Layout.TopLeft := ARect.TopLeft;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.WordWrap := AWordWrap;
    Layout.HorizontalAlign := ATextAlign;
    Layout.VerticalAlign := AVTextAlign;
    Layout.Font := Font;
    Layout.Color := Canvas.Fill.Color;
    Layout.Opacity := AOpacity;
    Layout.RightToLeft := TFillTextFlag.ftRightToLeft in Flags;
    S := CombinedText;
    Layout.Text := S.Substring(FirstVisibleChar - 1, S.Length - FirstVisibleChar + 1);
    Layout.EndUpdate;
    Layout.RenderLayout(Canvas);

    if (FMarkedText.Length > 0) and (Length(CompAttrBuf) > 0) then
    begin
      Canvas.Stroke.Assign(Canvas.Fill);
      Canvas.Stroke.Thickness := 2;
      Canvas.Stroke.Dash := TStrokeDash.sdSolid;
      try
        for I := 1 to FMarkedText.Length do
        begin
          case CompAttrBuf[I - 1] of
            ATTR_INPUT:
            begin
              Canvas.Stroke.Thickness := 1;
              Canvas.Stroke.Dash := TStrokeDash.sdDash
            end;
            ATTR_TARGET_CONVERTED:
            begin
              Canvas.Stroke.Thickness := 2;
              Canvas.Stroke.Dash := TStrokeDash.sdSolid;
            end;
            ATTR_CONVERTED:
            begin
              Canvas.Stroke.Thickness := 1;
              Canvas.Stroke.Dash := TStrokeDash.sdSolid;
            end;
            ATTR_TARGET_NOTCONVERTED:
            begin
              Canvas.Stroke.Thickness := 4;
              Canvas.Stroke.Dash := TStrokeDash.sdSolid;
            end;
            ATTR_INPUT_ERROR:
            begin
              Canvas.Stroke.Thickness := 1;
              Canvas.Stroke.Dash := TStrokeDash.sdDot
            end;
          end;

          Region := Layout.RegionForRange(TTextRange.Create(Max(0, CaretPosition.X + I - FirstVisibleChar), 1));
          for J := Low(Region) to High(Region) do
            Canvas.DrawLine(
              PointF(Region[J].Left, Region[J].Bottom),
              PointF(Region[J].Right, Region[J].Bottom),
              AOpacity, Canvas.Stroke);
        end;
      finally
        Canvas.Stroke.Thickness := 1;
        Canvas.Stroke.Dash := TStrokeDash.sdSolid;
      end;
    end;
  finally
    FreeAndNil(Layout);
  end;
end;

procedure TTextServiceWin.DrawSingleLine( const Canvas: TCanvas; const S: string;
      const ARect: TRectF;
      const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False);
var
  I, J: Integer;
  Layout: TTextLayout;
  Region: TRegion;
begin
  Layout := TTextLayoutManager.TextLayoutByCanvas(Canvas.ClassType).Create;
  try
    Layout.BeginUpdate;
    Layout.TopLeft := ARect.TopLeft;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.WordWrap := AWordWrap;
    Layout.HorizontalAlign := ATextAlign;
    Layout.VerticalAlign := AVTextAlign;
    Layout.Font := Font;
    Layout.Color := Canvas.Fill.Color;
    Layout.Opacity := AOpacity;
    Layout.RightToLeft := TFillTextFlag.ftRightToLeft in Flags;
    Layout.Text := S;
    Layout.EndUpdate;
    Layout.RenderLayout(Canvas);

    if (FMarkedText.Length > 0) and (Length(CompAttrBuf) > 0) then
    begin
      Canvas.Stroke.Assign(Canvas.Fill);
      Canvas.Stroke.Thickness := 2;
      Canvas.Stroke.Dash := TStrokeDash.sdSolid;
      try
        for I := 1 to FMarkedText.Length do
        begin
          case CompAttrBuf[I - 1] of
            ATTR_INPUT:
            begin
              Canvas.Stroke.Thickness := 1;
              Canvas.Stroke.Dash := TStrokeDash.sdDash
            end;
            ATTR_TARGET_CONVERTED:
            begin
              Canvas.Stroke.Thickness := 2;
              Canvas.Stroke.Dash := TStrokeDash.sdSolid;
            end;
            ATTR_CONVERTED:
            begin
              Canvas.Stroke.Thickness := 1;
              Canvas.Stroke.Dash := TStrokeDash.sdSolid;
            end;
            ATTR_TARGET_NOTCONVERTED:
            begin
              Canvas.Stroke.Thickness := 4;
              Canvas.Stroke.Dash := TStrokeDash.sdSolid;
            end;
            ATTR_INPUT_ERROR:
            begin
              Canvas.Stroke.Thickness := 1;
              Canvas.Stroke.Dash := TStrokeDash.sdDot
            end;
          end;

          Region := Layout.RegionForRange(TTextRange.Create(Max(0, CaretPosition.X + I), 1));
          for J := Low(Region) to High(Region) do
            Canvas.DrawLine(
              PointF(Region[J].Left, Region[J].Bottom),
              PointF(Region[J].Right, Region[J].Bottom),
              AOpacity, Canvas.Stroke);
        end;
      finally
        Canvas.Stroke.Thickness := 1;
        Canvas.Stroke.Dash := TStrokeDash.sdSolid;
      end;
    end;
  finally
    FreeAndNil(Layout);
  end;
end;

function TTextServiceWin.HasMarkedText: boolean;
begin
  Result := FMarkedText <> '';
end;

function TTextServiceWin.GetImeMode: TImeMode;
begin
  Result := FImeMode;
end;

procedure TTextServiceWin.SetImeMode(const Value: TImeMode);
begin
  FImeMode := Value;
end;

function TPlatformWin.GetTextServiceClass: TTextServiceClass;
begin
  Result := TTextServiceWin;
end;

{ Window }

type
  PRgnRects = ^TRgnRects;
  TRgnRects = array [0 .. 0] of TRect;

constructor TWinWindowHandle.Create(const AForm: TCommonCustomForm; const AWnd: HWnd);
begin
  inherited Create;
  FForm := AForm;
  FWnd := AWnd;
end;

function FindWindow(Handle: HWND): TCommonCustomForm;
begin
  Result := nil;
  if (Handle <> 0) then
  begin
    if GlobalFindAtomW(PChar(WindowAtomString)) = WindowAtom then
      Result := Pointer(GetProp(Handle, MakeIntAtom(WindowAtom)))
    else
      Result := nil;
  end;
end;

function FmxHandleToHWND(const FmxHandle: TWindowHandle): HWND;
begin
  if Assigned(FmxHandle) then
    Result :=WindowHandleToPlatform(FmxHandle).Wnd
  else
    Result := 0;
end;

function WindowHandleToPlatform(const AHandle: TWindowHandle): TWinWindowHandle;
begin
  Result := TWinWindowHandle(AHandle);
end;

destructor TWinWindowHandle.Destroy;
begin
  FreeBuffer;
  inherited;
end;

procedure TWinWindowHandle.CreateBuffer;
begin
  FBufferSize := TSize.Create(Width, Height);
  FBitmapInfo.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  FBitmapInfo.bmiHeader.biPlanes := 1;
  FBitmapInfo.bmiHeader.biBitCount := 32;
  FBitmapInfo.bmiHeader.biCompression := BI_RGB;
  FBitmapInfo.bmiHeader.biWidth := FBufferSize.Width;
  if FBitmapInfo.bmiHeader.biWidth <= 0 then
    FBitmapInfo.bmiHeader.biWidth := 1;
  FBitmapInfo.bmiHeader.biHeight := -FBufferSize.Height;
  if FBitmapInfo.bmiHeader.biHeight >= 0 then
    FBitmapInfo.bmiHeader.biHeight := -1;
  try
    FBufferBitmap := CreateDIBSection(0, FBitmapInfo, DIB_RGB_COLORS, Pointer(FBufferBits), 0, 0);
    if FBufferBits = nil then
      RaiseLastOSError;
    try
      FBufferHandle := CreateCompatibleDC(0);
      if FBufferHandle = 0 then
        RaiseLastOSError;
      try
        if SelectObject(FBufferHandle, FBufferBitmap) = 0 then
          RaiseLastOSError;
      except
        DeleteDC(FBufferHandle);
        FBufferHandle := 0;
        raise;
      end;
    except
      DeleteObject(FBufferBitmap);
      FBufferBits := nil;
      raise;
    end;
  except
    FBufferBitmap := 0;
    raise;
  end;
end;

procedure TWinWindowHandle.ResizeBuffer(const Width, Height: Integer);
begin
  if FBufferHandle = 0 then
    CreateBuffer(Width, Height)
  else if (FBitmapInfo.bmiHeader.biWidth <> Width) or (Abs(FBitmapInfo.bmiHeader.biHeight) <> Height) then
  begin
    FreeBuffer;
    CreateBuffer(Width, Height)
  end;
end;

procedure TWinWindowHandle.FreeBuffer;
begin
  if FBufferHandle <> 0 then
    DeleteDC(FBufferHandle);
  if FBufferBitmap <> 0 then
    DeleteObject(FBufferBitmap);
end;

procedure TWinWindowHandle.UpdateLayer;
var
  Blend: TBlendFunction;
  Origin, Size, BitmapOrigin: TPoint;
  ContextObject: IContextObject;
begin
  if FBufferHandle <> 0 then
  begin
    { Copy from Context }
    if Supports(Form, IContextObject, ContextObject) and Assigned(ContextObject.Context) then
      ContextObject.Context.CopyToBits(FBufferBits, Form.Width * 4, Rect(0, 0, Form.Width, Form.Height));
    { Update }
    Origin := Point(Form.Left, Form.Top);
    Size := Point(Form.Width, Form.Height);
    Blend.BlendOp := AC_SRC_OVER;
    Blend.AlphaFormat := $01; // AC_SRC_ALPHA;
    Blend.BlendFlags := 0;
    Blend.SourceConstantAlpha := $FF;
    BitmapOrigin := Point(0, 0);
    UpdateLayeredWindow(WindowHandleToPlatform(Form.Handle).Wnd, 0, @Origin, @Size, FBufferHandle, @BitmapOrigin, $00000000, @Blend,
      ULW_ALPHA);
  end;
end;

function FindDropTarget(Handle: HWND): TDropTarget;
begin
  Result := nil;
  if (Handle <> 0) then
  begin
    if GlobalFindAtomW(PChar(DropAtomString)) = DropAtom then
      Result := Pointer(GetProp(Handle, MakeIntAtom(DropAtom)))
    else
      Result := nil;
  end;
end;

function KeysToShiftState(Keys: Word): TShiftState;
begin
  Result := [];
  if Keys and MK_SHIFT <> 0 then
    Include(Result, ssShift);
  if Keys and MK_CONTROL <> 0 then
    Include(Result, ssCtrl);
  if Keys and MK_LBUTTON <> 0 then
    Include(Result, ssLeft);
  if Keys and MK_RBUTTON <> 0 then
    Include(Result, ssRight);
  if Keys and MK_MBUTTON <> 0 then
    Include(Result, ssMiddle);
  if GetKeyState(VK_MENU) < 0 then
    Include(Result, ssAlt);
end;

function KeyDataToShiftState(KeyData: Longint): TShiftState;
const
  AltMask = $20000000;
{$IFDEF LINUX}
  CtrlMask = $10000000;
  ShiftMask = $08000000;
{$ENDIF}
begin
  Result := [];
  if GetKeyState(VK_SHIFT) < 0 then
    Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then
    Include(Result, ssCtrl);
  if KeyData and AltMask <> 0 then
    Include(Result, ssAlt);
{$IFDEF LINUX}
  if KeyData and CtrlMask <> 0 then
    Include(Result, ssCtrl);
  if KeyData and ShiftMask <> 0 then
    Include(Result, ssShift);
{$ENDIF}
end;

function WMPaint(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  i, rgnStatus: Integer;
  Region: HRgn;
  RegionSize: Integer;
  RegionData: PRgnData;
  R: TRect;
  LForm: TCommonCustomForm;
  UpdateRects, InPaintUpdateRects: TUpdateRects;
  PS: TPaintStruct;
  Wnd: Winapi.Windows.HWND;
  PaintControl: IPaintControl;
begin
  LForm := FindWindow(hwnd);
  if LForm <> nil then
  begin
    Wnd := WindowHandleToPlatform(LForm.Handle).Wnd;
    GetUpdateRect(Wnd, R, False);
    Region := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
    if Region <> 0 then
    try
      rgnStatus := GetUpdateRgn(Wnd, Region, False);
      if (rgnStatus = 2) or (rgnStatus = 3) then
      begin
        RegionSize := GetRegionData(Region, $FFFF, nil);
        if RegionSize > 0 then
        begin
          GetMem(RegionData, RegionSize);
          try
            RegionSize := GetRegionData(Region, RegionSize, RegionData);
            if RegionSize = RegionSize then
            begin
              SetLength(UpdateRects, RegionData.rdh.nCount);
              for i := 0 to RegionData.rdh.nCount - 1 do
              begin
                R := PRgnRects(@RegionData.buffer[0])[i];
                UpdateRects[i] := RectF(R.Left, R.Top, R.Right, R.Bottom);
              end;
            end;
          finally
            FreeMem(RegionData, RegionSize);
          end;
          if Supports(LForm, IPaintControl, PaintControl) then
          begin
            PaintControl.ContextHandle := BeginPaint(Wnd, PS);
            try
              if PlatformWin.FInPaintUpdateRects.TryGetValue(LForm.Handle, InPaintUpdateRects) and (Length(InPaintUpdateRects) > 0) then
              begin
                // add update rects from FInPaintUpdateRects
                for I := 0 to High(InPaintUpdateRects) do
                begin
                  SetLength(UpdateRects, Length(UpdateRects) + 1);
                  UpdateRects[High(UpdateRects)] := InPaintUpdateRects[I];
                end;
              end;
              PaintControl.PaintRects(UpdateRects);
              if PlatformWin.FInPaintUpdateRects.TryGetValue(LForm.Handle, InPaintUpdateRects) and (Length(InPaintUpdateRects) > 0) then
              begin
                // paint second time - when Repaint called in painting
                PlatformWin.FInPaintUpdateRects.TryGetValue(LForm.Handle, UpdateRects);
                SetLength(InPaintUpdateRects, 0);
                PlatformWin.FInPaintUpdateRects.AddOrSetValue(LForm.Handle, InPaintUpdateRects);
                PaintControl.PaintRects(UpdateRects);
              end;
              PaintControl.ContextHandle := 0;
            finally
              EndPaint(Wnd, PS);
            end;
          end;
        end;
      end;
    finally
      DeleteObject(Region);
    end;
    Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
  end
  else
    Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
end;

function WMImeStartComposition(const AForm: TCommonCustomForm; hWnd: HWND; uMsg: UINT; wParam: wParam; lParam: lParam): LRESULT;
var
  TSObj: ITextInput;
begin
  if (AForm.Focused <> nil) and Supports(AForm.Focused, ITextInput, TSObj) then
    TTextServiceWin(TSObj.GetTextService).InternalStartIMEInput;
  if System.SysUtils.Win32MajorVersion >= 6 then
    Result := DefWindowProc(hWnd, uMsg, wParam, lParam)
  else
    Result := 0;
end;

function WMImeComposition(const AForm: TCommonCustomForm; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  IMC: HIMC;
  S: String;
  Size: Integer;
  Wnd: HWND;
  TSObj: ITextInput;
  TS: TTextServiceWin;
  I: Integer;
  Key: Word;
  Ch: Char;
begin
  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;

  if (lParam and GCS_RESULTSTR) <> 0 then
  begin
    IMC := ImmGetContext(Wnd);
    if IMC <> 0 then
    begin
      try
        if (AForm.Focused <> nil) and Supports(AForm.Focused, ITextInput, TSObj) then
        begin
          if not TTextServiceWin(TSObj.GetTextService).FWorking then
            Exit(0);
          TTextServiceWin(TSObj.GetTextService).InternalBreakIMEInput;
        end;
        Size := ImmGetCompositionString(IMC, GCS_RESULTSTR, nil, 0);
        SetLength(S, Size div SizeOf(Char));
        ImmGetCompositionString(IMC, GCS_RESULTSTR, PChar(S), Size);
      finally
        ImmReleaseContext(Wnd, IMC);
      end;
      for I := 0 to S.Length - 1 do
      begin
        Key := 0;
        Ch := S.Chars[I];
        AForm.KeyDown(Key, Ch, []);
        AForm.KeyUp(Key, Ch, []);
      end;
    end;
    Result := 0;
    if (GetKeyboardLayout(0) and $FFFF) = $0412 then // Special support for Korean IME
      SendMessage(Wnd, WM_IME_STARTCOMPOSITION, 0, 0);
  end
  else
  if (lParam and GCS_COMPSTR) <> 0 then
  begin
    IMC := ImmGetContext(Wnd);
    if IMC <> 0 then
    begin
      try
        if (AForm.Focused <> nil) and Supports(AForm.Focused, ITextInput, TSObj) then
        begin
          TS := TTextServiceWin(TSObj.GetTextService);

          if (lParam and GCS_CURSORPOS) <> 0 then
            TS.ImmCompCursorPos := ImmGetCompositionString(IMC, GCS_CURSORPOS, nil, 0);

          Size := ImmGetCompositionString(IMC, GCS_COMPSTR, nil, 0);
          SetLength(S, Size div SizeOf(Char));
          ImmGetCompositionString(IMC, GCS_COMPSTR, PChar(S), Size);
          if ((lParam and GCS_CURSORPOS) = 0) and ((GetKeyboardLayout(0) and $FFFF) = $0412) then //True for Special support for Korean IME
            TS.ImmCompCursorPos := TS.CombinedText.Length;
          TS.InternalSetMarkedText(S);

          if (lParam and GCS_COMPATTR) <> 0 then
          begin
            Size := ImmGetCompositionString(IMC, GCS_COMPATTR, nil, 0);
            SetLength(TS.CompAttrBuf, Size);
            ImmGetCompositionString(IMC, GCS_COMPATTR, @(TS.CompAttrBuf[0]), Size);
          end;

          if (lParam and GCS_COMPCLAUSE) <> 0 then
          begin
            Size := ImmGetCompositionString(IMC, GCS_COMPCLAUSE, nil, 0);
            SetLength(TS.CompClauseBuf, Size div sizeof(DWORD));
            ImmGetCompositionString(IMC, GCS_COMPCLAUSE, @(TS.CompClauseBuf[0]), Size);
          end;
        end;
      finally
        ImmReleaseContext(Wnd, IMC);
      end;
    end;
    Result := 0;
  end
  else
  begin
    //Pressed ESC
    if (AForm.Focused <> nil) and Supports(AForm.Focused, ITextInput, TSObj) then
    begin
      TS := TTextServiceWin(TSObj.GetTextService);
      //For Chinese Microsoft engkoo - do not call break
      if (GetKeyboardLayout(0) and $FFFF) <> $0804 then
        if TS.FWorking then
          TS.InternalBreakIMEInput;
    end;
    Result := DefWindowProc(Wnd, uMsg, wParam, lParam);
  end;
end;

//When the WM_GESTURENOTIFY message is received, use SetGestureConfig to specify the gestures to receive.
//This message should always be bubbled up using the DefWindowProc function.
procedure WMGestureNotify(const AForm: TCommonCustomForm; uMsg: UINT; wParam: wParam; lParam: lParam);
const
  // Gestures
  CPan: array[Boolean] of Cardinal = (0, GC_PAN);
  CZoom: array[Boolean] of Cardinal = (0, GC_ZOOM);
  CRotate: array[Boolean] of Cardinal = (0, GC_ROTATE);
  CPressAndTap: array[Boolean] of Cardinal = (0, GC_PRESSANDTAP);
  CTwoFingerTap: array[Boolean] of Cardinal = (0, GC_TWOFINGERTAP);
var
  LPoint: TPoint;
  LPointF: TPointF;
  LControl: TFmxObject;
  LConfigs: array of TGestureConfig;
  LGestures: TInteractiveGestures;
  LObj: IControl;
  LGestureNotify: ^GESTURENOTIFYSTRUCT;
begin
  LGestureNotify := Pointer(lParam);

  //Get the location of the gesture.
  LPoint := SmallPointToPoint(LGestureNotify.ptsLocation);
  LPointF := PointF(LPoint.X, LPoint.Y);

  //Find the object that the gesture belongs to.
  LObj := AForm.ObjectAtPoint(LPointF);
  if Assigned(LObj) then
    LControl := LObj.GetObject
  else
    LControl := TFmxObject(AForm);

  if Assigned(LControl) then
  begin
    LGestures := LControl.Touch.InteractiveGestures;
    if LGestures = [] then
    begin
      LControl := LControl.Parent;
      while (LGestures = []) and Assigned(LControl) do
      begin
        LGestures := LControl.Touch.InteractiveGestures;
        LControl := LControl.Parent;
      end;
    end;
  end;

  SetLength(LConfigs, 5);
  ZeroMemory(@LConfigs[0], SizeOf(GestureConfig) * 5);

  // Pan gesture & options
  LConfigs[0].dwID := GID_PAN;
  LConfigs[0].dwWant := CPan[TInteractiveGesture.igPan in LGestures] or
    GC_PAN_WITH_SINGLE_FINGER_VERTICALLY or
    GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY or GC_PAN_WITH_INERTIA;
  LConfigs[0].dwBlock := CPan[not(TInteractiveGesture.igPan in LGestures)] or
    GC_PAN_WITH_GUTTER;

  // Zoom gesture
  LConfigs[1].dwID := GID_ZOOM;
  LConfigs[1].dwWant := CZoom[TInteractiveGesture.igZoom in LGestures];
  LConfigs[1].dwBlock := CZoom[not(TInteractiveGesture.igZoom in LGestures)];

  // Rotate gesture
  LConfigs[2].dwID := GID_ROTATE;
  LConfigs[2].dwWant := CRotate[TInteractiveGesture.igRotate in LGestures];
  LConfigs[2].dwBlock := CRotate[not(TInteractiveGesture.igRotate in LGestures)];

  // TwoFingerTap gesture
  LConfigs[3].dwID := GID_TWOFINGERTAP;
  LConfigs[3].dwWant := CTwoFingerTap[TInteractiveGesture.igTwoFingerTap
    in LGestures];
  LConfigs[3].dwBlock := CTwoFingerTap
    [not(TInteractiveGesture.igTwoFingerTap in LGestures)];

  // PressAnTap gesture
  LConfigs[4].dwID := GID_PRESSANDTAP;
  LConfigs[4].dwWant := CPressAndTap[TInteractiveGesture.igPressAndTap
    in LGestures];
  LConfigs[4].dwBlock := CPressAndTap
    [not(TInteractiveGesture.igPressAndTap in LGestures)];

  SetGestureConfig(WindowHandleToPlatform(AForm.Handle).Wnd, 0, Length(LConfigs),
    @LConfigs[0], SizeOf(TGestureConfig));
end;

function WMGesture(const AForm: TCommonCustomForm; uMsg: UINT; wParam: wParam;
  lParam: lParam): LRESULT;
const
  GestureMap: array [0 .. 4] of TInteractiveGesture =
    (TInteractiveGesture.igZoom, TInteractiveGesture.igPan,
    TInteractiveGesture.igRotate, TInteractiveGesture.igTwoFingerTap,
    TInteractiveGesture.igPressAndTap);
var
  LPoint: TPointF;
  LControl: TFmxObject;
  LGestureInfo: GestureInfo;
  EventInfo: TGestureEventInfo;
  Obj: IControl;
begin
  Result := 0;
  ZeroMemory(@LGestureInfo, SizeOf(LGestureInfo));
  LGestureInfo.cbSize := SizeOf(LGestureInfo);
  if GetGestureInfo(lParam, LGestureInfo) then
    try
      ZeroMemory(@EventInfo, SizeOf(EventInfo));
      EventInfo.GestureID := LGestureInfo.dwID + igiFirst;

      // Get the control
      LPoint := PointF(LGestureInfo.ptsLocation.X, LGestureInfo.ptsLocation.Y);
      Obj := AForm.ObjectAtPoint(LPoint);
      if Assigned(Obj) then
        LControl := Obj.GetObject
      else
        LControl := TFmxObject(AForm);

      if EventInfo.GestureID = igiBegin then
        CapturedGestureControl := LControl;

      // Don't pass GID_BEGIN and GID_END to the control
      if (EventInfo.GestureID <> igiBegin) and
        (EventInfo.GestureID <> igiEnd) then
      begin
        // Set EventInfo fields from LGestureInfo
        EventInfo.Location := AForm.ScreenToClient(LPoint);
        EventInfo.Flags := [];
        if LGestureInfo.dwFlags and GF_BEGIN = GF_BEGIN then
          Include(EventInfo.Flags, TInteractiveGestureFlag.gfBegin);
        if LGestureInfo.dwFlags and GF_INERTIA = GF_INERTIA then
          Include(EventInfo.Flags, TInteractiveGestureFlag.gfInertia);
        if LGestureInfo.dwFlags and GF_END = GF_END then
          Include(EventInfo.Flags, TInteractiveGestureFlag.gfEnd);
        case EventInfo.GestureID of
          igiPan:
            begin
              EventInfo.Distance := Cardinal(LGestureInfo.ullArguments);
              EventInfo.InertiaVector := TPointF(SmallPointToPoint(InertiaVectorFromArgument(LGestureInfo.ullArguments)));
            end;
          igiZoom, igiTwoFingerTap:
            EventInfo.Distance := Cardinal(LGestureInfo.ullArguments);
          igiPressAndTap:
            begin
              // ullArguments is distance/offset. Add to Location to make TapLocation
              LPoint := TPointF(SmallPointToPoint(TSmallPoint(Cardinal(LGestureInfo.ullArguments))));
              //EventInfo.TapLocation := AForm.ScreenToClient(TPointF(LPoint.X + LGestureInfo.ptsLocation.X, LPoint.Y + LGestureInfo.ptsLocation.Y));
            end;
          igiRotate:
            EventInfo.Angle := RotateAngleFromArgument(LGestureInfo.ullArguments);
        end;
        //send message to the control
        if Assigned(CapturedGestureControl) then
          CapturedGestureControl.CMGesture(EventInfo);
      end
      else
        Result := DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam);

      if EventInfo.GestureID = igiEnd then
        CapturedGestureControl := nil;

    finally
      CloseGestureInfoHandle(lParam);
    end;
  //Result := DefWindowProc(PlatformWin.HandleToHWND(AForm.Handle), uMsg, wParam, lParam);
end;

function SetIMEWndPosition(const AForm: TCommonCustomForm; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  IMC: HIMC;
  Wnd: HWND;
//  PlatformWin: TPlatformWin;
  Candidate: TCandidateForm;
  TargetClausePoint: TPointF;
  TSObj: ITextInput;
//  TS: TTextServiceWin;
begin
//  PlatformWin := Platform as TPlatformWin;
  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
  Result := 0;
  IMC := ImmGetContext(Wnd);
  if IMC <> 0 then
  begin
    try
      if (AForm.Focused <> nil) and Supports(AForm.Focused, ITextInput, TSObj) then
      begin
//        TS := TTextServiceWin(TSObj.GetTextService);
        TargetClausePoint := TSObj.GetTargetClausePointF; // Return Composition caret point that is relative to parent form.
        Candidate.dwIndex := 0;
//          Candidate.dwStyle := CFS_FORCE_POSITION;
        Candidate.dwStyle := CFS_POINT;

//          CaretPoint.X := CaretPoint.X + Round(((AForm as IRoot).Focused.GetObject as TStyledControl).Position.X);
//          CaretPoint.Y := CaretPoint.Y + Round(((AForm as IRoot).Focused.GetObject as TStyledControl).Position.Y);
        Candidate.ptCurrentPos := TargetClausePoint.Round;

        Result := LRESULT(ImmSetCandidateWindow(IMC, @Candidate));

      end;
    finally
      ImmReleaseContext(Wnd, IMC);
    end;
  end;
end;

function WMImeNotify(const AForm: TCommonCustomForm; hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  if wParam = IMN_OPENCANDIDATE then
    Result := SetIMEWndPosition(AForm, uMsg, wParam, lParam)
  else
    Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
end;

//

type
  PDestroyChildData = ^TDestroyChildData;
  TDestroyChildData = record
    Parent: HWND;
    Recreating: Boolean;
  end;

var
  LastKeyIsDeadKey : Boolean = False;

function WndProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  UpdateRects: array of TRectF;
  LForm: TCommonCustomForm;
  Wnd: Winapi.Windows.HWND;
  ToCloseList: TList<TCommonCustomForm>;
  WindowBorder: TWindowBorderWin;

  procedure ProcessUpdateMessages;
  var
    Msg: TMsg;
  begin
    SetLength(UpdateRects, 1);
    UpdateRects[0] := RectF(TSmallPoint(cardinal(wParam)).X, TSmallPoint(cardinal(wParam)).Y,
      TSmallPoint(cardinal(lParam)).X, TSmallPoint(cardinal(lParam)).Y);
    while PeekMessage(Msg, hwnd, WM_ADDUPDATERECT, WM_ADDUPDATERECT, PM_REMOVE) do
    begin
      if Msg.Message = WM_QUIT then
      begin
        { Repost WM_QUIT messages }
        PostQuitMessage(Msg.wParam);
        break;
      end;
      SetLength(UpdateRects, Length(UpdateRects) + 1);
      UpdateRects[High(UpdateRects)] := RectF(TSmallPoint(cardinal(Msg.wParam)).X, TSmallPoint(cardinal(Msg.wParam)).Y,
        TSmallPoint(cardinal(Msg.lParam)).X, TSmallPoint(cardinal(Msg.lParam)).Y);
    end;
  end;

  procedure CloseNoStaysOpen;
  var
    I: Integer;
  begin
    if Assigned(LForm) and
       LForm.StaysOpen and
       Assigned(PlatformWin) and
       Assigned(PlatformWin.FNoStaysOpenList) then
    begin
      I := PlatformWin.FNoStaysOpenList.Count - 1;
      while I >= 0 do
      begin
        PlatformWin.FNoStaysOpenList[I].Close;
        Dec(I);
      end;
    end;
  end;

  procedure CloseNoStaysOpen1;
  var
    I: Integer;
  begin
    if LForm.StaysOpen then
    begin
      ToCloseList := TList<TCommonCustomForm>.Create;
      for I := 0 to PlatformWin.FNoStaysOpenList.Count - 1 do
        ToCloseList.Add(PlatformWin.FNoStaysOpenList[I]);
    end
    else
      ToCloseList := nil;
  end;

  procedure CloseNoStaysOpen2;
  var
    I: Integer;
  begin
    if ToCloseList <> nil then
    begin
      try
        for I := ToCloseList.Count - 1 downto 0 do
        begin
          if PlatformWin.FNoStaysOpenList.Contains(ToCloseList[I]) then
            ToCloseList[I].Close;
        end;
      finally
        FreeAndNil(ToCloseList);
      end;
    end
  end;

  function DispatchMouseWheelToPopups : Boolean;
  var
    I: Integer;
    Handled: Boolean;
  begin
    Handled := False;
    if LForm.StaysOpen then
      if PlatformWin.FNoStaysOpenList.Count > 0 then
        for I := PlatformWin.FNoStaysOpenList.Count - 1 downto 0 do
        begin
          PlatformWin.FNoStaysOpenList[I].MouseWheel(KeysToShiftState(wParam),
                                          TSmallPoint(cardinal(wParam)).Y,
                                          Handled);
          if Handled then break;
        end;

    Result := Handled;
  end;

  procedure CurrentChar(    Msg: tagMsg;
                        var Key: Word;
                        var Ch: WideChar;
                        var Shift: TShiftState);
  begin
    Key := wParam;
    Ch := WideChar(Msg.wParam);
    Shift := KeyDataToShiftState(lParam);
    if (Ch >= ' ') then
    begin
      if ((Shift * [ssAlt, ssCtrl]) = [ssAlt, ssCtrl]) then
      begin
        // AltGr + Char (in German keyboard)
        Shift := Shift - [ssAlt, ssCtrl];
      end;
      if (([ssAlt, ssCtrl, ssCommand] * Shift) = []) then
        Key := 0;
    end;
    if ((([ssAlt, ssCtrl, ssCommand] * Shift) <> []) or (Ch < ' ')) and (Key > 0) then
      Ch := #0;
  end;

var
  R: TRect;
  P: TPoint;
  H: Boolean;
  key: Word;
  ch: WideChar;
  tme: TTRACKMOUSEEVENT;
  tMsg: TMessage;
  Shift: TShiftState;
  Placement: TWindowPlacement;
  TSObj: ITextInput;
  Msg: tagMsg;
  PaintControl: IPaintControl;
  Item: TMenuItem;

const FlagZOrder: UINT = SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE;

begin
                                                                       
  Result := 0;
  LForm := FindWindow(hwnd);

  // Check to see if this is a design message
  if (LForm <> nil) and (LForm.Designer <> nil) then
  begin
    tMsg.Msg := uMsg;
    tMsg.WParam := wParam;
    tMsg.LParam := lParam;
    tMsg.Result := 0;
    if LForm.Designer.IsDesignMsg(LForm, tMsg) then Exit;
  end;

  if (LForm <> nil) and (not LForm.Released) then
  begin
    Wnd := WindowHandleToPlatform(LForm.Handle).Wnd;
    try
      case uMsg of
        WM_NCHITTEST,
        WM_NCACTIVATE,
        WM_NCADDUPDATERECT,
        WM_NCMOUSEMOVE, WM_NCLBUTTONDOWN, WM_NCLBUTTONUP,
        WM_NCCALCSIZE, WM_NCPAINT: Result := WMNCMessages(LForm, uMsg, wParam, lParam);
        $B000 + 74: // CM_DESTROYHANDLE
          begin
            if (LForm.ClassName = 'TFormContainerForm') and (wParam = 1) then
            begin
              // IDE parent recreate
              SetParent(Wnd, GetDesktopWindow);
              SetWindowPos(Wnd, 0, $A000, $A000, 10, 10, SWP_NOSIZE or SWP_NOZORDER);
            end;
          end;
        WM_DESTROY:
          begin
            Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
            CloseNoStaysOpen;
          end;
        WM_ACTIVATE:
          begin
            if not(TFmxFormState.fsRecreating in LForm.FormState) then
            begin
              if LOWORD(wParam) <> 0 then
              begin
                if HIWORD(wParam) = 0 then
                begin
                  ImmAssociateContextEx(hWnd, 0, IACE_IGNORENOCONTEXT);
                  LForm.Activate;
                  SetIMEWndPosition(LForm, uMsg, wParam, lParam);
                end;
                 // If the window is minimized, then do nothing.
              end
              else
              begin
                LForm.Deactivate;
                CloseNoStaysOpen;
              end;
            end;
            Result := 0;
          end;
        WM_MOUSEACTIVATE:
          begin
            if not(TFmxFormState.fsRecreating in LForm.FormState) then
            begin
              if not LForm.ShowActivated then
                Result := MA_NOACTIVATE
              else
                Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
              // Default result if nothing happens
            end;
          end;
        WM_ERASEBKGND:
          begin
            Result := 1;
          end;
        WM_PAINT:
          begin
            Result := WMPaint(hwnd, uMsg, wParam, lParam);
          end;
        WM_ADDUPDATERECT:
          begin
            ProcessUpdateMessages;
            if Supports(LForm, IPaintControl, PaintControl) then
              PaintControl.PaintRects(UpdateRects);
            WindowHandleToPlatform(LForm.Handle).UpdateLayer;
          end;
        WM_WINDOWPOSCHANGING:
          begin
            if ([csLoading, csDesigning] * LForm.ComponentState = [csLoading]) then
            begin
              if (LForm.Position in [TFormPosition.poDefault, TFormPosition.poDefaultPosOnly]) and
                (LForm.WindowState <> TWindowState.wsMaximized) then
              begin
                PWindowPos(lParam)^.flags := PWindowPos(lParam)^.flags or SWP_NOMOVE;
              end;
              if (LForm.Position in [TFormPosition.poDefault, TFormPosition.poDefaultSizeOnly]) and
                (LForm.BorderStyle in [TFmxFormBorderStyle.bsSizeable, TFmxFormBorderStyle.bsSizeToolWin]) then
              begin
                PWindowPos(lParam)^.flags := PWindowPos(lParam)^.flags or SWP_NOSIZE;
              end;
            end;
            if not ((PWindowPos(lParam)^.flags and FlagZOrder) = FlagZOrder) then
              CloseNoStaysOpen;
            Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
          end;
        WM_WINDOWPOSCHANGED:
          begin
            Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
            if (PWindowPos(lParam)^.flags and SWP_NOSIZE = 0) or
               (PWindowPos(lParam)^.flags and SWP_NOMOVE = 0) then
            begin
              GetWindowRect(hwnd, R);
              LForm.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
            end;
            { update state }
            PlatformWin.FDiableUpdateState := True;
            try
              Placement.length := SizeOf(TWindowPlacement);
              GetWindowPlacement(hwnd, Placement);
              case Placement.showCmd of
                SW_SHOWMINIMIZED: LForm.WindowState := TWindowState.wsMinimized;
                SW_SHOWMAXIMIZED: LForm.WindowState := TWindowState.wsMaximized;
              else
                if csDesigning in LForm.ComponentState then
                begin
                  { for using Metro-style interface in designer we set Maximized but we can change window size}
                  if LForm.WindowState <> TWindowState.wsMaximized then
                    LForm.WindowState := TWindowState.wsNormal;
                end
                else
                  LForm.WindowState := TWindowState.wsNormal;
              end;
            finally
              PlatformWin.FDiableUpdateState := False;
            end;
            WMNCMessages(LForm, uMsg, wParam, lParam);
          end;
        WM_CLOSE:
          begin
            LForm.Close;
          end;
        WM_LBUTTONDOWN:
          begin
            CloseNoStaysOpen1;
            try
              GetCursorPos(P);
              ScreenToClient(Wnd, P);
              LForm.MouseDown(TMouseButton.mbLeft, KeysToShiftState(wParam), P.X, P.Y);
            finally
              CloseNoStaysOpen2;
            end;
          end;
        WM_LBUTTONDBLCLK:
          begin
            CloseNoStaysOpen1;
            try
              GetCursorPos(P);
              ScreenToClient(Wnd, P);
              LForm.MouseDown(TMouseButton.mbLeft, KeysToShiftState(wParam) + [ssDouble], P.X, P.Y);
            finally
              CloseNoStaysOpen2;
            end;
          end;
        WM_LBUTTONUP:
          begin
            WindowBorder := TWindowBorderWin(LForm.Border.WindowBorder);
            if LForm.Border.IsSupported and WindowBorder.NCClick then
              Result := WMNCMessages(LForm, uMsg, wParam, lParam)
            else
            begin
              GetCursorPos(P);
              ScreenToClient(Wnd, P);
              LForm.MouseUp(TMouseButton.mbLeft, KeysToShiftState(wParam), P.X, P.Y);
            end;
          end;
        WM_RBUTTONDOWN:
          begin
            CloseNoStaysOpen;
            GetCursorPos(P);
            ScreenToClient(Wnd, P);
            LForm.MouseDown(TMouseButton.mbRight, KeysToShiftState(wParam), P.X, P.Y);
          end;
        WM_RBUTTONDBLCLK:
          begin
            CloseNoStaysOpen;
            GetCursorPos(P);
            ScreenToClient(Wnd, P);
            LForm.MouseDown(TMouseButton.mbRight, KeysToShiftState(wParam) + [ssDouble], P.X, P.Y);
          end;
        WM_RBUTTONUP:
          begin
            GetCursorPos(P);
            ScreenToClient(Wnd, P);
            LForm.MouseUp(TMouseButton.mbRight, KeysToShiftState(wParam), P.X, P.Y);
          end;
        WM_MBUTTONDOWN:
          begin
            CloseNoStaysOpen;
            GetCursorPos(P);
            ScreenToClient(Wnd, P);
            LForm.MouseDown(TMouseButton.mbMiddle, KeysToShiftState(wParam), P.X, P.Y);
          end;
        WM_MBUTTONUP:
          begin
            GetCursorPos(P);
            ScreenToClient(Wnd, P);
            LForm.MouseUp(TMouseButton.mbMiddle, KeysToShiftState(wParam), P.X, P.Y);
          end;
        WM_MBUTTONDBLCLK:
          begin
            CloseNoStaysOpen;
            GetCursorPos(P);
            ScreenToClient(Wnd, P);
            LForm.MouseDown(TMouseButton.mbMiddle, KeysToShiftState(wParam) + [ssDouble], P.X, P.Y);
          end;
        WM_MOUSEMOVE:
          begin
            WindowBorder := TWindowBorderWin(LForm.Border.WindowBorder);
            if LForm.Border.IsSupported then
            begin
              if WindowBorder.NCClick then
                Result := WMNCMessages(LForm, uMsg, wParam, lParam)
              else begin
                WindowBorder.MouseLeave;
                GetCursorPos(P);
                ScreenToClient(Wnd, P);
                LForm.MouseMove(KeysToShiftState(wParam), P.X, P.Y);
              end;
            end
            else
            begin
              GetCursorPos(P);
              ScreenToClient(Wnd, P);
              LForm.MouseMove(KeysToShiftState(wParam), P.X, P.Y);
            end;
            tme.cbSize := SizeOf(tme);
            tme.hwndTrack := Wnd;
            tme.dwFlags := TME_LEAVE;
            tme.dwHoverTime := 1;
            TrackMouseEvent(tme);
          end;
        WM_MOUSELEAVE:
          begin
            WindowBorder := TWindowBorderWin(LForm.Border.WindowBorder);
            if LForm.Border.IsSupported and WindowBorder.NCClick then
              Result := WMNCMessages(LForm, uMsg, wParam, lParam)
            else
              LForm.MouseLeave;
          end;
        WM_MOUSEWHEEL:
          begin
            H := DispatchMouseWheelToPopups;

            if not H then
              LForm.MouseWheel(KeysToShiftState(wParam),
                               TSmallPoint(cardinal(wParam)).Y, H);

            Result := Integer(H = True);
          end;
        WM_GETDLGCODE:
          begin
            Result := DLGC_WANTTAB or dlgc_WantArrows or DLGC_WANTCHARS;
          end;
        WM_CHAR:
          begin
            ch := WideChar(wParam);
            key := 0;
            LForm.KeyDown(key, ch, KeyDataToShiftState(lParam));
            LForm.KeyUp(key, ch, KeyDataToShiftState(lParam));
            Result := 0;
          end;
        WM_SYSKEYDOWN,
        WM_KEYDOWN:
          begin
            // Check if this key translates to a WM_CHAR message
            // and if it does, pass KeyDown with character code
            // and clear the original WM_CHAR from the queue
            Msg.hwnd := hwnd;
            Msg.message := WM_KEYDOWN;
            Msg.wParam := wParam;
            Msg.lParam := lParam;
            Result := 0;

            LastKeyIsDeadKey := false;
            if PeekMessage(Msg, hwnd, WM_DEADCHAR, WM_DEADCHAR, PM_NOREMOVE + PM_NOYIELD) then begin
              LastKeyIsDeadKey := true;
            end
            else
            if TranslateMessage(Msg) then
            begin
              if PeekMessage(Msg, hwnd, WM_CHAR, WM_CHAR, PM_REMOVE) then
              begin
                CurrentChar(Msg, key, ch, Shift);
                // clear duplicate WM_CHAR
                PeekMessage(Msg, hwnd, WM_CHAR, WM_CHAR, PM_REMOVE);
                LForm.KeyDown(key, ch, Shift);
              end
              else
              begin
                key := wParam;
                ch := #0;
                LForm.KeyDown(key, ch, KeyDataToShiftState(lParam));
              end
            end;

          // always let the system handle system shortcuts
          if uMsg = WM_SYSKEYDOWN then
            Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
          end;
        WM_DEADCHAR:
          begin
            PeekMessage(Msg, hwnd, WM_DEADCHAR, WM_DEADCHAR, PM_REMOVE);
            PeekMessage(Msg, hwnd, WM_CHAR, WM_CHAR, PM_REMOVE);
          end;
        WM_KEYUP:
          begin
            ch := #0;
            key := wParam;
            Shift := KeyDataToShiftState(lParam);
            if LastKeyIsDeadKey then begin
              Result := 0;
            end else
            begin
              Msg.hwnd := hwnd;
              Msg.message := WM_KEYDOWN;
              Msg.wParam := wParam;
              Msg.lParam := Msg.lParam and $7fffffff;
              if TranslateMessage(Msg) then
                if PeekMessage(Msg, hwnd, WM_CHAR, WM_CHAR, PM_REMOVE) then
                begin
                  CurrentChar(Msg, key, ch, Shift);
                end;
              LForm.KeyUp(key, ch, Shift);
              Result := 0;
            end
          end;
        WM_SYSKEYUP:
          begin
            if (wParam = VK_MENU) or (wParam = VK_F10) then
            begin
              LForm.EnterMenuLoop;
              Result := 0;
            end
            else
              Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
          end;
        WM_RELEASEFORM:
          begin
            LForm.Free;
          end;
        { IME }
        WM_INPUTLANGCHANGE:
          begin
//            OnInputLangChange();

          end;
        WM_IME_SETCONTEXT:
          begin
            // Request the candidate windows only
            Result := DefWindowProc(hwnd, uMsg, wParam, lParam and ISC_SHOWUIALLCANDIDATEWINDOW);
          end;
        WM_IME_STARTCOMPOSITION:
          begin
//            InitCompStringData();
//            *trapped = true;
            Result := WMImeStartComposition(LForm, hWnd, uMsg, wParam, lParam);
          end;
        WM_IME_COMPOSITION:
          begin
            Result := WMImeComposition(LForm, uMsg, wParam, lParam);
          end;
        WM_IME_ENDCOMPOSITION:
          begin
            if (LForm.Focused <> nil) and Supports(LForm.Focused, ITextInput, TSObj) then
            begin
              if ((GetKeyboardLayout(0) and $FFFF) = $0412) and not TTextServiceWin(TSObj.GetTextService).FWorking then // Special support for Korean IME
              begin
                if not TTextServiceWin(TSObj.GetTextService).FWorking then
                  SendMessage(Wnd, WM_IME_STARTCOMPOSITION, 0, 0);
              end
              else
              begin
                //For Chinese Microsoft engkoo - pressed ESC, need to interrupt input
                if ((GetKeyboardLayout(0) and $FFFF) = $0804) and TTextServiceWin(TSObj.GetTextService).FWorking then
                  TTextServiceWin(TSObj.GetTextService).InternalBreakIMEInput;
                TTextServiceWin(TSObj.GetTextService).InternalEndIMEInput;
              end;
            end;
          end;
        WM_IME_NOTIFY:
          begin
            Result := WMImeNotify(LForm, hwnd, uMsg, wParam, lParam);
          end;
//        WM_IME_SETCONTEXT:
//          begin
//            { TODO -cIME : For Korean IME only? }
//          end;
        { }
        WM_COMMAND:
          begin
            if wParam <> 0 then
            begin
              if PlatformWin.FHMenuMap.TryGetValue(TFmxHandle(wParam), Item) and
                 Assigned(Item) then
                TOpenMenuItem(Item).Click;
            end;
            Result := 0;
          end;
        WM_GESTURENOTIFY:
          begin
            WMGestureNotify(LForm, uMsg, wParam, lParam);
            Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
          end;
        WM_GESTURE:
          begin
            Result := WMGesture(LForm, uMsg, wParam, lParam);
          end;
        WM_TOUCH:
          begin
            GetCursorPos(P);
            ScreenToClient(Wnd, P);
          end;
      else
        Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
        // Default result if nothing happens
      end;
    except
      on E: Exception do
        Application.HandleException(E);
    end;
  end else
    Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
  // Default result if nothing happens
end;

function TPlatformWin.CreateWindow(const AForm: TCommonCustomForm): TWindowHandle;
var
  DesignerForm: IDesignerForm;
  IsDesignerForm: Boolean;
  WindowClass: TWndClass;
  DropTarget: TDropTarget;
  Style, ExStyle: DWORD;
  Wnd: HWND;
  ParentWnd: HWND;
  WndClassName: string;
begin
  Result := nil;
  WndClassName := 'FM' + AForm.ClassName;
  IsDesignerForm := Supports(AForm, IDesignerForm, DesignerForm);
  if not GetClassInfo(hInstance, PChar(WndClassName), WindowClass) then
  begin
    FillChar(WindowClass, SizeOf(WindowClass), 0);
    WindowClass.Style := CS_DBLCLKS or CS_HREDRAW or CS_VREDRAW;
    WindowClass.lpfnWndProc := @WndProc;
    WindowClass.cbClsExtra := 0;
    WindowClass.cbWndExtra := 0;
    WindowClass.hInstance := hInstance;
    WindowClass.hIcon := LoadIconW(MainInstance, PChar('MAINICON'));
    WindowClass.hCursor := LoadCursorW(0, PChar(IDC_ARROW));
    WindowClass.hbrBackground := GetStockObject(NULL_BRUSH);
    WindowClass.lpszMenuName := nil;
    WindowClass.lpszClassName := PChar(WndClassName);
    if Winapi.Windows.RegisterClass(WindowClass) = 0 then
      RaiseLastOSError;
  end;

  Style := 0;
  ExStyle := 0;
  if (csDesigning in AForm.ComponentState) or IsDesignerForm then
  begin
    // Only in IDE
    Style := Style or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_CHILDWINDOW;
    ExStyle := ExStyle;
  end
  else
  if AForm.Transparency then
  begin
    Style := Style or WS_POPUP or WS_CLIPCHILDREN;
    ExStyle := ExStyle or WS_EX_LAYERED;
    if (Application.MainForm <> nil) and (AForm <> Application.MainForm) then
      ExStyle := ExStyle or WS_EX_TOOLWINDOW; // disable taskbar
  end
  else
  begin
    Style := Style or WS_CLIPSIBLINGS or WS_CLIPCHILDREN;
    case AForm.BorderStyle of
      TFmxFormBorderStyle.bsNone:
        begin
          Style := Style or WS_POPUP or WS_SYSMENU;
          ExStyle := ExStyle { or WS_EX_TOOLWINDOW }; // disable taskbar
        end;
      TFmxFormBorderStyle.bsSingle, TFmxFormBorderStyle.bsToolWindow:
        Style := Style or (WS_CAPTION or WS_BORDER);
      TFmxFormBorderStyle.bsSizeable, TFmxFormBorderStyle.bsSizeToolWin:
        Style := Style or (WS_CAPTION or WS_THICKFRAME);
    end;
    if AForm.BorderStyle in [TFmxFormBorderStyle.bsToolWindow, TFmxFormBorderStyle.bsSizeToolWin] then
    begin
      ExStyle := ExStyle or WS_EX_TOOLWINDOW;
      if (Application.MainForm = nil) or (Application.MainForm = AForm) then
        ExStyle := ExStyle or WS_EX_APPWINDOW;
    end;
    if AForm.BorderStyle <> TFmxFormBorderStyle.bsNone then
    begin
      if TBorderIcon.biMinimize in AForm.BorderIcons then
        Style := Style or WS_MINIMIZEBOX;
      if TBorderIcon.biMaximize in AForm.BorderIcons then
        Style := Style or WS_MAXIMIZEBOX;
      if TBorderIcon.biSystemMenu in AForm.BorderIcons then
        Style := Style or WS_SYSMENU;
    end;
  end;

  if FApplicationHWND = 0 then
    CreateAppHandle;

  // modal forms must have an owner window
  if TFmxFormState.fsModal in AForm.FormState then
    ParentWnd := GetActiveWindow
  else
    if not (csDesigning in AForm.ComponentState)
    and (FMX.Forms.Screen.FormCount > 0)
    and (AForm.Handle <> FMX.Forms.Screen.Forms[0].Handle) then
    begin
      if FApplicationHWND = 0 then
        ParentWnd := WindowHandleToPlatform(FMX.Forms.Screen.Forms[0].Handle).Wnd
      else
        ParentWnd := FApplicationHWND;
    end
    else
    begin
      if FApplicationHWND = 0 then
        ParentWnd := GetDesktopWindow
      else
        ParentWnd := FApplicationHWND;
    end;
  Wnd := CreateWindowEx(ExStyle, WindowClass.lpszClassName, PChar(AForm.Caption), Style,
    Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
    ParentWnd, 0, hInstance, nil);
  if Wnd <> 0 then
  begin
    SetProp(Wnd, MakeIntAtom(WindowAtom), THandle(AForm));

    DropTarget := TDropTarget.Create(nil);
    DropTarget.Form := AForm;
    SetProp(Wnd, MakeIntAtom(DropAtom), THandle(DropTarget));

    if not ((csDesigning in AForm.ComponentState) or IsDesignerForm) then
      RegisterDragDrop(Wnd, DropTarget);
    Result := TWinWindowHandle.Create(AForm, Wnd);
  end else
    RaiseLastOSError;
end;

function TPlatformWin.CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
begin
  Result := FMX.Forms.Border.Win.CreateWindowBorder(AForm);
end;

procedure TPlatformWin.DestroyWindow(const AForm: TCommonCustomForm);
var
  Wnd: HWND;
  DesignerForm: IDesignerForm;
begin
  HideWindow(AForm);

  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
  if not ((csDesigning in AForm.ComponentState) or Supports(AForm, IDesignerForm, DesignerForm)) then
    RevokeDragDrop(Wnd);

  FindDropTarget(Wnd).Free;

  Winapi.Windows.DestroyWindow(Wnd);
end;

procedure TPlatformWin.ReleaseWindow(const AForm: TCommonCustomForm);
begin
end;

procedure TPlatformWin.InvalidateImmediately(const AForm: TCommonCustomForm);
begin
  InvalidateWindowRect(AForm, AForm.ClientRect);
end;

procedure TPlatformWin.InvalidateWindowRect(const AForm: TCommonCustomForm; R: TRectF);
var
  WR: TRect;
  Wnd: HWND;
  PaintControl: IPaintControl;
  UpdateRects: TUpdateRects;
  I: Integer;
begin
  if IntersectRect(R, RectF(0, 0, AForm.ClientWidth, AForm.ClientHeight)) then
  begin
    Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
    if AForm.Transparency and not (csDesigning in AForm.ComponentState) then
    begin
      PostMessage(Wnd, WM_ADDUPDATERECT, Integer(SmallPoint(Round(R.Left), Round(R.Top))),
        Integer(SmallPoint(Round(R.Right), Round(R.Bottom))));
    end
    else
    begin
      if Supports(AForm, IPaintControl, PaintControl) and (PaintControl.ContextHandle <> 0) then
      begin
        // In Paint
        if not FInPaintUpdateRects.TryGetValue(AForm.Handle, UpdateRects) then
        begin
          SetLength(UpdateRects, 1);
          UpdateRects[0] := R;
          FInPaintUpdateRects.Add(AForm.Handle, UpdateRects);
          Exit;
        end
        else
          for I := 0 to High(UpdateRects) do
            if (UpdateRects[I] = R) or (UpdateRects[I].Contains(R.TopLeft) and UpdateRects[I].Contains(R.BottomRight)) then
              Exit;
        SetLength(UpdateRects, Length(UpdateRects) + 1);
        UpdateRects[High(UpdateRects)] := R;
        FInPaintUpdateRects.AddOrSetValue(AForm.Handle, UpdateRects);
      end
      else
      begin
        WR := Rect(trunc(R.Left), trunc(R.Top), ceil(R.Right), ceil(R.Bottom));
        Winapi.Windows.InvalidateRect(Wnd, @WR, False);
      end;
    end;
  end;
end;

function TPlatformWin.IsMenuBarOnWindowBorder: boolean;
begin
  Result := True;
end;

var
  MsgCaptions: array[TMsgDlgType] of String = (SMsgDlgWarning, SMsgDlgError, SMsgDlgInformation, SMsgDlgConfirm, '');
  MsgIcons: array[TMsgDlgType] of UInt = (MB_ICONWARNING, MB_ICONERROR, MB_ICONINFORMATION, MB_ICONQUESTION, 0);

function TPlatformWin.MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn; X, Y,
  HelpCtx: Integer; const HelpFileName: string): Integer;
var
  Flags: UInt;
  Handle: HWnd;
begin
  Flags := 0;
  if (TMsgDlgBtn.mbOK in Buttons) then
    Flags := MB_OK;
  if (TMsgDlgBtn.mbOk in Buttons) and (TMsgDlgBtn.mbCancel in Buttons) then
  begin
    Flags := MB_OKCANCEL;
    if DefaultButton = TMsgDlgBtn.mbCancel then
      Flags := Flags or MB_DEFBUTTON2;
  end;
  if (TMsgDlgBtn.mbRetry in Buttons) and (TMsgDlgBtn.mbCancel in Buttons) then
  begin
    Flags := MB_RETRYCANCEL;
    if DefaultButton = TMsgDlgBtn.mbCancel then
      Flags := Flags or MB_DEFBUTTON2;
  end;
  if (TMsgDlgBtn.mbYes in Buttons) and (TMsgDlgBtn.mbNo in Buttons) then
  begin
    Flags := MB_YESNO;
    if DefaultButton = TMsgDlgBtn.mbNo then
      Flags := Flags or MB_DEFBUTTON2;
  end;
  if (TMsgDlgBtn.mbYes in Buttons) and (TMsgDlgBtn.mbNo in Buttons) and (TMsgDlgBtn.mbCancel in Buttons) then
  begin
    Flags := MB_YESNOCANCEL;
    if DefaultButton = TMsgDlgBtn.mbNo then
      Flags := Flags or MB_DEFBUTTON2;
    if DefaultButton = TMsgDlgBtn.mbCancel then
      Flags := Flags or MB_DEFBUTTON3;
  end;
  if (TMsgDlgBtn.mbAbort in Buttons) and (TMsgDlgBtn.mbRetry in Buttons) and (TMsgDlgBtn.mbIgnore in Buttons) then
  begin
    Flags := MB_ABORTRETRYIGNORE;
    if DefaultButton = TMsgDlgBtn.mbRetry then
      Flags := Flags or MB_DEFBUTTON2;
    if DefaultButton = TMsgDlgBtn.mbIgnore then
      Flags := Flags or MB_DEFBUTTON3;
  end;
  if (TMsgDlgBtn.mbHelp in Buttons) then
    Flags := Flags or MB_HELP;

  if Assigned(Screen) and Assigned(Screen.ActiveForm) then
    Handle := WindowHandleToPlatform(Screen.ActiveForm.Handle).Wnd
  else
    Handle := 0;
  Result := MessageBox(Handle, PChar(Msg), PChar(MsgCaptions[DlgType]), MsgIcons[DlgType] or Flags);
end;

function TPlatformWin.InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  CloseQueryFunc: TInputCloseQueryFunc): Boolean;
begin
  Result := DefaultInputQuery(ACaption, APrompts, AValues, CloseQueryFunc);
end;

function TPlatformWin.GetWindowRect(const AForm: TCommonCustomForm): TRectF;
var
  WR: TRect;
begin
  Winapi.Windows.GetWindowRect(WindowHandleToPlatform(AForm.Handle).Wnd, WR);
  Result := RectF(WR.Left, WR.Top, WR.Right, WR.Bottom);
end;

function TPlatformWin.GetWindowScale(const AForm: TCommonCustomForm): Single;
begin
  Result := FCurrentScreenScale;
end;

procedure TPlatformWin.SetWindowRect(const AForm: TCommonCustomForm; ARect: TRectF);
begin
  { for using Metro-style interface in designer we set Maximized but we can change window size}
  if AForm.WindowState in [TWindowState.wsNormal, TWindowState.wsMaximized] then
    SetWindowPos(WindowHandleToPlatform(AForm.Handle).Wnd, 0, Round(ARect.Left), Round(ARect.Top),
      Round(ARect.Right - ARect.Left), Round(ARect.Bottom - ARect.Top),
      SWP_NOACTIVATE or SWP_NOZORDER)
end;

procedure TPlatformWin.SetWindowCaption(const AForm: TCommonCustomForm; const ACaption: string);
begin
  SetWindowText(WindowHandleToPlatform(AForm.Handle).Wnd, ACaption);
end;

procedure TPlatformWin.RegisterCanvasClasses;
begin
  if GlobalUseGPUCanvas then
    FMX.Canvas.GPU.RegisterCanvasClasses;
  FMX.Canvas.D2D.RegisterCanvasClasses;
  FMX.Canvas.GDIP.RegisterCanvasClasses;
end;

procedure TPlatformWin.UnregisterCanvasClasses;
begin
  if GlobalUseGPUCanvas then
    FMX.Canvas.GPU.UnregisterCanvasClasses;
  FMX.Canvas.D2D.UnregisterCanvasClasses;
  FMX.Canvas.GDIP.UnregisterCanvasClasses;
end;

procedure TPlatformWin.RegisterContextClasses;
begin
  FMX.Context.DX9.RegisterContextClasses;
  FMX.Context.DX10.RegisterContextClasses;
end;

procedure TPlatformWin.UnregisterContextClasses;
begin
  FMX.Context.DX9.UnregisterContextClasses;
  FMX.Context.DX10.UnregisterContextClasses;
end;

procedure TPlatformWin.ReleaseCapture(const AForm: TCommonCustomForm);
begin
  Winapi.Windows.ReleaseCapture;
end;

procedure TPlatformWin.SetCapture(const AForm: TCommonCustomForm);
begin
  Winapi.Windows.SetCapture(WindowHandleToPlatform(AForm.Handle).Wnd);
end;

function TPlatformWin.GetCaretWidth: Integer;
begin
  Result := 1;
end;

function TPlatformWin.GetClientSize(const AForm: TCommonCustomForm): TPointF;
var
  CR: TRect;
begin
  if GetClientRect(WindowHandleToPlatform(AForm.Handle).Wnd, CR) then
    Result := PointF(CR.Right - CR.Left, CR.Bottom - CR.Top)
  else
    Result := PointF(0, 0)
end;

procedure TPlatformWin.SetClientSize(const AForm: TCommonCustomForm; const ASize: TPointF);
var
  CR, WR: TRect;
  Wnd: HWND;
begin
  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
  GetClientRect(Wnd, CR);
  Winapi.Windows.ClientToScreen(Wnd, CR.TopLeft);
  Winapi.Windows.ClientToScreen(Wnd, CR.BottomRight);
  Winapi.Windows.GetWindowRect(Wnd, WR);
  if (WR.Width  <> Round(ASize.X) + (CR.Left - WR.Left) + (WR.Right  - CR.Right)) or
     (WR.Height <> Round(ASize.Y) + (CR.Top  - WR.Top)  + (WR.Bottom - CR.Bottom)) then
    Winapi.Windows.SetWindowPos(Wnd, 0, WR.Left, WR.Top,
      Round(ASize.X) + (CR.Left - WR.Left) + (WR.Right - CR.Right),
      Round(ASize.Y) + (CR.Top  - WR.Top)  + (WR.Bottom - CR.Bottom),
      SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE);
end;

procedure TPlatformWin.HideWindow(const AForm: TCommonCustomForm);
begin
  FNoStaysOpenList.Remove(AForm);
  SetWindowPos(WindowHandleToPlatform(AForm.Handle).Wnd, 0, 0, 0, 0, 0,
    SWP_HIDEWINDOW or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE);
end;

const
  ShowCommands: array[TWindowState] of Integer =
    (SW_SHOWNORMAL, SW_MINIMIZE, SW_SHOWMAXIMIZED);

procedure TPlatformWin.ShowWindow(const AForm: TCommonCustomForm);
var
  Wnd: HWND;
begin
  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
  if not AForm.ShowActivated then
    Winapi.Windows.ShowWindow(Wnd, SW_SHOWNOACTIVATE)
  else
    Winapi.Windows.ShowWindow(Wnd, ShowCommands[AForm.WindowState] or SW_SHOWNORMAL);
  if AForm.Transparency and not (csDesigning in AForm.ComponentState) then
    PostMessage(WindowHandleToPlatform(AForm.Handle).Wnd, WM_ADDUPDATERECT, Integer(SmallPoint(0, 0)),
      Integer(SmallPoint(AForm.Width, AForm.Height)));
  if AForm.TopMost then
    if (GetParent(Wnd) = GetDesktopWindow) or (GetParent(Wnd) = 0) then
      SetWindowPos(Wnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
    else
      SetWindowPos(Wnd, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  if not AForm.StaysOpen then
    FNoStaysOpenList.Add(AForm);
end;

procedure TPlatformWin.BringToFront(const AForm: TCommonCustomForm);
var
  Wnd: HWND;
begin
  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
  SetWindowPos(Wnd, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TPlatformWin.SendToBack(const AForm: TCommonCustomForm);
var
  Wnd: HWND;
begin
  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
  SetWindowPos(Wnd, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TPlatformWin.Activate(const AForm: TCommonCustomForm);
var
  Wnd: HWND;
begin
  Wnd := WindowHandleToPlatform(AForm.Handle).Wnd;
  if (not IsWindowVisible(Wnd)) or (IsIconic(Wnd)) then
  begin
    WinApi.Windows.ShowWindow(Wnd, SW_RESTORE);
  end;
  Winapi.Windows.SetActiveWindow(Wnd);
end;

procedure TPlatformWin.SetWindowState(const AForm: TCommonCustomForm; const AState: TWindowState);
begin
  if not FDiableUpdateState then
    Winapi.Windows.ShowWindow(WindowHandleToPlatform(AForm.Handle).Wnd, ShowCommands[AState]);
end;

type
  PTaskWindow = ^TTaskWindow;
  TTaskWindow = record
    Next: PTaskWindow;
    Window: hwnd;
  end;

var
  TaskActiveWindow: HWND = 0;
  TaskFirstWindow: HWND = 0;
  TaskFirstTopMost: HWND = 0;
  TaskWindowList: PTaskWindow = nil;

function DoDisableWindow(Window: hwnd; Data: Longint): bool; stdcall;
var
  P: PTaskWindow;
begin
  if (Window <> TaskActiveWindow) and IsWindowVisible(Window) and IsWindowEnabled(Window) then
  begin
    New(P);
    P^.Next := TaskWindowList;
    P^.Window := Window;
    TaskWindowList := P;
    EnableWindow(Window, False);
  end;
  Result := True;
end;

procedure EnableTaskWindows(WindowList: Pointer);
var
  P: PTaskWindow;
begin
  while WindowList <> nil do
  begin
    P := WindowList;
    if IsWindow(P^.Window) then
      EnableWindow(P^.Window, True);
    WindowList := P^.Next;
    Dispose(P);
  end;
end;

function DisableTaskWindows(ActiveWindow: HWND): Pointer;
var
  SaveActiveWindow: hwnd;
  SaveWindowList: Pointer;
begin
  Result := nil;
  SaveActiveWindow := TaskActiveWindow;
  SaveWindowList := TaskWindowList;
  TaskActiveWindow := ActiveWindow;
  TaskWindowList := nil;
  try
    try
      EnumThreadWindows(GetCurrentThreadID, @DoDisableWindow, 0);
      Result := TaskWindowList;
    except
      EnableTaskWindows(TaskWindowList);
      raise;
    end;
  finally
    TaskWindowList := SaveWindowList;
    TaskActiveWindow := SaveActiveWindow;
  end;
end;

function DoFindWindow(Window: HWnd; Param: LPARAM): Bool; {$IFNDEF CLR}stdcall;{$ENDIF}
begin
  if (Window <> TaskActiveWindow) and
    IsWindowVisible(Window) and IsWindowEnabled(Window) then
    if GetWindowLong(Window, GWL_EXSTYLE) and WS_EX_TOPMOST = 0 then
    begin
      if TaskFirstWindow = 0 then TaskFirstWindow := Window;
    end else
    begin
      if TaskFirstTopMost = 0 then TaskFirstTopMost := Window;
    end;
  Result := True;
end;

function FindTopMostWindow(ActiveWindow: HWnd): HWnd;
var
  EnumProc: TFNWndEnumProc; // keep a reference to the delegate!
begin
  TaskActiveWindow := ActiveWindow;
  TaskFirstWindow := 0;
  TaskFirstTopMost := 0;
  EnumProc := @DoFindWindow;
  EnumThreadWindows(GetCurrentThreadID, EnumProc, 0);
  if TaskFirstWindow <> 0 then
    Result := TaskFirstWindow else
    Result := TaskFirstTopMost;
end;

type
  THackForm = class(TCommonCustomForm);

function TPlatformWin.ShowWindowModal(const AForm: TCommonCustomForm): TModalResult;
var
  WindowList: Pointer;
  AppService: IFMXApplicationService;
begin
  if GetCapture <> 0 then
    SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
  Winapi.Windows.ReleaseCapture;
  // recreate the WinApi handle of the form in order to make the underlying
  // window owned by ActiveWindow
  THackForm(AForm).Recreate;
  WindowList := DisableTaskWindows(WindowHandleToPlatform(AForm.Handle).Wnd);
  try
    AForm.Show;
    AForm.ModalResult := mrNone;
    SetActiveWindow(WindowHandleToPlatform(AForm.Handle).Wnd);
    SetFocus(WindowHandleToPlatform(AForm.Handle).Wnd);
    Screen.ActiveForm := AForm;
    AppService := IFMXApplicationService(TPlatformServices.Current.GetPlatformService(IFMXApplicationService));
    repeat
      if not Application.HandleMessage then
        AppService.WaitMessage;
      if Application.Terminated then
        AForm.ModalResult := mrCancel
      else if AForm.ModalResult <> mrNone then
        AForm.CloseModal;
    until AForm.ModalResult <> mrNone;

    if AForm.Visible then AForm.Hide;
  finally
    EnableTaskWindows(WindowList);
  end;

  Result := AForm.ModalResult;
end;

function TPlatformWin.ClientToScreen(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
var
  P: TPoint;
begin
  P := System.Types.Point(Round(Point.X), Round(Point.Y));
  Winapi.Windows.ClientToScreen(WindowHandleToPlatform(AForm.Handle).Wnd, P);
  Result := PointF(P.X, P.Y);
end;

function TPlatformWin.ScreenToClient(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
var
  P: TPoint;
begin
  P := System.Types.Point(Round(Point.X), Round(Point.Y));
  Winapi.Windows.ScreenToClient(WindowHandleToPlatform(AForm.Handle).Wnd, P);
  Result := PointF(P.X, P.Y);
end;

{ Menus }

procedure TPlatformWin.StartMenuLoop(const AView: IMenuView);
var
  FirstLoop: Boolean;

  procedure EndLoop;
  var
    View: IMenuView;
  begin
    View := AView;
    while View <> nil do
    begin
      View.Loop := False;
      View.Selected := nil;
      View := View.ParentView;
    end;
  end;

  function ContinueLoop: Boolean;
  begin
    Result := AView.Loop;
  end;

  function ForwardSelectNextMenuItem(AView: IMenuView; AStartInd, AEndInd: Integer): Boolean;
  var
    I: Integer;
  begin
    if not Assigned(AView) then
      Exit(False);

    Result := False;
    for I := AStartInd to AEndInd do
      if AView.GetItem(I) is TMenuITem then
      begin
        AView.Selected := TMenuItem(AView.GetItem(I));
        Result := True;
        Break;
      end;
  end;

  function BackwardSelectNextMenuItem(AView: IMenuView; AStartInd, AEndInd: Integer): Boolean;
  var
    I: Integer;
  begin
    if not Assigned(AView) then
      Exit(False);

    Result := False;
    for I := AStartInd downto AEndInd do
      if AView.GetItem(I) is TMenuItem then
      begin
        AView.Selected := TMenuItem(AView.GetItem(I));
        Result := True;
        Break;
      end;
  end;

  procedure SelectFirstMenuItem(AView: IMenuView);
  begin
    ForwardSelectNextMenuItem(AView, 0, AView.GetItemsCount - 1);
  end;

  procedure SelectLastMenuItem(AView: IMenuView);
  begin
    BackwardSelectNextMenuItem(AView, AView.GetItemsCount - 1, 0);
  end;

  procedure SelectPrevMenuItem(AView: IMenuView);
  begin
    if not Assigned(AView) then
      Exit;

    if Assigned(AView.Selected) then
    begin
      { Select first Menu item from old selected to first }
      if BackwardSelectNextMenuItem(AView, AView.Selected.Index - 1, 0) then
        Exit;
      { Select first Menu item from last to old selected }
      BackwardSelectNextMenuItem(AView, AView.GetItemsCount - 1, AView.Selected.Index);
    end
    else
      SelectLastMenuItem(AView);
  end;

  procedure SelectNextMenuItem(AView: IMenuView);
  begin
    if not Assigned(AView) then
      Exit;

    if Assigned(AView.Selected) then
    begin
      { Select first Menu item from old selected to last }
      if ForwardSelectNextMenuItem(AView, AView.Selected.Index + 1, AView.GetItemsCount - 1) then
        Exit;
      { Select first Menu item from first to old selected }
      ForwardSelectNextMenuItem(AView, 0, AView.Selected.Index);
    end
    else
      SelectFirstMenuItem(AView);
  end;

var
  Msg: TMsg;
  WP: TPoint;
  P: TPointF;
  InMenus: Boolean;
  CurrentView, NewView: IMenuView;
  Obj: IControl;
  AutoPopupTime: Integer;
  TimerId: THandle;
  TPos, TOldPos: TPoint;
begin
  AutoPopupTime := 0;
  AView.Loop := True;
  TOldPos := Point(0, 0);
  TPos := TOldPos;
  TimerId := SetTimer(0, 0, 50, nil);
  try
    FirstLoop := True;
    while ContinueLoop do
    begin
                                                         
      if FirstLoop then
        FirstLoop := False
      else
        WaitMessage;

      while ContinueLoop and PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE) do
      begin
        case Msg.message of
          WM_WINDOWPOSCHANGING:
            begin
              EndLoop;
              Exit;
            end;
          WM_QUIT{, WM_NCLBUTTONDOWN..WM_NCMBUTTONDBLCLK}:
            begin
              EndLoop;
              Continue;
            end;
          WM_TIMER:
            begin
              if (Msg.hwnd = 0) or (AView <> nil) then
              begin
                if GetCursorPos(TPos) then
                begin
                  AutoPopupTime := AutoPopupTime + 50;
                  { Check auto popup }
                  GetCursorPos(TPos);
                  if (TPos.X = TOldPos.X) and (TPos.Y = TOldPos.Y) then
                  begin
                    if (AutoPopupTime >= 500) then
                    begin
                      Obj := AView.ObjectAtPoint(PointF(TPos.X, TPos.Y));
                      if (Obj <> nil) and (Obj.GetObject is TMenuItem) and (TOpenMenuItem(Obj.GetObject).HavePopup) then
                      begin
                        TOpenMenuItem(Obj.GetObject).NeedPopup;
                      end;
                      AutoPopupTime := 0;
                    end
                  end
                  else
                    AutoPopupTime := 0;
                  TOldPos := TPos;
                end;
              end
              else
                TranslateMessage(Msg);
            end;
        end;
        if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
        begin
          case Msg.message of
            WM_CONTEXTMENU: ;
            WM_NCMOUSEMOVE, WM_NCLBUTTONDOWN, WM_NCLBUTTONUP:
            begin
              case Msg.message of
                WM_NCMOUSEMOVE: begin
                  { Handle MouseOver }
                  {$IFDEF CPUX64}
                  WP := SmallPointToPoint(TSmallPoint(Cardinal(Msg.lParam)));
                  {$ELSE}
                  WP := SmallPointToPoint(TSmallPoint(Msg.lParam));
                  {$ENDIF}
                  P := PointF(WP.X, WP.Y);
                  Obj := AView.ObjectAtPoint(P);
                  TranslateMessage(Msg);
                  DispatchMessage(Msg);
                  { Handle menus }
                  AutoPopupTime := 0;
                  { Find top level menu }
                  CurrentView := AView;
                  while CurrentView.ParentView <> nil do
                    CurrentView := CurrentView.ParentView;
                  { Check all items }
                  while CurrentView <> nil do
                  begin
                    Obj := CurrentView.ObjectAtPoint(P);
                    if (Obj <> nil) and (Obj.GetObject is TMenuItem) and not (TMenuItem(Obj.GetObject).IsSelected) then
                    begin
                      if (CurrentView <> AView) then
                      begin
                        NewView := AView;
                        while NewView <> CurrentView do
                        begin
                          NewView.Loop := False;
                          NewView := NewView.ParentView;
                        end;
                        TOpenMenuItem(Obj.GetObject).NeedPopup;
                        Exit;
                      end;
                    end;
                    CurrentView := CurrentView.ChildView;
                  end;
                  Continue;
                end;
                WM_NCLBUTTONDOWN: begin
                  { Handle MouseOver if mouse over not menuitem }
                  {$IFDEF CPUX64}
                  WP := SmallPointToPoint(TSmallPoint(Cardinal(Msg.lParam)));
                  {$ELSE}
                  WP := SmallPointToPoint(TSmallPoint(Msg.lParam));
                  {$ENDIF}
                  P := PointF(WP.X, WP.Y);
                  Obj := AView.ObjectAtPoint(P);
                  if (Obj <> nil) and not (Obj is TMenuItem) then
                  begin
                    TranslateMessage(Msg);
                    DispatchMessage(Msg);
                    Continue;
                  end;
                  { Menus }
                  if (Obj <> nil) and (Obj.GetObject is TMenuItem) then
                  begin
                    if not (TMenuItem(Obj.GetObject).IsSelected) and TMenuItem(Obj.GetObject).HavePopup then
                      TOpenMenuItem(Obj.GetObject).NeedPopup
                    else
                    begin
                      EndLoop;
                      TOpenMenuItem(Obj.GetObject).Click;
                    end;
                  end
                  else
                  begin
                    CurrentView := AView;
                    InMenus := False;
                    while (CurrentView <> nil) and not InMenus do
                    begin
                      if not (CurrentView.IsMenuBar) and (CurrentView.ObjectAtPoint(P) <> nil) then
                        InMenus := True;
                      CurrentView := CurrentView.ParentView;
                    end;
                    if not InMenus then
                      EndLoop;
                  end;
                end;
                WM_NCLBUTTONUP: begin
                  { Handle MouseOver if mouse over not menuitem }
                  {$IFDEF CPUX64}
                  WP := SmallPointToPoint(TSmallPoint(Cardinal(Msg.lParam)));
                  {$ELSE}
                  WP := SmallPointToPoint(TSmallPoint(Msg.lParam));
                  {$ENDIF}
                  P := PointF(WP.X, WP.Y);
                  Obj := AView.ObjectAtPoint(P);
                  if (Obj <> nil) and not (Obj is TMenuItem) then
                  begin
                    TranslateMessage(Msg);
                    DispatchMessage(Msg);
                    Continue;
                  end;
                end;
              end;
            end;
            WM_MOUSEFIRST..WM_MOUSELAST:
            begin
              case Msg.message of
                WM_MOUSEMOVE: begin
                  { Handle MouseOver }
                  {$IFDEF CPUX64}
                  WP := SmallPointToPoint(TSmallPoint(Cardinal(Msg.lParam)));
                  {$ELSE}
                  WP := SmallPointToPoint(TSmallPoint(Msg.lParam));
                  {$ENDIF}
                  Winapi.Windows.ClientToScreen(Msg.hwnd, WP);
                  P := PointF(WP.X, WP.Y);
                  Obj := AView.ObjectAtPoint(P);
                  TranslateMessage(Msg);
                  DispatchMessage(Msg);
                  { Handle menus }
                  AutoPopupTime := 0;
                  { Find top level menu }
                  CurrentView := AView;
                  while CurrentView.ParentView <> nil do
                    CurrentView := CurrentView.ParentView;
                  { Check all items }
                  while CurrentView <> nil do
                  begin
                    Obj := CurrentView.ObjectAtPoint(P);
                    if (Obj <> nil) and (Obj.GetObject is TMenuItem) and not (TMenuItem(Obj.GetObject).IsSelected) then
                    begin
                      if (CurrentView <> AView) then
                      begin
                        NewView := AView;
                        while NewView <> CurrentView do
                        begin
                          NewView.Loop := False;
                          NewView := NewView.ParentView;
                        end;
                        TOpenMenuItem(Obj.GetObject).NeedPopup;
                        Exit;
                      end;
                    end;
                    CurrentView := CurrentView.ChildView;
                  end;
                  Continue;
                end;
                WM_LBUTTONDOWN: begin
                  { Handle MouseOver if mouse over not menuitem }
                  {$IFDEF CPUX64}
                  WP := SmallPointToPoint(TSmallPoint(Cardinal(Msg.lParam)));
                  {$ELSE}
                  WP := SmallPointToPoint(TSmallPoint(Msg.lParam));
                  {$ENDIF}
                  Winapi.Windows.ClientToScreen(Msg.hwnd, WP);
                  P := PointF(WP.X, WP.Y);
                  Obj := AView.ObjectAtPoint(P);
                  if (Obj <> nil) and not (Obj is TMenuItem) then
                  begin
                    TranslateMessage(Msg);
                    DispatchMessage(Msg);
                    Continue;
                  end;
                  { Menus }
                  if (Obj <> nil) and (Obj.GetObject is TMenuItem) then
                  begin
                    if not (TMenuItem(Obj.GetObject).IsSelected) and TMenuItem(Obj.GetObject).HavePopup then
                      TOpenMenuItem(Obj.GetObject).NeedPopup
                    else
                    begin
                      EndLoop;
                      TOpenMenuItem(Obj.GetObject).Click;
                    end;
                  end
                  else
                  begin
                    CurrentView := AView;
                    InMenus := False;
                    while (CurrentView <> nil) and not InMenus do
                    begin
                      if not (CurrentView.IsMenuBar) and (CurrentView.ObjectAtPoint(P) <> nil) then
                        InMenus := True;
                      CurrentView := CurrentView.ParentView;
                    end;
                    if not InMenus then
                      EndLoop;
                  end;
                end;
                WM_LBUTTONUP: begin
                  { Handle MouseOver if mouse over not menuitem }
                  {$IFDEF CPUX64}
                  WP := SmallPointToPoint(TSmallPoint(Cardinal(Msg.lParam)));
                  {$ELSE}
                  WP := SmallPointToPoint(TSmallPoint(Msg.lParam));
                  {$ENDIF}
                  Winapi.Windows.ClientToScreen(Msg.hwnd, WP);
                  P := PointF(WP.X, WP.Y);
                  Obj := AView.ObjectAtPoint(P);
                  if (Obj <> nil) and not (Obj is TMenuItem) then
                  begin
                    TranslateMessage(Msg);
                    DispatchMessage(Msg);
                    Continue;
                  end;
                end;
              end;
            end;
            WM_KEYFIRST..WM_KEYLAST:
              if (GetKeyState(VK_LBUTTON) >= 0) then
                case Msg.message of
                  WM_KEYDOWN, WM_SYSKEYDOWN:
                    case Msg.wParam of
                      VK_TAB:
                      begin
                      end;
                      VK_RETURN:
                      begin
                        if (AView.Selected <> nil) then
                        begin
                          if AView.Selected.HavePopup then
                            AView.Selected.NeedPopup
                          else
                          begin
                            TOpenMenuItem(AView.Selected).Click;
                            EndLoop;
                          end;
                        end
                        else
                          EndLoop;
                      end;
                      VK_SPACE:
                      begin
                      end;
                      VK_ESCAPE:
                      begin
                        AView.Selected := nil;
                        Exit;
                      end;
                      VK_MENU, VK_F10:
                        EndLoop;
                      VK_LEFT:
                      begin
                        if AView.IsMenuBar then
                        begin
                          SelectPrevMenuItem(AView);
                        end
                        else
                          if (AView.ParentView <> nil) then
                            if (AView.ParentView.IsMenuBar) then
                            begin
                              AView.Loop := False;
                              SelectPrevMenuItem(AView.ParentView);
                              if AView.ParentView.Selected <> nil then
                                AView.ParentView.Selected.NeedPopup;
                              Exit;
                            end
                            else
                            begin
                              AView.Loop := False;
                            end;
                      end;
                      VK_RIGHT:
                      begin
                        if AView.IsMenuBar then
                        begin
                          SelectNextMenuItem(AView);
                        end
                        else
                        begin
                          if (AView.ParentView <> nil) then
                            if (AView.ParentView.IsMenuBar) then
                            begin
                              AView.Loop := False;
                              SelectNextMenuItem(AView.ParentView);
                              if AView.ParentView.Selected <> nil then
                                AView.ParentView.Selected.NeedPopup;
                              Exit;
                            end
                            else
                            begin
                              AView.Loop := False;
                            end;
                        end;
                      end;
                      VK_UP:
                        if not AView.IsMenuBar then
                          SelectPrevMenuItem(AView);
                      VK_DOWN:
                        if not AView.IsMenuBar then
                          SelectNextMenuItem(AView)
                        else
                          if AView.Selected <> nil then
                            AView.Selected.NeedPopup;
                    end;
                  WM_CHAR, WM_SYSCHAR: ;
                end;
          else
            TranslateMessage(Msg);
            DispatchMessage(Msg);
          end;
        end;
      end;
    end;
  finally
    KillTimer(0, TimerId);
    AView.Loop := False;
    Winapi.Windows.ReleaseCapture;
  end;
end;

type
  TMenuKeyCap = (mkcBkSp, mkcTab, mkcEsc, mkcEnter, mkcSpace, mkcPgUp,
    mkcPgDn, mkcEnd, mkcHome, mkcLeft, mkcUp, mkcRight, mkcDown, mkcIns,
    mkcDel, mkcShift, mkcCtrl, mkcAlt, mkcCmd);

var
  MenuKeyCaps: array[TMenuKeyCap] of string = (
    SmkcBkSp, SmkcTab, SmkcEsc, SmkcEnter, SmkcSpace, SmkcPgUp,
    SmkcPgDn, SmkcEnd, SmkcHome, SmkcLeft, SmkcUp, SmkcRight,
    SmkcDown, SmkcIns, SmkcDel, SmkcShift, SmkcCtrl, SmkcAlt, SmkcCmd);

procedure TPlatformWin.ShortCutToKey(ShortCut: TShortCut; var Key: Word;
  var Shift: TShiftState);
begin
  Key := ShortCut and not (scShift + scCtrl + scAlt);
  Shift := [];
  if ShortCut and scShift <> 0 then Include(Shift, ssShift);
  if ShortCut and scCtrl <> 0 then Include(Shift, ssCtrl);
  if ShortCut and scAlt <> 0 then Include(Shift, ssAlt);
  if ShortCut and scCommand <> 0 then Include(Shift, ssCommand);
end;

function TPlatformWin.ShortCutToText(ShortCut: TShortCut): string;

  function GetSpecialName(ShortCut: TShortCut): string;
  var
    ScanCode: Integer;
    KeyName: MarshaledString;
  begin
    Result := '';
    ScanCode := MapVirtualKey(LoByte(Word(ShortCut)), 0) shl 16;
    if ScanCode <> 0 then
    begin
      KeyName := StrAlloc(256);
      GetKeyNameText(ScanCode, KeyName, 256);
      GetSpecialName := KeyName;
      StrDispose(KeyName);
    end;
  end;

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
    if ShortCut and scCommand <> 0 then Result := Result + MenuKeyCaps[mkcCmd];
    if ShortCut and scAlt <> 0 then Result := Result + MenuKeyCaps[mkcAlt];
    Result := Result + Name;
  end
  else Result := '';
end;

function TPlatformWin.TextToShortCut(Text: string): integer;
 { If the front of Text is equal to Front then remove the matching piece
    from Text and return True, otherwise return False }

  function CompareFront(var Text: string; const Front: string): Boolean;
  begin
    Result := False;
    if (Length(Text) >= Length(Front)) and
      (AnsiStrLIComp(PChar(Text), PChar(Front), Length(Front)) = 0) then
    begin
      Result := True;
      Text := Text.Remove(0, Front.Length);
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
    else if CompareFront(Text, MenuKeyCaps[mkcCmd]) then Shift := Shift or scCommand
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

procedure TPlatformWin.ThreadSync(var Msg: TMessage);
begin
  if Msg.Msg = WM_NULL then
  begin
    CheckSynchronize;
    Msg.Result := 0;
  end else
    Msg.Result := DefWindowProc(FThreadSyncHandle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

{ OS Menu }

procedure TPlatformWin.RemoveChildHandles(const AMenu: IItemsContainer);
var
  I: Integer;
  ItemsContainer: IItemsContainer;
begin
  for I := 0 to AMenu.GetItemsCount - 1 do
  if Supports(AMenu.GetItem(I), IItemsContainer, ItemsContainer) then
    RemoveChildHandles(ItemsContainer);
  DestroyMenuItem(AMenu);
end;

procedure TPlatformWin.CreateOSMenu(AForm: TCommonCustomForm; const AMenu: IItemsContainer);

  function SetItemFlags(const AMenuItem: TMenuItem):integer;
  begin
    Result := 0;
    if AMenuItem.Text = '-' then
      Result := Result or MF_SEPARATOR
    else
    begin
      if AMenuItem.IsChecked then
        Result := Result or MF_CHECKED;

      if not AMenuItem.Enabled then
        Result := Result or MF_DISABLED;

      Result := Result or MF_STRING;
    end;
  end;

  procedure InsertItems(Parent: HMENU; Child: IItemsContainer; L: integer);
  var
    i, Flags, VisibleCount: Integer;
    PopupMenu: HMENU;
    Native: INativeControl;
    Item: TMenuItem;
    SubChild: IItemsContainer;
    S: string;
  begin
    if Assigned(Child) and
      (Child.GetObject is TMenuItem) then
    begin
      Item := TMenuItem(Child.GetObject);
      if Item.Visible and
         Supports(Item, INativeControl, Native) then
      begin
        Flags := SetItemFlags(Item);
        VisibleCount := 0;
        for i := 0 to Child.GetItemsCount - 1 do
          if (Child.GetItem(i) is TMenuItem) and
             (TMenuItem(Child.GetItem(i)).Visible) then
            inc(VisibleCount);
        if VisibleCount > 0 then
          Flags := Flags or MF_POPUP;

        Native.Handle := 0;
        PopupMenu := CreateMenu;
        if PopupMenu = 0 then
          RaiseLastOSError;
        try
          if L > 0 then
            S := ShortCutToText(Item.ShortCut)
          else
            S := '';
          if S <> '' then
            S := #9 + S;
          S := Item.Text + S;
          if AppendMenu(Parent, Flags, PopupMenu, PChar(S)) then
          begin
            if VisibleCount > 0 then
              for i := 0 to Child.GetItemsCount - 1 do
                if Supports(Child.GetItem(i), IItemsContainer, SubChild) then
                  InsertItems(PopupMenu, SubChild, L + 1);
            Native.Handle := PopupMenu;
          end
          else
            RaiseLastOSError;
        except
          DestroyMenu(PopupMenu);
          raise;
        end;
        FHMenuMap.Add(PopupMenu, Item);
      end;
    end;
  end;
var
  Handle: HMENU;
  WND: HWND;
  i, VisibleCount: Integer;
  WindowBorder: TWindowBorderWin;
  Native: INativeControl;
  LWindowState : TWindowState ;
begin
  if FCreateOSMenu then
    Exit;
  LWindowState := AForm.WindowState ;
  try
    FCreateOSMenu := True;
    WND := WindowHandleToPlatform(AForm.Handle).Wnd;
    if WND <> 0 then
    begin
      VisibleCount := 0;
      Native := nil;
      if Assigned(AMenu) then
      begin
        RemoveChildHandles(AMenu);
        Supports(AMenu.GetObject, INativeControl, Native);
        if ((not (csDesigning in AForm.ComponentState)) and
            (AForm.Border.IsSupported)) then
        begin
          WindowBorder := TWindowBorderWin(AForm.Border.WindowBorder);
          WindowBorder.CreateOSMenu(AMenu);
        end
        else
        begin
          if Assigned(Native) and
             (Native.HandleSupported) then
          begin
            for i := 0 to AMenu.GetItemsCount - 1 do
              if (AMenu.GetItem(i) is TMenuItem) and
                  TMenuItem(AMenu.GetItem(i)).Visible then
                inc(VisibleCount);
          end;
        end;
      end;
      Handle := GetMenu(WND);
      if VisibleCount > 0 then
      begin
        if Handle = 0 then
        begin
          Native.Handle := 0;
          Handle := CreateMenu;
          if Handle = 0 then
            RaiseLastOSError;
        end;
        try
          for i := 0 to AMenu.GetItemsCount - 1 do
            if (AMenu.GetItem(i) is TMenuItem) and
                TMenuItem(AMenu.GetItem(i)).Visible then
              InsertItems(Handle, TMenuItem(AMenu.GetItem(i)), 0);
        except
          DestroyMenu(Handle);
          raise;
        end;
        SetMenu(WND, Handle);
      end
      else
      begin
        if Handle <> 0 then
        begin
          if not DestroyMenu(Handle) then
            RaiseLastOSError;
          SetMenu(WND, 0);
          Handle := 0;
        end;
      end;
      if Assigned(Native) then
        Native.Handle := Handle;
    end;
    TOpenCustomForm(AForm).ResizeHandle;
  finally
    if LWindowState <> AForm.WindowState then
      AForm.WindowState := LWindowState;
    FCreateOSMenu := False;
  end;
end;

procedure TPlatformWin.UpdateMenuBar;
begin

end;

procedure TPlatformWin.UpdateMenuItem(const AItem: IItemsContainer; AChange: TMenuItemChanges);
var
  P: TFmxObject;
  RootMenu: TFmxObject;
  NativeControl: INativeControl;
  Root: IItemsContainer;
begin
  if Assigned(AItem) and (AItem.GetObject is TFmxObject) then
    P := AItem.GetObject
  else
    Exit;
  RootMenu := nil;
  while P.Parent <> nil do
  begin
    if Supports(P.Parent, IContent) then
      P := P.Parent;
    if (P is TMenuBar) or (P is TMainMenu) then
      RootMenu := P;
    P := P.Parent;
  end;
  if Assigned(RootMenu) and
     Assigned(RootMenu.Root) and
    (RootMenu.Root.GetObject is TCommonCustomForm) and
     Supports(RootMenu, INativeControl, NativeControl) and
     NativeControl.HandleSupported and
     Supports(RootMenu, IItemsContainer, Root) then
    CreateOSMenu(TCommonCustomForm(RootMenu.Root.GetObject), Root);
end;

procedure TPlatformWin.DestroyMenuItem(const AItem: IItemsContainer);
var
  LForm: TCommonCustomForm;
  P: TFmxObject;
  WND: HWND;
  Handle: TFmxHandle;
  Native: INativeControl;
  Root: IRoot;
begin
  if (not FInDestroyMenuItem) and
      Assigned(AItem) and
     (AItem.GetObject is TFmxObject) then
    P := AItem.GetObject
  else
    Exit;
  FInDestroyMenuItem := true;
  try
    Root := P.Root;
    if Assigned(Root) and (Root.GetObject is TCommonCustomForm) then
    begin
      LForm := TCommonCustomForm(Root.GetObject);
      if Assigned(P) and
        (Supports(P, INativeControl, Native)) and
        (Native.Handle <> 0) then
      begin
        Handle := Native.Handle;
        if not (csDesigning in LForm.ComponentState) and (LForm.Border.WindowBorder is TWindowBorderWin) and
           TWindowBorderWin(LForm.Border.WindowBorder).HandleExists(Handle) then
        begin
          TWindowBorderWin(LForm.Border.WindowBorder).RemoveHandle(Handle);
        end else
        begin
          if (Handle <> INVALID_HANDLE_VALUE) then
          begin
            WND := WindowHandleToPlatform(LForm.Handle).Wnd;
            if GetMenu(WND) = Handle then
              SetMenu(WND, 0);
            DestroyMenu(Handle);
          end;
          FHMenuMap.Remove(Handle);
        end;
        Native.Handle := 0
      end;
    end;
  finally
    FInDestroyMenuItem := False;
  end;
end;

{ Drag and Drop }

const
  SID_IDropTargetHelper = '{4657278B-411B-11d2-839A-00C04FD918D0}';
  CLSID_DragDropHelper: TGUID = (D1: $4657278A; D2: $411B; D3: $11D2; D4: ($83, $9A, $00, $C0, $4F, $D9, $18, $D0));

type
  IDropTargetHelper = interface(IUnknown)
    [SID_IDropTargetHelper]
    function DragEnter(hwndTarget: hwnd; const dataObj: IDataObject; var pt: TPoint;
      dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function DragOver(var pt: TPoint; dwEffect: Longint): HResult; stdcall;
    function Drop(const dataObj: IDataObject; var pt: TPoint; dwEffect: Longint): HResult; stdcall;
    function Show(Show: bool): HResult; stdcall;
  end;

var
  FDropTargetHelper: IDropTargetHelper;
  FDataObj: IDataObject;

function TDropTarget.GetDataObject: TDragObject;
var
  FormatEtc: TFormatEtc;
  StgMedium: TStgMedium;
  str: string;
  Drop: HDrop;
  i, numFiles, buflen: Integer;
  buffer: MarshaledString;
begin
  FillChar(Result, SizeOf(Result), 0);
  if FDataObj = nil then Exit;
  // get file name first
  FormatEtc.cfFormat := CF_HDROP;
  FormatEtc.ptd := nil;
  FormatEtc.dwAspect := DVASPECT_CONTENT;
  FormatEtc.lindex := -1;
  FormatEtc.Tymed := TYMED_HGLOBAL;
  // get FireMonkey
  FormatEtc.cfFormat := CF_OBJECT;
  if FDataObj.GetData(FormatEtc, StgMedium) = S_OK then
  begin
    Result := TDropSource(StgMedium.HGLOBAL).Data;
    Exit;
  end;
  // files
  str := '';
  FormatEtc.cfFormat := CF_HDROP;
  if FDataObj.GetData(FormatEtc, StgMedium) = S_OK then
  begin
    try
      drop := HDrop(GlobalLock(stgMedium.hGlobal));
      { Replace Text }
      numFiles := DragQueryFile(Drop, $FFFFFFFF, nil, 0);
      SetLength(Result.Files, numFiles);
      for i := 0 to numFiles - 1 do
      begin
        //Setting length of buffer plus 1 for string end char (#0)
        buflen := DragQueryFile(Drop, i, nil, 0) + 1;
        buffer := StrAlloc(buflen);
        DragQueryFile(Drop, i, buffer, buflen);
        Result.Files[i] := buffer;
        StrDispose(buffer);
        if i = 0 then
          Result.Data := Result.Files[0];
      end;
    finally
      GlobalUnlock(stgMedium.hGlobal);
      { Free the memory }
      ReleaseStgMedium(StgMedium);
    end;
    Exit;
  end;
  // get text
  FormatEtc.cfFormat := CF_UNICODETEXT;
  if FDataObj.GetData(FormatEtc, StgMedium) = S_OK then
  begin
    try
      { Lock the global memory handle to get a pointer to the data }
      str := PChar(GlobalLock(StgMedium.HGLOBAL));
      Result.Data := str;
    finally
      { Finished with the pointer }
      GlobalUnlock(StgMedium.HGLOBAL);
      { Free the memory }
      ReleaseStgMedium(StgMedium);
    end;
    Exit;
  end;
end;

function TDropTarget.DragEnter(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
  var dwEffect: Longint): HResult;
var
  Res: HResult;
begin
  try
    FDataObj := dataObj;
    Result := S_OK;
    dwEffect := DROPEFFECT_NONE;
    if (Succeeded(CoCreateInstance(CLSID_DragDropHelper, nil, CLSCTX_INPROC_SERVER, IDropTargetHelper,
      FDropTargetHelper))) and (FDropTargetHelper <> nil) then
    begin
      Res := FDropTargetHelper.DragEnter(WindowHandleToPlatform(Form.Handle).Wnd, dataObj, pt, dwEffect);
      if (Failed(Res)) then
        FDropTargetHelper := nil;
    end;
  except
    dwEffect := DROPEFFECT_NONE;
    Result := E_UNEXPECTED;
  end;
end;

function TDropTarget.DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult;
var
  P: TPointF;
  Accept: Boolean;
begin
  Result := E_UNEXPECTED;
  try
    dwEffect := DROPEFFECT_NONE;
    P := PointF(pt.X, pt.Y);
    Accept := False;
    Form.DragOver(GetDataObject, P, Accept);
    if Accept then
      dwEffect := DROPEFFECT_LINK;
    // do NOT translate the screen coordinates to form coordinates because
    // it seems that the drop target helper needs screen coordinates
    if FDropTargetHelper <> nil then
      FDropTargetHelper.DragOver(pt, dwEffect);
    Result := S_OK;
  except
    dwEffect := DROPEFFECT_NONE;
  end;
end;

function TDropTarget.DragLeave: HResult;
begin
  Form.DragLeave;
  if (FDropTargetHelper <> nil) then
    FDropTargetHelper.DragLeave;
  FDropTargetHelper := nil;
  FDataObj := nil;
  Result := S_OK;
end;

function TDropTarget.Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
  var dwEffect: Longint): HResult;
var
  P: TPointF;
begin
  Result := S_OK;
  try
    if (dataObj = nil) then
      Exit;
    P := PointF(pt.X, pt.Y);
    Form.DragDrop(GetDataObject, P);
    // do NOT translate the screen coordinates to form coordinates because
    // it seems that the drop target helper needs screen coordinates
    if (FDropTargetHelper <> nil) then
      FDropTargetHelper.Drop(dataObj, pt, dwEffect)
  finally
    FDataObj := nil;
    FDropTargetHelper := nil;
  end;
end;

{ TDropSource }

{ IDropSource }

function TDropSource.QueryContinueDrag(fEscapePressed: bool; grfKeyState: Integer): HResult;
var
  ContinueDrop: Boolean;
begin
  if fEscapePressed then
    Result := DRAGDROP_S_CANCEL
  else if (grfKeyState and (MK_LBUTTON or MK_RBUTTON) = 0) then
  begin
    ContinueDrop := True;
    if ContinueDrop then
      Result := DRAGDROP_S_DROP
    else
      Result := DRAGDROP_S_CANCEL;
  end
  else
    Result := S_OK;
end;

function TDropSource.GiveFeedback(dwEffect: Integer): HResult;
begin
  Result := S_OK; // DRAGDROP_S_USEDEFAULTCURSORS;
end;

{ IDataObject }

function TDropSource.dAdvise(const FormatEtc: TFormatEtc; advf: Longint; const advsink: IAdviseSink;
  out dwConnection: Longint): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TDropSource.dUnadvise(dwConnection: Longint): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TDropSource.EnumdAdvise(out EnumAdvise: IEnumStatData): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TDropSource.EnumFormatEtc(dwDirection: Longint; out EnumFormatEtc: IEnumFormatEtc): HResult;
begin
  if (dwDirection = DATADIR_GET) then
    Result := S_OK
  else
    Result := E_NOTIMPL;
end;

function TDropSource.GetCanonicalFormatEtc(const FormatEtc: TFormatEtc; out FormatEtcout: TFormatEtc): HResult;
begin
  Result := DATA_S_SAMEFORMATETC;
end;

function TDropSource.EqualFormatEtc(FormatEtc1, FormatEtc2: TFormatEtc): Boolean;
begin
  Result := (FormatEtc1.cfFormat = FormatEtc2.cfFormat) and (FormatEtc1.ptd = FormatEtc2.ptd) and
    (FormatEtc1.dwAspect = FormatEtc2.dwAspect) and (FormatEtc1.lindex = FormatEtc2.lindex) and
    (FormatEtc1.Tymed = FormatEtc2.Tymed)
end;

function TDropSource.FindFormatEtc(TestFormatEtc: TFormatEtc): Integer;
var
  i: Integer;
  Found: Boolean;
begin
  i := 0;
  Found := False;
  Result := -1;
  while (i < Length(Formats)) and not Found do
  begin
    Found := EqualFormatEtc(Formats[i].FormatEtc, TestFormatEtc);
    if Found then
      Result := i;
    Inc(i);
  end
end;

function TDropSource.HGlobalClone(HGLOBAL: THandle): THandle;
// Returns a global memory block that is a copy of the passed memory block.
var
  size: LongWord;
  Data, NewData: PByte;
begin
  size := GlobalSize(HGLOBAL);
  Result := GlobalAlloc(GPTR, size);
  Data := GlobalLock(HGLOBAL);
  try
    NewData := GlobalLock(Result);
    try
      Move(Data, NewData, size);
    finally
      GlobalUnlock(Result);
    end
  finally
    GlobalUnlock(HGLOBAL)
  end
end;

function TDropSource.RetrieveOwnedStgMedium(Format: TFormatEtc; var StgMedium: TStgMedium): HResult;
var
  i: Integer;
begin
  Result := E_INVALIDARG;
  i := FindFormatEtc(Format);
  if (i > -1) and Formats[i].OwnedByDataObject then
    Result := StgMediumIncRef(Formats[i].StgMedium, StgMedium, False)
end;

function TDropSource.StgMediumIncRef(const InStgMedium: TStgMedium; var OutStgMedium: TStgMedium;
  CopyInMedium: Boolean): HResult;
begin
  Result := S_OK;
  // Simply copy all fields to start with.
  OutStgMedium := InStgMedium;
  case InStgMedium.Tymed of
    TYMED_HGLOBAL:
      begin
        if CopyInMedium then
        begin
          // Generate a unique copy of the data passed
          OutStgMedium.HGLOBAL := HGlobalClone(InStgMedium.HGLOBAL);
          if OutStgMedium.HGLOBAL = 0 then
            Result := E_OUTOFMEMORY
        end
        else
          // Don't generate a copy just use ourselves and the copy previoiusly saved
          MySTGMEDIUM(OutStgMedium).UnkForRelease := Pointer(Self as IDataObject) // Does increase RefCount
      end;
    TYMED_FILE:
      begin
        if CopyInMedium then
        begin
          OutStgMedium.lpszFileName := CoTaskMemAlloc(lstrLenW(InStgMedium.lpszFileName));
          // !!          StrCopyW(PChar(OutStgMedium.lpszFileName), PChar(InStgMedium.lpszFileName))
        end
        else
          MySTGMEDIUM(OutStgMedium).UnkForRelease := Pointer(Self as IDataObject) // Does increase RefCount
      end;
    TYMED_ISTREAM:
                                              
      IUnknown(MySTGMEDIUM(OutStgMedium).stm)._AddRef;
    TYMED_ISTORAGE:
      IUnknown(MySTGMEDIUM(OutStgMedium).stg)._AddRef;
    TYMED_GDI:
      if not CopyInMedium then
        MySTGMEDIUM(OutStgMedium).UnkForRelease := Pointer(Self as IDataObject)
        // Does not increase RefCount
      else
        Result := DV_E_TYMED; // Don't know how to copy GDI objects right now
    TYMED_MFPICT:
      if not CopyInMedium then
        MySTGMEDIUM(OutStgMedium).UnkForRelease := Pointer(Self as IDataObject)
        // Does not increase RefCount
      else
        Result := DV_E_TYMED;
    // Don't know how to copy MetaFile objects right now
    TYMED_ENHMF:
      if not CopyInMedium then
        MySTGMEDIUM(OutStgMedium).UnkForRelease := Pointer(Self as IDataObject)
        // Does not increase RefCount
      else
        Result := DV_E_TYMED;
    // Don't know how to copy enhanced metafiles objects right now
  else
    Result := DV_E_TYMED
  end;

  // I still have to do this. The Compiler will call _Release on the above Self as IDataObject
  // casts which is not what is necessary.  The DataObject is released correctly.
  if Assigned(MySTGMEDIUM(OutStgMedium).UnkForRelease) and (Result = S_OK) then
    IUnknown(MySTGMEDIUM(OutStgMedium).UnkForRelease)._AddRef
end;

function TDropSource.GetData(const FormatEtcIn: TFormatEtc; out Medium: TStgMedium): HResult;
var
  Global: cardinal;
  P: Pointer;
  W: string;
  B: TBitmap;
  BitmapHandle: cardinal;
begin
  FillChar(Medium, SizeOf(Medium), 0);
  Result := DV_E_FORMATETC;
  if QueryGetData(FormatEtcIn) <> S_OK then
    Exit;

  if FormatEtcIn.cfFormat = CF_OBJECT then
  begin
    Medium.Tymed := TYMED_HGLOBAL;
    Medium.HGLOBAL := THandle(Self);
    Result := S_OK;
    Exit;
  end;
  case FormatEtcIn.cfFormat of
    CF_UNICODETEXT:
      begin
        W := Data.Data.ToString;
        Global := GlobalAlloc(0, (Length(W) + 1) * 2);
        P := GlobalLock(Global);
        try
          Move(PChar(W)^, P^, GlobalSize(Global));
        finally
          GlobalUnlock(Global);
        end;
        Medium.Tymed := TYMED_HGLOBAL;
        Medium.HGLOBAL := Global;
        Result := S_OK;
      end;
    CF_BITMAP:
      begin
        if Data.Data.IsObject and (Data.Data.AsObject is TBitmap) then
        begin
          B := TBitmap(Data.Data.AsObject);
          BitmapHandle := HBmpFromBitmap(B);
          if BitmapHandle <> 0 then
          begin
            Medium.Tymed := TYMED_GDI;
            Medium.HBITMAP := BitmapHandle;
            Result := S_OK;
          end;
        end
      end;
  end;
  if Result <> S_OK then
    if Assigned(Formats) then
    begin
      { Do we support this type of Data? }
      Result := QueryGetData(FormatEtcIn);
      if Result = S_OK then
      begin
        // If the data is owned by the IDataObject just retrieve and return it.
        if RetrieveOwnedStgMedium(FormatEtcIn, Medium) = E_INVALIDARG then
          Result := E_UNEXPECTED
      end
    end
end;

function TDropSource.GetDataHere(const FormatEtc: TFormatEtc; out Medium: TStgMedium): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDropSource.QueryGetData(const FormatEtc: TFormatEtc): HResult;
var
  i: Integer;
begin
  Result := DV_E_FORMATETC;
  if FormatEtc.cfFormat = CF_OBJECT then
  begin
    Result := S_OK;
    Exit;
  end;
  case FormatEtc.cfFormat of
    CF_UNICODETEXT:
      begin
        if not Data.Data.IsObject then
          Result := S_OK;
      end;
    CF_BITMAP:
      begin
        if Data.Data.IsObject and (Data.Data.AsObject is TBitmap) then
          Result := S_OK;
      end;
  end;
  if Result <> S_OK then
  begin
    if Assigned(Formats) then
    begin
      i := 0;
      Result := DV_E_FORMATETC;
      while (i < Length(Formats)) and (Result = DV_E_FORMATETC) do
      begin
        if Formats[i].FormatEtc.cfFormat = FormatEtc.cfFormat then
        begin
          if (Formats[i].FormatEtc.dwAspect = FormatEtc.dwAspect) then
          begin
            if (Formats[i].FormatEtc.Tymed and FormatEtc.Tymed <> 0) then
              Result := S_OK
            else
              Result := DV_E_TYMED;
          end
          else
            Result := DV_E_DVASPECT;
        end
        else
          Result := DV_E_FORMATETC;
        Inc(i)
      end
    end
    else
      Result := E_UNEXPECTED;
  end;
end;

function TDropSource.CanonicalIUnknown(const TestUnknown: IUnknown): IUnknown;
// Uses COM object identity: An explicit call to the IUnknown::QueryInterface
// method, requesting the IUnknown interface, will always return the same
// pointer.
begin
  if Assigned(TestUnknown) then
  begin
    if Supports(TestUnknown, IUnknown, Result) then
      IUnknown(Result)._Release
      // Don't actually need it just need the pointer value
    else
      Result := TestUnknown
  end
  else
    Result := TestUnknown
end;

function TDropSource.SetData(const FormatEtc: TFormatEtc; var Medium: TStgMedium; fRelease: Bool): HRESULT;
var
  Index: Integer;
begin
  // See if we already have a format of that type available.
  Index := FindFormatEtc(FormatEtc);
  if Index > -1 then
  begin
    // Yes we already have that format type stored.  Just use the TClipboardFormat
    // in the List after releasing the data
    ReleaseStgMedium(Formats[Index].StgMedium);
    FillChar(Formats[Index].StgMedium, SizeOf(Formats[Index].StgMedium), #0);
  end
  else
  begin
    // It is a new format so create a new TDataObjectInfo record and store it in
    // the Format array
    SetLength(Formats, Length(Formats) + 1);
    Formats[Length(Formats) - 1].FormatEtc := FormatEtc;
    Index := Length(Formats) - 1;
  end;
  // The data is owned by the TClipboardFormat object
  Formats[Index].OwnedByDataObject := True;

  if fRelease then
  begin
    // We are simply being given the data and we take control of it.
    Formats[Index].StgMedium := Medium;
    Result := S_OK
  end
  else
    // We need to reference count or copy the data and keep our own references
    // to it.
    Result := StgMediumIncRef(Medium, Formats[Index].StgMedium, True);

  // Can get a circular reference if the client calls GetData then calls
  // SetData with the same StgMedium.  Because the unkForRelease and for
  // the IDataObject can be marshalled it is necessary to get pointers that
  // can be correctly compared.
  // See the IDragSourceHelper article by Raymond Chen at MSDN.
  if Assigned(MySTGMEDIUM(Formats[Index].StgMedium).UnkForRelease) then
  begin
    if CanonicalIUnknown(Self) = CanonicalIUnknown(IUnknown(MySTGMEDIUM(Formats[Index].StgMedium).UnkForRelease)) then
    begin
      IUnknown(MySTGMEDIUM(Formats[Index].StgMedium).UnkForRelease)._Release;
      MySTGMEDIUM(Formats[Index].StgMedium).UnkForRelease := nil
    end;
  end;
end;

{ Platform DragDrop }

function DragHBmpFromBitmap(const Bitmap: TBitmap): THandle;
var
  BitmapInfo: TBitmapInfo;
  BitmapBits: Pointer;
  M: TBitmapData;
  I, J: Integer;
  C: PAlphaColorRec;
begin
  FillChar(BitmapInfo, SizeOf(BitmapInfo), 0);
  BitmapInfo.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  BitmapInfo.bmiHeader.biPlanes := 1;
  BitmapInfo.bmiHeader.biBitCount := 32;
  BitmapInfo.bmiHeader.biCompression := BI_RGB;
  BitmapInfo.bmiHeader.biWidth := Bitmap.Width;
  if BitmapInfo.bmiHeader.biWidth <= 0 then
    BitmapInfo.bmiHeader.biWidth := 1;
  BitmapInfo.bmiHeader.biHeight := -Bitmap.Height;
  if BitmapInfo.bmiHeader.biHeight >= 0 then
    BitmapInfo.bmiHeader.biHeight := -1;
  Result := CreateDIBSection(0, BitmapInfo, DIB_RGB_COLORS, Pointer(BitmapBits), 0, 0);
  if BitmapBits <> nil then
  begin
    if Bitmap.Map(TMapAccess.maRead, M) then
    try
      for I := 0 to Bitmap.Height - 1 do
        Move(PAlphaColorArray(M.Data)[I * (M.Pitch div 4)],
             PAlphaColorArray(BitmapBits)[I * Bitmap.Width],
             Bitmap.Width * 4);
      // Remove black pixel that didn't show
      for J := 0 to Bitmap.Height - 1 do
        for I := 0 to Bitmap.Width - 1 do
        begin
          C := @PAlphaColorRecArray(BitmapBits)[I + J * Bitmap.Width];
          if (C.A > 0) and ((C.Color and $FFFFFF) = 0) then
            C.Color := (C.Color and $FF000000) or $0A0A0A; // 0A is minimal not-ignored value
        end;
    finally
      Bitmap.Unmap(M);
    end;
  end;
end;

procedure TPlatformWin.BeginDragDrop(AForm: TCommonCustomForm; const Data: TDragObject; ABitmap: TBitmap);
var
  D: TDropSource;
  DropEffect: Longint;
  DragSourceHelper: IDragSourceHelper;
  SHDRAGIMAGE: TSHDRAGIMAGE;
  Offset: TPointF;
begin
  D := TDropSource.Create(nil);
  try
    D.Data := Data;

    if (Succeeded(CoCreateInstance(CLSID_DragDropHelper, nil, CLSCTX_INPROC_SERVER, IDragSourceHelper, DragSourceHelper)))
      and (DragSourceHelper <> nil) then
    begin
      if Data.Source is TControl then
        Offset := TControl(Data.Source).AbsoluteToLocal(AForm.ScreenToClient(GetMousePos))
      else
        Offset.SetLocation((ABitmap.Width div 2), ABitmap.Height div 2);

      FillChar(SHDRAGIMAGE, SizeOf(SHDRAGIMAGE), 0);
      SHDRAGIMAGE.sizeDragImage.cx := ABitmap.Width;
      SHDRAGIMAGE.sizeDragImage.cy := ABitmap.Height;
      SHDRAGIMAGE.ptOffset.X := Round(Offset.X);
      SHDRAGIMAGE.ptOffset.Y := Round(Offset.Y);
      SHDRAGIMAGE.hbmpDragImage := DragHBmpFromBitmap(ABitmap);
      if not Succeeded(DragSourceHelper.InitializeFromBitmap(@SHDRAGIMAGE, D)) then
        DeleteObject(SHDRAGIMAGE.hbmpDragImage);
    end;

    DoDragDrop(D, D, DROPEFFECT_LINK or DROPEFFECT_COPY or DROPEFFECT_MOVE, DropEffect);

    if Assigned(DragSourceHelper) then
      DragSourceHelper := nil;
  finally
    D.Free;
  end;
end;

{ Clipboard }

function TPlatformWin.GetClipboard: TValue;
var
  Data: THandle;
  W: string;
begin
  Result := TValue.Empty;
  OpenClipboard(0);
  Data := GetClipboardData(CF_UNICODETEXT);
  if Data <> 0 then
  begin
    W := PChar(GlobalLock(Data));
    Result := W;
    GlobalUnlock(Data);
  end;
  CloseClipboard;
end;

procedure TPlatformWin.SetClipboard(Value: TValue);
var
  Data: THandle;
  DataPtr: Pointer;
  W: string;
begin
  if not Value.IsObject then
  begin
    OpenClipboard(0);
    EmptyClipboard;
    try
      W := Value.ToString;
      Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, (Length(W) + 1) * 2);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(PChar(W)^, DataPtr^, GlobalSize(Data));
          SetClipboardData(CF_UNICODETEXT, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      CloseClipboard;
    end;
  end;
end;

{ Mouse }

procedure TPlatformWin.SetCursor(const ACursor: TCursor);
const
  CursorMap: array[crSizeAll..crNone] of PChar = (
    IDC_SIZEALL, IDC_HAND, IDC_HELP, IDC_APPSTARTING, IDC_NO, {IDC_SQLWAIT}IDC_WAIT,
    {IDC_MULTIDRAG}IDC_ARROW, {IDC_VSPLIT}IDC_SIZENS, {IDC_HSPLIT}IDC_SIZEWE, {IDC_NODROP}IDC_NO, {IDC_DRAG}IDC_ARROW, IDC_WAIT,
    IDC_UPARROW, IDC_SIZEWE, IDC_SIZENWSE, IDC_SIZENS, IDC_SIZENESW, IDC_SIZEALL,
    IDC_IBEAM, IDC_CROSS, IDC_ARROW, nil);
var
  C: HCursor;
begin
  FCursor := ACursor;
  if ACursor < 0 then
  begin
    C := LoadCursorW(0, CursorMap[ACursor]);
    Winapi.Windows.SetCursor(C);
  end;
end;

function TPlatformWin.GetCursor: TCursor;
begin
  Result := FCursor;
end;

function TPlatformWin.GetFullScreen(const AForm: TCommonCustomForm): Boolean;
var
  LFSParam : TFullScreenParams;
begin
  Result := False;
  if FFullScreenSupport.TryGetValue(AForm, LFSParam) then
    Result := LFSParam.IsFullScreen;
end;

procedure TPlatformWin.SetFullScreen(const AForm: TCommonCustomForm;
  const AValue: Boolean);
var
  LFSParam : TFullScreenParams;
  LClean : TFullScreenParams;
begin
  if not FFullScreenSupport.TryGetValue(AForm, LFSParam) then
    FFullScreenSupport.Add(AForm,LFSParam);

  if AValue then
  begin
    LFSParam.WindowState := AForm.WindowState;
    LFSParam.BorderStyle := AForm.BorderStyle;
    LFSParam.Size     := Point(AForm.Width, AForm.Height);
    LFSParam.Position := Point(AForm.Left, AForm.Top);
    FFullScreenSupport.Items[AForm] := LFSParam;
    AForm.BorderStyle := TFmxFormBorderStyle.bsNone;
    AForm.WindowState := TWindowState.wsMaximized;
  end
  else
  begin
    LClean := LFSParam;
    LClean.Clean;
    FFullScreenSupport.Items[AForm] := LClean;
    AForm.WindowState := LFSParam.WindowState;
    AForm.BorderStyle := LFSParam.BorderStyle;
    AForm.Width   := LFSParam.Size.X;
    AForm.Height  := LFSParam.Size.Y;
    AForm.Left    := LFSParam.Position.X;
    AForm.Top     := LFSParam.Position.Y;
  end;
end;

procedure TPlatformWin.SetShowFullScreenIcon(const AForm: TCommonCustomForm;
  const AValue: Boolean);
begin

end;

function TPlatformWin.GetMousePos: TPointF;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Result := PointF(P.X, P.Y);
end;

{ Screen }

function TPlatformWin.GetScreenSize: TPointF;
var
  WR: TRect;
begin
  Winapi.Windows.GetWindowRect(GetDesktopWindow, WR);
  Result := PointF(WR.Right, WR.Bottom);
end;

function TPlatformWin.GetScreenScale: Single;
begin
  Result := 1.0;
end;

function TPlatformWin.GetScreenOrientation: TScreenOrientation;
begin
  Result := TScreenOrientation.soLandscape;
end;

{ IFMXSystemInformationService }

function TPlatformWin.GetScrollingBehaviour: TScrollingBehaviours;
var
  Value: Integer;
begin
  Value := GetSystemMetrics(SM_DIGITIZER);
  if ((Value and NID_READY) = NID_READY) and (((Value and NID_MULTI_INPUT) = NID_MULTI_INPUT)) then
    Result := [sbAnimation, sbTouchTracking]
  else
    Result := [];
end;

function TPlatformWin.GetMinScrollThumbSize: Single;
begin
  Result := 15;
end;

{ IFMXStyleService }

function TPlatformWin.GetSystemStyle: TFmxObject;
begin
  Result := FMX.Controls.Win.GetSystemStyle;
end;

function TPlatformWin.GetCurrentLangID: string;
var
  buffer: MarshaledString;
  UserLCID: LCID;
  BufLen: Integer;
begin
  // defaults
  UserLCID := GetUserDefaultLCID;
  BufLen := GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, nil, 0);
  buffer := StrAlloc(BufLen);
  if GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, buffer, BufLen) <> 0 then
    Result := buffer
  else
    Result := 'en';
  StrDispose(buffer);
end;

function TPlatformWin.GetDefaultFontFamilyName: String;
var
  VI: TOSVersionInfo;
begin
  FillChar(VI, SizeOf(VI), 0);
  VI.dwOSVersionInfoSize := SizeOf(VI);
  GetVersionEx(VI);
  if VI.dwMajorVersion >= 6 then
    Result := 'Segoe UI'
  else
    Result := 'Tahoma';
end;

function TPlatformWin.GetLocaleFirstDayOfWeek: string;
var
  buffer: DWORD;
begin
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, @buffer, SizeOf(buffer) div SizeOf(Char));
  Result:= Chr(buffer);
end;

procedure GetFileNames(var OpenFileName: TOpenFilenameW; var AFileName: TFileName; var AFiles: TStrings; AOptions: TOpenOptions);
var
  Separator: WideChar;

  function ExtractFileName(P: PChar; var S: TFilename): PChar;
  begin
    Result := AnsiStrScan(P, Separator);
    if Result = nil then
    begin
      S := P;
      Result := StrEnd(P);
    end
    else
    begin
      SetString(S, P, Result - P);
      Inc(Result);
    end;
  end;

  procedure ExtractFileNames(P: PChar);
  var
    DirName, FileName: TFilename;
  begin
    P := ExtractFileName(P, DirName);
    P := ExtractFileName(P, FileName);
    if FileName = '' then
      AFiles.Add(DirName)
    else
    begin
      if AnsiLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
          (FileName[2] <> ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        AFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;

begin
  Separator := #0;
  if (TOpenOption.ofAllowMultiSelect in AOptions) and
    (TOpenOption.ofOldStyleDialog in AOptions) then
    Separator := ' ';
  if TOpenOption.ofAllowMultiSelect in AOptions then
  begin
    ExtractFileNames(OpenFileName.lpstrFile);
    AFileName := AFiles[0];
  end else
  begin
    ExtractFileName(OpenFileName.lpstrFile, AFileName);
    AFiles.Add(AFileName);
  end;
end;

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT_PTR; stdcall;
begin
  Result := 0;
end;

function TPlatformWin.DialogOpenFiles;
const
  FileNameBufferLen = 1000;
  OpenOptions: array [TOpenOption] of DWORD = (
    OFN_READONLY, OFN_OVERWRITEPROMPT, OFN_HIDEREADONLY,
    OFN_NOCHANGEDIR, OFN_SHOWHELP, OFN_NOVALIDATE, OFN_ALLOWMULTISELECT,
    OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST,
    OFN_CREATEPROMPT, OFN_SHAREAWARE, OFN_NOREADONLYRETURN,
    OFN_NOTESTFILECREATE, OFN_NONETWORKBUTTON, OFN_NOLONGNAMES,
    OFN_EXPLORER, OFN_NODEREFERENCELINKS, OFN_ENABLEINCLUDENOTIFY,
    OFN_ENABLESIZING, OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN);
var
  //Flags: DWORD;
  OpenFile: TOpenFilenameW;
  FileNameBuffer: PChar;
  FileNameBufferSize: Integer;
  InitialDir, Filter, DefaultExt: string;
  Option: TOpenOption;
  WindowList: Pointer;

  function AllocFilterStr(const s: string): string;
  var
    SepPos: Integer;
    SB: TStringBuilder;
  begin
    Result := '';
    if s <> '' then
    begin
      Result := s + #0; // double null terminators
      SB := TStringBuilder.Create(Result);
      try
        SepPos := Result.IndexOf('|');
        while SepPos >= 0 do
        begin
          SB.Chars[SepPos] := #0; // adjust because OP strings are 1-offset
          Result := SB.ToString;
          Inc(SepPos);
          SepPos := Result.IndexOf('|', SepPos);
        end;
        Result := SB.ToString + #0; // add final null terminator
      finally
        SB.Free;
      end;
    end;
  end;

begin
  InitialDir := AInitDir;
  DefaultExt := ADefaultExt;
  Filter := AllocFilterStr(AFilter);
  if (FileName <> '') and (FileName[Length(FileName)] = PathDelim) then
  begin
    // if the filename contains a directory, set the initial directory
    // and clear
    InitialDir := string(FileName).Substring(0, string(FileName).Length - 1);
    FileName := '';
  end;

  if (DefaultExt = '') or (DefaultExt = null) then
    DefaultExt := '*';

  FileNameBuffer := AllocMem(FileNameBufferLen * 2 + 2);

  if Length(FileName) > FileNameBufferLen then
    FileNameBufferSize := FileNameBufferLen
  else
    FileNameBufferSize := Length(FileName);

  Move(PChar(FileName)^, FileNameBuffer^, FileNameBufferSize * 2);

  if (Filter = '') or (Filter = null) then
     // Default -> avoid empty combobox
    Filter := 'All File Types(*.*)' + #0 + '*.*' + #0 + #0;

  AFiles.Clear;

  FillChar(OpenFile, SizeOf(OpenFile), 0);
  OpenFile.hInstance := hInstance;
  OpenFile.lStructSize := SizeOf(OpenFile);
  if (Assigned (Screen) and Assigned(Screen.ActiveForm)) then
    OpenFile.hWndOwner := WindowHandleToPlatform(Screen.ActiveForm.Handle).Wnd
  else
    OpenFile.hWndOwner := 0;

  OpenFile.nFilterIndex := 0;

  OpenFile.lpStrFile := FileNameBuffer;
  OpenFile.lpstrFilter := PChar(Filter);
  if ATitle <>'' then
    OpenFile.lpstrTitle := PChar(ATitle);
  OpenFile.lpstrInitialDir := PChar(InitialDir);
  OpenFile.lpstrDefExt := PChar(DefaultExt);
  OpenFile.lpStrFile := FileNameBuffer;

  OpenFile.nMaxFile := FileNameBufferLen + 1; // Size in TCHARs
  OpenFile.nFilterIndex := AFilterIndex;

  OpenFile.Flags := OFN_EXPLORER;
  for Option := Low(Option) to High(Option) do
    if Option in AOptions then
      OpenFile.Flags := OpenFile.Flags or OpenOptions[Option];

  if TOpenOption.ofOldStyleDialog in AOptions then
  begin
    OpenFile.Flags := OpenFile.Flags and (not OFN_EXPLORER);
    OpenFile.lpfnHook := DialogHook;
    OpenFile.Flags := OpenFile.Flags or OFN_ENABLEHOOK;
  end;
  WindowList := nil;
  try
    WindowList := DisableTaskWindows(OpenFile.hwndOwner);
    Result := GetOpenFileNameW(OpenFile);
  finally
    EnableTaskWindows(WindowList);
  end;

  if Result then
  begin
    FileName := FileNameBuffer;
    GetFileNames(OpenFile, FileName, AFiles, AOptions);
    if (OpenFile.flags and OFN_EXTENSIONDIFFERENT) <> 0 then
      Include(AOptions, TOpenOption.ofExtensionDifferent)
    else
      Exclude(AOptions, TOpenOption.ofExtensionDifferent);
    if (OpenFile.flags and OFN_READONLY) <> 0 then
      Include(AOptions, TOpenOption.ofReadOnly)
    else
      Exclude(AOptions, TOpenOption.ofReadOnly);
    AFilterIndex := OpenFile.nFilterIndex;
  end;
  FreeMem(FileNameBuffer);
end;


function TPlatformWin.DialogSaveFiles;
const
  FileNameBufferLen = 1000;
  OpenOptions: array [TOpenOption] of DWORD = (
    OFN_READONLY, OFN_OVERWRITEPROMPT, OFN_HIDEREADONLY,
    OFN_NOCHANGEDIR, OFN_SHOWHELP, OFN_NOVALIDATE, OFN_ALLOWMULTISELECT,
    OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST,
    OFN_CREATEPROMPT, OFN_SHAREAWARE, OFN_NOREADONLYRETURN,
    OFN_NOTESTFILECREATE, OFN_NONETWORKBUTTON, OFN_NOLONGNAMES,
    OFN_EXPLORER, OFN_NODEREFERENCELINKS, OFN_ENABLEINCLUDENOTIFY,
    OFN_ENABLESIZING, OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN);
var
  Flags: DWORD;
  SaveFile: TOpenFilenameW;
  FileNameBuffer: PChar;
  FileNameBufferSize: Integer;
  InitialDir, Filter, DefaultExt: string;
  Option: TOpenOption;
  WindowList: Pointer;

  function AllocFilterStr(const s: string): string;
  var
    SepPos: Integer;
    SB: TStringBuilder;
  begin
    Result := '';
    if s <> '' then
    begin
      Result := s + #0; // double null terminators
      SB := TStringBuilder.Create(Result);
      try
        SepPos := Result.IndexOf('|');
        while SepPos >= 0 do
        begin
          SB.Chars[SepPos] := #0; // adjust because OP strings are 1-offset
          Result := SB.ToString;
          Inc(SepPos);
          SepPos := Result.IndexOf('|', SepPos);
        end;
        Result := SB.ToString + #0; // add final null terminator
      finally
        SB.Free;
      end;
    end;
  end;

begin
  flags := 0;
  InitialDir := AInitDir;
  DefaultExt := ADefaultExt;
  Filter := AllocFilterStr(AFilter);
  if (AFileName <> '') and (AFileName[Length(AFileName)] = PathDelim) then
  begin
    // if the filename contains a directory, set the initial directory
    // and clear the filename
    InitialDir := string(AFileName).SubString(0, string(AFileName).Length);
    AFileName := '';
  end;
  if (DefaultExt = '') or (DefaultExt = null) then
    DefaultExt := '*';

  FileNameBuffer := AllocMem(FileNameBufferLen * 2 + 2);

  if Length(AFileName) > FileNameBufferLen then
    FileNameBufferSize := FileNameBufferLen
  else
    FileNameBufferSize := Length(AFileName);

  Move(PChar(AFileName)^, FileNameBuffer^, FileNameBufferSize * 2);

  if (Filter = '') or (Filter = null) then
    Filter := 'All File Types(*.*)' + #0 + '*.*' + #0 + #0;
    // Default -> avoid empty combobox

   AFiles.Clear;

  FillChar(SaveFile, SizeOf(SaveFile), 0);
  SaveFile.hInstance := hInstance;
  SaveFile.lStructSize := SizeOf(SaveFile);
    SaveFile.nFilterIndex := 0;
  if (Assigned (Screen) and Assigned(Screen.ActiveForm)) then
    SaveFile.hWndOwner := WindowHandleToPlatform(Screen.ActiveForm.Handle).Wnd
  else
    SaveFile.hWndOwner := 0;

  SaveFile.lpStrFile := FileNameBuffer;
  SaveFile.lpstrFilter := PChar(Filter);
  if ATitle <>'' then
    SaveFile.lpstrTitle := PChar(ATitle);
  SaveFile.lpstrInitialDir := PChar(InitialDir);
  SaveFile.lpstrDefExt := PChar(DefaultExt);
  SaveFile.lpStrFile := FileNameBuffer;

  SaveFile.nMaxFile := FileNameBufferLen + 1; // Size in TCHARs
  SaveFile.nFilterIndex := AFilterIndex;

  SaveFile.Flags := OFN_EXPLORER;
  for Option := Low(Option) to High(Option) do
    if Option in AOptions then
      SaveFile.Flags := SaveFile.Flags or OpenOptions[Option];
  if TOpenOption.ofAllowMultiSelect in AOptions then
    SaveFile.Flags := SaveFile.Flags or OFN_ALLOWMULTISELECT;
  WindowList := nil;
  try
    WindowList := DisableTaskWindows(SaveFile.hwndOwner);
    Result := GetSaveFileName(SaveFile);
  finally
    EnableTaskWindows(WindowList);
  end;

  if Result then
  begin
    AFileName := FileNameBuffer;
    GetFileNames(SaveFile, AFileName, AFiles, AOptions);
    if (flags and OFN_EXTENSIONDIFFERENT) <> 0 then
      Include(AOptions, TOpenOption.ofExtensionDifferent)
    else
      Exclude(AOptions, TOpenOption.ofExtensionDifferent);
    if (flags and OFN_READONLY) <> 0 then
      Include(AOptions, TOpenOption.ofReadOnly)
    else
      Exclude(AOptions, TOpenOption.ofReadOnly);
    AFilterIndex := SaveFile.nFilterIndex;
  end;
  FreeMem(FileNameBuffer);
end;

function TPlatformWin.FindForm(const AHandle: TWindowHandle): TCommonCustomForm;
begin
  Result := nil;
end;

procedure GetPrinter(var DeviceMode, DeviceNames: HGLOBAL);
var
  Device, Driver, Port: array[0..1023] of char;
  DevNames: PDevNames;
  Offset: PChar;
begin
  (Printer as TPrinterWin).GetPrinter(Device, Driver, Port, DeviceMode);
  if DeviceMode <> 0 then
  begin
    DeviceNames := GlobalAlloc(GHND, SizeOf(TDevNames) +
     (StrLen(Device) + StrLen(Driver) + StrLen(Port) + 3) * SizeOf(Char));
    DevNames := PDevNames(GlobalLock(DeviceNames));
    try
      Offset := PChar(PByte(DevNames) + SizeOf(TDevnames));
      DevNames^.wDriverOffset := Offset - PChar(DevNames);
      Offset := StrECopy(Offset, Driver) + 1;
      DevNames^.wDeviceOffset := Offset - PChar(DevNames);
      Offset := StrECopy(Offset, Device) + 1;
      DevNames^.wOutputOffset := Offset - PChar(DevNames);;
      StrCopy(Offset, Port);
    finally
      GlobalUnlock(DeviceNames);
    end;
  end;
end;

procedure SetPrinter(DeviceMode, DeviceNames: HGLOBAL);
var
  DevNames: PDevNames;
begin
  DevNames := PDevNames(GlobalLock(DeviceNames));
  try
    (Printer as TPrinterWin).SetPrinter(PChar(DevNames) + DevNames^.wDeviceOffset,
      PChar(DevNames) + DevNames^.wDriverOffset,
      PChar(DevNames) + DevNames^.wOutputOffset, DeviceMode);
  finally
    GlobalUnlock(DeviceNames);
    GlobalFree(DeviceNames);
  end;
end;

function CopyData(Handle: THandle): THandle;
var
  Src, Dest: PChar;
  Size: Integer;
begin
  if Handle <> 0 then
  begin
    Size := GlobalSize(Handle);
    Result := GlobalAlloc(GHND, Size);
    if Result <> 0 then
      try
        Src := GlobalLock(Handle);
        Dest := GlobalLock(Result);
        if (Src <> nil) and (Dest <> nil) then Move(Src^, Dest^, Size);
      finally
        GlobalUnlock(Handle);
        GlobalUnlock(Result);
      end
  end
  else
    Result := 0;
end;

function TPlatformWin.DialogPrint(var ACollate, APrintToFile: Boolean;
      var AFromPage, AToPage, ACopies: Integer; AMinPage, AMaxPage: Integer; var APrintRange: TPrintRange;
      AOptions: TPrintDialogOptions): Boolean;
const
  PrintRanges: array [TPrintRange] of Integer = (PD_ALLPAGES, PD_SELECTION,
    PD_PAGENUMS);
var
  PrintDlgRec: TPrintDlg;
  DevHandle: HGLOBAL;
  WindowList: Pointer;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  PrintDlgRec.hInstance := hInstance;
  PrintDlgRec.lStructSize := SizeOf(PrintDlgRec);

  if (Assigned (Screen) and Assigned(Screen.ActiveForm)) then
    PrintDlgRec.hWndOwner := WindowHandleToPlatform(Screen.ActiveForm.Handle).Wnd
  else
    PrintDlgRec.hWndOwner := 0;

  GetPrinter(DevHandle, PrintDlgRec.hDevNames);
  PrintDlgRec.hDevMode := CopyData(DevHandle);
  PrintDlgRec.flags := PrintRanges[APrintRange];
  if ACollate then
    Inc(PrintDlgRec.flags, PD_COLLATE);
  if not(TPrintDialogOption.poPrintToFile in AOptions) then
    Inc(PrintDlgRec.flags, PD_HIDEPRINTTOFILE);
  if not(TPrintDialogOption.poPageNums in AOptions) then
    Inc(PrintDlgRec.flags, PD_NOPAGENUMS);
  if not(TPrintDialogOption.poSelection in AOptions) then
    Inc(PrintDlgRec.flags, PD_NOSELECTION);
  if TPrintDialogOption.poDisablePrintToFile in AOptions then
    Inc(PrintDlgRec.flags, PD_DISABLEPRINTTOFILE);
  if APrintToFile then
    Inc(PrintDlgRec.flags, PD_PRINTTOFILE);
  if TPrintDialogOption.poHelp in AOptions then
    Inc(PrintDlgRec.flags, PD_SHOWHELP);
  if not(TPrintDialogOption.poWarning in AOptions) then
    Inc(PrintDlgRec.flags, PD_NOWARNING);
  PrintDlgRec.nFromPage := AFromPage;
  PrintDlgRec.nToPage := AToPage;
  PrintDlgRec.nMinPage := AMinPage;
  PrintDlgRec.nMaxPage := AMaxPage;
  WindowList := nil;
  try
    WindowList := DisableTaskWindows(PrintDlgRec.hwndOwner);
    Result := PrintDlg(PrintDlgRec);
  finally
    EnableTaskWindows(WindowList);
  end;

  if Result then
  begin
    SetPrinter(PrintDlgRec.hDevMode, PrintDlgRec.hDevNames);
    ACollate := PrintDlgRec.flags and PD_COLLATE <> 0;
    APrintToFile := PrintDlgRec.flags and PD_PRINTTOFILE <> 0;
    if PrintDlgRec.flags and PD_SELECTION <> 0 then
      APrintRange := TPrintRange.prSelection
    else if PrintDlgRec.flags and PD_PAGENUMS <> 0 then
      APrintRange := TPrintRange.prPageNums
    else
      APrintRange := TPrintRange.prAllPages;
    AFromPage := PrintDlgRec.nFromPage;
    AToPage := PrintDlgRec.nToPage;
//      if nCopies = 1 then
//        Copies := Printer.Copies
//      else
//        Copies := nCopies;
  end
  else
  begin
    if PrintDlgRec.hDevMode <> 0 then
    begin
      GlobalFree(PrintDlgRec.hDevMode);
      PrintDlgRec.hDevMode := 0;
    end;
    if PrintDlgRec.hDevNames <> 0 then
    begin
      GlobalFree(PrintDlgRec.hDevNames);
      PrintDlgRec.hDevNames := 0;
    end;
  end;
end;

function TPlatformWin.DialogPrinterSetup: Boolean;
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
  WindowList: Pointer;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  PrintDlgRec.lStructSize := SizeOf(PrintDlgRec);
  PrintDlgRec.hInstance := SysInit.HInstance;
  GetPrinter(DevHandle, PrintDlgRec.hDevNames);
  PrintDlgRec.hDevMode := CopyData(DevHandle);
  PrintDlgRec.Flags := PD_PRINTSETUP;

  if (Assigned (Screen) and Assigned(Screen.ActiveForm)) then
    printDlgRec.hWndOwner := WindowHandleToPlatform(Screen.ActiveForm.Handle).Wnd
  else
    PrintDlgRec.hWndOwner := 0;
  WindowList := nil;
  try
    WindowList := DisableTaskWindows(PrintDlgRec.hwndOwner);
    Result := PrintDlg(PrintDlgRec);
  finally
    EnableTaskWindows(WindowList);
  end;

  if Result then
    SetPrinter(PrintDlgRec.hDevMode, PrintDlgRec.hDevNames)
  else
  begin
    if PrintDlgRec.hDevMode <> 0 then GlobalFree(PrintDlgRec.hDevMode);
    if PrintDlgRec.hDevNames <> 0 then GlobalFree(PrintDlgRec.hDevNames);
  end;
end;

function TPlatformWin.PageSetupGetDefaults(var AMargin, AMinMargin: TRect; var APaperSize: TPointF; AUnits: TPageMeasureUnits;
  AOptions: TPageSetupDialogOptions): Boolean;
var
  PageSetupDlgRec: TPageSetupDlg;
  WindowList: Pointer;
begin
  Result := False;
  if TPrinterWin(Printer).Count = 0 then
    Exit;

  FillChar(PageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);
  PageSetupDlgRec.lStructSize := SizeOf(PageSetupDlgRec);
  PageSetupDlgRec.hInstance := SysInit.hInstance;
  case AUnits of
    // pmDefault    : Read from locale settings by the dialog
    TPageMeasureUnits.pmInches:
      Inc(PageSetupDlgRec.Flags, PSD_INTHOUSANDTHSOFINCHES);
    TPageMeasureUnits.pmMillimeters:
      Inc(PageSetupDlgRec.Flags, PSD_INHUNDREDTHSOFMILLIMETERS);
  end;
  if TPageSetupDialogOption.psoDefaultMinMargins in AOptions then
    Inc(PageSetupDlgRec.Flags, PSD_DEFAULTMINMARGINS);
  if TPageSetupDialogOption.psoDisableMargins in AOptions then
    Inc(PageSetupDlgRec.Flags, PSD_DISABLEMARGINS);
  if TPageSetupDialogOption.psoDisableOrientation in AOptions then
    Inc(PageSetupDlgRec.Flags, PSD_DISABLEORIENTATION);
  if TPageSetupDialogOption.psoDisablePagePainting in AOptions then
    Inc(PageSetupDlgRec.Flags, PSD_DISABLEPAGEPAINTING);
  if TPageSetupDialogOption.psoDisablePaper in AOptions then
    Inc(PageSetupDlgRec.Flags, PSD_DISABLEPAPER);
  if TPageSetupDialogOption.psoDisablePrinter in AOptions then
    Inc(PageSetupDlgRec.Flags, PSD_DISABLEPRINTER);

  PageSetupDlgRec.ptPaperSize.X := Round(APaperSize.X);
  PageSetupDlgRec.ptPaperSize.Y := Round(APaperSize.Y);
  PageSetupDlgRec.rtMinMargin.Left := AMinMargin.Left;
  PageSetupDlgRec.rtMinMargin.Top := AMinMargin.Top;
  PageSetupDlgRec.rtMinMargin.Right := AMinMargin.Right;
  PageSetupDlgRec.rtMinMargin.Bottom := AMinMargin.Bottom;
  PageSetupDlgRec.rtMargin.Left := AMargin.Left;
  PageSetupDlgRec.rtMargin.Top := AMargin.Top;
  PageSetupDlgRec.rtMargin.Right := AMargin.Right;
  PageSetupDlgRec.rtMargin.Bottom := AMargin.Bottom;

  PageSetupDlgRec.Flags := PageSetupDlgRec.Flags or PSD_RETURNDEFAULT;
  PageSetupDlgRec.hDevNames := 0;
  PageSetupDlgRec.hDevMode := 0;

  if Assigned(Screen) and (Screen.FormCount > 0) then
    PageSetupDlgRec.hWndOwner := WindowHandleToPlatform(Screen.Forms[0].Handle).Wnd
  else
    PageSetupDlgRec.hWndOwner := 0;
  WindowList := nil;
  try
    WindowList := DisableTaskWindows(PageSetupDlgRec.hwndOwner);
    Result := PageSetupDlg(PageSetupDlgRec);
  finally
    EnableTaskWindows(WindowList);
  end;

  if Result then
  begin
    APaperSize.X := PageSetupDlgRec.ptPaperSize.X;
    APaperSize.Y := PageSetupDlgRec.ptPaperSize.Y;
    AMargin.Left := PageSetupDlgRec.rtMargin.Left;
    AMargin.Top := PageSetupDlgRec.rtMargin.Top;
    AMargin.Right := PageSetupDlgRec.rtMargin.Right;
    AMargin.Bottom := PageSetupDlgRec.rtMargin.Bottom;
    if PageSetupDlgRec.hDevMode <> 0 then
    begin
      GlobalFree(PageSetupDlgRec.hDevMode);
      PageSetupDlgRec.hDevMode := 0;
    end;
    if PageSetupDlgRec.hDevNames <> 0 then
    begin
      GlobalFree(PageSetupDlgRec.hDevNames);
      PageSetupDlgRec.hDevNames := 0;
    end;
  end;
end;

function TPlatformWin.DialogPageSetup(var AMargin, AMinMargin: TRect;
  var APaperSize: TPointF; var AUnits: TPageMeasureUnits;
  AOptions: TPageSetupDialogOptions): Boolean;
var
  PageSetupDlgRec: TPageSetupDlg;
  DevHandle: THandle;
  WindowList: Pointer;
begin
  FillChar(PageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);
  PageSetupDlgRec.lStructSize := SizeOf(PageSetupDlgRec);
  PageSetupDlgRec.hInstance := SysInit.hInstance;
  GetPrinter(DevHandle, PageSetupDlgRec.hDevNames);
  PageSetupDlgRec.hDevMode := CopyData(DevHandle);

  if (Assigned(Screen) and Assigned(Screen.ActiveForm)) then
    PageSetupDlgRec.hWndOwner := WindowHandleToPlatform(Screen.ActiveForm.Handle).Wnd
  else
    PageSetupDlgRec.hWndOwner := 0;

  case AUnits of
    TPageMeasureUnits.pmInches:
      Inc(PageSetupDlgRec.flags, PSD_INTHOUSANDTHSOFINCHES);
    TPageMeasureUnits.pmMillimeters:
      Inc(PageSetupDlgRec.flags, PSD_INHUNDREDTHSOFMILLIMETERS);
  end;
  if TPageSetupDialogOption.psoDefaultMinMargins in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_DEFAULTMINMARGINS);
  if TPageSetupDialogOption.psoDisableMargins in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_DisableMargins);
  if TPageSetupDialogOption.psoDisableOrientation in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_DISABLEORIENTATION);
  if TPageSetupDialogOption.psoDisablePagePainting in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_DISABLEPAGEPAINTING);
  if TPageSetupDialogOption.psoDisablePaper in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_DISABLEPAPER);
  if TPageSetupDialogOption.psoDisablePrinter in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_DISABLEPRINTER);
  if TPageSetupDialogOption.psoMargins in AOptions then
  begin
    Inc(PageSetupDlgRec.flags, PSD_MARGINS);
    PageSetupDlgRec.rtMargin.Left := AMargin.Left;
    PageSetupDlgRec.rtMargin.Top := AMargin.Top;
    PageSetupDlgRec.rtMargin.Right := AMargin.Right;
    PageSetupDlgRec.rtMargin.Bottom := AMargin.Bottom;
  end;
  if TPageSetupDialogOption.psoMinMargins in AOptions then
  begin
    Inc(PageSetupDlgRec.flags, PSD_MINMARGINS);
    PageSetupDlgRec.rtMinMargin.Left := AMinMargin.Left;
    PageSetupDlgRec.rtMinMargin.Top := AMinMargin.Top;
    PageSetupDlgRec.rtMinMargin.Right := AMinMargin.Right;
    PageSetupDlgRec.rtMinMargin.Bottom := AMinMargin.Bottom;
  end;
  if TPageSetupDialogOption.psoShowHelp in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_SHOWHELP);
  if not(TPageSetupDialogOption.psoWarning in AOptions) then
    Inc(PageSetupDlgRec.flags, PSD_NOWARNING);
  if TPageSetupDialogOption.psoNoNetworkButton in AOptions then
    Inc(PageSetupDlgRec.flags, PSD_NONETWORKBUTTON);

  // Set the user defined margins and page size
  // ptPaperSize.X := APaperSize.X;
  // ptPaperSize.Y := APaperSize.Y;
  WindowList := nil;
  try
    WindowList := DisableTaskWindows(PageSetupDlgRec.hwndOwner);
    Result := PageSetupDlg(PageSetupDlgRec);
  finally
    EnableTaskWindows(WindowList);
  end;

  if Result then
  begin
    APaperSize.X := PageSetupDlgRec.ptPaperSize.X;
    APaperSize.Y := PageSetupDlgRec.ptPaperSize.Y;
    AMargin.Left := PageSetupDlgRec.rtMargin.Left;
    AMargin.Top := PageSetupDlgRec.rtMargin.Top;
    AMargin.Right := PageSetupDlgRec.rtMargin.Right;
    AMargin.Bottom := PageSetupDlgRec.rtMargin.Bottom;
    SetPrinter(PageSetupDlgRec.hDevMode, PageSetupDlgRec.hDevNames)
  end
  else
  begin
    if PageSetupDlgRec.hDevMode <> 0 then
    begin
      GlobalFree(PageSetupDlgRec.hDevMode);
      PageSetupDlgRec.hDevMode := 0;
    end;
    if PageSetupDlgRec.hDevNames <> 0 then
    begin
      GlobalFree(PageSetupDlgRec.hDevNames);
      PageSetupDlgRec.hDevNames := 0;
    end;
  end;
end;

procedure TPlatformWin.Log(Fmt: String; Params: array of const);
begin
{$IFDEF DEBUG}
  AllocConsole;
  WriteLn(Format(Fmt, Params));
{$ENDIF}
end;

type
    TWow64DisableWow64FsRedirection = Function(var Wow64FsEnableRedirection: LongBool): LongBool; StdCall;
    TWow64EnableWow64FsRedirection = Function(var Wow64FsEnableRedirection: LongBool): LongBool; StdCall;
var
   Wow64DisableWow64FsRedirection: TWow64DisableWow64FsRedirection;
   Wow64EnableWow64FsRedirection: TWow64EnableWow64FsRedirection;
   RedirectLoaded: boolean;

function RedirectLoad: boolean;
var H: HModule;
begin
  if not RedirectLoaded then
  begin
    H := GetModuleHandle('kernel32.dll');
    if H <> 0 then
    begin
      @Wow64EnableWow64FsRedirection := GetProcAddress(H, 'Wow64EnableWow64FsRedirection');
      @Wow64DisableWow64FsRedirection := GetProcAddress(H, 'Wow64DisableWow64FsRedirection');
    end
    else
    begin
      @Wow64EnableWow64FsRedirection := nil;
      @Wow64DisableWow64FsRedirection := nil;
    end;
    RedirectLoaded := True;
  end;
  Result := (@Wow64EnableWow64FsRedirection <> nil) and
            (@Wow64DisableWow64FsRedirection <> nil);
end;

procedure Wow64DisableRedirection(var EnableRedirection: boolean);
var
  Wow64FsEnableRedirection: LongBool;
begin
  if RedirectLoad then
  begin
    Wow64FsEnableRedirection := EnableRedirection;
    Wow64DisableWow64FsRedirection(Wow64FsEnableRedirection);
    EnableRedirection := Wow64FsEnableRedirection;
  end
  else
    EnableRedirection := False;
end;

procedure Wow64EnableRedirection(var EnableRedirection: boolean);
var
  Wow64FsEnableRedirection: LongBool;
begin
  if RedirectLoad then
  begin
    Wow64FsEnableRedirection := EnableRedirection;
    Wow64EnableWow64FsRedirection(Wow64FsEnableRedirection);
    EnableRedirection := Wow64FsEnableRedirection;
  end
  else
    EnableRedirection := False;
end;

{ TVirtualKeyboardWin }

constructor TVirtualKeyboardWin.Create;
var
  L: integer;
  S: string;
  HID: HKey;
  DVersion: DWORD;
  Major, Minor: byte;
begin
  S := '';
  inherited Create;
  SetLength(S, MAX_PATH);
  L := GetSystemDirectory(PChar(S), MAX_PATH);
  SetLength(S, L);
  FPath := S;
  FExeName := 'osk.exe';
  FWndClassName := 'OSKMainClass';

  FKBPresent := True;
  DVersion := Winapi.Windows.GetVersion;
  Major := Lo(LoWord(DVersion));
  Minor := Hi(LoWord(DVersion));
  FVersion := Major;
  FVersion := FVersion * 100 + Minor * 10;
  if DVersion < 620 then
  begin
    if Winapi.Windows.RegOpenKeyEx(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Enum', 0, KEY_READ,
      HID) = ERROR_SUCCESS then
      try
        S := FindKeyValue(HID, 'ClassGUID', '{4D36E96B-E325-11CE-BFC1-08002BE10318}', 'Control',
          'ActiveService');
        FKBPresent := S <> '';
      finally
        RegCloseKey(HID);
      end;
  end
  else
  begin
    //Windows.Devices.Input.KeyboardCapabilities.KeyboardPresent
  end;
  FNewvkbState := vkbState;
  StartTimerLang;
end;

procedure TVirtualKeyboardWin.Clear;
var
  H: HWND;
begin
  H := vkbHandle;
  if (H <> 0) and (FInst > 32) then
  begin
    PostMessage(H, WM_SYSCOMMAND, SC_CLOSE, 0);
  end;
  KillTimerVisible;
  KillTimerLang;
  FInst := 0;
  FError := False;
  FLastTime := 0;
  FLastHandle := 0;
end;

destructor TVirtualKeyboardWin.Destroy;
begin
  Clear;
  inherited;
end;

procedure TVirtualKeyboardWin.DisableRedirection;
begin
  Wow64DisableRedirection(FEnableRedirection);
end;

procedure TVirtualKeyboardWin.EnableRedirection;
begin
  Wow64EnableRedirection(FEnableRedirection);
end;

function TVirtualKeyboardWin.FindKeyValue(const Key: HKey;
  const Name, Value, SubKeyName, SubValueName: string): string;
var
  Buf, Val: String;
  R, I, J: integer;
  SubKey: HKey;
  BufSize, T, ValSize: cardinal;
begin
  Result := '';
  I := 0;
  Buf := '';
  Val := '';
  BufSize := 2048;
  SetLength(Buf, BufSize);
  ValSize := BufSize;
  SetLength(Val, ValSize);
  repeat
    BufSize := Length(Buf);
    ValSize := Length(Val);
    R := Winapi.Windows.RegEnumValue(Key, I, @Buf[1], BufSize, nil, @T, @Val[1], @ValSize);
    if (R = ERROR_SUCCESS) then
    begin
      if (string(PChar(Buf)) = Name) and (T = REG_SZ) and (SameText(string(PChar(Val)), Value)) then
      begin
        if Winapi.Windows.RegOpenKeyEx(Key, PChar(SubKeyName), 0, KEY_READ, SubKey) = ERROR_SUCCESS
        then
          try
            J := 0;
            repeat
              BufSize := Length(Buf);
              ValSize := Length(Val);
              R := Winapi.Windows.RegEnumValue(SubKey, J, @Buf[1], BufSize, nil, @T, @Val[1],
                @ValSize);
              if (R = ERROR_SUCCESS) and (string(PChar(Buf)) = SubValueName) and (T = REG_SZ) and
                (string(PChar(Val)) <> '') then
              begin
                Result := string(PChar(Val));
              end;
              inc(J);
            until (Result <> '') or (R <> ERROR_SUCCESS);
          finally
            RegCloseKey(SubKey);
          end;
      end;
      inc(I);
    end;
  until (Result <> '') or (R <> ERROR_SUCCESS);
  if Result = '' then
  begin
    I := 0;
    repeat
      R := Winapi.Windows.RegEnumKey(Key, I, PChar(Buf), BufSize);
      if R = ERROR_SUCCESS then
      begin
        if Winapi.Windows.RegOpenKeyEx(Key, PChar(Buf), 0, KEY_READ, SubKey) = ERROR_SUCCESS then
          try
            Result := FindKeyValue(SubKey, Name, Value, SubKeyName, SubValueName);
          finally
            RegCloseKey(SubKey);
          end;
        inc(I);
      end;
    until (Result <> '') or (R <> ERROR_SUCCESS);
  end;
end;

function TVirtualKeyboardWin.GetVirtualKeyBoardState: TVirtualKeyBoardState;
var
  LState: TvkbState;
begin
  if FError then
    Result := [vksError]
  else
    Result := [];
  if IsAutoShow then
    Result := Result + [vksAutoShow];
  if not FError then
  begin
    if Abs(Now - FLastTime) > 1 / 24 / 60 / 60 then
      LState := vkbState
    else
      LState := FLastvkbState;
    if LState = vkbsVisible then
      Result := Result + [vksVisible];
  end;
end;

function TVirtualKeyboardWin.GetVKBounds: TRect;
begin
  if FLastHandle <> 0 then
    GetWindowRect(FLastHandle, Result);
end;

function TVirtualKeyboardWin.HideVirtualKeyboard: boolean;
begin
  Result := not FError;
  if (not FError) then
  begin
    if IsAutoShow then
      FNewvkbState := vkbsHide
    else
      FNewvkbState := vkbsNone;
    if FNewvkbState <> vkbState then
    begin
      StartTimerVisible;
    end;
  end;
end;

function TVirtualKeyboardWin.ShowVirtualKeyboard(const AControl: TFmxObject): boolean;
var
  Root: IRoot;
begin
  Result := not FError;
  if (not FError) then
  begin
    FNewvkbState := vkbsVisible;
    if FNewvkbState <> vkbState then
      StartTimerVisible;
    FWait := True;
    FFormHandle := 0;
    if (AControl <> nil) then
    begin
      Root := AControl.Root;
      if (Root <> nil) and (Root.GetObject is TCommonCustomForm) then
        FFormHandle := WindowHandleToPlatform(TCommonCustomForm(Root.GetObject).Handle).Wnd;
    end;
  end;
end;

function TVirtualKeyboardWin.IsAutoShow: boolean;
begin
  Result := (VKAutoShowMode = TVKAutoShowMode.vkasAlways) or ((VKAutoShowMode = TVKAutoShowMode.vkasDefinedBySystem) and
    (not FKBPresent));
end;

procedure TVirtualKeyboardWin.KillTimerLang;
begin
  if FHTmerLang <> 0 then
  begin
    if Assigned(FTimerService) or
       TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FTimerService))
    then
    begin
      FTimerService.DestroyTimer(FHTmerLang);
      FHTmerLang := 0;
    end
    else
      raise EUnsupportedPlatformService.Create('IFMXTimerService');
  end;
end;

procedure TVirtualKeyboardWin.StartTimerLang;
begin
  if FHTmerLang = 0 then
  begin
    if Assigned(FTimerService) or
       TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FTimerService))
    then
    begin
      FHTmerLang := FTimerService.CreateTimer(250, TimerLangProc);
    end
    else
      raise EUnsupportedPlatformService.Create('IFMXTimerService');
  end;
end;

procedure TVirtualKeyboardWin.TimerLangProc;
var
  LCodeKeyboard: HKL;
begin
  if FStepActivate > 0 then
  begin
    FLastHandle := vkbHandle;
    case FStepActivate of
      1: begin
           SetActiveWindow(FLastHandle);
           SetFocus(FLastHandle);
         end;
      4: begin
           SetActiveWindow(FFormHandle);
         end;
      5: begin
           SetFocus(FFormHandle);
           FCodeKeyboard := GetKeyboardLayout(0);
         end;
    end;
    if FStepActivate = 5 then
      FStepActivate := 0
    else
    begin
      inc(FStepActivate);
      Exit;
    end;
  end
  else
  begin
    if vkbState = vkbsVisible then
    begin
      LCodeKeyboard := GetKeyboardLayout(0);
      if FCodeKeyboard <> LCodeKeyboard then
      begin
        SetActiveWindow(0);
        SetActiveWindow(FFormHandle);
        SetFocus(FFormHandle);
        FCodeKeyboard := LCodeKeyboard;
      end;
    end;
  end;
end;

procedure TVirtualKeyboardWin.KillTimerVisible;
begin
  if FHTmerVisible <> 0 then
  begin
    if Assigned(FTimerService) or
       TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FTimerService))
    then
    begin
      FTimerService.DestroyTimer(FHTmerVisible);
      FHTmerVisible := 0;
    end
    else
      raise EUnsupportedPlatformService.Create('IFMXTimerService');
  end;
end;

procedure TVirtualKeyboardWin.StartTimerVisible;
begin
  if FHTmerVisible = 0 then
  begin
    if Assigned(FTimerService) or
       TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FTimerService))
    then
    begin
      FHTmerVisible := FTimerService.CreateTimer(100, TimerVisibleProc);
    end
    else
      raise EUnsupportedPlatformService.Create('IFMXTimerService');
  end;
end;

procedure TVirtualKeyboardWin.TimerVisibleProc;
var
  LState: TvkbState;
  procedure Quit;
  begin
    if FLastHandle <> 0 then
      PostMessage(FLastHandle, WM_SYSCOMMAND, SC_CLOSE, 0);
    Sleep(40);
    FLastHandle := 0;
    TMessageManager.DefaultManager.SendMessage(Self, TVKStateChangeMessage.Create(false, TRect.Empty), true);
  end;
  procedure Restore;
  begin
    if FLastHandle <> 0 then
    begin
      if Winapi.Windows.GetActiveWindow <> FLastHandle then
      begin
        SendMessage(FLastHandle, WM_SYSCOMMAND, SC_RESTORE, 0);
        TMessageManager.DefaultManager.SendMessage(Self, TVKStateChangeMessage.Create(true, GetVKBounds), true);
      end;
    end;
  end;
  procedure Hide;
  begin
    if FLastHandle <> 0 then
      PostMessage(FLastHandle, WM_SYSCOMMAND, SC_CLOSE, 0);
    FWait := True;
    FLastHandle := 0;
    TMessageManager.DefaultManager.SendMessage(Self, TVKStateChangeMessage.Create(false, TRect.Empty), true);
  end;

begin
  if FWait then
  begin
    FLastHandle := vkbHandle;
    FWait := False;
    Exit;
  end;
  FWait := True;
  LState := vkbState;
  if LState <> FNewvkbState then
  begin
    case LState of
      vkbsNone:
        case FNewvkbState of
          vkbsHide: {none}
            ;
          vkbsVisible:
            begin
              vkbExecute(FFormHandle);
              FWait := False;
              FStepActivate := 1;
              TMessageManager.DefaultManager.SendMessage(Self, TVKStateChangeMessage.Create(true, GetVKBounds), true);
              Exit;
            end;
        end;
      vkbsHide:
        case FNewvkbState of
          vkbsNone:
            Quit;
          vkbsVisible:
            Restore;
        end;
      vkbsVisible:
        case FNewvkbState of
          vkbsNone:
            Quit;
          vkbsHide:
            Hide;
        end;
    end;
    FNewvkbState := vkbState;
  end;
  KillTimerVisible;
end;

procedure TVirtualKeyboardWin.vkbExecute(FormHandle: HWND);
var
  S: string;
  N: integer;
  H: HWND;
  CMD: integer;
begin
  if FError then
    Exit;
  H := vkbHandle;
  if H = 0 then
  begin
    S := IncludeTrailingPathDelimiter(Path);
    S := S + ExeName;
    if FileExists(S) then
    begin
      DisableRedirection;
      try
        CMD := SW_SHOWNOACTIVATE;
        FInst := ShellExecute(FormHandle, 'open', PChar(S), nil, PChar(ExtractFileDir(S)),
                              CMD);

        if FInst <= 32 then
        begin
          FError := True;
        end
        else
        begin
          N := 0;
          while (N < 100) and (vkbState = vkbsNone) do
          begin
            inc(N);
            Sleep(40);
          end;
          if N >= 100 then
          begin
            FInst := 0;
            FError := True;
          end;
        end;
      finally
        EnableRedirection;
      end;
    end
    else
    begin
      FError := True;
      FInst := 0;
    end;
  end;
end;

function TVirtualKeyboardWin.vkbHandle: HWND;
begin
  Result := Winapi.Windows.FindWindow(PChar(FWndClassName), nil);
end;

function TVirtualKeyboardWin.vkbState: TvkbState;
var
  H: HWND;
begin
  H := vkbHandle;
  if (H <> INVALID_HANDLE_VALUE) and (H <> 0) then
  begin
    if (not IsWindowVisible(H)) or (IsIconic(H)) then
      Result := vkbsHide
    else
      Result := vkbsVisible;
    FLastHandle := H;
  end
  else
  begin
    Result := vkbsNone;
    FLastHandle := 0;
  end;
  FLastvkbState := Result;
  FLastTime := Now;
end;


{ TFullScreenParams }

procedure TFullScreenParams.Clean;
begin
  Self.BorderStyle := TFmxFormBorderStyle.bsNone;
  Self.WindowState := TWindowState.wsMaximized;
end;

function TFullScreenParams.IsFullScreen: Boolean;
begin
  Result := not ((Self.BorderStyle = TFmxFormBorderStyle.bsNone)
    and (Self.WindowState = TWindowState.wsMaximized));
end;

initialization
  OleInitialize(nil);
  Wow64DisableWow64FsRedirection := nil;
  Wow64EnableWow64FsRedirection := nil;
  RedirectLoaded := False;
  CapturedGestureControl := nil;
finalization
  //UnregisterCorePlatformServices;
end.
