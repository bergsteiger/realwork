unit csTaskTypes;
{ Типы задач }

{ $Id: csTaskTypes.pas,v 1.54 2016/09/12 12:29:55 lukyanets Exp $ }

// $Log: csTaskTypes.pas,v $
// Revision 1.54  2016/09/12 12:29:55  lukyanets
// Принимаем и сохраняем
//
// Revision 1.53  2016/08/29 12:51:56  lukyanets
// Принимаем запрос и готовимся отдавать файл
//
// Revision 1.52  2016/06/02 15:23:09  fireton
// - синхронизация с Гардоком журнала импортов
//
// Revision 1.51  2016/05/27 11:14:25  fireton
// - синхронизация этапов в Гардок
//
// Revision 1.50  2016/05/20 09:50:09  lukyanets
// Вводим состояние "задача прерывается"
//
// Revision 1.49  2016/04/15 11:57:02  lukyanets
// Чистим протухший код
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.48  2016/04/12 08:24:38  lukyanets
// Отлаживаем контейнерную задачу
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.47  2016/04/11 12:47:55  lukyanets
// Отлаживаем контейнерную задачу
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.46  2016/04/07 13:52:49  lukyanets
// Заготовки прокси задачи
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.45  2016/04/01 12:07:04  lukyanets
// Заготовки контейнерной задачи
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.44  2015/09/08 14:38:27  lukyanets
// Заготовки импорта документов
//
// Revision 1.43  2015/09/04 13:03:58  lukyanets
// Заготовки задачи
//
// Revision 1.42  2015/04/15 13:56:40  lukyanets
// Даем клиенту возможность отменять свои задания
//
// Revision 1.41  2014/12/02 13:07:43  lukyanets
// Доставляем прогресс до пользователя
//
// Revision 1.40  2014/10/23 13:35:39  lukyanets
// Адекватное название состояния
//
// Revision 1.39  2014/09/05 12:39:33  lukyanets
// Рожаем RegionImportTask
//
// Revision 1.38  2014/09/01 08:18:36  lukyanets
// Готовимся выделить FTPBrowser
//
// Revision 1.37  2014/08/29 12:25:22  lukyanets
// При убивании сервера морозим отцепленные задачи, чтобы они перестартовали
//
// Revision 1.36  2014/08/25 12:02:30  lukyanets
// Хороним экспорт для ФНС
//
// Revision 1.35  2014/08/19 14:30:13  lukyanets
// {Requestlink:558466572}. Превращаем alcuMDP в НЕтаск
//
// Revision 1.34  2014/08/19 11:57:43  lukyanets
// Подчищаем неадекватные cs_tsFrozenRun
//
// Revision 1.33  2014/08/04 14:30:04  lukyanets
// {Requestlink:558466572}. Чистим протухшие хвосты - PrimeLite
//
// Revision 1.32  2014/08/04 13:13:11  lukyanets
// {Requestlink:558466572}. Отцепляем HavanskyExport
//
// Revision 1.31  2014/08/04 09:34:03  lukyanets
// {Requestlink:558466572}. Чистим протухшие хвосты - MisspellCorrect
//
// Revision 1.30  2014/08/01 10:23:07  lukyanets
// {Requestlink:558466572}. Отцепляем ddAppConfiguration
//
// Revision 1.29  2014/07/29 11:21:19  lukyanets
// {Requestlink:556143119}. Грузим таск через фабрику
//
// Revision 1.28  2014/07/24 10:05:51  lukyanets
// {Requestlink:556730516}. Более правильное название
//
// Revision 1.27  2014/07/16 15:35:40  lulin
// - вычищаем ненужное.
//
// Revision 1.26  2014/07/14 11:06:18  lukyanets
// {Requestlink:553422280}. Выделяем замену магической константе
//
// Revision 1.25  2014/07/09 06:52:42  lukyanets
// {Requestlink:553422280}. Более адекватное название.
//
// Revision 1.24  2014/07/08 13:58:58  lukyanets
// {Requestlink:553422280}. Разбираемся с ошибочными статусами
//
// Revision 1.23  2014/07/03 06:36:40  lukyanets
// {Requestlink:552022662}. Конфликты
//
// Revision 1.22  2014/07/02 13:31:36  lulin
// - разбираемся с контролем типов.
//
// Revision 1.21  2014/06/24 11:38:52  lulin
// - раскладываем данные задач в теги.
//
// Revision 1.20  2014/06/11 12:07:51  lulin
// - чистим код.
//
// Revision 1.19  2014/06/11 11:58:28  lulin
// - чистим код.
//
// Revision 1.18  2014/06/11 11:52:28  lulin
// - чистим код.
//
// Revision 1.17  2014/06/09 09:37:40  lulin
// - bug fix: не собирался Сервер Архивариуса.
//
// Revision 1.16  2014/05/27 15:12:19  lulin
// - чистим код.
//
// Revision 1.14  2012/10/12 10:50:20  narry
// Обновление
//
// Revision 1.13  2012/10/02 08:01:56  narry
// Поддержка экспортов Хаванского и МЦФР
//
// Revision 1.12  2012/07/13 11:27:26  narry
// Исправление опечаток из Арчи
//
// Revision 1.11  2012/04/17 13:21:56  narry
// Оптимизация выливки справок (356073078)
//
// Revision 1.10  2011/11/16 10:20:12  narry
// Интеграция импорта из К в сервер автоматизации (298682480)
//
// Revision 1.9  2011/08/09 09:31:20  narry
// Заливка информации в справки каждую ночь (266422146)
//

