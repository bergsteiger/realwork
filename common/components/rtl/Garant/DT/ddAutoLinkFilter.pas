unit ddAutoLinkFilter;

{ $Id: ddAutoLinkFilter.pas,v 1.36 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: ddAutoLinkFilter.pas,v $
// Revision 1.36  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.35  2015/11/23 11:37:15  lukyanets
// Заготовки Renum
//
// Revision 1.34  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.33  2015/04/23 09:49:44  fireton
// - bugfix: ошибки, допущенные при переводе l_FoundNum на Il3CString
//
// Revision 1.32  2015/04/14 09:35:00  dinishev
// Bug fix: не компилировался CreateTestBase
//
// Revision 1.31  2015/04/13 17:40:59  lulin
// - перерисовываем.
//
// Revision 1.30  2015/04/13 16:44:27  lulin
// - перерисовываем.
//
// Revision 1.29  2015/04/07 11:55:52  fireton
// - AV при пустом номере дока
// - ошибка с фиксацией источника при поиске по коротким названиям
//
// Revision 1.28  2015/04/01 12:29:56  fireton
// - убрал отладочное
//
// Revision 1.27  2015/04/01 12:16:49  fireton
// - нормализуем номер документа
//
// Revision 1.26  2014/06/20 12:50:47  fireton
// - пилим автолинковщик на базовые классы
//
// Revision 1.25  2014/06/20 09:19:02  fireton
// - попытка выделить абстрактный класс
//
// Revision 1.24  2014/06/03 09:06:41  fireton
// - не ставились ссылки ([$540178525])
//
// Revision 1.23  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.22  2014/04/11 15:30:43  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.21  2014/04/08 17:13:23  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2014/04/07 06:53:34  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.19  2014/03/28 06:13:15  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.18  2014/03/25 14:31:49  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2014/03/18 10:49:33  fireton
// - корректно отслеживаем позицию в документе (K 521625290)
//
// Revision 1.16  2014/03/04 14:36:46  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.15  2013/11/19 10:07:17  fireton
// - Index Out Of Range в NeedStartBuffering
//
// Revision 1.14  2013/10/21 15:43:09  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.13  2013/10/21 10:30:56  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.12  2013/10/18 15:38:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.11  2013/08/08 10:33:09  fireton
// - логика на случай документов с кривой структурой, типа ПДД (K 429694402)
//
// Revision 1.10  2013/08/01 09:16:06  fireton
// - неиницилизированная локальная переменная (K 475476081)
//
// Revision 1.9  2013/07/31 10:32:28  fireton
// - поиск ссылок на произвольные документы (K 434754968)
//
// Revision 1.8  2013/04/25 03:56:21  fireton
// - нормализуем номер судебного дела
//
// Revision 1.7  2012/11/07 10:41:34  fireton
// - не ставим ссылки в технических комментариях
//
// Revision 1.6  2012/11/02 08:19:52  lulin
// - правим за Мишей.
//
// Revision 1.5  2012/11/01 09:42:41  lulin
// - забыл точку с запятой.
//
// Revision 1.4  2012/11/01 07:44:35  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.3  2012/10/31 18:38:14  kostitsin
// переименовал методы Notify на двух интерфейсах
//
// Revision 1.2  2012/10/18 06:51:54  narry
// Падало при несоблюдении формата входного файла
//
// Revision 1.1  2012/09/21 09:10:43  lulin
// - не собирался Немезис.
//
// Revision 1.70  2012/09/21 07:57:53  fireton
// - скрипты для работы с фильтрами и генераторами
//
// Revision 1.69  2012/09/11 03:54:04  fireton
// - по возможности берём ID Конституции из настроек (K 392171444)
//
// Revision 1.68  2012/09/10 09:08:51  fireton
// - стоп-слова для (пока) типов документов (K 392168042)
//
// Revision 1.67  2012/08/20 09:17:47  fireton
// - улучшенная диагностика ошибок (K 385484738)
//
// Revision 1.66  2012/03/19 06:33:20  fireton
// - убрал ненужное "исправление"
//
// Revision 1.65  2012/03/16 12:23:58  narry
// Падает простановщик ссылок (346758397)
//
// Revision 1.64  2012/03/16 08:37:06  fireton
// - иногда получали AV из-за неинициированных переменных
//
// Revision 1.63  2012/03/14 10:39:31  fireton
// - распознаём и ставим ссылки на ГОСТы
//
// Revision 1.62  2012/03/13 13:43:15  fireton
// - распознаём и ставим ссылки с учётом номера дела, к которому принадлежит документ
//
// Revision 1.61  2011/10/14 13:54:11  fireton
// - используем историю ранее найденных документов
//
// Revision 1.60  2011/10/12 13:13:40  fireton
// - рано положил нерабочую версию
//
// Revision 1.59  2011/10/12 13:06:12  fireton
// - TddAutolinkDocHistory
//
// Revision 1.58  2011/06/30 13:18:05  fireton
// - выделил TddEntryCollector в отдельный модуль
//
// Revision 1.57  2011/06/29 16:01:49  fireton
// - косметика
//
// Revision 1.56  2011/06/23 10:49:27  fireton
// - ограничение на 30 ссылок в цепочке оказалось недостаточным, сделал 200
// - плюс подстраховался от переполнения
//
// Revision 1.55  2011/06/10 11:52:40  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.54  2011/06/03 14:43:43  fireton
// - для одного кодекса может быть несколько аббревиатур
//
// Revision 1.53  2011/05/30 10:08:52  fireton
// - различаем кодексы по ключевым словам в абзаце
//
// Revision 1.52  2011/05/26 13:09:04  fireton
// - удаляем функционал "спорных статей"
//
// Revision 1.51  2011/05/19 14:10:26  fireton
// - не искались статьи в кодексах
//
// Revision 1.50  2011/05/13 14:31:53  fireton
// - слияние с веткой
//
// Revision 1.49.2.1  2011/05/06 12:26:10  fireton
// - двойной кэш автопростановщика
//
// Revision 1.49  2011/04/13 10:50:20  fireton
// - переводим простановку ссылок на внешние номера документов
//
// Revision 1.48  2011/04/11 10:25:01  narry
// Названия для ФАС (259885290)
//
// Revision 1.47  2011/04/04 06:41:54  fireton
// - переводим загрузку ФЗ на "умный" CSV
//
// Revision 1.46  2011/03/29 11:41:22  fireton
// - промежуточный коммит
//
// Revision 1.45  2011/03/15 14:38:12  fireton
// - класс переименовали
//
// Revision 1.44  2011/03/03 08:38:20  fireton
// - кэш структур для простановщика ссылок
//
// Revision 1.43  2011/03/01 13:23:02  fireton
// - кэш данных для простановщика ссылок
//
// Revision 1.42  2011/02/11 17:10:25  fireton
// - отпиливаем простановщик от основной базы
//
// Revision 1.41  2011/02/07 13:06:39  fireton
// - строим кэш федеральных законов с краткими именами
//
// Revision 1.40  2011/01/21 11:54:42  fireton
// - единый механизм поиска редакций для кодексов и всех других документов
//
// Revision 1.39  2011/01/17 14:46:59  fireton
// - держим кэш структур документов на диске и обновляем его по необходимости
//
// Revision 1.38  2010/12/29 11:32:56  fireton
// - не ставилась ссылка, если источники разделены "и"
//
// Revision 1.37  2010/12/06 13:41:57  fireton
// - фильтровали не по тому полю
//
// Revision 1.36  2010/11/23 15:48:25  fireton
// - неправильно оставлялись актуальные редакции
//
// Revision 1.35  2010/10/14 10:08:16  fireton
// - не ставилась ссылка, если после короткого имени шла дата
//
// Revision 1.34  2010/10/13 14:32:27  fireton
// - ищем нужные статьи в неактуальной редакции документа
//
// Revision 1.33  2010/10/11 11:26:39  narry
// K235872167
//
// Revision 1.32  2010/10/04 14:08:23  fireton
// - const перед Tl3WString и Il3CString
//
// Revision 1.31  2010/10/01 12:23:36  fireton
// - ставились ссылки не на тот кодекс
//
// Revision 1.30  2010/09/30 11:09:04  fireton
// - синонимы типов документов прописываются в настройках простановщика
//
// Revision 1.29  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.28  2010/09/23 11:30:53  fireton
// - все данные читаются из одного файла
// - не ставим ссылки на документы без источника, если их типа нет в списке
//
// Revision 1.27  2010/09/21 11:06:50  fireton
// - переводим деревья с PChar на Tl3WString
//
// Revision 1.26  2010/09/06 13:58:12  fireton
// - ставим ссылки только на актуальные редакции
//
// Revision 1.25  2010/09/06 13:30:59  fireton
// - не попадали в словарь короткие имена с редакциями
//
// Revision 1.24  2010/09/03 09:15:46  fireton
// - не распознавался неразрывный пробел
//
// Revision 1.23  2010/09/03 07:36:25  fireton
// - исправление недочётов
//
// Revision 1.22  2010/08/13 10:28:03  voba
// - k:229214076
//
// Revision 1.21  2010/08/04 08:30:15  voba
// - k: 229672814
//
// Revision 1.20  2010/07/20 13:28:57  fireton
// - переделка читалки CSV под filer
//
// Revision 1.19  2010/03/19 16:12:24  fireton
// - bug fix: не ставились ссылки на буквы в кавычках
//
// Revision 1.18  2010/03/17 10:04:23  fireton
// - учим простановщик в отдельных случаях ставить ссылки на перечисляемые документы
//
// Revision 1.17  2010/03/10 12:04:39  fireton
// - не ставим ссылки в комментариях юристов
//
// Revision 1.16  2010/03/02 13:03:54  fireton
// - опознаём номера из трёх чисел через точку
//
// Revision 1.15  2010/02/12 14:12:26  fireton
// - обнуляем последний найденный кодекс
//
// Revision 1.14  2010/02/05 14:18:29  fireton
// - не ищем по кейскоду, если он есть, но пустой
//
// Revision 1.13  2010/01/27 14:35:00  fireton
// - распознаём римские цифры в главах документов
//
// Revision 1.12  2010/01/26 13:39:03  fireton
// - более удобно управляем списком разрешённых источников
//
// Revision 1.11  2010/01/19 09:44:57  fireton
// - синоним: "Информационное письмо" = "Письмо"
//
// Revision 1.10  2010/01/18 10:50:01  fireton
// - bugfix: адреса через "и"
//
// Revision 1.9  2010/01/18 08:26:57  fireton
// - уточняем поиск с помощью номера судебного дела
//
// Revision 1.8  2010/01/15 07:52:49  fireton
// - обходим проблему с вложенными "пунктами" и "частями" статей
//
// Revision 1.7  2010/01/13 16:51:56  fireton
// - bug fix
//
// Revision 1.6  2010/01/13 13:40:23  fireton
// - возможность не использовать списки кодексов и ФЗ
// - возможность фильтровать по источнику
//
// Revision 1.5  2010/01/13 13:16:14  fireton
// - возможность не использовать списки кодексов и ФЗ
// - возможность фильтровать по источнику
//
// Revision 1.4  2010/01/12 12:00:27  fireton
// - "пункт" и "часть" теперь синонимы
// - ошибка с поиском кластера "адресов"
//
// Revision 1.3  2009/12/24 14:49:34  fireton
// - Уточнённая простановка ссылок
//
// Revision 1.2  2009/12/07 14:36:51  fireton
// - по умолчанию ссылки ставятся
//
// Revision 1.1  2009/12/04 09:01:10  fireton
// - исправление ошибок в линковке
//
// Revision 1.41  2009/11/16 15:44:41  fireton
// - перенос поиска кодексов в основной finder
//
// Revision 1.40  2009/11/10 10:32:16  dinishev
// Bug fix: не собирался Арчи в ветке
//
// Revision 1.39  2009/10/23 09:36:41  fireton
// - ускорение, благодаря сортировке списков
// - исправление Range Check Error
//
// Revision 1.38  2009/10/22 10:17:07  fireton
// - кэш для блокнеймов
//
// Revision 1.37  2009/10/16 12:38:28  narry
// - минимизация вывода в лог
//
// Revision 1.36  2009/10/16 10:09:22  fireton
// - более корректная обработка цепочек: каждый встреченный тип начинает новую цепочку реквизитов
//
// Revision 1.35  2009/10/15 14:15:50  fireton
// - ошибки в поиске и простановке ссылок
//
// Revision 1.34  2009/10/14 13:53:59  fireton
// - bug fix: ищем статьи правильно
//
// Revision 1.33  2009/10/13 08:55:35  fireton
// - простановка ссылок с помощью нового сканера
//
// Revision 1.32  2009/09/28 12:49:50  fireton
// - "настоящего кодекса..."
//
// Revision 1.31  2009/09/25 13:23:43  fireton
// - выделяем ссылкой только тип документа
//
// Revision 1.30  2009/09/23 07:38:41  fireton
// - более корректный поиск законов
//
// Revision 1.29  2009/09/22 12:43:56  fireton
// - не ставим ссылку, если статьи не найдены
// - не ставим ссылку на документы внутри кавычек
// - мелкие ошибки
//
// Revision 1.28  2009/09/18 10:36:57  fireton
// - не выделяем ссылкой все название документа
//
// Revision 1.27  2009/09/17 13:41:53  fireton
// - не ставим ссылки на аббревиатуры кодексов (только если "РФ")
//
// Revision 1.26  2009/09/17 12:39:54  voba
// - opt.  function lRecAccessProc
//
// Revision 1.25  2009/09/17 08:03:00  fireton
// - исправления в простановке ссылок
//
// Revision 1.24  2009/09/15 08:18:40  narry
// - запрет вывода в лог
//
// Revision 1.23  2009/09/11 13:26:07  voba
// - заменил использование ISabCursor на Tl3FieldSortRecList
//
// Revision 1.22  2009/09/11 11:18:17  narry
// - промежуточное обновление
//
// Revision 1.21  2009/09/02 14:31:33  lulin
// {RequestLink:161122154}.
//
// Revision 1.20  2009/08/28 15:22:08  fireton
// - исправление ошибок по горячим следам
//
// Revision 1.19  2009/08/27 16:16:52  fireton
// - простановка ссылок на законы
//
// Revision 1.18  2009/08/18 11:51:03  fireton
// - рефакторинг
//
// Revision 1.17  2009/08/06 15:59:54  fireton
// - рефакторинг
//
// Revision 1.16  2009/07/29 07:41:07  narry
// - вывод ссобщений об ошибках не только в лог
//
// Revision 1.15  2009/06/23 14:32:25  fireton
// - отслеживаем, чему принадлежит число в следующем звене
//
// Revision 1.14  2009/06/23 07:34:15  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.13  2009/06/22 14:48:42  fireton
// - выводим ошибки в лог
// - проверка на противоречивые топики
//
// Revision 1.12  2009/06/16 11:52:10  fireton
// - не принимаем "статью 30.1" за "статью 30"
//
// Revision 1.11  2009/06/11 11:01:36  fireton
// - bug fix: суффиксы не искались
// - теперь в tabl.csv чистые регулярные выражения
//
// Revision 1.10  2009/06/11 08:58:33  fireton
// - bug fix: дополнительно проверяем аббревиатуры (что они не принадлежат номеру документа, например)
// - bug fix: более корректно обрабатывем цепочку контекста
//
// Revision 1.9  2009/06/11 07:41:13  fireton
// - bug fix: используем список вместо фиксированного массива
//
// Revision 1.8  2009/06/10 15:04:58  fireton
// - bug fix: скобки больше не рвут контекст
//
// Revision 1.7  2009/06/10 13:38:16  fireton
// - bug fix: иногда проставляли ссылку на мусор, если контекст подходил по-первости
//
// Revision 1.6  2009/06/10 07:52:55  narry
// - неправильная ссылка на номер кодекса
//
// Revision 1.5  2009/06/09 13:06:14  narry
// - смена типа даты - вместо dnDoc используется dnPublish
//
// Revision 1.4  2009/06/09 12:44:42  fireton
// - неверно запоминался последний найденный кодекс
//
// Revision 1.3  2009/06/04 13:54:20  fireton
// - [$148572782]
//
// Revision 1.2  2009/06/02 13:43:59  narry
// - падали при недостаче данных
//
// Revision 1.1  2009/06/01 11:28:34  fireton
// - [$146377261]
//

interface
uses
 l3ProtoObject,
 l3Interfaces,
 l3Variant,
 l3Date,
 l3RegEx,
 l3LongintList,
 l3RecList,
 l3StringList,
 l3FieldSortRecList,
 l3ObjectList,
 l3InterfaceList,
 l3Types,
 l3Tree_TLB,

 k2Types,
 k2Interfaces,
 k2TagGen,

 evdBufferedFilter,

 DT_Types,

 ddCSV,
 ddTypes,
 ddDocStructBase,
 ddDocStruct,
 ddBaseAutoLinkDataSource,
 ddAutoLinkDataSource,


 ddAutolinkInterfaces,
 ddAutolinkDocEntry,
 ddAutoLinkDocHistory,
 ddAutolinkArbitraryDocList,
 ddAutolinkArbitraryDocEntry,
 ddCustomAutolinkDataLoader,
 
 ddEntryCollector
 ;

{$I DtDefine.inc}

const
 cMaxLinkInChain = 200;

type
 PFoundCodexRec = ^TFoundCodexRec;
 TFoundCodexRec = record
  rCodexIdx : Integer; // индекс кодекса в списке кодексов
  rDoc      : array [0..cMaxLinkInChain-1] of TddALDocRec; // список возможных ссылок на кодекс
  rBlock    : array [0..cMaxLinkInChain-1] of Integer;
 end;

 TddLinkSetRoutine = procedure (aFrom, aTo : Integer;
                                aDocID     : TDocID;
                                aBlockID   : Longint;
                                aLinkMsg   : string) of object;

 TddCustomLinkFinder = class(Tl3ProtoObject)
 private
  f_OnError: TddErrorEvent;
 protected
  procedure pm_SetOnError(const Value: TddErrorEvent); virtual;
 public
  procedure Done; virtual; abstract;
  procedure DoOnNewDocument; virtual;
  procedure FindLinks(const aText     : string;    // text from master doc
                      aDocID          : TDocID;    // master doc id
                      aDocDate        : TStDate;   // master doc date
                      const aCaseCode : Il3CString; // casecode
                      aLinkProc       : TddLinkSetRoutine); virtual; abstract;
  procedure Init; virtual; abstract;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
 end;

 TddEntryAddrRec = packed record
  rType   : Byte;
  rNum    : Word;
  rSubNum : Word;
 end;

 PddEntryResultRec = ^TddEntryResultRec;
 TddEntryResultRec = packed record
  rType    : Byte;
  rNum     : Word;
  rSubNum  : Word;
  rBlockNum: Longint;
 end;

 PddDocBlocksRec = ^TddDocBlocksRec;
 TddDocBlocksRec = record
  rDocID: TDocID;
  rCache: Tl3FieldSortRecList;
 end;

 TddDocumentLinker = class(Tl3ProtoObject)
 private
  f_FinderList: Tl3ObjectList;
  f_OnError: TddErrorEvent;
  f_Para: Tl3Variant;
  f_SPInQuote: Tl3RegularSearch;
  f_Text: string;
  f_UseInternalLink : Boolean;

  function NoLinkAtPos(aStart, aEnd: Longint): Boolean;
  function NotInQuotation(const aFrom: Longint): Boolean;
  function pm_GetSPInQuote: Tl3RegularSearch;
  procedure pm_SetOnError(const Value: TddErrorEvent);
  procedure SetLinkToBlock(aStart, aEnd: Longint; aDocID: TDocID; aBlockID: Longint);
  procedure SetLinkCallback(aFrom, aTo : Integer;
                            aDocID     : TDocID;
                            aBlockID   : Longint;
                            aLinkMsg   : string);
 protected
  procedure Cleanup; override;
  procedure DoOnError(aMsg: string);
  property SPInQuote: Tl3RegularSearch read pm_GetSPInQuote;
 public
  procedure AddLinkFinder(const aFinder: TddCustomLinkFinder);
  procedure FindAndSetLinks(aPara           : Tl3Variant;
                            aMasterDocID    : TDocID;
                            aMasterDocDate  : TStDate;
                            const aCaseCode : Il3CString);
  procedure Init;
  procedure Done;
  procedure NewDocument;
  property UseInternalLink : Boolean read f_UseInternalLink write f_UseInternalLink;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
 end;

 TddAutoLinkFilter = class(TevdBufferedFilter)
 private
  f_CaseCode: Il3CString;
  f_Category: Integer;
  f_DocDate: TStDate;
  f_DocID: TDocID;
  f_DocLinker: TddDocumentLinker;
  f_OnError: TddErrorEvent;
  f_PresetFlags: Byte; // здесь помечаем, какие данные были поданы "свыше" и их не надо обнулять
  f_SetLinks: Boolean;
  procedure pm_SetOnError(const Value: TddErrorEvent);
 protected
  procedure Cleanup; override;
        {-}
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner; aAllowedSources: Tl3LongintList; aDataFileName: string); reintroduce;
  procedure CloseStream(NeedUndo: Boolean); override;
  procedure OpenStream; override;
  procedure SetCasecode(const aCasecode: Il3CString);
  procedure SetDocDate(aDate: TStDate);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator;
                           aAllowedSources: Tl3LongintList = nil;
                       const aDataFileName: string = '';
                           aDocID    : TDocID = 0;
                           aDocDate  : TStDate = 0;
                           aCasecode : Il3CString = nil): Pointer; overload;

  procedure SetDocID(aDocID: TDocID);
  procedure UseInternalNumForLink(aValue : boolean);
  procedure StartChild(TypeID: Tl3VariantDef); override;

  property Category: Integer read f_Category write f_Category;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
 end;

 TddCodexArray = array of ICodexDataHolder;

 TddGeneralLawsLinkFinder = class(TddCustomLinkFinder)
 private
  f_ArbCourtNode: Il3Node;
  f_AllowedSources: Tl3LongintList;
  f_ArbitraryDocs: TddAutolinkArbitraryDocList;
  f_CodexData: Tl3InterfaceList;
  f_DefaultAbbr: string;
  f_DefaultAbbrCodex: Integer;
  f_DefaultCodex: Integer;
  f_EntryCollector: TddEntryCollector;
  f_FoundCodex: Tl3RecList;
  f_FoundSources: Tl3LongintList;
  f_CodexType: TDictID;
  f_ConstitutionDocID: TddALDocRec;
  f_GostType : TDictID;
  f_CourtRootNode: Il3Node;
  f_KonsType: TDictID;
  f_LastFoundCodex: TDocID;
  f_LastFoundSources: Tl3LongintList;
  f_LoneTypes: Tl3LongintList;
  f_PossibleLinks: Tl3RecList;
  f_ResolutionType: TDictID;
  f_SPChainConnector: Tl3RegularSearch;
  f_SPRusFed: Tl3RegularSearch;
  f_DataSource: TddBaseAutolinkDataSource;
  f_DocHistory: TddAutolinkDocHistory;
  procedure LoadSkippies;
  function pm_GetFoundSources: Tl3LongintList;
  function pm_GetSPChainConnector: Tl3RegularSearch;
  function pm_GetSPRusFed: Tl3RegularSearch;
  function AddFoundCodex(const aCodexIdx: Integer): Integer;
  procedure LoadStopWords;
  function pm_GetFoundCodex(aIndex: Integer): PFoundCodexRec;
  property FoundCodex[aIndex: Integer]: PFoundCodexRec read pm_GetFoundCodex;
 protected
  procedure Cleanup; override;
  procedure pm_SetOnError(const Value: TddErrorEvent); override;
  property FoundSources: Tl3LongintList read pm_GetFoundSources;
  property SPChainConnector: Tl3RegularSearch read pm_GetSPChainConnector;
  property SPRusFed: Tl3RegularSearch read pm_GetSPRusFed;
 public
  constructor Create(aAllowedSources: Tl3LongintList; const aDataFileName: string);
  procedure Done; override;
  procedure DoOnNewDocument; override;
  procedure FindLinks(const aText     : string;  // text from master doc
                      aDocID          : TDocID;  // master doc id
                      aDocDate        : TStDate; // master doc date
                      const aCaseCode : Il3CString;
                      aLinkProc       : TddLinkSetRoutine); override;
  procedure Init; override;
  property AllowedSources: Tl3LongintList read f_AllowedSources;
 end;

