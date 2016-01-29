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
unit osprocess;

interface

{$I dorb.inc}

uses SysUtils, Classes, process_int, osthread, orbtypes,{$IFDEF LINUX}Libc{$ENDIF}
  {$IFDEF MSWINDOWS}Windows{$ENDIF};

type
  TProcessFactory = class(TInterfacedObject, IProcessFactory)
  private
{$IFDEF MSWINDOWS}
    FWatcher: IORBThread;
{$ENDIF}
  protected
    function CreateProcess(const ACommand: string; const ACallback: IProcessCallback): IProcess;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TProcess = class(TInterfacedObject, IProcess)
  private
    FCallback: IProcessCallback;
{$IFDEF MSWINDOWS}
    FPid: DWORD;
    FRequestExitEvent: THandle;
    FProcess: THandle;
{$ENDIF}
{$IFDEF LINUX}
    FPid: __pid_t;
{$ENDIF}
    FExitStatus: long;
    FCommand: string;
    FDetached: boolean;
{$IFDEF LINUX}
    //procedure SignalHandler(Sig: Longint); cdecl;
{$ENDIF}
  protected
    procedure Detach;
    procedure Terminate;
    function Run: boolean;
{$IFDEF MSWINDOWS}
    function PId: DWORD;
    function PHandle: THandle;
{$ENDIF}
{$IFDEF LINUX}
    function PId: __pid_t;
{$ENDIF}
    function Callback: IProcessCallback;
  public
    constructor Create(const ACommand: string; const ACallback: IProcessCallback);
    destructor Destroy; override;
    class procedure ProcessDied(APid: DWORD);
    class procedure Init();
    class procedure Shutdown();
  end;

  TProcessReaper = class(TORBThread)
  protected
    procedure Run(); override;
  end;

  TProcessExitEventListener = class(TORBThread)
  private
  protected
    procedure Run(); override;
  end;

function ProcessFactory: IProcessFactory;

implementation

uses orb;

var
{$IFDEF MSWINDOWS}
  SignalMutex: THandle;
  ProcessExitEvent: THandle;
  ExitEventThread: IORBThread;
  NumOfChildren: integer;
  ChildProcs: TWOHandleArray;
  ChildPids: array [0..MAXIMUM_WAIT_OBJECTS - 1] of DWORD;
{$ENDIF}
{$IFDEF LINUX}
  SigActionRec: TSigAction;
{$ENDIF}
  ProcessFactoryVar: IProcessFactory;
  ProcessList: IInterfaceList;

function ProcessFactory: IProcessFactory;
begin
  if ProcessFactoryVar = nil then
    ProcessFactoryVar := TProcessFactory.Create;
  result := ProcessFactoryVar;
end;

{ TProcess }

function TProcess.Callback: IProcessCallback;
begin
  result := FCallback;
end;

constructor TProcess.Create(const ACommand: string; const ACallback: IProcessCallback);
begin
  inherited Create;
{$IFDEF MSWINDOWS}
  WaitForSingleObject(SignalMutex, INFINITE);
  try
    FCommand := ACommand;
    FCallback := ACallback;
    FExitStatus := -1;
    ProcessList.Add(Self as IProcess);
  finally
    ReleaseMutex(SignalMutex);
  end; { try/finally }
{$ENDIF}
{$IFDEF LINUX}
  FCommand := ACommand;
  FCallback := ACallback;
  FExitStatus := -1;
  ProcessList.Add(Self as IProcess);
{$ENDIF}
end;

destructor TProcess.Destroy;
begin
{$IFDEF MSWINDOWS}
  WaitForSingleObject(SignalMutex, INFINITE);
  try
    if ProcessList <> nil then
      repeat
      until ProcessList.Remove(Self) = -1;
  finally
    CloseHandle(FRequestExitEvent);
    ReleaseMutex(SignalMutex);
  end; { try/finally }
{$ENDIF}
{$IFDEF LINUX}
  if ProcessList <> nil then
    repeat
    until ProcessList.Remove(Self) = -1;
{$ENDIF}
  { TODO -oOVS : exited }
  inherited;
end;

procedure TProcess.Detach;
begin
  FDetached := true;
  FCallback := nil;
end;

