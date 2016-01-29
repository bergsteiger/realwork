unit nsFolders;

// $Id: nsFolders.pas,v 1.19 2015/03/18 11:25:50 lulin Exp $

// $Log: nsFolders.pas,v $
// Revision 1.19  2015/03/18 11:25:50  lulin
// - перетряхиваем зависимости.
//
// Revision 1.18  2014/01/20 11:55:09  morozov
// {RequestLink: 508450259]
//
// Revision 1.17  2013/05/13 17:23:41  lulin
// - разборки с упавшими тестами.
//
// Revision 1.16  2011/10/28 16:06:29  lulin
// {RequestLink:274466565}
//
// Revision 1.15  2011/06/23 15:30:00  lulin
// {RequestLink:254944102}.
//
// Revision 1.14  2011/05/19 12:17:23  lulin
// {RequestLink:266409354}.
//
// Revision 1.13  2011/05/13 11:55:43  lulin
// - чистка комментариев.
//
// Revision 1.12  2011/01/27 12:14:15  lulin
// {RequestLink:248195582}.
// - избавляемся от развесистых макарон.
//
// Revision 1.11  2011/01/24 10:42:03  lulin
// [$251338402].
//
// Revision 1.10  2011/01/21 17:18:13  lulin
// {RequestLink:248195582}.
// - восстановил удаление закладок.
//
// Revision 1.9  2011/01/21 16:55:35  lulin
// {RequestLink:248195582}.
// - распиливаем на несколько пакетов.
//
// Revision 1.8  2010/10/14 14:41:55  oman
// - new: пытаемся редактировать {RequestLink:235057812}
//
// Revision 1.7  2010/10/07 14:12:48  oman
// - new: Переносим заглушки на модель {RequestLink:235057812}
//
// Revision 1.6  2010/10/07 07:51:32  oman
// - new: Заглушки и не падаем {RequestLink:235057812}
//
// Revision 1.5  2010/10/06 06:14:30  oman
// - new: Заглушки и не падаем {RequestLink:235057812}
//
// Revision 1.4  2010/10/04 12:32:31  oman
// - new: Заглушки и не падаем {RequestLink:235057812}
//
// Revision 1.3  2010/07/15 09:01:32  lulin
// {RequestLink:207389954}.
//
// Revision 1.2  2010/02/02 18:57:38  lulin
// {RequestLink:185828256}. Готовимся к переходу на использование состояния прецедента.
//
// Revision 1.1  2009/12/02 17:21:39  lulin
// {RequestLink:172984885}.
//
// Revision 1.3  2009/10/30 17:10:59  lulin
// - третья волна компании по борьбе со старыми внутренними операциями.
//
// Revision 1.2  2009/09/28 16:15:59  lulin
// - вызов диалога сохранения объекта в папки переведён на фабрику.
//
// Revision 1.1  2009/09/28 10:33:13  lulin
// - переносим примесь для обработки переключения закладок в более правильное место.
//
// Revision 1.2  2009/09/25 16:13:20  lulin
// - продолжаем перенос модуля Папки на модель.
//
// Revision 1.1  2009/09/14 11:28:32  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.246  2009/09/08 06:53:27  oman
// - new: {RequestLink:162077063}
//
// Revision 1.245  2009/09/08 06:07:03  oman
// - new: {RequestLink:162077086}
//
// Revision 1.244  2009/09/02 13:02:41  oman
// - new: Зачистка - {RequestLink:159369920}
//
// Revision 1.243  2009/08/28 17:16:34  lulin
// - начинаем публикацию и описание внутренних операций.
//
// Revision 1.242  2009/08/26 08:15:20  lulin
// - декорируем имена операций, чтобы можно было искать.
// - bug fix: не собирались мониторинги.
//
// Revision 1.241  2009/08/19 11:07:13  oman
// - new: Зачистка - {RequestLink:159355458}
//
// Revision 1.240  2009/08/13 07:13:10  oman
// - new: Более правильная нотификация - {RequestLink:159355458}
//
// Revision 1.239  2009/08/06 06:53:40  oman
// - fix: - {RequestLink:158336971}
//
// Revision 1.238  2009/07/31 17:30:00  lulin
// - убираем мусор.
//
// Revision 1.237  2009/07/23 06:48:50  oman
// - fix: Дочищаем - {RequestLink:157909222}
//
// Revision 1.236  2009/07/21 12:24:06  oman
// - fix: Не выставлялсь права - {RequestLink:155026997}
//
// Revision 1.235  2009/06/03 12:28:06  oman
// - new: компилируемся - [$148014435]
//
// Revision 1.234  2009/04/17 05:51:53  oman
// - new: переводим папки на новое дерево - [$127762671]
//
// Revision 1.233  2009/04/16 12:46:09  oman
// - new: В первом приближении переводим папки на новое дерево - [$127762671]
//
// Revision 1.232  2009/04/16 07:39:46  oman
// - new: Готовимся к переделке прав на папки - [$127762671]
//
// Revision 1.231  2009/04/14 09:20:44  oman
// - new: Готовимся к пользованию другим деревом - [$140280776]
//
// Revision 1.230  2009/03/24 12:49:37  oman
// - fix: Боремся с переходными процессами - [$139441554]
//
// Revision 1.229  2009/02/20 16:45:30  lulin
// - <K>: 136941122.
//
// Revision 1.228  2009/02/20 10:08:31  lulin
// - чистка комментариев.
//
// Revision 1.227  2009/02/10 19:03:26  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.226  2009/02/10 16:50:28  lulin
// - <K>: 133891247. Переносим интерфейсы папок.
//
// Revision 1.225  2009/02/10 13:34:37  lulin
// - <K>: 133891247. Выделяем интерфейсы профайлеров.
//
// Revision 1.224  2009/02/09 13:21:17  lulin
// - <K>: 133891247.
//
// Revision 1.223  2009/01/21 08:09:07  oman
// - fix: Забыли про инфарм (К-133892891)
//
// Revision 1.222  2009/01/20 11:38:30  oman
// - fix: Пытаемся грузить фильтры асинхронно сразу после папок (К-133892891)
//
// Revision 1.221  2009/01/20 11:26:01  oman
// - fix: Пытаемся грузить фильтры асинхронно сразу после папок (К-133892891)
//
// Revision 1.220  2009/01/11 10:08:50  oman
// - fix: Нотифицируем фильтры только если они созданы (К-132222088)
//
// Revision 1.219  2009/01/11 09:45:18  oman
// - fix: Чистим журнал позже (К-132222088)
//
// Revision 1.218  2008/12/25 12:19:57  lulin
// - <K>: 121153186.
//
// Revision 1.217  2008/11/05 16:26:37  lulin
// - <K>: 121167571.
//
// Revision 1.216  2008/11/05 14:36:29  lulin
// - <K>: 121164251.
//
// Revision 1.215  2008/08/26 13:43:09  oman
// - fix: Излишне вычитывали папки
//
// Revision 1.214  2008/07/18 17:15:31  mmorozov
// - bugfix:  Не сразу меняется имя документа на вкладке "на контроле"  (K<99647730>);
//
// Revision 1.213  2008/07/04 12:36:08  lulin
// - чистка кода по ходу выполнения <K>: 98337580.
//
// Revision 1.212  2008/05/07 16:17:20  mmorozov
// new: постоянные фильтры;
//
// Revision 1.211  2008/04/16 10:52:07  oman
// - fix: Не ожидали nil (cq28883)
//
// Revision 1.210  2008/04/16 07:50:36  mmorozov
// - new: созданы отдельные деревья фильтров для документа и препарата (K<89102296>).
//
// Revision 1.209  2008/04/04 12:58:13  oman
// - new: Документ-препарат - Пишем в журнал (cq28562)
//
// Revision 1.208  2008/03/19 11:45:56  oman
// Опечатка
//
// Revision 1.207  2008/03/12 11:32:41  oman
// - new: Заготовки для ПЛП - пишем в журнал работы
//
// Revision 1.206  2008/02/12 14:39:53  lulin
// - методы для чтения списка переехали на примесь.
//
// Revision 1.205  2008/01/14 13:06:57  mmorozov
// - new: запись терминов толкового словаря в журнал (CQ: OIT5-13341);
//
// Revision 1.204  2008/01/10 07:23:37  oman
// Переход на новый адаптер
//
// Revision 1.203  2008/01/09 09:57:47  mmorozov
// - new: скрываем вкладку "Доступ", если для объекта нельзя настроить общий доступ (CQ: OIT5-26952);
//
// Revision 1.202  2007/12/25 23:54:29  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.199.4.7  2007/12/20 14:06:18  oman
// - fix: Адекватней заполняем список прав.
//
// Revision 1.199.4.6  2007/12/20 11:26:23  oman
// - fix: Адекватней заполняем список прав.
//
// Revision 1.199.4.5  2007/12/11 09:32:20  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.199.4.4  2007/12/04 08:57:54  oman
// - new: Порядок создания папок в журнале (cq27781)
//
// Revision 1.199.4.3  2007/11/27 08:41:42  oman
// Перепиливаем на новый адаптер - фабрики контейнеров
//
// Revision 1.199.4.2  2007/11/26 09:04:05  oman
// Перепиливаем на новый адаптер
//
// Revision 1.199.4.1  2007/11/22 10:50:18  oman
// Перепиливаем на новый адаптер
//
// Revision 1.201  2007/12/10 12:51:14  mmorozov
// - new: реализуем шаблон publisher\subscriber при редактировании настроек, замены настроек (переключения конфигураций), настройке панелей инструментов (в рамках CQ: OIT5-27823);
//
// Revision 1.200  2007/12/04 08:59:40  oman
// - new: Порядок создания папок в журнале (cq27781)
//
// Revision 1.199  2007/09/17 09:43:47  oman
// - fix: Для удаления закладки не создаем сборку папок.
//  НО пользуемся ей, если она уже есть (cq26693)
//
// Revision 1.198  2007/08/14 14:29:52  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.197  2007/07/13 11:35:02  oman
// - fix: Не позиционировались на папке с ответами (cq25649)
//
// Revision 1.196  2007/06/18 10:52:46  lulin
// - cleanup.
//
// Revision 1.195  2007/05/23 10:40:16  oman
// - new: Новый тип запросов "Базовый поиск" (cq25374)
//
// Revision 1.194  2007/04/12 13:30:24  oman
// - new: более наглядная индикация полученного ответа по
//  линии Правового консалтинга (cq24493)
//
// Revision 1.193  2007/03/29 17:27:07  lulin
// - даем компонентам правильные названия.
//
// Revision 1.192  2007/03/29 17:02:33  lulin
// - отделяем мух от котлет.
//
// Revision 1.191  2007/03/21 07:44:35  lulin
// - выделяем из ЭлПака, только то, что мы реально используем.
//
// Revision 1.190  2007/03/20 11:38:10  lulin
// - не теряем кодировку при присваивании заголовков форм и контролов.
//
// Revision 1.189  2007/03/16 16:57:04  lulin
// - избавляемся от излишнего копирования и преобразования строк.
//
// Revision 1.188  2007/03/13 12:00:08  lulin
// - cleanup.
//
// Revision 1.187  2007/02/28 16:19:31  demon
// - new: при создании папки можно явно указать элемент перед которым ее создавать
//
// Revision 1.186  2007/02/27 14:14:56  lulin
// - для привязывания сущности к контролу используем ее идентификатор, а не имя.
//
// Revision 1.185  2007/02/27 12:03:42  lulin
// - cleanup.
//
// Revision 1.184  2007/02/27 10:32:36  lulin
// - cleanup.
//
// Revision 1.183  2007/02/27 09:17:53  lulin
// - используем более простые ноды при работе с папками.
//
// Revision 1.182  2007/02/13 14:33:19  lulin
// - cleanup.
//
// Revision 1.181  2007/02/12 18:55:45  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.180  2007/02/12 18:44:42  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.179  2007/02/09 12:37:45  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.178  2007/02/08 17:43:07  demon
// - fix: методы _ReloadChildren перенесены на объект TnsFoldersTree (используя интерфейс _InsReloadedTree)
//
// Revision 1.177  2007/02/07 14:30:41  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.176  2007/01/20 15:30:21  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.175  2007/01/18 11:48:11  oman
// - fix: Более правильно спрашиваем о создании папки в журнале (cq24155)
//
// Revision 1.174  2007/01/16 11:17:15  lulin
// - поправлена опечатка в названии метода.
//
// Revision 1.173  2007/01/16 10:24:39  lulin
// - убрана ненужная внутренняя операция - удаления закладки.
//
// Revision 1.172  2007/01/15 19:22:39  lulin
// - избавился от внутренней операции модуля - по получению списка фильтров. Заодним почистил вылезшие преобразования от одного интерфейса к другому.
//
// Revision 1.171  2006/12/27 16:18:06  lulin
// - cleanup.
//
// Revision 1.170  2006/12/22 15:06:26  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.169  2006/12/07 14:18:08  mmorozov
// - new: используем единые настройки для компонента с вкладками (CQ: OIT5-23819);
//
// Revision 1.168  2006/11/03 09:45:50  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.167.2.2  2006/10/23 08:36:23  oman
// - new: Отложенная загрузка фильтров (cq23125)
//
// Revision 1.167.2.1  2006/10/13 14:13:32  mmorozov
// - bugfix: при каждом получении Root`а дерево документов на контроле  пересортировывалось по признаку "измененности", теперь сортируем один раз при построении дерева (CQ: OIT5-17550);
//
// Revision 1.167  2006/10/06 08:28:35  oman
// - fix: FoldersTree.Tree отдает уже загруженные папки
// - new: Появился FoldersTree.AsyncTree - который инициирует
//  загрузку и отваливается, для присвоения в дерево папок (cq22889)
//
// Revision 1.166  2006/10/03 15:09:12  demon
// - fix: папки грузятся в отдельной триаде и оттуда же вызывалась прорисовка. Было зависание.
//
// Revision 1.165  2006/09/25 13:00:49  mmorozov
// - new behaviour: фильтруем все папки кроме "Мои документы" при сохранении/открытии объектов из моих документов;
// - new behaviour: папка "Мои документы" не скрывается при фильтрации по типу объекта;
// - _move: интерфейсы перенесены в модуль _nsInterfaces;
//
// Revision 1.164  2006/05/22 10:15:09  dinishev
// Cleanup
//
// Revision 1.163  2006/05/05 14:54:58  mmorozov
// - change: обобщен код открытие журнала работы по позиционированию на узле в папках (подготовка почвы для открытия моих консультаций);
//
// Revision 1.162  2006/04/21 06:53:24  dinishev
// New type: TEffectiveWorkJournalObject.
//
// Revision 1.161  2006/04/19 13:34:25  oman
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.160  2006/04/18 08:53:40  mmorozov
// - new: оценка консультации;
// - new: менеджер ссылок (bsHyperlinkManager);
// - warnings fix;
//
// Revision 1.159  2006/04/04 14:15:42  dinishev
// Не показываем КЗ для машины Доброва в коммерческой версии
//
// Revision 1.158  2006/03/20 15:31:20  dinishev
// Поддержка нового типа записи в журнал
//
// Revision 1.157  2006/03/20 12:30:44  oman
// - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)
//
// Revision 1.156  2005/11/29 14:11:22  oman
// - fix: При первом переключении на закладку прав, поднимался признак Modified
//
// Revision 1.155  2005/11/25 13:50:55  demon
// - new behavior: в журнале создаем папки только для тех поисков, атрибуты которых реально есть в базе
//
// Revision 1.154  2005/11/22 13:33:05  oman
// - fix: Дерево пользователей теперь запрашивается с сервера при первом показе закладки прав
//
// Revision 1.153  2005/11/21 16:53:06  lulin
// - cleanup.
//
// Revision 1.152  2005/11/18 14:36:26  oman
// - new behavior: перевод назначения прав ользователя на папки на новое дерево
//
// Revision 1.151  2005/10/28 06:09:50  lulin
// - заплатка для возможности работы при падении при записи в журнал.
//
// Revision 1.150  2005/10/21 09:09:57  demon
// - fix: ошибка получения списка фильтров при работе под ADMIN
//
// Revision 1.149  2005/10/20 15:36:18  demon
// - new behavior: при постановке на контроль из папок всегда ставим документ, а не папочную ноду
//
// Revision 1.148  2005/09/27 11:56:55  demon
// - fix: не сохранялись запросы в историю
//
// Revision 1.147  2005/09/09 08:07:25  demon
// - fix: переименовал Аналитический обор в журналах
//
// Revision 1.146  2005/08/29 16:09:12  demon
// - new behavior: Операция Open на ноде теперь возвращает IUnknown
//
// Revision 1.145  2005/08/29 09:40:19  demon
// - fix: не правильно удалялся элемент из дерева на контроле при приходе нотификации из папок
//
// Revision 1.144  2005/08/26 14:04:37  demon
// - new behavior: восстановлена нотификация об изменении списка объектов на контроле. Она все еще нужна
//
// Revision 1.143  2005/08/25 12:51:55  demon
// - new behavior: Документы на контроле теперь не зависят от папок (код пока заремлен)
//
// Revision 1.142  2005/08/24 17:03:53  demon
// - new behavior: изменен принцип обмена данными с деревом пользователей
//
// Revision 1.141  2005/06/28 12:59:27  demon
// - fix: после обновления не пересортировывался список документов на контроле.
//
// Revision 1.140  2005/06/02 07:35:32  mmorozov
// change: StatesTree -> vtStatesTree;
//
// Revision 1.139  2005/05/11 08:42:01  demon
// - fix: папка "Обзор законодательства" в журналах переименована в "Аналитические обзоры"
//
// Revision 1.138  2005/04/12 10:27:09  demon
// - new behavior: создаем вложенные в текущую дату журнала папки в обратном порядке для правильной работы сортировки на сервере.
//
// Revision 1.137  2005/03/30 09:22:26  mmorozov
// change: TFocusLabel -> _TssFocusLabel;
//
// Revision 1.136  2005/03/04 15:33:21  dinishev
// Директива Monitorings для уменшения количества подключаемых модулей
//
// Revision 1.135  2005/03/03 16:41:28  demon
// - new behavior: новый тип запроса для сохранения в журнал wjoPublishSourceSearch
//
// Revision 1.134  2005/02/01 12:57:22  mmorozov
// change: FreeAndNil -> vcmFree;
//
// Revision 1.133  2005/02/01 11:30:08  demon
// - new behavior: формат папки журнала не зависит от системных установок - dd.mm.yyyy
//
// Revision 1.132  2005/01/26 16:24:15  demon
// - fix: получаем Entity после override через Open, иначе она не правильная
//
// Revision 1.131  2005/01/26 13:53:06  demon
// - new behavior: нотификация об изменении закладок в журнале для кэша документов
//
// Revision 1.130  2005/01/18 14:59:23  mmorozov
// new: синхронизация с основным при удалении элементов журнала из моих документов;
//
// Revision 1.129  2005/01/18 14:51:20  demon
// - new behavior: разнесены нотификации об изменении и удалении нод из папок
//
// Revision 1.128  2005/01/13 11:39:57  demon
// - fix: AV при попытке постановки на контроль
//
// Revision 1.127  2004/12/27 11:21:37  lulin
// - убраны Warning'и.
//
// Revision 1.126  2004/12/27 11:00:30  demon
// - new behavior: изменены названия папок для журнала работы
//
// Revision 1.125  2004/12/22 13:32:57  demon
// - new behavior: изменена семантика метода ChangeFilterStatus
//
// Revision 1.124  2004/12/21 17:05:17  demon
// - new behavior: Рассылка сообщения об изменении Глобальных фильтров
//
// Revision 1.123  2004/12/21 13:31:54  demon
// - new behavior: property CurentHistoryFolder получило свой read method
//
// Revision 1.122  2004/12/16 13:28:40  demon
// - fix: не правильно отображались глобальные фильтры при хождении по истории.
//
// Revision 1.121  2004/12/15 15:18:11  demon
// - new behavior: начальная загрузка Глобальных фильтров
//
// Revision 1.120  2004/12/15 11:27:30  demon
// - new behavior: нотификация об изменении документов на контроле переделана на новый механизм.
//
// Revision 1.119  2004/12/10 16:35:02  demon
// - new behavior: новый вариант нотификации об изменении объектов в папках (еще не до конца доделан)
//
// Revision 1.118  2004/12/08 13:26:45  demon
// - new behavior: флаг принадлежности к фильтрам у запроса стал перечислимым (TFilterType).
//
// Revision 1.117  2004/12/08 11:30:22  demon
// - new behavior: overload method _ReloadChildren
//
// Revision 1.116  2004/12/08 11:11:18  demon
// - new behavior: Заготовка для отображения глобальных фильтров + D'n'D
//
// Revision 1.115  2004/11/25 15:12:00  demon
// - new behavior: операция "Очистить Журнал работы"
//
// Revision 1.114  2004/11/25 13:45:04  demon
// - new behavior: при создании папки с датой для журнала сразу создаем и вложенные по типам
//
// Revision 1.113  2004/11/24 18:30:33  demon
// - new behavior: Перезапись одинаковых элементов журнала (Документов)
//
// Revision 1.112  2004/11/23 14:14:18  demon
// - new behavior: в операции создания папки можно задавать комментарий
//
// Revision 1.111  2004/11/23 09:23:16  demon
// - new behavior: Операции для работы с журналом (SaveToJournal...)
//
// Revision 1.110  2004/10/28 14:55:38  demon
// - new behavior: обработано исключение ECanNotFindData при вызове .Open на Node, т.к. оно легально может возникать при работе с общими папками.
//
// Revision 1.109  2004/10/14 16:23:25  demon
// - new behavior: операции открытия елемента папок перенесены в nsOpenUtils
//
// Revision 1.108  2004/10/09 10:20:33  mmorozov
// new: method CheckFlag(overload);
// new: method CheckObjectType;
// bugfix: для объекта внешней папки не показывался текущий пользователь;
//
// Revision 1.107  2004/10/01 13:32:50  mmorozov
// new: используем UserList.IsChangeRights;
//
// Revision 1.106  2004/09/30 13:11:45  fireton
// - change: переплавка TElURLLabel на _TssFocusLabel (для фокуса)
//
// Revision 1.105  2004/09/23 15:03:17  demon
// - new behavior: в заголовке слово "элемент" заменено на слово "объект"
//
// Revision 1.104  2004/09/17 14:28:51  lulin
// - убрал лишнюю раннюю инициализацию.
//
// Revision 1.103  2004/09/16 12:38:48  demon
// - new behavior: если ни один документ не стоит на контроле - выводим элемент-заглушку...
//
// Revision 1.102  2004/09/15 10:52:41  demon
// - new behavior: изменен заголовок раздела свойства окна выбора из Моих документов (на Выбранный элемент)
//
// Revision 1.101  2004/09/15 08:28:35  mmorozov
// new: переходим на использование _TvcmObjectRefList;
//
// Revision 1.100  2004/09/14 12:03:32  mmorozov
// new: множественные строки ввода выделены в модуль nsMultiFields, многие классы переименованы, чистка кода;
//
// Revision 1.99  2004/09/07 16:22:12  law
// - перевел Nemesis на кешированные обьекты.
//
// Revision 1.98  2004/08/19 04:15:21  mmorozov
// - избавляемся от мерцания при загрузке пользователей;
//
// Revision 1.97  2004/08/16 05:24:23  mmorozov
// fix: warnings;
//
// Revision 1.96  2004/08/09 05:19:36  mmorozov
// new: блокировка отрисовки и размещения при выборе пользователей из дерева;
//
// Revision 1.95  2004/08/06 14:04:10  mmorozov
// change: "выключен" показ контекстного меню у гиперссылки "Для кого";
//
// Revision 1.94  2004/08/05 13:06:46  demon
// - cleanup: remove warnings and hints
//
// Revision 1.93  2004/07/16 04:58:19  mmorozov
// new behaviour: при установке галки "Общий доступ" подставляется группа "Все" если список прав пустой (присутствует только владелец);
//
// Revision 1.92  2004/07/14 16:04:26  demon
// - new _module: nsOpenUtils - операции для быстрого открытия документов, списков, запросов по _IBaseEntity
//
// Revision 1.91  2004/07/05 08:08:22  demon
// - new const: названия контейнера "Свойства папок"
//
// Revision 1.90  2004/06/29 06:49:11  mmorozov
// new: type TFolderElementTabSheet;
//
// Revision 1.89  2004/06/29 06:31:18  mmorozov
// bugfix: для external папок права не устанавливаются;
//
// Revision 1.88  2004/06/18 09:06:12  mmorozov
// new: глобальная процедура SharedFolder;
//
// Revision 1.87  2004/05/26 16:59:44  law
// - new behavior: TvtCustomOutliner теперь знает только про интерфейсы Il3SimpleTree и Il3Tree, а не про объект _Tl3Tree.
//
// Revision 1.86  2004/05/25 12:40:43  mmorozov
// new: methods TFolderSecurite.OnDuplicateValue;
// new behaviour: при дублировании пользователей выводим сообщение и очищаем поле;
//
// Revision 1.85  2004/05/25 11:09:41  mmorozov
// change: LockedAdd устанавливается после загрузки списка пользователей;
//
// Revision 1.84  2004/05/13 08:17:20  demon
// - fix: AV при просмотре "Доступа" к предустановленным фильтрам.
//
// Revision 1.83  2004/05/07 13:18:29  mmorozov
// bugfix: работа с доступом к папкам;
//
// Revision 1.82  2004/05/07 09:50:25  mmorozov
// bugfix: не устанавливаем ограничения на редактирование списка пользователей при выбранной группе "Все", если нет прав на редактирование доступа;
//
// Revision 1.81  2004/05/06 11:21:31  mmorozov
// new: изменения связанные с выбором группы "Все" в списке пользователей (ЕСЛИ выбрана группа "Все" с правом чтение, то доступными остаются пользовати с правами запись/чтение, кроме того можно добавлять пользователей только с правами запись/чтение; ЕСЛИ выбрана группа "Все" с правами запись/чтение, то все пользователи устанавливаются не доступными для редактирования и нельзя добавить новое поле; ПРИ сохранении все недоступные пользователи удаляются;
//
// Revision 1.80  2004/05/05 10:27:12  mmorozov
// new: при поиске пользователя в дереве для сравнения нод вместо IsSameNode используем идентификаторы пользователей;
//
// Revision 1.79  2004/04/30 08:24:51  mmorozov
// new: используем TDataAdapter.CurrentUserID;
//
// Revision 1.78  2004/04/09 13:56:54  demon
// - new behavior: избавились от работы с машиной времени на Адаптере.
//
// Revision 1.77  2004/04/01 15:40:43  demon
// - new behavior: оптимизация открытия документов (теперь в случае наличия открытого документа у него только перегружается контент)
//
// Revision 1.76  2004/03/31 07:04:22  mmorozov
// bugfix: при удалении всех пользователей с снятие галки общий доступ, при последующем открытии появлялись удаленные пользователи;
//
// Revision 1.75  2004/03/30 10:52:07  mmorozov
// no message
//
// Revision 1.74  2004/03/29 14:37:45  demon
// - new behavior: Выключение машины времени при открытии новых документов не переходом по ссылкам.
//
// Revision 1.73  2004/03/29 08:56:53  mmorozov
// new: methods TFolderSecurity (CheckFlag, CheckShared);
// new: если пользователь сохраняет общий доступ с пустым списком пользователей, то общий доступ автоматически снимается;
//
// Revision 1.72  2004/03/29 05:43:28  mmorozov
// bugfix: установка прав для первого пользователя;
// new: если общий доступ не установлен, то не показываем пользователей;
// new: если все пользователи удалены и установлен общий доступ, то при переключинии на закладку свойства, автоматический снимаем общий доступ;
//
// Revision 1.71  2004/03/25 11:37:31  mmorozov
// new: method TListOfMgrs._IsSet;
//
// Revision 1.70  2004/03/25 06:11:11  mmorozov
// bugfix: если редактировались права не шареной папки, то при установки галки "Открыть общий доступ", редактирования списка прав и снятия галки, кнопка Ok была доступна;
// bugfix: сохранения прав для пустого поля ввода;
//
// Revision 1.69  2004/03/20 16:21:10  mmorozov
// bugfix: отображался текущий пользователь при переходе с папки с внешней папки на внутреннюю;
//
// Revision 1.68  2004/03/17 15:54:09  nikitin75
// _TCheckBox -> TeeCheckBox
//
// Revision 1.67  2004/03/10 07:31:31  am
// change: "Закладка" -> "Документ, на который указывает закладка"
//
// Revision 1.66  2004/03/10 07:17:25  demon
// - fix: сообщение об отсутствующем документе
//
// Revision 1.65  2004/03/09 14:35:11  mmorozov
// bugfix;
//
// Revision 1.64  2004/03/05 14:42:43  mmorozov
// - установка прав по новому;
//
// Revision 1.63  2004/03/03 18:05:08  law
// - rename unit: l3Tree2 -> l3Tree.
//
// Revision 1.62  2004/03/03 15:35:29  mmorozov
// new: с компонентами множественных строкам может быть связано несколько сущностей с операциями;
//
// Revision 1.61  2004/03/02 11:16:48  mmorozov
// new: показываем текущего пользователя в списке пользователей для внешних папок;
//
// Revision 1.60  2004/03/02 10:25:57  demon
// - fix: проверка прав для фильтров не работала
//
// Revision 1.59  2004/03/01 15:44:12  mmorozov
// new: по умолчанию на вклдаке "Доступ" ничего не доступно;
//
// Revision 1.58  2004/02/25 14:21:16  mmorozov
// bugfix;
//
// Revision 1.57  2004/02/25 10:29:08  mmorozov
// new: при перезагрузке списка пользователей используем уже созданные строки ввода;
//
// Revision 1.56  2004/02/25 09:17:32  mmorozov
// bugfix;
//
// Revision 1.55  2004/02/25 09:00:46  mmorozov
// new: курсор часов во время загрузки;
//
// Revision 1.54  2004/02/25 06:03:42  mmorozov
// new: получаем текущего пользователя при первой необходимости;
// new: не отображаем текущего пользователя в списке пользователей;
//
// Revision 1.53  2004/02/24 16:41:06  mmorozov
// new: читаем список пользователей и права только если вкладка "доступ" активна или если пользватель ее активировал;
// new: TFoderSecurity знает о закладках;
// new: отображаем права пользователя;
// new: не показываем пользователя если список прав пустой;
//
// Revision 1.52  2004/02/20 15:17:34  mmorozov
// new: после рашраривания папки перичитываем IFolder;
//
// Revision 1.51  2004/02/20 13:42:34  mmorozov
// new: property TFolderSecurity.UserRightsList;
// new: при сохранении доступа к папке учитываются удаленные пользователи;
// new: при изменении списка пользователей перечитываем кеши;
//
// Revision 1.50  2004/02/20 10:13:54  demon
// - new behavior: функция _Refresh получила параметр (ноду для зануления заголовка)
//
// Revision 1.49  2004/02/19 13:35:23  mmorozov
// new: при изменении Shared вызываем DropUserRightsCache;
//
// Revision 1.48  2004/02/19 13:02:18  mmorozov
// - снят rem с функции загрузки списка пользователей;
//
// Revision 1.47  2004/02/19 12:59:32  demon
// - new behavior: при сбросе кэшированных прав они сбрасываются не только у детей, но и у родителей
//
// Revision 1.46  2004/02/19 11:48:32  mmorozov
// - рефакторинг;
//
// Revision 1.45  2004/02/19 08:34:32  mmorozov
// - вынесена функциональность из enFoldersElementInfoForm;
//
// Revision 1.44  2004/02/18 18:47:55  cyberz
// many fixes and refactoring for Security
//
// Revision 1.43  2004/02/18 15:03:51  mmorozov
// new: method TFolderSecurity.SetState (при изменении Share папки нужно изменить состояние комонентов);
//
// Revision 1.42  2004/02/18 14:14:44  nikitin75
// fix: если папки загрузить не удалось, убираем ноду "Загрузка папок...";
//
// Revision 1.41  2004/02/18 14:00:38  mmorozov
// new: property TFolderSecurity.Root;
//
// Revision 1.40  2004/02/18 12:44:18  mmorozov
// bugfix;
//
// Revision 1.39  2004/02/18 12:25:07  mmorozov
// new: если флаг "Открыть общий доступ" не установлен, то у компонентов закладки Enabled = False;
//
// Revision 1.38  2004/02/18 10:58:28  demon
// - new: сброс кэширования списка пользователей DropUserRightsCache
//
// Revision 1.37  2004/02/18 08:52:38  mmorozov
// bugfix: определение флага изменений;
//
// Revision 1.36  2004/02/17 15:59:52  mmorozov
// - чтение прав по новому;
//
// Revision 1.35  2004/02/17 15:44:21  mmorozov
// - temp commit;
//
// Revision 1.34  2004/02/17 15:27:52  mmorozov
// new: установка, чтение прав пользователей для папки;
//
// Revision 1.33  2004/02/17 13:01:30  demon
// - new: операции для реализации обновления структуры папок
//
// Revision 1.32  2004/02/17 12:48:20  mmorozov
// new: реализация контекстных операций;
//
// Revision 1.31  2004/02/16 16:18:36  mmorozov
// new: загрузка прав для папки и управление элементами управления вкладки "Доступ";
//
// Revision 1.30  2004/02/16 14:11:02  demon
// - new: операция проверки прав на для IeeNode (если она из папок)
//
// Revision 1.29  2004/02/16 12:19:16  mmorozov
// new: TFolderSecurity.GetUsers;
//
// Revision 1.28  2004/02/13 16:53:57  mmorozov
// new: получаем список пользователей в виде IstSetNodes и загружаем его;
//
// Revision 1.27  2004/02/13 10:43:07  demon
// - new: обновление дерева папок при постановке документа на контроль (из документа)
//
// Revision 1.26  2004/02/12 14:32:45  mmorozov
// new: TFolderSecurity.OnShowUsers;
//
// Revision 1.25  2004/02/12 14:16:33  demon
// - new: _operation OpenControllableElement
//
// Revision 1.24  2004/02/12 13:20:48  mmorozov
// - добавлен класс TFolderSecurity;
//
// Revision 1.23  2004/02/11 15:51:24  demon
// - new behavior: возможность взведения флага IsOpened для документов на контроле
// - new behavior: возможность сброся статуса "изменен" для  документов на контроле, просмотренных за сеанс
//
// Revision 1.22  2004/02/11 13:44:45  demon
// - new: интерфейс для синхронизации со списком "на контроле" _InsControlledList
// - syntax fix
// - logic fix: в связи с изменениями интерфейсов сервера
//
// Revision 1.21  2004/02/05 13:05:12  demon
// - fix: операция OpenElemet стала использовать интерфейс IvcmUserInteraction
//
// Revision 1.20  2004/02/05 12:46:25  demon
// - new behavior: операция OpenElemet и ее части перенесены в модуль nsFolders
//
// Revision 1.19  2004/02/05 08:43:09  demon
// - new behavior: при загрузке списка на контроле его элементы по умолчанию сортируются по статусу изменений.
//
// Revision 1.18  2004/02/03 13:42:32  demon
// - new: реализация поддержки синхронизации папок и списка документов на контроле (при удалении из папок, и изменении статуса)
//
// Revision 1.17  2004/02/02 13:35:36  demon
// - new: реализация загрузки и добавления "документов на контроле" в дерево (с использованием интерфейсов адаптера)
//
// Revision 1.16  2004/01/30 18:27:22  demon
// - new behavior: фильтры теперь сортируются по алфавиту.
//
// Revision 1.15  2004/01/16 15:10:39  nikitin75
// отложенная загрузка папок
// + переход с TThread на Тl3ThreadContainer;
// + время жизни WaitThread вложено во время жизни FoldersTree;
//
// Revision 1.14  2004/01/16 11:54:12  nikitin75
// + пока не приехали папки, показываем ноду "Загрузка папок...";
//
// Revision 1.13  2004/01/16 09:41:39  nikitin75
// отложенная загрузка папок (some fix);
//
// Revision 1.12  2004/01/15 13:42:07  nikitin75
// + отложенная загрузка папок (в отдельной нити; первое приближение);
//
// Revision 1.11  2004/01/15 08:50:07  demon
// - new behavior: объект TFoldersTree теперь содержит ссылку не на Root папок, а на дерево папок (_Tl3Tree).
//
// Revision 1.10  2003/10/30 14:14:19  demon
// - new behavior: сохраняем последние папки, куда производилось сохранение.
//
// Revision 1.9  2003/09/02 17:57:12  demon
// - add: операции удаления элемента и изменения статуса запроса вынесены на интерфейс дерева (для стандартизации операций из формы Фильтры).
//
// Revision 1.8  2003/08/21 11:17:05  demon
// - new: при удалении фильтров они проверяются на использование.
//
// Revision 1.7  2003/08/20 15:59:27  demon
// - new: переделана структура и взаимосвязи дерева папок и дерева фильтров.
//
// Revision 1.6  2003/08/20 11:25:01  demon
// - new: создана рутовая нода для папок с возможностью хранения дополнительной информации.
//
// Revision 1.5  2003/08/15 09:49:50  demon
// - new: Дерево текущих фильтров
//
// Revision 1.4  2003/08/08 13:20:53  demon
// - new: Включена загрузка настоящего дерева папок.
//
// Revision 1.3  2003/08/07 17:16:48  demon
// - new: Включено создание пустого дерева.
//
// Revision 1.2  2003/08/06 16:36:19  demon
// - new: объект для загрузки и последующего доступа к дереву папок
//
// Revision 1.1  2003/08/06 15:29:03  demon
// - new: системный модуль для поддержки дерева папок.
//

