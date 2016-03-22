//..........................................................................................................................................................................................................................................................
unit ddHTMLWriter;
{* Конвертация формата Эверест в HTML }


//$Id: ddHTMLWriter.pas,v 1.154 2016/03/09 13:32:37 dinishev Exp $

// $Log: ddHTMLWriter.pas,v $
// Revision 1.154  2016/03/09 13:32:37  dinishev
// Незакоммител.
//
// Revision 1.153  2016/03/03 12:21:54  dinishev
// {Requestlink:619321401}. Выкинул фактически неработающий код.
//
// Revision 1.152  2016/03/03 12:08:37  dinishev
// Выкинул никому не нужный функционал. Явно брошенный на пол-дороги.
//
// Revision 1.151  2015/08/28 08:14:48  dinishev
// {Requestlink:606129464}
//
// Revision 1.150  2015/06/05 14:33:19  dinishev
// {Requestlink:600665073}. Тест.
//
// Revision 1.149  2015/06/05 09:14:36  dinishev
// {Requestlink:600653825}
//
// Revision 1.148  2015/05/28 15:30:56  dinishev
// Убрал лишнее.
//
// Revision 1.147  2015/05/27 11:46:20  dinishev
// {Requestlink:600105637}
//
// Revision 1.146  2015/05/27 11:38:28  dinishev
// Cleanup
//
// Revision 1.145  2015/05/27 11:37:22  dinishev
// Cleanup
//
// Revision 1.144  2015/05/27 11:24:03  dinishev
// Cleanup
//
// Revision 1.143  2015/05/27 11:16:24  dinishev
// Cleanup
//
// Revision 1.141  2015/05/27 10:53:45  dinishev
// Cleanup
//
// Revision 1.139  2015/05/27 08:32:35  dinishev
// Cleanup
//
// Revision 1.137  2015/05/27 08:11:09  dinishev
// Cleanup
//
// Revision 1.135  2015/05/13 05:51:38  dinishev
// Заменил символы на константы.
//
// Revision 1.134  2015/05/12 13:49:27  dinishev
// Bug fix: выливали '\', если не было задано имя теста.
//
// Revision 1.133  2015/05/08 12:40:41  dinishev
// {Requestlink:598615356} Чистка кода.
//
// Revision 1.132  2015/05/07 14:22:20  dinishev
// {Requestlink:598615356}
//
// Revision 1.131  2015/04/08 12:25:00  dinishev
// Исправил хитрые зависимости между модулями.
//
// Revision 1.130  2015/03/25 10:54:03  dinishev
// {Requestlink:592251812}
//
// Revision 1.129  2015/02/24 14:07:28  dinishev
// {Requestlink:589529446}
//
// Revision 1.128  2015/02/10 13:21:10  dinishev
// {Requestlink:588037744}
//
// Revision 1.127  2015/01/29 11:30:30  fireton
// - не работал SetTo
//
// Revision 1.126  2014/09/10 07:29:30  dinishev
// Не записываем имя приложения в тестовый HTML.
//
// Revision 1.125  2014/07/15 06:03:40  dinishev
// {Requestlink:553919980}. Прячем невидимые линии для LibreOffice, на сколько это возможно.
//
// Revision 1.124  2014/07/11 11:01:38  dinishev
// {Requestlink:553914086}. Правка по горячим следам - получались испорченные rtf.
//
// Revision 1.123  2014/07/08 09:11:45  dinishev
// {Requestlink:552601541}
//
// Revision 1.122  2014/07/08 07:42:54  dinishev
// {Requestlink:552601541}
//
// Revision 1.121  2014/07/07 11:57:17  dinishev
// Reformat
//
// Revision 1.120  2014/07/02 12:01:30  dinishev
// {Requestlink:390585479}. Общие отступы для одинаковых стилей, правильное оформление стиля 'Формула'
//
// Revision 1.119  2014/07/02 06:40:06  dinishev
// {Requestlink:390585479}
//
// Revision 1.118  2014/07/01 13:22:50  dinishev
// {Requestlink:390585479}
//
// Revision 1.117  2014/07/01 05:30:37  dinishev
// {Requestlink:390585479}
//
// Revision 1.116  2014/05/22 12:58:21  dinishev
// {Requestlink:534790284}
//
// Revision 1.115  2014/04/15 10:42:03  dinishev
// {Requestlink:528446913}
//
// Revision 1.114  2014/03/31 10:06:54  dinishev
// {Requestlink:517781076}
//
// Revision 1.113  2014/03/27 14:20:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.112  2014/03/14 05:32:22  dinishev
// Не записываем данные о генераторе в эталон.
//
// Revision 1.111  2014/02/19 09:37:21  dinishev
// {Requestlink:481811059}. Очистка списка с путями к картинкам.
//
// Revision 1.110  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.109  2014/02/10 12:15:34  dinishev
// {Requestlink:481811059}
//
// Revision 1.108  2014/02/07 10:46:53  dinishev
// Чистка кода.
//
// Revision 1.107  2014/02/07 10:28:36  dinishev
// Чистка кода.
//
// Revision 1.105  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.104  2013/10/24 11:03:16  dinishev
// {Requestlink:483394869}
//
// Revision 1.103  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.102  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.101  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.100  2013/10/15 12:59:56  dinishev
// {Requestlink:492616334}
//
// Revision 1.99  2013/09/11 13:01:18  dinishev
// Убираем заточку для тестов - будет сделано по другому.
//
// Revision 1.98  2013/09/05 12:15:52  dinishev
// {Requestlink:481440106}
//
// Revision 1.97  2013/08/28 07:55:21  dinishev
// {Requestlink:479944898}
//
// Revision 1.96  2013/08/26 09:37:34  dinishev
// {Requestlink:479402974}
//
// Revision 1.95  2013/08/15 11:16:37  dinishev
// {Requestlink:476808666}
//
// Revision 1.94  2013/07/19 13:55:41  dinishev
// {Requestlink:466752604}. Теперь текстовый параграф сам умеет проверять и выливать номер.
//
// Revision 1.93  2013/05/14 11:13:19  dinishev
// {Requestlink:453164226}. Потихоньку переносим логику работы с таблицей из TdestNorm - не место ей там в TddTable.
//
// Revision 1.92  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.91  2013/03/04 13:03:14  narry
// Уменьшается шрифт текста при экспорте в HTML (429695536)
//
// Revision 1.90  2013/03/01 08:11:25  narry
// Уменьшается шрифт текста при экспорте в HTML (429695536)
//
// Revision 1.89  2013/01/24 06:55:32  narry
// Поддержка нумерованных абзацев (пока не работает)
//
// Revision 1.88  2013/01/22 12:33:38  narry
// Рефакторинг RTFReader
//
// Revision 1.86  2012/10/23 12:55:00  narry
// Теряются картинки, встроенные в параграф, при сохранении в файл (397290823)
//
// Revision 1.85  2012/02/09 09:01:17  narry
// Не сохраняется размер шрифта заголовков при экспорте в HTML (251339809)
//
// Revision 1.84  2012/01/19 10:30:49  narry
// Неправильно формируются отступы при сохранении в htm-файл (244711455)
//
// Revision 1.83  2011/11/18 08:00:57  narry
// Формулы экспортируются без отступа внутри таблицы (235055757)
//
// Revision 1.82  2010/12/21 12:07:06  lulin
// {RequestLink:245208822}.
//
// Revision 1.81  2010/12/16 11:18:07  narry
// 245208822. Экспортируются нерабочие ссылки в htm-файл
//
// Revision 1.80  2010/12/16 10:23:26  narry
// 245208822. Экспортируются нерабочие ссылки в htm-файл
//
// Revision 1.79  2010/09/13 08:18:47  narry
// K235046999. AV
//
// Revision 1.78  2010/07/13 11:52:46  narry
// - К121164205
//
// Revision 1.77  2010/07/13 11:38:13  narry
// - К121164205
//
// Revision 1.75  2010/03/15 18:08:41  lulin
// {RequestLink:196969151}.
//
// Revision 1.74  2010/03/15 16:17:06  lulin
// {RequestLink:196969151}.                                                        e
//
// Revision 1.73  2010/02/24 11:16:55  lulin
// {RequestLink:192643281}.
//
// Revision 1.72  2010/02/18 08:16:10  narry
// - не закрывался сегмент
//
// Revision 1.71  2009/04/09 15:08:18  lulin
// [$140280550]. Выкидываем мусор.
//
// Revision 1.70  2009/03/04 13:33:06  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.69  2009/02/17 12:53:21  narry
// - толстая линия, отделяющая документ от справки
//
// Revision 1.68  2008/08/19 12:00:07  narry
// - Терялось оформление текста
//
// Revision 1.67  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.66  2008/03/21 14:09:21  lulin
// - cleanup.
//
// Revision 1.65  2008/03/20 09:48:29  lulin
// - cleanup.
//
// Revision 1.64  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.63  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.62  2008/02/07 19:13:09  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.61  2008/02/07 14:44:37  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.60  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.59  2008/02/05 09:57:59  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.58  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.57  2007/10/23 05:52:38  narry
// - исправление ошибки получения номера цвета
//
// Revision 1.56  2007/08/21 12:43:29  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.55  2007/08/09 18:05:21  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.54  2007/02/12 16:40:34  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.53  2007/01/29 11:37:49  narry
// - чистка мусора от "продолжения ссылки"
//
// Revision 1.52  2007/01/19 14:35:22  oman
// - new: Локализация библиотек - dd (cq24078)
//
// Revision 1.51  2006/11/27 15:57:10  narry
// - экспорт в XML для nalog.ru
//
// Revision 1.50  2006/11/17 14:15:13  lulin
// - cleanup.
//
// Revision 1.49  2006/11/17 14:07:03  lulin
// - cleanup.
//
// Revision 1.48  2006/11/17 13:36:11  lulin
// - очищаем ссылки при освобождении объектов.
//
// Revision 1.47  2006/10/11 12:54:18  narry
// - исправление полей и отступов
//
// Revision 1.46  2006/09/04 13:49:28  narry
// - коррекция отступов абзаца
//
// Revision 1.45  2006/07/28 12:30:00  narry
// - коррекция стиля первого заголовка
//
// Revision 1.44  2006/07/20 06:24:15  narry
// - пустые абзацы оформляются как pre
//
// Revision 1.43  2006/07/20 06:12:42  narry
// - обновление
//
// Revision 1.42  2006/07/18 14:08:42  narry
// - исправление: не закрывались ссылки в оглавлении
//
// Revision 1.41  2006/05/06 13:37:09  narry
// - заточки под Прайм, починка таблиц
//
// Revision 1.40  2006/04/25 12:47:47  lulin
// - cleanup.
//
// Revision 1.39  2006/04/12 10:59:08  narry
// - изменение: формирование более корректного оформления для абазца по умолчанию
//
// Revision 1.38  2006/02/26 11:04:49  narry
// - исправление: неуместно создавался элемент списка
//
// Revision 1.37  2006/02/22 08:58:11  narry
// - исправление: ошибки экспорта списков
//
// Revision 1.36  2006/02/13 14:12:46  narry
// - обновление: корректный эспорт списков
//
// Revision 1.35  2006/02/11 11:12:33  narry
// - исправление: неправильно форматировался стиль "Заголовок статьи"
//
// Revision 1.34  2006/02/10 10:08:07  narry
// - исправление: абзацы по умоланию имели отступ красной строки
//
// Revision 1.33  2006/02/09 14:18:03  narry
// - исправление: корректная выливка символов <>
//
// Revision 1.32  2005/12/09 15:28:50  narry
// - ошибка: неправильное оформление центрированных абзацев
//
// Revision 1.31  2005/12/01 11:43:30  narry
// - исправление: перерассчет выравнивания и отступов абзаца
//
// Revision 1.30  2005/10/03 14:05:43  narry
// - исправление: генерация имени файла картинки не включает путь к файлу
//
// Revision 1.29  2005/07/14 15:49:10  narry
// - new property: NeedStyleSheet
//
// Revision 1.28  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.27  2004/10/19 12:06:44  narry
// - update: поддержка перечеркнутого текста
//
// Revision 1.26  2004/10/12 10:51:29  narry
// - bug fix: неполная таблица стилей приводила к исчезновению оформления
//
// Revision 1.25  2004/10/08 14:44:52  narry
// - update: поддержка "резиновой" SBS-таблицы
//
// Revision 1.24  2004/09/24 13:29:06  narry
// - update: горизонтальные линии до или после абзаца
//
// Revision 1.23  2004/09/21 15:19:10  fireton
// - bug fix: лишний раз прописывался шрифт в стиль
//
// Revision 1.22  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.21  2004/09/16 12:22:09  narry
// - bug fix: "разъезжание" оформления
// - bug fix: неровная правая граница таблицы из псевдографики
//
// Revision 1.20  2004/09/16 10:19:27  narry
// - update: перенос механизма фильтрации внешних ссылок на предка
//
// Revision 1.19  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.18  2004/04/16 13:48:46  narry
// - bug fix: спецсимвол не завершался ';'
//
// Revision 1.17  2004/04/15 14:38:39  narry
// - new property: _OneStep - генерация внешних форматов в один проход
//
// Revision 1.16  2004/04/09 12:18:07  narry
// - new: преобразование форматов картинок, не поддерживаемых HTML в jpg
//
// Revision 1.15  2004/03/19 11:18:04  narry
// - bug fix: AV при преобразовании таблицы
//
// Revision 1.14  2004/01/21 16:13:43  narry
// - bug fix: лишнее подчеркивание, неправильное выравнивание, "мертвые" ссылки
// - update
//
// Revision 1.13  2004/01/16 10:12:06  narry
// - change: вместо добавления ссылки на картинку в документ вставляеься сама картинка
//
// Revision 1.12  2004/01/12 09:23:02  narry
// - bug fix: отсутствие номера документа (0) в ссылке считалось  номером внешнего документа
// - bug fix: неверно формировалось имя файла для множественных ссылок
//
// Revision 1.11  2004/01/09 15:01:31  narry
// - bug fix
//
// Revision 1.10  2003/12/30 11:01:23  narry
// - new: сохранение картинок, вложенных в документ, в отдельные файлы и создание ссылок на них
// - fixed: сегменты, оформленные стилем абзаца, получают оформление стиля, а не ссылку на него
//
// Revision 1.9  2003/12/29 12:07:45  narry
// - change: для уменьшения путаницы переименованы методы доступа к сегментам по индексу символа
//
// Revision 1.8  2003/12/23 17:01:16  narry
// - update: улучшение алгоритма наследования стилей
// - add: сохранение вертикального выравнивания ячеек таблицы
//
// Revision 1.7  2003/11/06 15:16:49  narry
// - new: первый шаг в сторону сохранения "мультиссылок"
//
// Revision 1.6  2003/11/06 11:53:46  narry
// - new: короткое название документа сохраняется как <TITLE>
//
// Revision 1.5  2003/09/16 12:04:24  narry
// - bug fix: Index of bounds при преобразовании текста в таблицу
//
// Revision 1.4  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.3  2002/07/03 09:00:57  narry
// - update, cleanup и new behavior
//
// Revision 1.2.2.1  2002/06/21 09:28:08  narry
// - not ready
//
// Revision 1.2  2002/06/06 11:10:45  narry
// - update: добавлены флаги $Id и $Log
//

