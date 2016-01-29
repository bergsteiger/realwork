unit alcuStrings;

{ Ресурс строковых констант }

{ $Id: alcuStrings.pas,v 1.9 2015/10/01 12:56:31 lukyanets Exp $ }

// $Log: alcuStrings.pas,v $
// Revision 1.9  2015/10/01 12:56:31  lukyanets
// Разделяем логи
//
// Revision 1.8  2014/12/26 12:58:43  lukyanets
// Раскладываем по подкаталогам
//
// Revision 1.7  2014/12/23 08:42:47  fireton
// - настройка полного копирования базы по дням недели
//
// Revision 1.6  2014/09/26 07:24:50  lukyanets
// {RequestLink:565502566}
//
// Revision 1.5  2014/09/18 10:05:59  lukyanets
// {RequestLink:565263723}
//
// Revision 1.4  2014/09/04 11:52:09  lukyanets
// Чистим склады внешних дельт
//
// Revision 1.3  2014/08/29 10:07:40  lukyanets
// Cleanup
//
// Revision 1.2  2014/08/19 12:20:12  lukyanets
// Очеловеченное название
//
// Revision 1.1  2014/07/28 15:18:18  lukyanets
// {Requestlink:557844282}. Используем правильный ProjectDefine.inc
//
// Revision 1.12  2013/11/07 06:58:40  fireton
// - очищаем директорию с архивом импортированных данных
//
// Revision 1.11  2012/04/12 10:33:44  narry
// Исправление опечаток
//
// Revision 1.10  2012/03/12 13:52:39  narry
// Корректное сообщение о лимите свободного места на диске
// Инициализация окончаний
//
// Revision 1.9  2012/03/11 07:03:31  narry
// Обновление
//
// Revision 1.8  2011/10/13 09:22:16  narry
// Накопившиеся изменения
//
// Revision 1.7  2011/05/31 14:07:41  narry
// Забытый модуль
//
// Revision 1.6  2010/07/20 14:21:25  narry
// К214599203
//
// Revision 1.5  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.4  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.3  2009/01/28 15:34:11  narry
// - обновление
//
// Revision 1.2  2008/03/13 14:01:03  narry
// - пополнение списка констант
//
// Revision 1.1  2008/03/04 11:34:27  narry
// - выделение строковых констант в отдельный модуль
//


interface

resourcestring
// START resource string wizard section
  SalcuRequestService_Anno = 'anno_';
  SalcuRequestService_Annotation = 'Annotation';

  SalcuRequestService_AnnoFolder = 'AnnoFolder';
  SalcuRequestService_AnnoDocFolder = 'AnnoDocFolder';
  SalcuRequestService_AnnoDocListFile = 'AnnoDocListFile';
  SalcuRequestService_AnnoInfoList = 'AnnoInfoList';
  SalcuRequestService_HNn = 'h:nn';
  SalcuRequestService_Nsr = '.nsr';

  SalcuRequestService_BaseIni = 'base.ini';
  SalcuRequestService_Eksportannotaciy = 'Экспорт аннотаций';
  SalcuRequestService_ExportDate = 'ExportDate';
  SalcuRequestService_ob_emdokumentov = '  - объем документов %s';
  SalcuRequestService_Query = '.query';
  SalcuRequestService_Speshuuvedomit_toannotaciikolies = 'Спешу уведомить, что аннотации количеством %d штук успешно экспортированы в %s';
  SalcuRequestService_Spriskorbiemsoobtshayutonebyloek = 'С прискорбием сообщаю, что не было экспортировано ни одной аннотации.';
  SalcuRequestService_SS = 'SS';
  SalcuRequestService_YyyyMmDd = 'yyyy-mm-dd';
  SalcuRequestService_Zdravstvuytedorogiepol_zovateli = 'Здравствуйте, дорогие пользователи!'#13#10;

// END resource string wizard section

  SalcuRequestService_ExportDone = 'Экспортировано %s за %s';
