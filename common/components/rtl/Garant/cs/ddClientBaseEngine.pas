//..........................................................................................................................................................................................................................................................
unit ddClientBaseEngine;

// $Id: ddClientBaseEngine.pas,v 1.42 2016/05/16 12:54:36 lukyanets Exp $

// $Log: ddClientBaseEngine.pas,v $
// Revision 1.42  2016/05/16 12:54:36  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.41  2016/04/29 10:27:22  lukyanets
// Убираем зависимость от cs
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.40  2016/03/16 12:40:59  lukyanets
// Отлаживаем вилку
//
// Revision 1.39  2016/01/11 11:29:04  lukyanets
// Cleanup
//
// Revision 1.38  2015/11/25 14:01:43  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.37  2015/10/27 13:33:06  lukyanets
// Пытаемся подкючаться к Postgres
//
// Revision 1.36  2015/09/22 06:47:28  lukyanets
// Cleanup
//
// Revision 1.35  2015/09/11 12:25:23  lukyanets
// В тихом режиме не выводим окно с ошибкой логина
//
// Revision 1.34  2015/08/05 10:58:21  lukyanets
// Не запоминали введенный логин
//
// Revision 1.33  2015/06/01 08:40:50  lukyanets
// Выводим диагностику о несовпадении протокола
//
// Revision 1.32  2015/05/29 07:36:36  lukyanets
// Неинициализировался Temp каталог
//
// Revision 1.31  2015/05/28 12:40:39  lukyanets
// Глючило в логине без сервера
//
// Revision 1.30  2015/05/26 15:18:05  lukyanets
// Чистим залочки более гуманно
//
// Revision 1.29  2015/05/19 13:49:12  lukyanets
// Разделяем изготовление параметров и запуск клиента
//
// Revision 1.28  2015/05/19 13:05:52  lukyanets
// Разделяем изготовление параметров и запуск клиента
//
// Revision 1.27  2015/04/29 14:57:18  lukyanets
// Заготовки Большого Брата
//
// Revision 1.26  2015/04/24 13:20:17  lukyanets
// Боремся с ручными правками путей
//
// Revision 1.25  2015/04/24 13:17:18  lukyanets
// Боремся с ручными правками путей
//
// Revision 1.24  2015/04/13 15:20:36  lukyanets
// Снабжаем настройки понятием ReadOnly
//
// Revision 1.23  2015/04/01 15:26:01  lukyanets
// Изолируем логин
//
// Revision 1.22  2015/03/31 14:09:06  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.21  2015/03/30 14:59:42  lukyanets
// Изолируем AliasList
//
// Revision 1.20  2015/03/30 11:16:01  lukyanets
// Изолируем информацию о версии
//
// Revision 1.19  2015/03/27 13:15:46  lukyanets
// Заготовки Provider
//
// Revision 1.18  2015/03/27 09:23:09  lukyanets
// Отучаем параметры сервера от знания про HT
//
// Revision 1.17  2015/03/27 08:04:35  lukyanets
// Отучаем диалог логина от знания про HT
//
// Revision 1.16  2015/03/26 14:32:46  lukyanets
// Отучаем даилог логина от знания про HT
//
// Revision 1.15  2015/03/25 11:47:55  lukyanets
// Не падаем в STandAlone режима
//
// Revision 1.14  2015/03/25 11:07:13  lukyanets
// Обобщаем параметры
//
// Revision 1.13  2015/03/24 10:40:23  lukyanets
// Более правильно корректируем настройки
//
// Revision 1.12  2015/03/23 14:50:27  lukyanets
// Получаем настройки БД с сервера
//
// Revision 1.11  2015/03/20 14:38:15  lukyanets
// Готовимся принимать параметры с сервера
//
// Revision 1.10  2015/03/19 12:51:28  lukyanets
// Сохраняем параметры
//
// Revision 1.9  2015/03/13 13:35:14  lukyanets
// Перетрахиваем код
//
// Revision 1.8  2015/03/13 07:03:05  lukyanets
// Функция не возвращала результат.
//
// Revision 1.7  2015/03/12 15:03:49  lukyanets
// Читаем параметры базы
//
// Revision 1.6  2015/03/06 08:14:47  lukyanets
// Выкидываем ошметки
//
// Revision 1.5  2015/03/05 12:08:23  lukyanets
// Сохраняем парамеры сервера.
//
// Revision 1.4  2015/03/04 15:05:56  lukyanets
// Храним параметры по новому
//
// Revision 1.3  2015/03/04 13:42:54  lukyanets
// Убираем отмершие ошметки
//
// Revision 1.2  2015/02/27 08:49:07  lukyanets
// Развязываем зависимости
//
// Revision 1.1  2015/02/26 13:05:31  lukyanets
// Переносим в более подходящее место
//
// Revision 1.79  2015/02/26 11:59:33  lukyanets
// Cleanup
//
// Revision 1.78  2015/01/22 14:31:38  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.77  2014/12/05 12:01:41  voba
// - разнес темп-каталоги для двух копий архивариуса работающих одновременно
//
// Revision 1.76  2014/11/26 14:41:09  lukyanets
// Боремся с обрывами связи
//
// Revision 1.75  2014/10/16 10:41:58  lukyanets
// Более контролируемо создаем конфиги
//
// Revision 1.74  2014/10/15 10:59:16  lukyanets
// Отучаем ddAppCOnfig от dd
//
// Revision 1.73  2014/10/15 07:37:49  lukyanets
// Не пишем в серверный конфиг если он не локальный
//
// Revision 1.72  2014/10/14 10:11:44  lukyanets
// Запоминаем админские права залогиненного
//
// Revision 1.71  2014/10/13 10:32:05  lukyanets
// Убираем дублирующиеся параметры
//
// Revision 1.70  2014/10/13 07:05:17  lukyanets
// Cleanup
//
// Revision 1.69  2014/10/13 06:49:49  lukyanets
// Переносим функции на более низкий уровень
//
// Revision 1.68  2014/10/10 12:36:17  lukyanets
// Стираем пароль
//
// Revision 1.67  2014/10/10 12:03:16  lukyanets
// Частичное вычитывание параметров
//
// Revision 1.66  2014/10/09 07:43:02  lukyanets
// Обобщаем код
//
// Revision 1.65  2014/10/08 13:09:34  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.64  2014/10/08 09:45:41  lukyanets
// CLeanup
//
// Revision 1.63  2014/10/07 09:37:25  lukyanets
// Cleanup
//
// Revision 1.62  2014/10/02 11:45:29  lukyanets
// Cleanup
//
// Revision 1.61  2014/09/19 11:22:25  lukyanets
// {RequestLink:565273246} - Прицепили логику
//
// Revision 1.60  2014/09/19 07:41:43  lukyanets
// {RequestLink:565273246} - Заготовили транспорт
//
// Revision 1.59  2014/09/12 12:27:01  lukyanets
// Не пускаем на залоченную базу.
//
// Revision 1.58  2014/09/10 09:04:26  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.57  2014/09/09 07:23:38  lukyanets
// Выправляем диагностику логина
//
// Revision 1.56  2014/09/09 05:29:04  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.55  2014/09/08 11:05:38  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.54  2014/09/05 11:51:50  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.53  2014/09/04 13:19:33  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.52  2014/08/29 11:22:06  lulin
// - заменяем условную директиву на переменную.
//
// Revision 1.51  2014/08/15 05:51:34  lukyanets
// Учитываем режим без сервера
//
// Revision 1.50  2014/08/12 09:33:45  lukyanets
// {Requestlink:560730919}. Обощаем контроль флагов
//
// Revision 1.49  2014/08/12 07:33:54  lukyanets
// {Requestlink:560730919}. Прокидываем флаги базы
//
// Revision 1.48  2014/07/28 11:45:43  lukyanets
// {Requestlink:557844282}. Прикручиваем серверный ddAppConfig
//
// Revision 1.47  2014/06/17 10:33:29  lulin
// - переименовываем метод, чтобы название отражало его суть.
//
// Revision 1.46  2014/06/06 13:14:16  lulin
// - чистим код.
//
// Revision 1.45  2014/06/03 15:34:52  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.44  2014/05/28 10:09:11  lulin
// - вычищаем мусор.
//
// Revision 1.43  2014/02/12 12:35:27  lulin
// - рефакторим списки заданий.
//
// Revision 1.42  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.41  2013/02/05 11:00:13  voba
// Игнорировался параметр StandAlone
//
// Revision 1.40  2013/02/04 08:55:14  dinishev
// Bug fix: не запускался тестовый Арчи.
//
// Revision 1.39  2013/02/01 12:47:03  narry
// Не сохранялись настройки подключения
//
// Revision 1.38  2012/12/25 08:41:16  narry
// Не обновлялся IP-сервера
//
// Revision 1.37  2012/11/20 13:54:08  narry
// Всегда спрашивать логин-пароль                               
//
// Revision 1.36  2012/11/20 13:19:13  narry
// Обновление
//
// Revision 1.35  2012/10/18 07:06:13  narry
// Обновление
//
// Revision 1.34  2012/10/18 06:46:39  narry
// Пользователи заходят на закрытую базу (404360520)
//
// Revision 1.33  2012/10/17 09:29:38  fireton
// - bugfix: не работал Cancel в окошке логина
//
// Revision 1.32  2012/10/17 07:48:13  fireton
// - запрещаем входить под супервизором
//
// Revision 1.31  2012/10/10 10:15:19  narry
// Обновление
//
// Revision 1.30  2012/10/02 08:05:57  narry
// Обновление
//
// Revision 1.29  2012/09/06 11:13:14  narry
// Не работают два архивариуса запущенных на одной машине (390583699)
//
// Revision 1.28  2012/03/15 07:50:52  narry
// Некорректная диагностика ошибки подключения
//
// Revision 1.27  2012/03/06 13:24:53  narry
// Предупреждение о задержке подключения
//
// Revision 1.26  2012/03/06 13:20:51  narry
// Предупреждение о задержке подключения
//
// Revision 1.25  2012/02/20 09:44:14  narry
// Сообщение о состоянии экспорта (340167865)
//
// Revision 1.24  2012/02/15 13:59:24  narry
// Обновление
//
// Revision 1.23  2012/01/24 08:52:03  narry
// - не запрашивал логин-пароль в арчи
//
// Revision 1.22  2011/12/29 08:16:49  narry
// Не работало переключение сервер-без сервера
//
// Revision 1.21  2011/12/16 11:55:04  narry
// Не переинициализировался CSClient при смене IP-Port
//
// Revision 1.20  2011/12/15 13:00:46  narry
// Управление из Парня (319488062)
//
// Revision 1.19  2011/06/10 11:52:40  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.18  2011/05/31 12:01:24  narry
// AV при подключении к базе (267878505)
//
// Revision 1.17  2010/04/01 09:51:51  narry
// - запуск без запроса логин-пароля
//
// Revision 1.16  2010/02/26 09:45:23  narry
// - защита от повторного входа
//
// Revision 1.15  2010/02/24 10:24:24  narry
// - удаление зависимости проектов от парня
//
// Revision 1.14  2009/07/24 05:49:25  voba
// - remove procedure DefaultIdleProc;
//
// Revision 1.13  2009/07/22 11:27:31  narry
// - изменение доступа к DictServer
//
// Revision 1.12  2009/04/16 11:48:20  fireton
// [$143396358]. Переносим base64 из DD в L3
//
// Revision 1.11  2009/04/13 08:56:17  narry
// - разделение определения типов и реализации
//
// Revision 1.10  2009/03/13 15:07:51  narry
// - обновление запроса параметров подключения
//
// Revision 1.9  2009/02/11 10:56:39  narry
// - рефакторинг механизма подключения к базе
//
// Revision 1.8  2009/02/11 07:37:44  narry
// - пользователи с пустым паролем не могли войти в Арчи
//
// Revision 1.7  2009/02/10 14:04:42  narry
// - рефакторинг механизма подключения к базе
//
// Revision 1.6  2009/02/05 12:36:58  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.5  2009/02/05 10:27:28  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.4  2009/01/27 11:36:40  narry
// - корректное формирование имени станции при логине в базу
//
// Revision 1.3  2009/01/23 15:53:57  narry
// - исправление окошка подключения к базе
//
// Revision 1.2  2009/01/13 16:17:52  narry
// - обновление механизма
//
// Revision 1.1  2008/11/24 12:38:02  narry
// - рефакторинг
//
// Revision 1.65  2008/11/18 09:03:01  narry
// - Обновление
//
// Revision 1.64  2008/11/12 14:18:17  narry
// - можно было зайти на закрытую базу
//
// Revision 1.63  2008/11/01 12:23:20  narry
// - Обновление
//
// Revision 1.62  2008/10/30 13:06:57  narry
// - Обновление
//
// Revision 1.61  2008/10/21 08:00:24  narry
// - не подставлялись логин-пароль в пользовательскую функцию
//
// Revision 1.60  2008/10/15 09:06:29  fireton
// - кодируем зашифорованные строки в base64 (иначе в ini может записаться каша)
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.59  2008/10/13 12:39:27  narry
// - промежуточное обновление
//
// Revision 1.58  2008/10/07 12:13:18  narry
// - загрузка-сохранение параметров в функциях Init(Done)BaseEngine
//
// Revision 1.57  2008/10/06 12:38:55  narry
// - обновление
//
// Revision 1.56  2008/10/03 09:31:06  fireton
// - bugfix: выводим окно ввода пароля в любом случае
//
// Revision 1.55  2008/10/03 09:02:44  narry
// - обновление
//
// Revision 1.54  2008/10/03 07:04:53  narry
// - рефакторинг, исправление ошибок
//
// Revision 1.53  2008/10/01 10:49:57  narry
// - в StandAlone не устанавливался путь к образам
//
// Revision 1.52  2008/10/01 07:28:02  narry
// - при наличии в инишнике FamilyPath неправильно открывались таблицы семейства
//
// Revision 1.51  2008/09/29 13:50:53  narry
// - путь к образам документов получается с сервера
//
// Revision 1.50  2008/09/29 12:24:56  fireton
// - кастомизация инишников
//
// Revision 1.49  2008/09/29 08:09:10  narry
// - рефакторинг механизма подключения к базе
//
// Revision 1.48  2008/07/14 07:48:07  narry
// - получение путей к базе с сервера (первый шаг, немного в сторону)
//
// Revision 1.47  2008/04/17 13:21:29  fireton
// - упразднен модуль DocImgSup
//
// Revision 1.46  2008/03/21 17:19:49  narry
// - мелкие исправления
//
// Revision 1.45  2008/03/13 14:42:59  narry
// - процедуры починки таблиц
//
// Revision 1.44  2008/02/27 15:36:14  narry
// - выключенная база всегда закрыта
//
// Revision 1.43  2007/12/25 07:16:11  fireton
// - bug fix: неправильная инициализация параметров сервера, если ServerConfig не прописан
//
// Revision 1.42  2007/12/11 13:55:24  fireton
// - сообщение об ошибке, если версии протокола не совпадают
//
// Revision 1.41  2007/11/16 08:50:13  narry
// - проверка свободного места в папке Temp
//
// Revision 1.40  2007/10/10 07:05:22  narry
// - шифрованая запись пароля
//
// Revision 1.39  2007/10/04 11:18:48  narry
// - сохранение логина-пароля для старой процедуры регистрации
//
// Revision 1.38  2007/10/04 11:14:40  narry
// - сохранение логина-пароля для старой процедуры регистрации
//
// Revision 1.37  2007/09/28 05:39:10  narry
// - исправление ошибок подключения как клиент
//
// Revision 1.36  2007/07/25 10:42:24  narry
// - более логичное название метода
//
// Revision 1.35  2007/07/24 12:32:29  narry
// - рефакторинг системы сообщений
//
// Revision 1.34  2007/07/04 09:12:13  narry
// - рефакторинг процедуры инициализации HyTech
//
// Revision 1.33  2007/04/19 11:56:28  fireton
// - выкинут совершенно неясный код обработки исключения
//
// Revision 1.32  2006/12/01 15:03:50  fireton
// - доработка: теперь мы пытаемся прочитать настройки базы из серверного конфига
//
// Revision 1.31  2006/11/29 11:31:36  fireton
// no message
//
// Revision 1.30  2006/11/28 13:54:12  narry
// - корректный вход в К-С
//
// Revision 1.29  2006/10/12 11:31:30  narry
// - работа над ошибками
//
// Revision 1.28  2006/03/07 12:27:34  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.27  2006/01/12 09:05:53  narry
// - исправление: правильный порядок создания коммуникационных объектов
//
// Revision 1.26  2005/12/23 10:40:11  step
// переделки под CS
//
// Revision 1.25  2005/12/01 11:35:51  narry
// - обновление: переход на новый способ передачи задач
//
// Revision 1.24  2005/11/02 16:16:17  narry
// - новое: тип приложения
// - новое: инициализация пути к графическим образам
//
// Revision 1.23  2005/10/21 15:24:33  step
// внутри _InitBaseEngine указываем тип приложения
//
// Revision 1.22  2005/09/30 07:51:06  narry
// - обновление: новый параметр
//
// Revision 1.21  2005/06/22 15:55:25  step
// согласованы создание-очистка SendServer и g_DbServer
//
// Revision 1.20  2005/06/16 12:31:01  step
// слияние с веткой b_use_net_comm
//
// Revision 1.19.4.2  2005/06/06 16:12:33  step
// Использование автоматич. вычисления Ip-адреса сервера.
//
// Revision 1.19.4.1  2005/06/03 13:27:06  step
// используем g_DbServer : TDbServer
//
// Revision 1.19  2005/04/28 13:21:37  narry
// - update
//
// Revision 1.18  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.17  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.16  2004/12/23 11:42:08  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.15  2003/12/19 12:11:59  narry
// - new: инициализация BaseConfig
//
// Revision 1.14  2003/05/28 11:52:03  narry
// - cleanup
//
// Revision 1.13  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.12  2003/03/17 13:20:00  narry
// Новые команды версионности
//
// Revision 1.11  2002/08/28 08:14:57  narry
// - bug fix & update
//
// Revision 1.10  2002/07/15 13:16:43  narry
// - bug fix: после перезапуска механизма доступа к базе не принимались сообщения
//
// Revision 1.9  2002/05/22 12:06:48  narry
// no message
//
// Revision 1.8  2002/02/01 11:57:12  narry
// - bug fix: оставались объекты при переинициализации базы
//
// Revision 1.7  2001/12/27 13:44:43  narry
// - bug fix: при переинициализации механизма оставались неосввобожденные объекты
//
// Revision 1.6  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.5  2001/09/28 07:11:28  narry
// - bug fix: были ошибки в курсоре для списка строк.
//
// Revision 1.4  2001/08/21 12:27:06  narry
// - bug fix: повторное освобождение указателя
//
// Revision 1.3  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface
Uses
  l3Base, l3IniFile,
  daTypes,
  CSClient, CsDataPipe, csCommon, csNotification,
  ddBaseEngine, daDataProviderParams,
  ddAppConfig,
  Forms, Classes, SysUtils,
  ncsServiceProviderParams,
  IdGlobal;

