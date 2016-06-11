unit MainFormUnit;

interface

uses
  {$IF Defined(MSWINDOWS)}
  Winapi.Windows,
  {$ELSEIF Defined(IOS)}
  Macapi.Helpers, iOSapi.UIKit,
  {$ELSEIF Defined(MACOS)}
  Macapi.Foundation, Macapi.Helpers,
  {$ELSEIF Defined(ANDROID)}
  Androidapi.Helpers, Androidapi.JNI.Os, Androidapi.JNI.JavaTypes,
  {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Generics.Collections,
  System.Tether.Manager, System.Tether.AppProfile, IPPeerClient, IPPeerServer,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Edit,
  FMX.Layouts, FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Ani,
  PreviewFormUnit, StreamingUnit, FMX.Objects;

type
  TConnectionState = (Disconnected, Connected, Connecting, Authenticating);
  TServerEntry = TPair<string, TListViewItem>;

type
  TMainForm = class(TForm)
    tetProfile: TTetheringAppProfile;
    tetManager: TTetheringManager;
    btnConnect: TButton;
    ButtonPane: TPanel;
    lvAvailableIDEs: TListView;
    DiscoveringPane: TPanel;
    lblDiscovering: TLabel;
    anDiscoveringPaneOpacity: TFloatAnimation;
    btnAdvancedOptions: TButton;
    AppTitlePane: TLayout;
    lblAppName: TLabel;
    lblCompanyName: TLabel;
    imIcon: TImage;
    AppDataPane: TLayout;
    btnRefresh: TButton;
    procedure TetheringAppProfileResources0ResourceReceived(const Sender: TObject; const AResource: TRemoteResource);
    procedure FormCreate(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure tetManagerEndManagersDiscovery(const Sender: TObject; const ARemoteManagers: TTetheringManagerInfoList);
    procedure tetManagerEndProfilesDiscovery(const Sender: TObject; const ARemoteProfiles: TTetheringProfileInfoList);
    procedure ButtonPaneResize(Sender: TObject);
    procedure lvAvailableIDEsDblClick(Sender: TObject);
    procedure btnAdvancedOptionsClick(Sender: TObject);
    procedure tetManagerAuthErrorFromRemote(const Sender: TObject; const AManagerIdentifier: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tetManagerError(const Sender, Data: TObject; AError: TTetheringError);
    procedure btnRefreshClick(Sender: TObject);
    procedure tetManagerCommError(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo;
      const AProfileInfo: TTetheringProfileInfo);
    procedure tetManagerNewManager(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo);
    procedure tetManagerPairedToRemote(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo);
    procedure tetManagerRemoteManagerShutdown(const Sender: TObject; const AManagerIdentifier: string);
    procedure tetProfileDisconnect(const Sender: TObject; const AProfileInfo: TTetheringProfileInfo);
  private
    { Private declarations }
    FConnectedToManager: string;
    FConnectingToManager: string;
    FPreviewForm: TPreviewForm;
    FTetResource: TLocalResource;
    FStatus: TConnectionState;
    FServers: TList<TServerEntry>;
    FLastTarget: string;
    procedure ClearForm(AForm: TPreviewForm);
    procedure ConnectTo(const TargetID: string; const APwd: string = string.Empty);
    procedure Disconnect;
    procedure AddServer(const ID, Name, Text, ConnStr: string);
    procedure RemoveServer(const AManagerIdentifier: string);
    procedure UpdateConnectionState;
    procedure ApplyStream(const AStream: TStream);
    procedure LaunchDiscovery(const Address: string = string.Empty);
    procedure DisplayDiscoveringPane(const Address: string);
    procedure DiscoverProfilesOf(AManagerInfo: TTetheringManagerInfo);
    procedure DoUnknownClass(const AClassName: string; out AComponentClass: TComponentClass);
    procedure DoNewUnknownComponent(const AClassName: string; var AComponent: TComponent);
    procedure DoAdvancedOptions(Sender: TObject; const AResult: TModalResult; const AValues: array of string);
    procedure DoPasswordRequested(Sender: TObject; const AResult: TModalResult; const AValues: array of string);
    function GetDeviceName: string;
    function GetOSVersion: string;
    procedure SetStatus(const Value: TConnectionState);

    property Status: TConnectionState read FStatus write SetStatus;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$IF Defined(MSWINDOWS) OR (Defined(MACOS) AND NOT Defined(IOS))}
  {$DEFINE SYNCED_DIALOG}
{$ENDIF}

uses
  System.Math,
  {$IFDEF SYNCED_DIALOG}
  Fmx.DialogService.Sync,
  {$ELSE}
  Fmx.DialogService.Async,
  {$ENDIF}
  Consts;

{$R *.fmx}

{ TMainForm }

procedure TMainForm.DoPasswordRequested(Sender: TObject; const AResult: TModalResult; const AValues: array of string);
var
  LPwd: string;
begin
  if (AResult = mrOk) and (Length(AValues) > 0) then
  begin
    LPwd := AValues[0];
    ConnectTo(FConnectingToManager, LPwd);
  end
  else
  begin
    Status := TConnectionState.Disconnected;
  end;
end;

procedure TMainForm.DoAdvancedOptions(Sender: TObject; const AResult: TModalResult; const AValues: array of string);
begin
  if (AResult = mrOk) and (Length(AValues) > 0) then
  begin
    FLastTarget := AValues[0];
    LaunchDiscovery(FLastTarget);
  end;
end;

procedure TMainForm.btnAdvancedOptionsClick(Sender: TObject);
{$IFDEF SYNCED_DIALOG}
var
  LResult: TModalResult;
  LResults: array[0..0] of string;
begin
  LResults[0] := FLastTarget;
  if TDialogServiceSync.InputQuery(sAdvancedOptions, [sDiscoverTargetsAt], LResults) then
    LResult := mrOk
  else
    LResult := mrCancel;

  DoAdvancedOptions(Self, LResult, LResults);
end;
{$ELSE}
begin
  TDialogServiceAsync.InputQuery(sAdvancedOptions, [sDiscoverTargetsAt], [FLastTarget], DoAdvancedOptions);
end;
{$ENDIF}

procedure TMainForm.btnConnectClick(Sender: TObject);
var
  LSelectedItem: TListViewItem;
  LEntry: TServerEntry;
begin
  if FStatus = TConnectionState.Disconnected then
  begin
    LSelectedItem := TListViewItem(lvAvailableIDEs.Selected);
    for LEntry in FServers do
    begin
      if LEntry.Value = LSelectedItem then
      try
        ConnectTo(LEntry.Key);
      except
        FConnectedToManager := string.Empty;
        Status := TConnectionState.Disconnected;
        ShowMessage('Can not connect to ' + LSelectedItem.Text);
        RemoveServer(LEntry.Key);
      end;
    end;
  end
  else
    Disconnect;

  UpdateConnectionState;
end;

procedure TMainForm.btnRefreshClick(Sender: TObject);
begin
  lvAvailableIDEs.Items.Clear;
  FServers.Clear;
  LaunchDiscovery;
end;

procedure TMainForm.lvAvailableIDEsDblClick(Sender: TObject);
var
  LEntry: TServerEntry;
  LSelectedItem: TListViewItem;
begin
  LSelectedItem := TListViewItem(lvAvailableIDEs.Selected);
  if LSelectedItem <> nil then
  begin
    if FStatus <> TConnectionState.Disconnected then
      Disconnect;

    LSelectedItem := TListViewItem(lvAvailableIDEs.Selected);
    for LEntry in FServers do
    begin
      if LEntry.Value = LSelectedItem then
        ConnectTo(LEntry.Key);
    end;
  end;
end;

procedure TMainForm.tetManagerAuthErrorFromRemote(const Sender: TObject; const AManagerIdentifier: string);
{$IFDEF SYNCED_DIALOG}
var
  LResult: TModalResult;
  LResults: array[0..0] of string;
begin
  // This event is, by design, triggered inside a TThread.Synchronize on a Tethering comm thread
  // It means that when TDialogServiceSync.InputQuery is called, it will completely block that thread,
  // because it is waiting for the Synchronize call to finish. When the dialog is closed and DoPasswordRequest
  // is executed, it will request a Tethering connection again, but it is called from the comm thread
  // and will likely not work. To force the dialog execution by the main thread, a Queue call is needed,
  // but as Queue will detect that it is already being executed by the main thread (Synchorize code is
  // executed by the main thread) it will proceed with the code call inmediately and the result will be
  // the same, that is why we need to create a new thread: to force the queue to work as expected
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Queue(nil,
        procedure
        begin
          // Server requires a password
          Status := TConnectionState.Authenticating;

          if TDialogServiceSync.InputQuery(sServerNeedsAuth, [sPassword],
            LResults) then
            LResult := mrOk
          else
            LResult := mrCancel;

          DoPasswordRequested(Self, LResult, LResults);
        end)
    end).Start;
end;
{$ELSE}
begin
  Status := TConnectionState.Authenticating;

  TDialogServiceAsync.InputQuery(sServerNeedsAuth, [sPassword], [string.Empty], DoPasswordRequested);
end;
{$ENDIF}

procedure TMainForm.tetManagerCommError(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo;
  const AProfileInfo: TTetheringProfileInfo);
begin
  tetProfileDisconnect(Sender, AProfileInfo);
  RemoveServer(AManagerInfo.ManagerIdentifier);
end;

procedure TMainForm.tetManagerEndManagersDiscovery(const Sender: TObject; const ARemoteManagers: TTetheringManagerInfoList);
var
  n: Integer;
  LRemoteManager: TTetheringManagerInfo;
begin
  for n := 0 to ARemoteManagers.Count - 1 do
  begin
    LRemoteManager := ARemoteManagers.Items[n];
    AddServer(LRemoteManager.ManagerIdentifier, LRemoteManager.ManagerName,
      LRemoteManager.ManagerText, LRemoteManager.ConnectionString);
  end;

  DiscoveringPane.Visible := False;
end;

procedure TMainForm.tetManagerEndProfilesDiscovery(const Sender: TObject; const ARemoteProfiles: TTetheringProfileInfoList);
var
  LResult: Boolean;
  LStream: TStream;
  LProfile: TTetheringProfileInfo;
begin
  LResult := False;
  if (ARemoteProfiles <> nil) and not FConnectingToManager.IsEmpty then
  begin
    for LProfile in ARemoteProfiles do
    begin
      if SameText(LProfile.ManagerIdentifier, FConnectingToManager) then
      begin
        LResult := tetProfile.Connect(LProfile);
        if LResult then
          FConnectedToManager := LProfile.ManagerIdentifier
      end;
    end;
  end;

  FConnectingToManager := string.Empty;

  if LResult then
  begin
    LStream := tetProfile.Resources.FindByName(cFormStreamResourceName).Value.AsStream;
    ApplyStream(LStream);
    Status := TConnectionState.Connected;
  end
  else
  begin
    Status := TConnectionState.Disconnected;
  end;

end;

procedure TMainForm.tetManagerError(const Sender, Data: TObject; AError: TTetheringError);
begin
  Disconnect;
end;

procedure TMainForm.tetManagerNewManager(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo);
begin
  AddServer(AManagerInfo.ManagerIdentifier, AManagerInfo.ManagerName,
    AManagerInfo.ManagerText, AManagerInfo.ConnectionString);
end;

procedure TMainForm.tetManagerPairedToRemote(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo);
begin
//  DiscoverProfilesOf(AManagerInfo);
end;

procedure TMainForm.tetManagerRemoteManagerShutdown(const Sender: TObject; const AManagerIdentifier: string);
begin
  RemoveServer(AManagerIdentifier);
end;

procedure TMainForm.tetProfileDisconnect(const Sender: TObject; const AProfileInfo: TTetheringProfileInfo);
begin
  Status := TConnectionState.Disconnected;
  ClearForm(FPreviewForm);
  FPreviewForm.Close;
end;

procedure TMainForm.ConnectTo(const TargetID: string; const APwd: string);
var
  LManager: TTetheringManagerInfo;
begin
  tetManager.Password := APwd;

  FConnectingToManager := TargetID;
  FConnectedToManager := string.Empty;
  Status := TConnectionState.Connecting;

  for LManager in tetManager.RemoteManagers do
  begin
    if SameText(LManager.ManagerIdentifier, TargetID) then
        tetManager.PairManager(LManager);
  end;
end;

procedure TMainForm.Disconnect;
var
  LManager: TTetheringManagerInfo;
  LProfile: TTetheringProfileInfo;
begin
  if FStatus <> TConnectionState.Disconnected then
  begin
    FPreviewForm.Close;
    ClearForm(FPreviewForm);
    for LProfile in tetProfile.ConnectedProfiles do
      tetProfile.Disconnect(LProfile);
    for LManager in tetManager.PairedManagers do
    begin
      tetManager.UnPairManager(LManager);
                                                                                    
      // UnPairManager remove the Manager from RemoteManagers, so we add it again
      tetManager.RemoteManagers.Add(LManager);
    end;
    FConnectedToManager := string.Empty;
    Status := TConnectionState.Disconnected;
  end;
end;

procedure TMainForm.ButtonPaneResize(Sender: TObject);
const
  cButtonDefSize = 200;
var
  LSize: Single;
begin
  LSize := (ButtonPane.Width - btnConnect.Margins.Left - btnConnect.Margins.Right
    - btnAdvancedOptions.Margins.Left - btnAdvancedOptions.Margins.Right) / 2;
  LSize := Min(LSize, cButtonDefSize);
  btnConnect.Width := LSize;
  btnAdvancedOptions.Width := LSize;
end;

procedure TMainForm.UpdateConnectionState;
begin
  case FStatus of
    TConnectionState.Connected:
    begin
      btnConnect.Text := sDisconnect;
      btnConnect.Enabled := True;
      btnAdvancedOptions.Enabled := True;
    end;
    TConnectionState.Disconnected:
    begin
      btnConnect.Text := sConnect;
      btnConnect.Enabled := True;
      btnAdvancedOptions.Enabled := True;
    end;
    TConnectionState.Connecting:
    begin
      btnConnect.Text := sConnecting;
      btnConnect.Enabled := True;
      btnAdvancedOptions.Enabled := False;
    end;
    TConnectionState.Authenticating:
    begin
      btnConnect.Text := sAuthenticating;
      btnConnect.Enabled := False;
      btnAdvancedOptions.Enabled := False;
    end;
  end;
end;

function TMainForm.GetDeviceName: string;
{$IF Defined(MSWINDOWS)}
var
  LSize: Cardinal;
  LName: array[0..MAX_PATH - 1] of Char;
begin
  LSize := SizeOf(LName);
  if GetComputerName(LName, LSize) then
    Result := LName
  else
    Result := string.Empty;
end;
{$ELSEIF Defined(ANDROID)}
begin
  Result := JStringToString(TJBuild.JavaClass.MODEL);
end;
{$ELSEIF Defined(IOS)}
begin
  Result := NSStrToStr(TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).name);
