//..........................................................................................................................................................................................................................................................
unit ddProgressObj;
{* Объект для вычисления времени и процента выполнения длительного процесса }

{ $Id: ddProgressObj.pas,v 1.67 2014/11/28 15:18:57 lukyanets Exp $ }

// $Log: ddProgressObj.pas,v $
// Revision 1.67  2014/11/28 15:18:57  lukyanets
// Пытаемся доставлять
//
// Revision 1.66  2014/11/25 13:53:03  lukyanets
// Отсылаем прогрес
//
// Revision 1.65  2014/07/14 07:11:02  lukyanets
// {Requestlink:553422280}. Вертаем старую логику
//
// Revision 1.64  2014/07/14 06:21:03  lukyanets
// {Requestlink:553422280}. Разломался прогрессор на экспорте менее 10 документов
//
// Revision 1.63  2014/07/11 17:06:55  lulin
// - латаем за Ромой.
//
// Revision 1.62  2014/07/11 13:33:44  lukyanets
// {Requestlink:553422280}. Рисуем проценты от количества топиков
//
// Revision 1.61  2014/01/22 08:49:07  GarikNet
// K:513880842
//
// Revision 1.60  2013/04/19 13:10:10  lulin
// - портируем.
//
// Revision 1.59  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.58  2013/02/13 07:41:55  narry
// Обновление
//
// Revision 1.57  2013/01/22 12:42:24  narry
// Обновление
//
// Revision 1.56  2012/09/27 10:30:14  fireton
// - оптимизируем просчёт оставшегося времени
// - более корректно отображаем описание процесса
//
// Revision 1.55  2012/09/13 09:15:51  narry
// Строки в ресурсах
//
// Revision 1.54  2012/09/11 14:05:06  narry
// Исправление ошибок обновления прогресса
//
// Revision 1.53  2012/05/29 11:36:04  narry
// Range Check Error
//
// Revision 1.52  2012/05/17 10:37:28  narry
// Неправильный assert
//
// Revision 1.51  2012/04/12 10:25:59  narry
// Проверка, что обслуживается один процесс
//
// Revision 1.50  2012/04/11 12:34:23  narry
// AV
//
// Revision 1.49  2012/04/10 10:42:57  narry
// Корректное обновление Progressbar
//
// Revision 1.48  2012/03/29 07:37:19  fireton
// - bug fix: можно было получить AV
//
// Revision 1.47  2012/02/15 12:48:57  narry
// Обновление ProgressBar
//
// Revision 1.46  2012/01/11 10:29:26  narry
// UpdateProgress использует TotalPercent
//
// Revision 1.45  2011/11/11 12:25:52  narry
// Формирование таблички с датой-номером в начале текста (297708674)
//
// Revision 1.44  2011/10/13 08:43:31  narry
// Накопившиеся изменения
//
// Revision 1.43  2011/09/16 12:57:45  narry
// - обновление
//
// Revision 1.42  2011/09/07 13:02:21  narry
// Исправление градусника
//
// Revision 1.41  2010/02/12 09:42:19  narry
// - AV
//
// Revision 1.40  2010/01/29 11:45:58  narry
// - Обновление
//
// Revision 1.39  2009/11/20 15:20:05  narry
// - обновление
//
// Revision 1.38  2009/11/17 09:16:27  narry
// - обновление
//
// Revision 1.37  2009/11/16 10:11:38  narry
// - обновление
//
// Revision 1.36  2009/11/10 10:18:45  narry
// - обновление
//
// Revision 1.35  2009/09/15 08:30:08  narry
// - обновление
//
// Revision 1.34  2009/06/10 08:27:37  narry
// - корректный вызов OnUpdate
//
// Revision 1.33  2008/03/03 20:06:00  lulin
// - <K>: 85721135.
//
// Revision 1.32  2007/11/29 05:26:28  narry
// - не обновлялся "градусник"
//
// Revision 1.31  2007/07/04 09:17:53  narry
// - поддержка масштабирования значения индикатора
//
// Revision 1.30  2007/03/21 11:59:07  narry
// - Борьба со "схлопываением" окна прогресса
//
// Revision 1.29  2006/09/01 13:57:44  narry
// - не работал бегунок
//
// Revision 1.28  2005/11/03 09:40:50  narry
// - исправление: деление на ноль
//
// Revision 1.27  2005/11/02 16:28:13  narry
// - новое: название единицы измерения
// - исправление ошибок
//
// Revision 1.26  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.25  2005/02/21 15:20:08  narry
// - bug fix: range check
//
// Revision 1.24  2005/02/18 16:59:35  narry
// - bug fix: некорректный перевод секунд в строку
//
// Revision 1.23  2005/02/18 09:34:14  narry
// - bug fix: AV при использовании Tl3TimeEstimation
//
// Revision 1.22  2005/02/16 17:11:54  narry
// - update: альтернативный расчет времени окончания процесса
//
// Revision 1.21  2004/11/30 13:33:27  narry
// - bug fix: range check
//
// Revision 1.20  2004/07/01 12:54:40  narry
// - update
//
// Revision 1.19  2004/02/17 10:30:51  narry
// - update
// - cleanup
//
// Revision 1.18  2004/01/08 12:50:58  narry
// - update
//
// Revision 1.17  2003/11/05 12:21:50  narry
// - update: Ловушка для range check
//
// Revision 1.16  2003/09/15 14:35:49  narry
// - update
//
// Revision 1.15  2003/07/23 10:12:42  narry
// - update
//
// Revision 1.14  2003/07/22 12:03:31  narry
// - new: процедура обновления глобального прогресса
//
// Revision 1.13  2003/07/18 14:08:10  narry
// - change: запоминание сообщения о прогрессе выполнения
//
// Revision 1.12  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.11  2003/02/05 11:48:43  narry
// - update & bug fix
//
// Revision 1.10  2002/10/22 10:39:36  narry
// - update
//
// Revision 1.9  2002/10/18 14:57:18  narry
// - update & bug fix


