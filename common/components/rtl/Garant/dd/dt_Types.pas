Unit Dt_Types;

{ $Id: dt_Types.pas,v 1.76 2016/08/11 10:47:44 lukyanets Exp $ }

// $Log: dt_Types.pas,v $
// Revision 1.76  2016/08/11 10:47:44  lukyanets
// Полчищаем dt_user
//
// Revision 1.75  2016/06/16 05:40:04  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.74  2016/06/07 13:41:40  fireton
// - кеширование образов документов
//
// Revision 1.73  2016/05/17 11:59:38  voba
// -k:623081921
//
// Revision 1.72  2016/05/16 12:54:40  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.71  2016/04/27 13:07:47  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.70  2015/09/01 12:31:56  lukyanets
// Заготовки к Postgress
//
// Revision 1.69  2015/04/17 13:39:33  lukyanets
// Подчищаем протухшие словари
//
// Revision 1.68  2015/04/17 11:21:48  lukyanets
// Подчищаем протухшие словари
//
// Revision 1.67  2015/04/08 08:34:41  lukyanets
// Изолируем события
//
// Revision 1.66  2015/03/25 11:07:15  lukyanets
// Обобщаем параметры
//
// Revision 1.65  2015/03/24 10:40:26  lukyanets
// Более правильно корректируем настройки
//
// Revision 1.64  2015/03/04 13:42:57  lukyanets
// Убираем отмершие ошметки
//
// Revision 1.63  2014/12/30 11:56:07  lukyanets
// переносим хелперы
//
// Revision 1.62  2014/10/14 12:35:15  lukyanets
// Пишем/читаем все базовые параметры
//
// Revision 1.61  2014/09/04 13:19:33  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.60  2014/08/12 07:33:54  lukyanets
// {Requestlink:560730919}. Прокидываем флаги базы
//
// Revision 1.59  2014/07/14 15:42:26  lulin
// - учимся читать задания из EVD.
//
// Revision 1.58  2014/07/11 12:53:49  lulin
// - заворачиваем SourceFiles в теги.
//
// Revision 1.57  2014/06/25 16:43:42  lulin
// - делаем регистрацию атрибутов в отдельном списке.
//
// Revision 1.56  2014/06/18 16:55:18  voba
// - bugfix Конфликт Анно-Док
//
// Revision 1.55  2014/02/26 12:49:02  voba
// - удалил ненужный Diapason.Choise:= 1;
//
// Revision 1.54  2013/10/30 10:36:36  voba
// - отказ от fSrchList
//
// Revision 1.53  2013/07/11 12:49:19  voba
// - K:463114355
//
// Revision 1.52  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.51  2013/04/09 11:08:22  lulin
// - пытаемся отладиться под XE.
//
// Revision 1.50  2013/01/17 07:56:32  fireton
// - погорячились с удалением "мусорных" стадий
//
// Revision 1.49  2013/01/16 11:24:43  fireton
// - избавляемся от "мусорных" стадий
//
// Revision 1.48  2013/01/16 09:39:28  voba
// - K:320745193
//
// Revision 1.47  2012/08/16 07:04:08  narry
// Разобраться со странными форматами файлов в dt_Types (385024655)
//
// Revision 1.46  2012/07/27 10:17:00  voba
// - XML support
//
// Revision 1.45  2012/05/24 10:27:36  voba
// no message
//
// Revision 1.44  2012/05/18 11:52:44  voba
// - k:365825731
//
// Revision 1.43  2011/12/16 07:54:56  narry
// Избавляемся от зависимости от dt_Misc
//
// Revision 1.42  2011/12/15 16:32:30  lulin
// - bug fix: не собирались тесты.
//
// Revision 1.41  2011/12/14 11:59:39  voba
// - k:317261462
//
// Revision 1.40  2011/04/11 10:25:01  narry
// Названия для ФАС (259885290)
//
// Revision 1.39  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.38.2.1  2010/09/10 12:19:00  voba
// - k: 235046326
//
// Revision 1.38  2010/08/18 11:27:26  narry
// - нумерация некоторых перечислимых типов
//
// Revision 1.37  2010/04/05 06:24:48  narry
// - заточки под экспериметны с КТ
//
// Revision 1.36  2010/01/18 14:29:04  narry
// - заливка документов с расстановкой команды !CASECODE
//
// Revision 1.35  2009/11/18 10:17:55  voba
// - add comment
//
// Revision 1.34  2009/09/11 08:32:55  voba
// - поменял невзрачное название типа ELEMENT на клевое ThtElementInfo
//
// Revision 1.33  2009/08/28 14:36:26  voba
// - убрал utFullFeatureDocTypesEx
//
// Revision 1.32  2009/08/25 13:35:55  voba
// - add type TUserType kind utCard,utDossier
//
// Revision 1.31  2009/07/20 12:39:00  voba
// - Засунул renum в атрибуты
//
// Revision 1.30  2009/07/06 11:02:47  narry
// - форматирование текстов постановления
// - исправлены ошибки в генерации названия
// - добавлены новые типы участников процесса
//
// Revision 1.29  2009/06/23 07:33:58  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.28  2009/06/08 13:23:22  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.27  2009/04/24 09:37:53  narry
// - Обновление
//
// Revision 1.26  2009/04/21 10:03:06  narry
// - чтение Поставлений Арбтражных судов
//
// Revision 1.25  2009/04/13 07:12:57  narry
// - разделение определения типов и реализации
//
// Revision 1.24  2009/03/31 09:02:55  fireton
// - импорт/экспорт атрибута "Комментарий к документу" [$121164344]
//
// Revision 1.23  2009/03/25 13:57:20  voba
// - add TUserSortProc - прототип юзерской функции сортировки для HT
//
// Revision 1.22  2009/03/19 08:20:53  voba
// - del TSaveSrchDT
//
// Revision 1.21  2009/03/03 08:43:19  fireton
// - PNumberStr
//
// Revision 1.20  2009/02/20 13:27:54  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.19  2009/02/19 16:16:23  voba
// - add const CctAllAttributes
//
// Revision 1.18  2009/02/17 16:46:31  voba
// no message
//
// Revision 1.17  2009/01/13 07:59:06  voba
// - add  TDLPassportRec.rDefValue
//
// Revision 1.16  2008/11/21 12:36:58  voba
// no message
//
// Revision 1.15  2008/11/12 15:01:08  voba
// - add const
//
// Revision 1.14  2008/11/10 14:30:38  fireton
// - новый тип
//
// Revision 1.13  2008/10/15 09:06:59  fireton
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.12  2008/09/23 12:17:48  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.11  2008/09/17 14:47:45  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.10  2008/09/15 09:04:39  voba
// -add type TCorSrcShortName
//
// Revision 1.9  2008/08/11 08:47:03  voba
// - поиск по stCorSources ( не доделано)
//
// Revision 1.8  2008/07/08 13:32:30  voba
// - поменял формат TReadDictChangeProc
//
// Revision 1.7  2008/07/03 12:10:29  voba
// - add TReadDictChangeProc
//
// Revision 1.6  2008/06/10 10:55:19  fireton
// - поддержка Flash-документов
//
// Revision 1.5  2008/05/08 14:04:08  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.4  2008/05/05 10:41:44  voba
// - избавлялся от старой автоклассификации
//
// Revision 1.3  2008/04/14 12:44:31  voba
// - enh. расширил TDLPassportRec
//
// Revision 1.2  2008/03/27 09:39:41  voba
// - поиск по Published
//
// Revision 1.1  2008/02/26 12:30:57  lulin
// - боремся за чистоту арийской рассы.
//
// Revision 1.117  2008/02/12 14:38:57  voba
// - add some types
//
// Revision 1.116  2007/11/26 09:34:37  voba
// - use cUndefDictID
//
// Revision 1.115  2007/11/22 14:38:58  fireton
// - приводим информацию о всех пользователей, захвативших документ
//
// Revision 1.114  2007/10/25 11:10:33  voba
// - cc
//
// Revision 1.113  2007/10/09 08:53:53  voba
// - merge with b_archi_export_refact2
//
// Revision 1.112  2007/09/17 06:53:28  voba
// no message
//
// Revision 1.111  2007/08/28 13:54:18  voba
// - update to 128 DB version
//
// Revision 1.110  2007/08/14 14:30:09  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.109.2.9  2007/09/14 14:36:50  voba
// no message
//
// Revision 1.109.2.8  2007/09/11 15:08:08  voba
// no message
//
// Revision 1.109.2.7  2007/09/04 13:40:11  voba
// - add TdtOpenMode
//
// Revision 1.109.2.6  2007/08/27 13:12:12  voba
// no message
//
// Revision 1.109.2.5  2007/08/20 06:31:30  voba
// no message
//
// Revision 1.109.2.4  2007/08/10 12:07:51  voba
// - marge with head
//
// Revision 1.109.2.3  2007/08/06 12:54:53  voba
// no message
//
// Revision 1.109.2.2  2007/07/30 07:24:01  voba
// no message
//
// Revision 1.109.2.1  2007/07/26 12:08:31  voba
// - refact. выкинул  ImportType, все равно он только ietMassive использовался
//
// Revision 1.109  2007/07/19 08:55:16  voba
// no message
//
// Revision 1.108  2007/06/25 12:18:50  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.107  2007/06/20 11:47:56  voba
// - add dict dlServiceInfo
//
// Revision 1.106  2007/05/14 06:32:51  narry
// - удаление неиспользуемых таблиц
//
// Revision 1.105  2007/04/27 14:30:41  voba
// - ren  L2RecModifyProc -> L2RecAccessProc
//
// Revision 1.104  2007/04/26 10:56:50  fireton
// - Рефакторинг DT. Таблица DICTSRC больше не нужна.
//
// Revision 1.103  2007/04/26 10:26:49  fireton
// - Рефакторинг DT. Имена словарей переехали в cDLPassports.
//
// Revision 1.102  2007/04/26 10:01:43  fireton
// - Рефакторинг DT. Переход DT_Link и DT_Dict от таблиц к типам словарей.
//
// Revision 1.101  2007/04/25 09:30:57  fireton
// - Рефакторинг DT. Все типы переехали в DT_Types, а константы - в DT_Const
//
// Revision 1.100  2007/04/25 07:52:38  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.99  2007/04/17 06:25:07  voba
// - add type
//
// Revision 1.98  2007/04/09 11:41:38  fireton
// - максимально возможный размер имени таблицы - 8 символов (а не 5)
//
// Revision 1.97  2007/03/15 14:01:37  narry
// - не компилировалось
//
// Revision 1.96  2007/03/15 12:31:19  voba
// - merge with b_archi_BigDictID
//
// Revision 1.95  2007/03/14 15:14:32  fireton
// - merge полезных штук из ветки b_archi_BigDictID
// - тип групп пользователей теперь не TDictID, а TUserGrID
// - подчищен код замены пароля пользователей
// - замена указателя на дин.массив для массива групп пользователей
//
// Revision 1.94.2.3  2007/03/14 13:42:56  fireton
// - PUserGrID и TRegionID
//
// Revision 1.94.2.2  2007/03/13 07:07:51  voba
// no message
//
// Revision 1.94.2.1  2007/03/09 13:35:42  voba
// no message
//
// Revision 1.94.2.3  2007/03/14 13:42:56  fireton
// - PUserGrID и TRegionID
//
// Revision 1.94  2007/03/09 07:37:04  voba
// - _move type TFieldArray  to Dt_Types
//
// Revision 1.93  2007/02/22 14:33:53  narry
// - переход к 64 битам
//
// Revision 1.92  2007/02/22 13:35:39  fireton
// - переход на 64 бита в HyTech
//
// Revision 1.91  2007/02/16 16:07:46  voba
// - _move   TFillBufferProc  TdtRecModifyProc to dt_Types
//
// Revision 1.90  2006/12/13 13:49:41  fireton
// - добавлен TPublishLinkRec
//
// Revision 1.89  2006/11/07 16:15:25  voba
// - cc
//
// Revision 1.88  2006/10/05 10:04:37  voba
// no message
//
// Revision 1.87  2006/10/04 08:40:09  voba
// - remove tdSingle
//
// Revision 1.86  2006/06/08 15:54:46  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.85.2.1  2006/06/08 09:08:02  fireton
// - перевод User ID на Longword
//
// Revision 1.85  2006/06/02 14:22:37  narry
// - обновление: TPrority переехал из dt_User в dt_Types
//
// Revision 1.84  2005/10/27 13:19:36  step
// new: TBigDictId
//
// Revision 1.83  2005/10/21 15:22:14  step
// new: TAppKind
//
// Revision 1.82  2005/10/17 13:17:59  step
// no message
//
// Revision 1.81  2005/10/17 12:56:50  step
// изменена TPublishDataRec (учтено новое поле Nonperiod)
//
// Revision 1.80  2005/09/14 09:00:34  step
// в БД удалена табл. DictSour
//
// Revision 1.79  2005/09/05 09:19:31  step
// изменен TFamTbls - учтены новые таблицы
//
// Revision 1.78  2005/09/02 12:28:08  narry
// - update: замена директивы компилятора
//
// Revision 1.77  2005/09/01 14:19:37  narry
// - new: приоритет задания на импорт
//
// Revision 1.76  2005/07/26 10:45:59  narry
// - update: расширение функциональности экспорта - только структура документа
//
// Revision 1.75  2005/03/24 12:15:07  narry
// - изменение формата сообщения об экспорте аннотаций
//
// Revision 1.74  2005/03/16 08:37:38  voba
// - improve заменили PAnsiChar на String
//
// Revision 1.73  2005/03/14 14:01:45  narry
// - update: поддержка пользовательского импорта сторонних аннотаций
//
// Revision 1.72  2005/03/14 11:08:33  narry
// - update: экспорт аннотаций
//
// Revision 1.71  2005/03/11 16:40:01  narry
// - update: поддержка "большой красной кнопки" (экспорт специальных аннотаций)
//
// Revision 1.70  2005/03/02 16:08:07  narry
// - обновление: подготовка к разрешению пользователям импортировать подключенные документы
//
// Revision 1.69  2005/02/22 15:09:03  step
// расширена TExpCardRec
//
// Revision 1.68  2005/02/22 11:56:50  step
// Замена EmptyLinkEqualItem на c_NullValue
//
// Revision 1.67  2005/02/16 17:15:29  narry
// - update: поддержка Аннотаций
//
// Revision 1.66  2004/09/07 09:32:48  voba
//  - add new types
//
// Revision 1.65  2004/08/03 08:52:48  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.64  2004/07/22 14:19:49  voba
// - rename fPriceLevel_Fld ->  fStatus_Fld  PriceLevel ->  Status, который выполняет функцию набора флагов состояния документа (см.dstatChargeFree, dstatNotTM   в  Dt_Const)
//
// Revision 1.63  2004/06/22 13:54:41  step
// new: TSkipDocReason
// change: TSkipDocNotify
//
// Revision 1.62  2004/06/01 13:35:47  narry
// - update: расширение списка параметров задания на экспорт
//
// Revision 1.61  2004/03/26 14:09:41  voba
// no message
//
// Revision 1.60.2.1  2004/03/19 17:11:57  step
// Исправления, связанные с добавлением поля DT#A.PRIVATE
//
// Revision 1.60  2004/03/10 10:41:05  step
// учтено добавление поля TYP в табл. FILE
//
// Revision 1.59  2004/02/27 11:16:37  voba
// no message
//
// Revision 1.58  2004/02/27 10:30:56  voba
// - merge with adding_field_shname
//
// Revision 1.57  2004/02/16 10:49:54  step
// add: cCLExeFilelNotFound
//
// Revision 1.56  2004/02/10 16:24:33  step
// delete:TDocId2, TSubId2
//
// Revision 1.55  2004/02/10 13:35:07  step
// add:TDocId2, TSubId2
//
// Revision 1.54.2.2  2004/02/10 12:10:27  voba
// no message
//
// Revision 1.54.2.1  2004/02/10 11:19:07  step
// add: TPublishDataRec
//
// Revision 1.54  2004/02/03 09:07:07  step
// В таблицу DT#B возвращено поле Coment
//
// Revision 1.53  2004/01/30 11:41:05  narry
// - update: новая структура команды !PUBLISHEDIN
//
// Revision 1.52  2004/01/27 09:58:05  step
// TNetUsersJournal.ClearLocks не выбрасывает исключение, а возвращает Integer
//
// Revision 1.51  2004/01/22 18:33:03  step
// Добавлены константы, возвращаемые программой, которая выполняет снятие блокировок
//
// Revision 1.50  2004/01/13 15:14:26  voba
// - code clean
//
// Revision 1.49  2004/01/09 14:55:33  step
// Добавлен тип TPublishFullRec
//
// Revision 1.48  2003/12/17 11:27:01  narry
// - add: расширение списка параметров сообщения на импорт - отслеживание Группы Доступа "Передано в регионы"
//
// Revision 1.47  2003/11/06 11:59:46  step
// Добавлен тип TPairLongArr
//
// Revision 1.46  2003/10/02 13:56:32  voba
// - new: процедура преобразования типа DestHLinkRec
//
// Revision 1.45  2003/09/09 13:48:47  step
// Перенесена константа CurrentFamily из Main
//
// Revision 1.44  2003/09/08 08:55:10  step
// В TFamTbls, TMainTbls добавлены ftActiv, ftAlarm и mtDictSrc2
//
// Revision 1.43  2003/06/25 09:05:55  narry
// - update: Добавление новой таблицы (LNK#H) в список таблиц для обновления
//
// Revision 1.42  2003/06/03 11:17:16  narry
// - update: изменение типа TexpQueryRec для возможности сохранения заданий на экспорт
//
// Revision 1.41  2003/05/28 15:41:43  voba
// - add: процедурf преобразования типов GlobalCoordinateRec
//
// Revision 1.40  2003/03/13 14:43:59  demon
// - new: добавлено два типа для хранения импортных данных ActiveInterval и Alarm
//
// Revision 1.39  2003/03/13 09:46:32  demon
// - new: добавлено новое поле в данные документа VerLink
// (+удалены некоторые не используемые структуры и поля)
//
// Revision 1.38  2003/03/12 10:32:32  demon
// - del: Внесены изменения в связи с удалением полей
// NoActive и PreActive из таблицы File
//
// Revision 1.37  2003/01/27 13:11:19  demon
// - new behavior: расширен формат типа TSkipDocNotify, теперь в нем есть
// возможность передавать идентификатор пользователя, чьи действия привели к ошибке
//
// Revision 1.36  2003/01/24 16:01:16  narry
// - bug fix
//
// Revision 1.35  2003/01/23 16:45:31  demon
// - new: расширил типы TImpDateNumRec, TImpLogRec, TImpCheckRec, TImpPublishRec
// дополнительными полями позволяющими более полно импортировать эти структуры
//
// Revision 1.34  2003/01/21 17:20:16  demon
// - new: несколько новых типов.
//
// Revision 1.33  2003/01/04 10:15:58  narry
// - update: замена типа поля записи задания на экспорт
//
// Revision 1.32  2002/06/18 15:58:50  voba
// -new behavior : некорректная работа фильтра добавляющего метки в пакетном режиме
//
// Revision 1.31  2002/05/28 11:14:40  demon
// - add new type TDictHistogramRec
//
// Revision 1.30  2002/05/18 11:07:16  demon
// - add new tbl const
//
// Revision 1.29  2002/04/11 07:03:24  demon
// - add Unnecessary Export Data notifier
//
// Revision 1.28  2002/01/16 12:52:33  demon
// - rename table Access to Access2
//
// Revision 1.27  2001/11/21 12:51:36  demon
// - new: change access mask logic (Allow and Deny masks) and size (now LongInt)
//
// Revision 1.26  2001/10/22 08:50:15  demon
// new behavior: change params and types in Remote Export procedures
//
// Revision 1.25  2001/10/22 08:34:04  narry
// - new type: структура записи для передачи данных для экспорта
//
// Revision 1.24  2001/10/04 06:28:08  demon
// - new: type TExpResultRec
//
// Revision 1.23  2001/06/04 09:43:15  demon
// - new behavior: TDiapasonRec.Typ = tdSearch now required TSrchServer in OBJ field
// also now from search list exports only filtered documents.
//
// Revision 1.22  2001/03/15 10:38:09  demon
// - refresh information about family tables
//
// Revision 1.21  2000/12/15 15:36:18  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface

