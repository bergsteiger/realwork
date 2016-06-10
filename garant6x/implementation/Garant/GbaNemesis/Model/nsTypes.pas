unit nsTypes;

// $Id: nsTypes.pas,v 1.57 2016/05/11 20:42:52 lulin Exp $

// $Log: nsTypes.pas,v $
// Revision 1.57  2016/05/11 20:42:52  lulin
// - перегенерация.
//
// Revision 1.56  2016/05/11 15:43:44  lulin
// - перегенерация.
//
// Revision 1.55  2016/03/29 11:02:06  kostitsin
// {requestlink: 620672440 } - Настройки
//
// Revision 1.54  2014/11/19 06:50:56  kostitsin
// {requestlink: 564248678 } - впаял обратно
//
// Revision 1.53  2014/11/12 12:34:26  kostitsin
// {requestlink: 573675680 }
//
// Revision 1.52  2014/09/02 13:23:22  kostitsin
// {requestlink: 564248678 }
//
// Revision 1.51  2014/07/24 13:06:54  kostitsin
// {requestlink: 552601328 }
//
// Revision 1.50  2014/07/24 11:50:08  kostitsin
// {requestlink: 552601328 }
//
// Revision 1.49  2014/06/24 15:57:25  kostitsin
// {requestlink: 507443224 }
//
// Revision 1.48  2014/03/04 13:11:52  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.47  2013/08/20 14:44:31  kostitsin
// [$414849897] - перенес "мапу" на модель
//
// Revision 1.46  2013/08/20 10:07:57  kostitsin
// [$414849897] - новые контролы на форме настройки
//
// Revision 1.45  2013/07/05 18:19:51  lulin
// - вычищаем устаревшее.
//
// Revision 1.44  2013/04/24 09:35:56  lulin
// - портируем.
//
// Revision 1.43  2012/04/04 09:02:54  lulin
// {RequestLink:237994598}
//
// Revision 1.42  2012/03/23 15:56:44  lulin
// - выпиливаем настройки.
//
// Revision 1.41  2012/03/14 12:16:42  lulin
// {RequestLink:344754594}
//
// Revision 1.40  2012/03/14 11:34:25  lulin
// {RequestLink:344754594}
//
// Revision 1.39  2011/01/27 15:02:13  lulin
// {RequestLink:248195582}.
// - упрощаем программирование на форме.
//
// Revision 1.38  2011/01/27 12:15:42  lulin
// {RequestLink:248195582}.
// - избавляемся от развесистых макарон.
//
// Revision 1.37  2010/10/25 09:55:12  lulin
// {RequestLink:237502802}.
// Шаг №3.
//
// Revision 1.36  2010/10/22 19:48:43  lulin
// {RequestLink:237502802}.
// Шаг №1.
//
// Revision 1.35  2010/03/22 14:42:50  lulin
// {RequestLink:198672893}.
//
// Revision 1.34  2010/03/17 11:01:53  oman
// - new: Заготовки формы {RequestLink:196969092}
//
// Revision 1.33  2009/12/01 12:11:00  oman
// - new: LE_USER_OPERATION {RequestLink:121157219}
//
// Revision 1.32  2009/11/30 13:44:26  oman
// - new: Счетчики {RequestLink:121157219}
//
// Revision 1.31  2009/11/30 10:02:33  oman
// - new: LE_LOAD_QUERY {RequestLink:121157219}
//
// Revision 1.30  2009/11/27 11:56:32  oman
// - new: Печать {RequestLink:121157219}
//
// Revision 1.29  2009/11/26 13:11:19  oman
// - new: ExText {RequestLink:121157219}
//
// Revision 1.28  2009/11/26 11:44:13  oman
// - new: Search {RequestLink:121157219}
//
// Revision 1.27  2009/11/25 11:48:01  oman
// - new: {RequestLink:121157219}
//
// Revision 1.26  2009/11/25 11:25:10  oman
// - new: LE_VIEW_DOCUMENT_EDITION_LIST {RequestLink:121157219}
//
// Revision 1.25  2009/11/25 10:47:06  oman
//
// Revision 1.24  2009/11/25 10:19:35  oman
// - new: LE_TIME_MACHINE_ON {RequestLink:121157219}
//
// Revision 1.23  2009/11/25 09:54:31  oman
// - new: List {RequestLink:121157219}
//
// Revision 1.22  2009/11/24 14:19:43  oman
// - new: LE_OPEN_DOCUMENT_FROM_HISTORY {RequestLink:121157219}
//
// Revision 1.21  2009/11/24 12:14:53  oman
// - new: MainForm {RequestLink:121157219}
//
// Revision 1.20  2009/11/24 10:35:53  oman
// - new: FoldersElementInfo {RequestLink:121157219}
//
// Revision 1.19  2009/11/24 09:33:10  oman
// - new: LE_OPEN_DOCUMENT_FROM_FOLDERS {RequestLink:121157219}
//
// Revision 1.18  2009/11/24 09:07:46  oman
// - new: BaseTextOperations {RequestLink:121157219}
//
// Revision 1.17  2009/11/23 13:25:50  oman
// - new: LE_SEARCH_IN_DOCUMENT {RequestLink:121157219}
//
// Revision 1.16  2009/11/23 13:06:50  oman
// - new: LE_DELETE_FROM_LIST {RequestLink:121157219}
//
// Revision 1.15  2009/11/23 12:46:04  oman
// - new: LE_ADD_TO_LIST {RequestLink:121157219}
//
// Revision 1.14  2009/11/23 12:08:31  oman
// - new: LE_OPEN_DOCUMENT_FROM_LINK {RequestLink:121157219}
//
// Revision 1.13  2009/11/23 11:49:51  oman
// - new: LE_OPEN_DOCUMENT_FROM_LIST {RequestLink:121157219}
//
// Revision 1.12  2009/11/18 13:50:26  oman
// - new: LE_UNKNOWN {RequestLink:121157219}
//
// Revision 1.11  2009/10/30 17:11:04  lulin
// - третья волна компании по борьбе со старыми внутренними операциями.
//
// Revision 1.10  2009/10/20 17:29:32  lulin
// {RequestLink:159360578}. №4.
//
// Revision 1.9  2009/10/14 12:20:16  lulin
// - добиваемся отсутствия Warning'ов при генерации проектов F1.
//
// Revision 1.8  2009/10/14 07:30:58  oman
// - new:  {RequestLink:166855383}
//
// Revision 1.7  2009/10/12 11:27:27  lulin
// - коммитим после падения CVS.
//
// Revision 1.7  2009/10/08 12:26:06  lulin
// - добавляем ссылку на поиск "СМИ по налогам и бухучёту".
//
// Revision 1.6  2009/09/25 16:13:22  lulin
// - продолжаем перенос модуля Папки на модель.
//
// Revision 1.5  2009/09/24 16:41:10  lulin
// - продолжаем переносить на модель модуль Common.
//
// Revision 1.4  2009/09/21 13:27:46  lulin
// - модуль мониторингов полностью перенесён на модель.
//
// Revision 1.3  2009/09/17 09:47:26  lulin
// - операции модуля публикуем в run-time, а не в формах.
//
// Revision 1.2  2009/09/16 19:47:12  lulin
// - модуль Документ полностью перенесён на модель.
//
// Revision 1.1  2009/09/14 11:29:14  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.250  2009/09/11 16:46:15  lulin
// - удаляем ненужные операции.
// - правим модель за Ромой.
// - исправляем кривизну использования форм.
//
// Revision 1.249  2009/09/11 10:59:03  oman
// - new: Чат - {RequestLink:159353581}
//
// Revision 1.248  2009/09/11 07:58:43  oman
// - new: Кнопка назад - {RequestLink:159353581}
//
// Revision 1.247  2009/09/08 13:52:36  lulin
// - удаляем ненужного менеджера.
//
// Revision 1.246  2009/09/04 17:08:17  lulin
// {RequestLink:128288497}.
//
// Revision 1.245  2009/09/01 15:21:11  lulin
// - убираем неправильную зависимосто между прецедентами.
// - позволяем прецедентам заказывать операции, которые они используют.
// - делаем операции модулей "квадратиком".
//
// Revision 1.244  2009/08/19 12:06:34  oman
// - new: Фильтруем базы - {RequestLink:159360307}
//
// Revision 1.243  2009/08/19 11:07:18  oman
// - new: Зачистка - {RequestLink:159355458}
//
// Revision 1.242  2009/07/31 17:29:52  lulin
// - убираем мусор.
//
// Revision 1.241  2009/06/03 10:43:13  oman
// - new: Готовим проекты к отпилу - [$148014435]
//
// Revision 1.240  2009/03/19 12:11:08  oman
// - fix: Не падаем при открытии отсутствующего термина ТС (К-139441542)
//
// Revision 1.239  2009/02/10 19:03:14  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.238  2009/02/10 18:47:16  lulin
// - <K>: 133891247. Выделяем интерфейсы работы с адаптером и советами дня.
//
// Revision 1.237  2009/02/10 11:21:50  lulin
// - <K>: 133891247. Переносим поисковые интерфейсы.
//
// Revision 1.236  2009/02/10 09:49:56  lulin
// - <K>: 133891247. Выделяем интерфейсы логирования.
//
// Revision 1.235  2009/02/09 19:17:18  lulin
// - <K>: 133891247. Выделяем интерфейсы поиска.
//
// Revision 1.234  2009/02/09 15:18:21  lulin
// - <K>: 133891247. Переносим интерфейсы папок.
//
// Revision 1.233  2009/02/09 13:20:55  lulin
// - <K>: 133891247.
//
// Revision 1.232  2009/02/09 11:56:51  lulin
// - <K>: 133891247.
//
// Revision 1.231  2009/02/03 14:59:58  lulin
// - <K>: 135136020. Переносим код из формы в предка, описанного на модели.
//
// Revision 1.230  2009/02/02 16:34:40  lulin
// - <K>: 135136020. Выделяем общие части в примесь.
//
// Revision 1.229  2009/01/28 14:11:22  lulin
// - <K>: 133138664. №32.
//
// Revision 1.228  2009/01/27 15:19:45  lulin
// - <K>: 133138664. №25.
//
// Revision 1.227  2009/01/27 15:14:04  lulin
// - <K>: 133138664. №25.
//
// Revision 1.226  2009/01/27 14:50:36  lulin
// - <K>: 133138664. №25.
//
// Revision 1.225  2009/01/27 14:38:54  lulin
// - <K>: 133138664. №25.
//
// Revision 1.224  2009/01/27 14:31:19  lulin
// - <K>: 133138664. №25. Выделяем общий шаблон.
//
// Revision 1.223  2009/01/27 14:01:37  lulin
// - <K>: 133138664. №25.
//
// Revision 1.222  2009/01/14 09:34:54  oman
// - new: Эксопртим в первом приближении (К-96481841)
//
// Revision 1.221  2009/01/12 15:58:21  lulin
// - <K>: 133138664. № 22.
//
// Revision 1.220  2008/12/24 14:18:22  lulin
// - <K>: 133138664.
//
// Revision 1.219  2008/10/24 13:26:40  oman
// - fix: Новшества в логировании списков (К-121161486)
//
// Revision 1.218  2008/09/19 06:18:25  oman
// - fix: Логируем количество обращений к подсказке БП (К-111740091)
//
// Revision 1.217  2008/08/18 13:04:52  oman
// - new: Заготовки для остального (K-109085256)
//
// Revision 1.216  2008/07/16 12:43:07  oman
// - new: Фильтр на инфоблоки (К-97846369)
//
// Revision 1.215  2008/07/07 06:46:12  mmorozov
// - bugfix: уточнить в списке (K<96484582>);
//
// Revision 1.214  2008/07/01 07:16:14  mmorozov
// - change comment.
//
// Revision 1.213  2008/06/09 12:16:12  lulin
// - bug fix: не собирался Немезис.
//
// Revision 1.212  2008/05/27 12:04:13  mmorozov
// - new: регистрация операций открытия препарата и фирмы производителя.
//
// Revision 1.211  2008/05/27 08:25:47  mmorozov
// - new: операция открытия документа по номеру.
//
// Revision 1.210  2008/05/27 06:10:10  mmorozov
// - format code.
//
// Revision 1.209  2008/05/27 03:54:52  mmorozov
// - new: факт отправки запроса в службу правовой поддержки.
//
// Revision 1.208  2008/05/26 11:47:35  mmorozov
// - new: идентификаторы событий (CQ: OIT5-28459).
//
// Revision 1.207  2008/05/23 14:01:18  civ
// новые события для логирования
//
// Revision 1.206  2008/05/22 10:14:46  mmorozov
// - new: основное меню Инфарм.
//
// Revision 1.205  2008/05/22 07:05:39  mmorozov
// - new: основное меню Инфарм.
//
// Revision 1.204  2008/05/04 09:07:46  oman
// - new: Очередное изменение БП (cq28613)
//
// Revision 1.203  2008/04/30 07:54:08  mmorozov
// - new: регистрация события использования операции панели задач.
//
// Revision 1.202  2008/04/30 07:00:27  mmorozov
// - new: регистрация события использования примера базового поиска.
//
// Revision 1.201  2008/04/29 11:57:01  mmorozov
// - new: регистрация использования операций sub панели документа.
//
// Revision 1.200  2008/04/29 07:41:42  mmorozov
// - new: регистрация событий открытия списка фирм, словаря медицинских терминов;
//
// Revision 1.199  2008/04/29 07:05:55  mmorozov
// - new: регистрация события - "Проверить условия подключения к услуге Правовая поддержка онлайн";
//
// Revision 1.198  2008/04/26 07:58:12  mmorozov
// - new: регистрация события отправки списка по почте.
//
// Revision 1.197  2008/04/21 10:53:47  mmorozov
// - new: при фильтрации элементов моих документов используется параметр для чего вызвали мои документы: документы | препараты.
//
// Revision 1.196  2008/04/14 12:20:19  mmorozov
// - работа с моими документами из списка;
//
// Revision 1.195  2008/04/04 13:40:41  oman
// - new: Документ-препарат - Открываемся из папок (cq28562)
//
// Revision 1.194  2008/04/04 12:58:16  oman
// - new: Документ-препарат - Пишем в журнал (cq28562)
//
// Revision 1.193  2008/03/12 11:32:44  oman
// - new: Заготовки для ПЛП - пишем в журнал работы
//
// Revision 1.192  2008/03/12 08:58:35  oman
// - new: Заготовки для ПЛП - заготовки для фильтров
//
// Revision 1.191  2008/02/21 08:25:07  mmorozov
// - format code;
//
// Revision 1.190  2008/02/14 17:08:34  lulin
// - cleanup.
//
// Revision 1.189  2008/02/01 07:29:18  oman
// - new: Логгирование отсылки документа по мылу (cq10543)
//
// Revision 1.188  2008/01/31 13:29:59  oman
// - new: Поддержка _TrimLeafFilter (cq14053)
//
// Revision 1.187  2008/01/31 12:09:38  mmorozov
// - cleanup: не используемые типы;
//
// Revision 1.186  2008/01/21 07:18:16  mmorozov
// - new: работа с пользовательскими ссылками на докумени и из документа перенесене на sdsDocInfo, чтобы быть доступной для списка и документа + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-17587);
//
// Revision 1.185  2008/01/14 13:06:58  mmorozov
// - new: запись терминов толкового словаря в журнал (CQ: OIT5-13341);
//
// Revision 1.184  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.183  2007/12/04 08:59:42  oman
// - new: Порядок создания папок в журнале (cq27781)
//
// Revision 1.181.4.3  2007/11/27 07:21:49  oman
// Перепиливаем на новый адаптер - логгирование
//
// Revision 1.181.4.2  2007/11/21 10:26:01  oman
// Перепиливаем на новый адаптер
//
// Revision 1.181.4.1  2007/11/16 12:23:37  oman
// Перепиливаем на новый адаптер
//
// Revision 1.182  2007/11/15 12:06:03  mmorozov
// - в рамках работы над "Не смещались к выбранному в дереве" (CQ: OIT5-19586);
//
// Revision 1.181  2007/09/05 07:01:55  mmorozov
// - new: в списке поддержаны операции "Аннотация", "Похожие документы" (CQ: OIT5-26446) + почищен висячий интерфейс формы синхронный просмотр;
//
// Revision 1.180  2007/08/28 07:02:49  mmorozov
// - new: вместо события о сбросе детей, на менеджере корня дерева, используем нотификацию о сбросе детей (в рамках CQ: OIT5-26477);
//
// Revision 1.179  2007/08/22 11:17:27  oman
// - fix: Убираем AT_TEXT_OPT (cq25394)
//
// Revision 1.178  2007/08/14 14:29:48  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.177  2007/08/10 05:57:54  oman
// - fix: Убеждаемся, что в адаптер передается действительно PAnsiChar
//  (cq25680)
//
// Revision 1.176  2007/08/07 12:51:35  oman
// - fix: Избавляемся от прямых приведений к PAnsiChar строк,
//  передаваемых в адаптер (cq25680)
//
// Revision 1.175  2007/08/01 12:59:49  mmorozov
// - new: регистрация событий в рамках CQ: OIT5-25852;
//
// Revision 1.174  2007/07/30 09:44:24  oman
// - fix: Если даты интервала совпадают, то IntervalToString
//  возвращает одну дату, а не интервал (cq25196)
//
// Revision 1.173  2007/07/24 07:47:44  mmorozov
// - new behaviour: регистрируем каждое обращение к вкладкам (CQ: OIT5-25903);
//
// Revision 1.172  2007/07/24 05:37:13  mmorozov
// - change: идентификатор события;
//
// Revision 1.171  2007/07/19 13:54:44  mmorozov
// - new: регистрирация события активация справки к списку CQ: OIT5-25852);
//
// Revision 1.170  2007/07/19 10:39:39  mmorozov
// - new: - new: регистрация событий печати и превью списка (в рамках CQ: OIT5-25852);
//
// Revision 1.169  2007/07/18 13:27:18  mmorozov
// - new: регистрирация события открытие докумнета из последних открытых (в рамках CQ: OIT5-25852);
//
// Revision 1.168  2007/07/18 10:51:28  mmorozov
// - new: событие разрешение экрана (в рамках CQ: OIT5-25852);
//
// Revision 1.167  2007/07/17 13:26:42  mmorozov
// - new: изменены интерфейсы логирования событий (в рамках CQ: OIT5-25852);
//
// Revision 1.166  2007/07/13 07:55:13  oman
// - new: Новый фильтр "Списки и закладки" для Моих документов  (cq25830)
//
// Revision 1.165  2007/06/13 14:17:36  oman
// - new: Базовый поиск умеет теперь открываться тремя способами:
//  локальный контекстный поиск, базовый поиск и уточнение
//  списка (cq25674)
//
// Revision 1.164  2007/05/23 11:10:24  lulin
// - добавлены комментарии к константам.
//
// Revision 1.163  2007/05/23 10:40:18  oman
// - new: Новый тип запросов "Базовый поиск" (cq25374)
//
// Revision 1.162  2007/05/07 07:31:22  mmorozov
// - new: показ документов без команды CLASS (CQ: OIT5-24546);
//
// Revision 1.161  2007/04/23 08:27:28  oman
// - new: Вычищаем старую ППР и старые фильтры - _UserTypes (cq25125)
//
// Revision 1.160  2007/04/17 09:29:47  mmorozov
// - new: определены параметры поиска элементов дерева навигатора;
//
// Revision 1.159  2007/04/10 09:21:57  mmorozov
// - new: строим основное меню используя новые идентификаторы элементов навигатора (CQ: OIT5-24602);
//
// Revision 1.158  2007/04/05 10:22:28  lulin
// - избавляемся от лишних преобразований строк.
//
// Revision 1.157  2007/04/05 08:42:46  lulin
// - cleanup.
//
// Revision 1.156  2007/04/05 08:12:58  lulin
// - cleanup.
//
// Revision 1.155  2007/04/03 11:12:46  oman
// - new: При сохранении в один файл умеем писать не только RTF, а
//  все поддерживаемые форматы
//
// Revision 1.154  2007/03/28 14:51:26  oman
// - new: Избавляемся от ContextParams в КЗ (cq24456)
//
// Revision 1.153  2007/03/28 11:04:58  mmorozov
// - "таблица перехода фокуса" перенесена в библиотеку визуальных компонентов проекта Немезис;
//
// Revision 1.152  2007/03/26 12:55:12  lulin
// - ослабил условие проверки длины строки.
//
// Revision 1.151  2007/03/26 12:54:36  lulin
// - jckf,bk eckjdbt ghjdthrb lkbys cnhjrb
//
// Revision 1.150  2007/03/20 11:51:19  lulin
// - используем строки с кодировкой.
//
// Revision 1.149  2007/03/19 12:08:50  lulin
// - используем свою функцию форматирования.
//
// Revision 1.148  2007/03/19 11:57:24  lulin
// - избегаем копирования строк.
//
// Revision 1.147  2007/03/19 11:35:21  lulin
// - разделяем приведение к строке для форматирования и для исключения.
//
// Revision 1.146  2007/03/16 17:03:51  lulin
// - избавляемся от излишнего копирования и преобразования строк.
//
// Revision 1.145  2007/03/16 16:56:55  lulin
// - избавляемся от излишнего копирования и преобразования строк.
//
// Revision 1.144  2007/03/16 12:20:20  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.143  2007/02/28 16:17:01  lulin
// - корректнее обрабатываем юникодные строки.
//
// Revision 1.142  2007/02/16 16:31:28  lulin
// - избавляемся от стандартного строкового типа.
//
// Revision 1.141  2007/02/16 15:36:08  lulin
// - cleanup.
//
// Revision 1.140  2007/02/14 17:54:56  lulin
// - cleanup.
//
// Revision 1.139  2007/02/14 16:50:57  lulin
// - избавляемся от использования стандартных строк.
//
// Revision 1.138  2007/02/13 14:33:08  lulin
// - cleanup.
//
// Revision 1.137  2007/02/13 08:43:38  lulin
// - избегаем лишнего преобразования строк.
//
// Revision 1.136  2007/02/12 09:58:39  lulin
// - bug fix: искажались входные строковые параметры адаптера.
//
// Revision 1.135  2007/02/09 12:58:18  lulin
// - выделена функция преобразования к входной строке адаптера.
//
// Revision 1.134  2007/02/07 19:13:27  lulin
// - переводим мапы на строки с кодировкой.
//
// Revision 1.133  2007/02/07 17:48:27  lulin
// - избавляемся от копирования строк при чтении из настроек.
//
// Revision 1.132  2007/02/07 09:15:54  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.131  2007/02/06 15:20:41  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.130  2007/02/06 11:45:24  lulin
// - bug fix: не собирались мониторинги.
//
// Revision 1.129  2007/02/06 09:02:58  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.128  2007/02/05 14:36:20  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.127  2007/02/05 13:45:37  lulin
// - cleanup.
//
// Revision 1.126  2007/02/05 13:21:30  lulin
// - убрана функция приведения идентификатора языка к строке - чтобы не было соблазна воспользоваться.
//
// Revision 1.125  2007/02/05 13:14:22  lulin
// - избавляемся от копирования строк.
//
// Revision 1.124  2007/02/05 09:40:03  lulin
// - две функции объединены в одну.
//
// Revision 1.123  2007/02/02 14:31:35  lulin
// - добавлены функции преобразования к константной строке.
//
// Revision 1.122  2007/02/02 13:23:48  lulin
// - упрощаем преобразование строк.
//
// Revision 1.121  2007/01/31 14:36:25  mmorozov
// - MERGE WITH B_NEMESIS_6_4;
//
// Revision 1.115.4.3  2007/01/31 14:10:58  mmorozov
// - new: регистрируем события открытия\сохранения документа из папок (CQ: OIT5-23963);
//
// Revision 1.120  2007/01/29 10:09:28  mmorozov
// - new: в рамках работы над CQ: OIT5-24234;
// - bugfix: не обновляли деревья после переключения базы;
//
// Revision 1.119  2007/01/18 12:57:11  mmorozov
// - new: Простое основное меню (CQ: OIT5-23939);
//
// Revision 1.118  2007/01/15 06:33:57  mmorozov
// - высносим общую функциональность из основного меню (выделен в отдельный модуль компонент управления фокусом с клавиатуры; использование компонента "сетка контролов", для управления размещением элементов основного меню), в рамках работы над "CQ: OIT5-23939";
//
// Revision 1.117  2006/11/21 15:55:59  mmorozov
// MERGE WITH B_NEMESIS_6_4 (bugfix: не вовремя складывали документ в список просмотренных документов на контроле, в результате при закрытии приложения не получали подтверждения о сбросе статуса у просмотренных, т.к. таковых в списке не было (CQ: OIT5-23704));
//
// Revision 1.116  2006/11/13 15:13:53  mmorozov
// - MERGE WITH 6_4 (- new: возможность задания иконки для диалога длительного процесса; для инициализации диалога выделен отдельный интерфейс (CQ: OIT5-23597));
//
// Revision 1.115.4.1  2006/11/13 14:59:26  mmorozov
// - new: возможность задания иконки для диалога длительного процесса; для инициализации диалога выделен отдельный интерфейс (CQ: OIT5-23597);
//
// Revision 1.115  2006/10/04 12:09:19  mmorozov
// - bugfix: получали строковое представление даты без учета региональных настроек (CQ: OIT500022845);
//
// Revision 1.114  2006/09/25 13:01:03  mmorozov
// - new behaviour: фильтруем все папки кроме "Мои документы" при сохранении/открытии объектов из моих документов;
// - new behaviour: папка "Мои документы" не скрывается при фильтрации по типу объекта;
// - _move: интерфейсы перенесены в модуль _nsInterfaces;
//
// Revision 1.113  2006/09/21 13:10:23  mmorozov
// - remove: событие открытия документа по номеру (региструется на адаптере);
//
// Revision 1.112  2006/09/21 09:30:05  mmorozov
// - new: события журнала работы пользователя;
//
// Revision 1.111  2006/09/20 15:03:12  mmorozov
// - new: изменения в рамках работы над журналом работы пользователя;
//
// Revision 1.110  2006/05/12 07:20:06  oman
// - new beh: Убрал в папках фильтры "на контролем" (cq19991)
//
// Revision 1.109  2006/05/10 06:03:34  oman
// - fix: не компилировались мониторинги
//
// Revision 1.108  2006/05/06 12:10:50  lulin
// - cleanup.
//
// Revision 1.107  2006/05/02 13:56:26  mmorozov
// - работы связанные с редактированием фильтров;
//
// Revision 1.106  2006/04/21 06:53:27  dinishev
// New type: TEffectiveWorkJournalObject.
//
// Revision 1.105  2006/04/19 13:34:29  oman
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.104  2006/04/18 08:54:02  mmorozov
// - new: оценка консультации;
// - new: менеджер ссылок (bsHyperlinkManager);
// - warnings fix;
//
// Revision 1.103  2006/04/12 13:15:11  oman
// - change: перевод механизма локализации строк на использование фабрик
// - new beh: Локализация nsc
//
// Revision 1.102  2006/04/03 15:01:18  oman
// - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.
//
// Revision 1.101  2006/03/21 15:03:58  oman
// - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)
//
// Revision 1.100  2006/03/20 15:10:37  dinishev
// Поддержка нового типа записи в журнал
//
// Revision 1.99  2005/10/27 10:36:02  mmorozov
// - работа над толковым словарем;
//
// Revision 1.98  2005/10/19 14:37:15  mmorozov
// cleanup: вычищены не используемые адаптером типы/интерфейсы;
//
// Revision 1.97  2005/10/12 13:04:14  mmorozov
// - работа над сборкой толкового словаря;
//
// Revision 1.96  2005/09/14 12:54:52  demon
// - new behavior: тип TnsUserCRListId переехал в bsTypes
//
// Revision 1.95  2005/08/26 09:52:20  mmorozov
// change: TnsLanguage стал TbsLanguage и переехал в bsTypes;
//
// Revision 1.94  2005/08/22 15:35:34  mmorozov
// change: тип TDocumentPositionType перенесен в bsTypes;
//
// Revision 1.93  2005/08/17 08:26:08  mmorozov
// change: типы корреспондентов/респондентов перекочевали в модуль bsTypes;
//
// Revision 1.92  2005/08/08 16:09:04  demon
// - new: типы для пользовательских вкладок в документе
//
// Revision 1.91  2005/06/30 07:48:05  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.90  2005/03/14 16:34:39  lulin
// - инициализируем DocID нулем.
//
// Revision 1.89  2005/03/04 14:35:32  dinishev
// Директива Monitorings для уменшения количества подключаемых модулей
//
// Revision 1.88  2005/03/03 16:41:09  demon
// - new behavior: новый тип запроса для сохранения в журнал wjoPublishSourceSearch
//
// Revision 1.87  2005/01/26 13:48:03  demon
// - new type: TDocumentBookmarkTypes
//
// Revision 1.86  2005/01/18 14:51:23  demon
// - new behavior: разнесены нотификации об изменении и удалении нод из папок
//
// Revision 1.85  2005/01/18 12:44:03  demon
// - new behavior: новый тип нотификации при удалении элемента папок - fneJournalObjectDeleted
//
// Revision 1.84  2005/01/17 14:58:15  am
// change: перетащил nsGetDictLang
//
// Revision 1.83  2005/01/14 14:00:52  demon
// - new behavior: несколько изменен принцип показа предупреждения для МВ (появилось два вид - красное предупреждение и желтое)
//
// Revision 1.82  2004/12/22 13:32:59  demon
// - new behavior: изменена семантика метода ChangeFilterStatus
//
// Revision 1.81  2004/12/10 16:29:57  demon
// - new: Type TFoldersNodeEvent (для нотификаций об изменениях нод в папках)
//
// Revision 1.80  2004/12/01 12:19:37  demon
// - new behavior: операция IStringToString
//
// Revision 1.79  2004/11/23 09:20:22  demon
// - new type: _TWorkJournalObject
//
// Revision 1.78  2004/10/14 13:40:48  demon
// - fix: _Uses поправлены на модуль nsDocumentTools
//
// Revision 1.77  2004/10/14 11:05:40  demon
// - new type: _TFolderOperationType - операция с элементом папок
//
// Revision 1.76  2004/10/08 16:49:30  demon
// - fix: Не правильно отрабатывался отказ от удаления закладки.
//
// Revision 1.75  2004/09/30 14:37:25  am
// change: new func nsGetString(IStringOld): _string - вернуть строку, соотв. переданному IStringOld
//
// Revision 1.74  2004/09/17 13:26:47  am
// change: чистка
//
// Revision 1.73  2004/09/17 07:24:09  am
// change: доводка словаря
//
// Revision 1.72  2004/09/17 07:09:09  am
// new: nsTrimToAlpha - урезать слово справа и слева до букв
//
// Revision 1.71  2004/08/23 16:23:27  demon
// - new behavior: реструктуризировано командное меню (еще раз)
//
// Revision 1.70  2004/07/15 16:30:42  law
// - механизм ожидания доступности метки перенесен с генератора на TextSource.
// - к этому же механизму приделано ожидание доступности конца документа.
//
// Revision 1.69  2004/07/09 14:16:01  demon
// - new behavior: новые значениея в TWarningType
//
// Revision 1.68  2004/07/09 11:28:33  demon
// - new behavior: новое предупреждение про "Интервал неуверенности"
//
// Revision 1.67  2004/06/28 07:14:35  nikitin75
// bool is_para -> PositionType type //PT_SUB|PT_PARA|PT_BOOKMARK
//
// Revision 1.66  2004/06/15 11:24:34  am
// new: _TLogicOperation
//
// Revision 1.65  2004/06/07 12:04:23  law
// - new proc: nsFragment.
//
// Revision 1.64  2004/04/12 09:13:06  demon
// - new: функция IsNullDate
//
// Revision 1.63  2004/04/06 08:42:54  demon
// - new: function IsDateEqual(aFirstDate, aSecondDate : GblAdapter.TDate) : Boolean
//
// Revision 1.62  2004/04/02 13:58:35  demon
// - new type: TnsEmptyDocumentType - для генерации заглушек при отсутствующем тексте документа.
//
// Revision 1.61  2004/03/27 17:44:39  am
// new: GetLanguageImage
//
// Revision 1.60  2004/03/09 09:07:57  mmorozov
// - константы из модуля nsTypes перенесены в модуль nsConst;
//
// Revision 1.59  2004/03/03 10:24:18  demon
// - new: тип оболочки TnsShellType
//
// Revision 1.58  2004/03/02 15:12:55  am
// change: чистка тип сортировка\порядок сортировки
//
// Revision 1.57  2004/02/27 09:29:13  demon
// - new behavior: поддержка операции Reset для сброса состояния деревьев атрибутов в истории
//
// Revision 1.56  2004/02/19 18:31:07  demon
// - fix: TLang переименован в TnsLanguage
//
// Revision 1.55  2004/02/17 10:23:19  am
// new: настройки.
//
// Revision 1.54  2004/02/16 14:11:54  demon
// - new: тип Action, для которых можно проверить права в папках
//
// Revision 1.53  2004/02/11 12:40:08  migel
// - add: новые настройка `Aктивировать язык по умолчанию`.
// - change: настройка `Язык по умолчанию` перенесена в группу `Локализация`.
//
// Revision 1.52  2004/02/10 14:41:44  am
// *** empty log message ***
//
// Revision 1.51  2004/02/09 15:04:29  am
// new: Словарь толкований
//
// Revision 1.50  2004/02/09 08:31:45  demon
// - new const: _cNullInterface
//
// Revision 1.49  2004/02/05 08:42:27  demon
// - fix: Типы сортировки "На контроле"
//
// Revision 1.48  2004/02/05 08:34:53  demon
// - add: Типы сортировки "На контроле"
//
// Revision 1.47  2004/02/03 08:37:27  demon
// - new: _TnsFolderFilter (виды фильтрации папок)
//
// Revision 1.46  2004/01/16 06:43:28  demon
// - new: константа cNullDate вынесена в nsTypes
//
// Revision 1.45  2003/12/27 19:29:18  law
// - new behavior: пользовательские комментарии добавляются в оглавление (CQ OIT5-5708).
//
// Revision 1.44  2003/12/26 16:02:28  demon
// - new behavior: BreafSelectionAttributesTag теперь содержит только KW и то временно. Типы доступных операций читаются из DataAdapter.TagSearchList
//
// Revision 1.43  2003/12/24 08:41:37  demon
// - new: Select from folders type
//
// Revision 1.42  2003/12/17 14:36:11  dk3
// new settings
//
// Revision 1.41  2003/12/11 13:00:50  demon
// - new const
//
// Revision 1.40  2003/11/30 11:40:49  law
// - change: используем автогенерированные типы пользовательских объектов. Почистил nsTypes.
//
// Revision 1.39  2003/11/27 11:00:33  demon
// - add: типы Warning'ов
//
// Revision 1.38  2003/11/20 13:23:07  step
// добавлены функции преобразования типов Integer <-->LongWord
//
// Revision 1.37  2003/11/05 17:52:02  law
// - new behavior: сделан переход из оглавления на картинку.
//
// Revision 1.36  2003/10/15 13:45:05  demon
// - new: расширен тип TQueryFormType
// - add: операция проверки соответствия типа запроса типу формы.
//
// Revision 1.35  2003/10/14 09:29:11  demon
// - new: Описание констант для получения настроек вынесены в модуль nsSettings
//
// Revision 1.34  2003/10/09 16:54:32  migel
// - add/change: поддержка иконок на закладках
//
// Revision 1.33  2003/10/09 09:25:07  migel
// - add: поддержка иконок на закладках в `ChildZone` (пока не востанавливаются переходами по истории)
//
// Revision 1.32  2003/10/07 14:36:00  demon
// - new: Attribute tag constants
//
// Revision 1.31  2003/10/06 13:42:06  demon
// - new behavior: Изменены типы для SaveLoadForm.
//
// Revision 1.30  2003/09/15 17:10:02  demon
// - new: FolderInfo type
//
// Revision 1.29  2003/09/12 10:02:20  demon
// - new: типы контейнеров для ППР
//
// Revision 1.28  2003/09/10 16:08:21  demon
// - new: SelectionType moved to nsTypes
//
// Revision 1.27  2003/09/10 10:08:45  demon
// - add: функция конвертации типов ссылок из внутреннего формата в формат в редакторе.
//
// Revision 1.26  2003/09/08 15:23:04  demon
// - new: тип списка для "СКР к части документа"
//
// Revision 1.25  2003/09/08 15:04:55  demon
// - new: тип для запрета части операций при выборе словарных атрибутов.
// - add: функция конвертации типов ссылок в редакторе во внутренний тип.
//
// Revision 1.24  2003/09/05 10:10:57  demon
// - fixed: операции конвертации Дат и Интервалов дат в строчки.
//
// Revision 1.23  2003/09/05 08:37:26  demon
// - new: операции конвертации Дат и Интервалов дат в строчки.
//
// Revision 1.22  2003/09/03 18:17:16  demon
// - new: добавлен тип указателя на позицию в документе
//
// Revision 1.21  2003/09/01 09:13:25  demon
// - add: новый тип сохраненного в папках объекта "Фильтр"
//
// Revision 1.20  2003/08/28 08:51:06  demon
// - new: типы для контэйнера SaveLoad
//
// Revision 1.19  2003/08/20 14:11:34  demon
// - new: тип формы списка Saved .
//
// Revision 1.18  2003/08/13 14:36:51  demon
// - new: изменены имена типов элементов папок, добавлен fetNone
//
// Revision 1.17  2003/08/11 18:13:38  demon
// - new: типы сохраняемых объектов для папок
//
// Revision 1.16  2003/08/08 13:22:38  demon
// - del: убран тип fiNew
//
// Revision 1.15  2003/08/07 17:16:07  demon
// - new: Новый тип доп. информации в папках.
//
// Revision 1.14  2003/08/06 15:21:26  demon
// - new: константы типов дополнительной информации в папках
//
// Revision 1.13  2003/08/06 08:28:07  demon
// - add log messages
//

