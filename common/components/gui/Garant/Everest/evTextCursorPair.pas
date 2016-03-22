unit evTextCursorPair;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evTextParaCursorPair - }
{ Начат: 16.12.2002 15:23 }
{ $Id: evTextCursorPair.pas,v 1.6 2015/12/09 09:12:14 lulin Exp $ }

// $Log: evTextCursorPair.pas,v $
// Revision 1.6  2015/12/09 09:12:14  lulin
// - костыляем обратно.
//
// Revision 1.5  2015/12/08 12:58:12  lulin
// - очередной костыль для "красного болда".
//
// Revision 1.4  2015/12/08 12:53:50  lulin
// - очередной костыль для "красного болда".
//
// Revision 1.3  2015/04/16 13:26:47  dinishev
// {Requestlink:596845383}
//
// Revision 1.2  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.1  2014/07/29 12:54:56  lulin
// - рисуем фабрики интерфейсов.
//
// Revision 1.163  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.162  2014/04/21 12:18:18  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.161  2014/04/10 11:50:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.160  2014/04/09 13:12:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.159  2014/04/08 07:04:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.158  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.157  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.156  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.155  2014/03/26 15:51:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.154  2014/03/25 11:53:27  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.153  2014/03/24 12:02:14  lulin
// {RequestLink:522793127}
//
// Revision 1.152  2014/03/04 13:16:49  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.151  2013/12/25 15:35:19  lulin
// {RequestLink:509706011}
// - перетрясаем модель.
//
// Revision 1.150  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.149  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.148  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.147  2013/04/24 09:35:36  lulin
// - портируем.
//
// Revision 1.146  2013/01/30 09:28:06  dinishev
// {Requestlink:425273666}. Переносим на модель TevTableCurosrPair, т.к. нужна примесь.
//
// Revision 1.145  2011/09/15 18:32:06  lulin
// {RequestLink:278824896}.
//
// Revision 1.144  2011/08/05 10:42:55  dinishev
// [$278135327]
//
// Revision 1.143  2011/04/06 10:36:04  lulin
// {RequestLink:259171242}.
//
// Revision 1.142  2011/02/17 13:19:27  dinishev
// [$253663257]
//
// Revision 1.141  2010/07/21 04:51:15  lulin
// {RequestLink:227478809}.
//
// Revision 1.140  2010/07/08 09:21:00  lulin
// {RequestLink:224788868}.
//
// Revision 1.139  2010/05/31 10:23:19  lulin
// {RequestLink:216794957}.
//
// Revision 1.138  2010/05/05 08:17:50  lulin
// {RequestLink:209584437}.
//
// Revision 1.137  2010/05/05 07:49:56  lulin
// {RequestLink:208701762}.
//
// Revision 1.136  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.135  2009/07/20 16:44:04  lulin
// - убираем из некоторых листьевых параграфов хранение типа конкретного тега, вместо этого "плодим" под каждый тип тега свой тип класса.
//
// Revision 1.134  2009/07/14 14:56:29  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.133  2009/07/13 12:31:37  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.132  2009/07/10 15:04:44  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.131  2009/06/18 18:35:08  lulin
// {RequestLink:142613457}.
//
// Revision 1.130  2009/06/05 17:13:47  lulin
// - переносим на модель то, что возможно перенести.
//
// Revision 1.129  2009/06/02 13:48:01  lulin
// [$148574526].
//
// Revision 1.128  2009/04/15 18:49:30  lulin
// [$143396720]. Основательно перетрясаем модель.
//
// Revision 1.127  2009/04/13 16:43:33  lulin
// [$142613919]. Переносим базовый курсор на модель.
//
// Revision 1.126  2009/04/09 11:37:26  lulin
// - не ходим к собственным свойствам через Владивосток.
//
// Revision 1.125  2009/04/09 11:18:58  lulin
// - наводим порядок с указателями на объекты.
//
// Revision 1.124  2009/04/06 15:11:48  lulin
// [$140837386]. Убираем лишние присваивания интерфейсов.
//
// Revision 1.123  2009/04/06 07:56:44  lulin
// [$140837386]. Убираем старорежимную примесь для тестовых параграфов.
//
// Revision 1.122  2009/04/03 17:51:28  lulin
// [$140837386]. Ликвидируем старорежимную примесь.
//
// Revision 1.121  2009/03/04 13:32:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.120  2009/02/26 10:21:19  lulin
// - <K>: 137465982. №1
//
// Revision 1.119  2009/02/18 12:51:27  dinishev
// Летело AV при попытке замены на пустую строку
//
// Revision 1.118  2008/12/12 19:19:14  lulin
// - <K>: 129762414.
//
// Revision 1.117  2008/10/14 19:20:11  lulin
// - <K>: 121149970.
//
// Revision 1.116  2008/10/08 11:07:14  lulin
// - избавляемся от ненужных зависимостей между интерфейсами.
//
// Revision 1.115  2008/10/02 06:26:54  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=85169631&focusedCommentId=119475207#comment-119475207
//
// Revision 1.114  2008/09/26 10:10:47  dinishev
// <K>: 77235630 для Head'а
//
// Revision 1.113  2008/06/20 14:02:45  lulin
// - используем префиксы элементов.
//
// Revision 1.112  2008/06/20 12:48:40  lulin
// - используем префиксы элементов.
//
// Revision 1.111  2008/05/08 13:14:30  lulin
// - <K>: 90442618.
//
// Revision 1.110  2008/05/08 07:03:13  lulin
// - <K>: 90441963.
//
// Revision 1.109  2008/05/07 18:29:48  lulin
// - изменения в рамках <K>: 90441963.
//
// Revision 1.108  2008/05/07 17:30:11  lulin
// - cleanup.
//
// Revision 1.107  2008/05/07 16:19:28  lulin
// - изменения в рамках <K>: 90441943.
//
// Revision 1.106  2008/04/24 18:52:04  lulin
// - подготавливаемся к хранению форматированияв пуле, в рамках <K>: 89106312.
//
// Revision 1.105  2008/04/23 14:20:07  lulin
// - <K>: 89106322.
//
// Revision 1.104  2008/04/22 10:49:23  lulin
// - <K>: 88637809.
//
// Revision 1.103  2008/04/14 13:46:35  lulin
// - <K>: 89096854.
//
// Revision 1.102  2008/04/14 07:03:22  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.101  2008/04/11 12:51:54  lulin
// - <K>: 89100722.
//
// Revision 1.100  2008/04/11 12:26:08  lulin
// - <K>: 89100752.
//
// Revision 1.99  2008/04/11 11:29:59  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.98  2008/04/09 17:57:08  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.97  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.96  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.95  2008/03/21 12:17:25  lulin
// - <K>: 87590980.
//
// Revision 1.94  2008/03/21 10:38:37  lulin
// - <K>: 87590380.
//
// Revision 1.93  2008/03/20 15:00:47  lulin
// - <K>: 87590377.
//
// Revision 1.92  2008/03/19 14:23:34  lulin
// - cleanup.
//
// Revision 1.91  2008/02/21 10:55:02  lulin
// - упрощаем наследование.
//
// Revision 1.90  2008/02/07 19:12:55  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.89  2008/02/04 08:51:24  lulin
// - класс _Tl3InterfaceList выделен в отдельный модуль.
//
// Revision 1.88  2008/01/31 18:53:27  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.87  2008/01/24 07:58:58  dinishev
// Bug fix: портился параграф после изменения стиля и размера шрифта
//
// Revision 1.86  2007/12/29 12:44:03  dinishev
// _CleanUp
//
// Revision 1.85  2007/12/04 12:47:05  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.78.2.42  2007/10/10 17:40:34  lulin
// - в метод подсчета суперпозиции сегментов теперь передаем карту форматирования.
//
// Revision 1.78.2.41  2007/10/10 16:39:21  lulin
// - теперь при вычислении шрифта передаем ссылку на карту форматирования.
//
// Revision 1.78.2.40  2007/09/26 12:25:37  lulin
// - добавлен еще один флаг текстовой операции _misfSetText - для того, чтобы указать, что это установка текст. Починило отвалившуюся валидацию текста, вставляемого из буфера обмена (CQ OIT5-26801).
//
// Revision 1.78.2.39  2007/09/20 13:22:47  lulin
// - bug fix: терялась выбранная нода, в итоге получали список всех документов (CQ OIT5-26772).
//
// Revision 1.78.2.38  2007/09/14 13:26:06  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.78.2.37.2.2  2007/09/12 16:14:08  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.78.2.37.2.1  2007/09/12 15:23:02  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.78.2.37  2007/09/11 18:49:58  lulin
// - удален ненужный параметр.
//
// Revision 1.78.2.36  2007/08/21 16:10:28  lulin
// - неверно трактовали отсутствующий конец сегмента при переборе сегментов (CQ OIT5-25634).
//
// Revision 1.78.2.35  2007/08/09 11:19:13  lulin
// - cleanup.
//
// Revision 1.78.2.34  2007/06/25 13:29:07  lulin
// - cleanup.
//
// Revision 1.78.2.33  2007/06/22 20:18:32  lulin
// - cleanup.
//
// Revision 1.78.2.32  2006/11/27 08:43:22  lulin
// - cleanup.
//
// Revision 1.78.2.31  2006/11/03 11:00:08  lulin
// - объединил с веткой 6.4.
//
// Revision 1.78.2.30.6.4  2006/10/26 11:24:13  lulin
// - избавляемся от лишних преобразований типов.
//
// Revision 1.78.2.30.6.3  2006/10/20 05:48:56  oman
// Не собиралась библиотека
//
// Revision 1.78.2.30.6.2  2006/10/19 13:42:24  oman
// - fix: При даблклике в пустом поле КЗ пропадала каретка
//
// Revision 1.78.2.30.6.1  2006/10/12 17:45:21  lulin
// - вычищаем все, что связано с дозагрузкой документа.
//
// Revision 1.78.2.30  2006/08/02 10:51:53  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.78.2.29.2.2  2006/07/28 14:11:13  lulin
// - убрана функция переформатирования параграфа.
//
// Revision 1.78.2.29.2.1  2006/07/24 18:00:47  lulin
// - имя свойства убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.78.2.29  2006/07/10 14:55:45  lulin
// - убрана инициализация ссылки на родительский объект выделения.
//
// Revision 1.78.2.28  2006/05/18 13:00:20  lulin
// - cleanup.
//
// Revision 1.78.2.27  2006/02/27 17:14:37  lulin
// - bug fix: можно было изменить шрифт у константного текста (CQ OIT5-19664).
//
// Revision 1.78.2.26  2005/11/09 15:28:25  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.78.2.25  2005/11/04 11:22:09  lulin
// - cleanup: с параграфа убран метод переформатирования - он оставлен только на форме отображения объекта.
//
// Revision 1.78.2.24  2005/09/23 16:03:56  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.78.2.23  2005/09/14 14:28:20  lulin
// - bug fix: был AV при установке ссылки.
//
// Revision 1.78.2.22  2005/08/31 08:39:23  lulin
// - cleanup: удален ненужный глобальный метод.
//
// Revision 1.78.2.21  2005/07/20 18:21:15  lulin
// - убран переходный интерфейс.
//
// Revision 1.78.2.20  2005/07/19 15:32:24  lulin
// - убрана часть обращений к интересующим интерфейсам через цепочку Parent'ов диапазонов и курсоров.
//
// Revision 1.78.2.19  2005/07/19 12:03:20  lulin
// - cleanup: удалены ненужные модули и методы.
//
// Revision 1.78.2.18  2005/07/19 08:25:03  lulin
// - избавился от посылки сообщений для конвертации текста параграфа - перевел конвертацию на общий механизм Search/_Replace.
//
// Revision 1.78.2.17  2005/07/19 06:58:45  lulin
// - cleanup: убрано лишнее сообщение для конвертации текста параграфов.
//
// Revision 1.78.2.16  2005/07/18 17:37:43  lulin
// - упорядочена интерфейсная модель редактора - для удобства чтения и эффективности использования, а также для избавления от посылки сообщений.
//
// Revision 1.78.2.15  2005/07/18 15:10:27  lulin
// - избавляемся от косвенного приведения одного интерфейса к другому.
//
// Revision 1.78.2.14  2005/06/21 13:13:08  lulin
// - cleanup: удалены ненужные методы.
//
// Revision 1.78.2.13  2005/06/17 13:50:42  lulin
// - new property: InevTextPara._ViewSegments.
//
// Revision 1.78.2.12  2005/06/17 13:18:46  lulin
// - new property: InevTextPara.Formatting.
//
// Revision 1.78.2.11  2005/06/16 16:06:19  lulin
// - cleanup: подготавливаемся к расширению интерфейса InevTextPara.
//
// Revision 1.78.2.10  2005/06/07 13:43:48  lulin
// - удален ненужный модуль.
//
// Revision 1.78.2.9  2005/06/06 15:36:09  lulin
// - продолжаем бороться со знанием о природе реализации курсоров.
//
// Revision 1.78.2.8  2005/06/01 16:50:52  lulin
// - убрано знание о реализации курсоров выделения.
//
// Revision 1.78.2.7  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.78.2.6  2005/05/31 17:46:39  lulin
// - изживаем остатки объектов в качестве курсоров.
//
// Revision 1.78.2.5  2005/05/31 08:15:20  lulin
// - new behavior: корректнее присваиваем инструменты для работы с тегами.
//
// Revision 1.78.2.4  2005/05/23 12:23:55  lulin
// - bug fix: были AV при получении шрифта.
//
// Revision 1.78.2.3  2005/05/20 16:30:15  lulin
// - развязал интерфейс и реализацию шрифта выделения.
//
// Revision 1.78.2.2  2005/05/19 12:31:10  lulin
// - получение шрифта у блока и у курсора приведено к единому знаменателю.
//
// Revision 1.78.2.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.77.2.2  2005/05/18 12:32:10  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.77.2.1  2005/04/13 14:31:51  lulin
// - вместо безликих тегов используем параграфы.
//
// Revision 1.78  2005/05/17 09:27:33  lulin
// - new unit: _evResultFont.
//
// Revision 1.77  2005/03/30 10:14:52  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.76  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.75  2005/03/23 16:53:30  lulin
// - bug fix: бывали ошибки преобразования при установки стиля.
//
// Revision 1.74  2005/03/23 14:14:12  lulin
// - убран ненужный утилитный класс.
//
// Revision 1.73  2005/03/23 13:36:29  lulin
// - убран ненужный утилитный класс.
//
// Revision 1.72  2005/03/23 11:16:29  lulin
// - удалено ненужное исключение.
//
// Revision 1.71  2005/03/22 12:42:16  lulin
// - bug fix: установка стиля убивала гиперссылки.
//
// Revision 1.70  2005/03/21 16:28:16  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.69  2005/03/21 10:04:50  lulin
// - new interface: _Ik2Type.
//
// Revision 1.68  2005/03/21 06:44:53  lulin
// - убраны ненужные методы.
//
// Revision 1.67  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.66  2005/03/18 16:11:22  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.65  2005/03/16 12:16:52  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.64  2005/03/15 15:30:02  lulin
// - cleanup.
//
// Revision 1.63  2005/03/15 12:16:09  lulin
// - remove method: k2TagO.
//
// Revision 1.62  2005/03/15 10:30:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.61  2005/03/14 07:29:01  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.60  2005/03/10 17:44:02  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.59  2005/03/10 07:05:11  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.58  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.57  2005/02/03 15:05:55  lulin
// - bug fix: вставка строки не взводила флажок модифицированности.
//
// Revision 1.56  2004/12/22 15:24:29  lulin
// - при построении _preview теперь документ зачитывается целиком, а не кусочками.
//
// Revision 1.55  2004/10/29 11:38:30  lulin
// - new behavior: при изменении форматирования параграфа, удаляем из него все сегменты, у которых отсутствует какое-либо форматирование.
//
// Revision 1.54  2004/10/28 15:53:09  lulin
// - new behavior: по Ctrl-Shift-Space снимаем параметры шрифта и для слоя гиперссылок тоже.
//
// Revision 1.53  2004/10/28 14:10:55  lulin
// - remove unit: evParam.
//
// Revision 1.52  2004/10/28 13:54:26  lulin
// - remove type: TevParam.
//
// Revision 1.51  2004/10/18 16:18:57  lulin
// - remove unit: evTagTools.
//
// Revision 1.50  2004/10/18 15:41:42  lulin
// - remove method: TevTag.Unformat.
// - new proc: evUnformatPara.
//
// Revision 1.49  2004/07/06 12:08:03  law
// - new behavior: для Немезиса открутил сбор информации о стиле и шрифте.
//
// Revision 1.48  2004/07/02 10:57:49  law
// - замена Tk2AtomR -> _Ik2Tag.
//
// Revision 1.47  2004/06/30 11:32:21  law
// - rename proc: _k2Tag(TObject) -> k2TagO.
//
// Revision 1.46  2004/06/29 16:01:34  law
// - bug fix: зацикливание в получении документа в evNode.
//
// Revision 1.45  2004/06/28 13:46:33  law
// - remove unit: k2IntfStub.
//
// Revision 1.44  2004/06/28 13:34:46  law
// - remove class: Il3Pointer.
//
// Revision 1.43  2004/06/22 16:51:35  law
// - bug fix: не печатался (не сохранялся) первый догруженный текстовый параграф.
//
// Revision 1.42  2004/06/22 15:18:26  law
// - проведена подготовка для догрузки документа при печати, заборе в буфер обмена и т.п.
//
// Revision 1.41  2004/06/18 12:00:12  law
// - remove unit: evTextPara.
//
// Revision 1.40  2004/06/18 11:35:40  law
// - вычищаем все из модуля _TevTextPara.
//
// Revision 1.39  2004/06/18 11:19:16  law
// - cleanup.
//
// Revision 1.38  2004/06/18 10:15:43  law
// - класс _TevTextPara стал крайне аскетичным.
//
// Revision 1.37  2004/06/17 15:58:53  law
// - свойство Empty переместилось с класса _Tl3Base на класс _Tl3SomeDataContainer.
//
// Revision 1.36  2004/06/17 15:05:35  law
// - еще пачка методов уехала из класса _TevTextPara.
//
// Revision 1.35  2004/06/17 14:24:22  law
// - remove method: _TevTextPara.GetPosFont.
//
// Revision 1.34  2004/06/09 09:53:36  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.33  2004/06/03 15:59:51  law
// - убрал прямое обращение к _Tl3PVList (т.к. для оптимизации предполагается, что в теле документа не всегда он может хранится).
//
// Revision 1.32  2004/06/01 16:51:19  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.31  2004/05/14 15:16:53  law
// - remove unit: evTypesE.
//
// Revision 1.30  2004/05/06 09:19:21  law
// - change: функциональность TevTextParaCursorPair.SearchPrim перенесена в _TevLeafParaCursorPair.SearchPrim.
//
// Revision 1.29  2004/05/06 09:04:30  law
// - rename unit: evHyperlink_Impl -> evHyperlink.
//
// Revision 1.28  2004/05/06 08:49:10  law
// - rename class: TevHyperlinkImplementation -> _TevHyperlink.
//
// Revision 1.27  2004/05/05 12:05:52  law
// - change: изменен список параметров метода IevSearcher.Check.
//
// Revision 1.26  2004/04/19 16:08:15  law
// - new type: _Tl3PCharLenConst.
//
// Revision 1.25  2004/03/16 12:41:54  law
// - new method: TevTextParaPartFilter.WriteAtom.
//
// Revision 1.24  2004/03/16 11:49:07  law
// - new unit: evTextParaPartFilter.
//
// Revision 1.23  2004/03/15 13:13:52  law
// - bug fix: не устанавливали параграф при создании ссылки - соответственно в Немезисе не давали поставить ссылку на кусочек пользовательского комментария.
//
// Revision 1.22  2004/01/20 16:46:35  law
// - cleanup: TevBlock.StoreExPrim переименован в _DoStore.
//
// Revision 1.21  2003/12/01 14:39:59  law
// - new methods: TevCustomEditor.TextBufConvert, TextBufConvertF.
//
// Revision 1.20  2003/11/28 14:11:07  law
// - new unit: evSegmentsListConst.
//
// Revision 1.19  2003/10/16 15:46:57  law
// - new unit: evLeafParaCursorPair.
//
// Revision 1.18  2003/10/02 16:33:25  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.17  2003/05/13 13:05:04  law
// - cleanup.
//
// Revision 1.16  2003/04/24 16:29:54  law
// - new behavior: TevStyleReplacer при пустом свойстве Text убивает найденные сегменты.
//
// Revision 1.15  2003/02/17 15:34:19  law
// - bug fix: рудиментарное выделение конца текстового параграфа, после ухода по стрелке влево из пустой выделенной ячейки таблицы.
//
// Revision 1.14  2003/02/17 15:22:18  law
// - bug fix: BUG: в пустой ячейке таблицы жмем Shift-End - ячейка не выделяется, хотя по идее должна бы (№121).
//
// Revision 1.13  2003/02/05 17:14:50  law
// - optimization: уменьшаем время работы TevTextCursorPair.GetFontPrim.
//
// Revision 1.12  2003/02/05 16:16:06  law
// - optimization: уменьшаем время работы TevTextCursorPair.GetFontPrim.
//
// Revision 1.11  2003/02/05 15:50:59  law
// - bug fix: поправлена функция расчета шрифта выделения - теперь символ перед выделением не учитывается.
//
// Revision 1.10  2003/02/05 15:29:28  law
// - bug fix: неправильно работала функция TevTextCursorPair.GetFontPrim - видимо функциональность отвалилась после починки "прозрачности" параметров шрифта.
//
// Revision 1.9  2003/02/05 13:53:11  law
// - cleanup: переходим от сообщений (message)  к виртуальным функциям.
//
// Revision 1.8  2003/01/23 16:18:09  law
// - new behavior: используем TevBlock._Delete вместо WM_Clear.
//
// Revision 1.7  2003/01/21 12:49:46  law
// - new behavior: сделана возможность редактирование списков.
//
// Revision 1.6  2002/12/26 16:56:07  law
// - cleanup.
//
// Revision 1.5  2002/12/26 16:03:15  law
// - new directive: evNeedEditableCursors.
//
// Revision 1.4  2002/12/19 11:44:28  law
// - remove prop: _TevBasePara.BlockLength.
//
// Revision 1.3  2002/12/19 10:23:37  law
// - change: изменен список параметров IevSearcher.Check.
//
// Revision 1.2  2002/12/19 09:47:49  law
// - remove type: TevSearchEvent.
// - change: ипользуем IevSearcher вместо TevBaseSearcher.
//
// Revision 1.1  2002/12/16 12:56:02  law
// - new unit: evTextParaCursorPair.
//

