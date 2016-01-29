unit nsFolderNodes;

// $Id: nsFolderNodes.pas,v 1.23 2015/02/26 09:26:29 kostitsin Exp $

// $Log: nsFolderNodes.pas,v $
// Revision 1.23  2015/02/26 09:26:29  kostitsin
// List*ner -> Listener
//
// Revision 1.22  2015/02/25 13:52:03  kostitsin
// List*ner -> Listener
//
// Revision 1.21  2015/01/28 12:05:52  kostitsin
// рисуем Tl3PrimNode
//
// Revision 1.20  2013/07/29 14:10:37  morozov
// {RequestLink: 474594335}
//
// Revision 1.19  2013/06/03 11:51:36  kostitsin
// [$457094183]
//
// Revision 1.18  2013/05/20 09:44:53  morozov
// {RequestLink:440894636}
//
// Revision 1.17  2012/10/30 11:26:22  kostitsin
// В Tl3CustomTreeView вынес реализацию CompareChild в DoCompareChild
//
// Revision 1.16  2012/04/25 17:35:09  lulin
// {RequestLink:276534196}
//
// Revision 1.15  2011/10/17 16:50:43  lulin
// {RequestLink:268346048}.
//
// Revision 1.14  2011/10/17 13:22:29  lulin
// {RequestLink:276536832}.
//
// Revision 1.13  2011/06/20 15:17:54  lulin
// {RequestLink:269083814}.
//
// Revision 1.12  2010/12/16 19:05:26  lulin
// {RequestLink:244194233}.
//
// Revision 1.11  2010/10/14 14:41:52  oman
// - new: пытаемся редактировать {RequestLink:235057812}
//
// Revision 1.10  2010/10/13 12:59:44  oman
// - new: подчищаем {RequestLink:235057812}
//
// Revision 1.9  2010/10/13 08:20:31  oman
// - new: нотификация {RequestLink:235057812}
//
// Revision 1.8  2010/10/07 14:13:08  oman
// - new: Переносим заглушки на модель {RequestLink:235057812}
//
// Revision 1.7  2010/10/04 12:32:36  oman
// - new: Заглушки и не падаем {RequestLink:235057812}
//
// Revision 1.6  2010/03/19 08:21:56  oman
// - fix: Переводим на новые рельсы {RequestLink:197494291}
//
// Revision 1.5  2010/03/18 14:35:18  oman
// - fix: Готовим потроха {RequestLink:197494291}
//
// Revision 1.4  2009/10/21 12:37:42  lulin
// - переносим на модель базовые ноды.
//
// Revision 1.3  2009/10/21 10:05:35  lulin
// - перегенерация.
// - чистка кода.
//
// Revision 1.2  2009/10/20 07:18:28  oman
// - fix: {RequestLink:167347348}
//
// Revision 1.1  2009/10/14 12:20:08  lulin
// - добиваемся отсутствия Warning'ов при генерации проектов F1.
//
// Revision 1.186  2009/09/28 16:16:03  lulin
// - вызов диалога сохранения объекта в папки переведён на фабрику.
//
// Revision 1.185  2009/09/09 07:25:14  oman
// - new: Удаление из общих {RequestLink:162077063}
//
// Revision 1.184  2009/09/08 08:59:55  oman
// - new: {RequestLink:162077063}
//
// Revision 1.183  2009/09/08 07:18:41  oman
// - new: {RequestLink:162077063}
//
// Revision 1.182  2009/09/08 06:53:27  oman
// - new: {RequestLink:162077063}
//
// Revision 1.181  2009/09/08 06:07:03  oman
// - new: {RequestLink:162077086}
//
// Revision 1.180  2009/09/02 11:49:16  lulin
// {RequestLink:159360578}. №20.
//
// Revision 1.179  2009/08/31 13:23:56  lulin
// {RequestLink:159360578}. №11.
//
// Revision 1.178  2009/08/24 08:36:43  lulin
// - переносим системные операции на модель.
//
// Revision 1.177  2009/08/19 11:07:13  oman
// - new: Зачистка - {RequestLink:159355458}
//
// Revision 1.176  2009/08/19 09:57:23  oman
// - fix:  КОнчились модули... - {RequestLink:159359346}
//
// Revision 1.175  2009/08/10 09:36:49  oman
// - fix: Первое приближение - {RequestLink:159354768}
//
// Revision 1.174  2009/07/30 09:01:15  oman
// - fix: {RequestLink:157909690}
//
// Revision 1.173  2009/07/23 08:15:05  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.172  2009/04/10 09:36:02  oman
// - fix: Аккуратней подписываемся на нотификацию - [$142613480]
//
// Revision 1.171  2009/02/10 19:03:26  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.170  2009/02/10 13:34:37  lulin
// - <K>: 133891247. Выделяем интерфейсы профайлеров.
//
// Revision 1.169  2009/02/09 11:57:09  lulin
// - <K>: 133891247.
//
// Revision 1.168  2009/01/22 09:43:30  lulin
// - <K>: 135605082. Избавляемся от ненужных запросов интерфейсов.
//
// Revision 1.167  2009/01/22 08:55:38  lulin
// - <K>: 135605082.
//
// Revision 1.166  2009/01/21 19:18:09  lulin
// - <K>: 135602528.
//
// Revision 1.165  2009/01/21 08:09:07  oman
// - fix: Забыли про инфарм (К-133892891)
//
// Revision 1.164  2009/01/20 11:26:01  oman
// - fix: Пытаемся грузить фильтры асинхронно сразу после папок (К-133892891)
//
// Revision 1.163  2008/12/25 12:19:57  lulin
// - <K>: 121153186.
//
// Revision 1.162  2008/12/24 19:49:20  lulin
// - <K>: 121153186.
//
// Revision 1.161  2008/12/02 10:28:17  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=16351568&focusedCommentId=127766910#comment-127766910
//
// Revision 1.160  2008/11/05 16:26:37  lulin
// - <K>: 121167571.
//
// Revision 1.159  2008/09/26 10:45:07  oman
// - fix: Обрезаем имя при DnD (К-109904958)
//
// Revision 1.158  2008/08/15 05:47:34  mmorozov
// - bugfix: когда складывали в кеш объектов не очищали поле (<K>: 108627029);
//
// Revision 1.157  2008/08/13 09:14:07  mmorozov
// - bugfix: сброс выбранных в списке фильтров (K<96484569>);
//
// Revision 1.156  2008/08/12 11:25:43  lulin
// - <K>: 96484441.
//
// Revision 1.155  2008/07/28 16:05:35  mmorozov
// - bugfix: используем метод для проверки прав;
// - new: добавляем индекс к названию при перетаскивании из списка (K<104432822>);
//
// Revision 1.154  2008/07/28 11:28:50  mmorozov
// - new behaviour: при перемещении, если пользователь наводит на дочерний элемент, который не принимает объкты, то вставляем в родителя (K<104432944>);
//
// Revision 1.153  2008/07/18 17:15:31  mmorozov
// - bugfix:  Не сразу меняется имя документа на вкладке "на контроле"  (K<99647730>);
//
// Revision 1.152  2008/05/07 16:17:20  mmorozov
// new: постоянные фильтры;
//
// Revision 1.151  2008/04/21 10:53:43  mmorozov
// - new: при фильтрации элементов моих документов используется параметр для чего вызвали мои документы: документы | препараты.
//
// Revision 1.150  2008/04/16 07:50:36  mmorozov
// - new: созданы отдельные деревья фильтров для документа и препарата (K<89102296>).
//
// Revision 1.149  2008/04/15 06:26:45  mmorozov
// - new: добавление закладки на препарат к списку препаратов;
//
// Revision 1.148  2008/04/14 12:20:14  mmorozov
// - работа с моими документами из списка;
//
// Revision 1.147  2008/04/04 13:40:39  oman
// - new: Документ-препарат - Открываемся из папок (cq28562)
//
// Revision 1.146  2008/04/04 07:35:54  mmorozov
// - открываем документ и форму фильтров в списке препаратов;
//
// Revision 1.145  2008/03/25 14:09:04  mmorozov
// - new: типизируем rNode в структуре Tl3TreeData;
//
// Revision 1.144  2008/03/20 08:07:19  oman
// - new: Форма фильтров полнофункциональна (cq28560)
//
// Revision 1.143  2008/03/20 06:59:04  oman
// - new: допустимые типы фильтров переехали на дерево фильтров (cq28560)
//
// Revision 1.142  2008/03/03 07:37:16  mmorozov
// - bugfix: при перемещении проверяем права узла на добавление дочерних узлов (CQ: OIT5-28527);
//
// Revision 1.141  2008/02/21 13:39:26  mmorozov
// - change: при создании закладки на список оперируем IbsListTreeData (в рамках работы над CQ: OIT5-28331);
//
// Revision 1.140  2008/02/21 10:34:43  mmorozov
// - new behaviour: вставлять перемещать из списка можно только в папку мои документы (в рамках CQ: OIT5-28331);
//
// Revision 1.139  2008/02/19 13:34:48  mmorozov
// - new: устанавливаем новое название списка при сохранении\перемещении выделенных документов списка в мои документы (в рамках задачи CQ: OIT5-28331);
//
// Revision 1.138  2008/02/15 09:18:21  mmorozov
// - bugfix: при приёме узла не спрашивали CanMove (в рамках работы над CQ: OIT5-28331);
//
// Revision 1.137  2008/02/12 14:23:01  mmorozov
// - new: перетаскивание узлов из списка документов в мои документы, множественное выделение (CQ: OIT5-28331);
//
// Revision 1.136  2008/02/11 13:55:49  mmorozov
// - new: перетаскивание узлов из списка документов в мои документы, пока работает для одного узла (CQ: OIT5-28331);
//
// Revision 1.135  2008/02/09 13:56:59  mmorozov
// - new: перенос логики перетаскивания узлов, с формы "мои документы" на узлы дерева + подготовка к перетаскиванию из списка (CQ: OIT5-28331);
//
// Revision 1.134  2008/02/05 18:55:03  lulin
// - запрещаем напрямую устанавливать буфер строке.
//
// Revision 1.133  2008/01/31 12:09:12  mmorozov
// - warning fix;
//
// Revision 1.132  2008/01/14 09:58:50  oman
// - new: На выходе дожидаемся загрузки отложенных деревьев (cq27842)
//
// Revision 1.131  2008/01/10 07:23:37  oman
// Переход на новый адаптер
//
// Revision 1.130.4.1  2007/11/22 10:50:18  oman
// Перепиливаем на новый адаптер
//
// Revision 1.130  2007/10/09 07:06:46  oman
// - fix: Не фильтруем папки (cq25830, 26975)
//
// Revision 1.129  2007/08/14 14:29:52  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.128  2007/07/13 10:45:37  oman
// - fix: Для отфильтрованых папок выводим всплывающее окошко
//  по аналогии с пустыми (cq25830)
//
// Revision 1.127  2007/07/13 09:11:19  oman
// - fix: Не фильтруем пустые папки (cq25830)
//
// Revision 1.126  2007/07/13 07:55:11  oman
// - new: Новый фильтр "Списки и закладки" для Моих документов  (cq25830)
//
// Revision 1.125  2007/07/09 09:56:09  oman
// - fix: После отложенной загрузки папок применяем установленный
//  фильтр (cq25840)
//
// Revision 1.124  2007/03/20 09:27:05  lulin
// - используем строки с кодировкой.
//
// Revision 1.123  2007/03/14 19:02:40  lulin
// - вычистил мусор.
//
// Revision 1.122  2007/03/02 08:49:45  demon
// - new: добавлена группировка элементов папок по типу
//
// Revision 1.121  2007/03/01 13:52:46  demon
// - fix: не сортируем консультации
//
// Revision 1.120  2007/03/01 11:27:57  lulin
// - cleanup.
//
// Revision 1.119  2007/03/01 11:11:17  lulin
// - cleanup.
//
// Revision 1.118  2007/02/28 16:30:49  demon
// - new: сортировка папок после загрузки, D&D.
// - new: Операция сравнения папок
//
// Revision 1.117  2007/02/28 16:17:05  lulin
// - корректнее обрабатываем юникодные строки.
//
// Revision 1.116  2007/02/16 15:36:11  lulin
// - cleanup.
//
// Revision 1.115  2007/02/08 17:45:19  demon
// - fix: методы _ReloadChildren перенесены на объект TnsFoldersTree (используя интерфейс _InsReloadedTree)
// - new: в методе _LoadChildren добавлена сортировка (папки в начале - элементы потом)
//
// Revision 1.114  2007/02/02 09:10:44  lulin
// - упрощаем преобразование строк.
//
// Revision 1.113  2007/01/30 15:24:15  lulin
// - текст ноды - теперь более простого типа.
//
// Revision 1.112  2007/01/18 12:57:26  mmorozov
// - new: Простое основное меню (CQ: OIT5-23939);
//
// Revision 1.111  2007/01/15 19:22:39  lulin
// - избавился от внутренней операции модуля - по получению списка фильтров. Заодним почистил вылезшие преобразования от одного интерфейса к другому.
//
// Revision 1.110  2006/12/27 16:18:06  lulin
// - cleanup.
//
// Revision 1.109  2006/12/25 10:19:21  lulin
// - параметры строки теперь получаем одним вызовом, а не тремя.
//
// Revision 1.108  2006/12/22 11:47:33  lulin
// - не перевычисляем длину текста при работе с нодами.
//
// Revision 1.107  2006/11/03 09:45:49  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.106.2.1  2006/10/23 08:36:23  oman
// - new: Отложенная загрузка фильтров (cq23125)
//
// Revision 1.106  2006/09/25 13:00:49  mmorozov
// - new behaviour: фильтруем все папки кроме "Мои документы" при сохранении/открытии объектов из моих документов;
// - new behaviour: папка "Мои документы" не скрывается при фильтрации по типу объекта;
// - _move: интерфейсы перенесены в модуль _nsInterfaces;
//
// Revision 1.105  2006/09/13 09:46:11  oman
// - new beh: Поддержка свернуть/развернуть для новых деревьях -
//  убираение устаревших операций/интерфейсов(InsExpandedState)
//  /классов (cq22540)
//
// Revision 1.104  2006/05/12 12:42:55  oman
// - fix: Вкладку "Фильтры" сортируем без учета регистра (cq20603)
//
// Revision 1.103  2006/05/12 07:20:03  oman
// - new beh: Убрал в папках фильтры "на контролем" (cq19991)
//
// Revision 1.102  2006/04/20 14:31:21  lulin
// - распиливаем листы.
// - правим после Вовановых переименований методов.
//
// Revision 1.101  2006/04/19 14:36:20  lulin
// - cleanup.
//
// Revision 1.100  2005/11/09 15:28:21  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.99  2005/10/21 12:33:36  demon
// - fix: при выставлении флага "использовать как фильтр" всегда шлем нотификацию
//
// Revision 1.98  2005/08/29 16:09:12  demon
// - new behavior: Операция Open на ноде теперь возвращает IUnknown
//
// Revision 1.97  2005/08/25 12:51:55  demon
// - new behavior: Документы на контроле теперь не зависят от папок (код пока заремлен)
//
// Revision 1.96  2005/07/21 14:47:15  lulin
// - базовая виртуальная нода вынесена в отдельный модуль.
//
// Revision 1.95  2005/06/30 07:48:10  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.94  2005/06/28 12:59:27  demon
// - fix: после обновления не пересортировывался список документов на контроле.
//
// Revision 1.93  2005/04/12 15:29:00  dk3
// rename IControllable::get_name to get_short_name
// and fix IDocument::get_name
//
// Revision 1.92  2005/04/12 12:21:24  demon
// - new behavior: проверка флагов на ноде на принадлежность папке "Мои коментари"
//
// Revision 1.91  2005/04/06 10:12:38  demon
// - fix: запрет на редактирование папки "Мои документы"
//
// Revision 1.90  2005/03/04 15:32:33  dinishev
// _Move интерфейс InsFilterNode nsFoldersNode
//
// Revision 1.89  2005/01/21 15:52:17  demon
// - fix: неправильно сбрасывался счетчик использования фильтров при операции уничтожении формы с фильтрами.
//
// Revision 1.88  2005/01/21 13:53:09  demon
// - fix: неправильно снималось выделение при удалении последней ссылки на удаленный фильтр
//
// Revision 1.87  2005/01/18 14:51:20  demon
// - new behavior: разнесены нотификации об изменении и удалении нод из папок
//
// Revision 1.86  2005/01/18 12:44:01  demon
// - new behavior: новый тип нотификации при удалении элемента папок - fneJournalObjectDeleted
//
// Revision 1.85  2005/01/13 12:32:08  demon
// - fix: AV при удалении папки, содержащей не последнюю закладку на контроле
//
// Revision 1.84  2004/12/28 12:30:00  demon
// - fix: нельзя ставить закладки из Журнала на контроль.
//
// Revision 1.83  2004/12/22 13:32:57  demon
// - new behavior: изменена семантика метода ChangeFilterStatus
//
// Revision 1.82  2004/12/14 16:04:02  demon
// - fix: не срабатывала нотификация о удалении глобальных фильтров из папок
//
// Revision 1.81  2004/12/10 16:34:47  demon
// - new behavior: новый вариант нотификации об изменении объектов в папках (еще не до конца доделан)
//
// Revision 1.80  2004/12/08 13:26:45  demon
// - new behavior: флаг принадлежности к фильтрам у запроса стал перечислимым (TFilterType).
//
// Revision 1.79  2004/12/08 11:11:18  demon
// - new behavior: Заготовка для отображения глобальных фильтров + D'n'D
//
// Revision 1.78  2004/11/24 11:44:43  demon
// - new behavior: расширен список флагов (и их сочетаний), который проверяется операцией _nsHasNodeAnyFlag
//
// Revision 1.77  2004/11/23 14:13:34  demon
// - new behavior: добавлен запрет на модификацию имен папок вложенных в журнал работ.
//
// Revision 1.76  2004/11/23 12:12:31  demon
// - new behavior: в логику проверки прав в папках встроена проверка на принадлежность "Журналу"
//
// Revision 1.75  2004/10/28 14:55:24  demon
// - new behavior: обработано исключение ECanNotFindData при вызове .Open на Node, т.к. оно легально может возникать при работе с общими папками.
//
// Revision 1.74  2004/10/14 11:45:19  demon
// - new behavior: при удалении закладки из папок посылаем нотификацию кэшу документов.
//
// Revision 1.73  2004/08/05 13:49:22  demon
// - cleanup: remove warnings and hints
//
// Revision 1.72  2004/08/05 13:06:46  demon
// - cleanup: remove warnings and hints
//
// Revision 1.71  2004/07/02 08:31:13  nikitin75
// try..except //TODO: нода "пропала" что делать?
//
// Revision 1.70  2004/07/02 06:10:39  nikitin75
// - GetFilterSinchro, GetControlSinchro fix
// - готовы к INode.DeleteNode throw EmptyResult
//
// Revision 1.69  2004/05/28 10:09:32  demon
// - fix: не правильно сбрасывался счетчик использованных фильтров при переходе по истории.
//
// Revision 1.68  2004/05/27 09:01:54  law
// - change: избавился от лишнего метода IsMyIntf - вместо него теперь всегда используется IsSame.
//
// Revision 1.67  2004/05/26 14:23:59  law
// - change: скрестил "ежа с ужом" (старые деревья с новыми).
//
// Revision 1.66  2004/05/24 09:18:35  demon
// - fix: неправильно выставлялось право редактирования для папок вложенных в RW шару.
//
// Revision 1.65  2004/05/07 09:55:49  demon
// - new behavior: модифицирована операция расчета прав для элементов папок.
//
// Revision 1.64  2004/04/13 12:06:47  law
// - optimization: метод IsMyIntf перенесен на Il3Node.
//
// Revision 1.63  2004/04/05 13:54:22  nikitin75
// - переходим на IStringOld;
//
// Revision 1.62  2004/04/01 10:24:44  demon
// - fix: невозможно было удалить или отредактировать закладку на отсутствующий в базе документ.
//
// Revision 1.61  2004/03/29 08:57:39  mmorozov
// new behaviour: права на изменение доступа;
//
// Revision 1.60  2004/03/29 07:42:20  demon
// - new: DropAllChildrenUserRightsCache на интерфейсе  InsNodeWithRights
//
// Revision 1.59  2004/03/05 10:08:34  demon
// - fix: использовали IBookmark, вместо _IBaseEntity
//
// Revision 1.58  2004/03/05 08:09:47  demon
// - new behavior: при рассылке нотификации документам посылаем им BookMark, который будет удален.
//
// Revision 1.57  2004/03/05 07:04:23  demon
// - new behavior: при удалении закладки из папок всем документам рассылается нотификация об этом.
//
// Revision 1.56  2004/03/03 18:05:08  law
// - rename unit: l3Tree2 -> l3Tree.
//
// Revision 1.55  2004/03/02 10:25:36  demon
// - new behavior: выделен общий предок для FoldersNode и FiltersNode - TnsNodeWithRights
//
// Revision 1.54  2004/02/24 14:45:54  demon
// - new behavior: изменена логика кэширования и получения списка пользователей имеющих права на папки
//
// Revision 1.53  2004/02/20 10:13:06  demon
// - new: возможность сброса закешированного заголовка
//
// Revision 1.52  2004/02/19 12:57:54  demon
// - fix: для папки в которой есть Shared запрещено менять права.
//
// Revision 1.51  2004/02/19 12:30:28  demon
// - new behavior: для папки в которой есть Shared запрещено менять права.
//
// Revision 1.50  2004/02/19 08:59:43  demon
// - new behavior: для папки вложенной в Shared запрещено менять права.
//
// Revision 1.49  2004/02/18 11:22:15  demon
// - fix: сброс кэширования списка пользователей DropUserRightsCache
//
// Revision 1.48  2004/02/18 10:58:09  demon
// - new: сброс кэширования списка пользователей DropUserRightsCache
//
// Revision 1.47  2004/02/18 10:26:10  demon
// - new: кэширование списка пользователей, которым разрешон доступ к папке.
//
// Revision 1.46  2004/02/17 09:42:31  demon
// - new behavior: добавлена дополнительная проверка прав в операции Delete в FolderNode (т.к. эта операция может быть вызвана внутри программы).
//
// Revision 1.45  2004/02/16 15:40:17  demon
// - fix: при проверке прав для элемента папок принудительно сбрасываем faChangeRights
//
// Revision 1.44  2004/02/16 14:09:05  demon
// - new: операция проверки прав на InsFoldeersNode (для любого элемента папок). Права после первого получения кэшируются на ноде
//
// Revision 1.43  2004/02/12 14:18:22  demon
// - fix: провервка на то, что объект еще стоит на контроле при удалении из списка "На контроле"
//
// Revision 1.42  2004/02/12 10:36:26  demon
// - fix: Integer Overflow при сортировке
//
// Revision 1.41  2004/02/11 15:49:57  demon
// - new behavior: возможность хранения флага IsOpened для документов на контроле
//
// Revision 1.40  2004/02/11 13:46:19  demon
// - syntax fix
// - logic fix: в связи с изменениями интерфейсов сервера удален объект TnsUnderControlDocumentNode (теперь все ноды на контроле одинаковые)
//
// Revision 1.39  2004/02/06 16:34:22  demon
// - fix: упрощены операции проверки Shared и Extended
//
// Revision 1.38  2004/02/06 13:54:34  demon
// - new behavior: при прверке папки при удалении заранее стираем на сервере контролируемые объекты (для правильной работы синхронизации).
//
// Revision 1.37  2004/02/05 14:15:34  demon
// - new: операция SetUnderControlStatus для принудительной установки/снятия статуса на контроле
//
// Revision 1.36  2004/02/05 10:28:48  demon
// - fix: refresh tree при смене статуса у элемента
//
// Revision 1.35  2004/02/05 09:29:54  demon
// - new: при удалении Node из списка "На контроле" объект автоматически снимается с контроля.
//
// Revision 1.34  2004/02/05 08:43:56  demon
// - delete: Типы сортировки "На контроле" (перенесены в nsTypes)
//
// Revision 1.33  2004/02/05 07:06:07  demon
// - new behavior: интерфейс для получения и сброса статуса изменений на UnderControlNode
//
// Revision 1.32  2004/02/05 06:41:33  kool
// syntax fix
//
// Revision 1.31  2004/02/04 14:24:14  demon
// - new: отремлены строчки, ранее не поддерживавшиеся адаптером
//
// Revision 1.30  2004/02/04 14:10:31  demon
// - new: при фильтрации для постановки на контроль убираем все shared папки
//
// Revision 1.29  2004/02/04 12:43:40  demon
// - new behavior: в папках можно запретить смену фильтра.
//
// Revision 1.28  2004/02/03 13:40:13  demon
// - new: интерфейс и реализация для поддержки синхронизации папок и списка документов на контроле (при удалении из папок, и изменении статуса)
//
// Revision 1.27  2004/02/03 08:38:59  demon
// - new behavior: перешли на тип TnsFolderFilter с TFoldersElementType
// - new behavior: Реализация фильтрации "На контроле"
//
// Revision 1.26  2004/02/03 06:38:51  demon
// - new behavior: TnsUnderControlDocumentNode берет имя из храняшейся внутри ссылки на документ
//
// Revision 1.25  2004/02/02 13:34:19  demon
// - new: реализация TnsUnderControlDocumentNode для сохранения закладок, как "документов на контроле"
//
// Revision 1.24  2004/02/02 10:33:24  demon
// - new: реализация Tree и RootNode для "документов на контроле" (с возможностью сортировки по типу изменений)
//
// Revision 1.23  2004/02/02 07:59:21  demon
// - new: базовая реализация Node для "документов на контроле"
//
// Revision 1.22  2004/01/23 10:40:32  demon
// - fix: в связи с изменением интерфеса работы с папками (Query_filter теперь определяется через флаги, а не object_type).
//
// Revision 1.21  2004/01/15 08:49:01  demon
// - fix: resolve cycling references with nsFolders
//
// Revision 1.20  2003/12/10 07:11:35  law
// - change: подготавливаемся к расчету NumInParent в процессе создания нод.
//
// Revision 1.19  2003/10/09 07:37:52  demon
// - fix: warning clean
//
// Revision 1.18  2003/09/16 13:57:44  demon
// - new: при кэшировании строчек стал использоваться объект Tl3String
//
// Revision 1.17  2003/09/01 16:47:23  demon
// - add: операция прямого изменения флага IsFiltered.
//
// Revision 1.16  2003/09/01 14:10:27  demon
// - new: фильтрация пустых папок после удаления элементов.
//
// Revision 1.15  2003/09/01 13:04:18  demon
// - new: фильтрация элементов после добавления
// - new: сброс фильтрации при создании папки.
//
// Revision 1.14  2003/09/01 11:22:13  demon
// - new: операция фильтрация теперь реализована на дереве папок (TreeSource).
//
// Revision 1.13  2003/09/01 10:59:30  demon
// - new: информация о фильтрации и expand теперь хранится не на RootNode, а на дереве (TreeSource).
//
// Revision 1.12  2003/08/29 16:01:39  demon
// - new: сохранение информации о фильтре по типу в папках
//
// Revision 1.11  2003/08/26 13:20:18  demon
// - bug fix: при удалении папки теперь удаляются и вложенные в нее фильтры (если они там были).
//
// Revision 1.10  2003/08/21 13:14:36  demon
// - new: синхронизация состояния фильтров при попадании оных в историю.
//
// Revision 1.9  2003/08/21 11:17:39  demon
// - new: подсчет count'а использования фильтра.
//
// Revision 1.8  2003/08/21 09:16:42  demon
// - bug fix: Не работало удаление Query из папок.
//
// Revision 1.7  2003/08/20 16:05:09  demon
// - new: добавлена нотификация об удалении запросов и изменении их статуса.
//
// Revision 1.6  2003/08/20 11:25:01  demon
// - new: создана рутовая нода для папок с возможностью хранения дополнительной информации.
//
// Revision 1.5  2003/08/15 09:50:18  demon
// - new: Node для дерева фильтров
//
// Revision 1.4  2003/08/12 11:39:14  demon
// - new: добавлена синхронизация с БД при удалении элемента папок
//
// Revision 1.3  2003/08/08 13:20:15  demon
// - new: Временно (!!!) перекрыт метод Set_ST для отработки операций изменить имя.
//
// Revision 1.2  2003/08/07 17:17:25  demon
// - add: добавлен метод Make
//
// Revision 1.1  2003/08/06 16:35:44  demon
// - new: node - элемент дерева папок
//