class procedure TProcess.Init;
{$IFDEF MSWINDOWS}
var
  ProcessExitEvent: THandle;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ProcessExitEvent := OpenEvent(SYNCHRONIZE, true, PChar(Format('Process%8x', [GetCurrentProcessId()])));
  if ProcessExitEvent <> 0 then begin
    // we have been started by TProcess.run()
    CloseHandle(ProcessExitEvent);
    ExitEventThread := TProcessExitEventListener.Create();
    ExitEventThread.Start();
  end;
{$ENDIF}
end;

{$IFDEF MSWINDOWS}
function TProcess.PHandle: THandle;
begin
  result := FProcess;
end;
{$ENDIF}

function TProcess.PId: {$IFDEF MSWINDOWS}DWORD{$ENDIF}{$IFDEF LINUX}__pid_t{$ENDIF};
begin
  result := FPId;
end;

class procedure TProcess.ProcessDied(APId: DWORD);
{$IFDEF MSWINDOWS}
var
  i: integer;
  proc: IProcess;
  exitcode: DWORD;
  procList: IInterfaceList;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  procList := TInterfaceList.Create;
  ProcessList.Lock;
  try
    for i := 0 to ProcessList.Count - 1 do begin
      proc := IProcess(ProcessList.Items[i]);
      if APId = proc.PId then begin
        GetExitCodeProcess(proc.PHandle, exitcode);
        // cannot be set to exitcode which could be -1, if mains returns with -1
        // Avoid zombies
        CloseHandle(proc.PHandle);

        if proc.Callback <> nil then
          proc.Callback.ProcessCallback(proc, pceExited);

        procList.Add(proc);
      end;
    end;
  finally
    ProcessList.Unlock;
  end; { try/finally }
  for i := 0 to procList.Count - 1 do
    repeat
    until ProcessList.Remove(procList[i]) = -1;
{$ENDIF}
end;

{$IFDEF LINUX}
procedure SignalHandler(Sig: Longint); cdecl;
var
  pid: __pid_t;
  status: Integer;
  i: integer;
  proc: IProcess;
  procList: IInterfaceList;
begin
  while True do begin
    pid := waitpid(WAIT_ANY, @status, WNOHANG);
    if (pid < 0) and (errno() = EINTR) then
      Continue;
    if (pid < 0) then
      Break;
    procList := TInterfaceList.Create;
    ProcessList.Lock;
    try
      for i := 0 to ProcessList.Count - 1 do begin
        proc := IProcess(ProcessList.Items[i]);
        if pid = proc.PId then begin
          if proc.Callback <> nil then
            proc.Callback.ProcessCallback(proc, pceExited);

          procList.Add(proc);
        end;
      end;
    finally
      ProcessList.Unlock;
    end; { try/finally }
    for i := 0 to procList.Count - 1 do
      repeat
      until ProcessList.Remove(procList[i]) = -1;
  end;
end;
{$ENDIF}

function TProcess.Run: boolean;
var
{$IFDEF MSWINDOWS}
  startupInfo: TStartupInfo;
  processInfo: TProcessInformation;
{$ENDIF}
  path: string;
begin
{$IFDEF MSWINDOWS}
  StartupInfo.cb := SizeOf(TStartupInfo);
  GetStartupInfo(StartupInfo);
  StartupInfo.lpReserved := nil;
  StartupInfo.lpTitle := nil;

  path := ExtractFilePath(Copy(FCommand, 1, Pos(' ', FCommand) - 1));
  result := CreateProcess(nil, PChar(FCommand), nil, nil, false, CREATE_NEW_CONSOLE, nil, PChar(path),
    StartupInfo, processInfo);

  CloseHandle(processInfo.hThread); // must be closed and we don't need it

  FProcess := processInfo.hProcess;
  FPid := processInfo.dwProcessId;

  if result then begin
    // Synchronization with waiting thread,
    WaitForSingleObject(SignalMutex,INFINITE);
    try
      InterlockedIncrement(NumOfChildren);
      // Insert new Process at the end
      ChildProcs[NumOfChildren] := FProcess;
      ChildPids[NumOfChildren] := FPid;
      // Wake Up the thread
      SetEvent(ChildProcs[0]);

      if (FRequestExitEvent = 0) then
        FRequestExitEvent := CreateEvent(nil, true, false, PChar(Format('Process%8x', [FPid])));
    finally
      ReleaseMutex(SignalMutex);
    end; { try/finally }
    result := FPid <> 0;
  end
  else
    result := false;
{$ENDIF}
{$IFDEF LINUX}
  FillChar(SigActionRec, SizeOf(TSigAction), 0);
  SigActionRec.__sigaction_handler := SignalHandler;
  sigaction(SIGCHLD, @SigActionRec, nil);

  result := false;
  FPid := fork();
  if FPid = -1 then
    Exit
  else if FPid = 0 then begin
    path := ExtractFileDir(FCommand);
    chdir(path);
    execl('/bin/sh', '/bin/sh', '-c', PChar('exec ' + FCommand + ' > /dev/null'), nil); 
    Halt(1);
  end
  else
    result := true;
{$ENDIF}
end;

