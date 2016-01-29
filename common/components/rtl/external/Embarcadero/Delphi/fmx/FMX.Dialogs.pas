{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Dialogs;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes,
  FMX.Types, FMX.Forms, FMX.Styles;

{$SCOPEDENUMS ON}

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

{ TPrintDialog }

type

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TPrintDialog = class(TCommonDialog)
  private
    FCollate: Boolean;
    FCopies: Integer;
    FMinPage: Integer;
    FMaxPage: Integer;
    FOptions: TPrintDialogOptions;
    FFromPage: Integer;
    FToPage: Integer;
    FPrintRange: TPrintRange;
    FPrintToFile: Boolean;
    procedure SetNumCopies(Value: Integer);
  protected
    function DoExecute: Boolean; override;
  published
    property Collate: Boolean read FCollate write FCollate default False;
    property Copies: Integer read FCopies write SetNumCopies default 0;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TPrintDialogOptions read FOptions write FOptions default [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default False;
    property PrintRange: TPrintRange read FPrintRange write FPrintRange default TPrintRange.prAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
  end;

{ TPrinterSetupDialog }

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TPrinterSetupDialog = class(TCommonDialog)
  protected
    function DoExecute: Boolean; override;
  end;

{ TPageSetupDialog }

  TPageSetupPaintingEvent = procedure (Sender: TObject; const PaperSize: SmallInt;
    const Orientation: TPrinterOrientation; const PageType: TPageType;
    var DoneDrawing: Boolean) of object;
  TPaintPageEvent = procedure(Sender: TObject; Canvas: TCanvas; PageRect: TRect;
    var DoneDrawing: Boolean) of object;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TPageSetupDialog = class(TCommonDialog)
  private
    FOptions: TPageSetupDialogOptions;
    FMargin: TRect;
    FMinMargin: TRect;
    FPaperSize: TPointF;
    // FMinMarginLeft: Integer;
    // FMinMarginTop: Integer;
    // FMinMarginRight: Integer;
    // FMinMarginBottom: Integer;
    // FMarginLeft: Integer;
    // FMarginTop: Integer;
    // FMarginRight: Integer;
    // FMarginBottom: Integer;
    // FPageWidth: Integer;
    // FPageHeight: Integer;
    FPainting: TPageSetupPaintingEvent;
    FUnits: TPageMeasureUnits;
    FOnDrawRetAddress: TPaintPageEvent;
    FOnDrawMinMargin: TPaintPageEvent;
    FOnDrawEnvStamp: TPaintPageEvent;
    FOnDrawFullPage: TPaintPageEvent;
    FOnDrawGreekText: TPaintPageEvent;
    FOnDrawMargin: TPaintPageEvent;
    function getMinMarginLeft: Integer;
    function getMinMarginTop: Integer;
    function getMinMarginRight: Integer;
    function getMinMarginBottom: Integer;
    function getMarginLeft: Integer;
    function getMarginTop: Integer;
    function getMarginRight: Integer;
    function getMarginBottom: Integer;
    function getPageWidth: Single;
    function getPageHeight: Single;
    procedure setMinMarginLeft(Value: Integer);
    procedure setMinMarginTop(Value: Integer);
    procedure setMinMarginRight(Value: Integer);
    procedure setMinMarginBottom(Value: Integer);
    procedure setMarginLeft(Value: Integer);
    procedure setMarginTop(Value: Integer);
    procedure setMarginRight(Value: Integer);
    procedure setMarginBottom(Value: Integer);
    procedure setPageWidth(Value: Single);
    procedure setPageHeight(Value: Single);
  protected
    function DoExecute: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property MinMarginLeft: Integer read getMinMarginLeft write setMinMarginLeft;
    property MinMarginTop: Integer read getMinMarginTop write setMinMarginTop;
    property MinMarginRight: Integer read getMinMarginRight write setMinMarginRight;
    property MinMarginBottom: Integer read getMinMarginBottom write setMinMarginBottom;
    property MarginLeft: Integer read getMarginLeft write setMarginLeft;
    property MarginTop: Integer read getMarginTop write setMarginTop;
    property MarginRight: Integer read getMarginRight write setMarginRight;
    property MarginBottom: Integer read getMarginBottom write setMarginBottom;
    property Options: TPageSetupDialogOptions read FOptions write FOptions
      default [TPageSetupDialogOption.psoDefaultMinMargins];
    property PageWidth: Single read getPageWidth write setPageWidth;
    property PageHeight: Single read getPageHeight write setPageHeight;
    property Units: TPageMeasureUnits read FUnits write FUnits default TPageMeasureUnits.pmDefault;
    property Painting: TPageSetupPaintingEvent read FPainting write FPainting;
    property OnDrawFullPage: TPaintPageEvent read FOnDrawFullPage write FOnDrawFullPage;
    property OnDrawMinMargin: TPaintPageEvent read FOnDrawMinMargin write FOnDrawMinMargin;
    property OnDrawMargin: TPaintPageEvent read FOnDrawMargin write FOnDrawMargin;
    property OnDrawGreekText: TPaintPageEvent read FOnDrawGreekText write FOnDrawGreekText;
    property OnDrawEnvStamp: TPaintPageEvent read FOnDrawEnvStamp write FOnDrawEnvStamp;
    property OnDrawRetAddress: TPaintPageEvent read FOnDrawRetAddress write FOnDrawRetAddress;
  end;

const
  mbYesNo = [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo];
  mbYesNoCancel = [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbCancel];
  mbYesAllNoAllCancel = [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbYesToAll, TMsgDlgBtn.mbNo,
    TMsgDlgBtn.mbNoToAll, TMsgDlgBtn.mbCancel];
  mbOKCancel = [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel];
  mbAbortRetryIgnore = [TMsgDlgBtn.mbAbort, TMsgDlgBtn.mbRetry, TMsgDlgBtn.mbIgnore];
  mbAbortIgnore = [TMsgDlgBtn.mbAbort, TMsgDlgBtn.mbIgnore];

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload; inline;
function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload; inline;

function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer; overload; inline;
function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload; inline;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer; overload;
function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer; overload;

procedure ShowMessage(const Msg: string);
procedure ShowMessageFmt(const Msg: string; Params: array of const);
procedure ShowMessagePos(const Msg: string; X, Y: Integer);

type
  TInputCloseQueryEvent = procedure (Sender: TObject; const Values: array of string; var CanClose: Boolean) of object;
  TInputCloseQueryFunc = reference to function (const Values: array of string): Boolean;

{ Input dialog }

function InputBox(const ACaption, APrompt, ADefault: string): string;
function InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string; CloseQueryFunc: TInputCloseQueryFunc = nil): Boolean; overload;
function InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string; CloseQueryEvent: TInputCloseQueryEvent; Context: TObject = nil): Boolean; overload;
function InputQuery(const ACaption, APrompt: string; var Value: string): Boolean; overload;