{$Include ddDefine.inc }

interface

Uses
 Classes,
 ddDocument, ddBase, ddRTFProperties,
 l3Base, l3Types,
 k2Prim,
 k2TagGen,
 l3LongintList,
 l3ObjectRefList
 , l3VCLStrings, ddCharacterProperty, ddParagraphProperty, ddTextParagraph, ddTypes,
 ddTable, ddTableRow, ddDocumentAtom, ddBreak, ddPicture, ddTextSegment,

 l3Variant
 ;

type
  TddHTMLGenerator = class(TddDocumentGenerator)
  private
    f_AACBackColor: AnsiString;
    FNeedStyleSheet: Boolean;
    f_DivPreOpened: Boolean;
    f_IsAnno: Boolean;
    f_IsComplexTable: Boolean;
    f_IsEtalonRow: Boolean;
    f_isFirstHeader: Boolean;
    f_IsPrime: Boolean;
    f_Link: AnsiString;
    f_LinkStart: Boolean;
    f_LinkStop: Boolean;
    f_ListLevel: Integer;
    f_PictureNumber: Integer;
    f_ListIndents: Tl3LongintList;
    f_WriteFirstHyperlink: Boolean;
  private
    procedure CheckBullet(const aPara: TddTextParagraph);
    procedure CheckDiv(const aPara: TddTextParagraph);
    procedure CheckCloseDiv(const aPara: TddTextParagraph);
    procedure CheckSubsList(const aPara: TddTextParagraph);
    procedure CheckTopBorder(const aPara: TddTextParagraph);
    function EmtpyPara(const aPara: TddTextParagraph): Boolean;
    procedure CheckPre(const aPara: TddTextParagraph);
    procedure CheckStartStyleSegment(const aPara: TddTextParagraph; anIndex: Integer);
    procedure CheckStartHyperlink(const aPara: TddTextParagraph; anIndex: Integer; const aText: Tl3String; aStartIndex: Integer);
    function CheckObjectSegment(const aPara: TddTextParagraph; anIndex: Integer): Boolean;
    procedure WriteChar(const aPara: TddTextParagraph; anIndex: Integer; const aText: Tl3String);
    procedure CheckStopHyperlink(const aPara: TddTextParagraph; anIndex: Integer; aTextLen: Integer; aStopIndex: Integer);
    procedure CheckStopStyleSegment(const aPara: TddTextParagraph; anIndex: Integer);
    procedure CheckLinkContinue;
    procedure CheckBottomBorder(const aPara: TddTextParagraph);
    procedure CheckFirstHeader(const aPara: TddTextParagraph);
    procedure AddStyleProperty(PropertyList: Tl3ObjectRefList; const aProperty, aParam,
            aFlag: AnsiString);
    function CHP2HTML(aCHP: TddCHaracterProperty; StopTag: Boolean; const
            aList: Tl3ObjectRefList = nil): AnsiString;
    procedure pm_SetWriteFirstHyperlink(const Value: Boolean);
    procedure CloseDivPre;
    procedure CloseList(AllLevels: Boolean);
    function InchStr(aInch: Integer): AnsiString;
    function MakePictureName: AnsiString;
    procedure OpenDivPre;
    procedure OpenList(aLeftIndent: Integer);
    function pm_GetListLeftIndent: Integer;
    function pm_GetListOpened: Boolean;
    procedure pm_SetIsPrime(const Value: Boolean);
    procedure pm_SetListLeftIndent(const Value: Integer);
    function Style2HTML(aStyle: TddStyleEntry; const aList: Tl3ObjectRefList = nil):
            AnsiString;
    function AddAACStyleBackColor(aStyleID: Integer): AnsiString;
  protected
    procedure AddTag(TagList: Tl3ObjectRefList; const aTag, aParam: AnsiString);
    procedure Cleanup; override;
    function GetFormat(TagList: Tl3ObjectRefList; StopTag: Boolean): AnsiString;
    function PAP2HTML(aPAP: TddPAragraphProperty; StopTag: Boolean; const aList:
        Tl3ObjectRefList = nil): AnsiString; virtual;
    function StyleName(StyleID: Integer; var IsSpecial: Boolean): AnsiString; virtual;
    procedure WriteBreak(const aBreak: TddBreak); override;
    procedure WriteColorTable(aDefault: Boolean = False); override;
    procedure WriteDocumentBody; override;
    procedure WriteDocumentEnd; override;
    procedure WriteDocumentHeader; override;
    procedure WriteDocumentStart; override;
    procedure WriteFontTable(aDefault: Boolean = False); override;
    procedure WriteHeader(aDefault: Boolean = False); override;
    procedure WritePicture(const Picture: TddPicture; aWholePar: Boolean); override;
    procedure WriteStyleTable(aDefault: Boolean = False); override;
    procedure WriteTable(const Table: TddTable; aPart: Boolean); override;
    procedure WriteTableRow(const aRow: TddTableRow; anIndex: Integer; const aRowType: TddRowType = dd_rtNone; aRowPos: TddRowPosition = dd_rpNone); override;
    procedure WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False); override;
  public
    constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
    procedure StartChild(TypeID: Tl3VariantDef); override;
    property IsPrime: Boolean read f_IsPrime write pm_SetIsPrime;
    property ListLeftIndent: Integer read pm_GetListLeftIndent write
        pm_SetListLeftIndent;
    property NeedStyleSheet: Boolean read FNeedStyleSheet write FNeedStyleSheet;
    property ListOpened: Boolean read pm_GetListOpened;
    property WriteFirstHyperlink: Boolean read f_WriteFirstHyperlink write pm_SetWriteFirstHyperlink;
  end;