interface

uses
  SysUtils,

  l3Interfaces,
  l3Base,

  bsTypes,

  BaseTypesUnit,
  LoggingUnit,
  IOUnit,
  FoldersUnit,

  nsTypesNew
  ;

{------------------------------------------------------------------------------}
{ nsNodeNotiferEvents                                                          }
{------------------------------------------------------------------------------}
const
  nne_ResetChildrenCount = 1000;
    // - событие сброса детей;
const
{------------------------------------------------------------------------------}
{ Пользовательские флаги дерева.                                               }
{------------------------------------------------------------------------------}
  cOrBitFlag  = 4;
  cAndBitFlag = 8;
  cNotBitFlag = 16;
{------------------------------------------------------------------------------}
type
  TnsNavigatorItemParams = record
   {* Параметры поиска элемента дерева навигатора. }
    rId: TNavigatorMenuItemType;
     // - идентификатор элемента навигатора;
    rLevel: Integer;
     // - до какого уровня вложенности искать;
  end;//TnsNavigatorItemParams

  TnsFileFormat = nsTypesNew.TnsFileFormat;
const
  ns_ffRTF = nsTypesNew.ns_ffRTF;
  ns_ffTxt = nsTypesNew.ns_ffTxt;
  ns_ffHTML = nsTypesNew.ns_ffHTML;
  ns_ffXML = nsTypesNew.ns_ffXML;
  ns_ffEvd = nsTypesNew.ns_ffEvd;
  ns_ffNull = nsTypesNew.ns_ffNull;
  ns_ffPDF = nsTypesNew.ns_ffPDF;
  {* - Тип формата файла }