interface

uses
  Classes,
  Controls,
  StdCtrls,
  Forms,

  l3Interfaces,
  l3Base,
  l3Tree,
  l3Tree_TLB,
  l3TreeInterfaces,

  vcmExternalInterfaces,
  vcmBase,
  vcmInterfaces,
  vcmForm,
  vcmEntities,

  eeInterfaces,
  vtCheckBox,

  BaseTreeSupportUnit,
  FiltersUnit,
  FoldersUnit,
  SecurityUnit,
  UnderControlUnit,

  StdRes,

  bsTypes,

  nsTypes,
  nsFolderNodes,

  FoldersDomainInterfaces,

  nevTools,
  F1TagDataProviderInterface
  ;

type
  TFoldersTree = class(TvcmCacheableBase, InsFolderNodeNotifyObject)
  private
    f_Tree                     : Il3Tree;
    f_ControlledObj            : InsChildTree;
    f_LastQuerySaved           : IeeNode;
    f_LastListSaved            : IeeNode;
    f_LastBookmarkSaved        : IeeNode;
    f_ConsultationsFolder      : Il3Node;
    f_ConsultationAnswerFolder : Il3Node;
    f_ConsultationSentFolder   : Il3Node;
      {* - журнал очищается. }
  private
  // internal methods
    procedure NodeChanged(const aNode: INode; anEvent: TFoldersNodeChangeEvent);
      {-}
    procedure NodeBeforeDelete(const aNode: INode; anEvent: TFoldersNodeDeleteEvent);
      {-}
    procedure NodeDeleted(aFlags: LongInt; aNodeType: TFoldersItemType);
      {-}
    function FindNodeByFlag(const aFlag: LongWord; const aInRoot: Il3Node = nil): Il3Node;
      {* - поиск узла по флагу, из состава лежащих в корне. }
  private
  // property methods
    function pm_GetConsultationsFolder: Il3Node;
      {* - узел консультаций. }
    function pm_GetConsultationAnswerFolder: Il3Node;
      {-}
    function pm_GetConsultationSentFolder: Il3Node;
      {-}
    function  pm_GetFoldersTree: Il3Tree;
      {-}
    function  pm_GetAsyncTree: Il3Tree;
      {-}
    function  pm_GetControlledObj: InsChildTree;
      {-}
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
  public
  // public methods
    function  CreateFolder(const aName         : Il3CString;
                           const aParentFolder : Il3Node;
                           const aComment      : Il3CString = nil;
                           const aBeforeNode   : Il3Node = nil): Il3Node;
      {-}
    procedure Delete(const aNode : INode);
      {-}
    procedure DropUserRightsCache(const aNode : INode);
      {-}
    procedure Refresh(const aNode : INode = nil);
      {-}
  public
  // public methods
    property QuerySavedFolder: IeeNode
      read f_LastQuerySaved
      write f_LastQuerySaved;
      {-}
    property ListSavedFolder: IeeNode
      read f_LastListSaved
      write f_LastListSaved;
      {-}
    property BookmarkSavedFolder: IeeNode
      read f_LastBookmarkSaved
      write f_LastBookmarkSaved;
      {-}
    property ConsultationsFolder: Il3Node
      read pm_GetConsultationsFolder;
      {* - узел консультаций. }
    property ConsultationAnswerFolder: Il3Node
      read pm_GetConsultationAnswerFolder;
      {* - узел ответов на консультации. }
    property ConsultationSentFolder: Il3Node
      read pm_GetConsultationSentFolder;
      {* - узел запросов на оплату. }
    property Tree: Il3Tree
      read pm_GetFoldersTree;
      {-}
    property ControlledObj: InsChildTree
      read pm_GetControlledObj;
      {-}
    property AsyncTree: Il3Tree
      read pm_GetAsyncTree;
      {-}
  end;//TFoldersTree

 {$If not (defined(Monitorings) or defined(Admin))}

  TFolderSecurity = class(TvcmCacheableBase)
  {* - класс для управления доступа к папке. }
  private
  // inhernal fields
    f_cbShared         : TvtCheckBox;
    f_Folder           : IFolder;
    f_SelectedNode     : IeeNode;
    f_CanChangeRights  : Boolean;
    f_Shared           : Boolean;
  private
  // public methods
    procedure pm_SetCanChangeRights(const aValue: Boolean);
      {-}
    procedure pm_SetEeFolder(const aValue: IeeNode);
      {-}
    procedure pm_SetFolder(const aValue: IFolder);
      {-}
    procedure pm_SetModified(const aValue: Boolean);
      {-}
    procedure pm_SetShared(const aValue: Boolean);
      {-}
  private
  // internal methods
    function pm_GetModified: Boolean;
      {* - определяет редактировал ли пользователь информацию. }
    function CheckFlag(aFlag : Integer) : Boolean;
      overload;
      {* - проверяет у папки указанный флаг. }
    function CheckFlag(const aeeNode : IeeNode;
                       aFlag         : Integer) : Boolean;
      overload;
      {* - проверяет у папки указанный флаг. }
    function CheckObjectType(aItemType : TFoldersItemType) : Boolean;
      {* - проверяет тип объекта выбранный в дереве. }
    procedure OnSharedChaged(Sender : TObject);
      {-}
    function IsExternal: Boolean;
      {-}
  protected
    procedure Cleanup;
      override;
      {-}
  public
  // public methods
    constructor Create(acbShare: TvtCheckBox);
      reintroduce;
      {-}
    procedure Clear; 
      {-}
    function IsShareChanged: Boolean;
      {-}
    function Save : Boolean;
      {-}
    procedure SetState;
      {-}
    procedure ShareChanged;
      {* - пользователь открыл общий доступ используя контекстную операцию в дереве папок. }
  public
  // public properties
    property Modified : Boolean
      read pm_GetModified
      write pm_SetModified;
      {-}
    property Folder : IFolder
      read f_Folder
      write pm_SetFolder;
      {-}
    property eeFolder : IeeNode
      read f_SelectedNode
      write pm_SetEeFolder;
      {-}
    property CanChangeRights : Boolean
      read f_CanChangeRights
      write pm_SetCanChangeRights;
      {-}
    property Shared : Boolean
      read f_Shared
      write pm_SetShared;
      {-}
  end;//TFolderSecurity
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

