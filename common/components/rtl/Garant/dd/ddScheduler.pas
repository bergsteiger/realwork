unit ddScheduler;
{* Класс Планировщик }
{ Автор: Дудко Д.В.  }
{ Начат: 11.11.2003  }
{ $Id: ddScheduler.pas,v 1.112 2016/03/04 09:35:41 lukyanets Exp $ }

// $Log: ddScheduler.pas,v $
// Revision 1.112  2016/03/04 09:35:41  lukyanets
// Отвалились вложенные задания
//
// Revision 1.111  2016/03/02 11:06:43  lukyanets
// Меньше гадим в лог
//
// Revision 1.110  2016/03/01 13:19:09  lukyanets
// Текут LocalStub
//
// Revision 1.109  2016/03/01 12:56:18  lukyanets
// Текут LocalStub
//
// Revision 1.108  2016/02/25 13:43:25  lukyanets
// Временный механизм откладывания выполнения
//
// Revision 1.107  2016/02/25 12:44:44  lukyanets
// Cleanup
//
// Revision 1.106  2016/02/25 08:17:31  lukyanets
// Cleanup
//
// Revision 1.105  2016/02/19 11:48:49  lukyanets
// Заготовки вилочного запроса
//
// Revision 1.104  2016/01/21 06:41:52  lukyanets
// Cleanup
//
// Revision 1.103  2015/12/22 11:38:17  lukyanets
// Выводим в лог потребление виндовых ресурсов
//
// Revision 1.102  2015/12/10 13:16:41  lukyanets
// Логируем потребление памяти
//
// Revision 1.101  2015/10/14 07:08:12  lukyanets
// Cleanup
//
// Revision 1.100  2015/10/13 14:11:19  lukyanets
// Останавливаем обработку на закрытой базе
//
// Revision 1.99  2015/08/19 11:42:21  lukyanets
// Было зацикливание при смене времени
//
// Revision 1.98  2015/08/13 13:26:19  lukyanets
// Неверный вывод в лог
//
// Revision 1.97  2015/08/10 13:37:47  lukyanets
// Логирование
//
// Revision 1.96  2015/06/25 14:47:44  lukyanets
// Информируем об одновременных задачах
//
// Revision 1.95  2015/06/24 14:02:57  lukyanets
// Убираем излишний рестарт
//
// Revision 1.94  2015/06/24 13:39:06  lukyanets
// Убираем излишний рестарт
//
// Revision 1.93  2015/06/24 11:16:16  lukyanets
// Боремся с переполнением
//
// Revision 1.92  2015/06/24 11:00:45  lukyanets
// Переопространствил
//
// Revision 1.91  2015/06/23 14:12:32  lukyanets
// Заготовки переосмысления
//
// Revision 1.90  2015/06/23 11:55:46  lukyanets
// Рожаем таймер с собятием на смену машинного времени
//
// Revision 1.89  2015/03/12 07:34:30  lukyanets
// Подчищаем вывод в лог
//
// Revision 1.88  2015/02/11 13:44:27  kostitsin
// ChangingChanged
//
// Revision 1.87  2015/01/14 13:50:55  lukyanets
// Утечки памяти
//
// Revision 1.86  2014/12/29 06:47:06  lukyanets
// Зацикливались
//
// Revision 1.85  2014/12/11 08:37:05  voba
// - bf зацикливалосось при удалении всех заданий
//
// Revision 1.84  2014/12/11 08:10:50  voba
// - bf зацикливалосось при удалении всех заданий
//
// Revision 1.83  2014/12/08 07:11:39  lukyanets
// Логи и борьба с переходом через сутки
//
// Revision 1.82  2014/12/04 07:23:29  lukyanets
// Боремся с переходом через сутки
//
// Revision 1.81  2014/12/02 14:02:12  lukyanets
// Боремся с переходом через сутки
//
// Revision 1.80  2014/12/02 13:38:35  lukyanets
// Еще ловушек
//
// Revision 1.79  2014/11/25 08:41:42  lukyanets
// Выпадали за диапазон
//
// Revision 1.78  2014/11/24 12:16:24  lukyanets
// Расставляем логи
//
// Revision 1.77  2014/11/17 14:17:09  lukyanets
// Приостанавливаем шедулер на время глобальных обновлений
//
// Revision 1.76  2014/08/18 10:51:59  lukyanets
// {Requestlink:562611471}. Вертаем взад
//
// Revision 1.75  2014/08/18 10:22:22  fireton
// - более информативный лог
//
// Revision 1.74  2014/07/25 09:45:59  lukyanets
// {Requestlink:557844282}. Подружили dt_mail с ассистентом
//
// Revision 1.73  2014/07/16 07:59:01  lukyanets
// {Requestlink:553422280}. Притормаживаем отцепленное выполнение
//
// Revision 1.72  2014/07/16 07:47:46  lukyanets
// {Requestlink:553422280}. Притормаживаем отцепленное выполнение
//
// Revision 1.71  2014/02/17 16:26:04  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.70  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.69  2013/09/19 10:33:18  fireton
// - неверно возвращалось время из конфига
//
// Revision 1.68  2013/09/05 09:38:06  kostitsin
// [$476838236] - закончил c ddAppConfigTypes
//
// Revision 1.67  2013/09/05 09:22:42  kostitsin
// [$476838236] - закончил c ddAppConfigTypes
//
// Revision 1.66  2013/09/03 09:58:59  kostitsin
// [$476838236]
//
// Revision 1.65  2013/08/30 08:48:08  kostitsin
// [$476838236]
//
// Revision 1.64  2013/08/29 18:22:07  kostitsin
// [$476838236] - пока вручную. Осталось поправить модель.
//
// Revision 1.63  2013/08/28 05:14:09  fireton
// - не собиралось
//
// Revision 1.62  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.61  2013/04/08 07:06:47  narry
// Автоматический экспорт анонсированных (447390002)
//
// Revision 1.60  2013/01/22 12:32:40  narry
// Обновление
//
// Revision 1.59  2012/07/13 11:28:12  narry
// Обновление
//
// Revision 1.58  2012/05/31 07:42:24  narry
// Уточнение формирования времени запуска "ежеминутных" заданий
//
// Revision 1.57  2012/05/24 12:48:18  narry
// Интервал повторяемости в минутах (365825882)
//
// Revision 1.56  2010/09/27 05:50:22  narry
// K235057449. Задания, стоящие после отложенного не выполняются
//
// Revision 1.55  2010/09/03 06:52:47  narry
// - AV при выполнении вложенных задач
//
// Revision 1.54  2010/08/27 08:59:41  narry
// - Не отбработали задачи, вложенные в Компиляцию
//
// Revision 1.53  2010/07/23 09:39:34  narry
// К125894967. Связанные задания не запускаются, если не отработало предыдущее.
//
// Revision 1.52  2010/07/20 12:28:21  narry
// К226003904
//
// Revision 1.51  2010/03/16 11:42:22  narry
// - корректная запись вложенных заданий
//
// Revision 1.50  2010/03/10 13:57:24  narry
// - не собиралось
//
// Revision 1.49  2009/05/15 15:12:47  narry
// - не сохранялись параметры задания
//
// Revision 1.48  2009/03/13 15:13:51  narry
// - связь между элементами
//
// Revision 1.47  2009/02/20 13:36:15  narry
// - обновление
//
// Revision 1.46  2009/02/16 07:53:19  narry
// - не удалялись задания
//
// Revision 1.45  2009/01/23 15:56:12  narry
// - рефакторинг редактирования
// - вложенные задания
//
// Revision 1.44  2008/12/16 11:49:30  narry
// - не удалялись задачи из шедулера
//
// Revision 1.43  2008/10/28 08:54:21  narry
// - терялись даты исключений
//
// Revision 1.42  2008/10/21 09:51:54  narry
// - исправлен алгоритм вычисления предыдущей даты задания
//
// Revision 1.41  2008/09/29 13:53:09  narry
// - проверка не только даты, но и времени
// - событие "не по таймеру" выключало планировщик
//
// Revision 1.40  2008/08/25 09:57:16  narry
// - обновление
//
// Revision 1.39  2008/08/19 12:01:02  narry
// - неправильно вычислялась дата выполнения ежемесячного повторения
//
// Revision 1.38  2008/08/18 12:39:22  narry
// - упрощение сообщения об обязательном параметре
//
// Revision 1.37  2008/08/18 09:18:57  narry
// - замена LastExecuted на ExecuteByTimer
//
// Revision 1.36  2008/07/28 09:55:16  fireton
// - автоподстановка периодичности заданий
// - required типы заданий
//
// Revision 1.35  2008/07/25 12:33:23  narry
// - вывод в лог названия задания
//
// Revision 1.34  2008/07/24 11:49:52  fireton
// - уведомление клиента об изменениях заданий в планировщике
//
// Revision 1.33  2008/07/21 13:07:00  fireton
// - не выполняем уже выполненное задание
//
// Revision 1.32  2008/07/21 11:45:03  fireton
// - КалеСо (версии и компиляции)
//
// Revision 1.31  2008/07/16 16:09:45  narry
// - рефакторинг
//
// Revision 1.30  2008/07/09 06:37:35  fireton
// - переводим расписание с единичного события на подписку по типам заданий
//
// Revision 1.29  2008/02/06 09:27:36  narry
// - не компилировалось
//
// Revision 1.28  2008/02/04 12:24:51  narry
// - не компилировалось
//
// Revision 1.27  2007/08/27 16:28:19  lulin
// - убрано использование ненужных модулей.
//
// Revision 1.26  2007/02/28 10:29:49  narry
// - обновление
//
// Revision 1.25  2007/01/12 08:38:15  narry
// - отложенные задания больше не выполнялись :(
//
// Revision 1.24  2006/12/08 08:47:33  narry
// - отложенные задания зацикливались
//
// Revision 1.23  2006/03/27 13:55:48  narry
// - исправление: неправильные запись-чтение заданий
//
// Revision 1.22  2006/03/21 08:43:53  narry
// no message
//
// Revision 1.21  2006/01/05 16:25:43  narry
// - исправление: некорректно задавались "запретные" дни
// - новое: запись-чтение "запретных" дней
//
// Revision 1.20  2006/01/05 15:04:16  narry
// - новое: выбор дней недели,по которым не выполняется ежедневное задание
//
// Revision 1.19  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.18  2004/12/23 11:42:08  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.17  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.16  2004/06/02 16:24:49  narry
// - update: изменения в иерархии листов
//
// Revision 1.15  2004/05/21 12:03:57  narry
// - bug fix: ошибка чтения нескольких заданий
//
// Revision 1.14  2004/04/29 15:20:41  narry
// - update and bug fix
//
// Revision 1.13  2004/04/29 13:21:16  narry
// - bug fix: range check error
//
// Revision 1.12  2004/04/28 13:43:42  narry
// - update
//
// Revision 1.11  2004/03/04 17:55:26  narry
// - new: повторение текущего задания через N миллисекунд
//
// Revision 1.10  2004/02/24 14:40:00  narry
// - update
//
// Revision 1.9  2004/02/17 10:33:30  narry
// - update: попытка поймать AV
//
// Revision 1.8  2004/01/05 15:17:13  narry
// - update: заглушка для AV
//
// Revision 1.7  2003/12/29 13:41:00  narry
// - update: проверка дат перед заменой
//
// Revision 1.6  2003/12/23 17:04:31  narry
// - update
//
// Revision 1.5  2003/12/09 09:29:44  narry
// - add: Строковое описание задание
// - add: свойство UID для борьбы с повторными запусками задания
// - add: событие для генерации цвета задания по его ID
// - change: процедуры добавления заданий теперь функции
//
// Revision 1.4  2003/12/03 16:42:47  narry
// - update: интеграция с TCustomSchedulPanel
//
// Revision 1.3  2003/12/03 14:44:36  narry
// - update
//
// Revision 1.2  2003/12/01 15:20:34  narry
// - cleanup
// - bug fix: Integer overflow при формировании номера блока глубокой вложенности
// -change: переименование пункта "Произвольно" в "Больше пяти уровней" и перенос его в конец списка
//
// Revision 1.1  2003/11/12 15:43:07  narry
// - new unit; Класс предназначенный для выполнения заданий через указанные интервалы времени
//

