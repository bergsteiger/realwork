{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{      FireDAC monitor TCP/IP based implementation      }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Moni.RemoteServer;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.WinSock,
{$ENDIF}
  System.Classes, System.SysUtils, System.Win.ScktComp,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Moni.RemoteBase;

type
  // server
  TFDMoniRemoteServerQueueItem = class;
  TFDMoniRemoteReceiver = class;
  TFDMoniRemoteServerClientThread = class;
  TFDMoniRemoteServer = class;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteServerQueueItem                                               }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteServerQueueItem = class(TFDMoniRemoteQueueItem)
  public
    FHost: String;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteReceiver                                                      }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteReceiver = class(TFDMoniRemoteQueueWorker)
  private
    FServer: TFDMoniRemoteServer;
    procedure DoMessage;
  protected
    function GetQueue: TFDMoniRemoteQueue; override;
    procedure DoAction; override;
  public
    constructor Create(AServer: TFDMoniRemoteServer);
    destructor Destroy; override;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteServerClientThread                                            }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteServerClientThread = class (TServerClientThread)
  private
    FServer: TFDMoniRemoteServer;
    FStream: TFDMoniRemoteStream;
    FAdapterList: TFDMoniRemoteAdapterList;
    FProcessID: LongWord;
    FMonitorID: LongWord;
    FVersion: LongWord;
    procedure RemoveAllAdapters;
  protected
    procedure ClientExecute; override;
  public
    constructor Create(AServer: TFDMoniRemoteServer; ASocket: TServerClientWinSocket);
    destructor Destroy; override;
    property ProcessID: LongWord read FProcessID write FProcessID;
    property MonitorID: LongWord read FMonitorID write FMonitorID;
    property Version: LongWord read FVersion write FVersion;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteServer                                                        }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteServerMessageEvent = procedure (Sender: TObject; AMessage: TFDMoniRemoteQueueItem) of object;
  TFDMoniRemoteServer = class (TObject)
  private
    FTCPServer: TServerSocket;
    FQueue: TFDMoniRemoteQueue;
    FReceiver: TFDMoniRemoteReceiver;
    FPackVersion: Integer;
    FSynchronize: TFDMoniRemoteQueueEventKinds;
    FOnMessage: TFDMoniRemoteServerMessageEvent;
    procedure DoMessage(AMessage: TFDMoniRemoteServerQueueItem);
    procedure DoGetThread(Sender: TObject; ClientSocket: TServerClientWinSocket;
      var SocketThread: TServerClientThread);
    procedure DoExecute(AClient: TFDMoniRemoteServerClientThread);
    function GetTracing: Boolean;
    procedure SetTracing(const AValue: Boolean);
    function GetPort: Integer;
    procedure SetPortI(const AValue: Integer);
    function BuildItem(AClient: TFDMoniRemoteServerClientThread): TFDMoniRemoteServerQueueItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Queue: TFDMoniRemoteQueue read FQueue;
    property Receiver: TFDMoniRemoteReceiver read FReceiver;
    property Port: Integer read GetPort write SetPortI default C_FD_MonitorPort;
    property Tracing: Boolean read GetTracing write SetTracing default False;
    property Synchronize: TFDMoniRemoteQueueEventKinds read FSynchronize write FSynchronize default [];
    property OnMessage: TFDMoniRemoteServerMessageEvent read FOnMessage write FOnMessage;
  end;

implementation

uses
  System.Variants,
  FireDAC.Stan.Util, FireDAC.Stan.Factory;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteReceiver                                                         }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteReceiver.Create(AServer: TFDMoniRemoteServer);
begin
  inherited Create;
  FServer := AServer;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteReceiver.Destroy;
begin
  FServer := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteReceiver.GetQueue: TFDMoniRemoteQueue;
begin
  Result := FServer.FQueue;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteReceiver.DoAction;
begin
  if GetQueue.GetNextEvent in FServer.Synchronize then
    Synchronize(DoMessage)
  else
    DoMessage;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteReceiver.DoMessage;
var
  oItem: TFDMoniRemoteServerQueueItem;
  i: Integer;
