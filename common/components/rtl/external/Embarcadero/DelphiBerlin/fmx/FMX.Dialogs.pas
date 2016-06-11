{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Dialogs;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.SysUtils, System.UITypes, FMX.Types, FMX.Forms, FMX.Consts;

type

{ TCommonDialog }

  TCommonDialog = class(TFmxObject)
  private
    FHelpContext: THelpContext;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
  protected
    procedure DoClose; dynamic;
    procedure DoShow; dynamic;
    function DoExecute: Boolean; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; overload; virtual;
  published
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

{ TOpenDialog }

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TOpenDialog = class(TCommonDialog)
  private
    FHistoryList: TStrings;
    FOptions: TOpenOptions;
    FOptionsEx: TOpenOptionsEx;
    FFilter: string;
    FFilterIndex: Integer;
    FInitialDir: string;
    FTitle: string;
    FDefaultExt: string;
    FFileName: TFileName;
    FFiles: TStrings;
    FOnSelectionChange: TNotifyEvent;
    FOnFolderChange: TNotifyEvent;
    FOnTypeChange: TNotifyEvent;
    FOnCanClose: TCloseQueryEvent;
    function GetFileName: TFileName;
    function GetFiles: TStrings;
    function GetFilterIndex: Integer;
    function GetInitialDir: string;
    function GetTitle: string;
    procedure ReadFileEditStyle(Reader: TReader);
    procedure SetFileName(const Value: TFileName);
    procedure SetHistoryList(const Value: TStrings);
    procedure SetInitialDir(const Value: string);
    procedure SetTitle(const Value: string);
  protected
    function DoCanClose: Boolean; dynamic;
    procedure DoSelectionChange; dynamic;
    procedure DoFolderChange; dynamic;
    procedure DoTypeChange; dynamic;
    procedure DefineProperties(Filer: TFiler); override;
    function DoExecute: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Files: TStrings read GetFiles;
    property HistoryList: TStrings read FHistoryList write SetHistoryList;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property FileName: TFileName read GetFileName write SetFileName;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read GetFilterIndex write FFilterIndex default 1;
    property InitialDir: string read GetInitialDir write SetInitialDir;
    property Options: TOpenOptions read FOptions write FOptions
      default [TOpenOption.ofHideReadOnly, TOpenOption.ofEnableSizing];
    property OptionsEx: TOpenOptionsEx read FOptionsEx write FOptionsEx default [];
    property Title: string read GetTitle write SetTitle;
    property OnCanClose: TCloseQueryEvent read FOnCanClose write FOnCanClose;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
  end;

{ TSaveDialog }

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TSaveDialog = class(TOpenDialog)
  protected
    function DoExecute: Boolean; override;
  end;

const
  mbYesNo = [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo];
  mbYesNoCancel = [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbCancel];
  mbYesAllNoAllCancel = [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbYesToAll, TMsgDlgBtn.mbNo,
    TMsgDlgBtn.mbNoToAll, TMsgDlgBtn.mbCancel];
  mbOKCancel = [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel];
  mbAbortRetryIgnore = [TMsgDlgBtn.mbAbort, TMsgDlgBtn.mbRetry, TMsgDlgBtn.mbIgnore];
  mbAbortIgnore = [TMsgDlgBtn.mbAbort, TMsgDlgBtn.mbIgnore];

  MsgTitles: array[TMsgDlgType] of string = (SMsgDlgWarning, SMsgDlgError, SMsgDlgInformation, SMsgDlgConfirm, '');
  ModalResults: array[TMsgDlgBtn] of Integer = (mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll,
    mrNoToAll, mrYesToAll, 0, mrClose);
  ButtonCaptions: array[TMsgDlgBtn] of string = (SMsgDlgYes, SMsgDlgNo, SMsgDlgOK, SMsgDlgCancel, SMsgDlgAbort,
    SMsgDlgRetry, SMsgDlgIgnore, SMsgDlgAll, SMsgDlgNoToAll, SMsgDlgYesToAll, SMsgDlgHelp, SMsgDlgClose);

type
  TInputCloseQueryEvent = procedure(Sender: TObject; const Values: array of string; var CanClose: Boolean) of object;
  TInputCloseQueryFunc = reference to function(const Values: array of string): Boolean;
  TInputCloseQueryProc = reference to procedure(const AResult: TModalResult; const AValues: array of string);
  TInputCloseBoxProc = reference to procedure(const AResult: TModalResult; const AValue: string);
  TInputCloseDialogProc = reference to procedure(const AResult: TModalResult);
  TInputCloseDialogEvent = procedure(Sender: TObject; const AResult: TModalResult) of object;
  TInputCloseQueryWithResultEvent = procedure(Sender: TObject; const AResult: TModalResult; const AValues: array of string) of object;
  TInputCloseBoxEvent = procedure(Sender: TObject; const AResult: TModalResult; const AValue: string) of object;

/// <summary>Message dialogs must be shown in the UI thread. This procedure chacks that and raises an exception if is not in the UI thread.</summary>
procedure MessageDialogCheckInUIThread;

function MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt): Integer; overload; inline; deprecated 'Use FMX.DialogService methods';
procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ACloseDialogProc: TInputCloseDialogProc); overload; inline; deprecated 'Use FMX.DialogService methods';
procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject = nil); overload; inline;
  deprecated 'Use FMX.DialogService methods';

function MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ADefaultButton: TMsgDlgBtn): Integer; overload; inline; deprecated 'Use FMX.DialogService methods';
procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ADefaultButton: TMsgDlgBtn;
  const ACloseDialogProc: TInputCloseDialogProc); overload; inline; deprecated 'Use FMX.DialogService methods';
procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ADefaultButton: TMsgDlgBtn; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject = nil); overload; inline; deprecated 'Use FMX.DialogService methods';

function MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer): Integer; overload; inline; deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ACloseDialogProc: TInputCloseDialogProc); overload; inline;
  deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject = nil); overload; inline; deprecated 'Use FMX.DialogService methods';

function MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ADefaultButton: TMsgDlgBtn): Integer; overload; inline;
  deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ADefaultButton: TMsgDlgBtn;
  const ACloseDialogProc: TInputCloseDialogProc); overload; inline; deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ADefaultButton: TMsgDlgBtn;
  const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject = nil); overload; inline;
   deprecated 'Use FMX.DialogService methods';

function MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string): Integer; overload;
  deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ACloseDialogProc: TInputCloseDialogProc); overload; deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject = nil); overload;
  deprecated 'Use FMX.DialogService methods';

function MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ADefaultButton: TMsgDlgBtn): Integer; overload; deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ADefaultButton: TMsgDlgBtn; const ACloseDialogProc: TInputCloseDialogProc); overload;
  deprecated 'Use FMX.DialogService methods';
procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ADefaultButton: TMsgDlgBtn; const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject = nil); overload;
  deprecated 'Use FMX.DialogService methods';

procedure ShowMessage(const AMessage: string);
procedure ShowMessageFmt(const AMessage: string; const AParams: array of const);
procedure ShowMessagePos(const AMessage: string; const AX, AY: Integer); deprecated 'Use FMX.DialogService methods';

function SelectDirectory(const Caption: string; const Root: string;
  var Directory: string): Boolean;

{ Input dialog }

function InputBox(const ACaption, APrompt, ADefault: string): string; overload; deprecated 'Use FMX.DialogService methods';
procedure InputBox(const ACaption, APrompt, ADefault: string; const ACloseBoxProc: TInputCloseBoxProc); overload;
  deprecated 'Use FMX.DialogService methods';
procedure InputBox(const ACaption, APrompt, ADefault: string; const ACloseBoxEvent: TInputCloseBoxEvent;
  const AContext: TObject = nil); overload; deprecated 'Use FMX.DialogService methods';

function InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  const ACloseQueryFunc: TInputCloseQueryFunc = nil): Boolean; overload; deprecated 'Use FMX.DialogService methods';
function InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  const ACloseQueryEvent: TInputCloseQueryEvent; const AContext: TObject = nil): Boolean; overload; deprecated 'Use FMX.DialogService methods';
function InputQuery(const ACaption, APrompt: string; var Value: string): Boolean; overload; deprecated 'Use FMX.DialogService methods';

procedure InputQuery(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
  const ACloseQueryProc: TInputCloseQueryProc); overload; deprecated 'Use FMX.DialogService methods';