{$I ddDefine.inc }

interface

Uses
 l3InterfacedComponent,
 l3Base, {$IFDEF usel3TimeEstimation}l3TimeEstimation, {$ENDIF}
 {$IFDEF Win7}W7TaskBar, {$ENDIF}
 ddProgressTypes, ddProgressDlg,
 DateUtils,ComCtrls, Classes, l3ObjectList, l3Types, StdCtrls;

const
  DefaultSyncWithNext = True; 

type
  TddProgressProcess = class(Tl3Base)
  private
   f_Current: Int64;
   f_Description: AnsiString;
   f_Finish: TDateTime;
   f_Maximum: Int64;
   f_Start: TDateTime;
   f_UnitName: ShortString;
   f_SyncWithNext: Boolean;
   function CalcSeconds(aStart, aFinish: TDateTime): int64;
   function pm_GetPercent: Integer;
   procedure pm_SetCurrent(const Value: Int64);
   procedure pm_SetMaximum(const Value: Int64);
   property Finish: TDateTime read f_Finish;
   property Percent: Integer read pm_GetPercent;
   property Start: TDateTime read f_Start;
   property UnitName: ShortString read f_UnitName write f_UnitName;
  protected
   function GetElapsedTime: Int64;
   function GetRemainingTime: Int64;
   procedure IncMaximum(aIncValue: Int64);
  public
   constructor Make(aMaximum: Int64; const aDescription: AnsiString; aSyncWithNext:
       Boolean; const aUnitName: ShortString = '');
   procedure Clear;
   procedure IncCurrent(aIncValue: Int64 = 1);
   procedure Update(aState: Integer; aIncValue: Int64);
   procedure UpdateMaximum(aValue: Int64);
   property Current: Int64 read f_Current write pm_SetCurrent;
   property Description: AnsiString read f_Description write f_Description;
   property ElapsedTime: Int64 read GetElapsedTime;
   property Maximum: Int64 read f_Maximum write pm_SetMaximum;
   property RemainingTime: Int64 read GetRemainingTime;
   property SyncWithNext: Boolean read f_SyncWithNext write f_SyncWithNext;
  end;

  TddProgressInfoMode = (dd_pmValue, dd_pmPercent);
  TddProgressEvent = procedure(Sender: TObject; aTotalPercent: Integer) of object;
  TddProgressObject = class(Tl3InterfacedComponent)
  private
    {$IFDEF usel3TimeEstimation}
    f_TimeCalc    : Tl3TimeEstimation;
    f_TimeCalcSec : Int64;
    {$ENDIF}
    FShowProcess    : Boolean;
    f_Dialog        : TddProgressDialog;
    f_Last: TddProgressProcess;
    f_OnUpdate: TddProgressEvent;
    f_OnAbort       : TNotifyEvent;
    f_OnProgressProc: Tl3ProgressProc;
    f_PrevPercent: Integer;
    f_PrevTotalPercent: Integer;
    f_Processes: Tl3ObjectList;
    f_TotalProgressBar: TProgressBar;
    f_Starts        : Integer;
    f_Ticks: Int64;
    f_CurProgressBar: TProgressBar;
    f_TotalTimeInfoLabel: TLabel;
    f_CurTimeInfoLabel: TLabel;
    f_UpdateInterval: Integer;
    f_AllowProgressDecrement: Boolean;
    procedure DestroyProcess;
    function GetProcessDesc(const aProgressObj: TddProgressProcess): AnsiString;
    procedure MakeProcess(aTotalMax: Int64; const aMessage: AnsiString; aUpdatePrev:
        Boolean);
    function pm_GetCaption: AnsiString;
    function pm_GetCur: Int64;
    function pm_GetProcesses(Index: Integer): TddProgressProcess;
    function pm_GetSingleProcess: Boolean;
    function pm_GetTextMessage: AnsiString;
    function pm_GetTotalCaption: AnsiString;
    function pm_GetTotalCur: Int64;
    function pm_GetTotalData: TddProgressProcess;
    function pm_GetCurrentData: TddProgressProcess;
    function pm_GetTotalMax: Int64;
    function pm_GetTotalMessage: AnsiString;
    function pm_GetTotalState: Integer;
    function pm_GetWorking: Boolean;
    procedure UpdateProgress(aState: Byte);
    procedure UpdateProgressBar;
    function _ProcentChanged: Boolean;
    function _UpdateEnabled: Boolean;
    function TotalSyncWithNext: Boolean;
    property Processes[Index: Integer]: TddProgressProcess read pm_GetProcesses;
  protected
    function GetPercent: Integer;
    function GetTotalPercent: Integer;
    function GetElapsedTime: Int64;
    function GetRemainingTime: Int64;
    function GetTotalElapsedTime: Int64;
    function GetTotalRemainingTime: Int64;
    function GetElapsedTimeAsString: ShortString;
    function GetRemainingTimeAsString: ShortString;
    function GetTotalElapsedTimeAsString: ShortString;
    function GetTotalRemainingTimeAsString: ShortString;
    function CalcSpeed(Value: int64; aStart, aFinish: TDateTime): TddSpeed;
    function CalcSeconds(aStart, aFinish: TDateTime): int64;
    procedure Cleanup; override;
    procedure UpdateDialog(const AddMessage: Boolean = False);
    procedure DialogAbortProcess(Sender: TObject);
    procedure InnerStart(aTotalMax: Int64);
    procedure InnerStop;
    procedure InnerUpdate(aCurValue: Int64); overload;
    function Peek: TddProgressProcess;
    function Pop: TddProgressProcess;
    procedure Push(aData: TddProgressProcess);
    property TotalData: TddProgressProcess read pm_GetTotalData;
    property CurrentData: TddProgressProcess read pm_GetCurrentData;
    property Working: Boolean read pm_GetWorking;
  public
    constructor Create(anOwner: TComponent = nil);
    procedure Start(aProcessMax: Int64 = 0; const aProcessMessage: AnsiString = '';
        aSyncWithNext: Boolean = DefaultSyncWithNext);
    procedure Stop;
    procedure ProcessUpdate(aState: Byte; aCurValue: LongInt; const aMsg: AnsiString);
        overload;
    procedure IncSize(aIncrement: Int64);
    procedure TotalTick;
    procedure ShowDialog;
    procedure HideDialog;
    procedure AddToDialog(const aMessage: AnsiString);
    procedure Idle;
    procedure StartInfinity(const aMessage: AnsiString = '');
    procedure StopInfinity;
    procedure ProcessUpdate(aCurValue: Int64); overload;
    procedure IncProgress(aDelta: Int64);
    procedure SetVisualParams(aTotalProgressBar: TProgressBar; aTotalTimeInfoLabel: TLabel = nil;
        aCurProgressBar: TProgressBar = nil; aCurTimeInfoLabel: TLabel = nil);
  public
    property ElapsedTime: Int64 read GetElapsedTime;
    property ElapsedTimeAsString : ShortString
      read GetElapsedTimeAsString;
    property RemainingTime: Int64 read GetRemainingTime;
    property RemainingTimeAsString : ShortString
      read GetRemainingTimeAsString;

    property TotalElapsedTime: Int64 read GetTotalElapsedTime;
    property TotalElapsedTimeAsString : ShortString
      read GetTotalElapsedTimeAsString;
    property TotalRemainingTime: Int64 read GetTotalRemainingTime;
    property TotalRemainingTimeAsString : ShortString
      read GetTotalRemainingTimeAsString;

    property Percent: Integer
      read GetPercent;
    property TotalPercent: Integer
      read GetTotalPercent;

    property Caption: AnsiString read pm_GetCaption;
    property OnUpdate: TddProgressEvent read f_OnUpdate write f_OnUpdate;
    property OnAbort     : TNotifyEvent
     read f_OnAbort
     write f_OnAbort;
    property OnProgressProc: Tl3ProgressProc read f_OnProgressProc write
        f_OnProgressProc;
    property Cur: Int64 read pm_GetCur;
    property ShowProcess: Boolean read FShowProcess write FShowProcess;
    property SingleProcess: Boolean read pm_GetSingleProcess;
    property TotalCaption: AnsiString read pm_GetTotalCaption;
    property TotalCur: Int64 read pm_GetTotalCur;
    property TotalMax: Int64 read pm_GetTotalMax;
    property AllowProgressDecrement: Boolean read f_AllowProgressDecrement write f_AllowProgressDecrement;
  published
    property TotalState: Integer read pm_GetTotalState;
  end;

