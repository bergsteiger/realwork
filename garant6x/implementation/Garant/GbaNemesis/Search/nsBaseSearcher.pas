unit nsBaseSearcher;

// $Id: nsBaseSearcher.pas,v 1.199 2016/08/15 12:02:40 morozov Exp $

// $Log: nsBaseSearcher.pas,v $
// Revision 1.199  2016/08/15 12:02:40  morozov
// {RequestLink: 624870575}
//
// Revision 1.198  2016/07/26 12:56:10  lulin
// - перегенерация.
//
// Revision 1.197  2016/07/21 10:09:19  morozov
// {RequestLink: 624870575} Откатил
//
// Revision 1.196  2016/07/20 10:53:56  morozov
// {RequestLink: 624870575}
//
// Revision 1.195  2016/07/15 11:29:13  lulin
// - выпрямляем зависимости.
//
// Revision 1.194  2016/05/19 09:16:46  morozov
// {RequestLink: 607262792}
//
// Revision 1.193  2016/05/11 10:17:55  morozov
// {RequestLink: 623065673}
//
// Revision 1.192  2016/05/05 08:31:02  morozov
// {RequestLink: 622656003}
//
// Revision 1.191  2016/05/04 09:35:00  morozov
// {RequestLink: 607262792}
//
// Revision 1.190  2016/04/29 08:43:20  morozov
// {RequestLink: 622413531}
//
// Revision 1.189  2016/03/28 10:10:09  kostitsin
// {requestlink: 610093358 }
//
// Revision 1.188  2016/03/25 08:29:29  morozov
// {RequestLink: 619725581}
//
// Revision 1.187  2015/12/22 12:14:20  morozov
// {RequestLink: 609899254}
//
// Revision 1.186  2015/12/22 10:57:49  morozov
// {RequestLink: 613712939}
//
// Revision 1.185  2015/12/18 09:52:33  morozov
// {RequestLink: 612549121}
//
// Revision 1.184  2015/12/18 06:36:59  morozov
// {RequestLink: 613712939}
//
// Revision 1.183  2015/11/18 12:06:13  morozov
// {RequestLink: 611210158}
//
// Revision 1.182  2015/11/05 10:03:01  morozov
// {RequestLink: 610745222}
//
// Revision 1.181  2015/11/02 12:08:35  morozov
// Чтобы собиралось
//
// Revision 1.180  2015/10/22 11:38:51  morozov
// {RequestLink: 609899254}
//
// Revision 1.179  2015/10/22 08:33:27  morozov
// {RequestLink: 609899254}
//
// Revision 1.177  2015/10/21 12:37:17  morozov
// {RequestLink: 609899254}
//
// Revision 1.176  2015/10/08 14:39:47  kostitsin
// {requestlink: 297704553 }
//
// Revision 1.175  2015/09/30 09:22:26  morozov
// {RequestLink: 607522449}
//
// Revision 1.174  2015/08/13 12:18:35  morozov
// {RequestLink: 605134793}
//
// Revision 1.173  2015/08/12 16:36:53  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=13532&focusedCommentId=605363355#comment-605363355
//
// Revision 1.172  2015/07/28 13:20:16  morozov
// {RequestLink: 578895365}
//
// Revision 1.171  2015/07/28 12:47:17  morozov
// {RequestLink: 578895365}
//
// Revision 1.170  2015/07/22 09:43:06  morozov
// {RequestLink: 603590185}
//
// Revision 1.169  2015/07/14 05:46:32  morozov
// Не собралась сборка
//
// Revision 1.168  2015/07/13 11:15:20  morozov
// {RequestLink: 603402531}
//
// Revision 1.167  2015/03/10 09:26:00  kostitsin
// {requestlink: 588808889 }
//
// Revision 1.166  2015/03/06 07:24:44  morozov
// {RequestLink: 566792807}
//
// Revision 1.165  2015/02/24 08:25:37  morozov
// {RequestLink: 589107194}
//
// Revision 1.164  2014/10/16 12:37:51  morozov
// {RequestLink: 567573990}
//
// Revision 1.163  2014/10/15 08:37:31  morozov
// {RequestLink: 566792807}
//
// Revision 1.162  2014/10/10 11:10:17  morozov
// {RequestLink: 547719861}
//
// Revision 1.161  2014/10/10 07:48:39  morozov
// {RequestLink: 566792807}
//
// Revision 1.160  2014/10/09 09:46:54  morozov
// {RequestLink: 566792807}
//
// Revision 1.159  2014/10/07 08:28:50  morozov
// {RequestLink: 566113866}
//
// Revision 1.158  2014/10/07 06:15:41  morozov
// {RequestLink: 566113866}
//
// Revision 1.157  2014/04/25 14:12:39  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.156  2013/06/21 13:41:43  morozov
// {RequestLink:461708253}
//
// Revision 1.155  2013/05/29 16:14:30  lulin
// - портируем под XE4.
//
// Revision 1.154  2013/04/15 12:19:51  kostitsin
// no message
//
// Revision 1.153  2013/04/15 11:09:12  kostitsin
// [$406500580]
//
// Revision 1.152  2013/04/15 10:54:26  kostitsin
// [$406500580]
//
// Revision 1.151  2012/11/28 15:16:28  kostitsin
// небольшая чистка кода
//
// Revision 1.150  2012/11/26 13:17:15  kostitsin
// [$410619458] - при базовом поиске теперь каждый раз загружается новый список фильтров
//
// Revision 1.149  2012/10/22 17:59:27  lulin
// {RequestLink:405475133}
//
// Revision 1.148  2012/08/06 17:47:01  lulin
// {RequestLink:380046115}
//
// Revision 1.147  2012/04/09 08:38:46  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.146  2012/03/12 15:10:29  lulin
// {RequestLink:296618130}
//
// Revision 1.145  2012/01/24 14:25:25  lulin
// {RequestLink:330139744}
// - вставляем диагностику на предмет того, что главняе окна СОВПАДАЮТ.
//
// Revision 1.144  2012/01/18 17:20:23  lulin
// {RequestLink:327353057}
//
// Revision 1.143  2011/12/16 14:17:37  lulin
// {RequestLink:294600483}
//
// Revision 1.142  2011/12/12 13:24:12  lulin
// {RequestLink:300026165}
//
// Revision 1.141  2011/11/24 09:06:20  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=297705374
//
// Revision 1.140  2011/11/10 12:03:55  lulin
// {RequestLink:297701079}
// - прикручиваем диагностику наличия формы БП.
//
// Revision 1.139  2011/11/10 11:45:42  lulin
// - правим эталоны.
//
// Revision 1.138  2011/11/08 17:11:28  lulin
// - стараемся не расстраиваться, если не удалось сохраниться в историю.
//
// Revision 1.137  2011/11/07 14:54:36  lulin
// {RequestLink:269069309}
//
// Revision 1.136  2011/11/07 12:15:14  lulin
// {RequestLink:269069309}
//
// Revision 1.135  2011/10/14 14:46:23  lulin
// {RequestLink:269084953}.
//
// Revision 1.134  2011/06/17 13:46:38  lulin
// {RequestLink:269078664}.
//
// Revision 1.133  2011/06/14 19:14:43  lulin
// {RequestLink:269058314}.
//
// Revision 1.132  2011/06/07 11:13:17  lulin
// {RequestLink:268345098}.
// - вычищаем хвосты.
//
// Revision 1.131  2011/06/07 10:08:56  lulin
// {RequestLink:268345098}.
//
// Revision 1.130  2011/06/02 11:02:03  lulin
// {RequestLink:266897327}.
//
// Revision 1.129  2011/06/02 10:47:00  lulin
// {RequestLink:266897327}.
//
// Revision 1.128  2011/06/01 19:18:16  lulin
// {RequestLink:266897327}.
//
// Revision 1.127  2011/03/28 17:19:36  lulin
// {RequestLink:257393788}.
//
// Revision 1.126  2011/03/11 19:37:46  lulin
// {RequestLink:228688510}.
// - №2.
// - №3 частично.
//
// Revision 1.125  2011/03/11 18:05:00  lulin
// {RequestLink:228688510}.
// - впихиваем БП в специально подготовленный контейнер.
//
// Revision 1.124  2011/03/11 13:12:34  lulin
// {RequestLink:228688510}. №1.
//
// Revision 1.123  2010/11/30 13:30:32  lulin
// {RequestLink:228688602}.
// - немножко перерисовываем.
//
// Revision 1.122  2010/10/25 09:55:14  lulin
// {RequestLink:237502802}.
// Шаг №3.
//
// Revision 1.121  2010/10/07 14:13:00  oman
// - new: Переносим заглушки на модель {RequestLink:235057812}
//
// Revision 1.120  2010/06/01 11:12:57  oman
// - new: {RequestLink:216793285}
//
// Revision 1.119  2010/06/01 09:14:55  oman
// - new: {RequestLink:216793285}
//
// Revision 1.118  2010/05/26 12:09:58  oman
// - new: {RequestLink:197493008}
//
// Revision 1.117  2010/05/21 10:14:16  oman
// - new: Поиск {RequestLink:207004300}
//
// Revision 1.116  2010/04/29 09:43:52  lulin
// {RequestLink:159352361}.
// - описываем идентификаторы форм на модели.
//
// Revision 1.115  2010/04/09 07:52:07  oman
// - new: {RequestLink:201491867}
//
// Revision 1.114  2009/12/24 10:36:51  oman
// - fix: {RequestLink:174295675}
//
// Revision 1.113  2009/12/14 13:33:39  oman
// - new: {RequestLink:171542353}
//
// Revision 1.112  2009/11/05 11:41:44  oman
// - new: {RequestLink:121160631}
//
// Revision 1.111  2009/10/26 09:23:55  oman
// - fix: {RequestLink:121160631}
//
// Revision 1.110  2009/10/16 13:26:54  oman
// - new: Переносим на модель {RequestLink:164596503}
//
// Revision 1.109  2009/10/16 08:38:25  oman
// - new: Учимся распознавать разный контекст {RequestLink:164596503}
//
// Revision 1.108  2009/10/15 14:42:36  lulin
// {RequestLink:166856141}.
//
// Revision 1.107  2009/10/14 18:39:55  lulin
// {RequestLink:166855347}.
//
// Revision 1.106  2009/10/06 16:45:53  lulin
// {RequestLink:162596818}. Правильно ведём себя при хождении по истории, а также при открытии ОМ, если уже был открыт Базовый Поиск.
//
// Revision 1.105  2009/10/05 18:42:37  lulin
// {RequestLink:162596818}. Первые штрихи.
//
// Revision 1.104  2009/09/21 17:31:17  lulin
// - избавляемся от внутренних методов модуля, связанных с базовым поиском.
//
// Revision 1.103  2009/09/15 16:32:54  lulin
// - основной модуль мониторингов полностью перенесён на модель.
//
// Revision 1.102  2009/09/07 12:19:08  oman
// - new: Фильтруем - {RequestLink:161121505}
//
// Revision 1.101  2009/09/03 18:49:13  lulin
// - реструктуризируем поиски и удаляем ненужное.
//
// Revision 1.100  2009/09/03 13:26:17  lulin
// - делаем прецеденты более изолированными друг от друга.
//
// Revision 1.99  2009/07/20 12:09:43  oman
// - fix: {RequestLink:155026758}
//
// Revision 1.98  2009/06/08 07:25:39  oman
// - new: Спрашиваем обрезанный список - [$140286494]
//
// Revision 1.97  2009/05/20 07:29:45  oman
// - fix: Не обновлялась кнопочка - [$136939327]
//
// Revision 1.96  2009/05/15 06:01:07  oman
// - new: Пытаемся показывать - [$125404858]
//
// Revision 1.95  2009/05/05 10:00:13  oman
// - new: Опознаем смену документа - [$136939327]
//
// Revision 1.94  2009/05/05 07:12:29  oman
// - new: Пытаемся показывать количество найденных - [$136939327]
//
// Revision 1.93  2009/05/04 09:58:22  oman
// - new: заготовки потрохов - [$136939327]
//
// Revision 1.92  2009/02/10 19:04:03  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.91  2009/02/10 18:47:31  lulin
// - <K>: 133891247. Выделяем интерфейсы работы с адаптером и советами дня.
//
// Revision 1.90  2009/02/10 15:43:43  lulin
// - <K>: 133891247. Выделяем интерфейсы локализации.
//
// Revision 1.89  2009/02/10 12:53:52  lulin
// - <K>: 133891247. Выделяем интерфейсы настройки.
//
// Revision 1.88  2009/02/09 19:17:30  lulin
// - <K>: 133891247. Выделяем интерфейсы поиска.
//
// Revision 1.87  2009/01/12 15:58:38  lulin
// - <K>: 133138664. № 22.
//
// Revision 1.86  2008/12/25 12:20:19  lulin
// - <K>: 121153186.
//
// Revision 1.85  2008/12/24 19:49:52  lulin
// - <K>: 121153186.
//
// Revision 1.84  2008/12/23 19:40:15  lulin
// - <K>: 133138664.
//
// Revision 1.83  2008/12/08 09:33:27  lulin
// - <K>: 128292941.
//
// Revision 1.82  2008/12/04 14:59:09  lulin
// - <K>: 121153186.
//
// Revision 1.81  2008/11/20 18:40:18  lulin
// - используем кошерный шаблон.
//
// Revision 1.80  2008/07/07 06:46:10  mmorozov
// - bugfix: уточнить в списке (K<96484582>);
//
// Revision 1.79  2008/06/20 07:46:01  oman
// - fix: Не ставился хинт (cq29294)
//
// Revision 1.78  2008/06/20 06:31:58  oman
// - new: Для отсутствуюзих видов информации в БП не выводим суффикс (cq29294)
//
// Revision 1.77  2008/06/20 06:11:12  oman
// - new: Для отсутствующих классов выводим хинт - более структурный подход (cq29294)
//
// Revision 1.76  2008/06/18 10:43:10  oman
// - new: Переделка исправления опечаток (cq29204)
//
// Revision 1.75  2008/06/18 06:11:55  mmorozov
// - new: применение постоянных фильтров при базовом поиске (CQ: OIT5-29196);
//
// Revision 1.74  2008/06/09 11:39:50  demon
// - new: функция ISearch.CorrectContext получила дополнительный параметр - для Инфарм или нет
//
// Revision 1.73  2008/05/27 05:25:01  mmorozov
// - change: измененилось место регистрации события использования примера.
//
// Revision 1.72  2008/05/22 11:18:15  oman
// - fix: Исправляем опечатки при контекстном поиске (cq29024)
//
// Revision 1.71  2008/05/22 10:45:13  oman
// - fix: Исправляем опечатки в БП (cq29024)
//
// Revision 1.70  2008/05/04 09:07:44  oman
// - new: Очередное изменение БП (cq28613)
//
// Revision 1.69  2008/04/30 07:00:22  mmorozov
// - new: регистрация события использования примера базового поиска.
//
// Revision 1.68  2008/04/08 08:13:05  oman
// - new: Откручиваем БП для инфарма
//
// Revision 1.67  2008/03/11 11:25:28  oman
// - fix: Пытаемся жить на кривых базах (cq28563)
//
// Revision 1.66  2008/01/21 07:18:47  mmorozov
// - new: работа с пользовательскими ссылками на докумени и из документа перенесене на sdsDocInfo, чтобы быть доступной для списка и документа + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-17587);
//
// Revision 1.65  2008/01/10 07:23:08  oman
// Переход на новый адаптер
//
// Revision 1.64  2007/12/25 15:21:14  mmorozov
// - new: DataAdapter уведомляет о своём обновлении, а базовый поиск слушает, чтобы перечитать типы поиска (в рамках CQ: OIT5-27823);
//
// Revision 1.63  2007/12/25 12:27:24  mmorozov
// - new: используем прямо приведение объекта к интерфейсу вместо AS (в рамках CQ: OIT5-27823);
//
// Revision 1.62  2007/12/21 07:12:12  mmorozov
// - new: подписка на уведомление об обновлении данных (CQ: OIT5-27823);
//
// Revision 1.61  2007/12/04 12:36:40  oman
// - new: Меняем логику расстановки фокуса для БП (cq27326)
//
// Revision 1.60  2007/10/19 09:23:39  oman
// - fix: При разборе контекста выдаем сообщение - более
//  структурный вариант (К-57051004)
//
// Revision 1.59  2007/10/15 13:10:06  oman
// - fix: При успешном не базовом поиске считаем, что БП был
//  закрыт пользователем (cq27057)
//
// Revision 1.58  2007/09/11 06:22:41  oman
// - fix: При ручной активации скидываем вид информации (cq26641)
//
// Revision 1.57  2007/09/04 07:32:19  oman
// - fix: Историю контекста меняем при собственно поиске (cq26586)
//
// Revision 1.56  2007/08/29 13:31:04  oman
// - fix: При активации ползователем не активировалась насильная
//  покраска найденного контекста (cq26541)
//
// Revision 1.55  2007/08/20 10:42:18  oman
// - fix: Область поиска максимально ставим в "Везде" (cq26419)
//
// Revision 1.54  2007/08/09 10:05:51  oman
// - new: Успешный БП из ОМ трактуем как ручной вызов БП - т.е. в
//  открывшемся списке появиться панель БП (cq26300)
//
// Revision 1.53  2007/08/06 08:43:11  oman
// - fix: При подстановке примера в БП не моргаем меткой (cq26250)
//
// Revision 1.52  2007/08/02 06:53:59  oman
// - new: При БП проверяем распознанность контекста (cq26053)
//
// Revision 1.51  2007/08/02 05:53:44  oman
// - new: При БП проверяем распознанность контекста (cq26053)
//
// Revision 1.50  2007/08/01 11:29:43  oman
// - new: Готовимся к проверки контекста на распознаваемость для
//  базового поиска
//
// Revision 1.49  2007/07/27 07:08:37  oman
// - fix: При локальном поиске, если ничего не найдено предлагаем
//  поискать глобально (cq26041)
//
// Revision 1.48  2007/07/26 13:28:48  oman
// - fix: При локальном поиске, если ничего не найдено предлагаем
//  поискать глобально - другим макаром, с заделом на ближайшее
//  будущее (cq26041)
//
// Revision 1.47  2007/07/18 06:55:01  oman
// - fix: Была возможность искать контекст в непрогруженном документе.
//  Теперь кнопка поиска запрещается. (cq25850)
//
// Revision 1.46  2007/06/21 14:42:23  demon
// - new: чтение первого индекса для БП из настроек
//
// Revision 1.45  2007/06/20 15:33:54  demon
// - new: Механизм смены примеров при клике в Базовом поиске (CQ 25715)
//
// Revision 1.44  2007/06/15 06:54:31  oman
// - new: При базовом поиске по базе, если указан конкретный
//  вид информации, позволяем искать с пустым контекстом (cq25664)
//
// Revision 1.43  2007/06/13 14:17:38  oman
// - new: Базовый поиск умеет теперь открываться тремя способами:
//  локальный контекстный поиск, базовый поиск и уточнение
//  списка (cq25674)
//
// Revision 1.42  2007/06/13 13:04:55  oman
// - new: Свойство ExampleText - для задания текста примера (cq25678)
//
// Revision 1.41  2007/06/13 12:23:23  oman
// - new: Механизм примеров для базового поиска (cq25678)
//
// Revision 1.40  2007/05/31 10:41:15  oman
// - fix: Не разделяли ситуации когда история меняется из-за поиска
//  или из-за переключения конфигураций
//
// Revision 1.39  2007/05/28 09:06:43  oman
// - new: Если виды информации недоступны - скидываем их во "Все
//  документы" (cq25424)
//
// Revision 1.38  2007/05/23 10:40:12  oman
// - new: Новый тип запросов "Базовый поиск" (cq25374)
//
// Revision 1.37  2007/05/22 11:05:07  oman
// - new: Карточки запроса (пока без ППС 6х) открываем один раз и
//  меняем в них содержимое без записи в историю (cq25289)
//
// Revision 1.36  2007/05/17 08:52:13  oman
// - fix: Выделил отдельного хранителя истории контекстов
//
// Revision 1.35  2007/05/16 14:36:08  oman
// Читаем историю контекста из единого места
//
// Revision 1.34  2007/05/16 13:15:48  oman
// - fix: Неправильно вычислялся контекст для многострочных
//  контекстов (cq25145)
//
// Revision 1.33  2007/05/16 13:08:25  oman
// - new: Историю контекстов пишем/читаем через IawfSettings
//
// Revision 1.32  2007/05/16 11:40:02  oman
// - new: Логика сохранения истории запросов (cq25145)
//
// Revision 1.31  2007/05/15 14:19:41  oman
// - new: При локальном базовом поиске рисуем объект в котором
//   будет идти поиск контекста как сфокусированные (cq25145)
//
// Revision 1.30  2007/05/14 11:21:04  oman
// - new: Контекстный поиск в списке (cq25145)
//
// Revision 1.29  2007/05/14 07:45:34  oman
// - fix: Сбрасывалась область поиска (cq25145)
//
// Revision 1.28  2007/05/11 09:15:22  oman
// - new: Выставляем область при открытии окна пользователем (cq25145)
//
// Revision 1.27  2007/05/11 08:41:00  oman
// - new: Правила перехода для области поиска (cq25145, 25297)
//
// Revision 1.26  2007/05/11 08:10:23  oman
// - new: Группа опций только одна (cq25145, 25297)
//
// Revision 1.25  2007/05/11 07:23:55  oman
// - new: Описание области поиска для бавзового поиска - пока без
//  поведения (cq25145)
//
// Revision 1.24  2007/05/10 14:46:48  oman
// - fix: Продолжаем бороться с мерцанием - учитываем
//  FormDispatcher.Locked (cq25145)
//
// Revision 1.23  2007/05/10 11:59:48  oman
// - fix: Избавляемся от поддержки излишнего интерфейса (cq25145)
//
// Revision 1.22  2007/05/10 11:39:07  oman
// - fix: Разделили интерфейс базового искателя на собственно его
//  и его представление для окна поиска (cq25145)
//
// Revision 1.21  2007/05/10 10:25:15  oman
// - new: При смене фокуса, если сфокусированный не поддерживает
//  контекстный поиск, то в качестве активного искателя пытаемся
//  подставить объект в главной зоне (cq25145)
//
// Revision 1.20  2007/05/10 09:59:11  oman
// - new: Реакция на Ctrl+Enter в карточке базового поиска (cq25145)
//
// Revision 1.19  2007/05/10 09:42:31  oman
// - fix: Стараемся не так моргать при переключении вида поиска (cq25145)
//
// Revision 1.18  2007/05/08 15:58:48  oman
// - fix: Избавляемся от циклической зависимости карточки базового поиска и
//  самого базового поиска (cq25145)
//
// Revision 1.17  2007/05/08 15:21:17  oman
// - new: Загрузка параметров базового поиска из истории запросов
//  карточки (cq25145)
//
// Revision 1.16  2007/05/08 14:16:07  oman
// - fix: Показ карточки базового поиска трактуется как вызов панели
//  руками (cq25145)
//
// Revision 1.15  2007/05/08 13:58:43  oman
// - fix: Заготовки для загрузки базового поиска из истории
//  запросов (cq25145)
//
// Revision 1.14  2007/05/08 11:17:38  oman
// - fix: Для карточки базового поиска  (cq25145)
//
// Revision 1.13  2007/05/08 09:40:18  oman
// - fix: Создание форм для базового поиска перекладываем на
//  _ModuleOperation (cq25145)
//
// Revision 1.12  2007/05/08 09:03:03  oman
// - new: Заготовка для карточки запроса базового поиска (cq25145)
//
// Revision 1.11  2007/05/07 08:14:33  oman
// - new: Управляем доступностью видов информации от данных в
//  базе (cq25145)
// - new: Реагируем на переключение баз (cq25145)
//
// Revision 1.10  2007/05/04 14:49:43  oman
// - new: Неправильный вариант обработки вида информации,
//  но работает правильно - надо будет переделать потроха -
//  ноду для поиска пока берем не от того дерева (cq25145)
//
// Revision 1.9  2007/05/04 12:31:09  oman
// - new: Заготовки для управления доступностью видов
//  информации (cq25145)
//
// Revision 1.8  2007/05/04 07:45:53  oman
// - fix: Интерфейсы для базового поиска перенесены в проект (cq25145)
//
// Revision 1.7  2007/05/03 15:01:34  oman
// - fix: Таки переключаем внешний вид при смене фокуса (cq25149)
//
// Revision 1.6  2007/05/03 07:45:09  oman
// - new: Реализация базового поиска по всей базе (cq25149)
//
// Revision 1.5  2007/05/03 06:57:58  oman
// - new: Окончательный вариант обработки закрытия окна базового
//  поиска (cq25145)
//
// Revision 1.4  2007/05/02 14:53:36  oman
// - new: Управляем фокусом (cq25145)
// - new: Управляем сохраненеием контекстом поиска (cq25145)
//
// Revision 1.3  2007/05/02 14:23:45  oman
// - fix: Более правильная механика закрытия/автооткрытия окна (cq25145)
//
// Revision 1.2  2007/05/02 09:07:13  oman
// - new: Механика закрытия/автооткрытия окна (cq25145)
//
// Revision 1.1  2007/04/28 12:05:00  oman
// - new: Контроллер базового поиска (cq25145)
//

