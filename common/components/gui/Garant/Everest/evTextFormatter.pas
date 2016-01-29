unit evTextFormatter;
{* Фильтр для форматирования текста по строкам и пребразования таблиц в псевдографику. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evTextFormatter - текстовый экспорт}
{ Начат: 14.06.1997 12:10 }
{ $Id: evTextFormatter.pas,v 1.223 2015/10/23 15:51:28 lulin Exp $ }

// $Log: evTextFormatter.pas,v $
// Revision 1.223  2015/10/23 15:51:28  lulin
// - не выливаем псевдо-сегменты.
//
// Revision 1.222  2015/10/21 14:51:45  lulin
// {RequestLink:605383118}.
//
// Revision 1.221  2015/10/14 11:30:00  lulin
// - правим забор в Clipboard.
//
// Revision 1.220  2015/10/13 13:57:59  lulin
// {RequestLink:598136171}
//
// Revision 1.218  2015/10/13 13:43:11  lulin
// - заготовочка.
//
// Revision 1.217  2015/08/17 09:48:05  lulin
// - не фильтруем сегменты со шрифтом.
//
// Revision 1.215  2015/06/30 12:02:29  dinishev
// {Requestlink:602940462}
//
// Revision 1.214  2015/06/25 08:07:25  dinishev
// {Requestlink:602000766}
//
// Revision 1.213  2015/04/28 11:58:02  dinishev
// {Requestlink:598131905}
//
// Revision 1.212  2015/04/16 13:26:47  dinishev
// {Requestlink:596845383}
//
// Revision 1.211  2015/04/13 11:25:30  dinishev
// {Requestlink:596385658}
//
// Revision 1.210  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.209  2014/10/31 10:21:41  dinishev
// {Requestlink:570533073}
//
// Revision 1.208  2014/05/20 11:53:05  dinishev
// {Requestlink:532634915}. Правлю удалением лишних сегментов.
//
// Revision 1.207  2014/05/20 09:41:43  dinishev
// {Requestlink:532634915}. Откатил предыдущие правки - костыльное лечение не помогло...
//
// Revision 1.206  2014/05/16 14:29:45  lulin
// - bug fix: падал тест TK288010443.
//
// Revision 1.205  2014/05/07 07:13:37  dinishev
// {Requestlink:532634915}
//
// Revision 1.204  2014/05/06 12:17:29  dinishev
// {Requestlink:532630317}
//
// Revision 1.203  2014/04/21 11:45:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.202  2014/04/11 16:48:20  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.201  2014/04/10 13:09:44  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.200  2014/04/10 11:50:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.199  2014/04/09 14:19:24  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.198  2014/04/09 13:12:03  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.197  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.196  2014/04/07 06:02:21  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.195  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.194  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.193  2014/03/28 12:15:23  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.192  2014/03/21 17:15:14  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.191  2014/03/20 12:23:55  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.190  2014/03/18 15:56:59  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.189  2014/03/17 16:12:08  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.188  2014/03/12 11:45:35  lulin
// - выделяем базового предка.
//
// Revision 1.187  2014/03/07 15:29:16  lulin
// - перетряхиваем списки тегов.
//
// Revision 1.186  2014/03/07 14:53:48  lulin
// - перетряхиваем списки тегов.
//
// Revision 1.185  2014/03/06 17:23:19  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.184  2014/03/06 08:47:54  dinishev
// {Requestlink:518433388}
//
// Revision 1.183  2014/03/05 14:10:07  lulin
// {RequestLink:495125442}
//
// Revision 1.182  2014/03/04 13:16:49  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.181  2014/02/28 14:54:15  lulin
// - перетряхиваем генераторы.
//
// Revision 1.180  2014/02/24 15:43:09  lulin
// - чиним сломавшуюся выливку в NSRC.
//
// Revision 1.179  2014/02/21 18:08:40  lulin
// - избавляемся от обёрток над тегами.
//
// Revision 1.178  2014/02/18 13:34:27  lulin
// - избавляемся от ненужного списка.
//
// Revision 1.177  2013/11/19 11:30:48  dinishev
// {Requestlink:502975761}
//
// Revision 1.176  2013/10/22 09:21:22  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.175  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.174  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.173  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.172  2013/04/26 13:23:46  dinishev
// {Requestlink:431359667}
//
// Revision 1.171  2013/04/24 09:35:36  lulin
// - портируем.
//
// Revision 1.170  2013/04/05 12:02:16  lulin
// - портируем.
//
// Revision 1.169  2013/04/04 11:18:52  lulin
// - портируем.
//
// Revision 1.168  2013/02/18 14:11:51  lulin
// - bug fix: при выливки картинок иногда ездили по памяти.
//
// Revision 1.167  2012/11/01 07:11:19  lulin
// - вычищаем мусор.
//
// Revision 1.166  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.165  2012/03/19 11:37:42  narry
// Не выливается картинка для ObjTopic (344138525)
//
// Revision 1.164  2012/02/28 16:30:51  lulin
// {RequestLink:336664105}
//
// Revision 1.163  2012/02/28 16:23:48  lulin
// {RequestLink:336664105}
//
// Revision 1.162  2012/02/28 16:15:49  lulin
// {RequestLink:336664105}
//
// Revision 1.161  2012/01/30 11:50:42  lulin
// {RequestLink:331186919}
//
// Revision 1.160  2012/01/30 10:10:51  lulin
// {RequestLink:331186919}
//
// Revision 1.159  2011/09/28 14:50:23  lulin
// {RequestLink:288010443}.
//
// Revision 1.158  2011/09/28 14:27:12  lulin
// {RequestLink:288010443}.
//
// Revision 1.157  2011/09/28 12:31:51  lulin
// {RequestLink:288010443}.
//
// Revision 1.156  2011/09/19 16:04:54  lulin
// {RequestLink:283615304}.
//
// Revision 1.155  2011/08/05 10:42:55  dinishev
// [$278135327]
//
// Revision 1.154  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.153  2011/05/18 17:45:15  lulin
// {RequestLink:266409354}.
//
// Revision 1.152  2010/08/11 09:05:17  dinishev
// [$182452385]. Вернул, т.к. в Немезисе и в модели разъехалось - недоглядел. :-(
//
// Revision 1.33  2010/08/11 06:48:44  dinishev
// [$182452385]
//
// Revision 1.150  2010/05/20 05:15:44  narry
// - K214073721
//
// Revision 1.149  2010/05/14 12:09:38  lulin
// {RequestLink:213254256}.
//
// Revision 1.148  2010/05/13 11:45:28  dinishev
// [$211878862]
//
// Revision 1.147  2010/05/13 09:36:32  lulin
// {RequestLink:211878214}.
//                                                                                     
// Revision 1.146  2010/05/12 15:08:34  dinishev
// [$210438308]
//
// Revision 1.145  2010/05/12 11:41:32  narry
// - заточки под конвертер
//
// Revision 1.144  2010/05/06 10:13:17  lulin
// - чистим предыдущую таблицу.
//
// Revision 1.143  2010/05/05 14:52:08  lulin
// {RequestLink:209584396}.
// - берём видимость от стиля только если у параграфа нету своего собственного параметра.
//
// Revision 1.142  2010/05/05 14:08:07  lulin
// {RequestLink:209584396}.
// - тест подточен под архивариус.
//
// Revision 1.141  2010/05/04 09:17:59  lulin
// {RequestLink:208699964}.
//
// Revision 1.140  2010/04/30 12:37:51  lulin
// {RequestLink:208699964}.
//
// Revision 1.139  2010/04/28 13:04:26  lulin
// {RequestLink:207013375}.
// - не забываем сдвигать сегменты.
//
// Revision 1.138  2010/04/28 12:35:31  lulin
// {RequestLink:207013375}.
// - игнорируем перенос в начале строки таблицы.
//
// Revision 1.137  2010/04/27 08:58:38  dinishev
// Bug fix: Ошибка при установке блока в Арчи + автоматические тесты не проходят.
//
// Revision 1.136  2010/04/26 14:31:22  dinishev
// [$206504312]
//
// Revision 1.135  2010/04/26 11:21:03  lulin
// {RequestLink:206504616}.
// - информируем об удалении символов, при удалении двойных пробелов.
//
// Revision 1.134  2010/04/26 11:03:07  lulin
// {RequestLink:206504616}.
// - добавлен тест.
//
// Revision 1.133  2010/04/26 07:54:00  voba
// - не выливалась ссылка стоящая на последнем символе из-за недоделанной корректировки сегментов при удалении пробелов перед выливкой в псевдографику
//
// Revision 1.132  2010/04/22 13:02:59  dinishev
// _CleanUp
//
// Revision 1.131  2010/04/22 12:55:20  dinishev
// [$206077980]
//
// Revision 1.130  2010/04/21 14:25:38  lulin
// {RequestLink:205357352}.
// - типа оптимизация.
//
// Revision 1.129  2010/04/21 14:20:37  lulin
// {RequestLink:205357352}.
// - bug fix: не обрабатывали удаление символов.
//
// Revision 1.128  2010/04/21 13:47:23  lulin
// {RequestLink:205357352}.
// - не трогаем честные таблицы.
//
// Revision 1.127  2010/04/21 13:41:14  lulin
// {RequestLink:205357352}.
// - отрезаем "ненужные" пробелы.
//
// Revision 1.126  2010/03/26 13:29:44  lulin
// {RequestLink:199590833}.
// - записываем размер кегля для печати для старых таблиц.
//
// Revision 1.125  2010/02/24 18:15:07  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.124  2010/01/14 14:32:16  lulin
// {RequestLink:177964450}. Написан комментарий.
//
// Revision 1.123  2010/01/14 14:24:51  lulin
// {RequestLink:177964265}. Отрезаем Sub'ы у технических комментариев.
//
// Revision 1.122  2010/01/14 14:05:42  lulin
// {RequestLink:177964265}. Игнорируем ширины разделов.
//
// Revision 1.121  2010/01/14 13:56:14  lulin
// {RequestLink:177964264}. Не учитывали псевдографические таблицы.
//
// Revision 1.120  2010/01/14 13:34:51  lulin
// {RequestLink:177964278}. Написан комментарий.
//
// Revision 1.119  2010/01/14 13:32:36  lulin
// {RequestLink:177964278}.
//
// Revision 1.118  2010/01/13 16:40:43  lulin
// - убрана ненужная проверка, т.к. когда преобразуем гиперссылку в продолжение, то начало никогда убирать не надо.
//
// Revision 1.117  2010/01/13 16:27:16  lulin
// - написан комментарий.
//
// Revision 1.116  2010/01/13 16:21:17  lulin
// [$177963418].
//
// Revision 1.115  2010/01/13 15:58:47  lulin
// {RequestLink:177963362}. Не режем на строки внутри честных таблиц.
//
// Revision 1.114  2010/01/13 15:25:56  lulin
// - удалён ненужный код.
//
// Revision 1.113  2010/01/12 15:09:44  dinishev
// Bug fix: выливали лишние "сердечки" в NSRC+
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.112  2009/12/14 12:38:55  lulin
// - убираем лишние телодвижения при вставке подстроки.
//
// Revision 1.111  2009/09/29 06:03:50  dinishev
// [$164596048]. Bug fix: отъехала выливка некоторых документов.
//
// Revision 1.110  2009/09/28 06:21:40  dinishev
// [$164596048]
//
// Revision 1.109  2009/09/24 13:11:30  dinishev
// [$164594891]
//
// Revision 1.108  2009/08/31 08:13:46  lulin
// {RequestLink:160008456}.
//
// Revision 1.107  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.106  2009/07/21 14:36:02  lulin
// - убираем поддержку IUnknown со строк.
//
// Revision 1.105  2009/07/20 11:21:56  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.104  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.103  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.102  2009/06/25 12:57:31  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.101  2009/06/02 16:12:53  lulin
// - выделяем внутренние интерфейсы в отдельные модули.
//
// Revision 1.100  2009/05/18 14:23:27  dinishev
// [$147490971]
//
// Revision 1.99  2009/04/07 16:09:41  lulin
// [$140837386]. №13.
//
// Revision 1.98  2009/03/05 13:09:36  lulin
// - <K>: 137470629. Используем ссылки на типы.
//
// Revision 1.97  2009/03/04 13:32:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.96  2009/02/26 10:21:19  lulin
// - <K>: 137465982. №1
//
// Revision 1.95  2009/02/24 13:36:07  dinishev
// Bug fix: выливка кривых ссылок
//
// Revision 1.94  2008/12/29 09:22:20  dinishev
// Более корректное исправление дублирования бубны в ссылках
//
// Revision 1.93  2008/12/25 09:21:04  dinishev
// Мердж исправлений выливки с веткой
//
// Revision 1.92  2008/12/18 13:58:30  lulin
// - <K>: 132222370. Локализуем место выставления целевой кодировки.
//
// Revision 1.91  2008/12/18 13:45:08  lulin
// - <K>: 132222370. Поддерживаем работу с кодировкой TatarOEM.
//
// Revision 1.90  2008/12/12 19:19:14  lulin
// - <K>: 129762414.
//
// Revision 1.89  2008/12/10 06:58:24  dinishev
// Иногда неправильно выливались ссыкли
//
// Revision 1.88  2008/09/10 07:36:27  dinishev
// Bug fix: выливалась лишняя строка после подписи
//
// Revision 1.87  2008/09/03 11:24:21  dinishev
// Bug fix: иногда в начале таблицы с невидимыми границами не разделяли строки
//
// Revision 1.86  2008/08/21 13:37:41  dinishev
// Bug fix: в некоторых документах неправильно выливались _SBS (заточка до исправления 109904163)
//
// Revision 1.85  2008/08/12 10:44:24  dinishev
// Bug fix: иногда не выливались "мордочки" для текста.
//
// Revision 1.84  2008/08/05 12:24:19  dinishev
// <K> : 77235623
//
// Revision 1.83  2008/08/03 09:59:49  dinishev
// <K> : 103942072
//
// Revision 1.82  2008/07/01 14:22:47  dinishev
// Bug fix: две рядом стоящие формулы выливались криво
//
// Revision 1.81  2008/06/20 14:48:51  lulin
// - используем префиксы элементов.
//
// Revision 1.80  2008/06/20 14:02:45  lulin
// - используем префиксы элементов.
//
// Revision 1.79  2008/06/20 11:35:46  dinishev
// Bug fix: для подписей добавлялись лишние строки
//
// Revision 1.78  2008/05/23 16:04:38  lulin
// - <K>: 91848978.
//
// Revision 1.77  2008/04/23 13:46:27  dinishev
// Bug fix: при отстуствии границ рамок сливались строки в таблицах при выливке
//
// Revision 1.76  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.75  2008/03/21 12:17:25  lulin
// - <K>: 87590980.
//
// Revision 1.74  2008/03/21 10:38:37  lulin
// - <K>: 87590380.
//
// Revision 1.73  2008/03/20 15:00:47  lulin
// - <K>: 87590377.
//
// Revision 1.72  2008/03/19 14:23:34  lulin
// - cleanup.
//
// Revision 1.71  2008/02/26 14:59:33  lulin
// - использовали не то свойство.
//
// Revision 1.70  2008/02/21 18:48:12  lulin
// - упрощаем наследование.
//
// Revision 1.69  2008/02/20 17:22:54  lulin
// - упрощаем строки.
//
// Revision 1.68  2008/02/20 11:05:14  lulin
// - <TDN>: 84.
//
// Revision 1.67  2008/02/12 10:31:18  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.66  2008/02/07 17:08:34  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.65  2008/02/07 09:32:56  lulin
// - подготавливаемся к переносу списка целых на модель.
//
// Revision 1.64  2008/02/05 09:57:38  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.63  2008/02/04 08:51:24  lulin
// - класс _Tl3InterfaceList выделен в отдельный модуль.
//
// Revision 1.62  2008/02/01 15:14:29  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.61  2008/01/31 18:53:27  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.60  2008/01/10 15:20:36  lulin
// - bug fix: при выливке сегментов, не учитывали, что удаляем "звездочку".
//
// Revision 1.59  2008/01/10 14:14:27  lulin
// - bug fix: неверно выливалось продолжение ссылки в абзацах с "новой строкой".
//
// Revision 1.58  2007/12/24 15:25:22  lulin
// - удалены ненужные файлы.
//
// Revision 1.57  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.31  2007/11/28 12:39:49  dinishev
// Правка ошибок выливки таблиц
//
// Revision 1.30  2007/10/17 07:22:23  voba
// - bug fix от Шуры
//
// Revision 1.29  2007/09/21 15:30:14  dinishev
// Bug fix: AV при выливке документов с таблицами в Archi
//
// Revision 1.28  2007/09/21 12:58:16  lulin
// - сделана выливка формул в NSRC.
//
// Revision 1.27  2007/09/21 12:11:15  lulin
// - bug fix: не падаем на вложенных параграфах.
//
// Revision 1.26  2007/09/14 13:26:02  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.25.2.3  2007/09/12 17:51:45  lulin
// - cleanup.
//
// Revision 1.25.2.2  2007/09/12 16:14:04  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.25.2.1  2007/09/12 15:22:58  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.25  2007/09/11 18:49:55  lulin
// - удален ненужный параметр.
//
// Revision 1.24  2007/09/07 14:47:34  lulin
// - добавлено удаление последнего элемента списка.
//
// Revision 1.23  2007/09/06 16:04:32  dinishev
// Bug fix: отъехала выливка вложенных таблиц
//
// Revision 1.22  2007/09/06 09:37:34  lulin
// - переименовано свойство.
//
// Revision 1.21  2007/09/03 12:29:01  lulin
// - переименовываем тег.
//
// Revision 1.20  2007/08/30 07:59:39  dinishev
// Используем для временного запоминания ячейки переменную, а не список с таблицами.
//
// Revision 1.19  2007/08/28 15:21:55  dinishev
// Bug fix: выливалась лишняя пустая строка в таблице
//
// Revision 1.18  2007/08/21 16:10:25  lulin
// - неверно трактовали отсутствующий конец сегмента при переборе сегментов (CQ OIT5-25634).
//
// Revision 1.17  2007/08/10 18:27:13  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.16  2007/08/09 12:38:14  lulin
// - убираем замороченную логику с присвоением таблицы тегов.
//
// Revision 1.15  2007/08/09 11:19:10  lulin
// - cleanup.
//
// Revision 1.14  2007/07/19 08:54:55  voba
// - bug fix от Шуры
//
// Revision 1.13  2007/07/18 15:07:16  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.12  2007/07/09 14:54:36  dinishev
// Bug fix: падало при выливке.
//
// Revision 1.11  2007/05/25 15:30:47  dinishev
// Bug fix: Падало при выливке + неправильно выливались некоторые таблицы.
//
// Revision 1.10  2007/04/04 08:19:53  dinishev
// Bug fix: В некоторых таблицах "забывали" вылить широкую ячейку.
//
// Revision 1.9  2007/03/29 10:02:07  dinishev
// Bug fix: неправильно выливались некоторые таблицы
//
// Revision 1.8  2007/01/12 13:48:14  lulin
// - cleanup.
//
// Revision 1.7  2007/01/05 14:37:16  lulin
// - cleanup.
//
// Revision 1.6  2006/11/27 09:31:27  lulin
// - cleanup.
//
// Revision 1.5  2006/11/27 09:20:27  lulin
// - cleanup.
//
// Revision 1.4  2006/11/27 08:43:19  lulin
// - cleanup.
//
// Revision 1.3  2006/11/09 10:06:15  dinishev
// Bug fix: в сложных таблицах при выливке иногда "забывались" верхние границы, если предыдущая строка не имела нижней границы
//
// Revision 1.2  2006/10/12 15:17:37  lulin
// - переехали в общую папку.
//
// Revision 1.1.2.1  2006/10/12 15:15:01  lulin
// - переехали в общую папку.
//
// Revision 1.55  2006/09/21 12:29:29  dinishev
// new interface: Il3StringFormatter
//
// Revision 1.54  2006/09/20 14:26:02  dinishev
// Bug fix: вылива рамок срабатывала в неправильном месте
//
// Revision 1.53  2006/09/13 07:54:04  dinishev
// Bug fix: неправильно выливаись сложные таблицы или происходило зависание выливки
//
// Revision 1.52  2006/08/02 12:17:39  dinishev
// Bug fix: вис архивариус при выливке сложных таблиц в псевдографику
//
// Revision 1.51  2006/07/06 07:50:29  dinishev
// Bug fix: неправильная выливка верхней границы квадрата и гипессылок в таблице
//
// Revision 1.50  2005/10/18 08:30:46  lulin
// - new behavior: теперь методы вставки и добавления дочерних тегов могут подменять вставляемые теги.
//
// Revision 1.49  2005/09/08 15:23:11  lulin
// - bug fix: Unicode-строки неправильно разгонялись по ширине.
//
// Revision 1.48  2005/07/21 11:15:04  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.47  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.46.2.3  2005/04/26 16:07:07  lulin
// - уменьшаем число лишних вызовов.
//
// Revision 1.46.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.46.2.1  2005/04/21 15:36:40  lulin
// - окончательно избавился от необходимости обертки.
//
// Revision 1.46  2005/04/20 15:25:28  lulin
// - убираем прямое обращение к тегу.
//
// Revision 1.45  2005/04/20 14:19:44  lulin
// - убираем прямое обращение к тегу.
//
// Revision 1.44  2005/04/18 17:18:22  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.43  2005/03/30 15:27:30  narry
// - bug fix: AV При открытии потока
//
// Revision 1.42  2005/03/29 15:56:34  lulin
// - cleanup.
//
// Revision 1.41  2005/03/29 14:32:39  lulin
// - bug fix: брался неправильный генератор.
//
// Revision 1.40  2005/03/28 14:29:59  lulin
// - от класса генераторов переходим к интерфейсу.
//
// Revision 1.39  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.38  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.37  2005/03/24 14:10:31  lulin
// - удалены ненужные методы.
//
// Revision 1.36  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.35  2005/03/23 13:36:29  lulin
// - убран ненужный утилитный класс.
//
// Revision 1.34  2005/03/23 12:42:23  lulin
// - вместо вызова метода ссылаемся на свойство.
//
// Revision 1.33  2005/03/21 10:04:50  lulin
// - new interface: _Ik2Type.
//
// Revision 1.32  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.31  2005/03/18 16:11:22  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.30  2005/03/17 14:26:10  lulin
// - bug fix: AV при автоматическом изменении имен меток.
//
// Revision 1.29  2005/03/16 19:21:53  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.28  2005/03/15 10:30:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.27  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.26  2005/03/04 15:49:02  lulin
// - спрятана процедура Tk2Type.New.
//
// Revision 1.25  2004/10/12 16:22:45  lulin
// - bug fix: таблицы неправильно забирались в буфер обмена в кодировке Unicode (CQ OIT5-10225).
//
// Revision 1.24  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.23  2004/06/29 14:26:41  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.22  2004/06/04 11:25:39  law
// - new behavior: объединяем соседние сегменты с одинаковыми стилями.
//
// Revision 1.21  2004/06/02 10:20:33  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList.Make.
//
// Revision 1.20  2004/06/02 08:30:24  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.19  2004/06/01 16:51:19  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.18  2004/05/27 14:31:56  law
// - new methods: _Tl3_CBase.IsCacheable, _NeedStoreInPool.
//
// Revision 1.17  2004/05/14 16:07:57  law
// - new units: evFileGenerator, evPlainTextGenerator.
//
// Revision 1.16  2004/04/21 11:14:03  law
// - change: используем l3RTrim вместо ev_lpRTrimLen.
//
// Revision 1.15  2004/04/20 14:36:03  law
// - cleanup: избавился от лишнего вызова метода _Unconst.
//
// Revision 1.14  2004/04/19 16:08:15  law
// - new type: _Tl3PCharLenConst.
//
// Revision 1.13  2004/04/19 13:31:01  law
// - bug fix: боремся с неправильным форматированием Unicode-строк.
//
// Revision 1.12  2004/04/02 09:28:48  law
// - bug fix: после таблицы и команды !Division не выливалась команда !Style.
//
// Revision 1.11  2004/01/20 14:04:26  law
// - bug fix: Если блок заканчивается таблицей, то при выливке в NSRC ENDBLOCK выливается ПЕРЕД последней строкой таблицы (CQ OIT5-5909).
//
// Revision 1.10  2004/01/09 10:39:53  law
// - bug fix: в NSRC неправильно выливались продолжения ссылок, автоматически получаемые из ссылок.
//
// Revision 1.9  2003/11/28 14:11:07  law
// - new unit: evSegmentsListConst.
//
// Revision 1.8  2003/11/21 14:41:41  law
// - bug fix: не выливаем блоки, которые находятся внутри таблицы.
//
// Revision 1.7  2003/10/27 11:49:15  law
// - bug fix: CQ OIT500005102 - неправильно выливалась таблица без рамок с объединеными  по вертикали ячейками (см. _testset\verticalmerge\brak.evd ).
//
// Revision 1.6  2003/04/15 15:13:57  law
// - bug fix: не компилировался Эверест.
//
// Revision 1.5  2002/12/17 12:42:48  law
// - change: k2_idTableColumn переименовано в k2_idTableCell для большего соответстия смыслу тега.
//
// Revision 1.4  2002/10/23 14:36:09  law
// - new method: ValidateLine.
//
// Revision 1.3  2002/10/23 12:56:53  law
// - cleanup.
//
// Revision 1.2  2002/10/23 11:56:30  law
// - cleanup.
//
// Revision 1.1  2002/09/24 15:09:39  law
// - rename unit: evTxtExp -> evTextFormatter.
//
// Revision 1.103  2002/08/30 07:18:57  law
// - new behavior: учитываем ширину секции при выливке в txt и NSRC.
//
// Revision 1.102  2002/07/10 11:24:12  law
// - bug fix: выливался мусор от объединенных по вертикали ячеек.
//
// Revision 1.101  2002/07/09 12:02:22  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.100  2002/07/05 10:06:17  law
// - bug fix: пропадали пустые строки.
//
// Revision 1.99  2002/04/11 06:46:51  law
// - new behavior: поправлена выливка технических комментариев в объединенных ячейках.
//
// Revision 1.98  2002/04/10 15:15:03  law
// - new behavior: улучшена выливка технических комментариев внутри таблиц.
//
// Revision 1.97  2002/04/09 14:31:03  law
// - new behavior: в первом приближении сделан экспорт параграфов со стилем "Технический комментарий" внутри таблиц.
//
// Revision 1.96  2002/02/11 13:40:02  law
// - new behavior: изменен алгоритм перенесения слов по слогам.
//
// Revision 1.95  2001/08/28 12:55:12  law
// - rename unit: evUtils -> l3Utils.
//
// Revision 1.94  2001/07/24 12:30:24  law
// - comments: xHelpGen.
//
// Revision 1.93  2001/07/19 11:24:19  law
// - bug fix: неправильно выливались гиперссылки в конце параграфа. В соответствии с задачей №733. (см. _TestSet\Segments\Hyperlinks\2.evd)
//
// Revision 1.92  2001/07/18 16:02:02  law
// - new behavior: теперь при экспорте в NSRC правятся концы сегментов > длины текста. В соответствии с задачей №726. (см. _TestSet\Segments\Hyperlinks\1.evd)
//
// Revision 1.91  2001/07/17 14:59:02  law
// - bug fix: в соответствии с задачей №722.
//
// Revision 1.90  2001/05/31 15:32:41  law
// - bug fix: поправлена выливка рамок для маленьких ячеек (_TestSet\ComplexTable\6.evd).
//
// Revision 1.89  2001/05/30 11:29:14  law
// - bug fix: неправильно выливалась таблица с ячейками, объединенными по вертикали (см. _TestSet\ComplexTable\5.evd).
//
// Revision 1.88  2001/05/30 09:11:18  law
// - new behavior: пытаемся централизовать обработку ошибок чтения документов.
//
// Revision 1.87  2001/05/28 12:21:25  law
// - bug fix: неправильно выливались рамки у сложных таблиц с объединенными ячейками (_TestSet\ComplexTable\4.evd).
//
// Revision 1.86  2001/05/28 09:45:07  law
// - new behavior: теперь пользуемся процедурой l3FixWidth из l3StringEx.
//
// Revision 1.85  2001/05/07 06:56:55  law
// - bug fix: доделана выливка таблиц с учетом невидимых символов.
//
// Revision 1.84  2001/05/04 11:02:12  law
// - new behavior: сделан учет спецсимволов при выливке таблиц в NSRC и txt.
//
// Revision 1.83  2001/05/03 10:20:39  law
// - cleanup: убраны свойство и параметр CheckEmptyFrame.
//
// Revision 1.82  2001/05/03 10:07:51  law
// - comments.
//
// Revision 1.81  2001/04/24 12:59:51  voba
// - bug fix: пытались объединить головную ячейку объединения с предыдущим объединением.
//
// Revision 1.80  2001/04/23 11:44:54  law
// - new behavior: сегменты, стиль которых совпадает со стилем параграфа, теперь не выливаются в NSRC.
//
// Revision 1.79  2001/04/20 15:22:36  law
// - bug fix: поправлена выливка некоторых таблиц со сложными рамками.
//
// Revision 1.78  2001/04/20 12:22:03  law
// - bug fix: сделан учет рамок головной ячейки, для ячеек объединеных по вертикали.
//
// Revision 1.77  2001/04/12 09:19:49  law
// - bug fix: усилена проверка добавления пустой строки - иначе иногда было зависание.
//
// Revision 1.76  2001/03/22 13:29:22  law
// - bug fix: иногда неправильно вставлялся нулевой символ (#0).
//
// Revision 1.75  2001/03/22 13:09:48  law
// - bug fix: иногда неравильно прерывалось объединение ячеек.
//
// Revision 1.74  2001/03/21 16:58:49  law
// - bug fix: неправильно выливались таблицы, когда не удавалось разогнать строку по ширине (не было пробелов).
//
// Revision 1.73  2001/03/19 17:59:42  law
// - поправлена выливка таблиц с Preformatted-параграфами.
//
// Revision 1.72  2001/03/16 13:48:56  law
// - убрана ссылка на IterateSegmentsF.
//
// Revision 1.71  2001/03/14 13:24:55  law
// - some cleaup and tuning.
//
// Revision 1.70  2001/03/05 14:08:29  law
// - поменялся порядок у методов _IterateChildren...
//
// Revision 1.69  2001/03/01 15:45:21  law
// - отключена выливка ячеек с шириной <= 0.
//
// Revision 1.68  2001/02/28 15:11:08  law
// - сделано разбиение по слогам последнего неумещающегося слова.
//
// Revision 1.67  2001/02/28 10:12:40  law
// - процедуры Write и WriteEx объединены в одну - Write.
//
// Revision 1.66  2001/02/23 13:44:26  law
// - к текстовому параграфу добавлено свойство AllowHyphen.
//
// Revision 1.65  2001/02/22 12:06:36  law
// - bug fix: учитываем символы, вставленные при покраске сегментов.
//
// Revision 1.64  2001/02/20 13:28:09  law
// - немного переделал алгоритм нарезки слов по слогам.
//
// Revision 1.63  2001/02/19 15:30:04  law
// - bug fix: GPF при объединенных по вертикали ячейах.
//
// Revision 1.62  2001/02/19 13:34:03  law
// - bug fix: поправлена очередная ошибка зависания при сохранении в текст и NSCR.
//
// Revision 1.61  2001/02/02 14:46:47  law
// - версия 0.22 - поправлена выливка ячеек, объединенных по вертикали.
//
// Revision 1.60  2001/01/26 14:16:18  law
// - bug fix: экспорт сегментов для которых Start > Finish.
//
// Revision 1.59  2001/01/19 11:07:19  law
// - убраны свойства TevTableRowAtom.Cell и TevTableRowAtom.CellCount.
//
// Revision 1.58  2001/01/19 10:36:47  law
// - достаточно кривая заплатка для решения проблем с вертикально объединенными ячейками.
//
// Revision 1.57  2001/01/18 13:51:56  law
// - сделал обработку exception при проблемах с ячейками, объединенными по вертикали.
//
// Revision 1.56  2001/01/16 15:32:06  law
// - сделана обработка VerticalAligment в ячейках таблиц.
//
// Revision 1.55  2001/01/09 11:40:52  law
// - bug fix: переносы в ячейке таблицы.
//
// Revision 1.54  2000/12/27 13:00:02  law
// - bug fix: выливка отступа для таблицы, следующей сразу же за предыдущей.
//
// Revision 1.53  2000/12/27 09:05:45  law
// - bug fix: выливка тега k2_tiVisible для комментариев и гипертекстовых ссылок в NSRC.
//
// Revision 1.52  2000/12/20 18:03:38  law
// - поправил предыдущий коментарий.
//
// Revision 1.51  2000/12/20 18:01:52  law
// - bug fix: нарезка на строки параграфов с SoftEnter'ами.
//
// Revision 1.50  2000/12/20 14:57:07  law
// - переделана выливка таблиц следующих вплотную друг за другом.
//
// Revision 1.49  2000/12/18 17:30:32  law
// - добавлен перенос по слогам.
//
// Revision 1.48  2000/12/18 15:00:37  law
// - немного изменен алгоритм нарезки на строки - для возможности вставки переносов по слогам.
//
// Revision 1.47  2000/12/18 13:12:12  law
// - bug fix: выливка пустого текста иногда приводила к ошибке конвертации.
//
// Revision 1.46  2000/12/15 15:10:38  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Windows,
  Classes,
  Messages,

  l3Interfaces,
  l3Types,
  l3IID,
  l3Chars,
  l3InternalInterfaces,
  l3InterfacesMisc,
  l3Base,
  l3Filer,
  l3ObjectRefList,
  l3StringList,
  l3ProtoObject,
  l3ProtoObjectRefList,
  l3Variant,

  k2Types,
  k2TagGen,
  k2Interfaces,
  k2InternalInterfaces,
  k2Except,
  k2DocumentGenerator,
  k2SimpleTagList,
  k2String,

  evdTypes,
  evdPlainTextWriter,
  evdDocumentFilter,

  evConst,
  evInternalInterfaces,
  evGeneratorsInterfaces,
  
  l3ProtoPersistentRefList,

  evCustomTextFormatterModelPart
  ;

