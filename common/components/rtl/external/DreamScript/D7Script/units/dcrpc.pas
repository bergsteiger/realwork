{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
Unit dcRPC;

Interface
{$I dc.inc}

Uses Windows, SysUtils, Classes, sdMain;

Type
  { THandledObject }

  THandledObject=Class(TObject)
  Protected
    FHandle:THandle;
  Public
    Destructor Destroy;override;
    Property Handle:THandle read FHandle;
  End;
                              
  { TEvent }

  TEvent=Class(THandledObject)
  Private
    FName:String;
  Public
    Constructor Create(Const AName:String;Manual:Boolean);
    Procedure Pulse;
    Procedure Reset;
    Procedure Signal;
    Function Wait(TimeOut:DWord):Boolean;

    Property Name:String read FName;
  End;

  { TMutex }

  TMutex=Class(THandledObject)
  Private
    FName:String;
  Public
    Constructor Create(Const Name:String);

    Function Get(TimeOut:DWord):Boolean;
    Function Release:Boolean;
  End;

  { TSemaphore }

  TSemaphore=Class(THandledObject)
  Private
    FName:String;
  Public
    Constructor CReate(Const Name:String;MaxCount:Integer);
    Function Get(TimeOut:DWord):Boolean;
    Function Release:Boolean;
  End;

  { TSharedMem }

  TSharedMem=Class(THandledObject)
  Private
    FBuffer:Pointer;
    FName:String;
    FSize:Integer;
  Public
    Constructor Create(Const Name:String;Size:Integer);
    Destructor Destroy;override;

    Property Buffer:Pointer read FBuffer;
    Property Name:String read FName;
    Property Size:Integer read FSize;
  end;

  { TCustomIPCClient }
  TClientMode=(cmNone,cmRead,cmWrite);

  TCustomIPCClient=Class(TStream)
  Private
    FDataInEvent:TEvent;
    FDataOutEvent:TEvent;
    FMutex:TMutex;
    FMode:TClientMode;
    FPosition:Integer;
    FSharedMem:TSharedMem;
    Procedure CheckMode(RequiredMode:TClientMode);
    Procedure Flush(IsWait:Boolean);
    Function GetLocked:Boolean;
    Function GetStartPos:Integer;
    Procedure Lock;virtual;
    Procedure SetDataInEvent(Value:TEvent);
    Procedure SetDataOutEvent(Value:TEvent);
    Procedure SetMode(Value:TClientMode);
    Procedure SetMutex(Value:TMutex);
    Procedure SetSharedMem(Value:TSharedMem);
  Protected
    Procedure DataOutSignal;virtual;

    Property Mode:TClientMode read FMode write SetMode;
  Public
    Destructor Destroy;override;

    Procedure BeginRead;virtual;
    Procedure BeginWrite;virtual;

    Procedure EndRead;virtual;
    Procedure EndWrite;virtual;
    Procedure UnLock;
    Function Read(Var Buffer;Size:Integer):Integer;override;
    Function ReadBool:Boolean;
    Function ReadInt:Integer;
    Function ReadStr:String;
    Function Seek(Offset:Integer;Origin:Word):Integer;override;
    Function Write(Const Buffer;Size:Integer):Integer;override;
    Procedure WriteBool(Const Data:Boolean);
    Procedure WriteInt(Const Data:Integer);
    Procedure WriteStr(Const Data:String);

    Property DataInEvent:TEvent read FDataInEvent write SetDataInEvent;
    Property DataOutEvent:TEvent read FDataOutEvent write SetDataOutEvent;
    Property Locked:Boolean read GetLocked;
    Property Mutex:TMutex read FMutex write SetMutex;
    Property SharedMem:TSharedMem read FSharedMem write SetSharedMem;
    Property StartPos:Integer read GetStartPos;
  End;

  TClientStub=Class;
  
  { TIPCClient }

  TIPCClient=Class(TCustomIPCClient)
  Private
    FIsSended:Boolean;
    FOnFirstSend:TNotifyEvent;
    FOwner:TClientStub;
  Protected
    Procedure DataOutSignal;override;
    Procedure DoFirstSend;
    Procedure Lock;override; 
  Public
    Constructor Create(AOwner:TClientStub);
    Procedure BeginWrite;override;

    Property OnFirstSend:TNotifyEvent read FOnFirstSend write FOnFirstSend;  
  End;

  { TClientStub }

  TCallType=(ctNone,ctCall,ctRet);

  TClientStub=Class(TThread)
  Private
    FCallType:TCallType;
    FCallCS:TRTLCriticalSection;
    FClientCallEvent:TEvent;
    FClientRetEvent:TEvent;
    FInSynchronize:Boolean;
    FIPCClient:TIPCClient;
    FRetCS:TRTLCriticalSection;
    FServerCallEvent:TEvent;
    FServerRetEvent:TEvent;
    FWaitEvents:TList;
    FWaitReturnTime:DWord;
    Procedure ClearEvents;
    Procedure DoRet;
    Function GetIsStubThread:Boolean;
    Procedure OnFirstSend(Sender:TObject);
    Procedure SetClientCallEvent(Value:TEvent);
    Procedure SetClientRetEvent(Value:TEvent);
    Procedure SetServerCallEvent(Value:TEvent);
    Procedure SetServerRetEvent(Value:TEvent);
  Protected
    Procedure DoCall;virtual;abstract;
    Procedure DoIdle;virtual;
    Procedure DoProcess;virtual;
    Procedure Execute;override;
    Procedure InitEvents;virtual;abstract;
    Procedure InitIPC;virtual;abstract;
    Procedure LockCall;
    Procedure LockRet;
    Procedure UnLockCall;
    Procedure UnLockRet;
  Public
    Constructor Create(Suspend:Boolean);
    Destructor Destroy;override;

    Procedure ProcessGetMutex(Mutex:THandle);
    Procedure Return;
    Procedure WaitReturn;

    Property InSynchronize:Boolean read FInSynchronize write FInSynchronize;
    Property IPCClient:TIPCClient read FIPCClient;
    Property CallType:TCallType read FCallType write FCallType;
    Property ClientCallEvent:TEvent read FClientCallEvent write SetClientCallEvent;
    Property ClientRetEvent:TEvent read FClientRetEvent write SetClientRetEvent;
    Property IsStubThread:Boolean read GetIsStubThread;
    Property ServerCallEvent:TEvent read FServerCallEvent write SetServerCallEvent;
    Property ServerRetEvent:TEvent read FServerRetEvent write SetServerRetEvent;
  End;

  Function GenerateEvent(Mutex:TMutex):TEvent;

Implementation

Const
  ConfirmWaitTime=4000;

  //Resource string
  SErrCreatingObject='Error creating %s named "%s". Error code=%d';
  SFileMapping='File mapping';
  SEvent='Event';
  SMutex='Mutex';
  SErrSendError='Send error';
  SErrReceiveError='Receive error';
  SErrReadError='Read error';
  SErrNotImpl='Method is not implemented';

  SErrWaitReturnFailed='Wait return failed';
  SErrUnknownCallType='Unknown call type';
  SErrUnExpectedRet='Unexpected return';
  SErrWaitWithoutEndWrite='Wait without EndWrite';

Procedure CreatingError(Const ObjectType,ObjectName:String);
Begin
  ErrorFmt(SErrCreatingObject,[ObjectType,ObjectName,GetLastError]);
End;

Function GenerateEvent(Mutex:TMutex):TEvent;
Var
  I:Integer;
  AHandle:THandle;
  AName:String;
Begin
  Mutex.Get(Infinite);
  Try
    I:=0;
    Repeat
      AName:=EventPrefix+IntToStr(I);
      AHandle:=OpenEvent(EVENT_ALL_ACCESS,False,PChar(AName));
      If AHandle=0 Then
      Begin
        Result:=TEvent.Create(AName,False);
        Exit;
      End
      Else
        CloseHandle(AHandle);
      Inc(I);
    Until False;
  Finally
    Mutex.Release;
  End;  
End;

{ THandledObject }

Destructor THandledObject.Destroy;
Begin
  If FHandle<>0 then
    CloseHandle(FHandle);
End;

{ TEvent }

Constructor TEvent.Create(Const AName:String;Manual:Boolean);
Begin
  FName:=AName;
  FHandle:=CreateEvent(Nil,Manual,False,PChar(AName));
  If FHandle=0 Then
    CreatingError(SEvent,AName);
End;

Procedure TEvent.Pulse;
Begin
  PulseEvent(FHandle);
End;

Procedure TEvent.Reset;
Begin
  ResetEvent(FHandle);
End;

Procedure TEvent.Signal;
Begin
  SetEvent(FHandle);
End;

Function TEvent.Wait(TimeOut:DWord):Boolean;
Begin
  Result:=WaitForSingleObject(FHandle,TimeOut)=WAIT_OBJECT_0;
End;

{ TMutex }

Constructor TMutex.Create(Const Name:String);
Begin
  FName:=Name;
  FHandle:=CreateMutex(Nil,False,PChar(Name));
  If FHandle=0 Then
    CreatingError(SMutex,Name);
End;

Function TMutex.Get(TimeOut:DWord):Boolean;
Begin
  Result:=WaitForSingleObject(FHandle,TimeOut)=WAIT_OBJECT_0;
End;

Function TMutex.Release:Boolean;
Begin
  Result:=ReleaseMutex(FHandle);
End;

{ TSema[hore }

Constructor TSemaphore.Create(Const Name:String;MaxCount:Integer);
Begin
  FName:=Name;
  FHandle:=CreateSemaphore(Nil,MaxCount,MaxCount,PChar(Name));
End;

Function TSemaphore.Get(TimeOut:DWord):Boolean;
Begin
  Result:=WaitForSingleObject(FHandle,TimeOut)=WAIT_OBJECT_0;
End;

Function TSemaphore.Release:Boolean;
Begin
  Result:=ReleaseSemaphore(FHandle,1,Nil);
End;

{ TSharedMem }

Constructor TSharedMem.Create(const Name:String;Size:Integer);
Begin
  FName:=Name;
  FSize:=Size;
  FHandle:=CreateFileMapping($FFFFFFFF,Nil,PAGE_READWRITE,0,Size,PChar(Name));
  If FHandle=0 Then
    CreatingError(SFileMapping,Name);
  FBuffer:=MapViewOfFile(FHandle,FILE_MAP_WRITE,0,0,Size);
  If FBuffer=Nil Then
    CreatingError(SFileMapping,Name);
end;

Destructor TSharedMem.Destroy;
Begin
  If FBuffer<>Nil Then
    UnmapViewOfFile(FBuffer);
  Inherited Destroy;
End;

{ TCustomIPCClient }

Destructor TCustomIPCClient.Destroy;
Begin
  FDataInEvent.Free;
  FDataOutEvent.Free;
  FMutex.Free;
  FSharedMem.Free;
End;

Procedure TCustomIPCClient.BeginRead;
Begin
  Mode:=cmRead;
End;

Procedure TCustomIPCClient.BeginWrite;
Begin
  Lock;
  Mode:=cmWrite;
End;

Procedure TCustomIPCClient.CheckMode(RequiredMode:TClientMode);
Begin
  If FMode<>RequiredMode Then
    Error(SErrInvalidClientMode);
End;

Procedure TCustomIPCClient.DataOutSignal;
Begin
  FDataOutEvent.Signal;
End;

Procedure TCustomIPCClient.EndRead;
Begin
  FDataOutEvent.Signal;
  FMutex.Get(Infinite);
  Try
    UnLock;
  Finally
    FMutex.Release;
  End;  
  Mode:=cmNone;
End;

Procedure TCustomIPCClient.EndWrite;
Begin
  Flush(True);
  Mode:=cmNone;
End;

Procedure TCustomIPCClient.Flush(IsWait:Boolean);
Begin
  CheckMode(cmWrite);
  If FPosition=StartPos Then
    Exit;
  Cardinal(FSharedMem.Buffer^):=FPosition-StartPos;
  FPosition:=StartPos;
  DataOutSignal;
  If IsWait And Not FDataInEvent.Wait(ConfirmWaitTime) Then
    Error(SErrSendError);
End;

Function TCustomIPCClient.GetLocked:Boolean;
Begin
  FMutex.Get(Infinite);
  Try
    Result:=Boolean(PChar(FSharedMem.FBuffer)[SizeOf(Integer)]);
  Finally
    FMutex.Release;
  End;  
End;

Function TCustomIPCClient.GetStartPos:Integer;
Begin
  Result:=SizeOf(Integer)+SizeOf(Boolean)
End;

Procedure TCustomIPCClient.Lock;
Begin
  While Locked Do
    Sleep(1);
  FMutex.Get(Infinite);
  Try
    Boolean(PChar(FSharedMem.FBuffer)[SizeOf(Integer)]):=True;
  Finally
    FMutex.Release;
  End;
End;

Function TCustomIPCClient.Read(Var Buffer;Size:Integer):Integer;
Var
  BufferPos:Integer;
  BufferDataSize:Integer;
  RestSize:Integer;
  DataSize:Integer;
Begin
  Result:=Size;
  CheckMode(cmRead);
  BufferPos:=0;
  Repeat
    BufferDataSize:=Integer(FSharedMem.Buffer^);
    RestSize:=BufferDataSize-FPosition+StartPos;
    If RestSize>=Size Then
      DataSize:=Size
    Else
    Begin
      If BufferDataSize<>FSharedMem.Size-StartPos Then
        Error(SErrReadError);
      DataSize:=RestSize;
    End;
    Move(PChar(FSharedMem.Buffer)[FPosition],PChar(@Buffer)[BufferPos],DataSize);
    Dec(Size,DataSize);
    Inc(FPosition,DataSize);
    Inc(BufferPos,DataSize);
    If Size=0 Then
      Break;
    FDataOutEvent.Signal;
    If Not FDataInEvent.Wait(ConfirmWaitTime) Then
      Error(SErrReceiveError);
    FPosition:=StartPos;
  Until False;
End;

Function TCustomIPCClient.ReadBool:Boolean;
Begin
  Read(Result,SizeOf(Result));
End;

Function TCustomIPCClient.ReadInt:Integer;
Begin
  Read(Result,SizeOf(Result));
End;

Function TCustomIPCClient.ReadStr:String;
Var
  Len:Integer;
Begin
  Len:=ReadInt;
  SetLength(Result,Len);
  If Len<>0 Then
    Read(Result[1],Len);
End;

Function TCustomIPCClient.Seek(Offset:Integer;Origin:Word):Integer;
Begin
  Error(SErrNotImpl);
  Result:=0;
End;

Procedure TCustomIPCClient.SetDataInEvent(Value:TEvent);
Begin
  If FDataInEvent=Value Then
    Exit;
  FDataInEvent.Free;
  FDataInEvent:=Value;
End;

Procedure TCustomIPCClient.SetDataOutEvent(Value:TEvent);
Begin
  If FDataOutEvent=Value Then
    Exit;
  FDataOutEvent.Free; 
  FDataOutEvent:=Value;
End;

Procedure TCustomIPCClient.SetMode(Value:TClientMode);
Begin
  If FMode=Value Then
    Exit;
  FMode:=Value;
  FPosition:=StartPos;
End;

Procedure TCustomIPCClient.SetMutex(Value:TMutex);
Begin
  If FMutex=Value Then
    Exit;
  FMutex.Free;
  FMutex:=Value;
End;

Procedure TCustomIPCClient.SetSharedMem(Value:TSharedMem);
Begin
  If FSharedMem=Value Then
    Exit;
  FSharedMem.Free;
  FSharedMem:=Value;
End;

Procedure TCustomIPCClient.UnLock;
Begin
  FMutex.Get(Infinite);
  Try
    Boolean(PChar(FSharedMem.FBuffer)[SizeOf(Integer)]):=False;
  Finally
    FMutex.Release;
  End;  
End;

Function TCustomIPCClient.Write(Const Buffer;Size:Integer):Integer;
Var
  BufferPos:Integer;
  BufferSize:Integer;
  RestSize:Integer;
  DataSize:Integer;
Begin
  Result:=Size;
  CheckMode(cmWrite);
  BufferPos:=0;
  Repeat
    BufferSize:=FSharedMem.Size;
    RestSize:=BufferSize-FPosition;
    If RestSize>Size Then
      DataSize:=Size
    Else
      DataSize:=RestSize;
    Move(PChar(@Buffer)[BufferPos],PChar(FSharedMem.Buffer)[FPosition],DataSize);
    Dec(Size,DataSize);
    Inc(FPosition,DataSize);
    Inc(BufferPos,DataSize);
    If Size=0 Then
      Break;
    Flush(True);
    FPosition:=StartPos;
  Until False;
End;

Procedure TCustomIPCClient.WriteBool(Const Data:Boolean);
Begin
  Write(Data,SizeOf(Data));
End;

Procedure TCustomIPCClient.WriteInt(Const Data:Integer);
Begin
  Write(Data,SizeOf(Data));
End;

Procedure TCustomIPCClient.WriteStr(Const Data:String);
Begin
  WriteInt(Length(Data));
  If Data<>'' Then
    Write(Data[1],Length(Data));
End;

{ TIPCClient }

Constructor TIPCClient.Create(AOwner:TClientStub);
Begin
  Inherited Create;
  FOwner:=AOwner;
End;

Procedure TIPCClient.BeginWrite;
Begin
  Inherited;
  FIsSended:=False;
End;

Procedure TIPCClient.DataOutSignal;
Begin
  If FIsSended Then
    Inherited
  Else
    DoFirstSend;
  FIsSended:=True;
End;

Procedure TIPCClient.DoFirstSend;
Begin
  If Assigned(FOnFirstSend) Then
    FOnFirstSend(Self);
End;

Procedure TIPCClient.Lock;
Begin
  While Locked Do
  Begin
    Sleep(1);
    If FOwner.IsStubThread Then
      FOwner.DoProcess;
  End;
  FOwner.ProcessGetMutex(FMutex.Handle);
  Inherited;
  FMutex.Release;
End;

{ TClientStub }

Constructor TClientStub.Create(Suspend:Boolean);
Begin
  Inherited Create(True);
  InitializeCriticalSection(FCallCS);
  InitializeCriticalSection(FRetCS);
  FWaitReturnTime:=ConfirmWaitTime;
  FWaitEvents:=TList.Create;
  FIPCClient:=TIPCClient.Create(Self);
  InitIPC;
  InitEvents;
  FIPCClient.OnFirstSend:=OnFirstSend;
  If Not Suspend Then
    Resume;
End;

Destructor TClientStub.Destroy;
Begin
  FServerCallEvent.Free;
  FServerRetEvent.Free;
  FClientCallEvent.Free;
  FClientRetEvent.Free;
  FIPCClient.Free;
  ClearEvents;
  FWaitEvents.Free;
  FWaitEvents:=Nil;
  DeleteCriticalSection(FCallCS);
  DeleteCriticalSection(FRetCS);
  Inherited;
End;

Procedure TClientStub.ClearEvents;
Var
  I:Integer;
Begin
  For I:=0 To FWaitEvents.Count-1 Do
    CloseHandle(Integer(FWaitEvents[I]));
End;

Procedure TClientStub.DoIdle;
Begin
End;

Procedure TClientStub.DoProcess;
Begin
  If FClientCallEvent.Wait(1) Then
    DoCall
  Else
    If FClientRetEvent.Wait(1) Then
    Begin
      LockRet;
      Try
        DoRet;
      Finally
        UnLockRet;
      End;
    End
    Else
      DoIdle;
End;

Procedure TClientStub.DoRet;
Begin
  If FWaitEvents.Count=0 Then
    Error(SErrUnExpectedRet);
  SetEvent(THandle(FWaitEvents.Last));
  FWaitEvents.Count:=FWaitEvents.Count-1;
End;

Procedure TClientStub.Execute;
Begin
  While Not Terminated Do
    DoProcess;
End;

Procedure TClientStub.LockCall;
Begin
  EnterCriticalSection(FCallCS);
End;

Procedure TClientStub.LockRet;
Begin
  EnterCriticalSection(FRetCS);
End;

Function TClientStub.GetIsStubThread:Boolean;
Begin
  Result:=(ThreadID=GetCurrentThreadID) Or FInSynchronize;
End;

Procedure TClientStub.OnFirstSend(Sender:TObject);
Begin
  Case FCallType Of
    ctNone:Error(SErrUnknownCallType);
    ctCall:FServerCallEvent.Signal;
    ctRet:FServerRetEvent.Signal
  End;
  FCallType:=ctNone;
End;

Procedure TClientStub.ProcessGetMutex(Mutex:THandle);

  Procedure _WaitNonStubThread;
  Begin
    WaitForSingleObject(Mutex,INFINITE);
  End;

  Procedure _WaitStubThread;
  Begin
    While WaitForSingleObject(Mutex,1)<>WAIT_OBJECT_0 Do
      DoProcess;
  End;

Begin
  If IsStubThread Then
    _WaitStubThread
  Else
    _WaitNonStubThread;
End;

Procedure TClientStub.Return;
Begin
  FServerRetEvent.Signal;
End;

Procedure TClientStub.SetClientCallEvent(Value:TEvent);
Begin
  If FClientCallEvent=Value Then
    Exit;
  FClientCallEvent.Free;
  FClientCallEvent:=Value;
End;

Procedure TClientStub.SetClientRetEvent(Value:TEvent);
Begin
  If FClientRetEvent=Value Then
    Exit;
  FClientRetEvent.Free;
  FClientRetEvent:=Value;
End;

Procedure TClientStub.SetServerCallEvent(Value:TEvent);
Begin
  If FServerCallEvent=Value Then
    Exit;
  FServerCallEvent.Free;
  FServerCallEvent:=Value;
End;

Procedure TClientStub.SetServerRetEvent(Value:TEvent);
Begin
  If FServerRetEvent=Value Then
    Exit;
  FServerRetEvent.Free;
  FServerRetEvent:=Value;
End;

Procedure TClientStub.UnLockCall;
Begin
  LeaveCriticalSection(FCallCS);
End;

Procedure TClientStub.UnLockRet;
Begin
  LeaveCriticalSection(FRetCS);
End;

Procedure TClientStub.WaitReturn;
Var
  hEvent:THandle;
  Procedure _WaitNonStubThread;
  Begin
    If WaitForSingleObject(hEvent,FWaitReturnTime)<>WAIT_OBJECT_0 Then
      Error(SErrWaitReturnFailed);
  End;

  Procedure _WaitStubThread;
  Var
    InitTime:DWord;
  Begin
    InitTime:=GetTickCount;
    While WaitForSingleObject(hEvent,1)<>WAIT_OBJECT_0 Do
    Begin
      If DWord(Abs(GetTickCount-InitTime))>FWaitReturnTime Then
        Error(SErrWaitReturnFailed);
      DoProcess;  
    End;
  End;
Begin
  If IPCClient.Mode<>cmNone Then
    Error(SErrWaitWithoutEndWrite);
  hEvent:=CreateEvent(Nil,False,False,Nil);
  FWaitEvents.Add(Pointer(hEvent));
  UnLockRet;
  If IsStubThread Then
    _WaitStubThread
  Else
    _WaitNonStubThread;  
  CloseHandle(hEvent);
End;
End.