function GetAutoLinkFilter : TddAutoLinkFilter;
procedure CleanAutolinkFilter;

const
 sAutolinkDataFN = 'autolink.dat';

implementation
uses
 SysUtils, StrUtils,

 l3Const,
 l3Base,
 l3Chars,
 l3String,
 l3PrimString,
 l3LongintListPrim,
 l3Nodes,
 l3FileUtils,
 l3Filer,

 evdTypes,
 evSegLst,
 evdStyles,

 k2Base,
 k2Tags,
 k2InterfacesEx,
 Document_Const,
 LeafPara_Const,
 NumANDDate_Const,
 HyperLink_Const,
 Address_Const,
 TextSegment_Const,

 m4DictTypes,
 m4DictScanner,
 m4PhraseParser,

 daTypes,
 daInterfaces,
 daSchemeConsts,

 dtIntf,
 DT_Const,
 DT_AttrSchema,
 DT_DictConst,
 DT_Serv,
 DT_Active,
 DT_Doc,
 DT_LinkServ,
 DT_Hyper,
 DT_Dict,
 DT_ReNum,
 DT_Sab,
 DT_Query,
 DT_SrchQueries,

 ddAutolinkUtils,
 ddAutolinkServices

 {$If not defined(NoScripts)}
 ,
 kwFiltersAndGeneratorsPack
 {$IfEnd}
 ;