function CheckFolderElementRights(const aNode : Il3SimpleNode;
                                  aAction     : TFoldersActions) : Boolean;
  overload;
  {-}
function CheckFolderElementRights(const aNode : IeeNode;
                                  aAction     : TFoldersActions) : Boolean;
  overload;
  {-}
function GetIFolderFromIeeNode(const aNode: IeeNode) : IFolder;
  {-}
{$If not (defined(Monitorings) or defined(Admin))}
procedure SharedFolder(const aFolder: IeeNode;
                       aShared: Boolean);
  {* - устанавливает или снимает доступ к папке. При установке доступа, если
       в списке пользователей находится только владелец папки, то в список
       автоматически добавляется группа "все" с доступом читать. }
{$IfEnd not (defined(Monitorings) or defined(Admin))}
       
const
  cInfoCaptions: array [TFoldersInfoType] of PvcmStringID = (
   @str_Empty,
   @str_fiNewFolderCaption,
   @str_fiEditCaption,
   @str_fiLoadCaption,
   @str_fiSaveCaption,
   @str_fiSelectCaption
  );

function UserFoldersTree: TFoldersTree;
  {-}
function FoldersReaded: Boolean;
  {-}
function nsFindBookmarkInFolders(aBookmarkID         : Integer;
                                 var aNode           : IFoldersNode;
                                 var aFoldersControl : IvcmEntity;
                                 aCanCreate          : Boolean) : Boolean;
  {-}
