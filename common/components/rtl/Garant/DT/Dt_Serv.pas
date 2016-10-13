Unit Dt_Serv;
{$DEFINE UseCommServer}

{ $Id: Dt_Serv.pas,v 1.345 2016/10/13 09:17:19 lukyanets Exp $ }

// $Log: Dt_Serv.pas,v $
// Revision 1.345  2016/10/13 09:17:19  lukyanets
// Подправляем очистку
//
// Revision 1.344  2016/09/28 08:00:55  lukyanets
// Не собиралось
//
// Revision 1.343  2016/08/11 15:25:03  voba
// no message
//
// Revision 1.342  2016/08/11 08:37:29  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.341  2016/08/10 10:04:01  lulin
// - пытались при чтении картинки с нулевым номером перераспределить номер и в итоге не читали ничего.
//
// Revision 1.340  2016/07/29 14:04:17  lulin
// - правильнее выделяем номер.
//
// Revision 1.339  2016/06/16 07:47:47  lukyanets
// Развязываем зависимости
//
// Revision 1.338  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.337  2016/06/07 13:41:37  fireton
// - кеширование образов документов
//
// Revision 1.336  2016/05/17 11:59:35  voba
// -k:623081921
//
// Revision 1.335  2016/04/19 07:20:09  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.334  2016/04/18 08:39:58  lukyanets
// Cleanup
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.333  2016/04/14 11:14:28  lukyanets
// Cleanup
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.332  2016/03/18 10:28:40  lukyanets
// Не создаем лишнего при проверке пароля
//
// Revision 1.331  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.330  2015/11/25 07:22:13  lukyanets
// Заготовки для выдачи номеров
//
// Revision 1.329  2015/11/24 14:08:24  voba
// -bf убрал конкурентную запись дерева словаря. Теперь дерево переписываем только при апдейте, в спокойной обстановке
//
// Revision 1.328  2015/11/16 12:59:32  lukyanets
// Отдаем параметры
//
// Revision 1.327  2015/09/01 12:31:55  lukyanets
// Заготовки к Postgress
//
// Revision 1.326  2015/08/20 13:01:37  lukyanets
// Присматриваемся к транзакциям
//
// Revision 1.325  2015/08/05 13:56:33  lukyanets
// Показываем параметры данных с сервера
//
// Revision 1.324  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.323  2015/05/26 15:18:08  lukyanets
// Чистим залочки более гуманно
//
// Revision 1.322  2015/05/26 14:06:43  lukyanets
// Не создаем журнал дважды
//
// Revision 1.321  2015/05/14 13:59:51  lukyanets
// Cleanup
//
// Revision 1.320  2015/05/12 14:36:51  lukyanets
// Заготовки запросов
//
// Revision 1.319  2015/05/06 14:38:03  lukyanets
// Готовимся изолировать Большого Брата
//
// Revision 1.318  2015/05/05 07:35:38  lukyanets
// Cleanup
//
// Revision 1.317  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.316  2015/04/29 14:57:20  lukyanets
// Заготовки Большого Брата
//
// Revision 1.315  2015/04/29 08:13:30  lukyanets
// Cleanup
//
// Revision 1.314  2015/04/20 15:11:20  lukyanets
// Чиним админский логин
//
// Revision 1.313  2015/04/20 12:49:50  lukyanets
// Чиним админский логин
//
// Revision 1.312  2015/04/20 10:38:50  lukyanets
// Вернул в Public
//
// Revision 1.311  2015/04/10 08:27:33  lukyanets
// Убираем отмершее
//
// Revision 1.310  2015/04/08 13:56:45  lukyanets
// Изолируем события
//
// Revision 1.309  2015/04/08 08:34:40  lukyanets
// Изолируем события
//
// Revision 1.308  2015/04/07 13:57:58  lukyanets
// Изолируем события
//
// Revision 1.307  2015/04/07 12:02:52  lukyanets
// Изолируем пути
//
// Revision 1.306  2015/04/07 09:08:35  lukyanets
// Изолируем домашний каталог
//
// Revision 1.305  2015/04/07 07:37:09  lukyanets
// Изолируем HT
//
// Revision 1.304  2015/04/06 09:38:46  lukyanets
// Изолируем язык базы
//
// Revision 1.303  2015/04/06 08:46:28  lukyanets
// Изолируем Lock сервера
//
// Revision 1.302  2015/04/03 13:50:42  lukyanets
// Изолируем HT
//
// Revision 1.301  2015/04/03 11:30:43  lukyanets
// Изолируем HT
//
// Revision 1.300  2015/04/03 09:43:58  lukyanets
// Cleanup
//
// Revision 1.299  2015/04/02 14:12:02  lukyanets
// Cleanup
//
// Revision 1.298  2015/04/02 12:46:39  lukyanets
// Изолируем регион
//
// Revision 1.297  2015/04/02 11:09:42  lukyanets
// Изолируем логин
//
// Revision 1.296  2015/04/01 15:26:04  lukyanets
// Изолируем логин
//
// Revision 1.295  2015/04/01 11:54:54  lukyanets
// Изолируем утилиты
//
// Revision 1.294  2015/03/31 14:09:11  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.293  2015/03/30 11:16:06  lukyanets
// Изолируем информацию о версии
//
// Revision 1.292  2015/03/27 13:15:47  lukyanets
// Заготовки Provider
//
// Revision 1.291  2015/03/25 11:07:17  lukyanets
// Обобщаем параметры
//
// Revision 1.290  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.289  2015/03/05 12:08:26  lukyanets
// Сохраняем парамеры сервера.
//
// Revision 1.288  2015/03/04 13:42:55  lukyanets
// Убираем отмершие ошметки
//
// Revision 1.287  2015/02/27 07:27:24  lukyanets
// Развязываем зависимости
//
// Revision 1.286  2015/02/27 07:25:13  lukyanets
// Развязываем зависимости
//
// Revision 1.285  2014/12/26 09:37:46  fireton
// - у супервизора всегда есть админские права
//
// Revision 1.284  2014/12/05 12:01:43  voba
// - разнес темп-каталоги для двух копий архивариуса работающих одновременно
//
// Revision 1.283  2014/11/24 08:35:16  fireton
// - не там запретили нулевой номер региона
//
// Revision 1.282  2014/11/21 10:36:25  fireton
// - запрещаем нулевой код региона, если не прописан секретный ключ
//
// Revision 1.281  2014/10/15 11:16:51  lukyanets
// CleanUp
//
// Revision 1.280  2014/10/14 12:35:13  lukyanets
// Пишем/читаем все базовые параметры
//
// Revision 1.279  2014/10/14 10:11:49  lukyanets
// Запоминаем админские права залогиненного
//
// Revision 1.278  2014/10/14 08:17:47  lukyanets
// Пишем/читаем еще параметры
//
// Revision 1.277  2014/10/03 12:15:07  lukyanets
// Cleanup
//
// Revision 1.276  2014/10/02 08:40:55  lukyanets
// Пишем если ресур еще кто-то держит при отключении базы
//
// Revision 1.275  2014/09/24 14:53:18  lulin
// - готовимся к запуску тестов с разных машин.
//
// Revision 1.274  2014/09/19 11:22:27  lukyanets
// {RequestLink:565273246} - Прицепили логику
//
// Revision 1.273  2014/09/11 12:25:43  lulin
// - готовимся к монопольной работе с базой.
//
// Revision 1.272  2014/09/09 05:29:05  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.271  2014/09/08 11:05:36  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.270  2014/09/05 11:51:48  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.269  2014/09/04 13:19:36  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.268  2014/09/03 06:24:48  lukyanets
// Учим экспорт в разные регионы работать одновременно
//
// Revision 1.267  2014/08/26 10:23:14  lukyanets
// Считаем служебных суперпользователями
//
// Revision 1.266  2014/08/06 13:18:02  lukyanets
// {Requestlink:556143119}. Меняем в логе имя станции
//
// Revision 1.265  2014/08/06 07:55:40  lukyanets
// {Requestlink:556143119}. Готовим TaskResult
//
// Revision 1.264  2014/07/07 10:08:02  lukyanets
// {Requestlink:552022662}. Пул рабочих пользователей
//
// Revision 1.263  2014/06/09 17:27:13  lulin
// - подготавливаем "рыбу" для регистрации Action'ов.
//
// Revision 1.262  2014/06/02 12:14:18  lulin
// - вычищаем мусор.
//
// Revision 1.261  2014/05/30 17:28:21  lulin
// - рефакторим обработку команд.
//
// Revision 1.260  2014/05/21 14:28:38  voba
// no message
//
// Revision 1.259  2014/05/05 06:51:32  dinishev
// Bug fix: AV при проблемах с базой.
//
// Revision 1.258  2014/03/05 12:03:15  voba
// - адаптация под новый HyTech
//
// Revision 1.257  2014/02/18 10:01:30  lulin
// - для несортируемых списков убираем возможность поставить флаг сортировки.
//
// Revision 1.256  2014/02/17 16:25:59  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.255  2014/02/13 10:12:58  lulin
// - рефакторим безликие списки.
//
// Revision 1.254  2014/01/22 08:49:08  GarikNet
// K:513880842
//
// Revision 1.253  2013/12/03 09:55:07  voba
// - збавляемся от степановских итераторов
//
// Revision 1.252  2013/11/07 08:15:48  fireton
// - чтение региона как отдельная процедура нужно regiontool
//
// Revision 1.251  2013/10/31 13:04:36  voba
// no message
//
// Revision 1.250  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.249  2013/06/17 15:47:37  voba
//  отдавалось неправильное значение по-умолчанию для незаданного языка
//
// Revision 1.248  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.247  2012/10/18 12:02:52  voba
// no message
//
// Revision 1.246  2012/10/10 10:12:07  narry
// Обновление
//
// Revision 1.245  2012/09/26 10:26:43  fireton
// - создаём DocImageServer "on demand" (K 397280929)
//
// Revision 1.244  2012/09/13 12:52:53  narry
// Не создавалась папка
//
// Revision 1.243  2012/06/21 11:04:35  narry
// Лишний перевод строки при выводе в лог имени таблицы
//
// Revision 1.242  2012/04/27 12:51:16  narry
// Вывод имени таблицы при обновлении
//
// Revision 1.241  2012/03/11 10:06:34  fireton
// - поправил некорректное сообщение об ошибке
//
// Revision 1.240  2012/03/07 12:53:17  narry
// Отвязываем окончания от базы
//
// Revision 1.239  2012/03/06 10:51:03  fireton
// - загружаем список окончаний из защищённого zip-файла
//
// Revision 1.238  2011/06/10 12:01:32  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TdaFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.237  2011/06/08 13:31:44  dinishev
// Убираем лишние сообщения в лог тестов.
//
// Revision 1.236  2011/05/18 12:08:41  lulin
// {RequestLink:266409354}.
//
// Revision 1.235  2011/01/28 11:28:37  voba
// - k : 251343383
//
// Revision 1.234  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.233  2010/08/13 10:29:40  voba
// - k:229214076
//
// Revision 1.232  2010/04/21 09:57:11  voba
// [K:204932853]
//
// Revision 1.231  2010/04/16 14:03:57  narry
// - неверный путь к образам сбивал иницализацию
//
// Revision 1.230  2010/04/05 06:23:11  narry
// - обновления
//
// Revision 1.229  2010/02/17 13:08:17  fireton
// - UserIDBelongsToRegion
//
// Revision 1.228  2009/12/18 09:00:14  voba
// - add THTServer.Family
//
// Revision 1.227  2009/12/02 08:31:32  fireton
// - автоматическая линковка документов
//
// Revision 1.226  2009/10/14 11:09:14  voba
// - избавляемся от библиотеки mg
//
// Revision 1.225  2009/09/17 11:44:33  lulin
// {RequestLink:163065542}.
//
// Revision 1.224  2009/07/29 14:45:56  voba
// - add verload function StartTransaction список таблиц подается как aTables : _Il3CBaseList
//
// Revision 1.223  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.222  2009/07/21 15:10:13  lulin
// - bug fix: не собирался и не работал Архивариус в ветке.
//
// Revision 1.221  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.220  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.219  2009/05/19 12:15:10  voba
// - сс
//
// Revision 1.218  2009/05/08 11:10:08  voba
// - заменил TblH на Handle
//
// Revision 1.217  2009/04/21 08:06:08  voba
// - убрал странное использование ассерта
//
// Revision 1.216  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.215  2009/04/02 15:16:39  narry
// - с псевдотаблиц не снимаются залочки
//
// Revision 1.214  2009/03/23 11:01:34  voba
// - Гаррины правки, не запускался Архивариус
//
// Revision 1.213  2009/03/16 16:17:39  narry
// - вывод предупреждений только в режме работы "без сервера"
//
// Revision 1.212  2009/03/02 08:21:27  voba
// - enh.  медеджере открытых таблиц заменил хранение имени на хранение идентификатора таблицы, это дало возможность назначать несколько ID для одной таблицы (алиасы) см. TOpenTblRec
//                 rFamily    : TdaFamilyID;
//                 rTblID     : Integer;
//                 rATP       : TdtAttrTblPart;
//                 rObj       : TPrometTbl;
//                end;
//
// Revision 1.211  2009/02/16 14:19:14  narry
// - модификация процедуры проверки базы данных
//
// Revision 1.210  2009/02/05 12:37:40  narry
// - обновление
//
// Revision 1.209  2009/02/05 10:25:23  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.208  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.207  2009/01/16 10:04:55  voba
// - bug fix
//
// Revision 1.206  2009/01/14 07:56:39  narry
// - новое свойство - BaseLanguage
//
// Revision 1.205  2008/11/25 12:52:03  narry
// - обновление
//
// Revision 1.204  2008/10/28 11:41:19  narry
// - Обновление
//
// Revision 1.203  2008/10/22 06:16:49  fireton
// - сессия в ББ должна стартовать в любом случае
//
// Revision 1.202  2008/10/15 09:06:57  fireton
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.201  2008/10/13 12:39:29  narry
// - промежуточное обновление
//
// Revision 1.200.2.2.2.3  2009/01/23 14:06:30  fireton
// - перенос Парня на Query
//
// Revision 1.200.2.2.2.2  2008/12/22 11:09:25  fireton
// - перевод поисков на TdtQuery
//
// Revision 1.200.2.2.2.1  2008/11/21 11:49:23  fireton
// no message
//
// Revision 1.200.2.2  2008/10/06 07:20:24  voba
// no message
//
// Revision 1.200.2.1  2008/10/01 13:36:21  voba
// no message
//
// Revision 1.200  2008/09/26 09:30:05  narry
// - рефакторинг
// - корректное исправление ошибки -80
//
// Revision 1.199  2008/09/23 08:48:22  voba
// no message
//
// Revision 1.198  2008/09/18 07:13:03  voba
// - move AskList to DT_AskList
//
// Revision 1.197  2008/09/15 09:04:01  voba
// -add function CheckExists
//
// Revision 1.196  2008/07/03 11:16:56  narry
// - преобразовал метод ReadParams в свойство ExtDocIDsFromRange
//
// Revision 1.195  2008/05/08 14:04:12  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.194  2008/04/04 15:16:32  fireton
// - внешние номера документов из диапазона
//
// Revision 1.193  2008/04/04 14:49:23  narry
// - не собиралось
//
// Revision 1.192  2008/03/21 17:31:56  narry
// - более информативное сообщение об ошибке
//
// Revision 1.191  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.190  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.189  2008/02/04 12:30:33  voba
// - chng. procedure VerifyFamily
//
// Revision 1.188  2008/02/01 16:41:34  lulin
// - используем кошерные потоки.
//
// Revision 1.187  2007/09/14 15:26:57  voba
// - merge
//
// Revision 1.186  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.185  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.184  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.183.2.2  2007/08/20 06:31:30  voba
// no message
//
// Revision 1.183.2.1  2007/08/13 06:56:24  voba
// - move Procedure   GetUserTypeSab, GetDocTypeSab to DT_Srch
//
// Revision 1.183  2007/07/24 12:32:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.182  2007/07/04 09:18:49  narry
// - рефакторинг процедуры инициализации HyTech
//
// Revision 1.181  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.180  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.179  2007/05/07 13:37:31  fireton
// - bug fix: неправильно искалась таблица FREE
//
// Revision 1.178  2007/04/27 07:49:33  fireton
// - Рефакторинг DT. Перевод THTServer на идентификаторы таблиц.
//
// Revision 1.177  2007/04/26 10:01:43  fireton
// - Рефакторинг DT. Переход DT_Link и DT_Dict от таблиц к типам словарей.
//
// Revision 1.176  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.175  2007/04/20 14:21:59  fireton
// - теперь можно задавать регион по умолчанию
//
// Revision 1.174  2007/04/17 11:38:13  fireton
// - регионы в имени пользователей
//
// Revision 1.173  2007/04/09 11:46:54  fireton
// - поддержка регионов на сервере
//
// Revision 1.172  2007/03/26 09:34:03  fireton
// - изменился формат l3System.FreeLocalMem
//
// Revision 1.171  2007/03/15 12:29:17  voba
// - merge with b_archi_BigDictID
//
// Revision 1.170  2007/03/14 15:14:32  fireton
// - merge полезных штук из ветки b_archi_BigDictID
// - тип групп пользователей теперь не TDictID, а TUserGrID
// - подчищен код замены пароля пользователей
// - замена указателя на дин.массив для массива групп пользователей
//
// Revision 1.169.4.3  2007/03/14 13:44:50  fireton
// - TRegionID
//
// Revision 1.169  2007/01/19 14:04:06  voba
// - bug fix
//
// Revision 1.168  2006/11/16 10:48:31  fireton
// - подготовка к большому UserID
//
// Revision 1.167  2006/11/07 11:14:42  voba
// - bug fix
//
// Revision 1.166  2006/10/27 07:52:15  voba
// - cc
//
// Revision 1.165  2006/10/12 11:31:32  narry
// - работа над ошибками
//
// Revision 1.164  2006/10/04 08:37:19  voba
// - merge with b_archi_ht64
//
// Revision 1.163.2.1  2006/09/19 08:23:25  voba
// - переход на HTStub
//
// Revision 1.163  2006/08/29 15:28:40  voba
// - use procedure HTErr_NeedStackOut
//
// Revision 1.162  2006/08/23 08:52:18  voba
// - merge with b_archi_ifltr_opt
//
// Revision 1.161  2006/06/14 12:24:54  narry
// - новое: переход на новый механизм рассылки нотификаций
//
// Revision 1.160  2006/06/08 15:54:46  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.159.2.1  2006/06/08 09:08:01  fireton
// - перевод User ID на Longword
//
// Revision 1.159  2006/05/05 07:41:37  lulin
// - cleanup.
//
// Revision 1.158  2006/04/25 11:16:38  lulin
// - cleanup.
//
// Revision 1.157.6.3  2006/06/15 11:30:07  voba
// - merge
//
// Revision 1.157.6.2  2006/06/02 07:58:50  voba
// no message
//
// Revision 1.159  2006/05/05 07:41:37  lulin
// - cleanup.
//
// Revision 1.158  2006/04/25 11:16:38  lulin
// - cleanup.
// Revision 1.157.6.1  2006/05/30 11:50:36  voba
// no message
//
// Revision 1.157  2006/03/21 08:34:45  narry
// no message
//
// Revision 1.156  2006/02/06 13:33:09  voba
// - new beh. выпилил поддержку стаго хранилища (часть 2)
//
// Revision 1.155  2005/12/23 17:30:21  step
// запросы выполняются только если прошел коннект
//
// Revision 1.154  2005/12/23 10:47:12  step
// исправлена THTServer._CheckLocalTime
//
// Revision 1.153  2005/12/23 10:37:17  step
// опубликование g_AppKind
//
// Revision 1.152  2005/12/06 11:59:39  voba
// - открутил зануление ссылок при удалении документа
// - del Procedure   SetEmptyDestOnDocs(DestDocs : SAB);
// - del Procedure   SetEmptyDestOnSab(RecSab : Sab;IDSab : Sab);
//
// Revision 1.151  2005/11/29 06:34:08  step
// изменено сообщение о запрете работы на рабочей БД
//
// Revision 1.150  2005/11/21 10:11:55  step
// защита от запуска на рабочей БД
//
// Revision 1.149  2005/11/02 16:30:05  narry
// - изменение: формат вывода запрашиваемой памяти
//
// Revision 1.148  2005/11/02 08:53:13  step
// ограничим аппетиты Ht по операт. памяти
//
// Revision 1.147  2005/10/21 15:23:35  step
// Procedure CreateHt получила новый параметр и выводит отлад. сведения в лог
//
// Revision 1.146  2005/10/06 11:08:39  step
// переделана THTServer.CheckExportResults
//
// Revision 1.145  2005/10/05 06:53:40  step
// в _CreateHtEx добавлен вывод исключения в лог
//
// Revision 1.144  2005/09/21 08:05:05  step
// слияние с веткой B_UPDATE_INDY_TO_10_1_1
//
// Revision 1.143  2005/08/30 15:27:26  step
// подправлена THTServer.UpdateTbl
//
// Revision 1.142  2005/08/30 14:11:21  step
// процедура THTServer.UpdateTbl еще и удаляет файлы замков
//
// Revision 1.141.4.1  2005/08/15 15:43:37  step
// подгонка под новую библиотеку Indy
//
// Revision 1.141  2005/06/24 09:54:30  step
// вывод в лог ошибки при копировании результатов экспорта
//
// Revision 1.140  2005/06/23 11:44:07  step
// новый адрес широковещательной рассылки: c_AllStations
//
// Revision 1.139  2005/06/23 08:35:54  step
// переименование SendMessage --> SendNetMessage (во избежание путаницы)
//
// Revision 1.138  2005/06/22 18:01:43  step
// подчистка
//
// Revision 1.137  2005/06/22 15:26:27  step
// широковещательную отправку сообщения заменяем на отправку по адресу ''
//
// Revision 1.136  2005/06/16 12:29:26  step
// слияние с веткой b_use_net_comm
//
// Revision 1.135.6.3  2005/06/07 15:22:20  step
// используем Dt_NetComm.LocalAddress вместо GetWorkStationName
//
// Revision 1.135.6.2  2005/06/03 16:56:52  step
// изменены методы THTServer.CheckExportResults и THTServer._CheckLocalTime под новый Dt_NetComm
//
// Revision 1.135.6.1  2005/06/03 13:26:19  step
// отказ от использования dt_Comm
//
// Revision 1.135  2005/05/12 14:10:08  step
// вставлено условие компиляции UseCommServer
//
// Revision 1.134  2005/05/12 13:13:16  step
// вставлено условие компиляции UseCommServer
//
// Revision 1.133  2005/05/12 10:28:43  step
// вставлена проверка системного времени на станции (относительно сервера)
//
// Revision 1.132  2005/05/11 15:09:18  step
// изменена THTServer.CheckExportResults: готовые данные забираются с использованием TFilesCommClient
//
// Revision 1.131  2005/04/28 15:04:06  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.130.4.1  2005/04/26 14:30:51  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.130  2005/03/23 15:27:49  step
// подправляем пути извлеченные из инишника
//
// Revision 1.129  2005/02/18 17:41:45  step
// переименование: dlAnnoClass -> dlAnnoClasses
//
// Revision 1.128  2005/02/16 15:29:48  step
// no message
//
// Revision 1.127  2005/02/16 15:05:57  step
// Переписана THTServer.SabToList (с использованием TValuesIterator)
//
// Revision 1.126  2005/02/16 14:34:13  step
// исправлена THTServer.SabToList
//
// Revision 1.125  2005/02/15 13:12:02  step
// расширен тип TdaDictionaryType - добавлено dlAnnoClass
//
// Revision 1.124  2005/02/11 11:50:13  step
// no message
//
// Revision 1.123  2005/02/11 11:44:58  step
// подправлены Lock-Unlock
//
// Revision 1.122  2005/02/11 11:02:25  step
// отказ от записи в лог сообщения "Table locked"
//
// Revision 1.121  2005/02/10 14:40:50  step
// рефакторинг THTServer.PhisicalVerifyAllTbl
//
// Revision 1.120  2005/02/10 12:44:27  step
// изменена THTServer.PhisicalVerifyAllTbl (иначе показываются сообщения)
//
// Revision 1.119  2005/02/10 11:16:13  step
// изменена THTServer.PhisicalVerifyAllTbl (иначе показываются сообщения)
//
// Revision 1.118  2004/12/23 11:42:13  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.117  2004/12/23 08:40:43  lulin
// - вычищен ненужный модуль.
//
// Revision 1.116  2004/10/06 18:16:01  lulin
// - борьба за кошерность.
//
// Revision 1.115  2004/09/21 16:14:56  lulin
// - добавлен параметр.
//
// Revision 1.114  2004/09/21 12:04:21  lulin
// - Release заменил на Cleanup.
//
// Revision 1.113  2004/09/14 15:58:15  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.112  2004/09/13 14:19:45  lulin
// - для распределения памяти используем процедуры с подсчетом.
// - избавился от зависимости от RX.
//
// Revision 1.111  2004/08/30 14:04:51  law
// - new method: Im4DB.CompileDictionary.
//
// Revision 1.110  2004/08/27 16:39:58  voba
// -bug fix
//
// Revision 1.109  2004/08/27 15:13:34  voba
// - merge with B_New_Text_Base
//
// Revision 1.108.2.1  2004/08/25 16:11:50  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.108  2004/08/24 17:01:11  voba
// - add propertyTextBase - получение пути к текстовой части базы
//
// Revision 1.107  2004/08/06 09:15:59  step
// добавлены доп. методы по выводу в лог сведений об ошибках HT
//
// Revision 1.106  2004/08/05 18:03:14  step
// Увеличен объем памяти выделяемый под HyTech
//
// Revision 1.105  2004/08/03 08:52:47  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.104  2004/07/30 10:05:00  step
// исправлена THTServer.CheckExportResults - добавлен показ сообщения при ошибке копирования файлов
//
// Revision 1.103  2004/07/27 15:40:41  step
// увеличено макс. кол-во открываемых таблиц
//
// Revision 1.102  2004/07/20 11:13:19  step
// в CheckDbVersion вставлена проверка правильности заданных путей к БД
//
// Revision 1.101  2004/07/19 12:53:15  step
// убран лишний raise (сообщение перенесено в main)
//
// Revision 1.100  2004/07/16 09:00:34  step
// изменен тип TOnHtIdleProc
//
// Revision 1.99  2004/07/16 08:29:53  step
// процедура "для перерисовки окна" передается не через CreateHt, а через property THTServer.OnIdle
//
// Revision 1.98  2004/07/14 12:52:48  step
// время продолжительности транзакции задается теперь через параметр метода TAbsHtTbl.StartTA
//
// Revision 1.97  2004/07/14 10:45:41  step
// CreateHt получил еще один параметр - OnIdle
//
// Revision 1.96  2004/06/11 13:01:54  step
// в CheckDbVersion добавлена проверка наличия файлов и наличия данных в них
//
// Revision 1.95  2004/06/04 12:40:26  step
// bugfix: THTServer.FillValueSABfromList(Ex) добавлена сортировка параметра-списка
//
// Revision 1.94  2004/06/02 16:42:35  law
// - удален класс Tl3VList.
//
// Revision 1.93  2004/05/25 16:44:43  step
// версия БД проверяется не по archi.version, а по base.ini
//
// Revision 1.92  2004/05/24 17:21:23  step
// new: THTServer.GetTblObject(aSab: Sab)
//
// Revision 1.91  2004/05/21 19:01:21  step
// глобальная SabToList перенеса в GlobalHtServer.SabToList
//
// Revision 1.90  2004/05/21 10:38:56  step
// при закрытии HtServer'а таблица FREE убивается последней
//
// Revision 1.89  2004/05/18 09:50:08  step
// перенос MaxFamilyID из THtServer в TFamilyTbl;
//
// Revision 1.88  2004/05/18 09:18:36  step
// change: GlobalFamPaths, GlobalFamAttrib перенесены в TFamilyTbl;
// change: GlobalFamPaths[] --> GlobalHtServer.FamilyTbl.FamilyPath();
//
// Revision 1.87  2004/05/13 13:48:38  step
// new: StartTransaction, CommitTransaction, RollbackTransaction
//
// Revision 1.86  2004/05/06 13:40:04  step
// new: property THTServer.FreeTbl
//
// Revision 1.85  2004/05/06 09:15:51  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.84  2004/04/19 13:23:10  step
// добавлено открытие закрытых таблиц
//
// Revision 1.83  2004/03/31 11:58:26  fireton
// - коррекция _CreateHtEx
//
// Revision 1.82  2004/03/29 15:43:54  step
// bug fix
//
// Revision 1.81  2004/03/26 14:09:41  voba
// no message
//
// Revision 1.80  2004/03/18 14:26:09  fireton
// - подчиска кода
//
// Revision 1.79.2.1  2004/03/19 17:11:56  step
// Исправления, связанные с добавлением поля DT#A.PRIVATE
//
// Revision 1.80  2004/03/18 14:26:09  fireton
// - подчиска кода
//
// Revision 1.79  2004/03/15 13:02:17  step
// включена проверка версии БД (сверка с константой c_DbVersion)
//
// Revision 1.78  2004/03/10 16:58:00  fireton
// - добавилась _CreateHtEx
//
// Revision 1.77  2004/03/09 15:59:32  step
// в fn_OnHtError игнорируется ошибка № 90
//
// Revision 1.76  2004/03/05 16:56:45  step
// чистка кода
//
// Revision 1.75  2004/02/26 09:03:55  step
// изменена fn_OnHtError (игнорир. ошибку #25)
//
// Revision 1.74  2004/02/17 15:03:09  step
// вдвое увеличено время LockTimeOut  (40-->80)
//
// Revision 1.73  2004/02/17 12:00:53  step
// изменена обработка HT-ошибок в fn_OnHtError и fn_OnIOError
//
// Revision 1.72  2004/02/17 11:50:07  step
// изменена обработка HT-ошибок в fn_OnHtError и fn_OnIOError
//
// Revision 1.71  2004/02/16 11:55:19  step
// изменена THTServer.ClearTableLocks
//
// Revision 1.70  2004/02/16 10:53:05  step
// изменен алгоритм ClearLocks
//
// Revision 1.69  2004/02/12 16:04:27  step
// исправлены fn_OnIOError и fn_OnHtError
//
// Revision 1.68  2004/02/12 15:57:50  step
// исправлены fn_OnIOError и fn_OnHtError
//
// Revision 1.67  2004/02/12 10:42:10  step
// добавлена запись HT-ошибок в лог
//
// Revision 1.66  2004/01/29 16:38:50  voba
// - code clean
//
// Revision 1.65  2003/11/06 11:59:00  step
// Добавлен метод THTServer.FillValueSABfromListEx
//
// Revision 1.64  2003/09/22 14:00:14  voba
// code clean
//
// Revision 1.63  2003/09/08 08:56:47  step
// Замена Pred(High(TFamTbls)) на High(TFamTbls)
//
// Revision 1.62  2003/09/03 09:02:59  narry
// - cleanup
//
// Revision 1.61  2003/08/04 13:01:30  voba
// - отключил возврат свободных
//
// Revision 1.60  2003/01/23 16:42:52  demon
// - bug fix
//
// Revision 1.59  2002/11/21 17:23:47  voba
// - bug fix.
//
// Revision 1.58  2002/11/21 17:14:54  law
// - bug fix: неправильно обрабатывалась директива MonoUser.
//
// Revision 1.57  2002/08/08 10:51:36  voba
// -new behavior: изменил логику функции StartTransactionWithWait, топерь при неприсвоенной OnLongProcess функция повторяет попытки начать транзакцию до победного
//
// Revision 1.56  2002/06/18 15:57:08  voba
// -new behavior : подавил поднятие exception в CheckExportResults
//
// Revision 1.55  2002/05/23 14:58:32  law
// - rename class: TCommonReceiveServer -> TdtCommonReceiveServer.
//
// Revision 1.54  2002/05/22 11:11:43  law
// - new behavior: пытаемся посылать сообщения из другой нити.
//
// Revision 1.53  2002/05/10 12:25:55  voba
// no message
//
// Revision 1.52  2002/04/29 11:51:36  demon
// - new behavior: in saveDocFilter now Hyperlinks and Subs deleted all at once
//
// Revision 1.51  2002/02/11 14:30:49  voba
// -lib sincro : change some m0 modules to m2
//
// Revision 1.50  2002/01/16 11:03:06  demon
// - cleanup HtDebugInfo and merge with tag NullJournal_bug
//
// Revision 1.49.2.11  2001/10/04 07:39:52  demon
// - new behavior: changed export mechanizm throu server
//
// Revision 1.49.2.10  2001/09/06 12:05:53  narry
// - change: совместимость с Delphi 6.
//
// Revision 1.49.2.9  2001/09/04 13:59:10  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.49.2.8  2001/08/23 11:22:11  demon
// - new behavior: ShowDocFlag now renamed to UserTypeFilter
// - new: add filter on DocType - DocTypeFilter
//
// Revision 1.49.2.7  2001/07/17 11:10:51  demon
// no message
//
// Revision 1.49.2.6  2001/07/16 12:40:20  demon
// no message
//
// Revision 1.49.2.5  2001/07/16 12:22:34  voba
// - new behavior: заточка обработки ситуации с прописыванием нуля в журнал
//
// Revision 1.49.2.4  2001/07/09 15:28:47  demon
// no message
//
// Revision 1.49.2.3  2001/07/09 15:01:52  voba
// no message
//
// Revision 1.49.2.2  2001/07/09 14:54:59  voba
// no message
//
// Revision 1.49.2.1  2001/07/09 13:14:07  demon
// - new behavior: add OurProjectHtError function for callback from DLL
//
// Revision 1.49  2001/07/06 14:38:15  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.48  2001/06/21 10:33:38  demon
// - new behavior: now time on server writes to log only if Delta > 10 sec
//
// Revision 1.47  2001/05/29 14:50:40  voba
// -new behavior : теперь пытается сам создать каталог временных файлов "TmpDirPath" если он физически отсутствует
//
// Revision 1.46  2001/03/20 16:19:47  demon
// - bug fix
//
// Revision 1.45  2001/03/20 15:41:31  demon
// - bug fix in PhisicalVerifyAllTbl
//
// Revision 1.44  2000/12/15 15:36:17  law
// - вставлены директивы Log.
//

