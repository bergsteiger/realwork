unit ddHTML_r;

{ Попытка создать читалку HMTL }
{ $Id: ddHTML_r.pas,v 1.175 2016/03/21 14:04:34 dinishev Exp $ }

// $Log: ddHTML_r.pas,v $
// Revision 1.175  2016/03/21 14:04:34  dinishev
// Не вызываем BeforeCloseParagraph, если параграф не будет сохраняться.
//
// Revision 1.174  2016/03/21 13:50:58  dinishev
// Cleanup
//
// Revision 1.173  2016/03/15 10:27:57  dinishev
// {Requestlink:619725311}
//
// Revision 1.172  2016/03/14 11:06:07  dinishev
// {Requestlink:619724818}. Оказывается могут быть вложенные <P>.
//
// Revision 1.171  2016/03/11 07:57:33  dinishev
// Лишнее выравнивание в таблицах.
//
// Revision 1.170  2016/03/02 12:47:10  dinishev
// {Requestlink:618678791}
//
// Revision 1.169  2016/02/20 07:08:29  dinishev
// {Requestlink:618269589}
//
// Revision 1.168  2016/02/16 09:24:19  dinishev
// {Requestlink:617777252}
//
// Revision 1.167  2016/02/12 11:42:59  dinishev
// {Requestlink:617316346}
//
// Revision 1.166  2016/02/12 08:59:55  fireton
// - форматирование
//
// Revision 1.165  2016/02/12 06:36:24  dinishev
// {Requestlink:617312775}
//
// Revision 1.164  2016/02/12 05:22:53  dinishev
// {Requestlink:617312775}
//
// Revision 1.163  2016/02/11 14:25:55  dinishev
// {Requestlink:617312775}
//
// Revision 1.162  2016/02/11 12:13:07  dinishev
// {Requestlink:617312775}
//
// Revision 1.161  2016/01/29 06:32:17  dinishev
// Bug fix: подразнес чтение UTF-8 + AV при чтении HTML.
//
// Revision 1.160  2016/01/28 07:01:04  dinishev
// Более корректное вырезание &amp;
//
// Revision 1.159  2016/01/28 06:21:29  dinishev
// Вырезаем &amp; из URL. Пока наколенное решение.
//
// Revision 1.158  2016/01/27 15:25:07  dinishev
// {Requestlink:616562811}
//
// Revision 1.157  2016/01/27 13:47:10  dinishev
// Разборки с отъехавшими HTML-тестами после правок.
//
// Revision 1.156  2016/01/27 08:13:42  dinishev
// Cleanup
//
// Revision 1.155  2016/01/26 15:01:22  dinishev
// Bug fix: падали с Assert'ом.
//
// Revision 1.154  2016/01/25 14:23:00  dinishev
// {Requestlink:616227557}
//
// Revision 1.153  2016/01/21 05:50:44  dinishev
// {Requestlink:615706665}. Рамки из стилей.
//
// Revision 1.152  2016/01/19 10:36:29  dinishev
// {Requestlink:615706665}. Не поддерживалось больше одного уровня вложенности таблиц.
//
// Revision 1.151  2016/01/19 08:48:54  dinishev
// Cleanup
//
// Revision 1.150  2015/12/03 08:54:23  dinishev
// {Requestlink:609139066}
//
// Revision 1.149  2015/10/14 08:44:02  dinishev
// Доточил для DailyTest'ов HTMLReader.
//
// Revision 1.148  2015/05/08 12:12:17  dinishev
// {Requestlink:598615356}. Поддержка чтения картинок с формулами.
//
// Revision 1.147  2015/03/25 10:54:03  dinishev
// {Requestlink:592251812}
//
// Revision 1.146  2015/02/26 07:44:54  dinishev
// Правки по результатам работы тестов.
//
// Revision 1.145  2015/02/25 14:10:53  dinishev
// {Requestlink:589860215}
//
// Revision 1.144  2015/02/10 13:21:10  dinishev
// {Requestlink:588037744}
//
// Revision 1.143  2015/02/03 14:10:36  dinishev
// {Requestlink:522781827}. http://mdp.garant.ru/pages/viewpage.action?pageId=522781827&focusedCommentId=587164438#comment-587164438
//
// Revision 1.142  2015/01/29 12:35:01  dinishev
// {Requestlink:522781517}
//
// Revision 1.141  2014/12/29 11:16:20  dinishev
// {Requestlink:585940757}
//
// Revision 1.140  2014/06/20 12:07:52  dinishev
// {Requestlink:543433648}
//
// Revision 1.139  2014/06/19 13:30:53  dinishev
// {Requestlink:541899346}
//
// Revision 1.138  2014/05/26 10:45:40  dinishev
// {Requestlink:537954167}
//
// Revision 1.137  2014/04/23 11:25:20  dinishev
// {Requestlink:530839239}
//
// Revision 1.136  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.135  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.134  2013/10/21 08:33:36  dinishev
// {Requestlink:494524369}
//
// Revision 1.133  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.132  2013/10/15 07:54:54  dinishev
// {Requestlink:482741433}. Финальные аккорды.
//
// Revision 1.131  2013/10/14 12:29:05  dinishev
// {Requestlink:485431108}
//
// Revision 1.130  2013/09/27 12:25:29  dinishev
// Дублирующие поля, приводящие к AV при чтении.
//
// Revision 1.129  2013/09/27 12:03:26  dinishev
// {Requestlink:482741433}. Дотачиваю получение HREF.
//
// Revision 1.128  2013/09/26 10:04:01  dinishev
// {Requestlink:482741433}. Выкинул проверку на неизвестное свойство ячейки frame.
//
// Revision 1.127  2013/09/26 07:53:38  dinishev
// {Requestlink:482741433}. Вычистил проверку неиспользуемых тегов.
//
// Revision 1.126  2013/09/25 13:29:58  dinishev
// {Requestlink:482741433}
//
// Revision 1.124  2013/09/24 13:16:01  dinishev
// {Requestlink:482741433}
//
// Revision 1.123  2013/09/24 07:34:17  dinishev
// Cleanup
//
// Revision 1.122  2013/09/24 04:46:55  dinishev
// Cleanup
//
// Revision 1.121  2013/09/17 10:01:05  dinishev
// {Requestlink:481806782}. Не закрывались ячейки.
//
// Revision 1.120  2013/09/13 06:50:45  dinishev
// Экспериментальное определение кодировки. На тесте работает.
//
// Revision 1.119  2013/09/12 11:58:52  dinishev
// Cleanup
//
// Revision 1.118  2013/08/30 07:39:17  dinishev
// Cleanup
//
// Revision 1.117  2013/08/21 13:46:46  dinishev
// {Requestlink:460291228}. Вычистли устаревший код.
//
// Revision 1.116  2013/08/21 13:45:15  dinishev
// {Requestlink:460291228}
//
// Revision 1.115  2013/08/20 12:33:34  dinishev
// Вынос части кода за пределы WorkupText.
//
// Revision 1.114  2013/08/20 11:57:05  dinishev
// Убрал публичное свойство CodePage
//
// Revision 1.113  2013/08/20 11:40:29  dinishev
// Немного упрощаем код.
//
// Revision 1.112  2013/08/19 10:08:37  dinishev
// Cleanup
//
// Revision 1.111  2013/08/02 07:38:07  dinishev
// {Requestlink:449682598}
//
// Revision 1.110  2013/07/25 09:53:16  dinishev
// {Requestlink:460279011}
//
// Revision 1.109  2013/07/19 13:55:41  dinishev
// {Requestlink:466752604}. Теперь текстовый параграф сам умеет проверять и выливать номер.
//
// Revision 1.108  2013/06/14 12:30:49  dinishev
// {Requestlink:460261926}
//
// Revision 1.107  2013/06/14 11:09:58  dinishev
// Cleanup
//
// Revision 1.106  2013/06/07 08:18:32  dinishev
// Откатываю предыдущие изменения - когда доберусь до задачи, тогда и буду вдумчиво править.
//
// Revision 1.105  2013/06/06 15:01:32  dinishev
// Не падаем на чтении списков.
//
// Revision 1.104  2013/06/06 14:03:45  dinishev
// Cleanup
//                                                           
// Revision 1.103  2013/06/06 14:02:38  dinishev
// Cleanup
//
// Revision 1.102  2013/06/06 13:59:59  dinishev
// Cleanup
//
// Revision 1.101  2013/06/06 12:00:03  dinishev
// Игнорируем текст в <SCRIPT> при чтении файла.
//
// Revision 1.100  2013/06/03 13:00:26  dinishev
// Cleanup
//
// Revision 1.99  2013/06/03 09:04:22  dinishev
// Cleanup
//
// Revision 1.98  2013/06/03 08:58:40  dinishev
// {Requestlink:459284317}. Учим парсер распозновать тег <TH> для таблиц. Обрабатывается как <TD>
//
// Revision 1.97  2013/06/03 08:53:54  dinishev
// {Requestlink:459284317}. Откатываем предыдущий "костыль".
//
// Revision 1.96  2013/05/31 10:29:32  dinishev
// {Requestlink:459284317}. Добиваемся следующего AV. :-(
//
// Revision 1.95  2013/05/22 11:17:40  dinishev
// {Requestlink:453178004}. Учим HTMLReader читать вложенные таблицы. Вроде получилось.
//
// Revision 1.94  2013/05/06 12:37:11  dinishev
// Откатываем костыли и "рефакторинг" - отъехало чтение таблиц.
//
// Revision 1.93  2013/05/06 08:08:55  dinishev
// Убрал еще одно свойство.
//
// Revision 1.92  2013/04/16 09:06:05  narry
// Обновление
//
// Revision 1.91  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.90  2013/01/24 06:55:32  narry
// Поддержка нумерованных абзацев (пока не работает)
//
// Revision 1.89  2013/01/22 12:33:15  narry
// Рефакторинг RTFReader
//
// Revision 1.88  2012/08/28 09:10:35  narry
// Обработка спецсимволов HTML (336662745)
//
// Revision 1.87  2012/08/27 13:51:26  narry
// Ошибочно обрабатывается html (385976288)
//
// Revision 1.86  2012/04/19 12:18:37  narry
// Обработка отрицательных сабов в ссылках на гарантовские документы (358359010)
//
// Revision 1.85  2012/02/17 07:39:24  narry
// Обработка ссылок на гарантовские документы в html (288786476)
//
// Revision 1.84  2012/02/17 07:04:31  narry
// Обработка спецсимволов HTML (336662745)
//
// Revision 1.83  2012/02/15 10:51:30  narry
// Обработка спецсимволов HTML (336662745)
//
// Revision 1.82  2012/02/15 09:31:05  narry
// Обработка спецсимволов HTML (336662745)
//
// Revision 1.81  2012/02/15 09:24:45  narry
// Обработка спецсимволов HTML (336662745)
//
// Revision 1.80  2012/02/07 08:11:43  narry
// Сохранение html-ответа из редактора в evd (330703558)
//
// Revision 1.79  2012/02/07 07:11:24  narry
// Сохранение html-ответа из редактора в evd (330703558)
//
// Revision 1.78  2012/02/06 10:16:33  narry
// Сохранение html-ответа из редактора в evd (330703558)
//
// Revision 1.77  2011/10/13 08:43:31  narry
// Накопившиеся изменения
//
// Revision 1.76  2011/10/07 07:51:52  narry
// Поддержа неизвестных ключевых слов
//
// Revision 1.75  2011/10/06 11:53:20  narry
// Виртуальный метод для обработки StartKeywordChar
//
// Revision 1.74  2011/10/05 08:31:02  narry
// Рефакторинг чтения HTML
//
// Revision 1.73  2011/10/04 12:21:17  narry
// Рефакторинг чтения HTML
//
// Revision 1.72  2011/09/29 15:08:49  lulin
// {RequestLink:288788279}.
//
// Revision 1.71  2011/09/01 08:05:24  narry
// 35. Стирается пробел перед ссылкой (внимание на между "от" и датой) (278839514)
//
// Revision 1.70  2011/08/12 07:19:53  narry
// 28. Игнорировать содержимое файла после окончания html (278839269)
//
// Revision 1.69  2011/08/09 13:08:56  narry
// 25. Соседние объединенные по вертикали ячейки портят таблицу  (278833307)
//
// Revision 1.68  2011/07/29 05:24:44  narry
// Таблицы со смешанными ширинами ячеек (276534804)
//
// Revision 1.67  2011/07/28 12:04:43  narry
// Таблицы со смешанными ширинами ячеек (276534804)
//
// Revision 1.66  2011/07/19 14:39:55  narry
// Снова заголовки 2 (274835821)
//
// Revision 1.65  2011/07/19 12:32:05  narry
// Оформление текста 2 (274835320)
//
// Revision 1.64  2011/07/18 12:11:23  narry
// Снова заголовки (274829372)
//
// Revision 1.63  2011/07/15 10:35:20  narry
// Кривые рамки у таблиц (274825384)
//
// Revision 1.62  2011/07/15 09:38:07  narry
// Ссылки съедают пробел (274825348)
//
// Revision 1.61  2011/07/14 11:05:13  narry
// Кривые таблицы (273589115)
//
// Revision 1.60  2011/07/12 09:25:57  narry
// Кривые таблицы (273589115)
//
// Revision 1.59  2011/02/07 08:40:43  narry
// K251341845. Сохранение ссылок
//
// Revision 1.58  2010/10/14 04:37:41  narry
// K235872650. AV при открытии справки к списку
//
// Revision 1.57  2010/10/12 06:51:23  narry
// K208701604. Утилита сборки постановлений из html
//
// Revision 1.56  2010/09/29 08:45:13  narry
// K208208004. Класс для чтения атрибутов постановления из HTML-карточки
//
// Revision 1.54  2010/02/24 18:16:27  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.53  2009/12/14 11:46:59  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.52  2009/07/21 15:10:20  lulin
// - bug fix: не собирался и не работал Архивариус в ветке.
//
// Revision 1.51  2009/03/04 13:33:06  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.50  2008/10/13 12:39:27  narry
// - промежуточное обновление
//
// Revision 1.49  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.48  2008/03/21 14:09:21  lulin
// - cleanup.
//
// Revision 1.47  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.46  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.45  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.44  2008/02/05 18:20:36  lulin
// - удалено ненужное свойство строк.
//
// Revision 1.43  2008/02/05 12:49:12  lulin
// - упрощаем базовые объекты.
//
// Revision 1.42  2008/02/05 09:57:59  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.41  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.40  2006/12/01 15:51:01  lulin
// - cleanup.
//
// Revision 1.39  2006/11/03 11:00:39  lulin
// - объединил с веткой 6.4.
//
// Revision 1.38.36.1  2006/10/23 05:51:04  lulin
// - переход по ссылке переделан с обработки мыши на специально для этого выделенное событие.
//
// Revision 1.38  2005/05/26 15:35:07  lulin
// - базовая канва вывода теперь избавлена от знания о контролах управления.
//
// Revision 1.37  2004/12/23 08:40:38  lulin
// - вычищен ненужный модуль.
//
// Revision 1.36  2004/12/16 13:40:16  lulin
// - Print-preview списка полностью переведен на новый механизм.
//
// Revision 1.35  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.34  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.33  2004/05/26 10:26:55  narry
// - bug fix: &nbsp; интерпретировался как обычный пробел, а не как неразрывный
//
// Revision 1.32  2004/05/25 15:04:19  narry
// - bug fix: последствия перехода на "кошерную" функцию
//
// Revision 1.31  2004/05/25 14:54:40  law
// - прикрутил еще одну "кошерную" функцию разбора на слова - l3ParseWordsExF.
//
// Revision 1.30  2004/05/25 14:47:28  law
// - прикрутил "кошерную" функцию разбора на слова.
//
// Revision 1.29  2004/05/25 13:01:37  narry
// - update: поддержка чтения таблицы стилей из HTML
//
// Revision 1.28  2004/04/16 13:47:50  narry
// - update: игнорирование таблицы стилей
//
// Revision 1.27  2003/12/29 14:07:47  narry
// - new: чтения PRE-абзацев как Моноширинных
//
// Revision 1.26  2003/07/02 16:23:59  narry
// - bug fix: генерация пустых абзацев в "Немезисе".
//
// Revision 1.25  2003/06/30 12:37:30  narry
// - update: объединение с основной веткой
//
// Revision 1.24.2.1  2003/06/30 12:35:25  narry
// - bug fix: не распознавался тэг PRE; не работало шрифтовое выделение
//
// Revision 1.24  2003/06/04 11:55:16  narry
// no message
//
// Revision 1.23  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.22  2002/07/09 12:02:17  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.21  2002/03/14 13:55:36  narry
// - update: добавление обработки тэга <STRONG>
//
// Revision 1.20  2002/02/19 12:55:06  narry
// - bug fix: присвоение формата шрифта до открытия абзаца
//
// Revision 1.19  2001/10/18 12:14:16  narry
// - update : замена объекта TCyrCoder на внутреннюю перекодировку
//
// Revision 1.18  2001/09/03 13:22:48  narry
// - bug fix: коррекция ширин таблиц
//
// Revision 1.17  2001/08/29 12:52:47  narry
// - bug fix
//
// Revision 1.16  2001/08/29 08:59:39  voba
// -bug fix
//
// Revision 1.15  2001/08/28 13:05:01  narry
// - bug fix: двухуровненвые списки приводили к ошибке чтения
//
// Revision 1.14  2001/08/28 12:21:31  narry
// - update: Разбор текста без тэгов HTML и BODY. Разбор полужирного,
//        курсива и подчеркнутого
//
// Revision 1.12  2001/05/10 14:21:38  narry
// Update - более корректное чтение параметро
//
// Revision 1.11  2001/05/07 14:03:41  narry
// Update - улучшенный алгоритм чтения таблиц
//
// Revision 1.10  2001/03/14 16:28:14  narry
// Update HTML_r
//
// Revision 1.9  2001/03/06 11:27:51  narry
// Исправлено - рамки у таблиц
// Добавлено - поддержка списко
//
// Revision 1.8  2001/03/02 14:17:50  narry
// First release
//
// Revision 1.7  2001/03/01 10:21:25  narry
// Fix wrong #5 segments
//
// Revision 1.6  2001/02/27 16:07:33  narry
// Correct cell width
//
// Revision 1.5  2001/02/26 16:54:39  narry
// Temporary upload
//
// Revision 1.4  2000/12/15 15:29:54  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