uses
 Classes,
 l3Types, l3Date, l3Base,

 k2Tags,
 HT_Const,

 evdDTTypes,
 evdTasksHelpers
 ;

{+------------------------------------------------------------------------+
 | Перечислимые типы                                                      |
 +------------------------------------------------------------------------+}
type
 (* Внутренние типы документов *)
  TDocType        = (dtNone, dtText, dtRelText, dtShortCut, dtObject, dtDictEntry,
                     dtAnnotation, dtFlash, dtGroupOp);
const
  cRealDocType    = [dtText, dtShortCut, dtObject, dtDictEntry, dtFlash];
  (* самостоятельные типы документов  *)
type
  TDocTypeSet     = Set of TDocType;
 (* Пользовательские типы документов *)
  TUserType       = (utNone,utDoc,utNoDoc,utCalendar,utBusiness,utUserInfo,
                     utWEBReference,utEdition,utBook,utIzm,utCard,utDossier,utAAK_Cont,utAAK_Doc);
  {Всякие наборы смотрим в DT_Const "TUserTypeSETS"}
type
  TUserTypeSet    = Set of TUserType;

const
 cAllUserTypeSet {: TUserTypeSet} = [Low(TUserType) .. High(TUserType)];
 cAllDocTypeSet {: TDocTypeSet} = [Low(TDocType) .. High(TDocType)];

