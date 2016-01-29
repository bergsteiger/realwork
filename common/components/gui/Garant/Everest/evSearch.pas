unit evSearch;
{* Инструменты для поиска/замены. } 

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evSearch -      }
{ Начат: 27.05.1998 14:39 }
{ $Id: evSearch.pas,v 1.323 2015/09/24 11:26:24 dinishev Exp $ }

// $Log: evSearch.pas,v $
// Revision 1.323  2015/09/24 11:26:24  dinishev
// {Requestlink:607752167}
//
// Revision 1.322  2015/09/08 07:57:39  lulin
// - правим под XE.
//
// Revision 1.321  2015/08/25 12:03:52  dinishev
// {Requestlink:604032386}
//
// Revision 1.320  2015/08/14 11:50:30  dinishev
// {Requestlink:602009846}. Доточил TevCustomHyperlinkSearcher для игнорирования внеших номеров + убрал IFDEF в флаг игнорирования вложенных, если блок свернут
//
// Revision 1.319  2015/08/05 09:18:17  dinishev
// {Requestlink:602505046}
//
// Revision 1.318  2015/05/26 11:19:28  fireton
// - задерживаем сконвертированную для регекспа строку в памяти
//   чтобы теги остались валидными
//
// Revision 1.317  2015/04/21 12:22:18  fireton
// - AV при невалидном тексте в параграфе
//
// Revision 1.316  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.315  2014/10/15 12:21:22  lulin
// - bug fix: утекали объекты (http://mdp.garant.ru/pages/viewpage.action?pageId=534075240).
//
// Revision 1.314  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.313  2014/04/29 13:38:51  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.312  2014/04/10 11:50:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.311  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.310  2014/04/08 14:16:55  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.308  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.307  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.306  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.305  2014/03/27 09:51:21  dinishev
// {Requestlink:522796828}
//
// Revision 1.304  2014/03/24 12:02:14  lulin
// {RequestLink:522793127}
//
// Revision 1.303  2014/03/04 13:16:49  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.302  2014/02/13 15:15:55  lulin
// - рефакторим безликие списки.
//
// Revision 1.301  2013/12/25 15:35:18  lulin
// {RequestLink:509706011}
// - перетрясаем модель.
//
// Revision 1.300  2013/10/23 12:25:49  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.299  2013/05/31 04:58:21  lulin
// - портируем под XE4.
//
// Revision 1.298  2013/04/10 16:41:53  lulin
// - портируем.
//
// Revision 1.297  2013/04/10 16:37:05  lulin
// - портируем.
//
// Revision 1.296  2013/04/04 11:18:51  lulin
// - портируем.
//
// Revision 1.295  2012/07/04 08:18:36  fireton
// - поскольку рекеспы не понимают юникод, перекодируем редкие юникодные строки в ANSI (K 373560690)
//
// Revision 1.294  2012/03/16 08:35:28  fireton
// - рефакторинг регулярных выражений (оптимизация по скорости)
//
// Revision 1.293  2012/02/27 09:31:48  fireton
// - _f_CurrentSeg теперь protected
//
// Revision 1.292  2011/09/14 07:51:44  lulin
// {RequestLink:278824896}.
//
// Revision 1.291  2011/08/23 18:01:07  lulin
// {RequestLink:279774229}.
//
// Revision 1.290  2011/06/26 14:34:37  lulin
// {RequestLink:269081565}.
//
// Revision 1.289  2011/05/18 12:07:54  lulin
// {RequestLink:266409354}.
//
// Revision 1.288  2011/05/10 17:12:52  lulin
// {RequestLink:236719181}.
// №24.
//
// Revision 1.287  2011/03/30 13:14:20  dinishev
// [$259175668]
//
// Revision 1.286  2011/02/14 18:09:50  lulin
// {RequestLink:231670346}.
// - при всякого рода навигациях по тексту учитываем, что параграфы могут быть схлопнутыми.
//
// Revision 1.285  2011/01/25 10:59:01  lulin
// - вытащил ReplaceCount на интерфейс, для Антоши.
//
// Revision 1.284  2010/12/13 10:44:34  lulin
// {RequestLink:245761265}.
//
// Revision 1.283  2010/11/17 15:02:17  fireton
// - неверно формировался блок для следующего Searcher'а в цепочке (TevBaseMultipartSearcher)
//
// Revision 1.282  2010/07/29 11:03:15  lulin
// {RequestLink:228693150}.
// - bug fix: не перематывали вставляемый поток на начало.
//
// Revision 1.281  2010/07/29 09:56:08  fireton
// - выкидываем обрезание #13#10
//
// Revision 1.280  2010/07/23 08:39:04  fireton
// - механизм "перезапуска" цепочки searcher'ов
//
// Revision 1.279  2010/06/28 13:55:43  fireton
// - исправляем поиск несколькими searcher'ами последовательно
//
// Revision 1.278  2010/06/28 13:10:42  lulin
// {RequestLink:165514106}.
// - правильнее проверяем конец параграфа.
//
// Revision 1.277  2010/06/28 12:43:36  lulin
// {RequestLink:165514106}.
// - исправляем явную ошибку.
//
// Revision 1.276  2010/06/24 11:45:16  lulin
// {RequestLink:219123904}.
//
// Revision 1.275  2010/05/14 10:34:23  lulin
// {RequestLink:211879983}.
// - сделана ещё одна версия l3Pos.
// - поправлены Антошины ошибки.
//
// Revision 1.274  2010/05/07 14:19:28  fireton
// - оптимизация и доработка
//
// Revision 1.273  2010/03/16 15:50:27  lulin
// {RequestLink:197496426}.
//
// Revision 1.272  2010/02/10 19:15:28  lulin
// {RequestLink:186352297}.
//
// Revision 1.271  2009/10/19 17:55:56  lulin
// {RequestLink:164599478}.
//
// Revision 1.270  2009/10/14 09:00:50  voba
// - избавляемся от библиотеки mg
//
// Revision 1.269  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.268  2009/07/21 14:36:02  lulin
// - убираем поддержку IUnknown со строк.
//
// Revision 1.267  2009/07/14 14:56:27  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.266  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.265  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.264  2009/07/11 09:24:42  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.263  2009/06/25 12:57:30  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.262  2009/06/02 16:20:49  lulin
// - типы, необходимые для реализации, переносим туда, где они реально используются.
//
// Revision 1.261  2009/06/02 13:48:01  lulin
// [$148574526].
//
// Revision 1.260  2009/06/01 12:26:50  lulin
// [$148572848].
//
// Revision 1.259  2009/04/22 09:57:20  lulin
// [$145097239]. Переносим функцию в правильное место.
//
// Revision 1.258  2009/04/14 08:24:25  lulin
// [$142613919]. Группируем функциональность в базовых классах.
//
// Revision 1.257  2009/04/09 14:12:37  lulin
// [$140837386]. №15.
//
// Revision 1.256  2009/03/31 12:04:36  lulin
// [$140286997].
//
// Revision 1.255  2009/03/05 14:20:43  lulin
// - <K>: 137470629. Удалено ненужно свойство.
//
// Revision 1.254  2009/03/04 13:32:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.253  2009/02/05 13:02:43  lulin
// - <K>: 125895391.
//
// Revision 1.252  2009/02/05 11:58:30  lulin
// - <K>: 125895391. Передаём кодировку, а не флажок.
//
// Revision 1.251  2008/11/26 07:38:32  oman
// - fix: Вставлен Assert (К-125895391)
//
// Revision 1.250  2008/11/11 11:09:23  lulin
// - <K>: 122672539.
//
// Revision 1.249  2008/10/15 13:03:23  lulin
// - <K>: 121149970.
//
// Revision 1.248  2008/06/20 14:48:51  lulin
// - используем префиксы элементов.
//
// Revision 1.247  2008/06/20 14:02:45  lulin
// - используем префиксы элементов.
//
// Revision 1.246  2008/06/09 11:45:47  lulin
// - <K>: 93264011.
//
// Revision 1.245  2008/05/28 07:58:23  lulin
// - <CQ>: 29146.
//
// Revision 1.244  2008/05/27 08:53:58  lulin
// - <CQ>: 29024.
//
// Revision 1.243  2008/05/21 17:05:14  lulin
// - <K>: 90441490.
//
// Revision 1.242  2008/05/12 08:57:35  lulin
// - прилеплена заплатка для оптимизации определения видимости найденного параграфа.
//
// Revision 1.241  2008/05/04 14:57:44  lulin
// - не цепляем ненужные модули от Опоссума.
//
// Revision 1.240  2008/04/24 12:26:19  lulin
// - изменения в рамках <K>: 89106312.
//
// Revision 1.239  2008/04/15 09:32:18  lulin
// - правильно обрабатываем спрятанность параграфов.
//
// Revision 1.238  2008/04/15 08:23:46  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.237  2008/04/14 13:46:35  lulin
// - <K>: 89096854.
//
// Revision 1.236  2008/04/11 13:03:52  lulin
// - <K>: 89096854.
//
// Revision 1.235  2008/04/11 12:01:31  lulin
// - <K>: 89100701.
//
// Revision 1.234  2008/04/11 11:29:58  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.233  2008/04/10 17:34:24  lulin
// - <K>: 89097983.
//
// Revision 1.232  2008/04/10 12:45:57  lulin
// - <K>: 89099092.
//
// Revision 1.231  2008/04/09 17:57:08  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.230  2008/04/08 16:41:20  lulin
// - передаём View в AssignPoint. <K>: 89096854.
//
// Revision 1.229  2008/03/24 16:10:47  lulin
// - <K>: 87592745.
//
// Revision 1.228  2008/03/19 14:23:34  lulin
// - cleanup.
//
// Revision 1.227  2008/03/03 20:05:45  lulin
// - <K>: 85721135.
//
// Revision 1.226  2008/03/03 13:20:27  lulin
// - nevTools перенесён на модель. Теперь всё компилируется.
//
// Revision 1.225  2008/02/29 12:11:25  lulin
// - дорисовал nevTools.
//
// Revision 1.224  2008/02/06 11:44:27  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.223  2008/02/04 08:51:24  lulin
// - класс _Tl3InterfaceList выделен в отдельный модуль.
//
// Revision 1.222  2008/01/31 18:53:27  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.221  2007/12/19 15:40:03  dinishev
// new class: TevSpecialParagraphSearcher - для совместимости
// Поправлена логика работы с TevAnyParagraphSearcher
// Bug fix: передавали в конвертер блок верхнего уровня
//
// Revision 1.220  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.205.2.74  2007/10/10 17:40:34  lulin
// - в метод подсчета суперпозиции сегментов теперь передаем карту форматирования.
//
// Revision 1.205.2.73  2007/09/14 13:26:06  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.205.2.72.2.3  2007/09/12 17:51:48  lulin
// - cleanup.
//
// Revision 1.205.2.72.2.2  2007/09/12 16:14:07  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.205.2.72.2.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.205.2.72  2007/08/21 16:10:27  lulin
// - неверно трактовали отсутствующий конец сегмента при переборе сегментов (CQ OIT5-25634).
//
// Revision 1.205.2.71  2007/08/21 12:43:17  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.205.2.70  2007/08/10 14:44:43  lulin
// - cleanup.
//
// Revision 1.205.2.69  2007/06/22 19:18:57  lulin
// - cleanup.
//
// Revision 1.205.2.68  2007/06/22 18:59:53  lulin
// - cleanup.
//
// Revision 1.205.2.67  2007/04/18 11:01:39  oman
// warning fix
//
// Revision 1.205.2.66  2007/04/17 12:34:45  oman
// Warning fix
//
// Revision 1.205.2.65  2007/02/13 17:32:55  lulin
// - избавляемся от использования стандартной функции поиска подстроки в строке.
//
// Revision 1.205.2.64  2007/01/05 14:37:19  lulin
// - cleanup.
//
// Revision 1.205.2.63  2006/10/10 12:06:14  lulin
// - cleanup.
//
// Revision 1.205.2.62  2006/09/21 06:58:21  lulin
// - убраны ненужные параметры.
//
// Revision 1.205.2.61  2006/09/18 16:44:33  lulin
// - сделан переход по гиперссылкам назад (CQ OIT5-21613).
//
// Revision 1.205.2.60  2006/07/20 16:22:36  lulin
// - добавлен метод, возвращающий курсор на родителя, заданного уровня.
//
// Revision 1.205.2.59  2006/07/20 16:12:04  lulin
// - убрана множественность версий метода.
//
// Revision 1.205.2.58  2006/07/10 14:55:45  lulin
// - убрана инициализация ссылки на родительский объект выделения.
//
// Revision 1.205.2.57  2006/07/03 14:43:08  lulin
// - cleanup.
//
// Revision 1.205.2.56  2006/05/05 08:33:38  lulin
// - cleanup: вытерты "старые" регулярные выражения.
//
// Revision 1.205.2.55  2006/03/27 13:19:54  lulin
// - cleanup.
//
// Revision 1.205.2.54  2005/12/12 17:20:09  lulin
// - теперь спрятанность параграфа можно узнать на основе того спрятан родитель или нет и так по рекурсии. В связи с этим упрощена проверка в контекстном поиске.
//
// Revision 1.205.2.53  2005/11/16 16:34:38  lulin
// - bug fix: находился текст в скрытых комментариях Гаранта.
//
// Revision 1.205.2.52  2005/11/14 14:07:38  fireton
// - bug fix: искалось в скрытых комментариях
//
// Revision 1.205.2.51  2005/11/09 15:28:24  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.205.2.50  2005/11/07 12:24:36  fireton
// - bug fix: для определения "разделитель/не разделитель" теперь используется l3IsWordDelim
//
// Revision 1.205.2.49  2005/11/05 09:03:14  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.205.2.48  2005/10/11 12:49:45  lulin
// - модуль регулярных выражений переехал в правильную библиотеку.
//
// Revision 1.205.2.47  2005/10/11 09:52:32  lulin
// - cleanup.
//
// Revision 1.205.2.46  2005/10/11 09:44:47  lulin
// - дорогой, по словам Антоши вызов делаем гораздо реже.
//
// Revision 1.205.2.45  2005/10/06 13:09:25  fireton
// - bug fix: TevWordFromBeginningSearcher и TevStrictWordSearcher не просматривали остаток строки
//
// Revision 1.205.2.44  2005/09/30 10:57:28  fireton
// - change: Multipass и Multiblock (TevBaseMultipartSearche) теперь public
//
// Revision 1.205.2.43  2005/09/29 16:05:57  fireton
// - change: функция _Check (TevBaseSearcher) теперь virtual
// - change: свойство SearcherList (TevBaseMultipartSearcher) теперь public
//
// Revision 1.205.2.42  2005/09/29 07:36:10  fireton
// - перенес функционал (поиск в Unicode) из HEAD
//
// Revision 1.205.2.41  2005/09/23 16:03:55  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.205.2.40  2005/09/07 14:16:53  fireton
// - не собиралась библиотека
//
// Revision 1.205.2.39  2005/09/07 11:41:42  fireton
// - реализованы TevStrictWordSearcher и TevWordFromBeginningSearcher (бывший TevWholeWordSearcher)
//
// Revision 1.205.2.38  2005/07/29 13:02:29  lulin
// - убран глобальный метод приведения курсора к курсору на документ.
//
// Revision 1.205.2.37  2005/07/27 11:53:15  lulin
// - кеш документов теперь полностью переведен на интерфейс контейнера и ничего не знает про его реализацию.
//
// Revision 1.205.2.36  2005/07/26 15:16:58  lulin
// - задел на ускорение контекстного поиска в F1.
//
// Revision 1.205.2.35  2005/07/20 16:59:27  lulin
// - избавляем окружающих от необходимости знать про TagReader и _TagWriter.
//
// Revision 1.205.2.34  2005/07/20 15:20:15  lulin
// - избавляемся от потенциального AV.
//
// Revision 1.205.2.33  2005/07/20 15:13:19  lulin
// - убрано косвенное получение инструментов для чтения/записи тега.
//
// Revision 1.205.2.32  2005/07/19 17:23:47  lulin
// - убран косвенный доступ к списку Sub'ов документа - теперь он получается непосредственно от параграфа.
//
// Revision 1.205.2.31  2005/07/19 16:47:05  lulin
// - убран косвенный запрос подтверждения замены. Теперь соответствующий интерфейс подается непосредственно в Replacer.
//
// Revision 1.205.2.30  2005/07/19 15:32:24  lulin
// - убрана часть обращений к интересующим интерфейсам через цепочку Parent'ов диапазонов и курсоров.
//
// Revision 1.205.2.29  2005/07/19 11:33:08  lulin
// - окончательно избавился, от функциональности, работающей через посылку сообщений.
//
// Revision 1.205.2.28  2005/07/19 08:25:03  lulin
// - избавился от посылки сообщений для конвертации текста параграфа - перевел конвертацию на общий механизм Search/_Replace.
//
// Revision 1.205.2.27  2005/07/18 17:37:43  lulin
// - упорядочена интерфейсная модель редактора - для удобства чтения и эффективности использования, а также для избавления от посылки сообщений.
//
// Revision 1.205.2.26  2005/07/18 15:10:27  lulin
// - избавляемся от косвенного приведения одного интерфейса к другому.
//
// Revision 1.205.2.25  2005/07/18 11:22:37  lulin
// - методу, возвращаещему выделение на параграфе дано более подходящее название.
//
// Revision 1.205.2.24  2005/07/11 06:07:06  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.205.2.23  2005/06/16 14:59:14  lulin
// - cleanup: удалены ненужные зависимости.
//
// Revision 1.205.2.22  2005/06/16 14:11:29  lulin
// - cleanup: отдельно стоящие процедуры перенесены на интерфейсы.
//
// Revision 1.205.2.21  2005/06/15 17:23:52  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.205.2.20  2005/06/15 14:52:18  lulin
// - remove proc: evChangeBlockParam.
//
// Revision 1.205.2.19  2005/06/15 13:06:00  lulin
// - убрана инициализация блоков выделения в явном виде.
//
// Revision 1.205.2.18  2005/06/15 11:04:09  lulin
// - убрана инициализация курсоров в явном виде.
//
// Revision 1.205.2.17  2005/06/07 14:05:31  lulin
// - cleanup.
//
// Revision 1.205.2.16  2005/06/07 13:43:47  lulin
// - удален ненужный модуль.
//
// Revision 1.205.2.15  2005/06/07 09:29:23  lulin
// - cleanup: избавляемся от ссылки на нетипизированного Owner'а.
//
// Revision 1.205.2.14  2005/06/06 15:36:09  lulin
// - продолжаем бороться со знанием о природе реализации курсоров.
//
// Revision 1.205.2.13  2005/06/03 12:08:19  lulin
// - cleanup: убраны ненужные зависимости.
//
// Revision 1.205.2.12  2005/06/03 10:14:45  lulin
// - cleanup: убран ненужный результат функции.
//
// Revision 1.205.2.11  2005/06/02 15:07:05  lulin
// - cleanup: удалены устаревшие методы.
//
// Revision 1.205.2.10  2005/06/02 12:33:08  lulin
// - вчерне заменил прямое создание блока выделения на его получение от фабрики.
//
// Revision 1.205.2.9  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.205.2.8  2005/06/01 14:02:17  lulin
// - new unit: evCursor.
//
// Revision 1.205.2.7  2005/05/31 17:09:20  lulin
// - изживаем остатки объектов в качестве курсоров.
//
// Revision 1.205.2.6  2005/05/31 12:06:30  lulin
// - cleanup: при работе с курсорами используем интерфейсы, а не объекты.
//
// Revision 1.205.2.5  2005/05/26 15:34:57  lulin
// - базовая канва вывода теперь избавлена от знания о контролах управления.
//
// Revision 1.205.2.4  2005/05/20 14:58:39  lulin
// - new unit: evStyleInterface.
//
// Revision 1.205.2.3  2005/05/20 11:27:35  lulin
// - класс TevBlock вынесен в отдельный модуль.
//
// Revision 1.205.2.2  2005/05/19 14:33:40  lulin
// - от объектов переходим к интерфейсам.
//
// Revision 1.205.2.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.197.2.5  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.197.2.4  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.197.2.3  2005/04/08 14:18:47  lulin
// - bug fix: при поиске приходил последний символ параграфа, а не "пи".
//
// Revision 1.197.2.2  2005/04/08 10:15:33  lulin
// - переформатирование.
//
// Revision 1.197.2.1  2005/04/08 10:07:46  lulin
// - bug fix: контроллируем, что достигли конца параграфа и сигнализируем об этом - иначе зависал автоблокиратор.
//
// Revision 1.200.2.3  2005/04/26 16:07:07  lulin
// - уменьшаем число лишних вызовов.
//
// Revision 1.200.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.200.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.200  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.199  2005/04/08 14:32:35  lulin
// - слил с веткой.
//
// Revision 1.198  2005/04/08 10:12:23  lulin
// - слил с веткой.
//
// Revision 1.197.2.3  2005/04/08 14:18:47  lulin
// - bug fix: при поиске приходил последний символ параграфа, а не "пи".
//
// Revision 1.197.2.2  2005/04/08 10:15:33  lulin
// - переформатирование.
//
// Revision 1.197.2.1  2005/04/08 10:07:46  lulin
// - bug fix: контроллируем, что достигли конца параграфа и сигнализируем об этом - иначе зависал автоблокиратор.
//
// Revision 1.197.2.1  2005/04/08 10:07:46  lulin
// - bug fix: контроллируем, что достигли конца параграфа и сигнализируем об этом - иначе зависал автоблокиратор.
//
// Revision 1.205  2005/05/16 16:26:36  lulin
// - реструктурированы интерфейсы.
//
// Revision 1.204  2005/05/16 16:01:28  lulin
// - new behavior: параметры шрифта теперь применяются к мультивыделению.
//
// Revision 1.203  2005/05/16 15:31:11  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.202  2005/05/16 11:42:10  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.201  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.200.2.3  2005/04/26 16:07:07  lulin
// - уменьшаем число лишних вызовов.
//
// Revision 1.200.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.200.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.200  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.199  2005/04/08 14:32:35  lulin
// - слил с веткой.
//
// Revision 1.198  2005/04/08 10:12:23  lulin
// - слил с веткой.
//
// Revision 1.197.2.3  2005/04/08 14:18:47  lulin
// - bug fix: при поиске приходил последний символ параграфа, а не "пи".
//
// Revision 1.197.2.2  2005/04/08 10:15:33  lulin
// - переформатирование.
//
// Revision 1.197.2.1  2005/04/08 10:07:46  lulin
// - bug fix: контроллируем, что достигли конца параграфа и сигнализируем об этом - иначе зависал автоблокиратор.
//
// Revision 1.197.2.1  2005/04/08 10:07:46  lulin
// - bug fix: контроллируем, что достигли конца параграфа и сигнализируем об этом - иначе зависал автоблокиратор.
//
// Revision 1.197  2005/04/04 06:43:57  lulin
// - в связи с появлением механизма событий и фасада библиотеки K-2, удалены глобальные "заплатки" связанные с созданием/уничтожением таблицы тегов.
//
// Revision 1.196  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.195  2005/03/23 13:36:29  lulin
// - убран ненужный утилитный класс.
//
// Revision 1.194  2005/03/23 11:48:03  lulin
// - вызов метода заменен на обращение к свойству.
//
// Revision 1.193  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.192  2005/03/16 17:04:21  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.191  2005/03/16 12:16:52  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.190  2005/03/15 10:30:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.189  2005/03/11 13:59:44  lulin
// - optimization: реже дергаем evInPara.
//
// Revision 1.188  2005/03/11 13:04:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.187  2005/03/10 11:35:09  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.186  2005/03/04 13:53:48  fireton
// - bug fix: в TevBMTextSearcher не выставлялась функция поиска
// - add: TevBaseReplacer._Make
//
// Revision 1.185  2005/03/04 12:16:36  lulin
// - cleanup.
//
// Revision 1.184  2005/01/27 15:34:19  narry
// - update: добавлена директива условной компиляции
//
// Revision 1.183  2005/01/26 12:57:01  lulin
// - изменена проверка на то, что комментарий спрятан.
//
// Revision 1.182  2005/01/12 12:06:03  voba
// - bug fix: циклился сечер
//
// Revision 1.181  2004/12/28 13:20:21  fireton
// - bug fix: неправильно определялся блок при повторном поиске после NextSearcher
//
// Revision 1.180  2004/11/30 11:51:21  fireton
// - bug fix: AV при f_Text = nil
//
// Revision 1.179  2004/11/23 14:59:51  fireton
// - change: BaseSearcher использует NextSearcher последовательно, а не один раз
// - bug fix: чехарда с режимами Multiblock и Multipass
//
// Revision 1.178  2004/11/22 13:38:32  fireton
// - change: Изменен TevBaseMultipartSearcher с тем, чтобы умел искать "через блоки"
//
// Revision 1.177  2004/11/18 12:31:40  fireton
// - change: Изменен TevBaseMultipartSearcher с тем, чтобы умел искать в произвольном порядке
//
// Revision 1.176  2004/11/04 17:43:44  lulin
// - new interface: _Ik2TypeTable.
//
// Revision 1.175  2004/11/04 15:22:04  lulin
// - bug fix: не компилировалась библиотека Print Engine.
//
// Revision 1.174  2004/10/26 15:11:48  demon
// - new behavior: операция _DoCheckText возвращает False всегда, если f_SrchMashine.SearchPattern = ''
//
// Revision 1.173  2004/10/20 15:52:05  lulin
// - new behavior: не прогружаем весь документ при позиционировании на параграф.
//
// Revision 1.172  2004/10/14 07:38:23  mmorozov
// bugfix: TevRegularExpressionSearcher._DoCheckText;
//
// Revision 1.171  2004/10/11 09:29:05  lulin
// - new behavior: сделана синхронизация установки закладки на документ в разных окнах.
//
// Revision 1.170  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.169  2004/08/11 08:25:31  voba
// - bug fix RCE с конца параграфа
//
// Revision 1.168  2004/08/04 12:24:39  voba
// - new behavior Задание "!" в конце слова отключает поиск со словоформами для этого слова
//
// Revision 1.167  2004/07/21 15:59:01  law
// - bug fix: не искались несформатированные параграфы.
//
// Revision 1.166  2004/07/21 06:32:10  law
// - bug fix: не компилировалось.
//
// Revision 1.165  2004/06/29 14:26:41  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.164  2004/06/29 11:24:58  fireton
// - bug fix: исправлена ошибка при которой параметры в multipart searcher'e
//            не передавались "детям"
//
// Revision 1.163  2004/06/23 09:41:45  law
// - догрузка параграфов при поиске перенесена с Searcher'а на выделение.
//
// Revision 1.162  2004/06/22 18:38:39  law
// - new behavior: при поиске прогружаем непрогруженные параграфы.
//
// Revision 1.161  2004/06/22 12:43:50  law
// - new behavior: поиск теперь использует IevTagSelection, а не TevBlock.
//
// Revision 1.160  2004/06/15 11:38:04  narry
// - bug fix: integer overflow
//
// Revision 1.159  2004/06/10 07:17:26  law
// - new class: TevParaPlaceSearcer - для валидации расположения уже найденного куска параграфа.
//
// Revision 1.158  2004/06/10 07:03:54  law
// - new class: _TevStylesSearcher.
//
// Revision 1.157  2004/06/10 06:55:24  law
// - new behavior: _TevORSearcher - теперь может хранить больше 2-х дочерних Searcher'ов.
//
// Revision 1.156  2004/06/09 16:44:25  law
// - cleanup.
//
// Revision 1.155  2004/06/09 16:36:13  law
// - заменил #13#10 на константу.
//
// Revision 1.154  2004/06/09 16:31:43  law
// - new param: TevStyleSearcher._Make - aPlace    : TevSearchPlace = ev_spAll.
//
// Revision 1.153  2004/06/09 16:25:41  law
// - new proc: evGetParaTextByMask.
//
// Revision 1.152  2004/06/09 15:59:33  law
// - bug fix.
//
// Revision 1.151  2004/06/09 15:58:05  law
// - bug fix: отвязались от модуля Dialogs.
//
// Revision 1.150  2004/06/09 15:38:17  voba
// - bug fix.
//
// Revision 1.149  2004/06/09 15:28:17  law
// - new class: TevOneLevelSearcher.
//
// Revision 1.148  2004/06/09 14:21:40  law
// - bug fix: неправильно работала догрузка документа.
//
// Revision 1.147  2004/06/09 12:44:31  voba
// - bug fix.
//
// Revision 1.146  2004/06/09 12:22:00  law
// - new class: _TevORSearcher.
//
// Revision 1.145  2004/06/09 11:27:54  law
// - new class: TevInvertSearcher - инвертирует результат поиска.
//
// Revision 1.144  2004/06/09 11:08:56  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.143  2004/06/09 09:53:36  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.142  2004/06/08 16:14:55  law
// - new param: TevStyleSearcher._Make - aLayer.
//
// Revision 1.141  2004/06/08 16:10:04  law
// - new method: TevStyleSearcher._Make.
//
// Revision 1.140  2004/06/02 10:20:33  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList._Make.
//
// Revision 1.139  2004/06/01 15:44:33  law
// - удалены конструкторы Tl3VList.MakeString, MakeStringSorted - пользуйтесь Tl3StringList.
//
// Revision 1.138  2004/05/27 15:31:31  fireton
// - change: в _Check searcher'a теперь передается предыдущий блок
// - bug fix: нормальный поиск по словосочетаниям с морфологией
//
// Revision 1.137  2004/05/26 12:43:18  law
// - new behavior: спрашиваем IevConfirmSource сначала у Owner'а.
//
// Revision 1.136  2004/05/25 15:41:25  law
// - change: поправлено форматирование.
//
// Revision 1.135  2004/05/25 15:34:23  law
// - change: вынес TevRegExpMultipartSearcher за define.
//
// Revision 1.134  2004/05/25 15:29:51  law
// - new class: TevFakeSearcher.
//
// Revision 1.132  2004/05/25 14:22:50  law
// - bug fix.
//
// Revision 1.131  2004/05/25 14:15:58  law
// - bug fix: вытащил TevMorphologySearcher за define.
//
// Revision 1.130  2004/05/25 10:37:57  fireton
// - bug fix: TevRegularExpressionSearcher._DoCheckText - корректируем конечный курсор
// - bug fix: TevBaseMultipartSearcher теперь ищет корректно (применяет searcher'ы до тех пор, пока не кончится блок
//
// Revision 1.129  2004/05/25 09:50:50  law
// - добавлены комментарии.
//
// Revision 1.128  2004/05/25 09:44:28  law
// - изменено форматирование.
// - new behavior: применяем итератор для разбора строки на слова.
//
// Revision 1.127  2004/05/24 14:21:11  nikitin75
// +TevMorphologySearcher - в первом приближении добавлен поиск со словоформами
//
// Revision 1.126  2004/05/19 07:38:05  nikitin75
// + TevCustomEditorWindow.FindA - первая реализация поиска с поддержкой мультивыделения
//
// Revision 1.125  2004/05/17 14:40:25  fireton
// - add: новый класс TevRegExpReplacer (позволяет заменять с учетом тегов)
//
// Revision 1.124  2004/05/12 14:48:44  fireton
// - new: TevAnyParagraphSearcher - поиск любого параграфа (для multipart)
// - bug fix: корректная замена параграфов в _TevTextReplacer._ReplaceFunc
// - new behavior: TevRegExpMultipartSearcher.DoSetText
//
// Revision 1.123  2004/05/12 11:24:51  fireton
// - bug fix: TBaseMultipartSearcher теперь следит, чтобы найденные части
//            относились к одному предку
//
// Revision 1.122  2004/05/12 09:55:52  fireton
// - bug fix: ошибка в TBaseMultipartSearcher, приводящая к неправильным результатам поиска
// - bug fix: memory leak в TBaseMultipartSearcher
//
// Revision 1.121  2004/05/11 14:05:46  fireton
// - add: реализована замена "с параграфами" (TevTextReplacer)
//
// Revision 1.120  2004/05/11 10:02:45  fireton
// - bug fix: TBaseMultipartSearcher теперь корректно работает при повторном поиске
//
// Revision 1.119  2004/05/07 10:02:36  fireton
// - change: теперь TRegExpMultiSearcher умеет искать пустые параграфы
//
// Revision 1.118  2004/05/07 09:22:42  law
// - new behavior: делаем возможность Searcher'у в случае пустой строки понимать, что курсор стоит в конце параграфа.
//
// Revision 1.117  2004/05/07 08:58:26  law
// - change: методы Start, Finish перенесены из IevSearcher в IevSearchTool.
// - new prop: IevReplacer.Searcher.
//
// Revision 1.116  2004/05/06 17:19:33  law
// - new method: IevReplacer.NeedProgress - второй шаг в переходе от события замены к интерфейсу.
//
// Revision 1.115  2004/05/06 17:02:33  law
// - cleanup: у _ReplaceFunc удален ненужный и непонятный параметр Sender.
//
// Revision 1.114  2004/05/06 16:46:33  law
// - change: "для порядку" добавил вызов inherited.
//
// Revision 1.113  2004/05/06 16:00:59  fireton
// - add: новые классы: TevBaseMultipartSearcher, TevEmptyTextSearcher и TevRegExpMultipartSearcher
//
// Revision 1.112  2004/05/06 12:58:13  law
// - new method: TevBaseSearcher._Make.
//
// Revision 1.111  2004/05/06 11:08:53  law
// - change: NextSearcher теперь интерфейс IevSearcher.
//
// Revision 1.110  2004/05/06 11:06:29  law
// - bug fix: не учитывали, что Start и Finish могут быть от разных параграфов.
//
// Revision 1.109  2004/05/06 10:12:10  narry
// - bug fix: неаккуратность
//
// Revision 1.108  2004/05/06 09:04:30  law
// - rename unit: evHyperlink_Impl -> evHyperlink.
//
// Revision 1.107  2004/05/06 08:49:10  law
// - rename class: TevHyperlinkImplementation -> TevHyperlink.
//
// Revision 1.106  2004/05/06 08:37:33  law
// - change: "шаманство" c получением "процессора" и пр. упрятано в вызов метода TevHyperlinkImplementation._Make.
//
// Revision 1.105  2004/05/06 08:26:49  voba
// -bug fix
//
// Revision 1.104  2004/05/05 16:03:41  law
// - cleanup.
//
// Revision 1.103  2004/05/05 15:53:43  law
// - cleanup.
//
// Revision 1.102  2004/05/05 15:38:15  law
// - bug fix.
//
// Revision 1.101  2004/05/05 13:34:18  law
// - rename method: TevBaseSearcher.Search -> TevBaseSearcher._DoCheckText.
//
// Revision 1.100  2004/05/05 13:09:33  law
// - change: переименованы параметры - им даны более осмысленные параметры.
//
// Revision 1.99  2004/05/05 12:52:38  law
// - rename method: TevBaseSearcher.Search -> TevBaseSearcher._DoCheckText.
//
// Revision 1.98  2004/05/05 12:32:33  law
// - rename method: TevBaseSearcher.CheckEx -> TevBaseSearcher._DoCheck.
//
// Revision 1.97  2004/05/05 12:26:48  law
// - change: обработка NextSearcher перенесена в другой метод TevBaseSearcher._Check.
//
// Revision 1.96  2004/05/05 12:05:52  law
// - change: изменен список параметров метода IevSearcher._Check.
//
// Revision 1.95  2004/04/23 16:47:29  law
// - new unit: evCodePageAnalyzer.
//
// Revision 1.94  2004/03/25 16:15:19  law
// - new define: _evSearchToolIsComponent - выключен для Немезиса.
//
// Revision 1.93  2004/03/25 15:04:18  law
// - cleanup: убран мусор, переименованы названия.
// - new: добавлена документация.
//
// Revision 1.92  2004/03/25 10:38:35  voba
// -new behavior : прикрутил vtRegEx
//
// Revision 1.91  2004/01/06 16:21:06  law
// - new prop: TevBaseSearcher.IgnoreHidden - игнорировать ли при поиске скрытые параграфы.
//
// Revision 1.90  2003/12/23 16:11:57  law
// - new prop: TevBaseSearcher.NextSearcher.
//
// Revision 1.89  2003/12/23 15:00:00  law
// - new prop: IevSearchTool.Options.
// - new behavior: процедура TevCustomEditor._Find выставляет Options и Searcher'у и Replacer'у.
//
// Revision 1.88  2003/12/23 14:04:54  law
// - prop: TevBaseReplacer.Searcher.
//
// Revision 1.87  2003/12/23 13:28:35  law
// - new interfaces: IevSearchTool, IevReplacer.
//
// Revision 1.86  2003/12/02 12:40:36  law
// - new behavior: перекомпилируем регулярное выражение при смене Options.
//
// Revision 1.85  2003/11/28 14:11:06  law
// - new unit: evSegmentsListConst.
//
// Revision 1.84  2003/10/02 16:33:24  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.83  2003/09/25 12:45:19  law
// - bug fix: не было поиска когда курсор не отдавал IevConfirmSource.
//
// Revision 1.82  2003/09/25 11:33:29  narry
// - bug fix: не вызывался _Replace, когда поиск начинался не с курсора документа.
//
// Revision 1.81  2003/09/08 12:54:56  law
// - new method: TeeEditorExport.GotoPara.
//
// Revision 1.80  2003/04/24 16:29:54  law
// - new behavior: TevStyleReplacer при пустом свойстве Text убивает найденные сегменты.
//
// Revision 1.79  2003/01/20 13:03:04  law
// - cleanup: избавляемся от прямого использования ev_msgMove.
//
// Revision 1.78  2002/12/20 15:18:42  law
// - new param: TevSearchToo.Finish - aBlock.
//
// Revision 1.77  2002/12/20 13:44:45  law
// - new param: TevSearchToo.Finish - aCancel.
//
// Revision 1.76  2002/12/19 10:23:36  law
// - change: изменен список параметров IevSearcher._Check.
//
// Revision 1.75  2002/12/19 09:47:49  law
// - remove type: TevSearchEvent.
// - change: ипользуем IevSearcher вместо TevBaseSearcher.
//
// Revision 1.74  2002/11/11 12:23:51  law
// - comments.
//
// Revision 1.73  2002/11/11 11:58:15  law
// - remove prop: TevStyleSearcher.WholeParaOnly.
// - new prop: TevStyleSearcher.SearchPlace.
//
// Revision 1.72  2002/10/17 13:57:07  law
// - cleanup.
//
// Revision 1.71  2002/09/19 13:41:34  law
// - cleanup and comments.
//
// Revision 1.70  2002/09/19 12:52:38  law
// - cleanup.
//
// Revision 1.69  2002/09/18 14:31:36  law
// - change: начата работа по поддержке нотификации об изменении стилей.
// - new unit: evStyleTableTools.
//
// Revision 1.68  2002/09/17 08:38:50  law
// - change: методы Start, Finish, DoStart, DoFinish перенесены в TevBaseSearcher.
// - change param: TevCustomEditor._Find теперь надо подавать TevBaseSearcher.
//
// Revision 1.67  2002/09/11 12:32:14  law
// - new methods: DoStart, DoFinish.
//
// Revision 1.66  2002/09/11 12:28:31  law
// - change.
//
// Revision 1.65  2002/07/09 13:57:39  law
// - new unit: evMsgCode.
//
// Revision 1.64  2002/03/04 09:59:00  law
// - buf fix: неправильное использование директив условной компиляции.
//
// Revision 1.63  2002/03/01 09:10:13  voba
// - add compile options for usage old regular searcher
//
// Revision 1.62  2002/02/28 14:19:45  law
// - bug fix: ambigous function call.
//
// Revision 1.61  2002/02/08 16:22:55  law
// no message
//
// Revision 1.60  2002/02/08 16:22:37  law
// - change behavior: в TevHyperLinkReplacer.OnHyperlinkReplace подается теперь сам Replacer.
//
// Revision 1.59  2002/02/08 16:05:42  law
// - cleanup.
//
// Revision 1.58  2002/02/07 15:22:30  law
// - rename class: IevBlock -> TevBlock, для того чтобы не путать его с интерфейсом.
//
// Revision 1.57  2002/02/07 15:05:24  law
// - rename class: IevCursor -> _TevCursor, для того чтобы не путать его с интерфейсом.
//
// Revision 1.56  2002/02/07 14:42:47  law
// - rename class: IevLocation -> _TevLocation, для того чтобы не путать его с интерфейсом.
//
// Revision 1.55  2002/02/07 12:26:42  law
// - new event: _TevSearchTool.OnTextChanged.
//
// Revision 1.54  2002/02/07 10:10:08  voba
// - add TevCustomHyperLinkReplacer - common ancestor for HyperLink Replacers
//
// Revision 1.53  2002/02/05 14:58:17  voba
// - new behavior: remove TevSubReplacer.pm_GetDefaultText
//
// Revision 1.52  2002/02/01 16:05:08  law
// - new behavior: поддержка свойства Text в TevBaseReplacer.
//
// Revision 1.51  2002/01/03 14:19:02  law
// - some cosmetics.
//
// Revision 1.50  2001/12/27 15:19:28  law
// - change visibility: Tl3CustomString._SetSt перенесен из секции public в protected.
//
// Revision 1.49  2001/12/27 15:03:29  law
// - new constructors: добавлены два конструктора Tl3String._Make.
//
// Revision 1.48  2001/09/14 12:37:01  law
// - bug fix: не выставлялись опции по умолчанию.
//
// Revision 1.47  2001/09/07 09:34:40  law
// - change method: Perfrom(ev_msgSetAtom, ...) -> evChangeBlockParam.
//
// Revision 1.46  2001/09/07 08:13:59  law
// - cleanup.
//
// Revision 1.45  2001/08/31 09:04:36  law
// - cleanup.
//
// Revision 1.44  2001/08/29 07:01:08  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.43  2001/06/26 14:17:55  voba
// - new behavior : TevHyperLinkSearcher теперь умеет сам искать
//
// Revision 1.42  2001/06/26 10:56:19  law
// - new behavior: классу TevBlock добавлено свойство _Sharp и на его основе поправлено зацикливание поиска внутри таблиц.
//
// Revision 1.41  2001/06/09 07:18:50  law
// - bug fix: поиск по регулярному выражению: учитываем кодировку и начало блока поиска.
//
// Revision 1.40  2001/05/15 12:22:33  law
// - cleanup: немного подчищены ненужные типы и перекрестные ссылки между модулями.
// - comments: добавлены комментарии для xHelpGen.
//
// Revision 1.39  2001/05/14 12:34:22  law
// - new prop: TevStyleSearcher.WholeParaOnly.
//
// Revision 1.38  2001/04/10 15:13:24  law
// - new behavior: убран метод TevCustomEditor.GotoHyperlink, вместо него сделан класс TevHypelinkIDSearcher.
//
// Revision 1.37  2001/04/03 11:53:41  voba
// - bug fix: GPF при простановке стилей из поиска/замены.
//
// Revision 1.36  2001/03/30 11:54:34  law
// - курсор для текстовых параграфов вынесен в модуль evTextParaCursor.
//
// Revision 1.35  2001/03/26 13:50:24  law
// - убран класс Wk2Handle.
//
// Revision 1.34  2001/03/23 18:12:15  law
// - Tl3OperationContainer -> Il3OpPack.
//
// Revision 1.33  2001/03/23 17:50:47  law
// - сделана реализация IevOpInsertString и убрано использование ev_msgInsertString.
//
// Revision 1.32  2001/03/14 13:24:55  law
// - some cleaup and tuning.
//
// Revision 1.31  2001/03/11 17:08:22  law
// - дописаны комментарии для XHelpGen.
//
// Revision 1.30  2001/03/11 15:00:11  law
// - удалены ненужные связи между модулями.
//
// Revision 1.29  2001/03/11 13:32:00  law
// - TevHyperlinkSearchEvent & TevHyperlinkReplaceEvent -> TevHyperlinkEvent.
//
// Revision 1.28  2001/03/11 13:00:05  voba
// Добавили класс TevHyperlinkReplacer
//
// Revision 1.27  2001/03/05 14:08:28  law
// - поменялся порядок у методов _IterateChildren...
//
// Revision 1.26  2001/02/20 10:23:51  law
// - some tuning
//
// Revision 1.25  2001/01/31 10:37:31  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.24  2001/01/10 15:05:42  law
// - bug fix: ошибка удаления выделенного блока текста.
//
// Revision 1.23  2000/12/15 15:10:37  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