const
 c_NoEdition = High(TDocID);

 s_Entry   = 'статья';
 s_Chapter = 'глава';

const
 sp_RusFed = '(РФ)|(Российской Федерации)';

 cMaxCodex       = 40;

 cAbbrWordDelims: set of Char = [' ', '.', ',', '(', ')', '!', '?', ':', ';', cc_SoftSpace];

 etArticle = 1;
 etHead    = 2;

 cMaxEntryNum    = High(Word);
 cMaxEntrySubNum = High(Word);

 affDocID    = $01;
 affDocDate  = $02;
 affCasecode = $04;

type
 TALMiscSettingsRec = record
  rConstitutionDocID: TDocID;
 end;

 TddAutolinkDataLoader = class(TddCustomAutolinkDataLoader)
 private
  f_ArbitraryDocList: TddAutolinkArbitraryDocList;
  f_Misc: TALMiscSettingsRec;
 protected
  procedure LoadCodexes; override;
  procedure LoadFedLaws; override;
  procedure LoadArbitrary(aIsFedlaw: Boolean = False);
  procedure LoadLoneTypes; override;
  procedure LoadTypeSyns; override;
  procedure LoadMisc;
 protected
  procedure DispatchSection; override;
 public
  constructor Create(const aFileName: string; aCodexData: Tl3InterfaceList; aLoneTypeList: Tl3LongintList;
                     aArbitraryDocList: TddAutolinkArbitraryDocList);
  property Misc: TALMiscSettingsRec read f_Misc write f_Misc;
 end;

function IsReallySeparated(const aText: string; aStart, aFinish: Integer): Boolean;
begin
 Result := ((aStart = 1) or (aText[aStart-1] in cAbbrWordDelims)) and
        ((aFinish = Length(aText)) or (aText[aFinish+1] in cAbbrWordDelims));
end;

constructor TddAutoLinkFilter.Create(anOwner: Tk2TagGeneratorOwner; aAllowedSources: Tl3LongintList; aDataFileName:
    string);
begin
 inherited Create(anOwner);
 f_DocLinker := TddDocumentLinker.Create;
 f_DocLinker.AddLinkFinder(TddGeneralLawsLinkFinder.Create(aAllowedSources, aDataFileName));
end;

procedure TddAutoLinkFilter.Cleanup;
begin
 FreeAndNil(f_DocLinker);
 inherited;
end;

procedure TddAutoLinkFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
begin
 if TypeTable.TypeByHandle[-aTagID].IsKindOf(k2_typLeafPara) and f_SetLinks then
 begin
  f_DocLinker.FindAndSetLinks(aLeaf, f_DocID, f_DocDate, f_CaseCode);
 end;
 if (aTagId = -k2_idNumANDDate) then
 begin
  if (f_DocDate = 0) and (aLeaf.IntA[k2_tiType] = Ord(dnPublish)) then
   f_DocDate := DemonToStDate(aLeaf.IntA[k2_tiStart]);
  if (f_CaseCode = nil) and (aLeaf.IntA[k2_tiType] = Ord(dnLawCaseNum)) then
   f_CaseCode := l3CStr(aLeaf.PCharLenA[k2_tiNumber]);
 end;
 inherited;
end;

function TddAutoLinkFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -k2_idNumANDDate;
 if (not Result) and (aID < 0) then
  Result := (TypeTable.TypeByHandle[-aID] <> nil) and TypeTable.TypeByHandle[-aID].IsKindOf(k2_typLeafPara);
end;

function IsNumberOnly(const aStr: string): Boolean;
var
 I : Integer;
 l_Open: Integer;
begin
 l_Open := 0;
 for I := 1 to Length(aStr) do
 begin
  if aStr[I] = '(' then
   Inc(l_Open);
  if l_Open = 0 then
  begin
   Result := aStr[I] in ['0'..'9',' ','.','-'];
   if not Result then
    Exit;
  end;
  if aStr[I] = ')' then
   Dec(l_Open);
 end;
 Result := (l_Open = 0);
end;

procedure TddAutoLinkFilter.CloseStream(NeedUndo: Boolean);
begin
 inherited;
 f_DocLinker.Done;
end;

procedure TddAutoLinkFilter.DoAddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
  //virtual;
  {-}
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  case AtomIndex of
   k2_tiExternalHandle: f_DocID    := Value.AsInteger;
   k2_tiType          : f_SetLinks := Value.AsInteger <> Ord(dtRelText);
  end;
 inherited;
end;

procedure TddAutoLinkFilter.OpenStream;
begin
 inherited;
 f_DocLinker.Init;
end;

procedure TddAutoLinkFilter.pm_SetOnError(const Value: TddErrorEvent);
begin
 f_OnError := Value;
 f_DocLinker.OnError := Value;
end;

procedure TddAutoLinkFilter.SetCasecode(const aCasecode: Il3CString);
begin
 f_CaseCode := NormalizeCasecode(aCasecode);
 f_PresetFlags := f_PresetFlags or affCasecode;
end;

procedure TddAutoLinkFilter.SetDocDate(aDate: TStDate);
begin
 f_DocDate := aDate;
 f_PresetFlags := f_PresetFlags or affDocDate;
end;

class function TddAutoLinkFilter.SetTo(var theGenerator: Tk2TagGenerator;
                                           aAllowedSources: Tl3LongintList = nil;
                                     const aDataFileName  : string = '';
                                           aDocID    : TDocID = 0;
                                           aDocDate  : TStDate = 0;
                                           aCasecode : Il3CString = nil): Pointer;
  {-}
var
 l_Filter : TddAutoLinkFilter;
