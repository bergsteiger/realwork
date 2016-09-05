unit bsUtils;

{------------------------------------------------------------------------------}
{ Библиотека : Бизнес слой проекта "Немезис";                                  }
{ Автор      : Морозов М.А;                                                    }
{ Начат      : 24.08.2005 12.24;                                               }
{ Модуль     : bsUtils                                                         }
{ Описание   : Общие функции и процедуры бизнес слоя;                          }
{------------------------------------------------------------------------------}

// $Id: bsUtils.pas,v 1.66 2016/08/02 12:43:57 lulin Exp $
// $Log: bsUtils.pas,v $
// Revision 1.66  2016/08/02 12:43:57  lulin
// - перегенерация.
//
// Revision 1.65  2016/07/15 11:25:37  lulin
// - выпрямляем зависимости.
//
// Revision 1.64  2016/02/12 13:57:35  kostitsin
// {requestlink: 612742232 }
//
// Revision 1.63  2015/10/01 12:28:19  morozov
// {RequestLink: 608114858}
//
// Revision 1.62  2014/04/03 17:17:49  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.61  2014/03/04 13:11:49  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.60  2013/10/24 12:33:13  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.59  2013/10/18 14:11:09  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.58  2013/07/03 11:08:04  morozov
// {RequestLink:466761779}
//
// Revision 1.57  2012/11/28 15:16:17  kostitsin
// небольшая чистка кода
//
// Revision 1.56  2012/07/25 18:34:44  lulin
// {RequestLink:378540022}
//
// Revision 1.55  2012/06/18 10:32:58  kostitsin
// [$371631761]
//
// Revision 1.54  2012/04/28 10:38:49  lulin
// {RequestLink:361404275}
//
// Revision 1.53  2012/02/01 09:27:03  kostitsin
// [$333545491]
//
// Revision 1.52  2012/01/27 12:36:43  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=330704779
//
// Revision 1.51  2012/01/27 08:32:13  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=328859701
//
// Revision 1.50  2012/01/26 14:02:29  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=328859701
//
// Revision 1.49  2011/12/16 15:09:55  lulin
// [$320742215].
//
// Revision 1.48  2011/12/15 16:24:10  lulin
// {RequestLink:320734796}
//
// Revision 1.47  2011/11/14 15:52:34  lulin
// - обрабатываем переключение баз.
//
// Revision 1.46  2011/09/23 10:57:02  lulin
// {RequestLink:287219493}.
//
// Revision 1.45  2011/07/21 16:29:57  lulin
// {RequestLink:269058433}.
//
// Revision 1.44  2011/06/27 13:54:04  lulin
// {RequestLink:254944102}.
//
// Revision 1.43  2011/06/23 15:30:00  lulin
// {RequestLink:254944102}.
//
// Revision 1.42  2011/06/16 09:54:30  lulin
// {RequestLink:269072361}.
//
// Revision 1.41  2011/06/07 11:31:35  lulin
// {RequestLink:268345098}.
// - вычищаем хвосты.
//
// Revision 1.40  2011/06/07 11:11:18  lulin
// {RequestLink:268345098}.
// - вычищаем хвосты.
//
// Revision 1.39  2011/06/06 13:10:38  lulin
// {RequestLink:268345098}.
// [$268347311].
//
// Revision 1.38  2011/05/05 17:22:07  lulin
// {RequestLink:265408824}.
//
// Revision 1.37  2011/05/05 15:22:59  lulin
// {RequestLink:265408824}.
// [$265409530].
//
// Revision 1.36  2011/05/05 09:07:12  lulin
// {RequestLink:265399862}.
//
// Revision 1.35  2011/05/03 18:36:56  lulin
// {RequestLink:259892768}.
// - прикручиваем баллон о том что база устарела.
//
// Revision 1.34  2011/04/28 18:39:26  lulin
// {RequestLink:259892768}.
// - прикручиваем баллоны к медалям списков.
//
// Revision 1.33  2011/04/19 17:48:41  lulin
// {RequestLink:261981346}.
//
// Revision 1.32  2011/04/04 16:03:39  lulin
// {RequestLink:259175088}.
//
// Revision 1.31  2011/02/28 14:07:44  lulin
// {RequestLink:254944075}.
// - чистка кода.
//
// Revision 1.30  2011/02/28 13:31:35  lulin
// {RequestLink:254944075}.
//
// Revision 1.29  2011/01/27 12:14:15  lulin
// {RequestLink:248195582}.
// - избавляемся от развесистых макарон.
//
// Revision 1.28  2010/11/01 19:38:12  lulin
// {RequestLink:237994238}.
// - учитываем ifdef для состояний операций.
//
// Revision 1.27  2010/11/01 13:20:41  lulin
// {RequestLink:237994238}.
//
// Revision 1.26  2010/10/25 12:13:56  lulin
// {RequestLink:236722190}.
//
// Revision 1.25  2010/10/25 09:55:03  lulin
// {RequestLink:237502802}.
// Шаг №3.
//
// Revision 1.24  2010/10/25 08:36:46  lulin
// {RequestLink:237502802}.
// Шаг №2.
//
// Revision 1.23  2010/08/19 11:42:55  oman
// - fix: {RequestLink:233015148}
//
// Revision 1.22  2010/05/26 12:09:57  oman
// - new: {RequestLink:197493008}
//
// Revision 1.21  2010/03/22 16:48:19  lulin
// {RequestLink:198672893}.
// - упрощаем сигнатуры фабрик.
//
// Revision 1.20  2010/03/22 15:03:24  lulin
// {RequestLink:198672893}.
// - упрощаем сигнатуры фабрик.
//
// Revision 1.19  2010/03/22 14:42:30  lulin
// {RequestLink:198672893}.
//
// Revision 1.18  2010/03/03 16:52:44  lulin
// {RequestLink:193825692}.
//
// Revision 1.17  2010/02/15 12:47:02  oman
// - fix: {RequestLink:190680948}
//
// Revision 1.16  2010/02/08 08:41:14  oman
// - new: {RequestLink:186352569}
//
// Revision 1.15  2009/12/09 16:36:51  lulin
// - рисуем контейнер документа на модели и правим зависимости.
//
// Revision 1.14  2009/12/09 13:08:20  lulin
// {RequestLink:124453871}.
//
// Revision 1.13  2009/12/09 09:23:34  lulin
// - убиваем неиспользуемый класс.
//
// Revision 1.12  2009/12/07 19:06:13  lulin
// - удалил ненужный модуль.
//
// Revision 1.11  2009/12/07 18:36:34  lulin
// - переносим "интерфейсы обмена данными" в правильные места.
//
// Revision 1.10  2009/12/07 17:20:22  lulin
// - переносим "интерфейсы обмена данными" в правильные места.
//
// Revision 1.9  2009/12/04 11:53:06  lulin
// - перенесли на модель и добились собираемости.
//
// Revision 1.8  2009/11/05 11:41:39  oman
// - new: {RequestLink:121160631}
//
// Revision 1.7  2009/10/29 14:35:43  lulin
// - вторая волна компании по борьбе со старыми внутренними операциями.
//
// Revision 1.6  2009/10/13 13:50:50  oman
// - new:  {RequestLink:164596265}
//
// Revision 1.5  2009/09/29 13:44:18  lulin
// {RequestLink:159360578}. №34.
//
// Revision 1.4  2009/09/28 16:42:39  lulin
// - модуль Папки полностью перенесён на модуль.
//
// Revision 1.3  2009/09/28 11:31:53  lulin
// - избавляемся от внутренних опреация модуля Папки, связанных с документами на контроле.
//
// Revision 1.2  2009/09/22 14:49:21  lulin
// - переносим модуль поиска на модель.
//
// Revision 1.1  2009/09/14 11:28:53  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.188  2009/09/07 17:54:13  lulin
// - переводим консультации на фабрики.
//
// Revision 1.187  2009/09/03 18:49:00  lulin
// - реструктуризируем поиски и удаляем ненужное.
//
// Revision 1.186  2009/09/03 13:25:48  lulin
// - делаем прецеденты более изолированными друг от друга.
//
// Revision 1.185  2009/08/26 08:15:08  lulin
// - декорируем имена операций, чтобы можно было искать.
// - bug fix: не собирались мониторинги.
//
// Revision 1.184  2009/08/14 14:57:46  lulin
// {RequestLink:129240934}. №42.
//
// Revision 1.183  2009/08/04 11:25:39  lulin
// [$159351827].
//
// Revision 1.182  2009/07/31 17:29:53  lulin
// - убираем мусор.
//
// Revision 1.181  2009/07/29 11:31:46  oman
// - new: Обрабатываем пустой список - {RequestLink:152408792}
//
// Revision 1.180  2009/06/18 07:53:34  oman
// - new: строим полный список по новому - [$140286494]
//
// Revision 1.179  2009/06/03 12:27:38  oman
// - new: компилируемся - [$148014435]
//
// Revision 1.178  2009/04/07 09:28:45  oman
// - new: Парсим гиперссылки - [$96484299]
//
// Revision 1.177  2009/04/07 07:21:13  oman
// - new: Готовим потроха - [$96484299]
//
// Revision 1.176  2009/04/07 06:38:20  oman
// - cleanup: Лишний overload - [$96484299]
//
// Revision 1.175  2009/03/04 13:32:28  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.174  2009/03/03 17:42:00  lulin
// - <K>: 137470629. Убран ненужный промежуточный модуль.
//
// Revision 1.173  2009/02/19 19:04:59  lulin
// - переносим идентификаторы сообщений.
//
// Revision 1.172  2009/02/11 14:00:47  lulin
// - вычищены ненужные обращения к контроллеру области вывода.
// - убран ненужный утилитный метод.
//
// Revision 1.171  2009/02/10 19:03:16  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.170  2009/02/10 15:43:26  lulin
// - <K>: 133891247. Выделяем интерфейсы локализации.
//
// Revision 1.169  2009/02/09 19:17:21  lulin
// - <K>: 133891247. Выделяем интерфейсы поиска.
//
// Revision 1.168  2009/01/30 16:06:50  lulin
// - <K>: 122674504. №4.
//
// Revision 1.167  2009/01/30 07:59:07  lulin
// - <K>: 122674504.
//
// Revision 1.166  2009/01/27 15:14:06  lulin
// - <K>: 133138664. №25.
//
// Revision 1.165  2009/01/12 15:58:23  lulin
// - <K>: 133138664. № 22.
//
// Revision 1.164  2008/12/25 12:19:30  lulin
// - <K>: 121153186.
//
// Revision 1.163  2008/12/25 11:05:48  oman
// - fix: Падали на пустом списке (К-133891112)
//
// Revision 1.162  2008/12/24 19:49:12  lulin
// - <K>: 121153186.
//
// Revision 1.161  2008/12/04 14:58:41  lulin
// - <K>: 121153186.
//
// Revision 1.160  2008/12/02 10:28:12  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=16351568&focusedCommentId=127766910#comment-127766910
//
// Revision 1.159  2008/11/14 10:34:46  lulin
// - <K>: 122675356.
//
// Revision 1.158  2008/10/30 15:09:05  lulin
// - <K>: 121159648.
//
// Revision 1.157  2008/10/10 13:55:07  oman
// - fix: Запрещаем ставить на контроль неподходящие документы (К-121146314)
//
// Revision 1.156  2008/10/02 11:20:57  oman
// - fix: Не инициализировали данные (К-120720843)
//
// Revision 1.155  2008/09/26 10:44:27  oman
// - fix: Обрезаем имя при DnD (К-109904958)
//
// Revision 1.154  2008/08/01 13:10:07  mmorozov
// - new: информация об отсутствии FlashActiveX (K<104434872>);
//
// Revision 1.153  2008/07/28 16:05:46  mmorozov
// - new: добавляем индекс к названию при перетаскивании из списка (K<104432822>);
//
// Revision 1.152  2008/07/15 09:03:45  oman
// - new: Выбираем кнопку для закрытия подтверждения крестиком (К-100008730)
//
// Revision 1.151  2008/07/08 11:21:20  mmorozov
// - new: ограничиваем операции для документов-схем (К<99221827>);
//
// Revision 1.150  2008/07/07 07:30:11  mmorozov
// - bugfix: у узла "редакции" нет сущности, но с ним всё равно пытались работать (К<96484615>);
//
// Revision 1.149  2008/06/24 07:43:35  oman
// - new: Диалог исправления опечаток (cq29419)
//
// Revision 1.148  2008/06/20 13:55:28  lulin
// - используем префиксы элементов.
//
// Revision 1.147  2008/06/20 12:49:28  lulin
// - используем префиксы элементов.
//
// Revision 1.146  2008/06/18 12:57:08  oman
// - fix: Излишний вывод пользователю (cq29204)
//
// Revision 1.145  2008/06/18 10:43:08  oman
// - new: Переделка исправления опечаток (cq29204)
//
// Revision 1.144  2008/06/18 06:11:51  mmorozov
// - new: применение постоянных фильтров при базовом поиске (CQ: OIT5-29196);
//
// Revision 1.143  2008/06/09 11:39:44  demon
// - new: функция ISearch.CorrectContext получила дополнительный параметр - для Инфарм или нет
//
// Revision 1.142  2008/05/27 09:04:24  lulin
// - удалена старая проверка валидности контекста.
//
// Revision 1.141  2008/05/26 11:46:50  mmorozov
// - change: формат записи открытия документа из списка.
//
// Revision 1.140  2008/05/22 09:37:12  oman
// - fix: Данные для исправления опечаток (cq29024)
//
// Revision 1.139  2008/05/13 05:37:30  mmorozov
// - применение постоянных фильтров (CQ: OIT5-29022);
//
// Revision 1.138  2008/05/08 04:58:21  mmorozov
// - rename: QueryInfo -> SearchInfo;
//
// Revision 1.137  2008/05/06 07:06:10  mmorozov
// - bugfix: досутпность кнопки открыть в извлечениях;
//
// Revision 1.136  2008/04/29 12:43:01  oman
// - fix: Предлагаем ППО в случае отсутствия документа (cq28939)
//
// Revision 1.135  2008/04/17 08:36:46  oman
// - fix: Отсылаем к справке только неудаленные документы (cq28899)
//
// Revision 1.134  2008/04/17 05:53:49  mmorozov
// - new: "Экспортировать и печатать списки без вхождений" настраивается для документов и препаратов.
//
// Revision 1.133  2008/04/10 09:33:57  oman
// - new: Меняем хинт к медали (cq28805)
//
// Revision 1.132  2008/03/26 11:59:15  oman
// - new: Учимся извлекать DocInfo для фирм-производителей
//
// Revision 1.131  2008/03/25 08:33:01  mmorozov
// - bugfix: при изменении настроек не перечитывались вкладки с пользовательскими СКР (CQ: OIT5-28504);
//
// Revision 1.130  2008/03/20 10:30:27  oman
// - fix: Не падаем в случае отсутствия значений
//
// Revision 1.129  2008/02/19 13:34:43  mmorozov
// - new: устанавливаем новое название списка при сохранении\перемещении выделенных документов списка в мои документы (в рамках задачи CQ: OIT5-28331);
//
// Revision 1.128  2008/02/11 08:24:28  oman
// - fix: Ставить на контроль даем только актуальную редакцию (cq22611)
//
// Revision 1.127  2008/02/04 14:03:40  oman
// - new: Предупреждение о редакциях (cq20237, 11152)
//
// Revision 1.126  2008/01/31 10:55:03  oman
// - new: Плашка для отправки почты (cq28329)
//
// Revision 1.125  2008/01/21 07:18:36  mmorozov
// - new: работа с пользовательскими ссылками на докумени и из документа перенесене на sdsDocInfo, чтобы быть доступной для списка и документа + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-17587);
//
// Revision 1.124  2008/01/10 07:23:00  oman
// Переход на новый адаптер
//
// Revision 1.123  2007/12/28 17:59:30  lulin
// - удалена ненужная глобальная переменная - ссылка на метод получения настроек.
//
// Revision 1.122.2.7  2008/01/09 09:02:50  oman
// - fix: Не собирались
//
// Revision 1.122.2.6  2007/12/13 08:46:33  oman
// Перепиливаем на новый адаптер - Явно приводим интерфейс
//
// Revision 1.122.2.5  2007/11/29 12:44:53  oman
// Перепиливаем на новый адаптер
//
// Revision 1.122.2.4  2007/11/26 09:03:55  oman
// Перепиливаем на новый адаптер
//
// Revision 1.122.2.3  2007/11/23 09:09:47  oman
// cleanup
//
// Revision 1.122.2.2  2007/11/23 09:03:16  oman
// Перепиливаем на новый адаптер
//
// Revision 1.122.2.1  2007/11/16 14:03:46  oman
// Перепиливаем на новый адаптер
//
// Revision 1.122  2007/10/20 14:11:33  mmorozov
// - Рефакторинг работы с консультациями ввел недостающее для нормальной работы состояние bs_csPaymentRefusalOldFormat;
// - Изжил интерфейс (и реализацию) IdeConsultation, по сути частично дублировала _IbsConsultation;
// - cleanup;
//
// Revision 1.121  2007/10/19 09:23:35  oman
// - fix: При разборе контекста выдаем сообщение - более
//  структурный вариант (К-57051004)
//
// Revision 1.120  2007/10/17 14:03:48  oman
// - fix: При разборе контекста выдаем сообщение (К-57051004)
//
// Revision 1.119  2007/10/13 11:10:02  mmorozov
// - new behaviour: при открытии для консультаций не прошедших валидацию  не выдаем сообщения, сразу показываем текста запроса; для консультация с неподтвержденной оплатой в 6.4. при открытии выводим сообщение и показываем текст запроса (CQ: OIT5-27021);
//
// Revision 1.118  2007/10/03 12:49:26  mmorozov
// - new: разрешаем включать машину времени на дату ревизии базы + для документов с открытой датой действия делаем недоступной операцию включить машину времени с даты действия текущей редакции + сопуствующий рефакторинг (в рамках CQ: OIT5-26843; K<56295615>);
//
// Revision 1.117  2007/09/25 07:13:06  oman
// - new: Используем короткое имя списка
//
// Revision 1.116  2007/08/14 19:31:42  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.115  2007/08/14 14:29:50  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.114  2007/08/14 07:32:38  mmorozov
// - new: поддержка работы с удаленной консультаций (CQ: OIT5-25868);
//
// Revision 1.113  2007/07/17 13:26:52  mmorozov
// - new: изменены интерфейсы логирования событий (в рамках CQ: OIT5-25852);
//
// Revision 1.112  2007/07/17 12:37:23  oman
// - fix: Операции по экспорту/импорту информации из папок (cq25665)
//
// Revision 1.111  2007/07/17 11:29:50  oman
// - fix: Для экспорта консультаций пользуемя правильными методами
//  с адаптера (cq25665)
//
// Revision 1.110  2007/06/21 11:29:46  mmorozov
// - переименовано свойство;
//
// Revision 1.109  2007/06/06 14:29:04  oman
// hint fix
//
// Revision 1.108  2007/06/01 09:12:06  oman
// - new: Новая функция по получению нефильтрованной ноды СКР от
//  фильтрованной (cq25285)
//
// Revision 1.107  2007/05/17 12:04:09  oman
// cleanup
//
// Revision 1.106  2007/05/14 14:15:27  oman
// cleanup
//
// Revision 1.105  2007/05/14 11:20:57  oman
// - new: Контекстный поиск в списке (cq25145)
//
// Revision 1.104  2007/05/11 14:07:10  oman
// - new: Экспорт ссылок для интеграции в клипборд (cq25218)
//
// Revision 1.103  2007/05/03 05:51:52  mmorozov
// - opt: оптимизация скролирования в списке (CQ: OIT5-24996; OIT5-24543);
//
// Revision 1.102  2007/04/23 08:35:07  oman
// - new: Вычищаем старую ППР и старые фильтры (cq25125)
//
// Revision 1.101  2007/04/05 10:49:24  lulin
// - повторное использование кода.
//
// Revision 1.100  2007/03/28 08:49:19  oman
// cleanup
//
// Revision 1.99  2007/03/27 11:59:26  oman
// Переводим тэг атрибутов на константную строку
//
// Revision 1.98  2007/03/19 14:24:16  lulin
// - избавляемся от прямого обращения к данным адаптерной строки.
//
// Revision 1.97  2007/03/16 16:56:57  lulin
// - избавляемся от излишнего копирования и преобразования строк.
//
// Revision 1.96  2007/02/28 12:43:50  lulin
// - cleanup.
//
// Revision 1.95  2007/02/27 09:17:49  lulin
// - используем более простые ноды при работе с папками.
//
// Revision 1.94  2007/02/13 15:42:01  lulin
// - избавляемся от лишних преобразований строк - добавлены функции сложения строк, обладающих кодировкой.
//
// Revision 1.93  2007/02/13 14:33:12  lulin
// - cleanup.
//
// Revision 1.92  2007/02/12 19:35:52  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.91  2007/02/12 18:55:39  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.90  2007/02/12 18:44:28  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.89  2007/02/12 16:38:57  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.88  2007/02/12 09:58:42  lulin
// - bug fix: искажались входные строковые параметры адаптера.
//
// Revision 1.87  2007/02/09 12:58:21  lulin
// - выделена функция преобразования к входной строке адаптера.
//
// Revision 1.86  2007/02/07 17:48:29  lulin
// - избавляемся от копирования строк при чтении из настроек.
//
// Revision 1.85  2007/02/07 14:30:32  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.84  2007/02/06 15:20:45  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.83  2007/02/06 12:33:56  mmorozov
// - не собирались мониторинги;
//
// Revision 1.82  2007/02/06 09:03:00  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.81  2007/02/06 07:52:43  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.80  2007/02/06 07:28:18  mmorozov
// - bugfix: при переходе по списку документов из документа в документ корректируем редакцию документа в соответствии с состоянием машины времени (CQ: OIT5-23950);
//
// Revision 1.79  2007/02/02 13:23:49  lulin
// - упрощаем преобразование строк.
//
// Revision 1.78  2007/02/02 08:38:51  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.77  2007/01/22 12:22:55  lulin
// - переходим на более правильные строки.
//
// Revision 1.76  2006/12/22 15:06:20  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.75  2006/12/21 09:15:04  oman
// - new: Асинхронные окошки при сохранении и экспорте документов
//  и списков (cq23937)
//
// Revision 1.74  2006/12/20 15:00:29  oman
// - fix: Показываем асинхронное окошко в несколько другом месте
//
// Revision 1.73  2006/12/19 13:07:19  oman
// - new: Функция по получению асинхронного окошка
//  визуализирующего контекстный поиск (cq23829)
//
// Revision 1.72  2006/12/13 11:38:06  mmorozov
// - MERGE WITH B_NEMESIS_6_4;
//
// Revision 1.68.2.3.2.4  2006/12/13 11:27:58  mmorozov
// - bugfix: не передавался Root списка при открытии документа из списка (CQ: OIT5-23773);
//
// Revision 1.71  2006/11/28 13:29:43  mmorozov
// MERGE WITH B_NEMESIS_6_4
//
// Revision 1.70  2006/11/21 11:36:32  mmorozov
// MERGE WITH B_NEMESIS_6_4 (new: для внутренней версии, для списка отсортированного по релевантности, показывам в строке состояния релевантность текущего элемента в списке (CQ: OIT5-23059));
//
// Revision 1.69  2006/11/03 09:45:31  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.68.2.3  2006/11/02 07:40:36  oman
// - Для определения места поиска пользуем тип ноды, а не
//  строковые константы (cq20231, 20412)
//
// Revision 1.68.2.2  2006/10/31 16:18:55  oman
// - fix: СКР переведены со строк на типы (cq23213)
//
// Revision 1.68.2.1  2006/10/25 07:29:36  oman
// Продолжаем избавлятся от StdStr
//
// Revision 1.68  2006/10/11 13:48:40  mmorozov
// - new behaviour: если консультацию оценили в моих документах, то перечитываем эту же консультацию открытую на экране (CQ: OIT5-22959);
//
// Revision 1.67  2006/09/29 08:01:52  mmorozov
// - new: для документов устративших силу в предупрежедении выводим информацию о диапазоне действия актуальной редакции (CQ: OIT00011244);
//
// Revision 1.66  2006/09/29 07:23:14  mmorozov
// - new: перерисовываем дерево мои документов при получении нотификации об изменении количества не обработанных консультаций, меняют иконки (CQ: OIT500022747);
//
// Revision 1.65  2006/09/27 13:42:13  mmorozov
// В рамках работы над CQ: OIT500022679.
//
// - remove: TTagSearch, TTagSearchList, TAvailableTags. В списки были не работоспособны, в единственном месте где списки использовались, можно было обойтись _IAttributeInfo;
// - remove: неиспользуемые операции в enSelectedAttributesForm (enSelectedList: opAdd, opDelete, opChangeOperation);
// - new: TnsTaggedTreeInfo наделен логикой;
//
// Revision 1.64  2006/09/25 13:00:47  mmorozov
// - new behaviour: фильтруем все папки кроме "Мои документы" при сохранении/открытии объектов из моих документов;
// - new behaviour: папка "Мои документы" не скрывается при фильтрации по типу объекта;
// - _move: интерфейсы перенесены в модуль _nsInterfaces;
//
// Revision 1.63  2006/09/20 15:03:06  mmorozov
// - new: изменения в рамках работы над журналом работы пользователя;
//
// Revision 1.62  2006/08/24 13:33:46  oman
// - new beh: Экспорт консультаций в XML (cq22128)
//
// Revision 1.61  2006/08/22 13:13:58  oman
// - fix: Неопределенный результат функции (cq22371)
//
// Revision 1.60  2006/08/01 10:57:00  mmorozov
// - rename: local variables;
//
// Revision 1.59  2006/07/28 14:24:08  mmorozov
// - new: обработка открытия запросов из папки "Исходящие запросы";
// - new: обработка нотификации при отправке консультаций (не прошла валидацию, нет связи с сервером);
//
// Revision 1.58  2006/07/26 15:05:52  mmorozov
// - new: в письме разработчику выводим информацию о пользователе для которого сделана база (CQ: OIT500021485);
//
// Revision 1.57  2006/07/18 11:59:25  mmorozov
// - new: реакция оболочки на установку значений по умолчанию (CQ: OIT500021888);
//
// Revision 1.56  2006/07/03 05:24:49  oman
// -fix: Не компилировалось.
//
// Revision 1.55  2006/06/30 14:59:03  mmorozov
// - new: секретная операция "Информация о консультации" вызываемая по секретному shortcut-у. Операция открыавет вежливое письмо сопровождая его информаций о консультации;
// - change: обобщен код по работе с mailto (перенесено в nsUtils);
// - change: переименованы функции модуля bsConvert;
//
// Revision 1.54  2006/06/30 14:14:31  oman
// - new beh: В первом приближении прикрутил обработку линков для
//  интеграции (cq21517)
//
// Revision 1.53  2006/06/29 11:56:08  mmorozov
// - change: изменения в связи с поялением типа GblAdapter.TDateTime;
//
// Revision 1.52  2006/06/29 10:29:34  mmorozov
// - new behaviour: перед вставкой элемента в список анализируем его на предмет сортированности (CQ: OIT500021526);
//
// Revision 1.51  2006/06/27 11:08:50  mmorozov
// - bugfix: не обрабатывалось исключение при клонировании пустого списка (CQ: OIT500021503);
//
// Revision 1.50  2006/06/06 11:36:46  mmorozov
// - bugfix: если на экране было открыто уведомление консультации то нельзя было открыть ответ консультации (CQ: OIT00021243);
//
// Revision 1.49  2006/06/05 14:33:05  mmorozov
// - new behaviour: не открываем повторно одну и ту же консультацию (CQ: OIT500021143);
//
// Revision 1.48  2006/05/17 14:48:35  mmorozov
// - new behavour: при редактировании фильтра анализируем не только тип запроса но и состав атрибутов, чтобы открывать в конфигурации 5.х открывать старую карточку фильтров вместо ППР 5.х там где это уместно (OIT500020569);
//
// Revision 1.47  2006/05/16 07:36:01  mmorozov
// - bugfix: потерялся флаг "показывать в извлечениях" при переходе по цепочке документов (CQ: OIT500020718);
//
// Revision 1.46  2006/05/12 07:13:59  oman
// warning fix
//
// Revision 1.45  2006/05/05 13:11:12  mmorozov
// - работа над консультацией;
//
// Revision 1.44  2006/05/05 09:01:49  mmorozov
// - new: возможность оценить консультацию из папок;
//
// Revision 1.43  2006/05/04 13:12:12  mmorozov
// - работа над консультациями;
//
// Revision 1.42  2006/04/17 12:08:49  oman
// - change: Избавляем бизнес-объекты (слой модели) от обязательств
//  контроллера (хинты, imageindex)
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.41  2006/04/17 07:18:42  oman
// - change: Избавляем бизнес-объекты (слой модели) от обязательств
//  контроллера (хинты, imageindex)
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.40  2006/04/13 15:05:01  mmorozov
// - add comments;
//
// Revision 1.39  2006/04/12 13:14:54  oman
// - change: перевод механизма локализации строк на использование фабрик
// - new beh: Локализация nsc
//
// Revision 1.38  2006/04/12 09:53:04  mmorozov
// - изменены названия локальных переменных;
//
// Revision 1.37  2006/04/05 14:52:19  oman
// - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.
//
// Revision 1.36  2006/04/04 14:03:33  oman
// - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.
//
// Revision 1.35  2006/03/28 12:05:28  mmorozov
// - change: изменился тип возвращаемого результата после поиска;
//
// Revision 1.34  2006/03/28 11:56:34  oman
// - change: Изводим %s в константах + избавляемся от сборки сообщений из констант в коде.
//
// Revision 1.33  2006/03/27 07:19:16  mmorozov
// - bugfix: расширена проверка на наличие документа (cq: 20197);
//
// Revision 1.32  2006/03/15 14:12:58  oman
// - new beh: Перекладываем все текстовые константы в два места (StdStr и DebugStr)
//
// Revision 1.31  2006/03/15 12:26:07  mmorozov
// - new: при открытии форм для редактирования фильтров используем интерфейсы обмена данными;
//
// Revision 1.30  2006/03/01 12:16:29  mmorozov
// - new: в письме разработчикам появилось тело в виде названия комплекта и даты последнего обновления (CQ: 19150);
//
// Revision 1.29  2006/02/08 09:57:04  mmorozov
// - new: полезные функции в следствии рефакторинга _nsQueryUtils.GetContextFromQuery;
//
// Revision 1.28  2006/02/07 15:48:03  mmorozov
// - new: функции для работы с СКР документа;
//
// Revision 1.27  2005/12/23 14:07:35  lulin
// - убрано предупреждение.
//
// Revision 1.26  2005/12/23 13:25:23  mmorozov
// - bugfix: при разморозке ищем узлы корр\респ по имени;
//
// Revision 1.25  2005/12/21 11:26:57  mmorozov
// - bugfix: функция не возвращала результат;
//
// Revision 1.24  2005/12/20 14:36:45  mmorozov
// - bugfix: при открытии документа сразу после документа на контроле со статусом изменен, предупреждение не исчезало, логика перенесена на бизнес объект (cq: 00018776);
// - bugfix: не работа настройка "Автоматически сбрасывать статус изменен при открытии документа";
//
// Revision 1.23  2005/11/23 15:09:52  mmorozov
// bugfix: при открытии толкового словаря не сбрасывалась машина времени (cq: 00018266);
//
// Revision 1.22  2005/11/11 19:47:31  mmorozov
// new: в случае если доступна только одна операция при выборе поисковых атрибутов в форме выбранных атрибутов биение производится не по логическим операциям, а по родительским папкам;
//
// Revision 1.21  2005/11/04 09:39:16  demon
// - new behavior: "Поставить на контроль" в списке стала одна операция, которая понимает выделен один элемент или несколько
// - new behavior: операция "Поставить на контроль" для сущности "Выделенные документы" удалена
//
// Revision 1.20  2005/11/03 12:09:49  mmorozov
// new: флаг измененности списка;
//
// Revision 1.19  2005/11/01 15:24:32  demon
// - fix: неверно работала операция "поставить на контроль" для списков в child-zone
//
// Revision 1.18  2005/10/24 12:51:08  mmorozov
// bugfix: вместо открытия пустых списков выдается сообщение об отсутствии документов в базе;
//
// Revision 1.17  2005/10/18 16:46:36  mmorozov
// new: экспорт документов из списка (сохранение на диск);
//
// Revision 1.16  2005/10/12 13:04:07  mmorozov
// - работа над сборкой толкового словаря;
//
// Revision 1.15  2005/10/10 16:32:46  mmorozov
// - работа над сборкой толкового словаря;
//
// Revision 1.14  2005/10/05 09:47:51  mmorozov
// change: позиция в документе запись (тип ссылки, позиция);
//
// Revision 1.13  2005/10/04 16:43:16  demon
// - new behavior: восстановлена реализация SaveAs на списке
//
// Revision 1.12  2005/09/28 18:33:08  mmorozov
// - правки связанные с сортировкой списка;
//
// Revision 1.11  2005/09/27 13:38:50  demon
// - new behavior: Для группы "Редакции" сделана специальная обработка и подложена иконка
//
// Revision 1.10  2005/09/22 12:05:09  demon
// - new behavior: Расширен интерфейс IdeDocInfo
//
// Revision 1.9  2005/09/19 09:44:26  mmorozov
// change: клонирование списка;
//
// Revision 1.8  2005/09/16 10:41:00  mmorozov
// new: получение информации о списке;
//
// Revision 1.7  2005/09/16 09:46:51  mmorozov
// new: клонирование списка;
//
// Revision 1.6  2005/09/16 09:08:59  demon
// - fix: в операции _bsDocCount не обрабатывалась ситуация CanNotFindData
//
// Revision 1.5  2005/09/15 13:18:58  mmorozov
// - вычищение старого списка и переход на новый;
//
// Revision 1.4  2005/09/13 10:18:06  demon
// - new behavior: восстановлена работоспособность перехода по ссылке на другой документ
//
// Revision 1.3  2005/08/26 12:06:38  mmorozov
// change: сигнатура _bsDocInfoMake;
//
// Revision 1.2  2005/08/26 07:47:48  mmorozov
// new: function bsListClone;
//
// Revision 1.1  2005/08/24 09:33:45  mmorozov
// Новый модуль: общие функции и процедуры бизнес слоя;
//

