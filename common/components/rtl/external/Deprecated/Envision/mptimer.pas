unit MPTimer;

{$I MPC.INC}

interface

uses
  SysUtils, Classes, ExtCtrls;

type
  TMPTriggerEvent = procedure(Sender: TObject; Handle: integer; IntervalTicks, ElapsedTicks: longint) of object;
  TMPTriggerDestroyEvent = procedure(Sender: TObject; Handle: integer; ElapsedTicks: longint) of object;
  TMPTriggerEnableEvent = procedure(Sender: TObject; Handle: integer; Enabled: boolean; var Allow: boolean) of object;

  TTriggerIterator = function(aTrigger: TComponent; Data: pointer): boolean;

  TMPTimerPool = class(TComponent)
    private
      FDefEnabled: boolean;
      FTimer: TTimer;
      FOnAllTriggers: TMPTriggerEvent;

      function CheckHandle(Handle: integer): TComponent;
      function ForEachTrigger(Proc: TTriggerIterator; Data: pointer): TComponent;
      function ForEachEnabledTrigger(Proc: TTriggerIterator; Data: pointer): TComponent;    
      procedure CalcNewInterval;
      function GetEnabledTriggerCount: integer;
      function GetTriggerCount: integer;
      function GetElapsedTriggerTime(Handle: integer): longint;
      function GetElapsedTriggerTimeSec(Handle: integer): longint;
      procedure SetOnTrigger(Handle: integer; Value: TMPTriggerEvent);
      function GetOnTrigger(Handle: integer): TMPTriggerEvent;
      procedure SetOnTriggerDestroy(Handle: integer; Value: TMPTriggerDestroyEvent);
      function GetOnTriggerDestroy(Handle: integer): TMPTriggerDestroyEvent;
      procedure SetOnTriggerEnable(Handle: integer; Value: TMPTriggerEnableEvent);
      function GetOnTriggerEnable(Handle: integer): TMPTriggerEnableEvent;
      procedure SetTriggerEnabled(Handle: integer; Value: boolean);
      function GetTriggerEnabled(Handle: integer): boolean;
      procedure SetTriggerInterval(Handle: integer; Value: longint);
      function GetTriggerInterval(Handle: integer): longint;
      procedure SetTriggerTimes(Handle: integer; Value: longint);
      function GetTriggerTimes(Handle: integer): longint;
      procedure TimerEvent(Sender: TObject);

    protected
      function CalcNewHandle: integer; virtual;
      procedure DoOnAllTriggers; virtual;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
      constructor Create(AOwner: TComponent); override;

      function AddTimes(aOnTrigger: TMPTriggerEvent; aInterval, aMaxTimes: longint): integer;
      function AddOnce(aOnTrigger: TMPTriggerEvent; aInterval: longint): integer;
      function Add(aOnTrigger: TMPTriggerEvent; aInterval: longint): integer;
      procedure Remove(Handle: integer);
      procedure RemoveAll;
      
      property Count: integer read GetTriggerCount;
      property EnabledCount: integer read GetEnabledTriggerCount;
      property ElapsedTime[Handle: integer]: longint read GetElapsedTriggerTime;
      property ElapsedSeconds[Handle: integer]: longint read GetElapsedTriggerTimeSec;
      property OnTrigger[Handle: integer]: TMPTriggerEvent read GetOnTrigger write SetOnTrigger;
      property OnDestroy[Handle: integer]: TMPTriggerDestroyEvent read GetOnTriggerDestroy write SetOnTriggerDestroy;
      property OnEnable[Handle: integer]: TMPTriggerEnableEvent read GetOnTriggerEnable write SetOnTriggerEnable;
      property Enabled[Handle: integer]: boolean read GetTriggerEnabled write SetTriggerEnabled;
      property Interval[Handle: integer]: longint read GetTriggerInterval write SetTriggerInterval;
      property Times[Handle: integer]: longint read GetTriggerTimes write SetTriggerTimes;

    published
      property OnAllTriggers: TMPTriggerEvent read FOnAllTriggers write FOnAllTriggers;
      property DefEnabled: boolean read FDefEnabled write FDefEnabled default true;
  end;

