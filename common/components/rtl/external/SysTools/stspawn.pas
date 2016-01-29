{*********************************************************}
{*                   STSPAWN.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

unit StSpawn;

interface

uses
  SysUtils,
  {$IFDEF WIN32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  ExtCtrls, Messages, Classes, ShellAPI,

  StBase,
  StConst;


type
  {$IFDEF WIN32}
  TStWaitThread = class(TThread)
    protected
      FTimeOut  : Longint;
      procedure Execute; override;
    public
      CancelWaitEvent : THandle;
      WaitResult  : DWORD;
      WaitFors    : array[0..1] of THandle;

      constructor Create(aInst, CancelIt : THandle; ATimeOut : Longint);
  end;
  {$ENDIF}

  TStSpawnCommand = (scOpen, scPrint);
  TStShowState = (ssMinimized, ssMaximized, ssNormal, ssMinNotActive);

  TStSpawnErrorEvent = procedure (Sender : TObject; Error : Word) of object;
  TStSpawnCompletedEvent = procedure (Sender : TObject) of object;
  TStSpawnTimeOutEvent = procedure (Sender : TObject) of object;

  TStSpawnApplication = class(TStComponent)
  protected {private}
    { Private declarations }

    FAllowChange    : Boolean;
    FCancelEvent    : THandle;
    FDefaultDir     : string;
    FFileName       : string;
    FInstance       : THandle;
    FNotifyWhenDone : Boolean;
    FOnCompleted    : TStSpawnCompletedEvent;
    FOnSpawnError   : TStSpawnErrorEvent;
    FOnSpawnTimeOut : TStSpawnTimeOutEvent;
    FRunParameters  : string;
    FShowState      : TStShowState;
    FSpawnCommand   : TStSpawnCommand;
    FTimer          : TTimer;
    FTimeOut        : Longint;
    {$IFDEF WIN32}
    FWaitResult     : DWORD;
    FWaitThread     : TStWaitThread;
    {$ENDIF}

  protected
    { Protected declarations }

    CountDownValue : Longint;


    {$IFDEF WINDOWS}
    procedure OnSpawnTimer(Sender : TObject);
    {$ELSE}
    procedure DoOnThreadEnd(Sender : TObject);
    {$ENDIF}

    procedure SetDefaultDir(Value : string);
    procedure SetFileName(Value : string);
    procedure SetOnCompleted(Value : TStSpawnCompletedEvent);
    procedure SetOnSpawnError(Value : TStSpawnErrorEvent);
    procedure SetNotifyWhenDone(Value : Boolean);
    procedure SetRunParameters(Value : string);
    procedure SetShowState(Value : TStShowState);
    procedure SetSpawnCommand(Value : TStSpawnCommand);
    procedure SetSpawnTimeOut(Value : TStSpawnTimeOutEvent);
    procedure SetTimeOut(Value : Longint);
  public
    { Public declarations }

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure CancelWait;
    function Execute : THandle;
  published
    { Published declarations }

    property DefaultDir : string
      read FDefaultDir
      write SetDefaultDir;

    property FileName : string
      read FFileName
      write SetFileName;

    property NotifyWhenDone : Boolean
      read FNotifyWhenDone
      write SetNotifyWhenDone;

    property OnCompleted : TStSpawnCompletedEvent
      read FOnCompleted
      write SetOnCompleted;

    property OnSpawnError : TStSpawnErrorEvent
      read FOnSpawnError
      write SetOnSpawnError;

    property OnTimeOut : TStSpawnTimeOutEvent
      read FOnSpawnTimeOut
      write SetSpawnTimeOut;

    property RunParameters : string
      read FRunParameters
      write SetRunParameters;

    property ShowState : TStShowState
      read FShowState
      write SetShowState;

    property SpawnCommand : TStSpawnCommand
      read FSpawnCommand
      write SetSpawnCommand;

    property TimeOut : Longint
      read FTimeOut
      write SetTimeOut;

  end;

implementation

{-----------------------------------------------------------------------------}
{                               WIN32  WAIT THREAD                            }
{-----------------------------------------------------------------------------}

{$IFDEF WIN32}
constructor TStWaitThread.Create(aInst, CancelIt : THandle; ATimeOut : Longint);
begin
  WaitFors[0] := aInst;
  WaitFors[1] := CancelIt;
  FTimeOut := ATimeOut * 1000;
  CancelWaitEvent := CancelIt;

  inherited Create(True);
end;


procedure TStWaitThread.Execute;
begin
  if (FTimeOut > 0) then
    WaitResult := WaitForMultipleObjects(2, @WaitFors, False, FTimeOut)
  else
    WaitResult := WaitForMultipleObjects(2, @WaitFors, False, INFINITE);
end;
{$ENDIF}



{-----------------------------------------------------------------------------}
{                               TStSpawnApplication                           }
{-----------------------------------------------------------------------------}

constructor TStSpawnApplication.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FAllowChange    := True;
  FDefaultDir     := '';
  FFileName       := '';
  FNotifyWhenDone := True;
  FShowState      := ssNormal;
  FSpawnCommand   := scOpen;
  FTimer          := nil;
  {FTimeOut       := 60;}
  FTimeOut        := 0;                                                {!!.01}

end;

destructor TStSpawnApplication.Destroy;
begin
  FTimer.Free;
  FTimer := nil;

  inherited Destroy;
end;


{$IFDEF WIN32}
procedure TStSpawnApplication.CancelWait;
begin
  if (FCancelEvent <> 0) then
    SetEvent(FWaitThread.CancelWaitEvent);
end;


procedure TStSpawnApplication.DoOnThreadEnd(Sender : TObject);
begin
  FWaitResult := FWaitThread.WaitResult;

  case FWaitResult of
    WAIT_FAILED :
      begin
        if (Assigned(FOnSpawnError)) then
          FOnSpawnError(Self, GetLastError);
      end;

    WAIT_TIMEOUT :
      begin
        if Assigned(FOnSpawnTimeOut) then
          FOnSpawnTimeOut(Self);
      end;

    WAIT_OBJECT_0,
    WAIT_OBJECT_0 + 1 :
      begin
        if (FNotifyWhenDone) and (Assigned(FOnCompleted)) then
          FOnCompleted(Self);
      end;
  end;

  if (FCancelEvent <> 0) then begin
    SetEvent(FCancelEvent);
    CloseHandle(FCancelEvent);
    FCancelEvent := 0;
  end;
end;


function TStSpawnApplication.Execute : THandle;
var
  Cmd         : string;
  HowShow     : integer;
  Res         : Bool;
  Startup     : TShellExecuteInfo;

begin
  if (FileName = '') and (RunParameters > '') then
    RaiseStError(EStSpawnError, stscInsufficientData);
  if (FSpawnCommand = scOpen) then
    Cmd := 'open'
  else
    Cmd := 'print';

  case FShowState of
    ssNormal       : HowShow := SW_NORMAL;
    ssMinimized    : HowShow := SW_MINIMIZE;
    ssMaximized    : HowShow := SW_SHOWMAXIMIZED;
    ssMinNotActive : HowShow := SW_SHOWMINNOACTIVE;
  else
    HowShow := SW_NORMAL;
  end;
  FInstance := 0;

  with Startup do begin
    cbSize       := SizeOf(Startup);
    fMask        := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_NO_UI;
    Wnd          := 0;
    lpVerb       := PChar(Cmd);
    if (FFileName > '') then
      lpFile       := PChar(FFileName)
    else
      lpFile       := nil;
    if (FRunParameters > '') then
      lpParameters := PChar(FRunParameters)
    else
      lpParameters := nil;
    if (FDefaultDir > '') then
      lpDirectory  := PChar(FDefaultDir)
    else
      lpDirectory  := nil;
    nShow        := HowShow;
    hInstApp     := 0;
  end;

  Res := ShellExecuteEx(@Startup);
  FInstance := Startup.hProcess;

  if (not Res) then begin
    Result := 0;
    if (Assigned(FOnSpawnError)) then begin
      FOnSpawnError(Self, GetLastError);
    end;
  end else
    Result := FInstance;

  if (NotifyWhenDone) then begin
    FTimer := nil;
    FCancelEvent := CreateEvent(nil, False, False, PChar(FloatToStr(Now)));

    FWaitThread := TStWaitThread.Create(FInstance, FCancelEvent, FTimeOut);
    FWaitThread.OnTerminate := DoOnThreadEnd;
    FWaitThread.FreeOnTerminate := True;
    FWaitThread.Resume;
  end;
end;

{$ELSE}   {16-bit implementation}
function TStSpawnApplication.Execute : THandle;
var
  Path,
  CmdLine,
  Dir      : PChar;
  Cmd      : array[0..5] of char;
  HowShow  : integer;
  Err      : THandle;


begin
  if (FSpawnCommand = scOpen) then
    StrPCopy(Cmd, 'open')
  else
    StrPCopy(Cmd, 'print');

  case FShowState of
    ssNormal       : HowShow := SW_NORMAL;
    ssMinimized    : HowShow := SW_MINIMIZE;
    ssMaximized    : HowShow := SW_SHOWMAXIMIZED;
    ssMinNotActive : HowShow := SW_SHOWMINNOACTIVE;
  else
    HowShow := SW_NORMAL;
  end;
  FInstance := 0;

  GetMem(Path, Length(FFileName)+1);
  GetMem(CmdLine, Length(FRunParameters)+1);
  GetMem(Dir, Length(FDefaultDir)+1);

  if (NotifyWhenDone) or (FTimeOut > 0) then begin
    FTimer := TTimer.Create(Self);
    FTimer.OnTimer := OnSpawnTimer;
    FTimer.Interval := 1000;
    FCancelEvent := 0;
    if (FTimeOut > 0) then
      CountDownValue := FTimeOut;
  end else
    FTimer := nil;

  try
    StrPCopy(Path, FFileName);
    StrPCopy(CmdLine, FRunParameters);
    StrPCopy(Dir, FDefaultDir);

    FInstance := ShellExecute(0, Cmd, Path, CmdLine, Dir, HowShow);
    Result := FInstance;
    if (FInstance < 33) then begin

      FTimer.Enabled := False;
      Err := FInstance;
      FInstance := 0;
      if (Assigned(FOnSpawnError)) then
        FOnSpawnError(Self, Err);
    end else begin
      if (Assigned(FTimer)) and (NotifyWhenDone) then begin
        FTimer.Enabled := True;
      end;
    end;

  finally
    FreeMem(Path, Length(FFileName)+1);
    FreeMem(CmdLine, Length(FRunParameters)+1);
    FreeMem(Dir, Length(FDefaultDir)+1);
  end;
end;
{$ENDIF}


{$IFDEF WINDOWS}  {16-bit implementation}
procedure TStSpawnApplication.CancelWait;
begin
  FTimer.Enabled := False;
end;

procedure TStSpawnApplication.OnSpawnTimer(Sender : TObject);
begin
  if (GetModuleUsage(FInstance) = 0) then begin
    FTimer.Enabled := False;
    FInstance := 0;
    OutputDebugString('Expected failure of GetModuleUsage'#10#13);
    if (FNotifyWhenDone) and (Assigned(FOnCompleted)) then
      FOnCompleted(Self);
  end;

  if (Assigned(FOnSpawnTimeOut)) and (FTimeOut > 0) then begin
    Dec(CountDownValue);
    if (CountDownValue < 1) and (FInstance <> 0) then begin
      FTimer.Enabled := False;
      FInstance := 0;
      FOnSpawnTimeOut(Self);
    end;
  end;
end;
{$ENDIF}

procedure TStSpawnApplication.SetDefaultDir(Value : string);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then begin
    if (Value <> FDefaultDir) then
      FDefaultDir := Value;
  end;
end;


procedure TStSpawnApplication.SetFileName(Value : string);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then begin
    if (Value <> FileName) then
      FFileName := Value;
  end;
end;


procedure TStSpawnApplication.SetNotifyWhenDone(Value : Boolean);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then begin
    if (Value <> FNotifyWhenDone) then
      FNotifyWhenDone := Value;
  end;
end;


procedure TStSpawnApplication.SetRunParameters(Value : string);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then begin
    if (Value <> FRunParameters) then
      FRunParameters := Value;
  end;
end;


procedure TStSpawnApplication.SetOnCompleted(Value : TStSpawnCompletedEvent);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then
    FOnCompleted := Value;
end;


procedure TStSpawnApplication.SetOnSpawnError(Value : TStSpawnErrorEvent);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then
    FOnSpawnError := Value;
end;


procedure TStSpawnApplication.SetShowState(Value : TStShowState);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then begin
    if (Value <> FShowState) then
      FShowState := Value;
  end;
end;


procedure TStSpawnApplication.SetSpawnCommand(Value : TStSpawnCommand);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then begin
    if (Value <> FSpawnCommand) then
      FSpawnCommand := Value;
  end;
end;


procedure TStSpawnApplication.SetSpawnTimeOut(Value : TStSpawnTimeOutEvent);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then
    FOnSpawnTimeOut := Value;
end;


procedure TStSpawnApplication.SetTimeOut(Value : Longint);
begin
  if (FAllowChange) or (csDesigning in ComponentState) then begin
    if (Value <> FTimeOut) and (Value >= 0) then
      FTimeOut := Value;
  end;
end;


end.
