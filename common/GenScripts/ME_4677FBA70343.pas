unit l3Interfaces;

interface

uses
 l3IntfUses
 , Windows
 , l3PureMixIns
 , ActiveX
 , l3Core
;

type
 Tl3WString = object
  {* Строка с кодировкой и с длиной. }
 end;//Tl3WString
 
 Il3CString = interface
  {* Константная строка }
 end;//Il3CString
 
 Il3Base = interface
  {* Базовый интерфейс библиотеки L3 }
  function CheckStamp(const aGUID: TGUID): Boolean;
   {* Проверяет метку реализации интерфейса. Например для того, чтобы узнать, что реализация наша "родная". }
 end;//Il3Base
 
 TGUID = System.TGUID;
  {* GUID }
 
 Il3Reader = interface
  {* Читатель файла. }
  procedure execute;
   {* Выполняет процесс чтения файла. }
 end;//Il3Reader
 
 Il3Notify = interface
  {* Абстрактный подписчик. }
 end;//Il3Notify
 
 Il3CaretOwner = interface
  {* Владелец каретки ввода. }
  procedure RedrawCaret;
 end;//Il3CaretOwner
 
 Il3Lock = interface
  {* Замок. }
  procedure Lock(const aLocker: IUnknown);
   {* закрыть. }
  procedure Unlock(const aLocker: IUnknown);
   {* открыть. }
 end;//Il3Lock
 
 Il3FrameTextPainter = interface
  {* Рисователь текста рамки. }
  procedure DrawFrameText(aTop: Boolean);
   {* Рисует текст рамки. }
 end;//Il3FrameTextPainter
 
 IDataObject = ActiveX.IDataObject;
  {* Объект представляющий данные для буфера обмена или drag-and-drop. }
 
 Il3ChangeNotifier = interface
  {* Извещатель об изменении данных. }
  procedure Subscribe(const aRecipient: Il3Notify);
   {* подписка на извещения. }
  procedure Unsubscribe(const aRecipient: Il3Notify);
   {* "отписка" от извещений. }
 end;//Il3ChangeNotifier
 
 Il3Tool = interface
  {* Инструмент, привязанный к родителю. }
  procedure OwnerDead;
   {* Нотификация о смерти родителя. }
 end;//Il3Tool
 
 Il3ItemNotifyRecipient = interface(Il3Notify)
  {* Подписчик для получения нотификации об операции. }
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* прошла операция. }
 end;//Il3ItemNotifyRecipient
 
 Il3ChangeRecipient = interface(Il3Notify)
  {* Подписчик для получения нотификации об изменении данных. }
  procedure Changed;
   {* нотификация о завершении изменения состояния объекта. Для перекрытия и использования в потомках. }
  procedure Changing;
   {* нотификация о начале изменения состояния объекта. Для перекрытия и использования в потомках. }
 end;//Il3ChangeRecipient
 
 TPoint = l3Core.TPoint;
  {* Точка. }
 
 IEnumFormatEtc = IEnumFORMATETC;
  {* Итератор по данным внутри IDataObject. }
 
 Il3DataObjectInfo = interface
  {* Информация об объекте содержащимся в буфере обмена. }
 end;//Il3DataObjectInfo
 
 Tl3PCharLenPrim = Tl3WString;
  {* Строка с длинной. }
 
 Tl3FontIndex = (
  {* Индекс шрифта. }
  l3_fiNone
   {* нет. }
  , l3_fiSub
   {* нижний. }
  , l3_fiSuper
   {* верхний. }
  , l3_fiObject
   {* объект }
  , l3_fiBaseLined
 );//Tl3FontIndex
 
 Tl3TabStopStyle = (
  {* Стиль позиции табуляции. }
  l3_tssLeft
  , l3_tssCenter
  , l3_tssRight
  , l3_tssDecimal
  , l3_tssLine
 );//Tl3TabStopStyle
 
 Tl3Orientation = (
  {* Ориентация объекта. }
  ev_orNone
   {* неопределена. }
  , ev_orHorizontal
   {* горизонтально. }
  , ev_orVertical
   {* вертикально. }
 );//Tl3Orientation
 
 HResult = System.HResult;
 
 Tl3ClipboardFormat = Cardinal;
  {* Формат данных буфера обмена. }
 
 Tl3StringArray = array of AnsiString;
  {* Динамический массив строк. }
 
 Tl3StyleId = type Integer;
  {* Идентификатор таблицы стилей. }
 
 Tl3ClipboardFormats = array of Tl3ClipboardFormat;
  {* Набор форматов данных буфера обмена. }
 
 Tl3StoragePlace = TStgMedium;
  {* Приемник данных. }
 
 Tl3Color = l3Core.Tl3Color;
 
 LCID = l3Core.LCID;
  {* Идентификатор локали. }
 
 Il3LocaleInfo = interface
  {* Информация о локали. }
 end;//Il3LocaleInfo
 
 Il3SelectCountChangedRecipient = interface(Il3Notify)
  {* Подписчик для получения нотификации об изменении количества выделенных элементов. }
  procedure SelectCountChanged(anOldCount: Integer;
   aNewCount: Integer);
   {* прошла операция. }
 end;//Il3SelectCountChangedRecipient
 
 Il3ExternalTreeChangedRecipient = interface(Il3Notify)
  {* Подписчик для получения нотификации об изменении количества видимых элементов. }
  procedure ExternalVisibleCountChanged(aNewCount: Integer;
   aNodeIndex: Integer;
   aDelta: Integer);
   {* прошла операция. }
  procedure ExternalInvalidate;
   {* перерисуйся. }
  procedure ExternalModified(aNode: Integer;
   aDelta: Integer);
   {* в дереве были добавлены/удалены элементы.
             - aNode:
                 Узел ниже которого добавили/удалили узлы. Нумерация начинается
                 с нуля;
             - aDelta:
                 Количество элементов которое было добавлено/удалено. Если
                 aDelta со знаком минус элементы были удалены; }
 end;//Il3ExternalTreeChangedRecipient
 
 Il3MultipartText = interface
  {* Интерфейс для получения текста в виде кусочков (для многоколоночной ноды, в частности). }
  function GetTextPart(aIndex: Integer): Tl3PCharLenPrim;
   {* Возвращает кусок текста по индексу. }
 end;//Il3MultipartText
 
 Il3XMLWriter = interface
  {* Генератор XML. }
  procedure PutData(const aString: AnsiString); overload;
  procedure PutData(const aString: Il3CString); overload;
  procedure PutData(const aString: Tl3WString); overload;
  procedure OpenLevel(const aString: AnsiString); overload;
   {* открывает новый тег. }
  procedure OpenLevel(const aString: AnsiString;
   const aSuffix: AnsiString); overload;
   {* открывает новый тег. aSuffix - атрибуты тега. }
  procedure OpenSubLevel(const aSuffix: AnsiString);
   {* открывает подуровень, путем отрезания буквы "s" у предыдущего уровня. }
  procedure CloseLevel;
   {* закрывает тег. }
  function CS(const aSt: Tl3WString): AnsiString; overload;
   {* Escape'ит строку. }
  function CS(const aSt: Il3CString): AnsiString; overload;
   {* Escape'ит строку. }
  function CS(const aString: AnsiString): AnsiString; overload;
   {* Escape'ит строку. }
  procedure Start;
   {* начинает генерацию. }
  procedure Finish;
   {* заканчивает генерацию. }
 end;//Il3XMLWriter
 
 Il3AString = interface
  {* ANSI-строка. }
  function S: PAnsiChar;
   {* Собственно строка. }
 end;//Il3AString
 
 Il3RangeManager = interface
  {* Диапазон страниц. }
  function HasPage(anIndex: Integer): Boolean;
   {* содержит ли диапазон указанную страницу. }
 end;//Il3RangeManager
 
 TStrings = l3Core.TStrings;
  {* Список строк. }
 
 hDC = l3Core.hDC;
  {* Контекст устройства вывода. }
 
 Tl3PageOrientation = (
  {* Ориентация страницы. }
  l3_poPortrait
   {* книжная. }
  , l3_poLandscape
   {* альбомная. }
 );//Tl3PageOrientation
 
 Il3Strings = interface
  {* Список строк. }
 end;//Il3Strings
 
 Il3StringsEx = interface(Il3Strings)
  {* Список строк. }
  procedure Assign(const aStrings: Il3StringsEx); overload;
  procedure Assign(aStrings: TStrings); overload;
  function EQ(const aStrings: Il3StringsEx): Boolean;
  function Add(const aStr: AnsiString): Integer; overload;
  function Add(const Item: Il3CString): Integer; overload;
  function Add(const aStr: Tl3WString): Integer; overload;
  function AddObject(const aStr: AnsiString;
   anObject: TObject): Integer; overload;
  function AddObject(const aStr: Il3CString;
   anObject: TObject): Integer; overload;
  procedure Insert(aIndex: Integer;
   const aStr: Il3CString); overload;
  procedure Insert(aIndex: Integer;
   const aStr: AnsiString); overload;
  procedure BeginUpdate;
  procedure EndUpdate;
  procedure Clear;
  procedure Delete(anIndex: Integer);
  function IndexOf(const aSt: AnsiString): Integer; overload;
  function IndexOf(const aSt: Il3CString): Integer; overload;
  function IndexOf(const aSt: Tl3WString): Integer; overload;
 end;//Il3StringsEx
 
 Tl3OrientationSet = set of Tl3Orientation;
  {* Множество ориентаций объекта. }
 
 // Tl3Orientation1
 
 Tl3Inch = Integer;
  {* Дюйм. }
 
 Tl3_PointXY = record
 end;//Tl3_PointXY
 
 Tl3InchOArray = array [Tl3Orientation1] of Tl3Inch;
 
 Tl3InchBArray = array [Boolean] of Tl3Inch;
 
 Tl3PointSF = record
 end;//Tl3PointSF
 
 Tl3_PointUnion = record
 end;//Tl3_PointUnion
 
 Tl3_Point = object
  {* Базовая точка с координатами в дюймах (мировые координаты). }
 end;//Tl3_Point
 
 Tl3_RectLRTB = record
 end;//Tl3_RectLRTB
 
 Tl3_SPoint = object
  {* Базовая точка с координатами в пикселях (на экране). }
 end;//Tl3_SPoint
 
 Tl3_RectTB = record
 end;//Tl3_RectTB
 
 Tl3PointBArray = array [Boolean] of Tl3_Point;
 
 Tl3_RectUnion = record
 end;//Tl3_RectUnion
 
 Tl3_Rect = object
  {* Прямоугольник. }
 end;//Tl3_Rect
 
 Il3Meter = interface
  {* Индикатор прогресса }
  procedure ProgressProc(aState: Byte;
   aValue: Integer;
   const aMsg: Il3CString);
  procedure FreeNotification(AComponent: TComponent);
  procedure RemoveFreeNotification(AComponent: TComponent);
 end;//Il3Meter
 
 Il3SimpleView = interface
  procedure Update;
 end;//Il3SimpleView
 
 Il3Window = interface
  {* Окно. }
  procedure Invalidate;
   {* Запрос на перерисовку. }
 end;//Il3Window
 
 IStream = ActiveX.IStream;
  {* Поток. }
 
 Il3TempStream = interface
  {* Хранилище временных данных. }
  function MakeForWrite(aNeedCompression: Boolean): IStream;
   {* Создает поток для записи. }
  function MakeForRead: IStream;
   {* Создает поток для чтения. }
 end;//Il3TempStream
 
 Il3DropTarget = interface
  {* Место куда можно опустить объект. }
  function GetAcceptableFormats: Tl3ClipboardFormats;
   {* Список приемлимых форматов. }
  function DoDrop(aFormat: Tl3ClipboardFormat;
   const aMedium: Tl3StoragePlace;
   var dwEffect: Integer): Boolean;
  function DoDragOver(const aData: IDataObject;
   const aPoint: TPoint): Boolean;
  procedure DoDragEnter(const aData: IDataObject;
   const aPoint: TPoint);
  procedure DoDragLeave;
  function Keys2Effect(aKeys: Integer): Integer;
 end;//Il3DropTarget
 
 TFormatEtc = ActiveX.TFormatEtc;
 
 PMsg = l3Core.PMsg;
 
 Tl3HookProcResult = record
 end;//Tl3HookProcResult
 
 LPARAM = l3Core.LPARAM;
 
 WPARAM = l3Core.WPARAM;
 
 Il3Listener = interface
 end;//Il3Listener
 
 Il3ToolOwner = interface
  {* Менеджер инструментов. }
  procedure AddTool(const aTool: Il3Tool);
   {* Добавить инструмент. }
  procedure RemoveTool(const aTool: Il3Tool);
   {* Удалить инструмент. }
 end;//Il3ToolOwner
 
 IDropSource = ActiveX.IDropSource;
 
 IDropTarget = ActiveX.IDropTarget;
 
 IAdviseSink = ActiveX.IAdviseSink;
 
 IEnumStatData = ActiveX.IEnumStatData;
 
 PFormatEtc = ActiveX.PFormatEtc;
 
 hWnd = l3Core.hWnd;
 
 HPALETTE = l3Core.HPALETTE;
 
 HMETAFILE = l3Core.HMETAFILE;
 
 HGLOBAL = l3Core.HGLOBAL;
 
 Tl3CheckBoxState = (
  {* Состояние Checkbox'а. }
  l3_cbUnchecked
   {* Не выбран. }
  , l3_cbChecked
   {* Выбран. }
  , l3_cbGrayed
   {* Запрещен. }
 );//Tl3CheckBoxState
 
 Tl3ButtonState = (
  {* Состояние кнопки. }
  l3_bsUp
   {* Отжата. }
  , l3_bsDisabled
   {* Запрещена. }
  , l3_bsDown
   {* Нажата. }
  , l3_bsExclusive
   {* <?> Коллеги, это что? }
 );//Tl3ButtonState
 
 Tl3Alignment = (
  {* Выравнивание. }
  l3_taLeftJustify
   {* Влево. }
  , l3_taRightJustify
   {* Вправо. }
  , l3_taCenter
   {* По центру. }
 );//Tl3Alignment
 
 Tl3ValueMapID = record
  {* Идентификатор мапы. }
 end;//Tl3ValueMapID
 
 Il3ValueMap = interface
  {* базоый интерфейс для пар "строка"-нечто. }
  procedure GetDisplayNames(const aList: Il3StringsEx);
   {* заполняет список значениями "UI-строка" }
  function MapSize: Integer;
   {* количество элементов в мапе. }
 end;//Il3ValueMap
 
 Il3StringValueMap = interface(Il3ValueMap)
  {* Пары "строка"-"строка" для перевода. }
  function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  function ValueToDisplayName(const aValue: Il3CString): Il3CString;
 end;//Il3StringValueMap
 
 Il3ValueMapFactory = interface
  {* Фабрика массивов пар ключ-значение. }
  function MakeMap(const aID: Tl3ValueMapID): Il3ValueMap;
 end;//Il3ValueMapFactory
 
 Il3StringValueMapFactory = interface(Il3ValueMapFactory)
  {* Фабрика для Il3StringValueMap. }
 end;//Il3StringValueMapFactory
 
 Il3IntegerValueMap = interface(Il3ValueMap)
  {* Пары "строка"-"целое" для перевода. }
  function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function ValueToDisplayName(aValue: Integer): Il3CString;
 end;//Il3IntegerValueMap
 
 Il3IntegerValueMapFactory = interface(Il3ValueMapFactory)
  {* Фабрика для Il3IntegerValueMap. }
 end;//Il3IntegerValueMapFactory
 
 Il3IntegerValueMapManager = interface
  {* Контейнер для Il3IntegerValueMap. }
  procedure RegisterFactory(const aFactory: Il3IntegerValueMapFactory;
   aPreferred: Boolean);
   {* aPreferred - Фабрика будет вызываться как можно раньше. }
  procedure UnRegisterFactory(const aFactory: Il3IntegerValueMapFactory);
 end;//Il3IntegerValueMapManager
 
 Tl3LinePartDrawType = (
  {* Тип линии рамки. }
  lpdDraw
   {* линия рисуется всегда. }
  , lpdSpecialDraw
   {* невидимая линия (только для специальных режимов отрисовки). }
  , lpdHidden
   {* прячем во время оптимизации. }
 );//Tl3LinePartDrawType
 
 Tl3FramePartIndex = (
  {* Индекс части рамки. }
  l3_fpiUp
  , l3_fpiDown
  , l3_fpiLeft
  , l3_fpiRight
 );//Tl3FramePartIndex
 
 Tl3FramePart = record
  {* Элемент рамки. }
 end;//Tl3FramePart
 
 Tl3FramePartArray = array [Tl3FramePartIndex] of Tl3FramePart;
  {* Массив элементов рамки. }
 
 Il3Lines = interface
  {* Список строк. }
  function AsObject: TObject;
 end;//Il3Lines
 
 Il3MultiLines = interface
  function IsSingle: Boolean;
  function HasBreakInWord: Boolean;
 end;//Il3MultiLines
 
 Il3List = interface
  {* Список. }
  procedure Clear;
   {* очистить список. }
  procedure Delete(anIndex: Integer);
   {* удаляет элемент по индексу Index. }
 end;//Il3List
 
 Il3InterfaceList = interface(Il3List)
  {* Список интерфейсов. }
  function Add(const anItem: IUnknown): Integer;
   {* Добавляет элемент. Возвращает ео индекс. }
  procedure Insert(anIndex: Integer;
   const anItem: IUnknown);
   {* вставляет элемент Item по индексу Index. }
  procedure AssignList(const aList: Il3InterfaceList);
 end;//Il3InterfaceList
 
 Tl3FontIndexes = set of Tl3FontIndex;
  {* Множество индексов шрифта. }
 
 TFontName = l3Core.TFontName;
  {* Гарнитура шрифта. }
 
 TFontPitch = l3Core.TFontPitch;
 
 Il3FontInfo = interface
  {* Информация о шрифте. }
 end;//Il3FontInfo
 
 TFontStyles = l3Core.TFontStyles;
 
 Il3FontPrim = interface(Il3FontInfo)
  {* Шрифт объекта. }
 end;//Il3FontPrim
 
 hFont = l3Core.hFont;
 
 TFont = l3Core.TFont;
 
 Il3FontMetrics = interface
  {* Метрики шрифта. }
  function Pos2Index(W: Integer;
   const S: Tl3WString): Integer;
   {* находит индекс символа на рассоянии W дюймов от начала строки S. }
  function TextExtent(const S: Tl3WString): Tl3_Point;
   {* возвращает размеры строки текста в дюймах. }
 end;//Il3FontMetrics
 
 TCharSet = set of AnsiChar;
  {* Множество символов. }
 
 Tl3DString = type WideString;
 
 Tl3SetBitType = (
  sbSelect
  , sbDeselect
  , sbInvert
 );//Tl3SetBitType
 
 Tl3Direction = (
  {* направление движения. }
  dUp
  , dUpMax
  , dDown
  , dDownMax
  , dLeft
  , dRight
 );//Tl3Direction
 
 Tl3WordPosition = (
  wpAnyPathWord
   {* в любой части слова. }
  , wpAtBeginWord
   {* с начала слова. }
  , wpAtBeginString
   {* с начала строки. }
 );//Tl3WordPosition
 
 Tl3WordOrder = (
  {* порядок введенных слов. }
  woAnyOrder
   {* в любом порядке. }
  , woAsWrote
   {* с учетом порядка введенного контекста. }
 );//Tl3WordOrder
 
 Tl3TreeLevelDist = (
  {* область для иерархических деревьев. }
  tldAllLevels
   {* во всех уровнях. }
  , tldOneLevel
   {* в пределах одного уровня. }
 );//Tl3TreeLevelDist
 
 Tl3CStringArray = array of Il3CString;
  {* Динамический массив строк. }
 
 Tl3MemoryFlag = (
  {* Флаг распределения памяти. }
  l3_mfNil
   {* Не распределено. }
  , l3_mfSmall
   {* Меньше 4-х байт. }
  , l3_mfLocal
   {* Выделено по GetMem. }
  , l3_mfGlobal
   {* Выделено по GlobalAlloc. }
 );//Tl3MemoryFlag
 
 Tl3PtrRec = record
  {* Указатель на кусок памяти. }
 end;//Tl3PtrRec
 
 Tl3PtrRecLen = record
  {* Распределенная строка с кодировкой и длиной. }
 end;//Tl3PtrRecLen
 
 Tl3WrappedWString = record
  {* Выровненная строка. }
 end;//Tl3WrappedWString
 
 Tl3WStrCast = record
  {* Переходник между Tl3PtrRec и Tl3WStr. }
 end;//Tl3WStrCast
 
 Il3Console = interface
  {* Консоль. }
  procedure Shift(aDelta: Integer);
   {* Сдвигает отступ вывода. }
  procedure Say(const aStr: Il3CString);
   {* Выводит строчку на консоль. }
 end;//Il3Console
 
 Tl3Frame = record
  {* Рамка. }
 end;//Tl3Frame
 
 Il3Font = interface(Il3FontPrim)
  {* Шрифт объекта. }
  function AssignFont(Font: TFont): Boolean;
  procedure Assign2Font(const aFont: Il3Font);
  procedure Lock;
  procedure Unlock;
  function HF: hFont;
  function IsAtomic: Boolean;
   {* Строка для нанного шрифта представляет собой единый объект? }
  function FM: Il3FontMetrics;
   {* Метрики шрифта. }
 end;//Il3Font
 
 Tl3LinesColorArray = array [Tl3LinePartDrawType] of Tl3Color;
  {* Цвета для рисования рамок. }
 
 // Tl3Index
 
 VCLBitmap = l3Core.VCLBitmap;
  {* Картинка. }
 
 Tl3OperationCode = Cardinal;
  {* команда возвращаемая компоненту в результате срабатывания механизма ShortCut-ов }
 
 IStorage = ActiveX.IStorage;
 
 Il3WordsSeq = interface
  {* "Строка". }
  function WordStart(Pos: Tl3Position): Tl3Position;
  function WordLeft(Pos: Tl3Position): Tl3Position;
  function WordFinish(Pos: Tl3Position): Tl3Position;
  function WordRight(Pos: Tl3Position): Tl3Position;
 end;//Il3WordsSeq
 
 (*
 Ml3PageSetup = interface
  {* Информация о странице }
 end;//Ml3PageSetup
 *)
 
 WinBool = l3Core.WinBool;
 
 Il3Caret = interface
  function CheckHidden: Boolean;
  function CanHide: Boolean;
 end;//Il3Caret
 
 Il3ScrollCaret = interface(Il3Caret)
  function IsInited: Boolean;
  function IsOnScreen: Boolean;
  procedure Scroll(const aOfs: Tl3_SPoint);
  procedure Reset;
 end;//Il3ScrollCaret
 
 Il3MemoryPool = interface
  {* Кусок памяти. }
 end;//Il3MemoryPool
 
 Il3HandleMemoryPool = interface(Il3MemoryPool)
  {* Кусок памяти с Windows Handle. }
  function ReleaseHandle: THandle;
  function AsHandle: THandle;
   {* Windows Handle куска памяти. }
 end;//Il3HandleMemoryPool
 
 Il3StringValueMapManager = interface
  {* Контейнер для Il3StringValueMap. }
  procedure RegisterFactory(const aFactory: Il3StringValueMapFactory;
   aPreferred: Boolean);
   {* aPreferred - Фабрика будет вызываться как можно раньше. }
  procedure UnRegisterFactory(const aFactory: Il3StringValueMapFactory);
 end;//Il3StringValueMapManager
 
 Tl3CompareAction = function(I: Integer;
  J: Integer): Integer;
  {* Функция сравнения элементов. }
 
 PInteger = l3Core.PInteger;
  {* Указатель на Integer. }
 
 Large = Int64;
 
 Il3Progress = interface
  {* Индикатор процесса. }
  procedure Start(Count: Integer;
   const aMsg: Il3CString); overload;
   {* начать процесс. }
  procedure Start(Count: Large;
   const aMsg: Il3CString); overload;
   {* начать процесс. }
  procedure Finish;
   {* закончить процесс. }
  procedure Progress(Current: Integer); overload;
   {* изменить текущее состояние. }
  procedure Progress(Current: Large); overload;
   {* изменить текущее состояние. }
  procedure ProgressEx(Current: Integer;
   const aMsg: Il3CString);
  procedure ChangeIO(Start: Boolean);
   {* изменить флаг InIO. }
  function InIO: Boolean;
   {* в процессе ввода/вывода? }
  function InUse: Boolean;
 end;//Il3Progress
 
 Tl3TabStop = record
  {* Описание позиции табуляции. }
 end;//Tl3TabStop
 
 Il3TabStops = interface
  {* Позиции табуляции. }
  function Clone: Il3TabStops;
   {* клонирует позиции табуляции. }
  function Next: Tl3TabStop;
   {* следующая позиция табуляции. }
  function Filler: Tl3WString;
   {* следующий символ-заполнитель. }
  function Style: Tl3TabStopStyle;
   {* следующий стиль. }
  function NeedCutByTab: Boolean;
  procedure Reset;
 end;//Il3TabStops
 
 Il3ProgressSource = interface
 end;//Il3ProgressSource
 
 Il3DocIDSource = interface
 end;//Il3DocIDSource
 
 Il3TabInfo = interface
  {* Информация о текущем состоянии табуляции. }
  function TabOffset: Integer;
  function TabStops: Il3TabStops;
 end;//Il3TabInfo
 
 Tl3MouseAction = (
  {* событие мыши. }
  l3_maDown
  , l3_maUp
  , l3_maDouble
  , l3_maMove
  , l3_maCtlMove
 );//Tl3MouseAction
 
 Tl3MouseButton = (
  {* кнопка мыши. }
  l3_mbLeft
  , l3_mbMiddle
  , l3_mbRight
 );//Tl3MouseButton
 
 Il3Rollback = interface
  {* Объект, умеющий откатывать данные }
  procedure Rollback;
   {* Откатить данные }
 end;//Il3Rollback
 
 Il3PageSetup = interface
  {* Информация о странице }
 end;//Il3PageSetup
 
 Tl3StringID = object
 end;//Tl3StringID
 
 Pl3StringID = ^Tl3StringID;
 
 Il3ApplicationL10NStrings = interface
  {* Локализуемые строки приложения }
  procedure Define(const aName: AnsiString;
   const aRus: AnsiString;
   const anAlien: AnsiString);
 end;//Il3ApplicationL10NStrings
 
 Il3IntegerList = interface
  {* Список целых чисел }
 end;//Il3IntegerList
 
 Pl3WString = ^Tl3WString;
 
 Il3GetMessageListener = interface(Il3Listener)
  procedure GetMessageListenerNotify(Code: Integer;
   aWParam: WPARAM;
   Msg: PMsg;
   var theResult: Tl3HookProcResult);
 end;//Il3GetMessageListener
 
 Il3WndProcRetListener = interface(Il3Listener)
  procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
   var theResult: Tl3HookProcResult);
 end;//Il3WndProcRetListener
 
 Il3MouseListener = interface(Il3Listener)
  procedure MouseListenerNotify(aMouseMessage: WPARAM;
   aHookStruct: PMouseHookStruct;
   var theResult: Tl3HookProcResult);
 end;//Il3MouseListener
 
 Il3WndProcListener = interface(Il3Listener)
  {* Слушатель, получающий уведомления о поступлении сообщений в процедуры окон приложения. }
  procedure WndProcListenerNotify(Msg: PCWPStruct;
   var theResult: Tl3HookProcResult);
 end;//Il3WndProcListener
 
 Il3MouseWheelListener = interface(Il3Listener)
  procedure MouseWheelListenerNotify(Msg: PMsg;
   var theResult: Tl3HookProcResult);
 end;//Il3MouseWheelListener
 
 Il3CBTListener = interface(Il3Listener)
  procedure CBTListenerNotify(Code: Integer;
   WParam: WPARAM;
   LParam: LPARAM;
   var theResult: Tl3HookProcResult);
 end;//Il3CBTListener
 
 Tl3Point = Tl3_Point;
 
 Tl3Rect = Tl3_Rect;
 
 Tl3SPoint = Tl3_SPoint;
 
implementation

uses
 l3ImplUses
 , l3Math
 , l3MinMax
;

end.