{$IfDef evUseVisibleCursors}
uses
  Windows,
  Classes,
  SysUtils,

  {$IfDef evNeedNormalWordSearcher}
  mgSrcEvn,
  {$EndIf evNeedNormalWordSearcher}

  l3Types,
  l3Const,
  l3Chars,
  l3Base,
  l3Interfaces,
  l3UnicodeBMSearch,
  {$IfDef evSearchToolIsComponent}
  l3InterfacedComponent,
  {$EndIf evSearchToolIsComponent}
  l3InterfacedString,
  l3RegEx,
  l3StringList,
  l3BMSearch,
  l3Memory,
  l3ProtoObject,

  k2Interfaces,
  k2InternalInterfaces,

  evdTypes,
  evdInterfaces,

  afwNavigation,

  evTypes,
  evInternalInterfaces,
  evStyleInterface,
  evSearcherList,

  nevBase,
  nevTools,
  nevNavigation
  ;

type
  TevGetSubHandleEvent = function(Sender       : TObject;
                                  const aBlock : InevRange): Long of object;
   {* Тип событий для получения номера метки. }
  TevFinishReplaceEvent = procedure(Sender: TObject; ReplaceCount: Long) of object;
    {* Тип событий, вызываемых при завершении цикла поиска/замены.
       ReplaceCount - количество сделанных замен.}
  TevHyperlinkEvent = function(aSender: TObject; const aHLink : IevHyperLink): Bool of object;
    {* Тип событий для обработки гипертекстовых ссылок. }

  {$IfDef evSearchToolIsComponent}
  TevSearchToolOwner = TComponent;
  {$Else  evSearchToolIsComponent}
  TevSearchToolOwner = TObject;
  {$EndIf evSearchToolIsComponent}
  
  TevSearchTool = class(
                        {$IfDef evSearchToolIsComponent}
                        Tl3InterfacedComponent
                        {$Else  evSearchToolIsComponent}
                        Tl3ProtoObject
                        {$EndIf evSearchToolIsComponent}
                        ,
                        IevSearchTool)
   {* Базовый класс для инструментов поиска/замены. }
    private
    {property fields}
      f_Options   : TevSearchOptionSet;