interface

{$Include nsDefine.inc }

uses
  afwInterfaces,
  
  l3Interfaces,
  l3Types,
  l3Base,
  l3Tree,
  l3TreeInterfaces,
  l3Tree_TLB,
  l3IID,
  l3VirtualNode,

  eeInterfaces,

  BaseTreeSupportUnit,
  FiltersUnit,
  FoldersUnit,
  IOUnit,
  SecurityUnit,
  UnderControlUnit,
  DynamicTreeUnit,
  DynamicDocListUnit,

  bsTypes,
  
  nsTypes,
  nsNodes,
  nsAdapterDeferredTree,
  nsUnderControlRoot,

  bsInterfaces,
  FoldersDomainInterfaces
  ;

type
  TnsFoldersTree = class(TnsAdapterDeferredTree,
                         InsFoldersInfo,
                         InsReloadedTree,
                         InsFolderFilterInfoListener)
  private
  // fields
    f_FilterInfo       : InsFolderFilterInfo;
    f_CantChangeFilter : Boolean;
    f_NotifyObject     : Pointer; // InsFolderNodeNotifyObject
    f_RootListener     : Pointer; // InsDefferedTreeListener
  private
  // InsFolderFilterInfoListener
    procedure InsFolderFilterInfoListener_Changed;
    procedure InsFolderFilterInfoListener.Changed = InsFolderFilterInfoListener_Changed;
      {-}
  private
  // internal methods
    function  pm_GetFilterInfo: InsFolderFilterInfo;
    procedure pm_SetFilterInfo(const aValue : InsFolderFilterInfo);
      {-}
    function  pm_GetCantChangeFilter : Boolean;
    procedure pm_SetCantChangeFilter(aValue : Boolean);
      {-}
    function NodeHasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
      {-}
    function  GetNodeType(const aNode : Il3Node;
                          var aFlag   : Longint) : TFoldersItemType;
      {-}
    procedure SetNodeInvisible(const aNode: Il3Node);
      {-}
    procedure SetNodeVisible(const aNode: Il3Node);
      {-}
    function  ChangeNodeVisibility(const aNode: Il3Node) : Boolean;
      {-}
    procedure Filtrate;
      {-}
    class procedure LoadChildren(const aParent : Il3Node;
                                 aNeedSort     : Boolean = False);
      {-}
    procedure RemoveChildren(const aParent : Il3Node);
      {-}
    procedure ReloadChildren(const aNode: INode);
      overload;
      {-}
    procedure ReloadChildren(const aNode : Il3Node;
                             aNeedSort   : Boolean);
      overload;
      {-}
  private
  // properties
    property FilterInfo: InsFolderFilterInfo
      read pm_GetFilterInfo
      write pm_SetFilterInfo;
      {-}
  protected
  // methods
    function DoMakeRealRoot: Il3RootNode;
     override;
     {-}
    function MakeFakeRoot: Il3RootNode;
     override;
     {-}
    procedure DoSetBuildedRoot(const aNewRoot: Il3RootNode);
     override;
     {-}
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    procedure DoNotify(aOperation  : Integer;
                     const aNode : Il3SimpleNode);
      override;
      {-}
    constructor Create(const aNotifyObject: InsFolderNodeNotifyObject;
                       const aListener: InsDefferedTreeListener);
      reintroduce;
      {-}
    class function Make(const aNotifyObject: InsFolderNodeNotifyObject;
                        const aListener: InsDefferedTreeListener): Il3Tree;
      reintroduce;
      {-}
  end;//TnsFoldersTree

  TnsFoldersRoot = class(TnsCacheableNode,
                         InsFolderNodeNotifyObject,
                         InsFolderNodeNotification,
                         InsFolderNodeNotify,
                         InsFolderNodeListener)
    protected
     // internal methods
      function ChildNodeClass: Rl3CustomVirtualNode;
        override;
        {-}
    private
    // InsFolderNodeListener
      procedure ChildNodeDuplicated;
        {* - вызывается при попытке добавить узел с уже существующим названием. }
      procedure ChildNodeAdded(const aNode: Il3SimpleNode);
        {* - был добавлен дочерний узел. }
     function AllowMerge: TnsListMergeKind;
       {* Можно ли дописать в ноду }
    private
    // InsFolderNodeNotify
      procedure AddListener(const aListener: InsFolderNodeListener);
        {* - добавить слушателя. }
      procedure RemoveListener(const aListener: InsFolderNodeListener);
        {* - удалить слушателя. }
    private
     f_NotifyObject: Pointer;

     //interface InsFolderNodeNotification
     procedure ChangedNotify(const aNode : INode;
                             anEvent     : TFoldersNodeChangeEvent);
     procedure BeforeDeleteNotify(const aNode : INode;
                                  anEvent     : TFoldersNodeDeleteEvent);
     procedure AfterDeleteNotify(aFlags    : LongInt;
                                 aNodeType : TFoldersItemType);

     //interface InsFolderNodeNotifyObject
     procedure NodeChanged(const aNode : INode;
                           anEvent     : TFoldersNodeChangeEvent);
     procedure NodeBeforeDelete(const aNode : INode;
                                anEvent     : TFoldersNodeDeleteEvent);
     procedure NodeDeleted(aFlags    : LongInt;
                           aNodeType : TFoldersItemType);
    protected
     procedure Cleanup;
       override;
      procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
        override;
        {-}
    public
     class function Make(const aNode: INode;
                         const aNotifyObject: InsFolderNodeNotifyObject): IeeNode;
       reintroduce;
       {-}
  end;//TnsFoldersRoot

  TnsNodeWithRights = class(TnsCacheableNode, InsNodeWithRights)
  private
  // fields
    f_AcceptedRights   : TFoldersActionsSet;
    f_RestrictedRights : TFoldersActionsSet;
  private
  // internal methods
    procedure DropUserRightsCache;
      {-}
    procedure DropAllChildrenUserRightsCache;
      {-}
    procedure CountRights;
      {-}
    function  CheckRights(aAction: TFoldersActions) : Boolean;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  end;//TnsNodeWithRights

  TnsFoldersNode = class(TnsNodeWithRights, InsFoldersNode)
  private
  // internal methods
    function MakeDocumentBookmark(const aListRoot: INodeBase): Boolean;
      {* - создает закладку на документ из списка. }
    function MakeListBookmark(const aListData : IbsListTreeData): Boolean;
      {* - создает закладку на список созданный из выделенных узлов исходного
           списка. }
    function ExtendList(const aListData : IbsListTreeData): Boolean;
      {* - Дополняет список списком созданным из выделенных узлов исходного
           списка. }
    function IsNodeFromFolders(const aNode: Il3SimpleNode): Boolean;
      {* - определяет принадлежит ли узел дереву "мои документы". }
    procedure DropContentCache;
      {-}
    procedure SetDeleteBookmarkNotify(const aNode: INode);
      {-}
    procedure SetUnderControlStatus(aState : Boolean);
      {-}
    procedure ChangeUnderControlStatus;
    function pm_GetRoot: Il3SimpleNode;
      {-}
    function CanAcceptDataEx(const aData: Tl3TreeData;
                             aCheckParent: Boolean = True): Boolean;
      {* - может ли узел принять данные. }
  private
  // property
    property Root: Il3SimpleNode
      read pm_GetRoot;
      {* - корень дерева. }
  protected
  // methods
    function GetCanAcceptData(const aData: Tl3TreeData): Boolean;
      override;
      {* - может ли узел принять данные. }
    function DoDropData(const aData: Tl3TreeData): Boolean;
      override;
      {* - принять данные. }
    function GetCanMove: Boolean;
      override;
      {* определяет возможность перемещения узла }
  public
  // methods
      procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
        override;
        {-}
    procedure DoDelete;
      override;
      {-}
    function DoCompareChild(const aChildrenNode1, aChildrenNode2: Il3Node): Integer;
      override;
      {-}
  end;//TnsFoldersNode

  TnsUnderControlTree = class(Tl3Tree, InsUnderControlInfo)
   private
    f_SortType : TnsUCSortType;

    procedure ReSort;

    function  pm_getSortType: TnsUCSortType;
    procedure pm_setSortType(aValue: TnsUCSortType);
  end;//TnsUnderControlTree

 TnsAdapterFoldersFlags = (affNone, affExternal, affShared, affInExternal, affInComment);
 TnsAdapterFoldersFlagsSet = Set of TnsAdapterFoldersFlags;

 function nsHasNodeAnyFlag(const aNode : INode;
                           aFlags      : TnsAdapterFoldersFlagsSet): Boolean;
   overload;
 function nsHasNodeAnyFlag(const aNode : IeeNode;
                           aFlags      : TnsAdapterFoldersFlagsSet): Boolean;
   overload;