{$include nsDefine.inc}

interface

{$IfNDef Monitorings}

// <no_string>

uses
 l3Interfaces,
 l3TreeInterfaces,

 afwInterfaces,

 vcmInterfaces,
 vcmExternalInterfaces,
 vcmBase,

 DataAdapterInterfaces,
 L10nInterfaces,

 PrimBaseSearchInterfaces,
 BaseSearchInterfaces,

 ContextHistoryInterfaces
 ,
 l3Base
 ;

type
  TnsBaseSearcher = class(TvcmBase,
                          InsBaseSearchClassesListener,
                          InsBaseSearcher,
                          InsBaseSearchQueryDataProcessor,
                          InsBaseSearcherWindowData,
                          InsContextSearchHistoryNotifier,
                          InsBaseSearchDataReadyChecker,
                          InsBaseSearchResultProcessor,
                          InsBaseSearchContextProvider,
                          InsMistakesCorrector)
  private
   // InsBaseSearchClassesListener
   procedure NotifyClassesChanged;
  protected
   //InsBaseSearcher
   function pm_GetContextSearcher: InsContextSearcher;
     {-}
   procedure ShowWindowByUser(OpenKind: TnsBaseSearchOpenKind);
     {-}
   function pm_GetPresentation: InsBaseSearchPresentation;
     {-}
   procedure pm_SetPresentation(const aPresentation: InsBaseSearchPresentation);
     {-}
   procedure AddPresentation(const aPresentation: InsBaseSearchPresentation);
     {-}
   procedure RemovePresentation(const aPresentation: InsBaseSearchPresentation);
     {-}
   procedure ContainerIsClosing;
     {-}
   function pm_GetWindowData: InsBaseSearcherWindowData;
   // InsBaseSearchQueryDataProcessor
   procedure SetDataFromQuery(const aQuery: IUnknown);
     {-}
   procedure RequestFind;
     {-}
   procedure RequestCheckFragmentsCount;
     {-}
   procedure RequestCheckFindBack;
     {-}
   // InsBaseSearchResultProcessor
   procedure SearchResultEmpty(TryFullList: Boolean);
     {-}
   procedure SearchResultExists;
     {-}
   procedure AnotherSearchSuccessed;
     {-}
   procedure AnotherSearchCancelled;
     {-}
   // InsBaseSearcherWindowData
   function pm_GetSearchWindow: InsSearchWindow;
     {-}
   procedure pm_SetSearchWindow(const aWindow: InsSearchWindow);
     {-}
   function pm_GetContext: Il3CString;
     {-}
   procedure pm_SetContext(const aValue: Il3CString);
     {-}
   function pm_GetActiveClass: InsBaseSearchClass;
     {-}
   procedure pm_SetActiveClass(const aValue: InsBaseSearchClass);
     {-}
   function pm_GetActiveClassForSaveState: InsBaseSearchClass;
     {-}
   procedure DropActiveClass;
     {-}
   function pm_GetArea: TnsSearchArea;
     {-}
   procedure pm_SetArea(aValue: TnsSearchArea);
     {-}
   function pm_GetExampleText: Il3CString;
     {-}
   procedure Find;
     {-}
   function pm_GetFindEnabled: Boolean;
     {-}
   function pm_GetContextKind: TnsBaseSearchKind;
     {-}
   function pm_GetAvailableClasses: InsBaseSearchClasses;
     {-}
   function pm_GetClassesAnywayDisabled: Boolean;
     {-}
   function pm_GetAllowSearchInTitles: Boolean;
     {-}
   procedure ApplyCurrentExample;
     {-}
   function pm_GetErrorWords: IvcmStrings;
     {-}
   procedure pm_SetErrorWords(const aValue: IvcmStrings);
     {-}
   function pm_GetFindBackSupported: Boolean;
     {-}
   function pm_GetFindBackEnabled: Boolean;
     {-}
   procedure FindBack;
     {-}
   function pm_GetFragmentsCountSuffix: Il3CString;
     {-}
   function pm_GetPromptTree: Il3SimpleTree;
     {-}
   procedure StoreActiveClass;
     {-}
   function MakeState: InsBaseSearcherInitialState;
     {-}
   function MakeStateParams(aStateElements: TnsBaseSearchStateElements; aForClone: Boolean): InsBaseSearcherInitialState;
     {-}
   procedure AssignState(const aState: InsBaseSearcherInitialState);
     {-}
   // InsContextSearchHistoryNotifier
   procedure HistoryChanged(const aNewHistory: IvcmStrings);
     {-}
   procedure ContextSearched;
     {-}
   // InsBaseSearchDataReadyChecker
   procedure CheckLocalDataReady;
     {-}
   // InsBaseSearchContextProvider
   procedure RepairMistakes;
      {-}
   // InsMistakesCorrector
   procedure Correct(const aCorrectedContext: Il3StringsEx;
     const aMistakesList: Il3StringsEx);
   function ValidateBaseSearchForm(const aForm : IvcmEntityForm): Boolean;
   procedure ForceUpdateClassForHistory;
  private
   f_Presentation: Pointer;
   f_Container: Pointer; //IvcmContainer;
   f_SearchWindow: Pointer; //InsSearchWindow;
   f_WindowOpenedByUser: Boolean;
   f_LockOpenedFlag: Boolean;
   f_Context: Il3CString;
   f_OpenKind: TnsBaseSearchOpenKind;
   f_ActiveClass: InsBaseSearchClass;
   f_FirstClass: InsBaseSearchClass;
   f_SavedClass: InsBaseSearchClass;
   f_Searched: Boolean;
   f_ContextHistory: InsContextSearchHistory;
   f_ExampleText: Il3CString;
   f_CurrentExampleIndex: LongWord;
   f_ErrorWords: IvcmStrings;
   f_ExpandList: Boolean;
   f_ClassSaved: Boolean;
   f_SavedContext: Il3CString;
   f_InitialContext: Il3CString;
   f_InitialNeedShowWindow: Boolean;
   f_InitialOpenKind: TnsBaseSearchOpenKind;
   f_IsWindowOpened: Boolean;
   f_ClassSetFromState: Boolean;
   f_AreaSetFromState: Boolean;
   f_AreaFromState: TnsSearchArea;
   f_NeedActivate: Boolean;
  private
   procedure pm_SetExampleText(const aValue: Il3CString);
     {-}
  private
   procedure ShowWindow(ByUser: Boolean; OpenKind: TnsBaseSearchOpenKind);
     {-}
   procedure NotifyWindow;
     {-}
   procedure NotifyExampleChange;
     {-}
   procedure NotifyContextSearcher;
     {-}
   procedure NotifyVisibleWatcher(AllowVisible: Boolean = true);
     {-}
   procedure UpdateValidClasses(anInit: Boolean);
     {-}
   procedure CheckValidClasses;
     {-}
   function CalcValidClasses: InsBaseSearchClasses;
     {-}
   function CalcDefaultLocalArea(AllowSearchInTitles: Boolean): TnsSearchArea;
     {-}
   procedure UpdateContextFromHistory;
     {-}
   procedure SetNextExampleText;
     {-}
   procedure GetFirstExampleIndexFromSettings;
     {-}
   procedure SaveContextToHistory;
     {-}
   procedure CheckFindBtnsEnabled;
     {-}
   procedure CheckFragmentsCount;
     {-}
   procedure CloseSearchWindow;
     {-}  
  protected
  // methods
   procedure InitFields;
    override;
    {-}
   procedure Cleanup;
    override;
     {-}
   function Container: IvcmContainer;
     {-}
   property SearchWindow: InsSearchWindow
       read pm_GetSearchWindow;
     {-}
   property ContextSearcher: InsContextSearcher
       read pm_GetContextSearcher;
     {-}
   property Context: Il3CString
       read pm_GetContext
      write pm_SetContext;
     {-}
   property ActiveClass: InsBaseSearchClass
       read pm_GetActiveClass
      write pm_SetActiveClass;
     {-}
   property Area: TnsSearchArea
       read pm_GetArea
      write pm_SetArea;
   property ExampleText: Il3CString
       read pm_GetExampleText
      write pm_SetExampleText;
  public
   constructor Create(const aContainer: IvcmContainer; const aContextHistory: InsContextSearchHistory);
    reintroduce;
     {-}
   class function Make(const aContainer: IvcmContainer; const aContextHistory: InsContextSearchHistory): InsBaseSearcher;
     {-}
  end;//TnsBaseSearcher
{$EndIf Monitorings}