{$Include ..\dd\ddDefine.inc}

{$DEFINE NestedTasks}

interface

Uses
 Classes, IniFiles, Graphics, DateUtils, Math, Contnrs,
 l3IniFile,
 ddCalendarEvents,
 ddConfigStorages,
 l3Base,
 l3ObjectRefList,
 l3RecList,
 l3Timer,

 ddAppConfigTypes,
 ddAppConfigConst;

type
  TddSchedulerTaskPeriodicity = (stOnce,       // заданы время и дата
                         stEveryDay,   // задано время
                         stEveryWeek,  // заданы время и день недели
                         stEveryMonth, // заданы время и день месяца
                         stEveryYear,  // заданы время, день и месяц
                         stEveryMinutes // задан интервал повторения
                         );

  TddSchedulerDayOfWeek = (st_dowMonday = DayMonday,
                           st_dowTuesday,
                           st_dowWednesday,
                           st_dowThursday,
                           st_dowFriday,
                           st_dowSaturday,
                           st_dowSunday);
  TddSchedulerDays = set of TddSchedulerDayOfWeek;

  TddSchedulerTaskResult = (strOk, strFailed, strRequestDelay);

  TddSchedulerTime = class(Tl3Base)
  private
    f_DateTime: TDateTime;
    f_Isdate: Boolean;
    f_IsTime: Boolean;
  public
    procedure Assign(P: TddSchedulerTime); //override;
    property DateTime: TDateTime read f_DateTime write f_DateTime;
    property IsDate: Boolean read f_Isdate write f_Isdate;
    property IsTime: Boolean read f_IsTime write f_IsTime;
  end;

 TddSchedulerTask = class(Tl3Base)
 private
    FExcludeDates: Tl3ObjectRefList;
    FIncludeDates: Tl3ObjectRefList;
    f_Deleted: Boolean;
    f_ExecuteByTimer: Boolean;
    f_IsChanged: Boolean;
    f_Master: TddSchedulerTask;
    f_Params: TddAppConfigNode;
    f_UID: Integer;
    f_NextScheduledTime: TDateTime;
    f_ExecuteResult: TddSchedulerTaskResult;
    procedure AssignExcludeDates(aSource: TddSchedulerTask);
    procedure AssignIncludeDates(aSource: TddSchedulerTask);
    procedure CreateParams;
    procedure DestroyParams;
    function GetExcludeDates(Index: Integer): TddSchedulerTime;
    function GetExcludeDatesCount: Integer;
    function GetFullDateTime(NearDate: TDateTime): TDateTime;
    function GetIncludeDates(Index: Integer): TddSchedulerTime;
    function GetIncludeDatesCount: Integer;
    function IsValidDate(const aDate: TDateTime): Boolean;
    function NestedAlias: AnsiString;
    function NextDate(const aDate: TDateTime; const IsPrev: Boolean = False): TDateTime;
    function pm_GetCaption: AnsiString;
    function pm_GetDay: Word;
    function pm_GetPeriodicity: TddSchedulerTaskPeriodicity;
    function pm_GetPrevFullDateTime(NearDate: TDateTime): TDateTime;
    function pm_GetSubTaskType(Index: Integer): TddCalendarTaskType;
    function pm_GetSubTaskCount: Integer;
    function pm_GetTaskDate: TDateTime;
    function pm_GetTaskTime: TDateTime;
    function pm_GetTaskType: TddCalendarTaskType;
    function pm_GetWrongDays: TddSchedulerDays;
            procedure pm_SetCaption(const aValue: AnsiString);
    procedure pm_SetDay(const aValue: Word);
    procedure pm_SetIsChanged(const Value: Boolean);
    procedure pm_SetPeriodicity(const Value: TddSchedulerTaskPeriodicity);
    procedure pm_SetTaskDate(const aValue: TDateTime);
    procedure pm_SetTaskTime(const aValue: TDateTime);
    procedure pm_SetTaskType(const aValue: TddCalendarTaskType);
    procedure pm_SetUID(const aValue: Integer);
    procedure pm_SetWrongDays(const aValue: TddSchedulerDays);
    procedure TypeChanged(aItem: TddBaseConfigItem; const aValue: TddConfigValue);
    procedure ClearSubTasks;
 protected
    procedure Cleanup; override;
    function GetNearestDateTime(const aNow: TDateTime): TDateTime; virtual;
 public
    constructor Create; overload; override;
    function Clone: Pointer;
    procedure AddExcludeDate(aTime, aDate: TDateTime; aIsTime, aIsDate:
            Boolean);
    procedure AddIncludeDate(aTime, aDate: TDateTime; aIsTime, aIsDate:
            Boolean);
    procedure Assign(P: TddSchedulerTask); //override;
    procedure DoChanged; override;
    procedure ChangeDate(const FromDate, ToDate: TDateTime);
    procedure DeleteExcludeDate(aDate: TDateTime);
    procedure DeleteIncludeDate(aDate: TDateTime);
    function Edit: Boolean;
    procedure Executed(aDateTime: TDateTime = 0);
    function IsExcludeDate(aDate: TDateTime): Boolean;
    function IsIncludeDate(aDate: TDateTime): Boolean;
    procedure LoadFrom(aStorage: IddConfigStorage; aAlias: AnsiString; aNumber: Integer);
    class function MakeFrom(aStorage: IddConfigStorage; aAlias: AnsiString; aNumber:
        Integer): TddSchedulerTask;
    procedure SaveTo(aStorage: IddConfigStorage; aAlias: AnsiString);
    function ValidDate(const aDate: TDateTime; const IncludeDaily: Boolean =
            True): Boolean;
    property Caption: AnsiString read pm_GetCaption write pm_SetCaption;
    property Day: Word read pm_GetDay write pm_SetDay;
    property Deleted: Boolean read f_Deleted write f_Deleted;
    property ExecuteResult: TddSchedulerTaskResult read f_ExecuteResult write f_ExecuteResult;
    property ExcludeDates[Index: Integer]: TddSchedulerTime read
            GetExcludeDates;
    property ExcludeDatesCount: Integer read GetExcludeDatesCount;
    property ExecuteByTimer: Boolean read f_ExecuteByTimer write f_ExecuteByTimer;
    property FullDateTime[NearDate: TDateTime]: TDateTime read GetFullDateTime;
    property IncludeDates[Index: Integer]: TddSchedulerTime read
            GetIncludeDates;
    property IncludeDatesCount: Integer read GetIncludeDatesCount;
    property IsChanged: Boolean read f_IsChanged write pm_SetIsChanged;
    property Master: TddSchedulerTask read f_Master write f_Master;
    property Params: TddAppConfigNode read f_Params;
    property Periodicity: TddSchedulerTaskPeriodicity read pm_GetPeriodicity write pm_SetPeriodicity;
    property PrevFullDateTime[NearDate: TDateTime]: TDateTime read pm_GetPrevFullDateTime;
    property SubTaskType[Index: Integer]: TddCalendarTaskType read pm_GetSubTaskType;
    property SubTaskCount: Integer read pm_GetSubTaskCount;
    property TaskDate: TDateTime read pm_GetTaskDate write pm_SetTaskDate;
    property TaskTime: TDateTime read pm_GetTaskTime write pm_SetTaskTime;
    property TaskType: TddCalendarTaskType read pm_GetTaskType write pm_SetTaskType;
    property UID: Integer read f_UID write pm_SetUID;
    property WrongDays: TddSchedulerDays read pm_GetWrongDays write pm_SetWrongDays;
    property NextScheduledTime: TDateTime read f_NextScheduledTime write f_NextScheduledTime;
  end;

  TddTaskColor = procedure (aTaskID: TddCalendarTaskType; out aColor: TColor) of object;

  TddSchedulerTaskHandler = procedure (const aTask: TddSchedulerTask) of object;

  PddSchedulerTaskHandlerRec = ^TddSchedulerTaskHandlerRec;
  TddSchedulerTaskHandlerRec = record
   rTaskType: TddCalendarTaskType;
   rHandler : TddSchedulerTaskHandler;
  end;

  TddSchedulerCanRunTaskHandler = procedure (const aTask: TddSchedulerTask; var CanRun: Boolean) of object;

  PddSchedulerCanRunTaskHandlerRec = ^TddSchedulerCanRunTaskHandlerRec;
  TddSchedulerCanRunTaskHandlerRec = record
   rTaskType: TddCalendarTaskType;
   rHandler : TddSchedulerCanRunTaskHandler;
  end;

  TddScheduler = class(Tl3Base)
  private
    f_OnChangeTask: TNotifyEvent;
    f_OnTaskColor: TddTaskColor;
    f_Tasks: Tl3ObjectRefList;
    f_Timer: Tl3Timer;
    f_ExecuteHandlerList: Tl3RecList;
    f_ChangeHandlerList: Tl3RecList;
    f_CanRunHandlerList: Tl3RecList;
    f_IsChanged: Boolean;
    f_DisableCounter: Integer;
    f_DelayedTasks: Tl3ObjectRefList;
    f_TaskQueue: TObjectList;
    f_BusyCounter: Integer;
    f_Running: Boolean;
    f_NeedRecalc: Boolean;
    f_FromTimer: Boolean;
    f_FakeSubTask: TddSchedulerTask;
    procedure AddHandler(aList: Tl3RecList; aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
    function ColorOnID(aTaskType: TddCalendarTaskType): TColor;
    procedure DelHandler(aList: Tl3RecList; aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
    function ExecuteTask(const aTask: TddSchedulerTask; aWithSubTasks, AllowDelay, AskForExecution: Boolean): TddSchedulerTaskResult;
    procedure DelayTask(const aTask: TddSchedulerTask);
    function GetCount: Integer;
    function GetTasks(Index: Integer): TddSchedulerTask;
    function GetUID: Integer;
    procedure SetTaskList(const Value: Tl3ObjectRefList);
    procedure _OnTimer(Sender: TObject);
    procedure DoLocalTimeChange(Sender: TObject);
    function FindHandler(aList: Tl3RecList; aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler): Integer;
    function FindCanRunHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerCanRunTaskHandler): Integer;
    function GetTaskHandler(aTaskType: TddCalendarTaskType; out theHandler: TddSchedulerTaskHandler): Boolean;
    function GetCanRunTaskHandler(aTaskType: TddCalendarTaskType; out theHandler: TddSchedulerCanRunTaskHandler): Boolean;
    procedure pm_SetIsChanged(const Value: Boolean);
    procedure ReFillTaskQueue(aNow: TDateTime; aList: TObjectList = nil);
    procedure ProcessTaskQueue(aNow: TDateTime);
    procedure DeleteOutdatedTasks(aNow: TDateTime; aThreshold: TDateTime);
    function GetFirstSheduledTask: TddSchedulerTask;
    procedure Restart;
    procedure BeginWork;
    procedure EndWork;
    function IsInWork: Boolean;
    procedure DoDoLocalTimeChange(aFromTimer: Boolean);
    function CanRunTask(const aTask: TddSchedulerTask; aWithSubTasks: Boolean): Boolean;
    function GetFakeSubTask(const aParent: TddSchedulerTask; aTaskType: TddCalendarTaskType): TddSchedulerTask;
  protected
    procedure Cleanup; override;
  public
    constructor Create; override;
    function AddTask(aTask: TddSchedulerTask): TddSchedulerTask; overload;

    procedure AddExecuteHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
    procedure DelExecuteHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
    procedure AddChangeHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
    procedure DelChangeHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
    procedure AddCanRunHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerCanRunTaskHandler);
    procedure DelCanRunHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerCanRunTaskHandler);
    procedure CheckDelayedTasks;

    procedure Assign(P: TddScheduler); //override;
    procedure PostChanges;
    procedure DeleteTask(aUID: Integer); overload;
    procedure DeleteTask(aTask: TddSchedulerTask); overload;
    procedure NotifyTaskEdited(aTask: TddSchedulerTask);
    procedure FillListOnDate(const aDate: TDateTime; aList: Tl3ObjectRefList; const ShowDaily: Boolean = False);
    procedure FillMonthList(const aDate: TdateTime; aList: Tl3ObjectRefList; const ShowDaily: Boolean = False);
    procedure GetListOnDate(const aDate: TDateTime; aList: Tl3ObjectRefList);
    procedure FillTaskListDescription(aNow: TDateTime; const aList: TStrings; MaxCount: Integer = 5);
    function GetTaskByTaskType(aTaskType: TddCalendarTaskType): TddSchedulerTask;
    function GetTaskByUID(aUID: Integer): TddSchedulerTask;
    function IsRequredViolated(var theExplanation: AnsiString): Boolean;
    procedure LoadFrom(aStorage: IddConfigStorage; aAlias: AnsiString); overload;
    procedure Run(aNow: TDateTime = 0);
    procedure SaveTo(aStorage: IddConfigStorage; aAlias: AnsiString); overload;
    procedure Stop;
    function TaskDescription(aTask: TddSchedulerTask; aDate: TDateTime): AnsiString;
    procedure DisableSchedule;
    procedure EnableSchedule;
    function ScheduleEnabled: Boolean;
    function HasTaskExecutedByTimer: Boolean;
    property Count: Integer read GetCount;
    property OnChangeTask: TNotifyEvent read f_OnChangeTask write
            f_OnChangeTask;
    property OnTaskColor: TddTaskColor read f_OnTaskColor write f_OnTaskColor;
    property IsChanged: Boolean read f_IsChanged write pm_SetIsChanged;
    property TaskList: Tl3ObjectRefList read f_Tasks write SetTaskList;
    property Tasks[Index: Integer]: TddSchedulerTask read GetTasks;
  end;