type

 TbeError = (beOk, beCanceled, beUserParamsWrong, beConnectionError, beDuplicateClient,
  beDeadClient, beBaseLocked, beInsufficientRights, beBaseNotFound, beInvalidProocolVersion, beInvalidSQL);
 TbeErrors = set of TbeError;

 TClientBaseEngine = class(TBaseEngine)
 private
  f_AutoSave: Boolean;
  f_Canceled: Boolean;
  f_CSClient: TCSClient;
  f_IsRequireAdminRights: Boolean;
  f_LastError: AnsiString;
  f_LastErrorID: TbeError;
  f_OnGetLoginPassword: TGetLoginPasswordProc;
  f_QuietMode: Boolean;
  f_AllowClearLocks: Boolean;

  f_BaseFlags: TdaBaseFlags;
  f_ServiceParams: TncsServiceProviderParams;
  procedure FinishWork;
  function CheckLockStatus: Boolean;
  procedure CheckPathRec;
  function GetErrorString(aError: TbeError; const aErrorStr: AnsiString) : ANSIString;
  function CalcConnectKind: TcsUserConnectKind;
  function Get_IsDeveloper: Boolean;
    procedure Set_IsRequireAdminRights(const Value: Boolean);
  function csUsenManagerNotifyProc(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString): Boolean;
 protected
  procedure Cleanup; override;
  procedure CreateCommunications; override;
  function  DoStart: Boolean; override;
  procedure DoStop; override;
  function AllowClearLocks : Boolean; override;
  function pm_GetServerHostName: AnsiString; override;
  function pm_GetServerPort: Integer; override;
  function pm_GetWorkWithServer: Boolean; override;
 public
  constructor Make(const aDataParams: TdaDataProviderParams; const aServiceParams: TncsServiceProviderParams; aQuietMode: boolean = False; AllowClearLocks: Boolean = False); overload;
  function IsBaseLocked(var aMsg: AnsiString): Boolean; overload; override;
  procedure SetCurrentActiveUsers;
  property AutoSave: Boolean read f_AutoSave write f_AutoSave;
  property CSClient: TCSClient read f_CSClient;
  property IsDeveloper: Boolean read Get_IsDeveloper;
  property IsRequireAdminRights: Boolean read f_IsRequireAdminRights write Set_IsRequireAdminRights;
  property LastError: TbeError read f_LastErrorID write f_LastErrorID;
  property BaseFlags: TdaBaseFlags read f_BaseFlags;
  property ServiceParams: TncsServiceProviderParams read f_ServiceParams;
  property QuietMode: Boolean read f_QuietMode write f_QuietMode;
  property OnGetLoginPassword: TGetLoginPasswordProc read f_OnGetLoginPassword write f_OnGetLoginPassword;
 end;

