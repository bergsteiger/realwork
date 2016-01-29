{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCTIMER.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTimer;
  {-Timer Pool Component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Forms, Messages, SysUtils,
  OvcConst, OvcData, OvcExcpt, OvcMisc, OvcVer;

type
  TTriggerEvent =
    procedure(Sender : TObject; Handle : Integer; Interval : Word; ElapsedTime : LongInt)
    of object;

const
  DefEnabled      = True;   {by default, new triggers are enabled}
  MinInterval     = 55;     {smallest timer interval allowed}
  HalfMinInterval = MinInterval div 2;

type
  PEventRec       = ^TEventRec;
  TEventRec       = record
    erEnabled     : Boolean;        {true if trigger is active}
    erHandle      : Integer;        {handle of this event record}
    erInitTime    : LongInt;        {time when trigger was created}
    erInterval    : Word;           {trigger interval}
    erLastTrigger : LongInt;        {time last trigger was fired}
    erOnTrigger   : TTriggerEvent;  {method to call when fired}
    erRecurring   : Boolean;        {false for one time trigger}
  end;

type
  TOvcTimerPool = class(TComponent)
  {.Z+}
  protected {private}
    FOnAllTriggers : TTriggerEvent;

    ttList         : TList;    {list of event TEventRec records}
    ttHandle       : hWnd;     {our window handle}
    ttInterval     : Word;     {the actual Window's timer interval}
    ttEnabledCount : Word;     {count of active triggers}

    {property methods}
    function GetElapsedTriggerTime(Handle : Integer) : LongInt;
      {-return the number of miliseconds since the timer trigger was created}
    function GetElapsedTriggerTimeSec(Handle : Integer) : LongInt;
      {-return the number of seconds since the timer trigger was created}
    function GetOnTrigger(Handle : Integer) : TTriggerEvent;
      {-returns the timer trigger's event method address}
    function GetTriggerCount : Integer;
      {-returns the number of maintained timer triggers}
    function GetTriggerEnabled(Handle : Integer) : Boolean;
      {-returns the timer trigger's enabled status}
    function GetTriggerInterval(Handle : Integer) : Word;
      {-returns the interval for the timer trigger with Handle}
    function GetVersion : string;                                      {!!.13}
    procedure SetOnTrigger(Handle : Integer; Value: TTriggerEvent);
      {-sets the method to call when the timer trigger fires}
    procedure SetTriggerEnabled(Handle : Integer; Value: Boolean);
      {-sets the timer trigger's enabled status}
    procedure SetTriggerInterval(Handle : Integer; Value: Word);
      {-sets the timer trigger's interval}
    procedure SetVersion(Value : string);                              {!!.13}

    procedure ttCalcNewInterval;
      {-calculates the needed interval for the window's timer}
    function ttCountEnabledTriggers : Integer;
      {-returns the number of enabled/active timer triggers}
    function ttCreateTriggerHandle : Integer;
      {-returns a unique timer trigger handle}
    function ttEventIndex(Handle : Integer) : Integer;
      {-returns the internal list index corresponding to the trigger handle}
    procedure ttSortTriggers;
      {-sorts the internal list of timer trigger event records}
    procedure ttTimerWndProc(var Msg : TMessage);
      {-window procedure to catch timer messages}
    procedure ttUpdateTimer;
      {-re-create the windows timer with a new timer interval}

  protected
    procedure DoTriggerNotification;
      virtual;
      {-conditionally sends notification of all events}
  {.Z-}

  public
    constructor Create(AOwner: TComponent);
      override;
    destructor Destroy;
      override;

    function AddOneShot(OnTrigger : TTriggerEvent; Interval : Word) : Integer;{!!.12}
      {-adds or updates one timer trigger. removed automatically after one firing}
    function AddOneTime(OnTrigger : TTriggerEvent; Interval : Word) : Integer;
      {-adds a new timer trigger. removed automatically after one firing}
    function Add(OnTrigger : TTriggerEvent; Interval : Word) : Integer;
      {-adds a new timer trigger and returns a handle}
    procedure Remove(Handle : Integer);
      {-removes the timer trigger}
    procedure RemoveAll;
      {-disable and destroy all timer triggers}

    {public properties}
    property Count : Integer
      read GetTriggerCount;

    property ElapsedTime[Handle : Integer] : LongInt
      read GetElapsedTriggerTime;

    property ElapsedTimeSec[Handle : Integer] : LongInt
      read GetElapsedTriggerTimeSec;

    property Enabled[Handle : Integer] : Boolean
      read GetTriggerEnabled
      write SetTriggerEnabled;

    property Interval[Handle : Integer] : Word
      read GetTriggerInterval
      write SetTriggerInterval;

    {events}
    property OnTrigger[Handle : Integer] : TTriggerEvent
      read GetOnTrigger
      write SetOnTrigger;

  published
    {event triggered when any trigger is fired}
    property OnAllTriggers : TTriggerEvent
      read FOnAllTriggers
      write FOnAllTriggers;

    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

{*** internal routines ***}

function NewEventRec : PEventRec;
begin
  GetMem(Result, SizeOf(TEventRec));
  try
    FillChar(Result^, SizeOf(TEventRec), #0);
  except
    raise;
  end;
end;

procedure FreeEventRec(ER : PEventRec);
begin
  if (ER <> nil) then
    FreeMem(ER, SizeOf(TEventRec));
end;


{*** TOvcTimerPool ***}

constructor TOvcTimerPool.Create(AOwner: TComponent);
{$IFDEF TRIALRUN}
var
  X : Integer;
{$ENDIF}
begin
  inherited Create(AOwner);

  {create internal list for trigger event records}
  ttList := TList.Create;

  {allocate a window handle for the timer}
  ttHandle := AllocateHWnd(ttTimerWndProc);

{$IFDEF TRIALRUN}
  X := _CC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
  X := _VC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
{$ENDIF}
end;

destructor TOvcTimerPool.Destroy;
var
  I : Integer;
begin
  {force windows timer to be destroyed}
  ttInterval := 0;
  ttUpdateTimer;

  {free contents of list}
  for I := 0 to ttList.Count-1 do
    FreeEventRec(ttList[I]);

  {destroy the internal list}
  ttList.Free;
  ttList := nil;

  {deallocate our window handle}
  DeallocateHWnd(ttHandle);

  inherited Destroy;
end;

{!!.12}
function TOvcTimerPool.AddOneShot(OnTrigger : TTriggerEvent; Interval : Word) : Integer;
  {-adds or updates one timer trigger. removed automatically after one firing}
var
  I : Integer;
begin
  {if this OnTrigger handler is already installed, remove it}
  if Assigned(OnTrigger) then begin
    for I := 0 to ttList.Count-1 do
      with PEventRec(ttList[I])^ do
        if @erOnTrigger = @OnTrigger then begin
          Remove(erHandle);
          Break;
        end;
  end;
  {add the one-time trigger}
  Result := AddOneTime(OnTrigger, Interval);
end;

function TOvcTimerPool.AddOneTime(OnTrigger : TTriggerEvent; Interval : Word) : Integer;
  {-adds a new timer trigger. removed automatically after one firing}
var
  I : Integer;
begin
  {add trigger}
  Result := Add(OnTrigger, Interval);

  {if added, set to non-recurring}
  if (Result > -1) then begin
    I := ttEventIndex(Result);
    if I > -1 then
      PEventRec(ttList[I])^.erRecurring := False
    else
      Result := -1;
  end;
end;

function TOvcTimerPool.Add(OnTrigger : TTriggerEvent; Interval : Word) : Integer;
  {-adds a new timer trigger and returns a handle}
var
  ER : PEventRec;
begin
  Result := -1;  {assume error}
  {create new event record}
  ER := NewEventRec;
  if (ER = nil) then
    Exit;

  {fill event record}
  with ER^ do begin
    erEnabled     := DefEnabled;
    erHandle      := ttCreateTriggerHandle;
    erInitTime    := GetTickCount;
    erInterval    := Interval;
    erLastTrigger := erInitTime;
    erOnTrigger   := OnTrigger;
    erRecurring   := True;
  end;

  {add trigger record to the list}
  ttList.Add(ER);

  {return the trigger event handle}
  Result := ER^.erHandle;

  {re-calculate the number of active triggers}
  ttEnabledCount := ttCountEnabledTriggers;

  {calculate new interval for the windows timer}
  ttCalcNewInterval;
  ttSortTriggers;
  ttUpdateTimer;
end;

{!!.14} {revised}
procedure TOvcTimerPool.DoTriggerNotification;
  {-conditionally sends notification for all events}
var
  ER : TEventRec;
  TC : LongInt;
  I  : Integer;
begin
  TC := GetTickCount;

  {cycle through all triggers}
  I := 0;
  while I < ttList.Count do begin
    ER := PEventRec(ttList[I])^;
    if ER.erEnabled then begin
      {is it time to fire this trigger}
      if TC - ER.erLastTrigger >= LongInt(ER.erInterval)-HalfMinInterval then begin
        {update event record with this trigger time}
        ER.erLastTrigger := TC;
        PEventRec(ttList[I])^.erLastTrigger := TC;                     {!!.15}

        {remove one-time triggers before firing}
        if not ER.erRecurring then begin
          Remove(ER.erHandle);
          Dec(I); {adjust loop index for this deletion}
        end;

        {call user event handler, if assigned}
        if Assigned(ER.erOnTrigger) then
          ER.erOnTrigger(Self, ER.erHandle, ER.erInterval,
                         ER.erLastTrigger-ER.erInitTime);

        {call general event handler, if assigned}
        if Assigned(FOnAllTriggers) then
          FOnAllTriggers(Self, ER.erHandle, ER.erInterval,
                         ER.erLastTrigger-ER.erInitTime);
      end;
    end;
    Inc(I);
  end;
end;

function TOvcTimerPool.GetElapsedTriggerTime(Handle : Integer) : LongInt;
  {-return the number of miliseconds since the timer trigger was created}
var
  I : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then
    Result := GetTickCount - DWord(PEventRec(ttList[I])^.erInitTime)   {!!.D4}
  else
    raise EInvalidTriggerHandle.Create;
end;

function TOvcTimerPool.GetElapsedTriggerTimeSec(Handle : Integer) : LongInt;
  {-return the number of seconds since the timer trigger was created}
begin
  Result := GetElapsedTriggerTime(Handle) div 1000;
end;

function TOvcTimerPool.GetOnTrigger(Handle : Integer) : TTriggerEvent;
  {-returns the timer trigger's event method address}
var
  I : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then
    Result := PEventRec(ttList[I])^.erOnTrigger
  else
    raise EInvalidTriggerHandle.Create;
end;

function TOvcTimerPool.GetTriggerCount : Integer;
  {-returns the number of maintained timer triggers}
begin
  Result := ttList.Count;
end;

function TOvcTimerPool.GetTriggerEnabled(Handle : Integer) : Boolean;
  {-returns the timer trigger's enabled status}
var
  I : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then
    Result := PEventRec(ttList[I])^.erEnabled
  else
    raise EInvalidTriggerHandle.Create;
end;

function TOvcTimerPool.GetTriggerInterval(Handle : Integer) : Word;
  {-returns the interval for the timer trigger with Handle}
var
  I : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then
    Result := PEventRec(ttList[I])^.erInterval
  else
    raise EInvalidTriggerHandle.Create;
end;

{!!.13}
function TOvcTimerPool.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

procedure TOvcTimerPool.Remove(Handle : Integer);
  {-removes the timer trigger}
var
  ER : PEventRec;
  I  : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then begin
    ER := PEventRec(ttList[I]);
    ttList.Delete(I);
    FreeEventRec(ER);
    ttEnabledCount := ttCountEnabledTriggers;
    ttCalcNewInterval;
    ttUpdateTimer;
  end;
end;

procedure TOvcTimerPool.RemoveAll;
  {-disable and destroy all timer triggers}
var
  ER : PEventRec;
  I  : Integer;
begin
  for I := ttList.Count-1 downto 0 do begin
    ER := PEventRec(ttList[I]);
    ttList.Delete(I);
    FreeEventRec(ER);
  end;
  ttEnabledCount := 0;
  ttInterval := 0;
  ttUpdateTimer;
end;

procedure TOvcTimerPool.SetOnTrigger(Handle : Integer; Value: TTriggerEvent);
  {-sets the method to call when the timer trigger fires}
var
  I : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then
    PEventRec(ttList[I])^.erOnTrigger := Value
  else
    raise EInvalidTriggerHandle.Create;
end;

procedure TOvcTimerPool.SetTriggerEnabled(Handle : Integer; Value: Boolean);
  {-sets the timer trigger's enabled status}
var
  I : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then begin
    if (Value <> PEventRec(ttList[I])^.erEnabled) then begin
      PEventRec(ttList[I])^.erEnabled := Value;
      ttEnabledCount := ttCountEnabledTriggers;
      ttCalcNewInterval;
      ttUpdateTimer;
    end;
  end else
    raise EInvalidTriggerHandle.Create;
end;

procedure TOvcTimerPool.SetTriggerInterval(Handle : Integer; Value: Word);
  {-sets the timer trigger's interval}
var
  I : Integer;
begin
  I := ttEventIndex(Handle);
  if (I > -1) then begin
    if Value <> PEventRec(ttList[I])^.erInterval then begin
      PEventRec(ttList[I])^.erInterval := Value;
      ttCalcNewInterval;
      ttUpdateTimer;
    end;
  end else
    raise EInvalidTriggerHandle.Create;
end;

{!!.13}
procedure TOvcTimerPool.SetVersion(Value : string);
begin
end;

procedure TOvcTimerPool.ttCalcNewInterval;
  {-calculates the needed interval for the window's timer}
var
  I    : Integer;
  N    : Word;
  ER   : PEventRec;
  TC   : LongInt;                                                      {!!.10}
  Done : Boolean;
begin
  {find shortest trigger interval}
  TC := GetTickCount;                                                  {!!.10}
  ttInterval := OvcData.MaxWord;
  for I := 0 to ttList.Count-1 do begin
    ER := PEventRec(ttList[I]);
    if ER^.erEnabled then begin                                        {!!.10}
      if (ER^.erInterval < ttInterval) then
        ttInterval := ER^.erInterval;

      {is this interval greater than the remaining time on any existing triggers}
      if ttInterval > (ER^.erInterval - (TC - ER^.erLastTrigger)) then {!!.10}
        ttInterval := (ER^.erInterval - (TC - ER^.erLastTrigger));     {!!.10}
    end;                                                               {!!.10}
  end;

  {limit to smallest allowable interval}                               {!!.10}
  if ttInterval < MinInterval then                                     {!!.10}
    ttInterval := MinInterval;                                         {!!.10}


  if ttInterval = OvcData.MaxWord then
    ttInterval := 0
  else begin
    {find interval that evenly divides into all trigger intervals}
    repeat
      Done := True;
      for I := 0 to ttList.Count-1 do begin
        N := PEventRec(ttList[I])^.erInterval;
        if (N mod ttInterval) <> 0 then begin
          Dec(ttInterval, N mod ttInterval);
          Done := False;
          Break;
        end;
      end;
    until Done or (ttInterval <= MinInterval);

    {limit to smallest allowable interval}
    if ttInterval < MinInterval then
      ttInterval := MinInterval;
  end;
end;

function TOvcTimerPool.ttCountEnabledTriggers : Integer;
  {-returns the number of enabled/active timer triggers}
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to ttList.Count-1 do
    if PEventRec(ttList[I])^.erEnabled then
      Inc(Result);
end;

function TOvcTimerPool.ttCreateTriggerHandle : Integer;
  {-returns a unique timer trigger handle}
var
  I : Integer;
  H : Integer;
begin
  Result := 0;
  for I := 0 to ttList.Count-1 do begin
    H := PEventRec(ttList[I])^.erHandle;
    if H >= Result then
      Result := H + 1;
  end;
end;

function TOvcTimerPool.ttEventIndex(Handle : Integer) : Integer;
  {-returns the internal list index corresponding to Handle}
var
  I : Integer;
begin
  Result := -1;
  for I := 0 to ttList.Count-1 do
    if PEventRec(ttList[I])^.erHandle = Handle then begin
      Result := I;
      Break;
    end;
end;

procedure TOvcTimerPool.ttSortTriggers;
  {-sorts the internal list of timer trigger event records}
var
  I    : Integer;
  Done : Boolean;
begin
  repeat
    Done := True;
    for I := 0 to ttList.Count-2 do begin
      if (PEventRec(ttList[I])^.erInterval >
          PEventRec(ttList[I+1])^.erInterval) then begin
        ttList.Exchange(I, I+1);
        Done := False;
      end;
    end;
  until Done;
end;

procedure TOvcTimerPool.ttTimerWndProc(var Msg : TMessage);
  {-window procedure to catch timer messages}
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        DoTriggerNotification;
      except
        Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(ttHandle, Msg, wParam, lParam);
end;

procedure TOvcTimerPool.ttUpdateTimer;
  {-re-create the windows timer with a new timer interval}
begin
  if csDesigning in ComponentState then
    Exit;

  {remove existing timer, if any}
  if KillTimer(ttHandle, 1) then {ignore return value};

  if (ttInterval <> 0) and (ttEnabledCount > 0) then
    if SetTimer(ttHandle, 1, ttInterval, nil) = 0 then
      raise ENoTimersAvailable.Create;
end;



end.