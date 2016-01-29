unit nsExternalObjectPrim;

{ $Id: nsExternalObjectPrim.pas,v 1.24 2015/09/07 12:16:12 morozov Exp $ }

// $Log: nsExternalObjectPrim.pas,v $
// Revision 1.24  2015/09/07 12:16:12  morozov
// {RequestLink: 606129455}
//
// Revision 1.23  2015/08/28 07:01:50  morozov
// {RequestLink: 606138644}
//
// Revision 1.22  2015/08/26 12:32:01  morozov
// {RequestLink: 606129455}
//
// Revision 1.21  2015/07/13 12:32:09  kostitsin
// {requestlink: 127042272 }
//
// Revision 1.20  2015/05/06 13:52:23  dinishev
// {Requestlink:590772837}
//
// Revision 1.19  2015/05/06 12:41:39  dinishev
// {Requestlink:590772837}
//
// Revision 1.18  2015/04/27 12:50:19  morozov
// {RequestLink: 580699967}
//
// Revision 1.17  2015/03/02 11:42:37  dinishev
// {Requestlink:587628768}
//
// Revision 1.16  2015/03/02 11:14:27  dinishev
// {Requestlink:587628900}
//
// Revision 1.15  2015/03/02 09:33:36  dinishev
// {Requestlink:587628900}
//
// Revision 1.14  2014/11/19 06:50:52  kostitsin
// {requestlink: 564248678 } - впаял обратно
//
// Revision 1.13  2014/11/12 12:34:22  kostitsin
// {requestlink: 573675680 }
//
// Revision 1.12  2014/10/21 13:24:34  dinishev
// {Requestlink:566807405}
//
// Revision 1.11  2014/09/19 08:21:20  dinishev
// {Requestlink:565014958}. Недокоммител.
//
// Revision 1.10  2014/09/19 06:29:45  morozov
// Добавил "test_arbitr.garant.ru" в список броузеров открывающихся во вне
//
// Revision 1.9  2014/09/17 07:29:56  morozov
// {RequestLink: 565248245}
//
// Revision 1.8  2014/09/16 11:00:47  morozov
// {RequestLink: 477647723}
//
// Revision 1.7  2014/09/11 08:00:23  dinishev
// {Requestlink:564248678}. Фильтры для PDF
//
// Revision 1.6  2014/09/02 13:23:18  kostitsin
// {requestlink: 564248678 }
//
// Revision 1.5  2014/08/22 07:40:10  morozov
// {RequestLink: 563197648}
//
// Revision 1.4  2014/05/11 10:52:51  kostitsin
// {requestlink: 531974948 }
//
// Revision 1.3  2014/04/29 17:19:36  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.2  2014/04/03 17:17:50  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.1  2014/01/15 12:57:39  kostitsin
// {requestlink: 451251129}
//
// Revision 1.17  2013/11/12 12:57:44  lulin
// - вычищаем использование "устаревших" объектов.
//
// Revision 1.16  2013/10/18 14:11:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2013/09/25 12:36:33  morozov
// Не сохранялся список в простой текст (ассерт)
//
// Revision 1.14  2013/09/24 14:54:59  morozov
// {RequestLink: 431371899}
//
// Revision 1.13  2013/09/23 07:33:21  morozov
// {RequestLink: 484018812}
//
// Revision 1.12  2013/09/19 11:51:31  morozov
// {RequestLink: 484018812}
//
// Revision 1.11  2013/09/12 07:00:51  morozov
// {RequestLink: 482258671}
//
// Revision 1.10  2013/08/02 14:12:38  morozov
// {RequestLink: 475468995}
//
// Revision 1.9  2013/08/02 09:17:16  morozov
// {RequestLink: 475468995}
//
// Revision 1.8  2013/04/24 09:35:56  lulin
// - портируем.
//
// Revision 1.7  2013/03/07 10:55:17  morozov
// {RequestLink:434735908}
//
// Revision 1.6  2013/03/01 14:18:51  morozov
// {RequestLink:391840102}
//
// Revision 1.5  2013/02/27 13:00:12  kostitsin
// [$431385176]
//
// Revision 1.4  2013/02/27 10:31:52  kostitsin
// [$431385176]
//
// Revision 1.3  2012/08/03 13:01:16  kostitsin
// [$380616604]
//  - nsExternalObject
//
// Revision 1.2  2012/05/29 09:21:20  lulin
// {RequestLink:367201541}
//
// Revision 1.1  2012/02/27 16:13:40  lulin
// {RequestLink:338463186}
//
// Revision 1.21  2012/02/14 04:40:59  lulin
// - вставлена диагностика.
//
// Revision 1.20  2012/02/14 04:37:47  lulin
// - вставлена диагностика.
//
// Revision 1.19  2012/02/10 15:49:43  lulin
// {RequestLink:329646242}
//
// Revision 1.18  2012/02/10 14:24:38  lulin
// {RequestLink:329646242}
// - "кошерно" получаем генератор RTF'а.
//
// Revision 1.17  2011/10/14 15:36:48  lulin
// {RequestLink:278837963}.
//
// Revision 1.16  2011/10/13 16:52:38  lulin
// [$293277563].
//
// Revision 1.15  2011/07/12 09:44:43  migel
// - fix: не детектили `Google Chrome`.
//
// Revision 1.14  2011/06/23 13:13:25  migel
// - add: включили в "белый" список Сафари и Хром.
//
// Revision 1.13  2011/04/21 12:30:36  migel
// - add: поддержка для новых типов ExternalObjects.
//
// Revision 1.12  2011/03/01 10:59:44  lulin
// {RequestLink:253664017}.
//
// Revision 1.11  2011/02/16 16:09:26  lulin
// {RequestLink:251342018}.
//
// Revision 1.10  2011/02/16 15:58:13  lulin
// {RequestLink:253660286}.
//
// Revision 1.9  2011/02/07 14:44:44  lulin
// {RequestLink:252512765}.
//
// Revision 1.8  2011/01/25 13:51:35  lulin
// {RequestLink:235872416}.
//
// Revision 1.7  2010/08/18 08:19:44  oman
// - new: {RequestLink:221251901}
//
// Revision 1.6  2010/06/22 12:50:06  lulin
// {RequestLink:219122682}.
// - bug fix: были проблемы с новыми пакованными комментариями.
//
// Revision 1.5  2010/04/13 09:30:47  oman
// - new: Обработка {RequestLink:185205058}
//
// Revision 1.4  2010/03/26 16:04:56  lulin
// {RequestLink:197952025}.
//
// Revision 1.3  2010/02/09 15:51:10  oman
// - fix: {RequestLink:190251136}
//
// Revision 1.2  2010/01/28 06:27:29  oman
// Не собирались
//
// Revision 1.1  2009/09/28 10:33:13  lulin
// - переносим примесь для обработки переключения закладок в более правильное место.
//
// Revision 1.2  2009/09/15 16:32:40  lulin
// - основной модуль мониторингов полностью перенесён на модель.
//
// Revision 1.1  2009/09/14 11:28:32  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.104  2009/08/04 11:25:31  lulin
// [$159351827].
//
// Revision 1.103  2009/08/03 15:37:57  lulin
// {RequestLink:129240934}. №7.
//
// Revision 1.102  2009/07/31 17:29:52  lulin
// - убираем мусор.
//
// Revision 1.101  2009/05/22 14:19:52  migel
// - add: возможность отключения Интернет-Агента.
//
// Revision 1.100  2009/04/29 12:29:54  oman
// warning fix
//
// Revision 1.99  2009/04/24 15:32:27  lulin
// - переносим утилитный модуль в базовую библиотеку.
//
// Revision 1.98  2009/04/22 12:05:08  lulin
// [$124453728]. Делаем проверку на то что ссылка находится в домене Гаранта.
//
// Revision 1.97  2009/04/21 16:45:25  lulin
// [$124453728]. Все ссылки на Гарант открываем в Интернет-агенте.
//
// Revision 1.96  2009/04/02 08:21:50  oman
// - fix: Боремся с внешними диалогами - [$140286037]
//
// Revision 1.95  2009/03/04 13:32:27  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.94  2009/02/20 12:25:12  lulin
// - <K>: 136941122.
//
// Revision 1.93  2009/01/14 09:34:54  oman
// - new: Эксопртим в первом приближении (К-96481841)
//
// Revision 1.92  2009/01/13 14:19:44  oman
// - new: Потроха для экспорта в активный ворд (К-96481841)
//
// Revision 1.91  2008/12/25 12:19:26  lulin
// - <K>: 121153186.
//
// Revision 1.90  2008/12/24 18:01:14  lulin
// - <K>: 121153186.
//
// Revision 1.89  2008/10/01 12:21:52  oman
// - fix: Новый тип встроенного объекта (К-120718929)
//
// Revision 1.88  2008/09/26 12:00:48  oman
// Cleanup
//
// Revision 1.87  2008/09/25 13:12:01  oman
// Чтобы собиралось
//
// Revision 1.86  2008/09/18 13:05:55  oman
// - fix: Вытаскиваем навер окно почтовика (К-116851167)
//
// Revision 1.85  2008/08/26 08:59:18  oman
// - fix: Неверное условие (K-110985712)
//
// Revision 1.84  2008/08/25 11:44:11  oman
// - fix: При отсутствии почтового клиента ругаемся (K-109904939)
//
// Revision 1.83  2008/08/25 08:17:33  oman
// - fix: Хакерски боремся с вистой и windows mail (K-109904591)
//
// Revision 1.82  2008/08/21 10:46:37  oman
// - fix: Хакерски боремся с вистой и windows mail
//
// Revision 1.81  2008/08/20 13:50:42  oman
// - fix: Личили не там (К-106987661)
//
// Revision 1.80  2008/08/20 13:20:21  oman
// - fix: Боремся другим макаром - недоборолись (К-106987661)
//
// Revision 1.79  2008/08/20 12:52:42  oman
// cleanup
//
// Revision 1.77  2008/08/20 07:55:53  oman
// - fix: Откручиваем починку 106987661 (К-109086047)
//
// Revision 1.76  2008/08/14 10:41:46  oman
// - fix: Обрываем технические комментарии в списке (K-108627048)
//
// Revision 1.75  2008/08/11 11:56:50  oman
// - fix: Теоретически боремся с модальными формами (K-106987661)
//
// Revision 1.74  2008/08/08 11:37:08  oman
// - fix: Излишний Seek (K-107381159)
//
// Revision 1.73  2008/07/23 10:59:36  oman
// Учитываем если расширение уже есть.
//
// Revision 1.72  2008/07/21 13:04:03  mmorozov
// - новые типы внешних объектов.
//
// Revision 1.71  2008/07/16 09:53:14  oman
// - new: Проверяем наличие ЭНО и открываемся более правильным способом (К-102465668)
//
// Revision 1.70  2008/06/19 05:01:16  mmorozov
// - новый тип внешнего объекта;
//
// Revision 1.69  2008/03/28 12:45:20  mmorozov
// - класс переименован.
//
// Revision 1.68  2008/03/04 11:11:58  oman
// - fix: Учитываем особенности OutlookExpress под XP/2003 (cq28537)
//
// Revision 1.67  2008/03/03 12:33:06  oman
// - fix: Проблемы с многоящичным батом на отпревке писем (cq28537)
//
// Revision 1.66  2008/02/07 19:18:36  lulin
// - bug fix: не собиралось.
//
// Revision 1.65  2008/02/06 11:44:59  oman
// - fix: Из временного каталога удаляем только те файлы, имена
//  которых генерили (cq27904)
//
// Revision 1.64  2008/02/06 09:18:25  oman
// Ошибочный коммит
//
// Revision 1.63  2008/02/06 09:17:14  oman
// - new: Обрабатываем исключение об отсутствии файла помощи (cq28369)
//
// Revision 1.62  2008/02/05 11:42:08  oman
// - fix: При экспорте/открытии встроенного объекта ставим файлу RO (cq27904)
//
// Revision 1.61  2008/02/05 10:40:39  oman
// - fix: При экспорте/открытии встроенного объекта ставим файлу RO (cq27904)
//
// Revision 1.60  2008/02/05 09:49:05  oman
// - fix: Подчищаем за собой и RO-файлы (cq27904)
//
// Revision 1.59  2008/02/05 09:32:28  oman
// - fix: Не занимаемся излишним удалением файлов
//
// Revision 1.58  2008/01/29 14:24:20  oman
// - new: Отправка документа по EMail (cq10543)
//
// Revision 1.57  2008/01/25 10:29:37  oman
// - new: в фильтр параметров страницы подаем принтер (cq27281)
//
// Revision 1.56  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.55.4.2  2007/11/23 10:15:20  oman
// Перепиливаем на новый адаптер
//
// Revision 1.55.4.1  2007/11/16 12:23:36  oman
// Перепиливаем на новый адаптер
//
// Revision 1.55  2007/09/28 08:04:05  mmorozov
// - add comments;
//
// Revision 1.54  2007/09/28 07:03:05  mmorozov
// - небольшой рефакторинг _StdRes и _nsSaveDialog;
// - разделяем получение имени файла для диалогов сохранения и временных файлов + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-26809);
//
// Revision 1.53  2007/08/14 19:31:39  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.52  2007/08/14 14:29:48  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.51  2007/06/14 08:43:47  oman
// - new: При экспорте не в EVD эмулируем внешний вид
//  комментариев пользователя (cq13946)
//
// Revision 1.50  2007/04/17 12:27:28  lulin
// - используем функции преобразования строки с кодировкой к имени файла.
//
// Revision 1.49  2007/04/05 12:46:53  oman
// cleanup
//
// Revision 1.48  2007/04/03 11:12:46  oman
// - new: При сохранении в один файл умеем писать не только RTF, а
//  все поддерживаемые форматы
//
// Revision 1.47  2007/03/16 09:56:35  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.46  2007/03/05 14:26:47  lulin
// - cleanup.
//
// Revision 1.45  2007/03/05 13:47:17  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.44  2007/03/05 10:50:04  oman
// - fix: Экспорты выделенных документов в один файл (cq24552)
//
// Revision 1.43  2007/01/21 17:05:16  mmorozov
// - merge with B_NEMESIS_6_4 (CQ: OIT5-24130);
//
// Revision 1.42  2007/01/05 16:08:05  lulin
// - cleanup.
//
// Revision 1.41  2007/01/05 15:56:20  lulin
// - cleanup.
//
// Revision 1.40  2006/11/21 14:29:55  lulin
// - наведен порядок с сохранением в файл и прикручено сохранение в XML.
//
// Revision 1.39.4.1  2007/01/21 16:42:02  mmorozov
// - bugfix: формирование имени файла при сохранении (CQ: OIT5-24130);
//
// Revision 1.39  2006/08/24 13:30:56  oman
// - fix: Более корректное исправление имени файла (символ ":").
//
// Revision 1.38  2006/06/28 09:28:39  mmorozov
// - bugfix: в функцию ShellExecute не правильно подавалась строка, в результате в письме разработчикам имели мусор в конце текста (CQ: OIT500021485);
//
// Revision 1.37  2006/06/07 10:32:21  mmorozov
// - bugfix: при повторном экспорте списка в Word имели системную ошибку, пытались писать в файл, который держал Word. Кроме того при экспорте создавалось два файла, первый пустой без расширения,  второй с расшением с экпортированной информацией (CQ: OIT500021216);
//
// Revision 1.36  2006/05/18 09:30:38  oman
// - fix: При корректировке имени файла (при необходимости) добавляем
//  пробел перед заменяемым символом ":" (cq20972)
//
// Revision 1.35  2006/04/11 14:12:39  mmorozov
// - change: выносим код с формы;
// - bugfix: при сохранении файла не выдавалось подтверждение при если такой файл уже существовал (CQ: 20383);
//
// Revision 1.34  2006/03/10 12:55:18  mmorozov
// - warning fix;
//
// Revision 1.33  2006/03/10 12:02:59  mmorozov
// - new: при сохранении списка в xml пользователю предлагается две операции "Весь список", "Выделенные документы";
// - new: в качестве пути по умолчанию предлагается папка "Мои документы";
//
// Revision 1.32  2005/12/28 15:31:20  lulin
// - bug fix: при экспорте не ставились фильтры параметров страниц.
//
// Revision 1.31  2005/09/15 13:18:39  mmorozov
// - вычищение старого списка и переход на новый;
//
// Revision 1.30  2005/07/21 13:00:00  lulin
// - писатель формата EVD переехал в папку EVD.
//
// Revision 1.29  2005/07/21 12:21:22  lulin
// - читатель формата EVD переехал в папку EVD.
//
// Revision 1.28  2005/07/21 10:39:52  lulin
// - генератор plain-текста переехал в правильную папку.
//
// Revision 1.27  2005/07/21 10:19:50  lulin
// - теперь TextSource не знает как создавать Reader'ы, а про это знает контейнер документа.
//
// Revision 1.26  2005/06/30 07:48:05  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.25  2005/04/18 11:50:48  lulin
// - сделано сохранение документа из списка в пустоту.
//
// Revision 1.24  2005/01/17 16:39:19  migel
// - change: задаем время таймаута при экспорте документов (CQ: 11154).
// - fix: предупреждение компилятора о неинициализированном значении переменной.
//
// Revision 1.23  2004/09/21 13:53:10  lulin
// - Release заменил на Cleanup.
//
// Revision 1.22  2004/09/17 14:28:41  lulin
// - убрал лишнюю раннюю инициализацию.
//
// Revision 1.21  2004/09/02 10:25:28  law
// - cleanup: убраны лишние зависимости.
//