(* function nsHasNodeAnyFlag(const aNode : Il3Node;
                           aFlags      : TnsAdapterFoldersFlagsSet): Boolean;
   overload;*)

 function nsFindInsertPosition(const aRoot : Il3Node;
                               const aNode : INode): Il3Node;
   overload;
   {-}
 function nsFindInsertPosition(const aRoot : Il3Node;
                               const aName : Il3CString;
                               anIsFolder  : Boolean): Il3Node;
   overload;
   {-}
function GetIFolderFromINode(const aNode: INode) : IFolder;
  {-}

implementation

uses
  SysUtils,

  l3InterfacesMisc,
  l3Nodes,
  l3String,
  l3MinMax,
  l3TreeUtils,

  vcmBase,

  BaseTypesUnit,
  SearchUnit,
  DocumentUnit,

  bsUtils,

  nsTreeUtils,
  nsDocumentTools,
  nsUtils,
  nsFolderFilterInfo,

  StdRes,
  DataAdapter,

  FoldersChangeUserInteraction
  ;

function GetIFolderFromINode(const aNode : INode) : IFolder;
var
 lBaseEntity    : IUnknown;
 lFoldersNode   : IFoldersNode;
begin
 Result := nil;
 if Supports(aNode, IFoldersNode, lFoldersNode) then
 try
  { Рассматриваемая INode - папка }
  if (TFoldersItemType(aNode.GetObjectType) = FIT_FOLDER) then
  begin
   { Получим IFolder }
   try
    lFoldersNode.Open(lBaseEntity);
    try
     Supports(lBaseEntity, IFolder, Result);
    finally
     lBaseEntity := nil;
    end;
   except
    on ECanNotFindData do
     Exit; //TODO: нода "пропала" что делать?
   end
  end;
 finally
  lFoldersNode := nil;
 end;
