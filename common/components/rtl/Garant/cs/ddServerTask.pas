unit ddServerTask;
{ Задачи, которыми обменивается клиент с сервером }

{ $Id: ddServerTask.pas,v 1.90 2015/10/22 12:07:18 lukyanets Exp $ }

// $Log: ddServerTask.pas,v $
// Revision 1.90  2015/10/22 12:07:18  lukyanets
// Новый приоритет
//
// Revision 1.89  2015/04/07 07:37:04  lukyanets
// Изолируем HT
//
// Revision 1.88  2015/01/27 12:22:00  lukyanets
// Сортируем задачи в клиенте
//
// Revision 1.87  2015/01/22 14:31:37  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.86  2014/12/29 11:47:55  lukyanets
// Убираем старые ошметки
//
// Revision 1.85  2014/09/22 13:39:08  lulin
// - непонадобившийся запил.
//
// Revision 1.84  2014/09/22 12:54:10  lukyanets
// Вычитывали таск не того класса.
//
// Revision 1.83  2014/09/19 14:01:19  lukyanets
// Гоняем TaskID - нотификация на клиенте отвалилась.
//
// Revision 1.82  2014/08/15 11:57:19  fireton
// - не сохранялись запросы на сервере
//
// Revision 1.81  2014/08/04 13:35:54  lulin
// - добавлен метод MakeFromEVDSafe.
//
// Revision 1.80  2014/07/21 12:43:14  lulin
// - разделяем метод записи с флажком и без флажка.
//
// Revision 1.79  2014/07/18 16:40:16  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.78  2014/07/18 16:03:29  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.77  2014/07/18 15:47:22  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.76  2014/07/18 15:23:25  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.75  2014/07/16 14:29:37  lulin
// - вставляем проверку на корректность данных.
//
// Revision 1.74  2014/07/16 11:47:44  lulin
// - обучаем коробку с тегами нотифицировать заинтересованных лиц об изменении состояния задания.
//
// Revision 1.73  2014/07/15 10:53:33  lulin
// - переносим на модель.
//
// Revision 1.72  2014/07/15 10:14:19  lulin
// - причёсываем код.
//
// Revision 1.71  2014/07/14 13:05:47  lulin
// - учимся читать задания из EVD.
//
// Revision 1.70  2014/07/14 12:41:05  voba
// - получение списка заданий не работало
//
// Revision 1.69  2014/07/14 11:37:25  lulin
// - учимся читать задания из EVD.
//
// Revision 1.68  2014/07/14 11:27:33  lulin
// - учимся читать задания из EVD.
//
// Revision 1.66  2014/07/14 10:45:10  lulin
// - учимся читать задания из EVD.
//
// Revision 1.65  2014/07/11 16:43:13  lulin
// - учимся читать задания из EVD.
//
// Revision 1.64  2014/07/11 16:36:27  lulin
// - учимся читать задания из EVD.
//
// Revision 1.62  2014/07/11 14:46:47  lulin
// - заворачиваем SourceFiles в теги.
//
// Revision 1.61  2014/07/11 09:29:35  lulin
// - bug fix: не получали очередь заданий.
//
// Revision 1.60  2014/07/09 16:45:27  lulin
// - готовимся к записи в EVD.
//
// Revision 1.59  2014/07/09 16:31:46  lulin
// - готовимся к записи в EVD.
//
// Revision 1.58  2014/07/08 14:25:05  lulin
// - в идентификатор задания помещаем полную дату.
//
// Revision 1.57  2014/07/08 13:58:58  lukyanets
// {Requestlink:553422280}. Разбираемся с ошибочными статусами
//
// Revision 1.56  2014/07/08 13:58:24  lulin
// - чистим код.
//
// Revision 1.54  2014/07/08 13:13:13  lulin
// - часть задач может выполняться только от имени сервера Автоматизации.
//
// Revision 1.53  2014/07/08 11:40:39  lulin
// - боремся за константность параметров заданий.
//
// Revision 1.52  2014/07/07 15:54:56  lulin
// - чистим код и перестаём заниматься парсингом идентификатора задачи.
//
// Revision 1.51  2014/07/07 12:03:52  lulin
// - движемся к константности TaskType.
//
// Revision 1.50  2014/07/04 14:05:45  lulin
// - движемся к константности TaskType.
//
// Revision 1.49  2014/07/04 13:58:43  lulin
// - движемся к константности TaskType.
//
// Revision 1.48  2014/07/04 12:41:59  lulin
// - движемся к константности TaskType.
//
// Revision 1.47  2014/07/03 17:03:41  lulin
// - движемся к константности TaskType.
//
// Revision 1.46  2014/07/03 15:57:19  lulin
// - предохраняемся от перезатирания "серверного" пути.
//
// Revision 1.45  2014/07/03 15:20:05  lulin
// - чистим код.
//
// Revision 1.44  2014/07/03 11:18:17  lulin
// - правильнее упаковываем дату/время.
//
// Revision 1.43  2014/07/03 10:56:19  lulin
// - правильнее упаковываем дату/время.
//
// Revision 1.42  2014/07/02 16:51:56  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.41  2014/07/02 13:57:58  lulin
// - чистим код.
//
// Revision 1.39  2014/07/02 13:31:36  lulin
// - разбираемся с контролем типов.
//
// Revision 1.38  2014/07/02 10:44:11  lulin
// - разбираемся с тасками с неверными типами, на которых "засыпала" принимающая нить сервера.
//
// Revision 1.37  2014/07/01 08:01:55  lulin
// - работаем над инфраструктурой заворачивания тегов в таски. Делаем тесты и обрабатываем ошибочные кейсы. Пока как смогли.
//
// Revision 1.36  2014/06/26 14:35:12  lulin
// - проверяем сохранение задач в EVD.
//
// Revision 1.35  2014/06/26 13:59:58  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.34  2014/06/26 12:39:22  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.33  2014/06/24 11:38:52  lulin
// - раскладываем данные задач в теги.
//
// Revision 1.32  2014/06/18 13:58:26  lulin
// - перекомпиляция.
//
// Revision 1.31  2014/06/17 11:50:58  lulin
// - убираем ненужный параметр, он и так потом из потока читается.
//
// Revision 1.30  2014/06/17 10:33:28  lulin
// - переименовываем метод, чтобы название отражало его суть.
//
// Revision 1.29  2014/06/16 11:31:29  lulin
// - стабилизируем пути.
//
// Revision 1.28  2014/06/16 09:31:12  lulin
// - попытка стабилизировать пути. Безуспешная.
//
// Revision 1.27  2014/06/11 12:07:51  lulin
// - чистим код.
//
// Revision 1.26  2014/06/11 11:58:28  lulin
// - чистим код.
//
// Revision 1.25  2014/06/11 11:52:28  lulin
// - чистим код.
//
// Revision 1.24  2014/06/11 09:12:55  lulin
// - bug fix: не теряем милисекунды.
//
// Revision 1.23  2014/06/06 13:14:14  lulin
// - чистим код.
//
// Revision 1.22  2014/06/06 09:43:15  lulin
// - чистим код.
//
// Revision 1.21  2014/06/05 16:16:59  lulin
// - не очищаем клиентские сообщения, в них и так дубликов не бывает.
// - оптимизируем работу с датой сообщения.
//
// Revision 1.20  2014/06/03 15:34:50  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.19  2014/06/02 13:47:56  lulin
// - возвращаемся к старому формату.
//
// Revision 1.18  2014/05/30 17:28:28  lulin
// - рефакторим обработку команд.
//
// Revision 1.17  2014/05/30 10:04:51  lulin
// - избавляемся от условной записи в поток.
//
// Revision 1.16  2014/05/29 16:40:15  lulin
// - переименовываем безликое свойство.
//
// Revision 1.15  2014/05/29 16:24:25  lulin
// - упрятываем пользователя в "коробку".
//
// Revision 1.14  2014/05/29 15:52:27  lulin
// - упрятываем папку в "коробку".
//
// Revision 1.11  2014/05/29 15:22:06  lulin
// - упрятываем тип в "коробку".
//
// Revision 1.10  2014/05/29 15:14:32  lulin
// - упрятываем приоритет в "коробку".
//
// Revision 1.9  2014/05/29 14:44:11  lulin
// - упрятываем дату в "коробку".
//
// Revision 1.8  2014/05/29 14:17:27  lulin
// - распределяем коробку для данных.
//
// Revision 1.7  2014/05/29 13:25:19  lulin
// - чистим код.
//
// Revision 1.6  2014/05/29 12:34:59  lulin
// - используем другой формат дат.
//
// Revision 1.5  2014/05/29 12:28:08  lulin
// - чистим код.
//
// Revision 1.4  2014/05/28 16:34:41  lulin
// - чистим код.
//
// Revision 1.3  2014/05/28 15:48:03  lulin
// - причёсываем код.
//
// Revision 1.2  2014/05/28 12:46:25  lulin
// - переделываем нотификацию об изменении состояния задания.
//
// Revision 1.1  2014/05/27 15:12:19  lulin
// - чистим код.
//
// Revision 1.82  2014/05/27 14:43:10  lulin
// - чистим код.
//
// Revision 1.81  2014/05/27 14:18:28  lulin
// - чистим код.
//
// Revision 1.80  2014/05/27 12:45:57  lulin
// - чистим код.
//
// Revision 1.79  2014/05/27 12:30:36  lulin
// - чистим код.
//
// Revision 1.78  2014/05/27 12:04:12  lulin
// - чистим код.
//
// Revision 1.77  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.76  2014/02/12 12:35:27  lulin
// - рефакторим списки заданий.
//
// Revision 1.75  2013/04/19 13:10:10  lulin
// - портируем.
//
// Revision 1.74  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.73  2013/04/11 08:44:34  narry
// Избавляемся от мусора в логе
//
// Revision 1.72  2013/02/05 10:16:35  narry
// Ловушка для пользователя 0
//
// Revision 1.71  2012/11/01 09:43:24  lulin
// - забыл точку с запятой.
//
// Revision 1.70  2012/11/01 07:45:49  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.69  2012/10/18 06:50:41  narry
// Обновление
//
// Revision 1.68  2012/10/15 04:52:11  fireton
// - не собиралось
//
// Revision 1.67  2012/10/02 07:21:58  narry
// Обновление
//
// Revision 1.66  2012/02/20 10:46:23  narry
// Терялось описание задачи
//
// Revision 1.65  2012/01/31 10:49:12  narry
// Падала очередь заданий на неизвестном типе
//
// Revision 1.64  2011/04/11 10:25:01  narry
// Названия для ФАС (259885290)
//
// Revision 1.63  2010/07/14 12:47:43  narry
// - К226001558
//
// Revision 1.62  2010/05/19 11:00:21  narry
// - K211878089
//
// Revision 1.61  2010/05/17 08:31:20  narry
// - K211878129
// - переименование типов
//
// Revision 1.60  2010/03/24 05:59:23  narry
// - не распознавалось задание Экспорт для Прайм
//
// Revision 1.59  2010/02/24 10:24:24  narry
// - удаление зависимости проектов от парня
//
// Revision 1.58  2009/11/16 10:11:38  narry
// - обновление
//
// Revision 1.57  2009/11/10 09:12:33  narry
// - обновление
//
// Revision 1.56  2009/04/13 07:12:57  narry
// - разделение определения типов и реализации
//
// Revision 1.55  2009/03/13 15:11:55  narry
// - дата удаления элемента словаря
//
// Revision 1.54  2009/01/23 15:58:42  narry
// - переделки в сторону службы
//
// Revision 1.53  2008/11/24 12:43:41  narry
// - обновление
//
// Revision 1.52  2008/10/30 13:02:11  narry
// - Единый КВ
//
// Revision 1.51  2008/10/06 13:17:27  narry
// - Обрезалась очередь заданий на клиенте
//
// Revision 1.50  2008/08/18 12:40:16  narry
// - удален лишний класс
//
// Revision 1.49  2008/07/16 16:11:09  narry
// - реализация Автовыливки
//
// Revision 1.48  2008/07/15 14:53:48  voba
// - refact. перетаскивание методов в TDictionary
//
// Revision 1.47  2008/07/14 07:37:14  narry
// - промежуточное обновление Единого КВ
//
// Revision 1.46  2008/07/03 12:24:59  narry
// - промежуточное обновление Единого КВ
//
// Revision 1.45  2008/05/16 11:56:21  narry
// - борьба с Integer overflow при показе очереди заданий
//
// Revision 1.44  2008/04/23 07:27:19  narry
// - переделки для сервиса
//
// Revision 1.43  2008/03/25 14:02:34  narry
// - корректный формат выходного файла
//
// Revision 1.42  2008/03/20 09:48:29  lulin
// - cleanup.
//
// Revision 1.41  2008/03/13 14:45:36  narry
// - новые объекты
//
// Revision 1.40  2008/03/03 20:06:00  lulin
// - <K>: 85721135.
//
// Revision 1.39  2008/02/27 15:50:20  narry
// - внешний процесс для обработки результатов экспорта
//
// Revision 1.38  2008/02/21 18:37:21  lulin
// - вычищен ненужный параметр.
//
// Revision 1.37  2008/02/21 18:13:25  lulin
// - избавляемся от ненужных типов.
//
// Revision 1.36  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.35  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.34  2008/02/07 14:44:37  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.33  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.32  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.31  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.30  2007/12/07 08:44:57  narry
// - запись в лог об изменении статуса задачи стала более информативной
//
// Revision 1.29  2007/12/06 11:11:58  narry
// - поддержка автоклассификации
//
// Revision 1.28  2007/11/27 10:41:12  fireton
// - имя папки в письме об окончании импорта
//
// Revision 1.27  2007/09/05 15:44:23  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - индикация передачи данных между клиентом и сервером
//
// Revision 1.26  2007/09/04 10:13:26  narry
// - ошибка возврата заданий в евд-формате
//
// Revision 1.25  2007/08/30 08:34:32  narry
// - Промежуточное сохранение
//