function nsFindBookmarkForEditInFolders(aBookmarkID         : Integer;
                                 var aNode           : IFoldersNode;
                                 var aFoldersControl : IvcmEntity;
                                 aCanCreate          : Boolean;
                                 const aCont         : InevDocumentContainer) : Boolean;
  overload;
  {-}
function nsFindBookmarkForEditInFolders(aBookmarkID         : Integer;
                                 var aNode           : IFoldersNode;
                                 var aFoldersControl : IvcmEntity;
                                 aCanCreate          : Boolean;
                                 const anAdorn : InsDocumentAdornments) : Boolean;
  overload;
  {-}
function nsDeleteBookmark(anID : Integer; const aCont : InevDocumentContainer): TnsDeleteResult;
  overload;
  {-}
function nsDeleteBookmark(anID : Integer; const anAdorn : InsDocumentAdornments): TnsDeleteResult;
  overload;
  {-}

implementation

uses
  Graphics,
  SysUtils,
  Variants,

  DataAdapter,

  afwFacade,

  l3InterfacesMisc,
  l3Nodes,
  l3String,

  eeTreeMisc,

  BaseTypesUnit,
  DocumentUnit,

  nsTreeUtils,
  nsOpenUtils,
  nsNodes,
{$If not (defined(Monitorings) or defined(Admin))}
  nsUserNodes,
{$IfEnd not (defined(Monitorings) or defined(Admin))}
  nsConst,
  nsSettings,
  nsUnderControlRoot,
  nsUnderControlObjList,

  bsInterfaces,
  Folders_Strange_Controls,
  Base_Operations_Strange_Controls,

  vcmMessagesSupport
  ;

