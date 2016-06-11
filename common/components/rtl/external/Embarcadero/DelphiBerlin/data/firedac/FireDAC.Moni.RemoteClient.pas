{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{     FireDAC monitor TCP/IP based implementation       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Moni.RemoteClient;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts,
  FireDAC.Moni.Base;

type
  {----------------------------------------------------------------------------}
  { TFDMoniRemoteClientLink                                                    }
  {----------------------------------------------------------------------------}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TFDMoniRemoteClientLink = class(TFDMoniClientLinkBase)
  private
    FRemoteClient: IFDMoniRemoteClient;
    function IsHS: Boolean;
    function GetHost: String;
    procedure SetHost(const AValue: String);
    function GetPort: Integer;
    procedure SetPortI(const AValue: Integer);
    function GetTimeout: Integer;
    procedure SetTimeout(const AValue: Integer);
  protected
    function GetMoniClient: IFDMoniClient; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property RemoteClient: IFDMoniRemoteClient read FRemoteClient;
  published
    property Host: String read GetHost write SetHost stored IsHS;
    property Port: Integer read GetPort write SetPortI default C_FD_MonitorPort;
    property Timeout: Integer read GetTimeout write SetTimeout default C_FD_MonitorTimeout;
    property Tracing;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.WinSock,
{$ENDIF}
{$IFDEF UNIX}
  sockets, netdb,
{$ENDIF}
  System.SysUtils, System.Variants, System.Win.ScktComp, System.Generics.Collections, 
    System.Types,
  FireDAC.Moni.RemoteBase, FireDAC.Stan.Factory, FireDAC.Stan.Util;

type
  // client
  TFDMoniRemoteClientQueueItem = class;
  TFDMoniRemoteClientAdapterList = class;
  TFDMoniRemoteSender = class;
  TFDMoniRemoteClient = class;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteClientQueueItem                                               }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteClientQueueItem = class(TFDMoniRemoteQueueItem)
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteClientAdapterList                                             }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteClientAdapterList = class(TFDMoniRemoteAdapterList)
  private
    FNextHandle: Integer;
  public
    function GetUniqueHandle: LongWord;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteSender                                                        }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteSender = class(TFDMoniRemoteQueueWorker)
  private
    FTCPClient: TClientSocket;
    FStream: TFDMoniRemoteStream;
    FClient: TFDMoniRemoteClient;
    FTimeout: Integer;
    FHost: String;
    FPort: Integer;
    FOnDisconnect: TNotifyEvent;
    function GetTracing: Boolean;
    procedure SetTracing(const AValue: Boolean);
    function IsMonitorRunning: Boolean;
    procedure DoDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  protected
    function GetQueue: TFDMoniRemoteQueue; override;
    procedure DoAction; override;
  public
    constructor Create(AClient: TFDMoniRemoteClient);
    destructor Destroy; override;
    property Port: Integer read FPort write FPort default C_FD_MonitorPort;
    property Host: String read FHost write FHost;
    property Timeout: Integer read FTimeout write FTimeout default C_FD_MonitorTimeout;
    property Tracing: Boolean read GetTracing write SetTracing default False;
    property OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteClient                                                        }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteClient = class (TFDMoniClientBase, IFDMoniRemoteClient)
  private
    FSender: TFDMoniRemoteSender;
    FQueue: TFDMoniRemoteQueue;
    FAdapterList: TFDMoniRemoteClientAdapterList;
    FPackVersion: Integer;
    FProcessID: LongWord;
    FMonitorID: LongWord;
    FDestroying: Boolean;
    FDisconnecting: Boolean;
    function BuildItem(AEventKind: TFDMoniRemoteQueueEventKind): TFDMoniRemoteClientQueueItem;
    procedure DoDisconnected(Sender: TObject);
  protected
    // IFDMoniClient
    procedure Notify(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      ASender: TObject; const AMsg: String; const AArgs: array of const); override;
    function RegisterAdapter(const AAdapter: IFDMoniAdapter): LongWord; override;
    procedure UnregisterAdapter(const AAdapter: IFDMoniAdapter); override;
    procedure AdapterChanged(const AAdapter: IFDMoniAdapter); override;
    // IFDMoniRemoteClient
    function GetHost: String;
    procedure SetHost(const AValue: String);
    function GetPort: Integer;
    procedure SetPortI(const AValue: Integer);
    function GetTimeout: Integer;
    procedure SetTimeout(const AValue: Integer);
    // other
    function DoTracingChanged: Boolean; override;
    function OperationAllowed: Boolean; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    property Sender: TFDMoniRemoteSender read FSender;
  end;

