{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC GUIx components                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Comp.UI;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Consts,
  FireDAC.UI.Intf;

type
  TFDGUIxComponent = class;
  TFDGUIxAsyncExecuteDialog = class;
  TFDGUIxErrorDialog = class;
  TFDGUIxLoginDialog = class;
  TFDGUIxScriptDialog = class;
  TFDGUIxWaitCursor = class;

  TFDGUIxComponent = class(TFDComponent)
  private
    FProvider: String;
    FProviderSpecified: Boolean;
  protected
    function GetProvider: String;
    procedure SetProvider(const AValue: String); virtual;
  public
    class function GetGUID: TGUID; virtual;
    property ProviderSpecified: Boolean read FProviderSpecified;
  published
    property Provider: String read GetProvider write SetProvider
      stored FProviderSpecified;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDGUIxAsyncExecuteDialog = class(TFDGUIxComponent, IFDGUIxAsyncExecuteDialog)
  private
    FAsyncDialog: IFDGUIxAsyncExecuteDialog;
    FCaption: String;
    FPrompt: String;
    FShowDelay: Integer;
    FHideDelay: Integer;
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    function GetAsyncDialog: IFDGUIxAsyncExecuteDialog;
    procedure DoOnShow(ASender: TObject);
    procedure DoOnHide(ASender: TObject);
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function IsCS: Boolean;
    function GetShowDelay: Integer;
    procedure SetShowDelay(const AValue: Integer);
    function GetHideDelay: Integer;
    procedure SetHideDelay(const AValue: Integer);
    function GetPrompt: String;
    procedure SetPrompt(const AValue: String);
    function IsPS: Boolean;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetGUID: TGUID; override;
    property AsyncDialog: IFDGUIxAsyncExecuteDialog read FAsyncDialog
      implements IFDGUIxAsyncExecuteDialog;
  published
    property Caption: String read GetCaption write SetCaption stored IsCS;
    property Prompt: String read GetPrompt write SetPrompt stored IsPS;
    property ShowDelay: Integer read GetShowDelay write SetShowDelay
      default C_FD_DelayBeforeFWait;
    property HideDelay: Integer read GetHideDelay write SetHideDelay
      default C_FD_DelayBeforeFWait;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDGUIxErrorDialog = class(TFDGUIxComponent, IFDGUIxErrorDialog)
  private
    FErrorDialog: IFDGUIxErrorDialog;
    FCaption: String;
    FEnabled: Boolean;
    FStayOnTop: Boolean;
    FOnHide: TFDGUIxErrorDialogEvent;
    FOnShow: TFDGUIxErrorDialogEvent;
    function GetErrorDialog: IFDGUIxErrorDialog;
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function IsCS: Boolean;
    procedure DoOnHide(ASender: TObject; AException: EFDDBEngineException);
    procedure DoOnShow(ASender: TObject; AException: EFDDBEngineException);
    function GetEnabled: Boolean;
    procedure SetEnabled(const AValue: Boolean);
    function GetStayOnTop: Boolean;
    procedure SetStayOnTop(const AValue: Boolean);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetGUID: TGUID; override;
    procedure Execute(E: EFDDBEngineException);
    property ErrorDialog: IFDGUIxErrorDialog read FErrorDialog implements IFDGUIxErrorDialog;
  published
    property Caption: String read GetCaption write SetCaption stored IsCS;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property StayOnTop: Boolean read GetStayOnTop write SetStayOnTop default True;
    property OnShow: TFDGUIxErrorDialogEvent read FOnShow write FOnShow;
    property OnHide: TFDGUIxErrorDialogEvent read FOnHide write FOnHide;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDGUIxLoginDialog = class(TFDGUIxComponent, IFDGUIxLoginDialog)
  private
    FLoginDialog: IFDGUIxLoginDialog;
    FCaption: String;
    FHistoryEnabled: Boolean;
    FHistoryKey: String;
    FHistoryStorage: TFDGUIxLoginHistoryStorage;
    FHistoryWithPassword: Boolean;
    FLoginRetries: Integer;
    FVisibleItems: TStrings;
    FChangeExpiredPassword: Boolean;
    FConnectionDef: IFDStanConnectionDef;
    FOnChangePassword: TFDGUIxLoginDialogEvent;
    FOnLogin: TFDGUIxLoginDialogEvent;
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    function GetLoginDialog: IFDGUIxLoginDialog;
    function GetCaption: String;
    function GetChangeExpiredPassword: Boolean;
    function GetConnectionDef: IFDStanConnectionDef;
    function GetHistoryEnabled: Boolean;
    function GetHistoryKey: String;
    function GetHistoryStorage: TFDGUIxLoginHistoryStorage;
    function GetHistoryWithPassword: Boolean;
    function GetLoginRetries: Integer;
    function GetVisibleItems: TStrings;
    procedure SetCaption(const AValue: String);
    procedure SetConnectionDef(const AConnectionDef: IFDStanConnectionDef);
    procedure SetChangeExpiredPassword(const AValue: Boolean);
    procedure SetHistoryEnabled(const AValue: Boolean);
    procedure SetHistoryKey(const AValue: String);
    procedure SetHistoryStorage(const AValue: TFDGUIxLoginHistoryStorage);
    procedure SetHistoryWithPassword(const AValue: Boolean);
    procedure SetLoginRetries(const AValue: Integer);
    procedure SetVisibleItems(const AValue: TStrings);
    procedure DoOnHide(ASender: TObject);
    procedure DoOnShow(ASender: TObject);
    procedure DoChangePassword(ASender: TObject; var AResult: Boolean);
    procedure DoLogin(ASender: TObject; var AResult: Boolean);
    procedure SetOnChangePassword(const AValue: TFDGUIxLoginDialogEvent);
    procedure SetOnLogin(const AValue: TFDGUIxLoginDialogEvent);
    function IsCS: Boolean;
    function IsHKS: Boolean;
    function IsVIS: Boolean;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetGUID: TGUID; override;
    function Execute(ALoginAction: TFDGUIxLoginAction): Boolean;
    procedure GetAllLoginParams;
    property ConnectionDef: IFDStanConnectionDef read GetConnectionDef write SetConnectionDef;
    property LoginDialog: IFDGUIxLoginDialog read FLoginDialog implements IFDGUIxLoginDialog;
  published
    property Caption: String read GetCaption write SetCaption stored IsCS;
    property HistoryEnabled: Boolean read GetHistoryEnabled write SetHistoryEnabled default False;
    property HistoryWithPassword: Boolean read GetHistoryWithPassword write SetHistoryWithPassword default True;
    property HistoryStorage: TFDGUIxLoginHistoryStorage read GetHistoryStorage write SetHistoryStorage default hsRegistry;
    property HistoryKey: String read GetHistoryKey write SetHistoryKey stored IsHKS;
    property VisibleItems: TStrings read GetVisibleItems write SetVisibleItems stored IsVIS;
    property LoginRetries: Integer read GetLoginRetries write SetLoginRetries default 3;
    property ChangeExpiredPassword: Boolean read GetChangeExpiredPassword write SetChangeExpiredPassword default True;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnLogin: TFDGUIxLoginDialogEvent read FOnLogin write SetOnLogin;
    property OnChangePassword: TFDGUIxLoginDialogEvent read FOnChangePassword write SetOnChangePassword;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDGUIxScriptDialog = class(TFDGUIxComponent, IFDGUIxScriptDialog)
  private
    FScriptDialog: IFDGUIxScriptDialog;
    FCaption: String;
    FOptions: TFDGUIxScriptOptions;
    FOnOutput: TFDGUIxScriptOutputEvent;
    FOnInput: TFDGUIxScriptInputEvent;
    FOnPause: TFDGUIxScriptPauseEvent;
    FOnProgress: TFDGUIxScriptProgressEvent;
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    function GetScriptDialog: IFDGUIxScriptDialog;
    function GetCaption: String;
    function IsCS: Boolean;
    procedure SetCaption(const AValue: String);
    procedure DoOnHide(ASender: TObject);
    procedure DoOnShow(ASender: TObject);
    procedure DoOnProgress(ASender: TObject; AInfoProvider: TObject);
    procedure DoOnOutput(ASender: TObject; const AStr: String);
    procedure DoOnInput(ASender: TObject; const APrompt: String; var AResult: String);
    procedure DoOnPause(ASender: TObject; const APrompt: String);
    function GetOptions: TFDGUIxScriptOptions;
    procedure SetOptions(const AValue: TFDGUIxScriptOptions);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetGUID: TGUID; override;
    property ScriptDialog: IFDGUIxScriptDialog read FScriptDialog
      implements IFDGUIxScriptDialog;
  published
    property Caption: String read GetCaption write SetCaption stored IsCS;
    property Options: TFDGUIxScriptOptions read GetOptions write SetOptions
      default [ssCallstack, ssConsole, ssAutoHide];
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnProgress: TFDGUIxScriptProgressEvent read FOnProgress write FOnProgress;
    property OnOutput: TFDGUIxScriptOutputEvent read FOnOutput write FOnOutput;
    property OnInput: TFDGUIxScriptInputEvent read FOnInput write FOnInput;
    property OnPause: TFDGUIxScriptPauseEvent read FOnPause write FOnPause;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDGUIxWaitCursor = class(TFDGUIxComponent, IFDGUIxWaitCursor)
  private
    FWaitCursor: IFDGUIxWaitCursor;
    FScreenCursor: TFDGUIxScreenCursor;
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    function GetGUIxWaitCursor: IFDGUIxWaitCursor;
    function GetScreenCursor: TFDGUIxScreenCursor;
    procedure SetScreenCursor(const AValue: TFDGUIxScreenCursor);
    procedure DoOnHide(ASender: TObject);
    procedure DoOnShow(ASender: TObject);
  protected
    procedure Loaded; override;
    procedure SetProvider(const AValue: String); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetGUID: TGUID; override;
    property WaitCursor: IFDGUIxWaitCursor read FWaitCursor
      implements IFDGUIxWaitCursor;
  published
    property ScreenCursor: TFDGUIxScreenCursor read GetScreenCursor write SetScreenCursor
      default gcrSQLWait;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
  end;

implementation

uses
  FireDAC.Stan.Util, FireDAC.Stan.Factory, FireDAC.Stan.ResStrs,
  FireDAC.Phys.Intf;

{-------------------------------------------------------------------------------}
{ TFDGUIxComponent                                                              }
{-------------------------------------------------------------------------------}
function TFDGUIxComponent.GetProvider: String;
begin
  if FProviderSpecified then
    Result := FProvider
  else
    Result := FFDGUIxProvider;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxComponent.SetProvider(const AValue: String);
begin
  FProvider := AValue;
  FProviderSpecified := FProvider <> '';
end;

{-------------------------------------------------------------------------------}
class function TFDGUIxComponent.GetGUID: TGUID;
begin
  FillChar(Result, SizeOf(TGUID), 0);
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxAsyncExecuteDialog                                                     }
{-------------------------------------------------------------------------------}
constructor TFDGUIxAsyncExecuteDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCaption := S_FD_AsyncDialogDefCaption;
  FPrompt := S_FD_AsyncDialogDefPrompt;
  FShowDelay := C_FD_DelayBeforeFWait;
  FHideDelay := C_FD_DelayBeforeFWait;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxAsyncExecuteDialog.Destroy;