type
  TnsFilterType = (
  {* - дополнительный тип фильтрации для деревьев атрибутов. }
    ns_ftNone,    // никаких дополнительных фильтров
    ns_ftTrim,    // При создании дерева атрибутов нужно накладывать дополнительный фильтр ITrimFilter
    ns_ftTrimLeaf,// При создании дерева атрибутов нужно накладывать дополнительный фильтр ITrimLeafFilter
    ns_ftBlocks,  // При создании дерева атрибутов нужно накладывать дополнительный фильтр IBlocksFilter
    ns_ftInpharm  // Для фильтрации узла инфарама
  );//TnsFilterType

  TnsMedicMainMenuNodeType = (
  {* Узел основного меню. }
    ns_mntSearchDrug,       // Поиск лекарственного средства
    ns_mntAllDrugList,      // Лекарственные средства
    ns_mntFirms,            // Фирмы производители
    ns_mntDiction,          // Словарь медицинских терминов
    ns_mntDrugList,         // Открыть список
    ns_mntDocument,         // Документ
    //ns_mntHelp,             // Руководство пользователя
    ns_mntPublishSource,    // СМИ по медицине и здравоохранению
    ns_mntLegislationReview // Обзор изменений законодательства
  );//TnsMedicMainMenuNodeType

  TnsLongProcessType = (lptUpdate, lptProcessWithExit, lptProcessWithoutExit);

  TListLogicOperation = nsTypesNew.TListLogicOperation;