var
  FClients: TList;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteClientAdapterList                                                }
{-------------------------------------------------------------------------------}
function TFDMoniRemoteClientAdapterList.GetUniqueHandle: LongWord;
begin
  Result := LongWord(AtomicIncrement(FNextHandle));
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteSender                                                           }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteSender.Create(AClient: TFDMoniRemoteClient);
begin
  inherited Create;
  FClient := AClient;
  FStream := TFDMoniRemoteStream.Create;
  FHost := '127.0.0.1';
  FPort := C_FD_MonitorPort;
  FTimeout := C_FD_MonitorTimeout;
  Priority := tpHighest;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteSender.Destroy;
begin
  Tracing := False;
  Sleep(1);
  FDFreeAndNil(FTCPClient);
  FDFreeAndNil(FStream);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteSender.DoDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  if Assigned(FOnDisconnect) then
    FOnDisconnect(Sender);
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteSender.GetTracing: Boolean;
begin
  Result := (FTCPClient <> nil) and FTCPClient.Active;
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
var
  GWSAData: TWSAData;
  GWSAFailed: Boolean;
  GWSAInitialized: Boolean;

function TFDMoniRemoteSender.IsMonitorRunning: Boolean;
var
  iSock: TSocket;
  rAddr: TSockAddrIn;
  prHost: PHostEnt;
  pCh: {$IFDEF NEXTGEN} MarshaledAString {$ELSE} PAnsiChar {$ENDIF};
begin
  Result := False;

  if not GWSAInitialized then begin
    GWSAFailed := WSAStartup($0101, GWSAData) <> 0;
    GWSAInitialized := True;
  end;
  if GWSAFailed then
    Exit;

  try
    iSock := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
    if iSock <> INVALID_SOCKET then begin
      rAddr.sin_family := PF_INET;
      rAddr.sin_addr.s_addr := INADDR_ANY;
      rAddr.sin_port := 0;
      if bind(iSock, rAddr, SizeOf(rAddr)) <> SOCKET_ERROR then begin
        rAddr.sin_family := PF_INET;
        prHost := gethostbyname({$IFNDEF NEXTGEN} PAnsiChar {$ENDIF}(TFDEncoder.Enco(FHost, ecANSI)));
        if prHost <> nil then begin
          pCh := prHost^.h_addr_list^;
          rAddr.sin_addr.S_un_b.s_b1 := pCh[0];
          rAddr.sin_addr.S_un_b.s_b2 := pCh[1];
          rAddr.sin_addr.S_un_b.s_b3 := pCh[2];
          rAddr.sin_addr.S_un_b.s_b4 := pCh[3];
          rAddr.sin_port := htons(FPort);
          if connect(iSock, rAddr, SizeOf(rAddr)) <> SOCKET_ERROR then
            Result := True;
        end;
      end;
      shutdown(iSock, 2);
      closesocket(iSock);
    end;
  except
    // no exceptions visible
  end;
end;
{$ENDIF}

{$IFDEF POSIX}
function TFDMoniRemoteSender.IsMonitorRunning: Boolean;
var
  iSock: TSocket;
  rAddr: TSockAddr;
  rHost: THostEntry;
  sb: TFDByteString;
begin
  Result := False;
  try
    iSock := fpSocket(PF_INET, SOCK_STREAM, IPPROTO_IP);
    if iSock <> -1 then begin
      rAddr.sin_family := PF_INET;
      rAddr.sin_addr.s_addr := INADDR_ANY;
      rAddr.sin_port := 0;
      if fpBind(iSock, @rAddr, SizeOf(rAddr)) = 0 then begin
        rAddr.sin_family := PF_INET;
        sb := TFDEncoder.Enco(FHost, ecANSI);
        if GetHostByName(sb, rHost) or
           ResolveHostByName(sb, rHost) then begin
          rAddr.sin_addr := rHost.Addr;
          rAddr.sin_port := htons(FPort);
          if fpConnect(iSock, @rAddr, SizeOf(rAddr)) = 0 then
            Result := True;
        end;
      end;
      fpShutdown(iSock, 2);
      CloseSocket(iSock);
    end;
  except
    // no exceptions visible
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteSender.SetTracing(const AValue: Boolean);
begin
  if Tracing <> AValue then
    if AValue then begin
      if IsMonitorRunning then
        try
          FTCPClient := TClientSocket.Create(nil);
          FTCPClient.Host := FHost;
          FTCPClient.Port := FPort;
          FTCPClient.ClientType := ctBlocking;
          FTCPClient.OnDisconnect := DoDisconnect;
          // ScktComp does not support timeout
          // FTCPClient.ConnectTimeout := FTimeout;
          FTCPClient.Open;
        except
          FDFreeAndNil(FTCPClient);
          raise;
        end
    end
    else begin
      try
        while FStream.IsOpen do
          Sleep(1);
        FTCPClient.Close;
      except
        // no exceptions visible
      end;
      FDFreeAndNil(FTCPClient);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteSender.DoAction;