interface

uses
  Classes,
  Graphics,

  afwInterfaces,

  k2Interfaces,

  l3Interfaces,
  l3Types,
  l3Tree_TLB,
  l3TreeInterfaces,
  l3Base,

  eeInterfaces,

  vcmExternalInterfaces,
  vcmInterfaces,

  BaseTypesUnit,
  BaseTreeSupportUnit,
  ConsultingUnit,
  DocumentUnit,
  DynamicDocListUnit,
  DynamicTreeUnit,
  FoldersUnit,
  SearchUnit,
  SettingsUnit,
  UnderControlUnit,
  PharmFirmListUnit,

  bsTypes,

  nsTypes,
  bsInterfaces,

  SearchDomainInterfaces,
  PrimPrimListInterfaces
  {$If not Defined(Admin) AND not Defined(Monitorings)}
  ,
  BaseSearchInterfaces,
  DocumentInterfaces,
  DocumentAndListInterfaces,
  UnderControlInterfaces
  {$IfEnd}

  ,
  evdTypes
  ;

{------------------------------------------------------------------------------}
{ Консультации                                                                 }
{------------------------------------------------------------------------------}
function bsIsSame(const aValue1 : IConsultation;
                  const aValue2 : IConsultation): Boolean;
  {* - сравнивает две консультации. }