end;
{$ELSEIF Defined(MACOS)}
var
  LHost: NSHost;
begin
  LHost := TNSHost.Wrap(TNSHost.OCClass.currentHost);
  Result := NSStrToStr(LHost.localizedName);
end;
{$ENDIF}

function TMainForm.GetOSVersion: string;
begin
  Result := TOSVersion.ToString;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Disconnect;

  tetProfile.Enabled := False;
  tetManager.Enabled := False;

  FPreviewForm.DisposeOf;
  FPreviewForm := nil;

  FServers.Free;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  LPlatform: Integer;
begin
  FLastTarget := string.Empty;
  DiscoveringPane.Visible := False;
  FServers := TList<TServerEntry>.Create;

  btnConnect.Text := sConnect;

  lblAppName.Text := Format(sAppNameFormat, [sAppName, sAppVersion]);

  FPreviewForm := TPreviewForm.Create(nil);
  FPreviewForm.Visible := False;

  FConnectingToManager := string.Empty;
  FConnectedToManager := string.Empty;

  tetManager.Text := cLivePreviewManagerClientText;
  tetProfile.Text := cLivePreviewProfileClientText;

  tetProfile.Group := cLivePreviewGroup;

  tetManager.Enabled := True;
  tetProfile.Enabled := True;
  FTetResource := tetProfile.Resources.FindByName(cFormStreamResourceName);

  tetProfile.Resources.FindByName(cDevicNameResourceName).Value := GetDeviceName;
  tetProfile.Resources.FindByName(cDeviceDescriptionResourceName).Value := GetOSVersion;

  LPlatform := Ord(TOSVersion.Platform);
  tetProfile.Resources.FindByName(cDevicePlatformResourceName).Value := LPlatform;
  tetProfile.Resources.FindByName(cDeviceProtocolResourceName).Value := cDeviceProtocol;

  LaunchDiscovery;