procedure DoneClientBaseEngine(const ShowDialog: Boolean = False; aFinalizeProc: TProcedure = nil);

var
 g_BaseEngine: TClientBaseEngine;

implementation

Uses
 Controls,
 Dialogs,
 DateUtils,
 Types,
 Messages,

 l3String,
 l3FileUtils,
 l3Base64,
 l3Utils,
 l3Memory,

 ddClosingWin,

 daDataProviderSuperFactory,
 daSchemeConsts,
 daDataProvider,

 htDataProviderParams,

 CsErrors,
 csBaseStatusRequest,
 ncsServiceProviderParamsFactory,

 ddUtils,
 csUserRequestManager,

 Base_CFG,

 dt_Serv,
 Dt_user,
 dt_Const,
 dt_Dict,
 DT_DocImages,
 dtUserIDList,

 afwFacade,

 vtDialogs,
 StrUtils, dt_Doc, dt_Mail, csQueryTypes, dt_Acces, csConst,

 m3StgMgr
 ;

type
 TActiveUsersQuery = class(Tl3Base)
 private
  f_Users: TdtUserIDList;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure Write2Pipe(aPipe: TCsDataPipe);
  property Users: TdtUserIDList
   read f_Users;
 end;

const
 c_MaxLoginAttempts = 3;