Uses
 Classes,
 Graphics,

 k2Reader,
 k2TagGen,

 RTFTypes,

 ddBase,
 ddTypes,
 ddTable,
 ddHTMLTag,
 ddJustList,
 ddTableRow,
 ddParaList,
 ddDocument,
 ddHTMLParser,
 ddDocumentAtom,
 ddRTFProperties,
 ddSimpleHTMLReader,
 ddCharacterProperty,

 l3Base,
 l3Types,
 l3ObjectRefList,
 l3LongintList,
 l3RegEx;

type
  TddHTMLReader = class(TddSimpleHTMLReader)
  private
    f_CHP           : TddCharacterProperty;
    f_URL           : Tl3String;
    f_Lite          : Boolean;
    f_List          : TddParaList;
    f_Align         : TddJustList;
    f_InPTag        : Integer;
    f_ParaTag       : TddHTMLTag;
    f_NeedInc       : Boolean;
    f_IsHeader      : Boolean;
    f_NewSubID      : Integer;
    f_RefStart      : Integer;
    f_EtalonRow     : TddTableRow;
    f_HRefDocID     : Integer;
    f_HRefSubID     : Integer;
    f_SaveIsBody    : Boolean;
    f_CheckEmpty    : Boolean;
    f_HeaderStyle   : Integer;
    f_ScaleCellWidth: Boolean;
  private
    procedure CloseCell;
    procedure CloseHyperlink;
    procedure CloseList;
    procedure CloseRow;
    procedure CloseSegment;
    procedure CloseTable;
    procedure OpenHyperlink(aTag: TddHTMLTag);
    procedure ParseCell(aObj: TddHTMLTag);
    procedure ParseParagraph(aObj: TddHTMLTag);
    procedure ParseRow(aObj: TddHTMLTag);
    procedure ParseSpan(aObj: TddHTMLTag; aSpan: Boolean);
    procedure ParseTable(aObj: TddHTMLTag);
    function pm_GetDefAlign: TJust;
    procedure pm_SetDefAlign(const Value: TJust);
    procedure StartSegment;
    procedure WorkupB(aTag: TddHTMLTag);
    procedure WorkupBody(aTag: TddHTMLTag);
    procedure WorkupBR;
    procedure WorkupDiv(aTag: TddHTMLTag);
    procedure WorkupHTML(aTag: TddHTMLTag);
    procedure WorkupHN(aTag: TddHTMLTag);
    procedure WorkupA(aTag: TddHTMLTag);
    procedure WorkupI(aTag: TddHTMLTag);
    procedure WorkupImg(aTag: TddHTMLTag);
    procedure WorkupLI(aTag: TddHTMLTag);
    procedure WorkupMeta(aTag: TddHTMLTag);
    procedure WorkupOL(aTag: TddHTMLTag);
    procedure WorkupP(aTag: TddHTMLTag);
    procedure WorkupSpan(aTag: TddHTMLTag);
    procedure WorkupStyle(aTag: TddHTMLTag);
    procedure WorkupTable(aTag: TddHTMLTag);
    procedure WorkupTD(aTag: TddHTMLTag);
    procedure WorkupTR(aTag: TddHTMLTag);
    procedure WorkupU(aTag: TddHTMLTag);
    procedure WorkupUL(aTag: TddHTMLTag);
    procedure WorkupDel(aTag: TddHTMLTag);
    procedure WorkupSup(aTag: TddHTMLTag);
    procedure WorkupSub(aTag: TddHTMLTag);
    procedure WorkWithScript(aTag: TddHTMLTag);
    function GetHTMLParser: TddHTMLParser;
    procedure CheckPara;
    procedure DeletePara;
    function GetNewSubID: Integer;
    procedure CheckTextCaps;
    procedure DelTagsFinished; override;
  protected
    property DefAlign: TJust read pm_GetDefAlign write pm_SetDefAlign;
  protected
    procedure Cleanup; override;
    procedure Read; override;
    procedure BeforeCloseParagraph(const anAtom: TddDocumentAtom; aTag: TddHTMLTag; var theDelete: Boolean); virtual;
    procedure BeforeWrite; virtual;
    procedure CloseParagraph;
    procedure OpenParagraph; override;
    procedure RestoreDefAlign;
    procedure WorkupTag(aTag: TddHTMLTag); override;
  public
    constructor Create(aOwner: Tk2TagGeneratorOwner = nil); override;
    property Lite: Boolean read f_Lite write f_Lite;
    property ScaleCellWidth: Boolean read f_ScaleCellWidth write f_ScaleCellWidth;
  end;

