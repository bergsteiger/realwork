unit ArchiUserRequestManager;
{ $Id: ArchiUserRequestManager.pas,v 1.123 2016/10/05 12:04:41 lukyanets Exp $ }

// $Log: ArchiUserRequestManager.pas,v $
// Revision 1.123  2016/10/05 12:04:41  lukyanets
// Заготовка задачи
//
// Revision 1.122  2016/09/26 11:50:49  lukyanets
// Отладка
//
// Revision 1.121  2016/09/22 13:30:20  lukyanets
// Отправляем сообщение
//
// Revision 1.120  2016/09/13 07:45:01  lukyanets
// Неверное сообщение
//
// Revision 1.119  2016/09/12 12:27:53  lukyanets
// Принимаем и сохраняем
//
// Revision 1.118  2016/09/09 10:57:08  lukyanets
// Отправляем сообщение
//
// Revision 1.117  2016/08/31 10:30:11  lukyanets
// Первая доставка
//
// Revision 1.116  2016/08/30 14:11:44  lukyanets
// Пытаемся отдавать файл
//
// Revision 1.115  2016/08/29 12:51:29  lukyanets
// Принимаем запрос и готовимся отдавать файл
//
// Revision 1.114  2016/08/26 08:42:56  lukyanets
// Принимаем ответ
//
// Revision 1.113  2016/08/25 12:09:09  lukyanets
// Отправляем запрос на сервер
//
// Revision 1.112  2016/08/25 10:13:18  lukyanets
// Готовимся запрашивать сервер о получении текста документа.
//
// Revision 1.111  2016/08/24 12:50:47  lukyanets
// Готовимся запрашивать сервер о получении текста документа.
//
// Revision 1.110  2016/08/23 12:56:15  lukyanets
// Готовимся запрашивать сервер о получении текста документа.
//
// Revision 1.109  2016/06/03 07:51:36  fireton
// - недокоммит
//
// Revision 1.108  2016/06/02 13:25:22  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.107  2016/05/12 11:34:17  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.106  2016/05/11 10:16:26  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.105  2016/05/05 12:58:34  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.104  2016/04/07 13:56:40  lukyanets
// Заготовки прокси задачи
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.103  2016/04/05 08:51:30  lukyanets
// Заготовки контейнерной задачи для шедулера
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.102  2016/04/01 12:06:32  lukyanets
// Заготовки контейнерной задачи
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.101  2015/11/24 11:46:22  lukyanets
// Отладочные логи
//
// Revision 1.100  2015/10/05 11:45:33  lukyanets
// Причесываем название
//
// Revision 1.99  2015/09/08 14:38:12  lukyanets
// Заготовки импорта документов
//
// Revision 1.98  2015/09/04 13:03:41  lukyanets
// Заготовки задачи
//
// Revision 1.97  2015/07/13 11:05:34  lukyanets
// Высовываем галочку
//
// Revision 1.96  2015/04/15 13:56:12  lukyanets
// Даем клиенту возможность отменять свои задания
//
// Revision 1.95  2015/04/01 07:32:59  lukyanets
// Cleanup
//
// Revision 1.94  2015/04/01 07:17:19  lukyanets
// Cleanup
//
// Revision 1.93  2015/03/11 15:03:09  lukyanets
// Не было регистрации экспорта анонсированных
//
// Revision 1.92  2015/02/26 17:48:46  kostitsin
// Mult*y -> Multi
//
// Revision 1.91  2015/01/27 09:53:02  lukyanets
// Cleanup
//
// Revision 1.90  2015/01/27 09:23:31  lukyanets
// Фильтруем список заданий
//
// Revision 1.89  2015/01/26 15:16:32  lukyanets
// Поломалась доставка прогресса
//
// Revision 1.88  2015/01/23 06:54:21  lukyanets
// Не собиралось
//
// Revision 1.87  2015/01/22 14:31:11  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.86  2015/01/20 11:17:29  lukyanets
// Отладочная печать
//
// Revision 1.85  2015/01/19 12:17:03  lukyanets
// Отладочная печать
//
// Revision 1.84  2015/01/19 10:00:40  lukyanets
// Генерим вовремя TaskID
//
// Revision 1.83  2015/01/15 12:15:22  lukyanets
// Готовимся отвечать на запросы
//
// Revision 1.82  2015/01/14 12:28:40  lukyanets
// Заготовка по передаче файлов
//
// Revision 1.81  2015/01/13 13:23:05  lukyanets
// Не надо делать Free интерфейсам!
//
// Revision 1.80  2015/01/13 13:05:37  lukyanets
// Пересылаем задачу
//
// Revision 1.79  2014/12/29 07:13:12  lukyanets
// Не собиралось
//
// Revision 1.78  2014/12/29 06:29:43  lukyanets
// Не собиралось
//
// Revision 1.77  2014/12/25 13:57:02  lukyanets
// Показываем диалог смены каталога
//
// Revision 1.76  2014/12/25 11:27:31  lukyanets
// Исправляем каталог в потрохах
//
// Revision 1.75  2014/12/25 08:01:38  lukyanets
// Меняем таки каталог
//
// Revision 1.74  2014/12/24 13:18:13  lukyanets
// Отправляем сообщение о корректировке каталога
//
// Revision 1.73  2014/12/15 06:34:53  lukyanets
// Не собиралось
//
// Revision 1.72  2014/12/12 12:13:23  lukyanets
// Ускоряемся в 2 раза и профилируем
//
// Revision 1.71  2014/12/10 08:02:51  lukyanets
// Логирование
//
// Revision 1.70  2014/12/08 15:02:24  lukyanets
// Заготовки
//
// Revision 1.69  2014/12/05 14:02:05  lukyanets
// Заготовки
//
// Revision 1.68  2014/12/04 08:09:29  lukyanets
// Не падаем
//
// Revision 1.67  2014/12/02 13:07:15  lukyanets
// Доставляем прогресс до пользователя
//
// Revision 1.66  2014/12/02 07:10:09  lukyanets
// Отображаем в очереди задач
//
// Revision 1.65  2014/11/28 14:10:08  lukyanets
// Начинаем доставлять файлы
//
// Revision 1.64  2014/11/26 14:40:55  lukyanets
// Боремся с обрывами связи
//
// Revision 1.63  2014/11/26 13:14:21  lukyanets
// Не было адреса сервера
//
// Revision 1.62  2014/11/26 12:53:39  lukyanets
// Не собиралось
//
// Revision 1.61  2014/11/26 12:40:04  lukyanets
// Директивы компилятора
//
// Revision 1.60  2014/11/25 15:36:58  lukyanets
// Принимаем прогрес
//
// Revision 1.59  2014/11/18 09:19:05  lukyanets
// Заготовки обработчика 1 задачи
//
// Revision 1.58  2014/11/07 11:54:25  lukyanets
// Открываем соединение с клиента
//
// Revision 1.57  2014/10/22 07:02:13  lukyanets
// Cleanup
//
// Revision 1.56  2014/10/09 09:59:56  lukyanets
// Избавляемся от лишнего синглетона
//
// Revision 1.55  2014/09/24 07:16:23  lukyanets
// {RequestLink:565271071}
//
// Revision 1.54  2014/09/22 12:53:57  lukyanets
// Вычитывали таск не того класса.
//
// Revision 1.53  2014/09/19 14:00:46  lukyanets
// Регестрируем таски чтоб в лог не писалось
//
// Revision 1.52  2014/09/19 05:28:20  lukyanets
// {RequestLink:565271071} - Еще подкрутили логирование
//
// Revision 1.51  2014/09/10 09:49:13  lukyanets
// Cleanup
//
// Revision 1.50  2014/08/29 09:28:47  lukyanets
// Регистрация задачи (чтоб прогресс отражался)
//
// Revision 1.49  2014/08/25 13:38:50  lukyanets
// Переносим логику в таск
//
// Revision 1.48  2014/08/25 12:56:10  lukyanets
// Описание задач
//
// Revision 1.47  2014/08/21 12:23:32  lukyanets
// {Requestlink:563199760}. Переносим логику cs_ttAnnoExport в таск
//
// Revision 1.46  2014/08/20 10:34:42  lukyanets
// {Requestlink:558466572}. Спрямляем наследование alcuAutoClass
//
// Revision 1.45  2014/08/12 11:11:30  lukyanets
// {Requestlink:560730919}. Регистрация автоклассификации - чтоб в списке задач отражалась
//
// Revision 1.44  2014/08/08 10:01:42  lukyanets
// {Requestlink:560730919}. Завели alcuAACImport
//
// Revision 1.43  2014/07/30 13:29:18  lukyanets
// {Requestlink:556143119}. Отцепляем TalcuAutoAnnoExport
//
// Revision 1.42  2014/07/21 06:03:04  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.41  2014/07/18 15:23:20  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.40  2014/07/16 10:29:37  lukyanets
// {Requestlink:553422280}. Не нотифицируем лишний раз клиента
//
// Revision 1.39  2014/07/14 13:20:38  lulin
// - учимся читать задания из EVD.
//
// Revision 1.38  2014/07/14 11:27:30  lulin
// - учимся читать задания из EVD.
//
// Revision 1.37  2014/07/14 10:06:23  lulin
// - учимся читать задания из EVD.
//
// Revision 1.36  2014/07/09 13:13:03  lulin
// - заворачиваем список номеров документов в теги.
//
// Revision 1.35  2014/07/09 06:53:04  lukyanets
// {Requestlink:553422280}. Более адекватное название.
//
// Revision 1.34  2014/07/08 13:57:50  lukyanets
// {Requestlink:553422280}. Разбираемся с ошибочными статусами
//
// Revision 1.33  2014/07/08 07:02:53  lukyanets
// {Requestlink:552022662}. Полный цикл
//
// Revision 1.32  2014/07/07 12:10:44  lulin
// - движемся к константности TaskType.
//
// Revision 1.31  2014/07/04 14:05:47  lulin
// - движемся к константности _TaskType.
//
// Revision 1.30  2014/07/02 14:34:30  lulin
// - чистим код.
//
// Revision 1.29  2014/07/02 13:15:45  lukyanets
// {Requestlink:552022662}. Новый статус задачи
//
// Revision 1.28  2014/06/25 14:58:44  lulin
// - боремся с дубликатами.
//
// Revision 1.27  2014/06/23 16:14:40  lulin
// - применяем потокозащищённые списки.
//
// Revision 1.25  2014/06/23 15:22:14  lulin
// - чистим код.
//
// Revision 1.24  2014/06/23 15:18:01  lulin
// - "залатываем" неприход информации о заданиях.
//
// Revision 1.23  2014/06/17 10:33:22  lulin
// - переименовываем метод, чтобы название отражало его суть.
//
// Revision 1.22  2014/06/16 15:58:01  lulin
// - чистим код.
//
// Revision 1.21  2014/06/16 15:53:16  lulin
// - чистим код.
//
// Revision 1.20  2014/06/16 15:40:47  lulin
// - чистим код.
//
// Revision 1.19  2014/06/06 16:05:28  lulin
// - улучшаем диагностику.
//
// Revision 1.18  2014/06/06 13:26:14  lulin
// - чистим код.
//
// Revision 1.17  2014/06/06 13:14:13  lulin
// - чистим код.
//
// Revision 1.16  2014/06/06 09:42:54  lulin
// - чистим код.
//
// Revision 1.15  2014/06/04 16:03:17  lulin
// [$540613122]
//
// Revision 1.14  2014/06/03 15:34:09  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.13  2014/05/30 17:36:19  lulin
// - рефакторим обработку команд.
//
// Revision 1.12  2014/05/29 17:08:58  lulin
// - чистим код.
//
// Revision 1.11  2014/05/29 16:39:58  lulin
// - переименовываем безликое свойство.
//
// Revision 1.10  2014/05/21 13:57:08  lulin
// - чистим код.
//
// Revision 1.9  2014/02/12 17:14:21  lulin
// - рефакторим безликие списки.
//
// Revision 1.8  2014/02/12 12:39:10  lulin
// - рефакторим списки заданий.
//
// Revision 1.7  2013/04/19 13:04:38  lulin
// - портируем.
//
// Revision 1.6  2013/04/03 09:50:43  fireton
// - логика простановки VANONCED
//
// Revision 1.5  2012/04/19 12:48:58  voba
// - k : 358982593
//
// Revision 1.4  2012/03/06 12:10:58  narry
// Не собиралось
//
// Revision 1.3  2012/03/06 08:58:46  narry
// Переделать выбор группы доступа (273582322)
//
// Revision 1.2  2012/02/17 10:46:43  narry
// - Не доставлялся экспорт
//
// Revision 1.1  2012/02/15 13:36:50  narry
// Обновление
//
// Revision 1.62  2011/04/22 11:46:00  narry
// Большая кнопка (262636461)
//
// Revision 1.61  2010/07/22 08:44:54  narry
// К221675581. Не доставлялись результаты экспорта.
//
// Revision 1.60  2010/07/14 12:47:43  narry
// - К226001558
//
// Revision 1.59  2010/07/14 07:31:11  narry
// - К226001558
//
// Revision 1.58  2010/07/06 12:29:14  narry
// - К222759027
//
// Revision 1.57  2010/05/17 10:37:56  narry
// - K211878122
//
// Revision 1.56  2010/05/17 08:31:20  narry
// - K211878129
// - переименование типов
//
// Revision 1.55  2010/03/02 08:24:14  narry
// - изменения splash
//
// Revision 1.54  2010/02/24 10:24:24  narry
// - удаление зависимости проектов от парня
//
// Revision 1.53  2009/11/10 09:12:33  narry
// - обновление
//
// Revision 1.52  2009/07/23 08:02:43  voba
// - bug fix: Не работало без сервера
//
// Revision 1.51  2009/07/22 08:20:26  narry
// - новая процедура _KeepAlive
// - cleanup
//
// Revision 1.50  2009/07/20 13:13:31  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.49  2009/04/15 13:26:03  narry
// - был пустой список пользователей
//
// Revision 1.48  2009/04/15 08:45:10  narry
// - отвалилось уведомление о письмах
//
// Revision 1.47  2009/04/13 07:12:57  narry
// - разделение определения типов и реализации
//
// Revision 1.46  2009/03/13 15:12:47  narry
// - процедуры записи в файл информации об удалении меток с атрибутами
//
// Revision 1.45  2009/01/23 15:58:15  narry
// - переделки в сторону службы
//
// Revision 1.44  2008/11/24 12:43:54  narry
// - обновление
//
// Revision 1.43  2008/09/29 13:51:29  narry
// - без сервера не пишется мусор в лог
//
// Revision 1.42  2008/07/23 09:07:38  fireton
// - если работаем с сервером, то запрашиваем дату версии с него
//
// Revision 1.41  2008/07/21 11:45:03  fireton
// - КалеСо (версии и компиляции)
//
// Revision 1.40  2008/07/10 12:56:28  fireton
// - refactoring: типы календарных событий переехали "наверх"
//
// Revision 1.39  2008/04/23 07:27:19  narry
// - переделки для сервиса
//
// Revision 1.38  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.37  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.36  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.35  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.34  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.33  2007/12/06 11:11:58  narry
// - поддержка автоклассификации
//
// Revision 1.32  2007/09/28 05:38:19  narry
// - настройка сообщения о выходе
//
// Revision 1.31  2007/09/05 15:44:23  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - индикация передачи данных между клиентом и сервером
//
// Revision 1.30  2007/08/30 08:34:32  narry
// - Промежуточное сохранение
//
// Revision 1.29  2007/08/23 14:37:10  fireton
// - расширено событие о новом сообщении с сервера и список сообщений теперь виден снаружи
//
// Revision 1.28  2007/08/14 12:25:39  narry
// - Фоновый прием информационных сообщений
//
// Revision 1.27  2007/07/25 15:04:32  narry
// - результаты заданий приезжали кому попало
//
// Revision 1.26  2007/07/25 11:07:18  narry
// - обновление
//
// Revision 1.25  2007/07/24 14:15:37  voba
// - bug fix
//
// Revision 1.24  2007/07/24 12:32:29  narry
// - рефакторинг системы сообщений
//
// Revision 1.23  2006/11/28 11:19:28  narry
// - ошибка: подвисание Арчи при получении сообщения от сервера
//
// Revision 1.22  2006/10/11 07:58:03  narry
// - Ловушка
//
// Revision 1.21  2006/09/21 09:59:54  narry
// no message
//
// Revision 1.20  2006/09/15 06:50:57  narry
// - починка обмена сообщениями между сервером и клиентом
//
// Revision 1.19  2006/09/14 08:11:27  narry
// - борьба с бесконечным циклом обработки сообщений
//
// Revision 1.18  2006/09/07 08:57:06  narry
// - борьба с пропадающими запросами
//
// Revision 1.17  2006/09/01 13:59:20  narry
// no message
//
// Revision 1.16  2006/08/29 09:24:01  voba
// - борьба c AV
//
// Revision 1.15  2006/08/28 12:55:40  narry
// - клиент не получал уведомление о повторной регистрации
//
// Revision 1.14  2006/08/25 14:46:54  narry
// - защита от зацикливания
//
// Revision 1.13  2006/08/25 11:35:11  narry
// - письма не забирались с сервера
//
// Revision 1.12  2006/08/04 09:28:46  narry
// - Лечение мигающих окошек
//
// Revision 1.11  2006/08/04 09:01:00  narry
// - заплатка от мигания сообщения о постановке задания в очередь
//
// Revision 1.10  2006/08/02 12:18:38  narry
// - ловушка для сообщений с сервера
//
// Revision 1.9  2006/06/14 12:25:06  narry
// - новое: переход на новый механизм рассылки нотификаций
//
// Revision 1.8  2006/06/05 14:56:20  narry
// - новое: перевод на новый механизм рассылки нотификаций
//
// Revision 1.7  2006/04/05 08:20:17  narry
// - изменение: добавлен лог CVS
//