function bsConsultationName(const aConsultation: IConsultation): Il3CString;
  {* - имя консультации. }
{------------------------------------------------------------------------------}
{ Папки                                                                        }
{------------------------------------------------------------------------------}
function bsCheckNodeType(const aNode : Il3SimpleNode;
                         const aType : TFoldersItemType): Boolean;
  {* - тип узла папок. }
function bsHasFlag(const aNode  : IeeNode;
                   const aFlags : array of LongWord): Boolean;
  overload;
  {* - наличие флага у узла INode. }
function bsHasFlag(const aNode  : Il3SimpleNode;
                   const aFlags : array of LongWord): Boolean;
  overload;
  {* - наличие флага у узла INode. }
function bsHasFlag(const aNode  : INode;
                   const aFlags : array of LongWord): Boolean;
  overload;
  {* - наличие флага у узла INode. }
function bsHasFlag(const aFlags      : LongWord;
                   const aCheckFlags : array of LongWord): Boolean;
  overload;
  {* - проверяет наличие флага. }
function bsHasFlag(const aFlags      : LongWord;
                   aCheckFlag : LongWord): Boolean;
  overload;
  {* - проверяет наличие флага. }
function bsGetConsultation(const aNode: Il3SimpleNode): IConsultation;
  {* - извлечь консультацию. }
