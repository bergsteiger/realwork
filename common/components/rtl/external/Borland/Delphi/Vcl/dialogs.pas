
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1995-2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit Dialogs;

{$R-,T-,H+,X+}

interface

{$IFDEF LINUX}
uses WinUtils, Windows, Messages, SysUtils, CommDlg,
  Printers, Classes, Graphics, Controls, Forms, StdCtrls;
{$ENDIF}
{$IFDEF MSWINDOWS}
uses Windows, Messages, SysUtils, CommDlg,
  Printers, Classes, Graphics, Controls, Forms, StdCtrls;
{$ENDIF}
const

{ Maximum number of custom colors in color dialog }

  MaxCustomColors = 16;

type

{ TCommonDialog }

  TCommonDialog = class(TComponent)
  private
    FCtl3D: Boolean;
    FDefWndProc: Pointer;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FObjectInstance: Pointer;
    FTemplate: PChar;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMInitDialog(var Message: TWMInitDialog); message WM_INITDIALOG;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure MainWndProc(var Message: TMessage);
  protected
    procedure DoClose; dynamic;
    procedure DoShow; dynamic;
    procedure WndProc(var Message: TMessage); virtual;
    function MessageHook(var Msg: TMessage): Boolean; virtual;
    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; virtual;
    property Template: PChar read FTemplate write FTemplate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; virtual; abstract;
    procedure DefaultHandler(var Message); override;
    property Handle: HWnd read FHandle;
  published
    property Ctl3D: Boolean read FCtl3D write FCtl3D default True;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

{ TOpenDialog }

  TOpenOption = (ofReadOnly, ofOverwritePrompt, ofHideReadOnly,
    ofNoChangeDir, ofShowHelp, ofNoValidate, ofAllowMultiSelect,
    ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofCreatePrompt,
    ofShareAware, ofNoReadOnlyReturn, ofNoTestFileCreate, ofNoNetworkButton,
    ofNoLongNames, ofOldStyleDialog, ofNoDereferenceLinks, ofEnableIncludeNotify,
    ofEnableSizing, ofDontAddToRecent, ofForceShowHidden);
  TOpenOptions = set of TOpenOption;

  TOpenOptionEx = (ofExNoPlacesBar);
  TOpenOptionsEx = set of TOpenOptionEx;

  TFileEditStyle = (fsEdit, fsComboBox);
  TOFNotifyEx = type CommDlg.TOFNotifyEx;
  {$NODEFINE TOFNotifyEx}
  TIncludeItemEvent = procedure (const OFN: TOFNotifyEx; var Include: Boolean) of object;

  TOpenDialog = class(TCommonDialog)
  private
    FHistoryList: TStrings;
    FOptions: TOpenOptions;
    FFilter: string;
    FFilterIndex: Integer;
    FCurrentFilterIndex: Integer;
    FInitialDir: string;
    FTitle: string;
    FDefaultExt: string;
    FFileName: TFileName;
    FFiles: TStrings;
    FFileEditStyle: TFileEditStyle;
    FOnSelectionChange: TNotifyEvent;
    FOnFolderChange: TNotifyEvent;
    FOnTypeChange: TNotifyEvent;
    FOnCanClose: TCloseQueryEvent;
    FOnIncludeItem: TIncludeItemEvent;
    FOptionsEx: TOpenOptionsEx;
    function GetFileName: TFileName;
    function GetFilterIndex: Integer;
    procedure ReadFileEditStyle(Reader: TReader);
    procedure SetHistoryList(Value: TStrings);
    procedure SetInitialDir(const Value: string);
  protected
    function CanClose(var OpenFileName: TOpenFileName): Boolean;
    function DoCanClose: Boolean; dynamic;
    function DoExecute(Func: Pointer; AOwnerWnd: HWND = 0): Bool;
    procedure DoSelectionChange; dynamic;
    procedure DoFolderChange; dynamic;
    procedure DoTypeChange; dynamic;
    procedure DoIncludeItem(const OFN: TOFNotifyEx; var Include: Boolean); dynamic;
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetFileNames(var OpenFileName: TOpenFileName);
    function GetStaticRect: TRect; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    property FileEditStyle: TFileEditStyle read FFileEditStyle write FFileEditStyle;
    property Files: TStrings read FFiles;
    property HistoryList: TStrings read FHistoryList write SetHistoryList;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property FileName: TFileName read GetFileName write FFileName;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read GetFilterIndex write FFilterIndex default 1;
    property InitialDir: string read FInitialDir write SetInitialDir;
    property Options: TOpenOptions read FOptions write FOptions default [ofHideReadOnly, ofEnableSizing];
    property OptionsEx: TOpenOptionsEx read FOptionsEx write FOptionsEx default [];
    property Title: string read FTitle write FTitle;
    property OnCanClose: TCloseQueryEvent read FOnCanClose write FOnCanClose;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
    property OnIncludeItem: TIncludeItemEvent read FOnIncludeItem write FOnIncludeItem;
  end;

{ TSaveDialog }

  TSaveDialog = class(TOpenDialog)
    function Execute: Boolean; override;
  end;