implementation
Uses
 RTFTypes,
 {$IFDEF Envision}
 ddPictDetector,
 {$ELSE}
 imageenio,
 {$ENDIF}

 SysUtils,
 Graphics,
 Math,
 StrUtils,

 k2Interfaces,
 k2Tags,
 k2Base,

 l3Chars,
 l3Stream,
 l3FileUtils,
 l3Filer,
 l3Const,
 l3String,
// l3BitmapContainer,
// l3MetafileContainer,
 l3InternalInterfaces,

 evdStyles,

 evParaTools,

 k2FileGenerator,

 AnnoTopic_Const,
 Document_Const,

 {$IFDEF InsiderTest}
 ddPicturePathListner,
 {$ENDIF InsiderTest}

 ddUtils,
 ddTableCell,
 ddCellProperty,
 ddObjectSegment,
 ddPictureSegment,
 ddFormulaSegment,
 ddHyperlinkTarget,
 ddHTMLWriterRes,

 evdTypes;

type
  THTMLTag = class(Tl3Base)
  private
    Param: AnsiString;
    Tag: AnsiString;
  public
    constructor Create(const aTag, aParam: AnsiString);
    reintroduce;
  end;
  
{
*********************************** THTMLTag ***********************************
}
constructor THTMLTag.Create(const aTag, aParam: AnsiString);
begin
  inherited Create;
  Tag:= aTag;
  Param:= aParam;
end;


{
******************************* TddHTMLGenerator *******************************
}
constructor TddHTMLGenerator.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
  inherited;
  f_ListIndents := Tl3LongintList.Make;
  FNeedStyleSheet := True;
  UseExternalLinks := false;
  f_WriteFirstHyperlink := False;
end;

procedure TddHTMLGenerator.AddStyleProperty(PropertyList: Tl3ObjectRefList; const
        aProperty, aParam, aFlag: AnsiString);
var
 i     : Integer;
 l_Tag : THTMLTag;
begin
 l_Tag := nil;
 if aProperty <> '' then
 begin
  for i:= 0 to PropertyList.Hi do
   if UpperCase(THTMLTag(PropertyList.Items[i]).Tag) = UpperCase(aProperty) then
   begin
    l_Tag := THTMLTag(PropertyList.Items[i]);
    Break;
   end; // if l_Text.Empty then
   if aFlag = '' then
   begin
    if l_Tag = nil then
    begin
     l_Tag := THTMLTag.Create(aProperty, aParam);
     try
      PropertyList.Add(l_Tag);
     finally
      l3Free(l_Tag);
     end;
    end // if l_Tag = nil then
    else
     l_Tag.Tag := aProperty;
   end // if aFlag = '' then
   else
   if l_Tag <> nil then
    PropertyList.Delete(PropertyList.IndexOf(l_Tag));
 end; // aTag <> ''
end;

procedure TddHTMLGenerator.AddTag(TagList: Tl3ObjectRefList; const aTag, aParam: AnsiString);
var
 i     : Integer;
 l_Tag : THTMLTag;
begin
 l_Tag := nil;
 if aTag <> '' then
 begin
  for i := 0 to TagList.Hi do
   if UpperCase(THTMLTag(TagList.Items[i]).Tag) = UpperCase(aTag) then
   begin
    l_Tag := THTMLTag(TagList.Items[i]);
    Break;
   end; // if UpperCase(THTMLTag(TagList.Items[i]).Tag) = UpperCase(aTag) then
   if l_Tag = nil then
   begin
    l_Tag := THTMLTag.Create(aTag, aParam);
    try
     TagList.Add(l_Tag);
    finally
     l3Free(l_Tag);
    end;
   end // if l_Tag = nil then
   else
   if Pos(UpperCase(aParam), UpperCase(THTMLTag(TagList.Items[i]).Param)) = 0 then
   begin
    if l_Tag.Param <> '' then
     l_Tag.Param := l_Tag.Param + ' ';
    l_Tag.Param := l_Tag.Param + aParam;
   end;
 end; // aTag <> ''
end;

function TddHTMLGenerator.CHP2HTML(aCHP: TddCHaracterProperty; StopTag: Boolean;
        const aList: Tl3ObjectRefList = nil): AnsiString;
var
  l_S, l_StyleName: AnsiString;
  l_IsSpecial: Boolean;
  l_List: Tl3ObjectRefList;

  procedure _CHP2HTML(CHP: TddCHaracterProperty);
  begin
   with CHP do
   begin
    case Pos of
     cpSubScript  : l_S:= 'sub';
     cpSuperScript: l_S:= 'sup';
    else
      l_S:= '';
    end; // Case Pos
    AddTag(l_List, l_s, '');
    if FColor <> propUndefined then
     with Document.ColorTable[Pred(FColor)] do
     AddTag(l_List, 'font', 'color=#'+IntToHex(Red, 2)+IntToHex(Green, 2)+IntToHex(Blue, 2));
    if Bold then
     AddTag(l_List, 'b', '');
    if Italic then
     AddTag(l_List, 'i', '');
    if not (Underline in [utNone, utNotDefined]) then
     AddTag(l_List, 'u', '');
    if Strikeout then
     AddTag(l_List, 'strike', '');
   end; // with CHP
  end;

begin
  Result := '';
  if aList = nil then
   l_List:= Tl3ObjectRefList.Make
  else
   l_List:= aList;
  try
   with aCHP do
   begin
    if Style <> 0 then
    begin
     l_StyleName:= StyleName(Style, l_IsSpecial);
     if not l_IsSpecial and (l_StyleName <> '') then
      AddTag(l_List, 'font', 'class="'+l_StyleName+'"')
     else
     if l_IsSpecial then
      _CHP2HTML(Document.StyleTable[Style].CHP)
    end
    else
     _CHP2HTML(aCHP);
   end; // Style = 0
   Result:= GetFormat(l_List, StopTag);
  finally
   if aList = nil then
    l3Free(l_List);
  end; // try..finally
end;

function TddHTMLGenerator.GetFormat(TagList: Tl3ObjectRefList; StopTag: Boolean): AnsiString;
var
 i: LongInt;
 l_Tag: THTMLTag;
begin
 Result := '';
 for i := 0 to TagList.Hi do
 begin
  l_Tag := THTMLTag(TagList.Items[i]);
  if l_Tag.Tag <> '' then
  begin
   if StopTag then
    Result := '</'+l_Tag.Tag + '>' + Result
   else
   begin
    Result := Result + '<' + l_Tag.Tag;
    if l_Tag.Param <> '' then
    begin
     if not AnsiEndsStr(' ', Result) then
      Result := Result + ' ';
     Result := Result + l_Tag.Param
    end; // l_Tag.Param <> ''
   end; // if StopTag
   if not StopTag then
    Result := Result + '>';
  end; // l_Tag.Tag <> ''
 end; // for i