constructor TClientBaseEngine.Make(const aDataParams: TdaDataProviderParams;
  const aServiceParams: TncsServiceProviderParams; aQuietMode: boolean = False; AllowClearLocks: Boolean = False);
begin
 Create(aDataParams);
 aServiceParams.SetRefTo(f_ServiceParams);
 //StartCommunications;
{$IFDEF ServerAssistantSide}
 AutoSave:= False;
{$ELSE ServerAssistantSide}
 AutoSave:= True;
{$ENDIF ServerAssistantSide}
 QuietMode:= aQuietMode;
 f_LastErrorID:= beOk;
 f_AllowClearLocks := AllowClearLocks;
end;

procedure TClientBaseEngine.FinishWork;
begin
 //_UserRequestManager.CSClient:= nil;
 UserRequestManager.RequestTerminateCommunication;
 DestroyDataProvider;
 DoneBaseConfig;
end;

function TClientBaseEngine.CheckLockStatus: Boolean;
var
 l_LockMsg: AnsiString;
 l_MsgType: TMsgDlgType;
 l_Buttons: TMsgDlgButtons;
begin
 Result := True;
 if IsBaseLocked(l_LockMsg) then
 begin
  if QuietMode then
   Result:= IsDeveloper
  else
  begin
   if IsDeveloper then
   begin
    l_MsgType:= mtWarning;
    l_LockMsg:= 'ВНИМАНИЕ! Продолжение работы может разрушить базу данных.'^M^M + l_LockMsg + ^M^M'Продолжить?';
    l_Buttons:= [mbYes, mbNo];
   end
   else
   begin
    l_MsgType:= mtError;
    l_LockMsg:= 'ВНИМАНИЕ! Продолжение работы невозможно.'^M^M + l_LockMsg;
    l_Buttons:= [mbCancel];
   end;
   Result:= IsPositiveResult(MessageDlg(l_LockMsg, l_MsgType, l_Buttons, 0));
  end;
 end; // g_BaseEngine.IsBaseLocked(lLockMsg)