var
 g_UserFoldersTree : TFoldersTree = nil;

function UserFoldersTree: TFoldersTree;
begin
 if (g_UserFoldersTree = nil) then
  g_UserFoldersTree := TFoldersTree.Create;
 Result := g_UserFoldersTree;
end;

function FoldersReaded: Boolean;
begin
 Result := Assigned(g_UserFoldersTree);
end;

function nsFindBookmarkInFolders(aBookmarkID         : Integer;
                                 var aNode           : IFoldersNode;
                                 var aFoldersControl : IvcmEntity;
                                 aCanCreate          : Boolean) : Boolean;
  {-}
var
 l_Form : IvcmEntityForm;
begin
 Result := False;
 try
  DefDataAdapter.Folders.FindFolderNode(aBookmarkID, aNode);
  Result := True;
  l_Form := TdmStdRes.OpenFolders(nil, aCanCreate);
  if (l_Form <> nil) then
  begin
   UserFoldersTree.Tree;
   aFoldersControl := l_Form.Entity;
  end//l_Form <> nil
  else
   aFoldersControl := nil;
  Assert(not aCanCreate or Assigned(aFoldersControl));
 except
  on ECanNotFindData do ;
 end;//try..except
end;

function nsFindBookmarkForEditInFolders(aBookmarkID         : Integer;
                                        var aNode           : IFoldersNode;
                                        var aFoldersControl : IvcmEntity;
                                        aCanCreate          : Boolean;
                                        const aCont         : InevDocumentContainer) : Boolean;
  //overload;
  {-}
