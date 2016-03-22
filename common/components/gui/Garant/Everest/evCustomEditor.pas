unit evCustomEditor;
{* Базовый класс окна редактора с кучей "полезных" функций. Рекомендуется для конечного пользователя (программиста). }

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evCustomEditor - }
{ Начат: 25.11.2004 10:05 }
{ $Id: evCustomEditor.pas,v 1.182 2016/02/12 11:29:09 lulin Exp $ }

// $Log: evCustomEditor.pas,v $
// Revision 1.182  2016/02/12 11:29:09  lulin
// - меняем размер CodePage.
//
// Revision 1.181  2015/08/19 14:14:33  dinishev
// {Requestlink:602009846}
//
// Revision 1.180  2015/08/14 11:50:03  dinishev
// {Requestlink:602009846}. Доточил TevCustomHyperlinkSearcher для игнорирования внеших номеров + убрал IFDEF в флаг игнорирования вложенных, если блок свернут
//
// Revision 1.179  2015/07/09 08:46:23  dinishev
// {Requestlink:602951122}. Передергиваем курсор в левой части окна.
//
// Revision 1.178  2015/07/09 08:30:33  dinishev
// {Requestlink:602951122}. Передергиваем курсор в левой части окна.
//
// Revision 1.177  2015/07/09 07:59:19  dinishev
// {Requestlink:602951122}. Не перехватываем исключение раньше времени.
//
// Revision 1.176  2015/07/06 12:03:35  kostitsin
// {requestlink: 602951122 }
//
// Revision 1.175  2015/06/03 13:55:17  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.174  2015/06/03 12:43:15  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.173  2015/05/06 13:45:00  kostitsin
// {requestlink: 578890742 }
//
// Revision 1.172  2015/02/04 08:38:06  dinishev
// {Requestlink:564248798}
//
// Revision 1.171  2015/01/22 19:10:07  kostitsin
// рисуем TeeEditorExport
//
// Revision 1.170  2014/10/27 08:21:42  dinishev
// {Requestlink:570103142}
//
// Revision 1.169  2014/10/27 08:01:54  dinishev
// {Requestlink:569232703}. Сценарий № 2.
//
// Revision 1.168  2014/08/07 08:37:50  dinishev
// Reformat
//
// Revision 1.167  2014/08/06 08:44:47  dinishev
// {Requestlink:560190703}
//
// Revision 1.166  2014/08/05 14:21:47  dinishev
// {Requestlink:558964587}. Доделал.
//
// Revision 1.165  2014/08/01 09:17:57  dinishev
// {Requestlink:558964587}
//
// Revision 1.164  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.163  2014/04/29 13:38:51  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.162  2014/04/10 15:26:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.161  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.160  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.159  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.158  2014/03/21 16:24:50  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.157  2014/03/17 06:01:16  dinishev
// Недокоммител.
//
// Revision 1.156  2014/01/30 12:00:53  dinishev
// {Requestlink:515525560}
//
// Revision 1.155  2014/01/09 12:21:54  dinishev
// {Requestlink:510607174}
//
// Revision 1.154  2013/12/19 09:20:23  dinishev
// {Requestlink:509112119}
//
// Revision 1.153  2013/10/21 17:30:59  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.152  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.151  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.150  2013/10/18 14:11:22  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.149  2013/10/09 07:29:56  morozov
// {RequestLink: 488604061}
//
// Revision 1.148  2013/10/07 10:35:29  morozov
// {RequestLink: 488604061}
//
// Revision 1.147  2013/09/08 08:34:48  dinishev
// {Requestlink:481428636}
//
// Revision 1.146  2013/05/17 12:40:18  morozov
// {RequestLink:404361039}
//
// Revision 1.145  2013/03/14 14:06:04  dinishev
// {Requestlink:435460780}
//
// Revision 1.144  2012/11/27 11:49:49  dinishev
// {Requestlink:410628348}
//
// Revision 1.143  2012/10/30 13:48:14  dinishev
// {Requestlink:407150397}
//
// Revision 1.142  2012/10/26 14:54:54  lulin
// {RequestLink:406489593}
//
// Revision 1.141  2012/10/26 14:14:22  lulin
// {RequestLink:406489593}
//
// Revision 1.140  2012/10/01 13:14:47  dinishev
// {Requestlink:380622157}
//
// Revision 1.139  2012/10/01 09:52:29  dinishev
// Bug fix: не компилировался или не запускался EverestLite
//
// Revision 1.138  2012/09/29 15:24:35  lulin
// {RequestLink:397301416}
//
// Revision 1.137  2012/09/27 11:49:39  dinishev
// {Requestlink:397289578}
//
// Revision 1.136  2012/09/27 09:33:38  dinishev
// {Requestlink:397289578}
//
// Revision 1.135  2012/09/25 12:49:21  dinishev
// {Requestlink:391841554}
//
// Revision 1.134  2012/09/24 09:55:39  dinishev
// {Requestlink:396790773}
//
// Revision 1.133  2012/09/12 13:23:04  dinishev
// {Requestlink:390578250}
//
// Revision 1.132  2012/08/22 12:45:13  dinishev
// {Requestlink:382408222}
//
// Revision 1.131  2012/08/16 20:11:42  lulin
// {RequestLink:384434840}
//
// Revision 1.130  2012/08/16 19:00:04  lulin
// {RequestLink:384434840}
//
// Revision 1.129  2012/08/16 18:13:51  lulin
// {RequestLink:384434840}
//
// Revision 1.128  2012/08/08 15:05:06  dinishev
// {Requestlink:380623516}
//
// Revision 1.127  2012/08/08 13:07:44  dinishev
// {Requestlink:380623516}
//
// Revision 1.126  2012/08/08 11:04:56  dinishev
// {Requestlink:380623516}
//
// Revision 1.125  2012/08/06 13:50:38  dinishev
// {Requestlink:380623516}
//
// Revision 1.124  2012/06/14 11:52:13  dinishev
// {Requestlink:370384889}
//
// Revision 1.123  2012/06/14 10:46:01  dinishev
// {Requestlink:370384889}
//
// Revision 1.122  2012/06/05 14:57:52  dinishev
// {Requestlink:370383707}
//
// Revision 1.121  2012/03/23 10:40:40  dinishev
// {Requestlink:349116229}
//
// Revision 1.120  2012/03/22 13:18:21  dinishev
// {Requestlink:349116289}
//
// Revision 1.119  2012/01/26 07:39:35  dinishev
// {Requestlink:330139532}
//
// Revision 1.118  2012/01/26 07:39:15  dinishev
// {Requestlink:330139532}
//
// Revision 1.117  2011/09/15 18:32:06  lulin
// {RequestLink:278824896}.
//
// Revision 1.116  2011/09/15 16:23:21  lulin
// {RequestLink:278824896}.
//
// Revision 1.115  2011/09/14 18:01:51  lulin
// {RequestLink:278824896}.
//
// Revision 1.114  2011/09/14 07:51:44  lulin
// {RequestLink:278824896}.
//
// Revision 1.113  2011/09/01 13:44:25  lulin
// {RequestLink:280006084}.
//
// Revision 1.112  2011/08/12 11:49:08  dinishev
// [$205750429]
//
// Revision 1.111  2011/07/08 17:05:07  lulin
// {RequestLink:228688745}.
//
// Revision 1.110  2011/04/21 07:55:59  dinishev
// [$263750307]
//
// Revision 1.109  2010/12/01 14:56:11  lulin
// {RequestLink:244195072}.
//
// Revision 1.108  2010/11/16 08:50:22  dinishev
// [$234357754]
//
// Revision 1.107  2010/07/16 07:06:26  dinishev
// [$226005021]. Тест не работал.
//
// Revision 1.106  2010/07/15 14:35:49  dinishev
// [$226005021]
//
// Revision 1.105  2010/07/10 10:59:59  dinishev
// [$200902351]
//
// Revision 1.104  2010/07/10 06:54:52  dinishev
// [$224790796]
//
// Revision 1.103  2010/07/07 11:58:35  lulin
// {RequestLink:224134554}.
//
// Revision 1.102  2010/05/26 07:08:29  dinishev
// [$210436129]
//
// Revision 1.101  2010/02/26 09:24:47  lulin
// {RequestLink:193134950}.
// - отключаем возможность ввода SBS.
//
// Revision 1.100  2010/02/26 08:50:30  lulin
// {RequestLink:193134950}.
// - отключаем возможность ввода SBS.
//
// Revision 1.99  2010/02/17 10:42:57  dinishev
// [$189268714]
//
// Revision 1.98  2009/11/19 14:48:32  lulin
// {RequestLink:159361982}.
//
// Revision 1.97  2009/11/19 14:13:03  lulin
// - bug fix: не собиралось.
//
// Revision 1.96  2009/11/19 12:05:13  dinishev
// [$171968600]
//
// Revision 1.95  2009/10/19 17:55:55  lulin
// {RequestLink:164599478}.
//
// Revision 1.94  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.93  2009/07/23 08:14:38  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.92  2009/07/21 14:36:01  lulin
// - убираем поддержку IUnknown со строк.
//
// Revision 1.91  2009/07/14 14:56:26  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.90  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.89  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.88  2009/07/11 09:24:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.87  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.86  2009/06/25 12:57:30  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.85  2009/06/10 12:26:46  lulin
// - цепляем фильтр имён блоков к экспорту.
// - восстанавливаем код пропавший (точнее пролюбленный) при переносе на модель.
// - фильтруем полностью выделенные блоки.
//
// Revision 1.84  2009/05/15 05:30:13  oman
// Не собиралось
//
// Revision 1.83  2009/05/14 08:42:04  dinishev
// <K> : 137469295
//
// Revision 1.82  2009/04/14 08:24:25  lulin
// [$142613919]. Группируем функциональность в базовых классах.
//
// Revision 1.81  2009/04/09 14:12:36  lulin
// [$140837386]. №15.
//
// Revision 1.80  2009/03/31 12:04:36  lulin
// [$140286997].
//
// Revision 1.79  2009/03/05 13:09:35  lulin
// - <K>: 137470629. Используем ссылки на типы.
//
// Revision 1.78  2009/03/04 13:32:45  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.77  2009/03/03 08:03:40  oman
// - fix: Не падаем на переходных процессах (К-137469345)
//
// Revision 1.76  2009/01/23 08:37:32  dinishev
// <K> : 135602498
//
// Revision 1.75  2008/12/29 12:22:45  oman
// - fix: Не подаем HAFPainter снаружи (К-122675365)
//
// Revision 1.74  2008/12/25 10:01:15  dinishev
// Bug fix: не учитывали вложенность таблицы при установке выравнивания текста по разделителю
//
// Revision 1.73  2008/10/14 19:20:11  lulin
// - <K>: 121149970.
//
// Revision 1.72  2008/10/02 17:33:14  lulin
// - <K>: 120721787.
//
// Revision 1.71  2008/10/02 06:26:54  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=85169631&focusedCommentId=119475207#comment-119475207
//
// Revision 1.70  2008/10/01 11:13:29  lulin
// - <K>: 120718563.
//
// Revision 1.69  2008/10/01 10:49:49  lulin
// - <K>: 120718563.
//
// Revision 1.68  2008/09/29 12:21:14  lulin
// - выкидываем ненужную функциональность.
//
// Revision 1.67  2008/09/26 13:24:46  dinishev
// <K>: 77235630 - мерж испрвлений замечений с веткой
//
// Revision 1.66  2008/09/26 10:10:47  dinishev
// <K>: 77235630 для Head'а
//
// Revision 1.65  2008/09/19 16:36:32  lulin
// - <K>: 118394468.
//
// Revision 1.64  2008/08/15 13:13:52  lulin
// - <K>: 108626698.
//
// Revision 1.63  2008/08/08 15:07:03  lulin
// - <K>: 96484678.
//
// Revision 1.62  2008/05/16 15:20:35  lulin
// - переносим на модель.
//
// Revision 1.61  2008/04/23 09:52:50  lulin
// - <K>: 89105866.
//
// Revision 1.60  2008/04/16 07:34:53  lulin
// - cleanup.
//
// Revision 1.59  2008/04/15 08:23:45  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.58  2008/04/11 10:31:21  lulin
// - <K>: 89099090.
//
// Revision 1.57  2008/04/10 15:43:14  lulin
// - <K>: 89098967.
//
// Revision 1.56  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.55  2008/04/09 08:04:45  lulin
// - передаём вью в рамках <K>: 89096854.
// - не компилировался Архивариус.
//
// Revision 1.54  2008/04/07 13:51:45  lulin
// - поправлено имя метода.
//
// Revision 1.53  2008/04/07 13:34:06  lulin
// - изменения в рамках <K>: 89096854.
//
// Revision 1.52  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.51  2008/03/12 14:14:56  dinishev
// Bug fix: не выставлялся флаг модификации при добавлении таблицы
//
// Revision 1.50  2008/02/27 18:19:50  lulin
// - подгоняем код под модель.
//
// Revision 1.49  2008/01/10 08:38:49  dinishev
// Bug fix: List index out of bounds
//
// Revision 1.48  2007/12/25 12:55:52  lulin
// - удален ненужный модуль.
//
// Revision 1.47  2007/12/24 22:38:43  lulin
// - удален ненужный модуль.
//
// Revision 1.46  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.34.2.89  2007/12/03 15:51:39  lulin
// - cleanup.
//
// Revision 1.34.2.88  2007/12/03 11:26:07  lulin
// - bug fix: убрана ненужная пачка операций, т.к. не давала вставлять таблицы в комментарии (CQ OIT5-27741, <K>-76448000).
//
// Revision 1.34.2.87  2007/11/29 11:38:35  dinishev
// Используем единую пачку операций при вставке таблицы
//
// Revision 1.34.2.86  2007/11/28 15:24:21  dinishev
// Используем инструменты для работы с таблицами
//
// Revision 1.34.2.85  2007/10/04 15:46:57  lulin
// - добавлены параметры команд.
//
// Revision 1.34.2.84  2007/10/03 18:27:56  lulin
// - добавлена еще одна версия метода вставки строки.
//
// Revision 1.34.2.83  2007/09/25 14:42:11  lulin
// - добавлен метод вставки формулы.
//
// Revision 1.34.2.82  2007/09/14 13:26:04  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.34.2.81.2.1  2007/09/12 15:23:00  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.34.2.81  2007/09/03 12:29:04  lulin
// - переименовываем тег.
//
// Revision 1.34.2.80  2007/07/19 06:18:09  oman
// - fix: выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
// (Не собиралась библиотека)
//
// Revision 1.34.2.79  2007/04/18 12:15:34  oman
// - new: При поиске гиперссылок пользуем _FoundBlock (cq22752)
//
// Revision 1.34.2.78  2007/04/09 13:09:22  lulin
// - cleanup.
//
// Revision 1.34.2.77  2007/04/09 12:07:16  lulin
// - bug fix: раскорячивались после частичной вставки подписи в ридонли место документа (CQ OIT5-24921).
//
// Revision 1.34.2.76  2007/02/13 17:32:55  lulin
// - избавляемся от использования стандартной функции поиска подстроки в строке.
//
// Revision 1.34.2.75  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.34.2.74  2006/12/12 09:54:17  oman
// - fix: Перенос HiddenStyles c DocumentContainer на редактор.
//   Поддержка экспорта/клипборда/d'n'd (cq12564)
//
// Revision 1.34.2.73  2006/11/27 09:02:13  lulin
// - cleanup.
//
// Revision 1.34.2.72  2006/11/03 11:00:04  lulin
// - объединил с веткой 6.4.
//
// Revision 1.34.2.71.2.3  2006/11/02 13:10:33  lulin
// - cleanup.
//
// Revision 1.34.2.71.2.2  2006/11/01 14:40:31  lulin
// - рекурсивно вычисляем карту форматирования.
//
// Revision 1.34.2.71.2.1  2006/10/31 11:16:13  oman
// - fix: Окно поиска контекста передвигается от границ найденного
//  фрагмента, а не окрежающего его параграфа (cq22451)
//
// Revision 1.34.2.71  2006/10/10 12:06:13  lulin
// - cleanup.
//
// Revision 1.34.2.70  2006/09/26 14:43:51  oman
// - fix: При поиске гиперссылок.
//   1. Если было выделении могли замерзнуть на гиперссылке в
//       выделении (cq22726)
//   2. Гасилась каретка (cq22724)
//   3. Если было выедление, могли перескакивать через ссылку
//       (зависит от напровления выделения и поиска)
//
// Revision 1.34.2.69  2006/09/21 08:12:06  lulin
// - cleanup.
//
// Revision 1.34.2.68  2006/09/21 08:08:11  lulin
// - new behavior: если стоим в ссылке, то не учитываем ее при переходе по ссылкам вперед/назад (CQ OIT5-22653).
//
// Revision 1.34.2.67  2006/09/21 07:07:43  lulin
// - выделены методы перехода по ссылкам.
//
// Revision 1.34.2.66  2006/08/02 10:51:52  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.34.2.65.2.1  2006/07/24 17:57:50  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.34.2.65  2006/07/20 17:35:57  lulin
// - убраны параметры по умолчанию.
// - имя метода убрано из комментариев.
// - bug fix: в КЗ - рисовался "палец", теперь он правда рисуется в другом месте.
//
// Revision 1.34.2.64  2006/07/19 15:50:23  lulin
// - переименован метод - в соответствии с его параметрами.
//
// Revision 1.34.2.63  2006/07/19 14:24:13  lulin
// - теперь для определения прямоугольника вывода работаем с исходным объектом, а не с формой.
//
// Revision 1.34.2.62  2006/06/21 14:31:58  lulin
// - отключена вставка разрыва раздела/страницы в специфическом редакторе для Немезиса (CQ OIT5-19047).
//
// Revision 1.34.2.61  2006/06/21 13:36:25  oman
// - fix: Не собиралась библиотека
//
// Revision 1.34.2.60  2006/06/09 11:53:56  lulin
// - bug fix: по Shift-Enter курсор переходил на следующую строку (CQ OIT5-19047).
//
// Revision 1.34.2.59  2006/06/08 13:37:48  lulin
// - подготавливаем контролы к обработке числа повторений нажатия клавиши.
//
// Revision 1.34.2.58  2006/03/31 09:54:53  lulin
// - bug fix: форма поиска закрывала найденный фрагмент.
//
// Revision 1.34.2.57  2006/02/08 15:10:13  lulin
// - заставил работать Everest в ветке.
//
// Revision 1.34.2.56  2006/01/24 12:54:07  lulin
// - cleanup.
//
// Revision 1.34.2.55  2006/01/16 14:28:17  lulin
// - cleanup.
//
// Revision 1.34.2.54  2005/11/15 13:50:01  lulin
// - cleanup: используем только Reader тегов - не подкладывая под него Pool. Связывание теперь осуществляется раньше.
//
// Revision 1.34.2.53  2005/11/15 11:32:34  lulin
// - типизируем интерфейс потока.
//
// Revision 1.34.2.52  2005/11/14 18:36:56  lulin
// - теперь при заборе в буфер обмена в него кладется контейнер документа, а не TextSource - должно починить ошибку CQ OIT5-17870.
//
// Revision 1.34.2.51  2005/11/11 22:31:40  lulin
// - избавляемся от управления свойством модифицированности документа путем посылки сообщений.
//
// Revision 1.34.2.50  2005/11/11 12:45:27  fireton
// - bug fix: восстановлена (ограниченно) функциональность AdjustForm2Found
//
// Revision 1.34.2.49  2005/11/09 15:28:23  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.34.2.48  2005/11/07 06:25:22  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.34.2.47  2005/11/05 09:03:13  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.34.2.46  2005/11/04 16:47:57  lulin
// - базовый объект теперь поддерживает свое удаление.
//
// Revision 1.34.2.45  2005/10/25 11:05:44  lulin
// - не получаем напрямую информационную канву экрана, а получаем ее через фасад.
//
// Revision 1.34.2.44  2005/10/13 06:00:23  lulin
// - cleanup.
//
// Revision 1.34.2.43  2005/10/06 11:37:33  lulin
// - bug fix: убран assert при вставке SBS-параграфа с клавиатуры.
//
// Revision 1.34.2.42  2005/10/06 08:15:51  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.34.2.41  2005/10/06 07:31:53  lulin
// - cleanup.
//
// Revision 1.34.2.40  2005/09/23 16:03:54  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.34.2.39  2005/08/29 11:52:43  lulin
// - свойство PlainText переехало на базовый редактор.
//
// Revision 1.34.2.38  2005/07/29 12:37:49  lulin
// - реализация работы с таблицами убрана с редактора.
//
// Revision 1.34.2.37  2005/07/25 18:09:15  lulin
// - теперь TextSource не знает про реализацию контейнера документа, а только про его интерфейс.
//
// Revision 1.34.2.36  2005/07/25 12:13:13  lulin
// - TextSource теперь знает про базовый контейнер документа, а не про специализированный.
//
// Revision 1.34.2.35  2005/07/22 14:59:50  dinishev
// Поддержка промежуточного слоя
//
// Revision 1.34.2.34  2005/07/21 07:54:31  lulin
// - убран промежуточный интерфейс и упрощено использование функции поиска/замены.
//
// Revision 1.34.2.33  2005/07/20 18:49:26  lulin
// - редактор теперь умеет работать с базовым TextSource, а не со специализированным.
//
// Revision 1.34.2.32  2005/07/20 18:21:13  lulin
// - убран переходный интерфейс.
//
// Revision 1.34.2.31  2005/07/20 17:31:42  lulin
// - спрятаны методы, которые не стоит использовать напрямую.
//
// Revision 1.34.2.30  2005/07/20 16:59:27  lulin
// - избавляем окружающих от необходимости знать про TagReader и _TagWriter.
//
// Revision 1.34.2.29  2005/07/19 16:47:04  lulin
// - убран косвенный запрос подтверждения замены. Теперь соответствующий интерфейс подается непосредственно в Replacer.
//
// Revision 1.34.2.28  2005/07/19 15:32:23  lulin
// - убрана часть обращений к интересующим интерфейсам через цепочку Parent'ов диапазонов и курсоров.
//
// Revision 1.34.2.27  2005/07/19 08:25:03  lulin
// - избавился от посылки сообщений для конвертации текста параграфа - перевел конвертацию на общий механизм Search/_Replace.
//
// Revision 1.34.2.26  2005/07/19 06:58:45  lulin
// - cleanup: убрано лишнее сообщение для конвертации текста параграфов.
//
// Revision 1.34.2.25  2005/07/18 17:37:42  lulin
// - упорядочена интерфейсная модель редактора - для удобства чтения и эффективности использования, а также для избавления от посылки сообщений.
//
// Revision 1.34.2.24  2005/07/18 11:22:36  lulin
// - методу, возвращаещему выделение на параграфе дано более подходящее название.
//
// Revision 1.34.2.23  2005/07/13 15:36:29  lulin
// - new unit: evEditorWindowTextSource.
//
// Revision 1.34.2.22  2005/07/11 06:07:05  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.34.2.21  2005/07/07 13:09:27  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.34.2.20  2005/06/16 14:59:13  lulin
// - cleanup: удалены ненужные зависимости.
//
// Revision 1.34.2.19  2005/06/16 14:11:29  lulin
// - cleanup: отдельно стоящие процедуры перенесены на интерфейсы.
//
// Revision 1.34.2.18  2005/06/16 11:24:11  lulin
// - убрана косвенная типизация параграфов (при помощи _QI и QT).
//
// Revision 1.34.2.17  2005/06/15 17:23:51  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.34.2.16  2005/06/15 13:05:59  lulin
// - убрана инициализация блоков выделения в явном виде.
//
// Revision 1.34.2.15  2005/06/11 11:13:19  lulin
// - избавился от использования "устаревших" интерфейсов.
//
// Revision 1.34.2.14  2005/06/10 12:54:31  lulin
// - cleanup: у редактора убрано знание про верхнюю позицию скроллирования.
//
// Revision 1.34.2.13  2005/06/08 10:18:30  lulin
// - вместо объекта используем интерфейс.
//
// Revision 1.34.2.12  2005/06/07 14:05:31  lulin
// - cleanup.
//
// Revision 1.34.2.11  2005/06/07 13:43:46  lulin
// - удален ненужный модуль.
//
// Revision 1.34.2.10  2005/06/07 12:46:30  lulin
// - заключительный аккорд перехода с объектов на интерфейсы (при работе с курсорами).
//
// Revision 1.34.2.9  2005/06/03 12:08:18  lulin
// - cleanup: убраны ненужные зависимости.
//
// Revision 1.34.2.8  2005/06/02 12:33:07  lulin
// - вчерне заменил прямое создание блока выделения на его получение от фабрики.
//
// Revision 1.34.2.7  2005/06/01 16:22:24  lulin
// - remove unit: evIntf.
//
// Revision 1.34.2.6  2005/05/31 15:57:20  lulin
// - изживаем остатки объектов в качестве курсоров.
//
// Revision 1.34.2.5  2005/05/31 14:48:01  lulin
// - cleanup: при работе с курсорами используем интерфейсы, а не объекты.
//
// Revision 1.34.2.4  2005/05/31 12:06:30  lulin
// - cleanup: при работе с курсорами используем интерфейсы, а не объекты.
//
// Revision 1.34.2.3  2005/05/26 13:19:28  lulin
// - new unit: _l3ScreenIC.
//
// Revision 1.34.2.2  2005/05/20 11:27:35  lulin
// - класс TevBlock вынесен в отдельный модуль.
//
// Revision 1.34.2.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.23.2.4  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.23.2.3  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.23.2.2  2005/04/18 16:43:24  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.23.2.1  2005/04/08 07:50:40  lulin
// - bug fix: с клавиатуры не вставлялся разрыв страницы.
//
// Revision 1.25.2.2  2005/04/27 09:13:54  fireton
// - merge с HEAD
//
// Revision 1.25.2.1  2005/04/25 09:03:33  lulin
// - объединил с HEAD.
//
// Revision 1.26  2005/04/21 19:16:32  fireton
// - bug fix: полностью переписана _AjustFormToFound для корректной отработки позиционирования найденного блока и окна поиска.
//
// Revision 1.25  2005/04/18 17:18:22  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.24  2005/04/11 13:46:37  voba
// - bug fix
//
// Revision 1.34  2005/05/17 11:46:20  lulin
// - убран "лишний" метод.
//
// Revision 1.33  2005/05/17 11:19:24  lulin
// - cleanup: возвращаем более общий интерфейс.
//
// Revision 1.32  2005/05/16 11:59:28  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.31  2005/05/16 11:42:09  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.30  2005/05/13 17:54:21  lulin
// - спрятан ненужный метод.
//
// Revision 1.29  2005/05/12 13:45:16  lulin
// - удалено ненужное свойство RecalcMode.
//
// Revision 1.28  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.27  2005/04/26 11:28:15  fireton
// - bug fix: AdjustFormToFound - корректная обработка ситуаций, когда блок скроллировать нельзя (начало и конец документа)
//
// Revision 1.26  2005/04/21 19:16:32  fireton
// - bug fix: полностью переписана _AjustFormToFound для корректной отработки позиционирования найденного блока и окна поиска.
//
// Revision 1.25.2.2  2005/04/27 09:13:54  fireton
// - merge с HEAD
//
// Revision 1.25.2.1  2005/04/25 09:03:33  lulin
// - объединил с HEAD.
//
// Revision 1.26  2005/04/21 19:16:32  fireton
// - bug fix: полностью переписана _AjustFormToFound для корректной отработки позиционирования найденного блока и окна поиска.
//
// Revision 1.25  2005/04/18 17:18:22  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.24  2005/04/11 13:46:37  voba
// - bug fix
//
// Revision 1.23  2005/04/07 16:05:04  lulin
// - new method: Ik2TagBoxQT._MakeInterface.
//
// Revision 1.22  2005/03/31 10:30:46  lulin
// - remove unit: evBase_TLB.
//
// Revision 1.21  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.20  2005/03/24 13:14:37  lulin
// - уделена ненужная функция преобразования Tk2AtomR к _Ik2Tag.
//
// Revision 1.19  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.18  2005/03/21 06:44:53  lulin
// - убраны ненужные методы.
//
// Revision 1.17  2005/03/19 16:39:50  lulin
// - спрятаны ненужные методы.
//
// Revision 1.16  2005/03/17 15:58:32  lulin
// - флаги режима загрузки/вставки документа стали множеством, а не пачкой Boolean'ов.
//
// Revision 1.15  2005/03/16 17:04:21  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.14  2005/03/16 12:16:51  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.13  2005/03/04 15:49:02  lulin
// - спрятана процедура Tk2Type.New.
//
// Revision 1.12  2005/02/22 14:14:19  lulin
// - bug fix: не компилировалось.
//
// Revision 1.11  2005/01/24 15:02:53  lulin
// - bug fix: не вставлялись комментарии в документ из кеша, т.к. ему не вставлялся признак Loaded (CQ OIT5-11727).
// - new method: _TevCustomTextSource.CanUserModify.
// - new method: TevCustomEditor.CanUserModify.
//
// Revision 1.10  2005/01/24 11:43:15  lulin
// - new behavior: при освобождении заглушки очищаем указатель на нее.
//
// Revision 1.9  2005/01/19 10:50:41  lulin
// - new prop: TevCustomEditor.IsStaticText.
//
// Revision 1.8  2005/01/14 17:24:14  lulin
// - в ProcessCommand добавлен параметр aForce - сигнализирующий, что такого ShortCut'а нету в VCM и что не надо умничать с обработкой комманды.
//
// Revision 1.7  2005/01/11 09:29:26  lulin
// - bug fix: в Архивариусе при печати были неправильные колонтитулы.
//
// Revision 1.6  2004/12/29 16:36:12  lulin
// - remove prop: TevCustomEditor.HAFPainter.
//
// Revision 1.5  2004/12/29 14:37:53  fireton
// - bug fix: "улет" формы поиска за пределы экрана при большом найденном фрагменте (AdjustForm2Found)
//
// Revision 1.4  2004/12/29 14:04:29  lulin
// - evGraph и _Preview полностью переведены с класса TPrinter на интерфейс _Il3Printer.
//
// Revision 1.3  2004/12/28 16:49:56  lulin
// - cleanup.
//
// Revision 1.2  2004/11/25 12:44:56  lulin
// - new method: TevCustomEditorWindow._GetHotspotOnPoint.
// - избавился от дублирования кода.
//
// Revision 1.1  2004/11/25 07:37:41  lulin
// - new unit: TevCustomEditor.
//