function bsCanExportNodeToXML(const aNode: Il3SimpleNode): Boolean;
  {* - можно ли экспортировать ноду. }
procedure bsExportNodeToXML(const aNode     : Il3SimpleNode;
                            const aFileName : Tl3WString);
  {* - экспортировать ноду. }
function bsCanImportNodeFromXML(const aNode: Il3SimpleNode): Boolean;
  {* - можно ли импортировать в ноду. }
procedure bsImportNodeFromXML(const aNode     : Il3SimpleNode;
                              const aFileName : Tl3WString);
  {* - импортировать в ноду. }
function bsCanExportNodeToIntegrationXML(const aNode: Il3SimpleNode): Boolean;
  {* - можно ли экспортировать ноду. }
procedure bsExportNodeToIntegrationXML(const aNode: Il3SimpleNode);
  {* - эксопртировать текст XML в клипборд. }
function bsCalcUniqueName(const aParent: Il3Node; const aName: Il3CString; const aSuffix: Il3CString): Il3CString;
  {* - подобрать уникальное имя для сохранения в папки }  
{------------------------------------------------------------------------------}
{   Общие операции                                                             }
{------------------------------------------------------------------------------}
{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure bsEditorAddWikiPara(const aGen  : Ik2TagGenerator;
                              const aText : Tl3WString;
                              aFixedFont  : Boolean;
                              aDeleteLink : Boolean);
procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aAnchorNum     : TnsWarningSub = cNoneWarningSub;
                          aLinkHandle    : TnsWarningLinkHandle = cNone_LinkHandle;
                          aLinkStartPos  : Integer = 0;
                          aLinkEndPos    : Integer = 0;
                          anAddLinkText  : Il3CString = nil;
                          anAddLinkHandle: TnsWarningLinkHandle = cNone_LinkHandle;
                          aForeColor     : TColor = clWindowText;
                          aFontItalic    : Boolean = False;
                          NullifyIndent  : Boolean = False;
                          aJust          : TevIndentType = ev_itNone); overload;
  {* - добавить параграф, внутри котого может находится ссылка. }
procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aJust          : TevIndentType;
                          NullifyIndent  : Boolean = False); overload;
  { - }
{$IfEnd}
procedure bsAddLink(const aGen : Ik2TagGenerator;
                    aHandle    : Integer;
                    aStartPos,
                    aFinishPos : Integer);
  {* - добавить ссылку в редактор. }
function bsComplectOwner: Il3CString;
  {* - владелец информационного комплекта (для кого сделана база). }
function bsFindNodeByCaption(const aRoot : Il3Node;
                             const aNode : Tl3PCharLen): INodeBase;
  {* - найти узел по имени и вернуть его. }
function bsBaseDate: System.TDateTime;
  {* - дата обновления базы. }
function bsBaseDateStr: String;
  {* - дата обновления базы. }
function bsComplectName: Il3CString;
  {* - название комплекта. }
{$If not defined(Admin) AND not defined(Monitorings)}
function bsBuildFullList(const aList: IDynList): IDynList;
  {-}
{$IfEnd} //not Admin  
{------------------------------------------------------------------------------}
{   Дата                                                                       }
{------------------------------------------------------------------------------}
function bsIsDateEqual(const aDate1 : BaseTypesUnit.TDate;
                       const aDate2 : BaseTypesUnit.TDate): Boolean;
  {* - определяет равенство дат. }
{------------------------------------------------------------------------------}
{   Список                                                                     }
{------------------------------------------------------------------------------}
function bsListPrintOnlyFirstLevel(aList: TbsListType): Boolean;
  {-}
function bsIsListChanged(const aList: IDynList): Boolean;
  {* - определяет был ли изменен список. }
function bsIsListEmpty(const aList: IDynList): Boolean;
  {* - определяет пустой ли список. }
function bsListClone(const aList : IDynList) : IDynList;
  {* - клонирование списка. }
function bsDocCount(const aList: IDynList): Integer;
  {* - количество документов в списке. }
function bsListName(const aList: IDynList): Il3CString;
  {* - возвращает имя списка. }
function bsShortListName(const aList: IDynList): Il3CString;
  {* - возвращает короткое списка. }
function bsListCreationHistory(const aList: IDynList): Il3CString;
  {* - возвращает историю создания, изменения списка. }
function bsIsListSaved(const aList: IDynList): Boolean;
  {* - определяет был ли сохранен список. }
function bsListEntryInfo(const aNode: Il3SimpleNode): IListEntryInfo;
  overload;
  {* - получает интерфейс для работы с узлом списка. }
function bsListEntryInfo(const aNode: INodeBase): IListEntryInfo;
  overload;
  {* - получает интерфейс для работы с узлом списка. }
function bsMedicFirmListEntryInfo(const aNode: INodeBase): IPharmFirmListEntry;
  {* - получает интерфейс для работы с узлом списка. }