implementation

{$IfNDef Monitorings}
uses
 Classes,
 SysUtils,
 Forms,

 l3String,
 l3InterfacesMisc,
 l3ValueMap,
 l3Nodes,

 afwFacade,

 vcmStringList,

 nsTypes,
 nsConst,
 nsQuery,
 nsQueryUtils,
 nsValueMaps,
 nsValueMapsIDs,
 nsContextHistory,
 nsManagers,
 nsFolders,
 nsBaseSearchPromptTree,
 nsPromptForDocFilter,
 nsFiltersContainer,

 nsBaseSearchClasses,

 bsTypes,
 bsUtils,

 BaseTypesUnit,
 DynamicDocListUnit,
 IOUnit,
 SearchUnit,
 DynamicTreeUnit,
 FiltersUnit,

 StdRes,
 DataAdapter,

 bsInterfaces,
 SearchDomainInterfaces,
 SearchInterfaces,

 Common_FormDefinitions_Controls,
 Search_FormDefinitions_Controls,
 nsTreeStruct

 ,
 Controls,
 Windows
 , Base_Operations_F1Services_Contracts
 ;

type
 TnsBaseSearcherInitialState = class(TvcmBase, InsBaseSearcherInitialState)
 private
  f_StateElements: TnsBaseSearchStateElements;
  f_Context: Il3CString;
  f_NeedShowWindow: Boolean;
  f_OpenKind: TnsBaseSearchOpenKind;
  f_CurrentSearchClass: InsBaseSearchClass;
  f_SearchArea: TnsSearchArea;
  f_NeedActivate: Boolean;
 protected
  function pm_GetContext: Il3CString;
  function pm_GetNeedShowWindow: Boolean;
  function pm_GetOpenKind: TnsBaseSearchOpenKind;
  function pm_GetElements: TnsBaseSearchStateElements;
  function pm_GetCurrentSearchClass: InsBaseSearchClass;
  function pm_GetSearchArea: TnsSearchArea;
  function pm_GetNeedActivate: Boolean;
  procedure CleanUp; override;
 public
  constructor Create(aStateElements: TnsBaseSearchStateElements;
   const aContext: Il3CString; aNeedShowWindow: Boolean;
   aOpenKind: TnsBaseSearchOpenKind;
   const aCurrentSearchClass: InsBaseSearchClass;
   aSearchArea: TnsSearchArea;
   aNeedActivate: Boolean);
  class function Make(aStateElements: TnsBaseSearchStateElements;
   const aContext: Il3CString; aNeedShowWindow: Boolean;
   aOpenKind: TnsBaseSearchOpenKind;
   const aCurrentSearchClass: InsBaseSearchClass;
   aSearchArea: TnsSearchArea;
   aNeedActivate: Boolean): InsBaseSearcherInitialState;
 end;

