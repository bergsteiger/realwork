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
unit CosTimerEvent_impl;

interface

uses CosTimerEvent, CosTimerEvent_int, CosTime_int, CosTime, code_int, CosEventComm_int,
  osthread, orbtypes, orb_int, poa_int, Classes, SysUtils;

type
  ITimerThread = interface(IORBThread)
  ['{64878FB2-0098-44D8-A700-5F478D734A7C}']
    procedure Stop;
  end;

  TTimerEventHandler_impl = class(TCosTimerEvent_TimerEventHandler_serv)
  private
    FParent: ICosTimerEvent_TimerEventService;
    FEventChannel: IPushConsumer;
    FStatus: TCosTimerEvent_EventStatus;
    FData: IAny;
    FIsSet: boolean;
    FIsPeriodic: boolean;
    FDelay: long;
    FLastRelative: long;
    FCurTime: longlong;
    FSetTime: longlong;
    FThread: ITimerThread;
  protected
    function time_set(out uto: ICosTime_UTO): boolean; override;
    procedure SetTimer(const time_type: TCosTimerEvent_TimeType; const trigger_time: ICosTime_UTO); override;
    function cancel_timer: boolean; override;
    procedure set_data(const event_data: IAny); override;
    function _get_status: TCosTimerEvent_EventStatus; override;
  public
    constructor Create(AParent: ICosTimerEvent_TimerEventService; AEventChannel: IPushConsumer; ACurrentTime: longlong);
  end;

  TTimerEventService_impl = class(TCosTimerEvent_TimerEventService_serv)
  private
    FORB: IORB;
    FHandlers: IInterfaceList;
  protected
    function register(const event_interface: IPushConsumer; const data: IAny): ICosTimerEvent_TimerEventHandler; override;
    procedure unregister(const timer_event_handler: ICosTimerEvent_TimerEventHandler); override;
    function event_time(const timer_event: TCosTimerEvent_TimerEventT): ICosTime_UTO; override;
  public
    constructor Create(AORB: IORB);
  end;

  TTimerThread = class(TORBThread, ITimerThread)
  private
    FHandler: TTimerEventHandler_impl;
    FSema: TSemaphore;
  protected
    procedure Run(); override;
    procedure Stop;
  public
    constructor Create(AHandler: TTimerEventHandler_impl);
    destructor Destroy; override;
  end;

procedure TimerEventServiceInit(ORB: IORB; POA: IPOA; props: TStrings);

implementation

uses timehelper, throw, any, exceptions, except_int, CosEventComm, CosTime_impl,
  bootmanager, bootmanager_int;

procedure TimerEventServiceInit(ORB: IORB; POA: IPOA; props: TStrings);
var
  bootManager: IBootManager;
  obj: IORBObject;
begin
  assert(POA <> nil);
  obj := POA.servant_to_reference(TTimerEventService_impl.Create(ORB) as IServant);
  ORB.register_initial_reference('TimerEventService', obj);

  //BootManager
  bootManager := TBootManager._narrow(ORB.resolve_initial_reference('BootManager'));
  if bootManager <> nil then
    bootManager.add_binding('TimerEventService', obj);
end;

{ TTimerEventHandler_impl }

function TTimerEventHandler_impl._get_status: TCosTimerEvent_EventStatus;
begin
  result := FStatus;
end;

function TTimerEventHandler_impl.cancel_timer: boolean;
begin
  result := false;
  if (FStatus = ESTimeSet) or (FStatus = ESTriggered) and FIsPeriodic then begin
    FStatus := ESTimeCleared;
    FThread.Stop();
    FThread := nil;
    result := true;
  end;
end;

procedure TTimerEventHandler_impl.set_data(const event_data: IAny);
begin
  FData := CreateAny();
  FData.copy(event_data);
end;

procedure TTimerEventHandler_impl.SetTimer(
  const time_type: TCosTimerEvent_TimeType;
  const trigger_time: ICosTime_UTO);