{$Include evDefine.inc }

interface

uses
  Windows,
  Messages,
  
  Classes,

  Graphics,
  Controls,
  Forms,
  Dialogs,

  l3Interfaces,
  l3Types,
  l3Units,
  l3InternalInterfaces,
  l3Base,

  k2Base,

  evdTypes,

  evTypes,
  evInternalInterfaces,
  evCustomTextSource,
  evMultiSelectEditorWindow,

  afwInterfaces,
  afwNavigation,

  nevBase,
  nevTools,
  evCustomEditorModelPart
  ;

type
  TevMakeTextSourceEvent = procedure(aSender           : TObject;
                                     out theTextSource : TevCustomTextSource) of object;
    {-}
  TevCustomEditor = class(TevCustomEditorModelPart
                          {$IfDef evNeedDisp}
                          ,
                          Il3ActionProcessor
                          {$EndIf evNeedDisp})
   {* Базовый класс окна редактора с кучей "полезных" функций. Рекомендуется для конечного пользователя (программиста). }
    private
    // property fields
      f_PrintDialog : TPrintDialog;
      f_AutoSelect  : Boolean;
      f_PlainText   : Boolean;
      f_InCheckAACCursor : Boolean;
    private
    // event fields
      f_OnReplaceConfirm  : TevReplaceConfirmEvent;
      f_OnSelectionChange : TNotifyEvent;
      f_OnHyperlinkNavigate : TNotifyEvent;
      f_OnMakeTextSource  : TevMakeTextSourceEvent;
    private
    // message handlers
      procedure WMChar(var Msg : TWMChar);
        message WM_CHAR;
        {-}
      procedure WMKeyDown(var Msg : TWMKeyDown);
        message CN_KEYDOWN;
        {-}
      procedure WMSetFocus(var Msg : TWMSetFocus);
        message WM_SETFOCUS;
        {-}
      procedure WMKillFocus(var Msg : TWMKillFocus);
        message WM_KILLFOCUS;
        {-}
      procedure CMEnter(var Message: TCMGotFocus);
        message CM_ENTER;
        {-}
    protected
      function  DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean; virtual;
        {-}
    public
      function  SearchHyperLinkAddress(aSearchDown: Boolean;
                                       aSearchGlobal: Boolean;
                                       const anAddress : TevAddress): Boolean;
        {-}
    protected
    // internal methods
      procedure DoInitAACLikeCursor;
        override;
        {-}
      function AllowAutoSelectByMouse: Boolean;
        virtual;
        {-}
      procedure BlockChange;
        override;
        {* - изменилось выделение. }
      procedure ParaChange;
        override;
        {* - изменился текущий параграф. }
      procedure DoFontChange(const Font: Il3Font);
        override;
        {* - изменился текущий шрифт. }
      procedure MakeTextSource(out theTextSource: TevCustomTextSource);
        override;
        {-}
      procedure DoDrawSpecialChange(Sender: TObject);
        override;
        {-}
      function CanEdit: Boolean;
        {-}
      function CheckAACMode(aCommand: Long; aForce: Boolean; aCount: Integer): Boolean;
        override;
        {-}
    protected
    // property methods
      function  pm_GetCanUndo: Bool;
        {-}
      function  pm_GetCanRedo: Bool;
        {-}
      function  pm_GetIsStaticText: Boolean;
      procedure pm_SetIsStaticText(aValue: Boolean);
        {-}
      function  pm_GetReadOnly: Bool;
      procedure pm_SetReadOnly(Value: Bool);
        {-}
      function  pm_GetPlainText: Boolean;
        override;
      procedure pm_SetPlainText(aValue: Boolean);
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
      function  ReplaceConfirm(const aBlock        : InevRange;
                               AlienReplaceConfirm : TevReplaceConfirmEvent): ShortInt;
        override;                       
        {-}
      function  AdjustForm2Found(Form: TForm): TForm;
        virtual;
        {-}
      procedure Try2GoByHyperlinkUnderCursor;
        {-}
      procedure InsertTable(ACol, ARow: Long);
        {* - вставить таблицу из ACol столбцов и ARow строк, в текущую позицию курсора. }
      procedure InsertBuf(const aSt: Il3CString);
        overload;
      procedure InsertBuf(const aSt: Tl3PCharLenPrim);
        overload;
        {* - вставить строку aSt в тукещую позицию курсора.
           |* Пример использования метода InsertBuf.
            !begin
            ! CurrentEditor.InsertBuf(l3PCharLen('Hello world!', -1, CP_ANSI));
            ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
            !end;
           |*
        }
      function  InTable: Bool; virtual;
        {* - курсор в таблице? }
      function  InSBS: Bool;
        {* - курсор в параграфе Side By Side? }
      function  InBitmap: Bool;
        {* - курсор в картинке? }
      procedure InsertRow(aCount : Integer = 1;
                          aAtEnd : Boolean = False);
        {* - вставить строку таблицы. }
      procedure InsertColumn(aCount: Integer = 1);
        {* - вставить столбец таблицы. }
      procedure DeleteRow;
        {* - удалить текущую строку таблицы. }
      procedure DeleteColumn;
        {* - удалить столбец таблицы. }
      procedure SetOldNSRCFlag;
        {* - установить/сбросить флаг выливки таблицы как псевдографической. }
      procedure Block2Para;
        {* - преобразовать выделенный блок в параграф. }
      procedure DeleteHyperLink;
        {* - удалить гипертекстовую ссылку. }
      procedure InsertSBSPara(Left  : Tl3CustomString = nil;
                              Right : Tl3CustomString = nil);
        {* - вставить параграф Side By Side. }
      function  InsertSBSMark: Bool;
        {* - вставить разделитель параграфа Side By Side. }
      function  InsertPageBreak(NeedNewSection   : Boolean = false;
        aPageOrientation : TevPageOrientation = ev_poPortrait): Bool;
        virtual;                        
        {* - вставить разделитель страницы. }
      function  InsertPicture(aStream: TStream): Bool;
        {* - вставить картинку из потока aStream. }
      function  InsertFormula(const aFormula: String): Bool;
        {* - вставить формулу. }
      function  InsertBlock(H: Long): IevDocumentPart;
        overload;
        {* - вставить блок с идентификатором H. }
      function  InsertBlock: IevDocumentPart;
        overload;
        {* - вставить блок с автоматическим идентификатором. }
      procedure TextConvert(TCE: TevTextConvertEvent);
        {* - конвертировать выделенный блок путем замены символа на символ. }
      procedure TextBufConvert(TBCE: TevTextBufConvertEvent; DataPtr: Pointer);
        overload;
        {* - конвертировать выделенный блок путем вставки/удаления. }
      procedure TextBufConvert(TBCP: TevTextBufConvertProc);
        overload;
        {* - конвертировать выделенный блок путем вставки/удаления. }
      procedure AddAlignWithSeparator;
        {* - добавить выравнивание по разделителю. }
      procedure TextBufConvertF(TBCP: TevTextBufConvertProc);
        {* - конвертировать выделенный блок путем вставки/удаления. }
      function  MoveParaTypeCursor(anOp: Long; aTypeID: Tk2Type): Bool;
        {* - переместить курсор для типа aTypeID. (см. evOp: ev_ocCharLeft, ev_ocCharRight etc.) }
      procedure SelectWholeParas;
        {* - выровнять выделение к целым параграфам. }
      procedure SetVisibleEx(Visible: Bool);
        {* - установить признак видимости целым параграфам выделения. }
      procedure CustomPrint(const aMacroReplacer: IafwHAFMacroReplacer = nil);
        {* - печать документа с вызовом диалога настроек печати. }
      procedure AddToClipboard;
        {* - добавить выделение в буфер обмена. }
      procedure DecIndent;
        virtual;
        {* - уменьшить отступ. }
      procedure IncIndent;
        virtual;
        {* - увеличить отступ. }
      function  CanUserModify: Boolean;
        {-}
      function  NextHyperlink(anInPageDown: Boolean): Boolean;
        {-}
      function  PrevHyperlink(anInPageDown: Boolean): Boolean;
        {-}
    public
    // interface methods
      { Il3ActionProcessor }
      {$IfDef evNeedDisp}
      function Process(Sender : TObject;
                       aTarget : TObject;
                       Action : Long;
                       Down   : Bool): Bool;
        virtual;
        {-}
      {$EndIf evNeedDisp}  
    public
    // public properties
      property Color
        default clWindow;
        {-}
      property ParentColor
        default false;
        {-}
      property AutoSelect: Bool
        read f_AutoSelect
        write f_AutoSelect
        default false;
        {* - нужно ли выделять весь текст при получении редактором фокуса ввода. }
      property IsStaticText: Bool
        read pm_GetIsStaticText
        write pm_SetIsStaticText
        default false;
        {* - признак "только для чтения". }
      property ReadOnly: Bool
        read pm_GetReadOnly
        write pm_SetReadOnly
        default false;
        {* - признак "только для чтения". }
      property CanUndo: Bool
        read pm_GetcanUndo;
        {* - возможно ли Undo. }
      property CanRedo: Bool
        read pm_GetcanRedo;
        {* - возможно ли Redo. }
      property PrintDialog: TPrintDialog
        read f_PrintDialog
        write f_PrintDialog;
        {* - диалог, вызываемый при CustomPrint. }
      property Selection;
        {* - текущий курсор и выделение. }
      property Processor;
        {* - процессор операций. }
    public
    // public events
      property OnReplaceConfirm: TevReplaceConfirmEvent
        read f_OnReplaceConfirm
        write f_OnReplaceConfirm;
        {* - запрос при замене. }
      property OnSelectionChange: TNotifyEvent
        read f_OnSelectionChange
        write f_OnSelectionChange;
        {-}
      property OnHyperlinkNavigate : TNotifyEvent
        read f_OnHyperlinkNavigate
        write f_OnHyperlinkNavigate;
        {-}
      property OnMakeTextSource: TevMakeTextSourceEvent
        read f_OnMakeTextSource
        write f_OnMakeTextSource;
        {-}
  end;//TevCustomEditor