implementation

uses
  System.Math, FMX.Consts, FMX.Platform, FMX.Printer;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '', DefaultButton);
end;

function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;

function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '', DefaultButton);
end;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, HelpFileName, TMsgDlgBtn.mbOK);
end;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer; overload;
var
  DialogSvc: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogSvc)) then
    Result := DialogSvc.MessageDialog(Translate(Msg), DlgType, Buttons, DefaultButton, X, Y, HelpCtx, HelpFileName)
  else
    Result := 0;
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
  MessageDlgPos(Msg, TMsgDlgType.mtCustom, [TMsgDlgBtn.mbOK], 0, X, Y);
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
  if Assigned(FFiles) then
    FreeAndNil(FFiles);
  if Assigned(FHistoryList) then
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
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogService)) then
    Result := DialogService.DialogOpenFiles(FFileName, FInitialDir, FDefaultExt, FFilter,
      FTitle, FFilterIndex, FFiles, FOptions)
  else
    Result := False;
end;

{ TSaveDialog }

function TSaveDialog.DoExecute: Boolean;
var
  DialogService: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogService)) then
    Result := DialogService.DialogSaveFiles(FFileName, FInitialDir, FDefaultExt, FFilter,
      FTitle, FFilterIndex, FFiles, FOptions)
  else
    Result := False;
end;

{ TPrintDialog }

function TPrintDialog.DoExecute: Boolean;
var
  DialogService: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogService)) then
    Result := DialogService.DialogPrint(FCollate, FPrintToFile, FFromPage, FToPage, FCopies,
      FMinPage, FMaxPage, FPrintRange, FOptions)
  else
    Result := False;
end;

procedure TPrintDialog.SetNumCopies(Value: Integer);
begin
  FCopies := Value;
  Printer.Copies := Value;
end;

{ TPageSetupDialog }

constructor TPageSetupDialog.Create(AOwner: TComponent);
var
  DialogService: IFMXDialogService;
begin
  inherited;
  Options := [TPageSetupDialogOption.psoDefaultMinMargins];
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogService)) then
    DialogService.PageSetupGetDefaults(FMargin, FMinMargin, FPaperSize, FUnits, FOptions);
end;

function TPageSetupDialog.DoExecute: Boolean;
var
  DialogService: IFMXDialogService;
begin
  Result := False;
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogService)) then
    Result := DialogService.DialogPageSetup(FMargin, FMinMargin, FPaperSize, FUnits, FOptions);
end;

function TPageSetupDialog.getMarginBottom: Integer;
begin
  Result := FMargin.Bottom;