const
  TimeCalcValues = 100;
  dd_poMinimumTicks = 1000; // Обновлять индикаторы не чаще раза в секунду секунду

implementation

uses
  SysUtils, Forms, Math, Windows,

  afwFacade,

  ddUtils
  , l3ObjectRefList1;

// START resource string wizard section
resourcestring
 sElapsed      = 'Прошло: ';
 sWorked       = 'Обработано: ';
 sProcessDone  = 'Процесс завершен';
 sRemaining    = 'Осталось: ';
 sWrongPercent = 'Неверный процент: %d/%d*100';

// END resource string wizard section


constructor TddProgressObject.Create(anOwner: TComponent = nil);
begin
 inherited Create(anOwner);
 f_Processes:= Tl3ObjectList.Make;
end;

function TddProgressObject.GetPercent: Integer;
begin
 if Working then
  Result:= Peek.Percent
 else
  Result:= -1;
end;

function TddProgressObject.GetTotalPercent: Integer;
begin
 if Working then
  Result:= TotalData.Percent
 else
  Result:= -1;
end;

procedure TddProgressObject.Start(aProcessMax: Int64 = 0; const
    aProcessMessage: AnsiString = ''; aSyncWithNext: Boolean = DefaultSyncWithNext);
var
 l_Cur: TddProgressProcess;