(*      f_TypeTable : Ik2TypeTable;*)
    private
    // event fields
      f_OnTextChanged : TNotifyEvent;  
    protected
    {property methods}
      function  pm_GetOptions: TevSearchOptionSet;
      procedure pm_SetOptions(Value: TevSearchOptionSet); virtual;
        {-}
      function  pm_GetText: AnsiString;
        virtual;
      procedure pm_SetText(const Value: AnsiString);
        {-}
      function  pm_GetDefaultText: AnsiString;
        virtual;
        {-}
      procedure Cleanup;
        override;
        {-}
    protected
    // internal methods
      procedure OptionsChanged;
        virtual;
        {-}
      procedure DoSetText(const Value: AnsiString);
        virtual;
        {-}
      procedure DoTextChanged;
        virtual;
        {-}
      procedure DoStart;
        virtual;
        {-}
      procedure DoFinish(aCancel: Bool; const aBlock: InevRange);
        virtual;
        {-}
    public
    {public methods}
      constructor Create(anOwner: TevSearchToolOwner = nil);
        {$IfDef evSearchToolIsComponent}
        override;
        {$Else  evSearchToolIsComponent}
        virtual;
        {$EndIf evSearchToolIsComponent}
        {-}
      procedure Start;
        {* - начало пачки замен. }
      procedure Finish(aCancel: Bool; const aBlock: InevRange);
        {* - конец пачки замен. }
    public
    {public properties}
      property Options: TevSearchOptionSet
        read f_Options
        write pm_SetOptions;
        {* - опции поиска/замены. }
      property Text: AnsiString
        read pm_GetText
        write pm_SetText;
        {-}
      property DefaultText: AnsiString
        read pm_GetDefaultText;
        {-}
    published
    // published events
      property OnTextChanged: TNotifyEvent
        read f_OnTextChanged
        write f_OnTextChanged;
        {* - вызывается при смене свойства Text. }
  end;//TevSearchTool

  TevBaseSearcher = class(TevSearchTool, IevSearcher)
   {* Базовый класс для инструментов поиска. }
    private
    // property fields
      f_IgnoreHidden : Boolean;
      f_NextSearcher : IevSearcher;
    protected
    // property methods
      function  pm_GetNotFoundMessage: AnsiString;
        virtual;
        {-}
      procedure pm_SetNextSearcher(const aValue: IevSearcher);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure DoStart;
        override;
        {-}
      procedure DoFinish(aCancel: Bool; const aBlock: InevRange);
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: TevSearchToolOwner = nil);
        override;
        {-}
      class function Make(const aText : AnsiString;
                          anOptions   : TevSearchOptionSet = [];
                          aNext       : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
      function DoCheckTextEx(aPara    : Tl3Variant;
                             aText          : Tl3CustomString;
                             const aSel     : TevPair;
                             const aPrevSel : TevPair;
                             out theSel     : TevPair): Bool;
        virtual;
        {-}
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel  : TevPair): Bool;
        virtual;
        abstract;
        {* - определяет критерий отбора параграфа (его фрагмента). }
      function DoCheck(const aView : InevView;
                       const aBlock    : InevRange;
                       out theStart    : InevBasePoint;
                       out theFinish   : InevBasePoint;
                       const PrevBlock : InevRange): Bool;
        overload;
        virtual;
        {* - определяет критерий отбора параграфа (его фрагмента). }
      function DoCheck(const aView : InevView;
                       const aTag        : InevObject;
                       const aStart      : InevBasePoint;
                       const aFinish     : InevBasePoint;
                       const aStartPrev  : InevBasePoint;
                       const aFinishPrev : InevBasePoint;
                       out theSel        : TevPair): Bool;
        overload;
        virtual;
        {* - определяет критерий отбора параграфа (его фрагмента). }
      function Check(const aView : InevView;
                     const aBlock    : InevRange;
                     out theStart    : InevBasePoint;
                     out theFinish   : InevBasePoint;
                     const PrevBlock : InevRange): Bool;
        overload;
        virtual;
        {* - определяет критерий отбора параграфа (его фрагмента). }
      function Check(const aView : InevView;
                     const aBlock    : InevRange;
                     out theSel      : TevPair;
                     const PrevBlock : InevRange): Bool;
        overload;
        {* - определяет критерий отбора параграфа (его фрагмента). }
    public
    {public properties}
      property NotFoundMessage: AnsiString
        read pm_GetNotFoundMessage;
        {-}
      property NextSearcher: IevSearcher
        read f_NextSearcher
        write pm_SetNextSearcher;
        {-}
      property IgnoreHidden: Boolean
        read f_IgnoreHidden
        write f_IgnoreHidden
        default true;
        {-}
  end;//TevBaseSearcher

  TevBaseMultipartSearcher = class(TevBaseSearcher, InevRestartPositionSource)
    private
      FSearcherList: TevSearcherList;
      FCurSearcher: Integer;
      FFoundStart: InevBasePoint;
      FFoundFinish: InevBasePoint;
      FMultiblock: Boolean;
      FMultipass: Boolean;
      FFoundSearchersList: TevSearcherList;
      f_RestartPoint: InevBasePoint;
    protected
      procedure DoStart;
        override;
        {-}
      procedure DoFinish(aCancel: Bool; const aBlock: InevRange);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure pm_SetOptions(Value: TevSearchOptionSet);
        override;
        {-}
      function Get_RestartPos: InevBasePoint;
    public
      constructor Create(anOwner: TevSearchToolOwner = nil);
        override;
        {-}
      function DoCheck(const aView : InevView;
                       const aBlock    : InevRange;
                       out theStart    : InevBasePoint;
                       out theFinish   : InevBasePoint;
                       const PrevBlock : InevRange): Bool;
        override;
        {-}
      class function Make(const aText : AnsiString;
                          anOptions   : TevSearchOptionSet = [];
                          const aNext : IevSearcher = nil;
                          aMultipass  : Boolean = False): IevSearcher;
        reintroduce;

      property Multiblock: Boolean
        read FMultiblock
        write FMultiblock;
      property Multipass: Boolean
        read FMultipass
        write FMultipass;
      property SearcherList: TevSearcherList
        read FSearcherList;
        {-}
  end;//TevBaseMultipartSearcher

  TevBaseReplacer = class(TevSearchTool, IevReplacer)
   {* Базовый абстрактный класс для инструментов замены. }
    private
    {property fields}
      f_ReplaceCount : Long;
      f_Searcher     : IevSearcher;
    private
    {event fields}
      f_OnReplaceConfirm : TevReplaceConfirmEvent;
      f_OnFinishReplace  : TevFinishReplaceEvent;
    protected
    {property fields}
      f_Replace: Tl3InterfacedString;
    protected
    {property methods}
      function  Get_Searcher: IevSearcher;
      procedure Set_Searcher(const aValue: IevSearcher);
        {-}
      function  pm_GetText: AnsiString;
        override;
        {-}
    protected
    // internal methods
   function Get_ReplaceCount: Integer;
      function NeedProgress: Boolean;
        {-}
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      function  ReplaceFunc(const aView : InevView;
                            const Container : InevOp;
                            const aBlock    : InevRange): Bool;
        virtual;
        abstract;
        {* - абстрактная функция для замены блока Block на что-то еще.
             Наследники - должны перекрывать данную функцию. }
      procedure Cleanup;
        override;
        {-}
      procedure DoStart;
        override;
        {-}
      procedure DoFinish(aCancel: Bool; const aBlock: InevRange);
        override;
        {-}
    public
    // public methods
        {-}
      class function Make(const aText : AnsiString;
                          anOptions   : TevSearchOptionSet = []): IevReplacer;
        reintroduce;
        {-}
      function  Replace(const Container : InevOp;
                        const aBlock    : InevRange;
                        const aConfirm  : InevConfirm): Bool;
        {* - невиртуальная функция, вызываемая из цикла поиска для замены найденного фрагмента.
             Для определения функциональности замены - необходимо перекрывать ReplaceFunc.}
    public
    // public properties
      property Searcher: IevSearcher
        read f_Searcher
        write f_Searcher;
        {-}
    published
    {published events}
      property OnReplaceConfirm: TevReplaceConfirmEvent
        read f_OnReplaceConfirm
        write f_OnReplaceConfirm;
        {* - событие для подтверждения замены. }
      property OnFinishReplace: TevFinishReplaceEvent
        read f_OnFinishReplace
        write f_OnFinishReplace;
        {* - событие, вызываемое при завершении цикла поиска/замены. }
  end;//TevBaseReplacer

  TevBlockCollector = class(TevBaseReplacer)
    private
    // internal fields
      f_Block : IevdDataObject;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function  ReplaceFunc(const aView : InevView;
                            const Container : InevOp;
                            const aBlock    : InevRange): Bool;
        override;
        {-}
    public
    // public properties
      property Block: IevdDataObject
        read f_Block;
        {-}
  end;//TevBlockCollector

  TevCustomHyperLinkReplacer = class(TevBaseReplacer)
   {* Базовый класс инструментов для обработки найденных гипертекстовых ссылок. }
  end;//TevCustomHyperLinkReplacer

  TevHyperLinkReplacer = class(TevCustomHyperLinkReplacer)
   {* Инструмент для обработки найденных гипертекстовых ссылок. }
    private
    // event fields
      f_OnHyperlinkReplace : TevHyperlinkEvent;
    public
    // public methods
      function  ReplaceFunc(const aView : InevView;
                            const Container : InevOp;
                            const aBlock    : InevRange): Bool;
        override;
        {-}
    published
    // published properties
      property OnHyperlinkReplace: TevHyperlinkEvent
        read f_OnHyperlinkReplace
        write f_OnHyperlinkReplace;
        {* - событие для обработки гипертекстовой ссылки. }
  end;//TevHyperLinkReplacer

  TevSubReplacer = class(TevBaseReplacer)
   {* Инструмент для простановки меток на найденный фрагмент. }
    private
    // property fields
      f_Layer : Long;
    private
    // event fields
      f_OnGetSubHandle : TevGetSubHandleEvent;
    protected
    // property methods
      function  pm_GetDefaultText: AnsiString;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: TevSearchToolOwner = nil);
         override;
         {-}
      function  ReplaceFunc(const aView : InevView;
                            const Container : InevOp;
                            const aBlock    : InevRange): Bool;
        override;
        {-}
    public
    // public properties
      property Layer: Long
        read f_Layer
        write f_Layer
        default Ord(ev_sbtSub);
        {* - слой в который ставить метки. }
    published
    // published properties
      property OnGetSubHandle: TevGetSubHandleEvent
        read f_OnGetSubHandle
        write f_OnGetSubHandle;
        {* - событие для получения номера метки. }
  end;//TevSubReplacer

  TevStyleReplacer = class(TevBaseReplacer)
   {* Инструмент для замены найденного стилем. }
    private
    // property fields
      f_Style     : TevStyleInterface;
      f_WholePara : Bool;
    protected
    // property methods
      function  pm_GetText: AnsiString;
        override;
      function  pm_GetDefaultText: AnsiString;
        override;
        {-}
    protected
    // internal methods
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function MakeForStyleID(const aStyleID : Integer;
                                    anOptions      : TevSearchOptionSet = []): IevReplacer;
        {-}
      function  ReplaceFunc(const aView : InevView;
                            const Container : InevOp;
                            const aBlock    : InevRange): Bool;
        override;
        {-}
    public
    // public properties
      property WholePara: Bool
        read f_WholePara
        write f_WholePara
        default false;
        {* - применять стиль к целому параграфу? }
  end;//TevStyleReplacer

  TevTextReplacer = class(TevBaseReplacer)
   {* Иструмент для замены найденного текстом. }
    private
      f_HasEOL: Boolean;
      f_MemStream: Tl3ConstMemoryStream;
    protected
      procedure DoSetText(const Value: AnsiString); override;
      procedure Cleanup; override;
    public
    // public methods
      function  ReplaceFunc(const aView : InevView;
                            const Container : InevOp;
                            const aBlock    : InevRange): Bool;
        override;
        {-}
  end;//TevTextReplacer

  TevRegExpReplacer = class(TevTextReplacer)
   {* Иструмент для замены найденного текстом c исп. регулярных выражений (с тегами). }
    public
    // public methods
      function ReplaceFunc(const aView : InevView;
                           const Container : InevOp;
                           const aBlock    : InevRange): Bool;
        override;
        {-}
  end;//TevRegExpReplacer

  TevSearchPlace = (ev_spAll, ev_spSegments, ev_spPara);
   {* Место поиска. }

  TevStyleSearcher = class(TevBaseSearcher)
   {* Инструмент для поиска стиля, примененного к параграфу или его части. }
    private
    // property fields
      f_Layer       : Long;
      f_Style       : TevStyleInterface;
      f_SearchPlace : TevSearchPlace;
    protected
      f_CurrentSeg  : Tl3Variant;
    protected
    // property methods
      function  pm_GetNotFoundMessage: AnsiString;
        override;
        {-}
      function  pm_GetDefaultText: AnsiString;
        override;
        {-}
      function  pm_GetText: AnsiString;
        override;
      function  pm_GetHandle: Long;
        reintroduce;
      procedure pm_SetHandle(Value: Long);
        reintroduce;
        {-}
    protected
    // internal methods
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
     function IsStyleFound(aStyle : Tl3Variant): Boolean;
       virtual;
       {-}
    protected
      property Style: TevStyleInterface
        read f_Style;
        {-}   
    public
    // public methods
      class function Make(aStyle    : Long;
                          aLayer    : Long = l3NilLong;
                          aPlace    : TevSearchPlace = ev_spAll;
                          anOptions : TevSearchOptionSet = [];
                          aNext     : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
    public
    // public properties
      property Layer: Long
        read f_Layer
        write f_Layer;
        {* - идентификатор слоя для поиска (см. evSegLst). }
      property Handle: Long
        read pm_GetHandle
        write pm_SetHandle;
        {* - идентификатор стиля для поиска (см. evStyles). }
      property SearchPlace : TevSearchPlace
        read f_SearchPlace
        write f_SearchPlace
        default ev_spAll;
        {* - где искать? }
  end;//TevStyleSearcher

  TevCustomHyperlinkSearcher = class(TevStyleSearcher)
   {* Базовый инструмент для поиска гиперсылок. }
    private
    // property fields
      f_Text : AnsiString;
    protected
    // property methods
      function  pm_GetText: AnsiString;
        override;
      function  pm_GetNotFoundMessage: AnsiString;
        override;
        {-}
      function  pm_GetDefaultText: AnsiString;
        override;
        {-}
    protected
    //internal methods
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      function DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
        virtual;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    //public methods
      constructor Create(anOwner: TevSearchToolOwner = nil);
        override;
        {-}
      class function Make(anOptions : TevSearchOptionSet = [];
                          aNext     : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
  end;//TevCustomHyperlinkSearcher

  TevHyperlinkSearcher = class(TevCustomHyperlinkSearcher)
   {* Инструмент для поиска гиперсылок по адресу. }
    private
    // event fields
      f_OnHyperlinkSearch : TevHyperlinkEvent;
      f_SHyperAddr : TevAddress;
    protected
    // internal methods
      function DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
        override;
        {-}
    public
      property SearchHyperAddress: TevAddress
        read f_SHyperAddr
        write f_SHyperAddr;
        {* - адрес искомой ссылки. }
    published
    // published events
      property OnHyperlinkSearch: TevHyperlinkEvent
        read f_OnHyperlinkSearch
        write f_OnHyperlinkSearch;
        {* - событие для определения критерия найдена ссылка или нет. }
  end;//TevHyperlinkSearcher

  TevHyperlinkIDSearcher = class(TevCustomHyperlinkSearcher)
   {* Инструмент для поиска гиперссылок по идентификатору. }
    private
    // property fields
      f_ID : Long;
    protected
    // internal methods
      function DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
        override;
        {-}
    published
    // published properties
      property ID: Long
        read f_ID
        write f_ID;
        {* - идентификатор ссылки для поиска. }
  end;//TevHyperlinkIDSearcher

  TevBMTextSearcher = class(TevBaseSearcher)
   {* Класс инструментов для поиска подстроки методом Боера-Мура. }
    private
    // property fields
      f_OriginalString : Tl3String;
      f_ANSISearch     : Tl3String;
      f_OEMSearch      : Tl3String;
      f_ANSIBMTable    : Tl3BMTable;
      f_OEMBMTable     : Tl3BMTable;
      f_SearchFunc     : Tl3SearchFunc;
      f_UnicodeSearch  : TUTBMSearch;
    protected
    // property methods
      function  pm_GetNotFoundMessage: AnsiString;
        override;
        {-}
      function  pm_GetText: AnsiString;
        override;
    protected
    {internal methods}
      procedure ChooseSearchFunc;
        {-}
      procedure OptionsChanged;
        override;
        {-}
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      procedure MakeStrings;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
  end;//TevBMTextSearcher

  TevWordFromBeginningSearcher = class(TevBMTextSearcher)
   public
   function DoCheckText(aPara : Tl3Variant;
                        aText       : Tl3CustomString;
                        const aSel  : TevPair;
                        out theSel  : TevPair): Bool;
        override;
        {-}
  end;//TevWordFromBeginningSearcher

  TevStrictWordSearcher = class(TevBMTextSearcher)
  private
  protected
   function IsWordDelim(const aChar: AnsiChar; aCodePage: Long): Boolean; virtual;
  public
   function DoCheckText(aPara : Tl3Variant;
                        aText       : Tl3CustomString;
                        const aSel  : TevPair;
                        out theSel  : TevPair): Bool;
        override;
        {-}
  end;//TevStrictWordSearcher

  TevTextSearcher = class(TevBaseSearcher)
   {* Базовый класс для инструментов поиска подстроки. }
    private
    // property fields
      f_Text  : Tl3String;
    protected
    // property methods
      function  pm_GetText: AnsiString;
        override;
    protected
    // internal methods    
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
  end;//TevTextSearcher

  TevNormalWordSearcher = class(TevTextSearcher)
   {* Класс инструментов для поиска подстроки с нормализацией. }
    private
    // property fields
      {$IfDef evNeedNormalWordSearcher}
      f_Check : TmgFindFormChecker;
      {$EndIf evNeedNormalWordSearcher}
    protected
    // internal methods
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
  end;//TevNormalWordSearcher

  TevFakeSearcher = class(TevBaseSearcher)
    public
    // public methods
      class function Make: IevSearcher;
        reintroduce;
        {-}
  end;//TevFakeSearcher

  TevEmptyTextSearcher = class(TevFakeSearcher)
    protected
    // internal methods
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
  end;//TevEmptyTextSearcher

  TevContinuousTextSearchController = class(TevBaseSearcher)
    protected
    // internal methods
      function DoCheckTextEx(aPara    : Tl3Variant;
                             aText          : Tl3CustomString;
                             const aSel     : TevPair;
                             const aPrevSel : TevPair;
                             out theSel     : TevPair): Bool;
        override;
        {-}
  end;//TevContinuousTextSearchController

  TevAnyParagraphSearcher = class(TevFakeSearcher)
  {* - Класс для нахождения любого параграфа. }
    protected
    // internal methods
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel  : TevPair): Bool;
        override;
        {-}
  end;//TevAnyParagraphSearcher

  TevSpecialParagraphSearcher = class(TevFakeSearcher)
  {* - Антошина версия TevAnyParagraphSearcher - оставлена для совместимости. }
    protected
    // internal methods
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
  end;//TevAnyParagraphSearcher

  TevParaPlace = (ev_ppStart, ev_ppEnd, ev_ppWhole, ev_ppInner);

  TevParaPlaceSearcer = class(TevFakeSearcher)
    private
    // internal fields
      f_Place : TevParaPlace;
    protected
    // internal methods
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
    public
    // public methods
      class function Make(aPlace      : TevParaPlace;
                          const aNext : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
  end;//TevParaPlaceSearcer

  TevInvertSearcher = class(TevBaseSearcher)
    private
    // internal fields
      f_Searcher : IevSearcher;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure DoStart;
        override;
        {-}
      procedure DoFinish(aCancel: Bool; const aBlock: InevRange);
        override;
        {-}
      function DoCheck(const aView : InevView;
                       const aBlock    : InevRange;
                       out theStart    : InevBasePoint;
                       out theFinish   : InevBasePoint;
                       const PrevBlock : InevRange): Bool;
        override;
        {* - определяет критерий отбора параграфа (его фрагмента). }
    public
    // public methods
      constructor Create(const aSearcher : IevSearcher);
        reintroduce;
        {-}
      class function Make(const aSearcher : IevSearcher;
                          aNext           : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
  end;//TevInvertSearcher

  TevSearchers = array of IevSearcher;

  TevORSearcher = class(TevBaseSearcher)
    private
    // internal fields
      f_Searchers : TevSearchers;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure DoStart;
        override;
        {-}
      procedure DoFinish(aCancel: Bool; const aBlock: InevRange);
        override;
        {-}
      function DoCheck(const aView : InevView;
                       const aBlock    : InevRange;
                       out theStart    : InevBasePoint;
                       out theFinish   : InevBasePoint;
                       const PrevBlock : InevRange): Bool;
        override;
        {* - определяет критерий отбора параграфа (его фрагмента). }
      procedure Add(const aSearcher: IevSearcher);
        {-}
    public
    // public methods
      constructor Create(const aSearchers : array of IevSearcher);
        reintroduce;
        {-}
      class function Make(const aSearchers : array of IevSearcher;
                          aNext            : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
  end;//TevORSearcher

  TevStylesSearcher = class(TevORSearcher)
    public
    // public methods
      class function Make(const aStyles : array of Long;
                          aLayer        : Long = l3NilLong;
                          aPlace        : TevSearchPlace = ev_spAll;
                          anOptions     : TevSearchOptionSet = [];
                          aNext         : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
  end;//TevStylesSearcher

  TevOneLevelSearcher = class(TevBaseSearcher)
    private
    // internal fields
      f_Parent : Tl3Variant;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function DoCheck(const aView : InevView;
                       const aTag        : InevObject;
                       const aStart      : InevBasePoint;
                       const aFinish     : InevBasePoint;
                       const aStartPrev  : InevBasePoint;
                       const aFinishPrev : InevBasePoint;
                       out theSel        : TevPair): Bool;
        override;
        {* - определяет критерий отбора параграфа (его фрагмента). }
    public
    // public methods
      constructor Create(aParent : Tl3Variant);
        reintroduce;
        {-}
      class function Make(aParent : Tl3Variant;
                          aNext         : IevSearcher = nil): IevSearcher;
        reintroduce;
        {-}
  end;//TevOneLevelSearcher

  IevTaggedSearcher = interface(InevBase)
    ['{4A99E210-2F56-48BD-A635-8CEAD99BCF94}']
    // public methods
      function GetTag(Idx: Integer): AnsiString;
        {-}
      function GetTagCount: Integer;
        {-}
  end;//IevTaggedSearcher

  TevRegularExpressionSearcher = class(TevTextSearcher, IevTaggedSearcher)
   {* Класс инструментов для поиска регулярного выражения. }
    private
    // internal fields
      f_PersistentStr: Tl3CustomString;
      f_SrchMashine : Tl3RegularSearch;
    protected
    // internal methods
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      function GetTag(Idx: Integer): AnsiString;
        virtual;
        {-}
      function GetTagCount: Integer;
        virtual;
        {-}
    public
    // public methods
      constructor Create(aOwner: TevSearchToolOwner = nil);
        override;
        {-}
      class function SmartMake(const aText : AnsiString;
                               anOptions   : TevSearchOptionSet = [];
                               aNext       : IevSearcher = nil): IevSearcher;
        {-}
      function DoCheckText(aPara : Tl3Variant;
                           aText       : Tl3CustomString;
                           const aSel  : TevPair;
                           out theSel : TevPair): Bool;
        override;
        {-}
  end;//TevRegularExpressionSearcher

  TevRegExpMultipartSearcher = class(TevBaseMultipartSearcher, IevTaggedSearcher)
    private
    // internal fields
      FTags: Tl3StringList;
    protected
    // internal methods
      procedure DoSetText(const aValue: AnsiString);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      function GetTag(Idx: Integer): AnsiString;
        virtual;
        {-}
      function GetTagCount: Integer;
        virtual;
      procedure CollectTags;
        virtual;
        {-}
      function DoCheck(const aView : InevView;
                       const aBlock    : InevRange;
                       out theStart    : InevBasePoint;
                       out theFinish   : InevBasePoint;
                       const PrevBlock : InevRange): Bool;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: TevSearchToolOwner = nil);
        override;
        {-}
  end;//TevRegExpMultipartSearcher
  
  TevMorphologySearcher = class(TevBaseMultipartSearcher)
    protected
    // internal methods
      procedure DoSetText(const aValue: AnsiString);
        override;
        {-}
  end;//TevMorphologySearcher

  EevRegExpReplacerError = class(Exception)
  end;//EevRegExpReplacerError

  TevParaByIDSearcher = class(TevBaseSearcher)
    private
    // property fields
      f_ID    : Integer;
      f_AtEnd : Boolean;
    public
    // public methods
      constructor Create(anID           : Integer;
                         aAtEnd         : Boolean = true;
                         anIgnoreHidden : Boolean = false);
        reintroduce;
        {-}
      class function Make(anID           : Integer;
                          aAtEnd         : Boolean = true;
                          anIgnoreHidden : Boolean = false): IevSearcher;
        {-}
      function  DoCheckText(Sender : Tl3Variant;
                            S            : Tl3CustomString;
                            const aSel   : TevPair;
                            out theSel   : TevPair): Bool;
        override;
        {* - определяет критерий отбора параграфа (его фрагмента). }
    public
    // public properties
      property ID: Integer
        read f_ID
        write f_ID;
        {* - искомый идентификатор. }
  end;//TevParaByIDSearcher
{$EndIf evUseVisibleCursors}

implementation

{$IfDef evUseVisibleCursors}
uses
  Messages,
  StrUtils,
  Controls,

  l3InternalInterfaces,
  l3MinMax,
  l3String,
  l3InterfacesMisc,
  l3Parser,
  l3Utils,
  l3KeyWrd,
  l3Variant,

  k2Types,
  k2Facade,
  k2Base,
  k2Tags,

  evSegLst,
  evOp,
  evExcept,
  evdStyles,
  evHyperlink,
  evParaTools,
  evCursorTools,
  evCursorConst,

  TextPara_Const
  , l3PrimString, l3CustomString;

resourcestring
 SErrorInRegExpReplaceString    = 'TevRegExpReplacer: Неправильная строка замены!';
 SErrorInRegExpTagString        = 'TevRegExpReplacer: Неправильный тег!';
 SErrorInRegExpUnclosedTag      = 'TevRegExpReplacer: Тег не закрыт!';
 SErrorInRegExpInvalidTagNumber = 'TevRegExpReplacer: Неверный номер тега!';
 c_EOP = '$';
 c_Arrow = '^';

// start class TevSearchTool 

constructor TevSearchTool.Create(anOwner: TevSearchToolOwner = nil);
  {override;}
  {-}
begin
// f_TypeTable := k2.TypeTable;
 {$IfDef evSearchToolIsComponent}
 inherited;
 {$Else  evSearchToolIsComponent}
 inherited Create;
 {$EndIf evSearchToolIsComponent}
 Options := [];
end;

procedure TevSearchTool.Cleanup;
  {override;}
  {-}
begin
 inherited;
// f_TypeTable := nil;
end;

procedure TevSearchTool.Start;
  {-}
begin
 if (Self <> nil) then DoStart;
end;

procedure TevSearchTool.Finish(aCancel: Bool; const aBlock: InevRange);
  {* - конец пачки замен. }
begin
 if (Self <> nil) then
  DoFinish(aCancel, aBlock);
end;

procedure TevSearchTool.DoStart;
  //virtual;
  {-}
begin
end;

procedure TevSearchTool.DoFinish(aCancel: Bool; const aBlock: InevRange);
  //virtual;
  {-}
begin
end;

function TevSearchTool.pm_GetOptions: TevSearchOptionSet;
begin
 Result := f_Options;
end;

procedure TevSearchTool.pm_SetOptions(Value: TevSearchOptionSet);
  {virtual;}
  {-}
begin
 if (f_Options <> Value) then
 begin
  f_Options := Value;
  OptionsChanged;
 end;//f_Options <> Value
end;

procedure TevSearchTool.OptionsChanged;
  //virtual;
  {-}
begin
end;
  
function TevSearchTool.pm_GetText: AnsiString;
  {virtual;}
  {-}
begin
 Result := '';
end;

procedure TevSearchTool.pm_SetText(const Value: AnsiString);
  {-}
begin
 DoSetText(Value);
 DoTextChanged;
end;

procedure TevSearchTool.DoTextChanged;
  //virtual;
  {-}
begin
 if Assigned(f_OnTextChanged) then OnTextChanged(Self);
end;

procedure TevSearchTool.DoSetText(const Value: AnsiString);
  //virtual;
  {-}
begin
end;

function TevSearchTool.pm_GetDefaultText: AnsiString;
  {virtual;}
  {-}
begin
 Result := '';
end;

// start class TevBaseSearcher 

constructor TevBaseSearcher.Create(anOwner: TevSearchToolOwner = nil);
  //override;
  {-}
begin
 inherited;
 IgnoreHidden := true;
end;

class function TevBaseSearcher.Make(const aText : AnsiString;
                                    anOptions   : TevSearchOptionSet = [];
                                    aNext       : IevSearcher = nil): IevSearcher;
  //overload;
  {-}
var
 l_Searcher : TevBaseSearcher;
begin
 l_Searcher := Create;
 try
  l_Searcher.Options := anOptions;
  l_Searcher.Text := aText;
  l_Searcher.NextSearcher := aNext;
  Result := l_Searcher;
 finally
  l3Free(l_Searcher);
 end;//try..finally
end;

procedure TevBaseSearcher.Cleanup;
  //override;
  {-}
begin
 NextSearcher := nil;
 inherited;
end;

function TevBaseSearcher.pm_GetNotFoundMessage: AnsiString;
  {virtual;}
  {-}
begin
 Result := 'Поиск не дал результата.';
end;

procedure TevBaseSearcher.pm_SetNextSearcher(const aValue: IevSearcher);
  {-}
begin
 f_NextSearcher := aValue;
end;

procedure TevBaseSearcher.DoStart;
  //override;
  {-}
begin
 inherited;
 if (NextSearcher <> nil) then
  NextSearcher.Start;
end;

procedure TevBaseSearcher.DoFinish(aCancel: Bool; const aBlock: InevRange);
  //override;
  {-}
begin
 if (NextSearcher <> nil) then
  NextSearcher.Finish(aCancel, aBlock);
 inherited;
end;

function TevBaseSearcher.DoCheck(const aView : InevView;
                                 const aBlock    : InevRange;
                                 out theStart    : InevBasePoint;
                                 out theFinish   : InevBasePoint;
                                 const PrevBlock : InevRange): Bool;
  //overload;
  //virtual;
  {* - определяет критерий отбора параграфа (его фрагмента). }
var
 l_Sel  : TevPair;
 l_S    : InevBasePoint;
 l_F    : InevBasePoint;
 l_Para : InevPara;
begin
 Result := Check(aView, aBlock, l_Sel, PrevBlock);
 if Result then
 begin
  l_Para := aBlock.Obj.AsPara;
  with l_Para do
  begin
   l_S := MakePoint;
   try
    l_S.SetEntryPointPrim(l_Sel.rStart);
    theStart := l_S;
   finally
    l_S := nil;
   end;//try..finally
   l_F := MakePoint;
   try
    l_F.SetEntryPoint(l_Sel.rFinish);
    theFinish := l_F;
   finally
    l_F := nil;
   end;//try..finally
  end;//with l_Para
 end//Result
 else
 begin
  theStart := nil;
  theFinish := nil;
 end;//Result
end;

function TevBaseSearcher.Check(const aView : InevView;
                               const aBlock    : InevRange;
                               out theStart    : InevBasePoint;
                               out theFinish   : InevBasePoint;
                               const PrevBlock : InevRange): Bool;
  //overload;
  //virtual;
  {* - определяет критерий отбора параграфа (его фрагмента). }
var
 l_Start      : InevBasePoint;
 l_Finish     : InevBasePoint;
 l_Block      : InevRange;
 l_Block1     : InevRange;
 l_OuterBlock : InevRange;
begin
 l_OuterBlock := aBlock;
 try
  repeat
   Result := DoCheck(aView, l_OuterBlock, theStart, theFinish, PrevBlock);
   if Result AND (NextSearcher <> nil) then
   begin
    theStart := theStart.PointToParentByLevel(MaxInt);
    // - здесь может неправильно работать, когда ищем не с корневого документа
    if (theStart = nil) then
     Assert(false, 'Не должно такого быть');
    theFinish := theFinish.PointToParentByLevel(MaxInt);
    if (theFinish = nil) then
     Assert(false, 'Не должно такого быть');
    try
     l_Block := theStart.Obj.Range(theStart, theFinish);
     l_Block1 := l_Block.BottomChildBlock(aView);
     try
      if NextSearcher.Check(aView, l_Block1, l_Start, l_Finish, l_OuterBlock) then
      begin
       try
        theStart := l_Start;
        theFinish := l_Finish;
        Break;
       finally
        l_Start := nil;
        l_Finish := nil;
       end;//try..finally
      end//NextSearcher.Check
      else
      begin
       Result := false;
       try
        if theFinish.MostInner.AtEnd(aView) then
         // - достигли конца параграфа - выходим
         Break;
        l_OuterBlock := theStart.MostInner.Obj.Range(theFinish.MostInner,
                                                     nil);
       finally
        theStart := nil;
        theFinish := nil;
       end;//try..finally
      end;//NextSearcher.Check
     finally
      l_Block1 := nil;
     end; {try..finally}
    finally
     l_Block := nil;
    end;//try..finally
   end//Result..
   else
    Break;
  until False;
 finally
  l_OuterBlock := nil;
 end;//try..finally
end;

function TevBaseSearcher.Check(const aView : InevView;
                               const aBlock    : InevRange;
                               out theSel      : TevPair;
                               const PrevBlock : InevRange): Bool;
  {* - определяет критерий отбора параграфа (его фрагмента). }
var
 l_Start      : InevBasePoint;
 l_Finish     : InevBasePoint;
 l_StartPrev  : InevBasePoint;
 l_FinishPrev : InevBasePoint;
begin
 aBlock.GetBorderPoints(l_Start, l_Finish);
 if (l_Start <> nil) AND (l_Finish = nil) then
  if (l_Start.Position = ev_cpAtEnd) then
  // - стоим на самом конце параграфа, искать уже нечего
  // http://mdp.garant.ru/pages/viewpage.action?pageId=245761265
  begin
   //Assert(false);
   // - не должны сюда попадать, т.к. поправили TevSolidParaCursor.GetAtEnd
   // http://mdp.garant.ru/pages/viewpage.action?pageId=245761265
   // - ОБЛОМАЙТЕСЬ - ДОЛЖНЫ, так как GetAtEnd вызывается ПОЗЖЕ
   Result := false;
   Exit;
  end;//l_Start.Position = ev_cpAtEnd
 if (PrevBlock <> nil) then
  PrevBlock.GetBorderPoints(l_StartPrev, l_FinishPrev)
 else
 begin
  l_StartPrev := nil;
  l_FinishPrev := nil;
 end;//PrevBlock <> nil
 Result := DoCheck(aView, aBlock.Obj^, l_Start, l_Finish, l_StartPrev, l_FinishPrev, theSel);
end;

function TevBaseSearcher.DoCheckTextEx(aPara    : Tl3Variant;
                                       aText          : Tl3CustomString;
                                       const aSel     : TevPair;
                                       const aPrevSel : TevPair;
                                       out theSel     : TevPair): Bool;
begin
 Result := DoCheckText(aPara, aText, aSel, theSel);
end;


function TevBaseSearcher.DoCheck(const aView : InevView;
                                 const aTag        : InevObject;
                                 const aStart      : InevBasePoint;
                                 const aFinish     : InevBasePoint;
                                 const aStartPrev  : InevBasePoint;
                                 const aFinishPrev : InevBasePoint;
                                 out theSel        : TevPair): Bool;
  {* - определяет критерий отбора параграфа (его фрагмента). }
var
 l_Text    : Tl3CustomString;
 l_Sel     : TevPair;
 l_PrevSel : TevPair;
begin
 with aTag.AsObject.Attr[k2_tiText] do
  if IsValid then
   l_Text := AsObject As Tl3CustomString
  else
   l_Text := nil;
 if (aStart = nil) then
  l_Sel.rStart := 0
 else
 if aStart.AtEnd(aView) then
  l_Sel.rStart := ev_cpAtEnd
 else
  l_Sel.rStart := aStart.Position;
 if (aFinish = nil) then
  l_Sel.rFinish := ev_cpAtEnd
 else
 if aFinish.AtEnd(aView) then
  l_Sel.rFinish := ev_cpAtEnd
 else
  l_Sel.rFinish := aFinish.Position;
 if (aStartPrev = nil) then
  l_PrevSel.rStart := 0
 else
 if aStartPrev.AtEnd(aView) then
  l_PrevSel.rStart := ev_cpAtEnd
 else
  l_PrevSel.rStart := aStartPrev.Position;
 if (aFinishPrev = nil) then
  l_PrevSel.rFinish := ev_cpAtEnd
 else
 if aFinishPrev.AtEnd(aView) then
  l_PrevSel.rFinish := ev_cpAtEnd
 else
  l_PrevSel.rFinish := aFinishPrev.Position;
 Result := DoCheckTextEx(aTag.AsObject, l_Text, l_Sel, l_PrevSel, theSel);
 if (l_Sel.rFinish = ev_cpAtEnd) AND (theSel.rFinish <> ev_cpAtEnd) then
  // - конец выделения стоял в конце параграфа - нам нашли не до конца
  if (theSel.rStart = theSel.rFinish) then
  // - проверим - а не совпадает ли начало с концом
  begin
   if (l_Text <> nil) and (l_Text.Len = theSel.rStart) then
   begin
    theSel.rStart := ev_cpAtEnd;
    theSel.rFinish := ev_cpAtEnd;
   end;//l_Text.Len = theSel.rStart
  end;//theSel.rStart = theSel.rFinish..
 if IgnoreHidden AND Result then
 begin
  // - эта проверка оказалась не очень дешевой, поэтому проверяем после того как найдено
  if (aView <> nil) then
  // - без этой проверки не работала evReplaceInPara
  begin
   if (aView.Metrics.HiddenStyles <> []) then
   // - так побыстрее будет
    if Result AND aView.FormatInfoByPara(aTag).IsHidden(true, true) then
     Result := false;
  end;//aView <> nil
 end;//IgnoreHidden..
end;

// start class TevBMTextSearcher 

procedure TevBMTextSearcher.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_OriginalString);
 l3Free(f_ANSISearch);
 l3Free(f_OEMSearch);
 l3Free(f_UnicodeSearch);
 inherited;
end;

function TevBMTextSearcher.pm_GetText: AnsiString;
  {override;}
  {-}
begin
 if (f_OriginalString = nil) then
  Result := ''
 else
  Result := f_OriginalString.AsString;
end;

procedure TevBMTextSearcher.MakeStrings;
  {-}
var
 l_UnicodeStr: Tl3String;
 l_Options : TUCSearchFlags;
begin
 if (f_OriginalString <> nil) then
 begin
  if (f_ANSISearch = nil) then
   f_ANSISearch := Tl3String.Make(f_OriginalString)
  else
   f_ANSISearch.Assign(f_OriginalString);
  if (f_OEMSearch = nil) then
   f_OEMSearch := Tl3String.Make(f_OriginalString)
  else
   f_OEMSearch.Assign(f_OriginalString);
  f_OEMSearch.CodePage := CP_OEM;
  if not (ev_soMatchCase in Options) then
  begin
   f_ANSISearch.MakeUpper;
   f_OEMSearch.MakeUpper;
  end;//not (ev_soMatchCase in Options)
  f_ANSISearch.MakeBMTable(f_ANSIBMTable);
  f_OEMSearch.MakeBMTable(f_OEMBMTable);
  if f_UnicodeSearch = nil then
   f_UnicodeSearch := TUTBMSearch.Create{(Self)}
  else
   f_UnicodeSearch.Clear; 
  l_UnicodeStr := Tl3String.Make(f_OriginalString);
  try
   l_UnicodeStr.CodePage := CP_Unicode;
   l_Options := [sfSpaceCompress];
   if ev_soMatchCase in Options then
    l_Options := l_Options + [sfCaseSensitive];
   f_UnicodeSearch.FindPrepare(l_UnicodeStr.AsPWideChar, l_Options);
  finally
   l3Free(l_UnicodeStr);
  end;
 end;//f_OriginalString <> nil
end;

procedure TevBMTextSearcher.DoSetText(const Value: AnsiString);
  {override;}
  {-}
begin
 if (f_OriginalString = nil) then
  f_OriginalString := Tl3String.Make(l3PCharLen(Value))
 else
  f_OriginalString.AsPCharLen := l3PCharLen(PAnsiChar(@Value[1]), Length(Value));
 MakeStrings;
end;

procedure TevBMTextSearcher.ChooseSearchFunc;
  {-}
begin
 if (ev_soMatchCase in Options) then
  f_SearchFunc := l3SearchStr
 else
  f_SearchFunc := l3SearchStrUC;
end;

procedure TevBMTextSearcher.OptionsChanged;
  {override;}
  {-}
begin
 inherited;
 ChooseSearchFunc;
 MakeStrings;
end;

function TevBMTextSearcher.pm_GetNotFoundMessage: AnsiString;
  {override;}
  {-}
begin
 Result := Format('Строка "%s" не найдена.', [f_OriginalString.AsString]);
end;

function TevBMTextSearcher.DoCheckText(aPara : Tl3Variant;
                                       aText       : Tl3CustomString;
                                       const aSel  : TevPair;
                                       out theSel : TevPair): Bool;
  {override;}
  {-}

 function lp_CheckLayer: Boolean;
 var
  l_NotFound: Boolean absolute Result;

  function lp_CheckSegmant(aSeg: Tl3Variant; anIndex: Long): Boolean;
  begin
   l_NotFound := False; // Нам достаточно первого вхождения.
   Result := l_NotFound;
  end;

 var
  l_Segments : Tl3Variant;
  l_Layer    : Tl3Variant;
 begin
  l_NotFound := True;
  l_Segments := aPara.Attr[k2_tiSegments];
  if l_Segments.IsValid then
  begin
   l_Layer := evSegments_GetLayer(l_Segments, ev_slObjects);
   evSegmentsLayer_IterateSegmentsF(aPara.AsObject, l_Layer, theSel.rStart, theSel.rFinish, L2Mk2ChildrenIterateChildrenFAction(@lp_CheckSegmant))
  end; // if l_Segments.IsValid then
 end;

var
 P : Cardinal;
 L : Long;
 l_Start, l_Finish: Integer;
 l_S : Tl3PCharLen;
 l_SS : Tl3PCharLen;
 l_BT : ^Tl3BMTable;
begin
 if not Assigned(f_SearchFunc) then
  ChooseSearchFunc;
 if Assigned(f_SearchFunc) AND not aText.Empty and (aSel.rStart <> ev_cpAtEnd) then
 begin
  l_S := aText.AsPCharLen;
  L := Min(l_S.SLen, aSel.rFinish);
  Assert((L = 0) or (L >= aSel.rStart),'Impossible !!');
  if (l_S.SCodePage = CP_Unicode) then
  begin
   Result := f_UnicodeSearch.FindAll(PWideChar(@PWideChar(l_S.S)[aSel.rStart]), L - aSel.rStart);
   if Result then
   begin
    f_UnicodeSearch.GetResult(0, l_Start, l_Finish);
    theSel.rStart := l_Start + aSel.rStart;
    theSel.rFinish := l_Finish + aSel.rStart;
    Result := lp_CheckLayer;
   end;//Result
  end//l_S.SCodePage = CP_Unicode
  else
  begin
   if l3IsOEMEx(l_S.SCodePage) then
   begin
    l_SS := f_OEMSearch.AsPCharLen;
    l_BT := @f_OEMBMTable;
   end//l3IsOEMEx(l_S.SCodePage)
   else
   begin
    l_SS := f_ANSISearch.AsPCharLen;
    l_BT := @f_ANSIBMTable;
   end;//l3IsOEMEx(l_S.SCodePage)
   Result := f_SearchFunc(l3PCharLen(l_S.S + aSel.rStart, L - aSel.rStart, l_S.SCodePage), l_BT^, l_SS, P);
   if Result then
   begin
    theSel.rStart := P + aSel.rStart;
    theSel.rFinish := theSel.rStart + f_ANSISearch.Len;
    Result := lp_CheckLayer;
   end//Result
  end;//l_S.SCodePage = CP_Unicode
  if not Result then
  begin
   theSel.rStart := -1;
   theSel.rFinish := -1;
  end;//Result
 end//Assigned(f_SearchFunc)
 else
  Result := false;
end;


// start class TevStrictWordSearcher

function TevStrictWordSearcher.DoCheckText(aPara : Tl3Variant;
                     aText       : Tl3CustomString;
                     const aSel  : TevPair;
                     out theSel  : TevPair): Bool;
//        override;
var
 l_Sel   : TevPair;
begin
 l_Sel := aSel;
 repeat
  Result := inherited DoCheckText(aPara, aText, l_Sel, theSel);
  if Result then
  begin
   Result := (theSel.rStart = 0) or l3IsWordDelim(aText.St[theSel.rStart-1], aText.CodePage);
   Result := Result and ((theSel.rFinish = aText.Len) or  IsWordDelim(aText.St[theSel.rFinish], aText.CodePage));
   if Result then
    Break
   else
    l_Sel.rStart := theSel.rFinish;
  end
  else
   Break;
 until False;
end;

function TevStrictWordSearcher.IsWordDelim(const aChar: AnsiChar; aCodePage: Long): Boolean;
begin
 Result := l3IsWordDelim(aChar, aCodepage);
end;

// start class TevWordFromBeginningSearcher

function TevWordFromBeginningSearcher.DoCheckText(aPara : Tl3Variant;
                     aText       : Tl3CustomString;
                     const aSel  : TevPair;
                     out theSel  : TevPair): Bool;
//        override;
var
 l_Sel   : TevPair;
begin
 l_Sel := aSel;
 repeat
  Result := inherited DoCheckText(aPara, aText, l_Sel, theSel);
  if Result then
  begin
   Result := (theSel.rStart = 0) or l3IsWordDelim(aText.St[theSel.rStart-1], aText.CodePage);
   if Result then
   begin
    while not ((theSel.rFinish = aText.Len) or l3IsWordDelim(aText.St[theSel.rFinish], aText.CodePage)) do
     theSel.rFinish := theSel.rFinish+1;
    Break;
   end
   else
    l_Sel.rStart := theSel.rFinish;
  end
  else
   Break;
 until False;
end;


// start class TevStyleSearcher

class function TevStyleSearcher.Make(aStyle    : Long;
                                     aLayer    : Long = l3NilLong;
                                     aPlace    : TevSearchPlace = ev_spAll;
                                     anOptions : TevSearchOptionSet = [];
                                     aNext     : IevSearcher = nil): IevSearcher;
  //reintroduce;
  {-}
var
 l_S : TevStyleSearcher;
begin
 l_S := Create;
 try
  l_S.Options := anOptions;
  l_S.NextSearcher := aNext;
  l_S.Handle := aStyle;
  l_S.Layer := aLayer;
  l_S.SearchPlace := aPlace;
  Result := l_S;
 finally
  l3Free(l_S);
 end;//try..finally
end;

function TevStyleSearcher.pm_GetNotFoundMessage: AnsiString;
  {override;}
  {-}
begin
 Result := Format('Стиль "%s" не найден.', [f_Style.Name]);
end;

function TevStyleSearcher.pm_GetDefaultText: AnsiString;
  {override;}
  {-}
begin
 if (f_Style = nil) then Result := '' else Result := f_Style.Name;
end;

function TevStyleSearcher.pm_GetText: AnsiString;
  {override;}
  {-}
begin
 if (f_Style = nil) then Result := '' else Result := f_Style.Name;
end;

procedure TevStyleSearcher.DoSetText(const Value: AnsiString);
  {override;}
  {-}
begin
 if (f_Style = nil) then
 begin
  f_Style := TevStyleInterface.Create;
  f_Style.SelectStyledObjectType(k2_typTextPara);
 end;//f_Style = nil
 f_Style.SelectStyle(Value);
end;

function  TevStyleSearcher.pm_GetHandle: Long;
  {-}
begin
 if (f_Style = nil) then
  Result := ev_saTxtNormalANSI
 else
  Result := f_Style.Style.IntA[k2_tiHandle];
end;

procedure TevStyleSearcher.pm_SetHandle(Value: Long);
  {-}
begin
 if (f_Style = nil) then
 begin
  f_Style := TevStyleInterface.Create;
  f_Style.SelectStyledObjectType(k2_typTextPara);
 end;//f_Style = nil
 f_Style.SelectStyle(Value);
end;

procedure TevStyleSearcher.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Style);
 FreeAndNil(f_CurrentSeg);
 inherited;
end;

function TevStyleSearcher.IsStyleFound(aStyle : Tl3Variant): Boolean;
begin
 Result := aStyle.IsSame(f_Style.Tag);
end;

function TevStyleSearcher.DoCheckText(aPara : Tl3Variant;
                                      aText       : Tl3CustomString;
                                      const aSel  : TevPair;
                                      out theSel : TevPair): Bool;
  {override;}
  {-}

var
 l_Back : Boolean;
   
 function _SearchLayer(SL: Tl3Variant; Index: Long): Bool;

  function _SearchSegment(Seg: Tl3Variant; Index: Long): Bool; 
  begin//_SearchSegment
   Seg.SetRef(f_CurrentSeg);
   if IsStyleFound(Seg.Attr[k2_tiStyle]) then
   begin
    theSel.rStart := Max(aSel.rStart, Pred(Seg.IntA[k2_tiStart]));
    theSel.rFinish := Min(aSel.rFinish, Seg.IntA[k2_tiFinish]);
    DoCheckText := true;
    Result := false;
    _SearchLayer := false;
    Exit;
   end//IsStyleFound(Seg.Attr[k2_tiStyle])
   else
    Result := true;
  end;//_SearchSegment

 var
  l_Start  : Long;
  l_Finish : Long; 
 begin//_SearchLayer
  Result := true;
  l_Start := aSel.rStart;
  if (l_Start <> ev_cpAtEnd) then
   Inc(l_Start);
  l_Finish := aSel.rFinish;
  if (l_Finish <> ev_cpAtEnd) then
   Inc(l_Finish);
  if (Layer = l3NilLong) OR (Layer = SL.IntA[k2_tiHandle]) then
   evSegmentsLayer_IterateSegmentsF(aPara.AsObject, SL.AsObject, l_Start, l_Finish,
                                    L2Mk2ChildrenIterateChildrenFAction(@_SearchSegment), l_Back);
 end;//_SearchLayer

begin
 if ((Layer = l3NilLong) OR (SearchPlace <> ev_spSegments)) AND
    (aSel.rStart < aSel.rFinish) AND
    IsStyleFound(aPara.Attr[k2_tiStyle]) then
 begin
  Result := true;
  theSel.rStart := aSel.rStart;
  if (aText <> nil) and (aText.Len = aSel.rFinish) then
   theSel.rFinish := ev_cpAtEnd
  else
   theSel.rFinish := aSel.rFinish;
 end//Layer = l3NilLong..
 else
 begin
  Result := false;
  if (SearchPlace <> ev_spPara) then
  begin
   l_Back := (ev_soBackward in Options);
   aPara.Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_SearchLayer));
  end;//SearchPlace <> ev_spPara
  if Result then
   if (aText.Len <= theSel.rFinish) then
    theSel.rFinish := ev_cpAtEnd;
 end;//Layer = l3NilLong..