var
  oItem: TFDMoniRemoteClientQueueItem;
begin
  oItem := TFDMoniRemoteClientQueueItem(GetQueue.GetItem);
  if oItem <> nil then
  try
    FStream.Open(FTCPClient.Socket, omWrite);
    try
      FStream.WriteInteger(S_FD_MsgEvent, Integer(oItem.FEvent));
      FStream.WriteBeginBlock(C_FD_Mon_PacketBodyBlockID);
      case oItem.FEvent of
        ptConnectClient:
          begin
            FStream.WriteLongWord(S_FD_MsgProcessId, oItem.FProcessID);
            FStream.WriteLongWord(S_FD_MsgMonitorId, oItem.FMonitorID);
            FStream.WriteInteger(S_FD_MsgVersion, FClient.FPackVersion);
            FStream.WriteLongWord(S_FD_MsgTime, oItem.FTime);
            FStream.WriteString(S_FD_MsgText, oItem.FMessage);
          end;
        ptDisConnectClient:
          begin
            FStream.WriteLongWord(S_FD_MsgProcessId, oItem.FProcessID);
            FStream.WriteLongWord(S_FD_MsgMonitorId, oItem.FMonitorID);
            FStream.WriteLongWord(S_FD_MsgTime, oItem.FTime);
          end;
        ptRegisterAdapter:
          begin
            FStream.WriteLongWord(S_FD_MsgAdapterHandle, oItem.FHandle);
            FStream.WriteLongWord(S_FD_MsgTime, oItem.FTime);
            FStream.WriteString(S_FD_MsgText, oItem.FPath);
          end;
        ptUnRegisterAdapter:
          begin
            FStream.WriteLongWord(S_FD_MsgAdapterHandle, oItem.FHandle);
            FStream.WriteLongWord(S_FD_MsgTime, oItem.FTime);
          end;
        ptUpdateAdapter:
          begin
            FStream.WriteLongWord(S_FD_MsgAdapterHandle, oItem.FHandle);
            FStream.WriteLongWord(S_FD_MsgTime, oItem.FTime);
            FStream.WriteBlob(S_FD_MsgArgs, oItem.FArgs);
          end;
        ptNotify:
          begin
            FStream.WriteLongWord(S_FD_MsgAdapterHandle, oItem.FHandle);
            FStream.WriteInteger(S_FD_MsgNotifyKind, Integer(oItem.FKind));
            FStream.WriteInteger(S_FD_MsgNotifyStep, Integer(oItem.FStep));
            FStream.WriteLongWord(S_FD_MsgTime, oItem.FTime);
            FStream.WriteString(S_FD_MsgText, oItem.FMessage);
            FStream.WriteBlob(S_FD_MsgArgs, oItem.FArgs);
          end;
      end;
      FStream.WriteEndBlock;
    finally
      try
        if (FStream <> nil) and GetTracing then
          FStream.Close;
      except
        if FTCPClient <> nil then
          FClient.SetTracing(False);
        raise;
      end;
    end;
  finally
    FDFree(oItem);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteSender.GetQueue: TFDMoniRemoteQueue;
begin
  Result := FClient.FQueue;
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteClient                                                           }
{-------------------------------------------------------------------------------}
var
  FDMonitorLastID: Integer = 0;