begin
 if aProcessMax > 0 then
 begin
  MakeProcess(aProcessMax, aProcessMessage, aSyncWithNext);
  InnerStart(aProcessMax);
 end;
end;

procedure TddProgressObject.Stop;
begin
 if f_Starts > 0 then
 begin
  InnerStop;
  DestroyProcess;
 end; // f_Starts > 0
end;

procedure TddProgressObject.ProcessUpdate(aState: Byte; aCurValue: LongInt; const aMsg: AnsiString);
begin
 // Сюда приходит текущее значение процесса
 case aState of
  0: Start(aCurValue, aMsg, DefaultSyncWithNext);
  1: begin
      if (aMsg <> '') then
       Peek.Description:= aMsg;
      ProcessUpdate(aCurValue);
     end;
  2: Stop;
 end;
end;

function TddProgressObject.GetElapsedTime: Int64;
begin
 if Working then
  Result:= Peek.ElapsedTime
 else
  Result:= 0;
end;

function TddProgressObject.GetRemainingTime: Int64;
begin
 if Working then
  Result:= Peek.RemainingTime
 else
  Result:= 0;
end;

function TddProgressObject.GetTotalElapsedTime: Int64;
begin
 if Working then
  Result:= TotalData.ElapsedTime
 else
 if f_Last <> nil then
  Result:= f_Last.ElapsedTime
 else 
  Result:= 0;
end;

function TddProgressObject.GetTotalRemainingTime: Int64;
begin
 if Working then
  Result:= Totaldata.RemainingTime
 else
  Result:= 0;
end;

function TddProgressObject.CalcSeconds(aStart, aFinish: TDateTime): int64;
begin
 Result:= SecondsBetween(aFinish, aStart);
end;

function TddProgressObject.CalcSpeed(Value: int64; aStart, aFinish: TDateTime):
    TddSpeed;
