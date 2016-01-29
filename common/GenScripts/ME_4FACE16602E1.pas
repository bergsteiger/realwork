unit ddTablePrim;

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddRowList
 , ddTableRow
 , ddTextParagraph
 , ddCellProperty
 , ddTypes
 , ddTableCell
 , l3Base
 , ddRowProperty
 , ddParagraphProperty
 , ddPicture
 , k2Interfaces
 , ddCustomDestination
 , l3ProtoObject
;

type
 TddTablePrim = class(TddDocumentAtom)
  procedure AddRow(aRow: TddTableRow); overload;
  procedure AddRow(anEmpty: Boolean); overload;
  procedure ClearLastRow;
  procedure ProcessTableRow(aRow: TddTableRow;
   aPrevRow: TddTableRow;
   anIndex: Integer);
  procedure CloneRow;
  procedure CloseCell;
  procedure AdjustWidth(aNewWidth: Integer);
  function LastParagraph: TddTextParagraph;
  function AddParaWithCheckingRow(const aPara: TddDocumentAtom;
   anAssign2Last: Boolean): TddDocumentAtom;
  procedure ApplyCellProperty(const aCellProp: TddCellProperty;
   aClearBorder: TddClearBoder);
  function GetLastNotClosedRow: TddTableRow;
  function Cells(aRowID: Integer;
   aCellID: Integer): TddTableCell;
  function CellsProps(aRowID: Integer;
   aCellID: Integer): TddCellProperty;
  procedure CheckLastRow(aNeedClone: Boolean);
  procedure CalculateCellsWidth;
  procedure CheckPercentCells(aRow: TddTableRow);
  procedure CheckSpanCells(aScaleCellWidth: Boolean;
   aDocTextWidth: Integer);
  function GetLineLen(const aText: Tl3String): Integer;
  procedure NormalizeCells;
  procedure CloseRow;
  procedure CloseTable(aScaleCellWidth: Boolean;
   aDocTextWidth: Integer);
  function BeforeParseCell: TddTableRow;
  function FindPrevRowWithCellProps(aStartIndex: Integer): TddTableRow;
  procedure CloseLastRow(aRowProp: TddRowProperty;
   aParaProp: TddParagraphProperty;
   out aLastRow: Boolean);
  procedure CorrectParaLevelAfterCloseTable(aParaProp: TddParagraphProperty);
   {* Уменьшает уровень текущего параграфа на 1, чтобы следующие даннные добавлялись на уровень выше. }
  procedure Try2CloseNotClosedRow(aWidth: Integer);
  function GetFirstRowWidth: Integer;
  function IsTableCorrect: Boolean;
   {* Проверяет таблицу на корректность. }
  procedure AddPicture(aPicture: TddPicture;
   aPAP: TddParagraphProperty;
   anAssign2Last: Boolean);
  procedure Try2AlignRowWidth(aRow: TddTableRow);
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
 end;//TddTablePrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Math
 , l3Defaults
 , l3MinMax
 , l3UnitsTools
 , StrUtils
 , RTFtypes
 , ddEVDTypesSupport
 , l3Const
 , ddBase
 , ddBorder
 , ddConst
;

end.