{$Include nsDefine.inc }

interface

uses
  Windows,
  ActiveX,
  SysUtils,
  Classes,
  Messages,

  l3Interfaces,
  l3BaseStream,
  l3Base,
  l3ProtoObject,

  vcmInterfaces,

  k2TagGen,
  k2FileGenerator,

  evdPlainTextWriter,
  evdReader,

  ddRTFWriter,
  ddHTMLWriter,

  eeDocumentContainer,

  vcmBase,
  vcmExternalInterfaces,

  nevTools,

  nsTypes,
  nsExternalObjectModelPart,
  nsDocumentStreamList,

  evdStyles,

  DataAdapter,
  ExternalObjectUnit
  ;

type
  TnsExternalObjectPrim = class(Tl3ProtoObject)
  private
  // internal fields
    f_TempCatalogPath: String;
    f_TempFilesList: IvcmStrings;
  private
  // internal methods
    function GetRandomSuffix: String;
      {-}
    procedure CreateUniqueTempCatalog;
      {-}
    procedure RemoveUniqueTempCatalog;
      {-}
    function TempFilesList: IvcmStrings;
      {-}
    function MessageHook(var Msg: TMessage): Boolean; 
      {-}
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
  public
  // public methods
    constructor Create;
      reintroduce;
      {-}
    function Execute(const aExternalObject: IExternalObject): Boolean;
      {* - True, если все отработали нормально. }
    function PrepareFileName(const aName     : Il3CString;
                             const aNameOnly : Boolean = False): Il3CString;
      {* - удаляет запрещенные для диалога сохранения символы в имени файла, а
           тажке ограничивает днинну имени файла половиной максимально
           допустимой в операционной системе. }
    function MakeTemporaryFileName(const aName             : Il3CString;
                                   const aExtension        : String;
                                   const aWithFileCreation : Boolean = True): Il3CString;
      {* - готовит путь к файлу для сохранения во временную директорию, а также
           обеспечивает уникальность имени файла во временной директории. }
  end;//TnsExternalObjectPrim

  TnsExternalObjectStream = class(Tl3Stream)
  private
    f_ExternalObject : IExternalObject;
    f_Position       : Int64;
    //
    function  pm_getExternalObjectName: Il3CString;
  protected
    procedure Cleanup;
      override;
    procedure SetSize(a_Size: Longint);
      override;
  public
    constructor Create(const aExternalObject: IExternalObject);
      reintroduce;
    //
    function  Read(var aBuffer; aCount: Longint): Longint;
      override;
    function  Write(const aBuffer; aCount: Longint): Longint;
      override;
    function Seek(const anOffset: Int64; anOrigin: TSeekOrigin): Int64;
      override;
    procedure SaveToFile(const aFileName: TFileName);
    //
    property  ExternalObjectName: Il3CString read pm_getExternalObjectName;
  end;//TnsExternalObjectStream

  EDefaultMailCLientAbsent = class(Exception);