{$Include DtDefine.inc}

interface

uses
  Windows,
  Classes,
  SysUtils,

  l3Types,
  l3Base,
  l3IniFile,
  l3DatLst,
  l3Date,
  l3LongintList,
  l3BaseRefInterfacedList,
  l3ChangeNotifier,

  daInterfaces,
  daTypes,

  HT_Const,
  Dt_Types,
  Dt_Const,
  dt_AttrSchema,

  dt_Table,
  Dt_User,
  Dt_Fam,
  DT_Log,
  Dt_Doc,
  Dt_Hyper,
  DT_ATbl,
  Dt_ReNum,
  DT_Dict,
  Dt_Free,

  CsCommon,

  m3DBInterfaces,
  m3StorageInterfaces,

  m4DBInterfaces,
  l3languages,
  l3ProtoObjectRefList;

const
 // Server Notification Identifiers
 sni_Destroy = 0;

type
{+------------------------------------------------------------------------+
 | Сервер для работы с таблицами                                          |
 +------------------------------------------------------------------------+}
 POpenTblRec = ^TOpenTblRec;
 TOpenTblRec = Record
                rFamily    : TdaFamilyID;
                rTblID     : Integer;
                rATP       : TdtAttrTblPart;
                rObj       : TPrometTbl;
               end;

 THTServer = Class(Tl3ChangeNotifier)
  private
   f_AliasList: TStrings;
   f_HtInitData: HT_Const.INIT;
   f_TransTime: Word;
   f_AllLocked: Boolean;
   f_BaseLang: TLanguageObj;
   f_RegionID : TdaRegionID;
   f_BaseName : AnsiString;
   fUserID      : TdaUserID;
   fRequireAdminRights : boolean;
   f_HasAdminRights: Boolean;
   f_ControlTblFName: ShortString;
   f_ControlTbl     : HT_Const.THANDLE;
   f_CurHomePath: TPathStr;
   f_CurTblPath: TPathStr;
   f_GlobalHomePath: TPathStr;
   f_FamilyPath: TPathStr;
   f_CurStationName: TStationID;
   f_HyTechTableOpenMode: Byte;
   f_ForCheckLogin: Boolean;
   function GetAliasValue(const aAlias: AnsiString): ShortString;
   function pm_GetBaseLanguage(aFamily: TdaFamilyID): TLanguageObj;
   function pm_GetExtDocIDsFromRange: Boolean;
   function pm_GetRegionTbl: TDictionaryTbl;
   procedure ReleaseTables; // убивает все открытые таблицы придерживаясь определенного порядка
   procedure SetTransTime(const aSeconds: Word);
   function CheckFreeResource(aFamily : TdaFamilyID; const aResourceName : AnsiString): Boolean;
   procedure ReadMainIni;
   property AliasList: TStrings read f_AliasList;
   property FamilyPath: TPathStr read f_FamilyPath;
  protected
   fTmpOTRec      : TOpenTblRec;
   fOpenTbls      : Tl3DataList;

   fFamilyTbl     : TFamilyTbl;
   fFamilyList    : Tl3StringDataList;

   fFamilyLst     : Tl3ProtoObjectRefList;

   f_RegionTbl    : TDictionaryTbl;
   fLockPath      : TPathStr;

   (* Функция для работы с прогресс индикатором *)
   fProgressProc  : Tl3ProgressProc;

   (* Функция для индикации и возможности прерывания длительных процессов *)
   fLongProcessProc : TdaOnLongProcessEvent;

   Function  GetFamilyTbl : TFamilyTbl;
   Function  GetFamilyList : Tl3StringDataList;
   Function  GetFamily(aFamilyID : TdaFamilyID) : TdtFamily;
   procedure pm_SetUserID(aValue : TdaUserID);

   Function  GetFreeTbl(aFamily : TdaFamilyID): TFreeTbl;
   function  GetTextBase(aFamily : TdaFamilyID) : AnsiString;
   Procedure Cleanup; override;

   function  DoOnLongProcess(aState : TdaProcessState) : Boolean;
   function  SweepTable(aTable: AnsiString; aDeadStation: AnsiString): Integer;
   // Запуск процесса, который от имени сдохшей станции постарается снять замки с таблицы
   procedure ClearTransIds(const aTransId: Ht_Const.TRID);
   procedure GoingToDie;

   // вспомогательные процедуры по доп. обработке ошибок HT
   // (предназначенные в основном для записи доп. сведений в лог)
   procedure OnHtError(aErrorMessID: SmallInt);
   procedure OnHtIOError(aFileName: PAnsiChar;
                         aIoErrorCode: SmallInt;
                         aDosErrorNumber: SmallInt);
   Function  StartTransactionWithWait(aTables : LPTHANDLE;
                                      aTblCnt : SmallInt;
                                      Var TransID : TRID) : Boolean;
   property    TransTime: Word read f_TransTime write SetTransTime;
  public
   property CurStationName : TStationID read f_CurStationName;
   property CurTblPath: TPathStr read f_CurTblPath;
   property xxxCurHomePath : TPathStr read f_CurHomePath;
   property xxxGlobalHomePath: TPathStr read f_GlobalHomePath;

   property HyTechTableOpenMode: Byte read f_HyTechTableOpenMode;

   Constructor Create(aNetUserName,aLockPath : TPathStr;
                      aCurPathRec  : TPathRec); Reintroduce;


   procedure xxxReadRegionFromIni(aDefaultRegion: TdaRegionID = 0; aIni: TCfgList = nil);
   (* Работа со списком открытых таблиц *)
   Procedure   AddTblObj(aOTRec : TOpenTblRec);
   Procedure   DelTblObj(aTblObj : TPrometTbl);
   Procedure   CloseAllTbls(aFamily : TdaFamilyID);
   Procedure   OpenClosedTbls;
   function    GetTblObject(aFamily : TdaFamilyID; aTable : Integer; aATP : TdtAttrTblPart = atpMain): TPrometTbl;
   function    GetTblObjectEx(aFamily : TdaFamilyID; aTable : Integer; aATP : TdtAttrTblPart = atpMain): TPrometTbl;

   Procedure   ClearFamilyData(aFamily : TdaFamilyID);

   Procedure   UpdateTbl(aName : TTblNameStr;aFamily : TdaFamilyID;
                         aPass : TPassStr);
   Procedure   UpdateAllTbl(aFamily : TdaFamilyID);

   Function    xxxLockAll : Boolean;
   Procedure   xxxUnLockAll;