var
 SizeIndex : TddSizeType;
 TimeIndex : TddTimeType;
 Secs      : Longint;
begin
 { TODO -oДудко Дмитрий -cРазвитие : Какая-то фигня. Нужно пересмотреть и исправить }
 Result:= ddNullSpeed;
 Secs:= CalcSeconds(aStart, aFinish);
 if (Secs > 0) and (Value > 0) then
 begin
  Result.TimeType := dd_ttSec;
  Result.Value:= Value div Secs;
  for SizeIndex:= Low(TddSizeType) to Pred(High(TddSizeType)) do
  begin
   if Result.Value > dd_SizeMulti[SizeIndex] then
   begin
    Result.SizeType:= SizeIndex;
    Result.ValueHi:= Result.Value div dd_SizeMulti[SizeIndex];
    Result.ValueLo:= (Result.Value mod dd_SizeMulti[SizeIndex])*10 div dd_SizeMulti[SizeIndex];
    break;
   end; // Result.Value > dd_SizeMulti[SizeIndex]
  end; // for SizeIndex
 end; // Value > 0
end;


function TddProgressObject.GetElapsedTimeAsString: ShortString ;
begin
  Result:= TimeSec2Str(ElapsedTime);
end;

function TddProgressObject.GetRemainingTimeAsString: ShortString;
begin
 if Percent < 100 then
  Result:= TimeSec2Str(RemainingTime)
 else
  Result:= '';
end;

function TddProgressObject.GetTotalElapsedTimeAsString: ShortString;
begin
  Result:= TimeSec2Str(TotalElapsedTime);
end;

function TddProgressObject.GetTotalRemainingTimeAsString: ShortString;
begin
 {$IFDEF usel3TimeEstimation}
 if f_TimeCalcSec > 0 then
  Result := TimeSec2Str(f_TimeCalcSec)
 else
 {$ENDIF}
 if TotalPercent < 100 then
  Result:= TimeSec2Str(TotalRemainingTime)
 else
  Result:= '';
end;

procedure TddProgressObject.IncSize(aIncrement: Int64);
begin
 Assert(False, 'IncSize');
end;

procedure TddProgressObject.ShowDialog;
begin
 if f_Dialog = nil then
  f_Dialog:= TddProgressDialog.Create(Application);
 f_Dialog.OnAbort:= DialogAbortProcess;
 UpdateDialog;
 f_Dialog.Show;
end;

procedure TddProgressObject.HideDialog;
begin
 l3Free(f_Dialog);
end;

procedure TddProgressObject.AddToDialog(const aMessage: AnsiString);
begin
 if (f_Dialog <> nil) and f_Dialog.ShowDetails then
 begin
  f_Dialog.AddToDetails(aMessage);
 end; //f_Dialog <> nil
end;

procedure TddProgressObject.Cleanup;
var
 l_P: TddProgressProcess;
begin
 inherited;
 while not f_Processes.Empty do
 begin
  l_P := TddProgressProcess(f_Processes.Last);
  f_Processes.DeleteLast;
  l3Free(l_P);
 end; // while
 l3Free(f_Last);
 l3Free(f_Processes);
end;

procedure TddProgressObject.DestroyProcess;
var
 l_Cur: TddProgressProcess;
begin
 l_Cur:= Pop;
 if not Working then
  f_Last:= l_Cur.Use;
 l3Free(l_Cur);
end;

procedure TddProgressObject.UpdateDialog(const AddMessage: Boolean = False);
begin
 if f_Dialog <> nil then
 begin
  f_Dialog.Caption:= Caption;
  with f_Dialog do
  begin
   lblMessage.Caption:= Caption;
   pbLocal.Max:= 100;
   pbLocal.Position:= Percent;
   lblLocalDone.Caption:=      sWorked + Bytes2Str(Cur);
   lblLocalElapsed.Caption:=   sElapsed + ElapsedTimeAsString;
   if Percent <> 100 then
    lblLocalRemaining.Caption:= sRemaining + RemainingTimeAsString
   else
    lblLocalRemaining.Caption:= sProcessDone;
   if AddMessage then
    AddToDialog(Caption);
   pbTotal.Max:= 100;
   pbTotal.Position:= TotalPercent;
   lblTotalDone.Caption:=      sWorked + Bytes2Str(TotalCur);
   lblTotalElapsed.Caption:=   sElapsed + TotalElapsedTimeAsString;
   if TotalPercent <> 100 then
    lblTotalRemaining.Caption:= sRemaining + TotalRemainingTimeAsString
   else
    lblTotalRemaining.Caption:= sProcessDone;
  end;
  afw.ProcessMessages;
 end;
