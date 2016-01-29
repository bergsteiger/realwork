{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit HTTPIntr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.Win.SConnect;

type

  { THTTPServer }

  THTTPServer = class(TWebModule, ISendDataBlock)
    procedure InterpreterAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FInterpreter: TDataBlockInterpreter;
    FData: IDataBlock;
  protected
    function Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock; stdcall;
  end;

  function TerminateExtension(dwFlags: DWORD): BOOL; stdcall;

var
  HTTPServer: THTTPServer;

implementation

uses
  System.Win.ComObj, Winapi.ActiveX, Datasnap.MidConst, Web.Win.IsapiHTTP, Web.Win.ISAPIApp,
  System.Generics.Collections, System.Types;

{$R *.dfm}

type

  { TPooledDataInterpreter }

  TPooledDataInterpreter = class(TDataBlockInterpreter)
  protected
    function InternalCreateObject(const ClassID: TGUID): OleVariant; override;
    function StoreObject(const Value: OleVariant): Integer; override;
    function LockObject(ID: Integer): IDispatch; override;
    procedure UnlockObject(ID: Integer; const Disp: IDispatch); override;
    procedure ReleaseObject(ID: Integer); override;
  end;

  { TObject List }

  PObjectInfo = ^TObjectInfo;
  TObjectInfo = record
    Obj: IDispatch;
    LastAccessed: TDateTime;
    Locked: Boolean;
  end;

  TObjectManager = class;

  TObjectList = class
  private
    FClassID: string;
    FLock: TObject;
    FOwner: TStringList;
    FIndex: Integer;
    FList: TList;
    FMaxObjects: Integer;
    FSingleton: Boolean;
    FTimeout: TDateTime;
  public
    constructor Create(Owner : TObjectManager; const ClassID: string);
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    function LockObject: IDispatch;
    procedure UnlockObject(const Dispatch: IDispatch);
    property MaxObjects: Integer read FMaxObjects;
    property Singleton: Boolean read FSingleton;
    property Timeout: TDateTime read FTimeout;
  end;

  { TGarbageCollector }

  TGarbageCollector = class(TThread)
  private
    FEvent: THandle;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Event: THandle read FEvent;
  end;

  { TObjectManager }

  TObjectManager = class
  private
    FStateObjects: OleVariant;
    FLock: TObject;
    FList: TStringList;
    FNextID: Integer;
    FNextIndex: Integer;
    FSemaphore: THandle;
    FGarbageCollector: TGarbageCollector;
  protected
    procedure Lock;
    procedure Unlock;
    function GetCatID(const ClassID: TGUID): Integer;
    function LockList(CatID: Integer): TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    property Semaphore: THandle read FSemaphore;
    function CreateObject(const ClassID: TGUID): OleVariant;
    function StoreObject(const Value: OleVariant): Integer;
    function LockObject(ID: Integer): OleVariant;
    procedure UnlockObject(ID: Integer; const Disp: IDispatch);
    procedure ReleaseObject(ID: Integer);
  end;

var
  ObjectManager: TObjectManager;

{ THTTPServer }

function THTTPServer.Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock;
begin
  FData := Data;
  Result := nil;
end;

procedure THTTPServer.InterpreterAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  DataBlock: IDataBlock;
  S: AnsiString;
  BytesRead, ChunkSize: Integer;
  DataPacket: array of Byte;
begin
  try
    FData := nil;
    if not Assigned(FInterpreter) then
      FInterpreter := TPooledDataInterpreter.Create(Self, SWeb);
    S := Request.RawContent;
    BytesRead := Length(S);
    if BytesRead = 0 then EXIT;
    DataBlock := TDataBlock.Create;
    if BytesRead < Request.ContentLength then
    begin
      SetLength(DataPacket, Request.ContentLength);
      Move(S[1], DataPacket[0], BytesRead);
      repeat
        ChunkSize := TISAPIRequest(Request).ReadClient(Pointer(@Datapacket[BytesRead])^, Request.ContentLength - BytesRead);
        if ChunkSize > 0 then
        begin
          Inc(BytesRead, ChunkSize);
        end;
      until ChunkSize = -1;
      DataBlock.InitData(@DataPacket[0], Request.ContentLength, True);
    end else
      DataBlock.InitData(@S[1], Request.ContentLength, True);
    FInterpreter.InterpretData(DataBlock);
    if Assigned(FData) then
    begin
      Response.ContentStream := FData.Stream;
      FData.IgnoreStream;
    end;
  except
    {An exception here would take down IIS}
  end;
end;

{ TPooledDataInterpreter }

function TPooledDataInterpreter.InternalCreateObject(const ClassID: TGUID): OleVariant;
begin
  Result := ObjectManager.CreateObject(ClassID);
end;

function TPooledDataInterpreter.StoreObject(const Value: OleVariant): Integer;
begin
  Result := ObjectManager.StoreObject(Value);
end;

function TPooledDataInterpreter.LockObject(ID: Integer): IDispatch;
begin
  Result := ObjectManager.LockObject(ID);
end;

procedure TPooledDataInterpreter.UnlockObject(ID: Integer; const Disp: IDispatch);
begin
  ObjectManager.UnlockObject(ID, Disp);
end;

procedure TPooledDataInterpreter.ReleaseObject(ID: Integer);
begin
  ObjectManager.ReleaseObject(ID);
end;

{ TObjectList }

constructor TObjectList.Create(Owner : TObjectManager; const ClassID: string);	
var
  I: Integer;
begin
  FLock := TObject.Create;
  FList := TList.Create;
  FClassID := ClassID;
  FOwner := Owner.FList;
  FIndex := Owner.FNextIndex;
  Inc(Owner.FNextIndex);
  try
    FMaxObjects := StrToInt(GetRegStringValue(SClsid + ClassID, SMaxObjects));
    if FMaxObjects = 0 then FMaxObjects := MaxInt - 1;
  except
    FMaxObjects := MaxInt;
  end;
  FSingleton := GetRegStringValue(SClsid + ClassID, SSingleton) = SFlagOn;
  try
    I := StrToInt(GetRegStringValue(SClsid + ClassID, STimeout));
    FTimeout := EncodeTime(I div 60, I mod 60, 0, 0);
  except
    FTimeout := 0;
  end;
  FOwner.AddObject(ClassID, Self);
end;

destructor TObjectList.Destroy;
var
  I: Integer;
begin
  Lock;
  try
    for I := 0 to FList.Count - 1 do
      Dispose(PObjectInfo(FList[I]));
  I := FOwner.IndexOf(FClassId);
  if I > -1 then
    FOwner.Delete(I);
    inherited Destroy;
  finally
    Unlock;
    FLock.Free;
  end;
end;

procedure TObjectList.Lock;
begin
  TMonitor.Enter(FLock);
end;

procedure TObjectList.Unlock;
begin
  TMonitor.Exit(FLock);
end;

function TObjectList.LockObject: IDispatch;

  function CreateInfo: PObjectInfo;
  begin
    New(Result);
    try
      Result.LastAccessed := Now;
      { Singleton Object is never locked }
      Result.Locked := not Singleton;
      { For singleton objects, the object create needs to be blocked,
        for pooled objects, the creation shouldn't be blocked }
      if Singleton then
        Result.Obj := CreateComObject(StringToGUID(FClassID)) as IDispatch else
        Result.Obj := nil;
      FList.Add(Result);
    except
      Dispose(Result);
      raise;
    end;
  end;

var
  I: Integer;
  P: PObjectInfo;
begin
  if Singleton then
  begin
    if FList.Count < 1 then
    begin
      Lock;
      try
        if FList.Count < 1 then
          CreateInfo;
      finally
        Unlock;
      end;
    end;
    PObjectInfo(FList[0])^.LastAccessed := Now;
    Result := PObjectInfo(FList[0])^.Obj;
  end
  else
  begin
    P := nil;
    Lock;
    try
      for I := 0 to FList.Count - 1 do
        if not PObjectInfo(FList[I])^.Locked then
        begin
          PObjectInfo(FList[I])^.Locked := True;
          PObjectInfo(FList[I])^.LastAccessed := Now;
          Result := PObjectInfo(FList[I])^.Obj;
          Exit;
        end;
      if FList.Count >= MaxObjects then
        raise Exception.CreateRes(@SServerIsBusy);
      P := CreateInfo;
    finally
      Unlock;
    end;
    if Assigned(P) then
    begin
      try
        P.Obj := CreateComObject(StringToGUID(FClassID)) as IDispatch;
      except
        Lock;
        try
          FList.Remove(P);
          Dispose(P);
        finally
          Unlock;
        end;
        raise;
      end;
      Result := P.Obj;
    end;
  end;
end;

procedure TObjectList.UnlockObject(const Dispatch: IDispatch);
var
  I: Integer;
begin
  if Singleton then
  begin
    PObjectInfo(FList[0]).LastAccessed := Now;
  end else
  begin
    Lock;
    try
      for I := 0 to FList.Count - 1 do
        if PObjectInfo(FList[I])^.Obj = Dispatch then
        begin
          PObjectInfo(FList[I])^.Locked := False;
          PObjectInfo(FList[I])^.LastAccessed := Now;
          Exit;
        end;
    finally
      Unlock;
    end;
  end;
end;

constructor TGarbageCollector.Create;
begin
  FEvent := CreateEvent(nil, False, False, nil);
  inherited Create(False);
end;

destructor TGarbageCollector.Destroy;
begin
  CloseHandle(FEvent);
  inherited Destroy;
end;

procedure TGarbageCollector.Execute;

  function CheckObject(ObjectInfo: PObjectInfo; Timeout: TDateTime): Boolean;
  begin
    Result := False;
    if not ObjectInfo^.Locked then
    begin
      Result := (Timeout > 0) and ((Now - ObjectInfo^.LastAccessed) > Timeout);
      if Result then ObjectInfo^.Obj := nil;
    end;
  end;

  procedure CheckObjectList(ObjectList: TObjectList);
  var
    I: Integer;
  begin
    if not ObjectList.Singleton then
    begin
      ObjectList.Lock;
      try
        for I := ObjectList.FList.Count - 1 downto 0 do
          if CheckObject(PObjectInfo(ObjectList.FList[I]), ObjectList.Timeout) then
          begin
            Dispose(PObjectInfo(ObjectList.FList[I]));
            ObjectList.FList.Delete(I);
          end;
      finally
        ObjectList.Unlock;
      end;
    end;
  end;

var
  I: Integer;
begin
  while not Terminated do
    if WaitForSingleObject(FEvent, 360000) = WAIT_TIMEOUT then
    begin
      ObjectManager.Lock;
      try
        for I := 0 to ObjectManager.FList.Count - 1 do
          CheckObjectList(TObjectList(ObjectManager.FList.Objects[I]));
      finally
        ObjectManager.Unlock;
      end;
    end else
      Exit;
end;

{ TObjectManager }

constructor TObjectManager.Create;
begin
  FLock := TObject.Create;
  FNextID := 0;
  FNextIndex := 0;
  FList := TStringList.Create;
  FList.Sorted := True;
  FGarbageCollector := TGarbageCollector.Create;
end;

destructor TObjectManager.Destroy;
var
  I: Integer;
begin
  FGarbageCollector.Terminate;
  PulseEvent(FGarbageCollector.Event);
  FGarbageCollector.WaitFor;
  Lock;
  try
    for I := 0 to FList.Count - 1 do
      TObjectList(FList.Objects[I]).Free;
    FList.Free;
    inherited Destroy;
  finally
    Unlock;
    FLock.Free;
  end;
end;

procedure TObjectManager.Lock;
begin
  TMonitor.Enter(FLock);
end;

procedure TObjectManager.Unlock;
begin
  TMonitor.Exit(FLock);
end;

function TObjectManager.GetCatID(const ClassID: TGUID): Integer;
var
  S: string;
  I : Integer;
begin
  Lock;
  try
    S := GuidToString(ClassID);
  if FList.Find(S, Result) then
      Result := TObjectlist(FList.Objects[Result]).FIndex
  else
  begin
    I := FList.AddObject(S, TObjectList.Create(Self, S));
    Result := TObjectList(FList.Objects[I]).FIndex;
  end;
    Result := (Result + 1) shl 16;
  finally
    Unlock;
  end;
end;

function TObjectManager.LockList(CatID: Integer): TObjectList;
var
  I : Integer;
  Id : Integer;
begin
  Lock;
  Result := nil;
  try
    Id := HiWord(CatID) - 1;
    for I := FList.Count-1 downto 0 do
      if TObjectList(FList.Objects[I]).FIndex = Id then
      begin
        Result := TObjectList(FList.Objects[I]);
        break;
      end;
    if Result = nil then // should never happen
      raise Exception.Create(sNotFound);
  finally
    Unlock;
  end;
end;

function TObjectManager.CreateObject(const ClassID: TGUID): OleVariant;

  function CreateObject(const ClassID: TGUID): IDispatch;
  var
    Unk: IUnknown;
  begin
    OleCheck(CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
      CLSCTX_LOCAL_SERVER or CLSCTX_REMOTE_SERVER, IUnknown, Unk));
    Result := Unk as IDispatch;
  end;

  function IsClassPooled(ClassID: TGUID): Boolean;
  begin
    Result := GetRegStringValue(SClsid + GuidToString(ClassID), SPooled) = SFlagOn;
  end;

begin
  if IsClassPooled(ClassID) then
    Result := GetCatID(ClassID) else
    Result := CreateObject(ClassID);
end;

function TObjectManager.StoreObject(const Value: OleVariant): Integer;
begin
  { This is only used for statefull objects }
  Lock;
  try
    if not VarIsArray(FStateObjects) then
      FStateObjects := VarArrayCreate([0,10], varVariant);
    Result := FNextID;
    if Result > VarArrayHighBound(FStateObjects, 1) then
      VarArrayRedim(FStateObjects, Result + 10);
    if VarIsClear(FStateObjects[Result]) then
      FNextID := Result + 1 else
      FNextID := FStateObjects[Result];
    FStateObjects[Result] := Value;
  finally
    Unlock;
  end;
end;

function TObjectManager.LockObject(ID: Integer): OleVariant;
begin
  if HiWord(ID) = 0 then
  begin
    Lock;
    try
      Result := FStateObjects[ID];
    finally
      Unlock;
    end;
  end else
    Result := LockList(ID).LockObject;
end;

procedure TObjectManager.UnlockObject(ID: Integer; const Disp: IDispatch);
begin
  { Only used for stateless objects }
  if HiWord(ID) > 0 then LockList(ID).UnlockObject(Disp);
end;

procedure TObjectManager.ReleaseObject(ID: Integer);
begin
  { This is only used for statefull objects }
  if HiWord(ID) > 0 then Exit;
  Lock;
  try
    if (ID >= 0) and (VarIsArray(FStateObjects)) and
       (ID < VarArrayHighBound(FStateObjects, 1)) and
       (ID <> FNextID) and VarIsType(FStateObjects[ID], varDispatch) then
    begin
      FStateObjects[ID] := FNextID;
      FNextID := ID;
    end;
  finally
    Unlock;
  end;
end;

function TerminateExtension(dwFlags: DWORD): BOOL; stdcall;
begin
  Result := Web.Win.ISAPIApp.TerminateExtension(dwFlags);
  if Result then
    FreeAndNil(ObjectManager);
end;

procedure THTTPServer.WebModuleCreate(Sender: TObject);
begin
  { Each web module will be in a seperate thread. We need to initialize
    the COM subsystem for each thread }
  if Assigned(System.Win.ComObj.CoInitializeEx) then
    System.Win.ComObj.CoInitializeEx(nil, COINIT_MULTITHREADED)
  else
    CoInitialize(nil);
end;

procedure THTTPServer.WebModuleDestroy(Sender: TObject);
begin
  CoUninitialize;
end;

initialization
  if Assigned(System.Win.ComObj.CoInitializeEx) then
    System.Win.ComObj.CoInitializeEx(nil, COINIT_MULTITHREADED)
  else
    CoInitialize(nil);
    
  ObjectManager := TObjectManager.Create;
finalization
  CoUninitialize;
end.