// START resource string wizard section
  rsCount = 'Count';

  rsDdMmmYyyyHhNnSs = 'dd mmm yyyy, hh:nn:ss';
  rsDublirovaniezadaniya = 'Дублирование задания';
  rsEksportpolzovatelya = 'Экспорт пользователя %s';
  rsEksportpolzovatelyazavershen = 'Экспорт пользователя %s завершен';
  rsEstoshibki = 'Есть ошибки';
  rsExport = 'Export\';
  rsfayldokumentov = '  - файл документов "%s"';
  rsFaylysohranenyvpapke = 'Файлы сохранены в папке %s';
  rsformat = '  - формат "%s"';
  rsImportCommentsLog = 'Import comments.log';
  rsImportirovaniefaylovKW = 'Импортирование файлов KW';
  rsImportKwfaylazavershensoshibkoy = 'Импорт kw-файла завершен с ошибкой';
  rsImportKwfaylazavershenuspeshno = 'Импорт kw-файла завершен успешно';
  rsImportName = 'ImportName';
  rsImportzavershen = 'Импорт завершен. ';
  rsImportzavershilsyauspeshno = 'Импорт завершился успешно';
  rsInformaciyaobokonaniieksportadop = 'Информация об окончании экспорта до пользователя не дошла';
  rskazhdyydokumentotdelno = '  - каждый документ отдельно';
  rsklevyeslovav = '  - ключевые слова в "%s"';
  rsKsozhaleniVashezadanienaavtoklas = 'К сожалению Ваше задание на автоклассификацию выполнить невозможно';
  rsLastImport = 'LastImport';

  rsNaaloobrabotkioeredizadaniy = 'Начало обработки очереди заданий';
  rsNiodindokumentnebylavtoklassific = 'Ни один документ не был автоклассифицирован.'#13#10;
  rsOeredzadaniyobrabotana = 'Очередь заданий обработана';
  rsOshibkaimporta = 'Ошибка импорта (%s)';
  rsOshibkaotpravkipismapolzovatelID = 'Ошибка отправки письма пользователю %s (ID %d)';
  rsOshibkaotpravkisoobtsheniyapolzo = 'Ошибка отправки сообщения пользователю %s';
  rsOshibkasozdaniyatrubyeksporta = 'Ошибка создания трубы экспорта';
  
  rsAutoclassifyTaskCreateError = 'Ошибка создания задания на автоклассификацию';
  rsOtpravkasoobtsheniyaoboshibkedli = 'Отправка сообщения об ошибке длиной %d байт';
  rspapka = '  - папка "%s"';
  rsPismootpravleno = 'Письмо отправлено';
  rsPolzovatel = '----- Пользователь %s (%s)'#13#10;
  rsPosylaempismodlinoybayt = 'Посылаем письмо длиной %d байт';
  rsPosylshtatnogosoobtsheniya = 'Посыл штатного сообщения ';
  rsProverkaunikalnostikataloga = 'Проверка уникальности каталога';
  rsrazmerasti = '  - размер части %s';
  rsRezultatyavtoklassifikacii = 'Результаты автоклассификации - ';
  rsSborkasoobtsheniyadokumentotsuts = 'Сборка сообщения - документ %d отсутствует в базе';
  rsSborkavyborkidokumentov = 'Сборка выборки документов';

  rsSpisokdokumentovproshedshihavtok = 'Список документов, прошедших автоклассификацию, находится в приложении'#13#10;
  rsUserIni = 'user.ini';
  rsVashezadanienaavtoklassifikacivy = 'Ваше задание на автоклассификацию выполняется';
  rsVashezadanienaeksportvypolnyaets = 'Ваше задание (%s\%s) на экспорт выполняется';
  rsVashezadanienahoditsyavoeredipod = 'Ваше задание находится в очереди под номером %d';
  rsVashezadanienaimportvypolnyaetsy = 'Ваше задание на импорт выполняется';
  rsVovremyaeksportaproizoshlaoshibk = 'Во время экспорта произошла ошибка';
  rsVozmozhnonekotoryedokumentysoder = 'Возможно некоторые документы содержат ошибки. ';
  rsYyyyMmDdHhNnSsZzz = 'yyyy-mm-dd hh-nn-ss-zzz';
  rsZadanienaavtoklassifikacivypolne = 'Задание на автоклассификацию выполнено';
  rsZadanienaavtoklassifikacivypolny = 'Задание на автоклассификацию выполняется';
  rszadaniyostatsyanabudutshee = '%d заданий остаются на будущее';
  rsZapislogakommentariev = 'Запись лога комментариев';