procedure nsSetExportFilters4PDF(var aGenerator: Tk2TagGenerator; aHiddenStyles: TevStandardStyles);
  {-}
function nsDoShellExecuteEx(const aFile: Il3CString; SetReadOnlyToFile: Boolean;
 const aContainerMaker: IvcmContainerMaker; IgnoreGarantURL: Boolean = False): Boolean;
 {-}
function nsDoShellExecute(const aFile: Il3CString; SetReadOnlyToFile: Boolean = False;
 const aContainer: IvcmContainer = nil; IgnoreGarantURL: Boolean = False): Boolean;
 {-}
function nsInsertFileIntoWord(const aFile: Il3CString): Boolean;
 {-}
function nsSendAttachedFile(const aFile: Il3CString): Boolean;
 {-}
function nsExecuteExternalLink(const aExternalLink: IExternalLink; const aCont: IvcmContainer = nil): Boolean;
 {-}
function nsExecuteExternalLinkEx(const aExternalLink: IExternalLink; const aContainerMaker: IvcmContainerMaker): Boolean;
 {-}
function nsExtractURL(const aExternalLink: IExternalLink): Il3CString;
 {-}
function nsExecuteExternalObject(const aExternalObject: IExternalObject): Boolean;
 {-}
function nsPrepareFileName(const aName: Il3CString): Il3CString;
 {* - удаляет запрещенные для диалога сохранения символы в имени файла, а тажке
      ограничивает днинну имени файла половиной максимально допустимой в
      операционной системе. }
function nsMakeTemporaryFileName(const aName             : Il3CString;
                                 const aExtension        : String;
                                 const aWithFileCreation : Boolean = True): Il3CString;
 {* - готовит путь к файлу для сохранения во временную директорию, а также
      обеспечивает уникальность имени файла во временной директории. }
function nsGetExternalObjectExt(const aExternalObject: IExternalObject): Il3CString;
 {-}
function nsGetExternalObjectName(const aExternalObject: IExternalObject): Il3CString;
 {-}
function nsEvdStreamSave(const aGenerator : Tk2CustomFileGenerator;
                         aHead            : Tk2TagGenerator;
                         const aStream    : IStream;
                         var anOutput: TnsGetGenOutputStruct;
                         const aFormat    : TnsFileFormat;
                         HideTechComments: Boolean): Boolean;
 overload;
 {-}
function nsEvdStreamSave(const aGenerator : Tk2CustomFileGenerator;
                         aHead            : Tk2TagGenerator;
                         const aStream    : InevObjectHolder;
                         var anOutput: TnsGetGenOutputStruct;
                         const aFormat    : TnsFileFormat;
                         HideTechComments: Boolean): Boolean;
 overload;
 {-}
function nsEvdStreamSaveAs(const aStream : IStream;
                           var anOutput: TnsGetGenOutputStruct;
                           const aFormat : TnsFileFormat;
                           HideTechComments: Boolean): Boolean;
 overload;
 {-}
function nsEvdStreamSaveAs(const aStream : InevObjectHolder;
                           var anOutput: TnsGetGenOutputStruct;
                           const aFormat : TnsFileFormat;
                           HideTechComments: Boolean): Boolean;
 overload;
 {-}
function nsGetGen(//var aName     : Il3CString;
                  var anOutput: TnsGetGenOutputStruct;
                  const aFormat : TnsFileFormat;
                  out theGen    : Tk2CustomFileGenerator;
                  out theHead   : Tk2TagGenerator): Boolean;
 {-}
function nsGetFileFormatExt(const aFormat: TnsFileFormat): String;
  {* - расширения файлов для каждого типа формата. }

procedure nsSaveMultiplyDocuments(const aList: TnsDocumentStreamList;
                                  const aFileName: Il3CString;
                                  const aFormat: TnsFileFormat;
                                  const NeedPrintTopic: Boolean;
                                  HideTechComments: Boolean);
  {* - Сохраняет множество документов в один файл.
       топики разделяются фразой "Топик: <внутренний номер документа>"
       aSourceTree итерируется по флагу }

implementation

uses
  ShellApi,
  SysConst,
  MAPI,
  Forms,
  Registry,
  COMObj,
  Variants,
  StrUtils,

  l3InterfacesMisc,
  l3Filer,
  l3Types,
  l3FileUtils,
  l3String,
  l3Stream,
  l3Chars,

  afwFacade,

  vcmStringList,

  k2Tags,

  evdWriter,
  evdXMLWriter,
  evdPageParamsFilter,

  evTypes,
  evGeneratorUtils,
  evUserCommentFilter,
  evHiddenFilter,

  ddSectionRepair,

  nsUtils,
  nsExternalObject,

  IOUnit,

  StdRes,

  bsInterfaces,

  Document_Const,
  TextPara_Const,

  nsInternetUtils,
  evdVer,

  evTextFormatter,
  evNestedDocumentEliminator,

  nevPersistentDocumentContainer,
  evExtFormat,
  evStyleHeaderAdder,
  evPDFWriter,

  nsBrowserInfo
  ;

const
  c_nsFileFormatExt: array [TnsFileFormat] of String = (
  {* - расширения файлов для каждого типа формата. }
   '.rtf',
   '.txt',
   '.htm',
   '.xml',
   '.evd',
   '.rtf',
   '.pdf'
  );

procedure ForceDeleteFile(const aFileName: String);
begin
 FileSetAttr(aFileName, FileGetAttr(aFileName) and not faReadOnly);
 DeleteFile(aFileName);
end;

function nsGetFileFormatExt(const aFormat: TnsFileFormat): String;
  {* - расширения файлов для каждого типа формата. }