procedure Register;

implementation

uses
  WinProcs, Forms;

type
  TTrigger = class(TComponent)
    private
      FEnabled: boolean;
      FHandle: integer;
      FInterval: longint;
      FMaxTimes: longint;
      FLastTicks: longint;
      FInitTicks: longint;
      FOnTrigger: TMPTriggerEvent;
      FOnDestroy: TMPTriggerDestroyEvent;
      FOnEnable: TMPTriggerEnableEvent;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function ElapsedTime: longint;
      function ElapsedSecs: longint;
      procedure SetMaxTimes(Value: longint);
      procedure SetEnabled(Value: boolean);
      procedure SetInterval(Value: longint);
      procedure Calc(TC: longint);
      procedure DoTrigger(TC: longint);
      procedure DoDestroy;
      function DoEnable(NewValue: boolean): boolean;
      property MaxTimes: longint read FMaxTimes write SetMaxTimes;
      property Interval: longint read FInterval write SetInterval;
      property Enabled: boolean read FEnabled write SetEnabled;
  end;

constructor TTrigger.Create(AOwner: TComponent);
begin
  FHandle:= TMPTimerPool(AOwner).CalcNewHandle;
  inherited Create(AOwner);
  FLastTicks:= GetTickCount;
  FInitTicks:= FLastTicks;
end;

destructor TTrigger.Destroy;
begin
  if not (csDestroying in ComponentState) then
    DoDestroy;        
  inherited Destroy;    
end;

function TTrigger.ElapsedTime: longint;
begin
  Result:= GetTickCount - FInitTicks;  
end;

function TTrigger.ElapsedSecs: longint;
begin
  Result:= ElapsedTime div 1000;
end;

procedure TTrigger.SetMaxTimes(Value: longint);
begin
  if FMaxTimes <> Value then
  begin
    if Value = 0 then
    begin
      Value:= -1;
      Enabled:= false;
    end; {if}
    FMaxTimes:= Value;
  end; {if}
end;

procedure TTrigger.SetInterval(Value: longint);
begin
  if Value < 55 then
    FInterval:= 55
  else
    FInterval:= Value;
end;

procedure TTrigger.SetEnabled(Value: boolean);
begin
  if Value <> Enabled then
    if DoEnable(Value) then
      FEnabled:= Value;
end;

procedure TTrigger.Calc(TC: longint);
begin
  if TC - FLastTicks >= FInterval - 23 then
    DoTrigger(TC);
end;

procedure TTrigger.DoDestroy;
begin
  if assigned(FOnDestroy) then
    try
      FOnDestroy(Owner, FHandle, GetTickCount - FInitTicks);
    except
      on EAbort do;
      on E:Exception do
        Application.ShowException(E);
    end;
end;

function TTrigger.DoEnable(NewValue: boolean): boolean;
begin
  Result:= true;
  if assigned(FOnEnable) then
    try
      FOnEnable(Owner, FHandle, NewValue, Result);
    except
      on EAbort do;
      on E:Exception do
        Application.ShowException(E);
    end;
end;

procedure TTrigger.DoTrigger(TC: longint);
begin
  if assigned(FOnTrigger) then
    try
      FOnTrigger(Owner, FHandle, TC - FLastTicks, TC - FInitTicks);
    except
      on EAbort do;
      on E:Exception do
        Application.ShowException(E);
    end;
  FLastTicks:= TC;
  if FMaxTimes > 0 then
    dec(FMaxTimes);
  if FMaxTimes = 0 then
  begin
    Enabled:= false;
    FMaxTimes:= -1;
  end; {if}
end;

constructor TMPTimerPool.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDefEnabled:= true;
end;

