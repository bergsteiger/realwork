{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 2000-2002 Borland Software Corporation                        }
{                                                                             }
{ This file may be distributed and/or modified under the terms of the GNU     }
{ General Public License (GPL) version 2 as published by the Free Software    }
{ Foundation and appearing at http://www.borland.com/kylix/gpl.html.          }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit QDialogs;

{$R-,T-,H+,X+}

interface

uses
  {$IFDEF MSWINDOWS} Windows, Messages, ShlObj, ActiveX, CommDlg, {$ENDIF}
  SysUtils, Types, QTypes, Qt, Classes, QGraphics, QControls, QStdCtrls, QForms,
  QExtCtrls;

const

{ Maximum number of custom colors in color dialog }

  MaxCustomColors = 16;

type
  EQtDialogException = class(Exception);

  TDialog = class(TComponent)
  private
    FHelpType: THelpType;
    FScaleFlags: TScalingFlags;
    FPosition: TPoint;
    FModal: Boolean;
    FShowing: Boolean;
    FHelpKeyword: string;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FWidth: Integer;
    FHeight: Integer;
    FTitle: WideString;
    FHelpContext: THelpContext;
    procedure SetPosition(const Value: TPoint);
    function GetPosition: TPoint;
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    procedure DoClose; dynamic;
    function DoExecute: Boolean; virtual; abstract;
    procedure DoShow; dynamic;
    function GetBounds: TRect; virtual; abstract;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); virtual; abstract;
    procedure SetTitle(const Value: WideString); virtual;
    property Height: Integer read GetHeight write SetHeight;
    property Modal: Boolean read FModal write FModal default True;
    property Position: TPoint read GetPosition write SetPosition;
    property Title: WideString read FTitle write SetTitle;
    property Width: Integer read GetWidth write SetWidth;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; virtual;
  published
    property HelpType: THelpType read FHelpType write FHelpType default htKeyword;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property HelpKeyword: string read FHelpKeyword write FHelpKeyword;
  end;

  { TQtDialog }

  TQtDialog = class(TDialog)
  private
    FHooks: QObject_hookH;
    FHandle: QDialogH;
{$IFDEF MSWINDOWS}
    FUseNative: Boolean;
    FNativeFlags: Integer;
{$ENDIF}    
    function GetHandle: QDialogH;
    procedure CreateHandle;
    procedure DestroyedHook; cdecl;
    procedure HandleNeeded;
    procedure InvokeHelp;
    function GetHooks: QObject_hookH;
  protected
    function AppEventFilter(Sender: QObjectH; Event: QEventH): Boolean; virtual; cdecl;
    procedure CreateWidget; virtual;
    procedure DestroyWidget;
    procedure InitWidget; virtual;
    function GetBounds: TRect; override;
    procedure HookEvents; virtual;
    function DoExecute: Boolean; override;
    procedure DoShow; override;
    {$IFDEF MSWINDOWS}
    function NativeExecute(Flags: Integer): Boolean; virtual;
    {$ENDIF}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetTitle(const Value: WideString); override;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; virtual; cdecl;
    function WidgetFlags: Integer; virtual;
    property Hooks: QObject_hookH read GetHooks write FHooks;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    function HandleAllocated: Boolean;
    property Handle: QDialogH read GetHandle;
    property Position;
  published
    property Height default 0;
    {$IFDEF MSWINDOWS}
    property NativeFlags: Integer read FNativeFlags write FNativeFlags default 0;
    property UseNativeDialog: Boolean read FUseNative write FUseNative default True;
    {$ENDIF}
    property Width default 0;
  end;

{ TColorDialog }

  TCustomColors = array[0..MaxCustomColors - 1] of Longint;

  TColorDialog = class(TQtDialog)
  private
    FColor: TColor;
    FCustomColors: TStrings;
    procedure SetCustomColors(Value: TStrings);
  protected
    function DoExecute: Boolean; override;
{$IFDEF MSWINDOWS}
    function NativeExecute(Flags: Integer): Boolean; override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Color: TColor read FColor write FColor default clBlack;
    property CustomColors: TStrings read FCustomColors write SetCustomColors;
  end;

{ TFontDialog }

  TFontDialog = class(TQtDialog)
  private
    FFont: TFont;
    procedure SetFont(Value: TFont);
  protected
    function DoExecute: Boolean; override;
{$IFDEF MSWINDOWS}
    function NativeExecute(Flags: Integer): Boolean; override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Font: TFont read FFont write SetFont;
  end;

  TCustomDialog = class;

  TDialogForm = class(TForm)
  private
    FDialog: TCustomDialog;
  public
    procedure InvokeHelp; override;
    property Dialog: TCustomDialog read FDialog;
  end;

  TDialogFormClass = class of TDialogForm;

  TCustomDialog = class(TDialog)
  private
    FForm: TDialogForm;
    procedure Close(Sender: TObject; var Action: TCloseAction);
  protected
    function CreateForm: TDialogForm; virtual; abstract;
    function DoExecute: Boolean; override;
    procedure DoShow; override;
    procedure DoClose; override;
    function GetBounds: TRect; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetTitle(const Value: WideString); override;
  public
    destructor Destroy; override;
    function Execute: Boolean; override;
    property Form: TDialogForm read FForm;
    procedure InvokeHelp;
  end;

{ TOpenDialog }

var
  FileDialogFormClass: TDialogFormClass = nil;

type
  IFilePreviewer = interface
    ['{A1CE46CC-8358-4823-8743-C81787BE9263}']
    function CanPreview(const Filename: string): Boolean;
    procedure GetPreviewSize(Filename: string; Canvas: TCanvas; var Size: TSize);
    procedure Preview(const Filename: string; Canvas: TCanvas; const Rect: TRect;
      Progress: TProgressEvent);
    procedure StopPreview;
  end;

  TOpenDialog = class;
  TOpenOption = (ofShowHidden, ofOverwritePrompt, ofNoChangeDir, ofAllowMultiSelect,
    ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofShowHelp,
    ofHideReadOnly, ofReadOnly, ofViewDetail, ofViewIcon, ofViewList, ofPreview,
    ofAutoPreview);
  TOpenOptions = set of TOpenOption;

  TFileAddEvent = procedure(Sender: TObject; const Filename: string; const Readable,
    Writeable, Executable: Boolean; var CanAdd: Boolean) of object;
  TFileSelectEvent = procedure(Sender: TObject; const Filename: string) of object;
  TFilePreviewEvent = procedure(Sender: TObject; const Filename: string;
    Canvas: TCanvas; const Rect: TRect; Progress: TProgressEvent; var Handled: Boolean) of object;
  TDirChangeEvent = procedure(Sender: TObject; const Dir: string) of object;
  TFilterChangeEvent = procedure(Sender: TObject; NewIndex: Integer) of object;

  TFileSelectedEvent = procedure(Sender: TObject; AFile: PFileInfo;
    Selected: Boolean) of object;

  IOpenDialog = interface
    ['{D88505E5-3A59-D611-9577-00B0D006527D}']
    procedure CanClose(var CanClose: Boolean);
    procedure DirChanged(NewDir: WideString);
    function FileAdd(const Filename: WideString; const Readable, Writeable,
      Executable: Boolean): Boolean;
    procedure FilePreview(const Filename: WideString; Canvas: TCanvas;
      const Rect: TRect; Progress: TProgressEvent; var Handled: Boolean);
    procedure FileSelected(AFile: PFileInfo; Selected: Boolean);
    procedure FilterChanged(Index: Integer);
    procedure Help;
  end;

  IFileDialogForm = interface
    ['{D8C78BC3-15FB-D511-9898-94D131D16641}']
    procedure GetOptions(OpenDlg: TOpenDialog; Accepted: Boolean);
    function GetSelected: TFileInfos;
    procedure ListFiles(List: TStrings);
    procedure ResizePreview(const NewSize: TSize);
    procedure SetOptions(OpenDlg: TOpenDialog);
  end;

  TOpenDialog = class(TCustomDialog, IOpenDialog)
  private
    FOptions: TOpenOptions;
    FSaveDlg: Boolean;
    FHistoryList: TStrings;
    FFilter: string;
    FInitialDir: string;
    FSaveDir: string;
    FDefaultExt: string;
    FFileName: WideString;
    FFiles: TStrings;
    FFilterIndex: Integer;
    FOnFileAdd: TFileAddEvent;
    FOnFolderChange: TDirChangeEvent;
    FOnSelected: TFileSelectedEvent;
    FOnCanClose: TCloseQueryEvent;
    FOnFilterChange: TFilterChangeEvent;
{$IFDEF MSWINDOWS}
    FNativeFlags: Integer;
    FUseNative: Boolean;
    FHandle: HWnd;
{$ENDIF}
    FOnHelpClick: TNotifyEvent;
    FOnPreview: TFilePreviewEvent;
    procedure SetHistoryList(Value: TStrings);
    procedure SetSaveDlg(const Value: Boolean);
  protected
    function CreateForm: TDialogForm; override;
    function DoExecute: Boolean; override;
    procedure SetOptions; virtual;
    procedure RetrieveOptions(Accepted: Boolean); virtual;
    property SaveDlg: Boolean read FSaveDlg write SetSaveDlg default False;
    // IOpenDialog
    procedure DirChanged(NewDir: WideString); virtual;
    procedure CanClose(var CanClose: Boolean); virtual;
    function FileAdd(const Filename: WideString; const Readable, Writeable,
      Executable: Boolean): Boolean; virtual;
    procedure FilePreview(const Filename: WideString; Canvas: TCanvas;
      const Rect: TRect; Progress: TProgressEvent; var Handled: Boolean); virtual;
    procedure FileSelected(AFile: PFileInfo; Selected: Boolean); virtual;
    procedure FilterChanged(Index: Integer); virtual;
    procedure Help; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
{$IFDEF MSWINDOWS}
    function NativeExecute(Flags: Integer): Boolean; virtual;
{$ENDIF}
    procedure Refresh;
    property Files: TStrings read FFiles;
    property HistoryList: TStrings read FHistoryList write SetHistoryList;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property FileName: WideString read FFileName write FFileName;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read FFilterIndex write FFilterIndex default 1;
    property InitialDir: string read FInitialDir write FInitialDir;
    property Options: TOpenOptions read FOptions write FOptions
      default [ofHideReadOnly, ofEnableSizing];
    property Height default 350;
{$IFDEF MSWINDOWS}
    property NativeFlags: Integer read FNativeFlags write FNativeFlags default 0;
    property UseNativeDialog: Boolean read FUseNative write FUseNative default True;
{$ENDIF}
    property Title;
    property Width default 550;
    property OnClose;
    property OnCanClose: TCloseQueryEvent read FOnCanClose write FOnCanClose;
    property OnFileAdd: TFileAddEvent read FOnFileAdd write FOnFileAdd;
    property OnFilePreview: TFilePreviewEvent read FOnPreview write FOnPreview;
    property OnFilterChange: TFilterChangeEvent read FOnFilterChange
      write FOnFilterChange;
    property OnFolderChange: TDirChangeEvent read FOnFolderChange
      write FOnFolderChange;
    property OnHelpButtonClick: TNotifyEvent read FOnHelpClick write FOnHelpClick;
    property OnSelected: TFileSelectedEvent read FOnSelected write FOnSelected;
    property OnShow;
  end;

{ TSaveDialog }

  TSaveDialog = class(TOpenDialog)
  protected
    procedure SetOptions; override;
  public
{$IFDEF MSWINDOWS}
    function NativeExecute(Flags: Integer): Boolean; override;
{$ENDIF}
    constructor Create(AOwner: TComponent); override;
  end;