interface

{$I csDefine.inc}

uses
  Classes,
  l3Base, l3Types,
  dt_Types,
  csClient, CsDataPipe, csNotification, csTaskTypes

  ,
  l3ProtoObject,
  l3Variant,

  k2Base,

  ddTaskItemPrim
  ;

type
  TddTaskItem = class(TddTaskItemPrim)
(*  private
    f_Index: LongInt;*)
    function pm_GetDescription: AnsiString;
(*    function pm_GetTaskID: AnsiString;*)
(*    procedure pm_SetPriority(aValue: Integer);*)
(*    function pm_GetDate: TDateTime;*)
  protected
    procedure InitFields; override;
    procedure Cleanup; override;
    function GetDescription: AnsiString; virtual;
    function ReadFileFrom(aStream: TStream; const aFolderName: AnsiString): AnsiString;
    function pm_GetTaskFolder: AnsiString; virtual;
    procedure ReadString(aStream: TStream; out aStr: AnsiString); overload;
    function ReadString(aStream: TStream): AnsiString; overload;
    procedure WriteFileTo(aStream: TStream; aFileName: AnsiString; const aLocalName: AnsiString = '');
    procedure WriteString(aStream: TStream; const Str: AnsiString);
    property VersionW: Integer write pm_SetVersion;
    procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); virtual;
    procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); virtual;
  private
    property DateW: TDateTime write pm_SetDate;
    property UserIDW: TUserID write pm_SetUser;
  public
    constructor Create(aUserID: TUserID); reintroduce; overload; virtual;
    constructor Create(aUserID: TUserID; aDate: TDateTime); reintroduce; overload;
    class function MakeFrom(aStream: TStream; const aTaskFolder: AnsiString; aIsPipe: Boolean): TddTaskItem;
    class function MakeFromEVD(aStream: TStream; const aTaskFolder: AnsiString; aIsPipe: Boolean): TddTaskItem;
    class function MakeFromEVDSafe(aStream: TStream; const aTaskFolder: AnsiString; aIsPipe: Boolean): TddTaskItem;
    class function MakeFromTaggedData(aData: Tl3Tag; const aTaskFolder: AnsiString; aIsPipe: Boolean; aSafe: Boolean): TddTaskItem;
    procedure AssignFrom(P: TddTaskItem);
    procedure LoadFrom(aStream: TStream; aIsPipe: Boolean);
    procedure SaveTo(aStream: TStream; aIsPipe: Boolean);
    procedure SaveToEVDEx(aStream: TStream; aIsPipe: Boolean);
    procedure LoadFromEVD(aStream: TStream; aIsPipe: Boolean);
    property Date: TDateTime read pm_GetDate;
    property Description: AnsiString read pm_GetDescription write pm_SetDescription;
