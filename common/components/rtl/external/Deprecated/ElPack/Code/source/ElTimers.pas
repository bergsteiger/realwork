
{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

(*

Version History

11/13/2002

  Added TimerMode property
  Added Threaded Timer mode

11/06/2002

  Enabling and disabling the timer in ElTimerPool has been improved

06/15/2002

  Added support for power events -- before the change suspending the
  system caused incorrect behaviour after operations were resumed

04/06/2002

  Setting Precise property to true could cause an AV on application exit

12/16/2000

  Precise property added to ElTimerPool. Now when Precise is false, regular
  timer is used to track timer ticks.

*)

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

//{.$define run_thread_timer_over_sleep} // if it is defined then work over Sleep


unit ElTimers;

interface

uses
  Windows,
  Messages,
  Classes,
 {$IFDEF MSWINDOWS}
  MMSystem,
 {$ENDIF}
  SysUtils,
  ElTools;

type

  TCustomElTimer = class (TObject)
  private
    FEnabled: Boolean;
    FInterval: Cardinal;
    FOneTime: Boolean;
    FOnTimer: TNotifyEvent;
    FTag: Integer;
    procedure SetInterval(const Value: Cardinal);
  protected
    procedure DoTick; virtual;
    procedure DoTimer; virtual;
    procedure SetEnabled(const Value: Boolean); virtual;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
    property OneTime: Boolean read FOneTime write FOneTime;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
    property Tag: Integer read FTag write FTag;
  public
    constructor Create; virtual;
  end;

  TElTimer = class (TCustomElTimer)
  private
    FTimerID: Integer;
    FWnd: HWND;
    procedure WndProc(var Message: TMessage);
  protected
    procedure SetEnabled(const Value: boolean); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Enabled;
    property Interval;
    property OneTime;
    property OnTimer;
    property Tag;
  end;

  TElTimerPool = class;
  TElTimerPoolItem = class;

  TElPoolTimer = class (TCustomElTimer)
  private
    FElapsed: Cardinal;
    FOwner: TElTimerPoolItem;
  protected
    procedure SetEnabled(const Value: boolean); override;
  public
    procedure Tick(TickCount : integer);
    property Elapsed: Cardinal read FElapsed write FElapsed;
    property Enabled;
    property Interval;
    property OneTime;
    property OnTimer;
    property Owner: TElTimerPoolItem read FOwner;
    property Tag;
  end;

  TElTimerPoolItem = class (TCollectionItem)
  private
    FTimer: TElPoolTimer;
    FOnTimer: TNotifyEvent;
    function GetEnabled: Boolean;
    function GetInterval: Cardinal;
    function GetOneTime: Boolean;
    function GetOnTimer: TNotifyEvent;
    function GetTag: Integer;
    procedure SetEnabled(const Value: Boolean);
    procedure SetInterval(const Value: Cardinal);
    procedure SetOneTime(const Value: Boolean);
    procedure SetOnTimer(const Value: TNotifyEvent);
    procedure SetTag(const Value: Integer);

    procedure TimerTransfer(Sender : TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Timer: TElPoolTimer read FTimer;
  published
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Interval: Cardinal read GetInterval write SetInterval default 1000;
    property OneTime: Boolean read GetOneTime write SetOneTime;
    property OnTimer: TNotifyEvent read GetOnTimer write SetOnTimer;
    property Tag: Integer read GetTag write SetTag;
  end;

  TElTimerPoolItems = class (TCollection)
  private
    FOwner: TElTimerPool;
    function GetItem(Index: integer): TElTimerPoolItem;
    procedure SetItem(Index: integer; const Value: TElTimerPoolItem);
  protected
    {$ifndef D_2}
    function GetOwner: TPersistent; override;
    {$endif}
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TElTimerPool);
    function Add: TElTimerPoolItem;
    function AddTimer(Enabled:Boolean; Interval :Cardinal; OneTime: Boolean; OnTimerEvent: TNotifyEvent):TElTimerPoolItem;
    property Items[Index: integer]: TElTimerPoolItem read GetItem write SetItem; default;
  end;

  {$IFDEF LINUX}
    TFNTimeCallBack = procedure(uTimerID, uMessage: UINT; dwUser, dw1, dw2: DWORD) stdcall;
  {$ENDIF}

  TTimerThread = class(TThread)
    private
     fuDelay,
     fuResolution :UINT;
     flpFunction  :TFNTimeCallBack;
     fdwUser      :DWORD;
    public
     constructor Create;
     procedure execute; override;
     // MMSystem.pas api emulation:
     class function timeSetEvent(uDelay, uResolution: UINT;
              lpFunction: TFNTimeCallBack;
              dwUser: DWORD; uFlags: UINT): MMRESULT;
     class function timeKillEvent(uTimerID: UINT): MMRESULT;
  end;

  TElTimerMode = ( eltWindows, eltMMedia, eltThread );

  {$warnings off}
  TElTimerPool = class (TComponent)
  private
    FEnableCount : integer;
    FItems: TElTimerPoolItems;
    FTimerID: Integer;
    FLastTick: DWORD;
    FTimerMode: TElTimerMode;
    FWnd: HWND;
    FBlockEvents : boolean;
    procedure SetItems(Value: TElTimerPoolItems);
    procedure WndProc(var Msg: TMessage);
    procedure SetTimerMode(const Value: TElTimerMode);
    function GetPrecise: boolean; {$ifdef D_6_UP} deprecated; {$endif}
    procedure SetPrecise(newValue : boolean); virtual; {$ifdef D_6_UP} deprecated; {$endif}
    procedure ReadBool(Reader : TReader);
  protected
    procedure KillCurrTimer;
    procedure EnableTimer(Enable: boolean); virtual;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Tick(TickCount : integer);
    function AddTimer(Enabled:Boolean; Interval :Cardinal; OneTime: Boolean; OnTimerEvent: TNotifyEvent):TElTimerPoolItem;
    property Precise : boolean read GetPrecise write SetPrecise; // deprecated
  published
    property Items   : TElTimerPoolItems read FItems write SetItems;
    property TimerMode: TElTimerMode read FTimerMode write SetTimerMode default eltWindows;
  end;
  {$warnings on}

implementation

const
  PBT_APMQUERYSUSPEND             = 0000;
  PBT_APMQUERYSTANDBY             = 0001;
  PBT_APMQUERYSUSPENDFAILED       = 0002;
  PBT_APMQUERYSTANDBYFAILED       = 0003;

  PBT_APMSUSPEND                  = 0004;
  PBT_APMSTANDBY                  = 0005;
  PBT_APMRESUMECRITICAL           = 0006;
  PBT_APMRESUMESUSPEND            = 0007;
  PBT_APMRESUMESTANDBY            = 0008;
  PBTF_APMRESUMEFROMFAILURE       = 00000001;

  PBT_APMBATTERYLOW               = 0009;
  PBT_APMPOWERSTATUSCHANGE        = $000A;
  PBT_APMOEMEVENT                 = $000B;
  PBT_APMRESUMEAUTOMATIC          = $0012;

const

  {$IFDEF VCL_4_USED}
    MMTimeMessageID : Cardinal = 0;
  {$ELSE}
    MMTimeMessageID : integer = 0;
  {$ENDIF}

 cTimerUIDEvent  = 1234;

{ TCustomElTimer }

{
******************************** TCustomElTimer ********************************
}
constructor TCustomElTimer.Create;
begin
  inherited;
  FInterval := 1000;
end;

procedure TCustomElTimer.DoTick;
begin
  if OneTime then
     Enabled := False;
  DoTimer;
end;

procedure TCustomElTimer.DoTimer;
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self);
end;