const
  {* Логические операции со списками. }
    LLO_AND = nsTypesNew.LLO_AND;
    LLO_OR = nsTypesNew.LLO_OR;
    LLO_AND_NOT = nsTypesNew.LLO_AND_NOT;
    LLO_NONE = nsTypesNew.LLO_NONE;
type
  TnsShowSynchroForm = (
    ssfNone,
    ssfText,
    ssfRelated,
    ssfAttribute,
    ssfAnnotation,
    ssfSimilarDocuments
  );//TnsShowSynchroForm

  TDocumentBookmarkTypes = (
    dbtUsual,
    dbtCommon,
    dbtJournal
  );

  TnsChangeRedactionType = (
    crtActual,
    crtPrevious,
    crtNext,
    crtID
  );

  TnsEmptyDocumentType = (
    edtMissing,
    edtRelated
  );

  TFoldersItemTypes = set of TFoldersItemType;

  TSelectionType = (
    stUnknown,
    stRespondents,
    stCorrespondents
  );

  TWarningType = (
    wtNone,
    wtUsual,
    wtNotActualEdition,
    wtTimeMachineWarning,
    wtNotSure
  );

  TWarningTypeSet = set of TWarningType;

  TnsResetTreeStatus = (
    rtsNone,
    rtsRoot,
    rtsFullRoot,
    rtsOneLevel
  );

  TnsShellType = (
    shltNone,
    shltDesktop,
    shltNetwork
  );

  TnsDeleteResult = (
    drOk,
    drCancel,
    drDenied
  );

  TnsNavigatorFormPositionType = (
  {* Типы положений формы в области навигатора. }
   nfpLeftNavigator,
   nfpRightNavigator,
   nfpFloating);

  TnsExportKind = (
   ekDisk,
   ekShell,
   ekEMail,
   ekActiveWord
  );

  TnsMainMenuKind = (
  // Вид основного меню
   mmk_ProfNews, // С профессиональными новостями (необходим постоянный доступ в Интернет)
   mmk_Default   // Стандартный вид
  );

  ETryOpenMissingDocument = class(Exception);

