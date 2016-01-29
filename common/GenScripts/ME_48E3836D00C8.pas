unit evEditorInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , Graphics
 , k2PureMixIns
 , l3Variant
 , evdTypes
 , nevBase
 , k2Interfaces
 , nevTools
 , nevNavigation
 , Windows
;

type
 IedStyle = interface
  {* Стиль параграфа }
  function GetStylesForBlock: Il3Strings;
 end;//IedStyle
 
 TedHorizontalAligment = (
  {* Выравнивание параграфа по горизонтали }
  ed_halUndefined
  , ed_halLeft
  , ed_halRight
  , ed_halCenter
  , ed_halJustify
  , ed_halPreformatted
 );//TedHorizontalAligment
 
 TedRangeIndexes = record
 end;//TedRangeIndexes
 
 IedParagraphFormatting = interface
  {* Форматирование параграфа }
 end;//IedParagraphFormatting
 
 TedLineStyle = (
  ed_lsSingle
  , ed_lsDashSmall
  , ed_lsDotDash
  , ed_lsDotDotDash
  , ed_lsTriple
  , ed_lsThickThinSmall
  , ed_lsThinThickSmall
  , ed_lsThinThickThinSmall
  , ed_lsThickThinMedium
  , ed_lsThinThickMedium
  , ed_lsThinThickThinMedium
  , ed_lsThickThinLarge
  , ed_lsThinThickLarge
  , ed_lsThinThickThinLarge
  , ed_lsBlackGray
  , ed_lsGrayBlack
  , ed_lsGrayBlackGray
  , ed_lsWavy
  , ed_lsDoubleWavy
  , ed_lsStriped
  , ed_lsEmboss
  , ed_lsEngrave
  , ed_lsUndefined
 );//TedLineStyle
 
 PIedFramePart = ^IedFramePart;
 
 IedFramePart = interface
  {* Часть рамки вокруг объекта }
 end;//IedFramePart
 
 TedFramePartIndex = (
  {* Индекс части рамки }
  ed_fpiUp
  , ed_fpiDown
  , ed_fpiLeft
  , ed_fpiRight
  , ed_fpiVert
  , ed_fpiHorz
 );//TedFramePartIndex
 
 IedFrame = interface
  {* Рамка вокруг объекта }
 end;//IedFrame
 
 // TedNeighbourIndex
 
 TedFramePartIndexes = set of TedFramePartIndex;
 
 IedProcessorObject = interface
 end;//IedProcessorObject
 
 // edGridFrame
 
 // edBoxFrame
 
 IedEditableObject = interface(IedProcessorObject)
 end;//IedEditableObject
 
 IedFramedObject = interface(IedEditableObject)
  {* Интерфейс представляющий объект с рамкой }
 end;//IedFramedObject
 
 IedParagraph = interface(IedFramedObject)
  {* Базовый интерфес для параграфов }
 end;//IedParagraph
 
 IedLeafParagraph = interface(IedParagraph)
  {* Листьевой параграф }
 end;//IedLeafParagraph
 
 IedTextParagraph = interface(IedLeafParagraph)
 end;//IedTextParagraph
 
 TedRowType = (
  ed_Null
  , ed_NumericCels
  , ed_SingleCell
  , ed_SimpleCells
  , ed_PsevdoSingleCells
  , ed_SimpleWithoutEmpty
  , ev_FormCells
  , ed_HasHeadCells
  , ed_EmptyWithContnueCells
  , ed_HasMergedCell
  , ed_SimpleEmptyCells
  , ed_ChessTableRow
 );//TedRowType
 
 TedCellType = (
  {* Классификация содержимого ячейки. }
  ed_None
  , ed_Integer
  , ed_Number
  , ed_Empty
  , ed_Text
  , ed_Float
  , ed_HasFormLine
  , ed_NeedDelete
  , ed_NeedMakeContinue
  , ed_SmallText
  , ed_EmptyAndNotFramed
 );//TedCellType
 
 IedTable = interface;
 
 IedCell = interface(IedFramedObject)
  {* Интерфейс представляющий ячейку таблицы }
  function GetCellType: TedCellType;
   {* Возвращает тип содержимого ячейки. }
  procedure MakeCellContinue(const anOp: InevOp);
   {* Выставить тип ячейке (ev_msContinue) и очистить её содержимое. }
  function CalcHeadCellHeghtInRow: Integer;
   {* Посчитать сколько занимает строк объедиенная ячейка. }
  procedure UpdateWidth(aNewWidth: Integer);
  procedure UpdateWidthAndCheckHead(aNewWidth: Integer);
   {* изменяет ширину ячейки, в том числе и объединенных }
  function Merge(aNeighbour: TedNeighbourIndex): Boolean;
   {* объединяет ячейку с соседом }
  function Split(aColNum: Integer;
   aRowNum: Integer): Boolean; overload;
   {* разбивает ячейку }
  function Split(anOrientation: Tl3Orientation1): Boolean; overload;
   {* разбивает ячейку }
  function IsFirst: Boolean;
   {* возвращает - первая ли это ячейка }
  function IsLast: Boolean;
   {* возвращает - последняя ли это ячейка }
  function IsBottom: Boolean;
   {* возвращает - самая ли ячейка нижняя }
  function Delete(const anOp: InevOp;
   anInMerge: Boolean): Boolean;
   {* удаляет ячейку }
  function TextAsInteger: Integer;
   {* Пытается преобразовать текст в ячейке к целому числу. }
  function GetFirstLineText: AnsiString;
   {* Возвращает первую строку ячейки. Использыется для тестов. }
  function IsEmptyCell: Boolean;
  function IsFrameEmpty: Boolean;
  function AsObject: Tl3Variant;
 end;//IedCell
 
 IedRowsIterator = interface;
 
 IedColumn = interface;
 
 IedColumnsIterator = interface;
 
 IedCells = interface;
 
 IedTable = interface(IedFramedObject)
  {* Интерфейс представляющий таблицу }
  function GetTagCell(aRow: Tl3Variant;
   const aCell: InevPara;
   aTagIndex: LongInt;
   const aLocation: InevLocation;
   anInitNeighbours: Boolean): IedCell;
   {* Времянка до переноса на модель evParaUtilClasses на модель. }
  function GetTag: Tl3Variant;
  function InsertRows(NumRows: Integer): Boolean;
   {* втавляет NumRows строк в текущее место таблицы }
  function Split(const anIndicator: InevProgress): Boolean;
   {* разделяет таблицу на две, в текущем месте }
  function Merge(const anIndicator: InevProgress): Boolean;
   {* объединяет таблицу со следующей }
  function FirstRowID: Integer;
   {* возвращает номер первой выделенной строки }
  function Delete: Boolean;
   {* удаляет таблицу }
  function RowCount: Integer;
   {* возварщает количество строк в таблице }
 end;//IedTable
 
 IedBackCellsIterator = interface(IedProcessorObject)
  {* Интерфейс, обеспечивающий обратный перебор ячеек }
  function Last(aNeedNeighbours: Boolean): IedCell;
   {* возвращает последнюю ячейку и начинает перебор }
  function Prev: IedCell;
   {* возвращает предыдущую ячейку или nil, если перебор закончен }
 end;//IedBackCellsIterator
 
 IedCellsIterator = interface(IedProcessorObject)
  {* Интерфейс, обеспечивающий перебор ячеек }
  function First(aNeedNeighbours: Boolean): IedCell;
   {* возвращает первую ячейку и начинает перебор }
  function Next: IedCell;
   {* возвращает следующую ячейку или nil, если перебор закончен }
  function CellsCount: Integer;
   {* Количество ячеек }
 end;//IedCellsIterator
 
 IedRow = interface(IedEditableObject)
  {* Строка таблиц }
  function AnalizeRowCells: TedRowType;
 end;//IedRow
 
 IedRowsIterator = interface(IedProcessorObject)
  {* Интерфейс, обеспечивающий перебор строк таблицы }
  function First: IedRow;
   {* возвращает первую строку и начинает перебор }
  function Next: IedRow;
   {* возвращает следующую строку или nil, если перебор закончен }
 end;//IedRowsIterator
 
 IedColumn = interface(IedEditableObject)
  {* Интерфейс представляющий колонку таблицы }
 end;//IedColumn
 
 TedRangePart = (
  ed_rpWord
  , ed_rpToLeftWord
  , ed_rpToWordFinish
  , ed_rpToRightWord
  , ed_rpWholeWordRight
 );//TedRangePart
 
 IedColumnsIterator = interface(IedProcessorObject)
  {* Интерфейс, обеспечивающий перебор столбцов }
  function First: IedColumn;
   {* возвращает первый столбец и начинает перебор }
  function Next: IedColumn;
   {* возвращает следующий столбец или nil, если перебор закончен }
 end;//IedColumnsIterator
 
 TedMergeAlgorythm = (
  ed_maAll
  , ed_maHorz
  , ed_maVert
 );//TedMergeAlgorythm
 
 IedCells = interface(IedFramedObject)
  {* Интерфейc представляющий диапазон ячеек таблицы }
  function Merge(aMergeAlg: TedMergeAlgorythm): Boolean;
   {* объединить ячейки в диапазоне }
  procedure Translate2Text;
   {* преобразуем диапазон ячеек в текст. }
 end;//IedCells
 
 TevCellNeighbours = array [TedNeighbourIndex] of Il3TagRef;
 
 IedRange_IterateLeafParagraphs_Action = function(const anItem: IedLeafParagraph): Boolean;
  {* Тип подитеративной функции для IedRange.IterateLeafParagraphs }
 
 IedRange = interface
  {* Диапазон выделения параграфов }
  procedure IterateLeafParagraphs;
   {* перебирает все листьевые параграфы }
  function ContainsOneLeaf: Boolean;
   {* проверяет содержит ли диапазон только один листьевой параграф }
  function AsString(aFormat: Tl3ClipboardFormat): AnsiString;
   {* получает текст в диапазоне }
  function Delete(aMode: TevClearMode): Boolean;
   {* удаляет содержимое диапазона }
  function InsertData(aFormat: Tl3ClipboardFormat;
   aData: THandle;
   aNeedClearOld: Boolean): Boolean;
   {* вставить данные из памяти в формате aFormat }
  procedure InsertFrom(const aTextSource: InevTagReader;
   const aFilters: InevTagGenerator);
   {* вставить данные из другого источника текста }
  function InsertString(const aSt: Tl3PCharLenPrim;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString(l3PCharLen('Hello world!', -1, CP_ANSI));
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
  function InsertString(const aSt: AnsiString;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString('Hello world!');
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
  function InsertParaBreak: Boolean;
   {* вставляет разрыв параграфов }
  function DeleteChar: Boolean;
   {* удаляет текущий символ }
  function Save(aFormat: Tl3ClipboardFormat;
   const outPool: IStream;
   const aFilters: InevTagGenerator;
   anInternal: Boolean;
   ChildrenOnly: Boolean): Boolean;
   {* сохранить выделение }
 end;//IedRange
 
 IedRangeSource = interface
  {* Источник диапазона выделения }
 end;//IedRangeSource
 
 TedTabelType = (
  {* Тип таблицы - попытка заточить выравнивание для таблиц определенного вида. }
  ed_tsNone
  , ed_tsWithHeader
   {* Таблица с заголовоком. }
  , ed_tsForm
   {* Таблица - форма. }
  , ed_tsChessTable
   {* Таблица - "шахматка". }
 );//TedTabelType
 
 TedBoundaryCorrespondence = (
  ed_bcNonEqual
  , ed_bcRightEqual
  , ed_bcLeftEqual
  , ed_bcEqual
 );//TedBoundaryCorrespondence
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
