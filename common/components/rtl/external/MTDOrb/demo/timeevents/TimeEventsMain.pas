unit TimeEventsMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CosEventComm, CosEventComm_int, code_int, orb_int, poa_int,
  CosTimerEvent_int, ExtCtrls, Mask;

type
  TfmMain = class(TForm)
    edAddr: TEdit;
    btStart: TButton;
    mEvent: TMemo;
    btRegister: TButton;
    rgTimeType: TRadioGroup;
    meDate: TMaskEdit;
    meTime: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edOffset: TEdit;
    Label4: TLabel;
    edPeriod: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    procedure btStartClick(Sender: TObject);
    procedure btRegisterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rgTimeTypeClick(Sender: TObject);
  private
    { Private declarations }
    FThread: TThread;
    procedure DoTerminate(Sender: TObject);
  public
    { Public declarations }
  end;

  TORBThread = class(TThread)
  protected
    procedure Execute; override;
  public
  end;

  TConsumerImpl = class(TPushConsumer_serv, IPushConsumer)
  protected
    procedure push(const data: IAny); override;
    procedure disconnect_push_consumer; override;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses utils, orb, poa_impl, CosTimerEvent, any, CosTime_impl, timehelper;

var
  dorb: IORB;
  rootPoa: IPOA;
  timeService: ICosTimerEvent_TimerEventService;
  timerEvent: ICosTimerEvent_TimerEventHandler;
  cimpl : IPushConsumer;

procedure TfmMain.btStartClick(Sender: TObject);
var
  params : TStrings;
  obj : IORBObject;
begin
  if dorb <> nil then
    begin
      dorb.shutdown(true);
      dorb._destroy();
      if FThread <> nil then begin
        FThread.WaitFor;
        FThread.Free;
      end;
      btStart.Caption := 'Start';
      Exit;
    end;
  params := TStringList.Create;
  try
    try
      Split(PChar(edAddr.Text), params);
      dorb := ORB_Init(params);
      obj := dorb.resolve_initial_reference('RootPOA');
      rootPoa := POA_Narrow(obj);

      rootPoa.the_POAManager.activate();

      obj := dorb.bind('IDL:omg.org/CosTimerEvent/TimerEventService:1.0');
      timeService := TCosTimerEvent_TimerEventService._narrow(obj);
      Assert(timeService <> nil);
    finally
      params.free;
    end;
    if (dorb <> nil) then begin
      FThread := TORBThread.Create(true);
      //t.FreeOnTerminate := true;
      FThread.OnTerminate := DoTerminate;
      FThread.Resume;
      btStart.Caption := 'Stop';
    end;
  except
    on e: exception do
      ShowMessage(e.Message);
  end;
end;

procedure TfmMain.btRegisterClick(Sender: TObject);
const
  cMessage = 'Time event tested (%s)';
var
  data: IAny;
  uto: TUTO_impl;
  tt: TCosTimerEvent_TimeType;
begin
  uto := nil;
  if timerEvent = nil then begin
    if cimpl = nil then
      cimpl := TPushConsumer._narrow(rootPoa.activate_for_this(TConsumerImpl.Create as IServant));
    data := CreateAny();
    tt := TCosTimerEvent_TimeType(rgTimeType.ItemIndex);
    case tt of
      TTAbsolute: begin
        uto := TUTO_impl.Create(TTimeHelper.toUtcT(StrToDate(meDate.Text) + StrToTime(meTime.Text)));
        data.put_string(AnsiString(Format(cMessage, ['Absolute'])));
      end;
      TTRelative: begin
        uto := TUTO_impl.Create(StrToInt(edOffset.Text), 0);
        data.put_string(AnsiString(Format(cMessage, ['Relative'])));
      end;
      TTPeriodic: begin
        uto := TUTO_impl.Create(StrToInt(edPeriod.Text), 0);
        data.put_string(AnsiString(Format(cMessage, ['Periodic'])));
      end;
    else
      Assert(false);
    end;
    timerEvent := timeService.register(cimpl, data);
    timerEvent.SetTimer(tt, uto._this());

    btRegister.Caption := 'Unregister';
  end
  else begin
    timerEvent.cancel_timer();
    timeService.unregister(timerEvent);
    timerEvent := nil;

    btRegister.Caption := 'Register';
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dorb = nil then
    Exit;
  dorb.shutdown(true);
  dorb._destroy();
  if FThread <> nil then begin
    FThread.WaitFor;
    FThread.Free;
  end;
end;

procedure TfmMain.DoTerminate(Sender: TObject);
begin
  dorb := nil;
end;

procedure TfmMain.rgTimeTypeClick(Sender: TObject);
begin
  case TCosTimerEvent_TimeType(rgTimeType.ItemIndex) of
    TTAbsolute: begin
      meDate.Enabled := true;
      meTime.Enabled := true;
      edOffset.Enabled := false;
      edPeriod.Enabled := false;
    end;
    TTRelative: begin
      meDate.Enabled := false;
      meTime.Enabled := false;
      edOffset.Enabled := true;
      edPeriod.Enabled := false;
    end;
    TTPeriodic: begin
      meDate.Enabled := false;
      meTime.Enabled := false;
      edOffset.Enabled := false;
      edPeriod.Enabled := true;
    end;
  end;
end;

{ TORBThread }

procedure TORBThread.Execute;
begin
  try
    dorb.run;
  except
    on e: Exception do
      ShowMessage(e.message)
  end;
end;

{ TConsumerImpl }

procedure TConsumerImpl.disconnect_push_consumer;
begin

end;

procedure TConsumerImpl.push(const data: IAny);
var
  str: AnsiString;
  TmpTimerEvent: TCosTimerEvent_TimerEventT;
begin
  if any_to_CosTimerEvent_TimerEventT(data, TmpTimerEvent) and
     TmpTimerEvent.event_data.get_string(str) then
    fmMain.mEvent.Lines.Add(String(str));
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  meDate.Text := DateToStr(Date());
end;

end.