{ TColorDialog }

  TColorDialogOption = (cdFullOpen, cdPreventFullOpen, cdShowHelp,
    cdSolidColor, cdAnyColor);
  TColorDialogOptions = set of TColorDialogOption;

  TCustomColors = array[0..MaxCustomColors - 1] of Longint;

  TColorDialog = class(TCommonDialog)
  private
    FColor: TColor;
    FOptions: TColorDialogOptions;
    FCustomColors: TStrings;
    procedure SetCustomColors(Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
  published
    property Color: TColor read FColor write FColor default clBlack;
    property Ctl3D default True;
    property CustomColors: TStrings read FCustomColors write SetCustomColors;
    property Options: TColorDialogOptions read FOptions write FOptions default [];
  end;

{ TFontDialog }

  TFontDialogOption = (fdAnsiOnly, fdTrueTypeOnly, fdEffects,
    fdFixedPitchOnly, fdForceFontExist, fdNoFaceSel, fdNoOEMFonts,
    fdNoSimulations, fdNoSizeSel, fdNoStyleSel,  fdNoVectorFonts,
    fdShowHelp, fdWysiwyg, fdLimitSize, fdScalableOnly, fdApplyButton);
  TFontDialogOptions = set of TFontDialogOption;

  TFontDialogDevice = (fdScreen, fdPrinter, fdBoth);

  TFDApplyEvent = procedure(Sender: TObject; Wnd: HWND) of object;

  TFontDialog = class(TCommonDialog)
  private
    FFont: TFont;
    FDevice: TFontDialogDevice;
    FOptions: TFontDialogOptions;
    FOnApply: TFDApplyEvent;
    FMinFontSize: Integer;
    FMaxFontSize: Integer;
    FFontCharsetModified: Boolean;
    FFontColorModified: Boolean;
    procedure DoApply(Wnd: HWND);
    procedure SetFont(Value: TFont);
    procedure UpdateFromLogFont(const LogFont: TLogFont);
  protected
    procedure Apply(Wnd: HWND); dynamic;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
  published
    property Font: TFont read FFont write SetFont;
    property Device: TFontDialogDevice read FDevice write FDevice default fdScreen;
    property MinFontSize: Integer read FMinFontSize write FMinFontSize default 0;
    property MaxFontSize: Integer read FMaxFontSize write FMaxFontSize default 0;
    property Options: TFontDialogOptions read FOptions write FOptions default [fdEffects];
    property OnApply: TFDApplyEvent read FOnApply write FOnApply;
  end;

{ TPrinterSetupDialog }

  TPrinterSetupDialog = class(TCommonDialog)
  public
    function Execute: Boolean; override;
  end;

{ TPrintDialog }

  TPrintRange = (prAllPages, prSelection, prPageNums);
  TPrintDialogOption = (poPrintToFile, poPageNums, poSelection, poWarning,
    poHelp, poDisablePrintToFile);
  TPrintDialogOptions = set of TPrintDialogOption;

  TPrintDialog = class(TCommonDialog)
  private
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Boolean;
    FOptions: TPrintDialogOptions;
    FPrintToFile: Boolean;
    FPrintRange: TPrintRange;
    FMinPage: Integer;
    FMaxPage: Integer;
    FCopies: Integer;
    procedure SetNumCopies(Value: Integer);
  public
    function Execute: Boolean; override;
  published
    property Collate: Boolean read FCollate write FCollate default False;
    property Copies: Integer read FCopies write SetNumCopies default 0;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TPrintDialogOptions read FOptions write FOptions default [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default False;
    property PrintRange: TPrintRange read FPrintRange write FPrintRange default prAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
  end;

  TPrinterOrientation = Printers.TPrinterOrientation;  // required for Form Designer
  TPageSetupDialogOption = (psoDefaultMinMargins, psoDisableMargins,
    psoDisableOrientation, psoDisablePagePainting, psoDisablePaper, psoDisablePrinter,
    psoMargins, psoMinMargins, psoShowHelp, psoWarning, psoNoNetworkButton);
  TPageSetupDialogOptions = set of TPageSetupDialogOption;
  TPrinterKind = (pkDotMatrix, pkHPPCL);
  TPageType = (ptEnvelope, ptPaper);
  TPageSetupBeforePaintEvent = procedure (Sender: TObject; const PaperSize: SmallInt;
    const Orientation: TPrinterOrientation; const PageType: TPageType;
    var DoneDrawing: Boolean) of object;
  TPageMeasureUnits = (pmDefault, pmMillimeters, pmInches);
  TPaintPageEvent = procedure(Sender: TObject; Canvas: TCanvas; PageRect: TRect;
    var DoneDrawing: Boolean) of object;

{ TPageSetupDialog }

  TPageSetupDialog = class(TCommonDialog)
  private
    FOptions: TPageSetupDialogOptions;
    FMinMarginLeft: Integer;
    FMinMarginTop: Integer;
    FMinMarginRight: Integer;
    FMinMarginBottom: Integer;
    FMarginLeft: Integer;
    FMarginTop: Integer;
    FMarginRight: Integer;
    FMarginBottom: Integer;
    FPageWidth: Integer;
    FPageHeight: Integer;
    FPageSetupDlgRec: TPageSetupDlg;    
    FBeforePaint: TPageSetupBeforePaintEvent;
    FUnits: TPageMeasureUnits;
    FOnDrawRetAddress: TPaintPageEvent;
    FOnDrawMinMargin: TPaintPageEvent;
    FOnDrawEnvStamp: TPaintPageEvent;
    FOnDrawFullPage: TPaintPageEvent;
    FOnDrawGreekText: TPaintPageEvent;
    FOnDrawMargin: TPaintPageEvent;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    function GetDefaults: Boolean;
    property PageSetupDlgRec: TPageSetupDlg read FPageSetupDlgRec;
  published
    property MinMarginLeft: Integer read FMinMarginLeft write FMinMarginLeft;
    property MinMarginTop: Integer read FMinMarginTop write FMinMarginTop;
    property MinMarginRight: Integer read FMinMarginRight write FMinMarginRight;
    property MinMarginBottom: Integer read FMinMarginBottom write FMinMarginBottom;
    property MarginLeft: Integer read FMarginLeft write FMarginLeft;
    property MarginTop: Integer read FMarginTop write FMarginTop;
    property MarginRight: Integer read FMarginRight write FMarginRight;
    property MarginBottom: Integer read FMarginBottom write FMarginBottom;
    property Options: TPageSetupDialogOptions read FOptions write FOptions
      default [psoDefaultMinMargins];
    property PageWidth: Integer read FPageWidth write FPageWidth;
    property PageHeight: Integer read FPageHeight write FPageHeight;
    property Units: TPageMeasureUnits read FUnits write FUnits default pmDefault;
    property BeforePaint: TPageSetupBeforePaintEvent read FBeforePaint
      write FBeforePaint;
    property OnDrawFullPage: TPaintPageEvent read FOnDrawFullPage write FOnDrawFullPage;
    property OnDrawMinMargin: TPaintPageEvent read FOnDrawMinMargin write FOnDrawMinMargin;
    property OnDrawMargin: TPaintPageEvent read FOnDrawMargin write FOnDrawMargin;
    property OnDrawGreekText: TPaintPageEvent read FOnDrawGreekText write FOnDrawGreekText;
    property OnDrawEnvStamp: TPaintPageEvent read FOnDrawEnvStamp write FOnDrawEnvStamp;
    property OnDrawRetAddress: TPaintPageEvent read FOnDrawRetAddress write FOnDrawRetAddress;                
  end;

{ TFindDialog }

  TFindOption = (frDown, frFindNext, frHideMatchCase, frHideWholeWord,
    frHideUpDown, frMatchCase, frDisableMatchCase, frDisableUpDown,
    frDisableWholeWord, frReplace, frReplaceAll, frWholeWord, frShowHelp);
  TFindOptions = set of TFindOption;

  TFindReplaceFunc = function(var FindReplace: TFindReplace): HWnd stdcall;

  TFindDialog = class(TCommonDialog)
  private
    FOptions: TFindOptions;
    FPosition: TPoint;
    FFindReplaceFunc: TFindReplaceFunc;
    FRedirector: TWinControl;
    FOnFind: TNotifyEvent;
    FOnReplace: TNotifyEvent;
    FFindHandle: HWnd;
    FFindReplace: TFindReplace;
    FFindText: array[0..255] of Char;
    FReplaceText: array[0..255] of Char;
    function GetFindText: string;
    function GetLeft: Integer;
    function GetPosition: TPoint;
    function GetReplaceText: string;
    function GetTop: Integer;
    procedure SetFindText(const Value: string);
    procedure SetLeft(Value: Integer);
    procedure SetPosition(const Value: TPoint);
    procedure SetReplaceText(const Value: string);
    procedure SetTop(Value: Integer);
    property ReplaceText: string read GetReplaceText write SetReplaceText;
    property OnReplace: TNotifyEvent read FOnReplace write FOnReplace;
  protected
    function MessageHook(var Msg: TMessage): Boolean; override;
    procedure Find; dynamic;
    procedure Replace; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseDialog;
    function Execute: Boolean; override;
    property Left: Integer read GetLeft write SetLeft;
    property Position: TPoint read GetPosition write SetPosition;
    property Top: Integer read GetTop write SetTop;
  published
    property FindText: string read GetFindText write SetFindText;
    property Options: TFindOptions read FOptions write FOptions default [frDown];
    property OnFind: TNotifyEvent read FOnFind write FOnFind;
  end;

{ TReplaceDialog }

  TReplaceDialog = class(TFindDialog)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ReplaceText;
    property OnReplace;
  end;

{ Message dialog }

type
  TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);
  TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore,
    mbAll, mbNoToAll, mbYesToAll, mbHelp);
  TMsgDlgButtons = set of TMsgDlgBtn;

const
  mbYesNoCancel = [mbYes, mbNo, mbCancel];
  mbYesAllNoAllCancel = [mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel];
  mbOKCancel = [mbOK, mbCancel];
  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];
  mbAbortIgnore = [mbAbort, mbIgnore];

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): TForm;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;

procedure ShowMessage(const Msg: string);
procedure ShowMessageFmt(const Msg: string; Params: array of const);
procedure ShowMessagePos(const Msg: string; X, Y: Integer);

{ Input dialog }

function InputBox(const ACaption, APrompt, ADefault: string): string;
function InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;

function PromptForFileName(var AFileName: string; const AFilter: string = '';
  const ADefaultExt: string = ''; const ATitle: string = '';
  const AInitialDir: string = ''; SaveDialog: Boolean = False): Boolean;

{ Win98 and Win2k will default to the "My Documents" folder if the InitialDir
  property is empty and no files of the filtered type are contained in the
  current directory. Set this flag to True to force TOpenDialog and descendents
  to always open in the current directory when InitialDir is empty. (Same
  behavior as setting InitialDir to '.') }
var
  ForceCurrentDirectory: Boolean = False;

implementation

uses
  ExtCtrls, Consts, Dlgs, Math;

{ Private globals }

var
  CreationControl: TCommonDialog = nil;
  HelpMsg: Cardinal;
  FindMsg: Cardinal;
  WndProcPtrAtom: TAtom = 0;

{ Center the given window on the screen }

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
  Monitor: TMonitor;