// END resource string wizard section

 rsSavedTaskList = 'SavedTaskList';
 rsDelayedTaskList = 'DelayedTaskList';
 rsExportQueryDeleted = 'Ваше задание на экспорт (%s и %s в %s) '#10'удалено из очереди';
 rsImportQueryDeleted = 'Ваше задание на импорт удалено из очереди';
 rsAlreadyAdded = 'Ваше задание уже добавлено в очередь';
 rsErrorQuery   = 'Информация о Вашем задании ошибочна';
 rsExportQuery  = 'Пришел запрос на экспорт от %s (%s)';
 rsImportQuery  = 'Запрос на импорт от %s';
 rsQueryAdded   = 'Ваше задание добавлено в очередь под номером %d';
 srErrorAtExport = 'Во время выполнения Вашего задания на экспорт произошла ошибка';

 rsQueryFound = 'Найдено задание пользователя %s';
 rsQueryListEmpty = '  - очередь пуста';
 rsProcessNQueries = '  - идет обработка %d запросов';
 rsAddedByIndex = 'Ваше задание добавлено в очередь под номером %d';
 rsBadImportFound = 'Найдено задание, выполнение которого привело к сбою. Добавлять в очередь?';

 sStartStream = '<?xml version="1.0" encoding="windows-1251"?>'#13#10'<list>'#13#10;
 sFinishStream = '</list>'#13#10;


  SAutoPipeServerForm_BackupRoot = 'BackupRoot';
  SAutoPipeServerForm_Dannayaoperaciyaprivedetkotklyue = 'Данная операция приведет к отключению ВСЕХ пользователей. Продолжить?';
  SAutoPipeServerForm_imyakomp_yuteraopredelit_neudalo = 'Имя компьютера определить не удалось';
  SAutoPipeServerForm_ishodnyedannyedlyapostroeniyaDel = 'Исходные данные для построения "Дельты" пока НЕ готовы';
  SAutoPipeServerForm_IsLocalBase = 'IsLocalBase';
  SAutoPipeServerForm_LocalBasePath = 'LocalBasePath';
  SAutoPipeServerForm_Nakomp_yutererabotaet = 'На компьютере "%s" работает %s';
  SAutoPipeServerForm_Podtverzhdenie = 'Подтверждение';
  SAutoPipeServerForm_Poiskpol_zovatelyapoimenikomp_yu = 'Поиск пользователя по имени компьютера';
  SAutoPipeServerForm_Scheduler = 'Scheduler';
  SAutoPipeServerForm_Ukazhiteimyakomp_yutera = 'Укажите имя компьютера';
  SAutoPipeServerForm_UNCBasePath = 'UNCBasePath';
  SAutoPipeServerForm_VsegotovodlyapostroeniyaDel_ty = 'Все готово для построения "Дельты"';
  SAutoPipeServerForm_ConfirmExit = 'Вы уверены, что хотите закончить работу?';
  SAutoPipeServerForm_YyyyMmDd = 'yyyy-mm-dd';

  rsOshibka = 'Ошибка!';
  rs = ') ';
  rs1 = '?? ??? ???? ??:?? <- %s';
  rsAvtoklassifikaciya = 'Автоклассификация (';
  rsDannayaoperaciyaotklitVSEHpolzov = 'Данная операция отключит пользователя без дополнительного предупреждения. Продолжить?';
  rsDdMmmYyyyHhNn = 'dd mmm yyyy hh:nn';
  rsDdMmYyHhNn = 'dd/mm/yy hh:nn';
  rsEksport = 'Экспорт (';
  rseksport1 = 'экспорт';
  rsFamilyConst = 'FamilyConst';
  rsFamilyPath = 'FamilyPath';
  rsFormirovaniesoobtsheniya = 'Формирование сообщения...';
  rsIdetimport = 'Идет импорт...';
  rsImport = 'Импорт (';
  rsimport1 = 'импорт';
  rsIndeksaciyanazvaniydokumentov = 'Индексация названий документов...';
  rsInicializaciya = 'Инициализация';
  rsInkognito = 'Инкогнито';
  rsiz = '%d из %d';
  rsklassifikaciya = 'классификация';
  rsnaydeno = 'Найдено %d';
  rsOered = 'Очередь: %d';
  rsOibkainicializaciibazydannyhPopr = 'Ошибка инициализации базы данных. Проверьте пути к базе данных и попробуйте еще раз.';
  rsOtlozheno = 'Отложено';
  rsOzhidaniezadaniy = 'Ожидание заданий';
  rsPodgotovkaavtoklassifikacii = 'Подготовка автоклассификации...';
  rsPodgotovkaeksporta = 'Подготовка экспорта...';
  rsPoiskoeredi = 'Поиск очереди...';
  rsPolzovateli = 'Пользователи (%d)';
  rsPostoyannayabaza = 'Постоянная база (%s)';
  rsProverkatekstovoybazy = 'Проверка текстовой базы...';
  rsSessiyaostanovlenaDDMMYYYYvHhNn = 'Сессия остановлена DD.MM.YYYY в hh:nn';
  rsSessiyazaputshenaDdMmYyyyvHhNn = 'Сессия запущена dd.mm.yyyy в hh:nn';
  rsSozdaniekopiibazy = 'Создание копии базы...';
  rsSozdaniepolnoykopiibazy = 'Создание полной копии базы...';
  rsumenyadlyavasplohayanovostvperem = 'У меня для вас плохая новость - в переменной части обнаружены кросс-линки.';
  rsSaveUnfinishedTaskList = 'В очереди есть необработанные задания. Вы хотите их сохранить?';
  rsVosstanovleniebazy = 'Восстановление базы...';
  rsVosstanovleniepolnoybazy = 'Восстановление полной базы...';
  rsVovremyapodgotovkiDeltyproizolao = 'Во время подготовки "Дельты" произошла ошибка';
  rsVremennayabaza = 'Временная база (%s)';
  rsZadaniya = 'Задания (%d/%d)';
  rsZagruzkaDelty = 'Загрузка "Дельты"...';
  rsZagruzkafaylaklevyhslov = 'Загрузка файла ключевых слов...';
  rsZagruzkaNSRCfaylov = 'Загрузка NSRC-файлов...';
  rsZamorozheno = 'Заморожено';