procedure TCustomElTimer.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
     FEnabled := Value;
end;

procedure TCustomElTimer.SetInterval(const Value: Cardinal);
begin
  if (FInterval <> Value) and (Value > 0) then
  begin
    FInterval := Value;
    if Enabled then
    begin
      Enabled := False;
      Enabled := True;
    end;
  end;
end;

{ TElTimer }

{
*********************************** TElTimer ***********************************
}
constructor TElTimer.Create;
begin
  inherited;
end;

destructor TElTimer.Destroy;
begin
  Enabled := False;
  inherited;
end;

procedure TElTimer.SetEnabled(const Value: boolean);
begin
  if Enabled <> Value then
  begin
    if Value then
    begin
      if FWnd = 0 then
          FWnd := XAllocateHWND(Self, WndProc);
        FTimerID := SetTimer(FWnd, Cardinal(Self), FInterval, nil)
    end
    else
    begin
      KillTimer(FWnd, FTimerID);
      FTimerID := 0;
      if FWnd <> 0 then
        XDeallocateHWND(FWnd);
      FWnd := 0;
     end;
    inherited;
  end;
end;

procedure TElTimer.WndProc(var Message: TMessage);
begin
  with Message do
    if Msg = WM_TIMER then
      DoTick
    else
    if Msg = WM_QUERYENDSESSION then 
      Result := 1
    else
      Result := DefWindowProc(FWnd, Msg, WParam, LParam);