function TnsBaseSearcherInitialState.pm_GetContext: Il3CString;
begin
 Result := f_Context;
end;

function TnsBaseSearcherInitialState.pm_GetNeedShowWindow: Boolean;
begin
 Result := f_NeedShowWindow;
end;

function TnsBaseSearcherInitialState.pm_GetOpenKind: TnsBaseSearchOpenKind;
begin
 Result := f_OpenKind;
end;

function TnsBaseSearcherInitialState.pm_GetElements: TnsBaseSearchStateElements;
begin
 Result := f_StateElements;
end;

function TnsBaseSearcherInitialState.pm_GetCurrentSearchClass: InsBaseSearchClass;
begin
 Result := f_CurrentSearchClass;
end;

function TnsBaseSearcherInitialState.pm_GetSearchArea: TnsSearchArea;
begin
 Result := f_SearchArea;
end;

function TnsBaseSearcherInitialState.pm_GetNeedActivate: Boolean;
begin
 Result := f_NeedActivate;
end;

procedure TnsBaseSearcherInitialState.CleanUp;
begin
 f_Context := nil;
 f_CurrentSearchClass := nil;
 inherited;
end;

constructor TnsBaseSearcherInitialState.Create(aStateElements: TnsBaseSearchStateElements;
   const aContext: Il3CString; aNeedShowWindow: Boolean;
   aOpenKind: TnsBaseSearchOpenKind;
   const aCurrentSearchClass: InsBaseSearchClass;
   aSearchArea: TnsSearchArea;
   aNeedActivate: Boolean);   