end;

procedure TClientBaseEngine.CheckPathRec;
var
 l_BaseID: AnsiString;
begin
 if (DataParams as ThtDataProviderParams).TmpDirPath = '' then
  (DataParams as ThtDataProviderParams).TmpDirPath := GetWindowsTempFolder;

 with TBaseMagic.Create(ConcatDirName(DataParams.DocStoragePath, 'main\base.ini')) do
 try
  l_BaseID:= Magicstring['Base', 'ID'];
 finally
  Free;
 end;
 if (l_BaseID <> '') and not AnsiEndsText(l_BaseID, (DataParams as ThtDataProviderParams).TmpDirPath) then
  (DataParams as ThtDataProviderParams).TmpDirPath := ConcatDirName((DataParams as ThtDataProviderParams).TmpDirPath, l_BaseID);
end;

procedure TClientBaseEngine.CreateCommunications;
begin
 if CSClient = nil then
  f_CSClient := TCSClient.Create;
end;

function TClientBaseEngine.DoStart: Boolean;
type
 PLoginParam = ^TLoginParam;
 TLoginParam = record
  rLogin    : AnsiString;
  rPassword : AnsiString;
  rServerHostName: AnsiString;
  rServerPort: Integer;
  rError    : TbeError;
  rErrorMsg: AnsiString;
  rSuppressAskPassword : boolean;
  rDataParams: TdaDataProviderParams;
  rBaseFlags: TdaBaseFlags;
 end;