procedure bsMakeNewListName(const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  overload;
  {* - название для нового списка. }
procedure bsMakeNewListName(const aParent   : Il3Node;
                            const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  overload;
  {* - название для нового списка. }
function bsListType(const aList: IDynList): TbsListType;
  {* - тип списка. }
function bsListNodeType(const aNode: INodeBase): TbsListNodeType;
  {* - тип узла. }
{------------------------------------------------------------------------------}
{   Документ                                                                   }
{------------------------------------------------------------------------------}
{$If not defined(Admin) AND not defined(Monitorings)}
function bsConvertFilteredCRNode(const aNode: Il3SimpleNode): Il3SimpleNode;
  {* - По фильтрованной ноде получить нефильрованный аналог на полных деревьях СКР }
{$IfEnd}  
function bsRedationInfo(const aDocument: IDocument): TRedactionInfo;
  {* - получить информацию о редакциях документа. }
function bsIsCRUseAsUserCR(const aType : TlstCRType;
                           out aWeight : Integer): Boolean;
  {* - определяет используется ли корр\респ как пользовательская закладка. }
function bsUserCRNode(const aValue: TnsUserCRListId): IbsFrozenNode;
  {* - тип для первой пользовательской закладки. }
function bsIsCRNodeAreNotAllDocuments(const aNode: IbsFrozenNode): Boolean;
  overload;
  {* - Нода СКР не является "Все документы". }
function bsIsCRNodeAreNotAllDocuments(const aNode: INodeBase): Boolean;
  overload;
  {* - Нода СКР не является "Все документы". }
function bsUserCRList(const aValue: TnsUserCRListId): TlstCRType;
  {* - тип первой пользовательской закладки СКР. }
function bsGetCRType(const aNode: Il3SimpleNode): TNodeType;
  {* - тип СКР. }
(*function bsGetAllDocumentsCRNode: IbsFrozenNode;
  {* - Нода все документы }*)
{$If not defined(Admin) AND not defined(Monitorings)}
function bsDocInfoMake(const aListNode                 : INodeBase;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo: IdeSearchInfo = nil): IdeDocInfo;
 overload;
  {* - формирует интерфейс обмена данными для инициализации сборки документ. }
function bsDocInfoMake(const aData                     : IListEntryInfo;
                       const aListNode                 : INodeBase = nil;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo                : IdeSearchInfo = nil): IdeDocInfo;
 overload;
  {* - формирует интерфейс обмена данными для инициализации сборки документ. }
{$IfEnd}  
function bsExtractDocument(const aListNode : INodeBase): IDocument;
  overload;
  {* - извлекает из элемента списка документ. }
function bsExtractDocument(const aListNode : Il3SimpleNode): IDocument;
  overload;
  {* - извлекает из элемента списка документ. }
function bsCreateEditionDateInterval(const anActivIntervals: IActiveIntervalList): Il3CString;
  {* - Форматирует диапазон действия. }
{$If not (defined(Monitorings) or defined(Admin))}
function bsCreatePrintEditionWarning(const aDocument: IDocument): Il3CString;
  {* - Форматирует предупреждение для редакции для печати. }
{$IfEnd}  
{------------------------------------------------------------------------------}
{   Толковый словарь                                                           }
{------------------------------------------------------------------------------}
function bsLanguageImage(const aLanguage: TbsLanguage): Integer;
  {* - возвращает иконку для языка находящуюся в StdRes.ImageList. }
function bsLanguageCaption(const aLanguage: TbsLanguage): Il3CString;
  {* - возвращает иконку для языка находящуюся в StdRes.ImageList. }
{------------------------------------------------------------------------------}
{    Поиск                                                                     }
{------------------------------------------------------------------------------}
function bsIsOneOperation(const aOperations: TLogicOperationSet): Boolean;
  {* - количество операций доступные для данного атрибута. }
function bsDocumentList(const aEntity: ISearchEntity): IDynList;
  {* - получает список документов из aEntity. }
function bsMonitoringList(const aEntity: ISearchEntity): IDynList;
  {* - получает обзор законодательства. }
function bsGetOperations(const aTag : Il3CString) : TLogicOperationSet;
  overload;
  {* - получить список доступных операций. }
function bsGetOperations(const aAttrInfo : IAttributeInfo) : TLogicOperationSet;
  overload;
  {* - получить список доступных операций. }
{------------------------------------------------------------------------------}
{                                                                              }
{------------------------------------------------------------------------------}
function bsMakeSearchVisualizer(const aContext: Il3CString): IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации поиска. }
function bsMakeSaveVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации сохранения. }
function bsMakeExportVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации экспорта. }
function bsMakeEMailVisualizer: IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации отправки по почте. }
{$If not (defined(Monitorings) or defined(Admin))}
function bsCorrectMistakes(const aContext: Il3CString; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean; overload;
  {* - Разобрать контекст с исправлением опечаток и визуализацией процесса. }

function bsCorrectMistakes(const aContext: Il3StringsEx; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean; overload;
  {* - Разобрать контекст с исправлением опечаток и визуализацией процесса. }
{$IfEnd}

const
  c_bsCRWeights: array [0..1] of Integer = (40, 50);
    {* - веса расположения закладок Корр\Респ. }

implementation

uses
  SysUtils,
  Controls,
  ClipBrd,

  k2Tags,

  l3Nodes,
  l3AsincMessageWindow,
  l3String,
  l3Chars,
  l3Const,

  afwFacade,

  vcmBase,
  vcmForm,
  vcmSettings,
  vcmStringList,

  StdRes,
  SystemStr,

  DataAdapter,

  ComplectUnit,
  IOUnit,
  FiltersUnit,

  bsConvert,
  bsConst,
{$If not defined(Admin) AND not defined(Monitorings)}
  bsDataContainer,
  evCustomWikiReader,
  evDocumentEliminator,
  bsUtilsConst,
{$IfEnd}
  bsFrozenNode,

  nsAttributeTreeCacheNew,
  nsSettings,
  nsNodes,
  nsValueMapsIDs,
  nsValueMaps,
  nsListExecuteProgressIndicator,
  {$If not defined(Admin)}
  nsQuery,
  {$IfEnd}
  nsConst,
  {$If not (defined(Monitorings) or defined(Admin))}
  nsTimeMachine,
  deDocInfo,
  nsQuestionsWithChoices,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}
  nsINodeWrap,

  L10nInterfaces,
  vcmGUI,

  SegmentsLayer_Const,
  Hyperlink_Const,
  Sub_Const,
  TextPara_Const,

  bsTypesNew,

  vcmMessagesSupport,

  l3DateSt
  , Common_F1CommonServices_Contracts
  ;

procedure bsAddLink(const aGen : Ik2TagGenerator;
                    aHandle    : Integer;
                    aStartPos,
                    aFinishPos : Integer);
begin
 with aGen do
 begin
  StartTag(k2_tiSegments);
  try
   StartChild(k2_typSegmentsLayer);
   try
    AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperLinks));
    StartChild(k2_typHyperLink);
    try
     AddIntegerAtom(k2_tiStart, aStartPos);
     AddIntegerAtom(k2_tiFinish, aFinishPos);
     AddIntegerAtom(k2_tiHandle, aHandle);
    finally
     Finish; {k2_typHyperLink}
    end;
   finally
    Finish; {k2_typSegmentsLayer}
   end;
  finally
   Finish; {k2_tiSegments}
  end;
 end;
end;

{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure bsEditorAddWikiPara(const aGen  : Ik2TagGenerator;
                              const aText : Tl3WString;
                              aFixedFont  : Boolean;
                              aDeleteLink : Boolean);
var
 l_G : Ik2TagGenerator;
 l_E : TevDocumentEliminator;
 l_S : Il3CString;
begin
 l_S := l3CStr(aText);
 if not aDeleteLink then
  l_S := l3StringReplace(l_S,
                         str_wgReferenceHyperlinkSearchText.AsWStr,
                         str_wgReferenceHyperlinkReplaceText.AsWStr,
                         [rfReplaceAll])
 else
  l_S := l3StringReplace(l_S,
                         str_wgReferenceHyperlinkSearchText.AsWStr,
                         nsWStr(''),
                         [rfReplaceAll]);
 if aFixedFont then
 begin
  l_S := l3Cat('{fontsize:12}'#13#10 +
               '{justification:ev_itLeft}'#13#10, l_S);
  l_S := l3Cat(l_S, #13#10'{/justification}' +
                    #13#10'{/fontsize}');
 end//aFixedFont
 else
 begin // mdp.garant.ru/pages/viewpage.action?pageId=333545491
  l_S := l3Cat('{indent}'#13#10'{indent}'#13#10, l_S);
  l_S := l3Cat(l_S, #13#10'{/indent}'#13#10'{/indent}');
 end;
 l_G := aGen;
 l_E := TevDocumentEliminator.Create;
   // !!! SetTo тут нельзя использовать, т.к. там проблемы с FakeStarts и лишним CloseStructure !!!
 try
  l_E.Start;
  try
   l_E.Generator := l_G;
   try
    l_G := l_E;
    TevCustomWikiReader.SetFromStringTo(l_G, l_S.AsWStr).Execute;
   finally
    l_E.Generator := nil;
   end;//try..finally
  finally
   l_E.Finish;
  end;//try..finally
 finally
  FreeAndNil(l_E);
 end;//try..finally
end;
                          
procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aAnchorNum     : TnsWarningSub;
                          aLinkHandle    : TnsWarningLinkHandle;
                          aLinkStartPos  : Integer;
                          aLinkEndPos    : Integer;
                          anAddLinkText  : Il3CString;
                          anAddLinkHandle: TnsWarningLinkHandle;
                          aForeColor     : TColor;
                          aFontItalic    : Boolean;
                          NullifyIndent  : Boolean;
                          aJust          : TevIndentType);

 procedure lp_AddSub(const aGen : Ik2TagGenerator;
                  aAnchorNum : TnsWarningSub);
 begin
  with aGen do
  begin
   StartChild(k2_typSub);
   try
    AddIntegerAtom(k2_tiHandle, Ord(aAnchorNum));
   finally
    Finish; {k2_typSub}
   end;
  end;
 end;

var
 l_SegmentsStarted: Boolean;

 procedure lp_StartHyperLinks;
 begin
  if l_SegmentsStarted then
   Exit;
  with aGen do
  begin
   StartTag(k2_tiSegments);
   StartChild(k2_typSegmentsLayer);
   AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperLinks));
  end;
  l_SegmentsStarted := true;
 end;

 procedure lp_FinishHyperLinks;
 begin
  if not l_SegmentsStarted then
   Exit;
  with aGen do
  begin
   Finish;
   Finish;
  end;
  l_SegmentsStarted := false;
 end;

 procedure lp_AddHyperLink(aHandle: TnsWarningLinkHandle; aStartPos, aFinishPos : Integer);
 begin
  lp_StartHyperLinks;
  with aGen do
  begin
   StartChild(k2_typHyperLink);
   try
    AddIntegerAtom(k2_tiStart, aStartPos);
    AddIntegerAtom(k2_tiFinish, aFinishPos);
    AddIntegerAtom(k2_tiHandle, Ord(aHandle));
   finally
    Finish; {k2_typHyperLink}
   end;//try..finally
  end;//with aGen
 end;

var
 l_SearchString: Il3CString;
 l_Pos: Integer;
 l_AdditionalPos: Integer;
begin
 with aGen do
 begin
  StartChild(k2_typTextPara);
  try
   if NullifyIndent
      OR aFixedFont
      // - для баллонов отступ красной строки ВСЕГДА скидываем в 0
      // http://mdp.garant.ru/pages/viewpage.action?pageId=265408824&focusedCommentId=265409530#comment-265409530
      then
    AddIntegerAtom(k2_tiFirstIndent, 0);
   if aFixedFont then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=265408824&focusedCommentId=265409618#comment-265409618
    AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft))
   else
   if (aJust <> ev_itNone) then
    AddIntegerAtom(k2_tiJustification, Ord(aJust));
   // Добавляем Sub:
   if (aAnchorNum > cNoneWarningSub) then
    lp_AddSub(aGen, aAnchorNum);
   l_SegmentsStarted := False;
   try
    // Добавляем ссылку:
    if (aLinkHandle > cNone_LinkHandle) then
     lp_AddHyperLink(aLinkHandle, aLinkStartPos, aLinkEndPos);
    // прицепляем другие ссылки
    if not l3IsNil(anAddLinkText) and (anAddLinkHandle <> cNone_LinkHandle) then
    begin
     l_AdditionalPos := 0;
     l_SearchString := l3CStr(aText);
     repeat
      l_Pos := l3Pos(l_SearchString, anAddLinkText);
      if l_Pos <> l3NotFound then
      begin
       lp_AddHyperLink(anAddLinkHandle,
                       l_Pos + l_AdditionalPos + 1,
                       l_Pos + l_AdditionalPos + l3Len(anAddLinkText));
       l3Delete(l_SearchString, 0, l_Pos + l3Len(anAddLinkText));
       Inc(l_AdditionalPos, l_Pos + l3Len(anAddLinkText));
      end;//l_Pos <> l3NotFound
     until l_Pos = l3NotFound;
    end;
   finally
    lp_FinishHyperLinks;
   end;
   // Цвет текста:
   StartTag(k2_tiFont);
   try
    if aFixedFont then
     AddIntegerAtom(k2_tiSize, 12);
    AddIntegerAtom(k2_tiForeColor, aForeColor);
    AddBoolAtom(k2_tiItalic, aFontItalic);
   finally
    Finish;
   end;//try..finally
   // Добавляем текст:
   AddStringAtom(k2_tiText, aText);
  finally
   Finish; {ee_idTextPara}
  end;//try..finally
 end;//with aGen
end;//AddPara

procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aJust          : TevIndentType;
                          NullifyIndent  : Boolean);
  { - }
begin
 bsEditorAddPara(aGen, aText, aFixedFont,
                 cNoneWarningSub,
                 cNone_LinkHandle,
                 0,
                 0,
                 nil,
                 cNone_LinkHandle,
                 clWindowText,
                 False,
                 NullifyIndent,
                 aJust
                 );
end;
{$IfEnd}

function bsConsultationName(const aConsultation: IConsultation): Il3CString;
  {* - имя консультации. }
var
 l_Name: IString;