interface

{$Include w:\archi\source\projects\Archi\arDefine.inc}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  l3Base,
  daArchiUser,
  daArchiUserList,
  daTypes,
  m3DBInterfaces,
  dt_Types,
  CSClient, CSNotification, CsQueryTypes,
  csProcessTask, CsDataPipe, l3Types,
  l3ObjectRefList, ddCalendarEvents,
  csTaskTypes, csServerTaskTypes, csTaskRequest, csClientCommandsManager,
  csUploadDocStream,
  Menus, csUserRequestManager, l3LongintList,
  ddServerTask,
  Dt_EFltr, m4DocumentAddress,
  ncsMessage,

  ddServerTaskListPrim,
  ddTaskItemList,
  SyncObjs,

  l3MultiThreadIntegerList,
  arResultDeliverer, arResultDeliveryInterfaces
  ;

type
  TOnAnouncedDateChanged = procedure(aNewDate: TDateTime) of object;

  TCorrectExportFolderEvent = procedure (var aFolder: AnsiString; var aResult: Boolean) of object;

  TArchiUserRequestManager = class(TcsUserRequestManager, IarResultDelivererListner)
  private
   f_MyTaskList: TddTaskItemList;
   f_TaskList: TddTaskItemList;
   f_UserList: TdaArchiUserList;
   f_EnabledTasks: TcsTaskTypes;
   f_ExecuteEnabled: Boolean;
   f_OnAnouncedDateChanged: TOnAnouncedDateChanged;
   f_OnProgressProc: Tl3ProgressProc;
   f_ToRegionList: Tl3MultiThreadIntegerList;
   f_DeliveryGuard: TCriticalSection;
   f_ResultDeliverer: TarResultDeliverer;
   f_OnCorrectExportFolder: TCorrectExportFolderEvent;
   f_TerminatingTaskID: AnsiString;
   procedure ChangeTaskProgress(const aTaskID: AnsiString; aProgress: Integer);
   procedure Checktask(const aTaskID: AnsiString; aTaskStatus: TcsTaskStatus);
   function FindTask(const aTaskID: AnsiString; out theTask, theMyTask: TddTaskItem): Boolean;
   function makeTaskComment(Progress: Integer): AnsiString;
   procedure RegisterTaskTypes;
   function SendRequest(theRequest: TCsQueryId): Boolean;
   procedure ShowTaskIndex(const aTaskID: AnsiString{; aIndex: Integer});
   procedure pipe_ReadAllUsersList(aPipe: TcsDataPipe);
   procedure pipe_ReadAnouncedDate(aPipe: TcsDataPipe);
   procedure pipe_ReadDictChangeFileName(aPipe: TcsDataPipe);
   procedure pipe_ReadToRegionList(aPipe: TcsDataPipe);
   procedure pipe_TerminateTask(aPipe: TcsDataPipe);
   function CorrectExportFolder(var theFolder: AnsiString): Boolean;
   procedure CheckTaskExistence(const aTaskID: String);
   procedure ReportResult(const aResult: String);
   procedure DoTerminateTask(aTaskID: AnsiString);
  protected
   procedure CheckTaskExistance(const aTaskID: AnsiString);
   procedure RequestSendMessage(const aMessage: AnsiString);
   function RequestNewFolder(var aFolder: AnsiString): Boolean;
   procedure ChangeResultFolder(const aTaskID: AnsiString;
    const aNewFolder: AnsiString);
  protected
   procedure Cleanup; override;
   procedure ProcessNotify(aType: TcsNotificationType; aData: Integer; const
       aText: AnsiString); override;
   procedure DoProcessNotifyList; override;
   procedure DoServerStatusChanged; override;
   procedure AfterTaskSended(aTask: TddProcessTask); override;
   function NeedExecuteInMainThreadService: Boolean; override;
  public
   constructor Create; override;
   function GetLine: Boolean;