procedure InputQuery(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
  const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject = nil); overload;
  deprecated 'Use FMX.DialogService methods';
procedure InputQuery(const ACaption, APrompt, ADefaultValue: string; const ACloseBoxProc: TInputCloseBoxProc); overload;
  deprecated 'Use FMX.DialogService methods';
procedure InputQuery(const ACaption, APrompt, ADefaultValue: string;
  const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject = nil); overload;
  deprecated 'Use FMX.DialogService methods';

implementation

uses
  FMX.Platform,
{$IF DEFINED(ANDROID) OR (DEFINED(IOS))}
  FMX.DialogService.Async
{$ELSE}
  FMX.DialogService.Sync
{$ENDIF}
  ;

procedure MessageDialogCheckInUIThread;
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    raise Exception.Create(SDialogMustBeRunInUIThread);
end;

function MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt): Integer;
begin
  Result := MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, -1, -1, '');
end;

procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, -1, -1, '', ACloseDialogProc);
end;

procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, -1, -1, '', ACloseDialogEvent, AContext);
end;

function MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ADefaultButton: TMsgDlgBtn): Integer;
begin
  Result := MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, -1, -1, '', ADefaultButton);
end;

procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ADefaultButton: TMsgDlgBtn; const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, -1, -1, '', ADefaultButton, ACloseDialogProc);
end;

procedure MessageDlg(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const ADefaultButton: TMsgDlgBtn; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, -1, -1, '', ADefaultButton, ACloseDialogEvent,
    AContext);
end;

function MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer): Integer;
begin
  Result := MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, '');
end;

procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, '', ACloseDialogProc);
end;

procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, '', ACloseDialogEvent, AContext);
end;

function MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ADefaultButton: TMsgDlgBtn): Integer;
begin
  Result := MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, '', ADefaultButton);
end;

procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ADefaultButton: TMsgDlgBtn;
  const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, '', ADefaultButton, ACloseDialogProc);
end;

procedure MessageDlgPos(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const ADefaultButton: TMsgDlgBtn;
  const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, '', ADefaultButton, ACloseDialogEvent,
    AContext);
end;

function MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string): Integer;
begin
  Result := MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, AHelpFileName, TMsgDlgBtn.mbOK);
end;

procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, AHelpFileName, TMsgDlgBtn.mbOK,
    ACloseDialogProc);
end;

procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject);
begin
  MessageDlgPosHelp(AMessage, ADialogType, AButtons, AHelpContext, AX, AY, AHelpFileName, TMsgDlgBtn.mbOK,
    ACloseDialogEvent, AContext);
end;

function MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ADefaultButton: TMsgDlgBtn): Integer;
var
  DialogSvc: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogSvc) then
    Result := DialogSvc.MessageDialog(Translate(AMessage), ADialogType, AButtons, ADefaultButton, AX, AY, AHelpContext,
      AHelpFileName)
  else
    Result := 0;
end;

procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ADefaultButton: TMsgDlgBtn; const ACloseDialogProc: TInputCloseDialogProc);
var
  DialogSvc: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogSvc) then
    DialogSvc.MessageDialog(Translate(AMessage), ADialogType, AButtons, ADefaultButton, AX, AY, AHelpContext,
      AHelpFileName, ACloseDialogProc);
end;

procedure MessageDlgPosHelp(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const AHelpContext: LongInt; const AX, AY: Integer; const AHelpFileName: string;
  const ADefaultButton: TMsgDlgBtn; const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject);
var
  DialogSvc: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogSvc) then
    DialogSvc.MessageDialog(Translate(AMessage), ADialogType, AButtons, ADefaultButton, AX, AY, AHelpContext,
      AHelpFileName, procedure(const AResult: TModalresult)
      begin
        if Assigned(ACloseDialogEvent) then
          ACloseDialogEvent(AContext, AResult);
      end);
end;

procedure ShowMessage(const AMessage: string);
begin
 {$IF DEFINED(ANDROID) OR (DEFINED(IOS))}
  TDialogServiceAsync.ShowMessage(AMessage);
{$ELSE}
  TDialogServiceSync.ShowMessage(AMessage);
{$ENDIF}
end;

procedure ShowMessageFmt(const AMessage: string; const AParams: array of const);
begin
  ShowMessage(Format(AMessage, AParams));
