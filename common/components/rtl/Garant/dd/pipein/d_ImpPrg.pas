unit D_ImpPrg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TProgressForm = class(TForm)
    Animate1: TAnimate;
    BitBtn1: TBitBtn;
    Descript: TLabel;
    CheckTimer: TTimer;
    GroupBox1: TGroupBox;
    TotalProgressBar: TProgressBar;
    TotalLabel: TLabel;
    GroupBox2: TGroupBox;
    LocalLabel: TLabel;
    LocalProgressBar: TProgressBar;
    SpeedLabel: TLabel;
    TimeLabel: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckTimerTimer(Sender: TObject);
  private
    { Private declarations }
    SpeedHi, SpeedLo: Integer;
    f_OnAbort: TNotifyEvent;
    FTotal: Longint;
    FCurPos: Longint;
    FStartTime: TDateTime;
    FFinishTime: TDateTime;
    f_CheckTime: TDateTime;
    f_CheckValue: Longint;
    FDays: Word;
    FHours: Word;
    FMinutes:Word;
    FSecundes: Word;
    FMSec: Word;
    FStartTimeSec: Int64;
    f_EnableBreak: Boolean;
    f_RecalcUnits: Boolean;
    f_TimeDelta  : Longint;
    f_GreenFlag  : Boolean;
    { Время в секундах, прошедшее с начала }
    procedure SetTotal(Value: Longint);
    procedure SetEnableBreak(value: Boolean);
  public
    { Public declarations }
    procedure LocalProgressProc(aState: Byte;
                             aValue: Longint; const aMsg: AnsiString);
    procedure TotalProgressProc(aState: Byte;
                             aValue: Longint; const aMsg: AnsiString);
    procedure Stop;

    procedure Clear;

    procedure IncTotal(aValue: Longint);

    property EnableBreak: Boolean
      read f_EnableBreak write SetEnableBreak default True;
    property TotalSize: Longint
      read FTotal write SetTotal;
    property CurPos: Longint
      read fCurPos write fCurPos;
    property OnAbort : TNotifyEvent
      read f_OnAbort write f_OnAbort;
    property RecalcUnits: Boolean
      read f_RecalcUnits write f_RecalcUnits;
  end;

var
  ProgressForm: TProgressForm;

implementation

Uses ddUtils,
     afwFacade;

{$R *.DFM}
type
  TSizeType = (dd_stGiga, dd_stMega, dd_stKilo, dd_stSimple);
const
  SizeMulti : array[TSizeType] of Longint =
             (1024*1024*1024, 1024*1024, 1024, 1);
  SizePrefix : array[TSizeType] of String =
             ('Г', 'М', 'к', '');




procedure TProgressForm.LocalProgressProc(aState: Byte;
                             aValue: Longint; const aMsg: AnsiString);
var
  tcur, t2: TDateTime;
  Hour, Min, Sec, MSec: Word;
  timeS, Estimate: Int64;
  Percent: ShortInt;
  
  S: AnsiString;
  Cur, Tot: TSizeType;
  MaxValue: Longint;

procedure AdjustSize(const Cur, Tot: int64; var Perc: ShortInt; var SizeCur, SizeTot: TSizeType);
begin
 try
  Perc:= (Cur*100) div Tot;
 except
  Perc:= 0;
 end;

  if Tot > 1024*1024*1204 then
    SizeTot:= dd_stGiga
  else
  if Tot > 1024*1204 then
    SizeTot:= dd_stMega
  else
  if Tot > 1204 then
    SizeTot:= dd_stKilo
  else
    SizeTot:= dd_stSimple;

  if Cur > 1024*1024*1204 then
    SizeCur:= dd_stGiga
  else
  if Cur > 1024*1204 then
    SizeCur:= dd_stMega
  else
  if Cur > 1204 then
    SizeCur:= dd_stKilo
  else
    SizeCur:= dd_stSimple;
end;