//   function GetTaskResult(const aTaskID: String): Boolean;
   procedure ShowTaskList;
   function StartMonitoringLine: Boolean;
   function StopMonitoring: Boolean;
   procedure RequestTerminateCommunication; override;
   property EnabledTasks: TcsTaskTypes read f_EnabledTasks write f_EnabledTasks;
   property ExecuteEnabled: Boolean read f_ExecuteEnabled write f_ExecuteEnabled;
   property ToRegionList: Tl3MultiThreadIntegerList read f_ToRegionList;
   function AddTaskToLIst(const aTaskID: AnsiString; aList: TddTaskItemList): Boolean;
   procedure DeleteDocs(aDataIndex: Integer);
   procedure GetDictChangeFileName;
   function SendSpellCorrecttask: Boolean;
   procedure RequestResultsDelivery(aForce: Boolean = False);
   procedure RequestAnouncedDate;
   procedure RequestToRegionList;
   procedure RequestUsersList;
   function SendAnnotationExportTask: Boolean;
   function SendAutoclassifyTask: Boolean;
   procedure RequestShowMessage(const aMessage: AnsiString);
   function DownloadDocStream(aDocFamily: TdaFamilyID;
    aDocID: TdaDocID; anIsObjTopic: Boolean; const aDocumentType: String;
    aDocPart: Tm3DocPartSelector; aLevel: Integer; WithAttr: Boolean;
    DocPartSel: TDocPartSelector; aFoundSelector: Tm4Addresses; out theStream: IStream): Boolean;
   function UploadDocStream(const aMessage: TcsUploadDocStream): Boolean;
   function SendRequestWithReply(const aMessage: TncsMessage): TncsReply;
   property OnAnouncedDateChanged: TOnAnouncedDateChanged read f_OnAnouncedDateChanged write f_OnAnouncedDateChanged;
   property OnProgressProc: Tl3ProgressProc read f_OnProgressProc write
       f_OnProgressProc;
   property OnCorrectExportFolder: TCorrectExportFolderEvent
       read f_OnCorrectExportFolder
       write f_OnCorrectExportFolder;
  end;//TArchiUserRequestManager