end;

function nsHasNodeAnyFlag(const aNode: INode;
                          aFlags: TnsAdapterFoldersFlagsSet): Boolean; overload;
var
 l_Flags: Longint;
 l_ParentNode: INode;
begin
 Result := False;
 l_Flags := aNode.GetFlags;

 if affExternal in aFlags then
  Result := (l_Flags and NF_EXTERNAL = NF_EXTERNAL);

 if not Result and
    (affShared in aFlags) then
  Result := (l_Flags and NF_SHARED = NF_SHARED);

 if not Result and
    (affInExternal in aFlags) then
 begin
  Result := (l_Flags and NF_IN_SHARED = NF_IN_SHARED);
  if Result then
  begin
   aNode.GetParent(l_ParentNode);
   if l_ParentNode <> nil then
    Result := l_ParentNode.GetFlags and NF_EXTERNAL = NF_EXTERNAL
   else
    Result := False;
  end;
 end;

 if not Result and
    (affInComment in aFlags) then
  Result := (l_Flags and NF_COMMENTS = NF_COMMENTS) or
            (l_Flags and NF_IN_COMMENTS = NF_IN_COMMENTS);
end;

function nsHasNodeAnyFlag(const aNode: IeeNode;
                          aFlags: TnsAdapterFoldersFlagsSet): Boolean;
  overload;
var
 l_Node: INode;
begin
 if l3BQueryInterface(aNode, INode, l_Node) then
  Result := nsHasNodeAnyFlag(l_Node, aFlags)
 else
  Result := False;
end;

(*function nsHasNodeAnyFlag(const aNode: Il3Node;
                          aFlags: TnsAdapterFoldersFlagsSet): Boolean;
  overload;
var
 l_Node: INode;
begin
 if l3BQueryInterface(aNode, INode, l_Node) then
  Result := nsHasNodeAnyFlag(l_Node, aFlags)
 else
  Result := False;
end;*)

function nsFindNotifyObject(const aNode: IeeNode): InsFolderNodeNotifyObject;
var
 l_Parent: IeeNode;
begin
 Result := nil;
 l_Parent := aNode;
 while not l3BQueryInterface(l_Parent, InsFolderNodeNotifyObject, Result) do
  if Assigned(l_Parent) then
   l_Parent := l_Parent.ParentNode
  else
   break;
end;

procedure nsSendChangeNotify(const aNode: IeeNode; anEvent: TFoldersNodeChangeEvent;
                             const aINode: INode = nil);
var
 l_NotifyObject: InsFolderNodeNotifyObject;
 l_INode: INode;
begin
 l_NotifyObject := nsFindNotifyObject(aNode);
 if Assigned(l_NotifyObject) then
  try
   if Assigned(aINode) then
    l_NotifyObject.NodeChanged(aINode, anEvent)
   else
    if Supports(aNode, INode, l_INode) then
     l_NotifyObject.NodeChanged(l_INode, anEvent);
  finally
   l_NotifyObject := nil;
  end;
end;

function nsFindInsertPosition(const aRoot : Il3Node;
                              const aNode : INode): Il3Node;
//overload;
var
 l_IsFolder: Boolean;
 l_NodeCaption: IString;
begin
 Result := nil;
 l_IsFolder := TFoldersItemType(aNode.GetObjectType) = FIT_FOLDER;
 aNode.GetCaption(l_NodeCaption);
 Result := nsFindInsertPosition(aRoot, nsCStr(l_NodeCaption), l_IsFolder);
end;

function nsFindInsertPosition(const aRoot : Il3Node;
                              const aName : Il3CString;
                              anIsFolder  : Boolean): Il3Node;
//overload;

 function Compare(const anIntf: Il3Node): Boolean;
 var
  l_Node: INode;
  l_IsFolder: Boolean;
 begin
  if Supports(anIntf, INode, l_Node) then
   l_IsFolder := TFoldersItemType(l_Node.GetObjectType) = FIT_FOLDER
  else
   l_IsFolder := False;

  if anIsFolder then
  begin
   if l_IsFolder then
   begin
    if Assigned(aName) and
       (l3Compare(aName.AsWStr, anIntf.Text) < 0) then
     Result := True
    else
     Result := False;
   end
   else
    Result := True;
  end
  else
   begin
    if l_IsFolder then
     Result := False
    else
    begin
     if Assigned(aName) and
        (l3Compare(aName.AsWStr, anIntf.Text) < 0) then
      Result := True
     else
      Result := False;
    end
   end;
 end;