begin
 l_Filter := Create(nil, aAllowedSources, aDataFileName);
 try
  if aDocID <> 0 then
   l_Filter.SetDocID(aDocID);
  if aDocDate <> 0 then
   l_Filter.SetDocDate(aDocDate);
  if aCasecode <> nil then
   l_Filter.SetCasecode(aCasecode); 
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  FreeAndNil(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TddAutoLinkFilter.SetDocID(aDocID: TDocID);
begin
 f_DocID := aDocID;
 f_PresetFlags := f_PresetFlags or affDocID;
end;

procedure TddAutoLinkFilter.UseInternalNumForLink(aValue : boolean);
begin
 f_DocLinker.UseInternalLink := aValue;
end;

procedure TddAutoLinkFilter.StartChild(TypeID: Tl3VariantDef);
var
 I: Integer;
begin
 if TypeID = k2_typDocument then
 begin
  f_DocLinker.NewDocument;
  if f_PresetFlags and affDocID = 0 then
   f_DocID := 0;
  if f_PresetFlags and affDocDate = 0 then
   f_DocDate  := 0;
  if f_PresetFlags and affCasecode = 0 then
   f_CaseCode := nil;
  f_SetLinks := True;
  f_PresetFlags := 0; // учитываем флаги предустановки только для первого документа
 end;
 inherited;
end;

procedure TddDocumentLinker.AddLinkFinder(const aFinder: TddCustomLinkFinder);
begin
 if f_FinderList = nil then
  f_FinderList := Tl3ObjectList.Make;
 aFinder.OnError := f_OnError;
 f_FinderList.Add(aFinder);
end;

procedure TddDocumentLinker.Cleanup;
var
 I: Integer;
begin
 if f_FinderList <> nil then
 begin
  for I := 0 to Pred(f_FinderList.Count) do
   f_FinderList.Items[I].Free;
  FreeAndNil(f_FinderList);
 end;
 FreeAndNil(f_SPInQuote);
 FreeAndNil(f_Para);
 inherited;
end;

procedure TddDocumentLinker.DoOnError(aMsg: string);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg, 1);
end;

procedure TddDocumentLinker.FindAndSetLinks(aPara           : Tl3Variant;
                                            aMasterDocID    : TDocID;
                                            aMasterDocDate  : TStDate;
                                            const aCaseCode : Il3CString);
var
 I: Integer;
 l_Finder: TddCustomLinkFinder;
begin
 if f_FinderList <> nil then
 begin
  if aPara.IsValid and (not l3IsNil(aPara.PCharLenA[k2_tiText])) and
     (aPara.IntA[k2_tiStyle] <> ev_saTxtHeader1) and (aPara.IntA[k2_tiStyle] <> ev_saTxtComment) and
     (aPara.IntA[k2_tiStyle] <> ev_saTechComment) then
  begin
   f_Text := aPara.StrA[k2_tiText];
   if Trim(f_Text) = '' then
    Exit;
   aPara.SetRef(f_Para); 
   for I := 0 to Pred(f_FinderList.Count) do
   begin
    l_Finder := TddCustomLinkFinder(f_FinderList.Items[I]);
    l_Finder.FindLinks(f_Text, aMasterDocID, aMasterDocDate, aCaseCode, SetLinkCallback);
   end;
  end;
 end;
end;

procedure TddDocumentLinker.Init;
var
 I: Integer;
begin
 if f_FinderList <> nil then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).Init;
end;

procedure TddDocumentLinker.Done;
var
 I: Integer;
begin
 if f_FinderList <> nil then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).Done;
end;

procedure TddDocumentLinker.NewDocument;
var
 I: Integer;
begin
 if Assigned(f_FinderList) then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).DoOnNewDocument;
end;

function TddDocumentLinker.NoLinkAtPos(aStart, aEnd: Longint): Boolean;
var
 l_Layer: Tl3Variant;
begin
 l_Layer := f_Para.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil);
 Result := evIsSegmentsLayerEmpty(f_Para, l_Layer, aStart, aEnd);
end;

function TddDocumentLinker.NotInQuotation(const aFrom: Longint): Boolean;
var
 l_RP: Tl3MatchPosition;
begin
 Result := (aFrom = 0) or (not SPInQuote.SearchInString(PAnsiChar(f_Text), 0, aFrom+1, l_RP));
end;

function TddDocumentLinker.pm_GetSPInQuote: Tl3RegularSearch;
begin
 if f_SPInQuote = nil then
 begin
  f_SPInQuote := Tl3RegularSearch.Create;
  f_SPInQuote.IgnoreCase := True;
  f_SPInQuote.SearchPattern := '«[^»]*$';
 end;
 Result := f_SPInQuote;
end;

procedure TddDocumentLinker.pm_SetOnError(const Value: TddErrorEvent);
var
 I: Integer;
begin
 f_OnError := Value;
 if f_FinderList <> nil then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).OnError := Value;
end;

procedure TddDocumentLinker.SetLinkToBlock(aStart, aEnd: Longint; aDocID: TDocID; aBlockID: Longint);
var
 l_Seg: Tl3Variant;
 l_Addr: Tl3Variant;
begin
 if not f_UseInternalLink then
  aDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(aDocID);

 if aDocID <> cUndefDocID then
 begin
  with f_Para.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil) do
  begin
   l_Seg := k2_typHyperLink.MakeTag.AsObject;
   l_Seg.IntA[k2_tiStart]  := aStart + 1;
   l_Seg.IntA[k2_tiFinish] := aEnd;

   l_Addr := k2_typAddress.MakeTag.AsObject;
   l_Addr.IntA[k2_tiDocID] := aDocID;
   l_Addr.IntA[k2_tiSubID] := aBlockID;
   l_Seg.AddChild(l_Addr);

   AddChild(l_Seg);
  end;
 end;
end;

procedure TddDocumentLinker.SetLinkCallback(aFrom, aTo : Integer;
                                            aDocID     : TDocID;
                                            aBlockID   : Longint;
                                            aLinkMsg   : string);
begin
 if NoLinkAtPos(aFrom, aTo) and NotInQuotation(aFrom) then
 begin
  SetLinkToBlock(aFrom, aTo, aDocID, aBlockID);
  if aLinkMsg <> '' then
   DoOnError(aLinkMsg);
 end;
end;

procedure TddCustomLinkFinder.DoOnNewDocument;
begin
 // empty in base class
end;

procedure TddCustomLinkFinder.pm_SetOnError(const Value: TddErrorEvent);
begin
 f_OnError := Value;
end;

constructor TddGeneralLawsLinkFinder.Create(aAllowedSources: Tl3LongintList; const aDataFileName: string);
var
 l_TempID: TDictID;
 l_Sab: ISab;
 l_DataLoader : TddAutolinkDataLoader;
 l_FZType: TDictID;
 l_ZType: TDictID;
begin
 inherited Create;
 f_LoneTypes := Tl3LongintList.MakeSorted;
 f_CodexData := Tl3InterfaceList.Make;
 f_ArbitraryDocs := TddAutolinkArbitraryDocList.Make;
 if FileExists(aDataFileName) then
 begin
  l_DataLoader := TddAutolinkDataLoader.Create(aDataFileName, f_CodexData, f_LoneTypes, f_ArbitraryDocs);
  try
   l_DataLoader.Process;
   f_ConstitutionDocID.rExtDocID := l_DataLoader.Misc.rConstitutionDocID;
  finally
   FreeAndNil(l_DataLoader);
  end;
 end
 else
  l3System.Msg2Log('WARNING: Не найден файл %s! Возможно, будут проставлены не все ссылки.', [sAutolinkDataFN]);

 if f_ConstitutionDocID.rExtDocID > 0 then
 begin
  f_ConstitutionDocID.rIntDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(f_ConstitutionDocID.rExtDocID);
  if f_ConstitutionDocID.rIntDocID = cUndefDocID then
   l3FillChar(f_ConstitutionDocID, SizeOf(f_ConstitutionDocID));
 end;

 LoadSkippies;
 LoadStopWords;
 f_EntryCollector := TddEntryCollector.Create;
 f_PossibleLinks := Tl3RecList.Create(SizeOf(TLinkPrimRec));
 f_AllowedSources := Tl3LongintList.MakeSorted;
 if aAllowedSources <> nil then
 begin
  f_AllowedSources.Assign(aAllowedSources);
  l_Sab := GetExpandDictIDValueSab(da_dlSources, f_AllowedSources);
  f_AllowedSources.Clear;
  dtCopyValuesSabToList(l_Sab, f_AllowedSources);
  l_Sab := nil;
 end;
 f_FoundCodex := Tl3RecList.Create(SizeOf(TFoundCodexRec));
 f_LastFoundSources := Tl3LongintList.Make;
 with DictServer(CurrentFamily).Dict[da_dlSources] do
 begin
  f_CourtRootNode := FindNodeByFullPath(l3PCharLen('Органы судебной власти РФ и СССР'));
  f_ArbCourtNode := FindNodeByFullPath(l3PCharLen('Органы судебной власти РФ и СССР\Арбитражные апелляционные суды'));
 end;

 with DictServer(CurrentFamily).Dict[da_dlTypes] do
 begin
  f_KonsType := FindIDByFullPath(l3PCharLen('Конституция'));
  f_CodexType := FindIDByFullPath(l3PCharLen('Кодекс'));
  f_ResolutionType := FindIDByFullPath(l3PCharLen('Постановление'));
  f_GostType := FindIDByFullPath(l3PCharLen('Нормативно-техническая документация\ГОСТ (Государственный стандарт)'));

  l_TempID := FindIDByFullPath(l3PCharLen('Письмо'));
  l_ZType  := FindIDByFullPath(l3PCharLen('Закон'));
  l_FZType := FindIDByFullPath(l3PCharLen('Федеральный закон'));
 end;

 f_DocHistory := TddAutolinkDocHistory.Create(l_FZType, l_ZType);

 if l_TempID >= 0 then
 begin
  DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('информационное письмо'), l_TempID, Ord(da_dlTypes));
  DictServer(CurrentFamily).DictScanner.AddComplete;
 end;
end;

function TddGeneralLawsLinkFinder.AddFoundCodex(const aCodexIdx: Integer): Integer;
var
 l_CodexRec: TFoundCodexRec;
begin
 l3FillChar(l_CodexRec, SizeOf(TFoundCodexRec));
 l_CodexRec.rCodexIdx := aCodexIdx;
 Result := f_FoundCodex.Add(l_CodexRec);
end;

procedure TddGeneralLawsLinkFinder.Cleanup;
begin
 FreeAndNil(f_EntryCollector);
 FreeAndNil(f_PossibleLinks);
 FreeAndNil(f_FoundSources);
 FreeAndNil(f_FoundCodex);
 FreeAndNil(f_SPRusFed);
 FreeAndNil(f_SPChainConnector);
 FreeAndNil(f_AllowedSources);
 FreeAndNil(f_LastFoundSources);
 FreeAndNil(f_LoneTypes);
 FreeAndNil(f_CodexData);
 FreeAndNil(f_DataSource);
 FreeAndNil(f_DocHistory);
 FreeAndNil(f_ArbitraryDocs);
 inherited;