function ArchiRequestManager: TArchiUserRequestManager;

implementation

Uses
 Math, StrUtils,
 daInterfaces,
 daDataProvider,
 ddTaskListDlg, ddUtils,
 csMessageManager,
 csDownloadDocStream,
 csDownloadDocStreamReply,
 ncsDocStorageTransferReg,
 m3DocumentAddress,
 dt_Dict, dt_Mail,
 vConst,
 l3Memory,
 IdException, DateUtils, dt_DictConst, dt_Const, TypInfo, csLineRequest,
 csServerStatusRequest, csExportResultRequest, csImport, csCommonDataRequest, csRequestTask,
 l3FileUtils, csSpellCorrectTask, CsExport,
  ncsMessageInterfaces, ncsSynchroCompatibilityClientTransporter,
  csCommandsManager, csAutoAnnoExport, csAACImport, csAutoClassTask, csAnnotationTask,
  csAutoSpell, arDeliveryList, csRelPublishTask, l3StopWatch, csMdpSyncDicts, csMdpImportDocs,
  csContainerTask, csSchedulerProxyTask, csMdpSyncStages, csMdpSyncImport,
  csUploadDocStreamReply, csDeliveryProfileTask,
 StrShop,
 AutoClassTask_Const,
 k2Base,
 l3ExecuteInMainThread,
 l3AsyncTask,
 l3Utils
 ;

const
  MaxTryCount = 10;

function ArchiRequestManager: TArchiUserRequestManager;
begin
 Assert(UserRequestManager is TArchiUserRequestManager);
 Result := TArchiUserRequestManager(UserRequestManager);
end;

type
 TCheckTaskExistance = class(Tl3AsyncTask)
 private
  f_Manager: TArchiUserRequestManager;
  f_TaskID: AnsiString;
 public
  constructor Create(const aManager: TArchiUserRequestManager; const aTaskID: AnsiString);
  procedure Exec; override;
 end;

 TRequestSendMessage = class(Tl3AsyncTask)
 private
  f_Manager: TArchiUserRequestManager;
  f_Message: AnsiString;
 public
  constructor Create(const aManager: TArchiUserRequestManager; const aMessage: AnsiString);
  procedure Exec; override;
 end;

 TRequestNewFolder = class(Tl3AsyncTask)
 private
  f_Manager: TArchiUserRequestManager;
  f_Folder: AnsiString;
  f_Success: Boolean;
 public
  constructor Create(const aManager: TArchiUserRequestManager; const aFolder: AnsiString);
  procedure Exec; override;
  property IsSuccess: Boolean read f_Success;
  property Folder: AnsiString read f_Folder;
 end;

 TChangeResultFolder = class(Tl3AsyncTask)
 private
  f_Manager: TArchiUserRequestManager;
  f_TaskID: AnsiString;
  f_NewFolder: AnsiString;
 public
  constructor Create(const aManager: TArchiUserRequestManager; const aTaskID, aNewFolder: AnsiString);
  procedure Exec; override;
 end;

{
**************************** TArchiUserRequestManager *****************************
}
constructor TArchiUserRequestManager.Create;
begin
 inherited;
 f_DeliveryGuard := TCriticalSection.Create;
 f_TaskList := TddTaskItemList.Make;
 f_MyTaskList := TddTaskItemList.Make;
 f_UserList := TdaArchiUserList.Make;
// f_ActiveUserList := TArchiUserList.Make;
 f_ToRegionList:= Tl3MultiThreadIntegerList.Create;
 RegisterTaskTypes;

 Tl3ExecuteInMainThread.Instance.Init;
 f_ResultDeliverer := TarResultDeliverer.Create(Self);
 ncsDocStorageTransferReg.ncsClientRegister;
end;

procedure TArchiUserRequestManager.Checktask(const aTaskID: AnsiString; aTaskStatus: TcsTaskStatus);
var
 l_Task, l_MyTask: TddTaskItem;
 l_Show: Boolean;
begin
  if FindTask(aTaskID, l_Task, l_MyTask) then
  begin
   if l_Task <> nil then
   begin
    if (l_Task Is TddProcessTask) then
    begin
     TddProcessTask(l_Task).StatusW := aTaskStatus;
     TddProcessTask(l_Task).SetCommentToDefault;
    end;//l_Task Is TddProcessTask
   end;
   if (l_MyTask <> nil) AND (l_MyTask Is TddProcessTask) then
   begin
    l_Show := TddProcessTask(l_MyTask).Status <> aTaskStatus;
    TddProcessTask(l_MyTask).StatusW := aTaskStatus;
    TddProcessTask(l_MyTask).SetCommentToDefault;
    if l_Show then
    begin
     {if l_MyTask.Status = cs_tsQuery then
      ShowMessage(Format('Задание на %s добавлено в очередь', [TaskTypeNames[l_MyTask._TaskType]]))
     else}
     { TODO : Разобраться с описанием задач }
     (*
     if l_MyTask.Status = cs_tsRun then
      ShowMessage(Format('Задание на %s выполняется', [TaskTypeNames[l_MyTask._TaskType].Description]))
     else
     if l_MyTask.Status = cs_tsDeleted then
      ShowMessage(Format('Задание на %s удалено из очереди', [TaskTypeNames[l_MyTask._TaskType].Description]))
     *)
     if TddProcessTask(l_MyTask).Status = cs_tsRun then
      ShowMessage(Format('Задание "%s" выполняется', [l_MyTask.Description]))
     else
       if TddProcessTask(l_MyTask).Status = cs_tsAsyncRun then
        ShowMessage(Format('Задание "%s" выполняется асинхронно', [l_MyTask.Description]))
       else
        if TddProcessTask(l_MyTask).Status = cs_tsDeleted then
         ShowMessage(Format('Задание "%s" удалено из очереди', [l_MyTask.Description]))
        else
         if TddProcessTask(l_MyTask).Status in cs_tsErrorStatuses then
          ShowMessage(Format('Выполнение задания "%s" завершилось ошибкой', [l_MyTask.Description]))

    end; // l_Show
   end; // l_MyTask <> nil
  end // FindTask
  else
  if {(aTaskStatus = cs_tsQuery) and} (TaskListDialog <> nil) then
  begin
   // Добавляем новую задачу, если наблюдаем за очередью
   AddTaskToList(aTaskID, TaskListDialog.TaskLst);
  end; // (aTaskStatus = cs_tsQuery) and (TaskListDialog <> nil)
  // Обновить визуалку, если она есть
  if TaskListDialog <> nil then
   TaskListDialog.UpdateListView;