begin
  GetWindowRect(Wnd, Rect);
  if Application.MainForm <> nil then
  begin
    if Assigned(Screen.ActiveForm) then
      Monitor := Screen.ActiveForm.Monitor
      else
        Monitor := Application.MainForm.Monitor;
  end
  else
    Monitor := Screen.Monitors[0];
  SetWindowPos(Wnd, 0,
    Monitor.Left + ((Monitor.Width - Rect.Right + Rect.Left) div 2),
    Monitor.Top + ((Monitor.Height - Rect.Bottom + Rect.Top) div 3),
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{ Generic dialog hook. Centers the dialog on the screen in response to
  the WM_INITDIALOG message }

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CenterWindow(Wnd);
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end;
end;

{ TCommonDialog }

constructor TCommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCtl3D := True;
{$IFDEF MSWINDOWS}   
  FObjectInstance := Classes.MakeObjectInstance(MainWndProc);
{$ENDIF}
{$IFDEF LINUX}
  FObjectInstance := WinUtils.MakeObjectInstance(MainWndProc);
{$ENDIF}   
end;

destructor TCommonDialog.Destroy;
begin
{$IFDEF MSWINDOWS}   
  if FObjectInstance <> nil then Classes.FreeObjectInstance(FObjectInstance);
{$ENDIF}
{$IFDEF LINUX}
  if FObjectInstance <> nil then WinUtils.FreeObjectInstance(FObjectInstance);
{$ENDIF}   
  inherited Destroy;
end;

function TCommonDialog.MessageHook(var Msg: TMessage): Boolean;
begin
  Result := False;
  if (Msg.Msg = HelpMsg) and (FHelpContext <> 0) then
  begin
    Application.HelpContext(FHelpContext);
    Result := True;
  end;
end;

procedure TCommonDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, LParam)
  else inherited DefaultHandler(Message);
end;

procedure TCommonDialog.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TCommonDialog.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

procedure TCommonDialog.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  DoClose;
end;

procedure TCommonDialog.WMInitDialog(var Message: TWMInitDialog);
begin
  { Called only by non-explorer style dialogs }
  DoShow;
  { Prevent any further processing }
  Message.Result := 0;
end;

procedure TCommonDialog.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
end;

function TCommonDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
type
  TDialogFunc = function(var DialogData): Bool stdcall;
var
  ActiveWindow: HWnd;
  WindowList: Pointer;
  FPUControlWord: Word;
  FocusState: TFocusState;
begin
  ActiveWindow := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
  FocusState := SaveFocusState;
  try
    Application.HookMainWindow(MessageHook);
    asm
      // Avoid FPU control word change in NETRAP.dll, NETAPI32.dll, etc
      FNSTCW  FPUControlWord
    end;
    try
      CreationControl := Self;
      Result := TDialogFunc(DialogFunc)(DialogData);
    finally
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
      Application.UnhookMainWindow(MessageHook);
    end;
  finally
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
    RestoreFocusState(FocusState);
  end;
end;

procedure TCommonDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TCommonDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

{ Open and Save dialog routines }

function ExplorerHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end
  else if (Msg = WM_NOTIFY) and (POFNotify(LParam)^.hdr.code = CDN_INITDONE) then
    CenterWindow(GetWindowLong(Wnd, GWL_HWNDPARENT));
end;

{ TOpenDialog }

constructor TOpenDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHistoryList := TStringList.Create;
  FOptions := [ofHideReadOnly, ofEnableSizing];
  FOptionsEx := [];
  FFiles := TStringList.Create;
  FFilterIndex := 1;
  FFileEditStyle := fsEdit;
end;

destructor TOpenDialog.Destroy;
begin
  FFiles.Free;
  FHistoryList.Free;
  inherited Destroy;
end;

function TOpenDialog.CanClose(var OpenFileName: TOpenFileName): Boolean;
begin
  GetFileNames(OpenFileName);
  Result := DoCanClose;
  FFiles.Clear;
end;

procedure TOpenDialog.WndProc(var Message: TMessage);
var
  Index: Integer;
  Include: Boolean;
begin
  Message.Result := 0;
  { If not ofOldStyleDialog then DoShow on CDN_INITDONE, not WM_INITDIALOG }
  if (Message.Msg = WM_INITDIALOG) and not (ofOldStyleDialog in Options) then Exit
  else if (Message.Msg = WM_NOTIFY) then
    case (POFNotify(Message.LParam)^.hdr.code) of
      CDN_FILEOK:
        if not CanClose(POFNotify(Message.LParam)^.lpOFN^) then
        begin
          Message.Result := 1;
          SetWindowLong(Handle, DWL_MSGRESULT, Message.Result);
          Exit;
        end;
      CDN_INITDONE: DoShow;
      CDN_SELCHANGE: DoSelectionChange;
      CDN_FOLDERCHANGE: DoFolderChange;
      CDN_TYPECHANGE:
        begin
          Index := POFNotify(Message.LParam)^.lpOFN^.nFilterIndex;
          if Index <> FCurrentFilterIndex then
          begin
            FCurrentFilterIndex := Index;
            DoTypeChange;
          end;
        end;
      CDN_INCLUDEITEM:
        if Message.LParam <> 0 then
        begin
          Include := True;
          DoIncludeItem(TOFNotifyEx(POFNotifyEx(Message.LParam)^), Include);
          Message.Result := Byte(Include);
        end;
    end;
  inherited WndProc(Message);
end;

function TOpenDialog.DoCanClose: Boolean;
begin
  Result := True;
  if Assigned(FOnCanClose) then FOnCanClose(Self, Result);
end;

procedure TOpenDialog.DoSelectionChange;
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end;

procedure TOpenDialog.DoFolderChange;
begin
  if Assigned(FOnFolderChange) then FOnFolderChange(Self);
end;

procedure TOpenDialog.DoTypeChange;
begin
  if Assigned(FOnTypeChange) then FOnTypeChange(Self);
end;

procedure TOpenDialog.ReadFileEditStyle(Reader: TReader);
begin
  { Ignore FileEditStyle }
  Reader.ReadIdent;
end;

procedure TOpenDialog.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('FileEditStyle', ReadFileEditStyle, nil, False);
end;

{$IFDEF LINUX}
function DRIVE_GetRoot(Drive: Integer): PChar; cdecl; external 'libwine.borland.so' name 'DRIVE_GetRoot';

function FixFileName(const FileName: string): string;
var
  Root: string;
  I: Integer;
begin
  if (Length(FileName) > 2) and (FileName[2] = ':') then
  begin
    Result := Copy(FileName, 3, MaxInt);
    Root := DRIVE_GetRoot(Ord(UpCase(FileName[1])) - Ord('A'));
    if IsPathDelimiter(Root, Length(Root)) then
      Delete(Root, Length(Root) - 1, 1);
    Result := Root + PathDelim + Result;
  end else Result := FileName;
  for I := 1 to Length(Result) do
    if Result[I] = '\' then Result[I] := PathDelim;
end;
{$ENDIF}

function FixFileName(const FileName: string): string;
begin
  Result := FileName;
end;


function TOpenDialog.DoExecute(Func: Pointer; AOwnerWnd: HWND = 0): Bool;
const
  MultiSelectBufferSize = High(Word) - 16;
  OpenOptions: array [TOpenOption] of DWORD = (
    OFN_READONLY, OFN_OVERWRITEPROMPT, OFN_HIDEREADONLY,
    OFN_NOCHANGEDIR, OFN_SHOWHELP, OFN_NOVALIDATE, OFN_ALLOWMULTISELECT,
    OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST,
    OFN_CREATEPROMPT, OFN_SHAREAWARE, OFN_NOREADONLYRETURN,
    OFN_NOTESTFILECREATE, OFN_NONETWORKBUTTON, OFN_NOLONGNAMES,
    OFN_EXPLORER, OFN_NODEREFERENCELINKS, OFN_ENABLEINCLUDENOTIFY,
    OFN_ENABLESIZING, OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN);

  OpenOptionsEx: array [TOpenOptionEx] of DWORD = (OFN_EX_NOPLACESBAR);