begin
 Result := c_nsFileFormatExt[aFormat];
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function TnsExternalObjectPrim.GetRandomSuffix: String;
begin
 Result := IntToHex(Random($ffff), 4);
end;

function TnsExternalObjectPrim.TempFilesList: IvcmStrings;
begin
 if f_TempFilesList = nil then
  f_TempFilesList := TvcmStringList.Make;
 Result := f_TempFilesList;
end;

procedure TnsExternalObjectPrim.CreateUniqueTempCatalog;
const
 c_TempCatalogNamePrefix: String = '~NS6';
 c_TempCatalogRoot: String = 'C:\'; // используется в случае, если не удается получить временный каталог средствами ОС
var
 l_LastError       : Longword;
 l_TempCatalogPath : String;
 l_TempCatalogRoot : String;
 l_Path            : array [0..MAX_PATH] of Char;

 function lp_AdjustTempCatalog(const aPath: String): String;
 var
  l_MaxPathLength   : Integer;
 begin
  Result := aPath;
  l_MaxPathLength := Length(Result);
  Dec(l_MaxPathLength, Length(ExtractFileDrive(Result)));
  Inc(l_MaxPathLength, Length(c_TempCatalogNamePrefix));
  Inc(l_MaxPathLength, 4); // Length(RandomSuffix)
  Inc(l_MaxPathLength, 1); // Length(Slash)
  Inc(l_MaxPathLength, 4); // Length(Name)
  Inc(l_MaxPathLength, 1); // Length(' ')
  Inc(l_MaxPathLength, 4); // Length(RandomSuffix)
  Inc(l_MaxPathLength, 4); // Length(Extension)
  if (l_MaxPathLength > MAX_PATH) then
   Result := c_TempCatalogRoot;
 end;

begin
 if (GetTempPath(0, nil) = 0) then
  l_TempCatalogRoot := c_TempCatalogRoot
 else
 begin
  GetTempPath(SizeOf(l_Path), @l_Path);
  l_TempCatalogRoot := lp_AdjustTempCatalog(String(l3GetLongPathName(@l_Path, SizeOf(l_Path))));
 end;
 repeat
  l_TempCatalogPath := l_TempCatalogRoot+c_TempCatalogNamePrefix+GetRandomSuffix;
  if (not(DirectoryExists(l_TempCatalogPath) or FileExists(l_TempCatalogPath))
    and (CreateDir(l_TempCatalogPath))) then
   Break
  else
  begin
   l_LastError := GetLastError;                 
   if (l_LastError = ERROR_ACCESS_DENIED) then
    raise EInOutError.CreateRes(@SAccessDenied)
   else
    SetLastError(l_LastError);
  end;
  Sleep(0); // отдаем неиспользованное время другим процессам/нитям
 until False;
 f_TempCatalogPath := l_TempCatalogPath;
end;

procedure TnsExternalObjectPrim.RemoveUniqueTempCatalog;
const
 c_AllFilesMask: String = '*';
var
 l_IDX: Integer;