function DateToString(aDate : BaseTypesUnit.TDate) : Il3CString;
  {-}
function IntervalToString(aStart, aFinish : BaseTypesUnit.TDate) : Il3CString;
  overload;
function IntervalToString(aInterval : BaseTypesUnit.TDateInterval) : Il3CString;
  overload;
  {-}
function IsDateEqual(aFirstDate, aSecondDate : BaseTypesUnit.TDate) : Boolean;
function IsNullDate(aDate : BaseTypesUnit.TDate) : Boolean;
  {-}
function EdtSubTypeToDocPosType(aSubType : Integer) : TDocumentPositionType;
function DocPosTypeToEdtSubType(aDocType : TDocumentPositionType) : Integer;
  {-}
function StrToLang(const aStr: Il3CString): TbsLanguage;
  {-}
function nsWStr(const aString: Il3CString): Tl3WString;
  overload;
function nsWStr(const aString: IString): Tl3WString;
  overload;
function nsWStr(const aString: AnsiString): Tl3WString;
  overload;
  {-}
function nsCStr(const aString: AnsiString): Il3CString;
  overload;
function nsCStr(const aString: WideString): Il3CString;
  overload;
function nsCStr(const aString: Tl3WString): Il3CString;
  overload;
function nsCStr(const aString: IString): Il3CString;
  overload;
  {-}