var
 l_A : InsDocumentAdornments;
begin
 if Supports(aCont, InsDocumentAdornments, l_A) then
  try
   Result := nsFindBookmarkForEditInFolders(aBookmarkID, aNode, aFoldersControl, aCanCreate, l_A);
  finally
   l_A := nil;
  end//try..finally
 else
  Result := false;
end;

function nsFindBookmarkForEditInFolders(aBookmarkID         : Integer;
                                        var aNode           : IFoldersNode;
                                        var aFoldersControl : IvcmEntity;
                                        aCanCreate          : Boolean;
                                        const anAdorn       : InsDocumentAdornments) : Boolean;
  //overload;
  {-}
var
 l_L     : IBookmarkList;
 l_EID   : Integer;
 l_Index : Integer;
 l_D     : TBookmark2;
begin
 l_L := anAdorn.Bookmarks;
 l_EID := 0;
 if (l_L <> nil) then
 begin
  for l_Index := 0 to Pred(l_L.Count) do
  begin
   l_L.pm_GetItem(l_Index, l_D);
   if (l_D.rParaID = aBookmarkID) then
   begin
    l_EID := l_D.rEid;
    break;
   end;//l_D.rParaID = anID
  end;//for l_Index
  if (l_EID = 0) then
   Result := false
  else
   Result := nsFindBookmarkInFolders(l_EID, aNode, aFoldersControl, aCanCreate);
 end//l_L <> nil
 else
  Result := false;
end;
  
function nsDeleteBookmark(anID : Integer; const aCont : InevDocumentContainer): TnsDeleteResult;
  {-}
var
 l_A : InsDocumentAdornments;
begin
 if Supports(aCont, InsDocumentAdornments, l_A) then
  try
   Result := nsDeleteBookmark(anID, l_A);
  finally
   l_A := nil;
  end//try..finally
 else
  Result := drCancel;
end;
  
function nsDeleteBookmark(anID : Integer; const anAdorn : InsDocumentAdornments): TnsDeleteResult;
  {-}