begin
 inherited Create;
 f_StateElements := aStateElements;
 if (ns_sseContext in aStateElements) then
  f_Context := aContext;
 if (ns_sseNeedShowWindow in aStateElements) then
  f_NeedShowWindow := aNeedShowWindow;
 if (ns_sseOpenKind in aStateElements) then
  f_OpenKind := aOpenKind;
 if (ns_sseActiveClass in aStateElements) then
  f_CurrentSearchClass := aCurrentSearchClass;
 if (ns_sseSearchArea in aStateElements) then
  f_SearchArea := aSearchArea;
 f_NeedActivate := aNeedActivate;
end;

class function TnsBaseSearcherInitialState.Make(aStateElements: TnsBaseSearchStateElements;
 const aContext: Il3CString; aNeedShowWindow: Boolean;
 aOpenKind: TnsBaseSearchOpenKind;
 const aCurrentSearchClass: InsBaseSearchClass;
 aSearchArea: TnsSearchArea;
 aNeedActivate: Boolean): InsBaseSearcherInitialState;
var
 l_State: TnsBaseSearcherInitialState;
begin
 l_State := Create(aStateElements, aContext, aNeedShowWindow, aOpenKind,
  aCurrentSearchClass, aSearchArea, aNeedActivate);
 try
  Result := l_State;
 finally
  vcmFree(l_State);
 end;
end;

{ TnsBaseSearcher }

procedure TnsBaseSearcher.InitFields;
 //override;
 {-}
begin
 inherited;
 TnsBaseSearchClasses.Instance.Subscribe(Self as InsBaseSearchClassesListener);
end;//InitFields

procedure TnsBaseSearcher.Cleanup;
begin
 f_ContextHistory.RemoveNotifier(Self);
 f_ContextHistory := nil;
 NotifyVisibleWatcher(False);
 f_Container := nil;
 f_SearchWindow := nil;
 f_Presentation := nil;
 f_Context := nil;
 f_ExampleText := nil;
 f_ErrorWords := nil;
 f_ActiveClass := nil;
 f_FirstClass := nil;
 f_SavedClass := nil;
 f_InitialContext := nil;
 TnsBaseSearchClasses.Instance.Unsubscribe(Self as InsBaseSearchClassesListener); 
 inherited;
end;

function TnsBaseSearcher.Container: IvcmCOntainer;
begin
 Result := IvcmContainer(f_Container);
end;

procedure TnsBaseSearcher.CheckValidClasses;
  {-}
var
 l_Enumerator: InsBaseSearchClassesEnumerator;
begin
 l_Enumerator := TnsBaseSearchClasses.Instance.GetEnumerator;
 if l_Enumerator.MoveNext then
  f_FirstClass := l_Enumerator.Current;
end;

constructor TnsBaseSearcher.Create(const aContainer: IvcmContainer; const aContextHistory: InsContextSearchHistory);
begin
 inherited Create;
 CheckValidClasses;
 f_Container := Pointer(aContainer);
 f_ActiveClass := f_FirstClass;
 UpdateValidClasses(True);
 f_ContextHistory := aContextHistory;
 f_ContextHistory.AddNotifier(Self);
 // Получение примера
 GetFirstExampleIndexFromSettings;
 SetNextExampleText;
end;

procedure TnsBaseSearcher.Find;

 function GetPermanentFilters: IFiltersFromQuery;
 var
  l_Filters: IFiltersFromQuery;
  I: Integer;
  l_Filter: IFilterFromQuery;
 begin
  Result := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;

  DefDataAdapter.NativeAdapter.MakeFiltersManager.GetLegalFilters(l_Filters);
  for I := 0 to l_Filters.Count - 1 do
  begin
   l_Filters.pm_GetItem(I, l_Filter);
   if l_Filter.GetPermanent then
    Result.Add(l_Filter);
  end;
 end;

var
 l_Query: IQuery;
 l_List: IDynList;
 l_Source: InsBaseSearchListSource;
 //l_Converter: IbsCRSettingsConverter;
 l_bsNode: InsBaseSearchClass;
 l_PermFilters: IFiltersFromQuery;
begin
 if Assigned(ContextSearcher) and ContextSearcher.Find(Self, Self) then
 begin
  SaveContextToHistory;
  CheckFindBtnsEnabled;
  CheckFragmentsCount;
  Exit;
 end;

 if l3IsNil(Context) then
  raise ETryToFindEmptyContext.Create('');

 RepairMistakes;

 // Контекст мог быть не пустым до исправления ошибок, а после - стать пустым
 // http://mdp.garant.ru/pages/viewpage.action?pageId=461708253
 if l3IsNil(Context) then
  raise ETryToFindEmptyContext.Create('');

 if Supports(ContextSearcher, InsBaseSearchListSource, l_Source) then
 begin
  l_List := l_Source.SearchList;
  if f_ExpandList then
   l_List := bsBuildFullList(l_List);
 end
 else
  l_List := nil;
 DefDataAdapter.Search.CreateQuery(QT_BASE_SEARCH, l_Query);
 try
  if Area = ns_saTitlesOnly
   then SaveContextNew(l_Query, nsCStr(AT_TEXT_NAME), Context)
   else SaveContextNew(l_Query, nsCStr(AT_TEXT_BODY), Context);
  l_bsNode := ActiveClass;

  if Assigned(l_bsNode) and
     (*l_bsNode.HasNode and bsIsCRNodeAreNotAllDocuments(l_bsNode)*)
     (l_bsNode <> f_FirstClass) then
   SaveAttributeNew(l_Query, nsCStr(AT_BASE_SEARCH_PANES{AT_PREFIX}), loOr, l_bsNode.AdapterNode);

  l_PermFilters := GetPermanentFilters;

  if not (Assigned(l_PermFilters) and (l_PermFilters.Count > 0)) then // Итого: Необходимо применять фильтр к полному, а не короткому списку.
                                                                      // http://mdp.garant.ru/pages/viewpage.action?pageId=406500580 
   if (Area = ns_saEverywere) and
      afw.Application.Settings.LoadBoolean(pi_BaseSearch_BuildShortList,
                                           dv_BaseSearch_BuildShortList) then
    SaveContextNew(l_Query,
                   nsCStr(AT_SHORT_LIST),
                   GetDefaultContext(nsCStr(AT_SHORT_LIST)));

  nsSearch(l_Query,

           //TnsFiltersContainer.Instance.Filters[bs_ltDocument].PermanentFilters,
           l_PermFilters,
           
           bsBuildFullList(l_List),
           Self);
  CheckFindBtnsEnabled;
  CheckFragmentsCount;
 finally
  l_Query := nil;
 end;{try..finally}
end;

class function TnsBaseSearcher.Make(const aContainer: IvcmContainer; const aContextHistory: InsContextSearchHistory): InsBaseSearcher;
var
 l_Searcher: TnsBaseSearcher;
begin
 l_Searcher := Create(aContainer, aContextHistory);
 try
  Result := l_Searcher;
 finally
  vcmFree(l_Searcher);
 end;
end;

procedure TnsBaseSearcher.NotifyWindow;
begin
 if Assigned(f_SearchWindow) then
  SearchWindow.ParamsChanged;
end;

function TnsBaseSearcher.pm_GetContext: Il3CString;
begin
 Result := f_Context;
end;

function TnsBaseSearcher.pm_GetContextSearcher: InsContextSearcher;
begin
 if (f_Presentation = nil) then
  Result := nil
 else
  Result := InsBaseSearchPresentation(f_Presentation).ContextSearcher;
end;

function TnsBaseSearcher.pm_GetPresentation: InsBaseSearchPresentation;
begin
 Result := InsBaseSearchPresentation(f_Presentation);