begin

  case aState of
    0: begin
         FStartTime:= Time;
         if FCurPos = 0 then
         begin
           FStartTimeSec:= 0;
           f_CheckTime:= Time;
           f_CheckValue:= 0;
           f_GreenFlag:= False;
         end;
         LocalLabel.Caption:= aMsg;

         LocalProgressbar.Max:= aValue;
         LocalProgressBar.Position:= 0;
         Animate1.Active:= True;

       end;
    1: begin

         LocalProgressBar.Position:= aValue;
         if TotalSize <> 0 then
           TotalProgressBar.Position:= FCurPos + aValue;

        t2:= Time;
        try
         if f_GreenFlag then
         begin
           f_GreenFlag:= False;

           tcur:= t2-f_CheckTime;
           DecodeTime(tcur, Hour, Min, Sec, MSec);
           timeS:= Hour*3600+Min*60+Sec;
           try
             SpeedHi:= ((aValue - f_CheckValue) div 1024) div (Times);
             SpeedLo:= ((aValue - f_CheckValue) div 1024) mod (Times) div 100;
           except
             SpeedHi:= 0;
             SpeedLo:= 0;
           end;
           f_CheckTime:= t2;
           f_CheckValue:= aValue;
         end; { f_GreenFlag }

         try
           if TotalSize <> 0 then
             MaxValue:= TotalSize
           else
             MaxValue:= LocalProgressbar.Max;
           //Estimate:= ((FStartTimeSec+TimeS)*MaxValue div (FCurPos + aValue))-(FStartTimeSec+TimeS);
           Estimate:= (MaxValue-(FCurPos + aValue)) div (SpeedHi*1024);
         except
           Estimate:= 0;
         end;


         if Estimate < 0 then
           Estimate:= 0;

         S:= TimeSec2Str(Estimate);

         AdjustSize(FCurPos+aValue, FTotal, Percent, Cur, Tot);
         Caption:= Format('Ход процесса - %d%%', [Percent]);
         if RecalcUnits then
         try
           TotalLabel.Caption:=
             Format('Осталось %s (%4d.%2d %sб из %4d.%2d %sб)',
                [S, (FCurPos + aValue) div SizeMulti[Cur],
                    (FCurPos + aValue) mod SizeMulti[Cur] div 10000, SizePrefix[Cur],
                    MaxValue div SizeMulti[Tot],
                    MaxValue mod SizeMulti[Tot] div 10000, SizePrefix[Tot]]);
           if SpeedHi > 0 then
              SpeedLabel.Caption:= Format('Скорость преобразования %4d.%d кб/сек', [SpeedHi, SpeedLo])
           else
              SpeedLabel.Caption:= 'Скорость преобразования ??? кб/сек';
         except
           TotalLabel.Caption:= '';
           SpeedLAbel.Caption:= '';
         end
         else  { Не перерассчитывать }
         begin
           TotalLabel.Caption:=
             Format('Осталось %s (%d из %d)',
                [S, (FCurPos + aValue), MaxValue]);
           SpeedLabel.Caption:= '';
         end;
         tcur:= t2-fStartTime;
         DecodeTime(tcur, Hour, Min, Sec, MSec);
         timeS:= Hour*3600+Min*60+Sec;
         TimeLabel.Caption:= Format('Прошло %s', [TimeSec2Str(FStartTimeSec+TimeS)]);
        except
          {}
        end;
       end;
    2: begin
         Animate1.Active:= False;
         LocalProgressBar.Position:= LocalProgressBar.Max;

         if TotalSize <> 0 then
         begin
           Inc(FCurPos, LocalProgressBar.Max);
           TotalProgressBar.Position:= FCurPos
         end
         else
           FCurPos:= 0;
        try
         AdjustSize(FCurPos+aValue, FTotal, Percent, Cur, Tot);
         Caption:= Format('Ход процесса - %d%%', [Percent]);

         tcur:= Time-FStartTime; { время кусочка (aValue) }
         DecodeTime(tcur, Hour, Min, Sec, MSec);
         timeS:= Hour*3600+Min*60+Sec;
         {^ время в секундах, прошедшее с начала старта кусочка (aValue)}
         Inc(FStartTimeSec, TimeS);
        except
         {}
        end;
       end;
  end;
  afw.ProcessMessages;
end;

procedure TProgressForm.TotalProgressProc(aState: Byte;
                             aValue: Longint; const aMsg: AnsiString);
begin
  {}
end;

procedure TProgressForm.IncTotal(aValue: Longint);
begin
 try
  Inc(FTotal, aValue);
  Inc(FCurPos, aValue);
  TotalProgressBar.Max:= FTotal;
  TotalProgressBar.Position:= TotalProgressBar.Position + aValue;
 except
   
 end; 
end;

procedure TProgressForm.SetTotal(Value: Longint);
begin
  FTotal:= Value;
  FCurPos:= 0;
  if FTotal <> 0 then
  begin
    TotalProgressBar.Max:= FTotal;
    TotalProgressBar.Position:= 0;
    TotalProgressBar.Visible:= True;
    if Value <= 500*1024 then
      f_TimeDelta:= 1
    else
    if (Value > 500*1024) and (Value <= 10000*1024) then
      f_TimeDelta:= 15
    else
    if (Value > 10000*1024) and (Value <= 20000*1024) then
      f_TimeDelta:= 30
    else
      f_TimeDelta:= 60
  end;
  CheckTimer.Interval:=  f_TimeDelta*1000;
  FStartTime:= Time;
end;

procedure TProgressForm.BitBtn1Click(Sender: TObject);
begin
  { Прерывание процесса по желанию }
  if Assigned(f_OnAbort) then
  if MessageDlg('Вы действительно желаете прервать процесс?', mtConfirmation,
                [mbYes, mbNo], 0) = mrYes then
  begin
    BitBtn1.Enabled:= False;
    f_OnAbort(Self);
  end;
end;

procedure TProgressForm.Stop;
begin
  Caption:= 'Ход процесса';
  Clear;
end;

procedure TProgressForm.SetEnableBreak(value: Boolean);
begin
  f_EnableBreak:= Value;
  BitBtn1.Enabled:= f_EnableBreak;
end;

procedure TProgressForm.Clear;
begin
  f_OnAbort:= nil;
  FTotal:= 0;
  FCurPos:= 0;
  FStartTime:= 0;
  FFinishTime:= 0;
  FDays:= 0;
  FHours:= 0;
  FMinutes:= 0;
  FSecundes:=0;
  FMSec:= 0;
  FStartTimeSec:= 0;
  f_EnableBreak:= False;
  f_RecalcUnits:= True;
  SpeedHi:= 0;
  SpeedLo:= 0;
  f_CheckTime:= 0;
  f_CheckValue:= 0;
  f_GreenFlag:= False;
end;

procedure TProgressForm.FormShow(Sender: TObject);
begin
   BitBtn1.Enabled:= Assigned(OnAbort);
end;

procedure TProgressForm.CheckTimerTimer(Sender: TObject);
begin
  { Интервал прошел }
  f_GreenFlag:= True;

end;

end.