var
  Option: TOpenOption;
  OptionEx: TOpenOptionEx;
  OpenFilename: TOpenFilename;

  function AllocFilterStr(const S: string): string;
  var
    P: PChar;
  begin
    Result := '';
    if S <> '' then
    begin
      Result := S + #0;  // double null terminators
      P := AnsiStrScan(PChar(Result), '|');
      while P <> nil do
      begin
        P^ := #0;
        Inc(P);
        P := AnsiStrScan(P, '|');
      end;
    end;
  end;

var
  TempFilter, TempFilename, TempExt: string;
begin
  FFiles.Clear;
  FillChar(OpenFileName, SizeOf(OpenFileName), 0);
  with OpenFilename do
  begin
    if (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT) or { Win2k }
    ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion >= 4) and (Win32MinorVersion >= 90)) then { WinME }
      lStructSize := SizeOf(TOpenFilename)
    else
      lStructSize := SizeOf(TOpenFilename) - (SizeOf(DWORD) shl 1) - SizeOf(Pointer); { subtract size of added fields }

    hInstance := SysInit.HInstance;
    TempFilter := AllocFilterStr(FFilter);
    lpstrFilter := PChar(TempFilter);
    nFilterIndex := FFilterIndex;
    FCurrentFilterIndex := FFilterIndex;
    if ofAllowMultiSelect in FOptions then
      nMaxFile := MultiSelectBufferSize else
      nMaxFile := MAX_PATH;
    SetLength(TempFilename, nMaxFile + 2);
    lpstrFile := PChar(TempFilename);
    FillChar(lpstrFile^, nMaxFile + 2, 0);
    StrLCopy(lpstrFile, PChar(FFileName), nMaxFile);
    if (FInitialDir = '') and ForceCurrentDirectory then
      lpstrInitialDir := '.'
    else
      lpstrInitialDir := PChar(FInitialDir);
    lpstrTitle := PChar(FTitle);
    Flags := OFN_ENABLEHOOK;
    FlagsEx := 0;

    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or OpenOptions[Option];
    if NewStyleControls then
    begin
      Flags := Flags xor OFN_EXPLORER;
      if (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT) or { Win2k }
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion >= 4) and (Win32MinorVersion >= 90)) then { WinME }
        for OptionEx := Low(OptionEx) to High(OptionEx) do
          if OptionEx in FOptionsEx then
            FlagsEx := FlagsEx or OpenOptionsEx[OptionEx];
    end
    else
      Flags := Flags and not OFN_EXPLORER;
    TempExt := FDefaultExt;
    if (TempExt = '') and (Flags and OFN_EXPLORER = 0) then
    begin
      TempExt := ExtractFileExt(FFilename);
      Delete(TempExt, 1, 1);
    end;
    if TempExt <> '' then lpstrDefExt := PChar(TempExt);
    if (ofOldStyleDialog in Options) or not NewStyleControls then
      lpfnHook := DialogHook
    else
      lpfnHook := ExplorerHook;

    if Template <> nil then
    begin
      Flags := Flags or OFN_ENABLETEMPLATE;
      lpTemplateName := Template;
    end;
    if AOwnerWnd <> 0 then
     hWndOwner := AOwnerWnd
    else
     hWndOwner := Application.Handle;
    Result := TaskModalDialog(Func, OpenFileName);
    if Result then
    begin
      GetFileNames(OpenFilename);
      if (Flags and OFN_EXTENSIONDIFFERENT) <> 0 then
        Include(FOptions, ofExtensionDifferent) else
        Exclude(FOptions, ofExtensionDifferent);
      if (Flags and OFN_READONLY) <> 0 then
        Include(FOptions, ofReadOnly) else
        Exclude(FOptions, ofReadOnly);
      FFilterIndex := nFilterIndex;
    end;
  end;
end;