begin
 if aConsultation <> nil then
 begin
  aConsultation.GetName(l_Name);
  try
   Result := nsCStr(l_Name);
  finally
   l_Name := nil;
  end;//try..finally
 end//if aConsultation <> nil then
 else
  Result := nil;
end;//bsConsultationName

function bsIsSame(const aValue1 : IConsultation;
                  const aValue2 : IConsultation): Boolean;
  {* - сравнивает две консультации. }
var
 l_Value1 : IString;
 l_Value2 : IString;
begin
 Result := False;
 try
  aValue1.GetId(l_Value1);
 except
  on EDeleted do
   Exit;
 end;
 try
  try
   aValue2.GetId(l_Value2);
  except
   on EDeleted do
    Exit;
  end;
  try
   Result := l3Same(nsCStr(l_Value1), nsCStr(l_Value2));
  finally
   l_Value2 := nil;
  end;//try..finally
 finally
  l_Value1 := nil;
 end;//try..finally
end;

function bsGetConsultation(const aNode: Il3SimpleNode): IConsultation;
  {* - извлечь консультацию. }
var
 l_Node   : INode;
 l_Entity : IUnknown;
begin
 Result := nil;
 if bsCheckNodeType(aNode, FIT_CONSULTATION) and
  Supports(aNode, INode, l_Node) then
 try
  l_Node.Open(l_Entity);
  try
   Supports(l_Entity, IConsultation, Result);
  finally
   l_Entity := nil;
  end;{try..finally}
 finally
  l_Node := nil;
 end;{try..finally}
end;//bsGetConsultation

function bsCanExportNodeToXML(const aNode: Il3SimpleNode): Boolean;
  {* - можно ли экспортировать ноду. }
var
 l_Node: IFoldersNode;
begin
 Result := Supports(aNode, IFoldersNode, l_Node) and l_Node.CanSaveToXml;
end;

procedure bsExportNodeToXML(const aNode     : Il3SimpleNode;
                            const aFileName : Tl3WString);
  {* - экспортировать ноду. }
var
 l_Node: IFoldersNode;
begin
 if Supports(aNode, IFoldersNode, l_Node) then
  l_Node.SaveToXml(nsAStr(aFileName).S);
end;

function bsCanImportNodeFromXML(const aNode: Il3SimpleNode): Boolean;
  {* - можно ли импортировать в ноду. }
var
 l_Node: IFoldersNode;
begin
  Result := Supports(aNode, IFoldersNode, l_Node) and l_Node.CanLoadFromXml;
end;

procedure bsImportNodeFromXML(const aNode     : Il3SimpleNode;
                              const aFileName : Tl3WString);
  {* - импортировать в ноду. }
var
 l_Node: IFoldersNode;
begin
 if Supports(aNode, IFoldersNode, l_Node) then
  l_Node.LoadFromXml(nsAStr(aFileName).S);
end;

function bsCanExportNodeToIntegrationXML(const aNode: Il3SimpleNode): Boolean;
  {* - можно ли экспортировать ноду. }
var
 l_Node: IFoldersNode;
begin
  Result := Supports(aNode, IFoldersNode, l_Node) and l_Node.CanSaveToIntegrationXml;
end;

procedure bsExportNodeToIntegrationXML(const aNode: Il3SimpleNode);
  {* - можно ли экспортировать ноду. }
var
 l_Node: IFoldersNode;
 l_XML: IString;
begin
 if Supports(aNode, IFoldersNode, l_Node) then
 begin
  l_Node.SaveToIntegrationXml(l_XML);
  with ClipBoard do
  begin
   Open;
   try
    AsText := StrPas(l_XML.GetData);
   finally
    Close;
   end;
  end;
 end;
end;

function bsCalcUniqueName(const aParent: Il3Node; const aName: Il3CString; const aSuffix: Il3CString): Il3CString;
  {* - подобрать уникальное имя для сохранения в папки }

 function lp_BuildName(const aName: Il3CString; const anIndex: Il3CString; const aSuffix: Il3CString): Il3CString;
 const
  c_MaxLen = 70;
 var
  l_Name: Il3CString;
 begin
  l_Name := aName;
  if (l3Len(aName) + l3Len(anIndex) + l3Len(aSuffix)) > c_MaxLen then
  begin
   l3SetLen(l_Name, c_MaxLen - l3Len(anIndex) - l3Len(aSuffix) - 3);
   l_Name := l3Cat(l3Trim(l_Name), '...');
  end;
  Result := l3Cat([l_Name, anIndex, aSuffix]);
 end;

 function lp_BuildIndex(anIndex: Cardinal): Il3CString;
 begin
  if anIndex = 0 then
   Result := nil
  else
   Result := l3Fmt(l3CStr(' %d'), [anIndex]);
 end;

var
 l_NewName: Il3CString;

 function lp_CheckUniqueCaption(const Intf: Il3Node): Boolean;
 begin
  Result := l3Same(l_NewName, Intf.Text);
 end;

var
 l_Index: Cardinal;

begin
 l_Index := 0;
 repeat
  l_NewName := lp_BuildName(aName, lp_BuildIndex(l_Index), aSuffix);
  Inc(l_Index);
 until (aParent = nil) or (aParent.IterateF(l3L2NA(@lp_CheckUniqueCaption), imCheckResult) = nil);
 Result := l_NewName;
end;

function bsHasFlag(const aNode  : Il3SimpleNode;
                   const aFlags : array of LongWord): Boolean;
  // overload;
  {* - наличие флага у узла INode. }
var
 l_Node: INode;
begin
 Result := False;
 if Supports(aNode, INode, l_Node) then
  Result := bsHasFlag(l_Node, aFlags);
end;

function bsHasFlag(const aFlags      : LongWord;
                   const aCheckFlags : array of LongWord): Boolean;
  {* - проверяет наличие флага. }
var
 l_Index : Integer;
begin
 Result := False;
 for l_Index := Low(aCheckFlags) to High(aCheckFlags) do
  if aFlags and aCheckFlags[l_Index] = aCheckFlags[l_Index] then
  begin
   Result := True;
   Break;
  end;
end;

function bsHasFlag(const aFlags      : LongWord;
                   aCheckFlag : LongWord): Boolean;
  //overload;
  {* - проверяет наличие флага. }
begin
 Result := bsHasFlag(aFlags, [aCheckFlag]);
end;

function bsHasFlag(const aNode  : INode;
                   const aFlags : array of LongWord): Boolean;
  // overload;
  {* - наличие флага у узла INode. }
begin
 Result := bsHasFlag(LongWord(aNode.GetFlags), aFlags);
end;

function bsHasFlag(const aNode  : IeeNode;
                   const aFlags : array of LongWord): Boolean;
  {* - наличие флага у узла INode. }
var
 l_Node  : INode;
begin
 Result := False;
 if Supports(aNode, INode, l_Node) then
 try
  Result := bsHasFlag(l_Node, aFlags);
 finally
  l_Node := nil;
 end{try..finally}
end;//HasFlag

function bsCheckNodeType(const aNode : Il3SimpleNode;
                         const aType : TFoldersItemType): Boolean;

  {-}
var
 l_Node: INode;
begin
 Result := False;
 if Supports(aNode, INode, l_Node) then
 try
  Result := TFoldersItemType(l_Node.GetObjectType) = aType;
 finally
  l_Node := nil;
 end;{try..finally}
end;//TypeNode

function bsDocumentList(const aEntity: ISearchEntity): IDynList;
  {* - получает список документов из aEntity. }
var
 l_List: ISearchDynList;
begin
 if Supports(aEntity, ISearchDynList, l_List) then
 try
  l_List.GetDynList(Result);
 finally
  l_List := nil;
 end;{try..finally}
end;//bsDocumentList

function bsGetOperations(const aTag : Il3CString) : TLogicOperationSet;
  overload;
  {* - получить список доступных операций. }
var
 l_AttrInfo : IAttributeInfo;
begin
 Result := [];
 if not l3IsNil(aTag) then
 begin
  DefDataAdapter.Search.GetAttributeInfo(nsAStr(aTag).S, l_AttrInfo);
  try
   Result := bsGetOperations(l_AttrInfo);
  finally
   l_AttrInfo := nil;
  end;{try..finally}
 end;//if aTag <> '' then
end;//nsGetOperations

function bsGetOperations(const aAttrInfo : IAttributeInfo) : TLogicOperationSet;
  // overload;
  {* - получить список доступных операций. }
var
 l_Operations : IOperationList;
 l_Index      : Integer;
begin
 Result := [];
 aAttrInfo.GetAvailableOperations(l_Operations);
 if Assigned(l_Operations) then
  try
   for l_Index := 0 to Pred(l_Operations.Count) do
    Include(Result, bsAdapterToBusiness(l_Operations[l_Index]));
  finally
   l_Operations := nil;
  end;{try..finally}
end;//nsGetOperations

function bsMonitoringList(const aEntity: ISearchEntity): IDynList;
  {* - получает обзор законодательства. }
begin
 Supports(aEntity, IDynList, Result);
end;

{$If not defined(Admin) AND not defined(Monitorings)}
function bsBuildFullList(const aList: IDynList): IDynList;
  {-}
var
 l_Entity: ISearchEntity;
 l_Succsess: Boolean;
 l_Short: IFilterable;
 l_Full: IFilterable;
 l_Filters: IFiltersFromQuery;
begin
 Result := aList;
 if Assigned(aList) and aList.GetIsShort then
 begin
  l_Succsess := TnsListExecuteProgressIndicator.Make(aList).Execute(vcmCStr(str_seSearchTitle), l_Entity);
  if l_Succsess and Assigned(l_Entity) then
   with l_Entity do
    case GetResultType of
     SRT_DOCUMENT_LIST:
      begin
       Result := bsDocumentList(l_Entity);
       if Supports(aList, IFilterable, l_Short) and Supports(Result, IFilterable, l_Full) then
       begin
        l_Short.GetActiveFilters(l_Filters);
        if Assigned(l_Filters) and (l_Filters.Count > 0) then
         l_Full.ApplyFilters(l_Filters);
       end;
      end;
    else
     Assert(False, 'Не поддерживается');
    end;//case l_Entity.GetResultType of
 end
end;
{$IfEnd} //not Admin

function bsComplectName: Il3CString;
  {* - название комплекта. }
var
 l_Str: IString;
begin
 DefDataAdapter.CommonInterfaces.GetComplectName(l_Str);
 try
  Result := nsCStr(l_Str);
 finally
  l_Str := nil;
 end;{try..finally}
end;//bsComplectName

function bsBaseDate: System.TDateTime;
  {* - дата обновления базы. }
var
 l_Date: BaseTypesUnit.TDate;
begin
 DefDataAdapter.CommonInterfaces.GetBaseDate(l_Date);
 with l_Date do
  Result := EncodeDate(rYear, rMonth, rDay);
end;//bsBaseDate

function bsBaseDateStr: String;
  {* - дата обновления базы. }
begin
 //Result := l3DateToStr(bsBaseDate);
 Result := FormatDateTime('dd/mm/yyyy', bsBaseDate);
end;
  
function bsComplectOwner: Il3CString;
  {* - владелец информационного комплекта (для кого сделана база). }
var
 l_Owner : IString;
begin
 DefDataAdapter.NativeAdapter.MakeComplectInfo.GetOwner(l_Owner);
 Result := nsCStr(l_Owner);