function TMPTimerPool.ForEachTrigger(Proc: TTriggerIterator; Data: pointer): TComponent;

var
  x: integer;

begin
  for x:= 0 to ComponentCount -1 do
  begin
    Result:= Components[x];
    if Result is TTrigger then
      if not Proc(Result, Data) then
        exit;
  end; {for}
  Result:= nil;
end;

function TMPTimerPool.ForEachEnabledTrigger(Proc: TTriggerIterator; Data: pointer): TComponent;

var
  x: integer;
  
begin
  for x:= 0 to ComponentCount -1 do
  begin
    Result:= Components[x];
    if (Result is TTrigger) and TTrigger(Result).Enabled then
      if not Proc(Result, Data) then
        exit;
  end; {for}
  Result:= nil;
end;

function CompareHandle(aTrigger: TComponent; Data: pointer): boolean; far;
begin
  Result:= TTrigger(aTrigger).FHandle <> integer(Data);   
end;

function TMPTimerPool.CalcNewHandle: integer;
begin
  Result:= 0;
  while ForEachTrigger(CompareHandle, pointer(Result)) <> nil do
    inc(Result);
end;

function TMPTimerPool.CheckHandle(Handle: integer): TComponent;

procedure Error;
begin
  raise EListError.CreateFmt('Invalid trigger handle %d', [Handle]);
end;

begin
  if Handle < 0 then
    Error;
  Result:= ForEachTrigger(CompareHandle, pointer(Handle));
  if not assigned(Result) then
    Error;
end;

function CalcLowestInterval(aTrigger: TComponent; Data: pointer): boolean; far;
begin
  if longint(Data^) > TTrigger(aTrigger).Interval then
    longint(Data^):= TTrigger(aTrigger).Interval;
  Result:= true;
end;

procedure TMPTimerPool.CalcNewInterval;

var
  LowestInterval: longint;

begin
  if EnabledCount > 0 then
  begin
    LowestInterval:= MaxLongInt;
    ForEachEnabledTrigger(CalcLowestInterval, @LowestInterval);
    if LowestInterval < 55 then
      LowestInterval:= 55;
    if (not assigned(FTimer)) or (FTimer.Interval <> LowestInterval) then
    begin
      FTimer.Free;
      FTimer:= TTimer.Create(Self);
      FTimer.Interval:= LowestInterval;
      FTimer.Enabled:= true;
      FTimer.OnTimer:= TimerEvent; 
    end; {if}
  end
  else
    FTimer.Free;
end;

function CountTriggers(aTrigger: TComponent; Data: pointer): boolean; far;
begin
  inc(integer(Data^));
  Result:= true;
end;

function TMPTimerPool.GetEnabledTriggerCount: integer;
begin
  Result:= 0;
  ForEachEnabledTrigger(CountTriggers, @Result);
end;

function TMPTimerPool.GetTriggerCount: integer;
begin
  Result:= ComponentCount - ord(assigned(FTimer));
end;

function TMPTimerPool.GetElapsedTriggerTime(Handle: integer): longint;
begin
  Result:= TTrigger(CheckHandle(Handle)).ElapsedTime;
end;

function TMPTimerPool.GetElapsedTriggerTimeSec(Handle: integer): longint;
begin
  Result:= TTrigger(CheckHandle(Handle)).ElapsedSecs;
end;

procedure TMPTimerPool.SetOnTrigger(Handle: integer; Value: TMPTriggerEvent);
begin
  TTrigger(CheckHandle(Handle)).FOnTrigger:= Value;
end;

function TMPTimerPool.GetOnTrigger(Handle: integer): TMPTriggerEvent;
begin
  Result:= TTrigger(CheckHandle(Handle)).FOnTrigger;
end;

procedure TMPTimerPool.SetOnTriggerDestroy(Handle: integer; Value: TMPTriggerDestroyEvent);
begin
  TTrigger(CheckHandle(Handle)).FOnDestroy:= Value;
end;