{$IfDef evNeedDisp}
var
  evEditorExtActionProcessor : Il3ActionProcessor = nil;
{$EndIf evNeedDisp}

function  evL2CB(Action: Pointer): TevTextBufConvertProc;
  {-}
procedure evFreeCB(var aStub: TevTextBufConvertProc);
  {-}

implementation

uses
  Types,
  SysUtils,
  
  Printers,

  l3Chars,
  l3MinMax,
  l3String,
  l3Printer,
  l3ScreenIC,

  k2Interfaces,
  k2Tags,

  k2TagGen,

  evdInterfaces,

  nevFacade,

  nevNavigation,

  evAlignBySeparatorUtils,
  evEditorInterfaces,
  evTableCellUtils,
  evConst,
  evExcept,
  evDef,
  evMsgCode,
  evOp,
  {$IfDef evNeedDisp}
  evStandardActions,
  {$EndIf evNeedDisp}

  evCursorContext,

  evCursorTools,
  //evTabPar,          
  evTxtRd,

  {$IfDef evNeedDisp}
  evDisp,
  {$EndIf evNeedDisp}

  evSBSTm,
  evSegLst,
  evSearch,
  evConvertTextTools,
  evParaTools,
  evTextParaTools,
  evTableSearch,
  evTableImplementation,

  Table_Const,
  TableCell_Const,
  TableRow_Const,
  Document_Const,
  SBS_Const,
  BitmapPara_Const,
  SectionBreak_Const,
  PageBreak_Const,
  Formula_Const,
  Block_Const,
  TextPara_Const
  {$IfNDef NoVCM}
  {$IFNDEF EverestLite}
  ,
  vcmHistory
  {$ENDIF EverestLite}
  {$EndIf  NoVCM}
  ;
  