begin
 Result := aRoot.IterateF(l3L2NA(@Compare), imOneLevel or imCheckResult);
end;

// Start class TnsFoldersTree

procedure TnsFoldersTree.Cleanup;
begin
 f_CantChangeFilter := False;
 FilterInfo := nil;
 f_NotifyObject := nil;
 f_RootListener := nil;
 inherited;
end;

procedure TnsFoldersTree.DoNotify(aOperation : Integer; const aNode : Il3SimpleNode);
var
 l_Node  : Il3Node;
begin
 Supports(aNode, Il3Node, l_Node);
 inherited;
 if (FilterInfo.FilterType <> ffNone) and (aOperation = ntInsert) then
  ChangeNodeVisibility(l_Node);
end;

function TnsFoldersTree.GetNodeType(const aNode: Il3Node; var aFlag : LongInt) : TFoldersItemType;
var
 l_IterNode : INode;
begin
 aFlag := 0;
 if l3BQueryInterface(aNode, INode, l_IterNode) then
  try
   Result := TFoldersItemType(l_IterNode.GetObjectType);
   aFlag := l_IterNode.GetFlags;
  finally
   l_IterNode := nil;
  end
 else
  Result := FIT_FOLDER;
end;

procedure TnsFoldersTree.SetNodeVisible(const aNode: Il3Node);
var
 l_Parent : Il3Node;
begin
 NodeFlags[aNode] := NodeFlags[aNode] and not nfHidden;
 l_Parent := aNode.ParentNode;
 while (l_Parent <> nil) and
        not l_Parent.IsSame(RootNode) do
 begin
  NodeFlags[l_Parent] := NodeFlags[l_Parent] and not nfHidden;
  l_Parent := l_Parent.ParentNode;
 end;
end;

procedure TnsFoldersTree.SetNodeInvisible(const aNode: Il3Node);
begin
 NodeFlags[aNode] := NodeFlags[aNode] or nfHidden;
end;

function TnsFoldersTree.ChangeNodeVisibility(const aNode : Il3Node) : Boolean;

  function lp_Filtered: Boolean;
  var
   l_Node       : Il3SimpleNode;
   l_FolderNode : INode;
  begin
   Result := False;
   if FilterInfo.ShowFolders <> sfAll then
   begin
    l_Node := aNode;
    // Получим папку первого уровня:
    while not l_Node.Parent.IsSame(RootNode) do
     l_Node := l_Node.Parent;
    case FilterInfo.ShowFolders of
     sfMyDocuments:
     begin
      // Папка отличная от моих документов:
      if Supports(l_Node, INode, l_FolderNode) and
       not bsHasFlag(l_FolderNode, [NF_MY_DOCUMENTS]) then
      begin
       Result := True;
       // Скрываем/показываем только папку первого уровня:
       if aNode.Parent.IsSame(RootNode) then
        SetNodeInvisible(aNode);
      end;//if not bsHasFlag(l_Node, NF_MY_DOCUMENTS) then
     end;//sfMyDocuments
     sfMyDocumentsAndCommon:
     begin
      if Supports(l_Node, INode, l_FolderNode) and
       not bsHasFlag(l_FolderNode, [NF_MY_DOCUMENTS, NF_COMMON]) then
      begin
       Result := True;
       // Скрываем/показываем только папку первого уровня:
       if aNode.Parent.IsSame(RootNode) then
        SetNodeInvisible(aNode);
      end;//if not bsHasFlag(l_Node, NF_MY_DOCUMENTS) then
     end;//sfMyDocumentsAndCommon:
    end;//case ShowFolders.ShowFolders of
   end;//if ShowFolders.ShowFolders <> sfAll then
  end;//lp_Filtered

  procedure lp_VisibleNode(const aValue: Boolean);
  begin
   if aValue then
    SetNodeVisible(aNode)
   else
    SetNodeInvisible(aNode);
  end;

var
 l_CurType : TFoldersItemType;

  function lp_IsVisible(const aTypes : TFoldersItemTypes;
                        aFilterFor   : TnsFolderFilterFor): Boolean;
  begin
   Result := (l_CurType in aTypes) and (FilterInfo.FilterFor = aFilterFor);
  end;//lp_IsVisible

var
 l_CurFlag: Longint;

 procedure lp_Bookmark;
 begin
  lp_VisibleNode(lp_IsVisible([FIT_BOOKMARK, FIT_PHARM_BOOKMARK], ns_ffNone) or
                 lp_IsVisible([FIT_BOOKMARK], ns_ffDocument) or
                 lp_IsVisible([FIT_PHARM_BOOKMARK], ns_ffDrug));
 end;

 procedure lp_List;
 begin
  lp_VisibleNode(lp_IsVisible([FIT_LIST, FIT_PHARM_LIST], ns_ffNone) or
                 lp_IsVisible([FIT_LIST], ns_ffDocument) or
                 lp_IsVisible([FIT_PHARM_LIST], ns_ffDrug));
 end;

 procedure lp_ListAndBookmark;
 begin
  lp_VisibleNode(lp_IsVisible([FIT_LIST, FIT_BOOKMARK,
                               FIT_PHARM_BOOKMARK, FIT_PHARM_LIST], ns_ffNone) or
                 lp_IsVisible([FIT_LIST, FIT_BOOKMARK], ns_ffDocument) or
                 lp_IsVisible([FIT_PHARM_BOOKMARK, FIT_PHARM_LIST], ns_ffDrug));
 end;

begin
 Result := False;
 // Папка верхнего уровня не показывается, выходим:
 if lp_Filtered then
  Exit;
 if FilterInfo.FilterType = ffNone then
  SetNodeVisible(aNode)
 else
 begin
  l_CurType := GetNodeType(aNode, l_CurFlag);
  if l_CurType <> FIT_FOLDER then
   case FilterInfo.FilterType of
    ffBookmark:
     lp_Bookmark;
    ffList:
     lp_List;
    ffQuery:
     lp_VisibleNode(l_CurType = FIT_QUERY);
{    ffFilter:
     lp_VisibleNode(False);}
    ffListAndBookMarks:
     lp_ListAndBookmark;
   end//case FilterInfo.FilterType of
  else
   SetNodeVisible(aNode);
 end;//if FilterInfo.FilterType = ffNone then
end;//ChangeNodeVisibility

procedure TnsFoldersTree.Filtrate;

 function FiltrateNode(const anIntf: Il3Node) : Boolean;
 begin
  Result := ChangeNodeVisibility(anIntf);
 end;

begin
 if IsReady then
 begin
  Changing;
  try
   IterateF(l3L2NA(@FiltrateNode), imCheckResult);
  finally
   Changed;
  end;
 end;
end;

function TnsFoldersTree.pm_GetFilterInfo : InsFolderFilterInfo;
begin
 if f_FilterInfo = nil then
  FilterInfo := TnsFolderFilterInfo.Make(ffNone, ns_ffNone);
 Result := f_FilterInfo;
end;

procedure TnsFoldersTree.pm_SetFilterInfo(const aValue : InsFolderFilterInfo);
begin
 if (f_FilterInfo = nil) or not FilterInfo.IsSame(aValue) then
 begin
  if (f_FilterInfo <> nil) then
   f_FilterInfo.As_Il3ChangeNotifier.Unsubscribe(InsFolderFilterInfoListener(Self));
  f_FilterInfo := aValue;
  if (f_FilterInfo <> nil) then
   f_FilterInfo.As_Il3ChangeNotifier.Subscribe(InsFolderFilterInfoListener(Self));
  Filtrate;
 end;
end;

function TnsFoldersTree.pm_GetCantChangeFilter : Boolean;
begin
 Result := not IsReady or f_CantChangeFilter;
end;

procedure TnsFoldersTree.pm_SetCantChangeFilter(aValue : Boolean);
begin
 f_CantChangeFilter := aValue;
end;

function TnsFoldersTree.MakeFakeRoot: Il3RootNode;
var
 l_TempNode: TnsFoldersNode;
begin
 Result := TnsFoldersNode.Make(nil, -1, -1) as Il3RootNode;
 try
  l_TempNode := TnsFoldersNode.Create(nil, -1, -1);
  l_TempNode.AsWStr := nsWStr(vcmCStr(str_WaitFolders));
  Result.InsertChild(l_TempNode);
 finally
  l3Free(l_TempNode);
 end;
end;

function TnsFoldersTree.DoMakeRealRoot: Il3RootNode;
begin
 Result := TnsFoldersRoot.Make(DefDataAdapter.FoldersRoot, InsFolderNodeNotifyObject(f_NotifyObject)) as Il3RootNode;
 LoadChildren(Result);
end;

constructor TnsFoldersTree.Create(const aNotifyObject: InsFolderNodeNotifyObject;
                       const aListener: InsDefferedTreeListener);
begin
 defDataAdapter.BeginLoadFolders;
 inherited Create;
 f_NotifyObject := Pointer(aNotifyObject);
 f_RootListener := Pointer(aListener);
end;

class function TnsFoldersTree.Make(const aNotifyObject: InsFolderNodeNotifyObject;
                       const aListener: InsDefferedTreeListener): Il3Tree;
var
 l_Tree: TnsFoldersTree;
begin
 l_Tree := Create(aNotifyObject, aListener);
 try
  Result := l_Tree;
 finally
  l3Free(l_Tree);
 end;
end;

function IsSortNeeded(const aNode: INode; aWithCheckParent: Boolean): Boolean;
var
 l_Flags: LongInt;
 l_Parent: INode;
begin
 if Assigned(aNode) then
 begin
  l_Flags := aNode.GetFlags;
  Result := (l_Flags and NF_MY_DOCUMENTS = NF_MY_DOCUMENTS) or
            (l_Flags and NF_COMMON = NF_COMMON);

  if not Result and
     aWithCheckParent then
  begin
   aNode.GetParent(l_Parent);
   Result := IsSortNeeded(l_Parent, True);
  end;
 end
 else
  Result := False;
end;

class procedure TnsFoldersTree.LoadChildren(const aParent : Il3Node;
                                            aNeedSort: Boolean = False);
var
 l_Child,
 l_Parent: INode;
 I,
 l_ChildCount: LongInt;
 l_l3Child: Il3Node;
begin
 if l3BQueryInterface(aParent, INode, l_Parent) then
  try
   l_ChildCount := l_Parent.GetChildCount;
   if l_ChildCount > 0 then
   begin
    if not aNeedSort then
     aNeedSort := IsSortNeeded(l_Parent, False);

    for I := 0 to l_ChildCount - 1 do
    begin
     l_Parent.GetChild(I, l_Child);

     l_l3Child := aParent.InsertChild(TnsFoldersNode.Make(l_Child));

     if l_Child.GetChildCount > 0 then
      LoadChildren(l_l3Child, aNeedSort);
    end;

    if aNeedSort then
     aParent.SortChilds;
   end;
  finally
   l_Parent := nil;
  end;