type
 (* Статус действия документа *)
  TActiveStatus    = (asActive,asNoActive,asPreActive);
  TActiveStatusSet = Set of TActiveStatus;

  TSortField      = (sfNone, sfName, sfDate, sfPriority, sfUrgency);
  TSortOrder      = (soUpDown,soDownUp);
  TOpenFlag       = (ofRead,ofWrite);
  TOperActionType = (atNone,atAdd,atDelete,atEdit,atMove,atJurEdit);
  TExportTyp      = (etSelf,etWord,etText);

  PDNType         = ^TDNType;
  TDNType         = (dnDoc,dnPublish,dnMU,dnGD,dnSF,dnChangerDate,dnLawCaseNum,dnAddNum);
  TCorType        = (ctNone,ctFull,ctChange);
  TSaveDocDT      = (sdtNone,sdtComment,sdtDocs);
  TVerifyType     = (vtAll,vtDiction,vtDocs,vtHLinks);

  TLogActionFlags = (acfNone,acfOrdinal,acfJuror);
  PLogActionType  = ^TLogActionType;
  TLogActionType  = (acRevision,        // 0
                     acAttrWork,        // 1
                     acTextWork,        // 2
                     acHLWork,          // 3
                     acKWWork,          // 4
                     acClassWork,       // 5
                     acNew,             // 6
                     acIncluded,        // 7
                     acChanged,         // 8
                     acAbolished,       // 9
                     acLControl,        // 10
                     acAnonced,         // 11
                     acPublInWork,      // 12
                     acWasImported,     // 13
                     acAnnoDate,        // 14
                     acAnnoWork,        // 15
                     acAnnoWasImported, // 16
                     acAnnoWasDeleted,  // 17
                     acScriptHadled_AddPublInfo // 18
                     );
  {see also cfOrdinal cfJuror in DT_Log}

  TLogActionSet   = Set of TLogActionType;