begin
 try
  if (f_TempCatalogPath <> '') and (DirectoryExists(f_TempCatalogPath)) then
  begin
   if Assigned(f_TempFilesList) then
    for l_IDX := 0 to TempFilesList.Count - 1 do
     ForceDeleteFile(f_TempCatalogPath+'\'+l3PStr(TempFilesList.ItemC[l_IDX]));
   RemoveDir(f_TempCatalogPath);
  end;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

function TnsExternalObjectPrim.PrepareFileName(const aName     : Il3CString;
                                           const aNameOnly : Boolean): Il3CString;
  {* - удаляет запрещенные для диалога сохранения символы в имени файла, а
       тажке ограничивает днинну имени файла половиной максимально
       допустимой в операционной системе. }
var
 l_MaxNameLength : Integer;
begin
 // Надо убрать точки в конце файла, иначе после добавления суффикса
 // в фукнции MakeTemporaryFileName (GetRandomSuffix) расширение файла станет
 // неправильным (для примера .... B5B6). (CQ: OIT500021216):
 Result := nsDeleteFileNameDots(aName);
 if not aNameOnly then
 begin
  // Оставляем место для завершающего символа, т.к. MAX_PATH = A path is
  // structured in the following order: drive letter, colon, backslash,
  // components separated by backslashes, and a null-terminating character;
  l_MaxNameLength := Pred(MAX_PATH);
  Dec(l_MaxNameLength, Length(f_TempCatalogPath));
  Dec(l_MaxNameLength, 1); // Length('\')
  Dec(l_MaxNameLength, 1); // Length(' ')
  Dec(l_MaxNameLength, 4); // Length(RandomSuffix)
  Dec(l_MaxNameLength, 4); // Length(Extension)
 end//not(aNameOnly)
 else
  l_MaxNameLength := MAX_PATH div 2;
 l3MReplace(Result,
            ['"',  '*', '/', '?', '\', '|', ':',   '<', '>', #$A, #$D],
            ['''', '_', '_', '_', '_', '_', ' - ', '(', ')', ' ', ' ']);
 Result := l3DeleteDoubleSpace(Result);
 if (l_MaxNameLength <= 0) then
  ERangeError.CreateRes(@SRangeError)
 else
 if (l3Len(Result) > l_MaxNameLength) then
  l3SetLen(Result, l_MaxNameLength);
end;//PrepareFileName

function TnsExternalObjectPrim.MakeTemporaryFileName(const aName             : Il3CString;
                                                 const aExtension        : String;
                                                 const aWithFileCreation : Boolean): Il3CString;
  {* - готовит путь к файлу для сохранения во временную директорию, а также
       обеспечивает уникальность имени файла во временной директории. }

 function CreateFile(const aName: Il3CString): Boolean;
 var
  l_Handle: Integer;
 begin
  l_Handle := FileCreate(l3PStr(aName));
  if (l_Handle <= 0) then
  begin
   Result := False;
  end
  else
  begin
   FileClose(l_Handle);
   Result := True;
  end;
 end;

const
 c_NamePrefix = '~TMP';
var
 l_Name       : Il3CString;
 l_FileName   : Il3CString;
 l_NameSpace  : String;
 l_NameSuffix : String;
begin
 if l3IsNil(aName) then
 begin
  l_Name := nsCStr(c_NamePrefix);
  l_NameSuffix := GetRandomSuffix;
 end//if l3IsNil(aName) then
 else
 begin
  l_Name := PrepareFileName(aName);
  if ANSICompareText(aExtension, ExtractFileExt(l3PStr(l_Name))) = 0 then
   l_Name := nsCStr(ChangeFileExt(l3PStr(l_Name),''));
  l_NameSpace := '';
  l_NameSuffix := '';
 end;//if l3IsNil(aName) then
 CreateDir(f_TempCatalogPath);
 repeat
  l_FileName := l3Cat(l_Name, l_NameSpace + l_NameSuffix + aExtension);
  Result := l3Cat(f_TempCatalogPath + '\', l_FileName);
  if not FileExists(l3PStr(Result)) and
    (not aWithFileCreation or CreateFile(Result)) then
   Break;
  l_NameSpace := ' ';
  l_NameSuffix := GetRandomSuffix;
  Sleep(0);
   // - отдаем неиспользованное время другим процессам/нитям;
 until False;
 if (TempFilesList.IndexOf(l_FileName) = -1) then
  TempFilesList.Add(l_FileName);
end;//MakeTemporaryFileName

constructor TnsExternalObjectPrim.Create;
begin
 inherited Create;
 //
 CreateUniqueTempCatalog;
end;

procedure TnsExternalObjectPrim.Cleanup;
begin
 RemoveUniqueTempCatalog;
 f_TempFilesList := nil;
 //
 inherited;
end;

function TnsExternalObjectPrim.Execute(const aExternalObject: IExternalObject): Boolean;
var
 l_ExternalFileName: Il3CString;
begin
 l_ExternalFileName := MakeTemporaryFileName(nsGetExternalObjectName(aExternalObject), l3PStr(nsGetExternalObjectExt(aExternalObject)));
 //
 with Tl3FileStream.Create(l3PStr(l_ExternalFileName), l3_fmWrite) do
  try
   with aExternalObject do
    WriteBuffer(GetDataPointer^, Longint(GetDataSize));
  finally
   Free;
  end;
 //
 Result := nsDoShellExecute(l_ExternalFileName, True);
 if (not(Result)) then
  ForceDeleteFile(l3PStr(l_ExternalFileName));
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function TnsExternalObjectStream.pm_getExternalObjectName: Il3CString;

 function CorrectWrongSymbols(const aName: Il3CString): Il3CString;
 begin//CorrectWrongSymbols
  Result := aName;
  l3MReplace(Result,
             ['"',  '*', '/', '?', '\', '|', ':',   '<', '>', #$A, #$D],
             ['''', '_', '_', '_', '_', '_', ' - ', '(', ')', ' ', ' ']);
  Result := l3DeleteDoubleSpace(Result);
 end;//CorrectWrongSymbols

 begin
 Result := CorrectWrongSymbols(nsGetExternalObjectName(f_ExternalObject));
end;

procedure TnsExternalObjectStream.SetSize(a_Size: Longint);
begin
 raise EStreamError.Create('Unsupported');
end;

constructor TnsExternalObjectStream.Create(const aExternalObject: IExternalObject);
begin
 inherited Create;
 //
 f_ExternalObject := aExternalObject;
end;

procedure TnsExternalObjectStream.Cleanup;
begin
 f_ExternalObject := nil;
 //
 inherited;
end;

function TnsExternalObjectStream.Read(var aBuffer; aCount: Longint): Longint;
var
 l_DataSize: Int64;
begin
 l_DataSize := Int64(f_ExternalObject.GetDataSize);
 //
 if ((f_Position + Int64(aCount)) > l_DataSize) then
  Result := Longint(l_DataSize-f_Position)
 else
  Result := aCount;
 // 
 if (Result <> 0) then
 begin
  l3Move(PAnsiChar(f_ExternalObject.GetDataPointer)[f_Position], aBuffer, Integer(Result));
  f_Position := f_Position + Result;
 end;//Result <> 0
end;

function TnsExternalObjectStream.Write(const aBuffer; aCount: Longint): Longint;
begin
 Result := 0;
 Assert(false);
 // - наверное нельзя писать в чужой поток
end;

function TnsExternalObjectStream.Seek(const anOffset: Int64; anOrigin: TSeekOrigin): Int64;
  //override;
var
 l_DataSize : Int64;
begin
 l_DataSize := Int64(f_ExternalObject.GetDataSize);
 case anOrigin of
  soBeginning:
   f_Position := anOffset;
  soCurrent:
   f_Position := f_Position + anOffset;
  soEnd:
   f_Position := l_DataSize + anOffset;
  else
   Assert(False, Format('Unsupported Origin Value: $%.4x', [Ord(anOrigin)]));
 end;//case anOrigin
 //
 if (f_Position > l_DataSize) then
  f_Position := l_DataSize
 else
 if (f_Position < 0) then
  f_Position := 0;
 Result := f_Position;
end;

procedure TnsExternalObjectStream.SaveToFile(const aFileName: TFileName);
var
 l_Count: Int64;
 l_Position: Int64;
begin
 l_Count := Size;
 l_Position := Position;
 try
  Position := 0;
  //
  with TFileStream.Create(aFileName,fmCreate) do
   try
    CopyFrom(Self,l_Count);
   finally
    Free;
   end;//try..finally
 finally
  Position := l_Position;
 end;//try..finally
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function ExternalObject: TnsExternalObjectPrim;
begin
 Result := TnsExternalObject.Instance;
end;

function nsInsertFileIntoWord(const aFile: Il3CString): Boolean;
 {-}
var
 l_App: Variant;
 l_Wnd: Variant;
 l_File: WideString;
begin
 Result := True;
 l_File := vcmDStr(aFile);
 try
  l_App := GetActiveOleObject('Word.Application');
  try
   try
    l_Wnd := l_App.ActiveWindow;
    try
     l_Wnd.Selection.InsertFile(l_File);
     l_App.Activate;
     DeleteFile(nsEStr(aFile));
    finally
     l_Wnd := null;
    end;
   except
    on EOleException do
     Result := False;
   end;
  finally
   l_App := null;
  end;
 except
  on EOleSysError do
   Result := False;
 end;
end;

function IsValidDefaultBrowser: Boolean;
begin
 Result := nsIsValidBrowser(nsGetBrowserType(nsGetDefaultBrowserString), True);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=563197648,
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565248245
end;

function RunValidBrowser(const anURL: Il3CString): Boolean;
var
 l_StartupInfo: TStartupInfo;
 l_ProcessInformation: TProcessInformation;
 l_ShellExecuteInfo: {$IfDef XE}TShellExecuteInfoA{$Else}TShellExecuteInfo{$EndIf};
 l_ValidBrowserExeName: String;
begin
 l_ValidBrowserExeName := nsGetFirstValidBrowserExeName;
 if (l_ValidBrowserExeName = '') then
 begin
  Assert(False); // Не должны были сюда попасть в таком случае
  Result := False;
  Exit;
 end;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=563197648
 l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
 with l_ShellExecuteInfo do
 begin
  cbSize := SizeOf(l_ShellExecuteInfo);
  lpVerb := 'open';
  lpFile := PChar(l_ValidBrowserExeName);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=563197648
  lpParameters := nsAStr(anURL).S;
  nShow := SW_SHOWNORMAL;
 end;//with l_ShellExecuteInfo
 Result := ShellExecuteExA(@l_ShellExecuteInfo);
end;

function nsDoShellExecuteEx(const aFile: Il3CString; SetReadOnlyToFile: Boolean;
 const aContainerMaker: IvcmContainerMaker; IgnoreGarantURL: Boolean = False): Boolean;

 function lp_IsLocalFile(const aFileName: Il3CString): Boolean;
 begin
  Result := FileExists(l3Str(aFileName));
 end;

 function lp_IsJudgeArchiveURL(const anURL: Il3CString): Boolean;
 const
  c_Http = 'http://';
  c_Slash = '/';
  c_TestArchiveURL = 'http://test_arbitr.garant.ru';
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=555385722&focusedCommentId=565272487#comment-565272487
 var
  l_ArchiveURL: IString;
  l_LastSlashPos: Integer;
  l_RealURLStartsPos: Integer;
  l_RealURL: Il3CString;
  l_URLWithPrefix: Il3CString;
 begin
  Result := False;
  if DefDataAdapter.IsInternetAgentEnabled then
  begin
   DefDataAdapter.NativeAdapter.MakeDecisionsArchiveSupport.GetArchiveUrl(l_ArchiveURL);
   if (l_ArchiveURL <> nil) then
   try
    if l3Starts(l3CStr(c_Http), anURL) then
    begin
     l_RealURLStartsPos := Length(c_Http);
     l_RealURL := l3Copy(anURL, l_RealURLStartsPos,
      l3Len(anURL) - l_RealURLStartsPos)
    end
    else
     l_RealURL := anURL;
    l_LastSlashPos := l3Pos(l_RealURL, l3CStr(c_Slash));
    if (l_LastSlashPos <> -1) then
      l_RealURL := l3Prefix(l_RealURL, c_Slash);
    l_URLWithPrefix := l3Cat(c_Http, l_RealURL);
    Result := l3Starts(l_URLWithPrefix, nsCStr(l_ArchiveURL)) OR
              l3Starts(l_URLWithPrefix, l3CStr(c_TestArchiveURL));
   finally
    l_ArchiveURL := nil;
    l_RealURL := nil;
   end;
  end;
 end;

var
 l_ShellExecuteInfo: {$IfDef XE}TShellExecuteInfoA{$Else}TShellExecuteInfo{$EndIf};
 l_Handle: THandle;
 l_FindData: {$IfDef XE}TWin32FindDataA{$Else}TWin32FindData{$EndIf};
 l_File: Il3CString;
 l_ArchiveUrl : IString;
 l_URL: WideString;
 l_I: Integer;
 l_QuotedFileName: String;
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 //http://mdp.garant.ru/pages/viewpage.action?pageId=431371899
 if (not lp_IsLocalFile(aFile)) then
 begin
  afw.BeginOp;
  try
   // Ссылки на документы в архиве судебных решений открываем в браузере всегда
   // http://mdp.garant.ru/pages/viewpage.action?pageId=475468995
   // Ссылки на конструктор договоров открываем в браузере
   // http://mdp.garant.ru/pages/viewpage.action?pageId=482258671
   if (not IgnoreGarantURL) then
   begin
    l_URL := l3WideString(aFile);
    // Ссылки на i.garant.ru открываем во внешнем окне браузера
    // http://mdp.garant.ru/pages/viewpage.action?pageId=484018812
    IgnoreGarantURL := lp_IsJudgeArchiveURL(aFile) OR
     nsNeedOpenLinkInExternalBrowser(l_URL);
   end;
   if not SetReadOnlyToFile AND defDataAdapter.IsInternetAgentEnabled AND nsNeedOpenLinkInInternalBrowser(l3WideString(aFile)) then
   begin
    TdmStdRes.MakeInternetAgent(aFile, aContainerMaker.MakeContainer);
    Result := true;
    Exit;
   end;//not SetReadOnlyToFile AND nsIsGarantURL(l3WideString(aFile))
   if (not nsNeedOpenLinkInInternalBrowser(l3WideString(aFile))) and
      not IsValidDefaultBrowser and
      (nsGetFirstValidBrowserExeName <> '') then
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=563197648
   begin
    Result := RunValidBrowser(aFile);
    Exit;
   end;
  finally
   afw.EndOp;
  end;
 end;
 {$IfEnd} //not Admin AND not Monitorings
 l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
 //http://mdp.garant.ru/pages/viewpage.action?pageId=431371899
 afw.BeginOp;
 try
  with l_ShellExecuteInfo do
  begin
   cbSize := SizeOf(l_ShellExecuteInfo);
   lpFile := PChar(nsAStr(aFile).S);
   if SetReadOnlyToFile then
   begin
    l_Handle := Windows.FindFirstFileA(lpFile, l_FindData);
    if l_Handle <> INVALID_HANDLE_VALUE then
    begin
     Windows.FindClose(l_Handle);
     SetFileAttributesA(lpFile, GetFileAttributesA(lpFile) or faReadOnly);
    end;
   end;
   nShow := SW_SHOWNORMAL;
  end;//with l_ShellExecuteInfo
  Result := ShellExecuteExA(@l_ShellExecuteInfo);
 finally
  afw.EndOp;
 end;
end;

type
 TnsContainerMaker = class(Tl3ProtoObject, IvcmContainerMaker)
 private
  f_Container: Pointer;
 protected
  function MakeContainer: IvcmContainer;
  procedure CleanUp; override;
 public
  constructor Create(const aContainer: IvcmContainer);
  class function Make(const aContainer: IvcmContainer): IvcmContainerMaker;
 end;

function TnsContainerMaker.MakeContainer: IvcmContainer;
begin
 Result := IvcmContainer(f_Container);
end;

procedure TnsContainerMaker.CleanUp;
begin
 f_Container := nil;
 inherited;
end;

constructor TnsContainerMaker.Create(const aContainer: IvcmContainer);
begin
 inherited Create;
 f_Container := Pointer(aContainer);
end;

class function TnsContainerMaker.Make(const aContainer: IvcmContainer): IvcmContainerMaker;
var
 l_Inst : TnsContainerMaker;
begin
 l_Inst := Create(aContainer);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function nsDoShellExecute(const aFile: Il3CString; SetReadOnlyToFile: Boolean = False;
 const aContainer: IvcmContainer = nil; IgnoreGarantURL: Boolean = False): Boolean;
var
 l_ContainerMaker: IvcmContainerMaker;
begin
 l_ContainerMaker := TnsContainerMaker.Make(aContainer);
 try
  Result := nsDoShellExecuteEx(aFile, SetReadOnlyToFIle, l_ContainerMaker,
   IgnoreGarantURL);
 finally
  l_ContainerMaker := nil;
 end;
end;


function IsVistaWithMail: Boolean;
var
 l_Reg: TRegistry;
begin
 Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion = 6);
 if Result then
 begin
  l_Reg := TRegistry.Create;
  try
   l_Reg.RootKey := HKEY_LOCAL_MACHINE;
   with l_Reg do
    Result := OpenKeyReadOnly('SOFTWARE\Clients\Mail') and (ReadString('') = 'Windows Mail');
  finally
   FreeAndNil(l_Reg);
  end;
 end;
end;

function IsMailPresent: Boolean;
var
 l_Reg: TRegistry;
begin
  l_Reg := TRegistry.Create;
  try
   l_Reg.RootKey := HKEY_CURRENT_USER;
   with l_Reg do
   begin
    Result := OpenKeyReadOnly('SOFTWARE\Clients\Mail') and l_Reg.ValueExists('') and
     (ReadString('') <> '');
    if not Result then
    begin
     CloseKey;
     l_Reg.RootKey := HKEY_LOCAL_MACHINE;
     Result := OpenKeyReadOnly('SOFTWARE\Clients\Mail') and l_Reg.ValueExists('') and
      (ReadString('') <> '');
    end;
   end;
  finally
   FreeAndNil(l_Reg);
  end;
end;

function nsSendAttachedFile(const aFile: Il3CString): Boolean;
 {-}
var
 l_Msg: TMapiMessage;
 l_FileDesc: TMapiFileDesc;
 l_FileName: String;
 l_Result: Cardinal;
 l_WOrkAround: Boolean;

 function lp_SendSuccess(aResult: Cardinal): Boolean;
 begin
  Result := (aResult = SUCCESS_SUCCESS) or (aResult = MAPI_USER_ABORT);
 end;

 function lp_MAPISendMail(lhSession: LHANDLE; ulUIParam: Cardinal;
    var lpMessage: TMapiMessage; flFlags: FLAGS;
    ulReserved: Cardinal): Cardinal;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=391840102
 var
  l_MAPIModule: HModule;
  l_MAPISendMail: TFNMapiSendMail;
 begin
  l_MAPIModule := 0;
  l_MAPISendMail := nil;
  try
   l_MAPIModule := LoadLibrary(PChar(MAPIDLL));
   try
    @l_MAPISendMail := GetProcAddress(l_MAPIModule, 'MAPISendMail');
    if @l_MAPISendMail <> nil then
     Result := l_MAPISendMail(lhSession, ulUIParam, lpMessage, flFlags, ulReserved)
    else
     Result := MAPI_E_FAILURE;
   finally
    if l_MAPIModule <> 0 then
     FreeLibrary(l_MAPIModule);
   end;
  except
   Result := MAPI_E_FAILURE;
  end;
 end;

var
  l_ActiveWindow: HWnd;
  l_WindowList: Pointer;
  l_FPUControlWord: Word;
  l_FocusState: TFocusState;
begin
 if not IsMailPresent then
  raise EDefaultMailCLientAbsent.Create('');
 l3FillChar(l_FileDesc, SizeOf(l_FileDesc));
 l_FileDesc.nPosition := $FFFFFFFF;
 l_FileDesc.lpszPathName := nsAStr(aFile).S;
 l_FileDesc.lpszFileName := PANSIChar(ExtractFileName(nsEStr(aFile)));
 l3FillChar(l_Msg, SizeOf(l_Msg));
 l_Msg.lpszSubject := nsAStr(vcmFmt(str_MailSubject, [nsCStr(l_FileDesc.lpszFileName)])).S;
 l_Msg.nFileCount := 1;
 l_Msg.lpFiles := @l_FileDesc;
 l_WOrkAround := IsVistaWithMail;
 l_WOrkAround := false;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=278837963
 if l_WOrkAround then
 begin
  //g_WasMailSendWorkaround := true;
  SetWindowPos(Application.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
 end;//l_WOrkAround
 try
  // Устаиваем все это поскольку окно почтовика показывается как модальное, но
  // из под другого процесса. Поэтому на активации до него не доходит
  // и он прячется за нашим окном. К-116851167
  l_ActiveWindow := GetActiveWindow;
  try
   l_WindowList := DisableTaskWindows(0);
   try
    l_FocusState := SaveFocusState;
    try
      Application.HookMainWindow(ExternalObject.MessageHook);
      try
       asm
        // Avoid FPU control word change in NETRAP.dll, NETAPI32.dll, etc
        FNSTCW  l_FPUControlWord
       end;//asm
       try
        l_Result := lp_MAPISendMail(0, Application.Handle, l_Msg, MAPI_DIALOG or MAPI_LOGON_UI, 0);
        if not lp_SendSuccess(l_Result) then
         l_Result := lp_MAPISendMail(0, Application.Handle, l_Msg, MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);
       finally
        asm
         FNCLEX
         FLDCW l_FPUControlWord
        end;//asm
       end;//try..finally
      finally
       Application.UnhookMainWindow(ExternalObject.MessageHook);
      end;//try..finally
    finally
     RestoreFocusState(l_FocusState);
    end;//try..finally
   finally
    EnableTaskWindows(l_WindowList);
   end;//try..finally
  finally
   SetActiveWindow(l_ActiveWindow);
  end;//try..finally
 finally
  if l_WOrkAround then
   //SetWindowPos(Application.Handle, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=278837963
   SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
(*    if (Screen.ActiveForm <> nil) then
     Screen.ActiveForm.SendToBack;*)
   // http://mdp.garant.ru/pages/viewpage.action?pageId=278837963
   // тут это - не помогает :-(
 end;//try..finally
 Result := lp_SendSuccess(l_Result);
end;

function nsExtractURL(const aExternalLink: IExternalLink): Il3CString;
var
 l_URL: IString;
begin
 if Assigned(aExternalLink) then
 begin
  aExternalLink.GetUrl(l_URL);
  //
  if Assigned(l_URL) then
   try
    Result := nsCStr(l_URL);
   finally
    l_URL := nil;
   end;//try..finally
 end
 else
  Result := nil;
end;

function nsExecuteExternalLink(const aExternalLink: IExternalLink; const aCont: IvcmContainer = nil): Boolean;
var
 l_ContainerMaker: IvcmContainerMaker;
begin
 l_ContainerMaker := TnsContainerMaker.Make(aCont);
 try
  Result := nsExecuteExternalLinkEx(aExternalLink, l_ContainerMaker);
 finally
  l_ContainerMaker := nil;
 end;
end;

function nsExecuteExternalLinkEx(const aExternalLink: IExternalLink; const aContainerMaker: IvcmContainerMaker): Boolean;
begin
 Result := False;
 if Assigned(aExternalLink) then
  Result := nsDoShellExecuteEx(nsExtractURL(aExternalLink), False, aContainerMaker)
 else
  Result := False;
end;


function nsExecuteExternalObject(const aExternalObject: IExternalObject): Boolean;
begin
 Result := ExternalObject.Execute(aExternalObject);
end;

function nsPrepareFileName(const aName: Il3CString): Il3CString;
 {* - удаляет запрещенные для диалога сохранения символы в имени файла, а тажке
      ограничивает днинну имени максимально допустимой в операционной системе. }
begin
 Result := ExternalObject.PrepareFileName(aName, True);
end;//nsPrepareFileName

function nsMakeTemporaryFileName(const aName             : Il3CString;
                                 const aExtension        : String;
                                 const aWithFileCreation : Boolean): Il3CString;
 {* - готовит путь к файлу для сохранения во временную директорию, а также
      обеспечивает уникальность имени файла во временной директории. }
begin
 Result := ExternalObject.MakeTemporaryFileName(aName,
                                                aExtension,
                                                aWithFileCreation);
end;//nsMakeTemporaryFileName

function nsGetExternalObjectExt(const aExternalObject: IExternalObject): Il3CString;
var
 l_String: IString;
begin
 if Assigned(aExternalObject) then
 begin
  aExternalObject.GetExtension(l_String);
  Result := nsCStr(l_String);
 end//Assigned(aExternalObject)
 else
  Result := nil;
end;

function nsGetExternalObjectName(const aExternalObject: IExternalObject): Il3CString;
var
 l_String: IString;
begin
 if Assigned(aExternalObject) then
 begin
  aExternalObject.GetName(l_String);
  Result := nsCStr(l_String);
 end//Assigned(aExternalObject)
 else
  Result := nil;
end;

procedure nsSetExportFilters(const aFormat    : TnsFileFormat;
                             var aGenerator   : Tk2TagGenerator;
                             HideTechComments : Boolean);
begin
 //TddSectionRepairFilter.SetTo(aGenerator);
 TevdPageParamsFilter.SetTo(afw.Application.PrintManager.PageSetup, nil, aGenerator);
 if (aFormat <> ns_ffEVD) then
 begin
  TevStyleHeaderAdder.SetTo(aGenerator);
  TevUserCommentFilter.SetTo(aGenerator);
 end;//aFormat <> ns_ffEVD
 if HideTechComments then
  TevHiddenFilter.SetTo([-ev_saTechComment], true, aGenerator);
end;

function nsEvdStreamSave(const aGenerator : Tk2CustomFileGenerator;
                         aHead            : Tk2TagGenerator;
                         const aStream    : IStream;
                         var anOutput: TnsGetGenOutputStruct;
                         const aFormat    : TnsFileFormat;
                         HideTechComments: Boolean): Boolean;
const
 c_TimeOut = 5000; // таймаут на открытие файла (измеряется в тиках)
var
 l_TargetFiler  : Tl3CustomFiler;
 l_SourceFiler  : Tl3CustomFiler;
 l_EvdReader    : TevdNativeReader;
 l_Generator    : Tk2TagGenerator;
begin
 Result := False;
 //
 if (not Assigned(aStream)) or (not Assigned(aGenerator)) then
  Exit;
 //
 try
  l_SourceFiler := Tl3CustomFiler.Create(nil);
  try
   l_SourceFiler.COMStream := aStream;
   if not l3IsNil(anOutput.rName) then
    l_TargetFiler := Tl3DOSFiler.Make(l3PStr(anOutput.rName), l3_fmWrite, True, c_TimeOut)
   else
   begin
    l_TargetFiler := Tl3CustomFiler.Create;
    l_TargetFiler.COMStream := anOutput.rStream;
   end;
   try
    aGenerator.Filer := l_TargetFiler;
    //
    l_EvdReader := TevdNativeReader.Create;
    try
     //l_EvdReader.CurrentVersion := evNonPackedVer;
     l_EvdReader.Filer := l_SourceFiler;
     l_Generator := aHead.Use;
     try
      nsSetExportFilters(aFormat, l_Generator, HideTechComments);
      l_EvdReader.Generator := l_Generator;
     finally
      l3Free(l_Generator);
     end;//try..finally
     //
     l_EvdReader.Execute;
    finally
     l3Free(l_EvdReader);
    end;
   finally
    l3Free(l_TargetFiler);
   end;
  finally
   l3Free(l_SourceFiler);
  end;
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Exit;
  end;
 end;
 Result := True;
end;

function nsEvdStreamSave(const aGenerator : Tk2CustomFileGenerator;
                         aHead            : Tk2TagGenerator;
                         const aStream    : InevObjectHolder;
                         var anOutput: TnsGetGenOutputStruct;
                         const aFormat    : TnsFileFormat;
                         HideTechComments: Boolean): Boolean;
 //overload;
 {-}
const
 c_TimeOut = 5000; // таймаут на открытие файла (измеряется в тиках)
var
 l_TargetFiler : Tl3CustomFiler;
 l_Generator   : Tk2TagGenerator;
 l_Obj         : InevObject;
begin
 Result := False;
 //
 if (not Assigned(aStream)) or (not Assigned(aGenerator)) then
  Exit;
 //
 try
  if not l3IsNil(anOutput.rName) then
   l_TargetFiler := Tl3DOSFiler.Make(l3PStr(anOutput.rName), l3_fmWrite, True, c_TimeOut)
  else
  begin
   l_TargetFiler := Tl3CustomFiler.Create;
   l_TargetFiler.COMStream := anOutput.rStream;
  end;
  try
   aGenerator.Filer := l_TargetFiler;
   l_Obj := aStream.Obj;
   l_Generator := aHead.Use;
   try
    nsSetExportFilters(aFormat, l_Generator, HideTechComments);
    l_Generator.Start;
    try
     l_Generator.StartChild(l_Obj.AsObject.TagType);
     try
      l_Obj.AsObject.WriteTag(l_Generator);
     finally
      l_Generator.Finish;
     end;//try..finally
    finally
     l_Generator.Finish;
    end;//try..finally
   finally
    l3Free(l_Generator);
   end;//try..finally
  finally
   l3Free(l_TargetFiler);
  end;//try..finally
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Exit;
  end;
 end;//try..except
 Result := True;
end;

function nsEvdStreamSaveAs(const aStream : IStream;
                           var anOutput: TnsGetGenOutputStruct;
                           const aFormat : TnsFileFormat;
                           HideTechComments: Boolean): Boolean;
var
 l_Generator : Tk2CustomFileGenerator;
 l_G         : Tk2TagGenerator;
 l_H         : Tk2TagGenerator;
begin
 Result := False;
 try
  case aFormat of
   ns_ffNull:
   begin
    l_G := Tk2FakeGenerator.Create;
    try
     TevdNativeReader.SetTo(l_G, aStream);
     //TevdNativeReader(l_G).CurrentVersion := evNonPackedVer;
     TevdNativeReader(l_G).Execute;
     Result := true;
     Exit;
    finally
     l3Free(l_G);
    end;//try..finally
   end;//ns_ffNull
   else
   if nsGetGen(anOutput, aFormat, l_Generator, l_H) then
   begin
    if Assigned(l_Generator) then
     try
      Result := nsEvdStreamSave(l_Generator, l_H, aStream, anOutput, aFormat, HideTechComments);
     finally
      FreeAndNil(l_H);
      l3Free(l_Generator);
     end;
   end;//nsGetGen
  end;//case aFormat
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Exit;
  end;
 end;
end;

function nsEvdStreamSaveAs(const aStream : InevObjectHolder;
                           var anOutput: TnsGetGenOutputStruct;
                           const aFormat : TnsFileFormat;
                           HideTechComments: Boolean): Boolean;
 //overload;
 {-}
var
 l_Generator : Tk2CustomFileGenerator;
 l_G         : Tk2TagGenerator;
 l_H         : Tk2TagGenerator;
 l_Obj       : InevObject;
begin
 Result := False;
 try
  case aFormat of
   ns_ffNull:
   begin
    l_Obj := aStream.Obj;
    l_G := Tk2FakeGenerator.Create;
    try
     l_G.Start;
     try
      l_G.StartChild(l_Obj.AsObject.TagType);
      try
       l_Obj.AsObject.WriteTag(l_G);
      finally
       l_G.Finish;
      end;//try..finally
     finally
      l_G.Finish;
     end;//try..finally
     Result := true;
     Exit;
    finally
     l3Free(l_G);
    end;//try..finally
   end;//ns_ffNull
   else
   if nsGetGen(anOutput, aFormat, l_Generator, l_H) then
   begin
    if Assigned(l_Generator) then
     try
      Result := nsEvdStreamSave(l_Generator, l_H, aStream, anOutput, aFormat, HideTechComments);
     finally
      FreeAndNil(l_H);
      l3Free(l_Generator);
     end;//try..finally
   end;//nsGetGen
  end;//case aFormat
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Exit;
  end;
 end;//try..except
end;

function nsGetGen(var anOutput: TnsGetGenOutputStruct;
                  const aFormat : TnsFileFormat;
                  out theGen    : Tk2CustomFileGenerator;
                  out theHead   : Tk2TagGenerator): Boolean;
 {-}
var
 l_Ext : String;
 l_G : Tk2TagGenerator;
begin
 Assert(Assigned(evGetWriterProc));
 theHead := nil;
 Result := false;
 theGen := nil;
 case aFormat of
  ns_ffRTF:
  begin
   l_G := nil;
   evGetWriterProc(nil, CF_RTF, l_G);
   try
    Assert(l_G <> nil);
    l_G.FindGeneratorByDesiredClass(Tk2CustomFileGenerator, theGen);
    l_G.SetRefTo(theHead);
   finally
    FreeAndNil(l_G);
   end;//try,,finally
   //theGen := TevRTFObjectGenerator.Create;
   l_Ext := c_nsFileFormatExt[aFormat];
  end;//ns_ffRTF
  ns_ffTxt:
  begin
   theGen := TevdPlainTextWriter.Create;
   l_Ext := c_nsFileFormatExt[aFormat];
  end;
  ns_ffHTML:
  begin
   theGen := TddHTMLGenerator.Create;
   l_Ext := c_nsFileFormatExt[aFormat];
  end;
  ns_ffXML:
  begin
   theGen := TevdXMLWriter.Create;
   l_Ext := c_nsFileFormatExt[aFormat];
  end;
  ns_ffEvd:
  begin
   theGen := TevdNativeWriter.Create;
   l_Ext := c_nsFileFormatExt[aFormat];
  end;
  ns_ffPDF:
  begin
   theGen := TevPDFWriter.Create;
   l_Ext := c_nsFileFormatExt[aFormat];
  end;
 end;//case aFormat
 if Assigned(theGen) then
 begin
  Result := true;
  if not l3IsNil(anOutput.rName) then
  begin
   anOutput.rName := nsCStr(ChangeFileExt(l3PStr(anOutput.rName), l_Ext));
  end;
  if (aFormat = ns_ffTxt) then
  begin
   Assert(theHead = nil);
   theHead := TevTextFormatter.Create;
   with TevTextFormatter(theHead) do
   begin
    {$If defined(Archi) or defined(EverestLite)}
    CodePage := CP_OEMLite;
    {$ELSE}
    CodePage := CP_ANSI{CP_KeepExisting};
    {$IFEND}
    SBSDelimeter := ' ';
    Generator := theGen;
    FormatOrdinalParas := true;
   end;{with TevTextFormatter(Writer)..}
  end//aFormat = ns_ffTxt
  else
  if (theHead = nil) then
   theHead := theGen.Use;
 end;//Assigned(theGen)
end;

procedure nsSaveMultiplyDocuments(const aList     : TnsDocumentStreamList;
                                  const aFileName : Il3CString;
                                  const aFormat: TnsFileFormat;
                                  const NeedPrintTopic: Boolean;
                                  HideTechComments: Boolean);
var
 l_IDX          : Integer;
 l_SourceStream : InevObjectHolder;
 //l_FileName     : Il3CString;
 l_Output: TnsGetGenOutputStruct;
 l_Generator    : Tk2CustomFileGenerator;
 l_G            : Tk2TagGenerator;
 l_H            : Tk2TagGenerator;
 l_TargetFiler  : Tl3CustomFiler;
 l_Extracter    : IbsDocumentStreamWrapper;
 l_Obj          : InevObject;
const
 c_TimeOut = 5000; // таймаут на открытие файла (измеряется в тиках)
begin
 if (aList.Count > 0) then
 begin
  //l_FileName := aFileName;
  l_Output := TnsGetGenOutputStruct_Create(aFileName);
  nsGetGen(l_Output, aFormat, l_Generator, l_H);
  try
   TevNestedDocumentEliminator.SetTo(l_H);
   if (l_Output.rName <> nil) then
    l_TargetFiler := Tl3DOSFiler.Make(l3PStr(l_Output.rName), l3_fmWrite, True, c_TimeOut)
   else
   begin
    l_TargetFiler := Tl3CustomFiler.Create;
    l_TargetFiler.COMStream := l_Output.rStream;
   end; 
   l_Generator.Filer := l_TargetFiler;
   try
    l_G := l_H.Use;
    try
     nsSetExportFilters(aFormat, l_G, HideTechComments);
     l_G.Start;
     try
      l_G.StartChild(k2_typDocument);
      try
       for l_IDX := 0 to aList.Count - 1 do
       begin
        l_Extracter := aList[l_IDX];
        try
         l_SourceStream := l_Extracter.EVDStream;
         if Assigned(l_SourceStream) then
         try
          l_Obj := l_SourceStream.Obj;
          if NeedPrintTopic then
          begin
           l_G.StartChild(k2_typTextPara);
           try
            l_G.AddStringAtom(k2_tiText, l3PCharLen(l_Extracter.InternalNumber));
           finally
            l_G.Finish;
           end;//try..finally
          end;//NeedPrintTopic
          l_G.StartChild(l_Obj.AsObject.TagType);
          try
           l_Obj.AsObject.WriteTag(l_G);
          finally
           l_G.Finish;
          end;//try..finally
         finally
          l_SourceStream := nil;
         end;//try..finally
        finally
         l_Extracter := nil;
        end;//try..finally
       end;
      finally
       l_G.Finish;
      end;//try..finally
     finally
      l_G.Finish;
     end;//try..finally
    finally
     l3Free(l_G);
    end;//try
   finally
    l3Free(l_TargetFiler);
   end;//try..finally
  finally
   FreeAndNil(l_H);
   l3Free(l_Generator);
  end;//try..finally
 end;//aList.Count > 0
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

type
 PFindRecord = ^TFindRecord;
 TFindRecord = record
  Wnd: HWnd;
  Found: Boolean;
 end;

function FindMailDialog(aWnd: HWND; aParam: Pointer): Bool; stdcall;
var
 l_Rec: TFindRecord;
begin
 Result := True;
 if (GetWindow(aWnd, GW_OWNER) = PFindRecord(aParam).Wnd) then
 begin
  if IsWindowEnabled(aWnd) then
  begin
   SetForegroundWindow(aWnd);
   Result := False;
  end
  else
  begin
   l_Rec.Wnd := aWnd;
   EnumWindows(@FindMailDialog, LongInt(@l_Rec));
   if l_Rec.Found then
    Result := False;
  end;
 end;
 PFindRecord(aParam).Found := not Result;
end;

function FindMailClient(aWnd: HWND; aParam: Pointer): Bool; stdcall;
var
 ProcessID: Cardinal;
 TheadID: Cardinal;
 l_Rec: TFindRecord;
begin
 Result := True;
 if GetWindow(aWnd, GW_OWNER) = Application.Handle then
 begin
  if (GetWindowThreadProcessId(aWnd, ProcessID) <> MainTHreadID) and
    IsWindowVisible(aWnd) then
  begin
   SendMessage(aWnd, PMessage(aParam)^.Msg, PMessage(aParam)^.wParam, PMessage(aParam)^.lParam);
   if IsWindowEnabled(aWnd) then
   begin
    SetForegroundWindow(aWnd);
    Result := False;
   end
   else
   begin
    l_Rec.Wnd := aWnd;
    EnumWindows(@FindMailDialog, LongInt(@l_Rec));
    if l_Rec.Found then
     Result := False;
   end;
  end;
 end;
end;

function TnsExternalObjectPrim.MessageHook(var Msg: TMessage): Boolean;
begin
 Result := False;
 if (Msg.Msg = WM_ACTIVATEAPP) and TWMActivateApp(Msg).Active then
 begin
  EnumWindows(@FindMailClient, LongInt(@Msg));
 end;
end;

procedure nsSetExportFilters4PDF(var aGenerator : Tk2TagGenerator; aHiddenStyles: TevStandardStyles);
begin
 evSetFilters4PDF(aGenerator, aHiddenStyles);
end;

initialization
 Randomize;

finalization

end.