{ TFindDialog }

  TFindOption = (frDown, frFindNext, frHideMatchCase, frHideWholeWord,
    frHideUpDown, frMatchCase, frDisableMatchCase, frDisableUpDown,
    frDisableWholeWord, frReplace, frReplaceAll, frWholeWord, frShowHelp);
  TFindOptions = set of TFindOption;

  TFindDialogForm = class(TDialogForm)
  private
    FindEdit: TEdit;
    FindLabel: TLabel;
    WholeWord: TCheckBox;
    MatchCase: TCheckBox;
    Direction: TRadioGroup;
    FindNext: TButton;
    Cancel: TButton;
    Help: TButton;
    DialogUnits: TPoint;
  protected
    procedure ButtonPress(Sender: TObject); virtual;
    procedure CheckboxCheck(Sender: TObject);
    procedure DirectionClick(Sender: TObject);
    procedure EditChanged(Sender: TObject); virtual;
    procedure SetDialogOption(Option: TFindOption; Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TFindDialog = class(TCustomDialog)
  private
    FOptions: TFindOptions;
    FOnFind: TNotifyEvent;
    FFindText: WideString;
    procedure SetFindText(const Value: WideString);
  protected
    function CreateForm: TDialogForm; override;
    procedure DoShow; override;
    procedure Find; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    property Position;
  published
    property FindText: WideString read FFindText write SetFindText;
    property Modal default False;
    property Options: TFindOptions read FOptions write FOptions default [frDown];
    property Title;
    property OnClose;
    property OnFind: TNotifyEvent read FOnFind write FOnFind;
    property OnShow;
  end;

  TReplaceDialogForm = class(TFindDialogForm)
  private
    ReplaceBtn: TButton;
    ReplaceAll: TButton;
    ReplaceEdit: TEdit;
    ReplaceLabel: TLabel;
  protected
    procedure EditChanged(Sender: TObject); override;
    procedure ButtonPress(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TReplaceDialog }

  TReplaceDialog = class(TFindDialog)
  private
    FReplaceText: WideString;
    FOnReplace: TNotifyEvent;
    procedure SetReplaceText(const Value: WideString);
  protected
    function CreateForm: TDialogForm; override;
    procedure DoShow; override;
    procedure Replace; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ReplaceText: WideString read FReplaceText write SetReplaceText;
    property OnReplace: TNotifyEvent read FOnReplace write FOnReplace;
  end;

type
  TPreviewThread = class(TThread)
  private
    FPercent: Byte;
    FRedrawNow: Boolean;
    FContinue: Boolean;
    FCanvas: TCanvas;
    FFilename: WideString;
    FMessage: WideString;
    FProgress: TProgressEvent;
    FRect: TRect;
    FStage: TProgressStage;
    procedure DoProgress;
  protected
    procedure Draw; virtual; abstract;
    procedure Execute; override;
  public
    constructor Create(const Filename: WideString; ProgressEvent: TProgressEvent;
      Canvas: TCanvas; Rect: TRect); virtual;
    procedure UpdateProgress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect;
      const Msg: WideString; var Continue: Boolean);
    property Canvas: TCanvas read FCanvas;
    property Filename: WideString read FFilename;
    property Rect: TRect read FRect;
  end;

  TPreviewThreadClass = class of TPreviewThread;

  TThreadedPreviewer = class(TInterfacedObject, IFilePreviewer)
  private
    FThread: TPreviewThread;
    FFilename: WideString;
  protected
    function ThreadClass: TPreviewThreadClass; virtual;
  public
    function CanPreview(const Filename: string): Boolean; virtual;
    procedure GetPreviewSize(Filename: string; Canvas: TCanvas; var Size: TSize); virtual;
    procedure Preview(const Filename: string; Canvas: TCanvas; const Rect: TRect;
      Progress: TProgressEvent); virtual;
    procedure StopPreview; virtual;
  end;

  TGraphicThread = class(TPreviewThread)
  private
    FImage: TBitmap;
    procedure ImageProgress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect;
      const Msg: WideString; var Continue: Boolean);
  protected
    procedure Draw; override;
    procedure Execute; override;
  public
    constructor Create(const Filename: WideString; ProgressEvent: TProgressEvent;
      Canvas: TCanvas; Rect: TRect); override;
    destructor Destroy; override;
  end;

  TGraphicPreviewer = class(TThreadedPreviewer)
  protected
    function ThreadClass: TPreviewThreadClass; override;
  public
    function CanPreview(const Filename: string): Boolean; override;
  end;

{ Message dialog }

type
  TMsgDlgType = (mtCustom, mtInformation, mtWarning, mtError, mtConfirmation);
  TMsgDlgBtn = (mbNone, mbOk, mbCancel, mbYes, mbNo, mbAbort, mbRetry, mbIgnore);
  TMsgDlgButtons = set of TMsgDlgBtn;

const
  mbYesNoCancel = [mbYes, mbNo, mbCancel];
  mbYesNo = [mbYes, mbNo];
  mbOKCancel = [mbOK, mbCancel];
  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];

function MessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultBtn: TMsgDlgBtn = mbNone;
  Bitmap: TBitmap = nil): Integer; overload;