type
  TStageType      = (
                    stNone,         // 0
                    stNotUsed,      // 1
                    stInput,        // 2  0 bit
                    stRead,         // 3  1
                    stORead,        // 4  2
                    stEdit,         // 5  3
                    stOEdit,        // 6  4
                    stClass,        // 7  5
                    stKW,           // 8  6
                    stUrObr,        // 9  7
                    stFinUrObr,     // 10 8
                    stDocFormat,    // 11 9
                    stFullEdition,  // 12 10
                    stExternalObj,  // 13 11
                    stAnno,         // 14 12
                    stAnnoClass     // 15 13 bit
                    );
  TStageSet       = Set of TStageType;
  TStageFlag      = (stfNone,stfBegined,stfFinished,stfUnfinished);

{+------------------------------------------------------------------------+
 | Типы и Константы Таблиц и Семейств                                     |
 +------------------------------------------------------------------------+}
type
 TFamTbls     = (ftNone, // фиктивная таблица
                 ftFile,ftHLink,ftSub,ftFree,
                 ftDt1,ftDt2,ftDt3,ftDt5,
                 ftDt6,ftDt7,ftDT8,ftDt9,ftDtA,
                 ftDtB,ftDtC,ftDtD,ftDtE,ftDt3E,
                 ftDtF,ftDtI,ftDtJ,
                 ftLnk1,ftLnk2,ftLnk3,ftLnk5,
                 ftLnk6,ftLnk7,ftLnk8,ftLnk9,
                 ftLnkB,ftLnkC,ftLnkD,ftLnkE,
                 ftLnkF,ftLnkI,ftLnkJ,
                 ftLnkK,
                 ftPriority,ftRenum,ftStage,ftLog,
                 ftActiv,ftAlarm,ftCtrl,
                 ftFileDup1, ftFileDup2);

 TMainTbls    = (mtAccess,mtPass,mtUsers,mtGUDt,mtGULnk,mtFamily,
                 mtFree,mtBBLog, mtCtrl, mtRegions);

 TTblNameStr  = String[8];