end;

// start class TevNormalWordSearcher 

procedure TevNormalWordSearcher.Cleanup;
  {override;}
  {-}
begin
 {$IfDef evNeedNormalWordSearcher}
 l3Free(f_Check);
 {$EndIF evNeedNormalWordSearcher}
 inherited;
end;

function TevNormalWordSearcher.DoCheckText(aPara : Tl3Variant;
                                           aText       : Tl3CustomString;
                                           const aSel  : TevPair;
                                           out theSel : TevPair): Bool;
  {override;}
  {-}
begin
 {$IfDef evNeedNormalWordSearcher}
 if (f_Check = nil) OR aText.Empty then
  Result := false
 else
  Result := f_Check.SearchEvent({aPara,} aText, aSel.rStart, aSel.rFinish, theSel.rStart, theSel.rFinish);
 {$Else  evNeedNormalWordSearcher}
 Result := false;
 {$IfDef Nemesis}
 Assert(false);
 {$EndIf Nemesis}
 {$EndIf evNeedNormalWordSearcher}
end;

procedure TevNormalWordSearcher.DoSetText(const Value: AnsiString);
  {override;}
  {-}
begin
 inherited;
 {$IfDef evNeedNormalWordSearcher}
 l3Free(f_Check);
  //f_Check := TmgFindFormChecker.Create(f_Text.St, f_Text.Len, false);
 f_Check := TmgFindFormChecker.Create(f_Text.AsPCharLen);
 {$EndIf evNeedNormalWordSearcher}