procedure TOpenDialog.GetFileNames(var OpenFileName: TOpenFileName);
var
  Separator: Char;

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
      FFiles.Add(DirName)
    else
    begin
      if AnsiLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
          (FileName[2] <> ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        FFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;

begin
  Separator := #0;
  if (ofAllowMultiSelect in FOptions) and
    ((ofOldStyleDialog in FOptions) or not NewStyleControls) then
    Separator := ' ';
  with OpenFileName do
  begin
    if ofAllowMultiSelect in FOptions then
    begin
      ExtractFileNames(lpstrFile);
      FFileName := FFiles[0];
    end else
    begin
      ExtractFileName(lpstrFile, FFileName);
      FFiles.Add(FFileName);
    end;
  end;
end;

function TOpenDialog.GetStaticRect: TRect;
begin
  if FHandle <> 0 then
  begin
    if not (ofOldStyleDialog in Options) then
    begin
      GetWindowRect(GetDlgItem(FHandle, stc32), Result);
      MapWindowPoints(0, FHandle, Result, 2);
    end
    else GetClientRect(FHandle, Result)
  end
  else Result := Rect(0,0,0,0);
end;

function TOpenDialog.GetFileName: TFileName;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if NewStyleControls and (FHandle <> 0) then
  begin
    SendMessage(GetParent(FHandle), CDM_GETFILEPATH, SizeOf(Path), Integer(@Path));
    Result := StrPas(Path);
  end
  else Result := FFileName;
end;

function TOpenDialog.GetFilterIndex: Integer;
begin
  if FHandle <> 0 then
    Result := FCurrentFilterIndex
  else
    Result := FFilterIndex;
end;

procedure TOpenDialog.SetHistoryList(Value: TStrings);
begin
  FHistoryList.Assign(Value);
end;

procedure TOpenDialog.SetInitialDir(const Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  if (L > 1) and IsPathDelimiter(Value, L)
    and not IsDelimiter(':', Value, L - 1) then Dec(L);
  FInitialDir := Copy(Value, 1, L);
end;

function TOpenDialog.Execute: Boolean;
begin
  Result := DoExecute(@GetOpenFileName);
end;

procedure TOpenDialog.DoIncludeItem(const OFN: TOFNotifyEx; var Include: Boolean);
begin
  if Assigned(FOnIncludeItem) then FOnIncludeItem(OFN, Include);
end;

{ TSaveDialog }

function TSaveDialog.Execute: Boolean;
begin
  Result := DoExecute(@GetSaveFileName);
end;

{ TColorDialog }

constructor TColorDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCustomColors := TStringList.Create;
end;

destructor TColorDialog.Destroy;
begin
  FCustomColors.Free;
  inherited Destroy;
end;

function TColorDialog.Execute: Boolean;
const
  DialogOptions: array[TColorDialogOption] of DWORD = (
    CC_FULLOPEN, CC_PREVENTFULLOPEN, CC_SHOWHELP, CC_SOLIDCOLOR,
    CC_ANYCOLOR);
var
  ChooseColorRec: TChooseColor;
  Option: TColorDialogOption;
  CustomColorsArray: TCustomColors;

const
  ColorPrefix = 'Color';

  procedure GetCustomColorsArray;
  var
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
      FCustomColors.Values[ColorPrefix + Char(Ord('A') + I)] :=
        Format('%.6x', [CustomColorsArray[I]]);
  end;

  procedure SetCustomColorsArray;
  var
    Value: string;
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
    begin
      Value := FCustomColors.Values[ColorPrefix + Char(Ord('A') + I)];
      if Value <> '' then
        CustomColorsArray[I] := StrToInt('$' + Value) else
        CustomColorsArray[I] := -1;
    end;
  end;

begin
  with ChooseColorRec do
  begin
    SetCustomColorsArray;
    lStructSize := SizeOf(ChooseColorRec);
    hInstance := SysInit.HInstance;
    rgbResult := ColorToRGB(FColor);
    lpCustColors := @CustomColorsArray;
    Flags := CC_RGBINIT or CC_ENABLEHOOK;
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or DialogOptions[Option];
    if Template <> nil then
    begin
      Flags := Flags or CC_ENABLETEMPLATE;
      lpTemplateName := Template;
    end;
    lpfnHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := TaskModalDialog(@ChooseColor, ChooseColorRec);
    if Result then
    begin
      FColor := rgbResult;
      GetCustomColorsArray;
    end;
  end;
end;

procedure TColorDialog.SetCustomColors(Value: TStrings);
begin
  FCustomColors.Assign(Value);
end;

{ TFontDialog }

const
  IDAPPLYBTN = $402;

var
  FontDialog: TFontDialog;

function FontDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  if (Msg = WM_COMMAND) and (LongRec(WParam).Lo = IDAPPLYBTN) and
    (LongRec(WParam).Hi = BN_CLICKED) then
  begin
    FontDialog.DoApply(Wnd);
    Result := 1;
  end else
    Result := DialogHook(Wnd, Msg, wParam, lParam);
end;

constructor TFontDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
  FOptions := [fdEffects];
end;

destructor TFontDialog.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TFontDialog.WndProc(var Message: TMessage);
begin
  { Make sure we only take values from the color combobox and script combobox
    if they have been changed. }
  if (Message.Msg = WM_COMMAND) and (Message.WParamHi = CBN_SELENDOK) then
    if (Message.WParamLo = cmb4) then FFontColorModified := True
    else if (Message.WParamLo = cmb5) then FFontCharsetModified := True;
  inherited WndProc(Message);
end;

procedure TFontDialog.Apply(Wnd: HWND);
begin
  if Assigned(FOnApply) then FOnApply(Self, Wnd);
end;

procedure TFontDialog.DoApply(Wnd: HWND);
const
  IDCOLORCMB = $473;
var
  I: Integer;
  LogFont: TLogFont;
begin
  SendMessage(Wnd, WM_CHOOSEFONT_GETLOGFONT, 0, LongInt(@LogFont));
  UpdateFromLogFont(LogFont);
  I := SendDlgItemMessage(Wnd, IDCOLORCMB, CB_GETCURSEL, 0, 0);
  if I <> CB_ERR then
    Font.Color := SendDlgItemMessage(Wnd, IDCOLORCMB, CB_GETITEMDATA, I, 0);
  try
    Apply(Wnd);
  except
    Application.HandleException(Self);
  end;
end;

function TFontDialog.Execute: Boolean;
const
  FontOptions: array[TFontDialogOption] of DWORD = (
    CF_ANSIONLY, CF_TTONLY, CF_EFFECTS, CF_FIXEDPITCHONLY, CF_FORCEFONTEXIST,
    CF_NOFACESEL, CF_NOOEMFONTS, CF_NOSIMULATIONS, CF_NOSIZESEL,
    CF_NOSTYLESEL, CF_NOVECTORFONTS, CF_SHOWHELP,
    CF_WYSIWYG or CF_BOTH or CF_SCALABLEONLY, CF_LIMITSIZE,
    CF_SCALABLEONLY, CF_APPLY);  
  Devices: array[TFontDialogDevice] of DWORD = (
    CF_SCREENFONTS, CF_PRINTERFONTS, CF_BOTH);
var
  ChooseFontRec: TChooseFont;
  LogFont: TLogFont;
  Option: TFontDialogOption;
  SaveFontDialog: TFontDialog;
  OriginalFaceName: string;
begin
  with ChooseFontRec do
  begin
    lStructSize := SizeOf(ChooseFontRec);
    hDC := 0;
    if FDevice <> fdScreen then hDC := Printer.Handle;
    lpLogFont := @LogFont;
    GetObject(Font.Handle, SizeOf(LogFont), @LogFont);
    OriginalFaceName := LogFont.lfFaceName;
    Flags := Devices[FDevice] or (CF_INITTOLOGFONTSTRUCT or CF_ENABLEHOOK);
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or FontOptions[Option];
    if Assigned(FOnApply) then Flags := Flags or CF_APPLY;
    if Template <> nil then
    begin
      Flags := Flags or CF_ENABLETEMPLATE;
      lpTemplateName := Template;
    end;
    rgbColors := Font.Color;
    lCustData := 0;
    lpfnHook := FontDialogHook;
    nSizeMin := FMinFontSize;
    nSizeMax := FMaxFontSize;
    if nSizeMin > nSizeMax then Flags := Flags and (not CF_LIMITSIZE);
    hWndOwner := Application.Handle;
    SaveFontDialog := FontDialog;
    FontDialog := Self;
    FFontColorModified := False;
    FFontCharsetModified := False;
    Result := TaskModalDialog(@ChooseFont, ChooseFontRec);
    FontDialog := SaveFontDialog;
    if Result then
    begin
      if AnsiCompareText(OriginalFaceName, LogFont.lfFaceName) <> 0 then
        FFontCharsetModified := True;
      UpdateFromLogFont(LogFont);
      if FFontColorModified then Font.Color := rgbColors;
    end;
  end;
end;

procedure TFontDialog.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TFontDialog.UpdateFromLogFont(const LogFont: TLogFont);
var
  Style: TFontStyles;
begin
  with LogFont do
  begin
    Font.Name := LogFont.lfFaceName;
    Font.Height := LogFont.lfHeight;
    if FFontCharsetModified then
      Font.Charset := TFontCharset(LogFont.lfCharSet);
    Style := [];
    with LogFont do
    begin
      if lfWeight > FW_REGULAR then Include(Style, fsBold);
      if lfItalic <> 0 then Include(Style, fsItalic);
      if lfUnderline <> 0 then Include(Style, fsUnderline);
      if lfStrikeOut <> 0 then Include(Style, fsStrikeOut);
    end;
    Font.Style := Style;
  end;
end;

{ Printer dialog routines }

procedure GetPrinter(var DeviceMode, DeviceNames: THandle);
var
  Device, Driver, Port: array[0..1023] of char;
  DevNames: PDevNames;
  Offset: PChar;
begin
  Printer.GetPrinter(Device, Driver, Port, DeviceMode);
  if DeviceMode <> 0 then
  begin
    DeviceNames := GlobalAlloc(GHND, SizeOf(TDevNames) +
     StrLen(Device) + StrLen(Driver) + StrLen(Port) + 3);
    DevNames := PDevNames(GlobalLock(DeviceNames));
    try
      Offset := PChar(DevNames) + SizeOf(TDevnames);
      with DevNames^ do
      begin
        wDriverOffset := Longint(Offset) - Longint(DevNames);
        Offset := StrECopy(Offset, Driver) + 1;
        wDeviceOffset := Longint(Offset) - Longint(DevNames);
        Offset := StrECopy(Offset, Device) + 1;
        wOutputOffset := Longint(Offset) - Longint(DevNames);;
        StrCopy(Offset, Port);
      end;
    finally
      GlobalUnlock(DeviceNames);
    end;
  end;
end;

procedure SetPrinter(DeviceMode, DeviceNames: THandle);
var
  DevNames: PDevNames;
begin
  DevNames := PDevNames(GlobalLock(DeviceNames));
  try
    with DevNames^ do
      Printer.SetPrinter(PChar(DevNames) + wDeviceOffset,
        PChar(DevNames) + wDriverOffset,
        PChar(DevNames) + wOutputOffset, DeviceMode);
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
  else Result := 0;
end;

{ TPrinterSetupDialog }

function TPrinterSetupDialog.Execute: Boolean;
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PD_ENABLESETUPHOOK or PD_PRINTSETUP;
    lpfnSetupHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := TaskModalDialog(@PrintDlg, PrintDlgRec);
    if Result then
      SetPrinter(hDevMode, hDevNames)
    else begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ TPrintDialog }

procedure TPrintDialog.SetNumCopies(Value: Integer);
begin
  FCopies := Value;
  try
   Printer.Copies := Value;
  except
   on EPrinter do;
  end;
end;

function TPrintDialog.Execute: Boolean;
const
  PrintRanges: array[TPrintRange] of Integer =
    (PD_ALLPAGES, PD_SELECTION, PD_PAGENUMS);
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PrintRanges[FPrintRange] or (PD_ENABLEPRINTHOOK or
      PD_ENABLESETUPHOOK);
    if FCollate then Inc(Flags, PD_COLLATE);
    if not (poPrintToFile in FOptions) then Inc(Flags, PD_HIDEPRINTTOFILE);
    if not (poPageNums in FOptions) then Inc(Flags, PD_NOPAGENUMS);
    if not (poSelection in FOptions) then Inc(Flags, PD_NOSELECTION);
    if poDisablePrintToFile in FOptions then Inc(Flags, PD_DISABLEPRINTTOFILE);
    if FPrintToFile then Inc(Flags, PD_PRINTTOFILE);
    if poHelp in FOptions then Inc(Flags, PD_SHOWHELP);
    if not (poWarning in FOptions) then Inc(Flags, PD_NOWARNING);
    if Template <> nil then
    begin
      Flags := Flags or PD_ENABLEPRINTTEMPLATE;
      lpPrintTemplateName := Template;
    end;
    nFromPage := FFromPage;
    nToPage := FToPage;
    nMinPage := FMinPage;
    nMaxPage := FMaxPage;
    lpfnPrintHook := DialogHook;
    lpfnSetupHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := TaskModalDialog(@PrintDlg, PrintDlgRec);
    if Result then
    begin
      SetPrinter(hDevMode, hDevNames);
      FCollate := Flags and PD_COLLATE <> 0;
      FPrintToFile := Flags and PD_PRINTTOFILE <> 0;
      if Flags and PD_SELECTION <> 0 then FPrintRange := prSelection else
        if Flags and PD_PAGENUMS <> 0 then FPrintRange := prPageNums else
          FPrintRange := prAllPages;
      FFromPage := nFromPage;
      FToPage := nToPage;
      if nCopies = 1 then
        Copies := Printer.Copies else
        Copies := nCopies;
    end
    else begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ TPageSetupDialog }