implementation

uses
  Math,
  SysUtils,
  StrUtils,

  imageenio,

  k2Tags,

  l3Math,
  l3Units,
  l3Chars,
  l3MinMax,
  l3String,
  l3FileUtils,
  l3Interfaces,
  l3UnitsTools,

  evTypes,

  evdTypes,
  evdStyles,

  Document_Const,

  JClStringConversions,

  ddPicture,
  ddRTFUnits,
  ddHTMLTags,
  ddTableCell,
  ddHyperlink,
  ddTablePrim,
  ddTextSegment,
  ddTextParagraph,
  ddDocumentProperty;

{
******************************** TddHTMLReader *********************************
}
constructor TddHTMLReader.Create(aOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(aOwner);
 f_Lite:= True;
 f_ScaleCellWidth := True;
 f_Align := TddJustList.Create;
 f_URL := Tl3String.Make(CP_ANSI);
 f_ParaTag := nil;
 f_InPTag := 0;
 f_RefStart := 1;
end;

procedure TddHTMLReader.Read;
var
 l_LiteVersion: TddLiteVersion;
begin
 IsData := False;
 f_IsHeader := False;
 DefAlign := JustF;
 f_NewSubID := 0;
 { TODO : Вынести отсюда создание и разрушение объектов }
 f_CHP := TddCharacterProperty.Create;
 try
  Generator.StartChild(k2_typDocument);
  try
   f_Document:= TddDocument.Create(nil);
   {$IF Defined(nsTest) and not Defined(InsiderTest)}
   f_Document.DOP.xaRight := defHorisMargin;
   {$IFEND}
   f_Document.AddFont('Arial');
   f_IsBody := Lite;
   f_InPTag := 0;
   inherited;
   if IsData then
    CloseParagraph;
   BeforeWrite;
   l_LiteVersion := dd_lvNone;
   if Lite then
    if ReadURL then
     l_LiteVersion := dd_lvTextAlign
    else
     l_LiteVersion := dd_lvStyleOnly;
   f_Document.Write2Generator(Generator, l_LiteVersion);
  finally
   f_NewSubID := 0;
   Generator.Finish;
   FreeAndNil(f_Document);
   FreeAndNil(f_List);
  end;
 finally
  FreeAndNil(f_CHP);
 end; // l_CHP
end;

procedure TddHTMLReader.Cleanup;
begin
 inherited;
 f_InScript := False;
 FreeAndNil(f_URL);
 FreeAndNil(f_Align);
 FreeAndNil(f_ParaTag);
 f_InPTag := 0;
 f_RefStart := 1;
end;

procedure TddHTMLReader.CloseCell;
var
 l_Delete: Boolean;
begin
 CloseParagraph;
 if (f_Document.Table <> nil) and (f_Document.Table.LastRow <> nil) then
 begin
  l_Delete := False;
  BeforeCloseParagraph(f_Document.Table.LastRow.LastCell, nil, l_Delete);
  f_Document.Table.LastRow.LastCell.Closed := True;
 end; // if (f_Document.Table <> nil) and (f_Document.Table.LastRow <> nil) then
 RestoreDefAlign;
end;

procedure TddHTMLReader.CloseList;
begin
 if f_List <> nil then
 begin
  if f_List.Multilevel then
   f_List.CloseLevel
  else
  begin
   f_List.Closed := True;
   FreeAndNil(f_List);
  end;
 end;
end;

procedure TddHTMLReader.BeforeCloseParagraph(const anAtom: TddDocumentAtom; aTag: TddHTMLTag; var theDelete: Boolean);
begin
end;

procedure TddHTMLReader.BeforeWrite;
begin
 // TODO -cMM: TddHTMLReader.BeforeWrite default body inserted
end;

procedure TddHTMLReader.CloseHyperlink;
var
 l_Seg      : TddTextSegment;
 l_Hyperlink: Boolean;
begin
 if ((f_HREFDocID > 0) and (f_Document.LastPara.Text.Len > 0)) then // http://mdp.garant.ru/pages/viewpage.action?pageId=449682598
 begin
  l_Seg := TddHyperlink.Create;
  try
   l_Seg.AddTarget(f_HREFDocID, f_HREFSubID, CI_TOPIC);
   l_Seg.Start := f_RefStart;
   l_Seg.Stop := f_Document.LastPara.Text.Len;
   f_Document.LastPara.AddSegment(l_Seg);
  finally
   l3Free(l_Seg);
  end;
 end // if ((f_HREFDocID > 0) and (f_Document.LastPara.Text.Len > 0)) then
 else
  if ReadURL and not f_URL.Empty and (f_Document.LastPara.Text.Len > 0) then
  begin
   l_Seg := TddHyperlink.Create;
   try
    l_Seg.AddTarget(f_HREFDocID, f_HREFSubID, CI_REF);
    l_Seg.Start := f_RefStart;
    l_Seg.Stop := f_Document.LastPara.Text.Len;
    l_Seg.URL.AssignString(f_URL);
    f_URL.Clear;
    f_Document.LastPara.AddSegment(l_Seg);
   finally
    l3Free(l_Seg);
   end;
  end; // if ReadURL and not f_URL.Empty and (f_Document.LastPara.Text.Len > 0) then
end;

procedure TddHTMLReader.CloseParagraph;
var
 l_LastPara: TddTextParagraph;
begin
 if IsData then
 begin
  l_LastPara := f_Document.LastPara;
  if l_LastPara <> nil then
  begin
   if f_IsHeader then
    l_LastPara.PAP.Style := f_HeaderStyle;
   l_LastPara.Closed := True;
   l_LastPara.CorrectSegments(nil);
  end; // if l_LastPara <> nil then
 end;
end;

procedure TddHTMLReader.CloseRow;
var
 l_Table: TddTable;

 procedure lp_CheckTable;
 var
  i         : Integer;
  l_Row     : TddTableRow;
  l_Width   : Integer;
  l_Count   : Integer;
  l_DefCount: Integer;
 begin
  l_Row := l_Table.LastRow;
  l_DefCount := 0;
  l_Count := l_Row.CellCount - 1;
  for i := 0 to l_Count do
   if l_Row.Cells[i].Props.CellOffset = ddDefaultCellWidth then
    Inc(l_DefCount);
  if l_DefCount = l_Count then
  begin
   Inc(l_Count);
   l_Width := l_Table.Width div l_Count;
   for i := 0 to l_Row.CellCount - 1 do
    l_Row.Cells[i].Props.CellOffset := l_Width;
  end; // if l_DefCount = l_Row.CellCount - 1 then
 end;

begin
 if f_Document.Table <> nil then
 begin
  l_Table := f_Document.Table;
  lp_CheckTable;
  l_Table.CloseRow;
 end; // if f_Document.Table <> nil then
 RestoreDefAlign;
end;

procedure TddHTMLReader.CloseSegment;
var
 l_LastPara         : TddTextParagraph;
 l_LastStyledSegment: TddTextSegment;
begin
 l_LastPara := f_Document.LastPara;
 if l_LastPara <> nil then
 begin
  l_LastStyledSegment := l_LastPara.LastStyledSegment;
  if l_LastStyledSegment <> nil then
   l_LastStyledSegment.Stop := l_LastPara.Text.Len;
 end; // if l_LastPara <> nil then
end;

procedure TddHTMLReader.CloseTable;
begin
 f_Document.CloseTable(ScaleCellWidth);
end;

procedure TddHTMLReader.OpenHyperlink(aTag: TddHTMLTag);
var
 l_Text : AnsiString;
 l_Param: TddHTMLParam;
begin
 f_HREFDocID := -1;
 f_RefStart := 1;
 if aTag.HasKey(dd_paridName, l_Param) then
 begin
  if ReadURL then
  begin
   CheckPara;
   f_Document.LastPara.AddSub(GetNewSubID, aTag.Param2PCharLen(l_Param));
  end; // if ReadURL then
 end // if aTag.HasKey(dd_paridName, l_Param) then
 else
 if aTag.HasKey(dd_paridHREF, l_Param) then
  if l_Param.rType = dd_parHREF then
  begin
   f_HREFDocID := l_Param.rDocID;
   f_HREFSubID := l_Param.rSubID;
   f_URL.Clear;
   f_RefStart := Succ(f_Document.LastPara.Text.Len);
  end // if l_Param.rType = dd_parHREF then
  else
   if l_Param.rType = dd_parHREFURL then
   begin
    l_Text := l3PCharLen2String(aTag.Param2PCharLen(l_Param));
    ReasolveEntity(l_Text, f_URL);
    f_HREFDocID := 0;
    f_HREFSubID := 0;
    f_RefStart := Succ(f_Document.LastPara.Text.Len);
   end; // if l_Param.rType = dd_parHREFURL then
end;

procedure TddHTMLReader.OpenParagraph;
var
 l_Style: TddStyleEntry;
begin
 f_IsBody := True;
 CloseParagraph;
 if IsData then
 begin
  f_Document.AddParagraph;
  f_Document.LastPara.Closed := False;
  l_Style := f_Document.StyleByName('P');
  if l_Style <> nil then
  begin
   f_Document.LastPara.PAP := l_Style.PAP;
   f_Document.LastPara.CHP := l_Style.CHP;
  end; // l_Style
  if f_Document.Table <> nil then
   f_Document.LastPara.PAP.ClearProperty(dd_Just);
 end; // if not f_IsPara then
end;

procedure TddHTMLReader.ParseCell(aObj: TddHTMLTag);
var
 l_Row           : TddTableRow;
 l_Param         : TddHTMLParam;
 l_NeedFakeAlign : Boolean;
begin
 if f_Document.Table <> nil then
 begin
  { Проверяем предыдущий ряд на наличие объединенных по вертикали ячеек }
  l_Row := f_Document.Table.BeforeParseCell;
  l_NeedFakeAlign := True;
   { Вылить параметры ячейки таблицы, если они есть }
  if aObj.HasKey(dd_paridALIGN, l_Param) then
  begin
   DefAlign := l_Param.rAlign;
   l_NeedFakeAlign := False;
  end; // if aObj.HasKey(dd_paridALIGN, l_Param) then
  if aObj.HasKey(dd_paridVALIGN, l_Param) then
   l_Row.LastCell.Props.CellJust := l_Param.rVAlign;
  if aObj.HasKey(dd_paridWIDTH, l_Param) then
  begin
   l_Row.LastCell.Props.CellOffset := l_Param.rValue;
   l_Row.LastCell.Props.IsPercent := l_Param.rIsPercent;
  end; // if aObj.HasKey(dd_paridWIDTH, l_Param) then
  if aObj.HasKey(dd_paridCOLSPAN, l_Param) then
   f_Document.Table.LastRow.LastCell.Props.CellSpan := l_Param.rValue;
  if aObj.HasKey(dd_paridROWSPAN, l_Param) then
  begin
   f_Document.Table.LastRow.LastCell.Props.RowSpan := l_Param.rValue;
   f_Document.Table.LastRow.LastCell.Props.VMergeFirst := True;
  end; // if aObj.HasKey(dd_paridROWSPAN, l_Param) then
  if aObj.HasKey(dd_paridBorderTop, l_Param) then
  begin
   if l_Param.rHasBorder then
    l_Row.LastCell.Props.Border.Frames[bpTop].Enable := True;
  end; // if aObj.HasKey(dd_paridROWSPAN, l_Param) then
  (*if aObj.HasKey(dd_paridTextTransform, l_Param) then
  begin
   if l_Param.rHasBorder then
    l_Row.LastCell.Props.Border.Frames[bpBottom].Enable := True;
  end; // if aObj.HasKey(dd_paridROWSPAN, l_Param) then *)
  if aObj.HasKey(dd_paridBorderBottom, l_Param) then
  begin
   if l_Param.rHasBorder then
    l_Row.LastCell.Props.Border.Frames[bpBottom].Enable := True;
  end; // if aObj.HasKey(dd_paridROWSPAN, l_Param) then
  if aObj.HasKey(dd_paridBorderLeft, l_Param) then
  begin
   if l_Param.rHasBorder then
    l_Row.LastCell.Props.Border.Frames[bpLeft].Enable := True;
  end; // if aObj.HasKey(dd_paridROWSPAN, l_Param) then
  if aObj.HasKey(dd_paridBorderRight, l_Param) then
  begin
   if l_Param.rHasBorder then
    l_Row.LastCell.Props.Border.Frames[bpRight].Enable := True;
  end; // if aObj.HasKey(dd_paridROWSPAN, l_Param) then
  if l_NeedFakeAlign then
   DefAlign := justL
 end; // f_Document.Table <> nil
end;

procedure TddHTMLReader.ParseParagraph(aObj: TddHTMLTag);
var
 l_Param: TddHTMLParam;
begin
 OpenParagraph;
 if aObj.TagID = tidPRE then
  f_Document.LastPara.PAP.Style:= ev_saANSIDOS;
 if aObj.HasKey(dd_paridALIGN, l_Param) then
  f_Document.LastPara.PAP.Just := l_Param.rAlign;
end;

procedure TddHTMLReader.ParseRow(aObj: TddHTMLTag);
var
 l_Row   : TddTableRow;
 l_Param : TddHTMLParam;
begin
 if f_Document.Table <> nil then
 begin
  l_Row := f_Document.Table.GetLastNotClosedRow;
  if l_Row = nil then
  begin
   f_Document.Table.AddRow(False);
   l_Row := f_Document.Table.LastRow;
  end; // if l_Row = nil then
  f_Document.Table.LastRow.TAP.Width := 10206;
  { Вылить параметры строки таблицы, если они есть }
  if aObj.HasKey(dd_paridALIGN, l_Param) then
   DefAlign := l_Param.rAlign
  else
   DefAlign := DefAlign;
 end;
end;

procedure TddHTMLReader.ParseSpan(aObj: TddHTMLTag; aSpan: Boolean);
const
 csSpanPrefix: Tl3PCharLenPrim = (S         : 'span.';
                                  SLen      : 5;
                                  SCodePage : CP_ANSI);
var
 l_Str       : Tl3String;
 l_Para      : TddTextParagraph;
 l_Param     : TddHTMLParam;
 l_Style     : TddStyleEntry;
 l_StyleName : Tl3PCharLen;
begin
 // Style - оформление в одну строку
 // class - присвоение оформления сегменту
 if aObj.HasKey(dd_paridCLASS, l_Param) then
 begin
  if aSpan then
  begin
   l_Str := Tl3String.Make(csSpanPrefix);
   l_Str.Append(aObj.Param2PCharLen(l_Param));
  end // if aSpan then
  else
   l_Str := Tl3String.Make(aObj.Param2PCharLen(l_Param));
  try
   l_Style := f_Document.StyleByName(l_Str.AsPCharLen);
   if l_Style <> nil then
   begin
    if not IsData then
     IsData := True;
    CheckPara;
    l_Para := f_Document.LastPara;
    l_Para.PAP.MergeWith(l_Style.PAP);
    l_Para.AddSegment(l_Style.CHP, nil);
    if aSpan and (l_Style.PAP.xaLeft <> propUndefined) then
     l_Para.AddText(DupeString(' ', l_Style.PAP.xaLeft div 10));
   end; // l_Style <> nil
  finally
   l3Free(l_Str);
  end;
 end // l_Param.Key = 'CLASS'
 else
  if aObj.HasKey(dd_paridTextTransform, l_Param) then
   f_CHP.Caps := l_Param.rTransform;
end;

procedure TddHTMLReader.ParseTable(aObj: TddHTMLTag);
var
 l_Param: TddHTMLParam;
begin
 CloseParagraph;
 f_Document.CreateTable;
 { Вылить параметры таблицы, если они есть }
 if aObj.HasKey(dd_paridWIDTH, l_Param) then
  if l_Param.rIsPercent then
   f_Document.Table.Width := l3MulDiv(f_Document.TextWidth, l_Param.rValue, 100)
  else
   f_Document.Table.Width := l_Param.rValue
 else
  f_Document.Table.Width := f_Document.TextWidth;
end;

function TddHTMLReader.pm_GetDefAlign: TJust;
begin
 if f_Align.Count = 0 then
  Result := JustF
 else
  Result := f_Align.Last;
end;

procedure TddHTMLReader.pm_SetDefAlign(const Value: TJust);
begin
 f_Align.Add(Value);
end;

procedure TddHTMLReader.RestoreDefAlign;
begin
 f_Align.DeleteLast;
end;

procedure TddHTMLReader.StartSegment;
begin
 if not IsData then
  IsData := True;
 CheckPara;
 f_Document.LastPara.AddSegment(f_CHP, nil, True);
end;

procedure TddHTMLReader.WorkupB(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  CloseSegment;
  f_CHP.ClearProp(ddBold);
 end
 else
 begin
  f_CHP.Bold := True;
  StartSegment;
 end;
end;

procedure TddHTMLReader.WorkupBody(aTag: TddHTMLTag);
begin
 f_IsBody := not aTag.IsClosed;
 if f_IsBody then
  IsData := True;
end;

procedure TddHTMLReader.WorkupBR;
begin
 if f_Document.LastPara <> nil then
  f_Document.LastPara.Text.Append(cc_SoftEnter);
end;

procedure TddHTMLReader.WorkupDiv(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
  CloseParagraph;
end;

procedure TddHTMLReader.WorkupHTML(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  f_IsBody := False;
  BreakAnalyze;
 end // if aTag.IsClosed then
 else
  f_InitCodePage := True; 
end;

procedure TddHTMLReader.WorkupHN(aTag: TddHTMLTag);
var
 l_LastPara: TddTextParagraph;
begin
 if aTag.IsClosed then
 begin
  CloseParagraph;
  f_IsHeader := False;
  l_LastPara := f_Document.LastPara;
  if l_LastPara <> nil then
   l_LastPara.PAP.Style := f_HeaderStyle;
  f_HeaderStyle := ev_saEmpty;
 end // if aTag.IsClosed then
 else
 begin
  case aTag.TagID of
   tidH1: f_HeaderStyle := ev_saTxtHeader1;
   tidH2: f_HeaderStyle := ev_saTxtHeader2;
   tidH3: f_HeaderStyle := ev_saTxtHeader3;
  else
   f_HeaderStyle:= ev_saTxtHeader4;
  end;
  f_IsHeader:= True;
 end;
end;

procedure TddHTMLReader.WorkupI(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  CloseSegment;
  f_CHP.ClearProp(ddItalic);
 end // if aTag.IsClosed then
 else
 begin
  f_CHP.Italic := True;
  StartSegment;
 end;
end;

procedure TddHTMLReader.WorkupLI(aTag: TddHTMLTag);
begin
 if not aTag.IsClosed then
  OpenParagraph;
end;

procedure TddHTMLReader.WorkupMeta(aTag: TddHTMLTag);
var
 l_Param: TddHTMLParam;
begin
 if not aTag.IsClosed then
 begin
  f_InitCodePage := True;
  if aTag.HasKey(dd_paridCHARSET, l_Param) then
   f_CodePage := l_Param.rCharset;
 end; // if not aTag.IsClosed then
end;

procedure TddHTMLReader.WorkupOL(aTag: TddHTMLTag);
var
 l_List2: TddParaList;
begin
 if aTag.IsClosed then
  CloseList
 else
 begin
  if f_List <> nil then
  begin
   CloseParagraph;
   l_List2:= TddParaList.Create(nil);
   try
    l_List2.ListType:= ltUnordered;
    f_List.AddList(l_List2);
   finally
    l3Free(l_List2);
   end;
  end // if f_List <> nil then
  else
  begin
   f_List:= TddParaList.Create(nil);
   f_List.ListType:= ltOrdered;
   f_Document.Paragraphs.Add(f_List);
  end;
 end;
end;

procedure TddHTMLReader.WorkupP(aTag: TddHTMLTag);

 procedure lp_MakeCopy;
 begin
  if f_ParaTag <> nil then
   FreeAndNil(f_ParaTag);
  f_ParaTag := TddHTMLTag.Create(aTag.TagID);
  f_ParaTag.Assign(aTag);
 end;

 function lp_NeedDelete(aPara: TddTextParagraph): Boolean;
 begin
  Result := (aPara <> nil) and f_CheckEmpty and aPara.Empty;
 end;

var
 l_Delete  : Boolean;
 l_LastPara: TddTextParagraph;
begin
 if aTag.IsClosed then
 begin
  Dec(f_InPTag);
  if f_InPTag > 0 then Exit;
  GetHTMLParser.IgnoreHTMLComment := dd_icNone;
  if IsData then
  begin
   l_LastPara := f_Document.LastPara;
   l_Delete := lp_NeedDelete(l_LastPara);
   if not l_Delete then
    BeforeCloseParagraph(l_LastPara, f_ParaTag, l_Delete);
   if ReadURL then
    FreeAndNil(f_ParaTag);
   if l_Delete then
    DeletePara
   else
    CloseParagraph;
   f_IsPre := False;
  end; // if f_IsPara then
  f_CheckEmpty := False;
 end // if aTag.IsClosed then
 else
 begin
  IsData := True;
  Inc(f_InPTag);
  f_CheckEmpty := False;
  GetHTMLParser.IgnoreHTMLComment := dd_icAll;
  ParseParagraph(aTag);
  ParseSpan(aTag, False);
  if (f_InPTag = 1) and ReadURL then
   lp_MakeCopy;
  f_IsPre := aTag.TagID = tidPRE;
 end;
end;

procedure TddHTMLReader.WorkupSpan(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  GetHTMLParser.IgnoreHTMLComment := dd_icAll;
  CheckTextCaps;
  f_CHP.ClearProp(ddCaps);
 end // if aTag.IsClosed then
 else
 begin
  IsData := True;
  GetHTMLParser.IgnoreHTMLComment := dd_icNone;
  CheckPara;
  f_Document.LastPara.AddSegment(f_CHP, nil, True);
  ParseSpan(aTag, True);
 end;
end;

procedure TddHTMLReader.WorkupStyle(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  f_IsBody := f_SaveIsBody;
  f_IsStyle := False;
  GetHTMLParser.IgnoreHTMLComment := dd_icNone;
 end // if aTag.IsClosed then
 else
 begin
  f_SaveIsBody:= f_IsBody;
  f_IsBody := False;
  f_IsStyle := True;
  GetHTMLParser.IgnoreHTMLComment := dd_icHTML;
 end;
end;

procedure TddHTMLReader.WorkupTable(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  CloseTable;
  IsData := True;
 end // if aTag.IsClosed then
 else
  ParseTable(aTag);
end;

procedure TddHTMLReader.WorkupA(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
  CloseHyperlink
 else
  OpenHyperlink(aTag);
end;

procedure TddHTMLReader.WorkupTag(aTag: TddHTMLTag);
begin
 case aTag.TagID of
  tidP, tidPRE: WorkupP(aTag);
  tidB, tidSTRONG: WorkupB(aTag);
  tidI: WorkupI(aTag);
  tidU: WorkupU(aTag);
  tidSPAN: WorkupSpan(aTag);
  tidH1, tidH2, tidH3, tidH4: WorkupHN(aTag);
  tidTABLE: WorkupTable(aTag);
  tidTR: WorkupTR(aTag);
  tidTD: WorkupTD(aTag);                                      
  tidBR: WorkupBR;
  tidUL: WorkupUL(aTag);
  tidOL: WorkupOL(aTag);
  tidLI: WorkupLI(aTag);
  tidBODY: WorkupBody(aTag);
  tidMETA: WorkupMeta(aTag);
  tidDIV: WorkupDiv(aTag);
  tidSTYLE: WorkupStyle(aTag);
  tidHTML: WorkupHTML(aTag);
  tidA: WorkupA(aTag);
  tidTH: WorkupTD(aTag);
  tidIMG: WorkupIMG(aTag);
  tidSCRIPT: WorkWithScript(aTag);
  tidDel: WorkupDel(aTag);
  tidSup: WorkupSup(aTag);
  tidSub: WorkupSub(aTag);
 end;
end;

procedure TddHTMLReader.WorkupTD(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  CloseCell;
  IsData := False;
 end
 else
 begin
  IsData := True;
  ParseCell(aTag);
 end;
end;

procedure TddHTMLReader.WorkupTR(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
  CloseRow
 else
 begin
  IsData := False;
  ParseRow(aTag);
 end;
end;

procedure TddHTMLReader.WorkupU(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
  f_CHP.ClearProp(ddUnderline)
 else
  f_CHP.Underline := utThick;
 if aTag.IsClosed then
  CloseSegment
 else
  StartSegment;
end;

procedure TddHTMLReader.WorkupUL(aTag: TddHTMLTag);
var
 l_List2: TddParaList;
begin
 if aTag.IsClosed then
  CloseList
 else
  if f_List <> nil then
  begin
   CloseParagraph;
   l_List2 := TddParaList.Create(nil);
   try
    l_List2.ListType := ltUnordered;
    f_List.AddList(l_List2);
   finally
    l3Free(l_List2);
   end;
  end // if f_List <> nil then
  else
  begin
   f_List := TddParaList.Create(nil);
   f_List.ListType := ltUnordered;
   f_Document.Paragraphs.Add(f_List);
  end;
end;

procedure TddHTMLReader.WorkWithScript(aTag: TddHTMLTag);
begin
 f_InScript := not aTag.IsClosed;
end;

procedure TddHTMLReader.WorkupImg(aTag: TddHTMLTag);
var
 l_Param      : TddHTMLParam;
 l_Picture    : TddPicture;
 l_LastPara   : TddTextParagraph;
 l_PicturePath: AnsiString;
begin
 if not aTag.IsClosed then
  if aTag.HasKey(dd_paridSRC, l_Param) then
  begin
   l_PicturePath := l3PCharLen2String(aTag.Param2PCharLen(l_Param));
   if Pos('//', l_PicturePath) > 0 then Exit; // Пока заплатка, чтобы игнорировать гиперссылки не пытаясь открыть файл...
   if Pos('\', l_PicturePath) = 0 then
    l_PicturePath := NormalDir(Filer.GetFilePath) + l_PicturePath;
   l_Picture := TddPicture.CreateFromFile(l_PicturePath);
   try
    if (l_Picture <> nil) and (l_Picture.Format <> ioUnknown) then
    begin
     l_Picture.Width := Pixel2Twip(l_Picture.Width);
     l_Picture.Height := Pixel2Twip(l_Picture.Height);
     l_LastPara := f_Document.LastPara;
     l_Picture.Closed := True;
     if l_LastPara = nil then
      f_Document.AddDocumentAtom(l_Picture)
     else
      l_LastPara.AddPicture(l_Picture, False);
    end; // if l_Picture <> nil then
   finally
    l3Free(l_Picture);
   end;
  end; // if aTag.HasKey(dd_paridSRC, l_Param) then
end;

function TddHTMLReader.GetHTMLParser: TddHTMLParser;
begin
 Result := TddHTMLParser(Parser);
end;

procedure TddHTMLReader.CheckPara;
begin
 if (f_Document.LastPara = nil) then
  OpenParagraph;
end;

function TddHTMLReader.GetNewSubID: Integer;
begin
 Inc(f_NewSubID);
 Result := f_NewSubID;
end;

procedure TddHTMLReader.WorkupDel(aTag: TddHTMLTag);
begin
 if ApplyTextCorrections then
  if aTag.IsClosed then
   DecInDel
  else
   IncInDel;
end;

procedure TddHTMLReader.DeletePara;
begin
 if IsData then
  f_Document.DeleteLastTextPara;
end;

procedure TddHTMLReader.DelTagsFinished;
begin
 f_CheckEmpty := True;
end;

procedure TddHTMLReader.WorkupSup(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  CloseSegment;
  f_CHP.Pos := cpNone;
 end // if aTag.IsClosed then
 else
 begin
  f_CHP.Pos := cpSuperScript;
  StartSegment;
 end;
end;

procedure TddHTMLReader.WorkupSub(aTag: TddHTMLTag);
begin
 if aTag.IsClosed then
 begin
  CloseSegment;
  f_CHP.Pos := cpNone;
 end // if aTag.IsClosed then
 else
 begin
  f_CHP.Pos := cpSubScript;
  StartSegment;
 end;
end;

procedure TddHTMLReader.CheckTextCaps;
var
 l_LastPara: TddTextParagraph;
begin
 l_LastPara := f_Document.LastPara;
 if l_LastPara <> nil then
 begin
  if f_CHP.Caps = ccAllCaps then
   l_LastPara.Text.MakeUpper
  else
   if f_CHP.Caps = ccSmallCaps then
    l_LastPara.Text.MakeLower;
 end; // if l_LastPara <> nil then
end;

end.
