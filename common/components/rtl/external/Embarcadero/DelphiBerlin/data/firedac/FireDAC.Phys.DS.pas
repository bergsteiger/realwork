{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC DataSnap driver                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$IF DEFINED(IOS) OR DEFINED(ANDROID)}
  {$HPPEMIT LINKUNIT}
{$ELSE}
  {$IFDEF WIN32}
    {$HPPEMIT '#pragma link "FireDAC.Phys.DS.obj"'}
  {$ELSE}
    {$HPPEMIT '#pragma link "FireDAC.Phys.DS.o"'}
  {$ENDIF}
{$ENDIF}

unit FireDAC.Phys.DS;

interface

uses
  System.Classes,
  FireDAC.Phys.TDBXBase;

type
  TFDPhysDSDriverLink = class;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or 
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
  TFDPhysDSDriverLink = class(TFDPhysTDBXBaseDriverLink)
  protected
    function GetBaseDriverID: String; override;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils, System.IniFiles, System.Variants, System.JSON, 
  Data.DBXCommon, Data.DbxDatasnap, Data.DbxJSON, Datasnap.DSProxy, Datasnap.DSCommon,
    Data.DBXTransport, Data.DBXPlatform,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.SQLGenerator, FireDAC.Phys.Meta,
    FireDAC.Phys.DSMeta, FireDAC.Phys.DSDef;

type
  TFDPhysDSDriver = class;
  TFDPhysDSConnection = class;
  TFDPhysDSEventAlerter = class;
  TFDPhysDSCommand = class;

  TFDPhysDSDriver = class(TFDPhysTDBXDriverBase)
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  end;

  TFDPhysDSConnection = class(TFDPhysTDBXConnectionBase)
  private
    FProductVersion: TFDVersion;
    function CheckNetworkError(AExc: Exception; AObj: TObject): Boolean;
  protected
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateCommandGenerator(const ACommand: IFDPhysCommand):
      TFDPhysCommandGenerator; override;
    function InternalCreateMetadata: TObject; override;
    procedure InternalConnect; override;
    procedure InternalPing; override;
    procedure CheckDBXDriver; override;
    procedure BuildDBXConnParams(const AConnectionDef: IFDStanConnectionDef;
      AConnProps: TDBXProperties); override;
  end;

  TFDPhysDSEventAlerter = class(TFDPhysEventAlerter)
  private
    FManagers: TFDObjList;
    FCallbacks: TFDStringList;
    function GetDSConn: TFDPhysDSConnection;
  protected
    procedure InternalAllocHandle; override;
    procedure InternalReleaseHandle; override;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); override;
    procedure InternalRegister; override;
    procedure InternalUnregister; override;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); override;
  public
    constructor Create(AConnection: TFDPhysConnection; const AKind: String); override;
    destructor Destroy; override;
    property DSConn: TFDPhysDSConnection read GetDSConn;
  end;

  TFDPhysDSCommand = class(TFDPhysTDBXCommand)
  private
    function GetDSConn: TFDPhysDSConnection;
  protected
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    function InternalOpen: Boolean; override;
    function InternalNextRecordSet: Boolean; override;
    procedure InternalPrepare; override;
  public
    property DSConn: TFDPhysDSConnection read GetDSConn;
  end;

const
  S_FD_TCPIP = 'TCP/IP';
  S_FD_HTTP = 'HTTP';

{-------------------------------------------------------------------------------}
{ TFDPhysDSDriverLink                                                           }
{-------------------------------------------------------------------------------}
function TFDPhysDSDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_DSId;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDSDriver                                                               }
{-------------------------------------------------------------------------------}
class function TFDPhysDSDriver.GetBaseDriverID: String;
begin
  Result := S_FD_DSId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysDSDriver.GetBaseDriverDesc: String;