end;

procedure TMainForm.ClearForm(AForm: TPreviewForm);
begin
  AForm.Clear;
end;

procedure TMainForm.DisplayDiscoveringPane(const Address: string);
begin
  if Address.IsEmpty then
    lblDiscovering.Text := sDiscoveringNoIP
  else
    lblDiscovering.Text := Format(sDiscoveringIP, [Address]);
  DiscoveringPane.Opacity := 0;
  DiscoveringPane.Visible := True;
  anDiscoveringPaneOpacity.Start;
end;

procedure TMainForm.LaunchDiscovery(const Address: string);
begin
  DisplayDiscoveringPane(Address);
  tetManager.DiscoverManagers(Address);
end;

procedure TMainForm.DoUnknownClass(const AClassName: string; out AComponentClass: TComponentClass);
begin
end;

procedure TMainForm.DoNewUnknownComponent(const AClassName: string; var AComponent: TComponent);
begin
end;

procedure TMainForm.ApplyStream(const AStream: TStream);
var
  LReader: TPreviewReader;
begin
  if AStream <> nil then
  begin
    AStream.Position := 0;
    LReader := TPreviewReader.Create(AStream, 4096);
    try
      LReader.OnUnknownClass := DoUnknownClass;
      LReader.OnNewUnknownComponent := DoNewUnknownComponent;
      FPreviewForm.BeginUpdate;
      try
        ClearForm(FPreviewForm);
        LReader.ReadRootComponent(FPreviewForm);
      finally
        FPreviewForm.EndUpdate;
      end;
    finally
      LReader.DisposeOf;
    end;

  end;

  FPreviewForm.Visible := True;