//   function    ClearTableLocks: Integer;
   // Снятие залочек, остающихся в HyTech БД, после некорректных прекращений работы с БД.
   // В случае успеха функция возвращает 0, иначе - код ошибки.

   Procedure   PhisicalVerifyAllTbl(aFamily : TdaFamilyID; out aErrorFound: Boolean; out aMess: AnsiString);
   Procedure   VerifyFamily(aFamily : TdaFamilyID;VType : TVerifyType;
                            WithFixErrors : Boolean);

   Function    StartTransaction(aTables : array of TPrometTbl;
                                Var TransID : TRID;
                                aTransTime: Word = DefaultTransTime): Boolean;   overload;

   function    StartTransaction(aTables : Il3CBaseList;
                                     var TransID: TRID;
                                     aTransTime: Word = DefaultTransTime): Boolean; overload;

   procedure   CommitTransaction(var aTransID : TRID);
   procedure   RollbackTransaction(var aTransID : TRID);

   function    xxxIsRegionExists(aID: TdaRegionID): Boolean;
   function    xxxGetRegionName(aID: TdaRegionID): AnsiString;

   Function    xxxGetHomePathName(aUserID : TdaUserID) : TPathStr;
   Function    xxxGetHomePath(aUserID : TdaUserID) : TPathStr;
   Function    xxxCheckArchivariusPassword(aShortName : TPassNameStr;
                                        aPassWord  : TPassStr;
                                        RequireAdminRights: Boolean) : Boolean;

   function    xxxLoginAsServer: Boolean;