begin
  Result := 'DataSnap Server';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysDSDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.DataSnap;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysDSDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysDSConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysDSConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
  aList: TDBXStringArray;
  i: Integer;
  s: String;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('LoginIndex', -1);
    oView.Rows[0].EndEdit;
  end;

  aList := TDBXCommunicationLayerFactory.RegisteredLayerList;
  s := '';
  for i := 0 to Length(aList) - 1 do
    s := s + ';' + aList[i];
  s := Copy(s, 2, Length(s));
  Result.Rows.Add([Unassigned, S_FD_ConnParam_DS_Protocol, s, S_FD_TCPIP, S_FD_ConnParam_DS_Protocol, -1]);
  Result.Rows.Add([Unassigned, TDBXPropertyNames.IPImplementationID, '@S', '', TDBXPropertyNames.IPImplementationID, -1]);
  Result.Rows.Add([Unassigned, TDBXPropertyNames.CommunicationIPVersion, ';IP_IPv4;IP_IPv6', '', TDBXPropertyNames.CommunicationIPVersion, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Server, '@S', S_FD_Local, S_FD_ConnParam_Common_Server, 2]);
  if (AKeys <> nil) and
     (Pos(S_FD_HTTP, UpperCase(AKeys.Values[S_FD_ConnParam_DS_Protocol])) > 0) then
    s := '8080'
  else
    s := '211';
  Result.Rows.Add([Unassigned, TDBXPropertyNames.Port, '@I', s, TDBXPropertyNames.Port, 3]);
  Result.Rows.Add([Unassigned, TDBXPropertyNames.BufferKBSize, '@I', '32', TDBXPropertyNames.BufferKBSize, -1]);
  Result.Rows.Add([Unassigned, TDBXPropertyNames.Filters, '@S', '', TDBXPropertyNames.Filters, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_LoginTimeout, '@I', '10000', S_FD_ConnParam_Common_LoginTimeout, -1]);
  Result.Rows.Add([Unassigned, TDBXPropertyNames.CommunicationTimeout, '@I', '', TDBXPropertyNames.CommunicationTimeout, -1]);

  if (AKeys <> nil) and
     (Pos(S_FD_HTTP, UpperCase(AKeys.Values[S_FD_ConnParam_DS_Protocol])) > 0) then begin
    Result.Rows.Add([Unassigned, TDBXPropertyNames.URLPath, '@S', '', TDBXPropertyNames.URLPath, -1]);
    Result.Rows.Add([Unassigned, TDBXPropertyNames.DatasnapContext, '@S', DS_CONTEXT, TDBXPropertyNames.DatasnapContext, -1]);
    Result.Rows.Add([Unassigned, TDBXPropertyNames.DSProxyHost, '@S', '', TDBXPropertyNames.DSProxyHost, -1]);
    Result.Rows.Add([Unassigned, TDBXPropertyNames.DSProxyPort, '@I', '8888', TDBXPropertyNames.DSProxyPort, -1]);
    Result.Rows.Add([Unassigned, TDBXPropertyNames.DSProxyUsername, '@S', '', TDBXPropertyNames.DSProxyUsername, -1]);
    Result.Rows.Add([Unassigned, TDBXPropertyNames.DSProxyPassword, '@S', '', TDBXPropertyNames.DSProxyPassword, -1]);
    Result.Rows.Add([Unassigned, TDBXPropertyNames.DSAuthenticationScheme, ';basic', '', TDBXPropertyNames.DSAuthenticationScheme, -1]);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDSConnection                                                           }
{-------------------------------------------------------------------------------}
function TFDPhysDSConnection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
begin
  if CompareText(AEventKind, S_FD_EventKind_DS_Events) = 0 then
    Result := TFDPhysDSEventAlerter.Create(Self, AEventKind)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysDSCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  Result := TFDPhysCommandGenerator.Create(ACommand);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnection.InternalCreateMetadata: TObject;
