{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC GUIx layer base classes            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.UI;

interface

uses
  System.Classes, System.IniFiles,
  FireDAC.Stan.Factory, FireDAC.Stan.Intf, FireDAC.Stan.Util, FireDAC.Stan.Consts,
  FireDAC.UI.Intf;

type
  TFDGUIxObject = class(TFDObject)
  protected
    class function IsFactoryEnabled(const AMyProvider, AReqProvider: String): Boolean; override;
  end;

  PFDLoginItem = ^TFDLoginItem;
  TFDLoginItem = record
    FParam: String;
    FType: String;
    FCaption: String;
    FOrder: Integer;
    FValue: String;
  end;

  TFDGUIxLoginDialogImplBase = class(TFDGUIxObject, IFDGUIxLoginDialog)
  private
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FLoginRetries: Integer;
    FOnChangePassword: TFDGUIxLoginDialogEvent;
    FOnLogin: TFDGUIxLoginDialogEvent;
    FChangeExpiredPassword: Boolean;
    function CreateHistoryIniFile: TCustomIniFile;
    function InitParamList: Boolean;
    procedure LoadHistory;
    procedure SaveHistory;
  protected
    // run-time
    FParams: array of TFDLoginItem;
    FHistory: TStrings;
    FHistoryIndex: Integer;
    // setup
    FCaption: String;
    FConnectionDef: IFDStanConnectionDef;
    FHistoryEnabled: Boolean;
    FHistoryKey: String;
    FHistoryStorage: TFDGUIxLoginHistoryStorage;
    FHistoryWithPassword: Boolean;
    FVisibleItems: TStrings;
    // IFDGUIxLoginDialog
    function GetCaption: String;
    function GetChangeExpiredPassword: Boolean;
    function GetHistoryEnabled: Boolean;
    function GetHistoryKey: String;
    function GetHistoryStorage: TFDGUIxLoginHistoryStorage;
    function GetHistoryWithPassword: Boolean;
    function GetLoginRetries: Integer;
    function GetVisibleItems: TStrings;
    function GetConnectionDef: IFDStanConnectionDef;
    function GetOnHide: TNotifyEvent;
    function GetOnShow: TNotifyEvent;
    function GetOnChangePassword: TFDGUIxLoginDialogEvent;
    function GetOnLogin: TFDGUIxLoginDialogEvent;
    procedure SetCaption(const AValue: String);
    procedure SetChangeExpiredPassword(const AValue: Boolean);
    procedure SetHistoryEnabled(const AValue: Boolean);
    procedure SetHistoryKey(const AValue: String);
    procedure SetHistoryStorage(const AValue: TFDGUIxLoginHistoryStorage);
    procedure SetHistoryWithPassword(const AValue: Boolean);
    procedure SetLoginRetries(const AValue: Integer);
    procedure SetVisibleItems(const AValue: TStrings);
    procedure SetConnectionDef(const AValue: IFDStanConnectionDef);
    procedure SetOnHide(const AValue: TNotifyEvent);
    procedure SetOnShow(const AValue: TNotifyEvent);
    procedure SetOnChangePassword(const AValue: TFDGUIxLoginDialogEvent);
    procedure SetOnLogin(const AValue: TFDGUIxLoginDialogEvent);
    function Execute(ALoginAction: TFDGUIxLoginAction): Boolean;
    procedure GetAllLoginParams;
    // Forms & FMX
    function ExecuteLogin: Boolean; virtual; abstract;
    function ExecuteChngPwd: Boolean; virtual; abstract;
    // runtime
    procedure RemoveHistory(const AName: String);
    procedure ReadHistory(const AName: String; AList: TStrings);
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TFDGUIxScriptImplBase = class(TFDGUIxObject, IFDGUIxScriptDialog)
  protected
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FOnProgress: TFDGUIxScriptProgressEvent;
    FOnOutput: TFDGUIxScriptOutputEvent;
    FOnInput: TFDGUIxScriptInputEvent;
    FOnPause: TFDGUIxScriptPauseEvent;
    FCaption: String;
    FOptions: TFDGUIxScriptOptions;
    // IFDGUIxScriptDialog
    function GetOnShow: TNotifyEvent;
    procedure SetOnShow(const AValue: TNotifyEvent);
    function GetOnHide: TNotifyEvent;
    procedure SetOnHide(const AValue: TNotifyEvent);
    function GetOnProgress: TFDGUIxScriptProgressEvent;
    procedure SetOnProgress(const AValue: TFDGUIxScriptProgressEvent);
    function GetOnOutput: TFDGUIxScriptOutputEvent;
    procedure SetOnOutput(const AValue: TFDGUIxScriptOutputEvent);
    function GetOnInput: TFDGUIxScriptInputEvent;
    procedure SetOnInput(const AValue: TFDGUIxScriptInputEvent);
    function GetOnPause: TFDGUIxScriptPauseEvent;
    procedure SetOnPause(const AValue: TFDGUIxScriptPauseEvent);
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function GetOptions: TFDGUIxScriptOptions;
    procedure SetOptions(AValue: TFDGUIxScriptOptions);
    procedure Show; virtual; abstract;
    procedure Progress(const AInfoProvider: IFDGUIxScriptDialogInfoProvider); virtual; abstract;
    procedure Output(const AStr: String; AKind: TFDScriptOutputKind); virtual; abstract;
    procedure Input(const APrompt: String; var AResult: String); virtual; abstract;
    procedure Pause(const APrompt: String); virtual; abstract;
    procedure Hide; virtual; abstract;
  end;

  TFDGUIxVisualScriptImplBase = class(TFDGUIxScriptImplBase)
  public
    procedure Initialize; override;
  end;

  TFDGUIxWaitCursorImplBase = class(TFDGUIxObject, IFDGUIxWaitCursor)
  protected
    FWaitCursor: TFDGUIxScreenCursor;
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    // IFDGUIxWaitCursor
    procedure StartWait; virtual; abstract;
    procedure StopWait; virtual; abstract;
    procedure PushWait; virtual; abstract;
    procedure PopWait; virtual; abstract;
    procedure ForceStopWait; virtual; abstract;
    function GetWaitCursor: TFDGUIxScreenCursor;
    procedure SetWaitCursor(const AValue: TFDGUIxScreenCursor);
    function GetOnShow: TNotifyEvent;
    procedure SetOnShow(const AValue: TNotifyEvent);
    function GetOnHide: TNotifyEvent;
    procedure SetOnHide(const AValue: TNotifyEvent);
  end;

  TFDGUIxVisualWaitCursorImplBase = class(TFDGUIxWaitCursorImplBase)
  private
    FTimer: IFDGUIxTimer;
    FStopRequestTime: Cardinal;
    FWasActive: Integer;
    function IsVisible: Boolean;
    procedure HideCursor;
    procedure ShowCursor;
    procedure TimerProc(ASender: TObject);
    procedure StopTimer;
    procedure StartTimer;
  protected
    function CheckCurCursor: Boolean; virtual; abstract;
    function InternalHideCursor: Boolean; virtual; abstract;
    procedure InternalShowCursor; virtual; abstract;
    // IFDGUIxWaitCursor
    procedure StartWait; override;
    procedure StopWait; override;
    procedure PushWait; override;
    procedure PopWait; override;
    procedure ForceStopWait; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  System.Win.Registry,
{$ENDIF}
  System.SysUtils,
  FireDAC.Stan.ResStrs, FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf;

var
  FWait: TFDGUIxWaitCursorImplBase;

{-------------------------------------------------------------------------------}
{ TFDGUIxObject                                                                 }
{-------------------------------------------------------------------------------}
class function TFDGUIxObject.IsFactoryEnabled(const AMyProvider,
  AReqProvider: String): Boolean;
begin
  if FDIsDesignTime then
    Result := CompareText(AMyProvider, C_FD_GUIxFormsProvider) = 0
  else if AReqProvider = '' then
    Result := CompareText(AMyProvider, FFDGUIxProvider) = 0
  else
    Result := CompareText(AMyProvider, AReqProvider) = 0;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxLoginDialogImplBase                                                    }
{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.Initialize;
begin
  inherited Initialize;
{$IFDEF MSWINDOWS}
  FHistoryStorage := hsRegistry;
  FHistoryKey := S_FD_CfgKeyName + '\' + S_FD_Profiles;
{$ENDIF}
{$IFDEF POSIX}
  FHistoryStorage := hsFile;
  FHistoryKey := S_FD_Profiles;
{$ENDIF}
  FHistoryWithPassword := True;
  FHistoryEnabled := False;
  FHistory := TFDStringList.Create;
  FHistoryIndex := -1;
  FCaption := S_FD_LoginDialogDefCaption;
  FVisibleItems := TFDStringList.Create;
  FVisibleItems.Add(S_FD_ConnParam_Common_UserName);
  FVisibleItems.Add(S_FD_ConnParam_Common_Password);
  FLoginRetries := 3;
  FChangeExpiredPassword := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxLoginDialogImplBase.Destroy;
begin
  FDFreeAndNil(FHistory);
  FDFreeAndNil(FVisibleItems);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetCaption: String;
begin
  Result := FCaption;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetChangeExpiredPassword: Boolean;
begin
  Result := FChangeExpiredPassword;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetConnectionDef: IFDStanConnectionDef;
begin
  Result := FConnectionDef;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetHistoryEnabled: Boolean;
begin
  Result := FHistoryEnabled;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetHistoryKey: String;
begin
  Result := FHistoryKey;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetHistoryStorage: TFDGUIxLoginHistoryStorage;
begin
  Result := FHistoryStorage;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetHistoryWithPassword: Boolean;
begin
  Result := FHistoryWithPassword;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetLoginRetries: Integer;
begin
  Result := FLoginRetries;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetVisibleItems: TStrings;
begin
  Result := FVisibleItems;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetOnHide: TNotifyEvent;
begin
  Result := FOnHide;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetOnShow: TNotifyEvent;
begin
  Result := FOnShow;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetOnChangePassword: TFDGUIxLoginDialogEvent;
begin
  Result := FOnChangePassword;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.GetOnLogin: TFDGUIxLoginDialogEvent;
begin
  Result := FOnLogin;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetOnHide(const AValue: TNotifyEvent);
begin
  FOnHide := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetCaption(const AValue: String);
begin
  FCaption := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetChangeExpiredPassword(const AValue: Boolean);
begin
  FChangeExpiredPassword := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetConnectionDef(const AValue: IFDStanConnectionDef);
begin
  FConnectionDef := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetHistoryEnabled(const AValue: Boolean);
begin
  FHistoryEnabled := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetHistoryKey(const AValue: String);
begin
  FHistoryKey := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetHistoryStorage(const AValue: TFDGUIxLoginHistoryStorage);
begin
  FHistoryStorage := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetHistoryWithPassword(const AValue: Boolean);
begin
  FHistoryWithPassword := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetLoginRetries(const AValue: Integer);
begin
  FLoginRetries := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetVisibleItems(const AValue: TStrings);
begin
  FVisibleItems.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetOnShow(const AValue: TNotifyEvent);
begin
  FOnShow := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetOnChangePassword(const AValue: TFDGUIxLoginDialogEvent);
begin
  FOnChangePassword := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SetOnLogin(const AValue: TFDGUIxLoginDialogEvent);
begin
  FOnLogin := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.GetAllLoginParams;
var
  oMeta: IFDPhysManagerMetadata;
  oDrv: IFDPhysDriverMetadata;
  i: Integer;
  oTab: TFDDatSTable;
begin
  FDPhysManager.CreateMetadata(oMeta);
  if FDPhysManager.State <> dmsActive then
    FDPhysManager.Open;
  oMeta.CreateDriverMetadata(FConnectionDef.Params.DriverID, oDrv);
  oTab := oDrv.GetConnParams(FConnectionDef.Params);
  try
    FVisibleItems.Clear;
    for i := 0 to oTab.Rows.Count - 1 do
      if oTab.Rows[i].GetData('LoginIndex') <> -1 then
        FVisibleItems.Add(oTab.Rows[i].GetData('Name') + '=' + oTab.Rows[i].GetData('Caption'));
  finally
    FDFree(oTab);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.InitParamList: Boolean;
var
  oMeta: IFDPhysManagerMetadata;
  oDrv: IFDPhysDriverMetadata;
  i: Integer;
  oTab: TFDDatSTable;

  procedure AddItem(const AName, AType, ACaption: String; AOrder: Integer;
    const AValue: String);
  var
    i: Integer;
    s, sCaption: String;
    lOk: Boolean;
    pParam: PFDLoginItem;
  begin
    sCaption := ACaption;
    lOk := FVisibleItems.Count = 0;
    if not lOk then begin
      for i := 0 to FVisibleItems.Count - 1 do
        if CompareText(FVisibleItems.KeyNames[i], AName) = 0 then begin
          s := FVisibleItems.ValueFromIndex[i];
          if s <> '' then
            sCaption := s;
          lOk := True;
          Break;
        end;
      if not lOk then begin
        s := Trim(FVisibleItems.Text);
        lOk := (s = '') or (s = '*');
      end;
    end;
    if lOk then begin
      SetLength(FParams, Length(FParams) + 1);
      pParam := @FParams[Length(FParams) - 1];
      pParam^.FParam := AName;
      pParam^.FType := AType;
      pParam^.FCaption := sCaption;
      pParam^.FOrder := AOrder;
      pParam^.FValue := AValue;
    end;
  end;

begin
  SetLength(FParams, 0);
  if FDPhysManager.State = dmsInactive then
    FDPhysManager.Open;
  FDPhysManager.CreateMetadata(oMeta);
  oMeta.CreateDriverMetadata(FConnectionDef.Params.DriverID, oDrv);
  oTab := oDrv.GetConnParams(FConnectionDef.Params);
  try
    for i := 0 to oTab.Rows.Count - 1 do
      if oTab.Rows[i].GetData('LoginIndex') <> -1 then
        AddItem(oTab.Rows[i].GetData('Name'), oTab.Rows[i].GetData('Type'),
          oTab.Rows[i].GetData('Caption'), oTab.Rows[i].GetData('LoginIndex'),
          FConnectionDef.AsString[oTab.Rows[i].GetData('Name')]);
  finally
    FDFree(oTab);
  end;
  Result := Length(FParams) > 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.LoadHistory;
var
  oIni: TCustomIniFile;
  i: Integer;
begin
  FHistoryIndex := -1;
  FHistory.Clear;
  if FHistoryEnabled then begin
    oIni := CreateHistoryIniFile;
    try
      oIni.ReadSections(FHistory);
      i := 0;
      while i < FHistory.Count do
        if Pos(FConnectionDef.Params.DriverID + ' - ', FHistory[i]) = 0 then
          FHistory.Delete(i)
        else begin
          FHistory[i] := FDStrReplace(FHistory[i], '/', '\');
          Inc(i);
        end;
      FHistoryIndex := FHistory.IndexOf(FConnectionDef.Params.DriverID + ' - ' +
        AnsiUpperCase(FConnectionDef.Params.Database) + ' - ' + FConnectionDef.Params.UserName);
    finally
      FDFree(oIni);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.SaveHistory;
var
  oIni: TCustomIniFile;
  i: Integer;
  sName: String;
begin
  if FHistoryEnabled then begin
    oIni := CreateHistoryIniFile;
    try
      sName := FConnectionDef.Params.DriverID + ' - ' +
        FDStrReplace(AnsiUpperCase(FConnectionDef.Params.Database), '\', '/') + ' - ' +
        FConnectionDef.Params.UserName;
      oIni.EraseSection(sName);
      for i := 0 to Length(FParams) - 1 do
        if FHistoryWithPassword or
           (CompareText(FParams[i].FParam, S_FD_ConnParam_Common_Password) <> 0) then
          oIni.WriteString(sName, FParams[i].FParam, FConnectionDef.AsString[FParams[i].FParam]);
    finally
      FDFree(oIni);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.CreateHistoryIniFile: TCustomIniFile;
begin
  Result := nil;
  if FHistoryStorage = hsRegistry then
{$IFDEF MSWINDOWS}
    Result := TRegistryIniFile.Create(FHistoryKey)
{$ELSE}
    FDCapabilityNotSupported(nil, [S_FD_LGUIx, S_FD_LGUIx_PForms])
{$ENDIF}
  else if FHistoryStorage = hsFile then begin
    Result := TMemIniFile.Create(FHistoryKey);
    TMemIniFile(Result).AutoSave := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.RemoveHistory(const AName: String);
var
  oIni: TCustomIniFile;
begin
  oIni := CreateHistoryIniFile;
  try
    oIni.EraseSection(FDStrReplace(AName, '\', '/'));
  finally
    FDFree(oIni);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxLoginDialogImplBase.ReadHistory(const AName: String; AList: TStrings);
var
  oIni: TCustomIniFile;
begin
  oIni := CreateHistoryIniFile;
  try
    oIni.ReadSectionValues(FDStrReplace(AName, '\', '/'), AList);
  finally
    FDFree(oIni);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxLoginDialogImplBase.Execute(ALoginAction: TFDGUIxLoginAction): Boolean;
var
  iRetries: Integer;
  lRetry, lLoginPrompt, lInit: Boolean;
begin
  if FConnectionDef = nil then begin
    Result := False;
    Exit;
  end;
  if FDGUIxSilent() then begin
    if Assigned(ALoginAction) then
      ALoginAction;
    Result := True;
    Exit;
  end;
  if Assigned(FOnShow) then
    FOnShow(Self);
  iRetries := 0;
  lRetry := False;
  lLoginPrompt := True;
  lInit := True;
  try
    repeat
      try
        if lLoginPrompt then begin
          if Assigned(FOnLogin) then begin
            Result := True;
            FOnLogin(Self, Result);
          end
          else begin
            if lInit or lRetry then begin
              if not InitParamList then begin
                Result := True;
                Exit;
              end;
              LoadHistory;
              lInit := False;
            end;
            Result := ExecuteLogin;
          end;
        end
        else begin
          lLoginPrompt := True;
          Result := True;
        end;
        if Result and Assigned(ALoginAction) then
          ALoginAction;
        lRetry := False;
      except on E: EFDDBEngineException do
        // invalid password/user name
        if (E.Kind = ekUserPwdInvalid) and (FLoginRetries >= 0) then begin
          FDHandleException;
          Inc(iRetries);
          if iRetries >= FLoginRetries then
            FDException(Self, [S_FD_LGUIx, S_FD_LGUIx_PForms], er_FD_AccToManyLogins,
              [FLoginRetries]);
          lRetry := True;
        end
        // password expired
        else if (E.Kind = ekUserPwdExpired) and FChangeExpiredPassword then begin
          FDHandleException;
          if Assigned(FOnChangePassword) then begin
            Result := True;
            FOnChangePassword(Self, Result);
          end
          else
            Result := ExecuteChngPwd;
          lLoginPrompt := False;
          lRetry := Result;
        end
        // will expired
        else if E.Kind = ekUserPwdWillExpire then
          FDHandleException
        else
          raise;
      end;
    until not lRetry;
    if Result then begin
      SaveHistory;
      if Assigned(FOnHide) then
        FOnHide(Self);
    end;
  finally
    SetLength(FParams, 0);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxScriptImplBase                                                         }
{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetOnHide: TNotifyEvent;
begin
  Result := FOnHide;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetOnShow: TNotifyEvent;
begin
  Result := FOnShow;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetOnHide(const AValue: TNotifyEvent);
begin
  FOnHide := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetOnShow(const AValue: TNotifyEvent);
begin
  FOnShow := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetOnOutput: TFDGUIxScriptOutputEvent;
begin
  Result := FOnOutput;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetOnOutput(const AValue: TFDGUIxScriptOutputEvent);
begin
  FOnOutput := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetOnInput: TFDGUIxScriptInputEvent;
begin
  Result := FOnInput;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetOnInput(const AValue: TFDGUIxScriptInputEvent);
begin
  FOnInput := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetOnPause: TFDGUIxScriptPauseEvent;
begin
  Result := FOnPause;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetOnPause(const AValue: TFDGUIxScriptPauseEvent);
begin
  FOnPause := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetOnProgress: TFDGUIxScriptProgressEvent;
begin
  Result := FOnProgress;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetOnProgress(const AValue: TFDGUIxScriptProgressEvent);
begin
  FOnProgress := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetCaption: String;
begin
  Result := FCaption;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetCaption(const AValue: String);
begin
  FCaption := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxScriptImplBase.GetOptions: TFDGUIxScriptOptions;
begin
  Result := FOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxScriptImplBase.SetOptions(AValue: TFDGUIxScriptOptions);
begin
  FOptions := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxVisualScriptImplBase                                                   }
{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualScriptImplBase.Initialize;
begin
  inherited Initialize;
  FCaption := S_FD_ScriptDialogDefCaption;
  FOptions := [ssCallstack, ssConsole, ssAutoHide];
  FOnShow := nil;
  FOnHide := nil;
  FOnProgress := nil;
  FOnOutput := nil;
  FOnInput := nil;
  FOnPause := nil;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxWaitCursorImplBase                                                     }
{-------------------------------------------------------------------------------}
function TFDGUIxWaitCursorImplBase.GetWaitCursor: TFDGUIxScreenCursor;
begin
  Result := FWaitCursor;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursorImplBase.SetWaitCursor(const AValue: TFDGUIxScreenCursor);
begin
  FWaitCursor := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxWaitCursorImplBase.GetOnHide: TNotifyEvent;
begin
  Result := FOnHide;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxWaitCursorImplBase.GetOnShow: TNotifyEvent;
begin
  Result := FOnShow;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursorImplBase.SetOnHide(const AValue: TNotifyEvent);
begin
  FOnHide := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxWaitCursorImplBase.SetOnShow(const AValue: TNotifyEvent);
begin
  FOnShow := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxVisualWaitCursorImplBase                                               }
{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.Initialize;
begin
  inherited Initialize;
  FWait := Self;
  FWaitCursor := gcrSQLWait;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxVisualWaitCursorImplBase.Destroy;
begin
  ForceStopWait;
  FTimer := nil;
  inherited Destroy;
  FWait := nil;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxVisualWaitCursorImplBase.IsVisible: Boolean;
begin
  Result := not FDGUIxSilent() and (FWaitCursor <> gcrNone);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.StopTimer;
begin
  FStopRequestTime := 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.TimerProc(ASender: TObject);
begin
  if (FStopRequestTime <> 0) and
     FDTimeout(FStopRequestTime, C_FD_HideCursorDelay) then begin
    if IsVisible then
      HideCursor;
    StopTimer;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.StartTimer;
begin
  if FTimer = nil then begin
    FDCreateInterface(IFDGUIxTimer, FTimer);
    FTimer.SetEvent(TimerProc, C_FD_HideCursorDelay);
  end;
  FTimer.Enabled := True;
  FStopRequestTime := TThread.GetTickCount();
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.ShowCursor;
begin
  if not CheckCurCursor then begin
    if Assigned(FOnShow) then
      FOnShow(Self);
    InternalShowCursor;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.HideCursor;
begin
  if InternalHideCursor then
    if Assigned(FOnHide) then
      FOnHide(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.StartWait;
begin
  if not IsVisible then
    Exit;
  StopTimer;
  ShowCursor;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.StopWait;
begin
  if not IsVisible then
    Exit;
  StartTimer;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.PopWait;
begin
  if not IsVisible then
    Exit;
  if CheckCurCursor then
    if FStopRequestTime > 0 then
      FWasActive := 2
    else
      FWasActive := 1
  else
    FWasActive := 0;
  HideCursor;
  StopTimer;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.PushWait;
begin
  if not IsVisible then
    Exit;
  case FWasActive of
  2: begin
      ShowCursor;
      StartTimer;
     end;
  1: ShowCursor;
  0: ;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVisualWaitCursorImplBase.ForceStopWait;
begin
  StopTimer;
  if FTimer <> nil then
    FTimer.Enabled := False;
  HideCursor;
  FWasActive := 0;
end;

end.