end;

function TddHTMLGenerator.MakePictureName: AnsiString;
var
 l_OutDir: AnsiString;
begin
 l_OutDir := ExtractFileDir(FilerFilename);
 {$IFDEF InsiderTest}
 l_OutDir := GetOutputDirName4Test(l_OutDir, '', TddPicturePathListner.Instance.TestName);
 {$ENDIF InsiderTest}
 Result := Format('%s\pict%d-%d.picture', [l_OutDir,
                                         f_PictureNumber, ExtNumber]);
 Inc(f_PictureNumber);
end;

function TddHTMLGenerator.PAP2HTML(aPAP: TddPAragraphProperty; StopTag:
    Boolean; const aList: Tl3ObjectRefList = nil): AnsiString;
var
 l_Left      : Integer;
 l_List      : Tl3ObjectRefList;
 l_StyleName : AnsiString;
 l_IsSpecial : Boolean;
begin
  Result := '';
  if aList <> nil then
   l_List := aList
  else
   l_List := Tl3ObjectRefList.Make;
  try
   with aPAP do
   begin
    if (Style <> 0) and (Style <> propUndefined) then
    begin
     if IsPrime and (Style = ev_saNormalTable) then
      l_StyleName := ''
     else
      l_StyleName := StyleName(aPAP.Style, l_IsSpecial);

     if l_StyleName <> '' then
     begin
      if l_IsSpecial then
       AddTag(l_List, Format('%s', [l_StyleName]), '')
      else
      begin
       if (Just = justP) and not IsPrime then
        AddTag(l_List, 'pre', ''{'WIDTH=80'})
       else
       if Bullet = propUndefined then
        AddTag(l_List, 'p', Format('class="%s"', [l_StyleName]))
       else
        AddTag(l_List, 'li', '');
      end;
     end
     else
      AddTag(l_List, 'p', '');
    end //Style <> 0
    else
    begin
     if Bullet = propUndefined then
      AddTag(l_List, 'p', '')
     else
     if (Bullet <> propUndefined) then
     begin
      if StopTag then
       AddTag(l_List, '', '')
      else
       AddTag(l_List, 'li', '');
     end;
     if not IsPrime then
     begin
      Result := '' ;
      if (xaLeft <> propUndefined) and (xaLeft <> 0) then
       Result := Result + Format('margin-left : %s', [InchStr(xaLeft)]);
      if (xaRight <> propUndefined) and (xaRight <> 0) then
       Result := Result + Format('margin-right : %s', [InchStr(xaRight)]);
      { TODO -oДудко Дмитрий -cРазвитие : перерасчет отступа красной строки }
      if xaLeft <> propUndefined then
       l_Left := xaLeft
      else
       l_Left := 0;
      if (xaFirst <> propUndefined){ and (xaFirst <> 0) Зачем эта проверка ?} then
        Result := Result + Format('text-indent : %s', [InchStr(xaFirst)]);
      case JUST of
       justL: Result := Result + 'text-align=left;';
       justR: Result := Result + 'text-align=right;';
       justC: Result := Result + 'text-align=center;';
       justF: Result := Result + 'text-align=justify;';
      end; //case JUST
      if (Before <> propUndefined) and (Before <> 0) then
       Result := Result + Format('margin-top : %s', [InchStr(Before)]);
      if (After <> propUndefined) and (After <> 0) then
       Result := Result + Format('margin-bottom : %s', [InchStr(After)]);
      if Result <> '' then
       AddTag(l_List, 'p', 'style = "{' + Result + '}"')
      else
       AddTag(l_List, 'p', '');
     end;
    end;
   end; // with aPAP
   Result := GetFormat(l_List, StopTag);
  finally
   if aList = nil then
    l3Free(l_List);
  end; // try..finally
end;

procedure TddHTMLGenerator.Cleanup;
begin
 FreeAndNil(f_ListIndents);
 inherited;
end;

procedure TddHTMLGenerator.CloseDivPre;
begin
 if f_DivPreOpened then
 begin
  f_DivPreOpened := False;
  OutStringLn('</pre>');
 end;
end;

procedure TddHTMLGenerator.CloseList(AllLevels: Boolean);
begin
 if ListOpened then
 begin
  Dec(f_ListLevel);
  OutStringLn('</ul>');
  f_ListIndents.Delete(f_ListIndents.Hi);
  if AllLevels then
   while ListOpened do CloseList(False);
 end; // ListOpened
end;

function TddHTMLGenerator.InchStr(aInch: Integer): AnsiString;
begin
 Result := Format('%f in;', [aInch / 1440]);
 Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
end;

procedure TddHTMLGenerator.OpenDivPre;
begin
 if not f_DivPreOpened and IsPrime then
 begin
  f_DivPreOpened := True;
  OutStringLn('<pre>'); // условно
 end;
end;

procedure TddHTMLGenerator.OpenList(aLeftIndent: Integer);
var
 l_LI : Integer;
begin
 l_LI := IfThen(aLeftIndent = propUndefined, 0, aLeftIndent);
 if l_LI > ListLeftIndent then
 begin
  Inc(f_ListLevel);
  OutStringLn('<ul>');
  ListLeftIndent := l_LI;
 end
 else
 if l_LI < ListLeftIndent then
  CloseList(False);
end;

function TddHTMLGenerator.pm_GetListLeftIndent: Integer;
begin
 if f_ListIndents.Count > 0 then
  Result := f_ListIndents.Items[f_ListIndents.Hi]
 else
  Result := -1;
end;

function TddHTMLGenerator.pm_GetListOpened: Boolean;
begin
 Result := f_ListLevel > 0;
end;

procedure TddHTMLGenerator.pm_SetIsPrime(const Value: Boolean);
begin
 if f_IsPrime <> Value then
 begin
  f_IsPrime := Value;
  if IsPrime then
  begin
   NeedStyleSheet := False;
  end;
 end;
end;

procedure TddHTMLGenerator.pm_SetListLeftIndent(const Value: Integer);
begin
 f_ListIndents.Add(Value);
end;

procedure TddHTMLGenerator.StartChild(TypeID: Tl3VariantDef);
var
 l_TT : Tk2Type;
begin
 inherited;
 l_TT := CurrentType;
 if l_TT.IsKindOf(k2_typAnnoTopic) and f_IsPrime then
  f_IsAnno := True
 else
 if l_TT.IsKindOf(k2_typDocument) then
 begin
  f_IsFirstHeader := True;
  f_IsAnno := False;
  {$IFDEF InsiderTest}
  if TddPicturePathListner.Exists then
   TddPicturePathListner.Instance.Clear;
  {$ENDIF InsiderTest}
 end // if l_TT.IsKindOf(k2_typDocument) then
end;

function TddHTMLGenerator.Style2HTML(aStyle: TddStyleEntry; const aList:
        Tl3ObjectRefList = nil): AnsiString;
var
 l_List: Tl3ObjectRefList;
 i: Integer;
 l_Left: Integer;
 l_PAP, l_DiffPAP: TddParagraphProperty;
 l_CHP, l_DiffCHP: TddCharacterProperty;