{$Include evDefine.inc }

interface

uses
  Messages,
  
  l3Types,
  l3IID,
  l3Interfaces,
  l3Base,
  l3InternalInterfaces,
  l3Variant,

  k2Types,
  k2Interfaces,
  k2TagTool,
  k2TagGen,

  evdTypes,

  evInternalInterfaces,
  evMsgCode,

  evLeafParaCursorPair,

  nevBase,
  nevTools
  ;

type
  _nevTextParaTool_Parent_ = TevLeafParaCursorPair;
  {$Include nevTextParaTool.imp.pas }
  TevTextCursorPair = class(_nevTextParaTool_)
   {* Выделение для текстового параграфа. }
    protected
    // internal methods
      function DoDeleteHyperlink(const anOpPack : InevOp = nil): Boolean;
        override;
        {-}
      {$IfDef evNeedGetBlockFont}
      function  DoGetFont(const aView : InevView;
                        aMap : TnevFormatInfoPrim;
                        Stop       : PInteger = nil): InevFontPrim;
        override;
        {-}
      {$EndIf evNeedGetBlockFont}
      function  COMQueryInterface(const IID: Tl3GUID; out theObj): Tl3HResult;
        override;
        {-}
      procedure DoStore(const aView: InevView;
                        const G : Ik2TagGenerator;
                        aFlags : TevStoreFlags);
        override;
        {-}
      function  IsSolid(const aView: InevView): Bool;
        override;
        {-}
      function  GetContainsEnd(const aView: InevView): Bool;
        override;
        {-}
      function  DoGetBlockLength: Integer;
        override;
        {-}
      function DoInsertString(const aView : InevView;
                              const aString : Il3CString;
                              const anOp : InevOp = nil;
                              InsertMode : Bool = true;
                              aFlags     : TnevInsertStringFlags = []): Bool;
        override;
        {-}
      function  DoDelete(const aView : InevView;
                       const anOpPack : InevOp = nil;
                       aMode          : TevClearMode = ev_cmAll;
                       const aPara    : InevPara = nil): Bool;
        override;
        {-}
      function DoSetAtom(const aView : InevView;
                         anIndex        : Cardinal;
                         pSource  : Tl3Variant;
                         const anOpPack : InevOp): Bool;
        override;
        {-}
      function  IsCollapsed(const aView: InevView): Bool;
        override;
        {-}
      function DoAddIndentMarker(const aView    : InevView;
                                 aValue         : Integer;
                                 const anOpPack : InevOp = nil): Bool;
        override;
        {-}
      function DoDeleteIndentMarker(const aView: InevView; const anOpPack : InevOp = nil): Bool;
        override;
        {-}
      {$IfDef Nemesis}
      function EmptyIsNotConsideredCollapsed: Boolean;
        virtual;
        {* - трактовать пустое выделение в пустом параграфе как непустое }
      {$EndIf Nemesis}
      function  DeleteSegmentsEx(aLayerID       : TevSegmentHandle;
                                 const anOpPack : InevOp): Bool;
        {* - удаляет сегменты на слое aLayerID. }
    public
    // public methods
      function  DoDeleteSegments(const anOpPack : InevOp = nil): Bool;
        override;
        {* - удаляет сегменты. }
  end;//TevTextCursorPair