end;

procedure TevTextReplacer.Cleanup;
begin
 FreeAndNil(f_MemStream);
 inherited;
end;

procedure TevTextReplacer.DoSetText(const Value: AnsiString);
var
 l_S   : Tl3WString;
 l_Len : Integer;
 l_Pos : Cardinal;
 l_EOL : Tl3WString;
begin
 inherited DoSetText(Value);

 FreeAndNil(f_MemStream);
 l_S := f_Replace.AsWStr;

 l_EOL := l3PCharLen(AnsiString(#13#10));
 f_HasEOL := l3Pos(l_S, l_EOL) <> l3NotFound;
 if f_HasEOL then
 begin
  l_Len := l_S.SLen;
  {
  if l3Ends(l_S, l_EOL) then
   Dec(l_Len, 2);
  }
  f_MemStream := Tl3ConstMemoryStream.Create(l_S.S, l_Len);  
 end;//f_HasEOL
end;

// start class TevTextReplacer

function TevTextReplacer.ReplaceFunc(const aView : InevView;
                                     const Container : InevOp;
                                     const aBlock    : InevRange): Bool;
  {override;}
  {-}
begin
 if not f_HasEOL then
  Result := aBlock.Text.Modify.InsertString(aView, f_Replace, Container, true, [misfDirect])
 else
 begin
  f_MemStream.Seek(0, soBeginning);
  Result := aBlock.Text.Modify.InsertStream(aView, f_MemStream, cf_Text, Container);
 end;//not f_HasEOL
end;

// start class TevHyperLinkReplacer

function TevHyperLinkReplacer.ReplaceFunc(const aView : InevView;
                                          const Container : InevOp;
                                          const aBlock    : InevRange): Bool;
var
 l_HyperLink : IevHyperLink;
begin
 Result := false;
 if Assigned(f_OnHyperlinkReplace) AND
    Supports(aBlock, IevHyperLink, l_HyperLink) then
  try
   Result := f_OnHyperlinkReplace(Self, l_HyperLink);
  finally
   l_Hyperlink := nil;
  end;//try..finally
end;

// start class TevSubReplacer

constructor TevSubReplacer.Create(anOwner: TevSearchToolOwner = nil);
  {override;}
  {-}
begin
 inherited;
 f_Layer := Ord(ev_sbtSub);
end;

function TevSubReplacer.pm_GetDefaultText: AnsiString;
begin
 Result := 'Поставить метку';
end;

function TevSubReplacer.ReplaceFunc(const aView : InevView;
                                    const Container : InevOp;
                                    const aBlock    : InevRange): Bool;
  {override;}
  {-}
var
 l_Handle  : Long;
 Start     : InevBasePoint;
 Finish    : InevBasePoint;
 l_SubList : InevSubList;
begin
 Result := false;
 if Assigned(f_OnGetSubHandle) then
 begin
  l_Handle := f_OnGetSubHandle(Self, aBlock);
  if (l_Handle > 0) then
  begin
   aBlock.GetBorderPoints(Start, Finish);
   l_SubList := Start.Obj.AsPara.MainSubList;
   if (l_SubList <> nil) then
    try
     l_SubList.SubEx[l_Handle, Layer].SetTo(Start.MostInner.Obj^.AsObject);
    finally
     l_SubList := nil;
    end;//try..finally
   Result := true;
  end;//l_Handle > 0
 end;//Assigned(f_OnGetSubHandle)
end;

// start class TevStyleReplacer 

class function TevStyleReplacer.MakeForStyleID(const aStyleID : Integer;
                                               anOptions      : TevSearchOptionSet = []): IevReplacer;
  {-}
var
 l_S : TevStyleInterface;
begin
 l_S := TevStyleInterface.Create;
 try
  l_S.SelectStyledObjectType(k2_typTextPara);
  l_S.SelectStyle(aStyleID);
  Result := Make(l_S.Name, anOptions);
 finally
  FreeAndNil(l_S);
 end;//try..finally
end;

procedure TevStyleReplacer.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Style);
 inherited;
end;

function TevStyleReplacer.ReplaceFunc(const aView : InevView;
                                      const Container : InevOp;
                                      const aBlock    : InevRange): Bool;
  {override;}
  {-}
var
 Start  : InevBasePoint;
 Finish : InevBasePoint;
begin
 if (f_Style = nil) then
 begin
  if WholePara then
   Result := false
  else
  begin
   Result := aBlock.Formatting.Modify(aView).DeleteSegments(Container);
   Container.MarkModified(aBlock.AsObject.Box);
  end;
 end//f_Style = nil
 else
 begin
  Result := true;
  if WholePara then
  begin
   aBlock.GetBorderPoints(Start, Finish);
   Start.Move(aView, ev_ocParaHome, Container);
   Finish.Move(aView, ev_ocParaEnd, Container);
  end;//WholePara
  aBlock.Formatting.Modify(aView).SetAtom(aView, k2_tiStyle, f_Style.Tag.AsObject, Container);
 end;//f_Style = nil
end;

function TevStyleReplacer.pm_GetText: AnsiString;
  {override;}
  {-}
begin
 if (f_Style = nil) then Result := '' else Result := f_Style.Name;
end;

procedure TevStyleReplacer.DoSetText(const Value: AnsiString);
  {override;}
  {-}
begin
 if (Value = '') then
  l3Free(f_Style)
 else begin
  if (f_Style = nil) then
  begin
   f_Style := TevStyleInterface.Create;
   f_Style.SelectStyledObjectType(k2_typTextPara);
  end;//f_Style = nil
  f_Style.SelectStyle(Value);
 end;//Value = ''
end;

function TevStyleReplacer.pm_GetDefaultText: AnsiString;
  {override;}
  {-}
begin
 if (f_Style = nil) then Result := '' else Result := f_Style.Name;
end;

// start class TevBaseReplacer 

procedure TevBaseReplacer.Cleanup;
  {override;}
  {-}
begin
 Searcher := nil;
 l3Free(f_Replace);
 inherited;
end;

function TevBaseReplacer.Get_Searcher: IevSearcher;
  {-}
begin
 Result := Searcher;
end;

procedure TevBaseReplacer.Set_Searcher(const aValue: IevSearcher);
  {-}
begin
 Searcher := aValue;
end;

function TevBaseReplacer.pm_GetText: AnsiString;
  {override;}
begin
 if (f_Replace = nil) then
  Result := ''
 else
  Result := f_Replace.AsString;
end;

function TevBaseReplacer.Get_ReplaceCount: Integer;
begin
 Result := f_ReplaceCount;
end;

function TevBaseReplacer.NeedProgress: Boolean;
  {-}
begin
 Result := true;
end;

procedure TevBaseReplacer.DoSetText(const Value: AnsiString);
  {override;}
  {-}
begin
 if (Value = EmptyStr) then
  l3Free(f_Replace)
 else
 begin
  if (f_Replace = nil) then
   f_Replace := Tl3InterfacedString.Make(l3PCharLen(Value))
  else
   f_Replace.AsPCharLen := l3PCharLen(PAnsiChar(@Value[1]), Length(Value));
 end;//Value = EmptyStr
end;

function TevBaseReplacer.Replace(const Container : InevOp;
                                 const aBlock    : InevRange;
                                 const aConfirm  : InevConfirm): Bool;
  {-}
var
 siReplace : ShortInt;
 O         : TevSearchOptionSet;
 l_Start   : InevBasePoint;
 l_Finish  : InevBasePoint;
 l_Block   : InevRange;
begin
 aBlock.GetBorderPoints(l_Start, l_Finish);
 if (aConfirm = nil) then
 begin
  Result := false;
  if not (ev_soConfirm in Options) then
  begin
   if ReplaceFunc(aConfirm.View, Container, aBlock) then
    Inc(f_ReplaceCount);
   Result := (ev_soReplaceAll in Options);
  end;//not (ev_soConfirm in Options)
  Exit;
 end;//aConfirm = nil
 if (ev_soConfirm in Options) then
  siReplace := aConfirm.ReplaceConfirm(aBlock, f_OnReplaceConfirm)
 else
  siReplace := mrYes;
 if (siReplace = mrAll) then
 begin
  O := Options;
  Exclude(O, ev_soConfirm);
  Include(O, ev_soReplaceAll);
  Options := O;
 end;//siReplace = mrAll
 l_Block := aBlock.BottomChildBlock(aConfirm.View);
 try
  if (siReplace in [mrYes, mrOk, mrAll]) AND
     ReplaceFunc(aConfirm.View, Container, l_Block) then
   Inc(f_ReplaceCount);
 finally
  l_Block := nil;
 end;
 Result := (ev_soReplaceAll in Options) AND not(siReplace in [mrCancel, mrAbort]);
 with aConfirm do
  if DeleteFoundRgn OR (ev_soConfirm in Options) then
   Update;
end;

procedure TevBaseReplacer.DoStart;
  //virtual;
  {-}
begin
 inherited;
 f_ReplaceCount := 0;
end;

procedure TevBaseReplacer.DoFinish(aCancel: Bool; const aBlock: InevRange);
  //virtual;
  {-}
begin
 if Assigned(f_OnFinishReplace) AND (f_ReplaceCount > 0) then
  f_OnFinishReplace(Self, f_ReplaceCount);
 inherited; 
end;

class function TevBaseReplacer.Make(const aText : AnsiString;
                                    anOptions   : TevSearchOptionSet = []): IevReplacer;
  //overload;
  {-}
var
 l_Replacer : TevBaseReplacer;
begin
 l_Replacer := Create;
 try
  l_Replacer.Options := anOptions;
  l_Replacer.Text := aText;
  Result := l_Replacer;
 finally
  l3Free(l_Replacer);
 end;//try..finally
end;

// start class TevTextSearcher 

procedure TevTextSearcher.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Text);
 inherited;