var
 l_AppConfig: TddAppConfiguration;

 procedure InitLoginParam(var aLoginParam : TLoginParam);
 begin
  aLoginParam.rLogin    := Login;
  aLoginParam.rPassword := Password;
  aLoginParam.rServerHostName := ServerHostName;
  aLoginParam.rServerPort := ServerPort;
  aLoginParam.rError   := beOk;
  aLoginParam.rDataParams := DataParams;
  aLoginParam.rSuppressAskPassword := QuietMode;
  aLoginParam.rErrorMsg := '';
 end;

 function lpPromptForLoginPassword(var aLoginParam : TLoginParam): Boolean;
 var
  l_DataParams: TdaDataProviderParams;
 begin
  Result := aLoginParam.rSuppressAskPassword;
  if Result then
  begin
   aLoginParam.rSuppressAskPassword := false;
   TdaDataProviderSuperFactory.Instance.CorrectByClient(aLoginParam.rDataParams);
   Exit;
  end;

  if Assigned(f_OnGetLoginPassword) then
  begin
   Result := f_OnGetLoginPassword(aLoginParam.rLogin, aLoginParam.rPassword);
   if Result then
   begin
    TdaDataProviderSuperFactory.Instance.CorrectByClient(aLoginParam.rDataParams);
    f_ServiceParams.Login := aLoginParam.rLogin;
    f_ServiceParams.Password := aLoginParam.rPassword;
   end;
  end
  else
  begin

   { TODO : Хочется узнать состояние Shift, чтобы включить невидимые элементы }
   Result:= l_AppConfig.ShowNodeDialog('Common');
   if Result then
   begin
    TncsServiceProviderParamsFactory.Instance.FillOutConfig(l_AppConfig, f_ServiceParams);
    try
     TdaDataProviderSuperFactory.Instance.FillOutConfig(l_AppConfig, DataParams, l_DataParams);
     TdaDataProviderSuperFactory.Instance.CorrectByClient(l_DataParams);
     l_DataParams.Login := f_ServiceParams.Login;
     l_DataParams.Password := f_ServiceParams.Password;
     DataParams := l_DataParams;
     l_AppConfig.Changed := False;
    finally
     FreeAndNil(l_DataParams);
    end;
    InitLoginParam(aLoginParam);
   end;

  end;

  if not Result then
   aLoginParam.rError := beCanceled;
 end;


 function lpCheckLoginPassword(var aLoginParam : TLoginParam): Boolean;

   function lpCheckStandAlone(var aLoginParam : TLoginParam): Boolean;
   const
    cMap: array[TdaLoginError] of TbeError = (beOk, beInsufficientRights, beUserParamsWrong, beConnectionError, beInvalidSQL);
   begin
    Result:= False;
    TdaDataProviderSuperFactory.Instance.LoadDBVersion(aLoginParam.rDataParams);
    if (aLoginParam.rDataParams.DocBaseVersion <> 0) and (aLoginParam.rDataParams.AdminBaseVersion <> 0) then
    try
     aLoginParam.rError := cMap[TdaDataProviderSuperFactory.Instance.CheckLogin(aLoginParam.rDataParams, aLoginParam.rLogin, aLoginParam.rPassword, IsRequireAdminRights)];
     Result := aLoginParam.rError = beOk;
    except
     on E: Exception do
      f_LastError:= E.Message;
    end
    else
     aLoginParam.rError := beBaseNotFound;
   end;

   function lpCheckViaServer(var aLoginParam : TLoginParam): Boolean;
   var
    lError : TcsConnectResult;
   const
    cResultMap: array [TcsConnectResult] of TbeError = (
     beOk, //cs_crOk
     beConnectionError, //cs_crNetworkError
     beUserParamsWrong, //cs_crUserParamsWrong
     beDuplicateClient, //cs_crDuplicateClient
     beDeadClient, //cs_crDeadClient
     beBaseLocked, //cs_crBaseLocked
     beInsufficientRights //cs_crInsufficientRights
    );
   begin
    Result:= False;
    try
     CSClient.ReStart(aLoginParam.rServerHostName, aLoginParam.rServerPort);
    except
     on E: Exception do
     begin
      if E is ECsWrongVersionError then
      begin
       aLoginParam.rError := beInvalidProocolVersion;
       aLoginParam.rErrorMsg := E.Message;
      end
      else
       aLoginParam.rError := beConnectionError;
     exit;
     end;
    end;

    if CSClient.IsStarted then
    begin
     //l_OldVersion := False;

     Result:= CSClient.LoginEx(aLoginParam.rLogin, aLoginParam.rPassword, CalcConnectKind,
                               aLoginParam.rDataParams, aLoginParam.rBaseFlags, lError);
     try
      if Result then
      begin
       f_BaseFlags := aLoginParam.rBaseFlags;
       aLoginParam.rDataParams.UserID := CSClient.ClientId;
       TdaDataProviderSuperFactory.Instance.CorrectByClient(aLoginParam.rDataParams);
       aLoginParam.rDataParams.Login := f_ServiceParams.Login;
       aLoginParam.rDataParams.Password := f_ServiceParams.Password;
       DataParams := aLoginParam.rDataParams;

       aLoginParam.rError:= beOk;
      end
      else
      begin
       aLoginParam.rError := cResultMap[lError];
      end;
     finally
      FreeAndNil(aLoginParam.rDataParams);
      aLoginParam.rDataParams := DataParams;
     end;
    end // CSClient.IsStarted
    else
     aLoginParam.rError := beConnectionError;
   end; //function lpCheckViaServer

  {lpCheckLoginPassword}
  begin
   Result:= False;
   if WorkWithServer then
    Result:= lpCheckViaServer(aLoginParam)
   else
   begin
    Result:= lpCheckStandAlone(aLoginParam);
   end;
  end;