begin
  if FAsyncDialog <> nil then begin
    (FAsyncDialog as IFDStanComponentReference).SetComponentReference(nil);
    FAsyncDialog.OnShow := nil;
    FAsyncDialog.OnHide := nil;
    FAsyncDialog := nil;
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TFDGUIxAsyncExecuteDialog.GetGUID: TGUID;
begin
  Result := IFDGUIxAsyncExecuteDialog;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxAsyncExecuteDialog.Loaded;
var
  oDlg: IFDGUIxAsyncExecuteDialog;
begin
  inherited Loaded;
  oDlg := GetAsyncDialog;
  oDlg.Caption := FCaption;
  oDlg.Prompt := FPrompt;
  oDlg.ShowDelay := FShowDelay;
  oDlg.HideDelay := FHideDelay;
  oDlg.OnShow := DoOnShow;
  oDlg.OnHide := DoOnHide;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxAsyncExecuteDialog.GetAsyncDialog: IFDGUIxAsyncExecuteDialog;
begin
  if FAsyncDialog = nil then begin
    FDCreateInterface(IFDGUIxAsyncExecuteDialog, FAsyncDialog, True, Provider);
    (FAsyncDialog as IFDStanComponentReference).SetComponentReference(
      Self as IInterfaceComponentReference);
  end;
  Result := FAsyncDialog;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxAsyncExecuteDialog.DoOnHide(ASender: TObject);