(*    property TaskIndex: LongInt read f_Index write f_Index;*)
(*    property Priority: Integer read pm_GetPriority write pm_SetPriority;*)
    property TaskFolder: AnsiString read pm_GetTaskFolder write pm_SetTaskFolder;
(*    property TaskID: AnsiString read pm_GetTaskID;*)
    property UserID: TUserID read pm_GetUser;
  end;//TddTaskItem

 TddTaskClass = class of TddTaskItem;

procedure RegisterTaskClass(aType: TcsTaskType; aClass: TddTaskClass; const aDescription: AnsiString);

const
 dd_tpTimeCritical = -100;
 dd_tpHighest      = 0;
 dd_tpHigh         = 25;
 dd_tpNormal       = 50;
 dd_tpLow          = 75;
 dd_tpLowest       = 100;
 dd_tpDead         = High(Integer);
 dd_tpAutoClass    = dd_tpLowest;//Pred(dd_tpDead);
 dd_tpAutoClassRun = Pred(dd_tpAutoClass);

 CorrectPriorities : array[TPriority] of Integer =
     (dd_tpLowest, dd_tpLow, dd_tpNormal, dd_tpHigh, dd_tpHighest);


 TaskStatusNames: array[TcsTaskStatus] of String = (
                  'не определен',
                  'в очереди',
                  'выполняется',
                  'заморожено',
                  'выполнение приостановлено',
                  'ожидание доставки пользователю',
                  'обработано',
                  'удалено',
                  'выполнение привело к ошибке',
                  'задание отложено',
                  'доставляются результаты',
                  'асинхронное выполнение',
                  'асинхронное выполнение привело к ошибке'
                  );

