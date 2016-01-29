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
  {* ����� ��������� }
  function GetStylesForBlock: Il3Strings;
 end;//IedStyle
 
 TedHorizontalAligment = (
  {* ������������ ��������� �� ����������� }
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
  {* �������������� ��������� }
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
  {* ����� ����� ������ ������� }
 end;//IedFramePart
 
 TedFramePartIndex = (
  {* ������ ����� ����� }
  ed_fpiUp
  , ed_fpiDown
  , ed_fpiLeft
  , ed_fpiRight
  , ed_fpiVert
  , ed_fpiHorz
 );//TedFramePartIndex
 
 IedFrame = interface
  {* ����� ������ ������� }
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
  {* ��������� �������������� ������ � ������ }
 end;//IedFramedObject
 
 IedParagraph = interface(IedFramedObject)
  {* ������� �������� ��� ���������� }
 end;//IedParagraph
 
 IedLeafParagraph = interface(IedParagraph)
  {* ��������� �������� }
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
  {* ������������� ����������� ������. }
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
  {* ��������� �������������� ������ ������� }
  function GetCellType: TedCellType;
   {* ���������� ��� ����������� ������. }
  procedure MakeCellContinue(const anOp: InevOp);
   {* ��������� ��� ������ (ev_msContinue) � �������� � ����������. }
  function CalcHeadCellHeghtInRow: Integer;
   {* ��������� ������� �������� ����� ����������� ������. }
  procedure UpdateWidth(aNewWidth: Integer);
  procedure UpdateWidthAndCheckHead(aNewWidth: Integer);
   {* �������� ������ ������, � ��� ����� � ������������ }
  function Merge(aNeighbour: TedNeighbourIndex): Boolean;
   {* ���������� ������ � ������� }
  function Split(aColNum: Integer;
   aRowNum: Integer): Boolean; overload;
   {* ��������� ������ }
  function Split(anOrientation: Tl3Orientation1): Boolean; overload;
   {* ��������� ������ }
  function IsFirst: Boolean;
   {* ���������� - ������ �� ��� ������ }
  function IsLast: Boolean;
   {* ���������� - ��������� �� ��� ������ }
  function IsBottom: Boolean;
   {* ���������� - ����� �� ������ ������ }
  function Delete(const anOp: InevOp;
   anInMerge: Boolean): Boolean;
   {* ������� ������ }
  function TextAsInteger: Integer;
   {* �������� ������������� ����� � ������ � ������ �����. }
  function GetFirstLineText: AnsiString;
   {* ���������� ������ ������ ������. ������������ ��� ������. }
  function IsEmptyCell: Boolean;
  function IsFrameEmpty: Boolean;
  function AsObject: Tl3Variant;
 end;//IedCell
 
 IedRowsIterator = interface;
 
 IedColumn = interface;
 
 IedColumnsIterator = interface;
 
 IedCells = interface;
 
 IedTable = interface(IedFramedObject)
  {* ��������� �������������� ������� }
  function GetTagCell(aRow: Tl3Variant;
   const aCell: InevPara;
   aTagIndex: LongInt;
   const aLocation: InevLocation;
   anInitNeighbours: Boolean): IedCell;
   {* �������� �� �������� �� ������ evParaUtilClasses �� ������. }
  function GetTag: Tl3Variant;
  function InsertRows(NumRows: Integer): Boolean;
   {* �������� NumRows ����� � ������� ����� ������� }
  function Split(const anIndicator: InevProgress): Boolean;
   {* ��������� ������� �� ���, � ������� ����� }
  function Merge(const anIndicator: InevProgress): Boolean;
   {* ���������� ������� �� ��������� }
  function FirstRowID: Integer;
   {* ���������� ����� ������ ���������� ������ }
  function Delete: Boolean;
   {* ������� ������� }
  function RowCount: Integer;
   {* ���������� ���������� ����� � ������� }
 end;//IedTable
 
 IedBackCellsIterator = interface(IedProcessorObject)
  {* ���������, �������������� �������� ������� ����� }
  function Last(aNeedNeighbours: Boolean): IedCell;
   {* ���������� ��������� ������ � �������� ������� }
  function Prev: IedCell;
   {* ���������� ���������� ������ ��� nil, ���� ������� �������� }
 end;//IedBackCellsIterator
 
 IedCellsIterator = interface(IedProcessorObject)
  {* ���������, �������������� ������� ����� }
  function First(aNeedNeighbours: Boolean): IedCell;
   {* ���������� ������ ������ � �������� ������� }
  function Next: IedCell;
   {* ���������� ��������� ������ ��� nil, ���� ������� �������� }
  function CellsCount: Integer;
   {* ���������� ����� }
 end;//IedCellsIterator
 
 IedRow = interface(IedEditableObject)
  {* ������ ������ }
  function AnalizeRowCells: TedRowType;
 end;//IedRow
 
 IedRowsIterator = interface(IedProcessorObject)
  {* ���������, �������������� ������� ����� ������� }
  function First: IedRow;
   {* ���������� ������ ������ � �������� ������� }
  function Next: IedRow;
   {* ���������� ��������� ������ ��� nil, ���� ������� �������� }
 end;//IedRowsIterator
 
 IedColumn = interface(IedEditableObject)
  {* ��������� �������������� ������� ������� }
 end;//IedColumn
 
 TedRangePart = (
  ed_rpWord
  , ed_rpToLeftWord
  , ed_rpToWordFinish
  , ed_rpToRightWord
  , ed_rpWholeWordRight
 );//TedRangePart
 
 IedColumnsIterator = interface(IedProcessorObject)
  {* ���������, �������������� ������� �������� }
  function First: IedColumn;
   {* ���������� ������ ������� � �������� ������� }
  function Next: IedColumn;
   {* ���������� ��������� ������� ��� nil, ���� ������� �������� }
 end;//IedColumnsIterator
 
 TedMergeAlgorythm = (
  ed_maAll
  , ed_maHorz
  , ed_maVert
 );//TedMergeAlgorythm
 
 IedCells = interface(IedFramedObject)
  {* ��������c �������������� �������� ����� ������� }
  function Merge(aMergeAlg: TedMergeAlgorythm): Boolean;
   {* ���������� ������ � ��������� }
  procedure Translate2Text;
   {* ����������� �������� ����� � �����. }
 end;//IedCells
 
 TevCellNeighbours = array [TedNeighbourIndex] of Il3TagRef;
 
 IedRange_IterateLeafParagraphs_Action = function(const anItem: IedLeafParagraph): Boolean;
  {* ��� �������������� ������� ��� IedRange.IterateLeafParagraphs }
 
 IedRange = interface
  {* �������� ��������� ���������� }
  procedure IterateLeafParagraphs;
   {* ���������� ��� ��������� ��������� }
  function ContainsOneLeaf: Boolean;
   {* ��������� �������� �� �������� ������ ���� ��������� �������� }
  function AsString(aFormat: Tl3ClipboardFormat): AnsiString;
   {* �������� ����� � ��������� }
  function Delete(aMode: TevClearMode): Boolean;
   {* ������� ���������� ��������� }
  function InsertData(aFormat: Tl3ClipboardFormat;
   aData: THandle;
   aNeedClearOld: Boolean): Boolean;
   {* �������� ������ �� ������ � ������� aFormat }
  procedure InsertFrom(const aTextSource: InevTagReader;
   const aFilters: InevTagGenerator);
   {* �������� ������ �� ������� ��������� ������ }
  function InsertString(const aSt: Tl3PCharLenPrim;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* �������� ������ aSt � ������� ������� �������.
         |* ������ ������������� ������ InsertString.
          !begin
          ! CurrentEditor.Range.InsertString(l3PCharLen('Hello world!', -1, CP_ANSI));
          ! // - � ������� ������� ������� ����������� ������ 'Hello word!' � ��������� CP_ANSI.
          !end;
         |* }
  function InsertString(const aSt: AnsiString;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* �������� ������ aSt � ������� ������� �������.
         |* ������ ������������� ������ InsertString.
          !begin
          ! CurrentEditor.Range.InsertString('Hello world!');
          ! // - � ������� ������� ������� ����������� ������ 'Hello word!' � ��������� CP_ANSI.
          !end;
         |* }
  function InsertParaBreak: Boolean;
   {* ��������� ������ ���������� }
  function DeleteChar: Boolean;
   {* ������� ������� ������ }
  function Save(aFormat: Tl3ClipboardFormat;
   const outPool: IStream;
   const aFilters: InevTagGenerator;
   anInternal: Boolean;
   ChildrenOnly: Boolean): Boolean;
   {* ��������� ��������� }
 end;//IedRange
 
 IedRangeSource = interface
  {* �������� ��������� ��������� }
 end;//IedRangeSource
 
 TedTabelType = (
  {* ��� ������� - ������� �������� ������������ ��� ������ ������������� ����. }
  ed_tsNone
  , ed_tsWithHeader
   {* ������� � �����������. }
  , ed_tsForm
   {* ������� - �����. }
  , ed_tsChessTable
   {* ������� - "��������". }
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
