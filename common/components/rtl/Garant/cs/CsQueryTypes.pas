unit CsQueryTypes;

{ $Id: CsQueryTypes.pas,v 1.42 2015/06/05 11:50:09 lukyanets Exp $ }

// $Log: CsQueryTypes.pas,v $
// Revision 1.42  2015/06/05 11:50:09  lukyanets
// Допускаем релогин для закрытой базы
//
// Revision 1.41  2015/04/15 13:56:40  lukyanets
// Даем клиенту возможность отменять свои задания
//
// Revision 1.40  2015/04/01 07:17:39  lukyanets
// Cleanup
//
// Revision 1.39  2015/03/25 11:07:13  lukyanets
// Обобщаем параметры
//
// Revision 1.38  2015/01/27 09:53:15  lukyanets
// Cleanup
//
// Revision 1.37  2014/12/18 15:02:56  lukyanets
// Разводим пишуший и читающий сокет
//
// Revision 1.36  2014/12/08 15:03:29  lukyanets
// Заготовки
//
// Revision 1.35  2014/11/07 11:54:44  lukyanets
// Открываем соединение с клиента
//
// Revision 1.34  2014/10/28 11:52:23  lukyanets
// Открутили эстафетный перезапуск задачи. Только в крайнем случае.
//
// Revision 1.33  2014/09/24 07:16:40  lukyanets
// {RequestLink:565271071}
//
// Revision 1.32  2014/08/12 09:33:58  lukyanets
// {Requestlink:560730919}. Обощаем контроль флагов
//
// Revision 1.31  2014/08/12 07:33:53  lukyanets
// {Requestlink:560730919}. Прокидываем флаги базы
//
// Revision 1.30  2014/08/06 11:28:48  lukyanets
// {Requestlink:556143119}. Передаем результаты по сети
//
// Revision 1.29  2014/07/29 08:14:51  lukyanets
// {Requestlink:557844282}. Цель достигнута
//
// Revision 1.28  2014/07/25 09:45:57  lukyanets
// {Requestlink:557844282}. Подружили dt_mail с ассистентом
//
// Revision 1.27  2014/07/25 07:33:38  lukyanets
// {Requestlink:557844282}. Оказалось dt_mail впоне умеет перепихивать сообщения через сервер
//
// Revision 1.26  2014/07/15 07:23:18  lukyanets
// {Requestlink:553422280}. Перепихиваем ошибки по трубе
//
// Revision 1.25  2014/07/10 13:08:50  lukyanets
// {Requestlink:553422280}. Прокидываем прогресс
//
// Revision 1.24  2014/05/21 13:57:35  lulin
// - чистим код.
//
// Revision 1.23  2013/04/03 09:51:26  fireton
// - логика простановки VANONCED
//
// Revision 1.22  2012/10/18 06:49:55  narry
// Версия pipeout2, умеющая строить списки новых и измененных (383583730)
//
// Revision 1.21  2012/03/06 09:17:14  narry
// Получать с сервера список групп доступа Переданные в регион (273581950)
//
// Revision 1.20  2010/03/02 08:24:16  narry
// - изменения splash
//
// Revision 1.19  2009/07/22 08:20:23  narry
// - новая процедура _KeepAlive
// - cleanup
//
// Revision 1.18  2009/03/13 15:15:40  narry
// - процедуры записи в файл информации об удалении меток с атрибутами
//
// Revision 1.17  2009/01/13 16:18:23  narry
// - обновление механизма
//
// Revision 1.16  2008/11/25 12:59:34  narry
// - обновление
//
// Revision 1.15  2008/07/10 13:02:24  fireton
// - новый тип запроса - получение текущей даты компиляции базы
//
// Revision 1.14  2008/03/21 17:32:22  narry
// - задел для превращения Парня в сервис
//
// Revision 1.13  2007/10/04 07:53:59  narry
// - расширение процедуры регистрации клиента
//
// Revision 1.12  2007/07/24 12:32:27  narry
// - рефакторинг системы сообщений
//
// Revision 1.11  2006/09/01 13:55:01  narry
// - при подключении клиента к серверу проверяются версии клиента и сервера
//
// Revision 1.10  2006/08/02 12:18:46  narry
// - ловушка для сообщений с сервера
//
// Revision 1.9  2006/06/26 12:12:32  narry
// - обновление
//
// Revision 1.8  2006/06/22 11:41:21  fireton
// - обмен документами между клиентом и сервером
//
// Revision 1.7  2006/06/05 14:52:55  narry
// - обновление: расширение списка типов
//
// Revision 1.6  2006/03/31 12:46:18  narry
// - обновление
//
// Revision 1.5  2006/03/16 15:50:16  narry
// - еще один шажок в сторону клиент-сервера
//
// Revision 1.4  2006/03/09 11:47:12  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.3  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

type
 TCsQueryId = (qtTest,
               qtClientIp,
               qtReLogin,
               qtLogout,
               qtFile,
               qtDirectory,
               qtTask,
               // Выше исторические команды
               qtServerStatus,
               qtAllLine,
               qtMyLine_Deprecated,
               qtDeleteTask,
               qtTaskChanged,
               qtStartMonitoring,
               qtStartMyMonitoring,
               qtEndMonitoring,
               qtServerTask,
               qtTaskResult,
               qtGetTask,
               qtGetActiveUsersList,
               qtSendMail,
               qtDictEdit,
               qtGetDictEdit,
               qtGetMyMessages,
               qtGetTime,
               qtPrepareDocument,
               qtGetPreparedDocument,
               qtReturnChangedDocument,
               qtGetProtocolVersion,
               qtDeleteDocs,
               qtGetCommonData, // Запросить общий объект с номером N
               qtGetBaseConfig,
               qtLoginEx,
               qtGetCommands,
               qtExecuteCommand,
               qtGetVersionDate,
               qtGetBaseStatus,
               qtGetNonEditableDicts,
               qtGetAllUsersList,
               qtGetExecuteStatus,
               qtGetDictChangeFileName,
               qtKeepAlive,
               qtGetLogo,
               qtGetToRegionList,
               qtGetAEParams,
               qtGetCompileDate,
               qtGetAnouncedDate,
               qtAsyncProgress,
               qtalcuGetServerUser, // Получить UserID под которым крутиться сервер
               qtalcuSendEMail, // Переправить сообщение через alcuMail.SendEmail
               qtalcuSendEMailNotify, // Переправить сообщение через alcuMail.SendEmailNotify
               qtalcuSendSMSNotify, // Переправить сообщение через alcuMail.SendSMSNotify
               qtalcuSendTaskResult, // Переправить результат выполнения из утилиты в сервер
               qtRequestDeliveryTaskList, // Получить список задач по которым готовы результаты
               qtalcuAACNeedTerminate, // Надо ли прерывать AACImport - сугубо затычка
               qtalcuExportResultProcessing, // Обменяться результатами экспорта с докачкой и прочей фигней (CRC etc).
               qtalcuSendTask, // Отослать задачу с забором дополнительных файлов с докачкой и прочей фигней (CRC etc).
               qtalcuHandShake, // Соединение обратного сокета
               qtalcuTerminateTask // Прервать свою задачу.
             );

implementation

end.