implementation

uses
  SysUtils,
  
  l3String,
  l3MinMax,

  k2BaseTypes,
  k2Except,
  k2Base,
  k2Tags,
  k2InterfacesEx,

  evdInterfaces,

  evSegLst,

  evHyperlink,

  evParaTools,
  evTextParaPartFilter,
  evTextParaTools,
  evSegment,
  evAlignBySeparatorUtils,

  nevNavigation,

  Hyperlink_Const
  ;

{$Include nevTextParaTool.imp.pas }

// start class TevTextCursorPair

function TevTextCursorPair.IsCollapsed(const aView: InevView): Bool;
  //override;
  {-}
begin
 Result := inherited IsCollapsed(aView);
 if Result {$IfDef Nemesis} and EmptyIsNotConsideredCollapsed {$EndIf Nemesis} then
        // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=259171242&focusedCommentId=259892291#comment-259892291
 begin
  if (f_Start <> nil) AND f_Start.AtEnd(aView) AND
     not evHasText(GetRedirect) then
   Result := false;
 end;//Result
end;

function TevTextCursorPair.DoSetAtom(const aView : InevView;
                                     anIndex        : Cardinal;
                                     pSource  : Tl3Variant;
                                     const anOpPack : InevOp): Bool;
  //override;
  {-}         

 procedure ClearSegmentsWithoutFormatting;
 var
  l_Segments : Tl3Variant;

  procedure ClearLayer(aLayer: TevSegmentHandle);
  var
   l_Index : Integer;
   l_Layer : Tl3Variant;
   l_Seg   : Tl3Variant;
  begin//ClearLayer
   l_Layer := evSegments_GetLayer(l_Segments, aLayer);
   if l_Layer.IsValid then
   begin
    l_Index := 0;
    while (l_Index < l_Layer.ChildrenCount) do
    begin
     l_Seg := l_Layer.Child[l_Index];
     if not l_Seg.IsKindOf(k2_typHyperlink) AND
        not evSegmentHasSomeFormat(l_Seg.AsObject) then
      evSegments_DeleteSegment(ParaX, aLayer, l_Index, anOpPack)
     else
      Inc(l_Index); 
    end;//while (l_Index < l_Layer.ChildrenCount)
   end;//l_Layer.IsValid
  end;//ClearLayer

 begin//ClearSegmentsWithoutFormatting
  l_Segments := ParaX.AsObject.Attr[k2_tiSegments];
  if l_Segments.IsValid then
  begin
   ClearLayer(ev_slView);
   ClearLayer(ev_slHyperlinks);
  end;//l_Segments.IsValid
 end;//ClearSegmentsWithoutFormatting

 function _ParaParam: Bool;
 begin//_ParaParam
  Result := (anIndex = k2_tiJustification) OR (anIndex = k2_tiBullet);
 end;//_ParaParam