implementation

Uses
 Math, DateUtils, SysUtils, StrUtils,
 l3FileUtils, l3Stream, l3Memory,

 k2Tags,

 TypInfo,

 ddTaskClassManager,
 csTaskListening,
 Task_Const,
 daInterfaces,

 evdTaskTypes,
 csProcessTask,
 ProcessTask_Const,
 evdTaskFolderEliminator
 ;

procedure RegisterTaskClass(aType: TcsTaskType; aClass: TddTaskClass; const aDescription: AnsiString);
begin
 TddTaskClassManager.Instance.RegisterClass(aType, aClass, aDescription);
end;

{
********************************* TddTaskItem **********************************
}

constructor TddTaskItem.Create(aUserID: TUserID);
begin
 inherited Create;
 if Tk2Type(TaggedData.TagType).Prop[k2_attrUser].ReadOnly then
 begin
  if (Self.UserID <> aUserID) then
   if (aUserID <> usNotDefined) then
    Assert(false, 'Пытаются указать пользователя ' + IntToStr(aUserID) + ', вместо ' + IntToStr(Self.UserID));
 end//Tk2Type(TaggedData.TagType).Prop[k2_attrUser].ReadOnly
 else
  Self.UserIDW := aUserID;
 if (UserID < 1) then
  l3System.Stack2Log('UserID < 1');
