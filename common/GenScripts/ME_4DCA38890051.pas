unit ddTextToTableConverters;

interface

uses
 l3IntfUses
 , l3Base
 , ddTextParagraph
 , l3StringList
 , ddTableConvTypes
 , ddDocument
 , ddRowList
 , ddTableRow
 , ddVirtualTable
 , evdTypes
 , ddTableCell
 , l3Parser
;

type
 TddAbstractTable = class(Tl3Base)
  procedure Analyze(const aAutoFit: TddAutoFitBehavior);
  procedure RecalcRows;
  procedure CopyToVirtualTable(aTable: TddVirtualTable);
  function CheckJustification(aText: Tl3String;
   aCellWidth: Integer): TevIndentType;
  procedure AddParagraph(aText: Tl3String;
   aCell: TddTableCell);
  procedure AddText(aCell: TddTableCell;
   aText: Tl3String); overload;
  procedure AddText(aCell: TddTableCell;
   aText: Tl3String;
   aStart: Integer;
   aLen: Integer); overload;
  function ApplyFormatting(aP: TddTextParagraph;
   const aCell: TddTableCell): Boolean;
  function GetPrevCell(aCell: TddTableCell): TddTableCell;
 end;//TddAbstractTable
 
 TddGraphicTable = class(TddAbstractTable)
  function CheckRowEnd: Boolean;
  procedure CheckMixed(const OnlySpaces: Boolean);
  procedure CheckOnlyGraphic;
  procedure CheckGraphicAndSpace(const CloseTable: Boolean);
  procedure WriteRow;
  procedure ScanForCols;
  procedure CorrectRow;
  function ConvertCellToRow(aBottomBorder: Boolean): Boolean;
  function GetPrevVMergeCell(aPos: Integer;
   aNeedCheckVMerge: Boolean): TddTableCell;
 end;//TddGraphicTable
 
 TddSpaceTable = class(TddAbstractTable)
  procedure Map2Row(aMap: Tl3String);
 end;//TddSpaceTable
 
 TddSeparatorTable = class(TddAbstractTable)
  procedure Create(aSeparator: AnsiChar);
 end;//TddSeparatorTable
 
 TddParagraphTable = class(TddAbstractTable)
  {* TddParagraphTable }
  function CalcTextLen(aText: Tl3String): Integer;
 end;//TddParagraphTable
 
implementation

uses
 l3ImplUses
 , l3Chars
 , ddTextSegment
 , ddDocumentAtom
 , ddBase
 , ddDocumentAtomList
 , ddTextParaString
 , l3MinMax
 , l3String
 , SysUtils
 , RTFtypes
 , ddCellProperty
 , Classes
 , l3Interfaces
 , l3Memory
 , l3Filer
 , l3Types
;

end.