const
 TaskTypeNames : array [TddSchedulerTaskPeriodicity] of String =
    ('Один раз', 'Каждый день', 'Каждую неделю', 'Каждый месяц', 'Каждый год', 'Каждые N минут');

 Repetitive = [stEveryDay, stEveryWeek, stEveryMonth, stEveryYear, stEveryMinutes];
 MagicEpsilon = 500;
 c_SchedulerTaskAlias = 'SchedulerTask';

implementation

Uses
 Types, SysUtils, l3ProcessingEnabledService,
 ShedulPanel, ddExceptionHandler,
 l3Types, l3String, l3TypedIntegerValueMap,
 ddAppConfigStrings, l3Interfaces, ddAppConfigUtils, ddAppConfigDates, l3Bits, Dialogs,
 ddAppConfigDataAdapters, ddAppConfigLists, ddSchedulerConfigTypes;

const
 cResetSchedulerThreshold = 0.5; // 12 часов. Интервал при котором шедулер перестартует нафиг. 

function SchedulerTimeToDateTime(const ST: TddSchedulerTime; const DT: TDateTime): TDateTime;
begin
 Result:= DT;
 if ST.IsDate then
  ReplaceDate(Result, ST.DateTime);
 if ST.IsTime then
  ReplaceTime(Result, ST.DateTime);
end;

type
  TTaskRec = record
    ID: Integer;
    Caption: ShortString;
    Periodicity: Integer;
    DateTime: TDateTime;
    Day: Word;
  end;

  TTimeRec = record
    DateTime: TDateTime;
    IsTime: Boolean;
    IsDate: Boolean;
  end;

const
 schTypeID : Tl3ValueMapID = (rName : 'Тип задания'; rID : 1);
 schPereodicity : Tl3ValueMapID = (rName : 'Переодичность'; rID : 2);


function CalendarEventsNames: TStringDynArray;
var
 i: TddCalendarTaskType;
begin
 SetLength(Result, Ord(High(TddCalendarTaskType))+1);
 for i:= Low(TddCalendarTaskType) to High(TddCalendarTaskType) do
  if i in ddEnabledTasks then
   Result[Ord(i)]:= ddCalendarEventArray[i].Caption;
end;


constructor TddSchedulerTask.Create;
begin
 inherited Create;
 FExcludeDates:= Tl3ObjectRefList.Make;
 FIncludeDates:= Tl3ObjectRefList.Make;
 ExecuteByTimer:= True;
 CreateParams;
end;

function TddSchedulerTask.Clone: Pointer;
type
 RddSchedulerTask = class of TddSchedulerTask;
begin
 Result := RddSchedulerTask(ClassType).Create;
 TddSchedulerTask(Result).Assign(Self);
end;

procedure TddSchedulerTask.AddExcludeDate(aTime, aDate: TDateTime; aIsTime,
        aIsDate: Boolean);
var
  l_DT: TddSchedulerTime;
begin
  DeleteIncludeDate(aDate);
  l_DT:= TddSchedulerTime.Create;
  try
   ReplaceDate(aTime, aDate);
   l_DT.DateTime:= aTime;
   l_DT.IsDate:= aIsDate;
   l_DT.IsTime:= aIsTime;
   fExcludeDates.Add(l_DT);
  finally
   L3Free(l_DT);
  end;
end;

procedure TddSchedulerTask.AddIncludeDate(aTime, aDate: TDateTime; aIsTime,
        aIsDate: Boolean);
var
  l_DT: TddSchedulerTime;
begin
  DeleteExcludeDate(aDate);
  l_DT:= TddSchedulerTime.Create;
  try
   ReplaceDate(aTime, aDate);
   l_DT.DateTime:= aTime;
   l_DT.IsDate:= aIsDate;
   l_DT.IsTime:= aIsTime;
   fIncludeDates.Add(l_DT);
  finally
   L3Free(l_DT);
  end;
end;

procedure TddSchedulerTask.Assign(P: TddSchedulerTask);
var
 l_ST: TddSchedulerTask absolute P;
begin
 if P is TddSchedulerTask then
 begin
  f_UID:= l_ST.UID;
  f_Deleted:= l_ST.Deleted;
  f_IsChanged := l_ST.IsChanged;
  f_ExecuteByTimer:= l_ST.ExecuteByTimer;
  AssignExcludeDates(l_St);
  AssignIncludeDates(l_St);
  f_Params.Assign(l_ST.Params);
 end
 else
  inherited;
end;

procedure TddSchedulerTask.AssignExcludeDates(aSource: TddSchedulerTask);
var
 i: Integer;
 l_T: TddSchedulerTime;
begin
 FExcludeDates.Clear;
 for i:= 0 to Pred(aSource.ExcludeDatesCount) do
 begin
  l_T:= TddSchedulerTime.Create;
  try
   l_T.Assign(aSource.ExcludeDates[i]);
   fExcludedates.Add(l_T);
  finally
   l3Free(l_T);
  end;
 end;
end;

procedure TddSchedulerTask.AssignIncludeDates(aSource: TddSchedulerTask);
var
 i: Integer;
 l_T: TddSchedulerTime;
begin
 FIncludeDates.Clear;
 for i:= 0 to Pred(aSource.IncludeDatesCount) do
 begin
  l_T:= TddSchedulerTime.Create;
  try
   l_T.Assign(aSource.IncludeDates[i]);
   fIncludedates.Add(l_T);
  finally
   l3Free(l_T);
  end;
 end;
end;

procedure TddSchedulerTask.DoChanged;
begin
 f_IsChanged := True;
 f_Params.Changed:= True;
end;

procedure TddSchedulerTask.ChangeDate(const FromDate, ToDate: TDateTime);
begin
  if ValidDate(FromDate) and (CompareDate(FromDate, ToDate) <> EqualsValue) then
  begin
   AddExcludeDate(FromDate, FromDate, True, True);
   AddIncludeDate(ToDate, ToDate, True, True);
  end; // if ValidDate(FromDate)
end;

procedure TddSchedulerTask.Cleanup;
begin
 DestroyParams;
 l3Free(FExcludeDates);
 l3Free(FIncludeDates);
 inherited;
end;

procedure TddSchedulerTask.CreateParams;
var
 l_CI: TddContainerConfigItem;
 l_List: TddSimpleListConfigItem;
 l_I, l_I2: TddBaseConfigItem;
 l_Map: TddCalendarEventsMap;
 l_DefValue: TddConfigValue;