begin
  Result := TFDPhysDSMetadata.Create(Self, 0, FProductVersion, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnection.CheckDBXDriver;
begin
  FDriverName := 'DataSnap';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnection.BuildDBXConnParams(
  const AConnectionDef: IFDStanConnectionDef; AConnProps: TDBXProperties);

  procedure SetParam(const ADbxPar, AFDPar, ADef: String);
  var
    s: String;
  begin
    s := AFDPar;
    if s = '' then
      s := ADbxPar;
    s := AConnectionDef.AsString[s];
    if s = '' then
      s := ADef;
    if s <> '' then
      AConnProps.Values[ADbxPar] := s;
  end;

begin
  AConnProps.Values[TDBXPropertyNames.DriverName] := FDriverName;
  AConnProps.Values[TDBXPropertyNames.DriverUnit] := 'Data.DbxDatasnap';
  SetParam(TDBXPropertyNames.CommunicationProtocol, S_FD_ConnParam_DS_Protocol, S_FD_TCPIP);
  SetParam(TDBXPropertyNames.IPImplementationID, '', '');
  SetParam(TDBXPropertyNames.CommunicationIPVersion, '', '');
  SetParam(TDBXPropertyNames.HostName, S_FD_ConnParam_Common_Server, '127.0.0.1');
  if Pos(S_FD_HTTP, UpperCase(AConnectionDef.AsString[S_FD_ConnParam_DS_Protocol])) > 0 then
    SetParam(TDBXPropertyNames.Port, '', '8080')
  else
    SetParam(TDBXPropertyNames.Port, '', '211');
  SetParam(TDBXPropertyNames.BufferKBSize, '', '32');
  SetParam(TDBXPropertyNames.Filters, '', '');
  SetParam(TDBXPropertyNames.ConnectTimeout, S_FD_ConnParam_Common_LoginTimeout, '10000');
  SetParam(TDBXPropertyNames.CommunicationTimeout, '', '');

  SetParam(TDBXPropertyNames.URLPath, '', '');
  SetParam(TDBXPropertyNames.DatasnapContext, '', DS_CONTEXT);
  SetParam(TDBXPropertyNames.DSProxyHost, '', '');
  SetParam(TDBXPropertyNames.DSProxyPort, '', '8888');
  SetParam(TDBXPropertyNames.DSProxyUsername, '', '');
  SetParam(TDBXPropertyNames.DSProxyPassword, '', '');
  SetParam(TDBXPropertyNames.DSAuthenticationUser, S_FD_ConnParam_Common_UserName, '');
  SetParam(TDBXPropertyNames.DSAuthenticationPassword, S_FD_ConnParam_Common_Password, '');
  SetParam(TDBXPropertyNames.DSAuthenticationScheme, '', '');
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnection.CheckNetworkError(AExc: Exception; AObj: TObject): Boolean;
var
  oExc: ETDBXNativeException;
  oExcClass: TClass;
begin
  if (AExc is TDBXError) and (AExc.InnerException <> nil) then
    AExc := AExc.InnerException;
  oExcClass := AExc.ClassType;
  while (oExcClass <> nil) and (CompareText(oExcClass.ClassName, 'EIdException') <> 0) do
    oExcClass := oExcClass.ClassParent;
  if oExcClass <> nil then begin
    oExc := ETDBXNativeException.Create(er_FD_DBXGeneral,
      FDExceptionLayers([S_FD_LPhys, S_FD_TDBXId, S_FD_DSId]) + ' ' + AExc.Message);
    oExc.AppendError(1, TDBXErrorCodes.ConnectionFailed, AExc.Message, '', ekServerGone, -1, -1);
    FDException(AObj, oExc {$IFDEF FireDAC_Monitor}, False {$ENDIF});
    Result := True;
  end
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnection.InternalConnect;
begin
  try
    inherited InternalConnect;
    FProductVersion := FDVerStr2Int(DbxConnection.ProductVersion);
  except
    on E: Exception do
      if not CheckNetworkError(E, Self) then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnection.InternalPing;
begin
  try
    // simplest DataSnap command
    DbxConnection.GetVendorProperty(TDBXPropertyNames.ProductVersion);
  except
    on E: Exception do
      if not CheckNetworkError(E, Self) then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDSEventMessage                                                         }
{-------------------------------------------------------------------------------}
type
  TFDPhysDSEventMessage = class(TFDPhysEventMessage)
  private
    FCBName: String;
    FArgs: Variant;
  public
    constructor Create(const ACBName: String; const AArgs: Variant);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysDSEventMessage.Create(const ACBName: String;
  const AArgs: Variant);