var
 l_PaintHyper : Boolean;
 l_Segs       : Tl3Variant;
begin
 Result := true;
 if (f_B.rStart >= 0) AND (f_B.Len >= 0) then
 begin
  if _ParaParam then
   // - обрабатываем выравнивание параграфа
   evTextParaSetFontParam(ParaX, anIndex, pSource, anOpPack)
  else
  begin
   l_PaintHyper := (anIndex = k2_tiFont) AND
                   (pSource.IsNull);
   if Solid(aView) then
   begin
    // - выделен весь параграф
    if (anIndex = k2_tiStyle) then
    begin
     // - обрабатываем стиль параграфа
     if (pSource.IsNull) OR
        pSource.BoolA[k2_tiApply2Para] then
      // - стиль применим ко всему параграфу
      evTextParaSetFontParam(ParaX, anIndex, pSource, anOpPack)
     else
      // - стиль неприменим ко всему параграфу
      evSegments_PaintSegment(ParaX, ParaX.AsObject.cAtom(k2_tiSegments, anOpPack),
                              f_B, anIndex, pSource, anOpPack, l_PaintHyper);
    end//T = k2_tiStyle
    else
    begin
     // - обрабатываем другие параметры
     {$IfNDef Nemesis}
     (* [15:37]  БВ> Мы когда к целому параграфу применяем стиль выделения, как-то понимаем, что его надо не к параграфу применить. Может тут так же поступить? *)
     evSegments_PaintSegment(ParaX, ParaX.AsObject.cAtom(k2_tiSegments, anOpPack),
                             f_B, anIndex, pSource, anOpPack, l_PaintHyper);
     {$Else   Nemesis}
     evTextParaSetFontParam(ParaX, anIndex, pSource, anOpPack);
     l_Segs := ParaX.AsObject.Attr[k2_tiSegments];
     if l_Segs.IsValid then
      try
       evSegments_PaintSegment(ParaX, l_Segs, f_B, anIndex, pSource, anOpPack, l_PaintHyper);
      except
       on Ek2ReadOnlyProperty do ;
      end;//try..except
     {$EndIf  Nemesis}
    end;//T = k2_tiStyle
   end//Solid
   else
    // - выделен кусочек параграфа
    evSegments_PaintSegment(ParaX, ParaX.AsObject.cAtom(k2_tiSegments, anOpPack),
                            f_B, anIndex, pSource, anOpPack, l_PaintHyper);
   if l_PaintHyper then
    ClearSegmentsWithoutFormatting;
    // - очищаем все "ненужные" сегменты, которые не содержат форматирования
  end;//_ParaParam
 end;//f_B.rStart >= 0..