begin
 l_DefValue:= ddEmptyIntValue;
 l_DefValue.AsInteger:= 1;
 f_Params:= TddAppConfigNode.Create(c_SchedulerTaskAlias, 'Назначенное задание');
 with f_Params do
 begin
  LabelTop:= False;

  l_I:= AddItem(TddStringConfigItem.Make('Caption', 'Описание'));
  l_I.Required:= True;
  l_I.OnNotify:= TypeChanged;
  l_Map:= TddCalendarEventsMap.Make;
  try
   l_I2:= AddItem(TddComboBoxConfigItem.Create('Type', 'Тип', MakeIntValue(-1), l_Map));
   l_I2.Required:= True;
   l_I2.AddNotify(l_I);
   AddItem(TddTimeConfigItem.Create('Time', 'Время', ddEmptyValue));

   l_CI:= TddContainerConfigItem.SimpleCreate('Periodicity', 'Когда');
    l_CI.Labeled:= False;
    l_CI.AddCase('Один раз');
     l_CI.Add(TddDateConfigItem.Create('Date', 'Дата', ddEmptyDateValue));
    l_CI.AddCase('Каждый день');
     // Добавить TCheckBox для дней недели, чтобы выбрать запрещенный день
     l_CI.Add(TddWeekDaysCheckListItem.Make('WrongDays', 'Кроме', ddEmptyIntValue));
    l_CI.AddCase('Каждую неделю');
     // Добавить TComboBox с днями недели
     l_CI.Add(TddWeekDayCombo.Make('WeekDay', 'по', l_DefValue, 2));
    l_CI.AddCase('Каждый месяц');
     // Добавить TComboBox с днями месяца
     l_CI.Add(TddMonthDayCombo.Make('MonthDay', '', l_DefValue, 2));
    l_CI.AddCase('Каждый год');
     // Добавить TComboBox с днями месяца
     l_CI.Add(TddMonthDayCombo.Make('YearDay', '' , l_DefValue, 1));
     // Добавить TComboBox с месяцами
     l_CI.Add(TddMonthsCombo.Make('YearMonth', '', l_DefValue, 1));
    l_CI.AddCase('Каждые N минут');
     // Добавить TIntegerItem для редактирования минут
     l_CI.Add(TddIntegerConfigItem.CreateItem('Minutes', 'каждые|минут', 30));
     l_CI.Add(TddDateConfigItem.Create('emDate', 'Начиная с', ddEmptyDateValue));
   AddItem(l_CI);
   {$IFDEF NestedTasks}
   l_List:= TddSimpleListConfigItem.Make(NestedAlias, 'Список вложенных заданий');
   l_I2:= l_List.Config.AddItem(TddComboBoxConfigItem.Create('Type', 'Тип', MakeIntValue(-1), l_Map));
   l_I2.Required:= True;
   AddItem(l_List);
   {$ENDIF}
  finally
   l3Free(l_Map);
  end;
 end;
end;

procedure TddSchedulerTask.DeleteExcludeDate(aDate: TDateTime);
var
  i: Integer;
begin
  for i:= 0 to Pred(ExcludeDatesCount) do
   if CompareDate(ExcludeDates[i].DateTime, aDate) = EqualsValue then
   begin
    fExcludeDates.Delete(i);
    break;
   end;
end;

procedure TddSchedulerTask.DeleteIncludeDate(aDate: TDateTime);
var
  i: Integer;
begin
  for i:= 0 to Pred(IncludeDatesCount) do
   if CompareDate(IncludeDates[i].DateTime, aDate) = EqualsValue then
   begin
    fIncludeDates.Delete(i);
    break;
   end;
end;

procedure TddSchedulerTask.DestroyParams;
begin
 l3Free(f_Params);
end;

function TddSchedulerTask.Edit: Boolean;
begin
 repeat
  Result := ExecuteNodeDialog(f_Params, True);
  if Result then
  begin
   ExecuteByTimer:= ddCalendarEventArray[TaskType].ExecuteByTimer;
   { TODO -oДудко -cУлучшение : Нужно реализовать пометку измемений в процедуре ExecuteNodeDialog }
   Changed;
  end // Result
  else
   break
 until (Params.AsInteger['Type'] <> -1);
end;

procedure TddSchedulerTask.Executed(aDateTime: TDateTime = 0);
begin
 if aDateTime = 0 then
  aDateTime := Now;
end;

function TddSchedulerTask.GetExcludeDates(Index: Integer): TddSchedulerTime;
begin
  Result:= TddSchedulerTime(fExcludeDates.Items[Index]);
end;

function TddSchedulerTask.GetExcludeDatesCount: Integer;
begin
  try
   Result:= fExcludeDates.Count;
  except
   l3System.Msg2Log('уничтожен список "черных" дат');
   l3System.Msg2Log('Задача жива = '+BoolToStr(Self <> nil, True));
   Result:= 0;
  end;
end;

function TddSchedulerTask.GetFullDateTime(NearDate: TDateTime): TDateTime;
var
  i, l_Nearest, l_Inc: Integer;
  l_Delta, l_CurDelta: Int64;
  l_Valid: Boolean;
  l_DT, l_Next: TDateTime;
begin
  Result:= GetNearestdateTime(NearDate);
  l_Next:= Result;
  // Нужно проверить получившуюся дату на наличие в списках
  // запрещенных и разрешенных дат
  l_Valid:= IsValidDate(Result);
  if not l_Valid and (Periodicity in Repetitive) then
  begin
   l_Inc:= 0;
   while not l_Valid and (l_Inc <> 3) do
   begin
    l_Next:= NextDate(l_Next);
    l_Valid:= IsValidDate(l_Next);
    Inc(l_Inc);
   end; // not l_Valid and (l_Inc <> 3)
  end; // not l_IsValid and (and TaskType in Repetitive)
  if l_Valid then
   l_Delta:= SecondsBetween(NearDate, l_Next)
  else
  begin
   l_Delta:= High(l_Delta);
   Result:= GetNearestdateTime(NearDate);
  end;
  l_Nearest:= -1;
  for i:= 0 to Pred(IncludeDatesCount) do
  begin
   l_DT:= SchedulerTimeToDateTime(IncludeDates[i], NearDate{Result});
   if IsValidDate(l_DT) and (CompareDate(l_DT, NearDate) <> LessThanValue) then
   begin
    l_CurDelta:= SecondsBetween(NearDate{Result}, l_DT);
    if l_CurDelta < l_Delta then
    begin
     l_Nearest:= i;
     l_Delta:= l_CurDelta;
    end; // l_CurDelta <> l_Delta
   end; // IsValidDate(l_DT)
  end; // for i
  if l_Nearest <> -1 then
   Result:= SchedulerTimeToDateTime(IncludeDates[l_Nearest], Result)
  else
   Result:= l_Next;
end;

function TddSchedulerTask.GetIncludeDates(Index: Integer): TddSchedulerTime;
begin
  Result:= TddSchedulerTime(fIncludeDates.Items[Index]);
end;

function TddSchedulerTask.GetIncludeDatesCount: Integer;
begin
  Result:= fIncludeDates.Count;
end;

function TddSchedulerTask.GetNearestDateTime(const aNow: TDateTime): TDateTime;
var
  l_D, l_M, l_Y: Word;
  l_Div, l_Mod: Integer;
begin
  Result:= TaskTime;
   case Periodicity of
    stOnce       :
     begin
      ReplaceDate(Result, TaskDate);
     end;
    stEveryDay   :
     begin
       ReplaceDate(Result, aNow);
       if CompareTime(TaskTime, TimeOf(aNow)) = LessThanValue then
        Result:= IncDay(Result);
        while TddSchedulerDayOfWeek(DayOfTheWeek(Result)) in WrongDays do
         Result := IncDay(Result);
     end;
    stEveryWeek  :
     begin
      ReplaceDate(Result, DateOf(aNow));
      Result:= IncDay(Result, Day - DayOfTheWeek(DateOf(aNow)));
      if CompareDateTime(Result, aNow) = LessThanValue then
       Result:= IncDay(Result, 7);
     end;
    stEveryMonth :
     begin
      Decodedate(DateOf(aNow), l_Y, l_M, l_D);
      ReplaceDate(Result, EncodeDate(l_Y, l_M, Max(1, Params.AsInteger['MonthDay'])));
      if CompareDateTime(Result, aNow) = LessThanValue then
       Result:= IncMonth(Result);
     end;
    stEveryYear  :
     begin
      ReplaceDate(Result, EncodeDate(YearOf(DateOf(aNow)), Max(1, Params.AsInteger['YearMonth']), Max(1, Params.AsInteger['YearDay'])));
      if CompareDateTime(Result, aNow) = LessThanValue then
       Result:= IncYear(Result);
     end;
    stEveryMinutes:
     begin
      // TaskTime - это нулевая точка отсчета
      ReplaceDate(Result, DateOf(Params.Asdatetime['emDate']));
      l_Div:= MinutesBetween(aNow, Result) div Params.AsInteger['Minutes'];
      if CompareDateTime(aNow, IncMinute(Result, l_Div*Params.AsInteger['Minutes'])) = GreaterThanValue then
       Inc(l_Div);
      Result:= IncMinute(Result, l_Div*Params.AsInteger['Minutes']);
     end
    else
     Result:= aNow;
   end;
end;

function TddSchedulerTask.IsExcludeDate(aDate: TDateTime): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i:= 0 to Pred(ExcludeDatesCount) do
   if CompareDate(ExcludeDates[i].DateTime, aDate) = EqualsValue then
   begin
    Result:= True;
    break;
   end;
end;

function TddSchedulerTask.IsIncludeDate(aDate: TDateTime): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i:= 0 to Pred(IncludeDatesCount) do
   if CompareDate(IncludeDates[i].DateTime, aDate) = EqualsValue then
   begin
    Result:= True;
    break;
   end;
end;

function TddSchedulerTask.IsValidDate(const aDate: TDateTime): Boolean;
var
  i: Integer;
begin
 Result:= not Deleted;
 if Result then
  for i:= 0 to Pred(ExcludeDatesCount) do
  begin
   if CompareDateTime(aDate, SchedulerTimeToDateTime(ExcludeDates[i], aDate)) = EqualsValue then
   begin
    Result:= False;
    break;
   end; // CompareDateTime(Result, l_SDT) = EqualsValue
  end; // for i
end;

procedure TddSchedulerTask.LoadFrom(aStorage: IddConfigStorage; aAlias: AnsiString; aNumber: Integer);
var
 k: Integer;
 j: Integer;
 l_DateTime: TDateTime;
 l_DayOW: TddSchedulerDayOfWeek;
 l_Section: AnsiString;
 l_IsTime: Boolean;
 l_IsDate: Boolean;
 l_NumStr: AnsiString;
 l_TempTaskType: Integer;
 l_WrongDays: TddSchedulerDays;