end;

procedure TnsFoldersTree.RemoveChildren(const aParent: Il3Node);

 function RemoveNode(const anIntf: Il3Node): Boolean;
 begin
  Result := False;
  anIntf.Remove;
 end;

begin
 aParent.IterateF(l3L2NA(@RemoveNode), imOneLevel);
end;

procedure TnsFoldersTree.ReloadChildren(const aNode: INode);
var
 l_Node: Il3Node;
begin
 l_Node := FindOnAdapterNode(RootNode, aNode);
 if l_Node <> nil then
  try
   ReloadChildren(l_Node, IsSortNeeded(aNode, True));
  finally
   l_Node := nil;
  end;
end;

procedure TnsFoldersTree.ReloadChildren(const aNode: Il3Node; aNeedSort: Boolean);
begin
 Changing;
 try
  RemoveChildren(aNode);
  LoadChildren(aNode, aNeedSort);
 finally
  Changed;
 end;
end;

// Start class TnsFoldersRoot

class function TnsFoldersRoot.Make(const aNode: INode;
                                   const aNotifyObject: InsFolderNodeNotifyObject): IeeNode;
var
 l_Node : TnsFoldersRoot;
begin
 Result := inherited Make(aNode) As IeeNode;
 if (Result <> nil) then
 begin
  l_Node := ((Result As Il3NodeWrap).GetSelf As TnsFoldersRoot);
  l_Node.f_NotifyObject := Pointer(aNotifyObject);
 end;
end;

procedure TnsFoldersRoot.Cleanup;
begin
 f_NotifyObject :=  nil;

 inherited;
end;

procedure TnsFoldersRoot.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
begin
 l3Set(f_Caption, Value);
end;

function TnsFoldersRoot.ChildNodeClass: Rl3CustomVirtualNode;
begin
 Result := TnsFoldersNode;
end;

procedure TnsFoldersRoot.ChangedNotify(const aNode: INode; anEvent: TFoldersNodeChangeEvent);
begin
 if anEvent in [fnceChangeFilterType, fnceChangeControlledState] then
 begin
  Changing;
  Changed;
 end;
end;

procedure TnsFoldersRoot.BeforeDeleteNotify(const aNode: INode; anEvent: TFoldersNodeDeleteEvent);
begin
end;

procedure TnsFoldersRoot.AfterDeleteNotify(aFlags: LongInt; aNodeType: TFoldersItemType);
begin
end;

procedure TnsFoldersRoot.NodeChanged(const aNode: INode; anEvent: TFoldersNodeChangeEvent);
begin
 if f_NotifyObject <> nil then
  InsFolderNodeNotifyObject(f_NotifyObject).NodeChanged(aNode, anEvent);
end;

procedure TnsFoldersRoot.NodeBeforeDelete(const aNode: INode; anEvent: TFoldersNodeDeleteEvent);
begin
 if f_NotifyObject <> nil then
  InsFolderNodeNotifyObject(f_NotifyObject).NodeBeforeDelete(aNode, anEvent);
end;

procedure TnsFoldersRoot.NodeDeleted(aFlags: LongInt; aNodeType: TFoldersItemType);
begin
 if f_NotifyObject <> nil then
  InsFolderNodeNotifyObject(f_NotifyObject).NodeDeleted(aFlags, aNodeType);
end;

// Start class TnsNodeWithRights

procedure TnsNodeWithRights.CountRights;

 procedure GetEntityRights(const aNode : INode;
                           var anAcceptedRights,
                               aRestrictedRights : TFoldersActionsSet;
                           ForChildNode : Boolean = False);

   procedure SetChangeRights(aAllow : Boolean);
   begin
    if aAllow then
     Include(anAcceptedRights, faChangeRights)
    else
     Include(aRestrictedRights, faChangeRights);
   end;

 var
  l_Folder : IFolder;
  l_Flags : LongInt;
 begin
  anAcceptedRights := [];
  aRestrictedRights := [];
  Include(anAcceptedRights, faView);
  { "Писать": Модифицировать, Добавлять детей }
  l_Flags := aNode.GetFlags;
  if (ForChildNode or // Берутся права не для папки
     ((l_Flags and NF_MY_DOCUMENTS = 0) and // Не папка в Мои документы
      ((l_Flags and NF_EXTERNAL = 0) or // Папка своя
       (l_Flags and NF_IN_SHARED = NF_IN_SHARED)))) and
     aNode.CanModify then // Папка чужая, но вложенная
   Include(anAcceptedRights, faModify)
  else
   Include(aRestrictedRights, faModify);

  if not ForChildNode and aNode.CanModify then
   { Если папка изменяемая и не журнал, то можно добавить ребенка }
   Include(anAcceptedRights, faAddChild)
  else
   Include(aRestrictedRights, faAddChild);

  { Изменение прав доступа. Права изменения доступа есть у всех папок,
    поэтому они проверяются только если:
    - папка не внешняя;
    - папка не содержит расшаренных папок;
    - папка не находится в расшаренной; }
  if not ForChildNode then
   begin
    l_Folder := GetIFolderFromINode(aNode);
    if Assigned(l_Folder) then
     SetChangeRights(l_Folder.CanShare)
    else
     Include(aRestrictedRights, faChangeRights);
   end
  else
   Include(aRestrictedRights, faChangeRights);
 end;

var
 l_ParentNode: INode;

 l_ParentAcceptedRights,
 l_ParentRestrictedRights: TFoldersActionsSet;
begin
 f_AcceptedRights := [];
 f_RestrictedRights := [];

 if AdapterNode <> nil then
 begin
  if TFoldersItemType(AdapterNode.GetObjectType) in [FIT_FOLDER, FIT_OLD_HISTORY] then
  begin
   { Определим чтение, изменение, права доступа }
   GetEntityRights(AdapterNode, f_AcceptedRights, f_RestrictedRights);

   if l3BQueryInterface(ParentNode, INode, l_ParentNode) then
    try
     GetEntityRights(l_ParentNode, l_ParentAcceptedRights, l_ParentRestrictedRights);

     if (faAddChild in l_ParentAcceptedRights) then
      { Если в родительскую папку разрешено добавление или это журнал, то можно удалять ребенка }
      Include(f_AcceptedRights, faDelete)
     else
      Include(f_RestrictedRights, faDelete);
    finally
     l_ParentNode := nil;
    end
   else //l3BQueryInterface(ParentNode, INode, l_ParentNode)
    Include(f_RestrictedRights, faDelete);
  end
  else //TFoldersItemType(AdapterNode.GetObjectType) = FIT_FOLDER
  begin
   AdapterNode.GetParent(l_ParentNode);
   if l_ParentNode <> nil then
    try
     GetEntityRights(l_ParentNode, f_AcceptedRights, f_RestrictedRights, True);

     if faModify in f_AcceptedRights then
      Include(f_AcceptedRights, faDelete)
     else
      Include(f_RestrictedRights, faDelete);
    finally
     l_ParentNode := nil;
    end
   else //l3BQueryInterface(ParentNode, INode, l_ParentNode)
    f_RestrictedRights := [faView, faModify, faDelete, faAddChild, faChangeRights];
  end;
 end
 else //AdapterNode <> nil
  f_RestrictedRights := [faView, faModify, faDelete, faAddChild, faChangeRights];
end;

function TnsNodeWithRights.CheckRights(aAction: TFoldersActions) : Boolean;
begin
 if not (aAction in f_AcceptedRights) and
    not (aAction in f_RestrictedRights) then
  CountRights;

 if aAction in f_AcceptedRights then
  Result := True
 else
  if aAction in f_RestrictedRights then
   Result := False
  else
   Result := False;
end;

procedure TnsNodeWithRights.DropUserRightsCache;
begin
 f_AcceptedRights := [];
 f_RestrictedRights := [];
end;

procedure TnsNodeWithRights.DropAllChildrenUserRightsCache;

 function DropCache(const anIntf: Il3Node) : Boolean;
 var
  l_NodeWithRights : InsNodeWithRights;
 begin
  Result := False;
  if l3BQueryInterface(anIntf, InsNodeWithRights, l_NodeWithRights) then
   l_NodeWithRights.DropUserRightsCache;
 end;

begin
 IterateF(l3L2NA(@DropCache), imParentNeed);
end;

procedure TnsNodeWithRights.Cleanup;
begin
 DropUserRightsCache;

 inherited;
end;

// Start class TnsFoldersNode

function TnsFoldersNode.pm_GetRoot: Il3SimpleNode;
begin
 Result := ParentNode;
 while (Result <> nil) and (Result.Parent <> nil) do
  Result := Result.Parent;
end;//pm_GetRoot

function TnsFoldersNode.IsNodeFromFolders(const aNode: Il3SimpleNode): Boolean;
var
 l_Node : Il3Node;
 l_Root : Il3SimpleNode;
begin
 l_Root := Root;
 try
  Result := (l_Root <> nil) and Supports(aNode, Il3Node, l_Node) and
   l3IsNodeFromTree(l_Root, l_Node);
 finally
  l_Root := nil;
 end;//try..finally
end;//IsNodeFromFolders

function TnsFoldersNode.GetCanAcceptData(const aData: Tl3TreeData): Boolean;
begin
 Result := CanAcceptDataEx(aData);
end;

function nsListMergeIsPossible(aFolderType: TFoldersItemType; aListType: TDynListContent): Boolean;
begin
 Result := False;
 case aFolderType of
  FIT_LIST:
   Result := aListType = DLC_LEGAL_DOCUMENTS;
  FIT_PHARM_LIST:
   Result := aListType = DLC_MEDICAL_DOCUMENTS;
 end;
end;