end;

procedure ShowMessagePos(const AMessage: string; const AX, AY: Integer);
begin
  MessageDlgPos(AMessage, TMsgDlgType.mtCustom, [TMsgDlgBtn.mbOK], 0, AX, AY, nil);
end;

function SelectDirectory(const Caption: string; const Root: string;
  var Directory: string): Boolean;
var
  DialogSvc: IFMXDialogService;
  LDialog: TOpenDialog;
  LDirectories: TStrings;
begin
  Result := False;
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogSvc) then
  begin
    LDialog := TOpenDialog.Create(nil);
    LDialog.InitialDir := Root;
    LDialog.Title := Caption;
    LDirectories := TStringList.Create;
    Result := DialogSvc.DialogOpenFiles(LDialog, LDirectories, TDialogType.Directory);
    if Result then
      Directory := LDialog.FileName
    else
      Directory := '';
    LDirectories.Free;
    LDialog.Free;
  end;
end;

{ TCommonDialog }

constructor TCommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCommonDialog.Destroy;
begin
  inherited Destroy;
end;

procedure TCommonDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TCommonDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

function TCommonDialog.Execute: Boolean;
begin
  DoShow;
  Result := DoExecute;
  DoClose;
end;

{ TOpenDialog }

constructor TOpenDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHistoryList := TStringList.Create;
  FOptions := [TOpenOption.ofHideReadOnly, TOpenOption.ofEnableSizing];
  FFiles := TStringList.Create;
  FFilterIndex := 1;
end;

destructor TOpenDialog.Destroy;
begin
  FreeAndNil(FFiles);
  FreeAndNil(FHistoryList);
  inherited Destroy;
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

function TOpenDialog.GetFiles: TStrings;
begin
  Result := FFiles;
end;

function TOpenDialog.GetFileName: TFileName;
begin
  Result := FFileName;
end;

function TOpenDialog.GetFilterIndex: Integer;
begin
  Result := FFilterIndex;
end;

function TOpenDialog.GetInitialDir: string;
begin
  Result := FInitialDir;
end;

function TOpenDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TOpenDialog.SetFileName(const Value: TFileName);
begin
  if Value <> FFileName then
    FFileName := Value;
end;

procedure TOpenDialog.SetHistoryList(const Value: TStrings);
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

  FInitialDir := Value.Substring(0, L);
end;

procedure TOpenDialog.SetTitle(const Value: string);
begin
  if Value <> FTitle then
    FTitle := Value;
end;

function TOpenDialog.DoExecute: Boolean;
var
  DialogService: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogService) then
    Result := DialogService.DialogOpenFiles(Self, FFiles)
  else
    Result := False;
end;

{ TSaveDialog }

function TSaveDialog.DoExecute: Boolean;
var
  DialogService: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogService) then
    Result := DialogService.DialogSaveFiles(Self, FFiles)
  else
    Result := False;
end;

{ Input dialog }

function InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result);
end;

procedure InputBox(const ACaption, APrompt, ADefault: string; const ACloseBoxProc: TInputCloseBoxProc);
begin
  InputQuery(ACaption, [APrompt], [ADefault], procedure (const AResult: TModalResult; const AValues: array of string)
    begin
      if Assigned(ACloseBoxProc) then
        ACloseBoxProc(AResult, AValues[0]);
    end);
end;

procedure InputBox(const ACaption, APrompt, ADefault: string; const ACloseBoxEvent: TInputCloseBoxEvent;
  const AContext: TObject);
begin
  InputQuery(ACaption, [APrompt], [ADefault], procedure (const AResult: TModalResult; const AValues: array of string)
    begin
      if Assigned(ACloseBoxEvent) then
        ACloseBoxEvent(AContext, AResult, AValues[0]);
    end);
end;

function InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  const ACloseQueryFunc: TInputCloseQueryFunc): Boolean;
var
  DialogSvc: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogSvc) then
    Result := DialogSvc.InputQuery(Translate(ACaption), APrompts, AValues, ACloseQueryFunc)
  else
    Result := False;
end;

function InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  const ACloseQueryEvent: TInputCloseQueryEvent; const AContext: TObject): Boolean;
begin
  Result := InputQuery(ACaption, APrompts, AValues,
    function (const Values: array of string): Boolean
    begin
      Result := True;
      ACloseQueryEvent(AContext, Values, Result);
    end);