begin
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxAsyncExecuteDialog.DoOnShow(ASender: TObject);
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

{-------------------------------------------------------------------------------}
function TFDGUIxAsyncExecuteDialog.GetCaption: String;
begin
  if not (csLoading in ComponentState) then
    Result := GetAsyncDialog.Caption
  else
    Result := FCaption;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxAsyncExecuteDialog.SetCaption(const AValue: String);
begin
  FCaption := AValue;
  if not (csLoading in ComponentState) then
    GetAsyncDialog.Caption := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxAsyncExecuteDialog.IsCS: Boolean;
begin
  Result := Caption <> S_FD_AsyncDialogDefCaption;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxAsyncExecuteDialog.GetPrompt: String;
begin
  if not (csLoading in ComponentState) then
    Result := GetAsyncDialog.Prompt
  else
    Result := FPrompt;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxAsyncExecuteDialog.SetPrompt(const AValue: String);
begin
  FPrompt := AValue;
  if not (csLoading in ComponentState) then
    GetAsyncDialog.Prompt := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxAsyncExecuteDialog.IsPS: Boolean;
begin
  Result := Prompt <> S_FD_AsyncDialogDefPrompt;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxAsyncExecuteDialog.GetShowDelay: Integer;
begin
  if not (csLoading in ComponentState) then
    Result := GetAsyncDialog.ShowDelay
  else
    Result := FShowDelay;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxAsyncExecuteDialog.SetShowDelay(const AValue: Integer);
