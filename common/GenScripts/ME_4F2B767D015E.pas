unit evCellsWidthCorrecter;

interface

uses
 l3IntfUses
 , evRowAndTableTypeSupport
 , evCellsOffsetsPairList
 , evCellsOffsetsPair
 , l3LongintList
 , evEditorInterfaces
 , evCellWidthCorrecterSpy
 , evCellsOffsetsList
 , nevBase
 , l3Interfaces
;

type
 TevFoundSuitebleType = (
  ev_fstNone
  , ev_fstTemplate
  , ev_fstInList
 );//TevFoundSuitebleType
 
 TevCellsWidthCorrecter = class(TevRowAndTableTypeSupport)
  {* ���������� ��� ������������ ������ �����. }
  procedure ApplyChanges(const anOp: InevOp;
   const anIterator: IedBackCellsIterator;
   aCellCount: Integer);
  procedure Create(const aForegnTemplates: TevCellsOffsetsList);
  function TryToCopyFromSuitableList: Boolean;
  function GetTemplate: TevCellsOffsetsPair;
  function GetRowsWithSingleCell: Tl3LongintList;
  function AddevCellsOffsetsPair(const aCellIterator: IedCellsIterator): TevCellsOffsetsPair;
  procedure CheckRowsWithSingleCell;
  function GetSuitableList(out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
  procedure CopyFromSuitableList(const aList: TevCellsOffsetsPair;
   aFoundType: TevFoundSuitebleType);
  function GetIterator: IedCellsIterator;
  function CheckPreparrePriorityTemplate(out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
   {* ������������� ������� ����� ������� � ����������. ������ ����� ����� ����������� ��������������� ����������� ��� ������ �� ��������� ��� ������������. }
  procedure CheckLog;
  function FoundPriorityTemplate: Boolean;
  procedure AlighHeader;
   {* ��������� ������������ ���������. }
  function DoCorrection(const aTable: IedTable;
   const aForegnTemplates: TevCellsOffsetsList;
   aSeparateOp: Boolean;
   const aProgress: Il3Progress): Boolean;
  function TryToCopyForeignList: Boolean;
  function FindSuitableListInPrevious(const anIterator: IedCellsIterator;
   out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
  procedure SaveCellsTypeList(const aCellIterator: IedCellsIterator;
   const aCellOffsetPair: TevCellsOffsetsPair);
  procedure CorrectCells(const aRow: IedRow);
  procedure ApplyChanges2Row(const anOp: InevOp;
   const aRow: IedRow;
   aFirst: Boolean);
  function GetPrevRowType: TedRowType;
  function GetCellsCountInPreviousRow: Integer;
   {* ���������� ����� ����� � ��������� ����������� ������ }
 end;//TevCellsWidthCorrecter
 
implementation

uses
 l3ImplUses
 , evTableCellUtils
 , l3Base
 , l3Types
 , afwFacade
 , k2Op
 , evOp
 , evMsgCode
 , evCellsCharOffsets
 , edCellTypesList
;

end.