begin
 // Нужно раскручивать всю цепочку до первого предка, иначе теряется унаследованное оформление
 l_PAP := TddParagraphProperty.Create;
 try
  l_CHP := TddCharacterProperty.Create;
  try
   Document.MakeStyleParent(aStyle.BasedOn, l_PAP, l_CHP);
   l_DiffPAP := aStyle.PAP.Clone();
   try
    l_DiffPAP.JoinWith(l_PAP);
    l_DiffCHP := aStyle.CHP.Clone;
     try
      l_DiffCHP.JoinWith(l_CHP);
      if aList = nil then
       l_List := Tl3ObjectRefList.Make
      else
       l_List := aList;
      try
       with l_DiffCHP do
       begin
        if Bold then
         AddStyleProperty(l_List, 'font-weight:','Bold;', '');
        if not (Underline in [utNone, utNotDefined]) then
         AddStyleProperty(l_List, 'text-decoration:', 'underline;', '');
        if Italic then
         AddStyleProperty(l_List, 'font-style:', 'Italic;', '')
        else
         AddStyleProperty(l_List, 'font-style:', 'Italic;', '1');
         //case Caps of
         // ccAllCaps
         // ccSmallCapstext-transform:  property Caps: TCharCapsType
        if Hidden then
        with Document.ColorTable[Document.AddColor(clGray)] do
          AddStyleProperty(l_List, 'background-color:',
                           Format( '#%s%s%s;', [IntToHex(Red, 2),
                                                IntToHex(Green, 2),
                                                IntToHex(Blue, 2)]), '');

        if Abs(Highlight) <> propUndefined then
        with Document.ColorTable[Pred(Highlight)] do
          AddStyleProperty(l_List, 'background-color:',
                           Format( '#%s%s%s;', [IntToHex(Red, 2),
                                                IntToHex(Green, 2),
                                                IntToHex(Blue, 2)]), '');

         //  property Deleted: Bool
         //  property CharScale: Longint
         //  property Subpos: Longint
         //  property Contour: TContourType
        if (Abs(FontNumber) <> propUndefined){ and (FontNumber <> 0)}then
         AddStyleProperty(l_List, 'font-family: ', Document.FontTable[FontNumber].AsString + ';', '');
        if Abs(FontSize) <> propUndefined then
         AddStyleProperty(l_List, 'font-size:', Format('%dpt;',[FontSize div 2]), '');
         //  property Language: Longint
        if Abs(FColor) <> propUndefined then
         with Document.ColorTable[Pred(FColor)] do
          AddStyleProperty(l_List, 'color:', Format('#%s%s%s;',
                                                    [IntToHex(Red, 2),
                                                     IntToHex(Green, 2),
                                                     IntToHex(Blue, 2)]), '');
        if Abs(BColor) <> propUndefined then
         with Document.ColorTable[Pred(BColor)] do
          AddStyleProperty(l_List, 'background-color:', Format('#%s%s%s;',
                                                               [IntToHex(Red, 2),
                                                                IntToHex(Green, 2),
                                                                IntToHex(Blue, 2)]), '');
        case Pos of
         cpSuperscript: AddStyleProperty(l_List, 'vertical-align:', 'sup;', '');
         cpSubScript:   AddStyleProperty(l_List, 'vertical-align:', 'sub;', '');
        end; // case Pos
        if Strikeout then
         AddStyleProperty(l_List, 'text-decoration:', 'line-through;', '');
       end; //with aStyle.CHP

       if aStyle.StyleDef = sdParagraph then
        with l_DiffPAP do
        begin
         AddStyleProperty(l_List, 'margin:', '0 in;', '');
          if (xaLeft <> propUndefined) and (xaLeft <> 0) then
           AddStyleProperty(l_List, 'margin-left:', InchStr(xaLeft), '');
          if (xaRight <> propUndefined) and (xaRight <> 0) then
           AddStyleProperty(l_List, 'margin-right:', InchStr(xaRight), '');
          if xaLeft <> propUndefined then
           l_Left := xaLeft
          else
           l_Left := 0;
          if (xaFirst <> propUndefined){ and (xaFirst <> 0) Зачем эта проверка ?} then
            AddStyleProperty(l_List, 'text-indent :', InchStr(xaFirst{+l_Left}), '');

         case Just of
          justL : AddStyleProperty(l_List, 'text-align:', 'left;', '');
          justR : AddStyleProperty(l_List, 'text-align:', 'right;', '');
          justC : AddStyleProperty(l_List, 'text-align:', 'center;', '');
          justF : AddStyleProperty(l_List, 'text-align:', 'justify;', '');
         end; // case Just
          //margin-top: Before: Integer
          //margin-bottom:  After : Integer
          //  property Border : TddBorder
        end; //with aStyle.PAP
       if aList = nil then
       begin
        Result:= '';
        for i:= 0 to l_List.Hi do
        begin
         Result:= Result + ThTMLTag(l_List.Items[i]).Tag + ' '+ ThTMLTag(l_List.Items[i]).Param;
         if i <> l_List.Hi then
          Result:= Result + #10;
        end;
       end; // aList = nil
      finally
       if aList = nil then
        l3Free(l_List);
      end; // l_List
     finally
      FreeAndNil(l_DiffCHP);
     end;
   finally
    FreeAndNil(l_DiffPAP);
   end;
  finally
   FreeAndNil(l_CHP);
  end;
 finally
  FreeAndNil(l_PAP);
 end;
end;

function TddHTMLGenerator.StyleName(StyleID: Integer; var IsSpecial: Boolean): AnsiString;
begin
  IsSpecial:= False;
 if IsPrime then
  case StyleID of
   ev_saTxtNormalANSI   :
    begin
     Result:= 'p'; {* - Нормальный. }
     IsSpecial:= True;
    end;
   ev_saTxtHeader1      :
    begin
     if IsPrime then
     begin
      if f_isFirstHeader then
       Result := 'h2'
      else
       Result := 'h3';
     end;
     IsSpecial:= True;
    end;
   ev_saHyperLink       :
    begin
     Result:= 'a'; {* - Гипертекстовая ссылка. }
     IsSpecial:= True;
    end;
   ev_saToLeft          : Result:= 'ToLeft'; {* - Прижатый влево. }
   ev_saNormalSBSLeft   : Result:= 'ToLeft'; {* - Нормальный для левых частей SBS. }
   ev_saNormalSBSRight  : Result:= 'ToRight'; {* - Нормальный для правых частей SBS. }
   ev_saHFLeft          : Result:= 'ToLeft';   {* - колонтитул (левый). }
   ev_saHFRight         : Result:= 'ToRight'   {* - колонтитул (правый). }
  else
   Result:= '';
  end // case StyleID
 else
  case StyleID of
   ev_saTxtNormalANSI   :
    begin
     Result:= 'p'; {* - Нормальный. }
     IsSpecial:= True;
    end;
   ev_saTxtNormalOEM    : Result:= 'NormalOEM'; {* - Нормальный (OEM). }
   ev_saTxtHeader1      :
    begin
     Result:= 'h1'; {* - Заголовок 1. }
     IsSpecial:= True;
    end;
   ev_saTxtHeader2      :
    begin
     Result:= 'h2'; {* - Заголовок 2. }
     IsSpecial:= True;
    end;
   ev_saTxtHeader3      :
    begin
     Result:= 'h3'; {* - Заголовок 3. }
     IsSpecial:= True;
    end;
   ev_saTxtHeader4      :
    begin
     Result:= 'h4'; {* - Заголовок 4. }
     IsSpecial:= True;
    end;
   ev_saTxtOutOfDate    : Result:= 'TxtOutOfDate'; {* - Утратил силу. }
   ev_saHyperLink       :
    begin
     Result:= 'a'; {* - Гипертекстовая ссылка. }
     IsSpecial:= True;
    end;
   ev_saTxtComment      : Result:= 'TxtComment'; {* - Комментарий. }
   ev_saColorSelection  : Result:= 'ColorSelection'; {* - Цветовое выделение. }
   ev_saHyperLinkCont   : Result:= 'HyperLinkCont'; {* - Продолжение ссылки. }
   ev_saANSIDOS         : Result:= 'ANSIDOS'; {* - Моноширинный. }
   ev_saFoundWords      : Result:= 'FoundWords'; {* - Найденные слова. }
   ev_saNormalNote      : Result:= 'NormalNote'; {* - Нормальный (справка). }
   ev_saArticleHeader   : Result:= 'ArticleHeader'; {* - Заголовок статьи. }
   ev_saToLeft          : Result:= 'ToLeft'; {* - Прижатый влево. }
   ev_saNormalTable     : Result:= 'NormalTable'; {* - Нормальный для таблиц. }
   ev_saNormalSBSLeft   : Result:= 'NormalSBSLeft'; {* - Нормальный для левых частей SBS. }
   ev_saNormalSBSRight  : Result:= 'NormalSBSRight'; {* - Нормальный для правых частей SBS. }
   ev_saNormalTableList : Result:= 'NormalTableList'; {* - нормальный для списков в виде таблиц. }
   ev_saTechComment     : Result:= 'TechComment'; {* - технический комментарий. }
   ev_saVersionInfo     : Result:= 'VersionInfo'; {* - информация о версии. }
   ev_saUserComment     : Result:= 'UserComment'; {* - комментарий пользователя (для Гаранта 6х). }
   ev_saContents        : Result:= 'Contents'; {* - оглавление (для Гаранта 6х). }
   ev_saNotApplied      : Result:= 'NotApplied'; {* - не вступил в силу. }
   ev_saDictEntry       : Result:= 'DictEntry'; {* - Словарная статья. }
   ev_saHFLeft          : Result:= 'HFLeft';   {* - колонтитул (левый). }
   ev_saHFRight         : Result:= 'HFRight'   {* - колонтитул (правый). }
  else
   Result:= '';
  end; // case StyleID
end;

procedure TddHTMLGenerator.WriteBreak(const aBreak: TddBreak);
begin
end;

procedure TddHTMLGenerator.WriteColorTable(aDefault: Boolean = False);
begin
end;

procedure TddHTMLGenerator.WriteDocumentBody;
begin
 if not f_IsAnno then
 begin
  OutStringLn('<body>');
  inherited WriteDocumentBody;
  OutStringLn('</body>');
 end;
end;

procedure TddHTMLGenerator.WriteDocumentEnd;
begin
 if not f_IsAnno then
 begin
  if IsPrime then
   OutStringLn('</div>')
  else
  begin
   OutStringLn('</body>');
   OutStringLn('</html>');
  end;
 end;
end;

procedure TddHTMLGenerator.WriteDocumentHeader;
begin
 inherited;
 if not f_IsAnno then
 begin
  if not IsPrime then
   OutStringLn('<body>');
  OutStringLn('<a name="0"></a>');
 end;
end;

procedure TddHTMLGenerator.WriteDocumentStart;
begin
 if not f_IsAnno then
 begin
  if IsPrime then
   OutStringLn('<div id="primeDocs">')
  else
   OutStringLn('<html>');
 end;
end;