end;

function TevTextCursorPair.DoInsertString(const aView : InevView;
                                          const aString : Il3CString;
                                          const anOp : InevOp = nil;
                                          InsertMode : Bool = true;
                                          aFlags     : TnevInsertStringFlags = []): Bool;
  //override;
  {-}
  
var
 l_Delta  : Integer;
 l_OldLen : Integer;
 l_FinishPos : Integer;

  procedure InsertMore;
  var
   l_Start  : Il3CString;
   l_Finish : Il3CString;
   l_Point  : InevBasePoint;
  begin//InsertMore
   if (l_OldLen > 0) then
   begin
    l_Start := l3Copy(aString, 0, l_OldLen);
    Result := f_Start.Text.Modify.InsertString(aView, l_Start, anOp, false, aFlags);
    // - начало надо перезаписать
    Assert(Result);
   end;//l_OldLen > 0
   l_Finish := l3Copy(aString, l_OldLen, l_Delta);
   l_Point := ParaX.MakePoint;
   l_Point.PositionW := l_FinishPos;
   Result := l_Point.Text.Modify.InsertString(aView, l_Finish, anOp, true, aFlags);
   // - конец надо вставить
  end;//InsertMore

  procedure InsertLess;
  var
   //l_Range : InevRange;
   l_Point : InevBasePoint;
  begin//InsertLess
   Result := f_Start.Text.Modify.InsertString(aView, aString, anOp, false, aFlags);
   // - начало надо перезаписать
   // http://mdp.garant.ru/pages/viewpage.action?pageId=227478809&focusedCommentId=227967077#comment-227967077
   // Старый код:
(*   l_Range := ParaX.SubRange(aView, l_FinishPos + l_Delta, l_FinishPos);
   l_Range.Modify.Delete(aView, anOp);*)
   // Новый код:
   // - иначе misfSetText - теряется и потом зовётся TextChange, а не должен
   l_Point := ParaX.MakePoint;
   l_Point.PositionW := l_FinishPos + l_Delta;
   l_Point.Text.Modify.DeleteString(aView, -l_Delta, anOp, aFlags);
   // - конец надо удалить
   Self.Init(f_Start, f_Finish);
  end;//InsertLess

begin
 Include(aFlags, misfForSelection);
 if (f_Start = nil) then
  f_Start := ParaX.MakePoint;
 Assert(f_Start <> nil);
 l_OldLen := f_B.Len;
 l_Delta := l3Len(aString) - l_OldLen;
 l_FinishPos := f_B.rFinish;
 if (l_Delta = 0) then
 // - длины совпадают
  Result := f_Start.Text.Modify.InsertString(aView, aString, anOp, false, aFlags)
  // - просто перезаписываем один текст поверх другого
 else
 if (l_Delta > 0) then
 // - вставляем больше, чем было
  InsertMore
 else
 if (l_Delta < 0) then
 // - вставляем меньше, чем было
  InsertLess
 else
  Result := inherited DoInsertString(aView, aString, anOp, InsertMode, aFlags);