begin
  FShowDelay := AValue;
  if not (csLoading in ComponentState) then
    GetAsyncDialog.ShowDelay := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxAsyncExecuteDialog.GetHideDelay: Integer;
begin
  if not (csLoading in ComponentState) then
    Result := GetAsyncDialog.HideDelay
  else
    Result := FHideDelay;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxAsyncExecuteDialog.SetHideDelay(const AValue: Integer);
begin
  FHideDelay := AValue;
  if not (csLoading in ComponentState) then
    GetAsyncDialog.HideDelay := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxErrorDialog                                                            }
{-------------------------------------------------------------------------------}
constructor TFDGUIxErrorDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCaption := S_FD_ErrorDialogDefCaption;
  FEnabled := True;
  FStayOnTop := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxErrorDialog.Destroy;
begin
  if FErrorDialog <> nil then begin
    (FErrorDialog as IFDStanComponentReference).SetComponentReference(nil);
    FErrorDialog.OnShow := nil;
    FErrorDialog.OnHide := nil;
    FErrorDialog := nil;
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TFDGUIxErrorDialog.GetGUID: TGUID;
begin
  Result := IFDGUIxErrorDialog;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxErrorDialog.GetErrorDialog: IFDGUIxErrorDialog;
begin
  if FErrorDialog = nil then begin
    FDCreateInterface(IFDGUIxErrorDialog, FErrorDialog, True, Provider);
    (FErrorDialog as IFDStanComponentReference).SetComponentReference(
      Self as IInterfaceComponentReference);
  end;
  Result := FErrorDialog;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxErrorDialog.Loaded;
var
  oDlg: IFDGUIxErrorDialog;
begin
  inherited Loaded;
  oDlg := GetErrorDialog;
  oDlg.Caption := FCaption;
  oDlg.Enabled := FEnabled;
  oDlg.StayOnTop := FStayOnTop;
  oDlg.OnShow := DoOnShow;
  oDlg.OnHide := DoOnHide;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxErrorDialog.DoOnHide(ASender: TObject;
  AException: EFDDBEngineException);
begin
  if Assigned(FOnHide) then
    FOnHide(Self, AException);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxErrorDialog.DoOnShow(ASender: TObject;
  AException: EFDDBEngineException);
begin
  if Assigned(FOnShow) then
    FOnShow(Self, AException);
end;

{-------------------------------------------------------------------------------}
function TFDGUIxErrorDialog.GetCaption: String;
begin
  if not (csLoading in ComponentState) then
    Result := GetErrorDialog.Caption
  else
    Result := FCaption;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxErrorDialog.IsCS: Boolean;
begin
  Result := Caption <> S_FD_ErrorDialogDefCaption;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxErrorDialog.SetCaption(const AValue: String);
begin
  FCaption := AValue;
  if not (csLoading in ComponentState) then
    GetErrorDialog.Caption := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxErrorDialog.GetEnabled: Boolean;
begin
  if not (csLoading in ComponentState) then
    Result := GetErrorDialog.Enabled
  else
    Result := FEnabled;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxErrorDialog.SetEnabled(const AValue: Boolean);
begin
  FEnabled := AValue;
  if not (csLoading in ComponentState) then
    GetErrorDialog.Enabled := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxErrorDialog.GetStayOnTop: Boolean;