end;


procedure TddProgressObject.DialogAbortProcess(Sender: TObject);
begin
 if Assigned(f_OnAbort) then
  f_OnAbort(Self);
end;

function TddProgressObject.GetProcessDesc(const aProgressObj: TddProgressProcess): AnsiString;
var
 l_Str: AnsiString;
begin
 Result := aProgressObj.Description;
 if aProgressObj.Percent <> 100 then
  l_Str := sRemaining + TimeSec2Str(aProgressObj.RemainingTime)
 else
  l_Str := sProcessDone;
 if Result <> '' then
  Result := Format('%s (%s)', [Result, AnsiLowerCase(l_Str)])
 else
  Result := l_Str;
end;

procedure TddProgressObject.Idle;
begin
 ProcessUpdate(0);
 if (f_Dialog <> nil) and _UpdateEnabled then
  UpdateDialog;
end;

function TddProgressObject.Peek: TddProgressProcess;
begin
 if Working then
  Result := TddProgressProcess(f_Processes.Last)
 else
  Result:= f_Last;
 Assert(Result <> nil, 'Нужно сначала вызвать Start');
end;

function TddProgressObject.pm_GetCur: Int64;
begin
 if Peek <> nil then
  Result := Peek.Current
 else
  Result := 0; 
end;

function TddProgressObject.pm_GetTotalCur: Int64;
begin
 if TotalData <> nil then
  Result := TotalData.Current
 else
  Result := 0;
end;

function TddProgressObject.pm_GetTotalData: TddProgressProcess;
begin
 if Working then
  Result := TddProgressProcess(f_Processes.First)
 else
  Result:= Peek;
end;

function TddProgressObject.pm_GetTotalMax: Int64;
begin
 if TotalData <> nil then
  Result := TotalData.Maximum
 else
  Result := 0;
end;

function TddProgressObject.Pop: TddProgressProcess;
begin
 Result := TddProgressProcess(f_Processes.Last);
 f_Processes.DeleteLast;
end;

procedure TddProgressObject.Push(aData: TddProgressProcess);
var
 i: Integer;
begin
(*  Зачем?!
  for i:= f_Processes.Hi downto 0 do
   if Processes[i].SyncWithNext then
    Processes[i].UpdateMaximum(aData.Maximum)
   else
    break;
*)
 f_Processes.Add(aData);
end;

procedure TddProgressObject.InnerStart(aTotalMax: Int64);
var
 i: Integer;
begin
 Inc(f_Starts);

 if Peek.Maximum = 0 then
  Peek.Maximum:= aTotalMax;

  for i:= Pred(f_Processes.Hi) downto 0 do
  begin
   with Processes[i] do
   begin
    if SyncWithNext  then
     IncMaximum(aTotalMax)
    else
     break;
   end; // with Processes[i]
  end; // for i


 f_Ticks := GetTickCount;
 f_PrevPercent := 0;
 f_PrevTotalPercent:= 0;

 if ShowProcess then
  ShowDialog;
 if aTotalMax <> 0 then
  UpdateProgress(0);
end;

procedure TddProgressObject.InnerStop;
begin
 // Остановить текущй, обновить предыдущие...
 Dec(f_Starts);
 //if (Peek.Maximum > 0) and (Peek.Current <> Peek.Maximum) then // Заканчиваем текущий процесс
 ProcessUpdate(Peek.Maximum{, True});
 UpdateProgress(2);

 if ShowProcess and (f_Starts = 0) then
  HideDialog;
end;

procedure TddProgressObject.MakeProcess(aTotalMax: Int64; const aMessage:
    AnsiString; aUpdatePrev: Boolean);
begin
 l3Free(f_Last);
 Push(TddProgressProcess.Make(aTotalMax, aMessage, aUpdatePrev));
end;

function TddProgressObject.pm_GetCaption: AnsiString;
begin
 if Peek <> nil then
  Result := Peek.Description
 else
  Result := '';
end;

function TddProgressObject.pm_GetTextMessage: AnsiString;
begin
 if Working then
  Result := Peek.Description
 else
  Result:= '';
end;

function TddProgressObject.pm_GetTotalMessage: AnsiString;
begin
 if not f_Processes.Empty then
  Result := TddProgressProcess(f_Processes.First).Description
 else
  Result:= '';