interface

uses
  evdTaskTypes
  ;

type
 TcsTaskStatus = evdTaskTypes.TcsTaskStatus;

const
 cs_tsNone = evdTaskTypes.cs_tsNone;
 cs_tsQuery = evdTaskTypes.cs_tsQuery;       { в очереди }
 cs_tsRun = evdTaskTypes.cs_tsRun;         { выполняется }
 cs_tsFrozen = evdTaskTypes.cs_tsFrozen;      { заморожено }
 cs_tsFrozenRun = evdTaskTypes.cs_tsFrozenRun;      { заморожено }
 cs_tsReadyToDelivery = evdTaskTypes.cs_tsReadyToDelivery;    { ожидание доставки пользователю }
 cs_tsDone = evdTaskTypes.cs_tsDone;        { обработано }
 cs_tsDeleted = evdTaskTypes.cs_tsDeleted;     { удалено }
 cs_tsError = evdTaskTypes.cs_tsError;       { выполнение привело к ошибке }
 cs_tsDelayed = evdTaskTypes.cs_tsDelayed;     { выполнение отложено до ЕО }
 cs_tsDelivering = evdTaskTypes.cs_tsDelivering;  { выполняется доставка результатов }
 cs_tsAsyncRun = evdTaskTypes.cs_tsAsyncRun; { Исполнение в отцепленном процессе }
 cs_tsAsyncError = evdTaskTypes.cs_tsAsyncError; { выполнение в отцепленном процессе привело к ошибке }
 cs_tsAborting = evdTaskTypes.cs_tsAborting; { выполнение прерывается }

 cs_tsErrorStatuses = evdTaskTypes.cs_tsErrorStatuses;
 cs_tsRunningStatuses = evdTaskTypes.cs_tsRunningStatuses;
 cs_tsKeepProcessingStatuses = evdTaskTypes.cs_tsKeepProcessingStatuses;
 cs_tsStatusesWithProgress = evdTaskTypes.cs_tsStatusesWithProgress;
 cs_tsCanDeleteStatuses = evdTaskTypes.cs_tsCanDeleteStatuses;
 cs_tsFinishedStatuses = evdTaskTypes.cs_tsFinishedStatuses;

type 
 TcsTaskType = evdTaskTypes.TcsTaskType;

