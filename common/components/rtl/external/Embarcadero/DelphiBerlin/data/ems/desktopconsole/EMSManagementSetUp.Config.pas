{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSManagementSetUp.Config;

interface

uses System.Classes;

type
  TEMSManagementRegistry = class
  public type
    TConnectionProperties = record
    public
      ProfileName: string;
      Host: string;
      Port: integer;
      Protocol: string;
      BaseURL: string;
      ProxyServer: string;
      ProxyPort: integer;
    end;
  public type
    TCredentialsProperties = record
    public
      ServerPassword: string;
      ServerUserName: string;
      UseMasterSecret: Boolean;
      MasterSecret: string;
      AppSecret: string;
      ApplicationID: string;
      GCMAppID: string;
    end;
  public const
    sRegKeyProfiles = '\Software\Embarcadero\EMS\Profiles';
    sEMSConnectionProperties = 'Default';
    sLastProfUsed = 'LastProfileUsed';
    sConnection = 'Connection';
    sCredentials = 'Credentials';
    sProfileName = 'ProfileName';
    sHost = 'Host';
    sPort = 'Port';
    sProtocol = 'Protocol';
    sBaseURL = 'BaseURL';
    sProxyServer = 'ProxyServer';
    sProxyPort = 'ProxyPort';
    sServerPassword = 'Password';
    sServerUserName = 'User';
    sUseMasterSecret = 'UseMasterSevret';
    sMasterSecret = 'MasterSecret';
    sAppSecret = 'AppSecret';
    sApplicationID = 'ApplicationID';
    sGCMAppID = 'GCMAppID';
  private
    FFileName: String;
    FRegSettingMofified: Boolean;
    FConnection: TConnectionProperties;
    FCredentials: TCredentialsProperties;
    procedure SetConnectionRegistry(const Value: TConnectionProperties);
    procedure SetCredentialsRegistry(const Value: TCredentialsProperties);
  public
    property Filename: String read FFileName write FFileName;
    property RegSettingsMofified: Boolean read FRegSettingMofified write FRegSettingMofified;
    property Connection: TConnectionProperties read FConnection write SetConnectionRegistry;
    property Credentials: TCredentialsProperties read FCredentials write SetCredentialsRegistry;
    function SaveProfileToRegistry(const AProfileName: string = ''): Boolean;
    function SavedLastProfileUsed(const AProfileName: string): Boolean;
    function SaveProfileToRegistryAs(AConnection: TConnectionProperties;
      ACredentials: TCredentialsProperties; const AName: string = ''): Boolean;
    function ExportProfiles: Boolean;
    function SaveProfileFile(const AProfileName, ConnectionIndex: string): Boolean;
    function DeleteProfileFromRegistry(const AName: string): Boolean;
    function ImportProfiles: Boolean;
    function LoadProfileFile(const AIndex: string): Boolean;
    function LoadProfileNamesFromRegistry(var AProfilesList: TStringList): Boolean;
    function LoadProfileFromRegistry(const AProfileName: string = ''): Boolean;
    function GetLastProfile: string;
  end;

implementation

uses System.Win.Registry, Winapi.Windows, System.IniFiles,
     System.SysUtils, System.NetEncoding;

{ TEMSManagementRegistry }


function TEMSManagementRegistry.GetLastProfile: string;
var
  LReg: TRegistryIniFile;
begin
  Result := sEMSConnectionProperties;
  LReg := TRegistryIniFile.Create('', KEY_READ);
  try
    if LReg.RegIniFile.OpenKey(sRegKeyProfiles, False) then
    begin
      Result := LReg.ReadString('', sLastProfUsed, sEMSConnectionProperties);
    end
  finally
    LReg.Free;
  end;
end;

function TEMSManagementRegistry.LoadProfileFromRegistry(const AProfileName: string = ''): Boolean;
var
  LReg: TRegistryIniFile;
  LsEMSConnectionProperties: string;
begin
  LsEMSConnectionProperties := sEMSConnectionProperties;
  Result := False;
  if AProfileName <> '' then
    LsEMSConnectionProperties := AProfileName;
  LReg := TRegistryIniFile.Create('', KEY_READ);
  try
    if LReg.RegIniFile.OpenKey(sRegKeyProfiles, False) then
    begin
      SavedLastProfileUsed(AProfileName);
      FConnection.ProfileName := LReg.ReadString(LsEMSConnectionProperties, sProfileName, '');
      FConnection.Host := LReg.ReadString(LsEMSConnectionProperties, sHost, '');
      FConnection.Port := LReg.ReadInteger(LsEMSConnectionProperties, sPort, 0);
      FConnection.Protocol := LReg.ReadString(LsEMSConnectionProperties, sProtocol, '');
      FConnection.BaseURL := LReg.ReadString(LsEMSConnectionProperties, sBaseURL, '');
      FConnection.ProxyServer := LReg.ReadString(LsEMSConnectionProperties, sProxyServer, '');
      FConnection.ProxyPort := LReg.ReadInteger(sEMSConnectionProperties, sProxyPort, 0);

      FCredentials.ServerPassword := TNetEncoding.Base64.Decode((LReg.ReadString(LsEMSConnectionProperties, sServerPassword, '')));
      FCredentials.ServerUserName := LReg.ReadString(LsEMSConnectionProperties, sServerUserName, '');
      FCredentials.UseMasterSecret := LReg.ReadBool(LsEMSConnectionProperties, sUseMasterSecret, False);
      FCredentials.MasterSecret := LReg.ReadString(LsEMSConnectionProperties, sMasterSecret, '');
      FCredentials.AppSecret := LReg.ReadString(LsEMSConnectionProperties, sAppSecret, '');
      FCredentials.ApplicationID := LReg.ReadString(LsEMSConnectionProperties, sApplicationID, '');
      FCredentials.GCMAppID := LReg.ReadString(LsEMSConnectionProperties, sGCMAppID, '');

      Result := True;
    end
  finally
    LReg.Free;
  end;
end;

function TEMSManagementRegistry.DeleteProfileFromRegistry(const AName: string): Boolean;
var
  LReg: TRegistryIniFile;
  LsEMSConnectionProperties: string;
begin
  LsEMSConnectionProperties := sEMSConnectionProperties;
  Result := False;
  LReg := TRegistryIniFile.Create('', KEY_WRITE);
  if AName <> '' then
    LsEMSConnectionProperties := AName;
  try
    if LReg.RegIniFile.OpenKey(sRegKeyProfiles, True) then
    begin
        LReg.EraseSection(AName);
        Result := True;
    end
    else
      Assert(False);
  finally
    LReg.Free;
  end;
end;

function TEMSManagementRegistry.ImportProfiles: Boolean;
var
  I, LIndex: integer;
  LIndexStr: string;
  LProfiles: TStringList;
begin
  LProfiles := TStringList.Create;
  try
    LoadProfileNamesFromRegistry(LProfiles);
    I := 0;
    while LoadProfileFile(IntToStr(I)) do
    begin
      LIndex := 0;
      LIndexStr := '';
      while LProfiles.IndexOf(FConnection.ProfileName + LIndexStr) >= 0 do
      begin
        Inc(LIndex);
        LIndexStr := '.' + IntToStr(LIndex)
      end;
      SaveProfileToRegistry(FConnection.ProfileName + LIndexStr);
      Inc(I);
    end;
    Result := True;
  finally
    LProfiles.Free
  end;
end;

function TEMSManagementRegistry.LoadProfileFile(const AIndex: string): Boolean;
var
  LReg: TIniFile;
begin
  Result := False;
  LReg := TIniFile.Create(FFileName);
  try
    FConnection.ProfileName := LReg.ReadString(sConnection + AIndex, sProfileName, '');
    FConnection.Host := LReg.ReadString(sConnection + AIndex, sHost, '');
    FConnection.Port := LReg.ReadInteger(sConnection + AIndex, sPort, 0);
    FConnection.Protocol := LReg.ReadString(sConnection + AIndex, sProtocol, '');
    FConnection.BaseURL := LReg.ReadString(sConnection + AIndex, sBaseURL, '');
    FConnection.ProxyServer := LReg.ReadString(sConnection + AIndex, sProxyServer, '');
    FConnection.ProxyPort := LReg.ReadInteger(sConnection + AIndex, sProxyPort, 0);

    FCredentials.ServerPassword := TNetEncoding.Base64.Decode(LReg.ReadString(sCredentials + AIndex, sServerPassword, ''));
    FCredentials.ServerUserName := LReg.ReadString(sCredentials + AIndex, sServerUserName, '');
    FCredentials.UseMasterSecret := LReg.ReadBool(sCredentials + AIndex, sUseMasterSecret, False);
    FCredentials.MasterSecret := LReg.ReadString(sCredentials + AIndex, sMasterSecret, '');
    FCredentials.AppSecret := LReg.ReadString(sCredentials + AIndex, sAppSecret, '');
    FCredentials.ApplicationID := LReg.ReadString(sCredentials + AIndex, sApplicationID, '');
    FCredentials.GCMAppID := LReg.ReadString(sCredentials + AIndex, sGCMAppID, '');

    if FConnection.ProfileName <> '' then
      Result := True;
  finally
    LReg.Free;
  end;
end;

function TEMSManagementRegistry.LoadProfileNamesFromRegistry(var AProfilesList: TStringList): Boolean;
var
  LReg: TRegistryIniFile;
begin
  Result := False;
  LReg := TRegistryIniFile.Create('', KEY_READ);
  try
    if LReg.RegIniFile.OpenKey(sRegKeyProfiles, False) then
    begin
        LReg.ReadSections(AProfilesList);
        Result := True;
    end;
  finally
    LReg.Free;
  end;
end;

function TEMSManagementRegistry.SaveProfileToRegistryAs(AConnection: TConnectionProperties;
  ACredentials: TCredentialsProperties; const AName: string = ''): Boolean;
begin
  SetConnectionRegistry(AConnection);
  SetCredentialsRegistry(ACredentials);
  Result := SaveProfileToRegistry(AName);
end;

function TEMSManagementRegistry.SavedLastProfileUsed(const AProfileName: string): Boolean;
var
  LReg: TRegistryIniFile;
  LsEMSConnectionProperties: string;
begin
  LsEMSConnectionProperties := sEMSConnectionProperties;
  Result := False;
  LReg := TRegistryIniFile.Create('', KEY_WRITE);
  if AProfileName <> '' then
    LsEMSConnectionProperties := AProfileName;
  try
    if LReg.RegIniFile.OpenKey(sRegKeyProfiles, True) then
    begin
        LReg.WriteString('', sLastProfUsed, AProfileName);
        Result := True;
    end
    else
      Assert(False);
  finally
    LReg.Free;
  end;
end;

function TEMSManagementRegistry.SaveProfileToRegistry(const AProfileName: string = ''): Boolean;
var
  LReg: TRegistryIniFile;
  LsEMSConnectionProperties: string;
begin
  LsEMSConnectionProperties := sEMSConnectionProperties;
  Result := False;
  LReg := TRegistryIniFile.Create('', KEY_WRITE);
  if AProfileName <> '' then
    LsEMSConnectionProperties := AProfileName;
  try
    if LReg.RegIniFile.OpenKey(sRegKeyProfiles, True) then
    begin
        LReg.WriteString('', sLastProfUsed, AProfileName);
        LReg.WriteString(LsEMSConnectionProperties, sProfileName, AProfileName);
        LReg.WriteString(LsEMSConnectionProperties, sHost, FConnection.Host);
        LReg.WriteInteger(LsEMSConnectionProperties, sPort, FConnection.Port);
        LReg.WriteString(LsEMSConnectionProperties, sProtocol, FConnection.Protocol);
        LReg.WriteString(LsEMSConnectionProperties, sBaseURL, FConnection.BaseURL);
        LReg.WriteString(LsEMSConnectionProperties, sProxyServer, FConnection.ProxyServer);
        LReg.WriteInteger(LsEMSConnectionProperties, sProxyPort, FConnection.ProxyPort);

        LReg.WriteString(LsEMSConnectionProperties, sServerPassword, TNetEncoding.Base64.Encode(FCredentials.ServerPassword));
        LReg.WriteString(LsEMSConnectionProperties, sServerUserName, FCredentials.ServerUserName);
        LReg.WriteBool(LsEMSConnectionProperties, sUseMasterSecret, FCredentials.UseMasterSecret);
        LReg.WriteString(LsEMSConnectionProperties, sMasterSecret, FCredentials.MasterSecret);
        LReg.WriteString(LsEMSConnectionProperties, sAppSecret, FCredentials.AppSecret);
        LReg.WriteString(LsEMSConnectionProperties, sApplicationID, FCredentials.ApplicationID);
        LReg.WriteString(LsEMSConnectionProperties, sGCMAppID, FCredentials.GCMAppID);

        Result := True;
    end
    else
      Assert(False);
  finally
    LReg.Free;
  end;
end;

function TEMSManagementRegistry.ExportProfiles: Boolean;
var
  I: integer;
  LProfiles: TStringList;
begin
  LProfiles := TStringList.Create;
  try
    LoadProfileNamesFromRegistry(LProfiles);
    for I := 0 to LProfiles.Count - 1 do
    begin
      LoadProfileFromRegistry(LProfiles[I]);
      SaveProfileFile(LProfiles[I], IntToStr(I));
    end;
    Result := True;
  finally
    LProfiles.Free;
  end;
end;

function TEMSManagementRegistry.SaveProfileFile(const AProfileName, ConnectionIndex: string): Boolean;
var
  LReg: TIniFile;
begin
  LReg := TIniFile.Create(FFileName);
  try
    LReg.WriteString(sConnection + ConnectionIndex, sProfileName, AProfileName);
    LReg.WriteString(sConnection + ConnectionIndex, sHost, FConnection.Host);
    LReg.WriteInteger(sConnection + ConnectionIndex, sPort, FConnection.Port);
    LReg.WriteString(sConnection + ConnectionIndex, sProtocol, FConnection.Protocol);
    LReg.WriteString(sConnection + ConnectionIndex, sBaseURL, FConnection.BaseURL);
    LReg.WriteString(sConnection + ConnectionIndex, sProxyServer, FConnection.ProxyServer);
    LReg.WriteInteger(sConnection + ConnectionIndex, sProxyPort, FConnection.ProxyPort);

    LReg.WriteString(sCredentials + ConnectionIndex, sServerPassword, TNetEncoding.Base64.Encode(FCredentials.ServerPassword));
    LReg.WriteString(sCredentials + ConnectionIndex, sServerUserName, FCredentials.ServerUserName);
    LReg.WriteBool(sCredentials + ConnectionIndex, sUseMasterSecret, FCredentials.UseMasterSecret);
    LReg.WriteString(sCredentials + ConnectionIndex, sMasterSecret, FCredentials.MasterSecret);
    LReg.WriteString(sCredentials + ConnectionIndex, sAppSecret, FCredentials.AppSecret);
    LReg.WriteString(sCredentials + ConnectionIndex, sApplicationID, FCredentials.ApplicationID);
    LReg.WriteString(sCredentials + ConnectionIndex, sGCMAppID, FCredentials.GCMAppID);

    Result := True;
  finally
    LReg.Free;
  end;
end;

procedure TEMSManagementRegistry.SetConnectionRegistry(
  const Value: TConnectionProperties);
begin
  FConnection := Value;
end;

procedure TEMSManagementRegistry.SetCredentialsRegistry(
  const Value: TCredentialsProperties);
begin
  FCredentials := Value;
end;

end.