procedure TddHTMLGenerator.WriteFontTable(aDefault: Boolean = False);
begin
end;

procedure TddHTMLGenerator.WriteHeader(aDefault: Boolean = False);
begin
 if not IsPrime then
 begin
  OutStringLn('<!doctype html public "-//w3c//dtd html 4.0 transitional//en">');
  OutStringLn('<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-'+IntToStr(CP_RussianWin)+'">');
  {$IFNDEF InsiderTest}
  OutStringLn('<META NAME="Generator" CONTENT="'+l3System.AppTitle+'">');
  {$ENDIF InsiderTest}
  OutStringLn('<HEAD>');
  OutString('<TITLE>');
  OutString(Document.Info.Title);
  OutStringLn('</TITLE>');
  OutStringLn('</HEAD>');
 end; // not IsPrime
end;

procedure TddHTMLGenerator.WritePicture(const Picture: TddPicture; aWholePar:
    Boolean);
var
  l_FileName, PS: ShortString;
  l_Stream: Tl3FileStream;
  l_Width: Integer;
begin
  {$IFDEF Envision}
  case Picture.Format of
    pictBMP  : PS:= '.bmp';
    pictICO  : exit;
    pictWMF  : PS:= '.wmf';
    pictTIFF : exit;
    pictPNG  : PS:= '.png';
    pictJPG  : PS:= '.jpg';
    pictTGA  : exit;
    pictPCX  : exit;
    pictGIF  : exit;
  else
   PS:= '.unknown';
  end; { Picture.Format }
  {$ELSE}
  case Picture.Format of
   ioGIF: PS:= '.gif';
   ioJPEG: PS:= '.jpg';
   {$ifdef IEINCLUDEPNG}
   ioPNG: PS:= '.png';
   {$endif}
  {$ENDIF}
  else
   with TImageEnIO.Create(nil) do
   try
    LoadFromStream(Picture.Stream);
    Picture.Stream.Seek(0, 0);
    PS:= '.jpg';
    SaveToStreamJpeg(Picture.Stream);
    Picture.Stream.Seek(0, 0);
   finally
    Free;
   end;
  end; { Picture.Format }
  l_FileName:= ChangeFileExt(MakePictureName, PS);
  {$IFDEF InsiderTest}
  TddPicturePathListner.Instance.AddPicturePath(l_FileName);
  {$ENDIF InsiderTest}
  l_Stream := Tl3FileStream.Create(l_FileName, l3_fmWrite);
  try
   Picture.IsBinary := True;
   l_Stream.CopyFrom(Picture.Stream, Picture.Stream.Size);
  finally
   l3Free(l_Stream);
  end;
  l_Filename := ExtractFileName(l_Filename);
  {$IFDEF InsiderTest}
  if TddPicturePathListner.Instance.TestName <> '' then
   l_Filename := TddPicturePathListner.Instance.TestName + '\' + l_Filename;
  {$ENDIF InsiderTest}
  OutStringLn(Format('<img src = "%s">', [l_Filename]));
  if IsPrime then
   OutStringLn('</img>');
end;

procedure TddHTMLGenerator.WriteStyleTable(aDefault: Boolean = False);
var
  i: Integer;
  l_Style: TddStyleEntry;
  l_StyleName: AnsiString;
  l_IsSpecial,
  l_NeedP: Boolean;
begin
 if NeedStyleSheet then
 begin
  OutStringLn('<style type="text/css">');
  OutStringLn('body {');
  l_Style:= Document.StyleTable[ev_saTxtNormalAnsi];
  if l_Style <> nil then
  begin
   OutStringLn(Style2HTML(l_Style));
   if l_Style.CHP.FontName = '' then
    OutStringLn('font-family : Arial;');
  end
  else
  begin
   OutStringLn('text-indent : 0.5 in; margin: 0; margin-left: 1 in; margin-right: 1 in;');
   OutStringLn('text-align:justify; font-family : Arial; font-size: 10pt;');
  end;
  OutStringLn('}');
  OutStringLn('pre {');
  OutStringLn('margin: 0; margin-left: 0 in;text-indent : 0 in;text-align: left;');
  OutStringLn('}');
  l_Style:= Document.StyleTable[ev_saNormalTable];
  if l_Style <> nil then
  begin
   OutStringLn('td {');
   OutStringLn(Style2HTML(l_Style));
   OutStringLn('font-family : Arial;');
   OutStringLn('}');
  end; // l_Style <> nil
  l_NeedP := True;
  for i:= 0 to Pred(Document.StyleCount) do
  begin
   l_Style:= Document.StyleSheet[i];
   if l_NeedP then
    l_NeedP := l_Style.Number <> ev_saTxtNormalANSI;
   l_StyleName:= StyleName(l_Style.Number, l_IsSpecial);
   if l_StyleName <> '' then
   begin
    if l_IsSpecial then
     OutStringLn(Format('%s {', [l_StyleName]))
    else
     OutStringLn(Format('.%s {', [l_StyleName]));
    OutStringLn(Style2HTML(l_Style));
    OutStringLn('}');
   end; // l_StyleName <> ''
  end; // for i
  if l_NeedP then
  begin
   OutStringLn('p {');
   OutStringLn('text-indent : 0.5 in; margin: 0;');
   OutStringLn('text-align:justify; font-family : Arial; font-size: 10pt');
   OutStringLn('}');
  end;
  // Ссылка
  (*
  OutStringLn('A:link { color : #008000; text-decoration: none}');
  OutStringLn('A:visited { color : #008000; text-decoration: none}');
  OutStringLn('A:hover { color : #008000; text-decoration: none}');
  *)
  OutStringLn('</style>');
 end;
end;

procedure TddHTMLGenerator.WriteTable(const Table: TddTable; aPart: Boolean);

 function lp_InitRowType: TddRowType;
 begin
  Result := TddRowType(Table.IsSBS);
  if (Result = dd_rtNone) and evAACStyle(Table.Style) then
  begin
   Result := dd_rtAAC;
   f_AACBackColor := AddAACStyleBackColor(Table.Style);
  end; // if (Result = dd_rtNone) and evAACStyle(Table.Style) then
 end;

var
 i       : Integer;
 l_Count : Integer;

 function lp_Index2RowPos: TddRowPosition;
 begin
  if i = 0 then
   Result := dd_rpFirst
  else
   if i = l_Count then
    Result := dd_rpLast
   else
    Result := dd_rpNone;
 end;

var
 j                : Integer;
 l_Row            : TddTableRow;
 l_RowType        : TddRowType;
 l_MaxCellCount   : Integer;
 l_EtalonRowIndex : Integer;
begin
 l_RowType := lp_InitRowType;
 if not Table.IsSBS then
 begin
  if (l_RowType = dd_rtAAC) then
   OutStringLn('<table cellspacing = "0">')
  else
   if IsPrime then
    OutStringLn('<table class="primeTab">')
   else
    OutStringLn('<table border="1">')
 end // if not Table.IsSBS then
 else
  OutStringLn('<table>');

 l_EtalonRowIndex := -1;
 l_MaxCellCount := 0;
 f_IsComplexTable := False;
 l_Count := Table.RowCount - 1;
 for i := 0 to l_Count do
 begin
  l_Row:= Table.Rows[i];
  if l_Row.CellCount > l_MaxCellCount then
  begin
   l_EtalonRowIndex:= i;
   l_MaxCellCount:= l_Row.CellCount;
  end; // l_Row.CellCount > l_MaxCellCount
  if not f_IsComplexTable then
   for j := 0 to Pred(l_Row.CellCount) do
    if l_Row.Cells[j].Props.VMerged or l_Row.Cells[j].Props.Merged or
       l_Row.Cells[j].Props.MergeFirst or l_Row.Cells[j].Props.VMergeFirst then
    begin
     f_IsComplexTable := True;
     Break;
    end;
 end; // for i
 f_IsComplexTable := f_IsComplexTable and (l_EtalonRowIndex > 0);
 for i := 0 to l_Count do
 begin
  f_IsEtalonRow := i = l_EtalonRowIndex;
  WriteTableRow(Table.Rows[i], i, l_RowType, lp_Index2RowPos);
 end;
 OutStringLn('</table>')
end;

procedure TddHTMLGenerator.WriteTableRow(const aRow: TddTableRow; anIndex: Integer; const aRowType: TddRowType = dd_rtNone;
    aRowPos: TddRowPosition = dd_rpNone);
var
 i, j: Integer;
 l_FillType: TddFillAAC;
 l_Cell: TddTableCell;
 l_CellProp: TddCellProperty;
 l_List: Tl3ObjectRefList;
 l_S: AnsiString;
 l_Atom : TddDocumentAtom;