begin
  if not (csLoading in ComponentState) then
    Result := GetErrorDialog.StayOnTop
  else
    Result := FStayOnTop;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxErrorDialog.SetStayOnTop(const AValue: Boolean);
begin
  FStayOnTop := AValue;
  if not (csLoading in ComponentState) then
    GetErrorDialog.StayOnTop := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxErrorDialog.Execute(E: EFDDBEngineException);
begin
  FErrorDialog.Execute(E);
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxLoginDialog                                                            }
{-------------------------------------------------------------------------------}
constructor TFDGUIxLoginDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisibleItems := TFDStringList.Create;
  FCaption := S_FD_LoginDialogDefCaption;
  FHistoryWithPassword := True;
  FHistoryStorage := hsRegistry;
  FHistoryKey := {$IFDEF MSWINDOWS} S_FD_CfgKeyName + '\' + S_FD_Profiles {$ENDIF}
                 {$IFDEF POSIX} S_FD_Profiles {$ENDIF};
  FLoginRetries := 3;
  FChangeExpiredPassword := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxLoginDialog.Destroy;
begin
  if FLoginDialog <> nil then begin
    (FLoginDialog as IFDStanComponentReference).SetComponentReference(nil);
    FLoginDialog.OnLogin := nil;
    FLoginDialog.OnChangePassword := nil;
    FLoginDialog.OnShow := nil;
    FLoginDialog.OnHide := nil;
    FLoginDialog := nil;
    FDFreeAndNil(FVisibleItems);
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TFDGUIxLoginDialog.GetGUID: TGUID;
begin
  Result := IFDGUIxLoginDialog;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetLoginDialog: IFDGUIxLoginDialog;
begin
  if FLoginDialog = nil then begin
    FDCreateInterface(IFDGUIxLoginDialog, FLoginDialog, True, Provider);
    (FLoginDialog as IFDStanComponentReference).SetComponentReference(
      Self as IInterfaceComponentReference);
  end;
  Result := FLoginDialog;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.Loaded;
var
  oDlg: IFDGUIxLoginDialog;
begin
  inherited Loaded;
  oDlg := GetLoginDialog;
  oDlg.ConnectionDef := FConnectionDef;
  oDlg.Caption := FCaption;
  oDlg.HistoryEnabled := FHistoryEnabled;
  oDlg.HistoryWithPassword := FHistoryWithPassword;
  oDlg.HistoryStorage := FHistoryStorage;
  oDlg.HistoryKey := FHistoryKey;
  oDlg.VisibleItems := FVisibleItems;
  oDlg.LoginRetries := FLoginRetries;
  oDlg.ChangeExpiredPassword := FChangeExpiredPassword;
  if Assigned(FOnLogin) then
    oDlg.OnLogin := DoLogin;
  if Assigned(FOnChangePassword) then
    oDlg.OnChangePassword := DoChangePassword;
  oDlg.OnShow := DoOnShow;
  oDlg.OnHide := DoOnHide;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.DoLogin(ASender: TObject; var AResult: Boolean);
begin
  if Assigned(FOnLogin) then
    FOnLogin(Self, AResult);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.DoChangePassword(ASender: TObject; var AResult: Boolean);
begin
  if Assigned(FOnChangePassword) then
    FOnChangePassword(Self, AResult);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.DoOnShow(ASender: TObject);
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.DoOnHide(ASender: TObject);
begin
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetOnChangePassword(const AValue: TFDGUIxLoginDialogEvent);
begin
  FOnChangePassword := AValue;
  if not (csLoading in ComponentState) then
    if Assigned(FOnChangePassword) then
      GetLoginDialog.OnChangePassword := DoChangePassword
    else
      GetLoginDialog.OnChangePassword := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetOnLogin(const AValue: TFDGUIxLoginDialogEvent);
begin
  FOnLogin := AValue;
  if not (csLoading in ComponentState) then
    if Assigned(FOnLogin) then
      GetLoginDialog.OnLogin := DoLogin
    else
      GetLoginDialog.OnLogin := nil;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetConnectionDef: IFDStanConnectionDef;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.ConnectionDef
  else
    Result := FConnectionDef;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetCaption: String;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.Caption
  else
    Result := FCaption;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetChangeExpiredPassword: Boolean;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.ChangeExpiredPassword
  else
    Result := FChangeExpiredPassword;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetHistoryEnabled: Boolean;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.HistoryEnabled
  else
    Result := FHistoryEnabled;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetHistoryKey: String;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.HistoryKey
  else
    Result := FHistoryKey;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetHistoryStorage: TFDGUIxLoginHistoryStorage;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.HistoryStorage
  else
    Result := FHistoryStorage;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetHistoryWithPassword: Boolean;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.HistoryWithPassword
  else
    Result := FHistoryWithPassword;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetLoginRetries: Integer;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.LoginRetries
  else
    Result := FLoginRetries;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.GetVisibleItems: TStrings;