var
 l_DocBaseVersion: Integer;
 l_AdminBaseVersion: Integer;
 l_TryCount: Byte;
 l_WWS: Boolean;
 l_Ok: Boolean;
 l_Error: TbeError;
 //l_Errors: TbeErrors;

var
 lLoginParam : TLoginParam;
 I : integer;
{function TClientBaseEngine.DoStart: Boolean;}
begin
 Result:= False;
  //CreateCommunications;

 //l_TryCount:= 0;

 l_AppConfig := TddAppConfiguration.Create;
 try
  TncsServiceProviderParamsFactory.Instance.BuildConfig(l_AppConfig, TdaDataProviderSuperFactory.Instance.BuildConfig);
  TdaDataProviderSuperFactory.Instance.FillInConfig(l_AppConfig, DataParams);
  TncsServiceProviderParamsFactory.Instance.FillInConfig(l_AppConfig, f_ServiceParams);
  l_AppConfig.Changed := False;
  //вычитываем из ини параметры
  InitLoginParam(lLoginParam);

  //цикл по l_TryCount
  for I := 1 to c_MaxLoginAttempts do
  begin
   //вызываем диалог
   if lpPromptForLoginPassword(lLoginParam) then
   begin
    if lpCheckLoginPassword(lLoginParam) then //проверяем набитые данные
    begin
     Result := True;
     Break;
    end
    else
     if lLoginParam.rError <> beOk then
     begin
      if QuietMode then
      begin
       l3System.Msg2Log('LOGIN ERROR - %s', [GetErrorString(lLoginParam.rError, lLoginParam.rErrorMsg)]);
       Exit;
      end
      else
       showMessage(GetErrorString(lLoginParam.rError, lLoginParam.rErrorMsg)); //выдаем диагностику
     end;
   end
   else
    //if lLoginParam.rError = beCanceled then
      Exit // пользователь отказался от ввода пароля, выходим
  end;

  Result := Result and TdaDataProviderSuperFactory.Instance.IsParamsValid(DataParams);

  if Result then
  begin
   //инициализируем среду
   CreateDataProvider;
   InitBaseConfig(CurrentFamily);
   CSClient.AddNotifyProc(csUsenManagerNotifyProc);
//   UserManager.CSCLient := CSClient;
   DictServer(CurrentFamily).CSClient := CSClient;
   DocumentServer(CurrentFamily).CSClient:= CSClient;
   MailServer.CSClient := CSClient;
   AccessServer.CSClient:= CSClient;
   if AutoSave then
   begin
    TncsServiceProviderParamsFactory.Instance.SaveToConfig(f_ServiceParams);
    TdaDataProviderSuperFactory.Instance.SaveToConfig(DataParams);
   end;
  end;
 finally
  FreeAndNil(l_AppConfig);
 end;
end;

procedure TClientBaseEngine.DoStop;
begin
 FinishWork;
 l3Free(f_CSClient);
end;

function TClientBaseEngine.IsBaseLocked(var aMsg: AnsiString): Boolean;
begin
 Result:= True;
 aMsg:= 'Сервер Автоматизации недоступен';
 if CSClient.IsStarted then
 begin
  with TddBaseStatusRequest.Create({nil,} CSClient.ClientID) do
  try
   if CSClient.Exec(qtGetBaseStatus, SaveRequestToPipe) then
   begin
    Result:= IsFree;
    aMsg:= Message;
   end
   else
   if not WorkWithServer then
    Result:= inherited IsbaseLocked(aMsg);
  finally
   Free;
  end;
 end
 else
 if not WorkWithServer then
  Result:= inherited IsbaseLocked(aMsg);
end;

function TClientBaseEngine.GetErrorString(aError: TbeError; const aErrorStr: AnsiString) : ANSIString;
begin
 case aError of
  beOk              : Result := '';
  beConnectionError : Result := Format('Cервер Автоматизации (IP: %s, Порт: %d) не найден'#10,
                                           [IfThen(ServerHostName <> '', ServerHostName, 'не указан'), ServerPort]);
  beUserParamsWrong : Result := 'Неправильный пароль';
  beDuplicateClient : Result := 'Пользователь с указанным именем уже работает с базой';
  beDeadClient      : Result := 'Повторное подключение возможно не ранее, чем через 5 минут';
  beBaseLocked      : Result := 'База закрыта. Подключение невозможно';
  beInsufficientRights : Result := 'Не хватает прав для входа';
  beBaseNotFound : Result := 'Не найдена база данных!';
  beInvalidProocolVersion : Result := aErrorStr;
  beInvalidSQL : Result := 'Неверный запрос к базе. См. лог';
 end;