begin
  inherited Create;
  FCBName := ACBName;
  FArgs := AArgs;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDSCallback                                                             }
{-------------------------------------------------------------------------------}
type
  TFDPhysDSCallback = class(TDBXCallback)
  private
    [weak] FAlerter: TFDPhysDSEventAlerter;
    FName: String;
  public
    constructor Create(AAlerter: TFDPhysDSEventAlerter; const AName: String);
    function Execute(const AArg: TJSONValue): TJSONValue; overload; override;
    function Execute(AArg: TObject): TObject; overload; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysDSCallback.Create(AAlerter: TFDPhysDSEventAlerter;
  const AName: String);
begin
  inherited Create;
  FAlerter := AAlerter;
  FName := AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSCallback.Execute(const AArg: TJSONValue): TJSONValue;
var
  V: Variant;
  i: Integer;
begin
  if AArg is TJSONArray then begin
    V := VarArrayCreate([0, TJSONArray(AArg).Count - 1], varUString);
    for i := 0 to TJSONArray(AArg).Count - 1 do
      V[i] := TJSONArray(AArg).Items[i].Value;
  end
  else
    V := AArg.Value;

  if FAlerter.IsRunning then
    FAlerter.FMsgThread.EnqueueMsg(TFDPhysDSEventMessage.Create(FName, V));

  Result := TJSONTrue.Create;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSCallback.Execute(AArg: TObject): TObject;
begin
  Result := Execute(TDSClientCallbackChannelManager(FAlerter.FManagers[0]).
    MarshalData(AArg));
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDSEventAlerter                                                         }
{-------------------------------------------------------------------------------}
constructor TFDPhysDSEventAlerter.Create(AConnection: TFDPhysConnection;
  const AKind: String);
begin
  inherited Create(AConnection, AKind);
  FManagers := TFDObjList.Create;
  FCallbacks := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysDSEventAlerter.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FManagers);
  FDFreeAndNil(FCallbacks);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSEventAlerter.GetDSConn: TFDPhysDSConnection;
begin
  Result := TFDPhysDSConnection(ConnectionObj);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSEventAlerter.InternalAllocHandle;
var
  oDef: IFDStanConnectionDef;
  oParams: TFDPhysDSConnectionDefParams;
  oNames: TStrings;
  i: Integer;
  oMan: TDSClientCallbackChannelManager;
  sCBName: String;
  sChnlName: String;

  function Def(const AValue, ADef: String): String;
  begin
    if AValue = '' then
      Result := ADef
    else
      Result := AValue;
  end;

  function GenSessionId: String;
  begin
    Result := TDSSessionHelper.GenerateSessionId;
  end;

begin
  oDef := DSConn.ConnectionDef;
  oParams := oDef.Params as TFDPhysDSConnectionDefParams;
  oNames := GetNames;

  for i := 0 to oNames.Count - 1 do begin
    oMan := TDSClientCallbackChannelManager.Create(nil);
    FManagers.Add(oMan);

    oMan.CommunicationProtocol := Def(oDef.AsString[S_FD_ConnParam_DS_Protocol], S_FD_TCPIP);
    oMan.IPImplementationID := oParams.IPImplementationID;
    oMan.DSHostname := oParams.Server;
    if CompareText(oMan.CommunicationProtocol, S_FD_TCPIP) = 0 then
      oMan.DSPort := Def(oDef.AsString[S_FD_ConnParam_Common_Port], '211')
    else
      oMan.DSPort := Def(oDef.AsString[S_FD_ConnParam_Common_Port], '8080');
    oMan.DSPath := oParams.URLPath;
    oMan.UserName := oParams.UserName;
    oMan.Password := oParams.Password;
    oMan.ProxyHost := oParams.DSProxyHost;
    oMan.ProxyPort := oParams.DSProxyPort;
    oMan.ProxyUsername := oParams.DSProxyUsername;
    oMan.ProxyPassword := oParams.DSProxyPassword;
    oMan.ConnectionTimeout := IntToStr(oParams.LoginTimeout);
    oMan.CommunicationTimeout := IntToStr(oParams.CommunicationTimeout);
    oMan.ManagerId := GenSessionId;

    sChnlName := oNames.KeyNames[i];
    if sChnlName = '' then
      sChnlName := GenSessionId;
    oMan.ChannelName := sChnlName;

    sCBName := oNames.ValueFromIndex[i];
    if sCBName = '' then
      sCBName := GenSessionId;
    FCallbacks.Add(sCBName);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSEventAlerter.InternalHandle(AEventMessage: TFDPhysEventMessage);