// start class TevCustomEditor 

constructor TevCustomEditor.Create(anOwner: TComponent);
  //override;
  {-}
begin
 f_InCheckAACCursor := false;
 inherited;
 Color := clWindow;
 ParentColor := false;
end;

function TevCustomEditor.pm_GetCanUndo: Bool;
  {-}
begin
 Result := ((Processor <> nil) AND (Processor.CanUndo));
end;

function TevCustomEditor.pm_GetCanRedo: Bool;
  {-}
begin
 Result := ((Processor <> nil) AND (Processor.CanRedo));
end;

procedure TevCustomEditor.InsertTable(ACol, ARow: Long);
  {* - Вставить таблицу из ACol столбцов и ARow строк. }
var
 l_Table    : IedTable;
 l_Indents  : Integer;
 l_ColWidth : Long;

 procedure lp_CheckWidth;
 var
  l_TableWidth: Integer;
 begin
  if l_Table <> nil then
  begin
   l_TableWidth := ACol * l_ColWidth;
   if (l_Table.Column <> nil) and (l_Table.Column.Width < l_TableWidth) then
    l_Table.Column.Width := l_TableWidth + 2 * l_Indents;
  end; // if l_Table <> nil then
 end;

var
 l_Point       : InevBasePoint;
 l_Index       : Long;
 l_TabletTag   : Tl3Variant;
 l_TargetPoint : InevBasePoint;
 l_ParaList    : Tl3Variant;
 l_Pack        : InevOp;
 l_TableTool   : InevTable;
begin
 if (ACol > 0) AND (ARow > 0) then
 begin
  l_Pack := StartOp(ev_msgInsertPara);
  try
   l_TabletTag := k2_typTable.MakeTag.AsObject;
   try
    l_Point := Selection.Cursor.MostInner;
    l_Table := Range.Table;
    l_TargetPoint := l_Point.ParentPoint;
    l_ParaList := l_TargetPoint.Obj^.AsObject;
    if l_ParaList.IsKindOf(k2_typDocument) then
     l_ColWidth := def_inchSBSWidth
    else
    begin
     with l_ParaList do
     begin
      l_Indents := 2 * IntA[k2_tiLeftIndent];
      l_ColWidth := IntA[k2_tiWidth] - l_Indents;
     end; // with l_ParaList do
     if (l_ColWidth <= 0) then
      l_ColWidth := def_inchSBSWidth; 
    end;//l_ParaList.IsKindOf(k2_typDocument)
    l_ColWidth := l_ColWidth div ACol;
    l_ColWidth := evCheckCellWidth(l_ColWidth);
    lp_CheckWidth;
    if l_TabletTag.QT(InevTable, l_TableTool) then
     for l_Index := 1 to ARow do
      l_TableTool.AddRow(ACol, l_ColWidth, True)
    else
     Assert(False, 'Не поддерживается интерфейс InevTable!');  
    l_TargetPoint.Text.Modify.InsertBreak(View, False, l_Pack);    
    evInsertPara(l_Pack, l_TargetPoint, l_TabletTag.AsObject, []);
    l_TargetPoint.SetEntryPoint(l_TargetPoint.Position - 1, l_Pack);
    l_TargetPoint.Inner.Move(View, ev_ocTopLeft, l_Pack);
    l_Pack.MarkModified(l_TabletTag.AsObject);
   finally
    l_TabletTag := nil;
   end;//try..finally
  finally
   l_Pack := nil;
  end;//try..finally
 end;//ACol > 0..
end;

procedure TevCustomEditor.InsertBuf(const aSt: Tl3PCharLenPrim);
  {-}
begin
 TextSource.InsertBuf(View, aSt, Selection.Cursor);
end;

procedure TevCustomEditor.InsertBuf(const aSt: Il3CString);
  //overload;
begin
 TextSource.InsertBuf(View, aSt, Selection.Cursor);
end;

function TevCustomEditor.InTable: Bool;
  {-}
begin
 Result := InPara(k2_typTable);
end;

function  TevCustomEditor.InSBS: Bool;
  {-}
begin
 Result := InPara(k2_typSBS);
end;

function TevCustomEditor.InBitmap: Bool;
  {-}
begin
 Result := (Selection <> nil) AND
           Selection.Collapsed AND
           InPara(k2_typBitmapPara);
end;                                                                        

procedure TevCustomEditor.InsertRow(aCount : Integer = 1;
                                    aAtEnd : Boolean = False);
  {-вставить строку таблицы}
var
 l_Table : IevTable;
 l_Point : InevBasePoint;
begin
 l_Point := Selection.Cursor.MostInner;
 while (l_Point <> nil) do
 begin
  l_Table := TevTableImplementation.Make(View, l_Point, Processor);
  if (l_Table <> nil) then
  begin
   l_Table.InsertRows(aCount, aAtEnd);
   l_Table := nil;
   Break;
  end//Supports(OC, IevTable, T)
  else
   l_Point := l_Point.ParentPoint;
 end;//while (l_Point <> nil)}
end;

procedure TevCustomEditor.InsertColumn(aCount: Integer = 1);
  {-вставить столбец таблицы}
var
 l_Table : IevTable;
 l_Point : InevBasePoint;
begin
 l_Point := Selection.Cursor.MostInner;
 while (l_Point <> nil) do
 begin
  l_Table := TevTableImplementation.Make(View, l_Point, Processor);
  if (l_Table <> nil) then
  begin
   l_Table.InsertColumns(aCount);
   l_Table := nil;
   Break;
  end//Supports(OC, IevTable, T)
  else
   l_Point := l_Point.ParentPoint;
 end;//while (l_Point <> nil)
end;

procedure TevCustomEditor.DeleteRow;
  { - Удалить строку таблицы. }
var
 l_Table : IevTable;
 l_Point : InevBasePoint;
begin
 l_Point := Selection.Cursor.MostInner;
 while (l_Point <> nil) do
 begin
  l_Table := TevTableImplementation.Make(View, l_Point, Processor);
  if (l_Table <> nil) then
  begin
   l_Table.DeleteRow;
   l_Table := nil;
   Break;
  end//Supports(l_Point, IevTable, l_Table)
  else
   l_Point := l_Point.ParentPoint;
 end;//while (l_Point <> nil)
end;

procedure TevCustomEditor.DeleteColumn;
  { - Удалить столбец таблицы. }
var
 l_Block : InevRange;

 function lp_CheckInTable: Boolean;
 var
  l_SubRange : InevRange;
 begin
  Result := False;
  l_SubRange := l_Block.BottomChildBlock(View);
  if l_SubRange <> nil then
   Result := l_SubRange.AsObject.IsKindOf(k2_typTable);
 end;

var
 l_Table : IevTable;
 l_Point : InevBasePoint;
begin
 l_Block := InevSelection(Selection).GetBlock;
 if lp_CheckInTable then
  l_Block.Modify.Delete(View, StartOp(ev_msgDeletePara), ev_cmAll)
 else
 begin
  l_Point := Selection.Cursor.MostInner;
  while (l_Point <> nil) do
  begin
   l_Table := TevTableImplementation.Make(View, l_Point, Processor);
   if (l_Table <> nil) then
   begin
    l_Table.DeleteColumn;
    l_Table := nil;
    Break;
   end//Supports(l_Point, IevTable, l_Table)
   else
    l_Point := l_Point.ParentPoint;
  end;//while (l_Point <> nil)
 end;
end;

procedure TevCustomEditor.Block2Para;
  { - Преобразовать выделенный блок в параграф. }
var
 l_Block   : InevRange;
 l_InTable : Boolean;

 procedure lp_CheckInTable;
 var
  l_SubRange : InevRange;
  l_BS, l_BF : InevBasePoint;
 begin
  l_SubRange := l_Block.BottomChildBlock(View);
  l_InTable := l_SubRange.AsObject.IsKindOf([k2_typTableRow, k2_typTable]);
  if l_SubRange.AsObject.IsKindOf(k2_typTableCell) then
  begin
   l_SubRange.GetBorderPoints(l_BS, l_BF);
   l_InTable := l_BS.AtStart and l_BF.AtEnd(View);
  end; // if l_SubRange.IsKindOf(k2_typTableCell] then
 end;

var
 l_Mem        : Tl3String;
 l_Pack       : InevOp;
 l_Reader     : TevCustomTxtReader;
 l_Stream     : IStream;
 l_Cursor     : InevBasePoint;
 l_BS, l_BF   : InevBasePoint;
 l_ClearFlag  : TevClearMode;
 l_StoreFlags : TevdStoreFlags;