begin
  i := 5;
  repeat
    oItem := TFDMoniRemoteServerQueueItem(GetQueue.GetItem);
    if oItem <> nil then
      try
        FServer.DoMessage(oItem);
      finally
        FDFree(oItem);
      end;
    Dec(i);
  until (GetQueue.Count = 0) or (i = 0) or
        not (GetQueue.GetNextEvent in FServer.Synchronize);
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteServerClientThread                                               }
{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
constructor TFDMoniRemoteServerClientThread.Create(AServer: TFDMoniRemoteServer;
  ASocket: TServerClientWinSocket);
begin
  inherited Create(True, ASocket);
  FServer := AServer;
  FAdapterList := TFDMoniRemoteAdapterList.Create;
  FStream := TFDMoniRemoteStream.Create;
  Resume;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteServerClientThread.Destroy;
begin
  FServer := nil;
  FDFreeAndNil(FAdapterList);
  FDFreeAndNil(FStream);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteServerClientThread.RemoveAllAdapters;
var
  i: Integer;
  oItem: TFDMoniRemoteServerQueueItem;
begin
  try
    for i := 0 to FAdapterList.Count - 1 do begin
      oItem := FServer.BuildItem(Self);
      oItem.FEvent := ptUnRegisterAdapter;
      oItem.FHandle := FAdapterList.Handles[i];
      oItem.FPath := FAdapterList.Paths[i];
      FServer.FQueue.PostItem(oItem);
    end;
  finally
    FAdapterList.Clear;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteServerClientThread.ClientExecute;
var
  FDSet: TFDSet;
  TimeVal: TTimeVal;
begin
  while not Terminated and ClientSocket.Connected do begin
    FD_ZERO(FDSet);
    FD_SET(ClientSocket.SocketHandle, FDSet);
    TimeVal.tv_sec := 0;
    TimeVal.tv_usec := 500;
    if (select(0, @FDSet, nil, nil, @TimeVal) > 0) and not Terminated then
      if ClientSocket.ReceiveBuf(FDSet, -1) = 0 then
        Break
      else
        FServer.DoExecute(Self);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteServer                                                           }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteServer.Create;
begin
  inherited Create;
  FTCPServer := TServerSocket.Create(nil);
  FTCPServer.Port := C_FD_MonitorPort;
  FTCPServer.ServerType := stThreadBlocking;
  FTCPServer.OnGetThread := DoGetThread;

  FReceiver := TFDMoniRemoteReceiver.Create(Self);
  FQueue := TFDMoniRemoteQueue.Create(FReceiver);
  FPackVersion := C_FD_Mon_PacketVersion;
  FSynchronize := [];
  //FReceiver.PingTime := 1000000;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteServer.Destroy;
begin
  Tracing := False;
  FDFreeAndNil(FTCPServer);
  FDFreeAndNil(FReceiver);
  FDFreeAndNil(FQueue);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteServer.GetTracing: Boolean;
begin
  Result := FTCPServer.Active;
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure TFDMoniRemoteServer.SetTracing(const AValue: Boolean);
begin
  if Tracing <> AValue then
    if AValue then begin
      FTCPServer.Active := True;
      FReceiver.Resume;
    end
    else begin
      FTCPServer.Active := False;
      while FReceiver.GetQueue.Count > 0 do begin
        if (FReceiver.GetQueue.GetNextEvent in Synchronize) and
           (GetCurrentThreadID = MainThreadID) then
          CheckSynchronize()
        else
          Sleep(1);
      end;
      FReceiver.Suspend;
    end;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
function TFDMoniRemoteServer.GetPort: Integer;
begin
  Result := FTCPServer.Port;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteServer.SetPortI(const AValue: Integer);
begin
  FTCPServer.Port := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteServer.BuildItem(AClient: TFDMoniRemoteServerClientThread): TFDMoniRemoteServerQueueItem;
begin
  Result := TFDMoniRemoteServerQueueItem.Create;
  Result.FHost := AClient.ClientSocket.RemoteHost;
  Result.FProcessID := AClient.FProcessID;
  Result.FMonitorID := AClient.FMonitorID;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteServer.DoGetThread(Sender: TObject;
  ClientSocket: TServerClientWinSocket; var SocketThread: TServerClientThread);