function TnsFoldersNode.CanAcceptDataEx(const aData: Tl3TreeData;
                                        aCheckParent: Boolean = True): Boolean;
      {* - может ли узел принять данные. }
  // override;
  {* - может ли узел принять данные. }

 function lp_CanMoveFolderNode: Boolean;
 var
  l_Node        : Il3SimpleNode;
  l_AdapterNode : INode;
 begin
  Result := (aData.rNode <> nil) and
            IsNodeFromFolders(aData.rNode) and
            Supports(aData.rNode, INode, l_AdapterNode) and
            l_AdapterNode.CanMove and
            AdapterNode.CanInsert(l_AdapterNode);
 end;//lp_CanTargetAccept

 function lp_AcceptListData: Boolean;

  function lp_IsMyDocumentFolder: Boolean;
  var
   l_Parent : INode;
   l_Temp   : INode;
  begin
   l_Parent := AdapterNode;
   while (l_Parent <> nil) and
     (l_Parent.GetFlags and NF_MY_DOCUMENTS <> NF_MY_DOCUMENTS) do
   begin
    l_Parent.GetParent(l_Temp);
    try
     l_Parent := l_Temp;
    finally
     l_Temp := nil;
    end;
   end;
   Result := l_Parent <> nil;
  end;//lp_IsMyDocumentFolder

  function lp_CanMerge: Boolean;
  var
   l_Data: IbsListTreeData;
  begin
   Result := CheckRights(faModify) and Supports(aData.rNodes, IbsListTreeData, l_Data) and
     nsListMergeIsPossible(TFoldersItemType(AdapterNode.GetObjectType), l_Data.List.GetContentType)
  end;

 begin
  Result := (Supports(aData.rNode, IListEntryInfo) or
              // - перемещается узел из списка;
             Supports(aData.rNodes, IbsListTreeData)) and
              // - перемещаются узлы из списка;
             (CheckRights(faAddChild) or lp_CanMerge) and
              // - разрешено добавление узлов;
             lp_IsMyDocumentFolder;
              // складывать можно только в папку мои документы.
 end;//lp_AcceptListData

begin
 Result := inherited GetCanAcceptData(aData) or
           lp_CanMoveFolderNode or
            // - перемещается узел папок;
           lp_AcceptListData or
            // - принять данные списка.
           (aCheckParent and ParentNode.CanAcceptData(aData));
            // - когда курсор наводят к дочернему узлу, до добавим узел к
            //   родителю.
end;//CanAcceptData

function TnsFoldersNode.GetCanMove: Boolean;
  // override;
  {* определяет возможность перемещения узла }
begin
 Result := inherited GetCanMove or AdapterNode.CanMove;
end;

function TnsFoldersNode.MakeListBookmark(const aListData : IbsListTreeData): Boolean;
  {* - создает закладку на документ из списка. }
var
 l_NewCatalogBase : ICatalogBase;
 l_NewDynList     : IDynList;
 l_Entity         : IEntityBase;
 l_Storage        : IEntityStorage;
 (*l_Listener       : InsFolderNodeListener;*)
 l_NewNode        : INode;
begin
 Result := False;
 aListData.List.Create(aListData.Nodes, l_NewCatalogBase);
 try
  if Supports(l_NewCatalogBase, IDynList, l_NewDynList) then
  try
   bsMakeNewListName(Self,
                     aListData.List,
                     l_NewDynList,
                     aListData.Root.GetFlagCount(FM_SELECTION));
   if Supports(l_NewCatalogBase, IEntityBase, l_Entity) then
   try
    try
     l_Entity.SaveTo(AdapterNode, l_Storage);
     try
      if Supports(l_Storage, INode, l_NewNode) then
      try
       InsertChild(TnsFoldersNode.Make(l_NewNode));
       Result := True;
      finally
       l_NewNode := nil;
      end;//try..finally
     finally
      l_Storage := nil;
     end;//try..finally
    except
     on EDuplicateNode do
      // http://mdp.garant.ru/pages/viewpage.action?pageId=474594335
      TFoldersChangeUserInteraction.SayChildNodeDuplicated;
      (*if Supports(Root, InsFolderNodeListener, l_Listener) then
       l_Listener.ChildNodeDuplicated;
      else
       raise;*)
    end;//try..except
   finally
    l_Entity := nil;
   end;//try..finally
  finally
   l_NewDynList := nil;
  end//try..finally
  else
   Assert(False);
 finally
  l_NewCatalogBase := nil;
 end;//try..finally
end;//MakeListBookmark

function TnsFoldersNode.MakeDocumentBookmark(const aListRoot: INodeBase): Boolean;
  {* - создает закладку на список созданный из выделенных узлов исходного
       списка. }
var
 l_Node       : INodeBase;
 l_ListItem   : IListEntryInfo;
 l_Nodes      : INodeIterator;
 l_Doc        : IDocument;
 l_Bookmark   : IBookmark;
 l_NewNode    : INode;
 l_BaseEntity : IEntityBase;
(* l_Listener   : InsFolderNodeListener;*)
begin
 aListRoot.IterateNodes(FM_SELECTION, l_Nodes);
 try
  l_Nodes.GetNext(l_Node);
  try
   l_Node.GetEntity(l_BaseEntity);
   try
    if Supports(l_BaseEntity, IListEntryInfo, l_ListItem) then
    try
     l_ListItem.GetDoc(l_Doc);
     try
      nsDocumentTools.CreateNamedBookMark(l_Doc,
                                          l_ListItem.GetPosition,
                                          l_ListItem.GetType = PT_PARA,
                                          l_Bookmark,
                                          bsCalcUniqueName(Self, nsGetDocumentShortName(l_Doc), nil)
                                          );
      try
       try
        AdapterNode.AddChildNode(l_Bookmark, l_NewNode);
       except
        on EDuplicateNode do
         // http://mdp.garant.ru/pages/viewpage.action?pageId=474594335
         TFoldersChangeUserInteraction.SayChildNodeDuplicated;
         (*if Supports(Root, InsFolderNodeListener, l_Listener) then
         begin
          l_Listener.ChildNodeDuplicated;
          Result := False;
          Exit;
         end
         else
          raise;*)
       end;//try..except
       try
        InsertChild(TnsFoldersNode.Make(l_NewNode));
        DefDataAdapter.DocumentCacheSinchronize(fotAdd, l_Bookmark);
        Result := True;
        Exit;
       finally
        l_NewNode := nil;
       end;//try..finally
      finally
       l_Bookmark := nil;
      end;//try..finally
     finally
      l_Doc := nil;
     end;//try..finally
    finally
     l_ListItem := nil;
    end;//try..finally
   finally
    l_BaseEntity := nil;
   end;//try..finally
  finally
   l_Node := nil;
  end;//try..finally
 finally
  l_Nodes := nil;
 end;//try..finally
 Result := False;
end;//MakeDocumentBookmark

function TnsFoldersNode.DoDropData(const aData: Tl3TreeData): Boolean;
  // override;
  {* - принять данные. }

  function lp_DropNodes: Boolean;
  var
   l_ListData: IbsListTreeData;
   l_Listener: InsFolderNodeListener;

  begin
   if Supports(aData.rNodes, IbsListTreeData, l_ListData) then
   try
    if nsListMergeIsPossible(TFoldersItemType(AdapterNode.GetObjectType), l_ListData.List.GetContentType) then
    begin
     // http://mdp.garant.ru/pages/viewpage.action?pageId=474594335
     case TFoldersChangeUserInteraction.AskAllowMerge of
      lmkAllow: Result := ExtendList(l_ListData);
      lmkDeny:
       if ParentNode.CanAcceptData(aData) then
        Result := ParentNode.DropData(aData)
       else
        Result := False;
      lmkAbort:
       Result := False;
     end;
    end
    else
     if l_ListData.Root.GetFlagCount(FM_SELECTION) = 1 then
      Result := MakeDocumentBookmark(l_ListData.Root)
     else
      Result := MakeListBookmark(l_ListData);
    Result := True;
   finally
    l_ListData := nil;
   end//try..finally
   else
    Result := False;
  end;//lp_DropNodes

  function lp_MoveNode: Boolean;
  var
   l_MovingNode : Il3Node;
   l_Node       : INode;
   l_Listener   : InsFolderNodeListener;

   function lp_MoveAdapterNode: Boolean;
   begin
    if l_Node.CanMove then
    try
     l_Node.MoveToLocation(AdapterNode);
     Result := True;
    except
     on EDuplicateNode do
     begin
      // http://mdp.garant.ru/pages/viewpage.action?pageId=474594335
      TFoldersChangeUserInteraction.SayChildNodeDuplicated;
      (*l_Listener.ChildNodeDuplicated;*)
      Result := False;
     end//EDuplicateNode
     else
     begin
      Result := False;
      raise;
     end;//else
    end//try..except
    else
     Result := False;
   end;//lp_MoveAdapterNode

   procedure lp_MoveNodeInTree;

    procedure lp_UpdateParentRights;
    var
     l_Parent         : Il3SimpleNode;
     l_NodeWithRights : InsNodeWithRights;
    begin
     l_Parent := ParentNode;
     while Assigned(l_Parent) do
     begin
      if Supports(l_Parent, InsNodeWithRights, l_NodeWithRights) then
       try
        l_NodeWithRights.DropUserRightsCache;
       finally
        l_NodeWithRights := nil;
       end;//try..finally
      l_Parent := l_Parent.Parent;
     end;//while Assigned(l_Parent) do
    end;

   var
    l_Root: Il3Node;
   begin
    if Supports(Root, Il3Node, l_Root) then
    try
     l_Root.Changing;
     try
      l_MovingNode.Remove;
      InsertChild(l_MovingNode);
      SortChilds;
      DropAllChildrenUserRightsCache;
      lp_UpdateParentRights;
     finally
      l_Root.Changed;
     end;//try..finally
    finally
     l_Root := nil;
    end;//try..finally
   end;//lp_MoveNodeInTree

  begin
   if Supports(aData.rNode, INode, l_Node) and
       // - перещаемый объект является адаптерным узлом;
      Supports(aData.rNode, Il3Node, l_MovingNode) and
       // - перемещаемый объект является узлом дерева;
      Supports(Root, InsFolderNodeListener, l_Listener) then
       // - слушатель событий установлен;
   begin
    Result := lp_MoveAdapterNode;
    if Result then
    begin
     lp_MoveNodeInTree;
     l_Listener.ChildNodeAdded(l_MovingNode);
    end;//if Result then
   end//if Suppports(aData.rNode, INode, l_Node)...
   else
    Result := False;
  end;//lp_MoveNode

var
 l_Node: Il3Node;
 l_Self: INode;
begin
 Result := inherited DoDropData(aData);
 if not Result and CanAcceptDataEx(aData, False) then
  case aData.rMultiSelection of
   False:
    // Перемещается узел моих документов:
    if Supports(aData.rNode, Il3Node, l_Node) and IsNodeFromFolders(l_Node) then
     Result := lp_MoveNode
    // Перемещается узел из другого источника:
    else
     Result := aData.rNode <> nil;
   True:
    // Перемещаются несколько узлов:
    Result := lp_DropNodes;
  end//case aData.rMultiSelection of
 else
  if ParentNode.CanAcceptData(aData) then
   Result := ParentNode.DropData(aData)
  else
   Result := False;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=440894636   
 if Supports(Self, INode, l_Self) and IsSortNeeded(l_Self, False) then
  SortChilds;
end;//DropData

procedure TnsFoldersNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
begin
 if (f_Caption = nil) or (l3Compare(f_Caption.AsPCharLen, Value) <> 0) then
 begin
  l3Set(f_Caption, Value);