end;

function InputQuery(const ACaption, APrompt: string; var Value: string): Boolean;
var
  Values: array of string;
begin
  SetLength(Values, 1);
  Values[0] := Value;
  Result := InputQuery(ACaption, [APrompt], Values);
  if Result then
    Value := Values[0];
end;

procedure InputQuery(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
  const ACloseQueryProc: TInputCloseQueryProc);
var
  DialogSvc: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogSvc) then
    DialogSvc.InputQuery(Translate(ACaption), APrompts, ADefaultValues, ACloseQueryProc);
end;

procedure InputQuery(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
  const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject);
begin
  InputQuery(ACaption, APrompts, ADefaultValues, procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if Assigned(ACloseQueryEvent) then
        ACloseQueryEvent(AContext, AResult, AValues);
    end);
end;

procedure InputQuery(const ACaption, APrompt, ADefaultValue: string; const ACloseBoxProc: TInputCloseBoxProc);
begin
  InputQuery(ACaption, [APrompt], [ADefaultValue], procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if Assigned(ACloseBoxProc) then
        ACloseBoxProc(AResult, AValues[0]);
    end);
end;

procedure InputQuery(const ACaption, APrompt, ADefaultValue: string;
  const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject); overload;
begin
  InputQuery(ACaption, [APrompt], [ADefaultValue], procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if Assigned(ACloseQueryEvent) then
        ACloseQueryEvent(AContext, AResult, AValues[0]);
    end);
end;

type
  TDefaultLoginCredentials = class sealed
    class procedure LoginEvent(Sender: TObject; Callback: TLoginCredentialService.TLoginEvent; var Success: Boolean);
    class procedure LoginEventUsrPw(Sender: TObject; Callback: TLoginCredentialService.TLoginEvent; var Success: Boolean);
  end;

class procedure TDefaultLoginCredentials.LoginEvent(Sender: TObject; Callback: TLoginCredentialService.TLoginEvent; var Success: Boolean);
var
  Values: TArray<string>;
begin
  SetLength(Values, 3);
                                                                                                 
  {$WARN SYMBOL_DEPRECATED OFF}
  Success := InputQuery(SLogin, [SUsername, #31 + SPassword, SDomain], Values,
    function (const Values: array of string): Boolean
    begin
      Result := True;
      Callback(Sender, Values[0], Values[1], Values[2], Result);
    end);
  {$WARN SYMBOL_DEPRECATED DEFAULT}
end;

class procedure TDefaultLoginCredentials.LoginEventUsrPw(Sender: TObject; Callback: TLoginCredentialService.TLoginEvent; var Success: Boolean);
var
  Values: TArray<string>;
begin
  SetLength(Values, 2);
                                                                                                 
  {$WARN SYMBOL_DEPRECATED OFF}
  Success := InputQuery(SLogin, [SUsername, #31 + SPassword], Values,
    function (const Values: array of string): Boolean
    begin
      Result := True;
      Callback(Sender, Values[0], Values[1], '', Result);
    end);
  {$WARN SYMBOL_DEPRECATED DEFAULT}
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TCommonDialog, TFmxObject);
  TLoginCredentialService.RegisterLoginHandler(TLoginCredentialService.Default, TDefaultLoginCredentials.LoginEventUsrPw);
  TLoginCredentialService.RegisterLoginHandler(TLoginCredentialService.DefaultUsrPwDm, TDefaultLoginCredentials.LoginEvent);
  TLoginCredentialService.RegisterLoginHandler(TLoginCredentialService.DefaultUsrPw, TDefaultLoginCredentials.LoginEventUsrPw);
finalization
  TLoginCredentialService.UnregisterLoginHandler(TLoginCredentialService.DefaultUsrPw, TDefaultLoginCredentials.LoginEventUsrPw);
  TLoginCredentialService.UnregisterLoginHandler(TLoginCredentialService.DefaultUsrPwDm, TDefaultLoginCredentials.LoginEvent);
  TLoginCredentialService.UnregisterLoginHandler(TLoginCredentialService.Default, TDefaultLoginCredentials.LoginEventUsrPw);
end.