begin
 l_Pack := StartOp(ev_msgBlock2Para);
 try
  l_Mem := Tl3String.Create;
  try
   l_Block := InevSelection(Selection).GetBlock;
   try
    lp_CheckInTable;
    l_StoreFlags := evDefaultStoreFlags + [evd_sfInternal];
    if l_InTable then
    begin
     l_ClearFlag := ev_cmClearFirstCell;
     l_StoreFlags := l_StoreFlags + [evd_sfOnlyFirstCell];
    end // l_ClearFlag := ev_cmKeepOne;
    else
     l_ClearFlag := ev_cmKeepOne;
    l_Mem.CodePage := CP_OEM;
    if not l3IOk(l_Mem.QueryInterface(IStream, l_Stream)) then
     Assert(false);
    l_Block.Data.Store(cf_OEMText, l_Stream, MakeExportFilters(false, false), l_StoreFlags);
    l_Block.Modify.Delete(View, l_Pack, l_ClearFlag);
    if l_InTable then
     l_Block.GetBorderPoints(l_BS, l_BF)
    else
     l_BS := Selection.Cursor; 
   finally
    l_Block := nil;
   end;//try..finally
   l_Reader := TevCustomTxtReader.Create;
   try
    with l_Reader do
    begin
     AnalizeCharSet := False;
     Filer.CodePage := CP_OEM;
     PlainText := False;
     AddBlocks := False;
     with Criteria do
     begin
      AddSBS := False;
      EOLBeforeHeader := True;
     end;//with Criteria
     Filer.Mode := l3_fmRead;
     if not l3IOk(l_Mem.QueryInterface(IStream, l_Stream)) then
      Assert(false);
     Filer.COMStream := l_Stream;
    end;//with l_Reader..
    TextSource.DocumentContainer.TagWriter.WriteTagEx(View, l_Reader, l_BS, evDefaultLoadFlags + [ev_lfInternal]);
    if l_InTable then
     InevSelection(Selection).Unselect;
   finally
    l3Free(l_Reader);
   end;//try..finally
  finally
   l3Free(l_Mem);
  end;//try..finally
 finally
  l_Pack := nil;
 end;//try..finally
end;

function TevCustomEditor.pm_GetPlainText: Boolean;
  //override;
  {-}
begin
 Result := f_PlainText;
end;

procedure TevCustomEditor.pm_SetPlainText(aValue: Boolean);
  //override;
  {-}
begin
 f_PlainText := aValue;
end;

procedure TevCustomEditor.DeleteHyperLink;
  {-удалить гипертекстовую ссылку}
begin
 ProcessCommand(ev_msgDeleteHyperlink, True, 1);
end;

procedure TevCustomEditor.WMChar(var Msg : TWMChar);
  {message WM_CHAR;}
  {-}
begin
 if (Msg.CharCode = vk_Space) AND l3System.Keyboard.Key[vk_Shift].Down then
  if InsertSBSMark then Exit;
 inherited;
end;

procedure TevCustomEditor.WMKeyDown(var Msg : TWMKeyDown);
  {message WM_KEYDOWN;}
  {-}
begin
 if (Msg.CharCode = vk_Return) AND l3System.Keyboard.Key[vk_Shift].Down then
  if InsertPageBreak(l3System.Keyboard.Key[vk_Control].Down) then Exit;
 inherited;
end;

{$IfDef evNeedDisp}
function TevCustomEditor.Process(Sender : TObject;
                                 aTarget : TObject;      
                                 Action : Long;
                                 Down   : Bool): Bool;
  {-}
var
 l_Table : IedTable;
 l_Cell  : IedCell;
 l_Cells : IedCells;
begin
 Result := True;
 if (evEditorExtActionProcessor <> nil) AND
     evEditorExtActionProcessor.Process(Sender, Self, Action, Down) then
  Exit;
 case TevOperation(Action) of
  ev_ccUndo    : Processor.Undo;
  ev_ccRedo    : Processor.Redo;
  ev_ccDelete:
   with Range do
    if Collapsed then
     Part[ed_rpWholeWordRight].Delete
    else
     Delete;
  ev_ccCut     : Cut;
  ev_ccPaste   : Paste;
  {ev_ccInsert}
  ev_ccCopy    : Copy;
  ev_ccAdd     : AddToClipboard;
  {$IfNDef DesignTimeLibrary}
  ev_ccJustifyLeft   : TextPara.Formatting.HorizontalAligment := ed_halLeft;
  ev_ccJustifyRight  : TextPara.Formatting.HorizontalAligment := ed_halRight;
  ev_ccJustifyCenter : TextPara.Formatting.HorizontalAligment := ed_halCenter;
  ev_ccJustifyWidth  : TextPara.Formatting.HorizontalAligment := ed_halJustify;
  ev_ccJustifyPreformatted: TextPara.Formatting.HorizontalAligment := ed_halPreformatted;
  ev_ccBold          : TextPara.Font.Bold := Down;
  ev_ccItalic        : TextPara.Font.Italic := Down;
  ev_ccUnderline     : TextPara.Font.Underline := Down;
  ev_ccStrikeout     : TextPara.Font.Strikeout := Down;
  ev_ccSuperscript:
   if Down then
    TextPara.Font.Index := l3_fiSuper
   else
    TextPara.Font.Index := l3_fiNone;
  ev_ccSubscript:
   if Down then
    TextPara.Font.Index := l3_fiSub
   else
    TextPara.Font.Index := l3_fiNone;
  ev_ccVisible       : TextPara.Formatting.Visible := not Down;
  ev_ccAlignWithSeparator: AddAlignWithSeparator;
  {$EndIf  DesignTimeLibrary}
  ev_ccPrint         : Print;
  ev_ccPrintEx       : CustomPrint;
  ev_ccPrintPreview:
  begin
   WebStyle := not Down;
   if Focused then
     evOperationDispatcher.SetOpIntegerData(ev_ccPrintPreview, Ord(not WebStyle));
  end;//ev_ccPrintPreview
  ev_ccShowSpecial   : DrawSpecial := Down;
  ev_ccWebStyle :
   WebStyle := Down;
  ev_ccShowDocumentParts : begin
   if (TextSource <> nil) then
   begin
    ShowDocumentParts := Down;
    if Focused then
      evOperationDispatcher.SetOpIntegerData(ev_ccShowDocumentParts, Ord(ShowDocumentParts));
   end;//TextSource <> nil
  end;//ev_ccShowDocumentParts
  ev_ccShowDocumentPart : begin
   if Focused AND (Sender Is TComponent) then
    TextSource.ShowLevel := TComponent(Sender).Tag;
  end;//ev_ccShowDocumentPart
  ev_ccPersistent:
   Selection.Persistent := Down;
  ev_ccDrawLines:
   Selection.DrawLines := Down;
  ev_ccInsertRow:
   InsertRow;
  ev_ccInsertColumn:
   InsertColumn;
  ev_ccDeleteRow:
   DeleteRow;
  ev_ccDeleteColumn:
   DeleteColumn;
  ev_ccSelectAll:
   Select(ev_stDocument);
  ev_ccSelectPara:
   Select(ev_stPara);
  ev_ccSelectWord:
   Select(ev_stWord);
  ev_ccHideSelection:
   InevSelection(Selection).Unselect;
  ev_ccInsertSBS:
   if (ev_aptSBS in AllowParaType) then
    InsertSBSPara;
  ev_ccInsertSBSMark:
   if (ev_aptSBS in AllowParaType) then
    InsertSBSMark;
  ev_ccInsertPageBreak:
   InsertPageBreak;
  ev_ccInsertSectionBreak:
   InsertPageBreak(True);
  ev_ccOldNSRCTable:
   SetOldNSRCFlag;
  ev_ccMergeCells,
  ev_ccMergeCellsHorz,
  ev_ccMergeCellsVert :
  begin
   Result := False;
   l_Table := Range.Table;
   if (l_Table <> nil) then
   begin
    l_Cells := l_Table.Cells;
    case TevOperation(Action) of
     ev_ccMergeCellsHorz: begin
      if (l_Cells <> nil) then Result := l_Cells.Merge(ed_maHorz);
      Exit;
     end;//ev_ccMergeCellsHorz
     ev_ccMergeCellsVert: begin
      if (l_Cells <> nil) then
       Result := l_Cells.Merge(ed_maVert);
      Exit;
     end;//ev_ccMergeCellsVert
     else
      if (l_Cells <> nil) then
       Result := l_Cells.Merge;
    end;//case TevOperation(Action)
    if not Result then
    begin
     l_Cell := l_Table.Cell;
     if (l_Cell <> nil) then
      Result := l_Cell.Merge;
    end;//not Result
   end;//l_Table <> nil
  end;//ev_ccMergeCells
  ev_ccHSplit:
  begin
   Result := False;
   l_Table := Range.Table;
   if (l_Table <> nil) then
   begin
    l_Cell := l_Table.Cell;
    if (l_Cell <> nil) then
     Result := l_Cell.Split(ev_orHorizontal);
   end;//l_Table <> nil
  end;//ev_ccHSplit
  ev_ccVSplit:
  begin
   Result := False;
   l_Table := Range.Table;
   if (l_Table <> nil) then
   begin
    l_Cell := l_Table.Cell;
    if (l_Cell <> nil) then
     Result := l_Cell.Split(ev_orVertical);
   end;//l_Table <> nil
  end;//ev_ccVSplit
  ev_ccSplitTable:
  begin
   l_Table := Range.Table;
   if (l_Table = nil) then
    Result := False
   else
    Result := l_Table.Split(TextSource.Indicator);
  end;//ev_ccSplitTable
  ev_ccMergeTables: begin
   l_Table := Range.Table;
   if (l_Table = nil) then
    Result := False
   else
    Result := l_Table.Merge(TextSource.Indicator);
  end;//ev_ccMergeTables
  ev_ccVAlignTop .. ev_ccVAlignBottom:
  begin
   Result := False;
   l_Table := Range.Table;
   if (l_Table <> nil) then
   begin
    l_Cell := l_Table.Cell;
    if (l_Cell <> nil) then
    begin
     Result := True;
     l_Cell.VerticalAligment := TevVerticalAligment(Action - Ord(ev_ccVAlignTop));
     evOperationDispatcher.
      SetOpIntegerData(TevOperation(Ord(ev_ccVAlignTop) + Ord(l_Cell.VerticalAligment)), Ord(True));
    end//l_Cell <> nil
    else
    begin
     l_Cells := l_Table.Cells;
     if (l_Cells <> nil) then
     begin
      Result := True;
      l_Cells.VerticalAligment := TevVerticalAligment(Action - Ord(ev_ccVAlignTop));
      evOperationDispatcher.
       SetOpIntegerData(TevOperation(Ord(ev_ccVAlignTop) + Ord(l_Cells.VerticalAligment)), Ord(True));
     end;//l_Cells <> nil
    end;//l_Cell <> nil
   end;//l_Table <> nil
  end;//ev_ccVAlignTop..
  {$IfNDef DesignTimeLibrary}
  ev_ccBullet :
   if Down then
    TextPara.Formatting.Bullet := 1
   else
    TextPara.Formatting.Bullet := 0;
  {$EndIf  DesignTimeLibrary}
  ev_ccDecIndent : DecIndent;
  ev_ccIncIndent : IncIndent;
  ev_ccTranslate2Text : begin
     Result := True;
     if not InSBS then
     begin
      l_Table := Range.Table;
      if (l_Table <> nil) then
      begin
       l_Cells := l_Table.Cells;
       l_Cells.Translate2Text;
      end; // if (l_Table <> nil) then
     end; // if not InSBS then
    end; // ev_ccTranslate2Text
  else
   Result := False;
 end;//case TevOperation(Action)
end;
{$EndIf evNeedDisp}