end;

function bsFindNodeByCaption(const aRoot : Il3Node;
                             const aNode : Tl3PCharLen): INodeBase;
  {* - найти узел по имени и вернуть его. }
begin//bsFindNodeByCaption
 Supports(l3SearchByName(aRoot, aNode), INodeBase, Result);
end;//bsFindNodeByCaption

{ Дата }

function bsIsDateEqual(const aDate1 : BaseTypesUnit.TDate;
                       const aDate2 : BaseTypesUnit.TDate): Boolean;
  {* - определяет равенство дат. }
begin
 Result := (aDate1.rDay = aDate2.rDay) and
           (aDate1.rMonth = aDate2.rMonth) and
           (aDate1.rYear = aDate2.rYear);
end;//bsIsDataEqual

function bsIsOneOperation(const aOperations: TLogicOperationSet): Boolean;
  {* - количество операций доступные для данного атрибута. }
var
 l_Count : Integer;
 l_Op    : TLogicOperation;
begin
 l_Count := 0;
 Result := True;
 for l_Op := Low(TLogicOperation) to High(TLogicOperation) do
  if l_Op in aOperations then
  begin
   if l_Count = 0 then
    inc(l_Count)
   else
   begin
    Result := False;
    Exit;
   end
  end;
end;//bsIsOneOperation

function bsListPrintOnlyFirstLevel(aList: TbsListType): Boolean;
  {-}
begin
 case aList of
  bs_ltDocument:
   Result := afw.Settings.LoadBoolean(pi_DocumentList_PrintOnlyFirstLevel,
    dv_DocumentList_PrintOnlyFirstLevel);
  bs_ltDrug:
   Result := afw.Settings.LoadBoolean(pi_DrugList_PrintOnlyFirstLevel,
    dv_DrugList_PrintOnlyFirstLevel);
  else
  begin
   Result := True;
   Assert(False);
  end;
 end;
end;

function bsIsListChanged(const aList: IDynList): Boolean;
  {* - определяет был ли изменен список. }
var
 l_Entity: IEntityBase;
begin
 Result := False;
 if Supports(aList, IEntityBase, l_Entity) then
 try
  try
   Result := l_Entity.GetIsChanged;
  except
   on ECanNotFindData do
    Result := False;
  end;
 finally
  l_Entity := nil;
 end;{try..finally}
end;//bsIsListChanged

function bsIsListEmpty(const aList: IDynList): Boolean;
  {* - определяет пустой ли список. }
var
 l_Root: INodeBase;
begin
 Result := False;
 Assert(aList <> nil);
 l_Root := nil;
 aList.GetRoot(l_Root);
 Assert(l_Root <> nil);
 try
  Result := (l_Root.GetChildCount = 0);
 finally
  l_Root := nil;
 end;
end;

function bsLanguageCaption(const aLanguage: TbsLanguage): Il3CString;
  {* - возвращает иконку для языка находящуюся в StdRes.ImageList. }
begin
 Result := nsIntegerMapManager.Map[imap_Interface_Language].ValueToDisplayName(Ord(aLanguage));
end;

function bsLanguageImage(const aLanguage: TbsLanguage): Integer;
  {* - возвращает иконку для языка находящуюся в StdRes.ImageList. }
begin
 Result := cDocumentImage;
 case aLanguage of
  LG_RUSSIAN : Result := cRussianLangImage;
  LG_ENGLISH : Result := cEnglishLangImage;
  LG_GERMAN  : Result := cGermanLangImage;
  LG_FRENCH  : Result := cFrenchLangImage;
  LG_SPANISH : Result := cSpanishLangImage;
  LG_ITALIAN : Result := cItalianLangImage;
  else
   Assert(False);
 end;
end;

function bsIsListSaved(const aList: IDynList): Boolean;
  {* - определяет был ли сохранен список. }
var
 l_Entity: IEntityBase;
begin
 Result := False;
 if Supports(aList, IEntityBase, l_Entity) then
  Result := l_Entity.GetIsSaved;
end;

function bsListCreationHistory(const aList: IDynList): Il3CString;
  {* - возвращает историю создания, изменения списка. }
var
 l_Info : IString;
begin
 if Assigned(aList) then
  aList.GetHistory(l_Info)
 else
  l_Info := nil;
 Result := nsCStr(l_Info);
end;

function bsListName(const aList: IDynList): Il3CString;
  {* - возвращает имя списка. }
var
 l_String: IString;
begin
 if (aList <> nil) then
  aList.GetName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function bsShortListName(const aList: IDynList): Il3CString;
  {* - возвращает короткое списка. }
var
 l_String: IString;
begin
 if (aList <> nil) then
  aList.GetShortName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function bsDocCount(const aList: IDynList): Integer;
  {* - количество документов в списке. }
var
 l_Root: INodeBase;
begin
 Result := 0;
 if Assigned(aList) then
 begin
  try
   aList.GetRoot(l_Root);
   try
    Result := l_Root.GetChildCount;
   finally
    l_Root := nil;
   end;
  except
   on ECanNotFindData do
    Result := 0;
  end;
 end;
end;

function bsListClone(const aList : IDynList) : IDynList;
  {* - клонирование списка. }
var
 l_List: ICatalogBase;
begin
 Result := nil;
 if Assigned(aList) then
 try
  aList.Clone(l_List);
  Supports(l_List, IDynList, Result);
 except
  on ECanNotFindData do
 end;
end;//bsListClone

function bsExtractDocument(const aListNode : Il3SimpleNode): IDocument;
  // overload;
  {* - извлекает из элемента списка документ. }
var
 l_Node: INodeBase;
begin
 Result := nil;
 if Supports(aListNode, INodeBase, l_Node) then
 try
  Result := bsExtractDocument(l_Node);
 finally
  l_Node := nil;
 end;{try..finally}
end;

function bsExtractDocument(const aListNode : INodeBase): IDocument;
  // overload;
  {* - извлекает из элемента списка документ. }
var
 l_Info: IListEntryInfo;
 l_MedInfo: IPharmFirmListEntry;
begin
 l_Info := bsListEntryInfo(aListNode);
 if l_Info <> nil then
 try
  l_Info.GetDoc(Result);
 finally
  l_Info := nil;
 end
 else
 begin
  l_MedInfo := bsMedicFirmListEntryInfo(aListNode);
  if l_MedInfo <> nil then
  try
   l_MedInfo.GetDocument(Result)
  finally
   l_MedInfo := nil;
  end
  else
   Result := nil;
 end;
end;

{$If not defined(Admin) AND not defined(Monitorings)}
function bsConvertFilteredCRNode(const aNode: Il3SimpleNode): Il3SimpleNode;
  {* - По фильтрованной ноде получить нефильрованный аналог на полных деревьях СКР }
var
 l_Node: INodeBase;
begin
 if Supports(aNode, INodeBase, l_Node) then
  Result := TnsINodeWrap.Make(TbsCRTypeFrozen.Make(l_Node).Value)
 else
  Result := nil;
end;
{$IfEnd}

function bsRedationInfo(const aDocument: IDocument): TRedactionInfo;
  {* - получить информацию о редакциях документа. }
var
 l_State: IDocumentState;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 if Assigned(aDocument) then
 begin
  aDocument.GetCurrentState(l_State);
  try
   l_State.GetCurrentRedaction(Result);
  finally
   l_State := nil;
  end;//try..finally
 end;//if Assigned(aDocument) then
end;//bsRedationInfo

function bsIsCRUseAsUserCR(const aType : TlstCRType;
                           out aWeight : Integer): Boolean;
  {* - определяет используется ли корр\респ как пользовательская закладка. }
var
 l_Resp: Integer;
 l_Corr: Integer;

 function lp_AllDocumentsSelected(const aType        : TlstCRType;
                                  var aIndex         : Integer): Boolean;
   {* - есть ли такой тип пользовательской закладки. }
 begin
  Result := False;
  if (bsUserCRList(ulFirst) = aType) and
   not bsIsCRNodeAreNotAllDocuments(bsUserCRNode(ulFirst)) then
  begin
   Result := True;
   aIndex := 0;
  end;//if (bsUserCRList(ulFirst) = aType) and
  if (bsUserCRList(ulSecond) = aType) and
   not bsIsCRNodeAreNotAllDocuments(bsUserCRNode(ulSecond)) then
  begin
   Result := True;
   aIndex := 1;
  end;//if (bsUserCRList(ulSecond) = aType) and
 end;//bsHasUserCRType

begin
 Result := False;
 if lp_AllDocumentsSelected(crtRespondents, l_Resp) and
  lp_AllDocumentsSelected(crtCorrespondents, l_Corr) then
 begin
  case aType of
   crtCorrespondents:
    aWeight := c_bsCRWeights[l_Corr];
   crtRespondents:
    aWeight := c_bsCRWeights[l_Resp];
  end;
  Result := True;
 end;//if lp_AllDocumentsSelected(crtRespondents, l_Resp) and
end;//IsCRUseAsUserCR

function bsUserCRNode(const aValue: TnsUserCRListId): IbsFrozenNode;
  {* - тип для первой пользовательской закладки. }
var
 l_Converter: IbsCRSettingsConverter;
begin
 case aValue of
  ulFirst:
   if Supports(nsStringMapManager.Map[smap_SettingsCRType],
               IbsCRSettingsConverter,
               l_Converter) then
    Result := l_Converter.GetCRNodeByValue(
     afw.Settings.LoadString(pi_Document_CRType0, dv_Document_CRType0));
  ulSecond:
   if Supports(nsStringMapManager.Map[smap_SettingsCRType],
               IbsCRSettingsConverter,
               l_Converter) then
    Result := l_Converter.GetCRNodeByValue(afw.Settings.
     LoadString(pi_Document_CRType1, dv_Document_CRType1));
  else
  begin
   Result := nil;
   Assert(False);
  end;//else
 end;//case aValue of
end;//bsUserCRNode

(*function bsGetAllDocumentsCRNode: IbsFrozenNode;
  {* - Нода все документы }
var
 l_Converter: IbsCRSettingsConverter;
begin
 if Supports(nsStringMapManager.Map[smap_SettingsCRType],
             IbsCRSettingsConverter,
             l_Converter) then
  Result := l_Converter.GetCRNodeByValue(nsIntegerMapManager.Map[imap_SettingsCRTypes].ValueToDisplayName(Ord(PIT_ALL_DOCS)))
 else
  Result := nil;
end;*)

function bsUserCRList(const aValue: TnsUserCRListId): TlstCRType;
  {* - тип первой пользовательской закладки СКР. }
begin
 case aValue of
  ulFirst:
   Result := TlstCRType(afw.Settings.LoadInteger(pi_Document_CRSheet0,
                                                 dv_Document_CRSheet0));
  ulSecond:
   Result := TlstCRType(afw.Settings.LoadInteger(pi_Document_CRSheet1,
                                                 dv_Document_CRSheet1));
  else
  begin
   Result := Low(TlstCRType);
   Assert(False);
  end;//else
 end;//case aValue of
end;//bsUserCRList

function bsGetCRType(const aNode: Il3SimpleNode): TNodeType;
  {* - тип СКР. }
var
 l_Node: INodeBase;
begin
 if Supports(aNode, INodeBase, l_Node) then
  Result := l_Node.GetType
 else
  Result := High(TNodeType);