end;

function TevTextSearcher.pm_GetText: AnsiString;
  {override;}
  {-}
begin
 Result := f_Text.AsString;
end;

procedure TevTextSearcher.DoSetText(const Value: AnsiString);
  {override;}
  {-}
begin
 if (Value = EmptyStr) then
  l3Free(f_Text)
 else begin
  if (f_Text = nil) then
   f_Text := Tl3String.Make(l3PCharLen(Value))
  else
   f_Text.AsPCharLen := l3PCharLen(PAnsiChar(@Value[1]), Length(Value));
 end;
end;

// start class TevRegularExpressionSearcher

constructor TevRegularExpressionSearcher.Create(aOwner: TevSearchToolOwner = nil);
begin
 inherited Create(aOwner);
 f_SrchMashine := Tl3RegularSearch.Create;
end;

class function TevRegularExpressionSearcher.SmartMake(const aText : AnsiString;
                                                      anOptions   : TevSearchOptionSet = [];
                                                      aNext       : IevSearcher = nil): IevSearcher;
  {-}
begin
 if ANSIStartsStr(ch_BWord, aText) AND ANSIEndsStr(ch_EWord, aText) then
  Result := TevStrictWordSearcher.Make(Copy(aText, 2, Length(aText)-2))
 else
 if ANSIStartsStr(ch_BWord, aText) AND ANSIEndsStr(ch_Esc + ch_Word + ch_Closure, aText) then
  Result := TevWordFromBeginningSearcher.Make(Copy(aText, 2, Length(aText)-4))
 else
  Result := Make(aText, anOptions, aNext);