begin
 l_List := Tl3ObjectRefList.Make;
 try
  OutStringLn(' <tr>');
  for i := 0 to Pred(aRow.CellCount) do
  begin
   l_List.Clear;
   l_CellProp:= aRow.Cells[i].Props;
   if not l_CellProp.VMerged then
   begin
    if aRowType = dd_rtSBS then
     if IsPrime then
      AddTag(l_List, 'td', 'width="50%"')
     else
      AddTag(l_List, 'td', 'width="400"')
    else
    if (aRowPos = dd_rpFirst) and (aRowType <> dd_rtAAC) then
     l_S := 'th'
    else
     l_S := 'td';
    AddTag(l_List, l_S, '');
    AddTag(l_List, l_S, 'VALIGN="TOP"');

    if not IsPrime {and (f_IsEtalonRow or f_IsComplexTable)} then
    // Почему абсолютные величины, а не проценты?
     AddTag(l_List, l_S, Format('width="%d"', [Round(l_CellProp.CellOffset / l3Inch * 96)]));

    if l_CellProp.RowSpan > 1 then
     AddTag(l_List, l_S, Format('rowspan="%d"', [l_CellProp.RowSpan]));
    if l_CellProp.CellSpan > 1 then
     AddTag(l_List, l_S, Format('colspan="%d"', [l_CellProp.CellSpan]));
    if aRowType = dd_rtAAC then
    begin
     l_FillType := NeedFillCell(aRow, aRowType, aRowPos);
     if (l_FillType = dd_faacDefColor) or (l_FillType = dd_faacDefColorWithoutLine) then
      AddTag(l_List, l_S, f_AACBackColor);
     AddTag(l_List, l_S, 'align="left"');
    end // if aRowType = dd_rtAAC then
    else
     if l_CellProp.PatternBackColor <> propUndefined then
      with Document.ColorTable[Pred(l_CellProp.PatternBackColor)] do
       AddTag(l_List, l_S, Format('bgcolor="#%s%s%s"', [IntToHex(Red, 2), IntToHex(Green, 2), IntToHex(Blue, 2)]));
    OutStringLn(GetFormat(l_List, False));

    l_Cell := aRow.Cells[i];
    for j := 0 to Pred(l_Cell.Count) do
    begin
     l_Atom := l_Cell.Items[j];
     if l_Atom.IsTextPara then
      WriteTextParagraph(TddTextParagraph(l_Atom))
     else
      if l_Atom.IsPicture then
       WritePicture(TddPicture(l_Atom), True)
      else
       if l_Atom.IsTable then
        WriteTable(TddTable(l_Atom), False);
    end;
    OutStringLn(GetFormat(l_List, True));
   end; // if not l_CellProps.VMerged
  end; // for i
  OutStringLn('</tr>');
 finally
  l3Free(l_List);
 end; // l_List
end;

procedure TddHTMLGenerator.WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False);
var
 l_Text      : Tl3String;
 l_TextLen   : Integer;
 l_StopIndex : Integer;
 l_StartIndex: Integer;

 procedure lp_InitTextParams;
 begin
  l_Text := Para.Text;
  if l_Text.Empty then
  begin
   OutString('&nbsp;');
   f_Link := '';
  end // if l_Text.Empty then
  else
   l_Text.CodePage := cp_ANSI;

  l_StartIndex := 0;
  l_TextLen := l_Text.Len - 1;
  while (l_Text.Ch[l_StartIndex] = cc_HardSpace) and (l_StartIndex <= l_TextLen) do
   Inc(l_StartIndex);
  l_StopIndex := l_TextLen;
  while (l_Text.Ch[l_StopIndex] = cc_HardSpace) and (l_StopIndex > 0) do
   Dec(l_StopIndex);
 end;

var
 i          : LongInt;
 l_WasObject: Boolean;
begin
 if not f_IsAnno then
 begin
  f_LinkStart := False;
  f_LinkStop := False;
  CheckBullet(Para);
  CheckDiv(Para);
  CheckSubsList(Para);
  CheckTopBorder(Para);
  if EmtpyPara(Para) then Exit;
  CheckPre(Para);
  lp_InitTextParams;
  for i := 0 to l_TextLen do
  begin
   l_WasObject := False;
   CheckStartStyleSegment(Para, i);
    // открываем ссылку
   CheckStartHyperlink(Para, i, l_Text, l_StartIndex);
   l_WasObject := CheckObjectSegment(Para, i);
   if not l_WasObject then
    WriteChar(Para, i, l_Text);
    // Закрываем ссылку
   CheckStopHyperlink(Para, i, l_TextLen, l_StopIndex);
   // закрываем сегмент
   CheckStopStyleSegment(Para, i);
  end;//for i       
  CheckCloseDiv(Para);
  OutEOL;
  CheckLinkContinue;
  CheckBottomBorder(Para);
  CheckFirstHeader(Para);
 end;
end;

function TddHTMLGenerator.AddAACStyleBackColor(aStyleID: Integer): AnsiString;
var
 l_PAP     : TddParagraphProperty;
 l_CHP     : TddCharacterProperty;
 l_Style   : TddStyleEntry;
 l_DiffCHP : TddCharacterProperty;
begin
 Result := '';
 l_Style := Document.StyleTable[aStyleID];
 l_PAP := TddParagraphProperty.Create;
 try
  l_CHP := TddCharacterProperty.Create;
  try
   Document.MakeStyleParent(l_Style.BasedOn, l_PAP, l_CHP);
   l_DiffCHP := l_Style.CHP.Clone;
   try
    l_DiffCHP.JoinWith(l_CHP);
    with l_DiffCHP do
     if Abs(Highlight) <> propUndefined then
      with Document.ColorTable[Pred(Highlight)] do
       Result := Format('bgcolor = "#%s%s%s"', [IntToHex(Red, 2), IntToHex(Green, 2), IntToHex(Blue, 2)]);
   finally
    FreeAndNil(l_DiffCHP);
   end;
  finally
   FreeAndNil(l_CHP);
  end;
 finally
  FreeAndNil(l_PAP);
 end;
end;

procedure TddHTMLGenerator.CheckBullet(const aPara: TddTextParagraph);
begin
 if aPara.PAP.Bullet <> propUndefined then
  OpenList(aPara.PAP.xaLeft)
 else
  CloseList(True);
end;

procedure TddHTMLGenerator.CheckDiv(const aPara: TddTextParagraph);
begin
 if not aPara.PAP.InTable and IsPrime then
 begin
  if (aPara.PAP.Just = justP) and not aPara.Empty then
   OpenDivPre
  else
   CloseDivPre;
 end; // not Para.PAP.InTable
end;

procedure TddHTMLGenerator.CheckSubsList(const aPara: TddTextParagraph);
var
 i: Integer;
begin
 if (aPara.SubList.Count > 1) then
  for i := 0 to aPara.SubList.Hi do
   OutStringLn(Format('<a name="%d"></a>', [aPara.SubList[i].ID]))
 else
  if (aPara.SubList.Count = 1) and (IsPrime and (aPara.Empty or f_DivPreOpened)) then
   OutStringLn(Format('<p id="%d"></p>', [aPara.SubList[0].ID]));
end;

procedure TddHTMLGenerator.CheckTopBorder(const aPara: TddTextParagraph);
begin
 if aPara.PAP.Border.Frames[bpTop].Enable then
 begin
  if IsPrime then
   OutString(Format('<hr noshade size="%d" />', [aPara.PAP.Border.FrameWidth[bpTop] div 10 + 1]))
  else
   OutString('<hr>');
 end;
end;

procedure TddHTMLGenerator.CheckPre(const aPara: TddTextParagraph);
var
 l_List    : Tl3ObjectRefList;
 l_Style   : TddStyleEntry;
 l_EvdStyle: Integer;
begin
 if not f_DivPreOpened and not (IsPrime and aPara.PAP.InTable) then
 begin
  l_List := Tl3ObjectRefList.Make;
  try
   if aPara.Empty then
    AddTag(l_List, 'pre', '')
   else
   begin
    l_EvdStyle := Min(aPara.PAP.Style, aPara.Chp.Style);
    l_Style := Document.StyleTable[l_EvdStyle];
    if l_Style <> nil then
    begin
     // Оформление абзаца
     l_Style.PAP.Style := l_EvdStyle;
     PAP2HTML(l_Style.PAP, False, l_List);
    end; // if l_Style <> nil then
   end;
   {$IFNDEF InsiderTest}
   if aPara.SubList.Count = 1 then
    AddTag(l_List, THTMLTag(l_List.Items[0]).Tag, Format('id="%d"', [aPara.SubList[0].ID]));
   {$ENDIF InsiderTest}
   OutString(GetFormat(l_List, False));
  finally
   l3Free(l_List);
  end;
 end; // not f_DivPreOpened
end;

function TddHTMLGenerator.EmtpyPara(
  const aPara: TddTextParagraph): Boolean;
begin
 Result := False;
 if IsPrime and aPara.Empty then
  if aPara.PAP.InTable then
   OutStringLn('&nbsp;')
  else
   Result := True;
end;

procedure TddHTMLGenerator.CheckStartStyleSegment(
  const aPara: TddTextParagraph; anIndex: Integer);
var
 l_Segment: TddTextSegment;
begin
 l_Segment := aPara.SegmentByCharIndex(anIndex);
 if (l_Segment <> nil) and (l_Segment.Start = anIndex) and
    ((aPara.SegmentByCharIndex(anIndex, True) = nil) or (l_Segment.Start = l_Segment.Stop)) then
 begin
  { Выводим начало оформления }
  if not ((l_Segment.CHP.Style = ev_saHyperLinkCont) and (f_Link = '')) then
   OutString(CHP2HTML(l_Segment.CHP, False));
  if (l_Segment.CHP.Style = ev_saHyperLinkCont) and (f_Link <> '') then
   OutString(f_Link);
 end; // (l_Segment <> nil) and (l_Segment.Start = anIndex)