class procedure TProcess.Shutdown;
begin
{$IFDEF MSWINDOWS}
  if ProcessExitEvent <> 0 then begin
    SetEvent(ProcessExitEvent);
  end;
{$ENDIF}
end;

{$IFDEF LINUX}
{procedure TProcess.SignalHandler(Sig: Integer);
begin

end;}
{$ENDIF}

procedure TProcess.Terminate;
begin
{$IFDEF MSWINDOWS}
  SetEvent(FRequestExitEvent);
{$ENDIF}
{$IFDEF LINUX}
  kill(FPid, SIGTERM);
{$ENDIF}
  //FCallback := nil;
end;

{ TProcessFactory }

constructor TProcessFactory.Create;
begin
  ProcessList := TInterfaceList.Create;
{$IFDEF MSWINDOWS}
  SignalMutex := CreateMutex(nil, false, nil);
  NumOfChildren := 0;
  FillChar(ChildProcs, SizeOf(ChildProcs), 0);
  FillChar(ChildPids, SizeOf(ChildPids), 0);
  ChildProcs[0] := CreateEvent(nil, false, false, nil);
  FWatcher := TProcessReaper.Create();
  FWatcher.Start();
{$ENDIF}
end;

function TProcessFactory.CreateProcess(const ACommand: string;
  const ACallback: IProcessCallback): IProcess;
begin
  result := TProcess.Create(ACommand, ACallback);
end;

destructor TProcessFactory.Destroy;
begin
{$IFDEF MSWINDOWS}
  FWatcher.Finish();
  SetEvent(ChildProcs[0]);
  ReleaseMutex(SignalMutex);
{$ENDIF}
  inherited;
end;

{ TProcessReaper }

procedure TProcessReaper.Run;
{$IFDEF MSWINDOWS}
var
  rc: DWORD;
  pid: integer;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  while true do begin
    rc := WaitForMultipleObjects(NumOfChildren + 1, @ChildProcs, false, INFINITE);

    if FFinished or (rc = WAIT_TIMEOUT) then
      Break;

    rc := rc - WAIT_OBJECT_0;
    if rc <> 0 then begin
      Dec(rc);

      // move last proc to the position of terminated proc
      // could be the same
      WaitForSingleObject(SignalMutex, INFINITE);
      try
        pid := ChildPids[rc + 1];

        ChildProcs[rc + 1] := ChildProcs[NumOfChildren];
        ChildPids[rc + 1] := ChildPids[NumOfChildren];
        InterlockedDecrement(NumOfChildren);
        // Call the "signal_handler"
        TProcess.ProcessDied(pid);
      finally
        ReleaseMutex(SignalMutex);
      end; { try/finally }
    end;
  end; { while }
{$ENDIF}
end;

{ TProcessExitEventListener }

procedure TProcessExitEventListener.Run;
begin
{$IFDEF MSWINDOWS}
  ProcessExitEvent := OpenEvent(SYNCHRONIZE, true, PChar(Format('Process%8x', [GetCurrentProcessId()])));
  if ProcessExitEvent <> 0 then begin
    WaitForSingleObject(ProcessExitEvent, INFINITE);
    ResetEvent(ProcessExitEvent);
    ORB_Instance.shutdown(false);
    ORB_Instance.perform_work();
  end;
{$ENDIF}
end;

initialization
finalization
  ProcessFactoryVar := nil;
{$IFDEF MSWINDOWS}
  ProcessList := nil;
{$ENDIF}
end.