end;

constructor TddTaskItem.Create(aUserID: TUserID; aDate: TDateTime);
begin
 Create(aUserID);
 DateW := aDate;
end;

function TddTaskItem.pm_GetTaskFolder: AnsiString;
begin
 Result := TaggedData.StrA[k2_attrTaskFolder];
end;

procedure TddTaskItem.AssignFrom(P: TddTaskItem);
begin
 TaggedData.AssignTag(P.TaggedData);
 //Assert(false, 'А нужно ли это вообще');
 Self.DateW := P.Date;
 Self.Description := P.Description;
(* Self.Priority := P.Priority;
 TaggedData.StrA[k2_attrTaskFolder] := P.TaggedData.StrA[k2_attrTaskFolder];
 Self.TaskType := P.TaskType;
 Self.UserIDW := P.UserID;*)
end;

procedure TddTaskItem.InitFields;
begin
 inherited;
end;

procedure TddTaskItem.Cleanup;
begin
 inherited;
end;

function TddTaskItem.GetDescription: AnsiString;
begin
// Result := '';
 Result:= IfThen(TaggedData.StrA[k2_attrDescription] = '', ClassName, TaggedData.StrA[k2_attrDescription]);
end;

function TddTaskItem.ReadFileFrom(aStream: TStream; const aFolderName: AnsiString): AnsiString;
var
  l_Stream: TStream;
  l_FileName, l_LocalFileName: AnsiString;
  l_Len: Int64;
  l_FileOpenMode: Tl3FileMode;