end;

procedure TddHTMLGenerator.CheckStartHyperlink(
  const aPara: TddTextParagraph; anIndex: Integer; const aText: Tl3String; aStartIndex: Integer);
const
 csURLRef = '<a href="%s">';
 csInterlanRef = '<a href="#%d">';
 csExternalRef = '<a href=garantf1://%d.%d/>';
var
 l_DocID        : Integer;
 l_SubID        : Integer;
 l_TypeID       : Integer;
 l_Target       : TddHyperlinkTarget;
 l_LinkIndex    : Integer;
 l_LinkSegment  : TddTextSegment;
 l_HyperlinkText: AnsiString;
begin
 l_LinkSegment := aPara.HyperLinkByCharIndex(anIndex);
 if (l_LinkSegment <> nil) and (l_LinkSegment.Start = anIndex) and ((l_LinkSegment.TargetList.Count > 0) or not l_LinkSegment.URL.Empty) then
 begin
  l_HyperlinkText := '';
  if not l_LinkSegment.URL.Empty then
   l_HyperlinkText := Format(csURLRef, [l_LinkSegment.URL.AsString])
  else
  begin
   if not f_WriteFirstHyperlink and (l_LinkSegment.TargetList.Count > 1) then Exit;
   l_TypeID := l_LinkSegment.TargetList.First.TypeID;
   if (l_TypeID <> CI_REF) then
   begin
    l_DocID := l_LinkSegment.TargetList.First.DocID;
    l_SubID := l_LinkSegment.TargetList.First.SubID;
    if (l_DocID = ExtNumber) or (l_DocID = 0) then
     l_HyperlinkText := Format(csInterlanRef, [l_SubID])
    else
     if UseExternalLinks then
      l_HyperlinkText := Format(csExternalRef, [l_DocID, l_SubID]);
   end; // if l_LinkSegment.TargetList.First.TypeID <> CI_REF then
   OutString(l_HyperlinkText);
   if InRange(anIndex, 0, aStartIndex) then
   begin
    f_LinkStart := True;
    f_Link := l_HyperlinkText;
   end; // if anIndex = 0
  end;
 end; // l_LinkSegment <> nil
end;

function TddHTMLGenerator.CheckObjectSegment(const aPara: TddTextParagraph;
  anIndex: Integer): Boolean;
var
 l_ObjectSegment: TddTextSegment;
begin
 Result := False;
 l_ObjectSegment := aPara.ObjectByCharIndex(anIndex);
 if l_ObjectSegment <> nil then
 begin
  if l_ObjectSegment.IsObjectSegment then
  begin
   if l_ObjectSegment is TddPictureSegment then
    WritePicture(l_ObjectSegment.Data as TddPicture, False)
   else
    if l_ObjectSegment is TddFormulaSegment then
     WriteFormula(l_ObjectSegment, l_ObjectSegment.CHP, False);
   Result := True;
  end; // if l_ObjectSegment.ObjectType = dd_sotPicture then
 end; // l_ObjectSegment <> nil
end;

procedure TddHTMLGenerator.WriteChar(const aPara: TddTextParagraph;
  anIndex: Integer; const aText: Tl3String);
var
 l_Char: AnsiChar; 
begin
 l_Char := aText.Ch[anIndex];
 case l_Char of
  cc_Tab: OutString('&#9;');
  cc_SoftEnter:
    begin
     if IsPrime then
       OutString('<br />')
     else
      OutString('<br>');
    end;
  cc_Less : OutString('&lt;');
  cc_More : OutString('&gt;');
  cc_Ampersand : OutString('&amp;');
  cc_SingleQuote : OutString('&quot;');         {* - одинарная кавычка. }
  cc_DoubleQuote : OutString('&quot;');         {* - двойная кавычка. }
  cc_LSingleQuote: OutString('&quot;');         {* - открывающаяся одинарная кавычка. }
  cc_RSingleQuote: OutString('&quot;');         {* - закрывающаяся одинарная кавычка. }
  cc_LDoubleQuote: OutString('&ldquo;');         {* - открывающаяся двойная кавычка. }
  cc_RDoubleQuote: OutString('&rdquo;');         {* - закрывающаяся двойная кавычка. }
  cc_LTDoubleQuote: OutString('&laquo;');        {* - открывающаяся двойная треугольная кавычка. }
  cc_RTDoubleQuote: OutString('&raquo;');        {* - закрывающаяся двойная треугольная кавычка. }
 else
  begin
   if (aPara.PAP.Just <> justP) and (l_Char = cc_HardSpace) and ((anIndex = 0) or (aText.Ch[Pred(anIndex)] = cc_HardSpace)) then
    OutString('&nbsp;')
   else
    OutString(l_Char);
  end;
 end; // case l_Text.Ch[anIndex] of
end;

procedure TddHTMLGenerator.CheckStopHyperlink(
  const aPara: TddTextParagraph; anIndex: Integer; aTextLen: Integer; aStopIndex: Integer);
var
 l_LinkSegment: TddTextSegment;
begin
 l_LinkSegment := aPara.HyperLinkByCharIndex(anIndex, True);
 if (l_LinkSegment <> nil) and ((l_LinkSegment.TargetList.Count > 0) or not l_LinkSegment.URL.Empty) then
 begin
  if not l_LinkSegment.URL.Empty then
   OutString('</a>')
  else
   if l_LinkSegment.TargetList.First.TypeID <> CI_REF then
    if (l_LinkSegment.TargetList[0].DocID = ExtNumber) or (l_LinkSegment.TargetList[0].DocID = 0) or UseExternalLinks then
     OutString('</a>');
  if (anIndex = aTextLen) or (anIndex = aStopIndex) then
   f_LinkStop := True;
 end; // l_LinkSegment <> nil
end;

procedure TddHTMLGenerator.CheckStopStyleSegment(
  const aPara: TddTextParagraph; anIndex: Integer);
var
 l_StyleSegment: TddTextSegment;
begin
 l_StyleSegment := aPara.SegmentByCharIndex(anIndex, True);
 while (l_StyleSegment <> nil) do
 begin
  if (l_StyleSegment <> nil) then
  begin
    { Закрываем оформление }
   if l_StyleSegment.CHP.Style = ev_saHyperLinkCont then
    OutString('</a>');
   OutString(CHP2HTML(l_StyleSegment.CHP, True));
   l_StyleSegment := aPara.SegmentByCharIndex(anIndex, False, Pred(l_StyleSegment.Index));
   if (l_StyleSegment <> nil) and (l_StyleSegment.Start <> l_StyleSegment.Stop) then
   begin
    { Выводим начало оформления }
    if not ((l_StyleSegment.CHP.Style = ev_saHyperLinkCont) and (f_Link = '')) then
     OutString(CHP2HTML(l_StyleSegment.CHP, False));
    if (l_StyleSegment.CHP.Style = ev_saHyperLinkCont) and (f_Link <> '') then
     OutString(f_Link);
   end; // if (l_StyleSegment <> nil) and (l_StyleSegment.Start <> l_StyleSegment.Stop) then
  end; // l_StyleSegment <> nil) and (l_StyleSegment.Stop = anIndex
  if (l_StyleSegment <> nil) then
   l_StyleSegment := aPara.SegmentByCharIndex(anIndex, True, l_StyleSegment.Index);
 end;//while (l_StyleSegment <> nil)
end;

procedure TddHTMLGenerator.CheckCloseDiv(const aPara: TddTextParagraph);
var
 l_Style    : TddStyleEntry;
 l_EvdStyle : Integer;
begin
 if not f_DivPreOpened then
 begin
  if IsPrime and aPara.PAP.InTable then
   OutString(' ')
  else
  if aPara.Empty then
   OutString('</pre>')
  else
  begin
   l_EvdStyle := Min(aPara.PAP.Style, aPara.Chp.Style);
   l_Style := Document.StyleTable[l_EvdStyle];
   if l_Style <> nil then
   // Оформление абзаца
    OutString(PAP2HTML(l_Style.PAP, True))
   else
    OutString(PAP2HTML(aPara.PAP, True));
  end;
 end; // if not f_DivPreOpened then
end;

procedure TddHTMLGenerator.CheckLinkContinue;
begin
 if not (f_LinkStart and f_LinkStop) then
  f_Link := '';
end;

procedure TddHTMLGenerator.CheckBottomBorder(
  const aPara: TddTextParagraph);
begin
 if aPara.PAP.Border.Frames[bpBottom].Enable then
 begin
  if IsPrime then
   OutString('<hr />')
  else
   OutString('<hr>');
 end; // aPara.PAP.Border.Frames[bpBottom].Enable
end;

procedure TddHTMLGenerator.CheckFirstHeader(const aPara: TddTextParagraph);
begin
 if IsPrime and (aPara.PAP.Style = ev_saTxtHeader1) then
  f_IsFirstHeader := False;
end;

procedure TddHTMLGenerator.pm_SetWriteFirstHyperlink(const Value: Boolean);
begin
 f_WriteFirstHyperlink := Value;
end;

end.