type
{+------------------------------------------------------------------------+
 | Прочие типы                                                            |
 +------------------------------------------------------------------------+}

  TFieldArray      = TSmallIntArray;

  TLongWord = packed Record
               LoWord,
               HiWord  : Word;
              end;
  PText = ^Text;
  PElemArr = ^TElemArr;
  TElemArr = Array [1..3600] of ThtElementInfo;
  PLongArr = ^TLongArr;
  TLongArr = Array[0..$3fff] of LongInt;
  PIntArr = ^TIntArr;
  TIntArr = Array[0..$fff] of SmallInt;
  TChArr50 = Array [1..50] of AnsiChar;
  TArr10 = Array [1..10] of AnsiChar;
  TArr15 = Array [1..15] of AnsiChar;
  TResultMask = Word;
  TTblMask = LongInt;
  TTblMaskRec = packed Record
                 AllowMask,
                 DenyMask   : Word;
                end;

//  TRegionID = Byte;

  PDictID = ^TDictID;
  TDictID = LongWord;

  PDictIDArr = ^TDictIDArr;
  TDictIDArr = Array[0..$fff] of TDictID;

  PDocID = ^TDocID;
  TDocID = LongInt;
  PSubID = ^TSubID;
  TSubID = LongInt;
  TUserNameArr = TChArr50;
  TUserNameStr = String[50];
  TPassNameStr = String[16];
  TPassStr = String[11];
  TStationName = String[8];
  TStationNameArray = array of TStationName;
  TPrefName = String[8];
  TNameArr = Array[1..8] of AnsiChar;
  TPathStr = Tl3PathStr; // AnsiString; //String[128];
  TPathArr = Array [1..128] of AnsiChar;
  PFamilyPaths = ^TFamilyPaths;
  TFamilyPaths = Array[0..$fff] of PAnsiString;
  PFamilyAttrib = ^TFamilyAttrib;
  TFamilyAttrib = TLongArr;