var
  TmpTime: _ulonglong;
begin
  FSetTime := TTimeHelper.utcNow.time;
  if time_type = TTAbsolute then begin
    TmpTime := TTimeHelper.utcNow.time;
    FDelay := (trigger_time.time - TmpTime) div 10000;
  end
  else begin
    FIsPeriodic := time_type = TTPeriodic;
    if trigger_time.time = 0 then begin
      if FLastRelative = 0 then
        dorb_throw(st_BAD_PARAM)
      else
        FDelay := FLastRelative;
    end;
    FDelay := trigger_time.time;
    FLastRelative := FDelay;
  end;
  FStatus := ESTimeSet;

  FThread := TTimerThread.Create(Self);
  FThread.Start();
end;

function TTimerEventHandler_impl.time_set(out uto: ICosTime_UTO): boolean;
begin
  result := FIsSet and (FStatus = ESTimeSet);
end;

constructor TTimerEventHandler_impl.Create(
  AParent: ICosTimerEvent_TimerEventService; AEventChannel: IPushConsumer;
  ACurrentTime: longlong);
begin
  FParent := AParent;
  FEventChannel := AEventChannel;
  FCurTime := ACurrentTime;
end;

{ TTimerEventService_impl }

constructor TTimerEventService_impl.Create(AORB: IORB);
begin
  FORB := AORB;
  FHandlers := TInterfaceList.Create;
end;

function TTimerEventService_impl.event_time(
  const timer_event: TCosTimerEvent_TimerEventT): ICosTime_UTO;
var
  TmpUTO: TUTO_impl;
begin
  TmpUTO := TUTO_impl.Create(timer_event.utc);
  result := TmpUTO._this();
end;

function TTimerEventService_impl.register(
  const event_interface: IPushConsumer;
  const data: IAny): ICosTimerEvent_TimerEventHandler;
var
  TmpHandler: TTimerEventHandler_impl;
begin
  TmpHandler := TTimerEventHandler_impl.Create(Self, event_interface, TTimeHelper.utcNow().time);
  TmpHandler.set_data(data);
  FHandlers.Add(TmpHandler);
  result := TmpHandler._this();
end;

procedure TTimerEventService_impl.unregister(
  const timer_event_handler: ICosTimerEvent_TimerEventHandler);
begin
  FHandlers.Remove(timer_event_handler);
end;

{ TTimerThread }

constructor TTimerThread.Create(AHandler: TTimerEventHandler_impl);
begin
  FHandler := AHandler;
  FSema := TSemaphore.Create;
  inherited Create();
end;

destructor TTimerThread.Destroy;
begin
  FSema.Free;
  inherited;
end;

procedure TTimerThread.Run;
var
  TmpTimerEvent: TCosTimerEvent_TimerEventT;
  orbEx: ISystemException;
begin
  TmpTimerEvent.event_data := CreateAny();
  TmpTimerEvent.event_data.copy(FHandler.FData);
  while true do begin
    with FHandler do begin
      try
        if FSema.wait(FDelay) and FFinished then
          Break; //if stop
        try
          TmpTimerEvent.utc := TTimeHelper.toUtcT(TTimeHelper.utcNow.time, 0, 0);
          FEventChannel.push(CosTimerEvent_TimerEventT_to_any(TmpTimerEvent));
          FStatus := ESTriggered;
        except
          on E: TDisconnected do
            FStatus := ESFailedTrigger;
          on E: SystemException do begin
            orbEx := SystemException.Create(E);
            if orbEx.extype = st_COMM_FAILURE then begin
              FParent.unregister(_this());
              Break;
            end;
          end;
        end; { try/except }
        if not FIsPeriodic then
          Break;
      except
        raise;
      end; { try/except }
    end; { with }
  end;
end;

procedure TTimerThread.Stop;
begin
  Finish;
  FSema.post();
end;

end.