//   procedure   FillValueSABfromList(var aSAB : SAB;aList : Tl3LongintList);
   procedure   FillValueSABfromListEx(var aSAB: SAB;
                                      anId: Longint;
                                      aList: Tl3LongintList);

   function xxxGetFreeExtObjID(aFamily : TdaFamilyID): TDocID;
   function xxxGetFreeExtDocID(aFamily : TdaFamilyID): TDocID;

   function  xxxConvertAliasPath(CurPath : ShortString): AnsiString;
   function xxxCurUserIsServer: Boolean;
   property  xxxBaseLanguage[aFamily: TdaFamilyID]: TLanguageObj read pm_GetBaseLanguage;

   property  xxxUserID  : TdaUserID read fUserID write pm_SetUserID;

   property  ExtDocIDsFromRange: Boolean read pm_GetExtDocIDsFromRange;
   Property  FamilyTbl : TFamilyTbl read GetFamilyTbl;
   Property  FamilyList : Tl3StringDataList read GetFamilyList;
   property  Family[aFamily : TdaFamilyID] : TdtFamily read GetFamily;

   Property  FreeTbl[aFamily : TdaFamilyID] : TFreeTbl read GetFreeTbl;

   property  xxxTextBase[aFamily : TdaFamilyID] : AnsiString read GetTextBase;
   property  xxxRegionID: TdaRegionID read f_RegionID;
   property  xxxBaseName: AnsiString read f_BaseName;

   property xxxAdminRights: Boolean read f_HasAdminRights;

   property  xxxRegionTbl: TDictionaryTbl read pm_GetRegionTbl;
   Property  xxxOnProgress : Tl3ProgressProc read fProgressProc write fProgressProc;
   Property  xxxOnLongProcess : TdaOnLongProcessEvent read fLongProcessProc write fLongProcessProc;
 end;

// Procedure CreateHt;
 procedure CreateHtEx(aStationName: AnsiString; aRPath: TPathRec; aDocBaseVersion,
     aAdminBaseVersion: Integer; aAliasList: TStrings = nil; ForCheckLogin: Boolean = False;
     AllowClearLocks: Boolean = False);

 Procedure DestroyHt;

// Procedure OurProjectHtYield; {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};

// Function  TestError(nErrCode : SmallInt;
//                     fpRecord : Pointer) : Error_Mode; {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};

// function _ConvertAliasPath(CurPath : AnsiString): AnsiString;



 Const
{ Флаг  параллельных процессов }
  YieldProcFlag  : Boolean = False;

{ Указатель на объект сервера баз данных }
  GlobalHtServer : THTServer = Nil;

function dtGetDB(aFamily    : TdaFamilyID;
                 aOnYield   : TNotifyEvent = nil;
                 aFileMeter : Tl3ProgressProc = nil;
                 aFilesMeter : Tl3ProgressProc = nil): Im3DB;
  {-}
(*function dtGetDBEx(aFamily    : TdaFamilyID;
                   aOnYield   : TNotifyEvent = nil;
                   aFileMeter : Tl3ProgressProc = nil;
                   aFilesMeter : Tl3ProgressProc = nil): Im4DB;*)

//procedure CheckDbVersion(DocBaseVersion, AdminBaseVersion: Integer);

//procedure LoadDbVersion(const DocBaseFolder, AdminBaseFolder: AnsiString; out theDocBaseVersion, theAdminBaseVersion:
//    Integer);

  {-}

function dtGetObjectStream(aFamily: TdaFamilyID; aDocID: TDocID; var anObjID: Integer; aMode: Tm3StoreAccess): IStream;

//function ExtractParams(out theStationName: TStationName; out theFolders: TPathRec; aStandAlone: Boolean): Boolean;

//procedure PackParams(const theStationName: TStationName; theFolders: TPathRec);

implementation

uses
  Forms, Math, StrUtils,

  l3String,
  l3MinMax,
  l3FileUtils,

  daUtils,
  daSchemeConsts,

  HT_Dll,
  WinProcs,
  Dt_Err,
  Dt_Acces,
  Dt_Lock,
  Dt_LinkServ,
  dt_LinkServerService,
  DT_AskList,
  Dt_List,
  DT_DocImages,
  Dt_DictTree,
  ddAutolinkServer,
  
  vtVerInf,
  vtDialogs,

  m2XltLib,
  m2TmpLib,

  m3DB,

  m4DB,

  m0LNGLib,

  l3Interfaces, BAse_CFG, dt_UserConst;