const
  cDNNumberLen = 50;
type
  PNumberStr = ^TNumberStr;
  TNumberStr = Array [1..cDNNumberLen] Of AnsiChar;
  TLockHandle = ThtTblHandle;
  PStDate = ^TStDate;
  TJLHandle = LongInt;
  TStationID = Array [1..8] of AnsiChar;  // только 8 байт, т к в dt_Jour вместо него используется Int64 для скорости
  THostID = Array [1..15] of AnsiChar;
  PHostID = ^THostID;
  TFilttred = LongInt;
  TIsPrivate = Byte;
  TIsNonperiodic = Byte;
  TDocUrgency = Byte;
  TCorSrcShortName = array [1..50] of AnsiChar;

  TPairLong = record
   Doc, Sub: LongInt;
  end;

  TRefAddress = packed record
   rDocID : TDocID;
   rSubID : TSubID;
  end;

  PPairLongArr = ^TPairLongArr;
  TPairLongArr = Array[0..$3fff] of TPairLong;


{+------------------------------------------------------------------------+
 | Типы записей для таблиц                                                |
 +------------------------------------------------------------------------+}
Type
  POpenMode = ^TOpenMode;
  TOpenMode = Record
                openMode  : SmallInt;
                FldArr    : PSmallInt;
                Count     : SmallInt;
              end;

  TdtOpenMode = record
   rOpenMode  : SmallInt;
   rFieldsArr : TFieldArray;
  end;

  TPathRec = Record
               TblPath,
               HomePath,
               LockPath,
               TmpPath,
               DocImgPath,
               DocImgCachePath,
               DocsPath : TPathStr;
             end;

  PDictHistogramRec = ^TDictHistogramRec;            
  TDictHistogramRec = record
                       ID    : TDictID;
                       Count : LongInt;
                      end;

  PDestHLinkRec = ^TDestHLinkRec;
  TDestHLinkRec = Record
                   Doc : TDocID;
                   Sub : TSubID;
                 end;

  TSublinkDataRec = packed record
                     DictID : TDictID;
                     SubID  : TSubID;
                    end;

  TSortRec = Record
              Fld      : Array [1..255] of SmallInt;
              FldCount : Byte;
             end;


  //PDiapType = ^TDiapType;
  TDiapType       = evdDTTypes.TDiapType;
  TDiapTypeSet    = Set of TDiapType;


 TUGTblMask = record
 end;

const
  tdNone = evdDTTypes.tdNone;
  tdSingle = evdDTTypes.tdSingle;
  tdGroup = evdDTTypes.tdGroup;
  tdAll = evdDTTypes.tdAll;
  tdSearch = evdDTTypes.tdSearch;
  tdNumList = evdDTTypes.tdNumList;
  
type
  TDiapasonRec = Record
                  Typ            : TDiapType;
                  ExternalFormat : Boolean;
                  Case Byte of
                   1 : (ID       : LongInt);
                   2 : (List     : Sab);
                   3 : (Obj      : Pointer);
                 end;

  TReplaceDocPair = record
   aOldDocID : TDocID;
   aNewDocID : TDocID;
  end;

 TDCOperation = (dcAdd, dcDel, dcChange, dcMove);
type
 TepSupportFileType = evdDTTypes.TepSupportFileType;

const
 outEVD = evdDTTypes.outEVD;
 outEVDtext = evdDTTypes.outEVDtext;
 outTXT = evdDTTypes.outTXT;
 outNSRC = evdDTTypes.outNSRC;
 outRTF = evdDTTypes.outRTF;
 outHTML = evdDTTypes.outHTML;
 outXML = evdDTTypes.outXML;