function nsCStr(const aString: TnsStringPair): Il3CString;
  overload;
  {-}
function nsIStr(const aString: Il3CString): IString;
  overload;
  {-}
function nsIStr(const aString: Tl3WString): IString;
  overload;
  {-}
function nsIStr(const aString: PAnsiChar): IString;
  overload;
  {-}
function nsIStr(const aString: TnsStringPair): IString;
  overload;
  {-}
function nsAStr(const aString: Tl3WString): Il3AString;
  overload;
function nsAStr(const aString: Il3CString): Il3AString;
  overload;
function nsAStr(const aString: AnsiString): PAnsiChar;
  overload;
function nsAStr(const aString: PAnsiChar): PAnsiChar;
  overload;
  {* - преобразует строку к типу, необходимому для входных параметров адаптера. }
function nsEStr(const aString: Tl3WString): AnsiString;
  overload;
function nsEStr(const aString: Il3CString): AnsiString;
  overload;
  {* - преобразует строку к типу, необходимому для создания исключения. }
function nsFStr(const aString: Tl3WString): Il3CString;
  {* - преобразует строку к типу, необходимому для функции форматирования. }
function nsStrToDate(const aSt: Il3CString): System.TDateTime;
  {-}

implementation

uses
  vcmBase,

  l3Chars,
  l3Date,
  l3String,
  l3CacheableBase,

  evdTypes,
  
  evTypes,

  nsConst,
  nsCString,
  nsString,
{$If not (defined(Monitorings) or defined(Admin))}
  nsValueMapsIDs,
  nsValueMaps,
{$IfEnd not (defined(Monitorings) or defined(Admin))}

  StdRes,

  bsTypesNew,

  DataAdapter,

  afwAString
  ;