//~~~!!!~~~ К убиению
{  if Assigned(AdapterNode) and (TFoldersItemType(AdapterNode.GetObjectType) = FIT_QUERY) and
     ((AdapterNode.GetFlags and (NF_FILTER or NF_GLOBAL_FILTER)) <> 0) then
  nsSendChangeNotify(IeeNode(self), fnceRenameFilter <<<, AdapterNode);}
 end;
end;

procedure TnsFoldersNode.SetDeleteBookmarkNotify(const aNode: INode);
var
 l_BaseEntity: IUnknown;
begin
 try
  aNode.Open(l_BaseEntity);
  try
   defDataAdapter.DocumentCacheSinchronize(fotDelete, l_BaseEntity);
  finally
   l_BaseEntity := nil;
  end;
 except
  on ECanNotFindData do ; //TODO: нода "пропала" что делать?
 end;
end;


procedure TnsFoldersNode.DoDelete;
var
 l_NotifyObject: InsFolderNodeNotifyObject;
 l_AdapterNodeFlag: LongInt;
 l_AdapterNodeType: TFoldersItemType;

 procedure CheckINode(const aNode: INode; IsCurNode: Boolean = false);
 var
  l_Flag: LongInt;
  l_Type: TFoldersItemType;
 begin
  l_Flag := aNode.GetFlags;
  l_Type := TFoldersItemType(aNode.GetObjectType);

//~~~!!!~~~ К убиению
{  if (l_Type = FIT_QUERY) and
     (l_Flag and NF_FILTER = NF_FILTER) or
     (l_Flag and NF_GLOBAL_FILTER = NF_GLOBAL_FILTER) then
   l_NotifyObject.NodeBeforeDelete(aNode, fndeQuery <<<<);}

  if (l_Type in [FIT_BOOKMARK, FIT_PHARM_BOOKMARK]) then
   SetDeleteBookmarkNotify(aNode);

  {if (l_Type in [FIT_BOOKMARK, FIT_PHARM_BOOKMARK]) and  // временно, пока на контроль можно ставить только документы
     (l_Flag and NF_CONTROLLED = NF_CONTROLLED) then
  begin
    if DefDataAdapter.Folders.IsLastUnderControl(aNode as IFoldersNode) then
     l_NotifyObject.NodeBeforeDelete(aNode, fndeControlled)
    else
     if not IsCurNode then
      aNode.DeleteNode;
  end;
  !STUB! Это не нужно, т.к. теперь на контроле не связаны с папками}
 end;

 function CheckNode(const anIntf: Il3Node): Boolean;
 var
  l_IterNode: INode;
 begin
  if l3BQueryInterface(anIntf, INode, l_IterNode) then
   try
    CheckINode(l_IterNode);
   finally
    l_IterNode := nil;
   end;
  Result := False;
 end;

begin
 if CheckRights(faDelete) then
 begin
  l_NotifyObject := nsFindNotifyObject(IeeNode(self));
  try
   if (AdapterNode <> nil) then
     case TFoldersItemType(AdapterNode.GetObjectType) of
       FIT_PHARM_BOOKMARK,
       FIT_BOOKMARK,
       FIT_QUERY :
        CheckINode(AdapterNode, true);
       FIT_FOLDER :
        begin
         CheckINode(AdapterNode, true);
         IterateF(l3L2NA(@CheckNode));
        end;
      else
       ; // сюда нужно перенести реализацию из FIT_BOOKMARK, когда на контроль можно будет ставить не только документы
     end;

   inherited;

   if AdapterNode <> nil then
   begin
    try
     l_AdapterNodeFlag := AdapterNode.GetFlags;
     l_AdapterNodeType := TFoldersItemType(AdapterNode.GetObjectType);
     AdapterNode.DeleteNode;
     l_NotifyObject.NodeDeleted(l_AdapterNodeFlag, l_AdapterNodeType);
    except
     on EEmptyResult do
      ; //TODO: а если эту ноду не удалили, а отняли у нас права?
     else
      Assert(false); //TODO: AccessDenied!
    end;
    AdapterNode := nil;
   end;
  finally
   l_NotifyObject := nil;
  end;
 end;
end;

function TnsFoldersNode.DoCompareChild(const aChildrenNode1, aChildrenNode2: Il3Node): Integer;
 //override;
 {-}
var
 l_Node1,
 l_Node2: INode;
begin
 if Supports(aChildrenNode1, INode, l_Node1) and
    Supports(aChildrenNode2, INode, l_Node2) then
  Result := Integer(l_Node2.GetObjectType) - Integer(l_Node1.GetObjectType)
 else
  Result := 0;
 if (Result = 0) then
  Result := l3Compare(aChildrenNode1.Text, aChildrenNode2.Text, l3_siCaseUnsensitive);
end;

procedure TnsFoldersNode.SetUnderControlStatus(aState : Boolean);
var
 l_Controllable : IControllable;
begin
 if AdapterNode <> nil then
 begin
  if l3BQueryInterface(AdapterNode, IControllable, l_Controllable) then
   try
    if l_Controllable.GetControlled <> aState then
    begin
     Changing;
     try
      l_Controllable.SetControlled(aState);
      nsSendChangeNotify(IeeNode(self), fnceChangeControlledState, AdapterNode);
     finally
      Changed;
     end;
    end;
   finally
    l_Controllable := nil;
   end;
 end;
end;

procedure TnsFoldersNode.ChangeUnderControlStatus;
var
 l_Controllable : IControllable;
 l_newState    : Boolean;
begin
 if AdapterNode <> nil then
 begin
  if l3BQueryInterface(AdapterNode, IControllable, l_Controllable) then
   try
    l_newState := not l_Controllable.GetControlled;
    Changing;
    try
     l_Controllable.SetControlled(l_newState);
     nsSendChangeNotify(IeeNode(self), fnceChangeControlledState, AdapterNode);
    finally
     Changed;
    end;
   finally
    l_Controllable := nil;
   end;
 end;
end;

procedure TnsFoldersNode.DropContentCache;
begin
 l3Free(f_Caption);
end;

// Start class TnsUnderControlTree

function TnsUnderControlTree.pm_getSortType: TnsUCSortType;
begin
 //Result := f_SortType;
 if Assigned(RootNode) then
  Result := (RootNode as InsUnderControlRoot).SortType
 else
 begin
  Assert(False);
  Result := f_SortType;
 end; 
end;

procedure TnsUnderControlTree.pm_setSortType(aValue: TnsUCSortType);
begin
 if f_SortType <> aValue then
 begin
  f_SortType := aValue;
  ReSort;
 end;
end;

procedure TnsUnderControlTree.ReSort;
begin
 (RootNode as InsUnderControlRoot).SortType := f_SortType;
end;

// Start class TnsUnderControlNode

procedure TnsFoldersTree.DoSetBuildedRoot(const aNewRoot: Il3RootNode);
begin
 inherited;
 if (FilterInfo.ShowFolders <> sfAll) or (FilterInfo.FilterType <> ffNone) then
  Filtrate;
 if Assigned(f_RootListener) then
  InsDefferedTreeListener(f_RootListener).TreeLoaded(kdtFolders);
 defDataAdapter.EndLoadFolders;
end;

function TnsFoldersTree.NodeHasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
var
 l_Node: Il3Node;

 function SearchVisible(const anIntf: Il3Node) : Boolean;
 begin
  Result := NodeFlags[anIntf] and nfHidden = 0;
 end;

begin
 if aNode.HasChild then
  Result := Supports(aNode, Il3Node, l_Node) and
   (IterateF(l3L2NA(@SearchVisible), imCheckResult or imOneLevel, l_Node) <> nil)
 else
  Result := False;
end;

procedure TnsFoldersRoot.ChildNodeDuplicated;
  {* - вызывается при попытке добавить узел с уже существующим названием. }
(*var
 l_Listener : InsFolderNodeListener;
 l_Item     : IUnknown;
 l_Index    : Integer;*)
begin
 // http://mdp.garant.ru/pages/viewpage.action?pageId=474594335
 TFoldersChangeUserInteraction.SayChildNodeDuplicated;
(* for l_Index := 0 to Pred(NotifiedObjList.Count) do
 begin
  l_Item := IUnknown(NotifiedObjList.Items[l_Index]);
  if Supports(l_Item, InsFolderNodeListener, l_Listener) and
    (l_Item = l_Listener) then
   l_Listener.ChildNodeDuplicated;
 end;//for l_Index := 0 to Pred(NotifiedObjList.Count) do *)
end;//ChildNodeDuplicated

procedure TnsFoldersRoot.ChildNodeAdded(const aNode: Il3SimpleNode);
  {* - был добавлен дочерний узел. }
var
 l_Listener : InsFolderNodeListener;
 l_Item     : IUnknown;
 l_Index    : Integer;
begin
 for l_Index := 0 to Pred(NotifiedObjList.Count) do
 begin
  l_Item := IUnknown(NotifiedObjList.Items[l_Index]);
  if Supports(l_Item, InsFolderNodeListener, l_Listener) and
    (l_Item = l_Listener) then
   l_Listener.ChildNodeAdded(aNode);
 end;//for l_Index := 0 to Pred(NotifiedObjList.Count) do
end;//ChildNodeAdded

procedure TnsFoldersRoot.AddListener(const aListener: InsFolderNodeListener);
  {* - добавить слушателя. }
begin
 Subscribe(aListener);
end;

procedure TnsFoldersRoot.RemoveListener(const aListener: InsFolderNodeListener);
  {* - удалить слушателя. }
begin
 Unsubscribe(aListener);
end;

procedure TnsFoldersTree.InsFolderFilterInfoListener_Changed;
begin
 Filtrate;
end;

function TnsFoldersNode.ExtendList(
  const aListData: IbsListTreeData): Boolean;
var
 l_NewCatalogBase : ICatalogBase;
 l_Entity         : IEntityBase;
 l_Storage        : IEntityStorage;
begin
 Result := False;
 aListData.List.Create(aListData.Nodes, l_NewCatalogBase);
 if Supports(l_NewCatalogBase, IEntityBase, l_Entity) then
 begin
  l_Entity.AppendTo(AdapterNode, l_Storage);
  Result := True;
 end;
end;

function TnsFoldersRoot.AllowMerge: TnsListMergeKind;
(*var
 l_Listener : InsFolderNodeListener;
 l_Item     : IUnknown;
 l_Index    : Integer;*)
begin
 // http://mdp.garant.ru/pages/viewpage.action?pageId=474594335
 Result := TFoldersChangeUserInteraction.AskAllowMerge;
(* Result := lmkDeny;
 for l_Index := 0 to Pred(NotifiedObjList.Count) do
 begin
  l_Item := IUnknown(NotifiedObjList.Items[l_Index]);
  if Supports(l_Item, InsFolderNodeListener, l_Listener) and
    (l_Item = l_Listener) then
   begin
    Result := l_Listener.AllowMerge;
    if Result <> lmkDeny then
     Exit;
   end;
 end;//for l_Index := 0 to Pred(NotifiedObjList.Count) do *)
end;

end.