end;

procedure TMainForm.TetheringAppProfileResources0ResourceReceived(const Sender: TObject; const AResource: TRemoteResource);
var
  LStream: TStream;
begin
  LStream := AResource.Value.AsStream;
  ApplyStream(LStream);
end;

procedure TMainForm.AddServer(const ID, Name, Text, ConnStr: string);
var
  LEntry: TServerEntry;
  LItem: TListViewItem;
  LConnStr: string;
  LIndex: Integer;
  LText: string;
begin
  LIndex := Text.IndexOf(cLivePreviewServerManagerText);
  if LIndex >= 0 then
  begin
    LItem := nil;
    for LEntry in FServers do
    begin
      if SameText(LEntry.Key, ID) then
      begin
        LItem := LEntry.Value;
        Break;
      end;
    end;

    if LItem = nil then
    begin
      LItem := lvAvailableIDEs.Items.Add;
      LEntry.Key := ID;
      LEntry.Value := LItem;
      FServers.Add(LEntry);
    end;

    if (LIndex = 0) then
      LIndex := Text.Length + 1;
    LText := Text.Substring(0, LIndex - 1);
    LConnStr := ConnStr.Substring(0, ConnStr.IndexOf('$'));
    LItem.Text := Format(sConnDetail, [LText, LConnStr]);
  end;
end;

procedure TMainForm.RemoveServer(const AManagerIdentifier: string);
var
  n: Integer;
  LEntry: TServerEntry;
begin
  for LEntry in FServers do
  begin
    if SameStr(LEntry.Key, AManagerIdentifier) then
    begin
      n := lvAvailableIDES.Items.IndexOf(LEntry.Value);
      if (n >= 0) then
        lvAvailableIDEs.Items.Delete(n);
      FServers.Remove(LEntry);
      Break;
    end;
  end
end;

procedure TMainForm.SetStatus(const Value: TConnectionState);
begin
  FStatus := Value;
  UpdateConnectionState;
end;

procedure TMainForm.DiscoverProfilesOf(AManagerInfo: TTetheringManagerInfo);
begin
  tetManager.DiscoverProfiles(AManagerInfo);
end;

end.