end;

function TddProgressObject.pm_GetTotalState: Integer;
begin
 Result := IfThen(f_Starts > 1, 1, 0);
end;

function TddProgressObject.pm_GetWorking: Boolean;
begin
 Result := not f_Processes.Empty;
end;

procedure TddProgressObject.StartInfinity(const aMessage: AnsiString = '');
begin
 Start(-1, aMessage, False);
end;

procedure TddProgressObject.StopInfinity;
begin
 Stop;
end;

procedure TddProgressObject.ProcessUpdate(aCurValue: Int64);
begin
 // Сюда приходит текущее значение процесса
 InnerUpdate(aCurValue);
end;

procedure TddProgressObject.InnerUpdate(aCurValue: Int64);
var
 i: Integer;
 l_IncValue: Int64;
begin
 if AllowProgressDecrement or (aCurValue <> 0) then
 begin
  // Сюда приходит текущее значение процесса, нужно вычислить дельту
  l_IncValue:= aCurValue - Peek.Current;
  // Нужно обновить все процессы, включающие текущий
  if AllowProgressDecrement or (l_IncValue > 0) then
   Peek.IncCurrent(l_IncValue);
  for i:= Pred(f_Processes.Hi) downto 0 do
  begin
   with Processes[i] do
   begin
    if SyncWithNext and (l_IncValue > 0) then
     IncCurrent(l_IncValue)
    else
    if l_IncValue = 0{aCurValue = Peek.Maximum} then
     IncCurrent;
   end; // with Processes[i]
  end; // for i
  UpdateProgress(1);
 end;
end;

function TddProgressObject.pm_GetProcesses(Index: Integer): TddProgressProcess;
begin
 Result := TddProgressProcess(f_Processes.Items[index]);
end;

function TddProgressObject.pm_GetSingleProcess: Boolean;
begin
 Result:= TotalData = Peek;
end;

function TddProgressObject.pm_GetTotalCaption: AnsiString;
begin
 Result := TotalData.Description;
end;

function TddProgressObject.pm_GetCurrentData: TddProgressProcess;
begin
 Result := Peek;
end;

procedure TddProgressObject.SetVisualParams(aTotalProgressBar: TProgressBar; aTotalTimeInfoLabel:
    TLabel = nil; aCurProgressBar: TProgressBar = nil; aCurTimeInfoLabel: TLabel = nil);
begin
 f_TotalProgressBar:= aTotalProgressBar;
 f_TotalTimeInfoLabel:= aTotalTimeInfoLabel;
 f_CurProgressBar:= aCurProgressBar;
 f_CurTimeInfoLabel:= aCurTimeInfoLabel;
end;

procedure TddProgressObject.UpdateProgress(aState: Byte);
var
 l_Value: Int64;
begin
 // Обновление тех, кто следит за выполнением процесса
 if (aState <> 1) or _UpdateEnabled then
 begin
  UpdateDialog(True);

  if Assigned(f_OnUpdate) then
   f_OnUpdate(Self, TotalPercent);

  if Assigned(f_OnProgressProc) then
   f_OnProgressProc(aState, TotalPercent, TotalCaption);

  UpdateProgressBar;

  {$IFDEF Win7}
  if Application.MainForm <> nil then
  begin
   case aState of
    0: SetProgressState(Application.MainForm.Handle, tbpsIndeterminate);
    2: SetProgressState(Application.MainForm.Handle, tbpsNone);
   end;
   SetProgressValue(Application.MainForm.Handle, Percent, 100);
  end;
  {$ENDIF}
 end; // _UpdateEnabled;
end;

procedure TddProgressObject.UpdateProgressBar;
var
 l_State: Byte;
begin
 // Общий прогресс
 if f_TotalProgressBar <> nil then
 begin
  if TotalData.Current = 0 then
  begin
   f_TotalProgressBar.Position:= 0;
   f_TotalProgressBar.Max:= 100;
  end
  else
   f_TotalProgressBar.Position:= TotalPercent;
 end; // f_TotalProgressBar <> nil

 if f_TotalTimeInfoLabel <> nil then
  f_TotalTimeInfoLabel.Caption := GetProcessDesc(TotalData);
 // Текущий прогресс
 if f_CurProgressBar <> nil then
 begin
  if Cur = 0 then
  begin
   f_CurProgressBar.Position:= 0;
   f_CurProgressBar.Max:= 100;
  end
  else
   f_CurProgressBar.Position:= Percent;
 end; // f_TotalProgressBar <> nil
 if f_CurTimeInfoLabel <> nil then
  f_CurTimeInfoLabel.Caption := GetProcessDesc(CurrentData);
 if (f_TotalProgressBar <> nil) or (f_TotalTimeInfoLabel <> nil)
  or (f_CurProgressBar <> nil) or (f_CurTimeInfoLabel <> nil) then
  Application.ProcessMessages;