begin
  InternalHandleEvent(TFDPhysDSEventMessage(AEventMessage).FCBName,
                      TFDPhysDSEventMessage(AEventMessage).FArgs);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSEventAlerter.InternalRegister;
var
  i: Integer;
  oCB: TFDPhysDSCallback;
begin
  for i := 0 to FManagers.Count - 1 do begin
    oCB := TFDPhysDSCallback.Create(Self, FCallbacks[i]);
    TDSClientCallbackChannelManager(FManagers[i]).RegisterCallback(oCB.FName, oCB);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSEventAlerter.InternalUnregister;
var
  i: Integer;
begin
  for i := 0 to FManagers.Count - 1 do
    TDSClientCallbackChannelManager(FManagers[i]).UnregisterCallback(FCallbacks[i]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSEventAlerter.InternalReleaseHandle;
var
  i: Integer;
begin
  for i := 0 to FManagers.Count - 1 do
    FDFree(TDSClientCallbackChannelManager(FManagers[i]));
  FManagers.Clear;
  FCallbacks.Clear;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSEventAlerter.InternalSignal(const AEvent: String;
  const AArgument: Variant);
var
  iChnl, i: Integer;
  oClnt: TDSAdminClient;
  oArr: TJSONArray;
  oMsg: TJSONValue;
  oRsp: TJSONValue;
begin
  iChnl := GetNames.IndexOfName(AEvent);
  if iChnl = -1 then
    iChnl := GetNames.IndexOf(AEvent);

  if VarIsArray(AArgument) then begin
    oArr := TJSONArray.Create;
    for i := VarArrayLowBound(AArgument, 1) to VarArrayHighBound(AArgument, 1) do
      oArr.Add(VarToStrDef(AArgument[i], ''));
    oMsg := oArr;
  end
  else
    oMsg := TJSONString.Create(VarToStrDef(AArgument, ''));

  oClnt := TDSAdminClient.Create(DSConn.DbxConnection);
  try
    if iChnl <> -1 then
      oClnt.BroadcastToChannel(AEvent, oMsg)
    else
      oClnt.NotifyCallback(AArgument[0], AEvent, oMsg, oRsp);
  finally
    FDFree(oClnt);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDSCommand                                                              }
{-------------------------------------------------------------------------------}
function TFDPhysDSCommand.GetDSConn: TFDPhysDSConnection;
begin
  Result := TFDPhysDSConnection(TDBXConn);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSCommand.InternalPrepare;
begin
  try
    inherited InternalPrepare;
  except
    on E: Exception do
      if not DSConn.CheckNetworkError(E, Self) then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
begin
  try
    inherited InternalExecute(ATimes, AOffset, ACount);
  except
    on E: Exception do
      if not DSConn.CheckNetworkError(E, Self) then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSCommand.InternalOpen: Boolean;
begin
  Result := False;
  try
    Result := inherited InternalOpen;
  except
    on E: Exception do
      if not DSConn.CheckNetworkError(E, Self) then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSCommand.InternalNextRecordSet: Boolean;
begin
  Result := False;
  try
    Result := inherited InternalNextRecordSet;
  except
    on E: Exception do
      if not DSConn.CheckNetworkError(E, Self) then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysDSDriver);

end.