procedure TFDMoniRemoteClient.Initialize;
begin
  inherited Initialize;
  FSender := TFDMoniRemoteSender.Create(Self);
  FSender.Host := '127.0.0.1';
  FSender.Port := C_FD_MonitorPort;
  FSender.Timeout := C_FD_MonitorTimeout;
  FSender.OnDisconnect := DoDisconnected;
  FQueue := TFDMoniRemoteQueue.Create(FSender);
  FAdapterList := TFDMoniRemoteClientAdapterList.Create;
  FPackVersion := C_FD_Mon_PacketVersion;
{$IFDEF MSWINDOWS}
  FProcessID := GetCurrentProcessId;
{$ENDIF}
{$IFDEF POSIX}
  FProcessID := GetProcessId;
{$ENDIF}
  FMonitorID := AtomicIncrement(FDMonitorLastID);
  if FClients <> nil then
    FClients.Add(Self);
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteClient.Destroy;
begin
  if FClients <> nil then
    FClients.Remove(Self);
  FDestroying := True;
  SetTracing(False);
  FDFreeAndNil(FQueue);
  FDFreeAndNil(FSender);
  FDFreeAndNil(FAdapterList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClient.DoDisconnected(Sender: TObject);
begin
  FDisconnecting := True;
  SetTracing(False);
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClient.BuildItem(AEventKind: TFDMoniRemoteQueueEventKind): TFDMoniRemoteClientQueueItem;
begin
  Result := TFDMoniRemoteClientQueueItem.Create;
  Result.FProcessID := FProcessID;
  Result.FMonitorID := FMonitorID;
  Result.FEvent := AEventKind;
  Result.FTime := TThread.GetTickCount();
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
function TFDMoniRemoteClient.DoTracingChanged: Boolean;
var
  oItem: TFDMoniRemoteClientQueueItem;
  iStartTime: Cardinal;
begin
  Result := True;
  if GetTracing then begin
    FSender.Tracing := True;
    if FSender.Tracing then begin
      if FSender.Suspended then
        FSender.Resume;
      oItem := BuildItem(ptConnectClient);
      oItem.FMessage := ParamStr(0) + ';' + GetName;
      FQueue.PostItem(oItem);
    end
    else begin
      Result := False;
      if not FSender.Suspended then
        FSender.Suspend;
    end;
  end
  else begin
    FQueue.Clear;
    if FSender.Tracing then begin
      oItem := BuildItem(ptDisConnectClient);
      FQueue.PostItem(oItem);
      iStartTime := TThread.GetTickCount();
      while (FQueue.Count > 0) and FSender.Tracing do begin
        Sleep(10);
        if FDTimeout(iStartTime, GetTimeout) then
          FQueue.Clear;
      end;
    end;
    FAdapterList.Clear;
    FSender.Tracing := False;
    if not FDestroying and not FDisconnecting and not FSender.Suspended then
      FSender.Suspend;
  end;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClient.OperationAllowed: Boolean;
begin
  Result := (FClients <> nil);
end;

{-------------------------------------------------------------------------------}
type
  __TInterfacedObject = class(TInterfacedObject)
  end;

procedure TFDMoniRemoteClient.Notify(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  ASender: TObject; const AMsg: String; const AArgs: array of const);
var
  oItem: TFDMoniRemoteClientQueueItem;
  hHandle: LongWord;
  oMAIntf: IFDMoniAdapter;
  iRefCount: Integer;
  sClassName, sName: String;
begin
  if GetTracing and (AKind in GetEventKinds) then begin
    hHandle := 0;
    if (ASender <> nil) and (ASender is TInterfacedObject) then begin
      iRefCount := __TInterfacedObject(ASender).FRefCount;
      __TInterfacedObject(ASender).FRefCount := 2;
      try
        if Supports(ASender, IFDMoniAdapter, oMAIntf) then begin
          hHandle := oMAIntf.GetHandle;
          oMAIntf := nil;
        end;
      finally
        __TInterfacedObject(ASender).FRefCount := iRefCount;
      end;
    end;
    oItem := BuildItem(ptNotify);
    oItem.FKind := AKind;
    oItem.FStep := AStep;
    oItem.FHandle := hHandle;
    oItem.FMessage := AMsg;
    oItem.SetArgs(AArgs);
    FQueue.PostItem(oItem);
    if GetOutputHandler <> nil then begin
      GetObjectNames(ASender, sClassName, sName);
      GetOutputHandler.HandleOutput(sClassName, sName, AMsg);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClient.RegisterAdapter(const AAdapter: IFDMoniAdapter): LongWord;
var
  oItem: TFDMoniRemoteClientQueueItem;
  sPath: string;
  oObj: IFDStanObject;
begin
  if GetTracing then begin
    oObj := AAdapter as IFDStanObject;
    sPath := '';
    repeat
      if sPath <> '' then
        sPath := '.' + sPath;
      sPath := oObj.Name + sPath;
      oObj := oObj.Parent;
    until oObj = nil;
    Result := FAdapterList.FindByPath(sPath);
    if Result = 0 then begin
      Result := FAdapterList.GetUniqueHandle;
      oItem := BuildItem(ptRegisterAdapter);
      oItem.FPath := sPath;
      oItem.FHandle := Result;
      FQueue.PostItem(oItem);
    end;
  end
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClient.UnRegisterAdapter(const AAdapter: IFDMoniAdapter);
var
  oItem: TFDMoniRemoteClientQueueItem;
  hHandle: LongWord;
begin
  if GetTracing then begin
    hHandle := AAdapter.GetHandle;
    if hHandle <> 0 then begin
      FAdapterList.RemoveAdapter(hHandle);
      oItem := BuildItem(ptUnRegisterAdapter);
      oItem.FHandle := hHandle;
      FQueue.PostItem(oItem);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClient.AdapterChanged(const AAdapter: IFDMoniAdapter);
var
  oItem: TFDMoniRemoteClientQueueItem;
  hHandle: LongWord;
  V: Variant;
  i: Integer;
  sName: String;
  vValue: Variant;
  eKind: TFDMoniAdapterItemKind;
begin
  if GetTracing then begin
    hHandle := AAdapter.GetHandle;
    if hHandle <> 0 then begin
      oItem := BuildItem(ptUpdateAdapter);
      oItem.FHandle := hHandle;
      V := VarArrayCreate([0, AAdapter.ItemCount * 3 - 1], varVariant);
      for i := 0 to AAdapter.ItemCount - 1 do begin
        AAdapter.GetItem(i, sName, vValue, eKind);
        V[i * 3 + 0] := sName;
        V[i * 3 + 1] := vValue;
        V[i * 3 + 2] := Byte(eKind);
      end;
      oItem.SetArgs(V);
      FQueue.PostItem(oItem);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClient.GetHost: String;
begin
  Result := FSender.Host;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClient.SetHost(const AValue: String);
begin
  FSender.Host := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClient.GetPort: Integer;
begin
  Result := FSender.Port;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClient.SetPortI(const AValue: Integer);
begin
  FSender.Port := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClient.GetTimeout: Integer;
begin
  Result := FSender.Timeout;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClient.SetTimeout(const AValue: Integer);
begin
  FSender.Timeout := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteClientLink                                                       }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteClientLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRemoteClient := MoniClient as IFDMoniRemoteClient;
  Host := '127.0.0.1';
  Port := C_FD_MonitorPort;
  Timeout := C_FD_MonitorTimeout;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteClientLink.Destroy;