const
 cs_ttImport = evdTaskTypes.cs_ttImport;        // Импорт
 cs_ttExport = evdTaskTypes.cs_ttExport;        // Экспорт документов
 cs_ttAutoClass = evdTaskTypes.cs_ttAutoClass;     // Автоклассификация
 cs_ttAnnoExport = evdTaskTypes.cs_ttAnnoExport;     // Экспорт специальных аннотаций
 cs_ttDictEdit = evdTaskTypes.cs_ttDictEdit;
 cs_ttRequest = evdTaskTypes.cs_ttRequest;
 cs_ttGetTask = evdTaskTypes.cs_ttGetTask;
 cs_ttLine = evdTaskTypes.cs_ttLine;
 cs_ttServerStatus = evdTaskTypes.cs_ttServerStatus;
 cs_ttTaskResult = evdTaskTypes.cs_ttTaskResult;
 cs_ttUserEdit = evdTaskTypes.cs_ttUserEdit;
 cs_ttDeleteDocs = evdTaskTypes.cs_ttDeleteDocs;
 cs_ttCommonData = evdTaskTypes.cs_ttCommonData;
 cs_ttAExportDoc = evdTaskTypes.cs_ttAExportDoc;
 cs_ttAExportAnno = evdTaskTypes.cs_ttAExportAnno;
 cs_ttRegionAutoExport = evdTaskTypes.cs_ttRegionAutoExport;
 cs_ttRunCommand = evdTaskTypes.cs_ttRunCommand;
 cs_ttDossierMake = evdTaskTypes.cs_ttDossierMake;
 cs_ttCaseCode = evdTaskTypes.cs_ttCaseCode;
 cs_ttUserDefinedExport = evdTaskTypes.cs_ttUserDefinedExport;
 cs_ttSpellCheck = evdTaskTypes.cs_ttSpellCheck;
 cs_ttAutoSpellCheck = evdTaskTypes.cs_ttAutoSpellCheck;
 cs_ttAACImport = evdTaskTypes.cs_ttAACImport;
 cs_ttRelPublish = evdTaskTypes.cs_ttRelPublish;
 cs_ttUnregistered = evdTaskTypes.cs_ttUnregistered;
 cs_ttAnoncedExport = evdTaskTypes.cs_ttAnoncedExport;
 cs_ttHavanskyExport = evdTaskTypes.cs_ttHavanskyExport;
 cs_ttRegionImport = evdTaskTypes.cs_ttRegionImport;
 cs_ttMdpSyncDicts = evdTaskTypes.cs_ttMdpSyncDicts;
 cs_ttMdpSyncStages = evdTaskTypes.cs_ttMdpSyncStages;
 cs_ttMdpSyncImport = evdTaskTypes.cs_ttMdpSyncImport;
 cs_ttMdpImportDocs = evdTaskTypes.cs_ttMdpImportDocs;
 cs_ttContainer = evdTaskTypes.cs_ttContainer;
 cs_ttSchedulerProxy = evdTaskTypes.cs_ttSchedulerProxy;
 cs_ttDownloadDoc = evdTaskTypes.cs_ttDownloadDoc;
 cs_ttUploadDoc = evdTaskTypes.cs_ttUploadDoc;

(*  TcsFileRenameMode = (cs_frmUnique//, // создать уникальное имя Для нового файла
                       //cs_frmBackup, // создать bak-копию старого файла
                       //cs_frmAdd,    // добавить в существующие
                       //cs_frmReplace // Заменить существующий
                       );*)

type
  TcsTaskTypes = set of TcsTaskType;
  //TcsTaskNotifyEvent = procedure (Sender: TObject; PrevStatus : TcsTaskStatus) of object;


const
   { TcsExecutionStatus }
  cs_arsSuccess = 0;
  cs_arsAborted = 1;
  cs_arsGeneralError = 2;
  cs_arsUtilityNotFound = 3;
   { Утилита не найдена }
  cs_arsTaskUnregistered = 4;

implementation

end.
