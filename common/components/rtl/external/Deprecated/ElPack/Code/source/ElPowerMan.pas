{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
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

unit ElPowerMan;

interface

uses Windows, Classes, Messages, ElBaseComp;

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

type

  TElPowerResumeType = (prtNormal, prtCritical, prtAutomatic);
  TElPowerStatus = (psUnknown, psInactive, psActive);
  TElBatteryState = (bsUnknown, bsNoBattery, bsHigh, bsLow, bsCritical, bsCharging);

  //TElPowerEvent = procedure(Sender : TObject; PowerMan : integer) of object;
  TElPowerQueryEvent = procedure(Sender : TObject; UserInterfaceAllowed : boolean; var Allowed : boolean) of object;
  TElPowerResumeEvent = procedure(Sender : TObject; ResumeAfter : TElPowerResumeType) of object;

  TElPowerManager = class(TElBaseComponent)
  protected
    FOnResume: TElPowerResumeEvent;
    //FOnPowerEvent : TElPowerEvent;
    //FOnPowerQueryEvent : TElPowerQueryEvent;
    FOnSuspend: TNotifyEvent;
    FOnBatteryLow: TNotifyEvent;
    FOnPowerStatusChange: TNotifyEvent;
    FOnQuerySuspend: TElPowerQueryEvent;
    FOnSuspendAborted: TNotifyEvent;
    procedure WndProc(var Message : TMessage); override;
    procedure DoSuspend; virtual;
    procedure DoBatteryLow; virtual;
    procedure DoQuerySuspend(UIAllowed : boolean; var SuspendAllowed : boolean); virtual;
    procedure DoPowerStatusChange; virtual;
    procedure DoSuspendAborted; virtual;
    procedure DoResume(ResumeType : TElPowerResumeType); virtual;
    function GetACPowerStatus: TElPowerStatus;
    function GetBatteryState: TElBatteryState;
    function GetBatteryLifePercent: Integer;
  public
    property ACPowerStatus: TElPowerStatus read GetACPowerStatus;
    property BatteryState: TElBatteryState read GetBatteryState;
    property BatteryLifePercent: Integer read GetBatteryLifePercent;
  published
    property OnResume: TElPowerResumeEvent read FOnResume write FOnResume;
    property OnSuspend: TNotifyEvent read FOnSuspend write FOnSuspend;
    property OnBatteryLow: TNotifyEvent read FOnBatteryLow write FOnBatteryLow;
    property OnPowerStatusChange: TNotifyEvent read FOnPowerStatusChange write
        FOnPowerStatusChange;
    property OnQuerySuspend: TElPowerQueryEvent read FOnQuerySuspend write
        FOnQuerySuspend;
    property OnSuspendAborted: TNotifyEvent read FOnSuspendAborted write
        FOnSuspendAborted;

    property Enabled;
  end;

implementation

procedure TElPowerManager.WndProc(var Message : TMessage);
var SuspendAllowed : boolean;
    UIAllowed      : boolean;
begin
  if Message.Msg = WM_POWERBROADCAST then
  begin
    case Message.wParam of
      PBT_APMBATTERYLOW:
        DoBatteryLow;
      PBT_APMSUSPEND:
        DoSuspend;
      PBT_APMQUERYSUSPEND:
        begin
          SuspendAllowed := true;
          UIAllowed := (Message.lParam and 1 = 1);
          DoQuerySuspend(UIAllowed, SuspendAllowed);
          if SuspendAllowed then
            Message.Result := 1
          else
            Message.Result := BROADCAST_QUERY_DENY;
        end;
      PBT_APMQUERYSUSPENDFAILED:
        DoSuspendAborted;
      PBT_APMPOWERSTATUSCHANGE:
        DoPowerStatusChange;
      PBT_APMRESUMECRITICAL:
        DoResume(prtCritical);
      PBT_APMRESUMEAUTOMATIC:
        DoResume(prtAutomatic);
      PBT_APMRESUMESUSPEND:
        DoResume(prtNormal);
    end;
  end
  else
    inherited;
end;

procedure TElPowerManager.DoSuspend;
begin
  if assigned(FOnSuspend) then
    FOnSuspend(Self);
end;

procedure TElPowerManager.DoBatteryLow;
begin
  if Assigned(FOnBatteryLow) then
    FOnBatteryLow(Self);
end;

procedure TElPowerManager.DoQuerySuspend(UIAllowed : boolean; var
    SuspendAllowed : boolean);
begin
  if Assigned(FOnQuerySuspend) then FOnQuerySuspend(Self, UIAllowed, SuspendAllowed);
end;

procedure TElPowerManager.DoPowerStatusChange;
begin
  if assigned(FOnPowerStatusChange) then
    FOnPowerStatusChange(Self);
end;

procedure TElPowerManager.DoSuspendAborted;
begin
  if assigned(FOnSuspendAborted) then FOnSuspendAborted(Self);
end;

procedure TElPowerManager.DoResume(ResumeType : TElPowerResumeType);
begin
  if assigned(FOnResume) then
    FOnResume(Self, ResumeType);
end;

function TElPowerManager.GetACPowerStatus : TElPowerStatus;
var SPS : TSystemPowerStatus;
begin
  GetSystemPowerStatus(SPS);
  case SPS.ACLineStatus of
    0: result := psInactive;
    1: result := psActive;
    else result := psUnknown;
  end;
end;

function TElPowerManager.GetBatteryState: TElBatteryState;
var SPS : TSystemPowerStatus;
begin
  GetSystemPowerStatus(SPS);
  case SPS.BatteryFlag of
    128: result := bsNoBattery;
    1  : result := bsHigh;
    2  : result := bsLow;
    4  : result := bsCritical;
    8  : result := bsCharging;
    else result := bsUnknown;
  end;
end;

function TElPowerManager.GetBatteryLifePercent: Integer;
var SPS : TSystemPowerStatus;
begin
  GetSystemPowerStatus(SPS);
  if SPS.BatteryLifePercent = 255 then
    result := -1
  else
    result := SPS.BatteryLifePercent;
end;

end.