begin
  FRemoteClient := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClientLink.GetMoniClient: IFDMoniClient;
var
  oRemClient: IFDMoniRemoteClient;
begin
  FDCreateInterface(IFDMoniRemoteClient, oRemClient);
  Result := oRemClient as IFDMoniClient;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClientLink.GetHost: String;
begin
  Result := RemoteClient.Host;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClientLink.SetHost(const AValue: String);
begin
  RemoteClient.Host := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClientLink.IsHS: Boolean;
begin
  Result := FDMoniRemoteIsLocalHost(GetHost);
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClientLink.GetPort: Integer;
begin
  Result := RemoteClient.Port;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClientLink.SetPortI(const AValue: Integer);
begin
  RemoteClient.Port := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteClientLink.GetTimeout: Integer;
begin
  Result := RemoteClient.Timeout;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteClientLink.SetTimeout(const AValue: Integer);
begin
  RemoteClient.Timeout := AValue;
end;

{-------------------------------------------------------------------------------}
procedure StopAllClients;
var
  i: Integer;
  oClient: TFDMoniRemoteClient;
begin
  for i := 0 to FClients.Count - 1 do begin
    oClient := TFDMoniRemoteClient(FClients[i]);
    oClient.FDestroying := True;
    oClient.SetTracing(False);
  end;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
{$IFDEF MSWINDOWS}
  GWSAFailed := False;
  GWSAInitialized := False;
{$ENDIF}
  FClients := TList.Create;
  oFact := TFDSingletonFactory.Create(TFDMoniRemoteClient, IFDMoniRemoteClient);

finalization
  StopAllClients;
  FDFreeAndNil(FClients);
{$IFDEF MSWINDOWS}
  if GWSAInitialized then
    WSACleanup;
{$ENDIF}
  FDReleaseFactory(oFact);

end.