begin
 UID:= aNumber;
 params.Load(aStorage);
 
 with aStorage do
 begin
  Section:= PArams.Alias;
  Deleted:= ReadBool('Deleted', False);
  l_Section:= Format('ExcludeList.%d', [aNumber]);
  Section:= l_Section;
  k:= ReadInteger('Count', 0);
  for j:= 0 to Pred(k) do
  begin
   l_DateTime:= ReadDateTime('Time.'+IntToStr(j), 0);
   l_IsTime:= ReadBool('IsTime.'+IntToStr(j), False);
   l_IsDate:= ReadBool('IsDate.'+IntToStr(j), False);
   AddExcludeDate(TimeOf(l_DateTime), Dateof(l_DateTime), l_IsTime, l_IsDate);
  end; // for j

  l_Section:= Format('IncludeList.%d', [aNumber]);
  Section:= l_Section;
  k:= ReadInteger('Count', 0);
  for j:= 0 to Pred(k) do
  begin
   l_DateTime:= ReadDateTime('Time.'+IntToStr(j), 0);
   l_IsTime:= ReadBool('IsTime.'+IntToStr(j), False);
   l_IsDate:= ReadBool('IsDate.'+IntToStr(j), False);
   AddIncludeDate(TimeOf(l_DateTime), Dateof(l_DateTime), l_IsTime, l_IsDate);
  end; // for j
 end; // with aStorage;
end;

class function TddSchedulerTask.MakeFrom(aStorage: IddConfigStorage; aAlias:
    String; aNumber: Integer): TddSchedulerTask;
begin
 Result := Create;
 try
  Result.LoadFrom(aStorage, aAlias, aNumber);
  if //Result.Deleted or
     ((Result.Periodicity = stOnce) and (CompareDate(Result.FullDateTime[Now], Now) = LessThanValue)) then
  begin
   l3Free(Result);
  end;
 except
  l3Free(Result);
 end;
end;

function TddSchedulerTask.NestedAlias: AnsiString;
begin
 Result := Format('Nested%d', [f_UID]);
end;

function TddSchedulerTask.NextDate(const aDate: TDateTime; const IsPrev: Boolean = False): TDateTime;
var
 l_Modifier: Integer;
begin
 l_Modifier:= IfThen(IsPrev, -1, 1);
  case Periodicity of
   stEveryDay :
    begin
      if SizeOf(WrongDays) = 7 then
       Result := Yesterday
      else
      begin
       Result:= IncDay(aDate, l_Modifier);
       while TddSchedulerDayOfWeek(DayOfTheWeek(Result)) in WrongDays do
        Result := IncDay(Result, l_Modifier);
      end;
    end;
   stEveryWeek: Result:= IncDay(aDate, 7*l_Modifier);
   stEveryMonth: Result:= IncMonth(aDate, l_Modifier);
   stEveryYear: Result:= IncYear(aDate, l_Modifier);
   stEveryMinutes: Result:= IncMinute(aDate, l_Modifier*f_Params.AsInteger['Minutes']);
  else
   Result:= aDate
  end;
end;

function TddSchedulerTask.pm_GetCaption: AnsiString;
begin
 Result := Params.AsString['Caption'];
end;

function TddSchedulerTask.pm_GetDay: Word;
begin
 Result := Succ(Params.AsInteger['WeekDay']);
end;

function TddSchedulerTask.pm_GetPeriodicity: TddSchedulerTaskPeriodicity;
begin
 Result := TddSchedulerTaskPeriodicity(f_Params.AsInteger['Periodicity']);
end;

function TddSchedulerTask.pm_GetPrevFullDateTime(NearDate: TDateTime):
    TDateTime;
var
  i, l_Nearest, l_Inc: Integer;
  l_Delta, l_CurDelta: LongInt;
  l_Valid: Boolean;
  l_DT, l_Prev: TDateTime;
begin
 Result:= GetNearestdateTime(NearDate);
 if (Periodicity in Repetitive) then
  Result:= NextDate(Result, True);
 l_Prev:= Result;
 // Нужно проверить получившуюся дату на наличие в списках
 // запрещенных и разрешенных дат
 l_Valid:= IsValidDate(Result);
 if not l_Valid and (Periodicity in Repetitive) then
 begin
  l_Inc:= 0;
  while not l_Valid and (l_Inc <> 3) do
  begin
   l_Prev:= NextDate(l_Prev, True);
   l_Valid:= IsValidDate(l_Prev);
   Inc(l_Inc);
  end; // not l_Valid and (l_Inc <> 3)
 end; // not l_IsValid and (and TaskType in Repetitive)

 if l_Valid then
  l_Delta:= SecondsBetween(l_Prev, NearDate)
 else
 begin
  l_Delta:= High(l_Delta);
  Result:= GetNearestdateTime(NearDate);
 end;
 // Проверка на то, есть ли дата выполнения ближе, чем получившаяся
 l_Nearest:= -1;
 for i:= 0 to Pred(IncludeDatesCount) do
 begin
  l_DT:= SchedulerTimeToDateTime(IncludeDates[i], NearDate{Result});
  if IsValidDate(l_DT) and (CompareDate(l_DT, Neardate) = LessThanValue)then
  begin
   l_CurDelta:= SecondsBetween(NearDate{Result}, l_DT);
   if l_CurDelta < l_Delta then
   begin
    l_Nearest:= i;
    l_Delta:= l_CurDelta;
   end; // l_CurDelta <> l_Delta
  end; // IsValidDate(l_DT)
 end; // for i
 if l_Nearest <> -1 then
  Result:= SchedulerTimeToDateTime(IncludeDates[l_Nearest], Result)
 else
  Result:= l_Prev;
end;

function TddSchedulerTask.pm_GetSubTaskType(Index: Integer): TddCalendarTaskType;
begin
 Result := TddCalendarTaskType((Params.AsObject[NestedAlias] as TddSimpleListDataAdapter).Values[Index, 'Type'].AsInteger);
end;

function TddSchedulerTask.pm_GetSubTaskCount: Integer;
begin
 Result := (Params.AsObject[NestedAlias] as TddSimpleListDataAdapter).Count;
end;

function TddSchedulerTask.pm_GetTaskDate: TDateTime;
begin
 Result := Params.AsDateTime['Date'];
end;

function TddSchedulerTask.pm_GetTaskTime: TDateTime;
begin
 Result := Params.AsDateTime['Time'];
end;

function TddSchedulerTask.pm_GetTaskType: TddCalendarTaskType;
begin
 Result := TddCalendarTaskType(f_Params.AsInteger['Type']);
end;

function TddSchedulerTask.pm_GetWrongDays: TddSchedulerDays;
var
 l_Day: TddSchedulerDayOfWeek;
 l_Value: Integer;
begin
 Result := [];
 l_Value:= f_Params.AsInteger['WrongDays'];
 for l_Day:= Low(TddSchedulerDayOfWeek) to High(TddSchedulerDayOfWeek) do
  if l3TestBit(l_value, Pred(Ord(l_Day))) then
   Include(Result, l_Day);
end;

procedure TddSchedulerTask.pm_SetCaption(const aValue: AnsiString);
begin
 Params.AsString['Caption']:= aValue;
end;

procedure TddSchedulerTask.pm_SetDay(const aValue: Word);
begin
 Params.AsInteger['WeekDay']:= Pred(aValue);
end;

procedure TddSchedulerTask.pm_SetIsChanged(const Value: Boolean);
begin
 if f_IsChanged <> Value then
 begin
  f_IsChanged := Value;
  Params.Changed:= Value;
 end; // f_IsChanged <> Value
end;

procedure TddSchedulerTask.pm_SetPeriodicity(const Value: TddSchedulerTaskPeriodicity);
begin
 f_Params.AsInteger['Periodicity']:= Ord(Value);
end;

procedure TddSchedulerTask.pm_SetTaskDate(const aValue: TDateTime);
begin
 Params.AsDateTime['Date'];
end;

procedure TddSchedulerTask.pm_SetTaskTime(const aValue: TDateTime);
begin
 Params.AsDateTime['Time']:= aValue;
end;

procedure TddSchedulerTask.pm_SetTaskType(const aValue: TddCalendarTaskType);
begin
 f_Params.AsInteger['Type']:= Ord(aValue);
 { TODO : Видимо, нужно сделать как отдельный параметр }
 ExecuteByTimer:= ddCalendarEventArray[aValue].ExecuteByTimer;
end;

procedure TddSchedulerTask.pm_SetUID(const aValue: Integer);
var
 l_Nested: TddBaseConfigItem;
begin
 l_Nested:= Params.ItemByAlias[NestedAlias];
 f_UID := aValue;
 Params.Alias:= c_SchedulerTaskAlias + IntToStr(UID);
 l_Nested.Alias:= NestedAlias;
end;

procedure TddSchedulerTask.pm_SetWrongDays(const aValue: TddSchedulerDays);
var
 l_Value: Integer;
 i: TddSchedulerDayOfWeek;
begin
 l_Value:= 0;
 for i:= Low(TddSchedulerDayOfWeek) to High(TddSchedulerDayOfWeek) do
  if i in aValue then
   l3SetBit(l_Value, Succ(Ord(i)));
 f_Params.AsInteger['WrongDays']:= l_Value;
end;

procedure TddSchedulerTask.SaveTo(aStorage: IddConfigStorage; aAlias: AnsiString);
(*
var
  
  l_Day : TddSchedulerDayOfWeek;
  l_Task: TddSchedulerTask;

  l_DateTime: TDateTime;
*)
var
 l_Section: AnsiString;
 j: Integer;
begin
 //if not Deleted then
 begin
  Params.Save(aStorage);
  // Сохраняем списки исключений-включений
  with aStorage do
  begin
   try
    Section:= Params.Alias;
    WriteBool('Deleted', Deleted);
    l_Section:= Format('ExcludeList.%d', [uid]);
    Section:= l_Section;
    WriteInteger('Count', ExcludeDatesCount);
    for j:= 0 to Pred(ExcludeDatesCount) do
    begin
     WriteDateTime('Time.'+IntToStr(j), ExcludeDates[j].DateTime);
     WriteBool('IsTime.'+IntToStr(j), ExcludeDates[j].IsTime);
     WriteBool('IsDate.'+IntToStr(j), ExcludeDates[j].IsDate);
    end; // for j

    l_Section:= Format('IncludeList.%d', [uid]);
    Section:= l_Section;
    WriteInteger('Count', IncludeDatesCount);
    for j:= 0 to Pred(IncludeDatesCount) do
    begin
     WriteDateTime('Time.'+IntToStr(j), IncludeDates[j].DateTime);
     WriteBool('IsTime.'+IntToStr(j), IncludeDates[j].IsTime);
     WriteBool('IsDate.'+IntToStr(j), IncludeDates[j].IsDate);
    end; // for j
   except
    l3System.Msg2Log(Format('Ошибка записи задания №%d', [uid]));
   end; // try.. except for i
  end; // with aStorage
 end // not Deleted
 //else
 //