type
  TevTableAtom = class;

  TevTableRowAtom = class;

  TevCustomTextFormatter = class(TevCustomTextFormatterModelPart, IevTextPainter)
  {* Фильтр для форматирования текста по строкам и пребразования таблиц в псевдографику. }
  private
  {internal fields}
    f_Tables        : Tl3ProtoObjectRefList;
    f_Columns       : Tl3ProtoPersistentRefList;
    f_TextParaLines : Tl3StringList;
    f_CellsTag      : Tk2SimpleTagList;
  private
  {property fields}
    f_CodePage           : Long;
    f_FormatOrdinalParas : Bool;
    f_SBSDelimeter       : AnsiChar;
    f_PrevTable          : TevTableAtom;
  protected
  // - для работы TevSimpleTextPainter  
    f_SectionWidth       : Long;
    f_InTextPara         : Bool;
  private
  // interface methods
    procedure NotifyInsertion(aTarget: TObject; aPos, aLen: Long);
      {-}
    procedure NotifyDeletion(aTarget: TObject; aPos, aLen: Long);
      {-}
    procedure CorrectParentWidth(anSBS     : Boolean;
                                 aCurrenCell : Long;
                                 var aWidth  : Integer);
      {-}
    procedure CheckSBSTable(aText      : Tl3Variant;
                            const aRow       : TevTableRowAtom;
                            var aParentWidth : Integer);
      {* - Проверяем и корректируем ширину _SBS. }
    function CheckSubList(aTag: Tl3Variant): Tk2SimpleTagList;
      {-}
  protected
  // property methods
    procedure pm_SetPrevTable(Value: TevTableAtom);
      {-}
  protected
  // internal methods
    function IsStyleEqual(aParaStyle: Integer; aSegmentStyle: Integer): Boolean;
      virtual;
      {-}
    procedure DoStartAtom(var Atom: Tk2StackAtom);
      override;
      {-}
    function  DoBeforeFinishAtom(var anAtom: Tk2StackAtom): Bool;
      override;
      {-}
    procedure StartRow;
      {-}
    procedure DoFinishTableRow(const TR: Tk2StackAtom);
      {-}
    procedure DoStartTable(T: Tl3Variant);
      {-}
    procedure DoFinishTable(const T: Tk2StackAtom);
      {-}
    procedure StartCell;
      {-}
    procedure DoFinishTableColumn(const TC: Tk2StackAtom);
      {-}
    procedure DoFinishTextPara(const TP: Tk2StackAtom);
      {-}
    procedure ValidateSegments(aPara : Tl3Variant;
                               const aText : Tl3PCharLen);
      {* - Проверяет список сегментов и склеивает соседние. }
    procedure FormatLines(TP    : Tl3Variant;
                          Strings     : Tl3StringList;
                          Subs        : Tk2SimpleTagList;
                          InTable     : Bool;
                          ParentWidth : Long);
      {* - Нарезает параграф на строки. }
    procedure PaintLine(ParaVisible  : Bool;
                        ParaStyle    : Long;
                        S            : Tl3String;
                        Obj    : Tl3Variant;
                        First, aLast : Bool);
      virtual;
      {* - Процедура для "покраски" сегментов текста. Для перекрытия в потомках. }
    procedure ValidateLine(aLine : Tl3String; aCodePage : Integer);
      virtual;
      {* - Процедура для проверки корректности строки. Для перекрытия в потомках. }
    procedure ValidateText(aText: Tl3String; aValidateText: Tl3String = nil);
      {-}
    procedure AddAtom(AtomIndex: Long; aValue: Tl3Variant);
      override;
      {-}
    procedure Cleanup;
      override;
      {-}
    procedure OpenStream;
      override;
      {-}
    procedure CloseStream(NeedUndo: Bool);
      override;
      {-}
    function NeedAddSpaces: Boolean; virtual;
      {-}
  public
  // public methods
    constructor Create(AOwner: Tk2TagGeneratorOwner = nil);
      override;
    procedure ClearObjects;
      {-}
    function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
      override;
      {-}
  public
  // public properties
    property CodePage: Long
      read f_CodePage
      write f_CodePage
      default CP_OEM;
      {* - Кодировка текста в которой должны получаться генерируемые строки. }
    property FormatOrdinalParas: Bool
      read f_FormatOrdinalParas
      write f_FormatOrdinalParas
      default True;
      {* - Форматировать обычные параграфы или только таблицы? }
    property SBSDelimeter: AnsiChar
      read f_SBSDelimeter
      write f_SBSDelimeter
      default '|';
      {* - Разделитель для частей параграфа Side By Side. }
    property PrevTable: TevTableAtom
      read f_PrevTable
      write pm_SetPrevTable;
      {-}  
  end;//TevCustomTextFormatter

  {* Фильтр для форматирования текста по строкам и пребразования таблиц в псевдографику.
     Предполагает наличие за собой генератора, который занимается собственно записью, навроде TevCustomPlainTextGenerator'а или TevCustomNSRCWriter. }

  TevTextFormatter = class(TevCustomTextFormatter)
   {*! Фильтр для форматирования текста по строкам и пребразования таблиц в псевдографику. }
  published
    property Generator;
      {-}
    property CodePage;
      {-}
  end;//TevTextFormatter

  TevOutExtStringEvent = procedure(Sender: TObject; Name: Tl3CustomString; Filer: Tl3CustomFiler) of object;

  EevHyperlinkNotFound = class(Ek2NotFound);

  TevCustomTextPainter = class(TevdCustomPlainTextWriter, IevTextPainter)
  {* Фильтр для "покраски" строк текста при конвертации в формат подобный txt или NSRC. }
  protected
  {internal methods}
    function IsStyleEqual(aParaStyle: Integer; aSegmentStyle: Integer): Boolean;
      virtual;
      {-}
    function  IsMarkStyle(aParaVisible        : Bool;
                          aParaStyle          : Long;
                          aStyledObject : Tl3Variant;
                          aText: Tl3String;
                          out anOpen, aClose  : AnsiString;
                          var DeleteText      : Boolean): Bool;
      virtual;
      {* - Функция для определения того "красить" ли данным стилем или нет и определения открывающей и закрывающей скобок. }
    procedure PaintLine(ParaVisible  : Bool;
                        ParaStyle    : Long;
                        S            : Tl3String;
                        Obj    : Tl3Variant;
                        First, aLast : Bool);
      virtual;
      {* - Процедура для "покраски" сегментов текста. Для перекрытия в потомках. }
    procedure ValidateLine(aLine : Tl3String; aCodePage : Integer);
      virtual;
      {* - Процедура для проверки корректности строки. Для перекрытия в потомках. }
   procedure ValidateText(aText: Tl3String; aValidateText: Tl3String = nil); virtual;
     {-}
  end;//TevCustomTextPainter

  TevSubString = class(Tk2String)
  private                                         
  {property fields}
    f_Subs  : Tk2SimpleTagList;
    f_Owner : TevCustomTextFormatter;
  public  
    TP      : Il3TagRef;
  protected
  // property methods
    procedure pm_SetSubs(Value: Tk2SimpleTagList);
      {-}
      procedure NotifyInsertion(aPos: Integer;
                                aLen: Integer);
      override;
      {-}
      procedure NotifyDeletion(aPos: Integer;
                                aLen: Integer);
      override;
      {-}
  protected
  // internal methods
    procedure Cleanup;
      override;
      {-}
  public
  // public methods
    procedure Assign(P: TPersistent);
      override;
      {-}
    function  JoinWith(P: Tl3PrimString): Long;
      override;
      {-}
    constructor Create(anOwner : TevCustomTextFormatter);
      {-}
  public
  // public properties
    property Subs: Tk2SimpleTagList
      read f_Subs
      write pm_SetSubs;
      {-}
  end;//TevSubString

  TevSBSString = class(TevSubString);

  TevSoftEnterString = class(TevSubString);

  TevTableColumnAtom = class(Tl3StringList);

  TevTableAtom = class(Tl3ProtoObject)
  private
  {property fields}
    f_Frame         : Tl3String;
     {* - Текст рамки. }
    f_CurrentRow    : TevTableRowAtom;
     {* - Текущая колонка. }
    f_Table         : Tl3Variant;
     {* - Тег таблицы. }
    f_SBS           : Bool;
     {* - Таблица является подписью. }
    f_Generator     : Pointer;
     {* - Указатель на генератор. }
    f_Formatter     : TevCustomTextFormatter;
     {* - Форматтер текста. }
    f_Index         : Long;
     {* - Номер текущей строки. }
    f_OuterCell     : TevTableColumnAtom;
     {* - Охватывающая ячейка. }
    f_PrintFontSize : Integer; 
  private
  //property methods
    function  pm_GetGenerator: Ik2TagGenerator;
      {-}
    procedure pm_SetFrame(Value: Tl3String);
      {-}
    procedure pm_SetCurrentRow(Value: TevTableRowAtom);
      {-}
    procedure pm_SetTable(Value: Tl3Variant);
      {-}
  protected
  //internal methods
    procedure Cleanup;
      override;
      {-}
  public  
  {public methods}
    constructor Create(aFormatter       : TevCustomTextFormatter;
                       const aGenerator : Ik2TagGenerator;
                       aTable     : Tl3Variant);
      reintroduce;
      {-}
    procedure OutFrame(UpDelim : Tl3String = nil;
                       Next    : Tl3String = nil);
      {-}
    procedure OutRow(S: Tl3String);
      {-}
    class function IsCacheable: Bool;
      override;
      {-}
    function CreateString: TevSubString;
      {-}
  public
  {public properties}
    property Frame: Tl3String
      read f_Frame
      write pm_SetFrame;
      {-}
    property CurrentRow: TevTableRowAtom
      read f_CurrentRow
      write pm_SetCurrentRow;
      {-}
    property Table: Tl3Variant
      read f_Table
      write pm_SetTable;
      {-}
    property SBS: Bool
      read f_SBS;
      {-}
    property Generator: Ik2TagGenerator
      read pm_GetGenerator;
      {-}
    property Formatter: TevCustomTextFormatter
      read f_Formatter;
      {-}
    property Index: Long
      read f_Index;
      {-}
  end;{TevTableAtom}

  TevCellBorder = (cbLeft, cbRight, cbUp, cbDown);
  TevCellBorders = packed set of TevCellBorder;

  TevCell = class(Tl3ProtoObject)
  private
  {property fields}
    f_Borders          : TevCellBorders;
      {* - Рамки вокруг ячейки. }
    f_Width            : Long;
      {* - Ширина ячейки в символах. }
    f_WidthInInch      : Long;
      {* - Ширина ячейки в дюймах. }
    f_DeltaX           : Long;
      {* - Отступ для текущей ячейки в символах. }
    f_DeltaXInInch     : Long;
      {* - Отступ для текущей ячейки в дюймах. }
    f_MergeCellIndex   : Long;
      {* - Номер объединяемой ячейки сверху. }
    f_Lines            : TevTableColumnAtom;
      {* - Ячейка в виде списка строк. }
    f_MergeStatus      : TevMergeStatus;
      {* - Тип объединения ячеек. }
    f_VerticalAligment : TevVerticalAligment;
      {* - Тип вертикального выравнивания. }
    f_Gap              : Long;
      {* - Отступ для вертикального выравнивания. }
    f_NeedUpBorder     : Boolean;
      {* - Флаг необходимости рисования верхней границы. }
    f_Text             : Tk2SimpleTagList;
      {* - Теги текста. }
  protected
  {property methods}
    procedure pm_SetLines(Value: TevTableColumnAtom);
      {-}
    procedure Set_Borders(const Value: TevCellBorders);
      {-}
  protected
  {internal methods}
    procedure Cleanup;
      override;
      {-}
    procedure Release;
      override;
      {-}
    procedure SetFrame(Value: Tl3Variant);
      {-}
  public
  {public methods}
    class function IsCacheable: Bool;
      override;
      {-}
    procedure Init(aGenerator  : Tk2TagGenerator;
                   aTable      : TevTableAtom;
                   aCell       : Tl3Variant;
                   aLines      : TevTableColumnAtom);
      {-}
    function IsSmall: Bool;
      {-}   
  public
  {public properties}
    property Borders: TevCellBorders
      read f_Borders
      write Set_Borders;
      {-}
    property Width: Long
      read f_Width
      write f_Width;
      {* - Ширина ячейки в символах. }
    property Lines: TevTableColumnAtom
      read f_Lines
      write pm_SetLines;
      {-}
    property MergeStatus: TevMergeStatus
      read f_MergeStatus
      write f_MergeStatus;
      {-}
    property VerticalAligment: TevVerticalAligment
      read f_VerticalAligment
      write f_VerticalAligment;
      {-}
    property Gap: Long
      read f_Gap
      write f_Gap;
      {-}
    property DeltaX: Long
      read f_DeltaX;
      {* - Смещение ячейки в символах, относительно начала таблицы. }
    property MergeCellIndex: Long
      read f_MergeCellIndex;
      {* - Индекс ячейки, которая находится над данной ячейкой. }
  end;{TevCell}
  PevCell = ^TevCell;

  TevTableRowAtom = class(Tl3ProtoObject)
  private
   f_CurrentCell            : Long;
    {* - Номер текущей ячейки. }
   f_LineCount              : Long;
    {* - Количество строк без учета объединенных ячеек (количество строк для выливки). }
   f_FilledCount            : Long;
    {* - Количество заполненных ячеек при выливке. }
   f_Cells                  : Tl3ProtoObjectRefList;
    {* - Массив ячеек. }
   f_AccumulatedWidthInInch : Long;
    {* - Смещение текущей ячейки в дюймах. }
   f_AccumulatedWidthInChar : Long;
    {* - Смещение текущей ячейки в символах. }
   f_Table                  : TevTableAtom;
    {* - Указатель на таблицу. }
   f_PrevRow                : TevTableRowAtom;
    {* - Указатель на предыдущуюю строку. }
   f_NextRow                : TevTableRowAtom;
    {* - Указатель на следующую строку. }
   f_TechComments           : Tl3StringList;
    {* - Технические комментарии. }
   f_DisableDownFrame       : Boolean;
    {* - Осталась строка, но это не линия. }
   f_AddedEmptyLine         : Integer;
    {* - В строке есть ячейка с верхней рамкой (добавляется еще одна строка). }
   f_NeedUpLine             : Boolean; 
    {* - Признак, что нужно добавить вернюю линию при выливке (только один раз). }
   f_PrevEmpty              : Boolean;
    {* - Признак добавления новой пустой строки. }
  private
  //property methods
   procedure pm_SetPrevRow(Value: TevTableRowAtom);
     {-}
   procedure pm_SetTable(Value: TevTableAtom);
     {-}
  protected
  //internal methods
   procedure Release;
     override;
     {-}
   procedure Cleanup;
     override;
     {-}
   procedure BeforeAddToCache;
     override;
     {-}
   procedure CheckPrevRow;
     {-}
  public
  {public methods}
   constructor Create{(anOwner: TObject = nil)};
     virtual{override};
     {-}
   class function IsCacheable: Bool;
     override;
     {-}  
   function  IterateCellsF(Action: Tl3IteratorAction): Long;
     {-}
   procedure AddCell(aNewCell: TevCell; IsLast: Boolean);
     {-}
   procedure MergeWithPrev;
     {-}
   procedure Write(Index : Long);
     {-}
   function  GetLine(aLine : TevSubString; anOffset: Integer): Bool;
     {-}
   procedure GetFrame(aFrame : TevSubString; Up: Bool; aNextLineEmpty: Boolean);
     {-}
   procedure BreakMerge(aCellIndex: Long);
     {-}
   procedure BreakAllMerge;
     {-}
   procedure Finish;
     {-}
   procedure AddTechComment(aComment: Tl3CustomString; aOffset: Long);
     {-}  
  public
  {public properties}
   property Cells: Tl3ProtoObjectRefList
     read f_Cells;
     {-}
   property AccumulatedWidthInInch: Long
     read f_AccumulatedWidthInInch
     write f_AccumulatedWidthInInch;
     {-}
   property AccumulatedWidthInChar: Long
     read f_AccumulatedWidthInChar
     write f_AccumulatedWidthInChar;
     {-}
   property LineCount: Long
     read f_LineCount;
     {-}
   property FilledCount: Long
     read f_FilledCount;
     {-}
   property CurrentCell: Long
     read f_CurrentCell;
     {-}
   property Table: TevTableAtom
     read f_Table
     write pm_SetTable;
     {-}
   property PrevRow: TevTableRowAtom
     read f_PrevRow
     write pm_SetPrevRow;
     {-}
   property NextRow: TevTableRowAtom
     read f_NextRow;
     {-}
  end;{TevTableRowAtom}

  { история изменений: }
                                 {'0.01'; {- самая первая версия NSRC генератора }
                                 {'01/12/1998'; {-поправлены гипертекстовые
                                                  ссылки с SoftEnter'ом}
                                                {-поправлены моноширинные
                                                  параграфы внутри таблиц}
                                 {'02/12/1998'; {-поправлены пустые моноширинные
                                                  параграфы внутри таблиц}
                                                {-поправлены отступы параграфов
                                                  внутри таблиц}
                                 {'03/12/1998'; {-существенно изменен механизм
                                                  выливки таблиц с использованием
                                                  TevCell}
                                                {-изменен механизм расчета
                                                  ширины таблицы}
                                                {-поправлена выливка отрезков
                                                  выделений с SoftEnter'ом}
                                 {'07/12/1998'; {-поправлена выливка !STYLE
                                                  после пустого параграфа}
                                 {'08/12/1998'; {-поправлена выливка границы
                                                  таблиц при отрицательной левой
                                                  границе или отрицательной красной
                                                  строке}
                                 {'22/12/1998'; {-ширина Preformatted текста
                                                  заменена с 255 на 73}
                                 {'11/01/1999'; {-исправлена выливка выравнивания
                                                  для стиля 'Нормальный (справка)'}
                                 {'09/02/1999'; {-исправлен порядок применения OutEOL
                                                  в соответствии с измененной
                                                  логикой TevCustomPlainTextGenerator'а}
                                 {'09/04/1999'; {-ширина Preformatted текста
                                                  заменена с 73 на CharsInLine}
                                 {'12/04/1999'; {-поправлена выливка !STYLE
                                                  после пустой строки}
                                 {'13/04/1999'; {-изменен механизм выливки Application.Title}
                                 {'21/04/1999'; {-исправлен GPF при выливке Sub'ов
                                                  внутри таблиц}
                                 {'0.10'; {-пора уже хотя бы минорную версию повысить,
                                            а то как то несолидно}
                                 {'30/08/1999'; {-исправлен BUG при выливке
                                                  SBS-параграфов. Заменен разделитель
                                                  SBS с #9 на '|'}
                                 {'02/09/1999'; {-исправлен BUG при выливке
                                                  !STYLE P после начала и конца блоков}
                                                {-добавлена выливка ShortName перед началом
                                                  первого блока}
                                 {'03/09/1999'; {-переработан механизм очистки текущего
                                                  и предыдущего параграфов}
                                 {'17/09/1999'; {-отключена фильтрация тегов в
                                                  TevCustomTextFormatter}
                                 {'28/09/1999'; {-поправлена выливка Sub'ов -
                                                  включена проверка на k2_idDocumentSub}
 {-TevCustomNSRCGenerator - перемещен в модуль evNSRWrt и переименован в TevCustomNSRCWriter}
 { 11/10/1999 - поставлена заплатка в методе TevCustomTextFormatter.AddAtom для
   выливки бинарных объектов }
 { 22/12/1999 - добавлено свойство TevCustomTextFormatter.SBSDelimeter }
 { 27/04/2000 - поправлена ошибка с CodePage рамок }
 { 29/04/2000 - очень сильно переделана выливка рамок таблиц }
 { 08/06/2000 - поправлена ошибка при выливке начала выделения = 1 }
 // 09/12/2000 - поправлена ошибка при выливке рамок объединенных ячеек
 //            - поправлена ошибка выливки ячеек таблиц с параграфами Width <= 0
 // 14/12/2000 - поправлена ошибка при выливке нижней рамки таблицы для CP_OEMLite
 //            - начата выливка вложенных таблиц

implementation

uses
  SysUtils,

  l3Defaults,
  l3CharsEx,
  l3MinMax,
  l3Const,
  l3String,
  l3KeyWrd,
  l3CharSkipper,
  l3StringFormatter,
  l3StringEx,
  l3Math,

  l3Utils,

  l3Units,
  l3Stream,

  k2BaseTypes,
  k2InterfacesEx,
  k2Base,
  k2Tags,
  k2InterfacedTagList,

  nevTools,

  evNSRCConst,
  evTypes,
  evTextParaTools,
  evSegLst,
  evDef,
  evdStyles,
  evAlignBySeparatorUtils,

  TextPara_Const,
  SubLayer_Const,
  SBS_Const,
  Hyperlink_Const,
  ObjectSegment_Const,
  Para_Const,
  Document_Const,
  TableRow_Const,
  TableCell_Const,
  Table_Const,
  Block_Const,
  PageBreak_Const,
  SectionBreak_Const,
  TextSegment_Const,
  Segment_Const,
  SBSCell_Const,
  BitmapPara_Const,

  l3BaseStream,
  //k2TempFileStream,
  k2TagList,

  l3_String
  ;

procedure SetOutCodePage(aString: Tl3CustomString; aCodePage: Integer);
begin
 aString.CodePage := aCodePage;
end;

const
  evNoStart = -100;

// internal classes

// start class TevTableAtom

constructor TevTableAtom.Create(aFormatter       : TevCustomTextFormatter;
                                const aGenerator : Ik2TagGenerator;
                                aTable     : Tl3Variant);
  //reintroduce;
  {-}
begin
 inherited Create;
 Table := aTable;
 f_Formatter := aFormatter;
 f_Generator := Pointer(aGenerator);
 with f_Formatter do 
 begin
  with f_Columns do
   if (Count > 0) then
    f_OuterCell := TevTableColumnAtom(Last)
   else
    f_OuterCell := nil;
  if (PrevTable <> nil) then 
  begin
   f_Index := 1;
   with PrevTable do 
   begin
    if (CurrentRow <> nil) then 
    with CurrentRow do
    begin
     if (FilledCount > 0) then 
     begin
      BreakAllMerge;
      Write(0);
     end;//FilledCount > 0
    end;//if (CurrentRow <> nil) then with CurrentRow
    CurrentRow := nil;
    Self.Frame := Frame;
    Frame := nil;
   end;//with PrevTable
   PrevTable := nil;
  end;//PrevTable <> nil
 end;//with f_Formatter
end;

class function TevTableAtom.IsCacheable: Bool;
  {override;}
  {-}
begin
 Result := True;
end;

procedure TevTableAtom.Cleanup;
  {override;}
  {-}
begin
 f_PrintFontSize := 0;
 f_Generator := nil;
 Table := nil;
 f_Index := 0;
 Frame := nil;
 CurrentRow := nil;
 inherited;
end;

procedure TevTableAtom.OutFrame(UpDelim : Tl3String = nil;
                                Next    : Tl3String = nil);
  {-}
var
 i               : Long;
 l_UpChar        : AnsiChar;
 l_FrameChar     : AnsiChar;
 l_PrevFrameChar : AnsiChar;
 l_SuccFrameChar : AnsiChar;
 l_NextChar      : AnsiChar;
 l_Next          : Il3CharSkipper;
 l_Frame         : Il3CharSkipper;
 l_UpFrame       : Il3CharSkipper;
 l_Index         : Long;
 l_StartIndex    : Long;
begin
 if not Frame.Empty then 
 begin
  if Frame.IsOEMEx then 
  begin
   if Next.Empty then 
   begin
    { - Это последняя строка таблицы. }
    for i := 0 to Pred(Frame.Len) do
     case Frame.St[i] of
      cc_LeftCross  : Frame.St[i] := cc_BottomLeft;
      cc_Cross      : Frame.St[i] := cc_DownCross;
      cc_RightCross : Frame.St[i] := cc_BottomRight;
      cc_TopLeft,
      cc_TopRight,
      cc_UpCross    : Frame.St[i] := cc_HLine;
     end;{case Frame.St[i]}
   end 
   else 
   begin
    { - Это промежуточный разделитель. }
    if (UpDelim <> nil) AND (Next <> nil) then 
    begin
(*     Generator.Msg2Log('Frame:   ' + Frame.AsString);
     Generator.Msg2Log('UpDelim: ' + UpDelim.AsString);
     Generator.Msg2Log('');*)
     if l3IOk(Formatter.QueryInterface(Il3CharSkipper, l_Next)) then
      try
       l_Next.Init(Next);
       if l3IOk(Formatter.QueryInterface(Il3CharSkipper, l_Frame)) then
        try
         l_Frame.Init(Frame);
         l_PrevFrameChar := #0;
         l_SuccFrameChar := l_Frame.GetChar;
         if l3IOk(Formatter.QueryInterface(Il3CharSkipper, l_UpFrame)) then
          try
           l_UpFrame.Init(UpDelim);
           l_UpChar := l_UpFrame.GetChar;
           l_StartIndex := l_UpFrame.Index;
           for i := l_StartIndex to Max(Max(Frame.Len - 1, Next.Len - 1), UpDelim.Len - 1) do
           begin
            l_FrameChar := l_SuccFrameChar;
            l_Index := l_Frame.Index;
            l_SuccFrameChar := l_Frame.GetChar;
            if i <> l_StartIndex then
             l_UpChar := l_UpFrame.GetChar;//UpDelim[i];
            l_NextChar := l_Next.GetChar;
            if (l_FrameChar in cc_Frames) then
            begin
             l_PrevFrameChar := cc_FrameParts[l_FrameChar in cc_DownFrames,
                                              l_NextChar in cc_DownFrames,
                                              l_PrevFrameChar in cc_LeftFrames,
                                              [l_SuccFrameChar, UpDelim[Succ(i)]] * cc_RightFrames <> []][True].S^;
  //                                            [l_SuccFrameChar, UpDelim[Succ(i)]] * cc_LeftFrames <> []][True].S^;
            end
            else
             if l_FrameChar in [cc_HardSpace, cc_Null] then
             begin
              if (l_UpChar = cc_Null) then
               l_PrevFrameChar := cc_HardSpace
              else
               l_PrevFrameChar := l_UpChar;
             end
             else
              l_PrevFrameChar := l_FrameChar;
            if (l_FrameChar <> l_PrevFrameChar) then
             Frame[l_Index] := l_PrevFrameChar;
           end;//for i
          finally
           l_UpFrame := nil;
          end;
        finally
         l_Frame := nil;
        end;//try..finally
      finally
       l_Next := nil;
      end;//try..finally
    end;//UpDelim <> nil..
   end;//Next.Empty
  end;//Frame.IsOEMEx
  OutRow(Frame);
 end;//not Frame.Empty
end;

procedure TevTableAtom.OutRow(S: Tl3String);
  {-}
var
 l_CellString : Tl3String;
 l_Zoom       : Integer;
 l_Index      : Integer;
begin
 with Generator do
 begin
  S.LPad(cc_HardSpace, CP_ANSI, Pixel2Char(Table.IntA[k2_tiLeftIndent]));
  if (f_OuterCell = nil) then 
  begin
   StartChild(k2_typTextPara);
   try
    if (S is TevSubString) then
    begin
     if (TevSubString(S).Subs <> nil) then
     begin
      StartTag(k2_tiSubs);
      try
       StartChild(k2_typSubLayer);
       try
        AddIntegerAtom(k2_tiHandle, Ord(ev_sbtSub));
        for l_Index := 0 to Pred(TevSubString(S).Subs.Count) do
        begin
         StartChild(TevSubString(S).Subs[l_Index].TagType);
         try
          TevSubString(S).Subs[l_Index].WriteTag(Self.Generator);
         finally
          Finish;
         end;//try..finally
        end;//for l_Index
       finally
        Finish;
       end;//try..finally
      finally
       Finish;
      end;//try..finally
      TevSubString(S).Subs.Clear;
     end;//TevSubString(S).Subs <> nil
    end;//S is TevSubString
    if (f_PrintFontSize = 0) then
    begin
     f_PrintFontSize := -1;
     if not SBS then
     begin
      l_Zoom := f_Table.IntA[k2_tiZoom];
      if (l_Zoom > 0) AND (l_Zoom < 100) then
      begin
       f_PrintFontSize := l3MulDiv(12, l_Zoom, 100);
       if (f_PrintFontSize <= 4) then
        f_PrintFontSize := -1;
      end;//(l_Zoom > 0) AND (l_Zoom < 100)
     end;//not SBS
    end;//f_PrintFontSize = 0
    if (f_PrintFontSize > 0) then
     AddIntegerAtom(k2_tiPrintFontSize, f_PrintFontSize);
    AddIntegerAtom(k2_tiStyle, ev_saTxtNormalOEM);
    AddIntegerAtom(k2_tiFirstIndent, 0);
    AddIntegerAtom(k2_tiWidth, Char2Pixel(S.Len));
    S.RTrim;
    //SetOutCodePage(S, Formatter.CodePage);
    Formatter.ValidateLine(S, Formatter.CodePage);
    AddAtom(k2_tiText, S);
   finally
    Finish;
   end;//try..finally
  end//f_OuterCell = nil
  else 
  begin
   l_CellString := S.Clone;
   try
    f_OuterCell.Add(l_CellString);
   finally
    l3Free(l_CellString);
   end;//try..finally
  end;//f_OuterCell = nil
 end;//with Generator
end;

function TevTableAtom.CreateString: TevSubString;
  {-}
begin
 if SBS then
  Result := TevSBSString.Create(Formatter)
 else
  Result := TevSubString.Create(Formatter);
 SetOutCodePage(Result, Formatter.CodePage);
end;

function TevTableAtom.pm_GetGenerator: Ik2TagGenerator;
  {-}
begin
 Result := Ik2TagGenerator(f_Generator);
end;
  
procedure TevTableAtom.pm_SetFrame(Value: Tl3String);
  {-}
begin
 l3Set(f_Frame, Value);
end;

procedure TevTableAtom.pm_SetCurrentRow(Value: TevTableRowAtom);
  {-}
begin
 if (Value <> nil) then 
 begin
  Inc(f_Index);
  Value.Table := Self;
  Value.PrevRow := f_CurrentRow;
  //Value <> nil
 end 
 else 
 begin
  f_Index := 0;
  if (f_CurrentRow <> nil) then
   f_CurrentRow.Table := nil;
 end;//Value <> nil  
 l3Set(f_CurrentRow, Value);
end;

procedure TevTableAtom.pm_SetTable(Value: Tl3Variant);
  {-}
begin
 Value.SetRef(f_Table);
 if (Value = nil) then
  f_SBS := false
 else
  f_SBS := Value.IsKindOf(k2_typSBS);
end;

{ start class TevSubString }

constructor TevSubString.Create(anOwner : TevCustomTextFormatter);
  {-}
begin
 inherited Create;
 //f_Owner := anOwner;
 anOwner.SetRefTo(f_Owner);
end;

procedure TevSubString.Cleanup;
  {override;}
  {-}
begin
 TP := nil;
 Subs := nil;
 //f_Owner := nil;
 FreeAndNil(f_Owner);
 inherited;
end;

procedure TevSubString.pm_SetSubs(Value: Tk2SimpleTagList);
  {-}
begin
 l3Set(f_Subs, Value);
end;

procedure TevSubString.NotifyInsertion(aPos: Integer;
                          aLen: Integer);
  //virtual;
begin
 if (f_Owner <> nil) then
  f_Owner.NotifyInsertion(Self, aPos, aLen);
end;

procedure TevSubString.NotifyDeletion(aPos: Integer;
                          aLen: Integer);
//override;
{-}
begin
 f_Owner.NotifyDeletion(Self, aPos, aLen);
end;

procedure TevSubString.Assign(P: TPersistent);
  {override;}
  {-}
var
 SS     : TevSubString absolute P;
 l_Subs : Tk2SimpleTagList;
begin
 inherited;
 if (P is TevSubString) then 
 begin
  if SS.f_Subs.Empty then
   l3Free(f_Subs)
  else 
  begin
   if (f_Subs = nil) then
   begin
    l_Subs := Tk2SimpleTagList.Create;
    try
     l_Subs.SetRefTo(f_Subs);
    finally
     FreeAndNil(l_Subs);
    end;//try..finally
   end;//f_Subs = nil
   f_Subs.Assign(SS.f_Subs);
  end;//SS.f_Subs.Empty
 end;//P is TevSubString
end;

function TevSubString.JoinWith(P: Tl3PrimString): Long;
  //override;
  {-}
var
 SS     : TevSubString absolute P;
 l_Subs : Tk2SimpleTagList;
begin
 Result := inherited JoinWith(P);
 if (P is TevSubString) then
 begin
  if not SS.f_Subs.Empty then
  begin
   if (f_Subs = nil) then
   begin
    l_Subs := Tk2SimpleTagList.Create;
    try
     l_Subs.SetRefTo(f_Subs);
    finally
     FreeAndNil(l_Subs);
    end;//try..finally
   end;//f_Subs = nil
   f_Subs.JoinWith(SS.f_Subs);
  end;//SS.f_Subs.Empty
 end;//P Is TevSubString
end;

// start class TevCell

class function TevCell.IsCacheable: Bool;
  {override;}
  {-}
begin
 Result := True;
end;

procedure TevCell.Release;
  //override;
  {-}
begin
 Lines := nil;
 l3Free(f_Text);
 inherited;
end;

procedure TevCell.Cleanup;
  {override;}
  {-}
begin
 if (Lines <> nil) then Lines.Count := 0;
 f_Borders := [];
 f_Width := 0;
 l3Free(f_Text);
 inherited;
end;

procedure TevCell.pm_SetLines(Value: TevTableColumnAtom);
  {-}
begin
 l3Set(f_Lines, Value);
end;

procedure TevCell.SetFrame(Value: Tl3Variant);
  {-}
begin
 f_Borders := [];
 if Value.IsValid then
  with Value do begin
   with Attr[k2_tiFrameLeft] do
    if IsValid then
     Include(f_Borders, cbLeft);
   with Attr[k2_tiFrameRight] do
    if IsValid then
     Include(f_Borders, cbRight);
   with Attr[k2_tiFrameUp] do
    if IsValid then
     Include(f_Borders, cbUp);
   with Attr[k2_tiFrameDown] do
    if IsValid then
     Include(f_Borders, cbDown);
  end;
end;

procedure TevCell.Init(aGenerator  : Tk2TagGenerator;
                       aTable      : TevTableAtom;
                       aCell       : Tl3Variant;
                       aLines      : TevTableColumnAtom);
  {-} 
var
 i          : Integer;
 l_Row      : TevTableRowAtom;
 l_Count    : Integer;
 l_PrevRow  : TevTableRowAtom;
 l_PrevCell : TevCell;
begin
 l_Row := aTable.CurrentRow;
 with aCell do 
 begin  
  f_DeltaXInInch := l_Row.AccumulatedWidthInInch;
  f_Width := IntA[k2_tiWidth];
  f_WidthInInch := f_Width;
  
  // Заплатка: при отрисовке/форматировании пытаемся бороться с ошибками 
  // округления, преобразования. Но этого не происходит при выливке. :-( 
  // Здесь и делается попытка это исправить на сколько хватает информации. 
  l_PrevRow := l_Row.PrevRow; 
  l_PrevCell := nil;     
  if (l_PrevRow <> nil) then
  begin
   l_Count := l_PrevRow.f_Cells.Count - 1;
   // Пытаемся найти ячейку с "похожими" координатами и если они не одинаковые,
   // то корректируем отступ для текущей ячейки.
   for i := 0 to l_Count do
   begin
    l_PrevCell := TevCell(l_PrevRow.Cells.Items[i]);
    if (l_PrevCell.f_DeltaXInInch <> f_DeltaXInInch) and 
       (l_PrevCell.f_WidthInInch = f_WidthInInch) then 
     if Abs(l_PrevCell.f_DeltaXInInch - f_DeltaXInInch) < 2 * evEpsilon then 
     begin
      l_Row.AccumulatedWidthInInch := l_PrevCell.f_DeltaXInInch;
      f_DeltaXInInch := l_PrevCell.f_DeltaXInInch;
      Break;
     end//if Abs(l_PrevCell.f_DeltaXInInch - f_DeltaXInInch) < 2 * evEpsilon then 
    else 
     l_PrevCell := nil
    else
     l_PrevCell := nil;
   end;//for i := 0 to l_Count do
  end;//if (l_PrevRow <> nil) then

  l_Row.AccumulatedWidthInInch := l_Row.AccumulatedWidthInInch + Width;
  f_Width := aGenerator.Pixel2Char(l_Row.AccumulatedWidthInInch) - l_Row.AccumulatedWidthInChar;
  if (Width <= 0) then Exit;
  f_DeltaX := l_Row.AccumulatedWidthInChar;
  l_Row.AccumulatedWidthInChar := l_Row.AccumulatedWidthInChar + Width;

  Dec(f_Width);

  SetFrame(Attr[k2_tiFrame]);
  with Attr[k2_tiMergeStatus] do
   if IsValid then
    MergeStatus := TevMergeStatus(AsLong)
   else
    MergeStatus := ev_msNone;
  with Attr[k2_tiVerticalAligment] do
   if IsValid then
    VerticalAligment := TevVerticalAligment(AsLong)
   else
    VerticalAligment := ev_valTop;
  if (MergeStatus = ev_msContinue) then
   Borders := Borders - [cbUp];
 end;//with aCell 
 Lines := aLines;
 if (MergeStatus = ev_msContinue) then
  Lines.Clear;
 l_Row.AddCell(Self, (l_Row.Cells.Count + 1) = aCell.Owner.ChildrenCount);
end;

function TevCell.IsSmall: Bool;
  {-}
begin
 Result := (Width <= 0);
end;

{ start class TevTableRowAtom }

constructor TevTableRowAtom.Create{(anOwner: TObject = nil)};
  {override;}
  {-}
begin
 inherited;
 f_LineCount := 0;
 f_FilledCount := 0;
 f_CurrentCell := -1;
 f_DisableDownFrame := False;
 f_AddedEmptyLine := 0;
 if (f_Cells = nil) then
  f_Cells := Tl3ProtoObjectRefList.Make;
end;

class function TevTableRowAtom.IsCacheable: Bool;
  {override;}
  {-}
begin
 Result := True;
end;

procedure TevTableRowAtom.Release;
  {override;}
  {-}
begin
 l3Free(f_TechComments);
 l3Free(f_Cells);
 inherited;
end;

procedure TevTableRowAtom.Cleanup;
  //override;
  {-}
begin
 f_DisableDownFrame := False;
 PrevRow := nil;
 Table := nil;
 inherited;
end;

procedure TevTableRowAtom.BeforeAddToCache;
  {override;}
  {-}
begin
 f_AccumulatedWidthInChar := 0;
 f_AccumulatedWidthInInch := 0;
 if (f_Cells <> nil) then
  f_Cells.Count := 0;
 if (f_TechComments <> nil) then
  f_TechComments.Count := 0;
 inherited;
end;

procedure TevTableRowAtom.AddTechComment(aComment: Tl3CustomString; aOffset: Long);
  {-}
var
 l_Comment : Tl3KeyWord;
begin
 if not aComment.Empty then 
 begin
  if (f_TechComments = nil) then
   f_TechComments := Tl3StringList.MakeSorted(l3_dupAccept, l3_siByID);
  l_Comment := Tl3KeyWord.Create(aComment, aOffset);
  try
   f_TechComments.Add(l_Comment);
  finally
   l3Free(l_Comment);
  end;//try..finally
 end;//not aComment.Empty
end;

function TevTableRowAtom.IterateCellsF(Action: Tl3IteratorAction): Long;
  {-}
begin
 if (f_Cells = nil) then
  Result := -1
 else
  Result := f_Cells.IterateAllF(Action);
end;

procedure TevTableRowAtom.AddCell(aNewCell: TevCell; IsLast: Boolean);
  {-}
var
 l_PrevRowCell : TevCell;

 procedure CheckCells(var anAllWithFrame, anAllWithoutFrame: Boolean);

  function CheckOneCell(aCell: PevCell; aCellIndex: Long): Bool; far;
  begin//CheckOneLine
   Result := aCellIndex <= f_CurrentCell;  
   if Result and (aCell^.f_DeltaX >= l_PrevRowCell.f_DeltaX) then 
    if (cbUp in aCell^.Borders) then
     anAllWithoutFrame := False
    else 
     anAllWithFrame := False;
  end;//CheckOneLine
  
 begin
   anAllWithoutFrame := True; // Все ячейки с рамкой
   anAllWithFrame := True;    // Все ячейки без рамки
   // Дополнительная проверка нужно ли добавлять строку с рамкой. Здесь 
   // анализируются ячейки под предыдущей "охватывающей".
   IterateCellsF(l3L2IA(@CheckOneCell));
 end;

 function CheckMerged(out aNeedBreak: Boolean): Boolean;
 begin
  Result := (aNewCell.DeltaX + aNewCell.Width <= l_PrevRowCell.DeltaX + l_PrevRowCell.Width);
  aNeedBreak := (l_PrevRowCell.DeltaX < aNewCell.DeltaX + aNewCell.Width);
  if not Result then // <- {$206077980]
  begin
   Result := (aNewCell.MergeStatus = ev_msContinue) and
             (aNewCell.DeltaX = l_PrevRowCell.DeltaX) and
             (l_PrevRowCell.MergeStatus <> ev_msNone);
   if Result then  
   begin
    aNewCell.Width := l_PrevRowCell.Width;
    aNeedBreak := False;
   end; // if Result then
  end; // if not Result then
 end;

 function CheckNeedAddingLine: Boolean;
 var
  l_AllHasNotFrame : Bool;
  l_AllHasFrame    : Bool;  
 begin
  // Заточка для конкретной проблемы, но может возникнуть и в других случаях:
  // В редакторе верхняя строка одна большая и без границ, а ниже идут две
  // ячейки одна с границами, а вторая - без. В итоге при выливке верхняя
  // граница ячейки не сохраняется. 
  if (cbUp in aNewCell.Borders) and not (cbDown in l_PrevRowCell.Borders) and 
   (aNewCell.f_Width <= l_PrevRowCell.f_Width) and 
   (aNewCell.f_DeltaX >= l_PrevRowCell.f_DeltaX) then 
  begin    
   Result := True;
   CheckCells(l_AllHasFrame, l_AllHasNotFrame);
   if not IsLast and l_AllHasFrame then 
    l_AllHasNotFrame := True;
   if not (l_AllHasNotFrame xor l_AllHasFrame) then
   begin
    Inc(f_AddedEmptyLine);
    aNewCell.f_NeedUpBorder := True;
   end;
  end
  else 
   Result := False; 
 end;
 
var
 l_LineCount         : Long;  
 l_NeedBreak         : Bool;
 l_MergeCellIndex    : Long;
 l_NeedCheckUpBorrow : Boolean;
 l_PrevCellWidth     : Integer;
 l_AllHasNotFrame    : Bool;
 l_AllHasFrame       : Bool;
 l_OneCell           : Bool;
begin
 Inc(f_CurrentCell);
 Cells.Add(aNewCell);
 l_PrevRowCell := nil;
 with aNewCell do 
 begin
  l_LineCount := Lines.Count;
  if (MergeStatus = ev_msNone) then
   f_LineCount := Max(f_LineCount, l_LineCount);
  if (PrevRow <> nil) then 
  begin
   // Еще одна заточка: выливка таблицы с заголовком из одной ячейки, после 
   // которого следуют несколько "объединяемых" ячеек того же размера. В этом 
   // случае выливатор просто забывает вылить такую ячейку. Здесь мы пытаемся 
   // отследить такую ситуацию и подправить границы такой ячейки.
   if (MergeStatus = ev_msContinue) and 
    (PrevRow.Cells.Count = 1) and (Cells.Count = 1) and 
    (TevCell(PrevRow.Cells.First).Width = TevCell(Cells.First).Width) then
   begin 
    if PrevRow.Cells.Count > 0 then 
    begin     
     l_PrevRowCell := TevCell(PrevRow.Cells.First);
     if l_PrevRowCell.MergeStatus = ev_msHead then 
     begin
      l_PrevRowCell.Borders := l_PrevRowCell.Borders + [cbDown];
      l_PrevRowCell.MergeStatus := ev_msNone; 
     end;//if l_PrevRowCell.MergeStatus = ev_msHead then 
     f_MergeCellIndex := 0;
    end;//if PrevRow.Cells > 0 then 
   end 
   else 
   begin 
    if (CurrentCell > 0) then
     f_MergeCellIndex := TevCell(Cells.Items[CurrentCell - 1]).f_MergeCellIndex
    else
     f_MergeCellIndex := 0;
    l_NeedBreak := False; 
    while (MergeCellIndex < PrevRow.Cells.Count) do 
    begin
     l_PrevRowCell := TevCell(PrevRow.Cells.Items[MergeCellIndex]);
     if (l_PrevRowCell <> nil) then 
     begin
      if CheckMerged(l_NeedBreak) then
       Break
      else
      begin
       if (PrevRow.Cells.Count = 1) and not f_Table.SBS then 
       begin
        l_PrevCellWidth := l_PrevRowCell.Width + 1; 
        if (DeltaX + Width <= l_PrevCellWidth) then 
         l_NeedCheckUpBorrow := True;
       end;
      end; 
     end;//l_PrevRowCell <> nil
     Inc(f_MergeCellIndex);
    end;//while MergeCellIndex < PrevRow.Cells.Count
    if (MergeStatus = ev_msContinue) then 
    begin
     if (l_LineCount = 1) then 
     begin
      if (Tl3String(Lines.First).RTrimLen = 0) then 
      begin
       Lines.Count := 0;
       l_LineCount := 0;
      end;
     end;//l_LineCount = 1
     if l_NeedBreak and (l_PrevRowCell <> nil) then
      // - Здесь берем рамки от предыдущей ячейки
      Borders := l_PrevRowCell.Borders - [cbUp];
    end 
    else 
    if l_NeedBreak then 
    begin
     if l_PrevRowCell <> nil then
      CheckNeedAddingLine;
     PrevRow.BreakMerge(MergeCellIndex);
     for l_MergeCellIndex := Pred(MergeCellIndex) downto 0 do 
     begin
      l_PrevRowCell := TevCell(PrevRow.Cells.Items[l_MergeCellIndex]);
      if (l_PrevRowCell = nil) then
       Continue
      else 
       if (l_PrevRowCell.DeltaX + l_PrevRowCell.Width < DeltaX) then
        Break
       else
        PrevRow.BreakMerge(l_MergeCellIndex);
     end;//for l_MergeCellIndex
    end;//l_NeedBreak
   end;//if IsLast and (MergeStatus = ev_msContinue) and  
  end;//PrevRow <> nil  
  if (f_AddedEmptyLine > 0) and not aNewCell.f_NeedUpBorder then
  begin
   if l_PrevRowCell <> nil then
    CheckCells(l_AllHasFrame, l_AllHasNotFrame);
   l_OneCell := (PrevRow <> nil) and (PrevRow.Cells.Count = 1); 
   if (l_AllHasNotFrame xor l_AllHasFrame) and not l_OneCell then      
    f_AddedEmptyLine := 0;        
  end;    
  if (l_LineCount > 0) {and (f_AddedEmptyLine < 2)} then 
   Inc(f_FilledCount);
 end;//with aNewCell
end;

function TevTableRowAtom.GetLine(aLine : TevSubString; anOffset: Integer): Bool;
  {-}         
var
 l_PrevCell : TevCell;
 l_Delim    : AnsiChar;
 l_OEM      : Bool;

 function GetCellLine(aCell: PevCell; aCellIndex: Long): Bool; far;
 var
  l_CellLine : Tl3String;
 begin//GetCellLine
  Result := True;
  with aCell^ do 
  begin   
   with aLine do 
   begin
    if (cbLeft in Borders) or
       ((l_PrevCell <> nil) and (cbRight in l_PrevCell.Borders)) then
     Append(sp_VLine[l_OEM])
    else 
    begin
     if (aCellIndex = 0) then
      Append(cc_HardSpace)
     else
      Append(l_Delim);
    end;//cbLeft in Borders
    if (Gap > 0) then 
    begin
     Append(cc_HardSpace, Width);
     Dec(f_Gap);
    end //if (Gap > 0) then
    else 
     if (Lines.Count > 0) then 
     begin
      l_CellLine := Tl3String(Lines.First);
      l_CellLine.RPad2(Width, cc_HardSpace);
      JoinWith(l_CellLine);
      Lines.Delete(0);
      if (Lines.Count <= 0) then 
       Dec(f_FilledCount);       
     end //if (Lines.Count > 0) then
     else
      Append(cc_HardSpace, Width);
   end;//with aLine
  end;//with aCell^
  l_PrevCell := aCell^;
 end;//GetCellLine

var
 l_LineCount : Long;
 l_HasFramed : Boolean;
 l_LineCnt   : Long;

 function CheckOneLine(aCell: PevCell; aCellIndex: Long): Bool; far;
 begin//CheckOneLine
  Result := True;
  with aCell^ do 
  begin
   if (MergeStatus <> ev_msNone) then
    l_LineCount := Max(l_LineCount, Lines.Count)
   else
    if (cbDown in Borders) then
    begin
     l_HasFramed := True;
     l_LineCnt := Lines.Count;
    end; 
  end;//with aCell^
 end;//CheckOneLine

begin
 Result := (f_LineCount > 0);
 if not Result and (FilledCount > 0) then 
 begin
  l_HasFramed := False;
  l_LineCount := 0;
  l_LineCnt := 0;
  IterateCellsF(l3L2IA(@CheckOneLine));
  if (l_LineCount = 1) and (l_LineCnt <> 0) then
  begin
   if l_HasFramed then
   begin
    f_LineCount := 1;
    Result := True;
   end//l_HasFramed
   else
    f_DisableDownFrame := True;
  end;//l_LineCount = 1
 end;//not Result..
 if Result then 
 begin
  with Table, Formatter do 
  begin
   if SBS then
    l_Delim := SBSDelimeter
   else
    l_Delim := cc_HardSpace;
   l_OEM := l3IsOEMEx(CodePage);
  end;//Table..
  if (aLine.Subs <> nil) then 
   aLine.Subs.Clear;
  aLine.Clear;
  l_PrevCell := nil;
  IterateCellsF(l3L2IA(@GetCellLine));
  if (l_PrevCell <> nil) then 
  begin
   if (cbRight in l_PrevCell.Borders) then
    aLine.Append(sp_VLine[l_OEM])
   else
    aLine.Append(cc_HardSpace);
  end;//l_PrevCell <> nil
  Dec(f_LineCount);
 end;//Result
end;

procedure TevTableRowAtom.GetFrame(aFrame : TevSubString; Up: Bool; aNextLineEmpty: Boolean);
  {-}
var
 l_OEM        : Bool;
 l_PrevCell   : TevCell;
 l_NextRowStr : TevSubString;

 function FramePart(HasUp, HasDown, HasLeft, HasRight: Bool): Tl3PCharLenPrim;
 begin//FramePart
  Result := cc_FrameParts[HasUp, HasDown, HasLeft, HasRight][l_OEM];
  if (l_PrevCell <> nil) AND not aNextLineEmpty AND l_PrevCell.IsSmall  AND
     (Result.S^ = sp_HLine[l_OEM].S^) then
   Result := sp_HardSpace[l_OEM];
 end;//FramePart                                                

 function GetUpCellFrame(aCell: PevCell; aCellIndex: Long): Bool; far;
 begin//GetUpCellFrame
  Result := True;
  with aCell^ do 
  begin
   aFrame.Append(FramePart(False,
                           (cbLeft in Borders) OR ((l_PrevCell <> nil) AND (cbRight in l_PrevCell.Borders)),
                           ((l_PrevCell <> nil) AND (cbUp in l_PrevCell.Borders)),
                           cbUp in Borders));
(*   aFrame.Append(cc_FrameParts[false,
                               (cbLeft in Borders) OR ((l_PrevCell <> nil) AND (cbRight in l_PrevCell.Borders)),
                               ((l_PrevCell <> nil) AND (cbUp in l_PrevCell.Borders)),
                               cbUp in Borders][l_OEM]);*)
   if (cbUp in Borders) then
    aFrame.Append(sp_HLine[l_OEM], Width)
   else
    aFrame.Append(cc_HardSpace, Width);
   if Lines.Count > 0 then
    l_NextRowStr.JoinWith(Tl3String(Lines.First));
  end;//with aCell^
  if (l_PrevCell <> nil) then
   with l_PrevCell do
    Borders := Borders - [cbUp];
  l_PrevCell := aCell^;
 end;//GetUpCellFrame

var
 l_HasHorz     : Bool;
 l_PrevHasHorz : Bool;

 function GetDownCellFrame(aCell: PevCell; aCellIndex: Long): Bool; far;
 var
  l_HasVert : Bool;
 begin//GetDownCellFrame
  Result := True;
  with aCell^ do 
  begin
   l_HasHorz := ((MergeStatus = ev_msNone) {OR (Lines.Count <= 0)}) AND (cbDown in Borders);
   l_HasVert := (cbLeft in Borders) OR ((l_PrevCell <> nil) AND (cbRight in l_PrevCell.Borders));
   aFrame.Append(FramePart(l_HasVert,
                           l_HasVert,
                           l_PrevHasHorz,
                           l_HasHorz));
(*   aFrame.Append(cc_FrameParts[l_HasVert,
                               l_HasVert,
                               l_PrevHasHorz,
                               l_HasHorz][l_OEM]);*)                               
   if l_HasHorz then
    aFrame.Append(sp_HLine[l_OEM], Width)
   else 
    if (Lines.Count > 0) then 
    begin
     aFrame.JoinWith(Lines.First);
     Lines.Delete(0);
     if (Lines.Count <= 0) then Dec(f_FilledCount);
    end 
    else
     aFrame.Append(cc_HardSpace, Width);
  end;//with aCell^
  l_PrevCell := aCell^;
  l_PrevHasHorz := l_HasHorz;
 end;//GetDownCellFrame

begin
 l_NextRowStr := Table.CreateString;
 try
  if (aFrame.Subs <> nil) then
   aFrame.Subs.Clear;
  aFrame.Clear;
  with Table.Formatter do
   l_OEM := l3IsOEMEx(CodePage);
  l_PrevCell := nil;
  if Up then 
  begin
   IterateCellsF(l3L2IA(@GetUpCellFrame));
   if (l_PrevCell <> nil) then 
   begin
    with l_PrevCell do 
    begin
     aFrame.Append(cc_FrameParts[False,
                                 cbRight in Borders,
                                 cbUp in Borders,
                                 False][l_OEM]);
     Borders := Borders - [cbUp];
    end;//with l_PrevCell
   end;//l_PrevCell <> nil
  end 
  else 
  begin
   l_HasHorz := True;
   l_PrevHasHorz := False;
   IterateCellsF(l3L2IA(@GetDownCellFrame));
   if (l_PrevCell <> nil) then 
   begin
    with l_PrevCell do
     aFrame.Append(cc_FrameParts[cbRight in Borders,
                                 cbRight in Borders,
                                 l_PrevHasHorz,
                                 False][l_OEM]);
   end;//l_PrevCell <> nil
  end;//Up
  if f_PrevEmpty or Table.SBS or ((Table.Index <= 2) and Up) then
   aFrame.RTrim;
  if Up and (aFrame.RTrimLen > 0) then
   Table.Formatter.ValidateText(aFrame, l_NextRowStr);
 finally
  l3Free(l_NextRowStr);
 end;
end;

procedure TevTableRowAtom.BreakMerge(aCellIndex: Long);
  {-}
var
 l_Cell : TevCell;
begin
 if (aCellIndex < Cells.Count) then 
 begin
  l_Cell := TevCell(Cells.Items[aCellIndex]);
  if (l_Cell <> nil) then 
  begin
   with l_Cell do 
   begin
    if (MergeStatus <> ev_msNone) then 
    begin
     f_LineCount := Max(f_LineCount, Lines.Count);
     MergeStatus := ev_msNone;
    end;//MergeStatus <> ev_msNone
   end;//with l_Cell
  end;//l_Cell <> nil
 end;//aCellIndex < Cells.Count
end;

procedure TevTableRowAtom.BreakAllMerge;
  {-}
var
 i : Long;
begin
 for i := 0 to Cells.Count do BreakMerge(i);
end;

procedure TevTableRowAtom.Finish;
  {-}

 function CheckCellGap(aCell: PevCell; aCellIndex: Long): Bool; far;
 begin//CheckCellGap
  Result := True;
  with aCell^ do 
  begin
   if (MergeStatus = ev_msNone) then 
   begin
    case VerticalAligment of
     ev_valCenter : Gap := (LineCount - Lines.Count) div 2;
     ev_valBottom : Gap := LineCount - Lines.Count;
    end;//case VerticalAligment
    //MergeStatus = ev_msNone
   end 
   else
    Gap := 0;
  end;//with aCell^
 end;//CheckCellGap

begin
 if (PrevRow <> nil) then 
 begin
  CheckPrevRow;
  PrevRow.Write(1);
  MergeWithPrev;
 end;//PrevRow <> nil
 IterateCellsF(l3L2IA(@CheckCellGap));
end;

procedure TevTableRowAtom.MergeWithPrev;
  {-}
  
 function _AddCell(aCell: PevCell; aCellIndex: Long): Bool; far;
 var
  l_Cell : TevCell;
 begin//_AddCell
  Result := True;
  with aCell^ do 
  begin
   if (MergeStatus = ev_msContinue) then 
   begin
    try
     l_Cell := TevCell(PrevRow.Cells.Items[MergeCellIndex]);
    except
     on EListError do 
     begin
      if Lines.Empty then
       Table.Formatter.
        Error('Проблемы с ячейками, объединенными по вертикали.', false)
      else
       Table.Formatter.
        Error(Format('Проблемы с ячейками, объединенными по вертикали (%s).',
                [Tl3String(Lines.First).AsString]), false);
      Exit;
     end;//EListError
    end;//try..except
    if not l_Cell.Lines.Empty then 
    begin                                
     if (Lines.Count > 0) then         
      l_Cell.Lines.JoinWith(Lines)
     else
       Inc(f_FilledCount);
     Lines := l_Cell.Lines; // - Запоминаем строки в новой ячейке
     (* Заплатка убрана, т.к. приводила к выливке пустой строки. 
        Эффекта "залезания" на рамку повторить не удалось и, скорее всего, его не будет, 
        т.к. f_FilledCount > 0 и сработает добавление пустой строки в GetLine. 
        А конкретные случаи повторения лучше лечить в другом месте. 
     if (Lines.Count = 2) AND (Self.f_LineCount = 1) then
      Self.f_LineCount := 2; // - Предотвращаем залезание строки на рамку*)
     l_Cell.Lines := nil; // - Убиваем строки у предыдущей ячейки
    end;//not l_Cell.Lines.Empty
   end;//MergeStatus = ev_msContinue
  end;//with aCell^
 end;//_AddCell

begin
 if (PrevRow <> nil) then 
 begin
  if (PrevRow.FilledCount > 0) then
   IterateCellsF(l3L2IA(@_AddCell));
  if not PrevRow.f_TechComments.Empty then 
  begin
   if (f_TechComments <> nil) then
    PrevRow.f_TechComments.JoinWith(f_TechComments);
   l3Set(f_TechComments, PrevRow.f_TechComments);
   l3Free(PrevRow.f_TechComments);
  end;//not PrevRow.f_TechComments.Empty
  PrevRow := nil;
 end;//PrevRow <> nil
end;

procedure TevTableRowAtom.Write(Index : Long);
  {-}

 procedure __OutComment(aComment: Tl3CustomString);
 begin
  with Table do 
  begin
   SetOutCodePage(aComment, Formatter.CodePage);
   with Generator do 
   begin
    StartChild(k2_typTextPara);
    try
     AddIntegerAtom(k2_tiStyle, ev_saTechComment);
     AddStringAtom(k2_tiText, aComment.AsWStr);
    finally
     Finish;
    end;//try..finally
   end;//with Generator
  end;//with Table
 end;

var
 l_Offset : Long;

 procedure CorrectComments;
 var
  l_Index : Long;
 begin
  if (f_TechComments <> nil) then 
  begin
   with f_TechComments do
    for l_Index := 0 to Hi do
     with Tl3KeyWord(Items[l_Index]) do
      StringID := StringID - l_Offset;
  end;//f_TechComments
 end;

 procedure CheckOutComment;
 var
  l_Comment : Tl3KeyWord;
 begin
  if (f_TechComments <> nil) then 
  begin
   with f_TechComments do
    while not Empty do 
    begin
     l_Comment := Tl3KeyWord(First);
     if (l_Comment.StringID <= l_Offset) then 
     begin
      __OutComment(l_Comment);
      Delete(0);
     end 
     else
      Break;
    end;//while not Empty
  end;//f_TechComments
 end;

var
 l_OutFrame : Bool;
 l_String   : TevSubString;
 l_UpDelim  : TevSubString;
begin
 f_PrevEmpty := False;
 //Выливка для вложенной таблицы.
 if (PrevRow <> nil) then
 begin 
  PrevRow.Write(Succ(Index));
  MergeWithPrev;
 end;//PrevRow <> nil
 if ((Table.Index - Index) = 1) then
 begin
  l_UpDelim := Table.CreateString;
  try
   GetFrame(l_UpDelim, True, False);
   if not l_UpDelim.Empty then Table.OutRow(l_UpDelim);
  finally
   l3Free(l_UpDelim);
  end;//try..finally
 end;//Table.Index = 1
 l_OutFrame := False;
 l_String := Table.CreateString;
 try
  l_Offset := 0;
  while GetLine(l_String, l_Offset) do 
  begin
   l_OutFrame := True;
   Table.Formatter.ValidateText(l_String);
   if not Table.Frame.Empty then
   begin
    l_UpDelim := Table.CreateString;
    try
     GetFrame(l_UpDelim, True, l_String.RTrimLen = 0);
     Table.OutFrame(l_UpDelim, l_String);
     f_NeedUpLine := False;
    finally
     l3Free(l_UpDelim);
    end;//try..finally
    Table.Frame := nil;
    CheckOutComment;
   end{not Table.Frame.Empty}
   else
    if f_NeedUpLine then
    begin
     l_UpDelim := Table.CreateString;
     try
      GetFrame(l_UpDelim, True, False);
      if not l_UpDelim.Empty then
       Table.OutRow(l_UpDelim);
      f_NeedUpLine := False;
     finally
      l3Free(l_UpDelim);
     end;//try..finally
    end;
   if Table.SBS AND (l_String[0] = cc_HardSpace) then
    l_String.Delete(0, 1);
   Table.OutRow(l_String);
   Inc(l_Offset);
   CheckOutComment;
  end;//while GetLine(l_String)
  if l_OutFrame AND not f_DisableDownFrame then
  begin
   f_PrevEmpty := l_String.RTrim.Empty;
   l_UpDelim := Table.CreateString;
   try
    GetFrame(l_UpDelim, False, False);
    if l_UpDelim.RTrimLen > 0 then
     Table.Formatter.ValidateText(l_UpDelim, l_String);
    Table.Frame := l_UpDelim;
   finally
    l3Free(l_UpDelim);
   end;//try..finally
   Inc(l_Offset);
  end;//l_OutFrame
  CheckOutComment;
  CorrectComments;
 finally
  l3Free(l_String);
 end;//try..finally
end;

procedure TevTableRowAtom.pm_SetPrevRow(Value: TevTableRowAtom);
  {-}
begin
 if (f_PrevRow <> nil) then
  f_PrevRow.f_NextRow := Self;
 if (Value = nil) OR (Value.FilledCount < 0) then
  l3Free(f_PrevRow)
 else
  l3Set(f_PrevRow, Value);
 if (f_PrevRow <> nil) then
  f_PrevRow.f_NextRow := Self;
end;

procedure TevTableRowAtom.pm_SetTable(Value: TevTableAtom);
  {-}
begin
 f_Table := Value;
end;

procedure TevTableRowAtom.CheckPrevRow;
var
 i, k        : Integer;
 l_CountPrev : Integer;
 l_Count     : Integer; 
 l_CellPrev  : TevCell;
 l_Cell      : TevCell;
 l_Out       : Boolean;
 l_Start     : Boolean;
 l_PrevWidth : Integer;
begin
 // Чаво здесь делается: в некоторых случаях нижняя граница верхних ячеек 
 // не задана, но у нижних ячеек находящихся ниже граница присутсвует. 
 // В этом случае такая граница не выливается.
 // Здесь как раз и анализируется такая ситуация. 
 f_AddedEmptyLine := 0;
 l_CountPrev := PrevRow.Cells.Count - 1;
 for i := 0 to l_CountPrev do
 begin
  l_CellPrev := TevCell(PrevRow.Cells.Items[i]);
  l_Count := Cells.Count - 1;
  l_PrevWidth := l_CellPrev.Width;
  //if i = 0 then //Для первой ячейки в строке уменьшают ширину на один символ.
  // Inc(l_PrevWidth);
  for k := 0 to l_Count do
  begin
   l_Cell := TevCell(Cells.Items[k]);
   l_Start := (l_CellPrev.DeltaX <= l_Cell.DeltaX) and
     ((l_CellPrev.DeltaX + l_PrevWidth) >= (l_Cell.DeltaX + l_Cell.Width));
   if l_Start then
   begin
    if not (cbDown in l_CellPrev.f_Borders) and (cbUp in l_Cell.Borders) then
    begin
     Inc(f_AddedEmptyLine);
     l_Cell.f_NeedUpBorder := True;
     f_NeedUpLine := True;
    end; 
   end;
  end; 
 end;
end;
  
{ start class TevCustomTextFormatter }

constructor TevCustomTextFormatter.Create(AOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 f_Tables := Tl3ProtoObjectRefList.Make;
 f_Columns := Tl3ProtoPersistentRefList.Make;
 f_TextParaLines := Tl3StringList.Make;
 f_CodePage := CP_OEM;
 f_FormatOrdinalParas := True;
 f_SBSDelimeter := '|';
end;

function TevCustomTextFormatter.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(Il3CharSkipper) then 
 begin
  Result := Tl3HResult_C(l3QueryInterface(Generator, IID, Obj));
  if Result.Fail then 
  begin
   Result.SetOk;
   Pointer(Obj) := Pointer(Il3CharSkipper(Tl3CharSkipper.Create));
  end;//l3IFail(Result)
 end 
 else
  if IID.EQ(Il3StringFormatter) then 
  begin
   Result := Tl3HResult_C(l3QueryInterface(Generator, IID, Obj));
   if Result.Fail then 
   begin
    Result.SetOk;
    Pointer(Obj) := Pointer(Il3StringFormatter(Tl3StringFormatted.Create));
   end;//l3IFail(Result)
  end
  else
   Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TevCustomTextFormatter.Cleanup;
  {override;}
  {-}
begin
 try
  PrevTable := nil;
 finally
  // - finally тут потому, что ВНУТРИ PrevTable := nil летит EWriteError
  // http://mdp.garant.ru/pages/viewpage.action?pageId=495125442
  l3Free(f_CellsTag);
  l3Free(f_TextParaLines);
  l3Free(f_Columns);
  l3Free(f_Tables);
  inherited;
 end;//try..finally 
end;

procedure TevCustomTextFormatter.OpenStream;
  {override;}
  {-}
begin
 {$IfDef nsTest}
 Inc(l3BaseStream.g_IStreamCopyTo_Guard);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=288010443
 {$EndIf nsTest}
 inherited;
 if Generator <> nil then
  Generator.Start;
end;

procedure TevCustomTextFormatter.CloseStream(NeedUndo: Bool);
  {override;}
  {-}
begin
 Generator.Finish(NeedUndo);
 f_TextParaLines.Clear;
 inherited;
 {$IfDef nsTest}
 Dec(l3BaseStream.g_IStreamCopyTo_Guard);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=288010443
 {$EndIf nsTest}
end;

procedure TevCustomTextFormatter.DoStartTable(T: Tl3Variant);
  {-}
var
 TA : TevTableAtom;
begin
 TA := TevTableAtom.Create(Self, Generator, T);
 try
  f_Tables.Add(TA);
 finally
  l3Free(TA);
 end;{try..finally}
end;

procedure TevCustomTextFormatter.DoFinishTable(const T: Tk2StackAtom);
  {-}
begin
 with f_Tables do 
 begin
  PrevTable := TevTableAtom(Last);
  DeleteLast;
 end;//with f_Tables
end;

procedure TevCustomTextFormatter.DoFinishTableRow(const TR: Tk2StackAtom);
  {-}
begin
 TevTableAtom(f_Tables.Last).CurrentRow.Finish;
end;

procedure TevCustomTextFormatter.StartRow;
  {-}
var
 l_Row : TevTableRowAtom;
begin
 l_Row := TevTableRowAtom.Create;
 try
  TevTableAtom(f_Tables.Last).CurrentRow := l_Row;
 finally
  l3Free(l_Row);
 end;{try..finally}
end;

procedure TevCustomTextFormatter.StartCell;
  {-}
var
 TCA : TevTableColumnAtom;
begin
 TCA := TevTableColumnAtom.Make;
 try
  f_Columns.Add(TCA);
 finally
  l3Free(TCA);
 end;{try..finally}
end;

procedure TevCustomTextFormatter.DoFinishTableColumn(const TC: Tk2StackAtom);
  {-}
var
 l_Cell : TevCell;
begin
 l_Cell := TevCell.Create;
 try
   l_Cell.Init(Self, TevTableAtom(f_Tables.Last), TC.Box, TevTableColumnAtom(f_Columns.Last));
   if l_Cell.f_Text = nil then
    l_Cell.f_Text := Tk2SimpleTagList.Make;
   if f_CellsTag <> nil then
   begin
    l_Cell.f_Text.Assign(f_CellsTag);
    f_CellsTag.Clear;
   end; // if f_CellsTag <> nil then
   f_Columns.Delete(f_Columns.Hi);
 finally
  l3Free(l_Cell);
 end;{try..finally}
end;

procedure TevCustomTextFormatter.ValidateSegments(aPara : Tl3Variant;
                                                  const aText : Tl3PCharLen);
  {* - Проверяет список сегментов и склеивает соседние. }
  
 function CheckLayer(aLayer: Tl3Variant; anIndex: Long): Bool;

  function CheckSegment(aSegment: Tl3Variant; anIndex: Long): Bool;
  begin//CheckSegment
   Result := True;
   with aSegment do
    if HasSubAtom(k2_tiFinish) AND
       (IntA[k2_tiFinish] > aText.SLen) then
    begin
     IntA[k2_tiFinish] := aText.SLen;
(*     if HasSubAtom(k2_tiStart) AND
        (IntA[k2_tiStart] > aText.SLen) then
      IntA[k2_tiStart] := aText.SLen;*)
    end; // if HasSubAtom(k2_tiFinish) AND ...
  end;//CheckSegment

 begin//CheckLayer
  Result := True;
  aLayer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckSegment));
 end;//CheckLayer

 type
  TevSegmentBoundary = record
   rStart     : Integer;
   rFinish    : Integer;
   rLayer     : Tl3variant;
   rIndex     : Integer;
   rHyperLink : Boolean;
  end;
 var
  l_Boundaries  : array of TevSegmentBoundary;
  l_BoundArrayL : Integer;

 function CheckNeigbours(aLayer: Tl3Variant; anIndex: Long): Bool;
 var
  l_Index   : Long;
  l_PrevSeg : Tl3Variant;
  l_Start   : Long;
  l_Finish  : Long;

  procedure CheckSegment(aHyperLink: Boolean);
  var
   i       : Integer;
   l_Found : Boolean;
  begin
   l_Found := False;
   for i := 0 to l_BoundArrayL - 1 do
    with l_Boundaries[i] do
     if (rStart = l_Start) and (rFinish = l_Finish) then
     begin
      if aHyperLink and not rHyperLink then
       rLayer.DeleteChild(rIndex)
      else
       if rHyperLink and not aHyperLink then
        aLayer.DeleteChild(l_Index);
      l_Found := True;
      rStart := -1;
      rFinish := -1;
      Break;
     end; // if rHyperLink and (rStart = l_Start) and (rFinish = l_Finish) then
   if aHyperLink or not l_Found then
   begin
    Inc(l_BoundArrayL);
    SetLength(l_Boundaries, l_BoundArrayL);
    with l_Boundaries[l_BoundArrayL - 1] do
    begin
     rStart := l_Start;
     rFinish := l_Finish;
     rHyperLink := aHyperLink;
     if aHyperLink then
     begin
      rLayer := nil;
      rIndex := -1;
     end
     else
     begin
      rLayer := aLayer;
      rIndex := l_Index;
     end;
    end; // with l_Boundaries[l_BoundArrayL] do
   end; // if not l_Found then
  end;

 var
  l_Seg : Tl3Variant;
 begin//CheckNeigbours
  Result := True;
  with aLayer do
  begin
   l_PrevSeg := k2NullTag;
   l_Finish := 0;
   l_Index := 0;
   while (l_Index < ChildrenCount) do
   begin
    l_Seg := Child[l_Index];
    if l_PrevSeg.IsValid AND
       not l_Seg.IsKindOf(k2_typHyperlink) AND
       // - Гиперссылки объединять не надо
       not l_PrevSeg.IsKindOf(k2_typHyperlink) then
    begin
     l_Start := l_Seg.IntA[k2_tiStart];
     if (l_Start = Succ(l_Finish)) AND
        (l_Seg.Attr[k2_tiStyle].IsSame(l_PrevSeg.Attr[k2_tiStyle])) and
        not l_Seg.IsKindOf(k2_typObjectSegment) then
     begin
      // - Конец совпадает с началом надо объединить сегменты
       l_Finish := l_Seg.IntA[k2_tiFinish];
       aLayer.DeleteChild(l_Index);
       l_PrevSeg.IntA[k2_tiFinish] := l_Finish;
       Continue;
     end;//l_Start = Succ(l_PrevFinish
    end;//l_PrevSeg.IsValid
    l_Finish := l_Seg.IntA[k2_tiFinish];
    if (l_Finish <= 0) and (l_Seg.IntA[k2_tiStart] <= 0) then
     l_Finish := 0
    else
    if (l_Finish < l_Seg.IntA[k2_tiStart]) then
    begin
     aLayer.DeleteChild(l_Index);
     Continue;
    end
    else
    if (l_Finish = l_Seg.IntA[k2_tiStart]) and (aText.S[l_Finish - 1] = cc_HardSpace) then
    begin
     aLayer.DeleteChild(l_Index);
     Continue;
    end // if (l_Finish = l_Seg.IntA[k2_tiStart]) and (aText.S[l_Finish] = ' ') then
    else
     l_PrevSeg := l_Seg;
    if l_PrevSeg.IsKindOf(k2_typHyperlink) then
     CheckSegment(True)
    else
     if (l_PrevSeg.IntA[k2_tiStyle] = ev_saHyperLinkCont) then
      CheckSegment(False);
    Inc(l_Index);
   end;//while (l_Index < ChildrenCount)
  end;//with aLayer
 end;//CheckNeigbours                             

 function lp_CheckStyle(aLayer: Tl3Variant; anIndex: Long): Boolean;
 var
  l_Seg      : Tl3Variant;
  l_Index    : Integer;
  l_ParaStyle: Integer;
 begin
  Result := True;
  if aPara.Attr[k2_tiStyle].IsValid then
  begin
   l_ParaStyle := aPara.IntA[k2_tiStyle];
   l_Index := 0;
   with aLayer do
    while (l_Index < ChildrenCount) do
    begin
     l_Seg := Child[l_Index];
     if l_Seg.Attr[k2_tiStyle].IsValid and
        not l_Seg.IsKindOf(k2_typHyperlink) and not l_Seg.IsKindOf(k2_typObjectSegment) and
        (l_Seg.BoolA[k2_tiVisible] = aPara.BoolA[k2_tiVisible]) then
      if not l_Seg.HasSubAtom(k2_tiFont) then
       if IsStyleEqual(l_ParaStyle, l_Seg.IntA[k2_tiStyle]) then
       begin
        aLayer.DeleteChild(l_Index);
        Continue;
       end; // if IsStyleEqual(l_ParaStyle, l_Seg.IntA[k2_tiStyle]) then
     Inc(l_Index);
    end; // while (l_Index < ChildrenCount) do
  end; // if aPara.Attr[k2_tiStyle].IsValid then
 end;

begin
 with aPara do
 begin
  Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckLayer));
  // - Исправляем сегменты с неправильными концами
  l_BoundArrayL := 0;
  Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckNeigbours));
  // - Объединяем соседние сегменты
  SetLength(l_Boundaries, 0);
  Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckStyle));
 end;//with aPara
end;

procedure TevCustomTextFormatter.FormatLines(TP    : Tl3Variant;
                                             Strings     : Tl3StringList;
                                             Subs        : Tk2SimpleTagList;
                                             InTable     : Bool;
                                             ParentWidth : Long);
  {* - Нарезает параграф на строки. }
  
var
 l_NewSoftEnter : Bool;

 function OneLineSelection: Bool;
 begin
  Result := InTable OR l_NewSoftEnter;
 end;

 procedure ShiftSegments(aShiftCount: Long; aDeltaWhiteSpace : Integer);

  function ShiftSegmentsLayer(Layer: Tl3Variant; Index: Long): Bool; far;

   function ShiftSegment(Segment: Tl3Variant; Index: Long): Bool; far;

   var
    l_Pos : Long;

    procedure HL2HLCont;
    begin//HL2HLCont
     with Segment do
     begin
      if (aShiftCount > IntA[k2_tiFinish]){ OR
         (l_Pos = aShiftCount)} then
       IntW[k2_tiStart, Context] := evNoStart
      else
       IntW[k2_tiStart, Context] := 1;
      if IsKindOf(k2_typHyperlink) then
      begin
       AttrW[k2_tiHandle, Context] := nil;
       IntW[k2_tiStyle, Context] := ev_saHyperLinkCont;
       AttrW[k2_tiChildren, Context] := nil;
      end;//..k2_idHyperlink..
     end;//with Segment
    end;//HL2HLCont

   begin//ShiftSegment
    l_Pos := Segment.IntA[k2_tiStart];
    if (l_Pos <> evNoStart) then
    begin
     if (aShiftCount > l_Pos) OR
        ((aDeltaWhiteSpace = 0) AND not OneLineSelection AND (aShiftCount = l_Pos))
        // - это условие работает, когда ссылка или другое оформление режется принудительно,
        //   а не по пробелу.
        //   И мы не строим псевдографическую таблицу.
        //   И нет перевода строки.
        // Лечили три проблемы:
        //  http://mdp.garant.ru/pages/viewpage.action?pageId=177964278
        //  http://mdp.garant.ru/pages/viewpage.action?pageId=177963362
        //  http://mdp.garant.ru/pages/viewpage.action?pageId=177964264
        then
     begin
      if OneLineSelection then
       HL2HLCont
      else
       Segment.IntW[k2_tiStart, Context] := evNoStart;
     end//aShiftCount > l_Pos
     else
     // Закомментировано, т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=177963362&focusedCommentId=177963418&#comment-177963418
(*       if (aShiftCount = l_Pos) and not Segment.IsKindOf([k2_typHyperlink, k2_typObjectSegment]) and OneLineSelection then
       HL2HLCont
      else
       if (l_Pos = aShiftCount) and Segment.IsKindOf([k2_typHyperlink]) then
        Segment.IntW[k2_tiStart, Context] := 1
       else*)
       Segment.IntW[k2_tiStart, Context] := l_Pos - aShiftCount;
    end//l_Pos <> evNoStart
    else
    begin
     if Segment.HasSubAtom(k2_tiFinish) AND OneLineSelection then
      HL2HLCont;
    end;//l_Pos <> evNoStart
    if Segment.HasSubAtom(k2_tiFinish) then
    begin
     l_Pos := Segment.IntA[k2_tiFinish];
     if (aShiftCount > l_Pos) then
      Segment.AttrW[k2_tiFinish, Context] := nil
     else
      Segment.IntW[k2_tiFinish, Context] := l_Pos - aShiftCount;
    end;//Segment.HasSubAtom(k2_tiFinish)
    Result := True;
   end;//ShiftSegment

  begin//ShiftSegmentsLayer
   if (Layer.IntA[k2_tiHandle] > Ord(ev_slSuperposition)) then
    Layer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ShiftSegment));
   Result := True;
  end;//ShiftSegmentsLayer

 begin//ShiftSegments
  TP.Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ShiftSegmentsLayer));
 end;//ShiftSegments
  
var
 l_RealParentWidth : Long;

 procedure AddEmptyString;
 var
  l_S : TevSubString;
 begin
  l_S := TevSubString.Create(Self);
  try
   SetOutCodePage(l_S, CodePage);
   if (l_RealParentWidth = High(Long)) then
    l_S.Append(cc_HardSpace, ParentWidth)
   else
    l_S.Append(cc_HardSpace, l_RealParentWidth);
   l_S.Subs := Subs;
   Strings.Add(l_S);
  finally
   l3Free(l_S);
  end;//try..finally
 end;

var
 l_Formatted       : TevSubString;
 l_LineLength      : Long;
 l_ShortLineLen    : Long;
  {* - Длина строки без пробелов. }
 l_DeltaWhiteSpace : Long;
 l_ParaVisible     : Bool;
 l_ParaStyle       : Long;

 procedure Paint(First, aLast: Bool);

  procedure PaintSegments;

   function PaintLayer(Layer: Tl3Variant; Index: Long): Bool;

    function PaintSegment(Segment: Tl3Variant; Index: Long): Bool;
    begin//PaintSegment
     PaintLine(l_ParaVisible, l_ParaStyle, l_Formatted, Segment, First, aLast);
     Result := True;
    end;//PaintSegment

    function PaintTableSegment(Segment: Tl3Variant; Index: Long): Bool;
    var
     l_OF  : Long;
     l_Len : Long;
    begin//PaintTableSegment
     if Segment.HasSubAtom(k2_tiFinish) then
     begin
      l_OF := Segment.IntA[k2_tiFinish];
      l_Len := l_Formatted.Len;
      if (l_OF > l_Len) then 
      begin
       Segment.IntW[k2_tiFinish, Context] := l_Len;
       try
        PaintLine(l_ParaVisible, l_ParaStyle, l_Formatted, Segment, First, aLast);
       finally
        Segment.IntW[k2_tiFinish, Context] := l_OF + l_Formatted.Len - l_Len;
       end;//try..finally
      end 
      else
       PaintLine(l_ParaVisible, l_ParaStyle, l_Formatted, Segment, First, aLast);
     end
     else
      PaintLine(l_ParaVisible, l_ParaStyle, l_Formatted, Segment, First, aLast);
     Result := True;
    end;//PaintTableSegment

   var
    l_PVList : Ik2TagList;
    l_H : Integer;
   begin//PaintLayer
    l_H := Layer.IntA[k2_tiHandle];
    if (l_H > Ord(ev_slSuperposition)) AND (l_H < Ord(ev_slMistakes)) then
    begin
     l_PVList := evSegmentsLayer_GetSegments(TP, Layer.AsObject, 1, l_Formatted.Len, nil);
     try
      if OneLineSelection then
       l_PVList.ForEachF(L2Ik2TagListForEachAction(@PaintTableSegment))
      else
       l_PVList.ForEachF(L2Ik2TagListForEachAction(@PaintSegment));
     finally
      l_PVList := nil;
     end;//try..finally
    end;//Layer.IntA[k2_tiHandle] > ev_slSuperposition
    Result := True;
   end;//PaintLayer

  begin{PaintSegments}
   TP.Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@PaintLayer));
   ShiftSegments(l_LineLength + l_Formatted.Len - l_ShortLineLen - l_DeltaWhiteSpace, l_DeltaWhiteSpace);
  end;{PaintSegments}

 begin
  l_Formatted.TP := TP.AsRef;
  try
   PaintSegments;
  finally
   l_Formatted.TP := nil;
  end;{try..finally}
  if OneLineSelection then
   PaintLine(l_ParaVisible, l_ParaStyle, l_Formatted, TP, InTable OR First, True)
  else
   PaintLine(l_ParaVisible, l_ParaStyle, l_Formatted, TP, First, aLast);
 end;

var
 l_Text : Tl3PCharLen; // - Текст параграфа

 procedure TrimAll;
 var
  l_S : Tl3CustomString;
  l_SS : TevSubString;
 begin
  l_S := TP.Attr[k2_tiText] As Tl3CustomString;
  l_SS := TevSubString.Create(nil);
  try
   l_SS.AssignString(l_S);
   //l_SS.f_Owner := Self;
   Self.SetRefTo(l_SS.f_Owner);
   l_SS.TP := TP.AsRef;
   try
    l_SS.TrimAll;
   finally
    l_SS.TP := nil;
   end;//try..finally
   if not l3Same(l_SS.AsPCharLen, l_Text, false) then
   begin
    l_S.AssignString(l_SS);
    l_Text := l_S.AsPCharLen;
   end;//not l3Same(l_SS.AsPCharLen, l_Text, false)
  finally
   FreeAndNil(l_SS);
  end;//try..finally
 end;

var
 l_IndentType  : TevIndentType;
 l_ParentWidth : Long;
 l_FirstIndent : Long;

 procedure CalcDecimalTabIndent;
 var
  l_TextPara  : InevTextPara;
  l_TabIndent : Integer;
  l_Table     : TevTableAtom;
  l_Row       : TevTableRowAtom;
 begin
  TP.QT(InevTextPara, l_TextPara);
  if (l_TextPara <> nil) then
  begin
   l_TabIndent := evCalcDecimalTabIndent(l_TextPara, l_Text, l_IndentType, 0, nil, Self);
   if (l_TabIndent > 0) then
   begin
    l_Table := TevTableAtom(f_Tables.Last);
    l_Row := l_Table.CurrentRow;
    Inc(l_FirstIndent, l_TabIndent);
   end;//l_TabIndent > 0
  end;//if (l_TextPara <> nil) then
 end;

var
 l_SkipSoftEnter : Boolean;
  
 procedure DoRTrim;
 var
  l_Len : Integer;
 begin
  l_Len := l_LineLength;
  if l_SkipSoftEnter AND l_NewSoftEnter then
   l_Len := l3RTrim(l3PCharLen(l_Text.S, l_Len, l_Text.SCodePage), [cc_SoftEnter]).SLen;
  l_ShortLineLen := l3RTrim(l3PCharLen(l_Text.S, l_Len, l_Text.SCodePage)).SLen;
  if l_SkipSoftEnter AND l_NewSoftEnter then
   Inc(l_ShortLineLen);
 end;

var
 l_LeftIndent    : Long;
 l_CharCount     : Long;
 l_CharCount1    : Long;
 l_SoftEnterIndx : Long;
 l_SpacesCount   : Long;
 l_HalfSpacesCnt : Long;
 l_First         : Bool;
 l_AddHyphen     : Bool;
 l_AllowHyphen   : Bool;
 l_StrForm       : Il3StringFormatter;
begin
 ValidateStyles(TP);
 with TP do
 begin
  l_ParaVisible := BoolA[k2_tiVisible];
  l_AllowHyphen := BoolA[k2_tiAllowHyphen];
  l_ParentWidth := Max(0, ParentWidth - Pixel2Char(IntA[k2_tiRightIndent]));
  l_ParentWidth := Min(ParentWidth, l_ParentWidth);
  l_ParaStyle  := IntA[k2_tiStyle];
  if not HasSubAtom(k2_tiVisible) then
   if (l_ParaStyle = ev_saTxtComment)
      // - иначе не работали тесты для http://mdp.garant.ru/pages/viewpage.action?pageId=180060974
      OR (l_ParaStyle = ev_saVersionInfo) then
      // - иначе не работали тесты для http://mdp.garant.ru/pages/viewpage.action?pageId=209584396
    l_ParaVisible := false;
  l_IndentType := TevIndentType(IntA[k2_tiJustification]);
  if (l_IndentType = ev_itPreformatted) OR
     (l_ParaStyle = ev_saTxtNormalOEM) OR (l_ParaStyle = ev_saANSIDOS) then
   l_RealParentWidth := High(Long)
  else 
   if InTable then
    l_RealParentWidth := ParentWidth
   else
    l_RealParentWidth := l_ParentWidth;
  with Attr[k2_tiText] do
   if IsValid then
    Tl3WString(l_Text) := AsWStr
   else
   begin
    AddEmptyString;
    Exit;
   end;

  if InTable AND
     // - это таблица
     NeedAddSpaces AND
     // - и она не "честная"
     (l_IndentType <> ev_itPreformatted) AND
     // - и параграф не Preformatted
     // http://mdp.garant.ru/pages/viewpage.action?pageId=211878214
     (l_ParaStyle <> ev_saTxtNormalOEM) AND
     (l_ParaStyle <> ev_saANSIDOS)
     // http://mdp.garant.ru/pages/viewpage.action?pageId=213254256
     then
   // Здесь будем отрезать "ненужные" пробелы
   TrimAll;

  l_FirstIndent := Max(0, Pixel2Char(IntA[k2_tiFirstIndent]));
  l_LeftIndent := Max(0, Pixel2Char(IntA[k2_tiLeftIndent]));

  if InTable AND
     // - это таблица
     NeedAddSpaces
     // - и она не "честная"
     then
   CalcDecimalTabIndent;
   
 end;//with TP
 if (l_ParentWidth <= 0) then 
  l_ParentWidth := l_RealParentWidth;
 if (l_RealParentWidth = High(Long))
    OR not NeedAddSpaces
    // - не распиливаем на строки в честных таблицах
    // http://mdp.garant.ru/pages/viewpage.action?pageId=177963362
    // это конечно заплатка, т.к. для подобных же строк (с неразрывными пробелами)
    // но не в таблицах мы получим такую же лишнюю бубну в начале ссылки.
    then
 begin
  l_CharCount := l_Text.SLen;
  l_CharCount1 := l_Text.SLen;
 end//l_RealParentWidth = High(Long)..
 else
 begin
  l_CharCount := l_ParentWidth - l_FirstIndent;
  l_CharCount1 := l_ParentWidth - l_LeftIndent;
 end;//l_RealParentWidth = High(Long)
 if (l_CharCount <= 0) OR (l_CharCount1 <= 0) then
  AddEmptyString
 else 
 begin
  ValidateSegments(TP, l_Text);
  l_First := True;
  repeat
   l_SkipSoftEnter := false;
   l_SoftEnterIndx := ev_lpCharIndex(cc_SoftEnter, l_Text);
   if (l_SoftEnterIndx >= 0) AND (l_SoftEnterIndx <= l_CharCount) then
   begin
(*    if (l_SoftEnterIndx = 0) then
     // самое начало строки
     if InTable AND
        // - это таблица
        NeedAddSpaces
        // - и она не "честная"
        then
     // - игнорируем перенос в самом начале строки
     //   http://mdp.garant.ru/pages/viewpage.action?pageId=207013375
     begin
      l_NewSoftEnter := true;
      ShiftSegments(1, 0);
      l_Text.Shift(1);
      continue;
     end;//InTable*)
    // - закомментировано ибо - http://mdp.garant.ru/pages/viewpage.action?pageId=208699964 
    l_CharCount := l_SoftEnterIndx
   end//l_SoftEnterIndx >= 0
   else
   if (l_SoftEnterIndx > l_CharCount) then
   begin
    if l3AllCharsInCharSet(l3PCharLen(l_Text.S + l_CharCount,
                                      l_SoftEnterIndx - l_CharCount,
                                      l_Text.SCodePage),
                           [cc_HardSpace, cc_Tab]) then
    begin
     l_CharCount := l_SoftEnterIndx;
     l_SkipSoftEnter := true;
    end//l3AllCharsInCharSet(l3PCharLen(l_Text.S + l_CharCount,
    else
     l_SoftEnterIndx := -1;
   end//l_SoftEnterIndx > l_CharCount
   else
    l_SoftEnterIndx := -1;
   l_AddHyphen := False;
   if (l_CharCount >= l_Text.SLen) then
   begin
    l_LineLength := l_Text.SLen;
    l_NewSoftEnter := False;
   end 
   else 
   begin
    l_LineLength := l3FindNextLine(l_Text, l_CharCount, 1);
    l_NewSoftEnter := (l_LineLength > 0) AND (l_SoftEnterIndx >= 0);
    if not l_NewSoftEnter then 
    begin
     if l_AllowHyphen then 
     begin
      // - Здесь обрабатываем переносы по слогам.
      case l3SplitBySlog(l_Text, l_CharCount, InTable) of
       l3_ssYes : begin
        l_LineLength := l_CharCount;
        l_AddHyphen := True;
       end;//l3_ssYes
       l3_ssHyphen : l_LineLength := l_CharCount;
      end;//case l3SplitBySlog..
      //l_AllowHyphen
     end 
     else 
      if InTable then
       // - Здесь обрабатываем переносы по слогам для последнего слова.
       l_AddHyphen := l3SplitBySlog(l_Text, l_LineLength, InTable) = l3_ssYes;
    end;//not l_NewSoftEnter
   end;//l_CharCount >= l_Text.SLen
   DoRTrim;
   if l_NewSoftEnter then 
   begin
    l_Formatted := TevSoftEnterString.Create(Self);
    Dec(l_ShortLineLen);
   end 
   else 
   begin
    l_Formatted := TevSubString.Create(Self);
   end;//l_NewSoftEnter
   try
    l_Formatted.AsPCharLen := l3PCharLen(l_Text.S, l_ShortLineLen, l_Text.SCodePage);
    if l_AddHyphen then 
    begin
     l_Formatted.Append(cc_Hyphen);
     Inc(l_ShortLineLen);
    end;//l_AddHyphen
    if not l_NewSoftEnter AND not InTable and not l_AddHyphen then 
    begin
     l_DeltaWhiteSpace := l_LineLength - l_ShortLineLen;
     l_Formatted.Append(cc_HardSpace, l_DeltaWhiteSpace);
    end // if not l_NewSoftEnter AND not InTable and not l_AddHyphen then
    else
     l_DeltaWhiteSpace := 0;
    Paint(l_First, (l_LineLength = l_Text.SLen) OR l_NewSoftEnter);
    l_First := l_NewSoftEnter;
    //l_Formatted.f_Owner := nil;
    FreeAndNil(l_Formatted.f_Owner);
    if (l_RealParentWidth = High(Long)) then 
    begin
     //if (IT = ev_itLeft) then 
      l_Formatted.Append(cc_HardSpace, Max(ParentWidth - l_FirstIndent - l_ShortLineLen, 0));
     {l_RealParentWidth = High(Long)}
    end
    else
    begin
     if NeedAddSpaces then
     begin
      l_SpacesCount := l_RealParentWidth - l_ShortLineLen - l_FirstIndent;
      l_HalfSpacesCnt := l_SpacesCount div 2;
      case l_IndentType of
       ev_itLeft,
       ev_itPreformatted: l_Formatted.Append(cc_HardSpace, Max(l_RealParentWidth - l_FirstIndent - l_ShortLineLen, 0));
       ev_itRight  : l_Formatted.LPad(cc_HardSpace, CP_ANSI, l_SpacesCount);
       ev_itCenter : begin
        l_Formatted.LPad(cc_HardSpace, CP_ANSI, l_HalfSpacesCnt);
        l_Formatted.Append(cc_HardSpace, l_SpacesCount - l_HalfSpacesCnt);
       end;{ev_itCenter}
       ev_itWidth  : begin
        if (l_Text.SLen > l_LineLength) then
        begin
         if l3IOk(QueryInterface(Il3StringFormatter, l_StrForm)) then
         begin
          l_StrForm.FixWidth(l_Formatted, l_LineLength - l_ShortLineLen, l_SpacesCount);
          // Здесь именно разница между l_LineLength и l_ShortLineLen, т.к.
          // реальная длина строки к этому моменту может быть уже больше
          // (например, может добавиться информация о гиперссылках).
          l_Formatted.Append(cc_HardSpace, Max(l_RealParentWidth - l_FirstIndent - l_ShortLineLen - l_SpacesCount, 0));
         end
         else
          Assert(False);
        end//l_Text.SLen > l_LineLength
        else
         l_Formatted.Append(cc_HardSpace, Max(l_RealParentWidth - l_FirstIndent - l_ShortLineLen, 0));
       end;{ev_itWidth}
      end;{case IT }
     end;
     l_Formatted.LPad(cc_HardSpace, CP_ANSI, l_FirstIndent);
    end;{l_RealParentWidth = High(Long)}
    //SetOutCodePage(l_Formatted, CodePage);
    ValidateLine(l_Formatted, CodePage);
    l_Formatted.Subs := Subs;
    if not l_First then // K532630317
     l_First := l_Formatted.RTrimLen = 0;
    Strings.Add(l_Formatted);
   finally
    l3Free(l_Formatted);
   end;{try..finally}
   l_Text.Shift(l_LineLength);
   l_FirstIndent := l_LeftIndent;
   l_CharCount := l_CharCount1;
   Subs := nil;
  until l_Text.SLen = 0;
  if (l_SoftEnterIndx >= 0) AND (l_SoftEnterIndx = (l_LineLength - 1)) then
   AddEmptyString;
 end;//WC = 0
end;{FormatLines}

procedure TevCustomTextFormatter.PaintLine(ParaVisible  : Bool;
                                           ParaStyle    : Long;
                                           S            : Tl3String;
                                           Obj    : Tl3Variant;
                                           First, aLast : Bool);
  {virtual;}
  {-}
var
 l_Pnt : IevTextPainter;
begin
 if Supports(Generator, IevTextPainter, l_Pnt) then
  try
   l_Pnt.PaintLine(ParaVisible, ParaStyle, S, Obj, First, aLast);
  finally
   l_Pnt := nil;
  end;//try..finally
end;

procedure TevCustomTextFormatter.ValidateLine(aLine : Tl3String; aCodePage : Integer);
  //virtual;
  {* - процедура для проверки корректности строки. Для перекрытия в потомках. }
var
 l_Pnt : IevTextPainter;
begin
 if Supports(Generator, IevTextPainter, l_Pnt) then
 begin
  try
   l_Pnt.ValidateLine(aLine, aCodePage);
  finally
   l_Pnt := nil;
  end;//try..finally
 end//Supports(Generator, IevTextPainter, l_Pnt)
 else
  SetOutCodePage(aLine, aCodePage);
end;

procedure TevCustomTextFormatter.AddAtom(AtomIndex: Long; aValue: Tl3Variant);
  {override;}
  {-}
var
 l_O : TObject;
 //l_S : Tk2TempFileStream;
 l_Pos : Int64;
 //l_Tag : _Ik2Tag;
begin
 if (AtomIndex = k2_tiData) then
 begin
  if {(TK = k2_tkStream) AND}
     Tags.Top.IsKindOf(k2_typBitmapPara) AND
     Tags.Top.Parent.IsKindOf(k2_typObjectSegment) then
  begin
   if (aValue = nil) then
    Tags.Top.Box.AttrW[AtomIndex, nil] := nil
   else
   begin
    l_O := aValue;
    if (l_O Is Tl3SubStream) then
    begin
     Assert(false, 'Вроде не должны сюда попадать');
(*     l_Pos := Tl3SubStream(l_O).Position;
     try
      l_S := Tk2TempFileStream.Create;
      try
       {$IfDef nsTest}
       Dec(g_IStreamCopyTo_Guard);
       try
       {$EndIf nsTest}
        l3CopyStream(Tl3SubStream(l_O), l_S);
        l_S.Seek(0, soBeginning);
       {$IfDef nsTest}
       finally
        Inc(g_IStreamCopyTo_Guard);
       end;//try..finally
       {$EndIf nsTest}
       Tags.Top.Box.AttrW[AtomIndex, nil] := l_S;
      finally
       FreeAndNil(l_S);
      end;//try..finally
     finally
      Tl3SubStream(l_O).Seek(l_Pos, soBeginning);
     end;//try...finally*)
    end//l_O Is Tl3SubStream
    else
     Tags.Top.Box.AttrW[AtomIndex, nil] := aValue;
   end;//aValue = nil
  end//TK = k2_tkStream
  else
  if f_Tables.Empty AND not f_InTextPara then
   Generator.AddAtom(AtomIndex, aValue);
 end//AtomIndex = k2_tiData
 else
 begin
  inherited;
  if f_Tables.Empty AND not f_InTextPara then
   Generator.AddAtom(AtomIndex, aValue);
 end;//AtomIndex = k2_tiData
end;

procedure TevCustomTextFormatter.DoFinishTextPara(const TP: Tk2StackAtom);
  {-}
var
 i               : Long;
 l_CellLines     : TevTableColumnAtom;
 l_Row           : TevTableRowAtom;
 l_Table         : TevTableAtom;
 l_SubsList      : Tk2SimpleTagList;
 l_Str           : Tl3CustomString;
 l_StyleHandle   : Long;
 l_Justification : Long;
 l_LeftIndent    : Long;
 l_FirstIndent   : Long;
 l_Width         : Long;
 l_OutStyle      : Bool;
 l_ParentWidth   : Long;
 l_Parent        : Tl3Variant;
 l_PrevLineEmpty : Bool;
 l_ThisLineEmpty : Bool;
 l_ParaType      : Tk2Type;
 l_Exclude       : TByteSet;
begin
 if (TP.Parent = nil) then
 // - Учитываем, что параграф может быть не вложен никуда
  l_Parent := k2NullTag
 else
  l_Parent := TP.Parent.Box;
 if (f_Tables.Count > 0) then 
 begin
  l_ParentWidth := Max(0, l_Parent.IntA[k2_tiWidth]);

  if l_Parent.IsKindOf(k2_typSBSCell) then
  begin
   l_ParentWidth := Max(1, l_ParentWidth);
   if (l_ParentWidth < l3Epsilon * 2) then
   begin
    l_ParentWidth := ((def_inchPrintableWidth div 2) div 3) * l_ParentWidth;
    l_Parent.IntA[k2_tiWidth] := l_ParentWidth;
   end;//l_ParentWidth < l3Epsilon * 2..
  end;//l_Parent.IsKindOf(k2_typSBSCell)

  l_SubsList := nil;
  try
   l_SubsList := CheckSubList(TP.Box);

   l_CellLines := TevTableColumnAtom(f_Columns.Last);
   l_Table := TevTableAtom(f_Tables.Last);
   
   l_Row := l_Table.CurrentRow;
   if (TP.Box.IntA[k2_tiStyle] = ev_saTechComment) then 
   begin
    with TP.Box.Attr[k2_tiText] do
     if IsValid then
      l_Row.AddTechComment(AsObject as Tl3CustomString, l_CellLines.Count)
   end//TP.Box.IntA[k2_tiStyle] = ev_saTechComment 
   else 
   begin
    l_ParentWidth := Pixel2Char(l_Row.AccumulatedWidthInInch + l_ParentWidth) -
                      l_Row.AccumulatedWidthInChar;
    if l_Table.SBS then
     CheckSBSTable(TP.Box, l_Row, l_ParentWidth);
    CorrectParentWidth(l_Table.SBS, l_Row.CurrentCell, l_ParentWidth);
    FormatLines(TP.Box, l_CellLines, l_SubsList, True, l_ParentWidth);
   end;//..k2_tiStyle.. ..ev_saTechComment..
  finally
   l3Free(l_SubsList);
  end;//try..finally
 end//f_Tables.Count > 0
 else
 begin
  l_ParentWidth := f_SectionWidth;
  f_TextParaLines.Count := 0; { - Очищаем список строк без перераспределения памяти. }
  l_StyleHandle := TP.Box.IntA[k2_tiStyle];
  l_Width := Char2Pixel(l_ParentWidth) - TP.Box.IntA[k2_tiRightIndent];
  if FormatOrdinalParas then
   FormatLines(TP.Box, f_TextParaLines, nil, False, l_ParentWidth)
  else
   with TP.Box.Attr[k2_tiText] do
    if IsValid then
    begin
     l_Str := AsObject As Tl3CustomString;
     if (l_Str.CodePage = CodePage) then
      f_TextParaLines.Add(l_Str)
     else
     begin
      l_Str := l_Str.Clone;
      try
       //SetOutCodePage(l_Str, CodePage);
       ValidateLine(l_Str As Tl3String, CodePage);
       f_TextParaLines.Add(l_Str);
      finally
       l3Free(l_Str);
      end;//try..finally
     end;//l_Str.CharSet = CharSet
    end//IsValid
    else
     f_TextParaLines.Add(Tl3CustomString(nil));
  l_OutStyle := True;
  l_PrevLineEmpty := False;
  with TP.Box do 
  begin
   l_Justification := IntA[k2_tiJustification];
   l_LeftIndent := IntA[k2_tiLeftIndent];
   l_FirstIndent := IntA[k2_tiFirstIndent];
   l_ParaType := Tk2Type(TagType);
  end;//with TP.Box
  for i := 0 to f_TextParaLines.Hi do 
  begin
   Generator.StartChild(l_ParaType);
   try
    l_Str := Tl3CustomString(f_TextParaLines.Items[i]);
    l_ThisLineEmpty := (l_Str.RTrimLen = 0);
    if l_OutStyle OR (l_PrevLineEmpty AND not l_ThisLineEmpty) then 
    begin
     Generator.AddIntegerAtom(k2_tiJustification, l_Justification);
     Generator.AddIntegerAtom(k2_tiLeftIndent, l_LeftIndent);
     Generator.AddIntegerAtom(k2_tiFirstIndent, l_FirstIndent);
     Generator.AddIntegerAtom(k2_tiWidth, l_Width);
     Generator.AddIntegerAtom(k2_tiStyle, l_StyleHandle);
     if (i = 0) then
     begin
      l_Exclude := [k2_tiText,
                    k2_tiSegments,
                    k2_tiStyle,
                    k2_tiJustification,
                    k2_tiLeftIndent,
                    k2_tiFirstIndent,
                    k2_tiWidth];
      if (TP.Box.IntA[k2_tiStyle] = ev_saTechComment) then
       // - отрезаем сабы у технических комментариев
       //   http://mdp.garant.ru/pages/viewpage.action?pageId=177964450
       l_Exclude := l_Exclude + [k2_tiSubs];
      TP.Box.WriteTag(Generator, l3_spfAll, l_Exclude);
     end;//i = 0
    end;//l_OutStyle
    l_OutStyle := (l_Str is TevSoftEnterString);
    if FormatOrdinalParas then l_Str.RTrim;
    Generator.AddAtom(k2_tiText, l_Str);
    l_PrevLineEmpty := l_ThisLineEmpty;
   finally
    Generator.Finish;
   end;//try..finally
  end;//for i
 end;//f_Tables.Count > 0
 f_InTextPara := False;
end;

procedure TevCustomTextFormatter.NotifyInsertion(aTarget: TObject; aPos, aLen: Long);
  {-}    
  
 function ShiftSegments(Layer: Tl3Variant; Index: Long): Bool;

  function ShiftSegment(Segment: Tl3Variant; Index: Long): Bool;
  var
   l_Pos : Long;
  begin
   l_Pos := Segment.IntA[k2_tiStart];
   if (l_Pos <> evNoStart) then 
   begin
    if (aPos < l_Pos) then
     Segment.IntA[k2_tiStart] := l_Pos + aLen;
   end;
   if Segment.HasSubAtom(k2_tiFinish) then 
   begin
    l_Pos := Segment.IntA[k2_tiFinish];
    if (aPos < l_Pos) then
     Segment.IntA[k2_tiFinish] := l_Pos + aLen;
   end;
   Result := True;
  end;{ShiftSegment}

 begin{ShiftSegments}
  if (Layer.IntA[k2_tiHandle] > Ord(ev_slSuperposition)) then
   Layer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ShiftSegment));
  Result := True;
 end;{ShiftSegments}

begin
 with TevSubString(aTarget) do
  if (TP <> nil) then
   TP.AsObject.Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ShiftSegments));
end;

procedure TevCustomTextFormatter.NotifyDeletion(aTarget: TObject; aPos, aLen: Long);
  {-}

 function ShiftSegments(Layer: Tl3Variant; Index: Long): Bool;

  function ShiftSegment(Segment: Tl3Variant; Index: Long): Bool;
  var
   l_Pos : Long;
  begin
   l_Pos := Segment.IntA[k2_tiStart];
   if (l_Pos <> evNoStart) then
   begin
    if (aPos < l_Pos) then
     Segment.IntA[k2_tiStart] := l_Pos - aLen;
   end;//l_Pos <> evNoStart
   if Segment.HasSubAtom(k2_tiFinish) then
   begin
    l_Pos := Segment.IntA[k2_tiFinish];
    if (aPos < l_Pos) then
     Segment.IntA[k2_tiFinish] := l_Pos - aLen;
   end;//Segment.HasSubAtom(k2_tiFinish)
   Result := True;
  end;//ShiftSegment

 begin//ShiftSegments
  if (Layer.IntA[k2_tiHandle] > Ord(ev_slSuperposition)) then
   Layer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ShiftSegment));
  Result := True;
 end;//ShiftSegments

begin
 with TevSubString(aTarget) do
  if (TP <> nil) then
   TP.AsObject.Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ShiftSegments));
end;

procedure TevCustomTextFormatter.pm_SetPrevTable(Value: TevTableAtom);
  {-}
begin
 try
  if (f_PrevTable <> nil) then
  begin
   with f_PrevTable do
   begin
    if (CurrentRow <> nil) then
     with CurrentRow do
     begin
      if (FilledCount > 0) then
      begin
       BreakAllMerge;
       Write(0);
      end;//FilledCount > 0
    end;//with if (CurrentRow <> nil) then CurrentRow
    OutFrame;
   end;//with f_PrevTable
  end;//f_PrevTable <> nil
 finally
  // - finally тут потому, что ВНУТРИ Write(0) летит EWriteError
  // http://mdp.garant.ru/pages/viewpage.action?pageId=495125442
  l3Set(f_PrevTable, Value);
 end;//try..finally 
end;

procedure TevCustomTextFormatter.DoStartAtom(var Atom: Tk2StackAtom);
  { - Начался параграф. }
  {override;}
begin
 if Atom.IsKindOf(k2_typPara) AND
    ((Atom.Parent = nil) OR
     not Atom.Parent.IsKindOf(k2_typObjectSegment)) then 
 begin
  if Atom.IsKindOf(k2_typDocument) then 
  begin
   f_SectionWidth := CharsInLine;
   Generator.StartChild(Atom.TagType);
  end 
  else 
   if Atom.IsKindOf(k2_typTableRow) then
    StartRow
   else 
    if Atom.IsKindOf(k2_typTableCell) then
     StartCell
    else 
     if Atom.IsKindOf(k2_typTable) then
      DoStartTable(Atom.Box)
     else 
      if Atom.IsKindOf(k2_typTextPara) then
       f_InTextPara := True
      else
       if Atom.IsKindOf(k2_typBlock) then
       begin
        if f_Tables.Empty then
         Generator.StartChild(Atom.TagType);
       end//Atom.IsKindOf(k2_typBlock)
       else
        if Atom.IsKindOf(k2_typPageBreak) then
        begin
         PrevTable := nil; // - записываем таблицу, чтобы появилась команда !Style
         Generator.StartChild(Atom.TagType);
        end
        else
         Generator.StartChild(Atom.TagType);
  PrevTable := nil;
  {..k2_idPara..}
 end 
 else 
 begin
  if f_Tables.Empty and not f_InTextPara then
  begin
   if Atom.IsChild then
    Generator.StartChild(Atom.TagType)
   else
    Generator.StartTag(Atom.TagID);
  end;//f_Tables.Empty
 end;
end;

function TevCustomTextFormatter.DoBeforeFinishAtom(var anAtom: Tk2StackAtom): Bool;
  { - Кончился параграф}
  {override;}
var
 l_Start,
 l_Finish       : Tl3Variant;
 l_StartValue,
 l_FinishValue  : Long;
 l_SectionWidth : Long;
begin
 with anAtom, Box do
  if IsKindOf(k2_typPara) AND
     ((Parent = nil) OR
      not Parent.IsKindOf(k2_typObjectSegment)) then
  begin
   Result := False;
   if IsKindOf(k2_typTableRow) then
    DoFinishTableRow(anAtom)
   else 
   if IsKindOf(k2_typTableCell) then
    DoFinishTableColumn(anAtom)
   else 
   if IsKindOf(k2_typTextPara) then
    DoFinishTextPara(anAtom)
   else 
   if IsKindOf(k2_typTable) then
    DoFinishTable(anAtom)
   else
   begin
    PrevTable := nil;
    if IsKindOf(k2_typDocument) then
    begin
     Generator.Finish;
    end//IsKindOf(k2_typDocument)
    else
    if IsKindOf(k2_typBlock) then
    begin
     if f_Tables.Empty then // !!! зачем эта проверка?
      Generator.Finish;
    end//IsKindOf(k2_typBlock)
    else
    begin
     Generator.Finish;
     // Код ниже закомменирован т.к.:
     // http://mdp.garant.ru/pages/viewpage.action?pageId=177964265
(*     if IsKindOf(k2_typSectionBreak) then
     begin
      with Attr[k2_tiParas] do
      begin
       if IsValid then
       begin
        if (IntA[k2_tiOrientation] = Ord(ev_poLandscape)) then
         l_SectionWidth := IntA[k2_tiHeight]
        else
         l_SectionWidth := IntA[k2_tiWidth];
       end
       else
        l_SectionWidth := def_inchPaperWidth;
      end;//with Attr[k2_tiParas]
      f_SectionWidth := Max(73, l3MulDiv(l_SectionWidth, CharsInLine, def_inchPaperWidth));
     end;//..k2_idSection..*)
    end;//IsKindOf(k2_typDocument)
   end;//..k2_idPara..
  end
  else
  begin
   Result := True;
   if f_Tables.Empty and not f_InTextPara then 
    Generator.Finish
   else 
    if IsKindOf(k2_typTextSegment) then 
    begin
     l_Start := Attr[k2_tiStart];
     l_Finish := Attr[k2_tiFinish];
     if l_Start.IsValid then
      l_StartValue := l_Start.AsLong
     else
      l_StartValue := 1;
     if l_Finish.IsValid then
      l_FinishValue := l_Finish.AsLong
     else
      l_FinishValue := High(Long);
     Result := (l_StartValue <= l_FinishValue);
    end;//f_Tables.Empty..
  end;//..k2_idPara..
end;

{ start class TevCustomTextPainter }

function  TevCustomTextPainter.IsMarkStyle(aParaVisible        : Bool;
                                           aParaStyle          : Long;
                                           aStyledObject : Tl3Variant;
                                           aText: Tl3String;
                                           out anOpen, aClose  : AnsiString;
                                           var DeleteText      : Boolean): Bool;
  {virtual;}
  {-}
begin
 Result := False;
 anOpen := '';
 aClose := '';
end;

type
  TevHackString = class(TevSubString);

function TevCustomTextPainter.IsStyleEqual(aParaStyle,
  aSegmentStyle: Integer): Boolean;
begin
 Result := False;
end;

procedure TevCustomTextPainter.PaintLine(ParaVisible : Bool;
                                         ParaStyle   : Long;
                                         S           : Tl3String;
                                         Obj   : Tl3Variant;
                                         First, aLast : Bool);
  {virtual;}                                           
  {-}

var
 l_Pos    : Long;
 l_OpenPos: Integer;

 function lp_CheckSingleChar: Boolean;
 var
  i         : Integer;
  l_Char    : AnsiChar;
  l_Start   : Integer;
  l_PrevChar: AnsiChar;
 begin
  Result := False;
  l_PrevChar := #0;
  if l_OpenPos = l3NilLong then
   l_Start := 0
  else
   l_Start := l_OpenPos;
  for i := l_Start to l_Pos - 1 do
  begin
   l_Char := S[i];
   if l_Char = ev_NSRCHyperlink then
   begin
    l_PrevChar := #0;
    Break;
   end;
   if (l_Char in ev_NSRCSimple) then
    if l_PrevChar = l_Char then
     l_PrevChar := #0
    else
     l_PrevChar := l_Char;
  end; // for i := l_OpenPos to l_Pos do
  if l_PrevChar <> #0 then
  begin
   Result := True;
   S.Insert(l3PCharLen(l_PrevChar), l_Pos);
   S.Insert(l3PCharLen(l_PrevChar), l_Pos);
   Inc(l_Pos);
  end; // if l_PrevChar <> #0 then
 end;

var
 i        : Integer;
 l_Open   : AnsiString;
 l_Close  : AnsiString;
 l_Seg    : Bool;
 l_Del    : Boolean;
 l_DelPos : Integer;
begin
 l_Del := false;
 l_DelPos := 0;
 if IsMarkStyle(ParaVisible, ParaStyle, Obj, S, l_Open, l_Close, l_Del) then 
 begin
  l_Seg := Obj.IsKindOf(k2_typSegment);
  if l_Seg then 
  begin
   l_Pos := Obj.IntA[k2_tiStart];
   if (l_Pos <> evNoStart) then
   begin
    if l_Pos <> 0 then
     Dec(l_Pos)
   end//l_Pos <> evNoStart
   else
    l_Pos := l3NilLong;
  end//l_Seg 
  else 
  begin
   if First then
    l_Pos := 0
   else
    l_Pos := l3NilLong;
  end;//l_Seg
  l_OpenPos := l3NilLong;
  if (l_Pos <= S.Len) and not ((l_Pos = (S.Len - 1)) and (S[l_Pos] = cc_HardSpace)) then
  begin
   if l_Del then
   begin
    l_DelPos := l_Pos;
    S.Delete(l_DelPos, 1);
   end;//l_Del
   l_OpenPos := l_Pos;
   S.Insert(l3PCharLen(l_Open), l_Pos);
  end//l_Pos <= S.Len
  else
   l_Del := false;
  if l_Seg then 
  begin
   if Obj.HasSubAtom(k2_tiFinish) then
    l_Pos := Obj.IntA[k2_tiFinish]
   else
    l_Pos := l3NilLong;
  end//l_Seg
  else
  begin
   if aLast then
    l_Pos := S.Len
   else
    l_Pos := l3NilLong;
  end;//l_Seg
  if l_Del then
   Dec(l_Pos);
  if l_Del then
   TevHackString(S).f_Owner.NotifyDeletion(S, l_DelPos, 1);
  if (l_Pos <= S.Len) then
  begin
   if (l_Close[1] = ev_NSRCHyperlink) then
    if not lp_CheckSingleChar then
     if (l_OpenPos <> l3NilLong) and (S[l_Pos] in ev_NSRCSimple) then
     begin
      i := l_Pos - 1;
      while (i >= l_OpenPos) and not (S[i] in ev_NSRCAll) do
       Dec(i);
      if S[i] = S[l_Pos] then
       Inc(l_Pos);
     end; // if (l_Close[0] = ev_NSRCHyperlink) and (S[l_Pos] in ev_NSRCSimple) then
   S.Insert(l3PCharLen(l_Close), l_Pos);
  end;//l_Pos <= S.Len
 end;//IsMarkStyle..
end;

procedure TevCustomTextPainter.ValidateLine(aLine : Tl3String; aCodePage : Integer);
  //virtual;
  {* - Процедура для проверки корректности строки. Для перекрытия в потомках. }
begin
end;

procedure TevCell.Set_Borders(const Value: TevCellBorders);
begin
 f_Borders := Value;
end;

procedure TevCustomTextFormatter.CheckSBSTable(aText      : Tl3Variant;
                                               const aRow       : TevTableRowAtom;
                                               var aParentWidth : Integer);
var
 i             : Integer;
 l_NewWidth    : Long;
 l_CurRowWidth : Long;
 l_PrevCell    : TevCell;
 l_CellText    : Tl3Variant;
begin
 if f_CellsTag = nil then
  f_CellsTag := Tk2SimpleTagList.Make;
 f_CellsTag.Add(aText);
 if (aRow.Cells.Count > 0) then
 begin
  l_PrevCell := TevCell(aRow.Cells.First);
  l_CurRowWidth := l_PrevCell.f_Width + aParentWidth;
  if (f_SectionWidth - l_CurRowWidth) > 3 then
  begin
   l_NewWidth := l3MulDiv(l_PrevCell.f_Width, f_SectionWidth, l_CurRowWidth);
   CorrectParentWidth(True, aRow.CurrentCell - 1, l_NewWidth);
   l_PrevCell.f_Lines.Clear;
   for i := 0 to l_PrevCell.f_Text.Count - 1 do
   begin
    l_CellText := l_PrevCell.f_Text[i];
    FormatLines(l_CellText.AsObject, l_PrevCell.f_Lines, CheckSubList(l_CellText), True, l_NewWidth);
   end; // for i := 0 to l_PrevCell.f_CellsTag.Count - 1 do
   aRow.f_LineCount := Max(0, l_PrevCell.f_Lines.Count);
   aParentWidth := l3MulDiv(aParentWidth, f_SectionWidth, l_CurRowWidth);
  end; // if (f_SectionWidth - l_CurRowWidth) > 3 then
 end; // if (aRow.Cells.Count > 0) then
end;

procedure TevCustomTextFormatter.CorrectParentWidth(anSBS: Boolean;
  aCurrenCell: Long; var aWidth: Integer);
begin
 if (aWidth > 0) then Dec(aWidth);
end;

function TevCustomTextFormatter.CheckSubList(
  aTag: Tl3Variant): Tk2SimpleTagList;
var
 SA     : Tk2TagList;
 //l_Subs : _Ik2Tag;
begin
 Result := nil;
 with aTag.rAtomEx([k2_tiSubs, k2_tiChildren, k2_tiHandle, Ord(ev_sbtSub)]) do
  if IsValid then
   SA := AsObject as Tk2TagList
  else
   SA := nil;
 if not SA.Empty then
 begin
  Result := Tk2SimpleTagList.Create;
(*  l_Subs := k2_typSubLayer.MakeTag;
  try
   l3Set(Result, l_Subs.AsObject);
  finally
   l_Subs := nil;
  end;{try..finally}*)
  Result.JoinWith(SA);
 end;{not SA.Empty}
end;

procedure TevCustomTextFormatter.ClearObjects;
{ Вспомогательные процедуры для конвертера NSRC+ в NSRC }
begin
 if f_CellsTag <> nil then
  f_CellsTag.Clear;
 f_TextParaLines.Clear;
 f_Columns.Clear;
 f_Tables.Clear;
end;

function TevCustomTextFormatter.NeedAddSpaces: Boolean;
begin
 Result := True;
end;

procedure TevCustomTextPainter.ValidateText(aText: Tl3String;
  aValidateText: Tl3String = nil);
begin

end;

procedure TevCustomTextFormatter.ValidateText(aText: Tl3String;
  aValidateText: Tl3String = nil);
var
 l_Pnt : IevTextPainter;
begin
 if Supports(Generator, IevTextPainter, l_Pnt) then
  try
   l_Pnt.ValidateText(aText, aValidateText);
  finally
   l_Pnt := nil;
  end;//try..finally
end;

function TevCustomTextFormatter.IsStyleEqual(aParaStyle, aSegmentStyle: Integer): Boolean;
var
 l_Pnt : IevTextPainter;
begin
 Result := false;
 if Supports(Generator, IevTextPainter, l_Pnt) then
  try
   Result := l_Pnt.IsStyleEqual(aParaStyle, aSegmentStyle);
  finally
   l_Pnt := nil;
  end;//try..finally
end;

end.