end;

procedure TddGeneralLawsLinkFinder.Done;
begin
 FreeAndNil(f_DataSource);
end;

procedure TddGeneralLawsLinkFinder.DoOnNewDocument;
begin
 f_DefaultCodex := -1;
 f_DefaultAbbr := '';
 f_DefaultAbbrCodex := -1;
 f_LastFoundCodex := -1;
 f_DocHistory.Clear;
end;

procedure TddGeneralLawsLinkFinder.FindLinks(const aText     : string;  // text from master doc
                                             aDocID          : TDocID;  // master doc id
                                             aDocDate        : TStDate; // master doc date
                                             const aCaseCode : Il3CString;
                                             aLinkProc       : TddLinkSetRoutine);
var
 l_ChainCursor : Integer;
 l_ChainEndPos : Integer;
 l_FoundType: Integer;
 l_LastFoundType: Integer;
 l_FoundDate: TStDate;
 l_FoundNum      : Il3CString;
 l_FoundCasecode : Il3CString;
 l_FoundShort: TddALDocRec;
 l_TypePos : Tm4Segment;
 l_StopPos : Tm4Segment;
 l_DatePos : Tm4Segment;
 l_NumPos  : Tm4Segment;
 l_DocStartPos: Integer;
 l_LastChainEndPos: Integer;
 l_DocLen     : Integer;
 l_LeftMostPos: Integer;
 l_LastFoundCodexInPara: Integer;
 lFDIProcStub : Tm4FoundDictItemProc;
 l_TextLen: Integer;
 l_FurtherSeg: Tm4Segment;
 l_HistoryIdx: Integer;

 procedure ResetChain;
 begin
  l_ChainCursor := -1;
  l_ChainEndPos := -1;
  l_DocStartPos := 0;
  l_DocLen      := 0;
  FoundSources.Clear;
  l_FoundType := -1;
  l_FoundDate := 0;
  l3FillChar(l_FoundShort, SizeOf(l_FoundShort));
  l_FoundNum := nil;
  l_FoundCasecode := nil;
  l3FillChar(l_FurtherSeg, SizeOf(l_FurtherSeg));
  l3FillChar(l_StopPos, SizeOf(l_StopPos));
  l_HistoryIdx := -1;
 end;

 procedure OutWarning(const aStr: string);
 begin
  if Assigned(f_OnError) then
   f_OnError(Format('%d: %s', [aDocID, aStr]), 1);
 end;

 function IsElementEmpty(const aElem: TddElementNumRec): Boolean;
 begin
  Result := (aElem.rNum = 0) and (aElem.rSubnum = 0) and (aElem.rSubSubNum = 0);
 end;

 function FindBlockInCache(aExtDocID: TDocID; const anAddress: TddDocStructElementRec): Longint;
 var
  l_Addr: TddDocStructElementRec;
  l_TriedItemTrick: Boolean;
 begin
  // функция умеет "огрублять" адрес; если, скажем, подпункт не найден, то поищем без него
  l_Addr := anAddress;
  l_TriedItemTrick := False;
  while True do
  begin
   Result := f_DataSource.FindBlock(aExtDocID, l_Addr);  // !!! везде внешние номера документов !!!
   if (Result < 0) and (l_Addr.rType = stEntry) then
   begin
    // Если статья пустая, то вполне вероятно, что в кэше наши пункты лежат как подпункты, как например в ПДД.
    // Поэтому надо проверить эту вероятность.
    if (not l_TriedItemTrick) and IsElementEmpty(l_Addr.rEntry) and IsElementEmpty(l_Addr.rSubItem) then
    begin
     l_Addr.rSubItem := l_Addr.rItem;
     l_Addr.rItem.rSubnum := 0;
     l_Addr.rItem.rSubSubNum := 0;
     Result := f_DataSource.FindBlock(aExtDocID, l_Addr);
     l_TriedItemTrick := True;
     if Result >= 0 then
      Break;
     l_Addr := anAddress;
    end;

    if l_Addr.rSubItem.rNum <> 0 then
    begin
     l3FillChar(l_Addr.rSubItem, SizeOf(TddElementNumRec));
     Continue;
    end;
    if l_Addr.rItem.rNum <> 0 then
    begin
     l3FillChar(l_Addr.rItem, SizeOf(TddElementNumRec));
     Continue;
    end;
    Break;
   end
   else
    Break;
  end;
 end;

 procedure FindDocAndBlockToLink(const aDocument        : TddALDocRec;
                                 const anAddress        : TddDocStructElementRec;
                                 var   theContemporalDoc: TddALDocRec;
                                 out   theDocToLink     : TddALDocRec;
                                 out   theBlockID       : Integer);
 begin
  theBlockID := FindBlockInCache(aDocument.rExtDocID, anAddress);
  theDocToLink := aDocument;
  if theBlockID < 0 then // в актуальной редакции не нашли, ищем в современной
  begin
   if theContemporalDoc.rIntDocID = 0 then // если современную редакцию ещё не вычисляли...
   begin
    theContemporalDoc := f_DataSource.GetContemporalEdition(aDocument.rExtDocID, aDocDate);
    if theContemporalDoc.rExtDocID = aDocument.rExtDocID then
     theContemporalDoc.rIntDocID := -1; // если современная = актуальная, то искать в ней не имеет смысла
   end;
   if theContemporalDoc.rExtDocID > 0 then
   begin
    theBlockID := FindBlockInCache(theContemporalDoc.rExtDocID, anAddress);
    theDocToLink := theContemporalDoc;
   end;
  end;
 end;

 procedure FilterCodexByKeywords;
 var
  I: Integer;
  l_KeywordsCount: array[0..cMaxCodex-1] of Integer;
  l_MaxKeywords: Integer;
  l_Stub: Tm4FoundDictItemProc;

  function l_FoundOneKeyword(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
  var
   I: Integer;
  begin
   Result := True;
   if aDictItemID.rDictionaryID = cCodexKeywordsDictID then
   begin
    for I := 0 to f_FoundCodex.Count-1 do
     if FoundCodex[I].rCodexIdx = aDictItemID.rID then
     begin
      l_KeywordsCount[I] := l_KeywordsCount[I] + 1;
      if l_MaxKeywords < l_KeywordsCount[I] then
       l_MaxKeywords := l_KeywordsCount[I];
      Break;
     end;
   end;
  end;

 begin
  if f_FoundCodex.Count < 2 then
   Exit;
  l3FillChar(l_KeywordsCount, SizeOf(l_KeywordsCount));
  l_MaxKeywords := 0;
  l_Stub := L2FoundDictItemProc(@l_FoundOneKeyword);
  try
   DoParsePhrase(l3PCharLen(aText), DictServer(CurrentFamily).DictScanner, l_Stub);
  finally
   FreeFoundDictItemProc(l_Stub);
  end;
  if l_MaxKeywords > 0 then
   for I := f_FoundCodex.Count-1 downto 0 do
    if l_KeywordsCount[I] < l_MaxKeywords then
     f_FoundCodex.Delete(I);
 end;

 procedure WorkoutCodexPrim(const aOffset, aLen: Integer; const aIsAbbr: Boolean);
 var
  I, J : Integer;
  l_FoundLinkChain : Boolean;
  l_LinksIsSet : Boolean;
  l_FoundLinksPerCodex: array[0..cMaxCodex-1] of Integer;
  l_PLinkItem: PLinkPrimRec;
  l_DocToLink: TddALDocRec;
  l_ContemporalDoc: TddALDocRec;
  l_BlockID : Integer;
  l_MaxLinksFound: Integer;
  l_LinkMsg: string;
  l_FTempPos: Tl3MatchPosition;
  l_DocID: TddALDocRec;
  l_CD: ICodexDataHolder;
 begin
  l_FoundLinkChain := False;
  if f_FoundCodex.Count > 0 then
  begin
   l_LinksIsSet := False;

   l_FoundLinkChain := f_EntryCollector.CollectEntries(PAnsiChar(aText), l_LeftMostPos, aOffset-1, f_PossibleLinks);
   if f_PossibleLinks.Count > 0 then
   begin
    while f_PossibleLinks.Count > cMaxLinkInChain do  // подстраховка, на случай если цепочка слишком длинная
     f_PossibleLinks.Delete(f_PossibleLinks.Count-1); // хотя трудно представить цепочку >200 элементов...
     
    // Ищем в блокнеймах каждого найденного кодекса
    f_DataSource.DocumentAlreadyDefined; // говорим источнику данных, что документ искать не будем, он уже найден
    l3FillChar(l_FoundLinksPerCodex, SizeOf(l_FoundLinksPerCodex));
    for I := 0 to f_FoundCodex.Count - 1 do
    begin
     l_CD := ICodexDataHolder(f_CodexData[FoundCodex[I].rCodexIdx]);
     l3FillChar(l_ContemporalDoc, SizeOf(l_ContemporalDoc));
     for J := 0 to f_PossibleLinks.Count-1 do
     begin
      l_PLinkItem  := PLinkPrimRec(f_PossibleLinks.ItemSlot(J));
      // ищем нужный документ и блокнейм
      FindDocAndBlockToLink(l_CD.ActualEdition, l_PLinkItem^.rAddress, l_ContemporalDoc, l_DocToLink, l_BlockID);
      FoundCodex[I].rDoc[J]   := l_DocToLink;
      FoundCodex[I].rBlock[J] := l_BlockID;
      if l_BlockID >= 0 then // Если в хотя бы одной редакции блокнейм нашелся, то
       Inc(l_FoundLinksPerCodex[I]); // увеличиваем список найденных ссылок для этого кодекса
     end;
    end;

    // выясняем, для какое количество найденных ссылок - максимальное
    l_MaxLinksFound := 0;
    for I := 0 to f_FoundCodex.Count - 1 do
     if l_FoundLinksPerCodex[I] > l_MaxLinksFound then
      l_MaxLinksFound := l_FoundLinksPerCodex[I];

    if l_MaxLinksFound > 0 then // если вообще что-то нашлось
    begin
     // выкидываем из списка все кодексы с немаксимальным количеством ссылок
     for I := f_FoundCodex.Count - 1 downto 0 do
      if l_FoundLinksPerCodex[I] < l_MaxLinksFound then
       f_FoundCodex.Delete(I);

     // если и после всех манипуляций в списке больше одного кодекса - фильтруем список по ключевым словам в абзаце
     if f_FoundCodex.Count > 1 then
      FilterCodexByKeywords;

     // Проставляем ссылки на первый в списке кодекс, если он там не один - ну что ж, мы старались...
     for I := 0 to f_PossibleLinks.Count-1 do
     begin
      with PLinkPrimRec(f_PossibleLinks.ItemSlot(I))^, FoundCodex[0]^ do
      begin
       if rBlock[I] >= 0 then
       begin
        // ставим ссылку на нужную редакцию нужного кодекса
        aLinkProc(rStart, rEnd, rDoc[I].rIntDocID, rBlock[I], l_LinkMsg);
        l_LinkMsg := '';
        l_LinksIsSet := True;
       end;
      end
     end;
     l_LastFoundCodexInPara := FoundCodex[0].rCodexIdx;
     f_LastFoundCodex := l_LastFoundCodexInPara;
    end;
   end; // f_PossibleLinks.Count > 0

   if (not l_LinksIsSet) then // если не нашли цепочку или в цепочке не нашли ссылок, то
   begin
    if ((not aIsAbbr) and (not l_FoundLinkChain)) or
       (aIsAbbr and SPRusFed.SearchInString(PAnsiChar(aText)+ aOffset + aLen + 1, 0, l_TextLen - aOffset - aLen, l_FTempPos)) then
    begin
     // ставим ссылку на сам кодекс
     // если найдено несколько, пытаемся отфильтровать по ключевым словам
     if f_FoundCodex.Count > 1 then
      FilterCodexByKeywords;

     // ставим на первый в списке, если их несколько - что ж, мы старались
     I := 0;
     while I < f_FoundCodex.Count do // перебираем, на случай если данные из autolink.dat неверны
     begin
      l_CD := ICodexDataHolder(f_CodexData[FoundCodex[I].rCodexIdx]);
      l_DocID := l_CD.ActualEdition;
      if l_DocID.rIntDocID <> c_NoEdition then // вот на этот случай как раз
      begin
       l_LastFoundCodexInPara := FoundCodex[I].rCodexIdx;
       f_LastFoundCodex := l_LastFoundCodexInPara;
       if f_FoundCodex.Count > 1 then
        l_LinkMsg := 'Не удалось различить кодексы, ставим ссылку на первый валидный в списке';
       aLinkProc(aOffset, aOffset + aLen, l_DocID.rIntDocID, 0, l_LinkMsg);
       l_LinkMsg := '';
       Break;
      end;
      Inc(I);
     end; // while I < f_FoundCodex.Count do
    end;
   end;
  end; // f_FoundCodex.Count > 0
  l_LeftMostPos := l_DocStartPos + l_DocLen + 1;
  ResetChain;
 end;

 procedure WorkOutCodex(aCodexNo: Integer; const aOffset, aLen: Integer);
 begin
  f_FoundCodex.Clear;
  if (aCodexNo > f_CodexData.Count-1) then
  begin
   if (f_LastFoundCodex >= 0) then
    AddFoundCodex(f_LastFoundCodex)
   else
   begin
    ResetChain;
    Exit;
   end;
  end
  else
   AddFoundCodex(aCodexNo);
  WorkoutCodexPrim(aOffset, aLen, False);
 end;

 function CheckSources: Boolean;
 var
  I: Integer;
 begin
  if f_AllowedSources.Empty then
   Result := True
  else
  begin
   Result := False;
   if not FoundSources.Empty then
    for I := 0 to FoundSources.Count - 1 do
     if f_AllowedSources.IndexOf(FoundSources[I]) >= 0 then
     begin
      Result := True;
      Break;
     end;
  end;
 end;

 function l3CStr2WStr(const aCStr: Il3CString): Tl3WString;
 begin
  if l3IsNil(aCStr) then
   Result := cc_EmptyStr
  else
   Result := aCStr.AsWStr;
 end;

 procedure WorkoutChain;
 var
  l_DocStr: string;
  l_DocID: TddALDocRec;
  l_PLinkRec: PLinkPrimRec;
  l_BlockID: Longint;
  I: Integer;
  l_LinkIsSet: Boolean;
  l_SNode: Il3Node;
  l_TheDocLinkPos: Tm4Segment;
  l_RP: Tl3MatchPosition;
  l_ContemporalDoc: TddALDocRec;
  l_DocForLink: TddALDocRec;
 begin
  l3FillChar(l_DocID, SizeOf(TddALDocRec));
  l_TheDocLinkPos := l_TypePos;
  // надо проверить, не "наследуем" ли мы атрибуты прошлой цепочки
  // если уже были цепочки с типом документа и тип не найден, но найдена дата или номер...
  if (l_LastChainEndPos > 0) and (l_LastFoundType >= 0) and (l_FoundType < 0) and
     ((l_FoundDate > 0) or (not l3IsNil(l_FoundNum))) then
  begin
   if SPChainConnector.SearchInString(PAnsiChar(aText)+l_LastChainEndPos, 0, l_DocStartPos - l_LastChainEndPos, l_RP) then
   begin
    l_FoundType := l_LastFoundType;
    if f_FoundSources.Empty then
     f_FoundSources.Assign(f_LastFoundSources);
    if not l3IsNil(l_FoundNum) then
     l_TheDocLinkPos := l_NumPos
    else
     l_TheDocLinkPos := l_DatePos;
   end;
  end;

  if CheckSources then
  begin
   if (l_FoundShort.rIntDocID > 0) then // если мы нашли документ по короткому имени, то больше ничего не надо
   begin
    l_DocID := l_FoundShort;
    f_DataSource.DocumentAlreadyDefined;
   end
   else
   if (l_FoundType >= 0) and
      ((l_FoundType = f_KonsType) or (l_FoundDate > 0) or not l3IsNil(l_FoundNum) or not l3IsNil(l_FoundCasecode)) then
   begin
    if (FoundSources.Count > 0) or (f_LoneTypes.IndexOf(l_FoundType) >= 0) then
    begin
     if (l_FoundType = f_KonsType) and (f_ConstitutionDocID.rIntDocID <> 0) then
      l_DocID := f_ConstitutionDocID
     else
     begin
      if (l_FoundType = f_KonsType) or (l_FoundDate > 0) or not l3IsNil(l_FoundNum) or not l3IsNil(l_FoundCasecode) then
      begin
       // данных достаточно для поиска, строим запрос
       f_DataSource.StartDocQuery;
       try
        // тип документа
        f_DataSource.FilterByDocType(l_FoundType);

        // дата и номер
        if (l_FoundDate > 0) or (not l3IsNil(l_FoundNum)) then
        begin
         // если документ - постановление арбитражного суда, то надо отпилить у него суффикс "-ГК" или "-АК"
         if (not l3IsNil(l_FoundNum)) and (l_FoundType = f_ResolutionType) and
            (f_ArbCourtNode <> nil) and (FoundSources.Count = 1) then
         begin
          l_SNode := DictServer(CurrentFamily).Dict[da_dlSources].FindNodeByID(FoundSources.Items[0]);
          if (l_SNode <> nil) and (l_SNode.ParentNode = f_ArbCourtNode) then
          begin
           if l3Ends(l3PCharLen('-ГК'), l_FoundNum.AsWStr, True) or l3Ends(l3PCharLen('-АК'), l_FoundNum.AsWStr, True) then
            l3Delete(l_FoundNum, l_FoundNum.AsWStr.SLen - 3, 3);
          end;
         end;

         // если не указан номер, но есть дата и есть casecode текущего документа, то ищем по нему...
         if l3IsNil(l_FoundNum) and l3IsNil(l_FoundCasecode) and (not l3IsNil(aCaseCode)) and
            (FoundSources.Count = 1) then
         begin
          l_SNode := DictServer(CurrentFamily).Dict[da_dlSources].FindNodeByID(FoundSources.Items[0]);
          // убедиться, что документ, на который мы ссылаемся, принадлежит к документам судебной власти
          if (l_SNode <> nil) and (l3SearchByNode(f_CourtRootNode, l_SNode) <> nil) then
           f_DataSource.FilterByCasecode(Tl3PcharLen(aCaseCode.AsWStr));
         end;

         f_DataSource.FilterByDateNum(l_FoundDate, Tl3PCharLen(l3CStr2WStr(l_FoundNum)));
        end;

        if not l3IsNil(l_FoundCasecode) then
         f_DataSource.FilterByCasecode(Tl3PcharLen(l_FoundCasecode.AsWStr));

        // источники
        if FoundSources.Count > 0 then
         f_DataSource.FilterBySources(f_FoundSources);

        // оставляем только актуальные редакции
        f_DataSource.FilterByActualEditions;

        //l_DocStr := Copy(aText, l_DocStartPos + 1, l_DocLen); // отладочный код
        l_DocID := f_DataSource.ExecuteDocQuery;

        // если документ не определился или неоднозначно определился,
        // и у него есть какие-нибудь реквизиты, кроме типа документа,
        // и перед ним нет "далее",
        // то пробуем поискать в хистори (ранее найденных документах, на которые ссылки уже ставились)
        if ((l_DocID.rIntDocID = TDocID(cUndefDocID)) or (l_DocID.rIntDocID = TDocID(cUndefDocID))) and
           ((FoundSources.Count > 0) or (l_FoundDate > 0) or (not l3IsNil(l_FoundNum))) and
           (l_FurtherSeg.rOffs = 0) then
        begin
         l_HistoryIdx := f_DocHistory.FindBySubEntry(TddAutolinkDocEntry.Make(l_FoundType, l_FoundDate, Tl3PCharLen(l3CStr2WStr(l_FoundNum)),
             f_FoundSources, l_DocID));
         if l_HistoryIdx >= 0 then
          l_DocID := f_DocHistory.Entry[l_HistoryIdx].DocID;
        end;

        { выключим выдачу в лог, всё равно никто не читает (Маша С.)
        if l_DocID.rIntDocID = TDocID(cUndefDocID) then
         OutWarning(Format('неоднозначно определен закон (%s)', [l_DocStr]));
        if l_DocID.rIntDocID = 0 then
         OutWarning(Format('не найден закон (%s)', [l_DocStr]));
        }
       finally
        f_DataSource.CleanupDocQuery;
       end;
      end;
     end;
    end; // if найдены источники или тип входит в список типов, которые могут использоваться без источников
   end; // if достаточно данных для поиска
  end; // CheckSources

  if l_DocID.rIntDocID > 0 then // мы определились, что это за документ
  begin
   l3FillChar(l_ContemporalDoc, SizeOf(l_ContemporalDoc));
   l_LinkIsSet := False;
   if l_DocStartPos > 0 then
   begin
    f_EntryCollector.CollectEntries(PAnsiChar(aText), l_LeftMostPos, l_DocStartPos - 1, f_PossibleLinks);
    if f_PossibleLinks.Count > 0 then
    begin
     for I := 0 to f_PossibleLinks.Count - 1 do
     begin
      l_PLinkRec := PLinkPrimRec(f_PossibleLinks.ItemSlot(I));
      FindDocAndBlockToLink(l_DocID, l_PLinkRec^.rAddress, l_ContemporalDoc, l_DocForLink, l_BlockID);
      if l_BlockID >= 0 then
      begin
       aLinkProc(l_PLinkRec^.rStart, l_PLinkRec^.rEnd, l_DocForLink.rIntDocID, l_BlockID, '');
       l_LinkIsSet := True;
      end;
     end;
    end;
   end;
   if not l_LinkIsSet then
   begin
    aLinkProc(l_TheDocLinkPos.rOffs, l_TheDocLinkPos.rOffs + l_TheDocLinkPos.rLen, l_DocID.rIntDocID, 0, '');
   end;

   // добавляем документ в history
   if l_HistoryIdx < 0 then // мы нашли этот документ не в хистори
    // добавляем его туда
    f_DocHistory.AddEntry(TddAutolinkDocEntry.Make(l_FoundType, l_FoundDate, Tl3PCharLen(l3CStr2WStr(l_FoundNum)), f_FoundSources, l_DocID))
   else
    // передвигаем найденный в хистори документ на вершину списка
    f_DocHistory.MoveToTop(l_HistoryIdx);

   l_LeftMostPos := l_DocStartPos + l_DocLen + 1;
   l_LastFoundType := l_FoundType;
   f_LastFoundSources.Assign(f_FoundSources);
   l_LastChainEndPos := l_ChainEndPos;
  end; // if l_DocID > 0

  ResetChain;
 end;

 procedure WorkOutCodexAbbr(aAbbrSeg: Tm4Segment);
 var
  l_AbbrCStr: Il3CString;
  I : Integer;
  l_Idx: Integer;
 begin
  if IsReallySeparated(aText, aAbbrSeg.rOffs+1, aAbbrSeg.rOffs + aAbbrSeg.rLen) then
  begin
   if (l_LastFoundCodexInPara >= 0) and (l_FurtherSeg.rOffs > 0) and
      (aAbbrSeg.rWOffs = l_FurtherSeg.rWOffs + 1) then
   begin
    f_DefaultAbbr := Copy(aText, aAbbrSeg.rOffs+1, aAbbrSeg.rLen);
    f_DefaultAbbrCodex := l_LastFoundCodexInPara;
   end
   else
   begin
    l_AbbrCStr := l3CStr(l3PCharLen(PAnsiChar(aText) + aAbbrSeg.rOffs, aAbbrSeg.rLen));
    if l3Same(f_DefaultAbbr, l_AbbrCStr, True) then
     WorkOutCodex(f_DefaultAbbrCodex, aAbbrSeg.rOffs, aAbbrSeg.rLen)
    else
    begin
     f_FoundCodex.Clear;
     for I := 0 to f_CodexData.Count - 1 do
      if ICodexDataHolder(f_CodexData[I]).Abbreviations.FindData(l_AbbrCStr.AsWStr, l_Idx, l3_siCaseUnsensitive) then
       AddFoundCodex(I);
     WorkOutCodexPrim(aAbbrSeg.rOffs, aAbbrSeg.rLen, True);
    end;
   end;
  end;
  ResetChain;
 end;

 function StoppedByStopWord(const aCurSegment: Tm4Segment): Boolean;
 begin
  Result := (l_StopPos.rLen > 0) and (l_StopPos.rWOffs = aCurSegment.rWOffs - 1);
 end;

 function lFoundDictItem(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 var
  l_ArbitraryDoc: IddAutolinkArbitraryDocEntry;
  //l_FoundStr: string;

  procedure lp_UpdateChain;
  begin
   // устанавливаем курсор на следующий предполагаемый элемент цепочки
   if l_ChainCursor < 0 then
    l_DocStartPos := aSegment.rOffs;
   l_DocLen := aSegment.rOffs + aSegment.rLen - l_DocStartPos;
   l_ChainCursor := aSegment.rWOffs + aSegment.rWLen;
   l_ChainEndPos := aSegment.rOffs + aSegment.rLen;
  end;

 begin
  Result := True;
  //l_FoundStr := Copy(aText, aSegment.rOffs + 1, aSegment.rLen); // отладочный код
  if (l_ChainCursor >= 0) and (aSegment.rWOffs <> l_ChainCursor) then
   WorkoutChain; // цепочка прервана, смотрим, чего мы уже накопили...
  // приехал первый или очередной элемент цепочки
  case aDictItemID.rDictionaryID of
   cDateDictID :
    begin
     if l_FoundDate <> 0 then
      WorkoutChain;
     l_FoundDate := aDictItemID.rID;
     l_DatePos := aSegment;
    end;

   cNumDictID :
    begin
     if not l3IsNil(l_FoundNum) then
      WorkoutChain;
     l_FoundNum := l3Upper(l3CStr(l3PcharLen(PAnsiChar(aText) + aSegment.rOffs, aSegment.rLen)));
     l_NumPos := aSegment;
    end;

   cLawcaseNumDictID :
    begin
     if not l3IsNil(l_FoundCasecode) then
      WorkoutChain;
     l_FoundCasecode := NormalizeCasecode(l3CStr(l3PcharLen(PAnsiChar(aText) + aSegment.rOffs, aSegment.rLen)));
     //l_NumPos := aSegment; // пока непонятно, нужна ли нам позиция кейскода
    end;

   cGostDictID :
    begin
     // это - совсем отдельный тип документа, поэтому и обрабатывать его надо по-особому
     // для начала, обработаем уже накопленное (если что-то было накоплено)
     WorkoutChain;
     if f_GostType > 0 then
     begin
      l_FoundType := f_GostType; // тип строго определён
      l_TypePos := aSegment; // ссылка будет ставиться на всю строку
      l_FoundNum := l3Upper(l3CStr(l3PcharLen(PAnsiChar(aText) + aSegment.rOffs, aSegment.rLen))); // и она же используется как номер документа
      lp_UpdateChain;
      WorkoutChain; // дальше там ничего нет, обрабатываем цепочку
     end;
    end;

   cShortNameDictID :
    if l_FoundShort.rIntDocID = 0 then
    begin
     l_ArbitraryDoc := f_ArbitraryDocs.Items[aDictItemID.rID];
     // Если список разрешённых типов пуст и никакого типа не найдено ИЛИ найденный тип в списке разрешённых
     if ((l_ArbitraryDoc.TypesList = nil) and (l_FoundType < 0)) or
        ((l_ArbitraryDoc.TypesList <> nil) and (l_ArbitraryDoc.TypesList.IndexOf(l_FoundType) >= 0)) then
     begin
      l_FoundShort := ddFillALDocRecFromExtDocID(l_ArbitraryDoc.DocID);
      lp_UpdateChain;
      // если тип не определён, то надо скорректировать сегмент, на который будет ставиться ссылка
      if (l_FoundType < 0) then
       l_TypePos := aSegment;
     end;
     // если нашли короткое имя, то дальше будет какой-то мусор (даже если это дата или номер)
     // поэтому завершаем цепочку
     WorkoutChain;
     Exit;
    end;

   cSkippiesDictID     : ; // пропускаем, не разрывая цепочку
   //cCodexKeywordsDictID: ; // пропускаем, не разрывая цепочку -- наверное, так не надо делать

   cStopWordsDictID:
    begin
     // это стоп-слово = запоминаем позицию и рвём цепочку
     WorkoutChain;
     l_StopPos := aSegment;
     Exit;
    end;

   cCodexDictID    :
    begin
     lp_UpdateChain;
     WorkOutCodex(aDictItemID.rID, aSegment.rOffs, aSegment.rLen);
    end;
   cCodexAbbrDictID:
    begin
     lp_UpdateChain;
     WorkOutCodexAbbr(aSegment);
    end;
   cCodexSpecials  :
    case aDictItemID.rID of
     cs_Further:
      begin
       lp_UpdateChain;
       WorkoutChain;
       l_FurtherSeg := aSegment;
      end;
    end;
  else
   case TdaDictionaryType(aDictItemID.rDictionaryID) of
     da_dlSources: FoundSources.Add(aDictItemID.rID);
     da_dlTypes  :
      begin
       if not StoppedByStopWord(aSegment) then
       begin
        if l_FoundType >= 0 then //
         WorkoutChain;
        l_FoundDate := 0;

        if aDictItemID.rID = f_CodexType then
        begin
         if (l_FurtherSeg.rOffs > 0) and (aSegment.rWOffs = l_FurtherSeg.rWOffs + 1) then
          f_DefaultCodex := f_LastFoundCodex
         else
          if f_DefaultCodex >= 0 then
           WorkoutCodex(f_DefaultCodex, aSegment.rOffs, aSegment.rLen)
          else
           if l_LastFoundCodexInPara >= 0 then
            WorkoutCodex(l_LastFoundCodexInPara, aSegment.rOffs, aSegment.rLen);
        end
        else
        begin
         l_FoundType := aDictItemID.rID;
         l_TypePos := aSegment;
        end;
       end
       else // if not StoppedByStopWord
       begin
        // тип предварён стоп-словом = невалиден
        WorkoutChain;
        Exit;
       end;
      end;
   else
    // какой=то левый элемент, проверяем и сбрасываем цепочку
    WorkoutChain;
    Exit;
   end;
  end;
  lp_UpdateChain;
 end;

begin
 ResetChain;
 l_LastFoundType := -1;
 l_TextLen := Length(aText);
 l_LeftMostPos := 0;
 l_LastFoundCodexInPara := -1;
 l_LastChainEndPos := -1;
 // собственно, парсим строку
 lFDIProcStub := L2FoundDictItemProc(@lFoundDictItem);
 try
  DoParsePhrase(l3PCharLen(aText), DictServer(CurrentFamily).DictScanner, lFDIProcStub);
  WorkoutChain;
 finally
  FreeFoundDictItemProc(lFDIProcStub);
 end;
end;

procedure TddGeneralLawsLinkFinder.Init;
begin
 f_DataSource := TddDualAutolinkDataSource.Create(f_OnError); {TddCacheAutolinkDataSource.Create;} {TddDBAutolinkDataSource.Create;}
end;

procedure TddGeneralLawsLinkFinder.LoadSkippies;
begin
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('РФ'), 0, cSkippiesDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('Российская Федерация'), 0, cSkippiesDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('и'), 0, cSkippiesDictID);
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

procedure TddGeneralLawsLinkFinder.LoadStopWords;
begin
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('улица'), 0, cStopWordsDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('ул'), 0, cStopWordsDictID);
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