end;

procedure TddSchedulerTask.TypeChanged(aItem: TddBaseConfigItem; const aValue: TddConfigValue);
begin
 aItem.StringValue:= ddCalendarEventArray[TddCalendarTaskType(aValue.AsInteger)].Caption;
 Params.AsInteger['Periodicity']:= ddCalendarEventArray[TddCalendarTaskType(aValue.AsInteger)].DefaultRep;
 case Params.AsInteger['Periodicity'] of
  repeatOnce: Params.AsDateTime['Date']:= Now;
  repeatEveryweek: Params.AsInteger['WeekDay']:= Pred(DayOfTheWeek(Now));
 end;
end;

function TddSchedulerTask.ValidDate(const aDate: TDateTime; const IncludeDaily:
        Boolean = True): Boolean;
var
  l_DateTime: TDateTime;
begin
 l_DateTime:= FullDateTime[aDate];
 Result:= (CompareDate(aDate, l_DateTime) = EqualsValue) and not Deleted;
 if Result and not IncludeDaily and (Periodicity = stEveryDay) then
  Result:= IsIncludeDate(l_DateTime);
end;

{
********************************* TddScheduler *********************************
}
constructor TddScheduler.Create;
begin
  inherited Create;
  f_Timer:= Tl3Timer.Create;
  f_Timer.Interval:= 0;
  f_Timer.Enabled:= False;
  f_Timer.OnTimer:= _OnTimer;
  f_Timer.OnLocalTimeChange := DoLocalTimeChange;
  f_Tasks := Tl3ObjectRefList.Make;
  f_DelayedTasks := Tl3ObjectRefList.Make;
  f_TaskQueue := TObjectList.Create(True);
  f_ExecuteHandlerList := Tl3RecList.Create(SizeOf(TddSchedulerTaskHandlerRec));
  f_ChangeHandlerList := Tl3RecList.Create(SizeOf(TddSchedulerTaskHandlerRec));
  f_CanRunHandlerList := Tl3RecList.Create(SizeOf(TddSchedulerCanRunTaskHandlerRec));
  f_IsChanged := False;
end;

function TddScheduler.AddTask(aTask: TddSchedulerTask): TddSchedulerTask;
begin
 aTask.UID:= GetUID;
 f_Tasks.Add(aTask);
 Result:= Tasks[Pred(Count)];
end;

procedure TddScheduler.AddExecuteHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
begin
 AddHandler(f_ExecuteHandlerList, aTaskType, aTaskHandler);
end;

procedure TddScheduler.AddChangeHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
begin
 AddHandler(f_ChangeHandlerList, aTaskType, aTaskHandler);
end;

procedure TddScheduler.AddHandler(aList: Tl3RecList; aTaskType: TddCalendarTaskType; aTaskHandler:
    TddSchedulerTaskHandler);
var
 l_Rec: TddSchedulerTaskHandlerRec;
begin
 if FindHandler(aList, aTaskType, aTaskHandler) < 0 then
 begin
  l_Rec.rTaskType := aTaskType;
  l_Rec.rHandler := aTaskHandler;
  aList.Add(l_Rec);
 end;
end;

procedure TddScheduler.Assign(P: TddScheduler);
var
  l_S: TddScheduler absolute P;
  i: Integer;
  l_T: TddSchedulerTask;
begin
  if P is TddScheduler then
  begin
   TaskList.Clear;
   for i:= 0 to Pred(l_S.Count) do
   begin
    l_T:= (l_S.tasks[i] As TddSchedulerTask).Clone;
    try
     TaskList.Add(l_T);
    finally
     l3Free(l_T);
    end;
   end;
   IsChanged := l_S.IsChanged;
   Restart;
  end
  else
   inherited;
end;

procedure TddScheduler.PostChanges;

 function TaskIterator(aData: Pointer; anIndex: Integer): Boolean;
 var
  l_Task: TddSchedulerTask;

  function CheckHandler(aData: Pointer; anIndex: Integer): Boolean;
  var
   l_HandlerRec: PddSchedulerTaskHandlerRec;
  begin
   Result := True;
   l_HandlerRec := PddSchedulerTaskHandlerRec(aData^);
   if l_HandlerRec.rTaskType = l_Task.TaskType then
    l_HandlerRec.rHandler(l_Task);
  end;

 begin
  Result := True;
  l_Task := TddSchedulerTask(aData^);
  if l_Task.IsChanged then
  begin
   // задание было изменено, ищем обработчик и сбрасываем флаг (Зачем?)
   f_ChangeHandlerList.IterateAllF(l3L2IA(@CheckHandler));
   //l_Task.IsChanged := False;
  end;
 end;

begin
 TaskList.IterateAllF(l3L2IA(@TaskIterator));
end;

function TddScheduler.ColorOnID(aTaskType: TddCalendarTaskType): TColor;
begin
  if Assigned(f_OnTaskColor) then
   f_OnTaskColor(aTaskType, Result)
  else
   Result := clNavy;
end;

procedure TddScheduler.DeleteTask(aUID: Integer);
var
 i: Integer;
begin
 for i:= 0 to Pred(Count) do
  if Tasks[i].UID = aUID then
   DeleteTask(Tasks[i]);
end;

procedure TddScheduler.DeleteTask(aTask: TddSchedulerTask);
var
 l_Running: Boolean;
begin
 aTask.Deleted:= True;
 Restart;
end;

procedure TddScheduler.FillListOnDate(const aDate: TDateTime; aList: Tl3ObjectRefList; const ShowDaily: Boolean =
    False);
var
  i: Integer;
  l_D: TDateTypeObj;
begin
  for i:= 0 to Pred(Count) do
   if Tasks[i].ValidDate(aDate, ShowDaily) then
   begin
    { добавляем в список  aDate и Tasks[i].ID }
    l_D:= TDateTypeObj.Create(Tasks[i].FulldateTime[aDate], ColorOnID(Tasks[i].TaskType), Tasks[i].Caption);
    try
     aList.Add(l_D);
    finally
     l3Free(l_D);
    end;
   end;
end;

procedure TddScheduler.FillMonthList(const aDate: TdateTime; aList: Tl3ObjectRefList; const ShowDaily: Boolean = False);
var
  i: Integer;
  l_D: TDateTime;
begin
  aList.Clear;
  l_D:= StartOfTheMonth(aDate);
  for i:= 1 to DaysInMonth(aDate) do
  begin
   FillListOnDate(l_D, aList, ShowDaily);
   l_D:= IncDay(l_D);
  end;
end;

function TddScheduler.GetCount: Integer;
begin
  Result:= f_Tasks.Count;
end;

procedure TddScheduler.GetListOnDate(const aDate: TDateTime; aList: Tl3ObjectRefList);
var
  i: Integer;
begin
  for i:= 0 to Pred(Count) do
   if Tasks[i].ValidDate(aDate) then
     aList.Add(Tasks[i]);
end;

function TddScheduler.GetTaskByTaskType(aTaskType: TddCalendarTaskType): TddSchedulerTask;
var
 i: Integer;
 l_Task: TddSchedulerTask;
begin
  Result := nil;
  for i:= 0 to Pred(Count) do
  begin
   l_Task:= Tasks[i];
   if (l_Task.TaskType = aTaskType) and not l_Task.Deleted then
   begin
    Result:= l_Task;
    break;
   end;
  end;
end;

function TddScheduler.GetTasks(Index: Integer): TddSchedulerTask;
begin
  Result:= TddSchedulerTask(f_Tasks.Items[Index]);
end;

function TddScheduler.GetUID: Integer;
  
  function _Check(aUID: Integer): Boolean;
  var
   i: Integer;
  begin
   Result:= True;
   for i:= 0 to Pred(Count) do
    if Tasks[i].UID = aUID then
    begin
     Result:= False;
     break
    end;
  end;

begin
  Result:= 0;
  while not _Check(Result) do
   Inc(Result);
end;

procedure TddScheduler.LoadFrom(aStorage: IddConfigStorage; aAlias: AnsiString);
var
  i: Integer;
  l_Count: Integer;
  l_Task: TddSchedulerTask;
begin
 with aStorage do
 begin
  Section:= aAlias;
  l_Count:= ReadInteger('Count', 0); // Количество задач
  for i:= 0 to Pred(l_Count) do
  try
   Section:= aAlias;
   l_Task := TddSchedulerTask.MakeFrom(aStorage, aAlias, i);
   try
    if (l_Task <> nil) and (not l_Task.Deleted) then
     AddTask(l_Task);
   finally
    l3Free(l_Task);
   end;
  except
   l3System.Msg2Log(Format('Ошибка чтения задания №%d', [i]));
  end; // try.. except for i
 end;
 Restart;
end;

procedure TddScheduler.Cleanup;
begin
 l3Free(f_Timer);
 l3Free(f_Tasks);
 l3Free(f_TaskQueue);
 l3Free(f_DelayedTasks);
 l3Free(f_CanRunHandlerList);
 l3Free(f_ExecuteHandlerList);
 l3Free(f_ChangeHandlerList);
 l3Free(f_FakeSubTask);
 inherited;
end;

procedure TddScheduler.DelExecuteHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
begin
 DelHandler(f_ExecuteHandlerList, aTaskType, aTaskHandler);
end;

procedure TddScheduler.DelChangeHandler(aTaskType: TddCalendarTaskType; aTaskHandler: TddSchedulerTaskHandler);
begin
 DelHandler(f_ChangeHandlerList, aTaskType, aTaskHandler);
end;

procedure TddScheduler.DelHandler(aList: Tl3RecList; aTaskType: TddCalendarTaskType; aTaskHandler:
    TddSchedulerTaskHandler);
var
 l_Idx: Integer;
begin
 l_Idx := FindHandler(aList, aTaskType, aTaskHandler);
 if l_Idx >= 0 then
  aList.Delete(l_Idx);
end;

function TddScheduler.ExecuteTask(const aTask: TddSchedulerTask; aWithSubTasks, AllowDelay, AskForExecution: Boolean): TddSchedulerTaskResult;
(*
 function CheckHandler(aData: Pointer; anIndex: Integer): Boolean;
 var
  l_HandlerRec: PddSchedulerTaskHandlerRec;
 begin
  Result := True;
  l_HandlerRec := PddSchedulerTaskHandlerRec(aData^);
  if l_HandlerRec.rTaskType = aTask.TaskType then
   l_HandlerRec.rHandler(aTask);
 end;
*)

var
 I: Integer;
 l_SubTask: TddSchedulerTask;
 l_Handler: TddSchedulerTaskHandler;
 l_SubTaskType: TddCalendarTaskType;