end;

function TClientBaseEngine.CalcConnectKind: TcsUserConnectKind;
begin
 if IsRequireAdminRights then
  Result := cs_uckRequireAdminRights
 else
  if IsDeveloper then
   Result := cs_uckDeveloper
  else
   Result := cs_uckRegular;
end;

procedure DoneClientBaseEngine(const ShowDialog: Boolean = False; aFinalizeProc: TProcedure = nil);
var
 l_Dlg: TddClosingForm;
begin
 if ShowDialog then
 begin
  l_Dlg:= TddClosingForm.Create(nil, dd_cwtStop);
  l_Dlg.Show;
  afw.ProcessMessages;
 end;
 try
  l3Free(MailServer);

  UserRequestManager.CSClient:= nil;
  { TODO : Нужно дописать информацию о пути к базе }
(*  if (ServerConfig <> nil) and (g_BaseEngine <> nil) and ((StationConfig = nil) or (StationConfig.CfgFileName = ServerConfig.CfgFileName)) then
   with ServerConfig do
   begin
    Section:='Network';
    WriteParamStr('ServerName', g_BaseEngine.ServerHostName);
    WriteParamInt('ServerPort', g_BaseEngine.ServerPort);
    WriteParamBool('StandAlone', not g_BaseEngine.WorkWithServer);
   end;
  if (StationConfig <> nil) and (g_BaseEngine <> nil) then
   with StationConfig do
   begin
    Section:='User';
    WriteParamBool('SavePassword', g_BaseEngine.SavePassword);
    WriteParamStr('UserName', g_BaseEngine.Login);
    if g_BaseEngine.SavePassword then
     WriteParamStr('UserPassword', l3EncodeBase64(l3Encrypt(g_BaseEngine.Password)));
//    else
//     WriteParamStr('UserPassword', l3EncodeBase64(''))
   end;
*)
  try
   l3Free(g_BaseEngine);
   if Assigned(aFinalizeProc) then
    aFinalizeProc;
  finally
   DoneUserConfig;
  end;
 finally
  if ShowDialog then
   l_Dlg.Free;
 end;
end;

procedure TClientBaseEngine.Cleanup;
begin
 l3Free(f_ServiceParams);
 inherited;
end;

function TClientBaseEngine.Get_IsDeveloper: Boolean;
begin
  Result := f_ServiceParams.IsDeveloper;
end;

function TClientBaseEngine.pm_GetServerHostName: AnsiString;
begin
 Result := f_ServiceParams.ServerHostName;
end;

function TClientBaseEngine.pm_GetServerPort: Integer;
begin
 Result := f_ServiceParams.ServerPort;
end;

function TClientBaseEngine.pm_GetWorkWithServer: Boolean;
begin
 Result := not f_ServiceParams.StandAlone;
end;

function TClientBaseEngine.AllowClearLocks: Boolean;
begin
 Result := f_AllowClearLocks;
end;

procedure TClientBaseEngine.Set_IsRequireAdminRights(const Value: Boolean);
begin
  f_IsRequireAdminRights := Value;
end;

function TClientBaseEngine.csUsenManagerNotifyProc(
  aNotificationType: TCsNotificationType; aNumber: Integer;
  const aText: AnsiString): Boolean;
begin
 Result := True;
 case aNotificationType of
  ntUserLogin: GlobalDataProvider.UserManager.NotifyUserActiveChanged(TdaUserID(aNumber), True);
  ntUserLogout: GlobalDataProvider.UserManager.NotifyUserActiveChanged(TdaUserID(aNumber), False);
 else
  Result := False;
 end
end;

procedure TClientBaseEngine.SetCurrentActiveUsers;
var
 l_Query: TActiveUsersQuery;
 i: Integer;
begin
 l_Query:= TActiveUsersQuery.Create;
 try
  if CSClient <> nil then
  begin
   if CSClient.Exec(qtGetActiveUsersList, l_Query.Write2Pipe) then
    for i:= 0 to l_Query.users.Hi do
     GlobalDataProvider.UserManager.NotifyUserActiveChanged(l_Query.Users.Items[i], True);
  end;
 finally
  l3Free(l_Query);
 end;
end;

{ TActiveUsersQuery }

procedure TActiveUsersQuery.Cleanup;
begin
 l3Free(f_Users);
 inherited;
end;

constructor TActiveUsersQuery.Create;
begin
 inherited;
 f_Users:= TdtUserIDList.Make;
end;

procedure TActiveUsersQuery.Write2Pipe(aPipe: TCsDataPipe);
var
 l_Stream: TStream;
begin
 f_Users.Clear;
 //with aPipe do
 begin
  l_Stream := Tl3MemoryStream.Create;
  try
   aPipe.ReadStream(l_Stream);
   l_Stream.Seek(0, 0);
   f_Users.Load(l_Stream);
  finally
   l3Free(l_Stream);
  end;
 end;
end;

end.