// END resource string wizard section

  SDeleted = 'удалено';
  SRun = 'выполняется';
  SDone = 'выполнено';
  SWaiting = 'ожидание';
  SalcuAutoPipeServer_AddDeltaCreator = 'AddDeltaCreator';
  SalcuAutoPipeServer_ArchiLogFileName = 'ArchiLogFileName';
  SalcuAutoPipeServer_Arhivsklyuaminesozdan = 'Архив с ключами не создан';
  SalcuAutoPipeServer_Arhivsklyuamisozdan = 'Архив с ключами создан';
  SalcuAutoPipeServer_BackupCount = 'BackupCount';
  SalcuAutoPipeServer_BackupRoot = 'BackupRoot';
  SalcuAutoPipeServer_BadImportDir = 'BadImportDir';
  SalcuAutoPipeServer_BaseDocPath = 'BaseDocPath';
  SalcuAutoPipeServer_BazaArhivariusaotkrytadlyaraboty = 'База "Архивариуса" открыта для работы.';
  SalcuAutoPipeServer_Bazazakrytanavremyavypolneniyapr = 'База закрыта на время выполнения профилактических работ.';
  SalcuAutoPipeServer_BS = ' /B /S > ';
  SalcuAutoPipeServer_Bserv001 = 'bserv001';
  SalcuAutoPipeServer_Bserv001Ext = 'bserv001.ext';
  SalcuAutoPipeServer_CheckLogFile = 'CheckLogFile';
  SalcuAutoPipeServer_Cmd = 'cmd';
  SalcuAutoPipeServer_ComKw = 'com.kw';
  SalcuAutoPipeServer_ComRar = 'com.rar';
  SalcuAutoPipeServer_DateOfBaseTxt = 'Date Of Base.txt';
  SalcuAutoPipeServer_Dd17076352 = 'dd17076352';
  SalcuAutoPipeServer_DdNnnnnnnnnnnnYyyy = 'dd nnnnnnnnnnnn yyyy';
  SalcuAutoPipeServer_DeltaCreator = 'DeltaCreator';
  SalcuAutoPipeServer_Dir = 'dir ';
  SalcuAutoPipeServer_Dobropozhalovat_vArhivarius = 'Добро пожаловать в "Архивариус"';
  SalcuAutoPipeServer_DoDictEntryIndex = 'DoDictEntryIndex';
  SalcuAutoPipeServer_DoEverydayUpdate = 'DoEverydayUpdate';
  SalcuAutoPipeServer_DoEveryweekUpdate = 'DoEveryweekUpdate';
  SalcuAutoPipeServer_DoFullBackup = 'DoFullBackup';
  SalcuAutoPipeServer_DoHeaderIndex = 'DoHeaderIndex';
  SalcuAutoPipeServer_DoHolidayBase = 'DoHolidayBase';
  SalcuAutoPipeServer_DoImportKW = 'DoImportKW';
  SalcuAutoPipeServer_DoMakeDelta = 'DoMakeDelta';
  SalcuAutoPipeServer_doprevysheniepredelaostalos_Mbay = '%s, до превышение предела осталось %s';
  SalcuAutoPipeServer_DoUpdateBase = 'DoUpdateBase';
  SalcuAutoPipeServer_DoUpdateIndex = 'DoUpdateIndex';
  SalcuAutoPipeServer_DoUpdateText = 'DoUpdateText';
  SalcuAutoPipeServer_DoUpdateTextIndex = 'DoUpdateTextIndex';
  SalcuAutoPipeServer_Email = 'email';
  SalcuAutoPipeServer_ErrorsYYYYMMDDLog = '"Errors - "YYYY-MM-DD."log"';
  SalcuAutoPipeServer_EverydayBackupCount = 'EverydayBackupCount';
  SalcuAutoPipeServer_Export = 'Export';
  SalcuAutoPipeServer_Ezhednevnayaproceduraobnovleniya = 'Ежедневная процедура обновления базы завершена';
  SalcuAutoPipeServer_Ezhenedel_noeobnovleniezavershen = 'Еженедельное обновление завершено';
  SalcuAutoPipeServer_FamilyBackup = 'FamilyBackup';
  SalcuAutoPipeServer_FamilyConst = 'FamilyConst';
  SalcuAutoPipeServer_FamilyPath = 'FamilyPath';
  SalcuAutoPipeServer_Fayl = 'Файл ';
  SalcuAutoPipeServer_Fayletapovotsutstvuet = 'Файл этапов отсутствует';
  SalcuAutoPipeServer_Faylklyuevyhslov = 'Файл ключевых слов';
  SalcuAutoPipeServer_Faylklyuevyhslovneimportirovan = 'Файл ключевых слов не импортирован';
  SalcuAutoPipeServer_Faylklyuevyhslovneimportirovanin = 'Файл ключевых слов не импортирован и не отправлен в Тверь.';
  SalcuAutoPipeServer_Faylklyuevyhslovnenayden = 'Файл ключевых слов (%s) не найден';
  SalcuAutoPipeServer_Faylklyuevyhslovskopirovanuspesh = 'Файл ключевых слов скопирован успешно';
  SalcuAutoPipeServer_Faylklyuevyhslovuspeshnoimportir = 'Файл ключевых слов успешно импортирован.';
  SalcuAutoPipeServer_FaylneotpravlenvTver_ = 'Файл не отправлен в Тверь.';
  SalcuAutoPipeServer_FaylotpravlenvTver_ = 'Файл отправлен в Тверь.';
  SalcuAutoPipeServer_FreeSpaceLimit = 'FreeSpaceLimit';
  SalcuAutoPipeServer_FullBackup = 'FullBackup';
  SalcuAutoPipeServer_FullBackupAtDays = 'FullBackupAtDays';
  SalcuAutoPipeServer_Garant = '\garant\*.*';
  SalcuAutoPipeServer_Garant1 = '\garant\';
  SalcuAutoPipeServer_Garant2 = '\garant';
  SalcuAutoPipeServer_GarDocDir = 'GarDocDir';
  SalcuAutoPipeServer_HolidayFolder = 'HolidayFolder';
  SalcuAutoPipeServer_Idx = '*.idx';
  SalcuAutoPipeServer_ImageBaseListCmd = 'ImageBaseList.cmd';
  SalcuAutoPipeServer_ImageBaseListTxt = 'ImageBaseList.txt';
  SalcuAutoPipeServer_ImageStoragePath = 'ImageStoragePath';
  SalcuAutoPipeServer_importekvivalentnyhklassov = 'Импорт эквивалентных классов';
  SalcuAutoPipeServer_importekvivalentnyhklassovzavers = 'Импорт эквивалентных классов завершен';
  SalcuAutoPipeServer_importezhenedel_noyraznicydokume = 'Импорт еженедельной разницы документов';
  SalcuAutoPipeServer_importNSRCfaylovifaylaklyuevyhsl = 'Импорт NSRC-файлов и файла ключевых слов завершен';
  SalcuAutoPipeServer_IP = '%s (IP:%s)';
  SalcuAutoPipeServer_IsLocalBase = 'IsLocalBase';
  SalcuAutoPipeServer_itogkopirovaniyaKodoshibki = 'Итог копирования : Код ошибки %d (%s)';
  SalcuAutoPipeServer_izostalos_ = '%s из %s (осталось %s)';
  SalcuAutoPipeServer_Kompilyaciyaslovareyzavershena = 'Компиляция словарей завершена';
  SalcuAutoPipeServer_Kopirovaniebazyzaversheno = 'Копирование базы завершено';
  SalcuAutoPipeServer_Kopirovaniefaylaetapov = 'Копирование файла этапов';
  SalcuAutoPipeServer_Kopirovaniefaylaetapovzaversheno = 'Копирование файла этапов завершено';
  SalcuAutoPipeServer_KopirovaniefaylaklyuevyhslovsFTP = 'Копирование файла ключевых слов с FTP';
  SalcuAutoPipeServer_Kopiyafayla = 'Копия файла ';
  SalcuAutoPipeServer_Kopiyaotliaetsyaotoriginala = 'Копия (%s) отличается от оригинала (%s):';
  SalcuAutoPipeServer_KWfaylskopirovanneverno = 'KW-файл скопирован неверно';
  SalcuAutoPipeServer_KWFileName = 'KWFileName';
  SalcuAutoPipeServer_LocalBasePath = 'LocalBasePath';
  SalcuAutoPipeServer_Logfaylraznicydokumentovetsheneg = 'Лог-файл разницы документов еще не готов. Продолжить?';
  SalcuAutoPipeServer_Logfaylraznicydokumentovetsheneg1 = 'Лог-файл разницы документов еще не готов. Импорт еженедельной разницы откладывается на 30 минут';
  SalcuAutoPipeServer_MaxArchiLogFileSize = 'MaxArchiLogFileSize';
  SalcuAutoPipeServer_MaxExportAge = 'MaxExportAge';
  SalcuAutoPipeServer_MertvyedushineobnaruzhenyVypolni = 'Мертвые души не обнаружены. Выполнить снятие "замков"?';
  SalcuAutoPipeServer_NaaloimportaNSRCfaylovifaylaklyu = 'Начало импорта NSRC-файлов и файла ключевых слов';
  SalcuAutoPipeServer_Naalokompilyaciislovarey = 'Начало компиляции словарей';
  SalcuAutoPipeServer_Naalokopirovaniyabazy = 'Начало копирования базы';
  SalcuAutoPipeServer_Naaloobnovleniyabazy = 'Начало обновления базы';
  SalcuAutoPipeServer_Naaloobnovleniyatekstovogoindeks = 'Начало обновления текстового индекса';
  SalcuAutoPipeServer_Naaloobnovleniyatekstovoyasti = 'Начало обновления текстовой части';
  SalcuAutoPipeServer_Naalopolnogokopirovaniyabazy = 'Начало полного копирования базы';
  SalcuAutoPipeServer_Naalovosstanovleniyabazy = 'Начало восстановления базы';
  SalcuAutoPipeServer_Naalovypolneniyaprofilaktieskogo = 'Начало выполнения профилактического обновления';
  SalcuAutoPipeServer_NarryOitPuGarant = '.narry.oit.pu.garant';
  SalcuAutoPipeServer_Naydenyzadaniyaostavshiesyaspros = 'Найдены задания, оставшиеся с прошлой сессии. Разрешить их обработку?';
  SalcuAutoPipeServer_Neudalos_opredelit_svobodnoemest = 'Не удалось определить свободное место на диске с базой. ';
  SalcuAutoPipeServer_Neudalos_skopirovat_faylklyuevyh = 'Не удалось скопировать файл ключевых слов';
  SalcuAutoPipeServer_Nevozmozhnoskopirovat_faylklyuev = 'Невозможно скопировать файл ключевых слов с FTP - ';
  SalcuAutoPipeServer_Nevsepol_zovatelipokinuliArhivar = 'Не все пользователи покинули "Архивариус"';
  SalcuAutoPipeServer_NotifyAddress = 'NotifyAddress';
  SalcuAutoPipeServer_Obnovleniebazydannyhnevypoleneno = 'Обновление базы данных не выполнено';
  SalcuAutoPipeServer_Obnovleniebazyzaversheno = 'Обновление базы завершено';
  SalcuAutoPipeServer_Obnovlenieindeksazagolovkovnevyp = 'Обновление индекса заголовков не выполнено';
  SalcuAutoPipeServer_Obnovlenietablic = 'Обновление таблиц';
  SalcuAutoPipeServer_Obnovlenietabliczakonilos_soshib = 'Обновление таблиц закончилось с ошибкой';
  SalcuAutoPipeServer_Obnovlenietabliczaversheno = 'Обновление таблиц завершено';
  SalcuAutoPipeServer_Obnovlenietekstovogoindeksanevyp = 'Обновление текстового индекса не выполнено';
  SalcuAutoPipeServer_Obnovlenietekstovogoindeksazaver = 'Обновление текстового индекса завершено';
  SalcuAutoPipeServer_Obnovlenietekstovoyastizavershen = 'Обновление текстовой части завершено';
  SalcuAutoPipeServer_Oerednayaversiyafaylaklyuevyhslo = 'Очередная версия файла ключевых слов';
  SalcuAutoPipeServer_PurgingExportsFolder = 'Очистка папок экспорта';
  SalcuAutoPipeServer_PurgingExportsFolderComplete = 'Очистка папок экспорта завершена';
  SalcuAutoPipeServer_Oshibkaimportaekvivalentnyhklass = 'Ошибка импорта эквивалентных классов %s';
  SalcuAutoPipeServer_Oshibkaimportaetalonnoytablicyva = 'Ошибка импорта эталонной таблицы важности';
  SalcuAutoPipeServer_OshibkaimportaNSRCfaylov = 'Ошибка импорта NSRC-файлов';
  SalcuAutoPipeServer_Oshibkakompilyaciislovarey = 'Ошибка компиляции словарей';
  SalcuAutoPipeServer_Oshibkakopirovaniya = 'Ошибка копирования - ';
  SalcuAutoPipeServer_Oshibkakopirovaniyabazy = 'Ошибка копирования базы';
  SalcuAutoPipeServer_Oshibkaobnovleniyabazy = 'Ошибка обновления базы';
  SalcuAutoPipeServer_Oshibkapostroeniyaindeksaslovarn = 'Ошибка построения индекса словарных статей';
  SalcuAutoPipeServer_Oshibkapostroeniyaindeksazagolov = 'Ошибка построения индекса заголовков';
  SalcuAutoPipeServer_OshibkasozdaniyaBazyvyhodnogodny = 'Ошибка создания "Базы выходного дня"';
  SalcuAutoPipeServer_Oshibkasozdaniyafaylasspiskomgra = 'Ошибка создания файла с списком графических образов';
  SalcuAutoPipeServer_Oshibkasozdaniyapolnoykopiibazy = 'Ошибка создания полной копии базы %s';
  SalcuAutoPipeServer_Oshibkaudaleniyafayla = 'Ошибка удаления файла ';
  SalcuAutoPipeServer_Oshibkavosstanovleniyabazy = 'Ошибка восстановления базы';
  SalcuAutoPipeServer_Oshibkazapisilogaoshibokimporta = 'Ошибка записи лога ошибок импорта';
  SalcuAutoPipeServer_Ostalos_ = 'Осталось %s';
  SalcuAutoPipeServer_ostanovkamehanizmadostupakbazeda = 'остановка механизма доступа к базе данных';
  SalcuAutoPipeServer_Otklyueniepol_zovateley = 'Отключение %d пользователей:';
  SalcuAutoPipeServer_Otklyueniepol_zovatelya = 'Отключение пользователя:';
  SalcuAutoPipeServer_Otliaetsyaotoriginala = ' Отличается от оригинала';
  SalcuAutoPipeServer_otsutstvuet = ' отсутствует';
  SalcuAutoPipeServer_Pereklyuenienapostoyannuyubazu = 'Переключение на постоянную базу';
  SalcuAutoPipeServer_Pereklyuenienavremennuyubazu = 'Переключение на временную базу';
  SalcuAutoPipeServer_PictureFolder = 'PictureFolder';
  SalcuAutoPipeServer_Polnaya = 'Полная ';
  SalcuAutoPipeServer_Postroenieindeksaslovarnyhstatey = 'Построение индекса словарных статей';
  SalcuAutoPipeServer_Postroenieindeksaslovarnyhstatey1 = 'Построение индекса словарных статей завершено';
  SalcuAutoPipeServer_Postroenieindeksazagolovkov = 'Построение индекса заголовков';
  SalcuAutoPipeServer_Postroenieindeksazagolovkovzaver = 'Построение индекса заголовков завершено';
  SalcuAutoPipeServer_PotomVysmozheteotmenit_vosstanov = 'Потом Вы сможете отменить восстановление.';
  SalcuAutoPipeServer_prevysheniepredelanaMbayt = '%s - превышение предела на %s';
  SalcuAutoPipeServer_AbortProcessing = 'Принудительное прерывание всех операций';
  SalcuAutoPipeServer_StopProcessing = 'Остановка обработки новых операций';
  SalcuAutoPipeServer_PriorityFileName = 'PriorityFileName';
  SalcuAutoPipeServer_Profilaktieskoeobnovleniezaversh = 'Профилактическое обновление завершено';
  SalcuAutoPipeServer_Programmanastroenanarabotuslokal = 'Программа настроена на работу с локальными путями. Переключиться на глобальные?';
  SalcuAutoPipeServer_Proverkatonostikopii = 'Проверка точности копии';
  SalcuAutoPipeServer_Proverkazavershenauspeshno = 'Проверка завершена успешно';
  SalcuAutoPipeServer_Prover_teparametrLokal_nyyput_kb = 'Проверьте параметр "Локальный путь к базе данных".';
  SalcuAutoPipeServer_Rasetvazhnostidokumentov = 'Расчет важности документов.';
  SalcuAutoPipeServer_Rasetvazhnostidokumentovzakonen = 'Расчет важности документов закончен.';
  SalcuAutoPipeServer_SafeDirName  = 'SafeDirName';
  SalcuAutoPipeServer_MaxImportAge = 'MaxImportAge';
  SalcuAutoPipeServer_Scheduler = 'Scheduler';
  SalcuAutoPipeServer_ShowSplash = 'ShowSplash';
  SalcuAutoPipeServer_Snyatiezamkovsbazyzavershilos_so = 'Снятие "замков" с базы завершилось с ошибкой: %d';
  SalcuAutoPipeServer_Sostoyanieobnovleniya = 'Состояние обновления = ';
  SalcuAutoPipeServer_SourceFolder = 'SourceFolder';
  SalcuAutoPipeServer_SozdanieBazyvyhodnogodnya = 'Создание "Базы выходного дня"';
  SalcuAutoPipeServer_SozdanieBazyvyhodnogodnyazaversh = 'Создание "Базы выходного дня" завершено';
  SalcuAutoPipeServer_Sozdaniepolnoykopiibazyzavershen = 'Создание полной копии базы завершено';
  SalcuAutoPipeServer_Tom = 'tom';
  SalcuAutoPipeServer_TverKW = 'TverKW';
  SalcuAutoPipeServer_udalen = ' удален';
  SalcuAutoPipeServer_Udalenie = 'Удаление ';
  SalcuAutoPipeServer_Udalenierezervnyhkopiy = 'Удаление резервных копий...';
  SalcuAutoPipeServer_Udalenierezervnyhkopiyzaversheno = 'Удаление резервных копий завершено';
  SalcuAutoPipeServer_Udaleniestaryhindeksov = 'Удаление старых индексов';
  SalcuAutoPipeServer_Udaleniestaryhrezervnyhkopiy = 'Удаление старых резервных копий';
  SalcuAutoPipeServer_Udaleniestaryhverashnihkopiy = 'Удаление старых "вчерашних" копий';
  SalcuAutoPipeServer_UNCBasePath = 'UNCBasePath';
  SalcuAutoPipeServer_UndoRestore = 'UndoRestore';
  SalcuAutoPipeServer_Unitozhenoudalennyhdokumentov = 'Уничтожено %d удаленных документов';
  SalcuAutoPipeServer_Usr = 'Usr#*';
  SalcuAutoPipeServer_Verashnyayakopiyaneobnaruzhena = 'Вчерашняя копия не обнаружена';
  SalcuAutoPipeServer_Versiidokumentovvosnovnomirezerv = 'Версии документов в основном и резервном хранилищах совпадают';
  SalcuAutoPipeServer_Versiinekotoryhdokumentovvosnovn = 'Версии некоторых документов в основном и резервном хранилищах различаются';
  SalcuAutoPipeServer_Vkopiiotsutstvuetfayl = 'В копии отсутствует файл ';
  SalcuAutoPipeServer_Vnimanieerezminutnanutsyaprofila = 'Внимание! Через %d минут начнутся профилактические работы.'^M;
  SalcuAutoPipeServer_Vosstanovleniebazyzaversheno = 'Восстановление базы завершено';
  SalcuAutoPipeServer_Vovremyaimportaproizoshlaoshibka = 'Во время импорта произошла ошибка';
  SalcuAutoPipeServer_Vremennaya = 'Временная ';
  SalcuAutoPipeServer_Vremyaisteklo = 'Время истекло';
  SalcuAutoPipeServer_VremyapodgotovkiDel_tyisteklo = 'Время подготовки "Дельты" истекло';
  SalcuAutoPipeServer_VremyavyshloDerzhat_syabol_shene = 'Время вышло. "Держаться больше нету сил..."';
  SalcuAutoPipeServer_Vsepol_zovatelibudutotklyuenyZav = 'Все пользователи будут отключены. Завершите свою работу до истечения %d минут.';
  SalcuAutoPipeServer_Vydeystvitel_nohotiteotmenit_vos = 'Вы действительно хотите отменить восстановление семейства?';
  SalcuAutoPipeServer_Vydeystvitel_nohotitevosstanovit = 'Вы действительно хотите восстановить семейство?'#10;
  SalcuAutoPipeServer_WaitTime = 'WaitTime';
  SalcuAutoPipeServer_WorkDayStart = 'WorkDayStart';
  SalcuAutoPipeServer_YyyyMmDd = 'yyyy-mm-dd';
  SalcuAutoPipeServer_Zabytyepol_zovateli = '"Забытые" пользователи:';
  SalcuAutoPipeServer_Zamkisbazysnyatyuspeshno = '"Замки" с базы сняты успешно';
  SalcuAutoPipeServer_Zapuskmehanizmadostupakbazedanny = 'Запуск механизма доступа к базе данных';