end;
  
function TevTextCursorPair.DoDelete(const aView : InevView;
                                  const anOpPack : InevOp = nil;
                                  aMode          : TevClearMode = ev_cmAll;
                                  const aPara    : InevPara = nil): Bool;
  //override;
  {-}
begin
 if (f_Start = nil) then
 begin
  if (aMode = ev_cmAll) then
   ParaX.MakePoint.Text.Modify.DeleteString(aView, f_B.Len, anOpPack, [misfSetText])
  else
   ParaX.MakePoint.Text.Modify.DeleteString(aView, f_B.Len, anOpPack);
 end//f_Start = nil
 else
  f_Start.Text.Modify.DeleteString(aView, f_B.Len, anOpPack);
 Result := true;
end;

function TevTextCursorPair.DoDeleteHyperlink(const anOpPack : InevOp = nil): Boolean;
  //override;
  {-}
begin
 Result := DeleteSegmentsEx(ev_slHyperlinks, anOpPack);
end;

{$IfDef evNeedGetBlockFont}
function TevTextCursorPair.DoGetFont(const aView : InevView;
                                   aMap : TnevFormatInfoPrim;
                                   Stop       : PInteger = nil): InevFontPrim;
  {override;}
  {-}

var
 l_Font : InevFontPrim absolute Result; 

 function _AddSegmentFont(aSegment: Tl3Variant; Index: Integer): Bool;
 var
  l_NextFont : InevFontPrim;
  l_Finish   : Integer;
 begin//_AddSegmentFont
  Result := false;
  if (Stop <> nil) AND (Stop^ > 1) then Exit;
  l_NextFont := ParaX.Formatting[aSegment.IntA[k2_tiStart]].GetFont(aView, aMap, Stop);
  if l_Font.SubFont(l_NextFont) then
   Exit;
  l_Finish := aSegment.IntA[k2_tiFinish];
  if (l_Finish < f_B.rFinish) then
  begin
   l_NextFont := ParaX.Formatting[Succ(l_Finish)].GetFont(aView, aMap, Stop);
   if l_Font.SubFont(l_NextFont) then
    Exit;
  end;//l_Finish < f_B.rFinish
  Result := true;
 end;//_AddSegmentFont

var
 l_Start : Integer;
begin
 l_Start := Succ(f_B.rStart);
 l_Font := ParaX.Formatting[l_Start].GetFont(aView, aMap, Stop);
 evSegmentsLayer_IterateSegmentsF(ParaX.AsObject, aMap.ViewSegments, l_Start, f_B.rFinish, L2Mk2ChildrenIterateChildrenFAction(@_AddSegmentFont));
end;
{$EndIf evNeedGetBlockFont}

function TevTextCursorPair.COMQueryInterface(const IID: Tl3GUID; out theObj): Tl3HResult;
  {override;}
  {-}
var
 ResultHL : TevHyperlink;

 function SegmentID(Seg: Tl3Variant; Index: Integer): Bool; 
 begin//SegmentID
  Result := true;
  if Seg.IsKindOf(k2_typHyperlink) then
  begin
   if (ResultHL.ID = 0) then
    ResultHL.Init(Seg.AsObject)
   else
   begin
    l3Free(ResultHL);
    Result := false; { break }
   end;//ResultHL.ID = 0
  end;//Seg.IsKindOf(k2_typHyperlink)
 end;//SegmentID