var
 l_FoldersNode : IFoldersNode;
 l_Entity      : IvcmEntity;
 l_Node        : Il3Node;
 l_L           : IBookmarkList;
 l_EID         : Integer;
 l_Index       : Integer;
 l_D           : TBookmark2;
begin
 Result := drCancel;
 if (anAdorn <> nil) then
 begin
  l_EID := 0;
  l_L := anAdorn.Bookmarks;
  if (l_L <> nil) then
   for l_Index := 0 to Pred(l_L.Count) do
   begin
    l_L.pm_GetItem(l_Index, l_D);
    if (l_D.rParaID = anID) then
    begin
     l_EID := l_D.rEid;
     break;
    end;//l_D.rParaID = anID
   end;//for l_Index
  if (l_EID <> 0) AND
     nsFindBookmarkInFolders(l_EID, l_FoldersNode, l_Entity, False) then
   try
    if Assigned(l_Entity) then
     Result := Op_FoldersControl_DeleteElement.Call(l_Entity, l_FoldersNode)
    else
    begin
     Result := drCancel;
     l_Node := FindOnAdapterNode(UserFoldersTree.Tree.CRootNode, l_FoldersNode);
     if Assigned(l_Node) and vcmAsk(qr_ObjectDelete, [nsCStr(l_Node.Text)]) and
        CheckFolderElementRights(l_Node, faDelete) then
     begin
      Result := drOk;
      l_Node.Delete;
     end;//Assigned(l_Node)..
    end;//Assigned(l_Entity)
   finally
    l_Entity := nil;
    l_FoldersNode := nil;
   end//try..finally
  else
   vcmSay(war_DeleteMissingBookmark);
 end;//anAdorn <> nil
end;

{$If not (defined(Monitorings) or defined(Admin))}
procedure SharedFolder(const aFolder : IeeNode; aShared : Boolean);
var
 lAddNode  : InsFoldersNode;
 lFolder   : IFolder;
begin
 if Assigned(aFolder) and Supports(aFolder, InsFoldersNode, lAddNode) then
 try
  lFolder := GetIFolderFromIeeNode(aFolder);
  if Assigned(lFolder) and (lFolder.GetShared <> aShared) then
  try
   // установим доступ
   lFolder.SetShared(aShared);
  finally
   lFolder := nil;
  end;//lFolder := GetIFolderFromIeeNode(aFolder);
 finally
  lAddNode := nil;
 end;//if Assigned(aFolder) and...
end;
{$IfEnd not (defined(Monitorings) or defined(Admin))}

function GetIFolderFromIeeNode(const aNode : IeeNode) : IFolder;
var
 lNode          : INode;
begin

 Result := nil;

 if Supports(aNode, INode, lNode) then
 try
  Result := GetIFolderFromINode(lNode);
 finally
  lNode := nil;
 end;

end;

// Start class TFoldersTree

procedure TFoldersTree.Cleanup;
var
 l_Tree : InsDeferredTree;
begin
 if Supports(f_Tree, InsDeferredTree, l_Tree) then
  try
   l_Tree.WaitForReady;
  finally
   l_Tree := nil;
  end;//try..finally
 f_Tree := nil;
 f_ControlledObj := nil;

 f_LastQuerySaved := nil;
 f_LastListSaved := nil;
 f_LastBookmarkSaved := nil;

 f_ConsultationsFolder := nil;
 f_ConsultationAnswerFolder := nil;
 f_ConsultationSentFolder := nil;

 inherited;
end;

function TFoldersTree.pm_GetFoldersTree: Il3Tree;
var
 l_Tree : InsDeferredTree;
begin
 Result := AsyncTree;
 if Supports(f_Tree, InsDeferredTree, l_Tree) then
  try
   l_Tree.WaitForReady;
  finally
   l_Tree := nil;
  end;//try..finally
end;

function TFoldersTree.pm_GetControlledObj: InsChildTree;
var
 l_ControlledObj : TnsUnderControlObjList;
begin
 if f_ControlledObj = nil then
 begin
  l_ControlledObj := TnsUnderControlObjList.Create;
  try
   l3BQueryInterface(l_ControlledObj, InsChildTree, f_ControlledObj);
  finally
   vcmFree(l_ControlledObj);
  end;
 end;
 Result := f_ControlledObj;
end;

function TFoldersTree.CreateFolder(const aName         : Il3CString;
                                   const aParentFolder : Il3Node;
                                   const aComment      : Il3CString;
                                   const aBeforeNode   : Il3Node): Il3Node;
var
 l_NewFolder: IFolder;
 l_CurAdapterNode,
 l_CurAdapterRoot: INode;
begin
 Result := nil;

 l_CurAdapterNode := nil;
 if l3BQueryInterface(aParentFolder, INode, l_CurAdapterRoot) then
 begin
  DefDataAdapter.Folders.CreateFolder(l_NewFolder);
  try
   l_NewFolder.SetName(nsIStr(aName));
   if not l3IsNil(aComment) then
    l_NewFolder.SetComment(nsIStr(aComment));
   try
    l_CurAdapterRoot.AddChildNode(l_NewFolder, l_CurAdapterNode);
   except
    on EDuplicateNode do
    begin
     // Уже успели создать папку с таким именем.
     vcmSay(err_FolderCreateError);
     Exit;
    end;
    on ECanNotFindData do
    begin
     // Удалили папку, в которой мы пытаемся создавать.
     vcmSay(err_FolderCreateError);
     Exit;
    end;
   end;//try..except
  finally
   l_NewFolder := nil;
  end;//try..finally
 end;//l3BQueryInterface(aParentFolder, INode, l_CurAdapterRoot)

 if l_CurAdapterNode <> nil then
  if not Assigned(aBeforeNode) then
   Result := aParentFolder.InsertChild(TnsFoldersNode.Make(l_CurAdapterNode) as Il3Node)
  else
   Result := aParentFolder.InsertChildBefore(aBeforeNode,
                                             TnsFoldersNode.Make(l_CurAdapterNode) as Il3Node);
end;

function TFoldersTree.FindNodeByFlag(const aFlag: LongWord; const aInRoot: Il3Node = nil): Il3Node;

 function lp_FindRootNode(const anIntf: Il3Node): Boolean;
 var
  l_Child: INode;
 begin
  if l3BQueryInterface(anIntf, INode, l_Child) then
   Result := (l_Child.GetFlags and aFlag) = aFlag
  else
   Result := False;
 end;//lp_FindRootNode

var
 l_RootNode: Il3Node;
begin
 if Assigned(aInRoot) then
  l_RootNode := aInRoot
 else
  l_RootNode := Tree.CRootNode;
 Result := l_RootNode.IterateF(l3L2NA(@lp_FindRootNode), imOneLevel or imCheckResult);
end;//FindNodeByFlag

function TFoldersTree.pm_GetConsultationsFolder: Il3Node;
  {* - узел консультаций. }
begin
 if not Assigned(f_ConsultationsFolder) then
  f_ConsultationsFolder := FindNodeByFlag(NF_MY_CONSULTATIONS);
 Result := f_ConsultationsFolder;
end;//pm_GetConsultationsFolder

procedure TFoldersTree.NodeChanged(const aNode: INode; anEvent: TFoldersNodeChangeEvent);
begin
 if Assigned(f_ControlledObj) then
  f_ControlledObj.ChangedNotify(aNode, anEvent);
end;

procedure TFoldersTree.NodeBeforeDelete(const aNode: INode; anEvent: TFoldersNodeDeleteEvent);
begin
 if Assigned(f_ControlledObj) then
  f_ControlledObj.BeforeDeleteNotify(aNode, anEvent);
end;

procedure TFoldersTree.NodeDeleted(aFlags: LongInt; aNodeType: TFoldersItemType);
begin
end;                                          

procedure TFoldersTree.Delete(const aNode : INode);
var
 l_Node : Il3Node;
begin
 l_Node := FindOnAdapterNode(Tree.CRootNode, aNode);
 if l_Node <> nil then
  try
   l_Node.Delete;
  finally
   l_Node := nil;
  end;
end;

procedure TFoldersTree.DropUserRightsCache(const aNode : INode);

 function DropCache(const anIntf: Il3Node) : Boolean;
 var
  l_FolderNode : InsFoldersNode;
 begin
  Result := False;
  if Supports(anIntf, InsFoldersNode, l_FolderNode) then
   try
    l_FolderNode.DropUserRightsCache;
   finally
    l_FolderNode := nil;
   end;
 end;

 procedure DropParentCache(const aNode : Il3Node);
 var
  l_ParentNode : Il3Node;
  l_FolderNode : InsFoldersNode;
 begin
  if aNode <> nil then
  begin
   l_ParentNode := aNode.ParentNode;
   if Supports(l_ParentNode, InsFoldersNode, l_FolderNode) then
    try
     l_FolderNode.DropUserRightsCache;
    finally
     l_FolderNode := nil;
    end;
   DropParentCache(l_ParentNode);
  end;
 end;