end;

procedure TArchiUserRequestManager.Cleanup;
begin
 f_ResultDeliverer.TerminateProcess;
 FreeAndNil(f_ResultDeliverer);
 FreeAndNil(f_UserList);
// FreeAndNil(f_ActiveUserList);
 FreeAndNil(f_MyTaskList);
 FreeAndNil(f_TaskList);
 FreeAndNil(f_ToregionList);
 FreeAndNil(f_DeliveryGuard);
 inherited;
end;

function TArchiUserRequestManager.FindTask(const aTaskID: AnsiString; out theTask,
    theMyTask: TddTaskItem): Boolean;
var
 i: Integer;
 l_task: TddTaskItem;
begin
 theTask := nil;
 theMyTask := nil;
 for i:= 0 to f_TaskList.Hi do
 begin
  l_Task := f_TaskList.Items[i];
  if l_Task.TaskID = aTaskID then
  begin
   theTask := l_Task;
   break;
  end; // l_Task.TaskID = aTasskID
 end; // for i
 for i:= 0 to f_MyTaskList.Hi do
 begin
  l_Task := f_MyTaskList.Items[i];
  if (l_Task.TaskID = aTaskID) and (l_task.UserID = CSClient.ClientId) then
  begin
   theMyTask := l_Task;
   break;
  end; // l_Task.TaskID = aTasskID
 end; // for i
 if (theMyTask = nil) then
  if (theTask <> nil) then
   if (theTask.UserID = CSClient.ClientId) then
   begin
    AddTaskToList(theTask.TaskID, f_MyTaskList);
    theMyTask := theTask;
   end;//theTask.UserID = CSClient.ClientId
 Result := (theTask <> nil) or (theMyTask <> nil);
end;

function TArchiUserRequestManager.GetLine: Boolean;
var
 l_LineRequest : TcsLineRequest;
begin
 // Получить ВСЮ очередь заданий
 Result := False;
 StartMonitoringLine;
 if CSClient <> nil then
 begin
  l_LineRequest:= TcsLineRequest.Create(csClient.ClientID);
  try
   if CSClient.Exec(qtAllLine, l_LineRequest.SaveRequestToPipe) then
   begin
    Result := True;
    f_TaskList.Assign(l_LineRequest.TaskList);
   end;
  finally
   FreeAndNil(l_LineRequest);
  end;
 end; // CSClient <> nil
end;
(*
function TArchiUserRequestManager.GetTaskResult(const aTaskID: String): Boolean;
var
 l_TaskResult : TddTaskResultRequest;
 l_Task1, l_Task2: TddTaskItem;
 l_ExportResult: TcsExportResultRequest;
begin
 Result := False;
 if not FindTask(aTaskID, l_Task1, l_Task2) then
 begin
  if AddTaskToList(aTaskID, f_MyTaskList) then
   FindTask(aTaskID, l_Task1, l_Task2);
 end;
 if (CSClient <> nil) and (l_Task2 <> nil) then
 begin

  if not (l_Task2 Is TddProcessTask) then
   Exit;
  if (TddProcessTask(l_Task2).Status = cs_tsDone) then
   Exit;

  if l_Task2 is TcsExport then
    begin
     l_ExportResult:= TcsExportResultRequest.MakeFromTask(l_Task2 As TcsExport);
     try
      l_ExportResult.DestFolder:= (l_task2 as TcsExport).ExportDirectory;
      Result:= CSClient.Exec(qtTaskResult, l_ExportResult.SaveRequestToPipe);
      if Result and l_ExportResult.Success then
       ShowMessage(Format('Результаты экспорта помещены в папку %s', [(l_Task2 as TcsExport).ExportDirectory]))
      else
       ShowMessage(Format('Не удалось доставить результаты экспорта в папку %s', [(l_Task2 as TcsExport).ExportDirectory]));
     finally
      FreeAndNil(l_ExportResult);
     end;
    end
  else
  if l_Task2 is TcsImportTaskItem then
    begin
     l3System.Str2Log('RESULT DELIVERY ASSERT');
    { TODO : Нужно сделать унифицированную обработку результатов задачи }
     l_TaskResult:= TddTaskResultRequest.MakeFromTask(l_Task2 As TcsImportTaskItem);
     try
      if CSClient.Exec(qtTaskResult, l_TaskResult.SaveRequestToPipe) then
      begin
       Result := True;
      end;
     finally
      FreeAndNil(l_TaskResult);
     end;
    end;
 end; // CSClient <> nil
end;
*)
function TArchiUserRequestManager.AddTaskToLIst(const aTaskID: AnsiString; aList: TddTaskItemList): Boolean;
var
 l_TaskRequest : TddGetTaskRequest;
begin
 Result := False;
 if CSClient <> nil then
 begin
  l_TaskRequest:= TddGetTaskRequest.Create(CSClient.ClientID);
  try
   l_TaskRequest.SetTaskID(aTaskID);
   if CSClient.Exec(qtGetTask, l_TaskRequest.SaveRequestToPipe) then
   begin
    Result := True;
    if (l_TaskRequest.Task = nil) then
     l3System.Str2Log('Не удалось получить информацию о задаче ' + aTaskID)
    else
     aList.Add(l_TaskRequest.Task);
   end;//CSClient.Exec(qtGetTask, l_TaskRequest.Communicate)
  finally
   FreeAndNil(l_TaskRequest);
  end;
 end; // CSClient <> nil
end;

procedure TArchiUserRequestManager.ChangeTaskProgress(const aTaskID: AnsiString; aProgress: Integer);
var
 l_Task, l_MyTask: TddTaskItem;
begin
 if FindTask(aTaskID, l_Task, l_MyTask) then
 begin
  if (l_Task <> nil) AND (l_Task Is TddProcessTask) then
   TddProcessTask(l_Task).SetProgress(aProgress, '');
  if (l_MyTask <> nil) AND (l_MyTask Is TddProcessTask) then
   TddProcessTask(l_MyTask).SetProgress(aProgress, '');
  // Обновить визуалку, если она есть
  if TaskListDialog <> nil then
   TaskListDialog.UpdateListView;
 end; // FindTask
end;


procedure TArchiUserRequestManager.DeleteDocs(aDataIndex: Integer);
var
 l_Q: TddCommonDataRequest;
 Index: Integer;