var
  PgSetupDlg: TPageSetupDialog;  // Used for page paint callback

function PagePaint(Wnd: HWND; Message: UINT; wParam: WPARAM; lParam: LPARAM): UINT; stdcall;
var
  DoneDrawing: Boolean;

  procedure CallPaintEvent(Event: TPaintPageEvent);
  var
    Canvas: TCanvas;
  begin
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := HDC(wParam);
      if Assigned(Event) then
        Event(PgSetupDlg, Canvas, PRect(lParam)^, DoneDrawing);
    finally
      Canvas.Free;
    end;
  end;

const
  PageType: array[Boolean] of TPageType = (ptEnvelope, ptPaper);
  Orientation: array[Boolean] of TPrinterOrientation = (poPortrait, poLandscape);
begin
  Result := UINT(False);
  if not Assigned(PgSetupDlg) then exit; 
  DoneDrawing := False;
  if Message = WM_PSD_PAGESETUPDLG then
  begin
    if Assigned(PgSetupDlg.FBeforePaint) then
      // Constants used below are from WinAPI help on WM_PSD_PAGESETUPDLG
      PgSetupDlg.BeforePaint(PgSetupDlg, (wParam and $FFFF),
        Orientation[(wParam shr 16) in [$0001,$0003, $000B, $0019]],
        PageType[(wParam shr 16) > $000B], DoneDrawing);
  end
  else
    with PgSetupDlg do
      case Message of
        WM_PSD_FULLPAGERECT  : CallPaintEvent(FOnDrawFullPage);
        WM_PSD_MINMARGINRECT : CallPaintEvent(FOnDrawMinMargin);
        WM_PSD_MARGINRECT    : CallPaintEvent(FOnDrawMargin);
        WM_PSD_GREEKTEXTRECT : CallPaintEvent(FOnDrawGreekText);
        WM_PSD_ENVSTAMPRECT  : CallPaintEvent(FOnDrawEnvStamp);
        WM_PSD_YAFULLPAGERECT: CallPaintEvent(FOnDrawRetAddress);
      end;
  Result := UINT(DoneDrawing);
end;

constructor TPageSetupDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Options := [psoDefaultMinMargins];
  GetDefaults;
end;

function TPageSetupDialog.Execute: Boolean;
var
  DevHandle: THandle;
begin
  FillChar(FPageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);
  with PageSetupDlgRec do
  begin
    lStructSize := SizeOf(PageSetupDlgRec);
    hwndOwner := Application.Handle;
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PSD_RETURNDEFAULT;
    PageSetupDlg(FPageSetupDlgRec);
    Flags := PSD_ENABLEPAGEPAINTHOOK or PSD_ENABLEPAGESETUPHOOK or PSD_MARGINS;
    case FUnits of
//    pmDefault    : Read from locale settings by the dialog
      pmInches     : Inc(Flags, PSD_INTHOUSANDTHSOFINCHES);
      pmMillimeters: Inc(Flags, PSD_INHUNDREDTHSOFMILLIMETERS);
    end;
    if psoDefaultMinMargins in FOptions then Inc(Flags, PSD_DEFAULTMINMARGINS);
    if psoDisableMargins in FOptions then Inc(Flags, PSD_DisableMargins);
    if psoDisableOrientation in FOptions then Inc(Flags, PSD_DISABLEORIENTATION);
    if psoDisablePagePainting in FOptions then
      Inc(Flags, PSD_DISABLEPAGEPAINTING)
    else
    begin
      PgSetupDlg := Self;
      lpfnPagePaintHook := PagePaint;
    end;
    if psoDisablePaper in FOptions then Inc(Flags, PSD_DISABLEPAPER);
    if psoDisablePrinter in FOptions then Inc(Flags, PSD_DISABLEPRINTER);
    if psoMargins in FOptions then Inc(Flags, PSD_MARGINS);
    if psoMinMargins in FOptions then Inc(Flags, PSD_MINMARGINS);
    if psoShowHelp in FOptions then Inc(Flags, PSD_SHOWHELP);
    if not (psoWarning in FOptions) then Inc(Flags, PSD_NOWARNING);
    if psoNoNetworkButton in FOptions then Inc(Flags, PSD_NONETWORKBUTTON);
    ptPaperSize := Point(FPageWidth, FPageHeight);
    rtMinMargin := Rect(FMinMarginLeft, FMinMarginTop, FMinMarginRight, FMinMarginBottom);
    rtMargin := Rect(FMarginLeft, FMarginTop, FMarginRight, FMarginBottom);
    lpfnPageSetupHook := DialogHook;

    Result := TaskModalDialog(@PageSetupDlg, FPageSetupDlgRec);
    if Result then
    begin
      PageWidth := ptPaperSize.x;
      PageHeight := ptPaperSize.y;
      MarginLeft := rtMargin.Left;
      MarginTop := rtMargin.Top;
      MarginRight := rtMargin.Right;
      MarginBottom := rtMargin.Bottom;
      SetPrinter(hDevMode, hDevNames)
    end
    else begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

function TPageSetupDialog.GetDefaults: Boolean;
var
  PageSetupDlgRec: TPageSetupDlg;
begin
  Result := False;
  try
    Printer.PrinterIndex;  // raises an exception if there is no default printer
  except
    exit;
  end;
  FillChar(PageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);
  with PageSetupDlgRec do
  begin
    lStructSize := SizeOf(PageSetupDlgRec);
    hwndOwner := Application.Handle;
    hInstance := SysInit.HInstance;
    case FUnits of
//    pmDefault    : Read from locale settings by the dialog
      pmInches     : Inc(Flags, PSD_INTHOUSANDTHSOFINCHES);
      pmMillimeters: Inc(Flags, PSD_INHUNDREDTHSOFMILLIMETERS);
    end;
    if psoDefaultMinMargins in FOptions then Inc(Flags, PSD_DEFAULTMINMARGINS);
    if psoDisableMargins in FOptions then Inc(Flags, PSD_DISABLEMARGINS);
    if psoDisableOrientation in FOptions then Inc(Flags, PSD_DISABLEORIENTATION);
    if psoDisablePagePainting in FOptions then
      Inc(Flags, PSD_DISABLEPAGEPAINTING);
    if psoDisablePaper in FOptions then Inc(Flags, PSD_DISABLEPAPER);
    if psoDisablePrinter in FOptions then Inc(Flags, PSD_DISABLEPRINTER);
    ptPaperSize := Point(FPageWidth, FPageHeight);
    rtMinMargin := Rect(FMinMarginLeft, FMinMarginTop, FMinMarginRight, FMinMarginBottom);
    rtMargin := Rect(FMarginLeft, FMarginTop, FMarginRight, FMarginBottom);
    lpfnPageSetupHook := DialogHook;

    Flags := Flags or PSD_RETURNDEFAULT;
    Result := PageSetupDlg(PageSetupDlgRec);

    if Result then
    begin
      FPageWidth := ptPaperSize.x;
      FPageHeight := ptPaperSize.y;
      FMarginLeft := rtMargin.Left;
      FMarginTop := rtMargin.Top;
      FMarginRight := rtMargin.Right;
      FMarginBottom := rtMargin.Bottom;
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ TRedirectorWindow }
{ A redirector window is used to put the find/replace dialog into the
  ownership chain of a form, but intercept messages that CommDlg.dll sends
  exclusively to the find/replace dialog's owner.  TRedirectorWindow
  creates its hidden window handle as owned by the target form, and the
  find/replace dialog handle is created as owned by the redirector.  The
  redirector wndproc forwards all messages to the find/replace component.
}