end;

procedure TevRegularExpressionSearcher.Cleanup;
begin
 FreeAndNil(f_SrchMashine);
 FreeAndNil(f_PersistentStr);
 inherited;
end;

procedure TevRegularExpressionSearcher.DoSetText(const Value: AnsiString);
begin
 Inherited DoSetText(Value);
 f_SrchMashine.SearchPattern := Value;
end;

function TevRegularExpressionSearcher.DoCheckText(aPara : Tl3Variant;
                                                  aText       : Tl3CustomString;
                                                  const aSel  : TevPair;
                                                  out theSel : TevPair): Bool;
var
 l_Str: Tl3CustomString;
 REPosition: Tl3MatchPosition;
begin
 f_SrchMashine.IgnoreCase :=  not (ev_soMatchCase in Options);


 Result := (aText <> nil) and (f_SrchMashine.SearchPattern <> '');

 if Result then
 begin
  if (aText.CodePage = cp_Unicode) then
  begin
   // Регекспы не умеют работать с юникодом, поэтому надо сконвертировать строку в ANSI
   l_Str := aText.Clone;
   l_Str.CodePage := cp_ANSI;
   // надо задержать сконвертированную строку в памяти
   // иначе найденные теги в регекспе станут невалидны
   FreeAndNil(f_PersistentStr);
   f_PersistentStr := l_Str.Use; 
  end
  else
   l_Str := aText.Use;
  try
   Result := f_SrchMashine.SearchInString(l_Str.St, aSel.rStart, Min(l_Str.Len, aSel.rFinish),
       REPosition, l_Str.CodePage);
  finally
   FreeAndNil(l_Str);
  end;
 end;

 if Result then
  with REPosition do
   begin
    theSel.rStart := StartPos;
    if (Text <> '') and (Text[System.Length(Text)] = c_EOP) then
     theSel.rFinish := High(Longint)
    else
     theSel.rFinish := EndPos;
   end;
end;

function TevRegularExpressionSearcher.GetTagCount: Integer;
begin
 Result := f_SrchMashine.TagParts.Count;
end;

function TevRegularExpressionSearcher.GetTag(Idx: Integer): AnsiString;
begin
 if (Idx >= f_SrchMashine.TagParts.Count) or (f_SrchMashine.TagParts.Items[Idx] = nil) then
  Result := ''
 else
  Result := Tl3String(f_SrchMashine.TagParts.Items[Idx]).AsString;
end;

// start class TevCustomHyperlinkSearcher

constructor TevCustomHyperlinkSearcher.Create(anOwner: TevSearchToolOwner = nil);
  //override;
  {-}
begin
 inherited;
 Layer := Ord(ev_slHyperlinks);
 Handle := ev_saHyperLink;
end;

class function TevCustomHyperlinkSearcher.Make(anOptions : TevSearchOptionSet = [];
                                               aNext     : IevSearcher = nil): IevSearcher;
  //reintroduce;
  {-}
begin
 Result := inherited Make(ev_saHyperLink, Ord(ev_slHyperlinks), ev_spSegments, anOptions, aNext);
end;

procedure TevCustomHyperlinkSearcher.Cleanup;
  //override;
  {-}
begin
 FreeAndNil(f_CurrentSeg);
 inherited;
end;

function TevCustomHyperlinkSearcher.pm_GetText: AnsiString;
  //override;
  {-}
begin
 Result := f_Text;
end;

procedure TevCustomHyperlinkSearcher.DoSetText(const Value: AnsiString);
  //override;
  {-}
begin
 f_Text := Value;
end;

function TevCustomHyperlinkSearcher.pm_GetNotFoundMessage: AnsiString;
  //override;
  {-}
begin
 Result := 'Ссылка не найдена';
end;

function TevCustomHyperlinkSearcher.pm_GetDefaultText: AnsiString;
  //override;
  {-}
begin
 Result := '';
end;

function TevCustomHyperlinkSearcher.DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
  //virtual;
  {-}
begin
 if ev_soIngoreExternalLink in Options then
 begin
  Result := aHLink.AddressList.Count = 1;
  if Result then
   Result := (aHLink.AddressList[0].{$IfDef XE4}rTafwAddress.{$EndIf}TypeID = CI_TOPIC) and
             (aHLink.AddressList[0].{$IfDef XE4}rTafwAddress.{$EndIf}DocID = 0);
 end // if ev_soIngoreExternalLink in Options then
 else
  Result := true;
end;

function TevCustomHyperlinkSearcher.DoCheckText(aPara : Tl3Variant;
                                                aText       : Tl3CustomString;
                                                const aSel  : TevPair;
                                                out theSel : TevPair): Bool;
  //override;
  {-}
var
 l_Sel : TevPair;  
begin
 l_Sel := aSel;
 repeat
  Result := inherited DoCheckText(aPara, aText, l_Sel, theSel);
  if Result and (ev_soCheckOwnerCollapsed in Options) then
  begin
   Result := not aPara.Owner.BoolA[k2_tiCollapsed]; // http://mdp.garant.ru/pages/viewpage.action?pageId=602505046
   if Result then
    Result := not evHeaderTextPara(aPara);
  end; // if Result and (ev_soCheckOwnerCollapsed in Options) then
  if Result AND (f_CurrentSeg <> nil) then
  begin
   try
    Result := DoHyperlinkSearch(TevHyperlink.Make(aPara.AsObject, f_CurrentSeg));
   except
    Result := false;
   end;//try..except
   if Result then
    break
   else begin
    l_Sel.rStart := theSel.rFinish;
    if (l_Sel.rStart >= l_Sel.rFinish) then break;
   end;
  end//Result..
  else
   break;
 until False;
end;

// start class TevHyperlinkSearcher

function TevHyperlinkSearcher.DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
  //override;
  {-}
var
 lCurAddr : TevAddress;
 l_Index  : Integer;
begin
 if Assigned(f_OnHyperlinkSearch) then
  Result := f_OnHyperlinkSearch(Self, aHLink)
 else
 begin
  Result := false;
  if (aHLink.AddressList.Count = 0) then Exit;
  for l_Index := 0 to Pred(aHLink.AddressList.Count) do
  begin
   lCurAddr := aHLink.AddressList[l_Index];
   with SearchHyperAddress{$IfDef XE4}.rTafwAddress{$EndIf} do
    if ((lCurAddr.{$IfDef XE4}rTafwAddress.{$EndIf}DocID = DocID) or (DocID < 0)) and
       ((lCurAddr.{$IfDef XE4}rTafwAddress.{$EndIf}SubID = SubID) or (SubID < 0)) then
    begin
     Result := true;
     Break;
    end;//(lCurAddr.DocID = DocID) or (DocID < 0)
  end;//for I
 end;//Assigned(f_OnHyperlinkSearch)
end;

// start class TevHyperlinkIDSearcher

function TevHyperlinkIDSearcher.DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
  //override;
  {-}
begin
 Result := (aHLink.ID = ID);
end;

// start class TevRegExpMultipartSearcher

procedure TevRegExpMultipartSearcher.DoSetText(const aValue: AnsiString);
var
 lRegExp: AnsiString;
 X: Integer;
 STmp : AnsiString;
 lIsFirstPart: Boolean;
begin
 FSearcherList.Clear;
 // разбиваем по параграфам
 STmp := aValue;
 lIsFirstPart := True;
 repeat
  X := Pos(c_EOP, STmp);
  if X > 0 then
  begin
   lRegExp := Copy(STmp, 1, X);
   if (lRegExp <> c_Arrow + c_EOP) and (lRegExp <> c_EOP) then
    FSearcherList.Add(TevRegularExpressionSearcher.Make(lRegExp, Self.Options))
   else
    if lIsFirstPart then
     FSearcherList.Add(TevSpecialParagraphSearcher.Make)
    else
     FSearcherList.Add(TevEmptyTextSearcher.Make);
   Delete(STmp, 1, X);
   if STmp <> '' then
    STmp := c_Arrow + STmp;
  end
  else
   if STmp <> '' then
    FSearcherList.Add(TevRegularExpressionSearcher.Make(STmp, Self.Options));
  lIsFirstPart := False;
 until X = 0;
 inherited;
end;

function TevRegExpMultipartSearcher.GetTag(Idx: Integer): AnsiString;
begin
 Result := Tl3String(FTags.Items[Idx]).AsString;
end;

function TevRegExpMultipartSearcher.GetTagCount: Integer;
begin
 Result := FTags.Count;
end;

constructor TevRegExpMultipartSearcher.Create(anOwner: TevSearchToolOwner = nil);
begin
 inherited Create(anOwner);
 FTags := Tl3StringList.Make;
end;

procedure TevRegExpMultipartSearcher.Cleanup;
begin
 l3Free(FTags);
 inherited;
end;

procedure TevRegExpMultipartSearcher.CollectTags;
var
 lTSearcher: IevTaggedSearcher;
 I, J, N: Integer;
begin
 FTags.Clear;
 for I := 0 to FSearcherList.Count-1 do
 begin
  if Supports(FSearcherList[I], IevTaggedSearcher, lTSearcher) then
  try
   N := lTSearcher.GetTagCount;
   for J := 0 to N-1 do
    FTags.Add(lTSearcher.GetTag(J));
  finally
   lTSearcher := nil;
  end;
 end;
end;

function TevRegExpMultipartSearcher.DoCheck(const aView : InevView;
                                            const aBlock    : InevRange;
                                            out theStart    : InevBasePoint;
                                            out theFinish   : InevBasePoint;
                                            const PrevBlock : InevRange): Bool;
begin
 Result := inherited DoCheck(aView, aBlock, theStart, theFinish, nil);
 if Result then
  CollectTags;
end;

// start class TevMorphologySearcher

procedure TevMorphologySearcher.DoSetText(const aValue: AnsiString);
  {-}
  //override;
 const
  ccExclamationMark = '!';

 function DoWord(const aStr : Tl3PCharLen;
                 IsLast     : Bool): Bool;
 var
  lSearcher1 : IevSearcher;
  lSearcher2 : IevSearcher;

 begin//DoWord
  Result := true;
  if FSearcherList.Empty then
   lSearcher1 := nil
  else
   lSearcher1 := TevContinuousTextSearchController.Make('');
  if (aStr.S[Pred(aStr.SLen)] = ccExclamationMark) then
   lSearcher2 := TevBMTextSearcher.Make(l3PCharLen2String(
                                    l3PCharLen(aStr.S,
                                               Pred(aStr.SLen),
                                               aStr.SCodePage)),
                                   Options, lSearcher1)
  else
   lSearcher2 := TevNormalWordSearcher.Make(l3PCharLen2String(aStr), Options, lSearcher1);

  FSearcherList.Add(lSearcher2);
 end;//DoWord

begin
 inherited;
 FSearcherList.Clear;
 l3ParseWordsF(l3PCharLen(aValue), l3L2WA(@DoWord), [ccExclamationMark]);
end;

// start class TevBaseMultipartSearcher

constructor TevBaseMultipartSearcher.Create(anOwner: TevSearchToolOwner = nil);
begin
 inherited Create(anOwner);
 FSearcherList := TevSearcherList.Make;
 FFoundSearchersList := TevSearcherList.Make;
 FMultipass := False;
 FMultiblock := False;
end;

procedure TevBaseMultipartSearcher.Cleanup;
begin
 l3Free(FSearcherList);
 l3Free(FFoundSearchersList);
 inherited;
end;

procedure TevBaseMultipartSearcher.DoStart;
var
 I: Integer;
begin
 inherited;
 if FMultiblock then
 begin
  FCurSearcher := 0;
  FFoundStart := nil;
  FFoundFinish := nil;
  FFoundSearchersList.Clear;
 end;
 for I := 0 to Pred(FSearcherList.Count) do
  FSearcherList.Items[I].Start;
end;

function TevBaseMultipartSearcher.DoCheck(const aView : InevView;
                                          const aBlock    : InevRange;
                                          out theStart    : InevBasePoint;
                                          out theFinish   : InevBasePoint;
                                          const PrevBlock : InevRange): Bool;
var
 lMBNewFit       : Boolean;
 l_Searcher      : IevSearcher;
 lFound          : Boolean;
 lStart, lFinish : InevBasePoint;
 lTempStart,
 lTempFinish     : InevBasePoint;
 l_Block         : InevRange;
 l_Para          : InevPara;
begin
 Result := False;
 if FMultipass then
  FCurSearcher := 0;

 if FCurSearcher = 0{not FMultiblock} then
 begin
  FFoundStart := nil;
  FFoundFinish := nil;
  f_RestartPoint := nil;
 end;//not FMultiblock

 l_Block := aBlock;
 while true do
 begin
  lStart := nil;
  lFinish := nil;
  try
   if (FSearcherList.Count = 0) or (FCurSearcher >= FSearcherList.Count) then
    Exit;
   lMBNewFit := false;
   // - чтобы компилятор не выебывался 
   l_Searcher := FSearcherList.Items[FCurSearcher];
   try
    lFound := l_Searcher.Check(aView, l_Block, lStart, lFinish, nil);
    lMBNewFit := FMultiblock and (FFoundSearchersList.IndexOf(l_Searcher) = -1);
    if lFound and lMBNewFit then
     FFoundSearchersList.Add(l_Searcher); // если ищем через блоки, то запоминаем найденный серчер
   finally
    l_Searcher := nil;
   end;
   if lFound and Assigned(FFoundStart) and (not FMultiblock) then // проверяем, относится ли найденное к тому же родителю
    lFound := FFoundStart.MostInner.Obj.AsObject.Owner.IsSame(lFinish.MostInner.Obj.AsObject.Owner);
   if lFound then
   begin
    lStart := lStart.PointToParentByLevel(MaxInt);
    // - здесь может неправильно работать, когда ищем не с корневого документа
    lFinish := lFinish.PointToParentByLevel(MaxInt);
    if FMultipass then // если ищем многократно (т.е. серчеры могут быть найдены в любой последовательности)
    begin
     if (not FMultiblock) or lMBNewFit then
     begin
      if (FFoundStart = nil) or (lStart.Compare(FFoundStart) < 0) then
       FFoundStart := lStart;
      if (FFoundFinish = nil) or (lFinish.Compare(FFoundFinish) > 0) then
       FFoundFinish := lFinish;
     end; {if..}
    end
    else // FMultipass
    begin
     // если ищем последовательно
     if FCurSearcher = 0 then
     begin
      FFoundStart := lStart;
      f_RestartPoint := lFinish.ClonePoint(aView); // Точка рестарта - за концом поиска первого сёрчера
      f_RestartPoint.MostInner.Move(aView, ev_ocCharRight);
     end;
     FFoundFinish := lFinish;
    end;
    Inc(FCurSearcher);
    if (not FMultiblock and (FCurSearcher = FSearcherList.Count)) or
       (FMultiblock and (FFoundSearchersList.Count = FSearcherList.Count))  then
       // ура! мы нашли все что надо было
    begin
     Result := True;
     theStart := FFoundStart;
     theFinish := FFoundFinish;
     FFoundStart := nil;
     FFoundFinish := nil;
     FCurSearcher := 0;
     f_RestartPoint := nil;
    end
    else // if FCurSearcher = FSearcherList.Count
    begin
     if FMultipass then
     begin
      if FCurSearcher < FSearcherList.Count then
       Continue; // просто продолжаем поиск, пока не отработают все серчеры
     end
     else // FMultipass
      if not lFinish.MostInner.AtEnd(aView) then // если уткнулись в конец блока, то дальше продолжать не надо
      begin
       // cдвигаем область поиска
       l_Para := l_Block.Obj.AsPara;
       try
        l_Block.GetBorderPoints(lTempStart, lTempFinish);
        l_Block := l_Para.Range(lFinish.MostInner, lTempFinish);
       finally
        l_Para := nil;
       end;//try..finally
       Continue;
      end; {if..}
    end; // if FCurSearcher = FSearcherList.Count
   end
   else // if lFound
   begin
    if FMultiblock then
    begin
     Inc(FCurSearcher);
     if FCurSearcher < FSearcherList.Count then
      Continue;
    end
    else
    begin
     // Если у нас не "черезблочный" режим, то поиск неудачен
     FCurSearcher := 0;
     FFoundStart := nil;
     FFoundFinish := nil;
     if f_RestartPoint <> nil then
      raise EevSearcherRestart.Create(''); // перезапускаем поиск (с позиции за успешным поиском первого сёрчера)
    end;
   end;
  finally
   lStart := nil;
   lFinish := nil;
  end;
  Break;
 end; {while...do}