begin
{ TODO 1 -oДмитрий Дудко -cнедоделка : Нужно провести рефакторинг }
 ReadString(aStream, l_FileName);
 if (l_FileName <> '') then
 begin
  l_LocalFileName := ConcatDirName(aFolderName, l_FileName);
  ForceDirectories(ExtractFilePath(l_LocalFileName));
  if FileExists(l_LocalFileName) then
  begin
   l_FileName := GetUniqFileName(aFolderName, ExtractOnlyFileName(l_FileName), ExtractFileExt(l_FileName));
   l_FileOpenMode:= l3_fmWrite;
  end//FileExists(l_LocalFileName)
  else
  begin
   l_FileName := l_LocalFileName;
   l_FileOpenMode:= l3_fmWrite;
  end;//FileExists(l_LocalFileName)
  Result := l_FileName;
  aStream.Read(l_Len, SizeOf(Int64));
  if (l_Len > 0) then
  begin
   l_Stream := Tl3FileStream.Create(l_FileName, l_FileOpenMode);
   try
    l_Stream.CopyFrom(aStream, l_Len);
   finally
    l3Free(l_Stream);
   end;//try..finally
  end; // l_Len > 0
 end;//l_Len > 0
end;

procedure TddTaskItem.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
var
 l_User : TUserID;
begin
 Self.VersionW := ReadInteger(aStream);
 l_User := ReadCardinal(aStream);
 if Tk2Type(TaggedData.TagType).Prop[k2_attrUser].ReadOnly then
 begin
  if (Self.UserID <> l_User) then
   Assert(false, 'Пытаются указать пользователя ' + IntToStr(l_User) + ', вместо ' + IntToStr(Self.UserID));
 end//Tk2Type(TaggedData.TagType).Prop[k2_attrUser].ReadOnly
 else
  Self.UserIDW := l_User;
 if Tk2Type(TaggedData.TagType).Prop[k2_attrDate].ReadOnly then
 begin
  if not SameValue(Self.Date, ReadDateTime(aStream)) then
   Assert(false, 'Считанная дата не совпадает со значением по-умолчанию');
 end//Tk2Type(TaggedData.TagType).Prop[k2_attrDate].ReadOnly
 else
 begin
  Self.DateW := ReadDateTime(aStream);
 end;//Tk2Type(TaggedData.TagType).Prop[k2_attrDate].ReadOnly
 Self.Priority := ReadInteger(aStream);
 Self.Description := ReadString(aStream);
 {$IfDef nsTest}
 //if aIsPipe then
 {$EndIf nsTest}
  Self.TaskID := ReadString(aStream);
 if not aIsPipe then
  TaggedData.StrA[k2_attrTaskFolder] := ReadString(aStream);
end;

procedure TddTaskItem.LoadFrom(aStream: TStream; aIsPipe: Boolean);
begin
 if TaskType <> TcsTaskType(ReadInteger(aStream)) then
  {Assert(false, 'Неверный тип задания')}
  // - пока закомментировал ибо клиентам очередь не приезжает
  ;
 DoLoadFrom(aStream, aIsPipe);
end;

class function TddTaskItem.MakeFrom(aStream: TStream; const aTaskFolder: AnsiString; aIsPipe: Boolean):
    TddTaskItem;
var
 l_V: Integer;
 l_Pos: Cardinal;
 l_Description: AnsiString;
 l_Count: Integer;