function TddGeneralLawsLinkFinder.pm_GetFoundCodex(aIndex: Integer): PFoundCodexRec;
begin
 Result := PFoundCodexRec(f_FoundCodex.ItemSlot(aIndex));
end;

function TddGeneralLawsLinkFinder.pm_GetFoundSources: Tl3LongintList;
begin
 if f_FoundSources = nil then
  f_FoundSources := Tl3LongintList.Make;
 Result := f_FoundSources;
end;

function TddGeneralLawsLinkFinder.pm_GetSPChainConnector: Tl3RegularSearch;
begin
 if f_SPChainConnector = nil then
 begin
  f_SPChainConnector := Tl3RegularSearch.Create;
  f_SPChainConnector.IgnoreCase := True;
  f_SPChainConnector.SearchPattern := '^\s*[\,\и]\s*$';
 end;
 Result := f_SPChainConnector;
end;

function TddGeneralLawsLinkFinder.pm_GetSPRusFed: Tl3RegularSearch;
begin
 if f_SPRusFed = nil then
 begin
  f_SPRusFed := Tl3RegularSearch.Create;
  f_SPRusFed.IgnoreCase := True;
  f_SPRusFed.SearchPattern := '^\s+' + sp_RusFed;
 end;
 Result := f_SPRusFed;