begin
 BeginWork;
 try
  Result:= strFailed;
  if aTask.Deleted then
   Exit;
  if not ScheduleEnabled then
   DelayTask(aTask)
  else
  begin
   aTask.ExecuteResult := strFailed;
   if AskForExecution then
    if not CanRunTask(aTask, aWithSubTasks) then
    begin
     if AllowDelay then
      DelayTask(aTask);
     Exit;
    end;
   l3System.Msg2Log('Выполняется задача: %s, запланированная на %s', [aTask.Caption, DateTimeToStr(aTask.NextScheduledTime)]);
   // Маловероятно, что у задачи несколько обработчиков f_ExecuteHandlerList.IterateAllF(l3L2IA(@CheckHandler));
   if GetTaskHandler(aTask.TaskType, l_Handler) then
    l_Handler(aTask)
   else
    aTask.ExecuteResult := strOk;
   Result:= aTask.ExecuteResult;
   if Result = strOk then
   begin
    if (Result = strOk) and aWithSubTasks then
     for i:= 0 to Pred(aTask.SubTaskCount) do
     begin
      l_SubTaskType:= aTask.SubTaskType[i];
      if l_SubTaskType <> aTask.TaskType then
      begin
       l_SubTask := GetFakeSubTask(aTask, l_SubTaskType);
       if GetTaskHandler(l_SubTaskType, l_Handler) then
       begin
        l3System.Msg2Log('Выполняется связанная задача: %s', [ddCalendarEventArray[l_SubTaskType].Caption]);
        l_SubTask.ExecuteResult := strFailed;
        l_Handler(l_SubTask);
        if l_SubTask.ExecuteResult <> strOk then
        begin
         aTask.ExecuteResult := l_SubTask.ExecuteResult;
         Result:= aTask.ExecuteResult;
         break;
        end;
       end;
      end; // aTask.SubTaskType[i] <> aTask.TaskType
     end; // for i
   end; // Result
   if AllowDelay and (aTask.ExecuteResult = strRequestDelay) then
    DelayTask(aTask);
  end; // not ScheduleEnabled
 finally
  EndWork;
 end;
end;

function TddScheduler.FindHandler(aList: Tl3RecList; aTaskType: TddCalendarTaskType; aTaskHandler:
    TddSchedulerTaskHandler): Integer;
var
 l_Rec: TddSchedulerTaskHandlerRec;
begin
 l_Rec.rTaskType := aTaskType;
 l_Rec.rHandler := aTaskHandler;
 if not aList.FindPart(l_Rec, SizeOf(TddSchedulerTaskHandlerRec), Result) then
  Result := -1;
end;

function TddScheduler.GetTaskByUID(aUID: Integer): TddSchedulerTask;
var
  i: Integer;
begin
  Result := nil;
  for i:= 0 to Pred(Count) do
  begin
   if Tasks[i].UID = aUID then
   begin
    Result:= Tasks[i];
    break;
   end;
  end;
end;

function TddScheduler.GetTaskHandler(aTaskType: TddCalendarTaskType; out theHandler: TddSchedulerTaskHandler): Boolean;
var
 i: Integer;
 l_Handler: TddSchedulerTaskHandlerRec;

begin
 Result := False;
 for i:= 0 to f_ExecuteHandlerList.Hi do
 begin
  l_Handler:= PddSchedulerTaskHandlerRec(f_ExecuteHandlerList.ItemSlot(i))^;
  if l_Handler.rTaskType = aTaskType then
  begin
   theHandler:= l_Handler.rHandler;
   Result:= True;
   break;
  end; // l_Handler.rTaskType = aTaskType
 end; // for i
end;

function TddScheduler.IsRequredViolated(var theExplanation: AnsiString): Boolean;
var
 l_TT: TddCalendarTaskType;
 l_Idx: Integer;
 l_Found: Integer;

 function FindTask(aData: Pointer; aIndex: Integer): Boolean;
 var
  l_Task: TddSchedulerTask;
 begin
  Result := True;
  l_Task := TddSchedulerTask(aData^);
  Result := l_Task.TaskType <> l_TT;
  if not Result then
   l_Found := aIndex;
 end;

begin
 Result := False;
 theExplanation := '';
 for l_TT := Low(TddCalendarTaskType) to High(TddCalendarTaskType) do
 begin
  if ddCalendarEventArray[l_TT].Required then
  begin
   l_Found := -1;
   f_Tasks.IterateAllF(l3L2IA(@FindTask));
   if l_Found < 0 then // required задание не найдено
   begin
    if theExplanation <> '' then
     theExplanation := theExplanation + ', ';
    theExplanation := theExplanation + ddCalendarEventArray[l_TT].Caption;
   end;
  end;
 end;
 Result := theExplanation <> '';
end;

procedure TddScheduler.pm_SetIsChanged(const Value: Boolean);
var
 i: Integer;
begin
 if f_IsChanged <> Value then
 begin
  f_IsChanged:= Value;
  // Выставить всем задачам флаг Changed
  for i:= 0 to Pred(Count) do
   Tasks[i].IsChanged:= Value;
 end; // f_IsChanged <> Value
end;

function TddScheduler.TaskDescription(aTask: TddSchedulerTask; aDate: TDateTime): AnsiString;
var
  l_S: AnsiString;
  l_T: AnsiString;
  l_C: AnsiString;
  l_D: TDateTime;
begin
  l_S:= '';
  l_D:= aTask.FullDateTime[aDate];
  DateTimeToString(l_T, 'в hh:nn', l_D);
  if CompareDate(l_D, Now) = EqualsValue then
   l_C:= 'следующий запуск сегодня'
  else
  if CompareDate(Tomorrow, l_D) = EqualsValue then
   l_C:= 'следующий запуск завтра'
  else
   DateTimeToString(l_C, 'следующий запуск dd/mm/yy', l_D);
  case aTask.Periodicity of
   stOnce       :
    begin

    end;
   stEveryDay   :
    begin
    end;
   stEveryWeek  :
    begin
     case aTask.Day of
      1: l_S:= 'по понедельникам ';
      2: l_S:= 'по вторникам ';
      3: l_S:= 'по средам ';
      4: l_S:= 'по четвергам ';
      5: l_S:= 'по пятницам ';
      6: l_S:= 'по субботам ';
      7: l_S:= 'по воскресеньям ';
     end;
    end;
   stEveryMonth :
    begin
    end;
   stEveryYear  :
    begin
    end;
  end;
  Result:= Format('%s (%s %s%s, %s)', [aTask.Caption, TaskTypeNames[aTask.Periodicity], l_S, l_T, l_C]);
end;

procedure TddScheduler.Run(aNow: TDateTime = 0);
var
 l_Task: TddSchedulerTask;
 l_Day: AnsiString;
 l_RunTime: TDateTime;
begin
 BeginWork;
 try
  if aNow = 0 then
   aNow:= Now;

  Stop;
  f_Running := True;
  ReFillTaskQueue(aNow);
  if f_TaskQueue.Count = 0 then
   l3System.Msg2Log('Нет текущей задачи')
  else
  begin
   l_Task := GetFirstSheduledTask;
   case DaysBetween(aNow, l_Task.NextScheduledTime) of
    0: l_Day:= 'сегодня';
    1: l_Day:= 'завтра';
   else
    l_Day:= DateTimeToStr(l_Task.NextScheduledTime);
   end;

   l3System.Msg2Log('Следующая задача: %s, запуск %s', [l_Task.Caption, DateTimeToStr(l_Task.NextScheduledTime)]);
   if Assigned(f_OnChangeTask) then
     f_OnChangeTask(Self);

   l3System.Msg2Log('SCHEDUL ANOW = %s', [DateTimeToStr(aNow)], l3_msgLevel10);
   l3System.Msg2Log('SCHEDUL NOW = %s', [DateTimeToStr(Now)], l3_msgLevel10);

   if CompareDateTime(Now, l_Task.NextScheduledTime) = GreaterThanValue then
   begin
    l3System.Msg2Log('SCHEDUL immidiate %s', [DateTimeToStr(Now)]);
    _OnTimer(f_Timer);
   end
   else
   begin
    if CompareDateTime(Now, l_Task.NextScheduledTime) = GreaterThanValue then
     l3System.Msg2Log('SCHEDUL ASSERT next run time less then NOW');
    if Abs(Now - l_Task.NextScheduledTime) > 1 then
     f_Timer.Interval:= MillisecondsBetween(Now, Now + 1)
    else
     f_Timer.Interval:= MillisecondsBetween(Now, l_Task.NextScheduledTime)+MagicEpsilon;
    l_RunTime := l_Task.NextScheduledTime - Now;
    l3System.Msg2Log('SCHEDUL Будет запущена через %d дней %s', [Trunc(l_RunTime), TimeToStr(l_RunTime)], l3_msgLevel10);
    l3System.Msg2Log('SCHEDUL TASK DATE = %s', [DateTimeToStr(l_Task.NextScheduledTime)], l3_msgLevel10);
    f_Timer.Enabled:= True;
   end;
  end;
 finally
  EndWork;
 end;
end;

procedure TddScheduler.SaveTo(aStorage: IddConfigStorage; aAlias: AnsiString);
var
 i: Integer;
begin
  with aStorage do
  begin
   for i:= 0 to Pred(Count) do
   try
    Section:= aAlias;
    Tasks[i].SaveTo(aStorage, aAlias);
   except
    l3System.Msg2Log(Format('Ошибка записи задания №%d', [i]));
   end; // try.. except for i
   Section:= aAlias;
   WriteInteger('Count', Count); // Количество задач
  end;
end;

procedure TddScheduler.SetTaskList(const Value: Tl3ObjectRefList);
begin
  f_Tasks.Assign(Value);
  f_DelayedTasks.Clear;
end;

procedure TddScheduler.Stop;
begin
  f_Timer.Enabled:= False;
  f_TaskQueue.Clear;
  f_Running := False;
end;

procedure TddScheduler._OnTimer(Sender: TObject);
var
  l_Now: TDateTime;
begin
 BeginWork;
 try
  f_Timer.Enabled:= False;
  l_Now:= Now;
  if f_NeedRecalc then
   Exit;
  ProcessTaskQueue(l_Now);
  if f_NeedRecalc then
   Exit;
  Run(l_Now);
 finally
  EndWork;
 end;
end;

{
******************************* TddSchedulerTime *******************************
}
procedure TddSchedulerTime.Assign(P: TddSchedulerTime);
begin
  if P is TddSchedulerTime then
  begin
   f_Isdate:= TddSchedulerTime(P).IsDate;
   f_IsTime:= TddSchedulerTime(P).IsTime;
   f_DateTime:= TddSchedulerTime(P).DateTime;
  end
  else
   inherited;
end;

procedure TddScheduler.DisableSchedule;
begin
 Inc(f_DisableCounter);
end;