procedure TevCustomEditor.WMSetFocus(var Msg : TWMSetFocus);
  {message WM_SETFOCUS;}
  {-}
{$IfDef evNeedDisp}
var
 InO : TevOperationSet;
 ExO : TevOperationSet;
{$EndIf evNeedDisp}
begin
 {$IfDef evNeedDisp}
 if ReadOnly then
 begin
  ExO := evJustifyCommands + evFontCommands + evInsertCommands +
         evSaveCommands - [ev_ccSaveAs] + [ev_ccBordersAndShade] +
         [ev_ccReplace, ev_ccSpellcheck] + [ev_ccDelete] + evListCommands +
         [ev_ccCut] + evTableCommands;
  InO := evSelectCommands + evViewCommands + [ev_ccSaveAs] +
         evPrintCommands + evSearchCommands;
 end//ReadOnly
 else
 begin
  ExO := [];
  InO := evJustifyCommands + evFontCommands + evSelectCommands
       + evInsertCommands  + evViewCommands + evSaveCommands
       + evPrintCommands + evSearchCommands + [ev_ccBordersAndShade] + [ev_ccDelete]
       + evListCommands;
 end;//ReadOnly
 if InTable or not CanEdit then
  ExO := ExO + evBreakCommands
 else
  InO := InO + evBreakCommands;
 if (TextSource <> nil) then
 begin
  with TextSource.Processor do
  begin
   if CanUndo and CanEdit then
    Include(InO, ev_ccUndo)
   else
    Include(ExO, ev_ccUndo);
   if CanRedo and CanEdit then
    Include(InO, ev_ccRedo)
   else
    Include(ExO, ev_ccRedo);
  end;//with TextSource.Processor.UndoBuffer
 end;//TextSource <> nil
 if (ev_aptTable in AllowParaType) and CanEdit then
  Include(InO, ev_ccInsertTable)
 else
  Include(ExO, ev_ccInsertTable);
 if InSBS AND (ev_aptSBS in AllowParaType) then
 begin
  if CanEdit then
   InO := InO + [ev_ccVAlignTop .. ev_ccVAlignBottom];
  ExO := ExO + [ev_ccInsertSBS, ev_ccInsertSBSMark, ev_ccInsertTable]
             + evTableCommands;
 end//InSBS AND (ev_aptSBS in AllowParaType)
 else
 begin
  if InTable and CanEdit then
   InO := InO + evTableCommands
  else
   ExO := ExO + evTableCommands;
 end;
 if HasSelection then
  InO := InO + evBlockCommands
 else
  ExO := ExO + evBlockCommands;
 if InBitmap then
  InO := InO + [ev_ccCopy];
 InO := InO - ExO;
 with evOperationDispatcher do
 begin
  ExcludeOperations(ExO);
  IncludeOperations(InO);
  SetOpIntegerData(ev_ccShowSpecial, Ord(Canvas.DrawSpecial));
  if (Selection <> nil) then
   SetOpIntegerData(ev_ccDrawLines, Ord(Selection.DrawLines));
  if (TextSource = nil) then
  begin
   SetOpIntegerData(ev_ccPrintPreview, Ord(false));
   SetOpIntegerData(ev_ccShowDocumentParts, Ord(false));
  end//TextSource = nil
  else
  begin
   SetOpIntegerData(ev_ccPrintPreview,
         Ord(not WebStyle));
   SetOpIntegerData(ev_ccShowDocumentParts, Ord(ShowDocumentParts));
  end;//TextSource = nil
  SetOpIntegerData(ev_ccWebStyle, Ord(WebStyle));
  if (Selection <> nil) then
   SetOpIntegerData(ev_ccPersistent, Ord(Selection.Persistent));
 end;//with evOperationDispatcher
 {$EndIf evNeedDisp}
 inherited;
end;

procedure TevCustomEditor.WMKillFocus(var Msg : TWMKillFocus);
  {message WM_KILLFOCUS;}
  {-}
{$IfDef evNeedDisp}
var
 EO : TevOperationSet;
{$EndIf evNeedDisp} 
begin
 {$IfDef evNeedDisp}
 EO := evJustifyCommands + evFontCommands + evSelectCommands
       + evBlockCommands + evUndoCommands + evTableCommands
       + evInsertCommands + evViewCommands + evSaveCommands
       + evPrintCommands + evSearchCommands - [ev_ccZoom] + [ev_ccInsertTable]
       + [ev_ccBordersAndShade] + [ev_ccDelete] + evBreakCommands
       + evListCommands;
 evOperationDispatcher.ExcludeOperations(EO);
 {$EndIf evNeedDisp}
 inherited;
end;

function TevCustomEditor.AllowAutoSelectByMouse: Boolean;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevCustomEditor.CMEnter(var Message: TCMGotFocus);
  {message CM_ENTER;}
  {-}
begin
 if AutoSelect AND
    (AllowAutoSelectByMouse OR not (csLButtonDown in ControlState)) then
  Select(ev_stDocument);
 inherited;
end;

procedure TevCustomEditor.BlockChange;
  {override;}
  {-}
begin
 inherited;
 {$IfDef evNeedDisp}
 if Focused then
  with evOperationDispatcher do
  begin
   if HasSelection then
    IncludeOperations(evBlockCommands)
   else
    ExcludeOperations(evBlockCommands);
   if ReadOnly then
    OperationEnabled[ev_ccCut] := false;
   if InBitmap then
    OperationEnabled[ev_ccCopy] := true;
  end;//with evOperationDispatcher
 {$EndIf evNeedDisp}
 if Assigned(f_OnSelectionChange) then
  f_OnSelectionChange(Self);
end;

procedure TevCustomEditor.ParaChange;
  {override;}
  {-}
{$IfDef evNeedDisp}
var
 l_TextPara : IedTextParagraph;
 l_Range    : IedRange;
 l_Table    : IedTable;
 l_Cell     : IedCell;
 l_Cells    : IedCells;
{$EndIf evNeedDisp}
begin
 inherited;
 {$IfDef evNeedDisp}
 if Focused then
 begin
  {$IfDef DesignTimeLibrary}
  l_TextPara := nil;
  {$Else  DesignTimeLibrary}
  l_TextPara := TextPara;
  {$EndIf DesignTimeLibrary}
  try
   with evOperationDispatcher do
   begin
    {$IfNDef DesignTimeLibrary}
    try
     SetOpIntegerData(ev_ccBullet, l_TextPara.Formatting.Bullet);
    except
     on Ek2ParamNotDefined do ;
    end;//try..except
    try
     SetOpIntegerData(TevOperation(Ord(ev_ccJustifyLeft) + Pred(Ord(l_TextPara.Formatting.HorizontalAligment))), Ord(true));
    except
     on Ek2ParamNotDefined do ;
    end;{try..except}
    try
     SetOpIntegerData(TevOperation(Ord(ev_ccAlignWithSeparator)), Ord(l_TextPara.Formatting.HasDecimalAligment));
    except
     on Ek2ParamNotDefined do ;
    end;{try..except}
    try
     SetOpIntegerData(ev_ccVisible, Ord(not l_TextPara.Formatting.Visible));
    except
     on Ek2ParamNotDefined do ;
    end;//try..except
    {$EndIf DesignTimeLibrary}
    if InTable then
     ExcludeOperations(evBreakCommands)
    else
     IncludeOperations(evBreakCommands);
    if InSBS AND (ev_aptSBS in AllowParaType) then
    begin
     ExcludeOperations((evTableCommands  - [ev_ccVAlignTop .. ev_ccVAlignBottom]) +
                        [ev_ccInsertSBS, ev_ccInsertSBSMark, ev_ccInsertTable]);
     if CanEdit then
      IncludeOperations([ev_ccVAlignTop .. ev_ccVAlignBottom]);
    end//InSBS AND (ev_aptSBS in AllowParaType)
    else
    begin
     if InTable and CanEdit then
      IncludeOperations(evTableCommands)
     else
      ExcludeOperations(evTableCommands);
     if (ev_aptSBS in AllowParaType) and CanEdit then
      IncludeOperations([ev_ccInsertSBS, ev_ccInsertSBSMark]);
     if (ev_aptTable in AllowParaType) and CanEdit then
      IncludeOperations([ev_ccInsertTable])
     else
      ExcludeOperations([ev_ccInsertTable]);
     if InBitmap then
      OperationEnabled[ev_ccCopy] := true;
    end;//InSBS
    l_Range := Range;
    if (l_Range <> nil) then
    begin
     l_Table := l_Range.Table;
     if (l_Table <> nil) then
     begin
      SetOpIntegerData(ev_ccOldNSRCTable, Ord(l_Table.OldNSRC));
      l_Cell := l_Table.Cell;
      if (l_Cell <> nil) then
      begin
       if CanEdit then
        IncludeOperations(evVAlignCommands)
       else
        ExcludeOperations(evVAlignCommands);
       SetOpIntegerData(TevOperation(Ord(ev_ccVAlignTop) + Ord(l_Cell.VerticalAligment)), Ord(true));
      end//l_Cell <> nil
      else
      begin
       l_Cells := l_Table.Cells;
       if (l_Cells <> nil) then
       begin
        if CanEdit then
         IncludeOperations(evVAlignCommands)
        else
         ExcludeOperations(evVAlignCommands);
        SetOpIntegerData(TevOperation(Ord(ev_ccVAlignTop) + Ord(l_Cells.VerticalAligment)), Ord(true));
       end//l_Cells <> nil
       else
        ExcludeOperations(evVAlignCommands)
      end;//l_Cell <> nil
     end//l_Table <> nil
     else
      ExcludeOperations(evVAlignCommands)
    end;//l_Range <> nil
   end;//evOperationDispatcher
  finally
   l_TextPara := nil;
  end;//try..finally
 end;//Focused
 {$EndIf evNeedDisp}
end;

procedure TevCustomEditor.DoFontChange(const Font: Il3Font);
  {override;}
  {-}
{$IfDef evNeedDisp}
var
 F : Il3FontInfo;
{$EndIf evNeedDisp} 
begin
 inherited;
 {$IfDef evNeedDisp}
 if l3IOk(QueryInterface(Il3FontInfo, F)) then
  try
   with F do
   begin
    with evOperationDispatcher do
    begin
     SetOpIntegerData(ev_ccUnderline, Ord(Underline));
     SetOpIntegerData(ev_ccBold, Ord(Bold));
     SetOpIntegerData(ev_ccItalic, Ord(Italic));
     SetOpIntegerData(ev_ccStrikeout, Ord(Strikeout));
     SetOpIntegerData(ev_ccSuperscript, Ord(Index = l3_fiSuper));
     SetOpIntegerData(ev_ccSubscript, Ord(Index = l3_fiSub));
    end;//with evOperationDispatcher
   end;//with Font
  finally
   F := nil;
  end;//try..finally
 {$EndIf evNeedDisp}
end;

function TevCustomEditor.ReplaceConfirm(const aBlock        : InevRange;
                                        AlienReplaceConfirm : TevReplaceConfirmEvent): ShortInt;
  {-}
begin
 if Assigned(AlienReplaceConfirm) then
  Result := inherited ReplaceConfirm(aBlock, AlienReplaceConfirm)
 else
  Result := inherited ReplaceConfirm(aBlock, f_OnReplaceConfirm);
end;

function TevCustomEditor.AdjustForm2Found(Form: TForm): TForm;
  //virtual;
  {-}
var
 l_StartSPoint,
 l_FinishSPoint    : Tl3SPoint;
 l_FormTLPoint,
 l_FormBRPoint     : TPoint;
 l_Start, l_Finish : InevBasePoint;
 l_StartRect,
 l_FinishRect      : TnevRect;
 l_TempRect        : TRect;

 procedure l_CorrectFormPosition;
 var
  l_Shift: Integer;
  l_SpaceUnder, l_SpaceAbove: Integer;
 begin
  l_SpaceUnder := Height - l_FinishSPoint.Y;
  if l_SpaceUnder < 0 then
   l_SpaceUnder := 0;
  l_SpaceAbove := l_StartSPoint.Y;
  if l_SpaceAbove < 0 then
   l_SpaceAbove := 0;
  if l_SpaceAbove > Form.Height then
   l_Shift := (l_SpaceAbove - Form.Height) div 2 - l_FormTLPoint.Y
  else
   if l_SpaceUnder > Form.Height then
    l_Shift := (l_FinishSPoint.Y + (l_SpaceUnder - Form.Height) div 2) - l_FormTLPoint.Y
   else
    l_Shift := 0; // не можем двигать...
  if l_Shift <> 0 then
   Form.Top := Form.Top + l_Shift;
 end;

var
  l_InfoCanvas : Il3InfoCanvas;
  l_Map        : InevMap;
begin
 Result := Form;
 if (Form = nil) OR (Selection = nil) OR (View = nil) then
  Exit;
 l_Map := View.RootMap;
 if (l_Map = nil) then
  Exit; 
 InevSelection(Selection).GetBlock.GetBorderPoints(l_Start, l_Finish);
 if Assigned(l_Start) and Assigned(l_Finish) then // есть ли найденный фрагмент?
 begin
  l_InfoCanvas := l3CrtIC;
  try
   l_FormTLPoint := ScreenToClient(Form.BoundsRect.TopLeft);
   l_FormBRPoint := ScreenToClient(Form.BoundsRect.BottomRight);
   if not IntersectRect(l_TempRect, ClientRect,
      Rect(l_FormTLPoint.X, l_FormTLPoint.Y, l_FormBRPoint.X, l_FormBRPoint.Y)) then
    Exit; // форма поиска и редактор не пересекаются - значит и поправлять ничего не надо

   l_StartRect := l_Start.ViewBounds(View, l_Map);
   l_FinishRect := l_Finish.ViewBounds(View, l_Map);

   if Tl3Rect(l_StartRect).EQ(nevRect0) then
    l_StartSPoint.Init(0, 0)
   else
    l_StartSPoint := l_InfoCanvas.LP2DP(l_StartRect.R.TopLeft);
   if Tl3Rect(l_StartRect).EQ(nevRect0) then
    l_FinishSPoint.Init(Width, Height)
   else
    l_FinishSPoint := l_InfoCanvas.LP2DP(l_FinishRect.R.BottomRight);

   if l_FormTLPoint.Y < l_StartSPoint.Y then
   begin
    if l_FormBRPoint.Y < l_StartSPoint.Y then
     Exit; // Вся форма находится над блоком - ничего делать не надо
    l_CorrectFormPosition;
    Exit;
   end;
   if l_FormTLPoint.Y < l_FinishSPoint.Y then
    l_CorrectFormPosition;
  finally
   l_InfoCanvas := nil;
  end;
 end;
