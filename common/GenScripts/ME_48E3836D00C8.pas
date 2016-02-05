unit evEditorInterfaces;
 {* ������, ����������� ������ � ������� �� ������ "����" ��������� }

// ������: "w:\common\components\gui\Garant\Everest\evEditorInterfaces.pas"
// ���������: "Interfaces"

{$Include evDefine.inc}

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

const
 edNoneFrame = [];
 edSingleCell = [ed_PsevdoSingleCells, ed_SingleCell];
 edAllowCellInHeadRow = [ed_HasMergedCell, ed_SimpleCells, ed_SimpleWithoutEmpty];

type
 IedStyle = interface
  {* ����� ��������� }
  ['{821B4AA6-AAAB-40F8-8F95-E102524FD18D}']
  function pm_GetStyles: Il3Strings;
  function pm_GetName: AnsiString;
  procedure pm_SetName(const aValue: AnsiString);
  function pm_GetID: Integer;
  procedure pm_SetID(aValue: Integer);
  function GetStylesForBlock: Il3Strings;
  property Styles: Il3Strings
   read pm_GetStyles;
   {* ������ ������ }
  property Name: AnsiString
   read pm_GetName
   write pm_SetName;
   {* ��� ����� }
  property ID: Integer
   read pm_GetID
   write pm_SetID;
   {* ������������� ����� }
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
  rStartRow: Integer;
  rFinishRow: Integer;
  rStartCell: Integer;
  rFinishCell: Integer;
 end;//TedRangeIndexes

 IedParagraphFormatting = interface
  {* �������������� ��������� }
  ['{1126D058-B6AE-4C8A-BB07-E83D175D379C}']
  function pm_GetHorizontalAligment: TedHorizontalAligment;
  procedure pm_SetHorizontalAligment(aValue: TedHorizontalAligment);
  function pm_GetHasDecimalAligment: Boolean;
  function pm_GetVisible: Boolean;
  procedure pm_SetVisible(aValue: Boolean);
  function pm_GetFirstIndent: Integer;
  procedure pm_SetFirstIndent(aValue: Integer);
  function pm_GetLeftIndent: Integer;
  procedure pm_SetLeftIndent(aValue: Integer);
  function pm_GetBullet: Integer;
  procedure pm_SetBullet(aValue: Integer);
  property HorizontalAligment: TedHorizontalAligment
   read pm_GetHorizontalAligment
   write pm_SetHorizontalAligment;
   {* ��� ������������ ��������� �� ����������� }
  property HasDecimalAligment: Boolean
   read pm_GetHasDecimalAligment;
   {* ���� �� � ��������� ������������ �� ����������� }
  property Visible: Boolean
   read pm_GetVisible
   write pm_SetVisible;
   {* ����� �������� ��� ��� }
  property FirstIndent: Integer
   read pm_GetFirstIndent
   write pm_SetFirstIndent;
   {* ������ ������ ������ ��������� }
  property LeftIndent: Integer
   read pm_GetLeftIndent
   write pm_SetLeftIndent;
   {* ����� ������ ��������� }
  property Bullet: Integer
   read pm_GetBullet
   write pm_SetBullet;
   {* ��� ������ }
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
  ['{9142283A-2C6A-47CB-9932-4E122FE28663}']
  function Get_Style: TedLineStyle;
  procedure Set_Style(aValue: TedLineStyle);
  function Get_Visible: Boolean;
  procedure Set_Visible(aValue: Boolean);
  function Get_Color: TColor;
  procedure Set_Color(aValue: TColor);
  function Get_Width: Integer;
  procedure Set_Width(aValue: Integer);
  property Style: TedLineStyle
   read Get_Style
   write Set_Style;
   {* ����� ����� ����� }
  property Visible: Boolean
   read Get_Visible
   write Set_Visible;
   {* ��������� ����� }
  property Color: TColor
   read Get_Color
   write Set_Color;
   {* ���� ����� }
  property Width: Integer
   read Get_Width
   write Set_Width;
   {* ������ ����� }
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
  ['{BC8E5422-C4E6-41ED-A5AD-4485D6CE85C2}']
  function Get_FramePart(anIndex: TedFramePartIndex): IedFramePart;
  property FramePart[anIndex: TedFramePartIndex]: IedFramePart
   read Get_FramePart;
   default;
   {* ����� ����� }
 end;//IedFrame

 TedNeighbourIndex = ed_fpiUp .. ed_fpiRight;

 TedFramePartIndexes = set of TedFramePartIndex;

 IedProcessorObject = interface
  ['{231B734F-E6ED-4B52-9B15-D06DD96CAE6C}']
  function Get_Processor: Ik2Processor;
  property Processor: Ik2Processor
   read Get_Processor;
 end;//IedProcessorObject

 // edGridFrame

 // edBoxFrame

 IedEditableObject = interface(IedProcessorObject)
  ['{3D9193F4-9BA4-4C21-B9A4-444DCC0A605B}']
 end;//IedEditableObject

 IedFramedObject = interface(IedEditableObject)
  {* ��������� �������������� ������ � ������ }
  ['{19CCAA1B-ADF7-4200-B323-9DA865F6BC87}']
  function Get_Frame: IedFrame;
  property Frame: IedFrame
   read Get_Frame;
   {* ����� ������ ������� }
 end;//IedFramedObject

 IedParagraph = interface(IedFramedObject)
  {* ������� �������� ��� ���������� }
  ['{F713F3A6-2C9A-4939-A0B1-36A6DBFFCD44}']
 end;//IedParagraph

 IedLeafParagraph = interface(IedParagraph)
  {* ��������� �������� }
  ['{E56125B8-F4AE-48DB-9E28-6F56D45562A4}']
  function pm_GetStyle: IedStyle;
  function pm_GetPrintFontSize: Integer;
  procedure pm_SetPrintFontSize(aValue: Integer);
  property Style: IedStyle
   read pm_GetStyle;
   {* �����, ����������� � ��������� }
  property PrintFontSize: Integer
   read pm_GetPrintFontSize
   write pm_SetPrintFontSize;
   {* ������ ������ ��� ������ }
 end;//IedLeafParagraph

 IedTextParagraph = interface(IedLeafParagraph)
  ['{B5399F1F-CF3D-4AA3-85EF-D67C38E33202}']
  function pm_GetFormatting: IedParagraphFormatting;
  function pm_GetFont: Il3Font;
  procedure pm_SetFont(const aValue: Il3Font);
  property Formatting: IedParagraphFormatting
   read pm_GetFormatting;
   {* ���������� ��������� }
  property Font: Il3Font
   read pm_GetFont
   write pm_SetFont;
   {* ����� ��������� }
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
  ['{2E56A71D-AC99-4F61-B5EB-4EE95B33798E}']
  function pm_GetTable: IedTable;
  function pm_GetNeighbour(aNeighbour: TedNeighbourIndex): IedCell;
  function pm_GetWidth: Integer;
  procedure pm_SetWidth(aValue: Integer);
  function pm_GetVerticalAligment: TevVerticalAligment;
  procedure pm_SetVerticalAligment(aValue: TevVerticalAligment);
  function pm_GetMergeStatus: TevMergeStatus;
  function GetCellType: TedCellType;
   {* ���������� ��� ����������� ������. }
  procedure MakeCellContinue(const anOp: InevOp);
   {* ��������� ��� ������ (ev_msContinue) � �������� � ����������. }
  function CalcHeadCellHeghtInRow: Integer;
   {* ��������� ������� �������� ����� ����������� ������. }
  procedure UpdateWidth(aNewWidth: Integer);
  procedure UpdateWidthAndCheckHead(aNewWidth: Integer);
   {* �������� ������ ������, � ��� ����� � ������������ }
  function Merge(aNeighbour: TedNeighbourIndex = ed_fpiRight): Boolean;
   {* ���������� ������ � ������� }
  function Split(aColNum: Integer = 2;
   aRowNum: Integer = 1): Boolean; overload;
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
   anInMerge: Boolean = False): Boolean;
   {* ������� ������ }
  function TextAsInteger: Integer;
   {* �������� ������������� ����� � ������ � ������ �����. }
  function GetFirstLineText: AnsiString;
   {* ���������� ������ ������ ������. ������������ ��� ������. }
  function IsEmptyCell: Boolean;
  function IsFrameEmpty: Boolean;
  function AsObject: Tl3Variant;
  property Table: IedTable
   read pm_GetTable;
   {* ������� � ������� ����������� ������ }
  property Neighbour[aNeighbour: TedNeighbourIndex]: IedCell
   read pm_GetNeighbour;
   {* ������ ������ }
  property Width: Integer
   read pm_GetWidth
   write pm_SetWidth;
   {* ������ ������ }
  property VerticalAligment: TevVerticalAligment
   read pm_GetVerticalAligment
   write pm_SetVerticalAligment;
   {* ������������ ����������� ������ �� ��������� }
  property MergeStatus: TevMergeStatus
   read pm_GetMergeStatus;
 end;//IedCell

 IedRowsIterator = interface;

 IedColumn = interface;

 IedColumnsIterator = interface;

 IedCells = interface;

 IedTable = interface(IedFramedObject)
  {* ��������� �������������� ������� }
  ['{310438B0-F1B6-4FC8-AEA9-1C2F3160482B}']
  function Get_Cell: IedCell;
  function Get_Cells: IedCells;
  function Get_Column: IedColumn;
  function Get_ColumnsIterator: IedColumnsIterator;
  function pm_GetRowsIterator: IedRowsIterator;
  function pm_GetOldNSRC: Boolean;
  procedure pm_SetOldNSRC(aValue: Boolean);
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
  property Cell: IedCell
   read Get_Cell;
   {* ������� ������ ������� }
  property Cells: IedCells
   read Get_Cells;
   {* �������� ����� ������� ��� ��������� }
  property Column: IedColumn
   read Get_Column;
   {* ������� ������� ������� }
  property ColumnsIterator: IedColumnsIterator
   read Get_ColumnsIterator;
  property RowsIterator: IedRowsIterator
   read pm_GetRowsIterator;
  property OldNSRC: Boolean
   read pm_GetOldNSRC
   write pm_SetOldNSRC;
 end;//IedTable

 IedBackCellsIterator = interface(IedProcessorObject)
  {* ���������, �������������� �������� ������� ����� }
  ['{AC012527-AACB-4848-885E-AEF71CADE91D}']
  function Last(aNeedNeighbours: Boolean): IedCell;
   {* ���������� ��������� ������ � �������� ������� }
  function Prev: IedCell;
   {* ���������� ���������� ������ ��� nil, ���� ������� �������� }
 end;//IedBackCellsIterator

 IedCellsIterator = interface(IedProcessorObject)
  {* ���������, �������������� ������� ����� }
  ['{D1687D4A-F58E-46BA-88AB-4D62B21EEB1A}']
  function pm_GetBackIterator: IedBackCellsIterator;
  function First(aNeedNeighbours: Boolean): IedCell;
   {* ���������� ������ ������ � �������� ������� }
  function Next: IedCell;
   {* ���������� ��������� ������ ��� nil, ���� ������� �������� }
  function CellsCount: Integer;
   {* ���������� ����� }
  property BackIterator: IedBackCellsIterator
   read pm_GetBackIterator;
 end;//IedCellsIterator

 IedRow = interface(IedEditableObject)
  {* ������ ������ }
  ['{60F7CDBC-9E6C-4F05-900E-0CC7F8C8FD38}']
  function pm_GetTable: IedTable;
  function pm_GetCellsIterator: IedCellsIterator;
  function AnalizeRowCells: TedRowType;
  property Table: IedTable
   read pm_GetTable;
   {* �������, ������� ����������� ������ }
  property CellsIterator: IedCellsIterator
   read pm_GetCellsIterator;
 end;//IedRow

 IedRowsIterator = interface(IedProcessorObject)
  {* ���������, �������������� ������� ����� ������� }
  ['{13948C52-C4D8-416A-8E30-B119F8218412}']
  function First: IedRow;
   {* ���������� ������ ������ � �������� ������� }
  function Next: IedRow;
   {* ���������� ��������� ������ ��� nil, ���� ������� �������� }
 end;//IedRowsIterator

 IedColumn = interface(IedEditableObject)
  {* ��������� �������������� ������� ������� }
  ['{8D87847B-CBCA-4E7E-84A5-ED2E50A16ADB}']
  function pm_GetCellsIterator: IedCellsIterator;
  function pm_GetWidth: Integer;
  procedure pm_SetWidth(aValue: Integer);
  function pm_GetID: Integer;
  property CellsIterator: IedCellsIterator
   read pm_GetCellsIterator;
   {* �������� ����� ������� }
  property Width: Integer
   read pm_GetWidth
   write pm_SetWidth;
   {* ������ ������� }
  property ID: Integer
   read pm_GetID;
   {* ����� ������� �� ������� �� ������ ���� ������� (������� � 0) }
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
  ['{4CB6AB7D-9813-4ED9-A207-5789E8645932}']
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
  ['{FD5C09F4-6DF7-472B-B7B7-4F07CDD1095E}']
  function pm_GetTableRange: IevTableRange;
  function pm_GetTable: IedTable;
  function pm_GetVerticalAligment: TevVerticalAligment;
  procedure pm_SetVerticalAligment(aValue: TevVerticalAligment);
  function Merge(aMergeAlg: TedMergeAlgorythm = ed_maAll): Boolean;
   {* ���������� ������ � ��������� }
  procedure Translate2Text;
   {* ����������� �������� ����� � �����. }
  property TableRange: IevTableRange
   read pm_GetTableRange;
   {* �������� ��������� � ������� }
  property Table: IedTable
   read pm_GetTable;
   {* �������, � �������� ����������� ������ �������� ����� }
  property VerticalAligment: TevVerticalAligment
   read pm_GetVerticalAligment
   write pm_SetVerticalAligment;
   {* ������������ ����������� ������ �� ��������� }
 end;//IedCells

 TevCellNeighbours = array [TedNeighbourIndex] of Il3TagRef;

 IedRange_IterateLeafParagraphs_Action = function(const anItem: IedLeafParagraph): Boolean;
  {* ��� �������������� ������� ��� IedRange.IterateLeafParagraphs }

 IedRange = interface
  {* �������� ��������� ���������� }
  ['{A3735617-00AF-44F5-9D1A-1AEB1E5242C7}']
  function Get_Paragraph: IedParagraph;
  function Get_Table: IedTable;
  function Get_Hyperlink: IevHyperlink;
  function pm_GetCollapsed: Boolean;
  function pm_GetTextParagraph: IedTextParagraph;
  function pm_GetPart(aPart: TedRangePart): IedRange;
  function pm_GetDocument: IevDocument;
  procedure IterateLeafParagraphs(anAction: IedRange_IterateLeafParagraphs_Action;
   const aProgress: Il3Progress = nil
   {* ��������� ��������� };
   anOpCode: Integer = 1
   {* ������������� �������� });
   {* ���������� ��� ��������� ��������� }
  procedure IterateLeafParagraphsF(anAction: IedRange_IterateLeafParagraphs_Action;
   const aProgress: Il3Progress = nil
   {* ��������� ��������� };
   anOpCode: Integer = 1
   {* ������������� �������� });
   {* ���������� ��� ��������� ��������� }
  function ContainsOneLeaf: Boolean;
   {* ��������� �������� �� �������� ������ ���� ��������� �������� }
  function AsString(aFormat: Tl3ClipboardFormat = cf_Text): AnsiString;
   {* �������� ����� � ��������� }
  function Delete(aMode: TevClearMode = nevTools.ev_cmKeepOne): Boolean;
   {* ������� ���������� ��������� }
  function InsertData(aFormat: Tl3ClipboardFormat;
   aData: THandle;
   aNeedClearOld: Boolean = False): Boolean;
   {* �������� ������ �� ������ � ������� aFormat }
  procedure InsertFrom(const aTextSource: InevTagReader;
   const aFilters: InevTagGenerator);
   {* �������� ������ �� ������� ��������� ������ }
  function InsertString(const aSt: Tl3PCharLenPrim;
   aFormat: Tl3ClipboardFormat = cf_Text): Boolean; overload;
   {* �������� ������ aSt � ������� ������� �������.
         |* ������ ������������� ������ InsertString.
          !begin
          ! CurrentEditor.Range.InsertString(l3PCharLen('Hello world!', -1, CP_ANSI));
          ! // - � ������� ������� ������� ����������� ������ 'Hello word!' � ��������� CP_ANSI.
          !end;
         |* }
  function InsertString(const aSt: AnsiString;
   aFormat: Tl3ClipboardFormat = cf_Text): Boolean; overload;
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
   anInternal: Boolean = False;
   ChildrenOnly: Boolean = False): Boolean;
   {* ��������� ��������� }
  property Paragraph: IedParagraph
   read Get_Paragraph;
   {* �������� ����������� �������� � ���������, ���� �� � ���� ������ }
  property Table: IedTable
   read Get_Table;
   {* �������� ������� � ���������, ���� ��� � ���� ������ }
  property Hyperlink: IevHyperlink
   read Get_Hyperlink;
   {* �������� ����������� � ���������, ���� ��� � ���� ������ }
  property Collapsed: Boolean
   read pm_GetCollapsed;
   {* ��������� ��� ����� }
  property TextParagraph: IedTextParagraph
   read pm_GetTextParagraph;
   {* "���������" �������� � ��������� }
  property Part[aPart: TedRangePart]: IedRange
   read pm_GetPart;
   {* ����� ��������� }
  property Document: IevDocument
   read pm_GetDocument;
   {* �������� }
 end;//IedRange

 IedRangeSource = interface
  {* �������� ��������� ��������� }
  ['{0AA44E80-5CF7-4AB2-8298-6837804D9321}']
  function pm_GetRange: IedRange;
  procedure pm_SetRange(const aValue: IedRange);
  function pm_GetCursor: InevBasePoint;
  procedure pm_SetCursor(const aValue: InevBasePoint);
  property Range: IedRange
   read pm_GetRange
   write pm_SetRange;
  property Cursor: InevBasePoint
   read pm_GetCursor
   write pm_SetCursor;
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

function L2IedRangeIterateLeafParagraphsAction(anAction: pointer): IedRange_IterateLeafParagraphs_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� IedRange.IterateLeafParagraphs }

implementation

uses
 l3ImplUses
 , l3Base
;

function L2IedRangeIterateLeafParagraphsAction(anAction: pointer): IedRange_IterateLeafParagraphs_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� IedRange.IterateLeafParagraphs }
asm
 jmp l3LocalStub
end;//L2IedRangeIterateLeafParagraphsAction

end.