end;

function bsIsCRNodeAreNotAllDocuments(const aNode: IbsFrozenNode): Boolean;
  {* - Нода СКР не является "Все документы". }
begin
 if Assigned(aNode) and aNode.HasNode then
  Result := bsIsCRNodeAreNotAllDocuments(aNode.Value)
 else
  Result := true;
end;

function bsIsCRNodeAreNotAllDocuments(const aNode: INodeBase): Boolean;
  {* - Нода СКР не является "Все документы". }
begin
 if (aNode = nil) then
  Result := true
 else
  // В связи с новыми 64-битными kind неправильно отображались СКР
  // http://mdp.garant.ru/pages/viewpage.action?pageId=466761779
  Result := aNode.GetType <> ALL_DOCUMENTS_KIND;
  (*Result := TPrefixItemType(aNode.GetType) <> PIT_ALL_DOCS;*)
end;

{$If not defined(Admin) AND not defined(Monitorings)}
function bsDocInfoMake(const aData                     : IListEntryInfo;
                       const aListNode                 : INodeBase = nil;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo: IdeSearchInfo = nil): IdeDocInfo;
  {* - формирует интерфейс обмена данными для инициализации сборки документ. }
begin
 if (aData <> nil) then
 begin
  Result := TdeDocInfo.MakeFromList(TbsListNodeContainer.Make(aListNode, aData),
                                    TnsListInfo_C(aList,
                                                  aListNode,
                                                  aListRoot,
                                                  aCorrectByTimeMachine,
                                                  aQueryInfo),
                                    TbsDocPos_C(bsAdapterToBusiness(aData.GetType),
                                                aData.GetPosition),
                                    aLanguage);
 end//aData <> nil
 else
  Result := nil;
end;

function bsDocInfoMake(const aListNode                 : INodeBase;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo: IdeSearchInfo = nil): IdeDocInfo;
  {* - формирует интерфейс обмена данными для инициализации сборки документ. }
var
 l_Info: IListEntryInfo;
 l_MedInfo: IPharmFirmListEntry;
begin
 l_Info := bsListEntryInfo(aListNode);
 if l_Info <> nil then
 begin
  try
   Result := TdeDocInfo.MakeFromList(TbsListNodeContainer.Make(aListNode,
                                                               l_Info),
                                     TnsListInfo_C(aList,
                                                   aListNode,
                                                   aListRoot,
                                                   aCorrectByTimeMachine,
                                                   aQueryInfo),
                                     TbsDocPos_C(bsAdapterToBusiness(l_Info.GetType),
                                                 l_Info.GetPosition),
                                     aLanguage);
  finally
   l_Info := nil;
  end;//if Supports(l_Entity,
 end//if Assigned(aListNode) then
 else
 begin
  l_MedInfo := bsMedicFirmListEntryInfo(aListNode);
  if l_MedInfo <> nil then
  try
   Result := TdeDocInfo.MakeFromList(TbsMedicFirmNodeContainer.Make(aListNode,
                                                                    l_MedInfo),
                                     TnsListInfo_C(aList,
                                                   aListNode,
                                                   aListRoot,
                                                   aCorrectByTimeMachine,
                                                   aQueryInfo),
                                     TbsDocPos_E,
                                     aLanguage);
  finally
   l_MedInfo := nil;
  end
  else
   Result := nil;
 end;
end;//bsDocInfoMake
{$IfEnd}

function bsCreateEditionDateInterval(const anActivIntervals: IActiveIntervalList): Il3CString;
  {* - Форматирует диапазон действия. }
var
 l_IntervalStr : Il3CString;
 J             : Integer;
 l_Count       : LongInt;
 l_Interval    : TDateInterval;
begin
 if (anActivIntervals = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=260447845&focusedCommentId=320742195#comment-320742195
 begin
  Result := nil;
  Exit;
 end;//anActivIntervals = nil
 l_Count := anActivIntervals.Count;
 if l_Count = 0 then
  Result := nil
 else
  if (l_Count - 1 = 0) then
  begin
   anActivIntervals.pm_GetItem(0, l_Interval);
   l_IntervalStr := IntervalToString(l_Interval);
   if not l3IsNil(l_IntervalStr) then
    Result := l3Cat([vcmCStr(str_dwRedactionDateDiapazone), l_IntervalStr])
   else
    Result := nil;
  end//l_Count - 1 = 0
  else
  begin
   Result := vcmCStr(str_dwRedactionDateDiapazones);

   for J := 0 to l_Count - 1 do
   begin
    anActivIntervals.pm_GetItem(J, l_Interval);
    Result := l3Cat([Result, IntervalToString(l_Interval)]);
    if (J <> (l_Count - 1)) then
     Result := l3Cat(Result, ', ');
   end;//for J
  end;//l_Count - 1 = 0
end;

{$If not (defined(Monitorings) or defined(Admin))}
function bsCreatePrintEditionWarning(const aDocument: IDocument): Il3CString;
  {* - Форматирует предупреждение для редакции для печати. }
var
 l_State: IDocumentState;
 l_RedactionInfo    : TRedactionInfo;
 l_DateInterval: Il3CString;
begin
 aDocument.GetCurrentState(l_State);
 if not TCommonService.Instance.IsCurEditionActual(l_State) then
 begin
  l_State.GetCurrentRedaction(l_RedactionInfo);
  l_DateInterval := bsCreateEditionDateInterval(l_RedactionInfo.rActiveIntervals);
  if Assigned(l_DateInterval) then
   Result := vcmFmt(str_PrintEditionWarningWithDate,[l_DateInterval])
  else
   Result := vcmCStr(str_PrintEditionWarning);
 end
 else
  Result := nil;
end;
{$IfEnd}

function bsListType(const aList: IDynList): TbsListType;
  {* - тип списка. }
begin
 Result := bs_ltNone;
 if (aList <> nil) then
  case aList.GetContentType of
   DLC_LEGAL_DOCUMENTS:
    Result := bs_ltDocument;
   DLC_MEDICAL_DOCUMENTS:
    Result := bs_ltDrug;
   else
    Assert(False);
  end;//case ImpList.GetContentType of
end;

function bsListNodeType(const aNode: INodeBase): TbsListNodeType;
  {* - тип узла. }
begin
 if Assigned(aNode) then
  Result := cbsListNodeTypeMap[TListNodeType(aNode.GetType)]
 else
  Result := lntDocActive;
end;

procedure bsMakeNewListName(const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  {* - название для нового списка. }
begin
 bsMakeNewListName(nil, aSource, aTarget, aSelected);
end;

procedure bsMakeNewListName(const aParent   : Il3Node;
                            const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  {* - название для нового списка. }
var
 l_NewName: Il3CString;
 l_Name  : IString;
const
 c_Frm  = ' (%d)';

  begin
 l_NewName := bsCalcUniqueName(aParent, bsListName(aSource), l3Fmt(l3CStr(c_Frm), [aSelected]));
 l_Name := nsIStr(l_NewName);
 try
  aTarget.SetName(l_Name);
 finally
  l_Name := nil;
 end;//try..finally
end;//bsMakeNewListName

function bsListEntryInfo(const aNode: Il3SimpleNode): IListEntryInfo;
  // overload;
  {* - получает интерфейс для работы с узлом списка. }
var
 l_Node: INodeBase;
begin
 if Supports(aNode, INodeBase, l_Node) then
  Result := bsListEntryInfo(l_Node)
 else
  Result := nil;
end;

function bsListEntryInfo(const aNode: INodeBase): IListEntryInfo;
  {* - получает интерфейс для работы с узлом списка. }
var
 l_Entity: IEntityBase;
begin
 if (aNode <> nil) then
 begin
  try
   aNode.GetEntity(l_Entity);
   try
    Supports(l_Entity, IListEntryInfo, Result);
   finally
    l_Entity := nil;
   end;//try..finally
  except
   // Сущность не может быть получена:
   on ENoEntity do
    Result := nil;
  end;//try..except
 end//aNode <> nil
 else
  Result := nil;
end;

function bsMedicFirmListEntryInfo(const aNode: INodeBase): IPharmFirmListEntry;
  {* - получает интерфейс для работы с узлом списка. }
var
 l_Entity: IEntityBase;
begin
 if (aNode <> nil) then
 begin
  try
   aNode.GetEntity(l_Entity);
   try
    Supports(l_Entity, IPharmFirmListEntry, Result);
   finally
    l_Entity := nil;
   end;//try..finally
  except
   // Сущность не может быть получена:
   on ENoEntity do begin end;
  end;//try..except
 end//aNode <> nil
 else
  Result := nil;
end;

function bsMakeSearchVisualizer(const aContext: Il3CString): IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации поиска. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(vcmFmt(str_SearchContextMessage,
                                                            [aContext]),
                                                     0,
                                                     afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cFindContextImage)
end;

function bsMakeSaveVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации сохранения. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(aCaption, 0, afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cSaveToFileImage);
end;

function bsMakeExportVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации экспорта. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(aCaption, 0, afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cExportToWordImage);
end;

function bsMakeEMailVisualizer: IafwLongProcessVisualizer;
  {* - Создать асинхронное окно для визуализации отправки по почте. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(vcmCStr(str_MailVisualizer),
                                                     0, afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cExportToEMailImage);
end;

{$If not (defined(Monitorings) or defined(Admin))}
function bsCorrectMistakes(const aContext: Il3CString; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean; overload;
  {* - Разобрать контекст с исправлением опечаток и визуализацией процесса. }
var
 l_Context: Il3StringsEx;
begin
 l_Context := TvcmStringList.Make;
 l_Context.Add(aContext);
 Result := bsCorrectMistakes(l_Context, aForInpharm, aCorrector);
end;

function bsCorrectMistakes(const aContext: Il3StringsEx; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean;
  {* - Разобрать контекст с исправлением опечаток и визуадлизацией процесса. }
var
 l_Visualizer : IafwLongProcessVisualizer;
 l_CorrectedContext: Il3StringsEx;
 l_MistakesList: Il3StringsEx;
 l_Words: Il3CString;
 l_IDX: Integer;
 l_AskResult: Integer;
begin
 l_Visualizer := afw.Application.MakeLongProcessVisualizer(vcmCStr(str_ParsingContext),
                                                     0,
                                                     100,
                                                     dmStdRes.LargeImageList,
                                                     cFindContextImage);
 try
  Result := DefDataAdapter.CorrectMistakes(aContext, aForInpharm, l_CorrectedContext,
                                           l_MistakesList);
 finally
  l_Visualizer := nil;
 end;
 if Result then
 begin
  Assert(Assigned(aCorrector));
  aCorrector.Correct(l_CorrectedContext, l_MistakesList);
  if Assigned(l_MistakesList) then
  begin
   l_Words := nil;
   for l_IDX := 0 to l_MistakesList.Count - 1 do
   begin
    if Assigned(l_Words) then
     l_Words := l3Cat([l_Words, l3CStr(', ')]);
    l_Words := l3Cat([l_Words, l_MistakesList.ItemC[l_IDX]]);
   end;
   l_AskResult := vcmMessageDlg(str_SearchUnresolvedContext,[l_Words]);
   if (l_AskResult = mrNo) OR (l_AskResult = -2) then
    Result := False;
  end;//Assigned(l_MistakesList)
 end;//Result
end;
{$IfEnd}

end.