end;

function TnsBaseSearcher.pm_GetSearchWindow: InsSearchWindow;
begin
 Result := InsSearchWindow(f_SearchWindow);
end;

procedure TnsBaseSearcher.pm_SetContext(const aValue: Il3CString);
begin
 if not l3Same(f_Context, aValue) then
 begin
  f_InitialContext := nil;
  f_Context := aValue;
  f_ErrorWords := nil;
  NotifyContextSearcher;
  NotifyWindow;
 end;
end;

procedure TnsBaseSearcher.UpdateContextFromHistory;
var
 l_History: IvcmStrings;
begin
 if f_Searched then
 begin
  l_History := f_ContextHistory.History;
  try
   if l_History.Count > 0 then
    f_Context := l_History.ItemC[0]
   else
    f_Context := nil;
  finally
   l_History := nil;
  end;
 end
 else
 if (not l3IsNil(f_InitialContext)) and (l3IsNil(f_Context)) then
  f_Context := f_InitialContext
 else
 if (l3IsNil(f_InitialContext)) or (not l3Same(f_InitialContext, f_Context)) then
  f_Context := nil;
end;

procedure TnsBaseSearcher.CloseSearchWindow;
  {-}
begin
 f_IsWindowOpened := False;
 f_LockOpenedFlag := True;
 try
  SearchWindow.CloseWindow;
 finally
  f_LockOpenedFlag := False;
 end;//try..finally
end;

procedure TnsBaseSearcher.pm_SetPresentation(
  const aPresentation: InsBaseSearchPresentation);
var
 l_OpenKind: TnsBaseSearchOpenKind;
begin
 if not l3IEQ(InsBaseSearchPresentation(f_Presentation), aPresentation) then
 begin
  if Assigned(aPresentation) AND (aPresentation.ContextSearcher <> nil) then
  begin
   // Если область поиска задана на основании состояния при AssignState - умничать не нужно.
   // http://mdp.garant.ru/pages/viewpage.action?pageId=607262792 
   if f_AreaSetFromState then
    aPresentation.ContextSearcher.Area := f_AreaFromState
   else
   if aPresentation.ContextSearcher.SwitchToTextIfPossible then
    aPresentation.ContextSearcher.Area := ns_saText
   else
    aPresentation.ContextSearcher.Area := ns_saEverywere;
  end;
  NotifyVisibleWatcher(False);

  f_Presentation := Pointer(aPresentation);

  UpdateContextFromHistory;

  NotifyVisibleWatcher;
  NotifyContextSearcher;
  NotifyWindow;

  if f_InitialNeedShowWindow then
   l_OpenKind := f_InitialOpenKind
  else
   l_OpenKind := f_OpenKind;

  if Assigned(f_Presentation) and
     (InsBaseSearchPresentation(f_Presentation).WindowRequired or
      f_WindowOpenedByUser or
      f_InitialNeedShowWindow) then
  begin
   ShowWindow(f_InitialNeedShowWindow, l_OpenKind);
   f_InitialNeedShowWindow := False;
  end
  else
  if Assigned(f_SearchWindow) and (not g_Dispatcher.History.InBF) then
   CloseSearchWindow;
 end;//not l3IEQ(InsBaseSearchPresentation(f_Presentation), aPresentation)
end;

procedure TnsBaseSearcher.AddPresentation(const aPresentation: InsBaseSearchPresentation);
  {-}
begin
 Assert(aPresentation <> nil);
 if aPresentation.SupportDisabled then
  pm_SetPresentation(nil)
 else
  pm_SetPresentation(aPresentation);
end;

procedure TnsBaseSearcher.RemovePresentation(const aPresentation: InsBaseSearchPresentation);
  {-}
begin
 Assert(aPresentation <> nil);
 if l3IEQ(InsBaseSearchPresentation(f_Presentation), aPresentation) then
  pm_SetPresentation(nil);
end;

procedure TnsBaseSearcher.ContainerIsClosing;
begin
 f_ContextHistory.RemoveNotifier(Self);
 f_SearchWindow := nil;
// http://mdp.garant.ru/pages/viewpage.action?pageId=13532&focusedCommentId=605363355#comment-605363355
end;

function TnsBaseSearcher.pm_GetWindowData: InsBaseSearcherWindowData;
begin
  Result := Self;
end;

procedure TnsBaseSearcher.pm_SetSearchWindow(
  const aWindow: InsSearchWindow);
begin
 if (f_SearchWindow <> Pointer(aWindow)) then
 begin
  f_SearchWindow := Pointer(aWindow);
  if (f_SearchWindow = nil) and
     not f_LockOpenedFlag then
  begin
   if (g_Dispatcher = nil) OR
      (g_Dispatcher.History = nil) OR
      not g_Dispatcher.History.InBF then
    f_WindowOpenedByUser := False;
  end;//f_SearchWindow = nil
  NotifyVisibleWatcher;
 end;//f_SearchWindow <> Pointer(aWindow)
end;

function TnsBaseSearcher.pm_GetContextKind: TnsBaseSearchKind;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.Kind
 else
  if Assigned(f_Presentation) and InsBaseSearchPresentation(f_Presentation).IsQueryCard then
   Result := ns_bskQuery
  else
   Result := ns_bskMenu;
end;

procedure TnsBaseSearcher.ShowWindow(ByUser: Boolean; OpenKind: TnsBaseSearchOpenKind);
var
 l_Container : TnsContainerForBaseSearchInfo;
 l_Form      : IvcmEntityForm;
 l_OldCont   : IvcmContainer;
 l_FormCreated : IvcmEntityForm;
begin
 f_IsWindowOpened := True;
 l_Container.rContainer := nil;
 l_Container.rZone := vcm_ztAny;
 if ByUser and Assigned(ContextSearcher) then
  case OpenKind of
   ns_bsokGlobal:
    ContextSearcher.Area := ns_saEverywere;
   ns_bsokLocal:
    if not f_AreaSetFromState then
     ContextSearcher.Area := CalcDefaultLocalArea(ContextSearcher.AllowSearchInTitles);
   ns_bsokSpecify:
    ContextSearcher.Area := ns_saText;
  end;//case OpenKind of
 if ByUser then
 begin
  if (not f_ClassSetFromState) and (not f_InitialNeedShowWindow) then
   ActiveClass := f_FirstClass;
  NotifyVisibleWatcher;
  UpdateContextFromHistory;
 end;//ByUser
 if (f_Presentation <> nil) then
  l_Container := InsBaseSearchPresentation(f_Presentation).ContainerForBaseSearch;
 if (f_SearchWindow <> nil) then
 begin
  l_OldCont := InsSearchWindow(f_SearchWindow).Container;
  if (l_OldCont <> nil) then
  begin
   if (l_Container.rContainer <> nil) then
   begin
    if (not l_OldCont.IsSame(l_Container.rContainer)) then
     CloseSearchWindow;
   end//l_Container.rContainer <> nil
   else
   if (not l_OldCont.IsSame(Container)) then
    CloseSearchWindow;
  end//l_OldCont <> nil
  else
  if (l_Container.rContainer <> nil) then
   CloseSearchWindow;
 end;//f_SearchWindow <> nil
 if not Assigned(f_SearchWindow) then
 begin
  if (l_Container.rContainer = nil) then
  begin
   Assert(Container <> nil);
    l_Container.rContainer := Container;
    if l_Container.rContainer.HasForm(fm_NewBaseSearchForm.rFormID, l_Container.rZone{vcm_ztMain}, false, @l_Form) then
    begin
     Assert(false, 'По идее форма базового поиска уже должна быть закрыта');
     l_Form.SafeClose;
    end;//l_Container.HasForm(fm_NewBaseSearchForm, vcm_ztMain, false, @l_Form)
  end//l_Container = nil
  else
  begin
   if Container.HasForm(fm_NewBaseSearchForm.rFormID, vcm_ztMain, false, @l_Form) then
   begin
    Assert(false, 'По идее форма базового поиска уже должна быть закрыта');
    l_Form.SafeClose;
   end;//Container.HasForm(fm_NewBaseSearchForm, vcm_ztMain, false, @l_Form)
   if not ByUser AND vcmDispatcher.History.InBF then
   begin
   // - форма сама должна позаботится о сохранении базового поиска в историю и восстановлении его
    if (l_Container.rZone <> vcm_ztAny) then
     if (OpenKind = ns_bsokGlobal) then
      f_WindowOpenedByUser := true;
    Exit;
   end;//not ByUser AND vcmDispatcher.History.InBF
  end;//l_Container = nil
  if not vcmDispatcher.History.InBF then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=257393788
  // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309
  // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296636403#comment-296636403
  begin
   l_FormCreated := TBaseSearchService.Instance.MakeBaseSearchWindow(l_Container.rContainer, Self, l_Container.rZone);
   Assert(l_FormCreated <> nil);
   Assert(f_SearchWindow <> nil);
   if (f_SearchWindow = nil) then
   // - такое может случится, если форма была, но спрятана например
    pm_SetSearchWindow(l_FormCreated As InsSearchWindow);
  end;//not vcmDispatcher.History.InBF
 end//not Assigned(f_SearchWindow)
 else
  SearchWindow.PresentationChanged;
 if ByUser or
    (Assigned(f_Presentation) and
     InsBaseSearchPresentation(f_Presentation).AutoActivateWindow) then
 begin