var
 l_Node : Il3Node;
begin
 l_Node := FindOnAdapterNode(Tree.CRootNode, aNode);
 if l_Node <> nil then
  try
   l_Node.IterateF(l3L2NA(@DropCache), imParentNeed);
   DropParentCache(l_Node);
  finally
   l_Node := nil;
  end;
end;

procedure TFoldersTree.Refresh(const aNode : INode);
var
 l_Node : Il3Node;

 function DropCache(const anIntf: Il3Node) : Boolean;
 var
  l_FolderNode : InsFoldersNode;
 begin
  Result := False;
  if Supports(anIntf, InsFoldersNode, l_FolderNode) then
   try
    l_FolderNode.DropContentCache;
   finally
    l_FolderNode := nil;
   end;
 end;

begin
 Tree.Changing;
 try
  if aNode <> nil then
  begin
   l_Node := FindOnAdapterNode(Tree.CRootNode, aNode);
   if l_Node <> nil then
    try
     l_Node.IterateF(l3L2NA(@DropCache), imParentNeed);
    finally
     l_Node := nil;
    end;
  end;
 finally
  Tree.Changed;
 end;
end;

// Service functions

function CheckFolderElementRights(const aNode : Il3SimpleNode;
                                  aAction     : TFoldersActions) : Boolean;
var
 l_NodeWithRights  : InsNodeWithRights;
begin
 if l3BQueryInterface(aNode, InsNodeWithRights, l_NodeWithRights) then
  try
   Result := l_NodeWithRights.CheckRights(aAction);
  finally
   l_NodeWithRights := nil;
  end//try..finally
 else
  Result := False;
end;

function CheckFolderElementRights(const aNode : IeeNode;
                                  aAction     : TFoldersActions) : Boolean;
  //overload;
  {-}
var
 l_NodeWithRights  : InsNodeWithRights;
begin
 if l3BQueryInterface(aNode, InsNodeWithRights, l_NodeWithRights) then
  try
   Result := l_NodeWithRights.CheckRights(aAction);
  finally
   l_NodeWithRights := nil;
  end//try..finally
 else
  Result := False;
end;

{$If not (defined(Monitorings) or defined(Admin))}
{ TFolderSecurity }

constructor TFolderSecurity.Create(acbShare: TvtCheckBox);
begin
 inherited Create;
 f_cbShared := acbShare;
 f_cbShared.OnClick := OnSharedChaged;
 CanChangeRights := False;
 Shared := False;
end;

procedure TFolderSecurity.Cleanup;
begin
 f_Folder         := nil;
 f_SelectedNode   := nil;
 inherited;
end;

procedure TFolderSecurity.Clear;
begin
 f_Folder := nil;
 f_cbShared.Checked := False;
 f_CanChangeRights := False;
 f_Shared := False;
 SetState;
 inherited;
end;

function TFolderSecurity.Save : Boolean;
var
 lNode : INode;
begin
 Result := False;
 if IsExternal then
  Exit;
 { Есть ли изменения }
 Result := Modified;
 if Result then
 begin
  if Supports(f_SelectedNode, INode, lNode) then
  try
   { Общий доступ }
   if IsShareChanged then
   begin
    { Устновим доступ }
    f_Folder.SetShared(Shared);
    { Перечитаем флаги }
    UserFoldersTree.DropUserRightsCache(lNode);
   end;
  finally
   lNode := nil;
  end;
 end;
 Modified := False;
end;

function TFolderSecurity.IsShareChanged : Boolean;
begin
 Result := False;
 if Assigned(f_Folder) then
  Result := Shared <> f_Folder.GetShared;
end;

function TFolderSecurity.pm_GetModified: Boolean;
begin
 Result := IsShareChanged;
end;

procedure TFolderSecurity.pm_SetModified(const aValue: Boolean);
begin
 if Assigned(f_Folder) then
  Shared := f_Folder.GetShared;
end;

procedure TFolderSecurity.pm_SetFolder(const aValue: IFolder);
begin
 Shared := False;
 { Освободим f_Folder }
 if Assigned(f_Folder) then
  f_Folder := nil;
 { Установим f_Folder }
 if Assigned(aValue) then
 begin
  f_Folder := aValue;
  Shared := f_Folder.GetShared;
 end;
end;

procedure TFolderSecurity.OnSharedChaged(Sender: TObject);
begin
 Shared := f_cbShared.Checked;
end;

procedure TFolderSecurity.ShareChanged;
begin
 if Assigned(f_Folder) then
 begin
  Folder := GetIFolderFromIeeNode(eeFolder);
  Shared := f_Folder.GetShared;
 end;
end;

function TFolderSecurity.CheckObjectType(aItemType : TFoldersItemType) : Boolean;
var
 lNode : INode;
begin
 Result := False;
 if Assigned(f_SelectedNode) and Supports(f_SelectedNode, INode, lNode) then
 try
  Result := TFoldersItemType(lNode.GetObjectType) = aItemType;
 finally
  lNode := nil;
 end;
end;

function TFolderSecurity.CheckFlag(const aeeNode : IeeNode;
                                   aFlag         : Integer) : Boolean;
//overload;
{* - проверяет у папки указанный флаг. }
var
 lNode : INode;
begin
 Result := False;
 if not Assigned(aeeNode) then
  Exit;
 if Supports(aeeNode, INode, lNode) then
 try
  Result := (lNode.GetFlags and aFlag) = aFlag;
 finally
  lNode := nil;
 end;
end;

function TFolderSecurity.CheckFlag(aFlag : Integer) : Boolean;
begin
 Result := CheckFlag(f_SelectedNode, aFlag);
end;

function TFolderSecurity.IsExternal : Boolean;
var
 lNode : INode;
begin
 Result := False;
 { Установим External }
 if Supports(f_SelectedNode, INode, lNode) then
 try
  Result := (lNode.GetFlags and NF_EXTERNAL) = NF_EXTERNAL;
 finally
  lNode := nil;
 end;
end;

procedure TFolderSecurity.pm_SetEeFolder(const aValue: IeeNode);
begin
 f_SelectedNode := nil;
 { Установим eeFolder(IeeNode) }
 f_SelectedNode := aValue;
 { Очистим }
 Clear;
 { Определим можно ли менять права }
 CanChangeRights := CheckFolderElementRights(f_SelectedNode, faChangeRights);
 { Установим Folder(IFolder) }
 Folder := GetIFolderFromIeeNode(aValue);
 { Установим Modified = False }
 Modified := False;
end;

procedure TFolderSecurity.pm_SetCanChangeRights(const aValue: Boolean);
begin
 f_CanChangeRights := aValue;
 SetState;
end;//pm_SetCanChangeRights

procedure TFolderSecurity.pm_SetShared(const aValue: Boolean);
begin
 if f_Shared = aValue then
  Exit;
 f_Shared := aValue;
 SetState;
end;//pm_SetShared

procedure TFolderSecurity.SetState;
begin
 f_cbShared.Checked := f_Shared;
 f_cbShared.Enabled := f_CanChangeRights;
 f_cbShared.Visible := f_CanChangeRights;
end;//SetState

{$IfEnd not (defined(Monitorings) or defined(Admin))}

function TFoldersTree.pm_GetAsyncTree: Il3Tree;
begin
 if not Assigned(f_Tree) then
  f_Tree := TnsFoldersTree.Make(Self, nil);
 Result := f_Tree;
end;

function TFoldersTree.pm_GetConsultationAnswerFolder: Il3Node;
begin
 if not Assigned(f_ConsultationAnswerFolder) then
  f_ConsultationAnswerFolder := FindNodeByFlag(NF_FOLDER_RECEIVED, ConsultationsFolder);
 Result := f_ConsultationAnswerFolder; 
end;

function TFoldersTree.pm_GetConsultationSentFolder: Il3Node;
begin
 if not Assigned(f_ConsultationSentFolder) then
  f_ConsultationSentFolder := FindNodeByFlag(NF_FOLDER_SENT, ConsultationsFolder);
 Result := f_ConsultationSentFolder;
end;

initialization
finalization
 vcmFree(g_UserFoldersTree);
end.