end;

procedure TevBaseMultipartSearcher.DoFinish(aCancel: Bool; const aBlock: InevRange);
var
 I: Integer;
begin
 FCurSearcher := 0;
 for I := 0 to Pred(FSearcherList.Count) do
  FSearcherList.Items[I].Finish(aCancel, aBlock);
 inherited;
end;

class function TevBaseMultipartSearcher.Make(const aText : AnsiString;
                                             anOptions   : TevSearchOptionSet = [];
                                             const aNext : IevSearcher = nil;
                                             aMultipass  : Boolean = False): IevSearcher;
  //overload;
  {-}
var
 l_Searcher : TevBaseMultipartSearcher;
begin
 l_Searcher := Create;
 try
  l_Searcher.Options := anOptions;
  l_Searcher.Text := aText;
  l_Searcher.NextSearcher := aNext;
  l_Searcher.Multipass := aMultipass;
  Result := l_Searcher;
 finally
  l3Free(l_Searcher);
 end;//try..finally
end;

function TevBaseMultipartSearcher.Get_RestartPos: InevBasePoint;
begin
 Result := f_RestartPoint;
end;

procedure TevBaseMultipartSearcher.pm_SetOptions(Value: TevSearchOptionSet);
var
 I: Integer;
begin
 if Assigned(FSearcherList) then
  for I := 0 to Pred(FSearcherList.Count) do
   FSearcherList.Items[I].Options := Value;
 inherited;
end;

// start class TevEmptyTextSearcher

function TevEmptyTextSearcher.DoCheckText(aPara : Tl3Variant;
                                          aText       : Tl3CustomString;
                                          const aSel  : TevPair;
                                          out theSel  : TevPair): Bool;
begin
 Result := aText.Empty and (aSel.rStart = 0);
 if Result then
 begin
  theSel.rStart := 0;
  theSel.rFinish := ev_cpAtEnd;
 end;
end;

// start class TevAnyParagraphSearcher

function TevAnyParagraphSearcher.DoCheckText(aPara : Tl3Variant;
                                             aText       : Tl3CustomString;
                                             const aSel  : TevPair;
                                             out theSel  : TevPair): Bool;
begin
 Result := (aSel.rStart <> ev_cpAtEnd);
 if Result then
 begin
  if aText.Empty then
  begin
   theSel.rStart := 0;
   theSel.rFinish := ev_cpAtEnd;
  end
  else
  if (aSel.rStart = aSel.rFinish) then
  begin
   Result := false;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=219123904&focusedCommentId=220202125#comment-220202125
   theSel.rStart := ev_cpAtEnd;
   theSel.rFinish := ev_cpAtEnd;
  end//aSel.rStart = aSel.rFinish
  else
  begin
   theSel.rStart := aSel.rStart;
   theSel.rFinish := aSel.rFinish;
  end;//aSel.rStart = aSel.rFinish
 end;//Result
end;

// start class TevSpecialParagraphSearcher

function TevSpecialParagraphSearcher.DoCheckText(aPara : Tl3Variant;
                                                 aText       : Tl3CustomString;
                                                 const aSel  : TevPair;
                                                 out theSel  : TevPair): Bool;
begin
 Result := aSel.rStart <> ev_cpAtEnd;
 if Result then
 begin
  if aText.Empty then
   theSel.rStart := 0
  else
   theSel.rStart := aText.Len;
  theSel.rFinish := ev_cpAtEnd;
 end;
end;

// start class TevRegExpReplacer

function TevRegExpReplacer.ReplaceFunc(const aView : InevView;
                                       const Container : InevOp;
                                       const aBlock    : InevRange): Bool;
var
 TmpS: AnsiString;
 TagN: Integer;
 Par: Tl3Parser;
 RepStr: AnsiString;
 lTagSearcher: IevTaggedSearcher;
 lIsTagged : Boolean;
 l_KW : Tl3KeyWords;
begin
 lIsTagged := False;
 if Supports(f_Searcher, IevTaggedSearcher, lTagSearcher) then
 try
  Par := Tl3Parser.Make(f_Replace, [l3_poCheckKeyWords], [#0..#255]-['{','}'], []);
  try
   RepStr := '';
   l_KW := Tl3KeyWords.Create;
   try
    l_KW.AddKeyWords([ l3KW('\{',1), l3KW('\}',2) ]);
    Par.KeyWords := l_KW;
   finally
    FreeAndNil(l_KW);
   end;//try..finally
   Par.NextTokenSp;
   while Par.TokenType <> l3_ttEOF do
   begin
    case Par.TokenType of
     l3_ttSymbol: RepStr := RepStr + Par.TokenString;
     l3_ttSingleChar:
      begin
       if Par.TokenChar = '{' then
       begin
        Par.NextTokenSp;
        if Par.TokenType <> l3_ttSymbol then
         raise EevRegExpReplacerError.Create(SErrorInRegExpReplaceString);
        try
         TagN := StrToInt(Par.TokenString);
        except
         raise EevRegExpReplacerError.Create(SErrorInRegExpTagString);
        end;
        Par.NextTokenSp;
        if (Par.TokenType <> l3_ttSingleChar) or (Par.TokenChar <> '}') then
         raise EevRegExpReplacerError.Create(SErrorInRegExpUnclosedTag);
        if (TagN < 1) or (TagN > lTagSearcher.GetTagCount) then
         raise EevRegExpReplacerError.Create(SErrorInRegExpInvalidTagNumber);
        RepStr := RepStr + lTagSearcher.GetTag(TagN-1);
        lIsTagged := True;
       end
       else
        raise EevRegExpReplacerError.Create(SErrorInRegExpReplaceString);
      end;
     l3_ttKeyWord:
      raise EevSearchFailed.Create('Not Supported Yet...');
    end;
    Par.NextTokenSp;
   end;
  finally
   l3Free(Par);
  end;
 finally
  lTagSearcher := nil;
 end;
 if lIsTagged then
 begin
  TmpS := f_Replace.AsString;
  try
   Text := RepStr;
   Result := inherited ReplaceFunc(aView, Container, aBlock);
  finally
   Text := TmpS;
  end;
 end
 else
  Result := inherited ReplaceFunc(aView, Container, aBlock);
end;

// start class TevFakeSearcher

class function TevFakeSearcher.Make: IevSearcher;
  //reintroduce;
  {-}
begin
 Result := inherited Make('');
end;

function TevContinuousTextSearchController.DoCheckTextEx(aPara    : Tl3Variant;
                                                         aText          : Tl3CustomString;
                                                         const aSel     : TevPair;
                                                         const aPrevSel : TevPair;
                                                         out theSel     : TevPair): Bool;
begin

  Result := not l3CharSetPresent(aText.St + aPrevSel.rStart,
                                 aSel.rStart - aPrevSel.rStart,
                                 cc_ANSIRussian + cc_ANSIEnglish);
 if Result then
  theSel := aSel;
end;

// start class TevInvertSearcher

constructor TevInvertSearcher.Create(const aSearcher : IevSearcher);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Searcher := aSearcher;
end;

class function TevInvertSearcher.Make(const aSearcher : IevSearcher;
                                      aNext           : IevSearcher = nil): IevSearcher;
  //reintroduce;
  {-}
var
 l_IS : TevInvertSearcher;  
begin
 l_IS := Create(aSearcher);
 try
  l_IS.NextSearcher := aNext;
  Result := l_IS;
 finally
  l3Free(l_IS);
 end;//try..finally
end;

procedure TevInvertSearcher.Cleanup;
  //override;
  {-}
begin
 f_Searcher := nil;
 inherited;
end;

procedure TevInvertSearcher.DoStart;
  //override;
  {-}
begin
 inherited;
 if (f_Searcher <> nil) then
  f_Searcher.Start;
end;

procedure TevInvertSearcher.DoFinish(aCancel: Bool; const aBlock: InevRange);
  //override;
  {-}
begin
 if (f_Searcher <> nil) then
  f_Searcher.Finish(aCancel, aBlock);
 inherited;
end;

function TevInvertSearcher.DoCheck(const aView : InevView;
                                   const aBlock    : InevRange;
                                   out theStart    : InevBasePoint;
                                   out theFinish   : InevBasePoint;
                                   const PrevBlock : InevRange): Bool;
  //override;
  {* - определяет критерий отбора параграфа (его фрагмента). }
var
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;
 l_S, l_F : InevBasePoint;
begin
 theStart := nil;
 theFinish := nil;
 if (f_Searcher = nil) OR
    not f_Searcher.Check(aView, aBlock, theStart, theFinish, PrevBlock) then
 begin
  Result := True;
  if (aBlock = nil) then
  begin
   theStart := nil;
   theFinish := nil;
  end//aBlock = nil
  else
  begin
   aBlock.GetBorderPoints(l_Start, l_Finish);
   l_S := aBlock.Obj.MakePoint;
   try
    if (l_Start = nil) then
     l_S.Move(aView, ev_ocTopLeft)
    else
     l_S.AssignPoint(aView, l_Start);
    theStart := l_S;
   finally
    l_S := nil;
   end;//try..finally
   l_F := aBlock.Obj.MakePoint;
   try
    if (l_Finish = nil) then
     l_F.Move(aView, ev_ocBottomRight)
    else
     l_F.AssignPoint(aView, l_Finish);
    theFinish := l_F;
   finally
    l_F := nil;
   end;//try..finally
  end;//aBlock = nil
 end
 else
 begin
  Result := False;
  theStart := nil;
  theFinish := nil;
 end;//f_Searcher = nil
end;

// start class TevORSearcher

constructor TevORSearcher.Create(const aSearchers : array of IevSearcher);
  //reintroduce;
  {-}
var
 l_Index : Integer;
begin
 inherited Create;
 for l_Index := Low(aSearchers) to High(aSearchers) do
  Add(aSearchers[l_Index]);
end;

class function TevORSearcher.Make(const aSearchers : array of IevSearcher;
                                  aNext            : IevSearcher = nil): IevSearcher;
  //reintroduce;
  {-}
var
 l_IS : TevORSearcher;  
begin
 l_IS := Create(aSearchers);
 try
  l_IS.NextSearcher := aNext;
  Result := l_IS;
 finally
  l3Free(l_IS);
 end;//try..finally
end;

procedure TevORSearcher.Cleanup;
  //override;
  {-}
begin
 f_Searchers := nil;
 inherited;
end;

procedure TevORSearcher.DoStart;
  //override;
  {-}
var
 l_Index : Integer;
begin
 inherited;
 for l_Index := Low(f_Searchers) to High(f_Searchers) do
  if (f_Searchers[l_Index] <> nil) then
   f_Searchers[l_Index].Start;
end;

procedure TevORSearcher.DoFinish(aCancel: Bool; const aBlock: InevRange);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := Low(f_Searchers) to High(f_Searchers) do
  if (f_Searchers[l_Index] <> nil) then
   f_Searchers[l_Index].Finish(aCancel, aBlock);
 inherited;
end;

function TevORSearcher.DoCheck(const aView : InevView;
                               const aBlock    : InevRange;
                               out theStart    : InevBasePoint;
                               out theFinish   : InevBasePoint;
                               const PrevBlock : InevRange): Bool;
  //override;
  {* - определяет критерий отбора параграфа (его фрагмента). }
var
 l_Index : Integer;
begin
 Result := false;
 for l_Index := Low(f_Searchers) to High(f_Searchers) do
 begin
  Result := ((f_Searchers[l_Index] <> nil) AND
             f_Searchers[l_Index].Check(aView, aBlock, theStart, theFinish, PrevBlock));
  if Result then
   Break;
 end;//for l_Index
end;

procedure TevORSearcher.Add(const aSearcher: IevSearcher);
  {-}
var
 l_L : Integer;
begin
 l_L := Length(f_Searchers);
 SetLength(f_Searchers, Succ(l_L));
 f_Searchers[l_L] := aSearcher;
end;

// start class TevOneLevelSearcher

constructor TevOneLevelSearcher.Create(aParent : Tl3Variant);
  //reintroduce;
  {-}
begin
 inherited Create;
 aParent.Box.SetRef(f_Parent);
end;

class function TevOneLevelSearcher.Make(aParent : Tl3Variant;
                                        aNext         : IevSearcher = nil): IevSearcher;
  //reintroduce;
  {-}
var
 l_S : TevOneLevelSearcher;
begin
 l_S := Create(aParent);
 try
  l_S.NextSearcher := aNext;
  Result := l_S;
 finally
  l3Free(l_S);
 end;//try..finally
end;

procedure TevOneLevelSearcher.Cleanup;
  //override;
  {-}
begin
 FreeAndNil(f_Parent);
 inherited;
end;

function TevOneLevelSearcher.DoCheck(const aView : InevView;
                                     const aTag        : InevObject;
                                     const aStart      : InevBasePoint;
                                     const aFinish     : InevBasePoint;
                                     const aStartPrev  : InevBasePoint;
                                     const aFinishPrev : InevBasePoint;
                                     out theSel        : TevPair): Bool;
begin
 if (f_Parent <> nil) then
  if not f_Parent.IsSame(aTag.AsObject.Owner) then
   raise EevSearchFailed.Create('Встретился вложенный блок');
 Result := true;
 theSel.rStart := 0;
 theSel.rFinish := ev_cpAtEnd;
end;

// start class TevBlockCollector

procedure TevBlockCollector.Cleanup;
  //override;
  {-}
begin
 f_Block := nil;
 inherited;
end;

function TevBlockCollector.ReplaceFunc(const aView : InevView;
                                       const Container : InevOp;
                                       const aBlock    : InevRange): Boolean;
  //override;
  {-}
begin
 f_Block := aBlock.Data;
 Result := true;
end;

// start class TevStylesSearcher

class function TevStylesSearcher.Make(const aStyles : array of Long;
                                      aLayer        : Long = l3NilLong;
                                      aPlace        : TevSearchPlace = ev_spAll;
                                      anOptions     : TevSearchOptionSet = [];
                                      aNext         : IevSearcher = nil): IevSearcher;
  //reintroduce;
  {-}
var
 l_S     : TevStylesSearcher;
 l_Index : Integer;
begin
 l_S := Create([]);
 try
  l_S.Options := anOptions;
  l_S.NextSearcher := aNext;
  for l_Index := Low(aStyles) to High(aStyles) do
   l_S.Add(TevStyleSearcher.Make(aStyles[l_Index], aLayer, aPlace, anOptions));
  Result := l_S;
 finally
  l3Free(l_S);
 end;//try..finally
end;

// start class TevParaPlaceSearcer

class function TevParaPlaceSearcer.Make(aPlace      : TevParaPlace;
                                        const aNext : IevSearcher = nil): IevSearcher;
  //reintroduce;
  {-}
var
 l_S : TevParaPlaceSearcer;
begin
 l_S := Create;
 try
  l_S.NextSearcher := aNext;
  l_S.f_Place := aPlace;
  Result := l_S;
 finally
  l3Free(l_S);
 end;//try..finally
end;

function TevParaPlaceSearcer.DoCheckText(aPara : Tl3Variant;
                                         aText       : Tl3CustomString;
                                         const aSel  : TevPair;
                                         out theSel : TevPair): Bool;
  //override;
  {-}
begin
 Result := true;
 theSel := aSel;
 Case f_Place of
  ev_ppStart :
   if (aSel.rStart > 0) then
    Result := false;
  ev_ppEnd :
   if (aSel.rFinish <> ev_cpAtEnd) AND (aSel.rFinish < aText.Len) then
    Result := false;
  ev_ppWhole :
   if (aSel.rStart > 0) OR
      ((aSel.rFinish <> ev_cpAtEnd) AND (aSel.rFinish < aText.Len)) then
    Result := false;
  ev_ppInner :
   if (aSel.rStart = 0) OR
      ((aSel.rFinish = ev_cpAtEnd) OR (aSel.rFinish >= aText.Len)) then
    Result := false;
  else
   Result := false;
 end;//Case f_Place
end;

// start class TevParaByIDSearcher

constructor TevParaByIDSearcher.Create(anID           : Integer;
                                       aAtEnd         : Boolean = true;
                                       anIgnoreHidden : Boolean = false);
  //reintroduce;
  {-}
begin
 inherited Create;
 ID := anID;
 f_AtEnd := aAtEnd;
 IgnoreHidden := anIgnoreHidden;
end;

class function TevParaByIDSearcher.Make(anID           : Integer;
                                        aAtEnd         : Boolean = true;
                                        anIgnoreHidden : Boolean = false): IevSearcher;
  {-}
var
 l_Searcher : TevParaByIDSearcher;
begin
 l_Searcher := Create(anID, aAtEnd, anIgnoreHidden);
 try
  Result := l_Searcher;
 finally
  l3Free(l_Searcher);
 end;//try..finally
end;

function TevParaByIDSearcher.DoCheckText(Sender : Tl3Variant;
                                         S            : Tl3CustomString;
                                         const aSel   : TevPair;
                                         out theSel   : TevPair): Bool;
  //override;
  {* - определяет критерий отбора параграфа (его фрагмента). }
begin
 if (Sender.IntA[k2_tiHandle] = ID) then
 begin
  Result := true;
  theSel.rStart := aSel.rStart;
  if f_AtEnd then
   theSel.rFinish := aSel.rFinish
  else
   theSel.rFinish := aSel.rStart;
 end
 else
  Result := false;
end;
{$EndIf evUseVisibleCursors}

end.

