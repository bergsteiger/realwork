
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Connection classes                              }
{                                                       }
{       Copyright (c) 1999 Inprise Corporation          }
{                                                       }
{*******************************************************}

unit corbacon;

{$T-,H+,X+}

interface

uses
  Messages, Variants, Windows, SysUtils, CorbaObj, CorbaStd, Classes, Midas, DBClient;

type

  { TCorbaConnection }

  TRepositoryId = type string;
  TCancelEvent = procedure (Sender: TObject; var Cancel: Boolean;
    var DialogMessage: string) of object;

  TCorbaConnection = class(TCustomRemoteServer)
  private
    FRepositoryId: TRepositoryId;
    FObjectName: string;
    FHostName: string;
    FOnCancel: TCancelEvent;
    FConnecting: Boolean;
    FCancelable: Boolean;
    procedure ThreadTimeout(var DialogMessage: string; var Cancel: Boolean);
    procedure SetRepositoryId(const Value: TRepositoryId);
    procedure SetObjectName(const Value: string);
    procedure SetHostName(const Value: string);
  protected
    procedure DoConnect; override;
    procedure DoDisconnect; override;
    function GetConnected: Boolean; override;
    procedure SetConnected(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetServer: IAppServer; override;
  published
    property Cancelable: Boolean read FCancelable write FCancelable default False;
    property Connected;
    property RepositoryId: TRepositoryId read FRepositoryId write SetRepositoryId;
    property ObjectName: string read FObjectName write SetObjectName;
    property HostName: string read FHostName write SetHostName;
    property AfterConnect;
    property AfterDisconnect;
    property BeforeConnect;
    property BeforeDisconnect;
    property OnCancel: TCancelEvent read FOnCancel write FOnCancel;
  end;


implementation

uses
  ActiveX, ComObj, Forms, Registry, MidConst, OrbPas, Dialogs, CorbCnst;


{ TCorbaBindThread }

type
  PIObject = ^IObject;
  TCorbaBindThread = class(TThread)
  private
    FRepId: string;
    FFactoryId: string;
    FInstanceName: string;
    FHostName: string;
    FIID: TGUID;
    FObjectPtr: PIObject;
    FLock: TRTLCriticalSection;
    FCanFree: THandle;
    FCallComplete: THandle;
    FException: TObject;
    FFinished: Boolean;
    FDialogHandle: HWND;
    procedure SetDialogHandle(const Value: HWND);
  public
    constructor Create(const RepId, FactoryId, InstanceName, HostName: string;
      IID: TGUID; var Obj: IObject);
    destructor Destroy; override;
    procedure Cancel;
    procedure Execute; override;
    procedure MarkFreeable;
    property CallCompleteEvent: THandle read FCallComplete;
    property Exception: TObject read FException write FException;
    property Finished: Boolean read FFinished;
    property DialogHandle: HWND read FDialogHandle write SetDialogHandle;
  end;

{ TCorbaBindThread }

constructor TCorbaBindThread.Create(const RepId, FactoryId,
  InstanceName, HostName: string; IID: TGUID; var Obj: IObject);
begin
  FRepId := RepId;
  FFactoryId := FactoryId;
  FInstanceName := InstanceName;
  FHostName := HostName;
  FIID := IID;
  FObjectPtr := @Obj;
  FreeOnTerminate := True;
  InitializeCriticalSection(FLock);
  FCanFree := CreateEvent(nil, True, False, nil);
  FCallComplete := CreateEvent(nil, True, False, nil);
  inherited Create(False);
end;

destructor TCorbaBindThread.Destroy;
begin
  DeleteCriticalSection(FLock);
  CloseHandle(FCanFree);
  CloseHandle(FCallComplete);
  FException.Free;
  inherited Destroy;
end;

procedure TCorbaBindThread.Cancel;
begin
  EnterCriticalSection(FLock);
  try
    FObjectPtr := nil;
    FDialogHandle := 0;
  finally
    LeaveCriticalSection(FLock);
  end;
end;

procedure TCorbaBindThread.Execute;
var
  Obj: IObject;
begin
  FException:= nil;
  try
    Obj := CORBAFactoryCreateStub(FRepID, FFactoryID,
      FInstanceName, FHostName, FIID);
    EnterCriticalSection(FLock);
    try
      if FObjectPtr <> nil then FObjectPtr^ := Obj;
    finally
      LeaveCriticalSection(FLock);
    end;
  except
    FException := AcquireExceptionObject;
  end;
  EnterCriticalSection(FLock);
  try
    if FDialogHandle <> 0 then PostMessage(FDialogHandle, WM_CLOSE, 0, 0);
  finally
    LeaveCriticalSection(FLock);
  end;
  FFinished := True;
  ResetEvent(FCallComplete);
  WaitForSingleObject(FCanFree, INFINITE);
end;

procedure TCorbaBindThread.MarkFreeable;
begin
  ResetEvent(FCanFree);
end;

procedure TCorbaBindThread.SetDialogHandle(const Value: HWND);
begin
  EnterCriticalSection(FLock);
  try
   FDialogHandle := Value;
  finally
    LeaveCriticalSection(FLock);
  end;
end;

type
  TTimedOutEvent = procedure (var Msg: string; var Cancel: Boolean) of object;

function ThreadedBind(const RepId, FactoryId, InstanceName, HostName: string;
  IID: TGUID; Timeout: DWORD; TimedOut: TTimedOutEvent): IObject;
var
  Thread: TCorbaBindThread;
  CompleteEvent: THandle;
  WaitResult: DWORD;
  Cancel: Boolean;
  TickCount: DWORD;
  WaitTicks: DWORD;
  CurTicks: DWORD;
  ConnectMessage: string;
  Exception: TObject;

  procedure ShowConnectDialog(const Msg: string);
  var
    MsgDialog: TForm;
  begin
    MsgDialog := CreateMessageDialog(Msg, mtInformation, [mbCancel]);
    try
      Thread.DialogHandle := MsgDialog.Handle;
      MsgDialog.ShowModal;
    finally
      MsgDialog.Free;
    end;
  end;

begin
  Thread := TCorbaBindThread.Create(RepId, FactoryId, InstanceName,
    HostName, IID, Result);
  try
    CompleteEvent := Thread.CallCompleteEvent;
    TickCount := GetTickCount;
    WaitTicks := Timeout;
    while not Thread.Finished do
    begin
      WaitResult := MsgWaitForMultipleObjects(1, CompleteEvent, False, WaitTicks,
        QS_ALLINPUT);
      case WaitResult of
        WAIT_TIMEOUT:
          begin
            Cancel := False;
            ConnectMessage := sConnecting;
            if Assigned(TimedOut) then TimedOut(ConnectMessage, Cancel);
            if not Thread.Finished and not Cancel and (ConnectMessage <> '') then
            begin
              ShowConnectDialog(ConnectMessage);
              Cancel := True;
            end;
            if Cancel and not Thread.Finished then
            begin
              Thread.Cancel;
              Result := nil;
              Abort;
            end;
            TickCount := GetTickCount;
            WaitTicks := Timeout;
          end;
        $FFFFFFFF: RaiseLastOSError;
      else
        if Thread.Finished then Break;
        Application.ProcessMessages;
        CurTicks := GetTickCount;
        if TickCount + TimeOut > CurTicks then
          WaitTicks := TickCount + TimeOut - CurTicks else
          WaitTicks := 0;
      end;
    end;
    if Thread.Exception <> nil then
    begin
      Exception := Thread.Exception;
      Thread.Exception := nil;
      raise Exception;
    end;
  finally
    Thread.MarkFreeable;
  end;
end;

{ TCorbaConnection }

constructor TCorbaConnection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TCorbaConnection.SetRepositoryId(const Value: TRepositoryId);
begin
  if Value <> FRepositoryId then
  begin
    if not (csLoading in ComponentState) then
    begin
      SetConnected(False);
    end;
    FRepositoryId := Value;
  end;
end;

procedure TCorbaConnection.SetObjectName(const Value: string);
begin
  if Value <> FObjectName then
  begin
    if not (csLoading in ComponentState) then
    begin
      SetConnected(False);
    end;
    FObjectName := Value;
  end;
end;

procedure TCorbaConnection.SetHostName(const Value: string);
begin
  if Value <> FHostName then
  begin
    if not (csLoading in ComponentState) then
    begin
      SetConnected(False);
    end;
    FHostName := Value;
  end;
end;

function TCorbaConnection.GetConnected: Boolean;
begin
  Result := (not VarIsNull(AppServer) and (IUnknown(AppServer) <> nil));
end;

procedure TCorbaConnection.SetConnected(Value: Boolean);
begin
  Sleep(0);
  if (not (csReading in ComponentState)) and
     (Value and not Connected) and
     (FRepositoryId = '') then
    raise Exception.CreateResFmt(@SRepositoryIdBlank, [Name]);
  inherited SetConnected(Value);
end;

procedure TCorbaConnection.DoDisconnect;
begin
  SetAppServer(NULL);
end;

procedure TCorbaConnection.DoConnect;
const
  SPrefix = 'IDL:';   // Do not localize
  PrefixLength = Length(SPrefix);
  SFactory = 'Factory';
var
  Intf: IUnknown;
  FactoryId, ObjectId: string;
  IID: TGuid;
  P: Integer;
begin
  if FConnecting then Exit;
  FConnecting := True;
  try
    CorbaInitialize;
    if (Length(RepositoryId) <= PrefixLength) or
    (AnsiCompareStr(Copy(RepositoryId, 1, PrefixLength), SPrefix) <> 0) then
    begin
      FactoryId := Format('%s%s%s:1.0', [SPrefix, RepositoryId, SFactory]);
      ObjectId := Format('%s%s:1.0', [SPrefix, RepositoryId]);
    end
    else
    begin
      FactoryId := RepositoryId;
      ObjectId := RepositoryId;
      P := Pos(SFactory+':', ObjectId);
      if P > 0 then
        Delete(ObjectId, P, Length(SFactory));
    end;
    // Object ID has 'I' before object name
    P := Pos('/', ObjectID);
    if (P > 0) and (P < Length(ObjectId)) then
      Insert('I', ObjectID, P + 1);
    if not CorbaInterfaceIDManager.SearchGuid(ObjectId, IID) then
      IID := IAppServer;
    if FCancelable or (csDesigning in ComponentState) then
      Intf := ThreadedBind(FactoryId, ObjectName, '', HostName, IID,
        1000, ThreadTimeout)
    else
      Intf := CORBAFactoryCreateStub(FactoryId, ObjectName,
        '', HostName, IID);
    if Intf <> nil then
      SetAppServer(Intf);
  finally
    FConnecting := False;
  end;
end;

procedure TCorbaConnection.ThreadTimeout(var DialogMessage: string;
  var Cancel: Boolean);
begin
  if Assigned(FOnCancel) then FOnCancel(Self, Cancel, DialogMessage);
end;

function TCorbaConnection.GetServer: IAppServer;
begin
  Connected := True;
  Result := IUnknown(AppServer) as IAppServer;
end;

end.