type
  TRedirectorWindow = class(TWinControl)
  private
    FFindReplaceDialog: TFindDialog;
    FFormHandle: THandle;
    procedure CMRelease(var Message); message CM_Release;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;
  end;

procedure TRedirectorWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_VISIBLE or WS_POPUP;
    WndParent := FFormHandle;
  end;
end;

procedure TRedirectorWindow.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  if (Message.Result = 0) and (Message.Msg <> CM_RELEASE) and
    Assigned(FFindReplaceDialog) then
    Message.Result := Integer(FFindReplaceDialog.MessageHook(Message));
end;

procedure TRedirectorWindow.CMRelease(var Message);
begin
  Free;
end;

{ Find and Replace dialog routines }

function FindReplaceWndProc(Wnd: HWND; Msg, WParam, LParam: Longint): Longint; stdcall;

  function CallDefWndProc: Longint;
  begin
    Result := CallWindowProc(Pointer(GetProp(Wnd,
      MakeIntAtom(WndProcPtrAtom))), Wnd, Msg, WParam, LParam);
  end;

begin
  case Msg of
    WM_DESTROY:
      if Application.DialogHandle = Wnd then Application.DialogHandle := 0;
    WM_NCACTIVATE:
      if WParam <> 0 then
      begin
        if Application.DialogHandle = 0 then Application.DialogHandle := Wnd;
      end else
      begin
        if Application.DialogHandle = Wnd then Application.DialogHandle := 0;
      end;
    WM_NCDESTROY:
      begin
        Result := CallDefWndProc;
        RemoveProp(Wnd, MakeIntAtom(WndProcPtrAtom));
        Exit;
      end;
   end;
   Result := CallDefWndProc;
end;

function FindReplaceDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := DialogHook(Wnd, Msg, wParam, lParam);
  if Msg = WM_INITDIALOG then
  begin
    with TFindDialog(PFindReplace(LParam)^.lCustData) do
      if (Left <> -1) or (Top <> -1) then
        SetWindowPos(Wnd, 0, Left, Top, 0, 0, SWP_NOACTIVATE or
          SWP_NOSIZE or SWP_NOZORDER);
    SetProp(Wnd, MakeIntAtom(WndProcPtrAtom), GetWindowLong(Wnd, GWL_WNDPROC));
    SetWindowLong(Wnd, GWL_WNDPROC, Longint(@FindReplaceWndProc));
    Result := 1;
  end;
end;

const
  FindOptions: array[TFindOption] of DWORD = (
    FR_DOWN, FR_FINDNEXT, FR_HIDEMATCHCASE, FR_HIDEWHOLEWORD,
    FR_HIDEUPDOWN, FR_MATCHCASE, FR_NOMATCHCASE, FR_NOUPDOWN, FR_NOWHOLEWORD,
    FR_REPLACE, FR_REPLACEALL, FR_WHOLEWORD, FR_SHOWHELP);

{ TFindDialog }

constructor TFindDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [frDown];
  FPosition.X := -1;
  FPosition.Y := -1;
  with FFindReplace do
  begin
    lStructSize := SizeOf(TFindReplace);
    hWndOwner := Application.Handle;
    hInstance := SysInit.HInstance;
    lpstrFindWhat := FFindText;
    wFindWhatLen := SizeOf(FFindText);
    lpstrReplaceWith := FReplaceText;
    wReplaceWithLen := SizeOf(FReplaceText);
    lCustData := Longint(Self);
    lpfnHook := FindReplaceDialogHook;
  end;
  FFindReplaceFunc := @CommDlg.FindText;
end;

destructor TFindDialog.Destroy;
begin
  if FFindHandle <> 0 then SendMessage(FFindHandle, WM_CLOSE, 0, 0);
  if Assigned(FRedirector) then
    TRedirectorWindow(FRedirector).FFindReplaceDialog := nil;
  FreeAndNil(FRedirector);
  inherited Destroy;
end;

procedure TFindDialog.CloseDialog;
begin
  if FFindHandle <> 0 then PostMessage(FFindHandle, WM_CLOSE, 0, 0);
end;

function GetTopWindow(Wnd: THandle; var ReturnVar: THandle):Bool; stdcall;
var
  Test: TWinControl;
begin
  Test := FindControl(Wnd);
  Result := True;
  if Assigned(Test) and (Test is TForm) then
  begin
    ReturnVar := Wnd;
    Result := False;
   end;
end;

function TFindDialog.Execute: Boolean;
var
  Option: TFindOption;
begin
  if FFindHandle <> 0 then
  begin
    BringWindowToTop(FFindHandle);
    Result := True;
  end else
  begin
    FFindReplace.Flags := FR_ENABLEHOOK;
    FFindReplace.lpfnHook := FindReplaceDialogHook;
    FRedirector := TRedirectorWindow.Create(nil);
    with TRedirectorWindow(FRedirector) do
    begin
      FFindReplaceDialog := Self;
      EnumThreadWindows(GetCurrentThreadID, @GetTopWindow, LPARAM(@FFormHandle));
    end;
    FFindReplace.hWndOwner := FRedirector.Handle;
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        FFindReplace.Flags := FFindReplace.Flags or FindOptions[Option];
    if Template <> nil then
    begin
      FFindReplace.Flags := FFindReplace.Flags or FR_ENABLETEMPLATE;
      FFindReplace.lpTemplateName := Template;
    end;
    CreationControl := Self;
    FFindHandle := FFindReplaceFunc(FFindReplace);
    Result := FFindHandle <> 0;
  end;
end;

procedure TFindDialog.Find;
begin
  if Assigned(FOnFind) then FOnFind(Self);
end;

function TFindDialog.GetFindText: string;
begin
  Result := FFindText;
end;

function TFindDialog.GetLeft: Integer;
begin
  Result := Position.X;
end;

function TFindDialog.GetPosition: TPoint;
var
  Rect: TRect;
begin
  Result := FPosition;
  if FFindHandle <> 0 then
  begin
    GetWindowRect(FFindHandle, Rect);
    Result := Rect.TopLeft;
  end;
end;

function TFindDialog.GetReplaceText: string;
begin
  Result := FReplaceText;
end;

function TFindDialog.GetTop: Integer;
begin
  Result := Position.Y;
end;

function TFindDialog.MessageHook(var Msg: TMessage): Boolean;
var
  Option: TFindOption;
  Rect: TRect;
begin
  Result := inherited MessageHook(Msg);
  if not Result then
    if (Msg.Msg = FindMsg) and (Pointer(Msg.LParam) = @FFindReplace) then
    begin
      FOptions := [];
      for Option := Low(Option) to High(Option) do
        if (FFindReplace.Flags and FindOptions[Option]) <> 0 then
          Include(FOptions, Option);
      if (FFindReplace.Flags and FR_FINDNEXT) <> 0 then
        Find
      else
      if (FFindReplace.Flags and (FR_REPLACE or FR_REPLACEALL)) <> 0 then
        Replace
      else
      if (FFindReplace.Flags and FR_DIALOGTERM) <> 0 then
      begin
        GetWindowRect(FFindHandle, Rect);
        FPosition := Rect.TopLeft;
        FFindHandle := 0;
        PostMessage(FRedirector.Handle,CM_RELEASE,0,0); // free redirector later
        FRedirector := nil;
      end;
      Result := True;
    end;
end;

procedure TFindDialog.Replace;
begin
  if Assigned(FOnReplace) then FOnReplace(Self);
end;

procedure TFindDialog.SetFindText(const Value: string);
begin
  StrLCopy(FFindText, PChar(Value), SizeOf(FFindText) - 1);
end;