end;

function TddProgressObject._ProcentChanged: Boolean;
var
 l_P, l_TP: Integer;
begin
 l_P:= Percent;
 l_TP:= TotalPercent;
 Result := (f_PrevPercent <> l_P) and (f_PrevTotalPercent <> l_TP);
 if Result then
 begin
  f_PrevPercent := l_P;
  f_PrevTotalPercent := l_TP;
 end;
end;

function TddProgressObject._UpdateEnabled: Boolean;
var
 l_Ticks : Int64;
begin
 l_Ticks := GetTickCount;
 Result := ((l_Ticks - f_Ticks) > dd_poMinimumTicks){ and _ProcentChanged};
 if Result then
  f_Ticks := l_Ticks;
end;

constructor TddProgressProcess.Make(aMaximum: Int64; const aDescription:
    AnsiString; aSyncWithNext: Boolean; const aUnitName: ShortString = '');
begin
 inherited;
 Maximum:= aMaximum;
 Description:= aDescription;
 SyncWithNext:= aSyncWithNext;
end;

function TddProgressProcess.CalcSeconds(aStart, aFinish: TDateTime): int64;
begin
 Result:= SecondsBetween(aFinish, aStart);
end;

procedure TddProgressProcess.Clear;
begin
 f_Maximum:= 0;
 f_Current:= 0;
 f_Start:= 0;
 f_Finish:= 0;
end;

function TddProgressProcess.GetElapsedTime: Int64;
begin
 Result:= SecondsBetween(f_Finish, f_Start)
end;

function TddProgressProcess.GetRemainingTime: Int64;
var
 l_Time: Int64;
begin
 Result:= -1;
 //if Percent > 1 then
 begin
  l_Time:= ElapsedTime;
  if (Maximum > 0) and (l_Time > 0) then
   Result:= (l_Time*Maximum) div Current - l_Time
 end;
end;

procedure TddProgressProcess.IncCurrent(aIncValue: Int64 = 1);
begin
 if Maximum > 0 then
 Current:=Min(Maximum, Current + aIncValue);
end;

procedure TddProgressProcess.IncMaximum(aIncValue: Int64);
begin
 Inc(f_Maximum, aIncValue);
end;

function TddProgressProcess.pm_GetPercent: Integer;
begin
 try
  if Maximum > 0 then
   Result:= Current * 100 div Maximum
  else
   Result:= -1;
 except
  Result:= 100;
 end;
 if Abs(Result) > 100 then
 begin
  Result:= 100;
  l3System.Msg2Log(sWrongPercent, [Current, Maximum]);
 end; 
end;

procedure TddProgressProcess.pm_SetCurrent(const Value: Int64);
begin
 if Maximum > 0 then
  f_Current := Min(Maximum, Value);
 f_Finish:= Now;
end;

procedure TddProgressProcess.pm_SetMaximum(const Value: Int64);
begin
 Clear;
 f_Maximum:= Value;
 f_Start:= Now;
 f_Finish:= Now;
end;

procedure TddProgressProcess.Update(aState: Integer; aIncValue: Int64);
begin
 case aState of
  0: Maximum:= aIncValue;
  1: Current:= Min(f_Maximum, aIncValue);
  2: Current:= f_Maximum;
 end; // case
end;

procedure TddProgressProcess.UpdateMaximum(aValue: Int64);
begin
 if aValue > 0 then
  f_Maximum:= f_Maximum + aValue;
end;

function TddProgressObject.TotalSyncWithNext: Boolean;
begin
  if Working then
    Result := TotalData.SyncWithNext
  else
    Result := DefaultSyncWithNext;
end;

procedure TddProgressObject.TotalTick;
begin
  if not TotalSyncWithNext and Working then
    TotalData.IncCurrent;
end;

procedure TddProgressObject.IncProgress(aDelta: Int64);
begin
 InnerUpdate(Peek.Current + aDelta);
end;

end.