begin
  if not (csLoading in ComponentState) then
    Result := GetLoginDialog.VisibleItems
  else
    Result := FVisibleItems;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetCaption(const AValue: String);
begin
  FCaption := AValue;
  if not (csLoading in ComponentState) then
    GetLoginDialog.Caption := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.IsCS: Boolean;
begin
  Result := Caption <> S_FD_LoginDialogDefCaption;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetChangeExpiredPassword(const AValue: Boolean);
begin
  FChangeExpiredPassword := AValue;
  if not (csLoading in ComponentState) then
    GetLoginDialog.ChangeExpiredPassword := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetHistoryEnabled(const AValue: Boolean);
begin
  FHistoryEnabled := AValue;
  if not (csLoading in ComponentState) then
    GetLoginDialog.HistoryEnabled := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetHistoryKey(const AValue: String);
begin
  FHistoryKey := AValue;
  if not (csLoading in ComponentState) then
    GetLoginDialog.HistoryKey := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.IsHKS: Boolean;
begin
  Result := HistoryKey <> ({$IFDEF MSWINDOWS} S_FD_CfgKeyName + '\' + S_FD_Profiles {$ENDIF}
                           {$IFDEF POSIX} S_FD_Profiles {$ENDIF});
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetHistoryStorage(const AValue: TFDGUIxLoginHistoryStorage);
begin
  FHistoryStorage := AValue;
  if not (csLoading in ComponentState) then
    GetLoginDialog.HistoryStorage := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetHistoryWithPassword(const AValue: Boolean);
begin
  FHistoryWithPassword := AValue;
  if not (csLoading in ComponentState) then
    GetLoginDialog.HistoryWithPassword := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetLoginRetries(const AValue: Integer);
begin
  FLoginRetries := AValue;
  if not (csLoading in ComponentState) then
    GetLoginDialog.LoginRetries := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetConnectionDef(const AConnectionDef: IFDStanConnectionDef);
begin
  FConnectionDef := AConnectionDef;
  if not (csLoading in ComponentState) then
    GetLoginDialog.ConnectionDef := AConnectionDef;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.SetVisibleItems(const AValue: TStrings);
begin
  FVisibleItems.SetStrings(AValue);
  if not (csLoading in ComponentState) then
    GetLoginDialog.VisibleItems := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.IsVIS: Boolean;
begin
  Result := not ((VisibleItems.Count = 2) and
    (VisibleItems.IndexOf(S_FD_ConnParam_Common_UserName) >= 0) and
    (VisibleItems.IndexOf(S_FD_ConnParam_Common_Password) >= 0));
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialog.GetAllLoginParams;
begin
  GetLoginDialog.GetAllLoginParams;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialog.Execute(ALoginAction: TFDGUIxLoginAction): Boolean;
begin
  Result := GetLoginDialog.Execute(ALoginAction);
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxScriptDialog                                                           }
{-------------------------------------------------------------------------------}
constructor TFDGUIxScriptDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCaption := S_FD_ScriptDialogDefCaption;
  FOptions := [ssCallstack, ssConsole, ssAutoHide];
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxScriptDialog.Destroy;
begin
  if FScriptDialog <> nil then begin
    (FScriptDialog as IFDStanComponentReference).SetComponentReference(nil);
    FScriptDialog.OnShow := nil;
    FScriptDialog.OnHide := nil;
    FScriptDialog.OnProgress := nil;
    FScriptDialog.OnOutput := nil;
    FScriptDialog.OnInput := nil;
    FScriptDialog.OnPause := nil;
    FScriptDialog := nil;
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TFDGUIxScriptDialog.GetGUID: TGUID;
begin
  Result := IFDGUIxScriptDialog;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptDialog.GetScriptDialog: IFDGUIxScriptDialog;