const
 SupportFileTypeNames : array[TepSupportFileType] of ShortString =
     ('Эверест', //outEVD,
      'Эверест (текстовый)', //outEVDtext,
      'Обычный текст', //outTXT,
      'NSRC', //outNSRC,
      'Rich Text Format', //outRTF
      'HTML',  //outHTML
      'XML'  //outXML
      );
type
  TepDivideBy =  evdDTTypes.TepDivideBy;
const
 divNone = evdDTTypes.divNone;
 divTopic = evdDTTypes.divTopic;
 divAccRight = evdDTTypes.divAccRight;
 divSize = evdDTTypes.divSize;

type
 TlcParticipantType = (ptPlaintiff, // Истец
                       ptDefendant, // Ответчик
                       ptThirdSide, // Третье лицо
                       ptInterested,// Заинтересованные лица
                       ptCreditor,  // Кредитор
                       ptDolzhnik,  // Должник
                       ptInoy,      // Иной уполн. орган
                       ptArbitrazh, // Арбитражный управляющий
                       ptZayavitel, // Заявитель
                       ptPristav,   // Судебный пристав-исполнитель
                       ptProkuratura);// Прокуратура


{+------------------------------------------------------------------------+
 | Процедурные типы                                                        |
 +------------------------------------------------------------------------+}
type
(*
  TGetTextFunction  = Procedure (F_ID : TdaFamilyGroup; F_Name : ShortString;
                                 DocPath : TPathStr) of object;
*)
//  TAllocateNumber   = Procedure (F_ID : TdaFamilyID;Var FreeNumber : LongInt) of Object;
(*
  TPutTextFunction  = Procedure (F_ID : TdaFamilyGroup; F_Name : ShortString;
                                 DocPath : TPathStr;
                                 Tmp_ID : LongInt) of Object;
*)
  TPromProc         = Procedure of object;
  TFilterFunc       = Function (aNumber : Longint) : LongBool of object;
  TOpenSabProc      = Procedure (KeySab : Sab) of Object;
//  TUserStatusChange = Procedure (UserID : TUserID; Active : Boolean) of Object;

  TdtHandleIDType = (dt_hidSub, dt_hidHyperlink);
  TdtGetNewHandleID  = procedure(aType : TdtHandleIDType; var aHandleID : Integer) of object;

  TSkipDocReason = (srUnknown, srAlreadyExists, srBusy, srCantBeDeleted, srAccessDenied, srNoHandle);
  TSkipDocNotify    = Procedure (aDocID : TDocID; aReason: TSkipDocReason; User : LongInt) of object;
  TExportUnnecessaryData = Procedure (aDocID : TDocID; aMessage : AnsiString) of object;

type
  TFillBufferProc = function(aBuffer: Pointer; aBufSize: Longint): Longint; register;
  function  L2FillBufferProc(Action: Pointer): TFillBufferProc; register;
  procedure FreeFillBufferProc(var Stub: TFillBufferProc); register;

type
  TdtRecAccessProc = function(aRec : Pointer) : Boolean; register;
  function  L2RecAccessProc(Action: Pointer): TdtRecAccessProc; register;
  procedure FreeRecAccessProc(var Stub: TdtRecAccessProc); register;

type
  TdtBlockAccessProc = function(aBuffer: Pointer; aBufSize: Longint) : Boolean; register;
  function  L2BlockAccessProc(Action: Pointer): TdtBlockAccessProc; register;
  procedure FreeBlockAccessProc(var Stub: TdtBlockAccessProc); register;

type
  //PUserSortProc  = TUserSortProc; //LPOFUNC;
  TUserSortProc = function (aValue1 : Pointer; aValue2 : Pointer) : Integer; register; //StdCall; //OFUNC;
  function  L2UserSortProc(aProc: Pointer) : TUserSortProc; register;
  procedure FreeUserSortProc(var aProc : TUserSortProc); register;

type
  TDictNodeType = (dntItem, dntExtItem, dntEqual);

  TReadDictParam  = record
   rOperation : TDCOperation;
   rName : AnsiString;
   rNewName : AnsiString;
   rDate : TstDate;
  end;
  
  TReadDictChangeProc = procedure(aParam : TReadDictParam); register;
  function  L2ReadDictChangeProc(Action: Pointer): TReadDictChangeProc; register;
  procedure FreeReadDictChangeProc(var Stub: TReadDictChangeProc); register;

  function MakeReadDictParam(aOperation : TDCOperation; const aName : AnsiString; const aNewName : AnsiString; aDate : TstDate) : TReadDictParam;


{процедуры преобразования типов}
function DestHLinkRec(aDoc : TDocID; aSub : TSubID = 0) : TDestHLinkRec;
type
  TddPipeInputFileType = (dd_itAutoDetect,      // определяется путем анализа имени файла
                          dd_itGarant,          // ddNSRC_r
                          dd_itEverest,         // evEvdRd
                          dd_itEverestInternal, // evEvdRd
                          dd_itRTFAnnotation,   // ddDocReader
                          dd_itTXTAnnotation,   // evPlainText
                          //dd_itLawCase,         // Постановления судов
                          dd_itFASCaseCode,     // расстановка номеров дел
                          dd_itKT,              // расстановка КТ
                          dd_itUnknown);        // тип неизвестен
  TddPipeInputFileTypeSet = set of TddPipeInputFileType;