begin
  SocketThread := TFDMoniRemoteServerClientThread.Create(Self, ClientSocket);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteServer.DoExecute(AClient: TFDMoniRemoteServerClientThread);
var
  oItem: TFDMoniRemoteServerQueueItem;
  oStream: TFDMoniRemoteStream;
begin
  oItem := BuildItem(AClient);
  oStream := AClient.FStream;
  try
    oStream.Open(AClient.ClientSocket, omRead);
    try
      oItem.FEvent := TFDMoniRemoteQueueEventKind(oStream.ReadInteger(S_FD_MsgEvent));
      oStream.ReadBeginBlock(C_FD_Mon_PacketBodyBlockID);
      case oItem.FEvent of
        ptConnectClient:
          begin
            AClient.FProcessID := oStream.ReadLongWord(S_FD_MsgProcessId);
            AClient.FMonitorID := oStream.ReadLongWord(S_FD_MsgMonitorId);
            AClient.FVersion := oStream.ReadInteger(S_FD_MsgVersion);
            oItem.FProcessID := AClient.FProcessID;
            oItem.FMonitorID := AClient.FMonitorID;
            oItem.FTime := oStream.ReadLongWord(S_FD_MsgTime);
            oItem.FMessage := oStream.ReadString(S_FD_MsgText);
          end;
        ptDisConnectClient:
          begin
            oStream.ReadLongWord(S_FD_MsgProcessId);
            oStream.ReadLongWord(S_FD_MsgMonitorId);
            oStream.ReadLongWord(S_FD_MsgTime);
            AClient.RemoveAllAdapters;
            AClient.ClientSocket.Close;
          end;
        ptRegisterAdapter:
          begin
            oItem.FHandle := oStream.ReadLongWord(S_FD_MsgAdapterHandle);
            oItem.FTime := oStream.ReadLongWord(S_FD_MsgTime);
            oItem.FPath := oStream.ReadString(S_FD_MsgText);
            AClient.FAdapterList.AddAdapter(oItem.FPath, oItem.FHandle);
          end;
        ptUnRegisterAdapter:
          begin
            oItem.FHandle := oStream.ReadLongWord(S_FD_MsgAdapterHandle);
            oItem.FTime := oStream.ReadLongWord(S_FD_MsgTime);
            oItem.FPath := AClient.FAdapterList.FindByHandle(oItem.FHandle);
            AClient.FAdapterList.RemoveAdapter(oItem.FHandle);
          end;
        ptUpdateAdapter:
          begin
            oItem.FHandle := oStream.ReadLongWord(S_FD_MsgAdapterHandle);
            oItem.FTime := oStream.ReadLongWord(S_FD_MsgTime);
            oStream.ReadBlob(S_FD_MsgArgs, oItem.FArgs);
          end;
        ptNotify:
          begin
            oItem.FHandle := oStream.ReadLongWord(S_FD_MsgAdapterHandle);
            if oItem.FHandle > 0 then
              oItem.FPath := AClient.FAdapterList.FindByHandle(oItem.FHandle);
            oItem.FKind := TFDMoniEventKind(oStream.ReadInteger(S_FD_MsgNotifyKind));
            oItem.FStep := TFDMoniEventStep(oStream.ReadInteger(S_FD_MsgNotifyStep));
            oItem.FTime := oStream.ReadLongWord(S_FD_MsgTime);
            oItem.FMessage := oStream.ReadString(S_FD_MsgText);
            oStream.ReadBlob(S_FD_MsgArgs, oItem.FArgs);
          end;
      end;
      oStream.ReadEndBlock;
      FQueue.PostItem(oItem);
    finally
      oStream.Close;
    end;
  except
    on E: Exception do begin
      AClient.ClientSocket.Close;
      // connection reset by peer
      if (E is ESocketError) and (Pos('10054', LowerCase(E.Message)) <> 0) then begin
        oItem.FEvent := ptDisConnectClient;
        FQueue.PostItem(oItem);
      end
      else begin
        FDFree(oItem);
        raise;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteServer.DoMessage(AMessage: TFDMoniRemoteServerQueueItem);
begin
  if Assigned(FOnMessage) then
    FOnMessage(Self, AMessage);
end;

end.