procedure TddScheduler.EnableSchedule;
begin
 Dec(f_DisableCounter);
 if f_DisableCounter = 0 then
  CheckDelayedTasks;
 if f_DisableCounter < 0 then
  f_DisableCounter := 0;
end;

function TddScheduler.ScheduleEnabled: Boolean;
begin
  Result := (f_DisableCounter = 0) and Tl3ProcessingEnabledService.Instance.Enabled;
end;

procedure TddScheduler.CheckDelayedTasks;
var
 l_List: Tl3ObjectRefList;

 function DoCopy(aData: Pointer; aIndex: Integer): Boolean;
 var
  l_Task: TddSchedulerTask;
 begin
  Result := True;
  l_Task := TddSchedulerTask(aData^);
  l_List.Add(l_Task);
 end;

 function DoExecute(aData: Pointer; aIndex: Integer): Boolean;
 var
  l_Task: TddSchedulerTask;
 begin
  Result := True;
  l_Task := TddSchedulerTask(aData^);
  ExecuteTask(l_Task, True, True, True);
 end;

begin
 if ScheduleEnabled then
 begin
  l_List := Tl3ObjectRefList.Make;
  try
   f_DelayedTasks.IterateAllF(l3L2IA(@DoCopy));
   f_DelayedTasks.Clear;
   l_List.IterateAllF(l3L2IA(@DoExecute));
  finally
   FreeAndNil(l_List);
  end;
 end;
end;

function TddScheduler.HasTaskExecutedByTimer: Boolean;
var
 l_IDX: Integer;
 l_Task : TddSchedulerTask;
begin
 Result := False;
 for l_IDX := 0 to Count - 1 do
 begin
  l_Task:= Tasks[l_IDX];
  if not l_Task.Deleted and l_Task.ExecuteByTimer then
  begin
   Result := True;
   Exit;
  end;
 end;
end;

procedure TddScheduler.DoLocalTimeChange(Sender: TObject);
begin
 if IsInWork then
 begin
  f_NeedRecalc := True;
  f_FromTimer := Sender = f_Timer;
 end
 else
  DoDoLocalTimeChange(Sender = f_Timer);
end;

function QueueSort(Item1, Item2: Pointer): Integer;
begin
 Result := CompareDateTime(TddSchedulerTask(Item2).NextScheduledTime, TddSchedulerTask(Item1).NextScheduledTime);
end;

procedure TddScheduler.ReFillTaskQueue(aNow: TDateTime; aList: TObjectList = nil);

 function ProcessTask(aData: Pointer; aIndex: Integer): Boolean;
 var
  l_Task: TddSchedulerTask;
 begin
  Result := True;
  l_Task := TddSchedulerTask(aData^);
  l_Task.NextScheduledTime := l_Task.FullDateTime[aNow];
  if not l_Task.Deleted and l_Task.ExecuteByTimer and (CompareDateTime(l_Task.NextScheduledTime, aNow) = GreaterThanValue) then
  begin
   l_Task.Use;
   aList.Add(l_Task);
  end;
 end;

begin
  if aList = nil then
    aList := f_TaskQueue;
  aList.Clear;
  f_Tasks.IterateAllF(l3L2IA(@ProcessTask));
  aList.Sort(@QueueSort)
end;

procedure TddScheduler.ProcessTaskQueue(aNow: TDateTime);
var
 l_IDX: Integer;
begin
 for l_IDX := f_TaskQueue.Count - 1 downto 0 do
 begin
  if f_NeedRecalc then
   Exit;
  if CompareDateTime(TddSchedulerTask(f_TaskQueue[l_IDX]).NextScheduledTime, aNow) <> GreaterThanValue then
  begin
   ExecuteTask(TddSchedulerTask(f_TaskQueue[l_IDX]), True, True, False);
   f_TaskQueue.Delete(l_IDX);
  end
  else
   Exit;
 end;
end;

procedure TddScheduler.DeleteOutdatedTasks(aNow, aThreshold: TDateTime);
var
 l_IDX: Integer;
begin
 for l_IDX := f_TaskQueue.Count - 1 downto 0 do
  if Abs(TddSchedulerTask(f_TaskQueue[l_IDX]).NextScheduledTime - aNow) > aThreshold then
   f_TaskQueue.Delete(l_IDX);
end;

function TddScheduler.GetFirstSheduledTask: TddSchedulerTask;
begin
 if f_TaskQueue.Count > 0 then
  Result := TddSchedulerTask(f_TaskQueue.Last) // [f_TaskQueue.Count - 1]
 else
  Result := nil; 
end;

procedure TddScheduler.NotifyTaskEdited(aTask: TddSchedulerTask);
begin
 Restart;
end;

procedure TddScheduler.Restart;
begin
 if f_Running then
  DoLocalTimeChange(nil);
end;

procedure TddScheduler.FillTaskListDescription(aNow: TDateTime;
  const aList: TStrings; MaxCount: Integer = 5);
var
 l_List: TObjectList;
 l_Now: TDateTime;
 l_IDX: Integer;
 l_Count: Integer;
begin
 aList.Clear;
 l_Now := aNow;
 l_List := TObjectList.Create(True);
 try
  repeat
   ReFillTaskQueue(l_Now, l_List);
   if l_List.Count = 0 then
    Break;
   l_Now := TddSchedulerTask(l_List[l_List.Count - 1]).NextScheduledTime;
   for l_IDX := l_List.Count - 1 downto 0 do
   begin
    if SameDateTime(l_Now, TddSchedulerTask(l_List[l_IDX]).NextScheduledTime) then
    begin
     aList.Add(Format('%d. %s', [Succ(aList.Count),  TaskDescription(TddSchedulerTask(l_List[l_IDX]), l_Now)]));
     if aList.Count >= MaxCount then
      Exit;
    end
    else
     Break;
   end;
   l_Now:= IncSecond(l_Now, 30);
  until False;
 finally
  FreeAndNil(l_List);
 end;
end;

procedure TddScheduler.BeginWork;
begin
 Inc(f_BusyCounter);
end;

procedure TddScheduler.EndWork;
begin
 if f_BusyCounter > 0 then
 begin
  Dec(f_BusyCounter);
  if (f_BusyCounter = 0) and f_NeedRecalc then
   DoDoLocalTimeChange(f_FromTimer);
 end;
end;

function TddScheduler.IsInWork: Boolean;
begin
 Result := f_BusyCounter <> 0;
end;

procedure TddScheduler.DoDoLocalTimeChange(aFromTimer: Boolean);
var
 l_Now: TDateTime;
begin
 BeginWork;
 try
  Assert(f_BusyCounter = 1);
  f_NeedRecalc := False;
  if aFromTimer then
   l3System.Msg2Log('Системное время измемено - пересчитываем планировщик');
  l_Now := Now;
  DeleteOutdatedTasks(l_Now, cResetSchedulerThreshold);
  _OnTimer(nil);
 finally
  EndWork;
 end;
end;

procedure TddScheduler.DelayTask(const aTask: TddSchedulerTask);
begin
 f_DelayedTasks.Remove(aTask);
 f_DelayedTasks.Add(aTask);
end;

function TddScheduler.CanRunTask(const aTask: TddSchedulerTask; aWithSubTasks: Boolean): Boolean;
var
 l_Result: Boolean;
 I: Integer;
 l_Handler: TddSchedulerCanRunTaskHandler;
 l_SubTaskType: TddCalendarTaskType;

begin
 l_Result := True;
 if GetCanRunTaskHandler(aTask.TaskType, l_Handler) then
  l_Handler(aTask, l_Result);
 if l_Result and aWithSubTasks then
  for i:= 0 to Pred(aTask.SubTaskCount) do
  begin
   l_SubTaskType:= aTask.SubTaskType[i];
   if l_SubTaskType <> aTask.TaskType then
   begin
    if not CanRunTask(GetFakeSubTask(aTask, l_SubTaskType), False) then
    begin
     l_Result := False;
     Break;
    end;
   end; // aTask.SubTaskType[i] <> aTask.TaskType
  end; // for i
 Result := l_Result;
end;

procedure TddScheduler.AddCanRunHandler(aTaskType: TddCalendarTaskType;
  aTaskHandler: TddSchedulerCanRunTaskHandler);
var
 l_Rec: TddSchedulerCanRunTaskHandlerRec;
begin
 if FindCanRunHandler(aTaskType, aTaskHandler) < 0 then
 begin
  l_Rec.rTaskType := aTaskType;
  l_Rec.rHandler := aTaskHandler;
  f_CanRunHandlerList.Add(l_Rec);
 end;
end;

procedure TddScheduler.DelCanRunHandler(aTaskType: TddCalendarTaskType;
  aTaskHandler: TddSchedulerCanRunTaskHandler);
var
 l_Idx: Integer;
begin
 l_Idx := FindCanRunHandler(aTaskType, aTaskHandler);
 if l_Idx >= 0 then
  f_CanRunHandlerList.Delete(l_Idx);
end;

function TddScheduler.FindCanRunHandler(
  aTaskType: TddCalendarTaskType;
  aTaskHandler: TddSchedulerCanRunTaskHandler): Integer;
var
 l_Rec: TddSchedulerCanRunTaskHandlerRec;
begin
 l_Rec.rTaskType := aTaskType;
 l_Rec.rHandler := aTaskHandler;
 if not f_CanRunHandlerList.FindPart(l_Rec, SizeOf(TddSchedulerCanRunTaskHandlerRec), Result) then
  Result := -1;
end;

function TddScheduler.GetCanRunTaskHandler(aTaskType: TddCalendarTaskType;
  out theHandler: TddSchedulerCanRunTaskHandler): Boolean;
var
 i: Integer;
 l_Handler: TddSchedulerCanRunTaskHandlerRec;

begin
 Result := False;
 for i:= 0 to f_CanRunHandlerList.Hi do
 begin
  l_Handler:= PddSchedulerCanRunTaskHandlerRec(f_CanRunHandlerList.ItemSlot(i))^;
  if l_Handler.rTaskType = aTaskType then
  begin
   theHandler:= l_Handler.rHandler;
   Result:= True;
   break;
  end; // l_Handler.rTaskType = aTaskType
 end; // for i
end;

function TddScheduler.GetFakeSubTask(const aParent: TddSchedulerTask;
  aTaskType: TddCalendarTaskType): TddSchedulerTask;
begin
 if f_FakeSubTask = nil then
  f_FakeSubTask := TddSchedulerTask.Create;
 f_FakeSubTask.Assign(aParent);
 f_FakeSubTask.TaskType := aTaskType;
 f_FakeSubTask.ClearSubTasks;
 Result := f_FakeSubTask;
end;

procedure TddSchedulerTask.ClearSubTasks;
begin
 (Params.AsObject[NestedAlias] as TddSimpleListDataAdapter).ClearItems;
end;

end.