end;

procedure TddGeneralLawsLinkFinder.pm_SetOnError(const Value: TddErrorEvent);
begin
 inherited pm_SetOnError(Value);
 if f_DataSource <> nil then
  f_DataSource.OnError := Value;
end;

type
 TddAutoLinkFilterBox = class(Tl3Base, Il3ItemNotifyRecipient)
 private
  f_LinkFilter: TddAutoLinkFilter;
  procedure KillFilter;
 protected
  procedure Cleanup; override;
  procedure Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
 public
  constructor Create;
 end;

constructor TddAutoLinkFilterBox.Create;
begin
 inherited Create;
 Il3ChangeNotifier(GlobalHtServer).Subscribe(Il3ItemNotifyRecipient(Self));
 f_LinkFilter := TddAutoLinkFilter.Create(nil {anOwner}, nil {aAllowedSources},
                                     ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, sAutolinkDataFN));
end;

procedure TddAutoLinkFilterBox.Cleanup;
begin
 KillFilter;
 inherited;
end;

procedure TddAutoLinkFilterBox.KillFilter;
begin
 FreeAndNil(f_LinkFilter);
end;

procedure TddAutoLinkFilterBox.Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
begin
 if aOperation = sni_Destroy then
  KillFilter;
end;

var
 gALinkBox : TddAutoLinkFilterBox;