// END resource string wizard section

  rsCheckStorageDone = 'Сравнение хранилищ завершено';
  rsStorageAbsent = 'Резервное хранилище отсутствует';
  rsCheckStorage = 'Сравнение хранилищ';
  rsHolidayMask = '"Архивариус сердечно поздравляет своих пользователей с праздником %s';
  SalcuAutoPipeServer_DeltaNotStarted = 'Процедура подготовки и импорта "Дельты" не началась!'#10'На базе работают пользователи';
  SalcuAutoPipeServer_StageNotCopied = 'Файл этапов не скопирован, так как не все пользователи покинули "Архивариус"';
  SalcuAutoPipeServer_IndexNotUpdate = 'Текстовый индекс не обновлен, так как не все пользователи покинули "Архивариус"';
  SalcuAutoPipeServer_KWNotLoaded = 'Ключевые слова не импортированы, так как не все пользователи покинули "Архивариус"';
  rsNotEnoughSpace = 'На диске свободно %s';
  rsAdditionalCreatedSuccessful = 'Дополнительная дельта успешно создана';
  rsErrorCreateAdditional = 'Ошибка %d создания дополнительной дельты';
  rsUpdateTextBaseError = 'Ошибка обновления переменной части';
  rsStartBuildTextIndex = 'Начало полного перестроения текстового индекса';
  rsTextIndexBuilded = 'Перестроение текстового индекса завершено';
  rsStartTextUpdate = 'Начало обновления переменной части';
  rsTextUpdateDone = 'Обновление переменной части завершено';
  rsPleaseQuit = 'Пожалуйста, завершите работу с "Архивариусом"';
  rsUserNotQuit = 'Пользователь %s не покинул(а) Архивариус';
  rsDeltaCreateError = 'Во время подготовки "Дельты" произошла ошибка #%d';
  rsDeltaCreated = '"Дельта" подготовлена успешно';
  rsSpravkiFileName = '\\archi\archi\incoming\spravki\diff.lst';


 rsErrorSendMessage = 'Ошибка доставки сообщения пользователю %s';
 rsEveryDayUpdate = 'Ежедневная процедура обновления базы';
 rsResetArchiLogError = 'Ошибка переименования файла лога Архивариуса';
 rsPrepareDelta = 'Подготовка файлов "Дельты"';
 rsSpravki = 'Не все справки попали в Дельту документов. Список документов находится во вложении.';
 rsCopyBackupToVersion = 'Копирую из бэкапа в переменную часть';
 rsCopyVersionToBackup = 'Копирую из переменной части в бэкап';

 cServiceName = 'ArchiService';
 cServiceDisplayName = 'Сервер Автоматизации Архивариуса';

 cExecutorLogName = 'alcu_%s.log';

implementation

end.