begin
  if FScriptDialog = nil then begin
    FDCreateInterface(IFDGUIxScriptDialog, FScriptDialog, True, Provider);
    (FScriptDialog as IFDStanComponentReference).SetComponentReference(
      Self as IInterfaceComponentReference);
  end;
  Result := FScriptDialog;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.Loaded;
var
  oDlg: IFDGUIxScriptDialog;
begin
  inherited Loaded;
  oDlg := GetScriptDialog;
  oDlg.Caption := FCaption;
  oDlg.Options := FOptions;
  oDlg.OnShow := DoOnShow;
  oDlg.OnHide := DoOnHide;
  oDlg.OnProgress := DoOnProgress;
  oDlg.OnOutput := DoOnOutput;
  oDlg.OnInput := DoOnInput;
  oDlg.OnPause := DoOnPause;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.DoOnHide(ASender: TObject);
begin
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.DoOnShow(ASender: TObject);
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.DoOnProgress(ASender: TObject; AInfoProvider: TObject);
begin
  if Assigned(FOnProgress) then
    FOnProgress(Self, AInfoProvider);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.DoOnOutput(ASender: TObject;
  const AStr: String);
begin
  if Assigned(FOnOutput) then
    FOnOutput(Self, AStr);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.DoOnInput(ASender: TObject;
  const APrompt: String; var AResult: String);
begin
  if Assigned(FOnInput) then
    FOnInput(Self, APrompt, AResult);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.DoOnPause(ASender: TObject;
  const APrompt: String);
begin
  if Assigned(FOnPause) then
    FOnPause(Self, APrompt);
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptDialog.GetCaption: String;
begin
  if not (csLoading in ComponentState) then
    Result := GetScriptDialog.Caption
  else
    Result := FCaption;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.SetCaption(const AValue: String);
begin
  FCaption := AValue;
  if not (csLoading in ComponentState) then
    GetScriptDialog.Caption := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptDialog.IsCS: Boolean;
begin
  Result := Caption <> S_FD_ScriptDialogDefCaption;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptDialog.GetOptions: TFDGUIxScriptOptions;
begin
  if not (csLoading in ComponentState) then
    Result := GetScriptDialog.Options
  else
    Result := FOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptDialog.SetOptions(const AValue: TFDGUIxScriptOptions);
begin
  FOptions := AValue;
  if not (csLoading in ComponentState) then
    GetScriptDialog.Options := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxWaitCursor                                                             }
{-------------------------------------------------------------------------------}
constructor TFDGUIxWaitCursor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScreenCursor := gcrSQLWait;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxWaitCursor.Destroy;
begin
  if FWaitCursor <> nil then begin
    (FWaitCursor as IFDStanComponentReference).SetComponentReference(nil);
    FWaitCursor.OnShow := nil;
    FWaitCursor.OnHide := nil;
    FWaitCursor := nil;
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TFDGUIxWaitCursor.GetGUID: TGUID;
begin
  Result := IFDGUIxWaitCursor;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxWaitCursor.GetGUIxWaitCursor: IFDGUIxWaitCursor;
begin
  if FWaitCursor = nil then begin
    FDCreateInterface(IFDGUIxWaitCursor, FWaitCursor, True, Provider);
    (FWaitCursor as IFDStanComponentReference).SetComponentReference(
      Self as IInterfaceComponentReference);
  end;
  Result := FWaitCursor;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursor.Loaded;
var
  oCursor: IFDGUIxWaitCursor;
begin
  inherited Loaded;
  oCursor := GetGUIxWaitCursor;
  oCursor.WaitCursor := FScreenCursor;
  oCursor.OnShow := DoOnShow;
  oCursor.OnHide := DoOnHide;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursor.SetProvider(const AValue: String);
begin
  inherited SetProvider(AValue);
  FFDGUIxProvider := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursor.DoOnHide(ASender: TObject);
begin
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursor.DoOnShow(ASender: TObject);
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

{-------------------------------------------------------------------------------}
function TFDGUIxWaitCursor.GetScreenCursor: TFDGUIxScreenCursor;
begin
  if not (csLoading in ComponentState) then
    Result := GetGUIxWaitCursor.WaitCursor
  else
    Result := FScreenCursor;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursor.SetScreenCursor(const AValue: TFDGUIxScreenCursor);
begin
  FScreenCursor := AValue;
  if not (csLoading in ComponentState) then
    GetGUIxWaitCursor.WaitCursor := AValue;
end;

end.