const
 ImportFileMask : array[TddPipeInputFileType] of String =
                  ('*.*',          // dd_itAutoDetect
                   '*.nsr',        // dd_itGarant
                   '*.evd;*.evr',  // dd_itEverest
                   '*.evd;*.evr',  // dd_itEverestInternal
                   '*.rtf;*.doc',  // dd_itRTFAnnotation
                   '*.txt',        // dd_itTXTAnnotation
                   //'*.gz',         // dd_itLawCase
                   '*.nsr',        // dd_itFASCaseCode
                   '*.nsr',        // dd_itKT
                   ''              // dd_itUnknown
                   );

function CheckFileType(const FileList: TStrings; IsAnnotation: Boolean): TddPipeInputFileType; overload;

function CheckFileType(const FileList: StringListHelper; IsAnnotation: Boolean): TddPipeInputFileType; overload;

function CheckFileType(const Directory: AnsiString; IsAnnotation: Boolean): TddPipeInputFileType; overload;

implementation

uses
 StrUtils, SysUtils, l3FileUtils;

function MakeReadDictParam(aOperation : TDCOperation; const aName : AnsiString; const aNewName : AnsiString; aDate : TstDate) : TReadDictParam;
begin
 with result do
 begin
  rOperation := aOperation;
  rName      := aName;
  rNewName   := aNewName;
  rDate      := aDate;
 end;
end;

function  L2ReadDictChangeProc(Action: Pointer): TReadDictChangeProc; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure FreeReadDictChangeProc(var Stub: TReadDictChangeProc); register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  L2FillBufferProc(Action: Pointer): TFillBufferProc; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure FreeFillBufferProc(var Stub: TFillBufferProc); register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  L2RecAccessProc(Action: Pointer): TdtRecAccessProc; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure FreeRecAccessProc(var Stub: TdtRecAccessProc); register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  L2BlockAccessProc(Action: Pointer): TdtBlockAccessProc; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure FreeBlockAccessProc(var Stub: TdtBlockAccessProc); register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  L2UserSortProc(aProc : Pointer): TUserSortProc; register;
asm
          jmp l3LocalStub //HTStub3
end;

procedure FreeUserSortProc(var aProc : TUserSortProc); register;
asm
          jmp l3FreeLocalStub //HTStubFree
end;

function DestHLinkRec(aDoc : TDocID; aSub : TSubID = 0) : TDestHLinkRec;
begin
 with Result do
 begin
  Doc    := aDoc;
  Sub    := aSub;
 end;
end;

function CheckFileType(const FileList: TStrings; IsAnnotation: Boolean): TddPipeInputFileType;

 function _Check(const AExt: ShortString): Boolean;
 var
  i: Integer;
 begin
  Result := False;
  for i:= 0 to Pred(FileList.Count) do
   if AnsiEndsText(aExt, FileList.Strings[i]) then
   begin
    Result := True;
    break
   end;
 end;

begin
 if _Check('.nsr') then
  Result:= dd_itGarant
 else
 if _Check('.evd') then
  Result:= dd_itEverest
 else
 if IsAnnotation and (_Check('.rtf') or _Check('.doc')) then
  Result:= dd_itRTFAnnotation
 else
 if IsAnnotation and (_Check('.txt')) then
  Result:= dd_itTXTAnnotation
 else
  Result:= dd_itUnknown;
end;

function CheckFileType(const FileList: StringListHelper; IsAnnotation: Boolean): TddPipeInputFileType; overload;

 function _Check(const AExt: ShortString): Boolean;
 var
  i: Integer;
 begin
  Result := False;
  for i:= 0 to Pred(FileList.Count) do
   if AnsiEndsText(aExt, FileList.Strings[i]) then
   begin
    Result := True;
    break
   end;
 end;

begin
 if _Check('.nsr') then
  Result:= dd_itGarant
 else
 if _Check('.evd') then
  Result:= dd_itEverest
 else
 if IsAnnotation and (_Check('.rtf') or _Check('.doc')) then
  Result:= dd_itRTFAnnotation
 else
 if IsAnnotation and (_Check('.txt')) then
  Result:= dd_itTXTAnnotation
 else
  Result:= dd_itUnknown;
end;

function CheckFileType(const Directory: AnsiString; IsAnnotation: Boolean): TddPipeInputFileType;

 function _Check(const AExt: ShortString): Boolean;
 var
  SR: TSearchRec;
 begin
  Result:= FindFirst(ConcatDirName(Directory, AExt), faAnyFile, SR) = 0;
  FindClose(SR);
 end;

begin
 if _Check('*.nsr') then
  Result:= dd_itGarant
 else
 if _Check('*.evd') then
  Result:= dd_itEverest
 else
 if IsAnnotation and (_Check('*.rtf') or _Check('*.doc')) then
  Result:= dd_itRTFAnnotation
 else
 if IsAnnotation and (_Check('*.txt')) then
  Result:= dd_itTXTAnnotation
 else
  Result:= dd_itUnknown;
end;

end.