procedure TFindDialog.SetLeft(Value: Integer);
begin
  SetPosition(Point(Value, Top));
end;

procedure TFindDialog.SetPosition(const Value: TPoint);
begin
  if (FPosition.X <> Value.X) or (FPosition.Y <> Value.Y) then
  begin
    FPosition := Value;
    if FFindHandle <> 0 then
      SetWindowPos(FFindHandle, 0, Value.X, Value.Y, 0, 0,
        SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;

procedure TFindDialog.SetReplaceText(const Value: string);
begin
  StrLCopy(FReplaceText, PChar(Value), SizeOf(FReplaceText) - 1);
end;

procedure TFindDialog.SetTop(Value: Integer);
begin
  SetPosition(Point(Left, Value));
end;

{ TReplaceDialog }

constructor TReplaceDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFindReplaceFunc := CommDlg.ReplaceText;
end;

{ Message dialog }

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;


type
  TMessageForm = class(TForm)
  private
    Message: TLabel;
    procedure HelpButtonClick(Sender: TObject);
  protected
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WriteToClipBoard(Text: String);
    function GetFormText: String;
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
  end;

constructor TMessageForm.CreateNew(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
end;

procedure TMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TMessageForm.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    Beep;
    WriteToClipBoard(GetFormText);
  end;
end;

procedure TMessageForm.WriteToClipBoard(Text: String);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if OpenClipBoard(0) then
  begin
    try
      Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Length(Text) + 1);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(PChar(Text)^, DataPtr^, Length(Text) + 1);
          EmptyClipBoard;
          SetClipboardData(CF_TEXT, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      CloseClipBoard;
    end;
  end
  else
    raise Exception.CreateRes(@SCannotOpenClipboard);
end;

function TMessageForm.GetFormText: String;
var
  DividerLine, ButtonCaptions: string;
  I: integer;
begin
  DividerLine := StringOfChar('-', 27) + sLineBreak;
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TButton then
      ButtonCaptions := ButtonCaptions + TButton(Components[I]).Caption +
        StringOfChar(' ', 3);
  ButtonCaptions := StringReplace(ButtonCaptions,'&','', [rfReplaceAll]);
  Result := Format('%s%s%s%s%s%s%s%s%s%s', [DividerLine, Caption, sLineBreak,
    DividerLine, Message.Caption, sLineBreak, DividerLine, ButtonCaptions,
    sLineBreak, DividerLine]);
end;

var
  Captions: array[TMsgDlgType] of Pointer = (@SMsgDlgWarning, @SMsgDlgError,
    @SMsgDlgInformation, @SMsgDlgConfirm, nil);
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  ButtonNames: array[TMsgDlgBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help');
  ButtonCaptions: array[TMsgDlgBtn] of Pointer = (
    @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgOK, @SMsgDlgCancel, @SMsgDlgAbort,
    @SMsgDlgRetry, @SMsgDlgIgnore, @SMsgDlgAll, @SMsgDlgNoToAll, @SMsgDlgYesToAll,
    @SMsgDlgHelp);
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0);
var
  ButtonWidths : array[TMsgDlgBtn] of integer;  // initialized to zero

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): TForm;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, ALeft: Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  TextRect: TRect;
  CenteredLabel : Boolean;                      {V}
  lMsg: string;                                 {V}
begin
  {V}
  CenteredLabel := False;
  lMsg := Msg;
  If (Length(lMsg) > 0) and (lMsg[Byte(Length(lMsg))] = #3)
   then
    Begin
     SetLength(lMsg, Pred(Length(lMsg)));
     CenteredLabel := True;
    end;
  {^V}

  Result := TMessageForm.CreateNew(Application);
  with Result do
  begin
    BiDiMode := Application.BiDiMode;
    BorderStyle := bsDialog;
    Canvas.Font := Font;
    KeyPreview := True;
    OnKeyDown := TMessageForm(Result).CustomKeyDown;
    DialogUnits := GetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      if B in Buttons then
      begin
        if ButtonWidths[B] = 0 then
        begin
          TextRect := Rect(0,0,0,0);
          Windows.DrawText( canvas.handle,
            PChar(LoadResString(ButtonCaptions[B])), -1,
            TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
            DrawTextBiDiModeFlagsReadingOnly);
          with TextRect do ButtonWidths[B] := Right - Left + 8;
        end;
        if ButtonWidths[B] > ButtonWidth then
          ButtonWidth := ButtonWidths[B];
      end;
    end;
    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
    DrawText(Canvas.Handle, PChar(lMsg), Length(lMsg)+1, TextRect, {V}
      DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or
      DrawTextBiDiModeFlagsReadingOnly);

    IconID := IconIDs[DlgType];
    IconTextWidth := TextRect.Right;
    IconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;
    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);
    if DlgType <> mtCustom then
      Caption := LoadResString(Captions[DlgType]) else
      Caption := Application.Title;
    if IconID <> nil then
      with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;
    TMessageForm(Result).Message := TLabel.Create(Result);
    with TMessageForm(Result).Message do
    begin
      Name := 'Message';
      Parent := Result;
      WordWrap := True;
      Caption := lMsg; {V}
      BoundsRect := TextRect;
      BiDiMode := Result.BiDiMode;
      If CenteredLabel then Alignment := taCenter;  {V}
      ALeft := IconTextWidth - TextRect.Right + HorzMargin;
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
      SetBounds(ALeft, VertMargin,
        TextRect.Right, TextRect.Bottom);
    end;
    if mbOk in Buttons then DefaultButton := mbOk else
      if mbYes in Buttons then DefaultButton := mbYes else
        DefaultButton := mbRetry;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
        with TButton.Create(Result) do
        begin
          Name := ButtonNames[B];
          Parent := Result;
          Caption := LoadResString(ButtonCaptions[B]);
          ModalResult := ModalResults[B];
          if B = DefaultButton then Default := True;
          if B = CancelButton then Cancel := True;
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing,
            ButtonWidth, ButtonHeight);
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := TMessageForm(Result).HelpButtonClick;
        end;
  end;
end;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;

function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons) do
    try
      HelpContext := HelpCtx;
      HelpFile := HelpFileName;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if (Y < 0) and (X < 0) then Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
end;

procedure ShowMessage(const Msg: string);
begin
  ShowMessagePos(Msg, -1, -1);
end;

procedure ShowMessageFmt(const Msg: string; Params: array of const);
begin
  ShowMessage(Format(Msg, Params));
end;

procedure ShowMessagePos(const Msg: string; X, Y: Integer);
begin
  MessageDlgPos(Msg, mtCustom, [mbOK], 0, X, Y);
end;

{ Input dialog }

function InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;          
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result);
end;

function PromptForFileName(var AFileName: string; const AFilter: string = '';
  const ADefaultExt: string = ''; const ATitle: string = '';
  const AInitialDir: string = ''; SaveDialog: Boolean = False): Boolean;
var
  Dialog: TOpenDialog;
begin
  if SaveDialog then
  begin
    Dialog := TSaveDialog.Create(nil);
    Dialog.Options := Dialog.Options + [ofOverwritePrompt];
  end
  else
    Dialog := TOpenDialog.Create(nil);
  with Dialog do
  try
    Title := ATitle;
    DefaultExt := ADefaultExt;
    if AFilter = '' then
      Filter := SDefaultFilter else
      Filter := AFilter;
    InitialDir := AInitialDir;
    FileName := AFileName;
    Result := Execute;
    if Result then
      AFileName := FileName;
  finally
    Free;
  end;
end;

{ Initialization and cleanup }

procedure InitGlobals;
var
  AtomText: array[0..31] of Char;
begin
  HelpMsg := RegisterWindowMessage(HelpMsgString);
  FindMsg := RegisterWindowMessage(FindMsgString);
  WndProcPtrAtom := GlobalAddAtom(StrFmt(AtomText,
    'WndProcPtr%.8X%.8X', [HInstance, GetCurrentThreadID]));
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Vcl\dialogs.pas initialization enter'); {$EndIf}
  InitGlobals;
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TCommonDialog, TControl);
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Vcl\dialogs.pas initialization leave'); {$EndIf}
finalization
  if WndProcPtrAtom <> 0 then GlobalDeleteAtom(WndProcPtrAtom);
end.