begin
 // Запросить у сервера список удаленных документов и обновить открытые выборки
 if CSClient <> nil then { TODO 1 -oДмитрий Дудко -cРазвитие : Заменить на Assert все подобные фрагменты }
 begin
  l_Q:= TddCommonDataRequest.Create(CSClient.ClientID, aDataIndex);
  try
   //l_Q.DataIndex := aDataIndex;
   if CSClient.Exec(qtGetCommonData, l_Q.SaveRequestToPipe) then
   begin;
    for Index := 0 to Pred(l_Q.DeleteDocsQuery.DocumentIDList.Count) do
     Windows.SendMessage(Application.MainForm.Handle, wm_DelDoc, 0, l_Q.DeleteDocsQuery.DocumentIDList.Items[Index]);
   end; // CSClient.Exec(qtGetCommonData, l_Q.SaveRequestToPipe)
  finally
   FreeAndNil(l_Q);
  end;
  Windows.SendMessage(Application.MainForm.Handle, wm_RefreshDocs, 0, 0);
 end; // CSClient <> nil
end;

procedure TArchiUserRequestManager.GetDictChangeFileName;
begin
 if CSClient <> nil then
   if CSClient.Exec(qtGetDictChangeFileName, pipe_ReadDictChangeFileName) then
end;

function TArchiUserRequestManager.SendSpellCorrecttask: Boolean;
var
 l_Task: TcsSpellCorrectTask;
 l_FileName: String;
begin
 if PromptForFileName(l_FileName) then
 begin
  l_Task := TcsSpellCorrectTask.Create(CSClient.ClientId);
  try
   l_Task.ReplacementFile.Name := l_FileName;
   Result := SendTask(l_Task);
  finally
   FreeAndNil(l_Task);
  end;//try..finally
 end;//PromptForFileName(l_FileName)
end;

function TArchiUserRequestManager.makeTaskComment(Progress: Integer): AnsiString;
begin
 case Progress of
   -1: Result := 'Подсчет объема документов';
  else
   Result := Format('Осталось %s', [TimeSec2Str(Progress)]);
 end;//case Progress
end;

procedure TArchiUserRequestManager.RegisterTaskTypes;
begin
 RegisterTaskClass(cs_ttImport, TcsImportTaskItem, 'Задание на импорт документов');
 RegisterTaskClass(cs_ttExport, TcsExport, 'Задание на экспорт');
 RegisterTaskClass(cs_ttAExportAnno, TcsAutoAnnoExport, 'Задание на автоматический экспорт аннотаций');
 RegisterTaskClass(cs_ttAACImport, TcsAACImport, 'Задание на импорт подготовленных постановлений');
 RegisterTaskClass(cs_ttAutoClass, TcsAutoClassTask, 'Задание на автоклассификацию');
 RegisterTaskClass(cs_ttAnnoExport, TcsAnnotationTask, 'Задание на экспорт Прайм');
 RegisterTaskClass(cs_ttAutoSpellCheck, TcsAutoSpellTask, 'Задание на автоматическую проверку орфографии');
 RegisterTaskClass(cs_ttSpellCheck, TcsSpellCorrectTask, 'Проверка опечаток');
 RegisterTaskClass(cs_ttRelPublish, TcsRelPublishTask, 'Дополнение справок');
 RegisterTaskClass(cs_ttAnoncedExport, TcsExport, 'Экспорт анонсированных');
 RegisterTaskClass(cs_ttMdpSyncDicts, TcsMdpSyncDicts, 'Синхронизация словарей в Гардок');
 RegisterTaskClass(cs_ttMdpSyncStages, TcsMdpSyncStages, 'Синхронизация этапов в Гардок');
 RegisterTaskClass(cs_ttMdpSyncImport, TcsMdpSyncImport, 'Синхронизация журнала импорта в Гардок');
 RegisterTaskClass(cs_ttMdpImportDocs, TcsMdpImportDocs, 'Импорт документов из Гардока');
 RegisterTaskClass(cs_ttContainer, TcsContainerTask, 'Групповая задача');
 RegisterTaskClass(cs_ttSchedulerProxy, TcsSchedulerProxyTask, 'Задание планировщика');
 RegisterTaskClass(cs_ttDeliveryProfile, TcsDeliveryProfileTask, 'Проверка скорости доставки');
end;

procedure TArchiUserRequestManager.RequestUsersList;
begin
 // Запрашиваем у сервера список *всех* пользователей. У активных должен стоять флажок
 if CSClient.IsStarted and f_UserList.Empty then
  CSClient.Exec(qtGetAllUsersList, pipe_ReadAllUsersList);
end;

procedure TArchiUserRequestManager.ShowTaskList;
begin
 if f_UserList.Empty then
  RequestUsersList;

 TaskListDialog := TTaskListDialog.Create(nil);
 try
  TaskListDialog.UserList:= f_UserList;
  TaskListDialog.MyUserID := CSClient.ClientId;
  TaskListDialog.TaskLst := f_TaskList;
  TaskListDialog.OnTerminateTask := DoTerminateTask;
  TaskListDialog.Execute;
 finally
  FreeAndNil(TaskListDialog);
 end;
end;

function TArchiUserRequestManager.StartMonitoringLine: Boolean;
begin
 Result := SendRequest(qtStartMonitoring);
end;

function TArchiUserRequestManager.StopMonitoring: Boolean;
begin
 Result := SendRequest(qtEndMonitoring);
end;

function TArchiUserRequestManager.SendAnnotationExportTask: Boolean;
var
 l_Task : TcsAnnotationTask;
begin
 Result := False;
 l_Task := TcsAnnotationTask.Create(CSClient.ClientID);
 try
  Result := SendTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

function TArchiUserRequestManager.SendAutoclassifyTask: Boolean;
var
 l_Task : TddProcessTask;
begin
 Result := False;
 l_Task := TcsAutoClassTask.Create(CSClient.ClientId);
 try
  Result := SendTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

function TArchiUserRequestManager.SendRequest(theRequest: TCsQueryId): Boolean;
var
 l_Request: TddRequestTaskAsTask;
begin
 Result := False;
 if CSClient <> nil then
 begin
  l_Request:= TddRequestTaskAsTask.Create(CSClient.ClientID);
  try
   //l_Request.UserID := CSClient.ClientId;
   if CSClient.Exec(theRequest, l_Request.SaveTaskToPipe) then
    Result := True;
  finally
   FreeAndNil(l_Request);
  end;
 end; // CSClient <> nil;
end;

procedure TArchiUserRequestManager.ShowTaskIndex(const aTaskID: AnsiString{; aIndex: Integer});
var
 l_Task, l_MyTask: TddTaskItem;
begin
 if FindTask(aTaskID, l_Task, l_MyTask) then
 begin
  if (l_MyTask <> nil) {and (aIndex >= 0)}{ and (l_MyTask.Status <> cs_tsQuery)} then
   //ShowMessage(Format('Задание на %s добавлено в очередь под номером %d', [TaskTypeNames[l_MyTask._TaskType].Description, Succ(aIndex)]))
   //ShowMessage(Format('Задание "%s" добавлено в очередь под номером %d', [l_MyTask.Description, Succ(aIndex)]))
   ShowMessage(Format('Задание "%s" добавлено в очередь', [l_MyTask.Description]))
 end // FindTask
end;

procedure TArchiUserRequestManager.pipe_ReadAllUsersList(aPipe: TcsDataPipe);
var
 l_Count, i: Integer;
 l_Stream: TStream;
 l_User: IdaArchiUser;