end;

{ TElTimerPool }

procedure HiResTimerCallbackProc(uID : integer; uMsg : integer; dwUser, dw1,
    dw2 : DWORD);  stdcall;
begin
    PostMessage(TElTimerPool(dwUser).FWnd, MMTimeMessageID, 0, 0);
end;

procedure HiResThreadTimerCallbackProc(uID : integer; uMsg : integer; dwUser, dw1,
    dw2 : DWORD);  stdcall;
  // var i, j, k, l, TickCount : DWORD; // for (3) variant
begin
  // 1) variant
    PostMessage(TElTimerPool(dwUser).FWnd, WM_TIMER, 0, 0);

  // 2) variant
  // Be slow.
  // PostMessage(TElTimerPool(dwUser).FWnd, MMTimeMessageID, 0, 0);

  // 3) variant
  // But need protected of global properties.
  (*with TElTimerPool(dwUser) do
  begin
    i := timeGetTime;
    j := i;
    if i >= FLastTick then
       i := i - FLastTick
    else
    {$IFDEF VCL_4_USED}
       i := DWORD(Int64(i) - FLastTick);
    {$ELSE}
       i := $FFFFFFFF - FLastTick + i;
    {$ENDIF}
    FLastTick := j;
    if not FBlockEvents then
      begin
        TickCount := i;
        for k := 0 to FItems.Count - 1 do
          if FItems.Items[k].FTimer.Enabled then
          begin
            Inc(FItems.Items[k].FTimer.FElapsed, TickCount);
            if FItems.Items[k].FTimer.FElapsed >= FItems.Items[k].FTimer.Interval then
            begin
              for l := 1 to FItems.Items[k].FTimer.FElapsed div FItems.Items[k].FTimer.Interval do
              begin
                PostMessage(TElTimerPool(dwUser).FWnd, MMTimeMessageID, k, 1);
                if not FItems.Items[k].FTimer.Enabled then
                   break;
              end;
              FItems.Items[k].FTimer.FElapsed := 0;
            end;
          end;
      end;
  end;(**)
end;

{
********************************* TElTimerPool *********************************
}
constructor TElTimerPool.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
    FWnd       := XAllocateHWND(Self, WndProc);
  FItems     := TElTimerPoolItems.Create(Self);
  FTimerID   := 0;
  FTimerMode := eltWindows;
end;

destructor TElTimerPool.Destroy;
begin
  FItems.Free;
  FEnableCount := 0;
  EnableTimer(false);
  XDeallocateHWND(FWnd);
  inherited;
end;


{$ifdef D_6_UP}
  {$warnings off}
{$endif}
procedure TElTimerPool.SetPrecise(newValue : boolean);
begin
  if newValue = Precise then
    exit;
  if FTimerID = 0 then
  begin
       {$IFDEF MSWINDOWS}
         FTimerMode := eltMMedia
       {$else}
         FTimerMode := eltThread;
       {$endif}
  end
  else
  begin
    KillCurrTimer;
    if newValue then
      begin
          {$IFDEF MSWINDOWS}
            FTimerID := timeSetEvent(1, 1, @HiResTimerCallbackProc, Cardinal(Self),
                  TIME_PERIODIC);
            FTimerMode := eltMMedia;
          {$ELSE}
            FTimerID := TTimerThread.timeSetEvent(1, 1, @HiResTimerCallbackProc, Cardinal(Self),
                  TIME_PERIODIC);
            FTimerMode := eltThread;
          {$ENDIF}
      end
    else
      begin
        FTimerID := SetTimer(FWnd, cTimerUIDEvent, 10, nil);
        FLastTick:= timeGetTime;
        FTimerMode := eltWindows;
      end;
  end;
end;

function TElTimerPool.GetPrecise: boolean;
begin
    {$IFDEF MSWINDOWS}
      Result := TimerMode = eltMMedia;
    {$ELSE}
      Result := TimerMode = eltThread;
    {$ENDIF}
end;
{$ifdef D_6_UP}
  {$warnings on}
{$endif}

procedure TElTimerPool.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Precise', ReadBool, nil, false);
end;

procedure TElTimerPool.ReadBool(Reader : TReader);
begin
  if Reader.ReadBoolean then
    {$IFDEF MSWINDOWS}
      TimerMode := eltMMedia;
    {$ELSE}
      TimerMode := eltThread;
    {$ENDIF}
end;

procedure TElTimerPool.KillCurrTimer;
begin
  if FTimerID <> 0 then
    case FTimerMode of
        eltWindows:
           begin
             KillTimer(FWnd, cTimerUIDEvent);
             FTimerID := 0;
           end;
        eltMMedia:
           begin
               {$IFDEF MSWINDOWS}
               timeKillEvent(FTimerID);
               FTimerID := 0;
               sleep(0);
               {$ENDIF}
           end;
        eltThread:
           begin
             TTimerThread.timeKillEvent(FTimerID);
             FTimerID := 0;
           end;
    end;
end;

procedure TElTimerPool.SetTimerMode(const Value: TElTimerMode);
begin
  if FTimerMode <> Value then
    begin
      if FTimerID <> 0 then
      begin
         case Value of
             eltWindows:
               begin
                 KillCurrTimer;
                 FTimerID := SetTimer(FWnd, cTimerUIDEvent, 10, nil);
                 FLastTick:= timeGetTime;
               end;
             eltMMedia:
               begin
                   {$IFDEF MSWINDOWS}
                   KillCurrTimer;
                   FTimerID := timeSetEvent(1, 1, @HiResTimerCallbackProc,
                                Cardinal(Self), TIME_PERIODIC);
                   {$ENDIF}
               end;
             eltThread:
               begin
                 KillCurrTimer;
                   FTimerID := TTimerThread.timeSetEvent(1, 1, @HiResThreadTimerCallbackProc,
                                Cardinal(Self), TIME_PERIODIC);
                 FLastTick:= timeGetTime;
               end;

         end;
      end;
      FTimerMode := Value;
    end;
end;

function TElTimerPool.AddTimer(Enabled:Boolean; Interval :Cardinal; OneTime: Boolean; OnTimerEvent: TNotifyEvent):TElTimerPoolItem;
begin
  Result := Items.AddTimer(Enabled, Interval, OneTime, OnTimerEvent);
end;

procedure TElTimerPool.EnableTimer(Enable: boolean);
begin
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
  begin
    exit;
  end;
  if Enable then
  begin
    case TimerMode of
      eltWindows:
        begin
          if FTimerID = 0 then
          begin
            FTimerID := SetTimer(FWnd, cTimerUIDEvent, 10, nil);
            FLastTick:= timeGetTime;
          end;
        end;
      eltMMedia:
        begin
            {$IFDEF MSWINDOWS}
            if FTimerID = 0 then
              FTimerID := timeSetEvent(1, 1, @HiResTimerCallbackProc, Cardinal(Self),
                  TIME_PERIODIC);
            {$ENDIF}
        end;
      eltThread:
        begin
          if FTimerID = 0 then
            begin
               FTimerID := TTimerThread.timeSetEvent(1, 1, @HiResThreadTimerCallbackProc,
                            Cardinal(Self), TIME_PERIODIC);
              FLastTick:= timeGetTime;
            end;
        end;

    end;
    inc(FEnableCount);
  end
  else
  if (FTimerID <> 0) then
  begin
    dec(FEnableCount);
    if (FEnableCount <= 0) then
      KillCurrTimer;
  end;
end;

procedure TElTimerPool.SetItems(Value: TElTimerPoolItems);
begin
  FItems.Assign(Value);
end;

procedure TElTimerPool.Tick(TickCount : integer);
var
  I: Integer;
begin
  I := 0;
  while I < FItems.Count do
  begin
    FItems.Items[I].FTimer.Tick(TickCount);
    Inc(I);
  end;
end;

procedure TElTimerPool.WndProc(var Msg: TMessage);
var i, j : DWORD;
begin
  if Msg.Msg = MMTimeMessageID then // for eltMMedia
  begin
    if not FBlockEvents then
      begin
       case FTimerMode of
         eltMMedia:
            Tick(1);
         eltThread: // for (2) and (3) variants of HiResThreadTimerCallbackProc
            if Msg.WParam = 0 then
              Tick(1)
            else
              if Msg.LParam < FItems.Count then
                FItems.Items[Msg.LParam].FTimer.DoTick;
       end;
      end;
  end
  else
  if Msg.Msg = WM_POWERBROADCAST then
  begin
    if (Msg.wParam = PBT_APMSUSPEND) or
       (Msg.wParam = PBT_APMSTANDBY) then
    begin
      FBlockEvents := true;
    end;
    if (Msg.wParam = PBT_APMRESUMEAUTOMATIC) or
       (Msg.wParam = PBT_APMRESUMECRITICAL) or
       (Msg.wParam = PBT_APMRESUMESUSPEND) then
    begin
      FBlockEvents := false;
      FLastTick := timeGetTime;
    end;
    Msg.Result := DefWindowProc(FWnd, Msg.Msg, Msg.WParam, Msg.LParam);
  end
  else
  if Msg.Msg = WM_TIMER then // for eltWindows, eltThread
  begin
    i := timeGetTime;
    j := i;
    if i >= FLastTick then
       i := i - FLastTick
    else
    {$IFDEF VCL_4_USED}
       i := DWORD(Int64(i) - FLastTick);
    {$ELSE}
       i := $FFFFFFFF - FLastTick + i;
    {$ENDIF}
    FLastTick := j;
    if not FBlockEvents then
      Tick(i);
  end
  else
    Msg.Result := DefWindowProc(FWnd, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TElTimerPool.Loaded;
var i : integer;
begin
  inherited;
  for i := 0 to FItems.Count - 1 do
    if Items[i].Enabled then
    begin
      EnableTimer(true);
      break;
    end;
end;

{TElTimerPoolItem}

{
******************************* TElTimerPoolItem *******************************
}
constructor TElTimerPoolItem.Create(Collection: TCollection);
begin
  inherited;
  FTimer := TElPoolTimer.Create;
  FTimer.FOwner := Self;
  Interval := 1000;
end;

destructor TElTimerPoolItem.Destroy;
begin
  Enabled := False;
  FTimer.Free;
  inherited;
end;

procedure TElTimerPoolItem.Assign(Source: TPersistent);
begin
  if Source is TElTimerPoolItem then
  begin
    Tag := TElTimerPoolItem(Source).Tag;
    Interval := TElTimerPoolItem(Source).Interval;
    OneTime := TElTimerPoolItem(Source).OneTime;
    Enabled := TElTimerPoolItem(Source).Enabled;
  end
  else
    inherited;
end;

function TElTimerPoolItem.GetEnabled: Boolean;
begin
  Result := FTimer.Enabled;
end;

function TElTimerPoolItem.GetInterval: Cardinal;
begin
  Result := FTimer.Interval;
end;

function TElTimerPoolItem.GetOneTime: Boolean;
begin
  Result := FTimer.OneTime;
end;

function TElTimerPoolItem.GetOnTimer: TNotifyEvent;
begin
  Result := FOnTimer;
end;

function TElTimerPoolItem.GetTag: Integer;
begin
  Result := FTimer.Tag;
end;

procedure TElTimerPoolItem.SetEnabled(const Value: Boolean);
begin
  if FTimer.Enabled <> Value then
  begin
    FTimer.Enabled := Value;
    Changed(false);
  end;
end;

procedure TElTimerPoolItem.SetInterval(const Value: Cardinal);
begin
  FTimer.Interval := Value;
end;

procedure TElTimerPoolItem.SetOneTime(const Value: Boolean);
begin
  FTimer.OneTime := Value;
end;

procedure TElTimerPoolItem.SetOnTimer(const Value: TNotifyEvent);
begin
  FTimer.OnTimer := TimerTransfer;
  FOnTimer := Value;
end;

procedure TElTimerPoolItem.SetTag(const Value: Integer);
begin
  FTimer.Tag := Value;
end;

procedure TElTimerPoolItem.TimerTransfer(Sender : TObject);
begin
  if assigned(FOnTimer) then FOnTimer(Self);
end;

{ TElTimerPoolItems }

{
****************************** TElTimerPoolItems *******************************
}
constructor TElTimerPoolItems.Create(AOwner: TElTimerPool);
begin
  inherited Create(TElTimerPoolItem);
  FOwner := AOwner;
end;

function TElTimerPoolItems.Add: TElTimerPoolItem;
begin
  Result := TElTimerPoolItem(inherited Add);
end;

function TElTimerPoolItems.AddTimer(Enabled:Boolean; Interval :Cardinal; OneTime: Boolean; OnTimerEvent: TNotifyEvent):TElTimerPoolItem;
begin
  Result := Add;
  Result.OnTimer := OnTimerEvent;
  Result.Interval := Interval;
  Result.OneTime := OneTime;
  Result.Enabled :=  Enabled;
end;

function TElTimerPoolItems.GetItem(Index: integer): TElTimerPoolItem;
begin
  Result := TElTimerPoolItem(inherited GetItem(Index));
end;

{$ifndef D_2}
function TElTimerPoolItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;
{$endif}

procedure TElTimerPoolItems.SetItem(Index: integer; const Value:
    TElTimerPoolItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TElTimerPoolItems.Update(Item: TCollectionItem);
begin
  if (Item <> nil) and (FOwner.ComponentState * [csLoading, csReading] = []) then
    FOwner.EnableTimer(TElTimerPoolItem(Item).Enabled);
end;

{ TElPoolTimer }

{
********************************* TElPoolTimer *********************************
}

procedure TElPoolTimer.SetEnabled(const Value: boolean);
begin
  if Value <> Enabled then
  begin
    inherited;
    if csDesigning in TElTimerPoolItems(FOwner.Collection).FOwner.ComponentState then
      exit;
    TElTimerPoolItems(FOwner.Collection).FOwner.EnableTimer(Value);
    if Value then
       FElapsed := 0;
  end;
end;

procedure TElPoolTimer.Tick(TickCount : integer);
var i : integer;
begin
  if Enabled then
  begin
    Inc(FElapsed, TickCount);
    if FElapsed >= Interval then
    begin
      for i := 1 to FElapsed div Interval do
      begin
        DoTick;
        if not Enabled then
           break;
      end;
      FElapsed := 0;
    end;
  end;
end;

{ TTimerThread }

{
********************************* TTimerThread *********************************
}

{$ifndef run_thread_timer_over_sleep}

var
 TimerEvent
{$IFDEF MSWINDOWS} // OR CLR: ???
        :THandle;
{$ELSE}
 {$IFDEF LINUX}
        :TPipeDescriptors;
 {$ELSE}
    {$MESSAGE Error 'TimerEvent is specified for platform'}
 {$ENDIF LINUX}
{$ENDIF MSWINDOWS}


{$IFDEF MSWINDOWS}
{$ifndef D_6_UP}
function SysErrorMessage(ErrorCode: Integer): string;
var
  Buffer: array[0..255] of Char;
var
  Len: Integer;
begin
  Len := FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS or
    FORMAT_MESSAGE_ARGUMENT_ARRAY, nil, ErrorCode, 0, Buffer,
    SizeOf(Buffer), nil);
  while (Len > 0) and (Buffer[Len - 1] in [#0..#32, '.']) do Dec(Len);
  SetString(Result, Buffer, Len);
end;

resourcestring
  SUnkOSError = 'A call to an OS function failed';
  SOSError = 'System Error.  Code: %d.'#13#10'%s';

procedure RaiseLastOSError;
 var LastError: Integer;
begin
  LastError := GetLastError;
  if LastError <> 0 then
    raise Exception.CreateFmt(SOSError, [LastError, SysErrorMessage(LastError)])
  else
    raise Exception.Create(SUnkOSError);
end;
{$endif ifndef D_6_UP}
{$ENDIF MSWINDOWS}

procedure InitTimerEvent;
begin
{$IFDEF MSWINDOWS}
   TimerEvent := CreateEvent(nil, True, False, '');
   if TimerEvent = 0 then
     RaiseLastOSError;
{$ELSE}
 {$IFDEF LINUX}
   if pipe(TimerEvent) < 0 then
     RaiseLastOSError;
 {$ELSE}
   ERROR
 {$ENDIF LINUX}
{$ENDIF MSWINDOWS}
end;

procedure DoneTimerEvent;
begin
{$IFDEF MSWINDOWS}
   CloseHandle(TimerEvent);
{$ELSE}
 {$IFDEF LINUX}
   __close(TimerEvent.ReadDes);
   __close(TimerEvent.WriteDes);
 {$ELSE}
 ERROR
 {$ENDIF LINUX}
{$ENDIF MSWINDOWS}
end;

procedure WaitForTimerEvent(Timeout: Integer);
{$IFDEF LINUX}
var
  EventFds: TFDSet;
  Tm: TTimeVal;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
   WaitForSingleObject(TimerEvent, Timeout);
{$ELSE}
 {$IFDEF LINUX}
   FD_ZERO(EventFds);
   FD_SET(TimerEvent.ReadDes, EventFds);
   Tm.tv_sec := Timeout div 1000;
   Tm.tv_usec := (Timeout mod 1000) * 1000;
   select(TimerEvent.ReadDes + 1, @EventFds, nil, nil, @Tm);
 {$ELSE}
  ERROR
 {$ENDIF LINUX}
{$ENDIF MSWINDOWS}
end;

{$endif run_thread_timer_over_sleep}

constructor TTimerThread.Create;
begin
   inherited Create(True);
     FreeOnTerminate := False;
     //vAd: ???
     Priority := tpHigher;
end;

procedure TTimerThread.execute;
begin
 try
  while not Terminated do
    begin
        {$ifndef run_thread_timer_over_sleep}
          WaitForTimerEvent(fuDelay{-1});
        {$else}
          sleep(fuDelay-1); // uDelay = 1
        {$endif}
        if Assigned(flpFunction) then
          flpFunction(
            {uTimerID = }UINT(Self),
            MMTimeMessageID, // any
            fdwUser,         // = TElTimerPool
            0,               // any
            0                // any
          );
    end;
 except
 end;
end;

class function TTimerThread.timeSetEvent(uDelay, uResolution: UINT;
  lpFunction: TFNTimeCallBack;
  dwUser: DWORD; uFlags: UINT
): MMRESULT;
  var vResult :TTimerThread;
begin
   vResult := TTimerThread.Create;

   if uDelay <=0 then
   uDelay := 1;
   if uResolution <=0 then
   uResolution := 1;

   vResult.fuDelay      := uDelay;
   vResult.fuResolution := uResolution;
   vResult.flpFunction  := lpFunction;

   vResult.fdwUser      := dwUser; // = TElTimerPool

     Result               := MMRESULT(vResult);
   vResult.Resume;
end;

class function TTimerThread.timeKillEvent(uTimerID: UINT): MMRESULT;
begin
    if TObject(uTimerID) is TTimerThread then
      with TTimerThread(uTimerID) do
        begin
          Terminate;
            try
             WaitFor;
             Free;
             Result := 0;
            except
             //???:
             //Classes.pas: CheckThreadError(GetExitCodeThread(H[0], Result));
             Result := 1;
            end;
        end
    else
      Result := 1;
end;

initialization

  MMTimeMessageID := RegisterWindowMessage('ElPack Timer pool tick message');

{$ifndef run_thread_timer_over_sleep}
  InitTimerEvent;
{$endif}

finalization

{$ifndef run_thread_timer_over_sleep}
  DoneTimerEvent;
{$endif}

end.