function DateToString(aDate : BaseTypesUnit.TDate) : Il3CString;
var
 l_S : String;
begin
 if (aDate.rDay <> 0) then
 begin
  DateTimeToString(l_S, l3Date.DefDateFormat(True),
   EncodeDate(aDate.rYear, aDate.rMonth, aDate.rDay));
   // - получим дату с двумя цифрами для месяца и дня, в соответствии с
   //   региональными настройками (1/4/2003 -> 01/04/2003);
  Result := nsCStr(l_S); 
 end//aDate.rDay <> 0
 else
  Result := nil;
end;

function IntervalToString(aStart, aFinish : BaseTypesUnit.TDate) : Il3CString;
var
 l_StrStart : Il3CString;
 l_StrFinish : Il3CString;
begin
 Result := nil;
 l_StrStart := DateToString(aStart);
 l_StrFinish := DateToString(aFinish);
 if not l3IsNil(l_StrStart) then
 begin
  if not l3IsNil(l_StrFinish) then
   if IsDateEqual(aStart, aFinish) then
    Result := l_StrStart
   else
    Result := vcmFmt(str_DateIntervalFromTo, [l_StrStart, l_StrFinish])
  else
   Result := vcmFmt(str_DateIntervalFrom, [l_StrStart]);
 end;//l_StrStart <> ''