begin
 f_UserList.Clear;
 l_Count:= aPipe.ReadInteger;
 l_Stream:= Tl3MemoryStream.Make();
 try
  // поток, содержащий всех пользователей
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  for i:= 0 to Pred(l_Count) do
  begin
   l_User := TdaArchiUser.Make(GlobalDataProvider.UserManager.PriorityCalculator);
   try
    l_User.Load(l_Stream);
    f_UserList.Add(l_User);
   finally
    l_user := nil;
   end;
  end; // for i
 finally
  FreeAndNil(l_Stream);
 end;
end;

procedure TArchiUserRequestManager.pipe_ReadAnouncedDate(aPipe: TcsDataPipe);
begin
 f_OnAnouncedDateChanged(aPipe.ReadDateTime);
end;

procedure TArchiUserRequestManager.pipe_ReadDictChangeFileName(aPipe: TcsDataPipe);
begin
 DictChangeFileName := aPipe.ReadLn;
end;

procedure TArchiUserRequestManager.pipe_ReadToRegionList(aPipe: TcsDataPipe);
var
 i, l_Count, l_ID: Integer;
begin
 f_ToRegionList.Clear;
 l_Count:= aPipe.ReadInteger;
 for i:= 0 to Pred(l_Count) do
 begin
  l_ID:= aPipe.ReadInteger;
  f_ToRegionList.Add(l_ID);
 end;
end;

procedure TArchiUserRequestManager.ProcessNotify(aType: TcsNotificationType;
    aData: Integer; const aText: AnsiString);
begin
 inherited;
 case aType of
  ntTaskChanged:
   Checktask(aText, TcsTaskStatus(aData));
  ntTaskAdded:
   ShowTaskIndex(aText{, aData});
  ntTaskProgress:
   ChangeTaskProgress(aText, aData);
  //Это в inherited!!! // ntDictEdit       : DictServer(CurrentFamily).CSClientNotify(aType, aData, aText); //Нужно проверить пользуется ли этик кто-нибудь
  ntMailArrived:
   mailserver.ReciveMessage(aData); // прочитать  почту
  ntDelDoc:
   DeleteDocs(aData);
  ntAnouncedDateChanged:
   RequestAnouncedDate;
  ntResultsReadyForDelivery:
   begin
    f_ResultDeliverer.RequestDelivery;
    RequestResultsDelivery;
   end;
 end;//case aType
end;

procedure TArchiUserRequestManager.RequestAnouncedDate;
begin
 if (CSClient <> nil) and Assigned(f_OnAnouncedDateChanged) then
  CSClient.Exec(qtGetAnouncedDate, pipe_ReadAnouncedDate);
end;

procedure TArchiUserRequestManager.RequestToRegionList;
begin
 // Запрашиваем у сервера список Групп Доступа "переданные в регион"
 if CSClient.IsStarted then
  CSClient.Exec(qtGetToRegionList, pipe_ReadToRegionList);
end;

procedure TArchiUserRequestManager.RequestResultsDelivery(aForce: Boolean = False);
begin
 if ServerOnline then
 begin
  if (aForce or f_ResultDeliverer.CanRequestDelivery) then
  begin
   f_ResultDeliverer.ServerHost := CSClient.ServerIp;
   f_ResultDeliverer.ServerPort := CSClient.ServerPort;
   f_ResultDeliverer.ClientID := CSClient.ClientID;
   f_ResultDeliverer.Suspended := False;
  end;
  if f_ResultDeliverer.HasReadyToDeliveryData then
   PostThreadMessage(MainThreadID, WM_NULL, 0, 0);
 end;
end;

procedure TArchiUserRequestManager.DoProcessNotifyList;
begin
 inherited;
 if f_ResultDeliverer.HasReadyToDeliveryData then
  RequestResultsDelivery;
end;

procedure TArchiUserRequestManager.DoServerStatusChanged;
begin
 inherited;
 if ServerOnline then
  RequestResultsDelivery;
end;

procedure TArchiUserRequestManager.CheckTaskExistence(
  const aTaskID: String);
var
 l_Task1, l_Task2: TddTaskItem;
begin
 if not FindTask(aTaskID, l_Task1, l_Task2) then
 begin
  if AddTaskToList(aTaskID, f_MyTaskList) then
   FindTask(aTaskID, l_Task1, l_Task2);
 end;
end;

procedure TArchiUserRequestManager.ReportResult(const aResult: String);
begin
  ShowMessage(aResult)
end;

procedure TArchiUserRequestManager.RequestTerminateCommunication;
begin
 inherited;
 f_ResultDeliverer.TerminateProcess;
end;

procedure TArchiUserRequestManager.ChangeResultFolder(const aTaskID,
  aNewFolder: AnsiString);
var
 l_Task: TChangeResultFolder;
