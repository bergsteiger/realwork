unit ddTableRow;

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddCellList
 , ddCellsPropertyList
 , ddRowProperty
 , ddTableCell
 , ddCellProperty
 , ddTypes
 , k2Interfaces
 , ddCustomDestination
 , l3ProtoObject
;

type
 TddTableRow = class(TddDocumentAtom)
  procedure AddCell(aCell: TddTableCell);
  procedure AddCellAndPara(const OnlyCell: Boolean);
  procedure AddEmptyCell;
  procedure AddCellProp(aCellProps: TddCellProperty;
   aClearBorder: TddClearBoder);
  procedure ApplyCellProps;
  function CellIndexBySpan(anIndex: Integer): Integer;
  procedure ClearCellProps;
  procedure DeleteCell(anIndex: Integer);
  function GetLastNonClosedCell: TddTableCell;
  procedure CloneCell(aCellProp: TddCellProperty);
  function GetLastNonClosedCellOrAddNew: TddTableCell;
   {* Проверяет не закрыта ли предыдущая ячейка, а если закрыта открывает новую. }
  function IsCellPropsInit: Boolean;
  procedure ApplyExternalCellPropsDef(aRow: TddTableRow);
  procedure DoApplyCellProps(aCellProps: TddCellsPropertyList);
  procedure ApplyCellProperty(aCEP: TddCellProperty);
  procedure SetVMerged2LastCell(aFirst: Boolean);
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
 end;//TddTableRow
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Math
 , RTFtypes
 , evdFrame_Const
 , ddTable
 , l3Const
 , ddTextParagraph
 , Math
 , ddBase
 , ddEVDTypesSupport
;

end.