function TMPTimerPool.GetOnTriggerDestroy(Handle: integer): TMPTriggerDestroyEvent;
begin
  Result:= TTrigger(CheckHandle(Handle)).FOnDestroy; 
end;

procedure TMPTimerPool.SetOnTriggerEnable(Handle: integer; Value: TMPTriggerEnableEvent);
begin
  TTrigger(CheckHandle(Handle)).FOnEnable:= Value;
end;

function TMPTimerPool.GetOnTriggerEnable(Handle: integer): TMPTriggerEnableEvent;
begin
  Result:= TTrigger(CheckHandle(Handle)).FOnEnable; 
end;

procedure TMPTimerPool.SetTriggerEnabled(Handle: integer; Value: boolean);
begin
  TTrigger(CheckHandle(Handle)).Enabled:= Value;
  CalcNewInterval;
end;

function TMPTimerPool.GetTriggerEnabled(Handle: integer): boolean;
begin
  Result:= TTrigger(CheckHandle(Handle)).Enabled;
end;

procedure TMPTimerPool.SetTriggerInterval(Handle: integer; Value: longint);
begin
  TTrigger(CheckHandle(Handle)).Interval:= Value;
  CalcNewInterval;
end;

function TMPTimerPool.GetTriggerInterval(Handle: integer): longint;
begin
  Result:= TTrigger(CheckHandle(Handle)).Interval;
end;

procedure TMPTimerPool.SetTriggerTimes(Handle: integer; Value: longint);
begin
  TTrigger(CheckHandle(Handle)).MaxTimes:= Value;
end;

function TMPTimerPool.GetTriggerTimes(Handle: integer): longint;
begin
  Result:= TTrigger(CheckHandle(Handle)).MaxTimes;
end;

function TriggerCalc(aTrigger: TComponent; Data: pointer): boolean; far;
begin
  TTrigger(aTrigger).Calc(longint(Data));
  Result:= true;
end;

procedure TMPTimerPool.TimerEvent(Sender: TObject);
begin
  DoOnAllTriggers;
end;

procedure TMPTimerPool.DoOnAllTriggers;
begin
  ForEachEnabledTrigger(TriggerCalc, pointer(GetTickCount));
  if assigned(FOnAllTriggers) then
    FOnAllTriggers(Self, -1, 0, 0);
end;

procedure TMPTimerPool.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (not (csDestroying in ComponentState)) then
  begin
    if (AComponent is TTrigger) and (AComponent.Owner = Self) then
      CalcNewInterval
    else if AComponent = FTimer then
      FTimer:= nil;
  end; {if}
end;

function TMPTimerPool.AddTimes(aOnTrigger: TMPTriggerEvent; aInterval, aMaxTimes: longint): integer;
begin
  with TTrigger.Create(Self) do
    try
      Result:= FHandle;
      Enabled:= DefEnabled;
      Interval:= aInterval;
      MaxTimes:= aMaxTimes;
      FOnTrigger:= aOnTrigger;
    except
      Free;
      raise;
    end;
  CalcNewInterval;
end;

function TMPTimerPool.AddOnce(aOnTrigger: TMPTriggerEvent; aInterval: longint): integer;
begin
  Result:= AddTimes(aOnTrigger, aInterval, 1); 
end;

function TMPTimerPool.Add(aOnTrigger: TMPTriggerEvent; aInterval: longint): integer;
begin
  Result:= AddTimes(aOnTrigger, aInterval, -1);
end;

procedure TMPTimerPool.Remove(Handle: integer);
begin
  CheckHandle(Handle).Free;
end;

function FreeTrigger(aTrigger: TComponent; Data: pointer): boolean; far;
begin
  aTrigger.Free;
  Result:= true;
end;

procedure TMPTimerPool.RemoveAll;
begin
  ForEachTrigger(FreeTrigger, nil);
end;

procedure Register;
begin
  RegisterComponents('MPC', [TMPTimerPool]);
end;

end.