function MessageDlg(const Caption: WideString; const Msg: WideString;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
  DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer; overload;
function MessageDlg(const Caption: WideString; const Msg: WideString;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
  X, Y: Integer; DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer; overload;
function MessageDlg(const Caption: WideString; const Msg: WideString;
  DlgType: TMsgDlgType; Button1, Button2, Button3: TMsgDlgBtn; HelpCtx: Longint;
  X, Y: Integer; DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer; overload;

function MessageDlgPos(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer;

procedure ShowMessage(const Msg: WideString); overload;
procedure ShowMessage(const Msg: WideString; Params: array of const); overload;
procedure ShowMessageFmt(const Msg: WideString; Params: array of const);
procedure ShowMessagePos(const Msg: WideString; X, Y: Integer);

{ Input dialogs }

function InputBox(const ACaption, APrompt, ADefault: WideString): WideString; overload;
function InputBox(const ACaption, APrompt: WideString; ADefault: Integer;
  Min: Integer = Low(Integer); Max: Integer = High(Integer);
  Increment: Integer = 1): Integer; overload;
function InputBox(const ACaption, APrompt: WideString; ADefault: Double;
  Min: Double = Low(Integer); Max: Double = High(Integer);
  Decimals: Integer = 1): Double; overload;

function InputQuery(const ACaption, APrompt: WideString;
  var Value: WideString): Boolean; overload;
function InputQuery(const ACaption, APrompt: WideString;
  var Value: string): Boolean; overload;
function InputQuery(const ACaption, APrompt: WideString; var Value: Integer;
  Min: Integer = Low(Integer); Max: Integer = High(Integer);
  Increment: Integer = 1): Boolean; overload;
function InputQuery(const ACaption, APrompt: WideString; var Value: Double;
  Min: Double = Low(Integer); Max: Double = High(Integer);
  Decimals: Integer = 1): Boolean; overload;

function PromptForFileName(var AFileName: WideString; const AFilter: WideString = '';
  const ADefaultExt: WideString = ''; const ATitle: WideString = '';
  const AInitialDir: WideString = ''; SaveDialog: Boolean = False;
  Options: TOpenOptions = []): Boolean;

{$IFDEF LINUX}
function SelectDirectory(const Caption, Root: WideString;
  var Directory: WideString; ShowHidden: Boolean = False): Boolean;
{$ENDIF}
{$IFDEF MSWINDOWS}
function SelectDirectory(const Caption: string; const Root: WideString;
  out Directory: WideString): Boolean;
{$ENDIF}

procedure RegisterFilePreviewer(const Previewer: IFilePreviewer);
procedure UnregisterFilePreviewer(const Previewer: IFilePreviewer);

implementation

uses QConsts, QFileDialog {$IFDEF LINUX}, DirSel {$ENDIF};

{$R *.res}

var
  CustomColorCount: Integer;
  GFilePreviewers: TInterfaceList = nil;

type
  TOpenApplication = class(TApplication);

{$IFDEF LINUX}
function SelectDirectory(const Caption, Root: WideString;
  var Directory: WideString; ShowHidden: Boolean = False): Boolean;
var
  Dlg: TDirSelDlg;
  SaveDir: string;
begin
  Dlg := TDirSelDlg.Create(Application);
  try
    SaveDir := Directory;
    Result := Dlg.GetDirectory(Caption, Root, Directory, ShowHidden);
  finally
    Dlg.Free;
  end;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
type
  PTaskWindow = ^TTaskWindow;
  TTaskWindow = record
    Next: PTaskWindow;
    Window: HWnd;
  end;

var
  TaskActiveWindow: HWnd = 0;
  TaskFirstWindow: HWnd = 0;
  TaskFirstTopMost: HWnd = 0;
  TaskWindowList: PTaskWindow = nil;

function DoDisableWindow(Window: HWnd; Data: Longint): Bool; stdcall;
var
  P: PTaskWindow;
begin
  if (Window <> TaskActiveWindow) and IsWindowVisible(Window) and
    IsWindowEnabled(Window) then
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
    if IsWindow(P^.Window) then EnableWindow(P^.Window, True);
    WindowList := P^.Next;
    Dispose(P);
  end;
end;

function DisableTaskWindows(ActiveWindow: HWnd): Pointer;
var
  SaveActiveWindow: HWND;
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

var
  CreationControl: TQtDialog = nil;
  WndProcPtrAtom: TAtom = 0;
  InstancePtrAtom: TAtom = 0;

function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
type
  TDialogFunc = function(var DialogData): Bool stdcall;
var
  ActiveWindow: HWnd;
  WindowList: Pointer;
  FPUControlWord: Word;
  AtomText: array[0..31] of Char;
begin
  ActiveWindow := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
  WndProcPtrAtom := GlobalAddAtom(StrFmt(AtomText,
    'WndProcPtr%.8X%.8X', [HInstance, GetCurrentThreadID]));
  InstancePtrAtom := GlobalAddAtom(StrFmt(AtomText,
    'DlgInstancePtr%.8X%.8X', [HInstance, GetCurrentThreadID]));
  try
    asm
      // Avoid FPU control word change in NETRAP.dll, NETAPI32.dll, etc
      FNSTCW  FPUControlWord
    end;
    try
      Result := TDialogFunc(DialogFunc)(DialogData);
    finally
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
    end;
  finally
    if WndProcPtrAtom <> 0 then GlobalDeleteAtom(WndProcPtrAtom);
    if InstancePtrAtom <> 0 then GlobalDeleteAtom(WndProcPtrAtom);
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
  end;
end;

{ Open and Save dialog routines for Windows native dialog }

procedure GetFileNames(OpenDialog: TOpenDialog; var OpenFileName: TOpenFileName);
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
      OpenDialog.FFiles.Add(DirName)
    else
    begin
      if AnsiLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
          (FileName[2] <> ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        OpenDialog.FFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;
var
  FName: TFileName;
begin
  Separator := #0;
  with OpenFileName do
  begin
    if ofAllowMultiSelect in OpenDialog.FOptions then
    begin
      ExtractFileNames(lpstrFile);
      OpenDialog.FFileName := OpenDialog.FFiles[0];
    end else
    begin
      FName := OpenDialog.FFileName;
      ExtractFileName(lpstrFile, FName);
      OpenDialog.FFiles.Add(FName);
    end;
  end;
end;

function OpenWndProc(Wnd: HWND; Msg, WParam, LParam: Longint): Longint; stdcall;

  function StrRetToString(PIDL: PItemIDList; StrRet: TStrRet): string;
  var
    P: PChar;
  begin
    case StrRet.uType of
      STRRET_CSTR:
        SetString(Result, StrRet.cStr, lStrLen(StrRet.cStr));
      STRRET_OFFSET:
        begin
          P := @PIDL.mkid.abID[StrRet.uOffset - SizeOf(PIDL.mkid.cb)];
          SetString(Result, P, PIDL.mkid.cb - StrRet.uOffset);
        end;
      STRRET_WSTR:
        Result := StrRet.pOleStr;
    end;
  end;

  function CallDefWndProc: Longint;
  begin
    Result := CallWindowProc(Pointer(GetProp(Wnd,
      MakeIntAtom(WndProcPtrAtom))), Wnd, Msg, WParam, LParam);
  end;

var
  Instance: TOpenDialog;
  CanClose: Boolean;
  Include: Boolean;
  StrRet: TStrRet;
  Path: array[0..MAX_PATH] of Char;
  SR: TSearchRec;
  FileInfo: PFileInfo;
begin
  Result := 0;
  { If not ofOldStyleDialog then DoShow on CDN_INITDONE, not WM_INITDIALOG }
  if (Msg = WM_INITDIALOG) {and not (ofOldStyleDialog in Options) }then Exit;
  Instance := TOpenDialog(GetProp(Wnd, MakeIntAtom(InstancePtrAtom)));
  case Msg of
    WM_NOTIFY:
      case (POFNotify(LParam)^.hdr.code) of
        CDN_FILEOK:
          begin
            CanClose := True;
            GetFileNames(Instance, POFNotify(LParam)^.lpOFN^);
            Instance.CanClose(CanClose);
            Instance.FFiles.Clear;
            if not CanClose then
            begin
              Result := 1;
              SetWindowLong(Wnd, DWL_MSGRESULT, Result);//Wnd??
              Exit;
            end;
          end;
        CDN_INITDONE:
          Instance.DoShow;
        CDN_SELCHANGE:
          begin
            SendMessage(GetParent(Longint(Instance.FHandle)), CDM_GETFILEPATH,
              SizeOf(Path), Integer(@Path));
            if FindFirst(Path, faAnyFile, SR) = 0 then
            begin
              New(FileInfo);
              try
                FileInfo.SR := SR;
                Instance.FileSelected(FileInfo, True);
              finally
                Dispose(FileInfo);
              end;
              FindClose(SR);
            end;
          end;
        CDN_FOLDERCHANGE:
          begin
            SendMessage(GetParent(Longint(Instance.FHandle)), CDM_GETFOLDERPATH,
              SizeOf(Path), Integer(@Path));
            Instance.DirChanged(Path);
          end;
        CDN_INCLUDEITEM:
          if (LParam <> 0) and Assigned(Instance.OnFileAdd) then
          begin
            POFNotifyEx(LParam)^.psf.GetDisplayNameOf(POFNotifyEx(LParam)^.pidl, SHGDN_FORPARSING, StrRet);
            Include := Instance.FileAdd(StrRetToString(POFNotifyEx(LParam)^.pidl, StrRet), True, True, True);
            Result := Byte(Include);
            Exit;
          end;
      end;
    WM_NCDESTROY:
      begin
        Result := CallDefWndProc;
        Instance.FHandle := 0;
        RemoveProp(Wnd, MakeIntAtom(InstancePtrAtom));
        RemoveProp(Wnd, MakeIntAtom(WndProcPtrAtom));
        Exit;
      end;
  end;
  Result := CallDefWndProc;
end;

function OpenDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    SetProp(Wnd, MakeIntAtom(InstancePtrAtom), Longint(POpenFileName(LParam)^.lCustData));
    SetProp(Wnd, MakeIntAtom(WndProcPtrAtom), GetWindowLong(Wnd, GWL_WNDPROC));
    TOpenDialog(POpenFileName(LParam)^.lCustData).FHandle := Wnd;
    SetWindowLong(Wnd, GWL_WNDPROC, Longint(@OpenWndProc));
    Result := 1;
  end;
end;

function WinFileDialogExecute(Dialog: TOpenDialog; DlgFunc: Pointer; ODFlags: DWORD = 0): Boolean;
const
  MultiSelectBufferSize = High(Word) - 16;
  OpenOptions: array [TOpenOption] of DWORD = (
    OFN_FORCESHOWHIDDEN, OFN_OVERWRITEPROMPT, OFN_NOCHANGEDIR,
    OFN_ALLOWMULTISELECT, OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST,
    OFN_FILEMUSTEXIST, OFN_ENABLESIZING, OFN_SHOWHELP, OFN_HIDEREADONLY,
    0, 0, 0, 0, 0, 0);

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
  Option: TOpenOption;
  OpenFilename: TOpenFilename;
  TempFilename, TempExt: string;
  TempFilter: string;
  ATitle: string;
  FileNameAsStr: string;
begin
  Dialog.FFiles.Clear;
  FillChar(OpenFileName, SizeOf(OpenFileName), 0);
  with OpenFilename do
  begin
    if (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT) or { Win2k }
    ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion >= 4) and (Win32MinorVersion >= 90)) then { WinME }
      lStructSize := SizeOf(TOpenFilename)
    else
      lStructSize := SizeOf(TOpenFilename) - (SizeOf(DWORD) shl 1) - SizeOf(Pointer); { subtract size of added fields }

    hInstance := SysInit.HInstance;
    TempFilter := AllocFilterStr(Dialog.Filter);
    lpstrFilter := PChar(TempFilter);
    nFilterIndex := Dialog.FilterIndex;  
    if ofAllowMultiSelect in Dialog.Options then
      nMaxFile := MultiSelectBufferSize else
      nMaxFile := MAX_PATH;
    SetLength(TempFilename, nMaxFile + 2);
    lpstrFile := PChar(TempFilename);
    FillChar(lpstrFile^, nMaxFile + 2, 0);
    FileNameAsStr := Dialog.Filename; { Convert the WideString to an AnsiString }
    StrLCopy(lpstrFile, PChar(FileNameAsStr), nMaxFile);
    if (Dialog.InitialDir = '') then
      lpstrInitialDir := '.'
    else
      lpstrInitialDir := PChar(Dialog.InitialDir);
    ATitle := Dialog.Title;
    lpstrTitle := PChar(ATitle);
    if ODFlags = 0 then
    begin
      Flags := OFN_NOREADONLYRETURN;
      for Option := Low(Option) to High(Option) do
        if Option in Dialog.Options then
          Flags := Flags or OpenOptions[Option];
    end
    else
      Flags := ODFlags;
    Flags := Flags or OFN_ENABLEHOOK or OFN_ENABLEINCLUDENOTIFY or OFN_EXPLORER;
    TempExt := Dialog.DefaultExt;
    if (TempExt = '') and (Flags and OFN_EXPLORER = 0) then
    begin
      TempExt := ExtractFileExt(Dialog.Filename);
      Delete(TempExt, 1, 1);
    end;
    if TempExt <> '' then lpstrDefExt := PChar(TempExt);
    lCustData := Integer(Dialog);
    lpfnHook := OpenDialogHook;
    hWndOwner := GetActiveWindow;
    Result := TaskModalDialog(DlgFunc, OpenFileName);
    if Result then
    begin
      GetFileNames(Dialog, OpenFilename);
      if (Flags and OFN_EXTENSIONDIFFERENT) <> 0 then
        Include(Dialog.FOptions, ofExtensionDifferent) else
        Exclude(Dialog.FOptions, ofExtensionDifferent);
      Dialog.FFilterIndex := nFilterIndex;
    end;
  end;
end;

{ Font dialog routine for Windows native dialog }

function WinFontDialogExecute(FontDialog: TFontDialog; FDFlags: DWORD = 0): Boolean;
var
  FontCharSetModified: Boolean;

  procedure UpdateFromLogFont(const LogFont: TLogFont);
  var
    Style: TFontStyles;
  begin
    with LogFont do
    begin
      FontDialog.Font.Name := LogFont.lfFaceName;
      FontDialog.Font.Height := LogFont.lfHeight;
      if FontCharsetModified then
        FontDialog.Font.Charset := TFontCharset(LogFont.lfCharSet);
      Style := [];
      with LogFont do
      begin
        if lfWeight > FW_REGULAR then Include(Style, fsBold);
        if lfItalic <> 0 then Include(Style, fsItalic);
        if lfUnderline <> 0 then Include(Style, fsUnderline);
        if lfStrikeOut <> 0 then Include(Style, fsStrikeOut);
      end;
      FontDialog.Font.Style := Style;
    end;
  end;

var
  ChooseFontRec: TChooseFont;
  LogFont: TLogFont;
  OriginalFaceName: string;
begin
  with ChooseFontRec do
  begin
    lStructSize := SizeOf(ChooseFontRec);
    hDC := 0;
    lpLogFont := @LogFont;
    GetObject(QFont_handle(FontDialog.Font.Handle), SizeOf(LogFont), @LogFont);
    OriginalFaceName := LogFont.lfFaceName;
    if FDFlags = 0 then
      Flags := CF_BOTH or CF_EFFECTS
    else
      Flags := FDFlags;
    Flags := Flags or CF_INITTOLOGFONTSTRUCT;
    rgbColors := FontDialog.Font.Color;
    lCustData := 0;
    lpfnHook := nil;
    hWndOwner := GetActiveWindow;
    Result := TaskModalDialog(@ChooseFont, ChooseFontRec);
    if Result then
    begin
      if AnsiCompareText(OriginalFaceName, LogFont.lfFaceName) <> 0 then
        FontCharsetModified := True;
      UpdateFromLogFont(LogFont);
      FontDialog.Font.Color := rgbColors;
    end;
  end;
end;

function WinColorDialogExecute(ColorDialog: TColorDialog; CDFlags: DWORD = 0): Boolean;
var
  ChooseColorRec: TChooseColor;
  CustomColorsArray: TCustomColors;

const
  ColorPrefix = 'Color';

  procedure GetCustomColorsArray;
  var
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
      ColorDialog.CustomColors.Values[ColorPrefix + Char(Ord('A') + I)] :=
        Format('%.6x', [CustomColorsArray[I]]);
  end;

  procedure SetCustomColorsArray;
  var
    Value: string;
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
    begin
      Value := ColorDialog.CustomColors.Values[ColorPrefix + Char(Ord('A') + I)];
      if Value <> '' then
        CustomColorsArray[I] := StrToInt('$' + Value) else
        CustomColorsArray[I] := -1;
    end;
  end;

begin
  FillChar(ChooseColorRec, SizeOf(ChooseColorRec), 0);
  with ChooseColorRec do
  begin
    SetCustomColorsArray;
    lStructSize := SizeOf(ChooseColorRec);
    hInstance := SysInit.HInstance;
    rgbResult := ColorToRGB(ColorDialog.Color);
    lpCustColors := @CustomColorsArray;
    if CDFlags = 0 then
      Flags := CC_FULLOPEN or CC_ANYCOLOR
    else
      Flags := CDFlags;
    Flags := Flags or CC_RGBINIT;
    hWndOwner := GetActiveWindow;
    Result := TaskModalDialog(@ChooseColor, ChooseColorRec);
    if Result then
    begin
      ColorDialog.Color := rgbResult;
      GetCustomColorsArray;
    end;
  end;
end;

function SelectDirectory(const Caption: string; const Root: WideString;
  out Directory: WideString): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
  ActiveWindow: HWND;
begin
  Result := False;
  Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then
      begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(0, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do
      begin
        hwndOwner := 0;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
      end;
      ActiveWindow := GetActiveWindow;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
        SetActiveWindow(ActiveWindow);
      end;
      Result :=  ItemIDList <> nil;
      if Result then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;
{$ENDIF}


function MessageDlg(const Caption: WideString; const Msg: WideString;
  DlgType: TMsgDlgType; Button1, Button2, Button3: TMsgDlgBtn; HelpCtx: Longint;
  X, Y: Integer; DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer; overload;
const
  ConfirmResName = 'MSGDLG_CONFIRM';
  MessageBox_DefaultMask = $100;
  MessageBox_EscapeMask = $200;
var
  MB: QMessageBoxH;
  I: Integer;
  Btns: array[0..2] of Integer;
  CaptureControl: TControl;
  Title: WideString;
  FreeBitmap: Boolean;
  DlgParent: QWidgetH;
  DlgLabel: QLabelH;
{$IFDEF LINUX}
  SigQuitStatus,
  SigIntStatus: TSignalState;
{$ENDIF}
begin
  Result := -1;
  if Application.Terminated then
    Exit;

  FreeBitmap := (Bitmap = nil) and (DlgType = mtConfirmation);
  case DlgType of
    mtCustom: Title := Caption;
    mtInformation: Title := SMsgDlgInformation;
    mtError: Title := SMsgDlgError;
    mtWarning: Title := SMsgDlgWarning;
    mtConfirmation:
      begin
        Title := SMsgDlgConfirm;
        if Bitmap = nil then
        begin
          Bitmap := TBitmap.Create;
          Bitmap.LoadFromResourceName(hInstance, ConfirmResName);
        end;
      end;
  end;

  if DefaultBtn = mbNone then DefaultBtn := Button1;

  I := 0;
  FillChar(Btns, SizeOf(Btns), Ord(mbNone));
  if Button1 <> mbNone then
  begin
    Btns[I] := Ord(Button1);
    if DefaultBtn = Button1 then
      Btns[I] := Btns[I] or MessageBox_DefaultMask;
    Inc(I);
  end;
  if Button2 <> mbNone then
  begin
    Btns[I] := Ord(Button2);
    if DefaultBtn = Button2 then
      Btns[I] := Btns[I] or MessageBox_DefaultMask;
    Inc(I);
  end;
  if Button3 <> mbNone then
  begin
    Btns[I] := Ord(Button3);
    if DefaultBtn = Button3 then
      Btns[I] := Btns[I] or MessageBox_DefaultMask;
  end;

  if DlgType = mtConfirmation then
  begin
    DlgType := mtCustom;
    Bitmap.Transparent := True;
  end;

  DlgParent := QApplication_activeWindow(Application.Handle);
  if DlgParent = nil then
    if (Screen.ActiveCustomForm <> nil) and Screen.ActiveCustomForm.HandleAllocated then
      DlgParent := Screen.ActiveCustomForm.Handle
    else
      DlgParent := TOpenApplication(Application).AppWidget;
  MB := QMessageBox_create(PWideString(@Title), PWideString(@Msg),
    QMessageBoxIcon(DlgType), Btns[0], Btns[1], Btns[2], DlgParent, nil, True, WFlags(WidgetFlags_WStyle_StaysOnTop));

  try
    if Bitmap <> nil then
      QMessageBox_setIconPixmap(MB, Bitmap.Handle);
    if (X >= 0) and (Y >= 0) then QDialog_move(MB, X, Y);

    //force wordbreak alignment of dialog label.
    DlgLabel := QLabelH(QObject_child(MB, 'text', nil));  //do not localize
    if DlgLabel <> nil then
      QLabel_setAlignment(DlgLabel, QLabel_alignment(DlgLabel)
        or Integer(AlignmentFlags_WordBreak));

    CaptureControl := GetCaptureControl;
    try
      SetCaptureControl(nil);
      QForms.Application.ModalStarted(nil);
      try
{$IFDEF LINUX}
        SigIntStatus := InquireSignal(RTL_SIGINT);
        SigQuitStatus := InquireSignal(RTL_SIGQUIT);
        if SigIntStatus = ssHooked then
          UnhookSignal(RTL_SIGINT);
        if SigQuitStatus = ssHooked then
          UnhookSignal(RTL_SIGQUIT);
        try
{$ENDIF}
          try
            Result := QDialog_exec(MB);
          except
            Application.HandleException(DlgParent);
          end;
{$IFDEF LINUX}
        finally
          if SigIntStatus = ssHooked then
            HookSignal(RTL_SIGINT);
          if SigQuitStatus = ssHooked then
            HookSignal(RTL_SIGQUIT);
        end;
{$ENDIF}
      finally
        QForms.Application.ModalFinished(nil);
      end;
    finally
      SetCaptureControl(CaptureControl);
      QWidget_setActiveWindow(DlgParent);
    end;
  finally
    QMessageBox_destroy(MB);
    if FreeBitmap then Bitmap.Free;
  end;
end;

function MessageDlg(const Caption: WideString; const Msg: WideString;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
  X, Y: Integer; DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer; overload;
var
  Btns: array[0..2] of TMsgDlgBtn;
  B: TMsgDlgBtn;
  I: Integer;
begin
  { Button order is hard-coded in Windows. We follow their conventions here. }
  if Buttons = mbYesNoCancel then
  begin
    Btns[0] := mbYes;
    Btns[1] := mbNo;
    Btns[2] := mbCancel;
  end
  else
  if Buttons = mbYesNo then
  begin
    Btns[0] := mbYes;
    Btns[1] := mbNo;
    Btns[2] := mbNone;
  end
  else
  if Buttons = mbOkCancel then
  begin
    Btns[0] := mbOk;
    Btns[1] := mbCancel;
    Btns[2] := mbNone;
  end
  else
  if Buttons = mbAbortRetryIgnore then
  begin
    Btns[0] := mbAbort;
    Btns[1] := mbRetry;
    Btns[2] := mbIgnore;
  end
  else
  begin
    I := 0;
    FillChar(Btns, SizeOf(Btns), Ord(mbNone));

    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if (B in Buttons) and (B <> mbNone) then
      begin
        if I > High(Btns) then
          raise EInvalidOperation.CreateRes(@STooManyMessageBoxButtons);

        Btns[I] := B;
        Inc(I);
      end;
  end;

  Result := MessageDlg(Caption, Msg, DlgType, Btns[0], Btns[1], Btns[2],
    HelpCtx, X, Y, DefaultBtn, Bitmap);
end;

function MessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultBtn: TMsgDlgBtn = mbNone;
  Bitmap: TBitmap = nil): Integer;
begin
  Result := MessageDlg(Application.Title, Msg, DlgType, Buttons, HelpCtx, -1,
    -1, DefaultBtn, Bitmap);
end;

function MessageDlg(const Caption: WideString; const Msg: WideString;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
  DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer;
begin
  Result := MessageDlg(Caption, Msg, DlgType, Buttons, HelpCtx, -1, -1,
    DefaultBtn, Bitmap);
end;

function MessageDlgPos(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultBtn: TMsgDlgBtn = mbNone; Bitmap: TBitmap = nil): Integer;
begin
  Result := MessageDlg(Application.Title, Msg, DlgType, Buttons, HelpCtx,
    X, Y, DefaultBtn, Bitmap);
end;

procedure ShowMessage(const Msg: WideString);
begin
  MessageDlg(Msg, mtCustom, [mbOk], 0);
end;

procedure ShowMessage(const Msg: WideString; Params: array of const);
begin
  ShowMessageFmt(Msg, Params);
end;

procedure ShowMessageFmt(const Msg: WideString; Params: array of const);
begin
  ShowMessage(Format(Msg, Params));
end;

procedure ShowMessagePos(const Msg: WideString; X, Y: Integer);
begin
  MessageDlg(Application.Title, Msg, mtCustom, [mbOk], 0, X, Y);
end;

function InputQuery(const ACaption, APrompt: WideString;
  var Value: WideString): Boolean;
var
  RetVal: WideString;
  CaptureControl: TControl;
{$IFDEF LINUX}
  SigIntStatus,
  SigQuitStatus: TSignalState;
{$ENDIF}
begin
  CaptureControl := GetCaptureControl;
  try
    SetCaptureControl(nil);
    QForms.Application.ModalStarted(nil);
    try
{$IFDEF LINUX}
      SigIntStatus := InquireSignal(RTL_SIGINT);
      SigQuitStatus := InquireSignal(RTL_SIGQUIT);
      if SigIntStatus = ssHooked then
        UnhookSignal(RTL_SIGINT);
      if SigQuitStatus = ssHooked then
        UnhookSignal(RTL_SIGQUIT);
      try
{$ENDIF}
        QInputDialog_getText(PWideString(@RetVal), PWideString(@ACaption),
          PWideString(@APrompt), PWideString(@Value), @Result, nil, nil);
{$IFDEF LINUX}
      finally
        if SigIntStatus = ssHooked then
          HookSignal(RTL_SIGINT);
        if SigQuitStatus = ssHooked then
          HookSignal(RTL_SIGQUIT);
      end;
{$ENDIF}
      if Result then Value := RetVal;
    finally
      QForms.Application.ModalFinished(nil);
    end;
  finally
    SetCaptureControl(CaptureControl);
  end;
end;

function InputQuery(const ACaption, APrompt: WideString;
  var Value: string): Boolean;
var
  WValue: WideString;
begin
  WValue := Value;
  Result := InputQuery(ACaption, APrompt, WValue);
  if Result then Value := WValue;
end;

function InputQuery(const ACaption, APrompt: WideString; var Value: Integer;
  Min: Integer = Low(Integer); Max: Integer = High(Integer);
  Increment: Integer = 1): Boolean;
var
  RetVal: Integer;
  CaptureControl: TControl;
{$IFDEF LINUX}
  SigIntStatus,
  SigQuitStatus: TSignalState;
{$ENDIF}
begin
  CaptureControl := GetCaptureControl;
  try
    SetCaptureControl(nil);
    QForms.Application.ModalStarted(nil);
    try
{$IFDEF LINUX}
      SigIntStatus := InquireSignal(RTL_SIGINT);
      SigQuitStatus := InquireSignal(RTL_SIGQUIT);
      if SigIntStatus = ssHooked then
        UnhookSignal(RTL_SIGINT);
      if SigQuitStatus = ssHooked then
        UnhookSignal(RTL_SIGQUIT);
      try
{$ENDIF}
        RetVal := QInputDialog_getInteger(PWideString(@ACaption),
          PWideString(@APrompt), Value, Min, Max, Increment, @Result, nil, nil);
{$IFDEF LINUX}
      finally
        if SigIntStatus = ssHooked then
          HookSignal(RTL_SIGINT);
        if SigQuitStatus = ssHooked then
          HookSignal(RTL_SIGQUIT);
      end;
{$ENDIF}
      if Result then Value := RetVal;
    finally
      QForms.Application.ModalFinished(nil);
    end;
  finally
    SetCaptureControl(CaptureControl);
  end;
end;

function InputQuery(const ACaption, APrompt: WideString; var Value: Double;
  Min: Double = Low(Integer); Max: Double = High(Integer);
  Decimals: Integer = 1): Boolean;
var
  RetVal: Double;
  CaptureControl: TControl;
{$IFDEF LINUX}
  SigIntStatus,
  SigQuitStatus: TSignalState;
{$ENDIF}
begin
  CaptureControl := GetCaptureControl;
  try
    SetCaptureControl(nil);
    QForms.Application.ModalStarted(nil);
    try
{$IFDEF LINUX}
      SigIntStatus := InquireSignal(RTL_SIGINT);
      SigQuitStatus := InquireSignal(RTL_SIGQUIT);
      if SigIntStatus = ssHooked then
        UnhookSignal(RTL_SIGINT);
      if SigQuitStatus = ssHooked then
        UnhookSignal(RTL_SIGQUIT);
      try
{$ENDIF}
        RetVal := QInputDialog_getDouble(PWideString(@ACaption), PWideString(@APrompt),
          Value, Min, Max, Decimals, @Result, nil, nil);
{$IFDEF LINUX}
      finally
        if SigIntStatus = ssHooked then
          HookSignal(RTL_SIGINT);
        if SigQuitStatus = ssHooked then
          HookSignal(RTL_SIGQUIT);
      end;
{$ENDIF}
      if Result then Value := RetVal;
    finally
      QForms.Application.ModalFinished(nil);
    end;
  finally
    SetCaptureControl(CaptureControl);
  end;
end;

function InputBox(const ACaption, APrompt, ADefault: WideString): WideString;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result);
end;

function InputBox(const ACaption, APrompt: WideString; ADefault: Integer;
  Min: Integer = Low(Integer); Max: Integer = High(Integer);
  Increment: Integer = 1): Integer;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result, Min, Max, Increment);
end;

function InputBox(const ACaption, APrompt: WideString; ADefault: Double;
  Min: Double = Low(Integer); Max: Double = High(Integer);
  Decimals: Integer = 1): Double;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result, Min, Max, Decimals);
end;

function PromptForFileName(var AFileName: WideString; const AFilter: WideString = '';
  const ADefaultExt: WideString = ''; const ATitle: WideString = '';
  const AInitialDir: WideString = ''; SaveDialog: Boolean = False;
  Options: TOpenOptions = []): Boolean;
var
  Dialog: TOpenDialog;
begin
  if SaveDialog then
    Dialog := TSaveDialog.Create(nil)
  else
    Dialog := TOpenDialog.Create(nil);
  if Options <> [] then
      Dialog.Options := Options
  else
    if SaveDialog then
      Dialog.Options := Dialog.Options + [ofOverwritePrompt];

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

{ TPreviewThread }

constructor TPreviewThread.Create(const Filename: WideString;
  ProgressEvent: TProgressEvent; Canvas: TCanvas; Rect: TRect);
begin
  FCanvas := Canvas;
  FProgress := ProgressEvent;
  FFilename := Filename;
  FRect := Rect;
  inherited Create(False);
end;

procedure TPreviewThread.DoProgress;
begin
  if Terminated then Exit;
  if FRedrawNow then
    Draw;
  FProgress(Self, FStage, FPercent, FRedrawNow, FRect, FMessage, FContinue);
end;

procedure TPreviewThread.Execute;
begin
  // override
end;

procedure TPreviewThread.UpdateProgress(Sender: TObject;
  Stage: TProgressStage; PercentDone: Byte; RedrawNow: Boolean;
  const R: TRect; const Msg: WideString; var Continue: Boolean);
begin
  FPercent := PercentDone;
  FStage := Stage;
  FRedrawNow := RedrawNow;
  FMessage := Msg;
  FContinue := Continue;
  if not Terminated then
    Synchronize(DoProgress);
end;

{ TGraphicThread }

constructor TGraphicThread.Create(const Filename: WideString;
  ProgressEvent: TProgressEvent; Canvas: TCanvas; Rect: TRect);
begin
  FImage := TBitmap.Create;
  inherited Create(Filename, ProgressEvent, Canvas, Rect);
  FImage.OnProgress := ImageProgress;
end;

destructor TGraphicThread.Destroy;
begin
  inherited Destroy;
  if Assigned(FImage) then
    FImage.Free;
end;

procedure TGraphicThread.Draw;
var
  H, W: Integer;
  HScale, WScale, Scale: Single;
  R: TRect;
begin
  WScale := (FRect.Right - FRect.Left) / FImage.Width;
  HScale := (FRect.Bottom - FRect.Top) / FImage.Height;
  if (HScale < 1) or (WScale < 1) then
  begin
    if HScale < WScale then
      Scale := HScale
    else
      Scale := WScale;
  end else
    Scale := 1;
  H := Round(FImage.Height * Scale);
  W := Round(FImage.Width * Scale);
  R.Top := (FRect.Bottom - FRect.Top - H) div 2;
  R.Left := (FRect.Right - FRect.Left - W) div 2;
  R.Bottom := R.Top + H;
  R.Right := R.Left + W;
  Canvas.StretchDraw(R, FImage);
end;

procedure TGraphicThread.Execute;
var
  Icon: TIcon;
begin
  try
    if AnsiLowerCase(ExtractFileExt(Filename)) = '.ico' then
    begin
      Icon := TIcon.Create;
      try
        Icon.LoadFromFile(Filename);
        FImage.Assign(Icon);
      finally
        Icon.Free;
      end;  
    end else
      FImage.LoadFromFile(Filename);
    FRedrawNow := True;
    FPercent := 100;
    FStage := psEnding;
    if not Terminated then
      Synchronize(DoProgress);
  except
    on EInvalidGraphicOperation do
    //squelch
  end;
end;

procedure TGraphicThread.ImageProgress(Sender: TObject;
  Stage: TProgressStage; PercentDone: Byte; RedrawNow: Boolean;
  const R: TRect; const Msg: WideString; var Continue: Boolean);
var
  AMessage: WideString;
begin
  if Stage = psRunning then
    AMessage := SLoadingEllipsis;
  UpdateProgress(Self, Stage, PercentDone, Stage = psEnding, R,
    AMessage, Continue);
  Continue := Continue and not Terminated;
end;

{ TThreadedPreviewer }

function TThreadedPreviewer.CanPreview(const Filename: string): Boolean;
begin
  Result := False;
end;

procedure TThreadedPreviewer.GetPreviewSize(Filename: string; Canvas: TCanvas;
  var Size: TSize);
begin
  // accept default.
end;

procedure TThreadedPreviewer.Preview(const Filename: string; Canvas: TCanvas;
  const Rect: TRect; Progress: TProgressEvent);
begin
  if FFilename <> Filename then
  begin
    FFilename := Filename;
    FThread := ThreadClass.Create(Filename, Progress, Canvas, Rect);
  end;
end;

procedure TThreadedPreviewer.StopPreview;
begin
  if Assigned(FThread) then
    FreeAndNil(FThread);
  FFilename := '';
end;

function TThreadedPreviewer.ThreadClass: TPreviewThreadClass;
begin
  Result := TPreviewThread;
end;

{ TGraphicPreviewer }

function TGraphicPreviewer.CanPreview(const Filename: string): Boolean;
var
  Formats: TFileFormatsList;
  Ext: string;
begin
  Formats := GetFileFormats;
  Ext := ExtractFileExt(Filename);
  if (Length(Ext) > 0) and (Ext[1] = '.') then
    Delete(Ext, 1, 1);
  Result := Formats.FindExt(Ext) <> nil;
end;

function TGraphicPreviewer.ThreadClass: TPreviewThreadClass;
begin
  Result := TGraphicThread;
end;

function FilePreviewers: TInterfaceList;
begin
  if not Assigned(GFilePreviewers) then
    GFilePreviewers := TInterfaceList.Create;
  Result := GFilePreviewers;
end;

procedure RegisterFilePreviewer(const Previewer: IFilePreviewer);
begin
  FilePreviewers.Insert(0, Previewer);
end;

procedure UnregisterFilePreviewer(const Previewer: IFilePreviewer);
var
  Index: Integer;
begin
  Index := FilePreviewers.IndexOf(Previewer);
  if (Index >= 0) and (Index < FilePreviewers.Count) then
    FilePreviewers.Delete(Index);
end;

{ TDialog }

constructor TDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModal := True;
end;

procedure TDialog.DoClose;
begin
  FWidth := Width;
  FHeight := Height;
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

function TDialog.Execute: Boolean;
var
  ALeft, ATop, AWidth, AHeight: Integer;
  GrabControl: TControl;
begin
  GrabControl := GetMouseGrabControl;
  try
    SetMouseGrabControl(nil);
    { accept defaults if necessary. }
    if not (sfLeft in FScaleFlags) then ALeft := GetPosition.X else ALeft := FPosition.X;
    if not (sfTop in FScaleFlags) then ATop := GetPosition.Y else ATop := FPosition.Y;
    if not (sfWidth in FScaleFlags) then AWidth := GetWidth else AWidth := FWidth;
    if not (sfHeight in FScaleFlags) then AHeight := GetHeight else AHeight := FHeight;
    SetBounds(ALeft, ATop, AWidth, AHeight);
    Result := DoExecute;
  finally
    SetMouseGrabControl(GrabControl);
  end;
end;

function TDialog.GetHeight: Integer;
begin
  Result := GetBounds.Bottom;
end;

function TDialog.GetPosition: TPoint;
begin
  Result.X := GetBounds.Left;
  Result.Y := GetBounds.Top;
end;

function TDialog.GetWidth: Integer;
begin
  Result := GetBounds.Right;
end;

procedure TDialog.SetHeight(const Value: Integer);
begin
  if GetWidth = Value then Exit;
  SetBounds(Position.X, Position.Y, Width, Value);
  Include(FScaleFlags, sfHeight);
end;

procedure TDialog.SetPosition(const Value: TPoint);
begin
  SetBounds(Value.X, Value.Y, Width, Height);
  Include(FScaleFlags, sfLeft);
  Include(FScaleFlags, sfTop);
end;

procedure TDialog.SetTitle(const Value: WideString);
begin
  FTitle := Value;
end;

procedure TDialog.SetWidth(const Value: Integer);
begin
  if GetWidth = Value then Exit;
  SetBounds(Position.X, Position.Y, Value, Height);
  Include(FScaleFlags, sfWidth);
end;

{ TQtDialog }

function TQtDialog.AppEventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  Result := False;
  try
    Result := (QEvent_type(Event) = QEventType_KeyPress)
      and (QKeyEvent_key(QKeyEventH(Event)) = Application.HelpKey) and
      (QWidget_topLevelWidget(QWidgetH(Sender)) = Handle);
    if Result then InvokeHelp;
  except
    Application.HandleException(Self);
  end;
end;

constructor TQtDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModal := True;
  FShowing := False;
{$IFDEF MSWINDOWS}
  FUseNative := True;
{$ENDIF}
end;

procedure TQtDialog.CreateHandle;
begin
{$IFDEF MSWINDOWS}
  if UseNativeDialog then Exit;
{$ENDIF}
  if FHandle = nil then
  begin
    CreateWidget;
    InitWidget;
    HookEvents;
    if (FHandle = nil) then
      raise EQtDialogException.CreateResFmt(@SInvalidCreateWidget, [ClassName]);
    QClxObjectMap_add(QWidgetH(FHandle), Integer(Self));
  end;
end;

procedure TQtDialog.CreateWidget;
begin
  FHandle := QDialog_create(nil, nil, FModal, WidgetFlags);
  FHooks := QWidget_hook_create(FHandle);
end;

procedure TQtDialog.DestroyedHook;
begin
  try
    QClxObjectMap_remove(FHandle);
    FHandle := nil;
    QObject_hook_destroy(FHooks);
    FHooks := nil;
    Application.EnableQtAccelerators := False;
  except
    Application.HandleException(Self);
  end;
end;

function TQtDialog.DoExecute: Boolean;
begin
  QDialog_show(Handle);
  if FModal then
  begin
    try
      Result := QDialog_result(Handle) = Integer(QDialogDialogCode_Accepted);
    finally
      QDialog_destroy(Handle);
    end;
  end
  else
    Result := True;
end;

function TQtDialog.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  try
    Result := False;
    case QEvent_type(Event) of
      QEventType_WindowActivate:
        { for modeless Qt dialogs}
        Application.EnableQtAccelerators := True;
      QEventType_WindowDeactivate:
        { for modeless Qt dialogs}
        Application.EnableQtAccelerators := False;
      QEventType_Show:
        begin
          Application.EnableQtAccelerators := True;
          FShowing := True;
          DoShow;
        end;
      QEventType_Hide:
        begin
          Application.EnableQtAccelerators := False;
          DoClose;
          FShowing := False;
        end;
    end;
  except
    Application.HandleException(Self);
    Result := False;
  end;
end;

function TQtDialog.GetHandle: QDialogH;
begin
{$IFDEF MSWINDOWS}
  if not UseNativeDialog then
{$ENDIF}
  HandleNeeded;
  Result := FHandle;
end;

function TQtDialog.GetHooks: QObject_hookH;
begin
  HandleNeeded;
  Result := FHooks;
end;

function TQtDialog.HandleAllocated: Boolean;
begin
  Result := FHandle <> nil;
end;

procedure TQtDialog.HandleNeeded;
begin
  if FHandle = nil then CreateHandle;
end;

procedure TQtDialog.HookEvents;
var
   Method: TMethod;
begin
  if FHooks = nil then
  begin
    Assert(FHandle <> nil);
    FHooks := QObject_hook_create(Handle);
  end;

  TEventFilterMethod(Method) := EventFilter;
  Qt_hook_hook_events(FHooks, Method);

  QObject_destroyed_event(Method) := Self.DestroyedHook;
  QObject_hook_hook_destroyed(FHooks, Method);
end;

procedure TQtDialog.InitWidget;
begin
  Application.EnableQtAccelerators := True;
end;

procedure TQtDialog.InvokeHelp;
begin
  case HelpType of
    htKeyword:
      Application.KeywordHelp(HelpKeyword);
    htContext:
      Application.ContextHelp(HelpContext);
  end;
end;

procedure TQtDialog.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if not (csDesigning in ComponentState) and HandleAllocated then
  begin
    QWidget_move(Handle, ALeft, ATop);
    QWidget_resize(Handle, AWidth, AHeight);
  end;
  FPosition.X := ALeft;
  FPosition.Y := ATop;
  FWidth := AWidth;
  FHeight := AHeight;
end;

procedure TQtDialog.SetTitle(const Value: WideString);
begin
  inherited;
  if {$IFDEF MSWINDOWS} not UseNativeDialog and {$ENDIF} HandleAllocated then
    QWidget_setCaption(Handle, PWideString(@FTitle));
end;

function TQtDialog.WidgetFlags: Integer;
begin
  Result := Integer(WidgetFlags_WStyle_DialogBorder) or
    Integer(WidgetFlags_WStyle_Title) or
    Integer(WidgetFlags_WStyle_Customize) or
    Integer(WidgetFlags_WStyle_SysMenu) or
    Integer(WidgetFlags_WStyle_ContextHelp);
end;

procedure TQtDialog.DestroyWidget;
begin
  if FHandle <> nil then QObject_destroy(FHandle);
  FHandle := nil;
end;

destructor TQtDialog.Destroy;
begin
  if FHandle <> nil then
  begin
    DestroyWidget;
    FHandle := nil;
  end;
  inherited Destroy;
end;

function TQtDialog.GetBounds: TRect;
begin
  if HandleAllocated {$IFDEF MSWINDOWS} and not UseNativeDialog {$ENDIF} then
  begin
    QWidget_geometry(Handle, @Result);
    Result.Right := Result.Right - Result.Left;
    Result.Bottom := Result.Bottom - Result.Top;
  end
  else
    Result := Rect(FPosition.X, FPosition.Y, FWidth, FHeight);
end;

procedure TQtDialog.DoShow;
begin
{$IFDEF MSWINDOWS}
  if not UseNativeDialog then
{$ENDIF}
  QWidget_setCaption(Handle, PWideString(@FTitle));
  inherited;
end;

{$IFDEF MSWINDOWS}
function TQtDialog.NativeExecute(Flags: Integer): Boolean;
begin
  Result := False;
end;
{$ENDIF}

function TQtDialog.Execute: Boolean;
var
  AppHook: QObject_hookH;
  Method: TMethod;
{$IFDEF MSWINDOWS}
  GrabControl: TControl;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if UseNativeDialog then
  begin
    GrabControl := GetMouseGrabControl;
    try
      SetMouseGrabControl(nil);
      Result := NativeExecute(FNativeFlags);
    finally
      SetMouseGrabControl(GrabControl);
    end;
  end
  else
{$ENDIF}
  if FShowing then
  begin
    QWidget_raise(Handle);
    Result := True;
  end
  else
  begin
    Application.ModalStarted(Self);
    try
      HandleNeeded;
      AppHook := QObject_Hook_create(Application.Handle);
      try
        TEventFilterMethod(Method) := AppEventFilter;
        Qt_hook_hook_events(AppHook, Method);
        Result := inherited Execute;
      finally
        QObject_hook_destroy(AppHook);
        if FModal then DestroyWidget;
      end;
    finally
      Application.ModalFinished(Self);
    end;
  end;
end;

{ TOpenDialog }

constructor TOpenDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFiles := TStringList.Create;
  Modal := True;
  FSaveDlg := False;
  FOptions := [ofHideReadOnly, ofEnableSizing];
{$IFDEF MSWINDOWS}
  FUseNative := True;
{$ENDIF}
end;

function TOpenDialog.CreateForm: TDialogForm;
begin
  if Form = nil then
  begin
    if not Assigned(FileDialogFormClass) then
      FileDialogFormClass := QFileDialog.TFileDialogForm;
    Result := FileDialogFormClass.Create(Self);
  end
  else
    Result := Form;
end;

destructor TOpenDialog.Destroy;
begin
  FFiles.Free;
  inherited Destroy;
end;

procedure TOpenDialog.DirChanged(NewDir: WideString);
begin
  if Assigned(FOnFolderChange) then
    FOnFolderChange(Self, NewDir);
end;

function TOpenDialog.DoExecute: Boolean;
var
  I: Integer;
begin
  SetOptions;
  Result := inherited DoExecute;
  for I := 0 to FilePreviewers.Count - 1 do
    IFilePreviewer(FilePreviewers[I]).StopPreview;
  RetrieveOptions(Result);
  FPosition := Point(FForm.Left, FForm.Top);
  FWidth := FForm.Width;
  FHeight := FForm.Height;
  FScaleFlags := [sfLeft, sfTop, sfWidth, sfHeight];
  FForm.Free;
  FForm := nil;
end;

procedure TOpenDialog.FilterChanged(Index: Integer);
begin
  if Assigned(FOnFilterChange) then
    FOnFilterChange(Self, Index);
end;

{$IFDEF MSWINDOWS}
function TOpenDialog.NativeExecute(Flags: Integer): Boolean;
begin
  Result := WinFileDialogExecute(Self, @GetOpenFileName, Flags);
end;
{$ENDIF}

procedure TOpenDialog.Refresh;
begin

end;

procedure TOpenDialog.RetrieveOptions(Accepted: Boolean);
begin
  if Accepted then
  begin
    if not (ofNoChangeDir in FOptions) then
      FSaveDir := ExtractFilePath(FFilename);
    SetCurrentDir(FSaveDir);
  end;
  Exclude(FOptions, ofReadOnly);
  Exclude(FOptions, ofViewDetail);
  Exclude(FOptions, ofViewIcon);
  Exclude(FOptions, ofViewList);
  (Form as IFileDialogForm).GetOptions(Self, Accepted);
end;

procedure TOpenDialog.SetHistoryList(Value: TStrings);
begin

end;                

procedure TOpenDialog.SetOptions;
begin
  FSaveDir := GetCurrentDir;
  FFiles.Clear;
  (Form as IFileDialogForm).SetOptions(Self);
end;

procedure TOpenDialog.SetSaveDlg(const Value: Boolean);
begin
  if FSaveDlg <> Value then
  begin
    FSaveDlg := Value;
    if FSaveDlg then
    begin
      if (AnsiCompareStr(Title, SOpen) = 0) then
        Title := SSave;
    end else
      if (AnsiCompareStr(Title, SSave) = 0) then
        Title := SOpen;
  end;
end;

function TOpenDialog.Execute: Boolean;
{$IFDEF MSWINDOWS}
var
  GrabControl: TControl;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if UseNativeDialog then
  begin
    GrabControl := GetMouseGrabControl;
    try
      SetMouseGrabControl(nil);
      Result := NativeExecute(FNativeFlags);
    finally
      SetMouseGrabControl(GrabControl);
    end;
  end
  else
{$ENDIF}
    Result := inherited Execute;
end;

procedure TOpenDialog.FilePreview(const Filename: WideString; Canvas: TCanvas;
  const Rect: TRect; Progress: TProgressEvent; var Handled: Boolean);
var
  I: Integer;
  Previewer: IFilePreviewer;
  Size: TSize;
  R: TRect;
begin
  Handled := False;
  if Assigned(FOnPreview) then
    FOnPreview(Self, Filename, Canvas, Rect, Progress, Handled);
  if not Handled then
  begin
    for I := 0 to FilePreviewers.Count - 1 do
    begin
      Previewer := IFilePreviewer(FilePreviewers[I]);
      Previewer.StopPreview;
      Handled := Previewer.CanPreview(Filename);
      if Handled then
      begin
        R := Rect;
        Size.cy := R.Bottom - R.Top;
        Size.cx := R.Right - R.Left;
        Previewer.GetPreviewSize(Filename, Canvas, Size);
        (Form as IFileDialogForm).ResizePreview(Size);
        R.Right := R.Left + Size.cx;
        R.Bottom := R.Top + Size.cy;
        Previewer.Preview(Filename, Canvas, R, Progress);
        Exit;
      end;
    end;
    Canvas.Font.Color := clText;
    Canvas.Brush.Color := clBackground;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left, Rect.Top, SNoPreview,
      Integer(AlignmentFlags_AlignCenter));
  end;
end;

procedure TOpenDialog.CanClose(var CanClose: Boolean);
var
  I: Integer;
{$IFDEF MSWINDOWS}
  Drive: string;
  DT: Cardinal;
{$ENDIF}
begin
  if Form <> nil then
    (Form as IFileDialogForm).ListFiles(FFiles);
  if FFiles.Count > 0 then
  begin
    FFilename := FFiles[0];
{$IFDEF MSWINDOWS}
    if (Length(FFilename) > 1) and (FFilename[2] = DriveDelim) then
    begin
      Drive := Copy(FFilename, 1, 2);
      DT := Windows.GetDriveType(PChar(Drive));
      CanClose := (DT <> DRIVE_UNKNOWN) and (DT <> DRIVE_NO_ROOT_DIR);
      if not CanClose then
      begin
        MessageDlg(Title, Format(SDriveNotFound, [Drive]), mtError, [mbOk],
          0);
        Exit;
      end;
      if DT = DRIVE_REMOVABLE then
      begin
        ChDir(Drive);
        CanClose := IOResult = 0;
        if not CanClose then
        begin
          MessageDlg(Title, Format(SCannotReadDirectory, [ExtractFilePath(FFilename)]),
            mtError, [mbOk], 0);
          Exit;
        end;
      end;
    end;
{$ENDIF}

  end;
  //ofOverwritePrompt
  if SaveDlg and (ofOverwritePrompt in Options) and FileExists(FFilename)
    and not UseNativeDialog then
      CanClose := MessageDlg(Format(SOverwriteCaption, [FFilename]),
        Format(SOverwriteText, [FFilename]), mtWarning, [mbNo, mbYes], 0, mbNo) = mrYes
  //ofFileMustExist, ofPathMustExist

  //TODO: drive must exist.
  else if CanClose
   then
    for I := 0 to FFiles.Count - 1 do
    begin
      if ofFileMustExist in Options then
      begin
        CanClose := FileExists(FFiles[I]);
        if not CanClose then
          MessageDlg(Title, Format(SFileMustExist, [ExtractFileName(FFiles[I])]),
            mtCustom, [mbOk], 0);
      end;
      if CanClose and (ofPathMustExist in Options) then
      begin
        CanClose := DirectoryExists(ExtractFilePath(FFiles[I]));
        if not CanClose then
          MessageDlg(Title, Format(SPathMustExist, [ExtractFilePath(FFiles[I])]),
            mtCustom, [mbOk], 0);
      end;

      if (FDefaultExt <> '') and (AnsiCompareStr('.' + FDefaultExt,
        ExtractFileExt(FFiles[I])) <> 0) then
        Include(FOptions, ofExtensionDifferent);

    end;
    if CanClose and Assigned(FOnCanClose) then
      FOnCanClose(Self, CanClose);
end;

function TOpenDialog.FileAdd(const Filename: WideString; const Readable,
  Writeable, Executable: Boolean): Boolean;
begin
  Result := True;
  if Assigned(FOnFileAdd) then
    FOnFileAdd(Self, Filename, Readable, Writeable, Executable, Result);
end;

procedure TOpenDialog.FileSelected(AFile: PFileInfo; Selected: Boolean);
begin
  if Assigned(FOnSelected) then
    FOnSelected(Self, AFile, Selected);
end;

procedure TOpenDialog.Help;
begin
  if Assigned(FOnHelpClick) then
    FOnHelpClick(Self)
  else
    InvokeHelp;
end;

{ TSaveDialog }

constructor TSaveDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTitle := SSave;
  FSaveDlg := True;
end;

{$IFDEF MSWINDOWS}
function TSaveDialog.NativeExecute(Flags: Integer): Boolean;
begin
  Result := WinFileDialogExecute(Self, @GetSaveFileName, Flags);
end;
{$ENDIF}

procedure TSaveDialog.SetOptions;
begin
  inherited SetOptions;
 // QClxFileDialog_setMode(Handle, QClxFileDialogMode_AnyFile);
end;

{ TFontDialog }

constructor TFontDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
end;

destructor TFontDialog.Destroy;
begin
  inherited Destroy;
  FFont.Free;
end;

function TFontDialog.DoExecute: Boolean;
var
  QFont: QFontH;
{$IFDEF LINUX}
  SigIntStatus,
  SigQuitStatus: TSignalState;
{$ENDIF}
begin
  QFont := QFont_create;
  try
{$IFDEF LINUX}
    SigIntStatus := InquireSignal(RTL_SIGINT);
    SigQuitStatus := InquireSignal(RTL_SIGQUIT);
    if SigIntStatus = ssHooked then
      UnhookSignal(RTL_SIGINT);
    if SigQuitStatus = ssHooked then
      UnhookSignal(RTL_SIGQUIT);
    try
{$ENDIF}
      QFontDialog_getFont(QFont, @Result, FFont.Handle, Screen.ActiveWidget, nil);
      if Result then
      begin
        FFont.Handle := QFont;
        FFont.OwnHandle;
      end;
{$IFDEF LINUX}
    finally
      if SigIntStatus = ssHooked then
        HookSignal(RTL_SIGINT);
      if SigQuitStatus = ssHooked then
        HookSignal(RTL_SIGQUIT);
    end;
{$ENDIF}
  finally
    if not Result then QFont_destroy(QFont);
  end;
end;

{$IFDEF MSWINDOWS}
function TFontDialog.NativeExecute(Flags: Integer): Boolean;
begin
  Result := WinFontDialogExecute(Self, Flags);
end;
{$ENDIF}

procedure TFontDialog.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
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

function TColorDialog.DoExecute: Boolean;
const
  ColorPrefix = 'Color';

  procedure GetCustomColors;
  var
    I: Integer;
    Color: QRgb;
  begin
    Color := 0;
    for I := 0 to CustomColorCount - 1 do
    begin
      QColorDialog_customColor(@Color, I);
      FCustomColors.Values[ColorPrefix + Char(Ord('A') + I)] :=
        Format('%.6x', [Color]);
    end;
  end;

  procedure SetCustomColors;
  var
    Value: string;
    I: Integer;
    CustomColor: QRgb;
  begin
    for I := 0 to CustomColorCount - 1 do
    begin
      Value := FCustomColors.Values[ColorPrefix + Char(Ord('A') + I)];
      if Value <> '' then
        CustomColor := QRgb(StrToInt('$' + Value))
      else
        CustomColor := QRgb(0);
      QColorDialog_setCustomColor(I, @CustomColor);
    end;
  end;

var
  QC: QColorH;
{$IFDEF LINUX}
  SigIntStatus,
  SigQuitStatus: TSignalState;
{$ENDIF}
begin
  SetCustomColors;
  QC := QColor_create;
  try
{$IFDEF LINUX}
    SigIntStatus := InquireSignal(RTL_SIGINT);
    SigQuitStatus := InquireSignal(RTL_SIGQUIT);
    if SigIntStatus = ssHooked then
      UnhookSignal(RTL_SIGINT);
    if SigQuitStatus = ssHooked then
      UnhookSignal(RTL_SIGQUIT);
    try
{$ENDIF}
      QColorDialog_getColor(QC, QColor(FColor), Screen.ActiveWidget, nil);
{$IFDEF LINUX}
    finally
      if SigIntStatus = ssHooked then
         HookSignal(RTL_SIGINT);
      if SigQuitStatus = ssHooked then
        HookSignal(RTL_SIGQUIT);
    end;
{$ENDIF}
    Result := QColor_isValid(QC);
    if Result then
    begin
      FColor := QColorColor(QC);
      GetCustomColors;
    end;
  finally
    QColor_destroy(QC);
  end;
end;

{$IFDEF MSWINDOWS}
function TColorDialog.NativeExecute(Flags: Integer): Boolean;
begin
  Result := WinColorDialogExecute(Self, Flags);
end;
{$ENDIF}

procedure TColorDialog.SetCustomColors(Value: TStrings);
begin
  FCustomColors.Assign(Value);
end;

{ TDialogForm }

procedure TDialogForm.InvokeHelp;
begin
  if ((HelpType = htKeyword) and (HelpKeyword = '')) or
    ((HelpType = htContext) and (HelpContext = 0)) then
      FDialog.InvokeHelp
  else
    inherited;
end;

{ TCustomDialog }

function TCustomDialog.DoExecute: Boolean;
begin
  Result := True;
  if (sfLeft in FScaleFlags) or (sfTop in FScaleFlags) then
    FForm.Position := poDefault;
  DoShow;
  if FModal then
    Result := FForm.ShowModal = mrOK
  else
    FForm.Show;
end;

procedure TCustomDialog.Close(Sender: TObject; var Action: TCloseAction);
begin
  DoClose;
end;

procedure TCustomDialog.DoClose;
begin
  FWidth := FForm.Width;
  FHeight := FForm.Height;
  FPosition.Y := FForm.Top;
  FPosition.X := FForm.Left;
  inherited;
end;

procedure TCustomDialog.DoShow;
begin
  if FForm <> nil then
  begin
    FForm.Caption := FTitle;
    FForm.OnClose := Self.Close;
  end;
  inherited;
end;

procedure TCustomDialog.InvokeHelp;
begin
  case HelpType of
    htKeyword:
      Application.KeywordHelp(HelpKeyword);
    htContext:
      Application.ContextHelp(HelpContext);
  end;
end;

procedure TCustomDialog.SetTitle(const Value: WideString);
begin
  inherited;
  if FForm <> nil then FForm.Caption := Value;
end;

procedure TCustomDialog.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  ResizeEvent: QResizeEventH;
  Size: TSize;
begin
  if not (csDesigning in ComponentState) and Assigned(FForm) and FForm.HandleAllocated then
  begin
    QWidget_move(FForm.Handle, ALeft, ATop);
    QWidget_resize(FForm.Handle, AWidth, AHeight);
    Size.cx := AWidth;
    Size.cy := AHeight;
    ResizeEvent := QResizeEvent_create(@Size, @Size);
    try
      QObject_event(FForm.Handle, ResizeEvent);
    finally
      QResizeEvent_destroy(ResizeEvent);
    end;
  end;
  FPosition.X := ALeft;
  FPosition.Y := ATop;
  FWidth := AWidth;
  FHeight := AHeight;
end;

function TCustomDialog.GetBounds: TRect;
begin
  if FForm <> nil then
    Result := Rect(FForm.Left, FForm.Top, FForm.Width, FForm.Height)
  else
    Result := Rect(FPosition.X, FPosition.Y, FWidth, FHeight);
end;

function TCustomDialog.Execute: Boolean;
begin
  if FForm = nil then
  begin
    FForm := CreateForm;
    FForm.FDialog := Self;
  end;
  Result := inherited Execute;
end;

destructor TCustomDialog.Destroy;
begin
  FForm.Free;
  inherited Destroy;
end;

{ TFindDialog }

function Max(L, R: Integer): Integer;
begin
  if L > R then Result := L
  else Result := R;
end;

constructor TFindDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModal := False;
  FTitle := SFindTitle;
  FOptions := [frDown];
  Position := Point(Screen.Width div 3, Screen.Height div 3);
end;

function TFindDialog.CreateForm: TDialogForm;
begin
  Result := TFindDialogForm.Create(Self);
end;

procedure TFindDialog.DoShow;
begin
  with TFindDialogForm(FForm) do
  begin
    FindEdit.Text := FindText;
    WholeWord.Visible := not (frHideWholeWord in FOptions);
    WholeWord.Checked := frWholeWord in FOptions;
    WholeWord.Enabled := not (frDisableWholeWord in FOptions);
    MatchCase.Visible := not (frHideMatchCase in FOptions);
    MatchCase.Checked := frMatchCase in Options;
    MatchCase.Enabled := not (frDisableMatchCase in FOptions);
    if frDown in FOptions then Direction.ItemIndex := 1 else Direction.ItemIndex := 0;
    Direction.Enabled := not (frDisableUpDown in FOptions);
    Direction.Visible := not (frHideUpDown in FOptions);
    Help.Visible := frShowHelp in FOptions;
    if Help.Visible then
      Height := Max(Direction.Top + Direction.Height + 5, Help.Top + Help.Height + 5)
    else
      Height := Direction.Top + Direction.Height + 8;
    FindEdit.SetFocus;
    FindEdit.SelectAll;
  end;
  inherited DoShow;
end;

procedure TFindDialog.Find;
begin
  if Assigned(FOnFind) then FOnFind(Self);
end;

type
  TWidgetAccess = class(TWidgetControl);

function TextWidth(Control: TWidgetControl; const Text: WideString): Integer;
var
  FM: QFontMetricsH;
begin
  FM := QFontMetrics_create(TWidgetAccess(Control).Font.Handle);
  try
    QWidget_FontMetrics(Control.Handle, FM);
    Result := QFontMetrics_width(FM, PWideString(@Text), -1);
  finally
    QFontMetrics_destroy(FM);
  end;
end;

function TextHeight(Control: TWidgetControl): Integer;
var
  FM: QFontMetricsH;
begin
  FM := QFontMetrics_create(TWidgetAccess(Control).Font.Handle);
  try
    QWidget_FontMetrics(Control.Handle, FM);
    Result := QFontMetrics_height(FM);
  finally
    QFontMetrics_destroy(FM);
  end;
end;

procedure TFindDialog.SetFindText(const Value: WideString);
begin
  if FindText <> Value then
  begin
    FFindText := Value;
    if FForm <> nil then 
      TFindDialogForm(FForm).FindEdit.Text := Value;
  end;
end;

{ TFindDialogForm }

procedure TFindDialogForm.ButtonPress(Sender: TObject);
begin
  with TFindDialog(FDialog) do
    if Sender = FindNext then
    begin
      Include(FOptions, frFindNext);
      FFindText := FindEdit.Text;
      if FModal then ModalResult := mrOk;
      Find;
    end
    else if Sender = Cancel then
    begin
      SetDialogOption(frFindNext, False);
      Exclude(FOptions, frFindNext);
      Exclude(FOptions, frReplace);
      if FModal then
        ModalResult := mrCancel
      else
        Self.Close;
    end;
end;

procedure TFindDialogForm.CheckboxCheck(Sender: TObject);
var
  Option: TFindOption;
begin
  if Sender = WholeWord then
    Option := frWholeWord
  else
    Option := frMatchCase;
  if (Sender as TCheckBox).Checked then
    Include(TFindDialog(FDialog).FOptions, Option)
  else
    Exclude(TFindDialog(FDialog).FOptions, Option);
end;

constructor TFindDialogForm.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  FormStyle := fsStayOnTop;
  BorderStyle := fbsDialog;
  DialogUnits := Types.Point(6, 13);
  SetBounds(FLeft, FTop, MulDiv(245, DialogUnits.x, 4),
    MulDiv(65, DialogUnits.y, 8));
  Scaled := True;
  AutoScroll := False;
  FindLabel := TLabel.Create(Self);
  with FindLabel do
  begin
    Parent := Self;
    Caption := SFindWhat;
    AutoSize := True;
    SetBounds(MulDiv(5, DialogUnits.y, 8), MulDiv(10, DialogUnits.x, 4),
      TextWidth(FindLabel, Caption), Font.Height + 2);
    Visible := True;
    Name := 'FindLabel';
  end;
  WholeWord := TCheckBox.Create(Self);
  with WholeWord do
  begin
    Parent := Self;
    Caption := SWholeWord;
    Left := FindLabel.Left;
    Top := MulDiv(30, DialogUnits.y, 8);
    Width := TextWidth(WholeWord, Caption) + 20;
    Height := Font.Height + 2;
    OnClick := CheckBoxCheck;
    Name := 'WholeWordCheckbox';
    TabOrder := 1;
  end;
  MatchCase := TCheckBox.Create(Self);
  with MatchCase do
  begin
    Parent := Self;
    Caption := SMatchCase;
    Left := FindLabel.Left;
    Top := WholeWord.Top + WholeWord.Height + 7;
    Width := TextWidth(MatchCase, Caption) + 20;
    Height := Font.Height + 2;
    OnClick := CheckBoxCheck;
    Name := 'MatchCaseCheckbox';
    TabOrder := 2;
  end;
  Direction := TRadioGroup.Create(Self);
  with Direction do
  begin
    Parent := Self;
    Caption := SDirection;
    Left := Max(WholeWord.Left + WholeWord.Width + 5, MatchCase.Left +
      MatchCase.Width + 5);
    Columns := 2;
    ColumnLayout := clAutoSize;
    Items.Add(SUp);
    Items.Add(SDown);
    RequestAlign;
    Top := WholeWord.Top - TextHeight(Direction) div 2;
    Width := Controls[1].Left + Controls[1].Width + 5;
    Height := (MatchCase.Top + MatchCase.Height) - Top + 5;
    OnClick := Self.DirectionClick;
    Name := 'DirectionRadioGroup';
    TabStop := True;
    TabOrder := 3;
  end;
  FindEdit := TEdit.Create(Self);
  with FindEdit do
  begin
    Parent := Self;
    HandleNeeded;
    AutoSize := True;
    Left := FindLabel.Left + FindLabel.Width + 5;
    Top := FindLabel.Top + ((FindLabel.Height - Height) div 2);
    Width := Direction.Left + Direction.Width - Left;
    FindLabel.FocusControl := FindEdit;
    Visible := True;
    OnChange := EditChanged;
    AutoSelect := True;
    TabOrder := 0;
//    Name := 'FindEdit';
  end;
  FindNext := TButton.Create(Self);
  with FindNext do
  begin
    Parent := Self;
    Caption := SFindNext;
    Enabled := False;
    Left := FindEdit.Left + FindEdit.Width + 10;
    Top := FindEdit.Top - 1;
    Height := TextHeight(FindNext) * 9 div 5;
    Width := Max(TextWidth(FindNext, SFindNext + '  '),
	     Max(TextWidth(FindNext, SCancel + '  '),
	     Max(TextWidth(FindNext, SHelp + '  '),
	     Width)));
    Default := True;
    OnClick := Self.ButtonPress;
    Visible := True;
    Name := 'FindNextButton';
    TabOrder := 4;
  end;
  Cancel := TButton.Create(Self);
  with Cancel do
  begin
    Parent := Self;
    Caption := SCancel;
    Left := FindNext.Left;
    Top := FindNext.Top + FindNext.Height + 3;
    Width := FindNext.Width;
    Height := FindNext.Height;
    Cancel := True;
    OnClick := Self.ButtonPress;
    Visible := True;
    Name := 'CancelButton';
    TabOrder := 5;
  end;
  Help := TButton.Create(Self);
  with Help do
  begin
    Parent := Self;
    Caption := SHelp;
    Left := FindNext.Left;
    Top := Self.Cancel.Top + Self.Cancel.Height + 3;
    Width := FindNext.Width;
    Height := FindNext.Height;
    OnClick := Self.ButtonPress;
    Name := 'HelpButton';
    TabOrder := 6;
  end;
  Width := FindNext.Left + FindNext.Width + 10;
end;

procedure TFindDialogForm.DirectionClick(Sender: TObject);
begin
  case Direction.ItemIndex of
    0: SetDialogOption(frDown, False);
    1: SetDialogOption(frDown, True);
  end;
end;

procedure TFindDialogForm.EditChanged(Sender: TObject);
begin
  FindNext.Enabled := FindEdit.Text <> '';
end;

procedure TFindDialogForm.SetDialogOption(Option: TFindOption;
  Value: Boolean);
begin
  if Value then
    Include(TFindDialog(FDialog).FOptions, Option)
  else
    Exclude(TFindDialog(FDialog).FOptions, Option);
end;

{ TReplaceDialog }

constructor TReplaceDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTitle := SReplaceTitle;
end;

function TReplaceDialog.CreateForm: TDialogForm;
begin
  Result := TReplaceDialogForm.Create(Self);
end;

procedure TReplaceDialog.DoShow;
begin
  with TReplaceDialogForm(FForm) do
    ReplaceEdit.Text := FReplaceText;
  inherited;
end;

procedure TReplaceDialog.Replace;
begin
  if Assigned(FOnReplace) then FOnReplace(Self);
end;

procedure TReplaceDialog.SetReplaceText(const Value: WideString);
begin
  if ReplaceText <> Value then
  begin
    FReplaceText := Value;
    if FForm <> nil then
      TReplaceDialogForm(FForm).ReplaceEdit.Text := FReplaceText;
  end;
end;

{ TReplaceDialogForm }

procedure TReplaceDialogForm.ButtonPress(Sender: TObject);
begin
  if Sender = ReplaceBtn then
  begin
    SetDialogOption(frReplace, True);
    SetDialogOption(frReplaceAll, False);
  end
  else if Sender = ReplaceAll then
  begin
    SetDialogOption(frReplaceAll, True);
    SetDialogOption(frReplace, False);
  end;
  TReplaceDialog(FDialog).FFindText := FindEdit.Text;
  TReplaceDialog(FDialog).FReplaceText := ReplaceEdit.Text;
  if (Sender = ReplaceBtn) or (Sender = ReplaceAll) then
  with TReplaceDialog(FDialog) do
  begin
    if FModal then ModalResult := mrOk;
    Replace;
  end;
  inherited ButtonPress(Sender);
end;

constructor TReplaceDialogForm.Create(AOwner: TComponent);
var
  ButtonWidth: Integer;
begin
  inherited;
  Height := MulDiv(95, DialogUnits.y, 8);
  ButtonWidth := Max(TextWidth(FindNext, SReplace + '  '),
		 Max(TextWidth(FindNext, SReplaceAll + '  '),
		 FindNext.Width));
  FindNext.Width := ButtonWidth;
  Cancel.Width := ButtonWidth;
  Help.Width := ButtonWidth;
  Width := FindNext.Left + ButtonWidth + 10;
  ReplaceLabel := TLabel.Create(Self);
  with ReplaceLabel do
  begin
    Parent := Self;
    Caption := SReplaceWith;
    SetBounds(FindLabel.Left, FindEdit.Top + FindEdit.Height + 13,
      TextWidth(ReplaceLabel, ReplaceLabel.Caption), Font.Height + 2);
    Visible := True;
    Name := 'ReplaceLabel';
  end;
  FindEdit.Left := ReplaceLabel.Left + Max(ReplaceLabel.Width, FindLabel.Width) + 5;
  FindEdit.Width := FindNext.Left - FindEdit.Left - 5;
  WholeWord.Top := MulDiv(50, DialogUnits.Y, 8);
  MatchCase.Top := WholeWord.Top + WholeWord.Height + 10;

  ReplaceBtn := TButton.Create(Self);
  with ReplaceBtn do
  begin
    Parent := Self;
    HandleNeeded;
    SetBounds(Self.Cancel.Left, Self.Cancel.Top, ButtonWidth,
      Self.Cancel.Height);
    Caption := SReplace;
    OnClick := ButtonPress;
    Visible := True;
    Enabled := False;
    Name := 'ReplaceButton';
    TabOrder := 5;
  end;
  ReplaceAll := TButton.Create(Self);
  with ReplaceAll do
  begin
    Parent := Self;
    HandleNeeded;
    SetBounds(FindNext.Left, ReplaceBtn.Top + ReplaceBtn.Height + 3,
      ButtonWidth, FindNext.Height);
    Caption := SReplaceAll;
    OnClick := ButtonPress;
    Visible := True;
    Enabled := False;
    Name := 'ReplaceAllButton';
    TabOrder := 6;
  end;

  Cancel.Top := ReplaceAll.Top + ReplaceAll.Height + 3;

  ReplaceEdit := TEdit.Create(Self);
  with ReplaceEdit do
  begin
    Parent := Self;
    HandleNeeded;
    AutoSize := True;
    Left := ReplaceLabel.Left + ReplaceLabel.Width + 5;
    Top := ReplaceLabel.Top + ((ReplaceLabel.Height - Height) div 2);
    Width := FindEdit.Width;
    Visible := True;
    Name := 'ReplaceEdit';
    TabOrder := 1;
  end;
  ReplaceLabel.FocusControl := ReplaceEdit;
  Direction.Top := WholeWord.Top - 5;
  Help.Top := Cancel.Top + Cancel.Height + 3;
end;

procedure TReplaceDialogForm.EditChanged(Sender: TObject);
begin
  inherited EditChanged(Sender);
  ReplaceBtn.Enabled := FindEdit.Text <> '';
  ReplaceAll.Enabled := FindEdit.Text <> '';
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\QDialogs.pas initialization enter'); {$EndIf}
  CustomColorCount := QColorDialog_customCount;
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TDialog, TControl);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\QDialogs.pas initialization leave'); {$EndIf}
finalization

  if Assigned(GFilePreviewers) then
    FreeAndNil(GFilePreviewers);

end.