end;

function IntervalToString(aInterval : BaseTypesUnit.TDateInterval) : Il3CString;
begin
 Result := IntervalToString(aInterval.rStart, aInterval.rFinish);
end;

function IsDateEqual(aFirstDate, aSecondDate : BaseTypesUnit.TDate) : Boolean;
begin
 Result := aFirstDate.rYear = aSecondDate.rYear;
 if Result then
 begin
  Result := aFirstDate.rMonth = aSecondDate.rMonth;
  if Result then
   Result := aFirstDate.rDay = aSecondDate.rDay;
 end;
end;

function IsNullDate(aDate : BaseTypesUnit.TDate) : Boolean;
begin
 Result := IsDateEqual(aDate, cNullDate);
end;

function EdtSubTypeToDocPosType(aSubType : Integer) : TDocumentPositionType;
begin
 case aSubType of
  Ord(ev_sbtSub):
   Result := dptSub;
  Ord(ev_sbtMarker):
   Result := dptMarker;
  Ord(ev_sbtBookmark):
   Result := dptBookmark;
  ev_sbtPara:
   Result := dptPara;
  Ord(ev_sbtMark):
   Result := dptMark;
  ev_sbtDocumentPlace:
   Result := dptDocumentPlace;
  else
   Result := dptNone;
 end;
end;

function DocPosTypeToEdtSubType(aDocType : TDocumentPositionType) : Integer;
begin
 case aDocType of
  dptNone,
  dptSub:
   Result := Ord(ev_sbtSub);
  dptMarker:
   Result := Ord(ev_sbtMarker);
  dptBookmark:
   Result := Ord(ev_sbtBookmark);
  dptPara:
   Result := ev_sbtPara;
  dptMark:
   Result := Ord(ev_sbtMark);
  dptDocumentPlace:
   Result := ev_sbtDocumentPlace;
  else
   Result := Ord(ev_sbtNone);
 end;
end;

function StrToLang(const aStr: Il3CString): TbsLanguage;
begin
{$If not (defined(Monitorings) or defined(Admin))}
 Result := TbsLanguage(nsIntegerMapManager.Map[imap_IfaceLanguage].DisplayNameToValue(aStr));
{$ELSE Monitorings}
 Result := LG_RUSSIAN;
{$IfEnd not (defined(Monitorings) or defined(Admin))}
end;

function nsWStr(const aString: Il3CString): Tl3WString;
  //overload;
  {-}
begin
 Result := l3PCharLen(aString);
end;

function nsWStr(const aString: IString): Tl3WString;
  //overload;
  {-}
begin
 if (aString = nil) then
  l3AssignNil(Result)
 else
  Result := l3PCharLen(aString.GetData, aString.GetLength, aString.GetCodePage);
end;

function nsWStr(const aString: AnsiString): Tl3WString;
  //overload;
  {-}
begin
 Result := l3PCharLen(aString);
end;

function nsCStr(const aString: AnsiString): Il3CString;
  //overload;
begin
 Result := TnsCDelphiString.MakeI(aString);
end;

function nsCStr(const aString: WideString): Il3CString;
  //overload;
begin
 Result := TnsCWideString.MakeI(aString);
end;

function nsCStr(const aString: Tl3WString): Il3CString;
  //overload;
begin
 Result := TnsCString.MakeI(aString);
end;

function nsCStr(const aString: IString): Il3CString;
  //overload;
begin
 Result := TnsNewConstString.MakeI(aString);
end;

function nsCStr(const aString: TnsStringPair): Il3CString;
  {-}
begin
 if (aString.rIl3CString <> nil) then
  Result := aString.rIl3CString
 else
  Result := nsCStr(aString.rIString);
end;

function nsIStr(const aString: Il3CString): IString;
  {-}
begin
 Result := defDataAdapter.NativeAdapter.MakeString(nsAStr(aString).S);
end;

function nsIStr(const aString: Tl3WString): IString;
  {-}
begin
 Result := defDataAdapter.NativeAdapter.MakeString(nsAStr(aString).S);
end;

function nsIStr(const aString: PAnsiChar): IString;
  {-}
begin
 Result := defDataAdapter.NativeAdapter.MakeString(aString);
end;

function nsIStr(const aString: TnsStringPair): IString;
  {-}
begin
 if (aString.rIString <> nil) then
  Result := aString.rIString
 else
  Result := nsIStr(aString.rIl3CString);
end;

type
  TnsAString1 = class(Tl3String, Il3AString)
    private
    // internal fields
      f_Tmp : AnsiString;
    protected
    // internal methods
      function S: PAnsiChar;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function MakeI(const aStr: Tl3WString): Il3AString;
        reintroduce;
        {-}
  end;//TnsAString1

class function TnsAString1.MakeI(const aStr: Tl3WString): Il3AString;
  //reintroduce;
  {-}
var
 l_S : TnsAString1;
begin
 l_S := Make(aStr);
 try
  Result := l_S;
 finally
  l3Free(l_S);
 end;//try..finally
end;

procedure TnsAString1.Cleanup;
  //override;
  {-}
begin
 f_Tmp := '';
 inherited;
end;

function TnsAString1.S: PAnsiChar;
  {-}
var
 l_S : Tl3WString;  
begin
 l_S := AsWStr;
 if (l_S.SCodePage = CP_ANSI) then
 begin
  Result := l_S.S;
  Assert(l_S.SLen >= l3StrLen(Result));
 end//l_S.SCodePage = CP_ANSI
 else
 begin
  f_Tmp := l3Str(AsWStr);
  Result := PAnsiChar(f_Tmp);
 end;//l_S.SCodePage = CP_ANSI
end;

function nsAStr(const aString: Tl3WString): Il3AString;
  //overload;
  {-}
begin
 Result := TnsAString1.MakeI(aString);
end;

type
  TnsAString = TafwAString;

function nsAStr(const aString: Il3CString): Il3AString;
  //overload;
  {-}
begin
 Result := TnsAString.Make(aString);
end;

function nsAStr(const aString: AnsiString): PAnsiChar;
//  overload;
  {-}
begin
 Result := PAnsiChar(aString);
end;

function nsAStr(const aString: PAnsiChar): PAnsiChar;
  overload;
  {-}
begin
 Result := aString;
end;

function nsEStr(const aString: Tl3WString): AnsiString;
  {-}
begin
 Result := l3Str(aString);
end;

function nsEStr(const aString: Il3CString): AnsiString;
  //overload;
  {-}
begin
 Result := l3Str(aString);
end;

function nsFStr(const aString: Tl3WString): Il3CString;
  //overload;
begin
 Result := Tl3ConstString.MakeI(aString);
end;

function nsStrToDate(const aSt: Il3CString): System.TDateTime;
  {-}
begin
 Result := StrToDate(l3Str(aSt));
end;

end.