end;

function TPageSetupDialog.getMarginLeft: Integer;
begin
  Result := FMargin.Left;
end;

function TPageSetupDialog.getMarginRight: Integer;
begin
  Result := FMargin.Right;
end;

function TPageSetupDialog.getMarginTop: Integer;
begin
  Result := FMargin.Top;
end;

function TPageSetupDialog.getMinMarginBottom: Integer;
begin
  Result := FMinMargin.Bottom;
end;

function TPageSetupDialog.getMinMarginLeft: Integer;
begin
  Result := FMinMargin.Left;
end;

function TPageSetupDialog.getMinMarginRight: Integer;
begin
  Result := FMinMargin.Right;
end;

function TPageSetupDialog.getMinMarginTop: Integer;
begin
  Result := FMinMargin.Top;
end;

function TPageSetupDialog.getPageHeight: Single;
begin
  Result := FPaperSize.Y;
end;

function TPageSetupDialog.getPageWidth: Single;
begin
  Result := FPaperSize.X;
end;

procedure TPageSetupDialog.setMarginBottom(Value: Integer);
begin
  if Value <> FMargin.Bottom then
    if Value >= 0 then
      FMargin.Bottom := Value;
end;

procedure TPageSetupDialog.setMarginLeft(Value: Integer);
begin
  if Value <> FMargin.Left then
    if Value >= 0 then
      FMargin.Left := Value;
end;

procedure TPageSetupDialog.setMarginRight(Value: Integer);
begin
  if Value <> FMargin.Right then
    if Value >= 0 then
      FMargin.Right := Value;
end;

procedure TPageSetupDialog.setMarginTop(Value: Integer);
begin
  if Value <> FMargin.Top then
    if Value >= 0 then
      FMargin.Top := Value;
end;

procedure TPageSetupDialog.setMinMarginBottom(Value: Integer);
begin
  if Value <> FMinMargin.Bottom then
    if Value >= 0 then
      FMinMargin.Bottom := Value;
end;

procedure TPageSetupDialog.setMinMarginLeft(Value: Integer);
begin
  if Value <> FMinMargin.Left then
    if Value >= 0 then
      FMinMargin.Left := Value;
end;

procedure TPageSetupDialog.setMinMarginRight(Value: Integer);
begin
  if Value <> FMinMargin.Right then
    if Value >= 0 then
      FMinMargin.Right := Value;
end;

procedure TPageSetupDialog.setMinMarginTop(Value: Integer);
begin
  if Value <> FMinMargin.Top then
    if Value >= 0 then
      FMinMargin.Top := Value;
end;

procedure TPageSetupDialog.setPageHeight(Value: Single);
begin
  if Value <> FPaperSize.Y then
    if Value >= 0 then
      FPaperSize.Y := Value;
end;

procedure TPageSetupDialog.setPageWidth(Value: Single);
begin
  if Value <> FPaperSize.X then
    if Value >= 0 then
      FPaperSize.X := Value;
end;

{ TPrinterSetupDialog }

function TPrinterSetupDialog.DoExecute: Boolean;
var
  DialogService: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogService)) then
    Result := DialogService.DialogPrinterSetup
  else
    Result := False;
end;

{ Input dialog }

function InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result);
end;

function InputQuery(const ACaption: string; const APrompts: array of string;
  var AValues: array of string; CloseQueryFunc: TInputCloseQueryFunc = nil): Boolean;
var
  DialogSvc: IFMXDialogService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, IInterface(DialogSvc)) then
    Result := DialogSvc.InputQuery(Translate(ACaption), APrompts, AValues, CloseQueryFunc)
  else
    Result := False;
end;

function InputQuery(const ACaption: string; const APrompts: array of string;
  var AValues: array of string; CloseQueryEvent: TInputCloseQueryEvent; Context: TObject = nil): Boolean;
begin
  Result := InputQuery(ACaption, APrompts, AValues,
    function (const Values: array of string): Boolean
    begin
      Result := True;
      CloseQueryEvent(Context, Values, Result);
    end)
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
  Success := InputQuery(SLogin, [SUsername, #31 + SPassword, SDomain], Values,
    function (const Values: array of string): Boolean
    begin
      Result := True;
      Callback(Sender, Values[0], Values[1], Values[2], Result);
    end);
end;

class procedure TDefaultLoginCredentials.LoginEventUsrPw(Sender: TObject; Callback: TLoginCredentialService.TLoginEvent; var Success: Boolean);
var
  Values: TArray<string>;
begin
  SetLength(Values, 2);
  Success := InputQuery(SLogin, [SUsername, #31 + SPassword], Values,
    function (const Values: array of string): Boolean
    begin
      Result := True;
      Callback(Sender, Values[0], Values[1], '', Result);
    end);
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