begin
 Result.SetOk;
 if IID.EQ(IevHyperlink) then
 begin
  ResultHL := TevHyperlink.Create(Self, ParaX.AsObject);
  try
   if (f_B.Len > 0) then
    evSegmentsLayer_IterateSegmentsF(ParaX.AsObject,
                                     ParaX.AsObject.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperLinks)]),
                                     Succ(f_B.rStart),
                                     f_B.rFinish,
                                     L2Mk2ChildrenIterateChildrenFAction(@SegmentID));
   if (ResultHL = nil) then
    Result := inherited COMQueryInterface(IID, theObj)
   else
    IevHyperlink(theObj) := ResultHL;
  finally
   l3Free(ResultHL);
  end;//try..finally
 end//IID.EQ(IevHyperlink)
 else
  Result := inherited COMQueryInterface(IID, theObj);
end;

procedure TevTextCursorPair.DoStore(const aView: InevView;
                                    const G : Ik2TagGenerator;
                                    aFlags  : TevStoreFlags);
  {override;}
  {-}

var
 l_Atom : Tl3Variant;
 l_Text : Tl3CustomString;
begin
 if not (evd_sfChildrenOnly in aFlags) then
 begin
  l_Atom := GetRedirect;
  G.StartChild(l_Atom.TagType);
  try
   with l_Atom.Attr[k2_tiText] do
    if IsValid then
     l_Text := AsObject As Tl3CustomString
    else
     l_Text := nil;
   if l_Text.Empty OR (f_B.Len = l_Text.Len) then
   begin
    if Solid(aView) then
     l_Atom.AsObject.WriteTag(G)
    else
     l_Atom.AsObject.WriteTag(G, l3_spfAll, [k2_tiSubs]);
   end
   else
    TevTextParaPartFilter.WriteAtom(G, l_Atom, f_B);
  finally
   G.Finish;
  end;{try..finally}
  if (evd_sfStoreParaEnd in aFlags) AND ContainsEnd(aView) AND (f_Finish <> nil) then
  begin
   G.StartChild(l_Atom.TagType);
   G.Finish;
  end;//evd_sfStoreParaEnd in aFlags..
 end;//not (evd_sfChildrenOnly in aFlags)
end;

function TevTextCursorPair.IsSolid(const aView: InevView): Bool;
  {override;}
  {-}
var
 SC : InevBasePoint;
 FC : InevBasePoint;
begin
 GetBorderPoints(SC, FC);
 Result := ((SC = nil) OR (f_B.rStart <= 0)) AND ContainsEnd(aView);
end;

function TevTextCursorPair.GetContainsEnd(const aView: InevView): Bool;
  //override;
  {-}
var
 SC : InevBasePoint;
 FC : InevBasePoint;
begin
 GetBorderPoints(SC, FC);
 Result := (FC = nil) OR FC.AtEnd(aView);
end;

function TevTextCursorPair.DoGetBlockLength: Integer;
  //override;
  {-}
begin
 Result := evTextLength(GetRedirect);
end;

function TevTextCursorPair.DeleteSegmentsEx(aLayerID       : TevSegmentHandle;
                                            const anOpPack : InevOp): Bool;
  {* - удаляет сегменты на слое aLayerID. }
var
 l_Segments : Tl3Variant;
 l_List     : Ik2TagList;
 l_Layer    : Tl3Variant;
 l_Index    : Integer;
 l_Seg      : Tl3Variant;
begin
 Result := true;
 if (f_B.Len > 0) then
 begin
  l_Segments := ParaX.AsObject.Attr[k2_tiSegments];
  if l_Segments.IsValid then
  begin
   l_Layer := evSegments_GetLayer(l_Segments, aLayerID);
   if l_Layer.IsValid then
   begin
    l_List := evSegmentsLayer_GetSegments(ParaX.AsObject, l_Layer, Succ(f_B.rStart), Succ(f_B.rFinish), nil);
    try
     if not l_List.Empty then
     begin
      for l_Index := 0 to Pred(l_List.Count) do
      begin
       l_Seg := l_List[l_Index];
       if (aLayerID <> ev_slHyperlinks) OR l_Seg.IsKindOf(k2_typHyperlink) then
        evSegments_DeleteSegment(ParaX, aLayerID, l_Layer.IndexOfChild(l_Seg), anOpPack);
      end;//for l_Index
     end;//not l_List.Empty
    finally
     l_List := nil;
    end;//try..finally
   end;//l_Layer.IsValid
  end;//l_Segments.IsValid
 end;//f_B.Len > 0
end;

function TevTextCursorPair.DoDeleteSegments(const anOpPack : InevOp = nil): Bool;
  //override;
  {* - удаляет сегменты. }
begin
 Result := DeleteSegmentsEx(ev_slView, anOpPack);
end;

{$IfDef Nemesis}
function TevTextCursorPair.EmptyIsNotConsideredCollapsed: Boolean;
begin
 Result := True;
end;
{$EndIf Nemesis}

function TevTextCursorPair.DoAddIndentMarker(const aView : InevView; 
  aValue: Integer; const anOpPack: InevOp): Bool;
begin
 Result := evNewIndentMarker(aView, aValue, ParaX, anOpPack);
end;

function TevTextCursorPair.DoDeleteIndentMarker(const aView    : InevView;
  const anOpPack: InevOp): Bool;
begin
 Result := evDeleteIndentMarker(ParaX, anOpPack);
end;


end.