begin
 l_Task := TChangeResultFolder.Create(Self, aTaskID, aNewFolder);
 try
  Tl3ExecuteInMainThread.Instance.AsyncExec(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

procedure TArchiUserRequestManager.CheckTaskExistance(
  const aTaskID: AnsiString);
var
 l_Task: TCheckTaskExistance;
begin
 l_Task := TCheckTaskExistance.Create(Self, aTaskID);
 try
  Tl3ExecuteInMainThread.Instance.AsyncExec(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

function TArchiUserRequestManager.RequestNewFolder(
  var aFolder: AnsiString): Boolean;
var
 l_Task: TRequestNewFolder;
begin
 l_Task := TRequestNewFolder.Create(Self, aFolder);
 try
  Tl3ExecuteInMainThread.Instance.SyncExec(l_Task);
  Result := l_Task.IsSuccess;
  if Result then
   aFolder := l_Task.Folder;
 finally
  FreeAndNil(l_Task);
 end;
end;

procedure TArchiUserRequestManager.RequestSendMessage(
  const aMessage: AnsiString);
var
 l_Task: TRequestSendMessage;
begin
 l_Task := TRequestSendMessage.Create(Self, aMessage);
 try
  Tl3ExecuteInMainThread.Instance.AsyncExec(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

{ TCheckTaskExistance }

constructor TCheckTaskExistance.Create(
  const aManager: TArchiUserRequestManager; const aTaskID: AnsiString);
begin
 inherited Create;
 f_Manager := aManager;
 f_TaskID := aTaskID;
end;

procedure TCheckTaskExistance.Exec;
begin
 f_Manager.CheckTaskExistence(f_TaskID);
end;

{ TRequestSendMessage }

constructor TRequestSendMessage.Create(
  const aManager: TArchiUserRequestManager; const aMessage: AnsiString);
begin
 inherited Create;
 f_Manager := aManager;
 f_Message := aMessage;
end;

procedure TRequestSendMessage.Exec;
begin
 f_Manager.ShowMessage(f_Message);
end;

{ TChangeResultFolder }

constructor TChangeResultFolder.Create(
  const aManager: TArchiUserRequestManager; const aTaskID,
  aNewFolder: AnsiString);
begin
 f_Manager := aManager;
 f_TaskID := aTaskID;
 f_NewFolder := aNewFolder;
end;

procedure TChangeResultFolder.Exec;
var
 l_Task, l_MyTask: TddTaskItem;
begin
 if f_Manager.FindTask(f_TaskID, l_Task, l_MyTask) then
 begin
  if (l_Task <> nil) AND (l_Task Is TcsExport) then
  begin
   TcsExport(l_Task).ExportDirectory := f_NewFolder;
   TcsExport(l_Task).Description := TcsExport(l_Task).DefaultDescription;
  end;
  if (l_MyTask <> nil) AND (l_MyTask Is TcsExport) then
   TcsExport(l_MyTask).ExportDirectory := f_NewFolder;
   TcsExport(l_MyTask).Description := TcsExport(l_MyTask).DefaultDescription;
  // Обновить визуалку, если она есть
  if TaskListDialog <> nil then
   TaskListDialog.UpdateListView;
 end; // FindTask
end;

{ TRequestNewFolder }

constructor TRequestNewFolder.Create(const aManager: TArchiUserRequestManager; const aFolder: AnsiString);
begin
 inherited Create;
 f_Manager := aManager;
 f_Folder := aFolder;
 f_Success := False;
end;

procedure TRequestNewFolder.Exec;
begin
 f_Success := f_Manager.CorrectExportFolder(f_Folder);
end;

function TArchiUserRequestManager.CorrectExportFolder(
  var theFolder: AnsiString): Boolean;
begin
 Result := False;
 if Assigned(f_OnCorrectExportFolder) then
  f_OnCorrectExportFolder(theFolder, Result)
 else
  Result := False;
end;

procedure TArchiUserRequestManager.AfterTaskSended(aTask: TddProcessTask);
begin
  inherited;
  f_MyTaskList.Add(aTask); // Чтобы можно было отслеживать статус ?
end;

function TArchiUserRequestManager.NeedExecuteInMainThreadService: Boolean;
begin
 Result := True;
end;

procedure TArchiUserRequestManager.DoTerminateTask(aTaskID: AnsiString);
begin
 if CSClient.IsStarted then
 begin
  f_TerminatingTaskID := aTaskID;
  CSClient.Exec(qtalcuTerminateTask, pipe_TerminateTask);
 end;
end;

procedure TArchiUserRequestManager.pipe_TerminateTask(aPipe: TcsDataPipe);
begin
 aPipe.WriteLn(f_TerminatingTaskID); 
end;

procedure TArchiUserRequestManager.RequestShowMessage(const aMessage: AnsiString);
begin
 RequestSendMessage(aMessage);
end;

function TArchiUserRequestManager.DownloadDocStream(aDocFamily: TdaFamilyID;
  aDocID: TdaDocID; anIsObjTopic: Boolean; const aDocumentType: String;
  aDocPart: Tm3DocPartSelector; aLevel: Integer; WithAttr: Boolean;
  DocPartSel: TDocPartSelector; aFoundSelector: Tm4Addresses; out theStream: IStream): Boolean;
var
 l_Transporter: IncsClientTransporter;
 l_Reply: TncsMessage;
 l_Message: TcsDownloadDocStream;

 function DoIterate(anAddress: PObject; anIndex: Long): Bool;
 var
  l_Addr: Tm3DocumentAddress;
 begin//DoAddress
  l_Addr := aFoundSelector.Address[anIndex];
  l_Message.FoundSelector.Add(l_Addr.rPara, l_Addr.rWord, l_Addr.rDocument);
  Result := true;
 end;//DoAddress

begin
 Result := False;
 theStream := nil;
 if ArchiRequestManager.CSClient.IsStarted then
 begin
  l_Transporter := TncsSynchroCompatibilityClientTransporter.Make(qtalcuSendCustomMessage);
  try
   l_Transporter.Connect(CSClient.ServerIp, CSClient.ServerPort, l3CreateStringGUID);
   try
    if not l_Transporter.Connected then
     raise Exception.Create(sidClientServerDocLoadFailed);
    l_Message := TcsDownloadDocStream.Create;
    try
     l_Message.DocFamily := aDocFamily;
     l_Message.IsObjTopic := anIsObjTopic;
     l_Message.DocumentType := aDocumentType;
     l_Message.DocID := aDocID;
     l_Message.DocPart := aDocPart;
     l_Message.Level := aLevel;
     l_Message.WithAttr := WithAttr;
     l_Message.DocPartSel := DocPartSel;
     if aFoundSelector <> nil then
      aFoundSelector.IterateAllF(l3L2IA(@DoIterate));
     l_Transporter.Send(l_Message);
     l_Reply := nil;
     try
      Result := l_Transporter.WaitForReply(l_Message, l_Reply) and (l_Reply is TcsDownloadDocStreamReply) and TcsDownloadDocStreamReply(l_Reply).IsSuccess;
      if Result then
       theStream := TcsDownloadDocStreamReply(l_Reply).Data as IStream
      else
       if Assigned(l_Reply) and (l_Reply is TcsDownloadDocStreamReply) then
        raise Exception.Create(TcsDownloadDocStreamReply(l_Reply).ErrorMessage)
       else
        raise Exception.Create('Нет связи с сервером');
     finally
      FreeAndNil(l_Reply);
     end;
    finally
     FreeAndNil(l_Message);
    end;
   finally
    l_Transporter.Disconnect;
   end;
  finally
   l_Transporter := nil;
  end;
 end;
end;

function TArchiUserRequestManager.UploadDocStream(
  const aMessage: TcsUploadDocStream): Boolean;
var
 l_Transporter: IncsClientTransporter;
 l_Reply: TncsMessage;
begin
 Result := False;
 if ArchiRequestManager.CSClient.IsStarted then
 begin
  l_Transporter := TncsSynchroCompatibilityClientTransporter.Make(qtalcuSendCustomMessage);
  try
   l_Transporter.Connect(CSClient.ServerIp, CSClient.ServerPort, l3CreateStringGUID);
   try
    if not l_Transporter.Connected then
     raise Exception.Create(sidClientServerDocSaveFailed);
    l_Transporter.Send(aMessage);
    l_Reply := nil;
    try
     Result := l_Transporter.WaitForReply(aMessage, l_Reply) and (l_Reply is TcsUploadDocStreamReply) and TcsUploadDocStreamReply(l_Reply).IsSuccess;
     if not Result then
     begin
      if Assigned(l_Reply) and (l_Reply is TcsUploadDocStreamReply) then
       raise Exception.Create(TcsUploadDocStreamReply(l_Reply).ErrorMessage)
      else
       raise Exception.Create('Нет связи с сервером');
     end;
    finally
     FreeAndNil(l_Reply);
    end;
   finally
    l_Transporter.Disconnect;
   end;
  finally
   l_Transporter := nil;
  end;
 end;
end;

function TArchiUserRequestManager.SendRequestWithReply(
  const aMessage: TncsMessage): TncsReply;
var
 l_Transporter: IncsClientTransporter;
 l_Reply: TncsMessage;
begin
 Result := nil;
 if ArchiRequestManager.CSClient.IsStarted then
 begin
  l_Transporter := TncsSynchroCompatibilityClientTransporter.Make(qtalcuSendCustomMessage);
  try
   l_Transporter.Connect(CSClient.ServerIp, CSClient.ServerPort, l3CreateStringGUID);
   try
    if not l_Transporter.Connected then
     raise Exception.Create(sidClientServerDocSaveFailed);
    l_Transporter.Send(aMessage);
    l_Reply := nil;
    if not l_Transporter.WaitForReply(aMessage, l_Reply) then
     raise Exception.Create('Нет связи с сервером');
    if (l_Reply = nil) or not (l_Reply is TncsReply) then
     raise Exception.Create('Нет связи с сервером');
    Result := l_Reply as TncsReply;
   finally
    l_Transporter.Disconnect;
   end;
  finally
   l_Transporter := nil;
  end;
 end;
end;

initialization
 SetUserRequestManagerClass(TArchiUserRequestManager);

end.