end;

procedure TevCustomEditor.MakeTextSource(out theTextSource: TevCustomTextSource);
  //override;
  {-}
begin
 theTextSource := nil;
 if Assigned(f_OnMakeTextSource) then
  f_OnMakeTextSource(Self, theTextSource);
end;

procedure TevCustomEditor.InsertSBSPara(Left  : Tl3CustomString = nil;
                                        Right : Tl3CustomString = nil);
  {-вставить параграф Side By Side}
var
 G : Ik2TagGenerator;
begin
 G := TextSource.GetGenerator(View, Selection);
 try
  G.Start;
  try
   G.StartChild(k2_typDocument);
   try
    evSBSTm.OutSBS(G, Left, Right);
   finally
    G.Finish;
   end;//try..finally
  finally
   G.Finish;
  end;//try..finally
 finally
  G := nil;
 end;//try..finally
end;

function TevCustomEditor.InsertBlock(H: Long): IevDocumentPart;
  {-вставить блок}
begin
 Result := TextSource.InsertDocumentPart(View, Selection, H, ev_ibRaiseIfBlock);
end;

function TevCustomEditor.InsertBlock: IevDocumentPart;
  {-вставить блок}
begin
 Result := TextSource.InsertDocumentPart(View, Selection, -1, ev_ibRaiseIfBlock);
end;

function TevCustomEditor.InsertSBSMark: Bool;
  {-вставить разделитель параграфа Side By Side}
var
 P      : Tl3Variant;
 Whole  : Tl3CustomString;
 Left   : Tl3String;
 Right  : Tl3String;
 l_Pos  : Long;
 G      : Ik2TagGenerator;
 l_Pack : InevOp;
 l_Para : InevObject;
begin
 if (ev_aptSBS in AllowParaType) then
 begin
  Result := true;
  P := CurPara;
  if (P.IsKindOf(k2_typTextPara)) AND
     (P.Owner.IsKindOf(k2_typBlock)) then
  begin
   l_Pack := StartOp(ev_msgInsertPara);
   try
    try
     Left := Tl3String.Create;
     try
      Right := Tl3String.Create;
      try
       l_Pos := Selection.Cursor.MostInner.Position;
       with P.Attr[k2_tiText] do
        if IsValid then
         Whole := AsObject As Tl3CustomString
        else
         Whole := nil;
       if not Whole.Empty then
       begin
        Left.AsPCharLen := l3PCharLen(Whole.St, l_Pos, Whole.CodePage);
        Left.TrimAll;
        Right.AsPCharLen := l3PCharLen(Whole.St + l_Pos, Whole.Len - l_Pos, Whole.CodePage);
        Right.TrimAll;
       end;//not Whole.Empty
       l_Para := Selection.Cursor.MostInner.Obj^;
       l_Para.Range.Modify.Delete(View, l_Pack);
       G := TextSource.GetGenerator(View, Selection);
       try
        G.Start;
        try
         G.StartChild(k2_typDocument);
         try
          evSBSTm.OutSBS(G, Left, Right);
         finally
          G.Finish;
         end;//try..finally
        finally
         G.Finish;
        end;//try..finally
       finally
        G := nil;
       end;//try..finally
       if MoveParaTypeCursor(ev_ocTopLeft, k2_typSBS) then
        MoveLeafCursor(ev_ocParaRight, true);
       if l_Para.PID >= 0 then
        l_Para.Edit.Delete(False, l_Pack);
      finally
       l3Free(Right);
      end;//try..finally
     finally
      l3Free(Left);
     end;//try..finally
    except
     on EevReadOnly do
     begin
      l_Pack.Undo(Processor);
      Result := false;
     end;//on EevReadOnly
    end;//try..except
   finally
    l_Pack := nil;
   end;//try..finally
  end;//..k2_idTextPara..
 end//(ev_aptSBS in AllowParaType)
 else
  Result := false;
end;

function TevCustomEditor.InsertPageBreak(NeedNewSection   : Bool = false;
                                         aPageOrientation : TevPageOrientation = ev_poPortrait): Bool;
  {-вставить разделитель параграфа Side By Side}
var
 G    : Ik2TagGenerator;
 Pack : InevOp;
begin
 if (ev_aptPageBreak in AllowParaType) then
 begin
  Result := true;
  if not InTable then
  begin
   Pack := StartOp(ev_msgInsertPara);
   try
    Range.Delete(ev_cmAll);
    G := TextSource.GetGenerator(View, Selection);
    try
     G.Start;
     try
      G.StartChild(k2_typDocument);
      try
       if NeedNewSection then
       begin
        G.StartChild(k2_typSectionBreak);
        if (aPageOrientation <> ev_poPortrait) then
        begin
         G.StartTag(k2_tiParas);
         try
          G.AddIntegerAtom(k2_tiOrientation, Ord(aPageOrientation));
         finally
          G.Finish;
         end;//try..finally
        end;//aPageOrientation <> ev_poPortrait
       end//NeedNewSection
       else
        G.StartChild(k2_typPageBreak);
       G.Finish;
      finally
       G.Finish;
      end;//try..finally
     finally
      G.Finish;
     end;//try..finally
    finally
     G := nil;
    end;//try..finally
    if MoveParaTypeCursor(ev_ocTopLeft, k2_typPageBreak) then
     MoveLeafCursor(ev_ocParaRight, true);
   finally
    Pack := nil;
   end;//try..finally
  end;//..k2_idTextPara..
 end else
  Result := false; 
end;

function TevCustomEditor.InsertPicture(aStream: TStream): Bool;
  {-вставить картинку}
var
 G    : Ik2TagGenerator;
 Pack : InevOp;
begin
 if (ev_aptPicture in AllowParaType) then
 begin
  Result := true;
  Pack := StartOp(ev_msgInsertPara);
  try
   Range.Delete(ev_cmAll);
   G := TextSource.GetGenerator(View, Selection);
   try
    G.Start;
    try
     G.StartChild(k2_typDocument);
     try
      G.StartChild(k2_typBitmapPara);
      try
       G.AddStreamAtom(k2_tiData, aStream);
      finally
       G.Finish;
      end;//try..finally
     finally
      G.Finish;
     end;//try..finally
    finally
     G.Finish;
    end;//try..finally
   finally
    G := nil;
   end;//try..finally
   if MoveParaTypeCursor(ev_ocTopLeft, k2_typBitmapPara) then
    MoveLeafCursor(ev_ocParaRight, true);
  finally
   Pack := nil;
  end;//try..finally
 end//(ev_aptPicture in AllowParaType)
 else
  Result := false;
end;

function TevCustomEditor.InsertFormula(const aFormula: String): Bool;
  {* - вставить формулу. }
var
 G    : Ik2TagGenerator;
 Pack : InevOp;
begin
 if (ev_aptFormula in AllowParaType) and (aFormula <> '') then
 begin
  Result := true;
  Pack := StartOp(ev_msgInsertPara);
  try
   Range.Delete(ev_cmAll);
   G := TextSource.GetGenerator(View, Selection);
   try
    G.Start;
    try
     G.StartChild(k2_typDocument);
     try
      G.StartChild(k2_typFormula);
      try
       G.AddStringAtom(k2_tiText, aFormula);
      finally
       G.Finish;
      end;//try..finally
     finally
      G.Finish;
     end;//try..finally
    finally
     G.Finish;
    end;//try..finally
   finally
    G := nil;
   end;//try..finally
   if MoveParaTypeCursor(ev_ocTopLeft, k2_typFormula) then
    MoveLeafCursor(ev_ocParaRight, true);
  finally
   Pack := nil;
  end;//try..finally
 end//(ev_aptFormula in AllowParaType)
 else
  Result := false;
end;

procedure TevCustomEditor.TextConvert(TCE: TevTextConvertEvent);
  {-конвертировать выделенный блок}
var
 l_Op : TevSearchOptionSet;
begin
 l_Op := [ev_soGlobal, ev_soSelText, ev_soReplaceAll];
 Find(TevAnyParagraphSearcher.Make,
      TevInPlaceTextConverter.Make(TCE, l_Op), l_Op);
 InevSelection(Selection).Unselect; // http://mdp.garant.ru/pages/viewpage.action?pageId=330139532
end;

procedure TevCustomEditor.TextBufConvert(TBCE: TevTextBufConvertEvent; DataPtr: Pointer);
  {-конвертировать выделенный блок поблочно}

 function DoText(var aStr : Tl3PCharLen): Boolean;
 var
  l_CP : SmallInt;
 begin//DoText
  l_CP := aStr.SCodePage;
  Result := TBCE(Self, aStr.S, aStr.SLen, l_CP, DataPtr);
  aStr.SCodePage := l_CP;
 end;//DoText

begin
 if Assigned(TBCE) then
  TextBufConvertF(evL2CB(@DoText));
end;

procedure TevCustomEditor.TextBufConvert(TBCP: TevTextBufConvertProc);
  //overload;
  {* - конвертировать выделенный блок путем вставки/удаления. }
var
 l_Op : TevSearchOptionSet;
begin
 l_Op := [ev_soGlobal, ev_soSelText, ev_soReplaceAll];
 Find(TevAnyParagraphSearcher.Make,
      TevTextConverter.Make(TBCP, l_Op), l_Op);
end;

procedure TevCustomEditor.TextBufConvertF(TBCP: TevTextBufConvertProc);
  {* - конвертировать выделенный блок путем вставки/удаления. }
begin
 try
  TextBufConvert(TBCP);
 finally
  evFreeCB(TBCP);
 end;//try..finally
end;

function TevCustomEditor.MoveParaTypeCursor(anOp: Long; aTypeID: Tk2Type): Bool;
  {* - переместить курсор для типа aTypeID. (см. evOp: ev_ocCharLeft, ev_ocCharRight etc.) }
var
 l_Cursor : InevBasePoint;
begin
 if InPara(aTypeID, l_Cursor) then
  Result := l_Cursor.Move(View, anOp, StartOp(ev_msgMove))
 else
  Result := false; 
end;

procedure TevCustomEditor.SelectWholeParas;
  {-}
var
 Pack : InevOp;
begin
 Pack := StartOp(ev_msgMove);
 try
  if HasSelection then
   with Selection do
   begin
    Start.MostInner.Move(View, ev_ocTopLeft, Pack);
    Finish.MostInner.Move(View, ev_ocBottomRight, Pack);
   end//with Selection
  else
   Select(ev_stPara);
 finally
  Pack := nil;
 end;//try..finally
end;

procedure TevCustomEditor.SetVisibleEx(Visible: Bool);
  {-}
{$IfNDef DesignTimeLibrary}
var
 Pack : InevOp;
{$EndIf  DesignTimeLibrary}
begin
 {$IfNDef DesignTimeLibrary}
 Pack := StartOp;
 try
  SelectWholeParas;
  TextPara.Formatting.Visible := Visible;
 finally
  Pack := nil;
 end;//try..finally
 {$EndIf DesignTimeLibrary}
end;

procedure TevCustomEditor.CustomPrint(const aMacroReplacer: IafwHAFMacroReplacer = nil);
  {-}
var
 l_Printer       : TPrinter;
 l_l3Printer     : Tl3Printer;
 l_PrintDialog   : TPrintDialog;
 l_PrintSelection: Boolean;
begin
 l_PrintDialog := Self.PrintDialog;
 if (l_PrintDialog = nil) AND (TextSource <> nil) then
  l_PrintDialog := TextSource.PrintDialog;
 if (l_PrintDialog = nil) then
  Print(nil, false)
 else
 begin
  l_l3Printer := Tl3Printer.Create;
  try
   l_Printer := Printer;
   try
    SetPrinter(l_l3Printer);
    if HasSelection then
     l_PrintDialog.Options := l_PrintDialog.Options + [poSelection]
    else
     l_PrintDialog.Options := l_PrintDialog.Options - [poSelection];
    {$IFDEF nsTest}
    l_PrintSelection := HasSelection;
    {$ELSE}
    if l_PrintDialog.Execute then
    begin
     l_PrintSelection := l_PrintDialog.PrintRange = prSelection;
    {$ENDIF nsTest}
     Print(l_l3Printer, l_PrintSelection, aMacroReplacer);
    {$IFNDEF nsTest}
    end;
    {$ENDIF nsTest}
   finally
    SetPrinter(l_Printer);
   end;//try..finally
  finally
   l3Free(l_l3Printer);
  end;//try..finally
 end;//_PrintDialog = nil