begin
 Result := nil;
 with aStream do
 begin
  l_Pos := Position;
  l_Count:= Read(l_V, SizeOf(Integer));
  if l_Count = SizeOf(Integer) then
  begin
   if InRange(l_V, Ord(Low(TcsTaskType)), Ord(High(TcsTaskType))) then
   begin
    if TddTaskClassManager.Instance.Registered(TcsTaskType(l_V)) then
    begin
     Result:= TddTaskClassManager.Instance.GetClass(TcsTaskType(l_V), l_Description).Create(usNotDefined);
     Result.Description:= l_Description;
     Result.TaskFolder := aTaskFolder;
     Position := l_Pos;
     try
      Result.LoadFrom(aStream, aIsPipe);
      if aIsPipe then
       Result.TaskFolder := aTaskFolder;
     except
      on E: Exception do
      begin
       l3System.Msg2Log('Ошибка (%s) загрузки задачи %s', [E.message, Result.ClassName]);
       FreeAndNil(Result);
      end;//on E: Exception
     end;//try..except
(*     if (Result <> nil) then
     begin
      Result.Description:= l_Description;
      Result.TaskFolder := aTaskFolder;
     end;//Result <> nil*)
    end // _TaskClassManager.Registered(TcsTaskType(l_V))
    else
    begin
     {$IFNDEF csNewQueueTaskLine}
     l3System.Msg2Log('Незарегистрированный тип задания %s', [GetEnumName(TypeInfo(TcsTaskType), l_V)]);
     {$ENDIF csNewQueueTaskLine}
     Position:= l_Pos;
    end;
   end // InRange(l_V, Ord(Low(TcsTaskType)), Ord(High(TcsTaskType)))
   else
   begin
    l3System.Msg2Log('Неправильный тип задания %d', [l_V]);
    l3System.Msg2Log('Данные о потоке: размер %d, позиция %d', [Size, l_Pos]);
    raise EStreamError.Create('Очередь заданий повреждена');
   end;
  end; // l_Count = SizeOf(Integer)
 end; // with aStream
end;

class function TddTaskItem.MakeFromTaggedData(aData: Tl3Tag; const aTaskFolder: AnsiString; aIsPipe: Boolean; aSafe: Boolean): TddTaskItem;
var
 l_Description : AnsiString;
 l_TaskType : TcsTaskType;
 l_TaskClass : TddTaskClass;
begin
 l_TaskType := TcsTaskType(aData.IntA[k2_attrTaskType]);
 if not TddTaskClassManager.Instance.Registered(l_TaskType) then
 begin
  l_Description := Format('Незарегистрированный тип задания %s', [GetEnumName(TypeInfo(TcsTaskType), Ord(l_TaskType))]);
  l3System.Msg2Log(l_Description);
  if not aSafe then
  begin
   Result := nil;
   Exit;
  end;//not aSafe 
  if aData.IsKindOf(k2_typProcessTask) then
   l_TaskClass := TddProcessTask
  else
   l_TaskClass := TddTaskItem;
 end//TddTaskClassManager.Instance.Registered(l_TaskType)
 else
  l_TaskClass := TddTaskClassManager.Instance.GetClass(l_TaskType, l_Description);

 Result := l_TaskClass.Create(usNotDefined);
 try
  Result.Description := l_Description;
  Result.TaskFolder := aTaskFolder;
  //Result.TaggedData.AssignTag(aData);
  Result.SetTaggedData(aData);
  if aIsPipe then
   Result.TaskFolder := aTaskFolder;
 except
  FreeAndNil(Result);
  raise;
 end;//try..except
end;

class function TddTaskItem.MakeFromEVD(aStream: TStream; const aTaskFolder: AnsiString; aIsPipe: Boolean): TddTaskItem;
var
 l_Data : Tl3Tag;
begin
 Result := nil;
 l_Data := CreateTaggedDataFromEVD(aStream);
 try
  Result := MakeFromTaggedData(l_Data, aTaskFolder, aIsPipe, false);
 finally
  FreeAndNil(l_Data);
 end;//try..finally
end;

class function TddTaskItem.MakeFromEVDSafe(aStream: TStream; const aTaskFolder: AnsiString; aIsPipe: Boolean): TddTaskItem;
var
 l_Data : Tl3Tag;
begin
 Result := nil;
 l_Data := CreateTaggedDataFromEVD(aStream);
 try
  Result := MakeFromTaggedData(l_Data, aTaskFolder, aIsPipe, true);
 finally
  FreeAndNil(l_Data);
 end;//try..finally
end;

function TddTaskItem.pm_GetDescription: AnsiString;
begin
 if (TaggedData.StrA[k2_attrDescription] = '') then
  TaggedData.StrW[k2_attrDescription, nil] := GetDescription;
 Result := TaggedData.StrA[k2_attrDescription];
end;

(*function TddTaskItem.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 if not TaggedData.HasSubAtom(k2_attrHandle) then
  Result := SysUtils.Format('%d-%s', [Self.UserID, FormatDateTime('dd-mm-yyyy-hh-nn-ss-zzz', Self.Date)])
 else
  Result := Self.Handle;
end;*)

function TddTaskItem.ReadString(aStream: TStream): AnsiString;
begin
 ReadString(aStream, Result);
end;

procedure TddTaskItem.ReadString(aStream: TStream; out aStr: AnsiString);
var
  l_Len: Integer;
begin
 aStr := '';
 if aStream.Size - aStream.Position >= SizeOf(l_Len) then
 begin
  l_Len := ReadInteger(aStream);
  if l_Len <= aStream.Size - aStream.Position then
  begin
   SetLength(aStr, l_Len);
   if l_Len > 0 then
    aStream.Read(aStr[1], l_Len);
  end;
 end; // aStream.Size - aStream.Position >= SizeOf(l_Len)
end;

procedure TddTaskItem.WriteFileTo(aStream: TStream; aFileName: AnsiString; const aLocalName: AnsiString = '');
var
  l_Stream: TStream;
  l_Len: Int64;
begin
  if aLocalName = '' then
   WriteString(aStream, ExtractFileName(aFileName))
  else
   WriteString(aStream, aLocalName);
  if (aFileName = '') then
   l_Len := 0
  else
   l_Len := GetFileSize(aFileName);
  aStream.Write(l_Len, SizeOf(Int64));
  if (l_Len = 0) then
   Exit;
  l_Stream := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   aStream.CopyFrom(l_Stream, l_Len);
  finally
   l3Free(l_Stream);
  end;
end;

procedure TddTaskItem.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
begin
 WriteInteger(aStream, Self.Version);
 WriteCardinal(aStream, Self.UserID);
 WriteDateTime(aStream, Self.Date);
 WriteInteger(aStream, Self.Priority);
 WriteString(aStream, Self.Description);
 {$IfDef nsTest}
 //if aIsPipe then
 {$EndIf nsTest}
  WriteString(aStream, Self.TaskID);
 if not aIsPipe then
  WriteString(aStream, TaggedData.StrA[k2_attrTaskFolder]);
  //WriteString(aStream, TaskFolder);
end;

procedure TddTaskItem.SaveTo(aStream: TStream; aIsPipe: Boolean);
begin
 WriteInteger(aStream, Ord(TaskType));
 DoSaveTo(aStream, aIsPipe);
end;

procedure TddTaskItem.SaveToEVDEx(aStream: TStream; aIsPipe: Boolean);
var
 l_G : Ik2TagGenerator;
begin
 l_G := nil;
 if aIsPipe then
  TevdTaskFolderEliminator.SetTo(l_G);
 inherited SaveToEVD(aStream, l_G);
end;

procedure TddTaskItem.LoadFromEVD(aStream: TStream; aIsPipe: Boolean);
begin
 inherited LoadFromEVD(aStream);
end;

(*procedure TddTaskItem.pm_SetPriority(aValue: Integer);
begin
 if Self.Priority <> aValue then
 begin
  TaggedData.IntA[k2_attrPriority] := aValue;
  Changed(cs_tsNone);
 end;//Self.Priority <> aValue
end;*)

(*function TddTaskItem.pm_GetDate: TDateTime;
begin
 if not TaggedData.HasSubAtom(k2_attrDate) then
  if not Tk2Type(TaggedData.TagType).Prop[k2_attrDate].ReadOnly then
  begin
   pm_SetDate(Now);
  end;//not TaggedData.HasSubAtom(k2_attrDate)
 Result := inherited Date;
end;*)

procedure TddTaskItem.WriteString(aStream: TStream; const Str: AnsiString);
var
  l_Len: Integer;
begin
  l_Len := Length(Str);
  WriteInteger(aStream, l_Len);
  if l_Len > 0 then
   aStream.Write(Str[1], l_Len);
end;

end.
