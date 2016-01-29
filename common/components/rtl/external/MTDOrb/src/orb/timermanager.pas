// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit timermanager;

interface

{$I dorb.inc}

uses {$IFDEF MSWINDOWS}WinSock, Windows,{$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}timermanager_int,
  osthread, Classes, orbtypes, SysUtils;

type
  // The set of registered timers
  TTimerData = record
    timer: ITimer;
    when: TTimeVal;
  end;
  PTimerData = ^TTimerData;

  TTimerDataList = class(TList)
  public
    procedure Clear; override;
  end;

  ITimerManagerWorker = interface(IORBThread)
  ['{C119D116-8092-4F88-860A-0A7D4FE2FF6F}']
    procedure _Destroy;
    procedure Add(const ATimer: ITimer; const AWhen: TTimeVal);
    function Remove(const ATimer: ITimer): boolean;
  end;

  TTimerManagerWorker = class(TORBThread, ITimerManagerWorker)
  private
    FMonitor: TThreadMonitor;
    FDestroy: boolean;// Has the worker been destroyed?
    FTimers: TTimerDataList;
    // Return the number of msec to sleep, or -1 for infinity
    function GetTimeout(): long;
    // Return a list of expired timers. If the returned list is 0
    // length then the worker is done.
    function GetExpiredTimers(): TTimerDataList;
  protected
    procedure Run(); override;
    { ITimerManagerWorker }
    procedure _Destroy;
    procedure Add(const ATimer: ITimer; const AWhen: TTimeVal);
    function Remove(const ATimer: ITimer): boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TTimerManager = class(TInterfacedObject, ITimerManager)
  private
    FWorker: ITimerManagerWorker;
    FHandle: TThreadHandle;
  protected
    { ITimerManager }
    procedure Add(const ATimer: ITimer; const AWhen: TTimeVal);
    procedure Remove(const ATimer: ITimer);
    procedure _Destroy;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses utils, internalexceptions;

{ TTimerManagerWorker }

procedure TTimerManagerWorker._Destroy;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  FDestroy := true;
  FMonitor.notify();
end;

procedure TTimerManagerWorker.Run();
var
  timers: TTimerDataList;
  i: integer;
begin
  timers := nil;
  while true do begin
    FreeAndNil(timers);
    timers := GetExpiredTimers();
    if timers.Count = 0 then
      Break;

    // Notify the expired timers
    for i := 0 to timers.Count - 1 do
      try
        PTimerData(timers.Items[i])^.timer.Notify();
      except
        //consume
      end; { try/except }
  end;
  timers.Free;
end;

procedure TTimerManagerWorker.Add(const ATimer: ITimer;
  const AWhen: TTimeVal);
var
  sync: ISynchronized;
  td: PTimerData;
begin
  td := AllocMem(SizeOf(TTimerData));
  td^.timer := ATimer;
  td^.when := AWhen;

  sync := TSynchronized.Create(FMonitor);

  FTimers.Add(td);

  // Wake the worker and recalculate the timeout
  FMonitor.notify();
end;

constructor TTimerManagerWorker.Create;
begin
  inherited Create();
  FMonitor := TThreadMonitor.Create;
  FTimers := TTimerDataList.Create;
end;

destructor TTimerManagerWorker.Destroy;
begin
  FMonitor.Free;
  FTimers.Free;
  inherited;
end;

function TTimerManagerWorker.GetExpiredTimers: TTimerDataList;
var
  sync: ISynchronized;
  tout: long;
  n: TTimeVal;
  i: integer;
  it: PTimerData;
begin
  result := TTimerDataList.Create;

  sync := TSynchronized.Create(FMonitor);

  while not FDestroy and (result.Count = 0) do begin
    tout := GetTimeout();
    if tout <> 0 then begin
      try
        if tout = -1 then
          FMonitor.wait()
        else
          FMonitor.wait(tout);
      except
        on E: EInterruptedException do ;
        else
          raise;
      end;
    end;

    if FDestroy then
      Continue;

    // Copy any expired timers to the expired list
    n := TimeNow();
    i := 0;
    while i < FTimers.Count do begin
      it := PTimerData(FTimers.Items[i]);
      if TimeCmp(n, it^.when) >= 0 then begin
        result.Add(it);
        i := Succ(i);
        FTimers.Remove(it);
        Continue;
      end;
      i := Succ(i);
    end;
  end;
end;

function TTimerManagerWorker.GetTimeout: long;
var
  n, tout: TTimeVal;
  i: integer;
  it: PTimerData;
  tv: long;
begin
  n := TimeNow();

  result := -1;

  for i := 0 to FTimers.Count - 1 do begin
    it := PTimerData(FTimers.Items[i]);
    // If the time has already arrived then return 0.
    if TimeCmp(n, it^.when) >= 0 then begin
      result := 0;
      Exit;
    end;

    tout := TimeSub(it^.when, n);

    // Ensure we don't get an overflow. 2147483647L is
    // LONG_MAX of a 32 bit signed value.
    if (tout.tv_sec < (2147483647 div 1000) - 1000) then begin
      // Convert timeval to msec
      tv := tout.tv_sec * 1000 + tout.tv_usec div 1000;
      if(tv < result) or (result = -1) then
        result := tv;
    end;
  end;
end;

function TTimerManagerWorker.Remove(const ATimer: ITimer): boolean;
var
  sync: ISynchronized;
  i: integer;
  it: PTimerData;
begin
  sync := TSynchronized.Create(FMonitor);

  for i := 0 to FTimers.Count - 1 do begin
    it := PTimerData(FTimers.Items[i]);
    if it^.timer = ATimer then begin
      FTimers.Remove(it);
      //it^.timer := nil;
      System.Finalize(it^);
      FreeMem(it, SizeOf(TTimerData));
      // Don't bother to notify. The worst thing that could
      // happen is that the worker wakes and doesn't expire
      // anything.
      //FMonitor.notify();
      result := true;
      Exit;
    end;
  end;
  result := false;
end;

{ TTimerManager }

procedure TTimerManager._Destroy;
begin
  Assert(FWorker <> nil);
  FWorker._Destroy();
  FWorker.Wait();
  FWorker := nil;
  FHandle := TORBThread.CurrentThread();
end;

procedure TTimerManager.Add(const ATimer: ITimer; const AWhen: TTimeVal);
begin
  FWorker.Add(ATimer, AWhen);
end;

constructor TTimerManager.Create;
begin
  FWorker := TTimerManagerWorker.Create();
  FHandle := FWorker.GetThreadId;
  FWorker.start();
end;

destructor TTimerManager.Destroy;
begin
  Assert(FWorker = nil);
  inherited;
end;

procedure TTimerManager.Remove(const ATimer: ITimer);
begin
  FWorker.Remove(ATimer);
end;

{ TTimerDataList }

procedure TTimerDataList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do begin
    System.Finalize(PTimerData(Items[i])^);
    FreeMem(Items[i], SizeOf(TTimerData));
  end;
  inherited;
end;

end.