procedure fn_OnIOError(fpFileName: PAnsiChar;
                       nIoCode:    SmallInt;
                       nDosError:  SmallInt); {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
var
 l_Buff220: array[0..220] of Char;
begin
 // Ошибку "File locking violation" игнорируем (слишком часто возникает)
 if nDosError = 33 then
  Exit;

 try
  htIOMessage(@l_Buff220);
  l3System.Msg2Log('IOError: ' + IntToStr(nDosError) + ', ' + IntToStr(nIoCode) +
                   '; ' + StrPas(l_Buff220));

  if GlobalHtServer <> nil then
   GlobalHtServer.OnHtIOError(fpFileName, nIoCode, nDosError);

 except // хотя это и маловероятно. Но наружу ни одного исключения пропустить нельзя
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

procedure fn_OnHtError(nMessID: SmallInt); {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
var
 l_Buff220: array[0..220] of Char;
 lErrStr : AnsiString;
 lErrDescr : AnsiString;
begin
 // игнорируемые ошибки
 if nMessID in [
  72, // "Таблица задействована в транзакциях" (это вовсе не ошибка)

  25, // "Unique key doublet value found" - возникает при изменении записи,
      //   при этом дубликаты удаляются автоматически, так что можно не беспокоиться

  90, // "Heap block already freed" - внутренняя ошибка библиотеки HT (со слов Малярского) -
      // мы на никак не можем повлиять на ее появление

  58, // "Таблица захвачена целиком" - возникает при попытке захвата таблицы, которая
      // удерживается кем-то другим - вообщем-то рядовая ситуация, так-что нечего зря лог засорять.

  46, //  HT_ERR_RECORD_LOCKED "Запись(и) захвачены" все равно всплывет в HT(), нет смысла тут поднимать
  43  // HT_ERR_OPERATION_DENYED "Операция запрещена" Обрабатывается "сверху"
 ] then
  Exit;

 try
  htMessage(nMessID, @l_Buff220);

  lErrStr := StrPas(l_Buff220);
  {$IFDEF HT_NEWDLL}
  SetLength(lErrDescr, 300);
  SetLength(lErrDescr, htLastErrorText(@lErrDescr[1], 300));
  if Length(lErrDescr) > 0 then
   lErrStr := lErrStr + ' ['+ lErrDescr +']';
  {$ENDIF}

  l3System.Msg2Log('HtError: %d; %s', [nMessID, lErrStr]);
  HTErr_NeedStackOut(nMessID);
  if GlobalHtServer <> nil then
   GlobalHtServer.OnHtError(nMessID);

 except // хотя это и маловероятно. Но наружу ни одного исключения пропустить нельзя
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

procedure CreateHtEx(aStationName: AnsiString; aRPath: TPathRec; aDocBaseVersion,
    aAdminBaseVersion: Integer; aAliasList: TStrings = nil; ForCheckLogin: Boolean = False;
    AllowClearLocks: Boolean = False);
Var
 CurDll      : TVersionInfo;
 constVer,
 CurVer      : TLongVersion;
 I           : LongInt;
 l_Port      : Integer;
 l_CurHostName : AnsiString;
Begin
 if ForCheckLogin and (aStationName = '') then
  aStationName := 'HT_LOGIN';

 if GlobalHTServer <> nil then Exit;

 CurDll:=TVersionInfo.Create(HTDLL);
 try
  constVer:=StringToLongVersion(htDllVersion);
  CurVer:=CurDll.FileLongVersion;
  If (CurVer.MS <> constVer.MS) or (CurVer.LS < constVer.LS) then
   raise Exception.Create('У Вас используется старая версия Dll HyTech!'#13+
                          'Свяжитесь с разработчиками.')
 finally
  l3Free(CurDll);
 end;
 CheckDBVersion(aDocBaseVersion, aAdminBaseVersion);

 if aRPath.HomePath = '' then
  aRPath.HomePath:=aRPath.TblPath;

 Try
  GlobalHTServer := THTServer.Create(aStationName,aRPath.LockPath, aRPath);
  GlobalHTServer.AliasList.Assign(aAliasList);
  GlobalHTServer.f_ForCheckLogin := ForCheckLogin;
  if not ForCheckLogin then
  begin
   LockServer:=TLockServer.Create(AllowClearLocks);
   For I:=0 to GlobalHTServer.FamilyList.Count - 1 do
    LockServer.InitFamilyLocks(PdaFamilyID(GlobalHTServer.FamilyList.Data[I])^);
   cDocumentServer := TDocumentServer.Create;
   AccessServer := TAccessServer.Create;
  end;
  xxxUserManager := TUserManager.Create;
  SetDocImagePath(aRPath.DocImgPath, aRPath.DocImgCachePath);
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   raise Exception.Create('Процесс инициализации не прошел!'#13#10 +
                          'Причина: ' + E.Message + #13#10 +
                          'Свяжитесь с разработчиками.');
  end;
 end;
end;

Procedure DestroyHt;
Begin
 if GlobalHtServer <> nil then
  GlobalHtServer.GoingToDie;
 CleanupAutolinkServer;
 SetDocImagePath('', '');
 FreeLinkServer;
 l3Free(LockServer);
 FreeDictServer;
 l3Free(cDocumentServer);
 l3Free(AccessServer);
 l3Free(xxxUserManager);
 l3FreeGlobal(GlobalHtServer);
end;
(********************************* THTServer ************************************)

Constructor THTServer.Create(aNetUserName,aLockPath : TPathStr;
                             aCurPathRec  : TPathRec);
Var
 TmpStr,
 TmpStr1,
 TmpStr2    : ShortString;
 l_MemoryStatus: MEMORYSTATUS;



Begin
 Inherited Create{(Nil)};
 f_HyTechTableOpenMode := TAB_SHARE;
 f_TransTime := MaxTrsTime;
 f_AliasList := TStringList.Create;
 l3FillChar(f_HtInitData, SizeOf(f_HtInitData), $00);
 With f_HtInitData do
 Begin
  nTableCnt:=MaxTbls;      (* Число таблиц, с которыми будут работать*)
  nTaskCnt:=20;            (* Число файлов, которые может открыть задача*)
  nHtCnt:= 6 + 7 * nTableCnt + 1;  (* Число файлов, которые может открыть СУБД*)
  nLockTimeOut:=80;        (* Таймаут разделения ресурсов сети *)
  nPollDelay:=40;          (* Задержка опроса сети (тиков) *)
  nTransTimeOut := f_TransTime; (* Таймаут выполнения транзакций *)
  nTrsMode:=TRS_HARD;      (* Режимы механизма транзакций *)
  TmpStr2:=aCurPathRec.TmpPath+#0;
  fpTmpPath:=@TmpStr2[1];  (* Каталог для создания временных файлов *)
  TmpStr:=aLockPath+#0;
  fpNetPath:=@TmpStr[1];   (* Каталог для сетевых замков *)
  fpTrtPath:=@TmpStr[1];   (* Каталог журнала транзакций *)
  TmpStr1:=aNetUserName+#0;
  fpNetName:=@TmpStr1[1];  (* Имя станции в сети (до 8 символов) *)
  fpfInfo:=Pointer(-1);    (* Функция информационного сообщения *)
  fpfIoMess := @fn_OnIOError;  (* Функция сообщения об ошибке В/В *)
  fpfErrMess := @fn_OnHtError; (* Функция сообщения об ошибке *)
  fpfPiStart:=Pointer(-1); (* Функция инициализации прогресс-индикатора *)
  fpfPiDraw:=Pointer(-1);  (* Функция продвижения прогресс-индикатора *)
  fpfPiStop:=Pointer(-1);  (* Функция снятия прогресс-индикатора *)
  fpfYield := Pointer(-1); (* Функция активации других процессов *)

  // Делим память для HT:
  // Четверть размера доступной физической (но не менее 4М и не более 200М) отдадим под поиски-результаты
  // Восьмушку размера доступной физической (но не менее 1М и не более 50М) отдадим под СУБД
  // Пользователь ничего не заметит, т.к. будет зарезервировано место в виртуальной, а не физической памяти.
  GlobalMemoryStatus(l_MemoryStatus);
  gHeapCtrl:= Min(200*1024*1024, Max(4*1024*1024, l_MemoryStatus.dwAvailPhys div 4));
  gHeapTask:= Min( 50*1024*1024, Max(1*1024*1024, l_MemoryStatus.dwAvailPhys div 8));
 end;

 if f_HtInitData.gHeapCtrl < 100*1024*1024 then
  l3System.Msg2Log('HeapCtrl = %d', [f_HtInitData.gHeapCtrl]);

 Ht(htInit(@f_HtInitData, SizeOf(f_HtInitData)));

 TmpStr1:=aNetUserName;
 TmpStr1:=TmpStr1+#0;

 l3FillChar(f_CurStationName,SizeOf(TStationID));
 l3Move(TmpStr1[1],f_CurStationName,Min(Length(TmpStr1),SizeOf(TStationID)));

 f_CurHomePath:=aCurPathRec.HomePath;
 f_GlobalHomePath:=aCurPathRec.HomePath;
 f_CurTblPath:=aCurPathRec.TblPath;
 f_FamilyPath :=aCurPathRec.DocsPath;
 f_ControlTblFName:= ConcatDirName(CurTblPath, TableName(MainTblsFamily, Ord(mtCtrl))) + #0;

 Try
  Ht(htTableOpen(@f_ControlTblFName[1],Nil,Nil,HyTechTableOpenMode,f_ControlTbl));
 except
  htShut;
  raise EHtErrors.CreateFmt('Не удалось открыть таблицу %s', [AnsiString(f_ControlTblFName)]);
 end;

 //CurUserGr:=Nil;
 //CurUGCount:=0;

 f_HasAdminRights := False;
 fOpenTbls:=Tl3DataList.CreateSize(SizeOf(TOpenTblRec));

 fLockPath := aLockPath;

 ReadMainIni;
end;

procedure THTServer.Cleanup;
Begin
 l3Free(f_BaseLang);
 L3Free(fFamilyTbl);
 L3Free(fFamilyList);
 l3Free(f_RegionTbl);

 ReleaseTables;

 L3Free(fFamilyLst);
 htShut;
 l3Free(f_AliasList);
 Inherited;
end;

procedure THTServer.ReadMainIni;
var
 l_BaseIniPath: AnsiString;
 l_BaseIni: TCfgList;
begin
 l_BaseIniPath := ConcatDirName(CurTblPath, 'base.ini');
 if not FileExists(l_BaseIniPath) then
  raise Exception.Create('Не найден файл ' + l_BaseIniPath);

 l_BaseIni := TCfgList.Create(l_BaseIniPath);
 try
  l_BaseIni.Section:= 'Base';
  f_BaseName := l_BaseIni.ReadParamStrDef('Name', '');
  xxxReadRegionFromIni(0, l_BaseIni);
 finally
  FreeAndNil(l_BaseIni);
 end;
end;

Function THTServer.GetFamilyTbl : TFamilyTbl;
Begin
 If fFamilyTbl = Nil then fFamilyTbl:=TFamilyTbl.Create(False);
 Result:=fFamilyTbl;
end;

function THTServer.GetFamilyList : Tl3StringDataList;
begin
 if fFamilyList = Nil then
  Begin
   fFamilyList:=Tl3StringDataList.Create;
   FamilyTbl.GetFamilysList(fFamilyList);
  end;
 Result:=fFamilyList;
end;

function THTServer.GetFamily(aFamilyID : TdaFamilyID) : TdtFamily;
var
 lFamily : TdtFamily;
begin
 if fFamilyLst = nil then
  fFamilyLst := Tl3ProtoObjectRefList.Create;

 if fFamilyLst.Count < Succ(aFamilyID) then
  if aFamilyID = MainTblsFamily then
   fFamilyLst.Count := 1
  else
  begin
   fFamilyLst.Count := 1 + FamilyTbl.MaxFamilyID;
   Assert(fFamilyLst.Count > aFamilyID);
  end;

 if fFamilyLst[aFamilyID] = nil then
 begin
  if aFamilyID = MainTblsFamily then
   lFamily := TdtFamily.Create(aFamilyID, CurTblPath)
  else
   lFamily := TdtFamily.Create(aFamilyID, FamilyTbl.FamilyPath(aFamilyId));
  try
   fFamilyLst[aFamilyID] := lFamily;
  finally
   l3Free(lFamily);
  end;
 end;

 Result := TDTFamily(fFamilyLst[aFamilyID]);
end;

procedure THTServer.pm_SetUserID(aValue : TdaUserID);
var
 l_UserGroups: TdaUserGroupIDArray;
begin
 if aValue <> fUserID then
 begin
  fUserID := aValue;
  If not f_ForCheckLogin and (fRequireAdminRights or ((fUserID <> usSupervisor) and (fUserID < usAdminReserved))) then
  begin
   l_UserGroups := xxxUserManager.xxxGetUserGroups(fUserID);
   f_CurHomePath:=xxxGetHomePath(fUserID);
   AccessServer.CurrentUserGroups := l_UserGroups;
   AccessServer.ReLoadMaskArr(MainTblsFamily);
  end;
  f_HasAdminRights := xxxUserManager.xxxIsUserAdmin(fUserID);
 end;
end;

(******************* Работа со списком открытых таблиц **************)

Procedure THTServer.AddTblObj(aOTRec : TOpenTblRec);
Begin
 If fOpenTbls.IndexOfData(Pointer(aOTRec.rObj),SizeOf(Pointer),
                          fOpenTbls.DataSize-SizeOf(Pointer))=-1 then
 begin
  aOTRec.rObj.Use;
  fOpenTbls.Add(@aOTRec);
 end;
end;

procedure THTServer.DelTblObj(aTblObj : TPrometTbl);
var
 lIndex : LongInt;
begin
 lIndex := fOpenTbls.IndexOfData(Pointer(aTblObj),SizeOf(Pointer),
                                 fOpenTbls.DataSize-SizeOf(Pointer));
 if lIndex <> -1 then
 begin
  fOpenTbls.Delete(lIndex);
  l3Free(aTblObj);
 end;
end;

Procedure THTServer.CloseAllTbls(aFamily : TdaFamilyID);
Var
 I : LongInt;
Begin
 If fOpenTbls.Count=0 then exit;
 For I:=0 to Pred(fOpenTbls.Count) do
  If (POpenTblRec(fOpenTbls.Data[I])^.rFamily = aFamily)  then
   Begin
    fOpenTbls.Select[I] := True;
    POpenTblRec(fOpenTbls.Data[I])^.rObj.CloseTbl;
   end;
end;

Procedure THTServer.OpenClosedTbls;
Var
 I : LongInt;
Begin
 If fOpenTbls.Count=0 then exit;
 For I:=0 to fOpenTbls.Count-1 do
  If fOpenTbls.Select[I] then
   Begin
    fOpenTbls.Select[I]:=False;
    POpenTblRec(fOpenTbls.Data[I])^.rObj.OpenTbl;
   end;
end;

function THTServer.GetTblObject(aFamily : TdaFamilyID; aTable : Integer; aATP : TdtAttrTblPart = atpMain): TPrometTbl;
Var
 TmpInd : LongInt;
Begin
 Result := nil;
 l3FillChar(fTmpOTRec,SizeOf(fTmpOTRec));
 with fTmpOTRec do
 begin
  rFamily := aFamily;
  rTblID  := aTable;
  rATP    := aATP;
 end;
 TmpInd := fOpenTbls.IndexOfData(fTmpOTRec, fOpenTbls.DataSize - SizeOf(Pointer), 0);
 if TmpInd >= 0 then
  Result := POpenTblRec(fOpenTbls.Data[TmpInd])^.rObj;
end;

Procedure THTServer.ClearFamilyData(aFamily : TdaFamilyID);
Var
 Suffix  : String[4];
 TmpName : ShortString;
 TmpTblH : HT_Const.THandle;
 I       : TFamTbls;
 J       : Byte;
 TmpFrRec: TFreeRec;
 TmpHnd  : Integer;
Begin

 CloseAllTbls(aFamily);
 Try
  Suffix:=IntToHex(aFamily,3);
  For I:=Low(TFamTbls) to High(TFamTbls) do
   Begin
    if I in cFictTables then
     Continue;
    If I<>ftDt6 then
     Begin
      TmpName:=FamilyTbl.FamilyPath(aFamily)+FamTblNames[I]+Suffix+#0;
      htDropTableData(@TmpName[1],Nil,Nil);
     end;
    If (I = ftDt1) or (I = ftDt2) or (I = ftDt3) then
     Begin
      TmpName:=FamilyTbl.FamilyPath(aFamily)+FamTblNames[I]+Suffix+'.tre';
      TmpHnd:=FileCreate(TmpName);
      FileClose(TmpHnd);
     end;
   end;
  TmpName:=FamilyTbl.FamilyPath(aFamily)+FamTblNames[ftFree]+Suffix+#0;
  htTableOpen(@TmpName[1],Nil,Nil,Tab_Private,TmpTblH);
  Try
   TmpFrRec.FreeNum:=1;
   TmpFrRec.Limit:=NO_LIMIT;
   For J:=1 to FreeRecCount do
    Begin
     l3StringToArray(TmpFrRec.TblName,SizeOf(TmpFrRec.TblName),
                   FamTblNames[FreeRecIndex[J]]);
     htRecordAdd(TmpTblH,@TmpFrRec);
    end;
  finally
   Ht(htTableClose(TmpTblH));
   Ht(htUpdateTable(@TmpName[1],Nil,Nil,True,False));
  end;
 finally
  OpenClosedTbls;
 end;
end;

Procedure THTServer.UpdateTbl(aName : TTblNameStr; aFamily : TdaFamilyID;
                              aPass : TPassStr);
Var
 hTable : HT_Const.THANDLE;
 lTblName: TFileName;
 TmpPass: ShortString;
 Ok     : LongInt;
 l_FamilyPath: TPathStr;
Begin
 l_FamilyPath := FamilyTbl.FamilyPath(aFamily);
 TmpPass:=aPass;
 TmpPass:=TmpPass+#0;
 lTblName := ConcatDirName(l_FamilyPath, aName);

 UpdateTreeStuct(lTblName);

 Ok:=htTableHandleByName(PChar(lTblName), hTable);
 If Ok < 0 then
 begin
  l3System.Msg2Log(aName);
  Ht(htUpdateTable(PChar(lTblName),@TmpPass[1],@TmpPass[1],True,False));

  SysUtils.DeleteFile(ChangeFileExt(lTblName, '.HLK')); // разделяемый файл замка
  DeleteFilesByMaskRecur(fLockPath, ChangeFileExt(aName, '.!*')); // "приватные" файлы замков
 end
 else
  raise EHtErrors.CreateInt(ecTblOpen);
end;

Procedure THTServer.UpdateAllTbl(aFamily : TdaFamilyID);
Var
 I      : TMainTbls;
 J      : TFamTbls;
 Suffix : String[4];
Begin
 CloseAllTbls(aFamily);
 Try
  If aFamily=MainTblsFamily then
   Begin
    If Assigned(fProgressProc) then
     fProgressProc(piStart,Byte(High(TMainTbls)),'Обновление основных таблиц');
    Try
     For I:=Low(TMainTbls) to High(TMainTbls) do
     begin
      if I = mtCtrl then
       Continue;
      If Assigned(fProgressProc) then
       fProgressProc(piCurrent, Byte(I)+1, MainTblNames[I]);
      Try
       UpdateTbl(MainTblNames[I],aFamily,TblPassW[MainPassIndex[I]]);
      except
      end;
     end;
    finally
     If Assigned(fProgressProc) then fProgressProc(piEnd, Byte(High(TMainTbls)),'');
    end;
   end
  else
   Begin
    Suffix:=IntToHex(aFamily,3);
    If Assigned(fProgressProc) then
     fProgressProc(piStart, Byte(High(TFamTbls)),'Обновление таблиц семейства');
    Try
     For J:=Low(TFamTbls) to High(TFamTbls) do
     begin
      if J in cFictTables then
       Continue;
      If Assigned(fProgressProc) then
       fProgressProc(piCurrent,Byte(J)+1, FamTblNames[J]+Suffix);
      Try
       UpdateTbl(FamTblNames[J]+Suffix,aFamily,TblPassW[FamPassIndex[J]]);
      except
      end;
     end;
    finally
     If Assigned(fProgressProc) then
      fProgressProc(piEnd, Byte(High(TFamTbls)),'');
    end;
   end;
 finally
  OpenClosedTbls;
 end;
end;

Function THTServer.xxxLockAll : Boolean;
Begin
 Result:=False;
 Ht(HtTableClose(f_ControlTbl));
 Try
  Ht(htTableOpen(@f_ControlTblFName[1],Nil,Nil,TAB_PRIVATE,f_ControlTbl));
  Result:=True;
 except
  Ht(htTableOpen(@f_ControlTblFName[1],Nil,Nil,HyTechTableOpenMode,f_ControlTbl));
 end;
 f_AllLocked := Result;
end;

Procedure THTServer.xxxUnLockAll;
Begin
 Ht(HtTableClose(f_ControlTbl));
 Ht(htTableOpen(@f_ControlTblFName[1],Nil,Nil,HyTechTableOpenMode,f_ControlTbl));
 f_AllLocked := False;
end;

function THTServer.SweepTable(aTable: AnsiString; aDeadStation: AnsiString): Integer;
const
 cExeName = 'ClearLocks.exe';
 cWaitTimeout = 60*1000; // 1 мин.
var
 l_CurDir: AnsiString;
 l_ExeFile: AnsiString;
 l_StartupInfo: {$IfDef XE}TStartupInfoA{$Else}TStartupInfo{$EndIf};
 l_ProcessInfo: TProcessInformation;
 l_ExitCode: DWORD;
 l_ExitCodeAsInteger: Integer absolute l_ExitCode;
begin
 l_CurDir := GetCurrentDir;
 l_ExeFile := l_CurDir + '\' + cExeName;
 if not FileExists(l_ExeFile) then
  Result := cCLExeFilelNotFound
 else
 begin
  l3FillChar(l_StartupInfo, SizeOf(l_StartupInfo));
  l_StartupInfo.cb := SizeOf(l_StartupInfo);

  if CreateProcessA(PAnsiChar('Sweeping HyTech table'),
                   PAnsiChar(l_ExeFile + ' ' +
                         aDeadStation + ' ' +
                         fLockPath + ' ' +
                         aTable),
                   nil,
                   nil,
                   TRUE,
                   NORMAL_PRIORITY_CLASS,
                   nil,
                   PAnsiChar(l_CurDir),
                   l_StartupInfo,
                   l_ProcessInfo)
  then
   case WaitForSingleObject(l_ProcessInfo.hProcess, cWaitTimeout) of
    WAIT_FAILED:
     begin
      TerminateProcess(l_ProcessInfo.hProcess, WAIT_FAILED);
      Result := cCLProcessFailed;
     end;
    WAIT_TIMEOUT:
     begin
      TerminateProcess(l_ProcessInfo.hProcess, WAIT_TIMEOUT);
      Result := cCLProcessIsTimedOut;
     end;
    WAIT_OBJECT_0:
     if GetExitCodeProcess(l_ProcessInfo.hProcess, l_ExitCode) then
      Result := l_ExitCodeAsInteger
     else
      Result := cThereNoResultOfCLProcess;
   end // case
  else
   Result := cCLProcessNotStarted;
 end;
end;
(*
function THTServer.ClearTableLocks: Integer;
var
 l_TableNameSuffix: String[4];
 l_Table: AnsiString;
 l_TableId: TFamTbls;
 l_TableHandle: HT_Const.THandle;
 l_AllRecs: Sab;
 l_DeadStation: HT_Const.OWNER;
begin
 Result := 0; // успех
 begin
  CloseAllTbls(CurrentFamily);
  try
   // перебор всех таблиц
   l_TableNameSuffix := IntToHex(CurrentFamily, 3) + #0;
   for l_TableId := Low(TFamTbls) to High(TFamTbls) do
   begin
    if not (l_TableID in cFictTables) then
    begin
     l_Table := FamilyTbl.FamilyPath(CurrentFamily) + FamTblNames[l_TableId] + l_TableNameSuffix;
     Result := htTableOpen(PAnsiChar(l_Table), nil, nil, TAB_SHARE, l_TableHandle);
     if Result = 0 then
     try
      // захваты таблиц
      if htWhoLockTable(PAnsiChar(l_Table), l_DeadStation) > 0 then
       Result := SweepTable(l_Table, StrPas(l_DeadStation.szUser));

      if Result = 0 then
      begin
       // захваты записей
       htSearch(nil, l_AllRecs, l_TableHandle, AbsNumFld, GREAT, @Zero, nil);
       Result := l_AllRecs.nRetCode;
       if Result = 0 then
       try
        while htWhoLockSet(l_AllRecs, l_DeadStation) > 0 do
        begin
         // перебор мертвецов
         Result := SweepTable(l_Table, StrPas(l_DeadStation.szUser));
         if Result <> 0 then
          Break;
        end; // while
       finally
        htClearResults(l_AllRecs);
       end;
      end; // if
     finally
      htTableClose(l_TableHandle);
     end;

     if Result <> 0 then Break;
    end; // not (l_TableID in cFictTables)
   end; // for
  finally
   OpenClosedTbls;
  end;
 end;
end;
*)
type
 ThtRepairModes = (repFixConst, repFixVar, repDropIdx, repBuildIdx);
 ThtRepairModeSet = set of ThtRepairModes;

Procedure THTServer.PhisicalVerifyAllTbl(aFamily : TdaFamilyID; out aErrorFound: Boolean; out aMess: AnsiString);
Var
 I      : TMainTbls;
 J      : TFamTbls;
 Suffix : String[4];
 TmpName,
 TmpPass : ShortString;
 l_NeededTemporaryLock: Boolean;

 function lp_AnalyzeResult(const aShortName, aFullName, aPassword: ShortString; aResult: Integer): Integer;
 var
  l_Mode: ThtRepairModeSet;
  l_Count: Integer;
  nDosError : SmallInt; // Сюда занесут код, возвращенный ДОС
  nOperation: SmallInt; // Сюда занесут код операции, приведшей к ошибке
  lErrstr : array[0..1000] of char;
  lErrstr2 : PAnsiChar;
 begin
   if Length(aMess) > 0 then
    aMess := aMess + #13#10;
   if aResult = -1 then
   begin
    lErrstr2 := htExtError(nDosError, nOperation, @lErrstr[0]);
    if nDosError <> 32 then
     aMess := aMess + SysUtils.Format('Обнаружена ошибка ввода-вывода %d, %d в таблице %s. Нужно восстановить таблицу из резервной копии', [nDosError, nOperation, aShortName])
    else
     aResult:= 0;
   end // aResult = -1
   else
    aMess := aMess + SysUtils.Format('Обнаружена ошибка %d в таблице %s.', [aResult, aShortName]);
   if aResult <> 0 then
   begin
    l_Mode:= [];
    case aResult of
     HT_ERR_ASSO_DAMAGED:
      begin
       Include(l_Mode, repDropIdx);
       Include(l_Mode, repBuildIdx);
      end;
     HT_ERR_DATA_CORRUPTED:
      begin
       Include(l_Mode, repFixConst);
       Include(l_Mode, repFixVar);
      end;
     HT_ERR_INDEX_NOT_SORTED,
     HT_ERR_NOT_INDEXED:
      Include(l_Mode, repBuildIdx);
     HT_ERR_LOG_CORRUPTED:
      Include(l_Mode, repFixVar);
    end; // case l_Result
    if l_Mode <> [] then
    begin
     Result:= 0;
     if repFixConst in l_Mode then
      Result:= htRepairTable(@aFullName[1], @aPassword[1], @aPassword[1]);
     if (Result >= 0) and (repFixVar in l_Mode) then
      Result:= htRepairTableLog(@aFullName[1], @aPassword[1], @aPassword[1], l_Count);
     if Result >= 0 then
      Result:= htUpdateTable(@aFullName[1], @aPassword[1], @aPassword[1], True, False);
     if Result < 0 then
      Result:= lp_AnalyzeResult(aShortName, aFullName, aPassword, Result);

     if (Result >= 0) and (repDropIdx in l_Mode) then
      Result:= htDropIndexes(@aFullName[1], @aPassword[1], @aPassword[1]);
     if (Result >= 0) and (repBuildIdx in l_Mode) then
      Result:= htBuildIndexes(@aFullName[1], @aPassword[1], @aPassword[1], True, False);
     if Result >=0 then
      aMess := aMess + ' Ошибка исправлена.'
     else
      aMess := aMess + ' Ошибку исправить не удалось.';
    end
    else
    begin
     Result:= aResult;
     if aResult = -54 then
      aMess:= aMess + ' Необходимо заменить HTB-файл.';
    end;
   end; // aResult <> 0
 end;

 procedure VerifyTable(const aShortName, aFullName, aPassword: ShortString; aProcessState: Longint);
 var
  l_Result: Integer;
 begin
  // Общая проверка таблицы
  l_Result:= htTableVerify(@aFullName[1], @aPassword[1], @aPassword[1], 0);
  if l_Result < 0 then
   l_Result:= lp_AnalyzeResult(aShortName, aFullName, aPassword, l_Result);
  if l_Result = 0 then
  begin
   // проверка индекса. Возможно, не нужно выполнять
   l_Result:= htTableVerify(@aFullName[1], @aPassword[1], @aPassword[1], HTVF_INDEX);
   if l_Result < 0 then
    lp_AnalyzeResult(aShortName, aFullName, aPassword, l_Result);
  end; // l_Result = 0
  If Assigned(fProgressProc) then
   fProgressProc(piCurrent,aProcessState+1, aFullName);
 end;

Begin
 l_NeededTemporaryLock := not f_AllLocked;
 if l_NeededTemporaryLock then
  if not xxxLockAll then
   raise EHtErrors.Create('Невозможно выполнить проверку и исправление таблиц, '#13#10+
                          'т.к. для этого не удалось получить эксклюзивный доступ к БД.');
 try
  aMess := '';
  CloseAllTbls(aFamily);
  Try
   If aFamily=MainTblsFamily then
   Begin
    If Assigned(fProgressProc) then
     fProgressProc(piStart,Byte(High(TMainTbls)),'Проверка основных таблиц');
    Try
     For I:=Low(TMainTbls) to High(TMainTbls) do
     begin
      //if i <> mtCtrl then // Таблица Ctrl всегда генерирует ошибку :(
      begin
       l3System.Msg2Log('Таблица %s...', [MainTblNames[I]]);
       VerifyTable(MainTblNames[I],
                  FamilyTbl.FamilyPath(aFamily)+MainTblNames[I]+#0,
                  TblPassW[MainPassIndex[I]]+#0,
                  Byte(I));
       htPurgeError;
      end;
     end;
    finally
     If Assigned(fProgressProc) then
      fProgressProc(piEnd,0,'');
    end;
   end
   else
   Begin
    Suffix:=IntToHex(aFamily,3)+#0;
    If Assigned(fProgressProc) then
     fProgressProc(piStart,Byte(High(TFamTbls))+1,'Проверка таблиц семейства');
    Try

     For J:=Low(TFamTbls) to High(TFamTbls) do
     begin
      if J in (cFictTables - [ftCtrl]) then
       Continue;
      TmpName:=FamilyTbl.FamilyPath(aFamily)+FamTblNames[J]+Suffix;
      TmpPass:=TblPassW[FamPassIndex[J]]+#0;
      l3System.Msg2Log('Таблица %s...', [FamTblNames[j]]);
      VerifyTable(FamTblNames[J],
                  FamilyTbl.FamilyPath(aFamily)+FamTblNames[J]+Suffix,
                  TblPassW[FamPassIndex[J]]+#0,
                  Byte(J));
      htPurgeError;
     end;
     If Assigned(fProgressProc) then
      fProgressProc(piCurrent, Byte(j)+1, FamilyTbl.FamilyPath(aFamily)+FamTblNames[J]+Suffix);

    finally
     If Assigned(fProgressProc) then
      fProgressProc(piEnd,0,'');
    end;
   end;
  finally
   OpenClosedTbls;
  end;

  aErrorFound := Length(aMess) > 0;
  if aErrorFound then
   l3System.Msg2Log(aMess);
 finally
  if l_NeededTemporaryLock then
   xxxUnLockAll;
 end;
end;


Procedure THTServer.VerifyFamily(aFamily : TdaFamilyID;VType : TVerifyType;  WithFixErrors : Boolean);
Var
 ReportFile : Text;
 I          : TdaDictionaryType;
Begin
 AssignFile(ReportFile,'Verify.log');
 ReWrite(ReportFile);
 WriteLn(ReportFile,' Проверка логической целостности семейства N ',aFamily);
 WriteLn(ReportFile,'-----------------------------------------------');
 WriteLn(ReportFile);
 Try
  If aFamily<>0 then
  Begin
   If (VType = vtAll) or (VType = vtDiction) then
   Begin
    For I := da_dlSources to High(TdaDictionaryType) do
    Begin
     WriteLn(ReportFile,' Проверка словаря '+ cDLPassports[I].rName);
     WriteLn(ReportFile);
     try
      LinkServer(aFamily).VerifyLink(I, @ReportFile, WithFixErrors);
     except
      WriteLn(ReportFile,'!! Exception');
     end;
     WriteLn(ReportFile);
    end;
   end;
  end
  else
  begin
   // проверка main семейства
  end;
 finally
  CloseFile(ReportFile);
 end;
end;

Function THTServer.DoOnLongProcess(aState : TdaProcessState) : Boolean;
begin
 If Assigned(fLongProcessProc) then
  Result := fLongProcessProc(aState)
 else
  Result := False; // крутить цикл до победного конца
end;

Function THTServer.StartTransactionWithWait(aTables : LPTHANDLE;
                                            aTblCnt : SmallInt;
                                            Var TransID : TRID) : Boolean;
Var
 OpRes      : LongInt;
 CancelFlag : Boolean;
begin
 Result:=False;
 CancelFlag:=False;

 OpRes:=htStartTransaction(aTables,aTblCnt,TransID);
 If OpRes = 0 then
  begin
   Result:=True;
   SignalStartTransaction;
   exit;
  end
 else
  begin
   If (OpRes = -72) (* Table used in other transaction *) then
    begin
     DoOnLongProcess(da_psStart);
     Repeat
      Sleep(200);
      OpRes:=htStartTransaction(aTables,aTblCnt,TransID);
      If OpRes = 0 then
       begin
        Result:=True;
        DoOnLongProcess(da_psEnd);
        SignalStartTransaction;
        exit;
       end
      else
       If (OpRes = -72) then
        CancelFlag:=DoOnLongProcess(da_psCurrent)
       else
        begin
         DoOnLongProcess(da_psEnd);
         Ht(OpRes);
        end;
     until CancelFlag;
     DoOnLongProcess(da_psEnd);
    end
   else
    Ht(OpRes);
  end;
end;

function THTServer.xxxGetHomePathName(aUserID : TdaUserID) : TPathStr;
Var
 DirName     : TPathStr;
Begin
 DirName:=GetHomePathCode(aUserID)+'\';
 Result:=ConcatDirName(xxxGlobalHomePath, DirName);
end;

function THTServer.xxxGetHomePath(aUserID : TdaUserID) : TPathStr;
Begin
 Result := xxxGetHomePathName(aUserID);
 if not l3FileUtils.FileExists(Result) then
  MakeDir(Result);
end;

Function THTServer.xxxCheckArchivariusPassword(aShortName : TPassNameStr;
                                            aPassWord  : TPassStr;
                                            RequireAdminRights: Boolean) : Boolean;
var
 lUserID : TdaUserID;
 l_HasAdminRights: Boolean;
begin
 Result := False;
 if xxxUserManager = nil then Exit; // Мог выскочить exception при инициализаци базы...
 if (AnsiLowerCase(aShortName) = c_SupervisorUserName) and not RequireAdminRights then
  Exit;
 if xxxUserManager.xxxCheckPassword(lUserID, aShortName, aPassword) then
 begin
  if (lUserID <> usSupervisor) and RequireAdminRights then
  begin
   if not xxxUserManager.xxxIsUserAdmin(lUserID) then
    Exit;
  end;
  Result:= True;
  fRequireAdminRights := RequireAdminRights;
  xxxUserID := lUserID;
 end; // xxxUserManager.CheckPassword(lUserID, aShortName,aPassword)
end;
(*
procedure THTServer.FillValueSABfromList(var aSAB : SAB;aList : Tl3LongintList);
const
 MaxBufRecords = 64000 div SizeOf(TDocID);
var
 TmpBuf     : Pointer;
 I,
 MaxCount   : Word;
 CurListPos,
 CurInsPos  : LongInt;
begin
 if aList = nil then
  Exit;
 aList.Sorted := True;
 Ht(htOpenResults(aSAB,ROPEN_READ,nil,0));
 try
  if aList.Count <= MaxBufRecords then
   MaxCount:=aList.Count
  else
   MaxCount:=MaxBufRecords;
  I:=0;
  CurListPos:=0;
  CurInsPos:=0;
  l3System.GetLocalMem(TmpBuf,MaxCount*SizeOf(LongInt));
  try
   repeat
    PLongArr(TmpBuf)^[I]:=aList[CurListPos];
    Inc(I);
    Inc(CurListPos);
    if (CurListPos = aList.Count) or
       (I = MaxCount) then
     begin
      Ht(htIncludeResultsBlock(aSAB,CurInsPos,TmpBuf,I*SizeOf(LongInt)));
      Inc(CurInsPos,I);
      I:=0;
     end;
   until CurListPos = aList.Count;
  finally
   l3System.FreeLocalMem(TmpBuf);
  end;
 finally
  htCloseResults(aSAB);
 end;
end;
*)
procedure THTServer.FillValueSABfromListEx(var aSAB: SAB;
                                           anId: Integer;
                                           aList: Tl3LongintList);
const
 MaxBufRecords = 64000 div SizeOf(TPairLong);
var
 TmpBuf     : Pointer;
 I,
 MaxCount   : Word;
 CurListPos,
 CurInsPos  : LongInt;
begin
 if aList = nil then
  Exit;
 aList.Sorted := True;
 Ht(htOpenResults(aSAB, ROPEN_READ, nil, 0));
 try
  if aList.Count <= MaxBufRecords then
   MaxCount := aList.Count
  else
   MaxCount := MaxBufRecords;
  I := 0;
  CurListPos := 0;
  CurInsPos := 0;
  l3System.GetLocalMem(TmpBuf, MaxCount * SizeOf(TPairLong));
  try
   repeat
    PPairLongArr(TmpBuf)^[I].Doc := anId;
    PPairLongArr(TmpBuf)^[I].Sub := aList[CurListPos];
    Inc(I);
    Inc(CurListPos);
    if (CurListPos = aList.Count) or (I = MaxCount) then
    begin
     Ht(htIncludeResultsBlock(aSAB, CurInsPos, TmpBuf, I * SizeOf(TPairLong)));
     Inc(CurInsPos, I);
     I := 0;
    end;
   until CurListPos = aList.Count;
  finally
   l3System.FreeLocalMem(TmpBuf);
  end;
 finally
  htCloseResults(aSAB);
 end;
end;

(*function THTServer.CheckDocumentsWithOutGarantID(aFamily : TdaFamilyID;
                                                 Report  : Boolean;
                                                 LogName : TFileName) : LongInt;
Const
 Suffix : Array [1..2] of Char = #13#10;
Var
 tmpReNumTbl : TRenumTbl;

 RenumKeys,
 DocKeys,
 RelKeys,
 CorrectID,
 WrongID     : SAB;

 CurFl       : TmgExFileStream;
 CurBuf      : TmgBuffStream;

 procedure WriteToLog(CurIDSab : Sab;aTitle : ShortString);
 Var
  CurID : TDocID;
  TmpStr  : ShortString;
 begin
  If CurIDSab.gFoundCnt>0 then
   Begin
    Result:=Result+CurIDSab.gFoundCnt;

    if Report then
     begin
      Ht(htOpenResults(CurIDSab,ROPEN_READ,Nil,0));
      Try
       If aTitle<>'' then
        begin
         CurBuf.WriteBuffer(Suffix,2);
         CurBuf.WriteBuffer(aTitle[1],Length(aTitle));
         CurBuf.WriteBuffer(Suffix,2);
        end;
       While htReadResults(CurIDSab,@CurID,SizeOf(TDocID)) > 0 do
        Begin
         TmpStr:=IntToStr(CurID);
         CurBuf.WriteBuffer(TmpStr[1],Length(TmpStr));
         CurBuf.WriteBuffer(Suffix,2);
        end;
      finally
       htCloseResults(CurIDSab);
      end;
     end;
   end;
 end;

begin
 Result:=0;
 DocumentServer.Family:=aFamily;
 tmpReNumTbl:=ReNumTbl[aFamily];

 If Report then
  begin
   If LogName = '' then LogName:='BadGarID.log';
   CurFl:=TmgExFileStream.Create(LogName,l3_fmWrite);
   CurBuf:=TmgBuffStream.Create(CurFl,32000);
  end;
 Try
  tmpReNumTbl.RefreshSrchList;
  htValuesOfKey(RenumKeys,rnRealID_fld,tmpReNumTbl.fSrchList);
  Try
   DocumentServer.FileTbl.RefreshSrchList;
   htValuesOfKey(DocKeys,fId_Fld,DocumentServer.FileTbl.fSrchList);
   Try
    htTransferToPhoto(RenumKeys,DocumentServer.FileTbl.fSrchList,fId_Fld);
    htAndResults(CorrectID,DocKeys,RenumKeys);
    Try
     htNotResults(WrongID,CorrectID);
     Try
      WriteToLog(WrongID,'Документы без внешнего ID.');
     finally
      htClearResults(WrongID);
     end;
    finally
     htClearResults(CorrectID);
    end;
   finally
    htClearResults(DocKeys);
   end;

   htValuesOfKey(RelKeys,fRelated_fld,DocumentServer.FileTbl.fSrchList);
   Try
    htTransferToPhoto(RenumKeys,DocumentServer.FileTbl.fSrchList,fRelated_fld);
    htAndResults(CorrectID,RelKeys,RenumKeys);
    Try
     htNotResults(WrongID,CorrectID);
     Try
      WriteToLog(WrongID,'Справки без внешнего ID.');
     finally
      htClearResults(WrongID);
     end;
    finally
     htClearResults(CorrectID);
    end;
   finally
    htClearResults(RelKeys);
   end;
  finally
   htClearResults(RenumKeys);
  end;
 finally
  if Report then
   begin
    l3Free(CurBuf);
    l3Free(CurFl);
   end;
 end;
end;
*)
(*
Function THTServer.CheckNullDocuments(aFamily : TdaFamilyID;
                                      Clear,Report : Boolean;
                                      LogName : TFileName) : LongInt;
Const
 tmpFldCount = 1;
 tmpFld : SmallInt = rnImportID_fld;
 Suffix : Array [1..2] of Char = #13#10;

Var
 tmpReNumTbl  : TRenumTbl;

 RenumKeys,
 DocKeys,
 RelKeys,
 AllIDKeys,
 RealRenumKeys,
 FakeRenumKeys   : SAB;

 TmpSab  : SAB;
 TmpList : TAbstractList;
 TmpMode : TOpenMode;
 TmpRec  : PAnsiChar;
 TmpID,
 I       : LongInt;
 TmpStr  : ShortString;

 CurFl   : TmgExFileStream;
 CurBuf  : TmgBuffStream;
Begin
 Result:=0;
 HLServer.Family:=aFamily;
 DocumentServer.Family:=aFamily;
 tmpReNumTbl:=ReNumTbl[aFamily];

 tmpReNumTbl.RefreshSrchList;
 htValuesOfKey(RenumKeys,rnRealID_fld,tmpReNumTbl.fSrchList);
 Try
  DocumentServer.FileTbl.RefreshSrchList;
  htValuesOfKey(DocKeys,fId_Fld,DocumentServer.FileTbl.fSrchList);
  Try
   htValuesOfKey(RelKeys,fRelated_fld,DocumentServer.FileTbl.fSrchList);
   Try
    htOrResults(AllIDKeys,DocKeys,RelKeys);
    Try
     htTransferToPhoto(AllIDKeys,tmpReNumTbl.fSrchList,rnRealID_fld);
     htAndResults(RealRenumKeys,AllIDKeys,RenumKeys);
     Try
      htNotResults(FakeRenumKeys,RealRenumKeys);
      Try
       If FakeRenumKeys.gFoundCnt>0 then
        Begin
         Result:=FakeRenumKeys.gFoundCnt;

         if Report then
          begin
           htRecordsByKey(TmpSAB,FakeRenumKeys);
           Try
            TmpMode.openMode:=ROPEN_READ;
            TmpMode.Count:=tmpFldCount;
            TmpMode.FldArr:=@tmpFld;
            TmpList:=TAbstractList.Create(@TmpSab,TmpMode);
            TmpList.ReadForvard:=True;
            Try
             CurFl:=TmgExFileStream.Create(LogName,l3_fmWrite);
             CurBuf:=TmgBuffStream.Create(CurFl,32000);
             Try
              For I:=0 to TmpList.Count-1 do
               Begin
                TmpRec:=TmpList.GetItem(I);
                TmpID:=0;
                l3Move(TmpRec[0],TmpID,SizeOf(TDocID));
                TmpStr:=IntToStr(TmpID);
                CurBuf.WriteBuffer(TmpStr[1],Length(TmpStr));
                CurBuf.WriteBuffer(Suffix,2);
               end;
             finally
              l3Free(CurBuf);
              l3Free(CurFl);
             end;
            finally
             l3Free(TmpList);
            end;
           finally
            htClearResults(TmpSAB);
           end;
          end;
         if Clear then
          begin
           tmpReNumTbl.DelRealNumbers(FakeRenumKeys);
           //HLServer.HLinkTbl.SetEmptyDestOnDocs(FakeRenumKeys);
          end;
        end;
      finally
       htClearResults(FakeRenumKeys);
      end;
     finally
      htClearResults(RealRenumKeys);
     end;
    finally
     htClearResults(AllIDKeys);
    end;
   finally
    htClearResults(RelKeys);
   end;
  finally
   htClearResults(DocKeys);
  end;
 finally
  htClearResults(RenumKeys);
 end;
end;
*)

function THTServer.GetTblObjectEx(aFamily: TdaFamilyID; aTable: Integer; aATP : TdtAttrTblPart = atpMain): TPrometTbl;
var
 l_FTbl: TFamTbls;
 l_MTbl: TMainTbls;
 l_DictType: TdaDictionaryType;
 I: Integer;
Begin
 Result := GetTblObject(aFamily, aTable, aATP);
 if Result = nil then
 begin
  // теперь ищем по другим серверам
  if aFamily = 0 then
  begin
   Assert(false, 'GetTblObjectEx');
  end
  else
  begin
   l_FTbl := TFamTbls(aTable);
   Assert(l_FTbl in [ftFile, ftFileDup1, ftFileDup2], 'GetTblObjectEx');

   case l_FTbl of
    ftFile  :
      Result := DocumentServer(aFamily).FileTbl; // FILE
    ftHlink :
      ;//Result := LinkServer(aFamily)[atHLink].Table;      // HLINK
    ftActiv :
      ;//Result := LinkServer(aFamily)[atActiveIntervals].Table;
    ftLog   :
      ;//Result := LinkServer(aFamily)[atLogRecords].Table
   else
    // DT*
    for l_DictType := da_dlSources to da_dlAnnoClasses do
     if cDLPassports[l_DictType].rDict = l_FTbl then
     begin
      {DictServer.Family := aFamily;
      Result := DictServer.DictTbl[l_DictType];
      if Result <> nil then
       Break;}
     end;
   end; // case l_FTbl of
  end; // if-else
 end; // if

 if Result = nil then
 begin
  Result := TPrometTbl.Create(aFamily, aTable, aATP);
  Result.Free; // уменьшаем счетчик ссылок
 end;
end;

function THTServer.GetFreeTbl(aFamily : TdaFamilyID): TFreeTbl;
begin
 if aFamily = MainTblsFamily then
  Result := TFreeTbl(GetTblObject(aFamily, Ord(mtFree)))
 else
  Result := TFreeTbl(GetTblObject(aFamily, Ord(ftFree)));

 if Result = nil then
 begin
  Result := TFreeTbl.Create(aFamily);
  Result.Free; // уменьшим количество ссылок
 end;
end;

function THTServer.GetTextBase(aFamily : TdaFamilyID) : AnsiString;
begin
 Result := FamilyTbl.FamilyPath(aFamily) + 'bserv' + IntToHex(aFamily, 3);
end;

function THTServer.StartTransaction(aTables: array of TPrometTbl;
                                    var TransID: TRID;
                                    aTransTime: Word = DefaultTransTime): Boolean;
var
 l_TableHandles: array of HT_Const.THANDLE;
 l_TablesAmount: Integer;
 I: Integer;
begin
 l_TablesAmount := Length(aTables);
 // сформируем массив Handle'ов
 SetLength(l_TableHandles, l_TablesAmount);
 try
  for I := 0 to l_TablesAmount - 1 do
   l_TableHandles[I] := aTables[I].Handle;

  // собственно subj
  TransTime := aTransTime;
  Result := StartTransactionWithWait(@l_TableHandles[0],
                                     l_TablesAmount,
                                     TransID);
  // ставим пометки на таблицы, участвующие в этой транзакции (просто запишем номера этой транзакции)
  if Result then
   for I := 0 to l_TablesAmount - 1 do
    aTables[I].TransID := TransId;
 finally
  l_TableHandles := nil;
 end;
end;

function THTServer.StartTransaction(aTables : Il3CBaseList;
                                     var TransID: TRID;
                                     aTransTime: Word = DefaultTransTime): Boolean;
var
 l_TableHandles: array of HT_Const.THANDLE;
 l_TablesAmount: Integer;
 I: Integer;
begin
 l_TablesAmount := aTables.Count;
 // сформируем массив Handle'ов
 SetLength(l_TableHandles, l_TablesAmount);
 try
  for I := 0 to l_TablesAmount - 1 do
   l_TableHandles[I] := TdtTable(aTables[I]).Handle;

  // собственно subj
  TransTime := aTransTime;
  Result := StartTransactionWithWait(@l_TableHandles[0],
                                     l_TablesAmount,
                                     TransID);
  // ставим пометки на таблицы, участвующие в этой транзакции (просто запишем номера этой транзакции)
  if Result then
   for I := 0 to l_TablesAmount - 1 do
    TdtTable(aTables[I]).TransID := TransId;
 finally
  l_TableHandles := nil;
 end;
end;

procedure THTServer.CommitTransaction(var aTransID: TRID);
begin
 try
  Ht(htCommitTransaction(aTransID));
 finally
  SignalEndTransaction;
  ClearTransIds(aTransID); // снятие пометок
 end;
 TransTime := DefaultTransTime;
end;

procedure THTServer.RollbackTransaction(var aTransID: TRID);
begin
 try
  Ht(htRollBackTransaction(aTransID));
 finally
  SignalEndTransaction;
  ClearTransIds(aTransID); // снятие пометок
 end;
 TransTime := DefaultTransTime;
end;

procedure THTServer.ClearTransIds(const aTransId: Ht_Const.TRID);
var
 I: Integer;
 l_Table: TPrometTbl;
begin
 for I := 0 to fOpenTbls.Count - 1 do
 begin
  l_Table := POpenTblRec(fOpenTbls.Data[I])^.rObj;
  if CompareMem(@l_Table.TransID,
                @aTransId,
                SizeOf(Ht_Const.TRID))
  then
   l_Table.ClearTransId;
 end;
end;

procedure THTServer.ReleaseTables;
var
 I         : Integer;
 lCurTable : TPrometTbl;
begin
 if Assigned(fOpenTbls) then
 begin
  // сначала убиваются все таблицы, кроме FREE
  for I := Pred(fOpenTbls.Count) downto 0 do
  begin
   lCurTable := POpenTblRec(fOpenTbls.Data[I])^.rObj;
   if (lCurTable <> nil) and not (lCurTable is TFreeTbl) then
   begin
    fOpenTbls.Delete(I);
    if lCurTable.RefCount > 1 then
     l3System.Msg2Log('ALERT: Unfreed HT table: ' + lCurTable.TblFullName);
    l3Free(lCurTable);
   end;
  end;

  // теперь убиваются все остальные, т.е. FREE
  for I := Pred(fOpenTbls.Count) downto 0 do
   l3Free(POpenTblRec(fOpenTbls.Data[I])^.rObj);

  L3Free(fOpenTbls);
 end;
end;

(*procedure THTServer.DelTblObj(aTblObj : TPrometTbl);
var
 lIndex : LongInt;
begin
 lIndex := fOpenTbls.IndexOfData(Pointer(aTblObj),SizeOf(Pointer),
                                 fOpenTbls.DataSize-SizeOf(Pointer));
 if lIndex <> -1 then
 begin
  fOpenTbls.Delete(lIndex);
  l3Free(aTblObj);
 end;
end;
*)

(*
class procedure THTServer.SabToList(var aSrcSab: Sab; aDstList: Tl3LongintList);
var
 l_ValIter: TValuesIterator;
 l_Value: Longint;
begin
 if (aDstList = nil)
  or (htResultsType(aSrcSab) <> RES_VALUE)
  or htIsResultOpen(aSrcSab)
 then
  Exit;

 aDstList.Clear;
 aDstList.Capacity := aSrcSab.gFoundCnt;
 l_ValIter := TValuesIterator.Create(aSrcSab);
 try
  if l_ValIter.RecordSize > SizeOf(l_Value) then
   Exit;
  while not l_ValIter.EOF do
  begin
   l_Value := 0;
   l_ValIter.Read(l_Value);
   aDstList.Add(l_Value);
   l_ValIter.Next;
  end;
 finally
  L3Free(l_ValIter);
 end;
end;
*)
procedure THTServer.SetTransTime(const aSeconds: Word);
begin
 if f_TransTime <> aSeconds then
 begin
  f_TransTime := aSeconds;
  htSetTransTimeOut(f_TransTime);
 end;
end;

procedure THTServer.OnHtError(aErrorMessID: SmallInt);
begin
 case aErrorMessID of
  2: // "not enough memory"
  begin
   l3System.Msg2Log(Format('HtInitData.gHeapCtrl = %d, HtInitData.gHeapTask = %d',
                           [f_HtInitData.gHeapCtrl, f_HtInitData.gHeapTask]));
  end;

 end; // case

end;

procedure THTServer.OnHtIOError(aFileName: PAnsiChar;
                                aIoErrorCode,
                                aDosErrorNumber: SmallInt);
begin
 ; // пусто
end;

function dtGetDB(aFamily     : TdaFamilyID;
                 aOnYield    : TNotifyEvent = nil;
                 aFileMeter  : Tl3ProgressProc = nil;
                 aFilesMeter : Tl3ProgressProc = nil): Im3DB;
  {-}
begin
 Result := Tm3DB.Make(GlobalHtServer.xxxTextBase[aFamily], aOnYield, aFileMeter, aFilesMeter);
end;

(*function dtGetDBEx(aFamily     : TdaFamilyID;
                   aOnYield    : TNotifyEvent = nil;
                   aFileMeter  : Tl3ProgressProc = nil;
                   aFilesMeter : Tl3ProgressProc = nil): Im4DB;
  {-}
begin
 Result := Tm4DB.Make(GlobalHtServer.xxxTextBase[aFamily], aOnYield, aFileMeter, aFilesMeter);
end;*)

function THTServer.xxxLoginAsServer: Boolean;
Begin
 fRequireAdminRights := True;
 xxxUserID := usServerService;
 Result:=True;
end;

function THTServer.xxxGetRegionName(aID: TdaRegionID): AnsiString;
begin
 try
  Result := xxxRegionTbl.GetNameStr(aID);
 except
  Result := '';
 end;
end;

function THTServer.xxxIsRegionExists(aID: TdaRegionID): Boolean;
begin
 try
  Result := xxxRegionTbl.CheckExists(aID);
 except
  Result := False;
 end;
end;

function THTServer.pm_GetRegionTbl: TDictionaryTbl;
begin
 if f_RegionTbl = nil then
 begin
  f_RegionTbl := TDictionaryTbl.Create(MainTblsFamily, da_dlNone, Ord(mtRegions));
  f_RegionTbl.NameFld := 2;
  f_RegionTbl.LoadItemList;
 end;
 Result := f_RegionTbl;
end;

function THTServer.xxxConvertAliasPath(CurPath : ShortString): AnsiString;
var
 SecondPos : Byte;
 CfgPath,
 PathConst,
 SaveSection : ShortString;
Begin
 If CurPath[1]='%' then
 Begin
   SecondPos:=PosEx('%',CurPath,2);
   If SecondPos=0 then
    raise EHtErrors.CreateInt(ecPathNotFound);
   PathConst:= AnsiDequotedStr(CurPath, '%'); // Copy(CurPath,2,SecondPos-2);
   CfgPath := IncludeTrailingBackslash(GetAliasValue(PathConst));

   If SecondPos=Length(CurPath) then
    Result:=CfgPath
   else
   Begin
    If CurPath[SecondPos+1]='\' then
     Result:=CfgPath+Copy(CurPath,SecondPos+2,Length(CurPath))
    else
     Result:=CfgPath+Copy(CurPath,SecondPos+1,Length(CurPath));
   end;
  end
 else
  Result := CurPath;
 Result := IncludeTrailingBackslash(Result);
end;

function THTServer.GetAliasValue(const aAlias: AnsiString): ShortString;
begin
 Result := '';
 if f_AliasList.Count > 0 then
  Result := f_AliasList.Values[aAlias];

 if (Result = '') and  (aAlias = 'FamilyPath') then
  Result := FamilyPath;

 if (Result = '') then
  raise EHTErrors.CreateInt(ecPathNotFound);
end;

procedure THTServer.GoingToDie;
begin
 CallNotify(sni_Destroy, 0);
end;

function THTServer.pm_GetBaseLanguage(aFamily: TdaFamilyID): TLanguageObj;
begin
 if BaseConfig = nil then
  InitBaseConfig(CurrentFamily);
 if f_BaseLang = nil then
 begin
  f_BaseLang:= TLanguageObj.Create;
  f_BaseLang.LanguageID:= BaseConfig['Settings'].ReadParamIntDef('Language', -1);
 end;
 Result:= f_BaseLang;
end;

function THTServer.CheckFreeResource(aFamily : TdaFamilyID; const aResourceName : AnsiString): Boolean;
begin
 Result := FreeTbl[aFamily].AnyRangesPresent(aResourceName);
end;

function THTServer.pm_GetExtDocIDsFromRange: Boolean;
begin
 Result := CheckFreeResource(CurrentFamily, ftnDocIDExternal);
end;

function THTServer.xxxGetFreeExtObjID(aFamily : TdaFamilyID): TDocID;
begin
 Result := 0;
 // если есть ftnObjIDExternal возмем из него
 //if CheckFreeResource(aFamily, ftnImgHandle) then
 try
  Result := GlobalHtServer.FreeTbl[aFamily].GetFree(ftnImgHandle);
 except
  Result := 0;
 end;

 if (Result <= 0) {and (CheckFreeResource(aFamily, ftnDocIDExternal))} then
 try
  Result := GlobalHtServer.FreeTbl[aFamily].GetFree(ftnDocIDExternal);
 except
  Result := 0;
 end;
end;

function THTServer.xxxGetFreeExtDocID(aFamily : TdaFamilyID): TDocID;
var
 lRenum : TReNumTbl;
begin
 if not ExtDocIDsFromRange then
  Result := 0
 else
 begin
  lRenum := LinkServer(aFamily).Renum;
  repeat
   Result := GlobalHtServer.FreeTbl[aFamily].GetFree(ftnDocIDExternal);
  until lRenum.ConvertToRealNumber(Result) = cUndefDocID;
 end;
end;

procedure THTServer.xxxReadRegionFromIni(aDefaultRegion: TdaRegionID = 0; aIni: TCfgList = nil);
var
 l_BaseIniPath: AnsiString;
 l_BaseIni: TCfgList;
begin
 if aIni = nil then
 begin
  l_BaseIniPath := ConcatDirName(CurTblPath, 'base.ini');
  if not FileExists(l_BaseIniPath) then
   raise Exception.Create('Не найден файл ' + l_BaseIniPath);
  l_BaseIni := TCfgList.Create(l_BaseIniPath);
 end
 else
  l_BaseIni := aIni.Use;
  
 try
  l_BaseIni.Section:= 'Tables';
  f_RegionID := l_BaseIni.ReadParamIntDef('Region', aDefaultRegion);
 finally
  FreeAndNil(l_BaseIni);
 end;
end;


function dtGetObjectStream(aFamily: TdaFamilyID; aDocID: TDocID; var anObjID: Integer; aMode: Tm3StoreAccess): IStream;
var
 l_DB  : Im3DB;
 l_Doc : Im3DBDocument;
begin
 l_DB := dtGetDB(aFamily);
 try
  l_Doc := l_DB.GetDocument(aDocID);
  try
   if (aMode = m3_saRead) then
   begin
    if (anObjID < 0) then
     l3System.Msg2Log('Картинке не назначен номер');
   end//aMode = m3_saRead
   else
   begin
    if (anObjID <= 0) then
     anObjID := l_Doc.GetFreeObjectID;
   end;//aMode = m3_saRead
   Result := l_Doc.Open(aMode, m3_dsObject, anObjID);
  finally
   l_Doc := nil;
  end;
 finally
  l_DB := nil;
 end;//try..finally
end;

function THTServer.xxxCurUserIsServer: Boolean;
begin
  Result := UserIsService(xxxUserID);
end;

Initialization
 htGlobalInit(HInstance);

Finalization
 htGlobalShut;

end.