end;

procedure TevCustomEditor.AddToClipboard;
  {-}
begin
 {$IfDef evUseOleClipboard}
 if not CopyToClipboardEx(cf_EverestBin, true) then
 {$EndIf evUseOleClipboard}
 begin
  if OpenClipboard(Handle) then
   try
    CopyToClipboardEx(cf_EverestBin, true);
    CopyToClipboardEx(cf_Text, true);
    CopyToClipboardEx(cf_OEMText, true);
   finally
    CloseClipboard;
   end;//try..finally
 end;
end;

procedure TevCustomEditor.DecIndent;
  {* - уменьшить отступ. }
begin
 {$IfDef evNeedMarkers}
 {$IfNDef DesignTimeLibrary}
 with TextPara.Formatting do
  FirstIndent := FirstIndent - (evInchMul div 2);
 {$EndIf  DesignTimeLibrary}
 {$EndIf evNeedMarkers}
end;

procedure TevCustomEditor.IncIndent;
  {* - увеличить отступ. }
begin
 {$IfDef evNeedMarkers}
 {$IfNDef DesignTimeLibrary}
 with TextPara.Formatting do
  FirstIndent := FirstIndent + (evInchMul div 2);
 {$EndIf DesignTimeLibrary}
 {$EndIf evNeedMarkers}
end;

function TevCustomEditor.CanUserModify: Boolean;
  {-}
begin
 Result := not IsStaticText AND HasDocument AND TextSource.CanUserModify;
end;

function TevCustomEditor.SearchHyperLinkAddress(aSearchDown: Boolean;
                                                aSearchGlobal: Boolean;
                                                const anAddress : TevAddress): Boolean;
  {-}
var
 l_Opt: TevSearchOptionSetEx;
 l_Op: InevOp;
 l_Searcher : TevHyperlinkSearcher;
begin
 Result := false;
 // после переключения баз Selection = nil в ААК-Оглавлении
 // http://mdp.garant.ru/pages/viewpage.action?pageId=404361039
 if (AACLike = nev_aacLeft) AND (Selection = nil) then
  MakeCursor;
 if not f_InCheckAACCursor AND (Selection <> nil) then
 begin
  if aSearchDown then
   l_Opt := []
  else
   l_Opt := [ev_soBackward];
  if aSearchGlobal then
   Include(l_Opt, ev_soGlobal);
  if (AACLike = nev_aacLeft) then
   Include(l_Opt, ev_soIngoreExternalLink);
  try
   l_Op := Processor.StartOp;
   try
    l_Searcher := TevHyperlinkSearcher.Create;
    try
     l_Searcher.SearchHyperAddress := anAddress;
     f_InCheckAACCursor := true;
     try
      Result := Find(l_Searcher, nil, l_Opt);
     finally
      f_InCheckAACCursor := false;
     end;//try..finally
    finally
     FreeAndNil(l_Searcher);
    end;//try..finally
    //Result := true;
   finally
    l_Op := nil;
   end;//try..finally
  except
   on EevSearchFailed do
    Result := false;
  end;//try..except
 end; 
end;

function TevCustomEditor.DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean;
var
 l_Op: InevOp;
begin
 Result := false;
 if (Selection <> nil) then
 begin          
  try
   l_Op := Processor.StartOp;
   try
    Find(TevCustomHyperlinkSearcher.Make, nil, anOption);
    Result := true;
   finally
    l_Op := nil;
   end;//try..finally
  except
   on EevSearchFailed do
    Result := false;
  end;//try..except
 end;
 if Result then
  if not f_InCheckAACCursor then
   if Assigned(f_OnHyperlinkNavigate) then
    f_OnHyperlinkNavigate(Self);
end;

function TevCustomEditor.NextHyperlink(anInPageDown: Boolean): Boolean;
var
 l_Opt: TevSearchOptionSetEx;
begin
 l_Opt := [];
 if anInPageDown and View.IsDocumentTailVisible then
  l_Opt := [ev_soBackward, ev_soInPageDown];
 Result := DoSearchHyperLink(l_Opt);
end;

function TevCustomEditor.PrevHyperlink(anInPageDown: Boolean): Boolean;
var
 l_Opt: TevSearchOptionSetEx;
begin
 l_Opt := [ev_soBackward];
 if anInPageDown and View.TopAnchor.AtStart then
  l_Opt := [ev_soInPageUp];
 Result := DoSearchHyperLink(l_Opt);
end;

function TevCustomEditor.pm_GetIsStaticText: Boolean;
  {-}
begin
 Result := IsReadOnly;
end;

procedure TevCustomEditor.pm_SetIsStaticText(aValue: Boolean);
  {-}
begin
 Perform(EM_SetReadOnly, WParam(aValue), 0);
end;

function TevCustomEditor.pm_GetReadOnly: Bool;
  {-}
begin
 Result := IsStaticText;
end;

procedure TevCustomEditor.pm_SetReadOnly(Value: Bool);
  {-}
begin
 IsStaticText := Value;
end;

function  evL2CB(Action: Pointer): TevTextBufConvertProc;
  {-}
  register;
  {-}
asm
          jmp  l3LocalStub
end;

procedure evFreeCB(var aStub: TevTextBufConvertProc);
  {-}
  register;
  {-}
asm
          jmp  l3FreeLocalStub
end;{asm}

procedure TevCustomEditor.AddAlignWithSeparator;
var
 l_TabIndent : Long;
 l_Table     : InevPara;

 function CheckRow(const aSelection : InevRange;
                         anIndex    : Long): Boolean;

  function CheckCell(const aSelection : InevRange;
                           anIndex    : Long): Boolean;

   function CheckText(const aSelection : InevRange;
                            anIndex    : Long): Boolean;
   var
    l_Pos      : Long;
    l_TextPara : InevTextPara;
    l_Value    : Long;
    l_FI       : TnevFormatInfoPrim;
   begin
    aSelection.Obj.AsObject.QT(InevTextPara, l_TextPara);
    if l_TextPara <> nil then
    begin
     l_FI := View.FormatInfoByPara(l_TextPara);
     l_Pos := EvGetSeparatorPos(l_TextPara, l_FI);
     if l_Pos > 1 then
     begin
      l_Value := evTextParaGetDeltaByPos(l_FI, l_TextPara.Text, l_TextPara, l_Pos, 1);
      l_Value := l_FI.ClientToParent(l_Value);
      l_TabIndent := Max(l_TabIndent, l_Value);
      if l_Table = nil then
       l_Table := l_TextPara.OwnerPara.OwnerPara.OwnerPara;
     end; // if l_Pos > 1 then
    end; // if l_TextPara <> nil then
    Result := False;
   end;

  begin
   aSelection.IterateF(evL2TSA(@CheckText));
   Result := True;
  end;

 begin
  aSelection.IterateF(evL2TSA(@CheckCell));
  Result := True;
 end;

var
 l_Block      : InevRange;
 l_ChildRange : InevRange;
begin
 l_Block := InevSelection(Selection).GetBlock;
 if l_Block <> nil then
 begin
  l_ChildRange := l_Block.BottomChildBlock(View);
  l_TabIndent := 0;
  l_ChildRange.IterateF(evL2TSA(@CheckRow));
  if l_TabIndent > 0 then
  begin
   Selection.AddIndentMarker(l_TabIndent);
   l_Table.Invalidate([nev_spExtent]);
   DoMarkerChange;
  end;//if l_TabIndent > 0 then
 end;//if l_Cursor <> nil then
end;

procedure TevCustomEditor.DoDrawSpecialChange(Sender: TObject);
begin
 inherited DoDrawSpecialChange(Sender);
{$IfDef evNeedDisp}
 if Focused then
  evOperationDispatcher.SetOpIntegerData(ev_ccShowSpecial, Ord(Canvas.DrawSpecial));
{$EndIf evNeedDisp}
end;

procedure TevCustomEditor.SetOldNSRCFlag;
var
 l_Range : IedRange;
 l_Table : IedTable;
begin
 if HasSelection then
  Find(TevFirstTableCellSearcher.Make, TevOldNSRCFlagReplacer.Make, [ev_soGlobal, ev_soSelText, ev_soUseInternalCursor, ev_soReplace, ev_soReplaceAll])
 else
 begin
  l_Range := Range;
  if l_Range <> nil then
  begin
   l_Table := l_Range.Table;
   if l_Table <> nil then
   begin
    l_Table.OldNSRC := not l_Table.OldNSRC;
 {$IfDef evNeedDisp}
    evOperationDispatcher.SetOpIntegerData(ev_ccOldNSRCTable, Ord(l_Table.OldNSRC));
 {$EndIf evNeedDisp}
   end // if l_Table <> nil then
  end; // if l_Range <> nil then
 end; // if HasSelection then
end;

function TevCustomEditor.CanEdit: Boolean;
begin
 {$IFDEF ARCHI}
 Result := not ReadOnly
 {$ELSE}
 Result := True;
 {$ENDIF ARCHI}
end;

function TevCustomEditor.CheckAACMode(aCommand: Long; aForce: Boolean; aCount: Integer): Boolean;
begin
 Result := AACLike in [nev_aacLeft, nev_aacRight];
 if Result then
 begin
  if (aCommand >= ev_ocExtLineDown) and (aCommand <= ev_ocExtWordRight) then Exit;
  case aCommand of
    ev_ocPageUp, ev_ocPageTop, ev_ocTopLeft:
     begin
      Result := ProcessCommandEx(ev_msgMove, aForce, aCommand, aCount);
      if Result then
       PrevHyperlink(True);
     end;//ev_ocPageUp, ev_ocPageTop, ev_ocTopLeft
    ev_ocPageDown, ev_ocPageBottom:
     begin
      Result := ProcessCommandEx(ev_msgMove, aForce, aCommand, aCount);
      if Result then
       NextHyperlink(True);
     end;//ev_ocPageDown, ev_ocPageBottom

   ev_ocExtPageUp,
   ev_ocExtPageDown: ;

   ev_ocLineUp,
   ev_ocWordLeft,
   ev_ocCharLeft,
   ev_ocWordStart,
   ev_ocParaHome,
   ev_ocLineHome,
   ev_ocParaLeft,
   ev_ocBottomRight,
   ev_ocBottomRightIgnoreMergedCell,
   ev_ocParaUp: PrevHyperlink(False);

   ev_ocLineDown,
   ev_ocParaEnd,
   ev_ocCharRight,
   ev_ocLineEnd,
   ev_ocWordFinish,
   ev_ocWordRight,
   ev_ocParaRight,
   ev_ocParaDown: NextHyperlink(False);
   else
    Result := False;
  end;
 end;
end;

procedure TevCustomEditor.DoInitAACLikeCursor;
var
 l_Hyperlink: IevHyperlink;
begin
 if f_InCheckAACCursor then
  Exit;
 if (AACLike in [nev_aacLeft, nev_aacRight]) then
  if HasSelection then
  begin
   if not Selection.Cursor.Obj.IsSame(Document.AsObject) then
   begin
    FreeCursor;
    MakeCursor;
    if (AACLike = nev_aacLeft) then
     NextHyperlink(False);
   end; // if not Selection.Cursor.Obj.IsSame(Document.AsObject) then
  end // if HasSelection then
  else
  begin
   f_InCheckAACCursor := true;
   try
    if f_CursorFromHistory then
    begin
     if (Selection <> nil) then
     begin
      f_CursorFromHistory := False;
      if not HasSelection then
       if (AACLike = nev_aacLeft) then
        GotoTop;
     end;//Selection <> ni
    end//f_CursorFromHistory
    else
    begin
     if (Selection = nil) then
      MakeCursor;
     NextHyperlink(False);
    end;//f_CursorFromHistory
   finally
    f_InCheckAACCursor := false;
   end;//try..finally
  end;//(AACLike > nev_aacNone) and not HasSelection
end;

procedure TevCustomEditor.Try2GoByHyperlinkUnderCursor;
begin
 {$IfNDef NoVCM}
 {$IFNDEF EverestLite}
 if Assigned(f_OnHyperlinkNavigate) then
 begin
  Inc(g_LockHistory);
  try
   f_OnHyperlinkNavigate(Self);
  finally
   Dec(g_LockHistory);
  end;//try..finally
 end;//Assigned(f_OnHyperlinkNavigate)
 {$ENDIF EverestLite}
 {$EndIf  NoVCM}
end;

end.