(*  if SearchWindow <> nil then // http://mdp.garant.ru/pages/viewpage.action?pageId=297705374
    SearchWindow.ActivateWindow(ByUser); *)
  if ByUser or
     (Assigned(f_Presentation) and
      InsBaseSearchPresentation(f_Presentation).IsQueryCard) then
   f_WindowOpenedByUser := True;
 end;//ByUser..
 f_OpenKind := OpenKind;
end;

type
 THackCustomForm = class(TCustomForm)
 end;//THackCustomForm
 
procedure TnsBaseSearcher.ShowWindowByUser(OpenKind: TnsBaseSearchOpenKind);
var
 l_Form : IvcmEntityForm;
begin
 f_NeedActivate := True;
 f_OpenKind := OpenKind;
 if Assigned(f_Presentation) then
 begin
  ShowWindow(True, OpenKind);
  if (f_SearchWindow <> nil) then
   InsSearchWindow(f_SearchWindow).ActivateWindow(True);
 end 
 else
 if (OpenKind = ns_bsokGlobal) then
 begin
  l_Form := TBaseSearchService.Instance.MakeBaseSearchCard(Container);
  Assert(l_Form <> nil);
  l_Form.SetActiveInParent;
  THackCustomForm(l_Form.VCLWinControl).Activate;
  //ShowWindow(false, OpenKind);
 end;//OpenKind = ns_bsokGlobal
end;

function TnsBaseSearcher.pm_GetAvailableClasses: InsBaseSearchClasses;
begin
 CheckValidClasses;
 Result := TnsBaseSearchClasses.Instance;
end;

function TnsBaseSearcher.CalcValidClasses: InsBaseSearchClasses;
begin
 CheckValidClasses;
 Result := TnsBaseSearchClasses.Instance;
end;