function GetAutoLinkFilter : TddAutoLinkFilter;
begin
 if gALinkBox = nil then
  gALinkBox := TddAutoLinkFilterBox.Create;
 Result := gALinkBox.f_LinkFilter;
end;

procedure CleanAutolinkFilter;
begin
 if gALinkBox <> nil then
  gALinkBox.f_LinkFilter.Generator := nil;
end;

constructor TddAutolinkDataLoader.Create(const aFileName: string; aCodexData: Tl3InterfaceList;
    aLoneTypeList: Tl3LongintList; aArbitraryDocList: TddAutolinkArbitraryDocList);
begin
 inherited Create(aFileName, aCodexData, aLoneTypeList);
 f_ArbitraryDocList := aArbitraryDocList;
end;

procedure TddAutolinkDataLoader.DispatchSection;
begin
 if l3Same(SectName, 'arbitrary', True) then
  LoadArbitrary
 else
 if l3Same(SectName, 'misc', True) then
  LoadMisc
 else
  inherited;
end;

procedure TddAutolinkDataLoader.LoadCodexes;
var
 l_CDocID: TDocID;
 l_Keywords: string;

 function AddOnePhrase(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, f_CodexData.Count-1, cCodexDictID);
 end;

 function AddOneKeyword(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, f_CodexData.Count-1, cCodexKeywordsDictID);
 end;

 function AddOneAbbr(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_Str: Tl3WString;
 begin
  Result := True;
  l_Str := l3Trim(aStr);
  if l3IsNil(l_Str) then
   Exit;
  ICodexDataHolder(f_CodexData[f_CodexData.Count-1]).Abbreviations.Add(l_Str);
  DictServer(CurrentFamily).DictScanner.AddToDict(l_Str, cDummyID, cCodexAbbrDictID);
 end;

begin
 f_CodexData.Clear;
 while NextLine do
 begin
  if ValuesCount >= 3 then
  begin
   l_CDocID := l3StrToIntDef(ValuesW[ctc_DocumentID], cUndefDocID);
   Assert((l_CDocID <> cUndefDocID) and (l_CDocID <> 0), 'Неверный номер документа '+ValuesW[ctc_DocumentID].S);
   if (l_CDocID <> cUndefDocID) and (l_CDocID <> 0) then
   begin
    l_Keywords := Trim(l3PCharLen2String(ValuesW[ctc_Keywords]));
    f_CodexData.Add(TCodexDataHolder.Make(l_CDocID));
    l3ParseWordsExF(ValuesW[ctc_CodexName], l3L2WA(@AddOnePhrase), ['|']);
    l3ParseWordsExF(ValuesW[ctc_Abbreviation], l3L2WA(@AddOneAbbr), [',']);
    if ValuesCount > 3 then
     l3ParseWordsExF(ValuesW[ctc_Keywords], l3L2WA(@AddOneKeyword), [',']);
   end // (l_CDocID <> cUndefDocID) and (l_CDocID <> 0)
   else
    l3System.Msg2Log('Неверный номер документа %s', [ValuesW[ctc_DocumentID].S]);
  end;
 end; // while
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('настоящий кодекс'), cDummyID, cCodexDictID);
 DictServer(CurrentFamily).DictScanner.AddToDict(l3PCharLen('далее'), cs_Further, cCodexSpecials);
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

procedure TddAutolinkDataLoader.LoadArbitrary(aIsFedlaw: Boolean = False);
var
 I: Integer;
 l_Q: TdtQuery;
 l_SC: ISabCursor;
 l_DocID: TDocID;
 l_AQ: TdtCustomQuery;
 l_TypeList: Tl3LongintList;
 l_C: Tl3Char;
 l_WStr: Tl3WString;
 l_CurDoc: IddAutolinkArbitraryDocEntry;

 function AddOnePhrase(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, f_ArbitraryDocList.Count-1, cShortNameDictID);
 end;

 function AddOneType(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_ID: Longint;
 begin
  Result := True;
  l_ID := DictServer(CurrentFamily).Dict[da_dlTypes].FindIDByFullPath(l3Trim(aStr));
  if l_ID <> cUndefDictID then
   l_TypeList.Add(l_ID);
 end;

begin
 l_TypeList := nil;
 try
  // поддержка старого формата
  if aIsFedLaw then
  begin
   l_TypeList := Tl3LongintList.MakeSorted;
   AddOneType(l3PCharLen('Закон'), False);
   AddOneType(l3PCharLen('Федеральный закон'), False);
   AddOneType(l3PCharLen('Федеральный конституционный закон'), False);
   if l_TypeList.Count = 0 then
    Exit;
  end;

  while NextLine do
   if ValuesCount >= 2 then
   begin
    l_DocID := 0;
    if ValuesCount > 2 then
     l_DocID := l3StrToIntDef(ValuesW[2], 0);
    if l_DocID = 0 then
    begin
     l_Q := SQText2Query(l3PCharLen2String(ValuesW[0]));
     try
      if l_Q <> nil then
      begin
       l_AQ := TdtActiveQuery.Create([asActive]);
       SQAndF(l_Q, l_AQ);
       if l_Q.FoundList.Count = 1 then
       begin
        l_SC := l_Q.FoundList.MakeSabCursor([fId_Fld], cmForward);
        l_DocID := LinkServer(CurrentFamily).Renum.GetExtDocID(PDocID(l_SC.GetItem(0))^);
        Values[2] := l3CStr(IntToStr(l_DocID));
        l_SC := nil;
       end;
      end;
     finally
      FreeAndNil(l_Q);
     end;
    end;
    if l_DocID <> 0 then
    begin
     l_CurDoc := TddAutolinkArbitraryDocEntry.Make(l_DocID, l_TypeList);
     f_ArbitraryDocList.Add(l_CurDoc);
     l3ParseWordsExF(ValuesW[1], l3L2WA(@AddOnePhrase), ['|']);
    end;
   end
   else
   begin
    if (ValuesCount = 1) and (not aIsFedLaw) then
    begin
     l_C := l3CharEx(ValuesW[0], 0);
     if l_C.rAC = '#' then
     begin
      l_WStr := l3Copy(ValuesW[0], 1);
      FreeAndNil(l_TypeList);
      l_TypeList := Tl3LongintList.MakeSorted;
      l3ParseWordsExF(l_WStr, l3L2WA(@AddOneType), [',']);
      if l_TypeList.Count = 0 then
       FreeAndNil(l_TypeList);
     end;
    end;
   end;
 finally
  FreeAndNil(l_TypeList);
 end;
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

procedure TddAutolinkDataLoader.LoadFedLaws;
begin
 LoadArbitrary(True);
end;

procedure TddAutolinkDataLoader.LoadLoneTypes;
var
 l_ID: TDictID;
begin
 while NextLine do
  if ValuesCount > 0 then
  begin
   l_ID := DictServer(CurrentFamily).Dict[da_dlTypes].FindIDByFullPath(ValuesW[0]);
   if l_ID <> cUndefDictID then
    f_LoneTypesList.Add(l_ID);
  end;
end;

procedure TddAutolinkDataLoader.LoadMisc;
begin
 while NextLine do
  if ValuesCount = 2 then
  begin
   if l3Same(Values[0], 'ConstitutionDocID', True) then
    f_Misc.rConstitutionDocID := l3StrToIntDef(ValuesW[1], 0);
  end;
end;

procedure TddAutolinkDataLoader.LoadTypeSyns;
var
 l_ID: TDictID;

 function AddOnePhrase(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  DictServer(CurrentFamily).DictScanner.AddToDict(aStr, l_ID, Ord(da_dlTypes));
 end;

begin
 while NextLine do
  if ValuesCount = 2 then
  begin
   l_ID := DictServer(CurrentFamily).Dict[da_dlTypes].FindIDByFullPath(ValuesW[0]);
   if l_ID <> cUndefDictID then
    l3ParseWordsExF(ValuesW[1], l3L2WA(@AddOnePhrase), ['|']);
  end;
 DictServer(CurrentFamily).DictScanner.AddComplete;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\ddAutoLinkFilter.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\ddAutoLinkFilter.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(gALinkBox);
end.