function TnsBaseSearcher.pm_GetActiveClass: InsBaseSearchClass;
begin
 if Assigned(ContextSearcher) and ContextSearcher.IsLocalSearchArea then
  f_ActiveClass := f_FirstClass;
 if (f_ActiveClass = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=294600483&focusedCommentId=320742073&#comment-320742073
  f_ActiveClass := f_FirstClass;
 Result := f_ActiveClass;
end;

procedure TnsBaseSearcher.pm_SetActiveClass(
  const aValue: InsBaseSearchClass);
begin
 if (f_ActiveClass = nil) or
    (not f_ActiveClass.IsSame(aValue)) then
 begin
  f_ActiveClass := aValue;
  f_ClassSetFromState := False;  
  NotifyWindow;
 end;//f_ActiveClass <> l_Value
end;

function TnsBaseSearcher.pm_GetActiveClassForSaveState: InsBaseSearchClass;
  {-}
begin
 if (g_Dispatcher <> nil) AND (g_Dispatcher.History <> nil) AND
    g_Dispatcher.History.InBF then
  Result := pm_GetActiveClass
  // - сохраняем то, что у нас во вкладке
 else 
 if f_ClassSaved AND (f_SavedClass <> nil) then
  Result := f_SavedClass
  // - сохраняем то, что у нас БЫЛО во вкладке ДО ПОИСКА
  // http://mdp.garant.ru/pages/viewpage.action?pageId=300026165
 else
  Result := pm_GetActiveClass;
end;

procedure TnsBaseSearcher.DropActiveClass;
  {-}
begin
 Self.ActiveClass := f_FirstClass;
 // // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258
end;

procedure TnsBaseSearcher.UpdateValidClasses(anInit: Boolean);
begin
 NotifyWindow;
end;

procedure TnsBaseSearcher.SetDataFromQuery(const aQuery: IUnknown);
var
 l_Context: IvcmStrings;
 l_ClassCaption: Il3CString;
 l_ActiveClass: InsBaseSearchClass;
 l_Query: IQuery;
var
 l_Path : Tl3WString;
 l_N    : Il3SimpleNode;
begin
 if Supports(aQuery, IQuery, l_Query) then
 begin
  l_Context := nsGetContextFromQuery(ns_chkDocument, l_Query);
  
  if Assigned(l_Context) then
   Context := l_Context.ItemC[0]
  else
   Context := nil;

  if LoadAttributeCaption(l_Query, nsCStr(AT_BASE_SEARCH_PANES), l_ClassCaption) and
     Assigned(l_ClassCaption) then
  begin
   l_Path := l_ClassCaption.AsWStr;
   l_ActiveClass := TnsBaseSearchClasses.Instance.GetClassByPath(l_Path);
  end//LoadAttributeCaption(l_Query, nsCStr(AT_BASE_SEARCH_PANES), l_ClassCaption) and Assigned(l_ClassCaption)
  else
   l_ActiveClass := f_FirstClass;
   
  ActiveClass := l_ActiveClass;
 end//Supports(aQuery, IQuery, l_Query)
 else
  Assert(Assigned(l_Query));
end;

procedure TnsBaseSearcher.RequestFind;
begin
 Find;
end;

function TnsBaseSearcher.pm_GetAllowSearchInTitles: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.AllowSearchInTitles
 else
  Result := True;
end;

function TnsBaseSearcher.pm_GetArea: TnsSearchArea;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.Area
 else
  Result := ns_saEverywere;
end;

procedure TnsBaseSearcher.pm_SetArea(aValue: TnsSearchArea);
begin
 if Area <> aValue then
 begin
  f_AreaSetFromState := False;
  if Assigned(ContextSearcher) then
   ContextSearcher.Area := aValue;
  NotifyVisibleWatcher;
  NotifyWindow;
 end;
end;

function TnsBaseSearcher.CalcDefaultLocalArea(
  AllowSearchInTitles: Boolean): TnsSearchArea;
begin
 if AllowSearchInTitles then
  Result := ns_saTitlesOnly
 else
  Result := ns_saText;
end;

procedure TnsBaseSearcher.NotifyContextSearcher;
begin
 if Assigned(ContextSearcher) then
  ContextSearcher.ContextChanged(f_Context);
end;

procedure TnsBaseSearcher.NotifyVisibleWatcher(AllowVisible: Boolean = true);
begin
 if (ContextSearcher <> nil) AND
    Assigned(ContextSearcher.VisibleWatcher) then
  ContextSearcher
   .VisibleWatcher.VisibleChanged(AllowVisible and
                                  ContextSearcher.IsLocalSearchArea and
                                  Assigned(f_SearchWindow));
end;

procedure TnsBaseSearcher.HistoryChanged(const aNewHistory: IvcmStrings);
begin
end;

procedure TnsBaseSearcher.ContextSearched;
begin
 if l3IEQ(Container, afw.Application.CurrentMainForm) then
  f_Searched := True;
end;

procedure TnsBaseSearcher.GetFirstExampleIndexFromSettings;
begin
 f_CurrentExampleIndex := defDataAdapter.BaseSearchFirstExampleIndex;
end;

procedure TnsBaseSearcher.SetNextExampleText;
var
 l_ExampleCount: LongWord;
 l_String: IString;
begin
 l_ExampleCount := DefDataAdapter.Search.GetExampleTextCount;
 if l_ExampleCount > 0 then
 begin
  if f_CurrentExampleIndex >= l_ExampleCount then
   f_CurrentExampleIndex := 0;
  DefDataAdapter.Search.GetExampleText(f_CurrentExampleIndex, l_String);
  ExampleText := nsCStr(l_String);
  Inc(f_CurrentExampleIndex);
 end
 else
  ExampleText := vcmCStr(str_DefaultContextExample);
end;

procedure TnsBaseSearcher.ApplyCurrentExample;
begin
 Context := pm_GetExampleText;
 SetNextExampleText;

 if Assigned(f_SearchWindow) then
  SearchWindow.ActivateWindow(False);
end;

function TnsBaseSearcher.pm_GetExampleText: Il3CString;
begin
 Result := f_ExampleText;
end;

procedure TnsBaseSearcher.NotifyExampleChange;
begin
 if Assigned(f_SearchWindow) then
  SearchWindow.ExampleChanged;
end;

procedure TnsBaseSearcher.pm_SetExampleText(const aValue: Il3CString);
begin
 if not l3Same(f_ExampleText, aValue) then
 begin
  f_ExampleText := aValue;
  NotifyExampleChange;
 end;
end;

function TnsBaseSearcher.pm_GetFindEnabled: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := not ContextSearcher.IsSearchLocked and (
              not ContextSearcher.IsLocalSearchArea or
              ContextSearcher.IsLocalDataReady)
 else
  Result := True;
end;

procedure TnsBaseSearcher.CheckLocalDataReady;
begin
 CheckFindBtnsEnabled;
end;

procedure TnsBaseSearcher.SearchResultEmpty(TryFullList: Boolean);
begin
 if TryFullList then
 begin
  f_ExpandList := True;
  try
   Find;
  finally
   f_ExpandList := False;
  end;
 end//TryFullList
 else
 if (ActiveClass <> f_FirstClass) then
 begin
  ActiveClass := f_FirstClass;
  Find;
 end//ActiveClass <> f_FirstClass
 else
 if (Area <> ns_saEverywere) then
 begin
  Area := ns_saEverywere;
  Find;
 end;//Area <> ns_saEverywere
end;

procedure TnsBaseSearcher.SaveContextToHistory;
var
 l_Context: IvcmStrings;
begin
 l_Context := TvcmStringList.Make;
 try
  l_Context.Add(Context);
  f_ContextHistory.Searched(l_Context);
 finally
  l_Context := nil;
 end;
end;

procedure TnsBaseSearcher.SearchResultExists;
begin
 if Assigned(f_Presentation) and
    InsBaseSearchPresentation(f_Presentation).TreatSuccessSearchAsManualOpen then
  f_WindowOpenedByUser := True;
 if Assigned(f_ErrorWords) then
 begin
  f_ErrorWords := nil;
  NotifyWindow;
 end;//Assigned(f_ErrorWords)
 f_SavedContext := Context;
end;

procedure TnsBaseSearcher.AnotherSearchSuccessed;
begin
 if Assigned(f_SearchWindow) and
    Assigned(f_Presentation) and
    InsBaseSearchPresentation(f_Presentation).CanCloseWindow then
  SearchWindow.CloseWindow;
 f_WindowOpenedByUser := False;
end;

procedure TnsBaseSearcher.NotifyClassesChanged;
begin
 f_ActiveClass := nil;
 f_ActiveClass := nil;
 f_FirstClass := nil;
 f_SavedClass := nil;
 if Assigned(f_SearchWindow) then
  SearchWindow.ClassNamesChanged;
end;

function TnsBaseSearcher.pm_GetErrorWords: IvcmStrings;
begin
 Result := f_ErrorWords;
end;

procedure TnsBaseSearcher.pm_SetErrorWords(const aValue: IvcmStrings);
begin
 f_ErrorWords := aValue;
end;

procedure TnsBaseSearcher.RepairMistakes;
begin
 if not l3IsNil(Context) and
    bsCorrectMistakes(Context, False, Self)
    and Assigned(f_ErrorWords) then
  SysUtils.Abort;
end;

procedure TnsBaseSearcher.Correct(const aCorrectedContext: Il3StringsEx;
  const aMistakesList: Il3StringsEx);
var
 l_Context : Il3CString;
 l_Index : Integer;
begin
 Assert(Assigned(aCorrectedContext) and (aCorrectedContext.Count >= 1));
 f_ErrorWords := aMistakesList;
 l_Context := nil;
 for l_Index := 0 to Pred(aCorrectedContext.Count) do
  if l3IsNil(l_Context) then
   l_Context := aCorrectedContext[l_Index]
  else
   l_Context := l3Cat([l_Context, aCorrectedContext[l_Index]]);
 if not l3Same(Context, l_Context) then
 begin
  f_Context := l_Context;
  NotifyContextSearcher;
 end;
 NotifyWindow;
end;

function TnsBaseSearcher.ValidateBaseSearchForm(const aForm : IvcmEntityForm): Boolean;
begin
 Result := false;
 if (aForm <> nil) then
  Result := (aForm.NativeMainForm.AsForm.VCLWinControl = Self.Container.AsForm.VCLWinControl);
 Assert(Result);
end;

procedure TnsBaseSearcher.ForceUpdateClassForHistory;
begin
 if (pm_GetSearchWindow <> nil) then
  pm_GetSearchWindow.ForceUpdateClassForHistory;
end;

function TnsBaseSearcher.pm_GetClassesAnywayDisabled: Boolean;
begin
 Result := Assigned(ContextSearcher) and ContextSearcher.IsLocalSearchArea;
end;

procedure TnsBaseSearcher.FindBack;
begin
 if Assigned(ContextSearcher) and ContextSearcher.FindBack(Self, Self) then
 begin
  CheckFindBtnsEnabled;
  Exit;
 end;//Assigned(ContextSearcher)
 Assert(False);
end;

function TnsBaseSearcher.pm_GetFindBackEnabled: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := not ContextSearcher.IsSearchLocked and ContextSearcher.FindBackEnabled
 else
  Result := False;
end;

function TnsBaseSearcher.pm_GetFindBackSupported: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.FindBackSupported
 else
  Result := False;
end;

procedure TnsBaseSearcher.CheckFindBtnsEnabled;
begin
 if Assigned(f_SearchWindow) then
  SearchWindow.CheckFindEnabled;
end;

procedure TnsBaseSearcher.CheckFragmentsCount;
begin
 if Assigned(f_SearchWindow) then
  SearchWindow.CheckFragmentsCount;
end;

function TnsBaseSearcher.pm_GetFragmentsCountSuffix: Il3CString;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.FragmentsCountSuffix
 else
  Result := nil;
end;

procedure TnsBaseSearcher.RequestCheckFragmentsCount;
begin
 CheckFragmentsCount;
end;

procedure TnsBaseSearcher.RequestCheckFindBack;
begin
 CheckFindBtnsEnabled;
end;

function TnsBaseSearcher.pm_GetPromptTree: Il3SimpleTree;
var
 l_FilterableTree: Il3FilterableTree;
 l_Filters: InsBaseSearchPromptFilters;
 l_Data: LongWord;
 l_Current: Integer;
begin
 if Assigned(ContextSearcher) and not ContextSearcher.AllowPrompts then
  Result := nil
 else
 begin
  Result := TnsBaseSearchPromptTree.Make;
  if Supports(Result, Il3FilterableTree, l_FilterableTree) and
   Supports(l_FilterableTree.CloneFilters, InsBaseSearchPromptFilters, l_Filters) then
  begin
   if Assigned(ContextSearcher) then
    l_Data := ContextSearcher.PromptsInfo
   else
    l_Data := 0;
   Result := l_FilterableTree.MakeFiltered(l_Filters.SetPromptForDoc(
                                            TnsPromptForDocFilter.Make(l_Data)),
                                           nil,
                                           l_Current,
                                           True);
  end;//Supports(Result, Il3FilterableTree, l_FilterableTree)..
 end;//Assigned(ContextSearcher)..
end;

procedure TnsBaseSearcher.StoreActiveClass;
begin
 f_SavedClass := f_ActiveClass;
 f_ClassSaved := True;
end;

function TnsBaseSearcher.MakeState: InsBaseSearcherInitialState;
begin
 Result := MakeStateParams([ns_sseContext, ns_sseNeedShowWindow, ns_sseOpenKind, ns_sseSearchArea], False);
end;

function TnsBaseSearcher.MakeStateParams(aStateElements: TnsBaseSearchStateElements;
  aForClone: Boolean): InsBaseSearcherInitialState;
var
 l_NeedOpenWindow: Boolean;
 l_StateElements: TnsBaseSearchStateElements;
 l_NeedActivate: Boolean;
begin
 l_StateElements := aStateElements;
 l_NeedOpenWindow := ((aForClone or f_WindowOpenedByUser)
                       and f_IsWindowOpened and Assigned(f_SearchWindow))
                     or
                     (not l3IsNil(f_Context))
                  and (f_Searched or aForClone or f_WindowOpenedByUser)
                  and (not (    Assigned(f_SearchWindow)
                            and InsSearchWindow(f_SearchWindow).IsMainInUseCase
                            and aForClone));
 l_NeedActivate := f_IsWindowOpened and (f_SearchWindow <> nil) and InsSearchWindow(f_SearchWindow).IsActive;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=566792807,
 // http://mdp.garant.ru/pages/viewpage.action?pageId=567573990
 if aForClone then
  l_StateElements := l_StateElements + [ns_sseActiveClass, ns_sseSearchArea];
 Result := TnsBaseSearcherInitialState.Make(l_StateElements, f_Context,
  l_NeedOpenWindow, f_OpenKind, pm_GetActiveClass, pm_GetArea, l_NeedActivate);
end;

procedure TnsBaseSearcher.AssignState(const aState: InsBaseSearcherInitialState);
begin
 if (aState <> nil) then
 begin
  if (ns_sseContext in aState.Elements) then
   f_InitialContext := aState.Context;
  if (ns_sseNeedShowWindow in aState.Elements) then
  begin
   f_InitialNeedShowWindow := aState.NeedShowWindow;
   f_WindowOpenedByUser := f_InitialNeedShowWindow;
   f_IsWindowOpened := f_InitialNeedShowWindow;
  end; 
  if (ns_sseOpenKind in aState.Elements) then
   f_InitialOpenKind := aState.OpenKind;
  if (ns_sseActiveClass in aState.Elements) then
  begin
   f_ActiveClass := aState.CurrentSearchClass;
   f_ClassSetFromState := True;
  end;
  if (ns_sseSearchArea in aState.Elements) then
  begin
   f_AreaSetFromState := True;
   if Assigned(ContextSearcher) then
    ContextSearcher.Area := aState.SearchArea
   else
    f_AreaFromState := aState.SearchArea;
  end; 
  f_NeedActivate := aState.NeedActivate;
 end;
end;

procedure TnsBaseSearcher.AnotherSearchCancelled;
begin
 if f_ClassSaved and
    ((l3IsNil(f_SavedContext)) or l3Same(Context, f_SavedContext)) then
  ActiveClass := f_SavedClass;
 f_ClassSaved := False;
end;
{$EndIf Monitorings}

end.
