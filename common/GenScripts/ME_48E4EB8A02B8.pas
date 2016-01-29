unit evParaUtilClasses;

interface

uses
 l3IntfUses
 , evCustomParaListUtils
 , evEditorInterfaces
 , nevTools
 , evdTypes
 , nevBase
 , k2Interfaces
;

type
 TevTable = class(TevLocationProcessorTagTool, IedTable, IedCells)
  {* ���������� ����������� IedCell � IedCells ��� �������. }
  function Frame: IedFrame;
   {* ����� ������ ������� }
  function Merge(aMergeAlg: TedMergeAlgorythm): Boolean; overload;
   {* ���������� ������ � ��������� }
  function TableRange: IevTableRange;
   {* �������� ��������� � ������� }
  function Table: IedTable;
   {* �������, � �������� ����������� ������ �������� ����� }
  function VerticalAligment: TevVerticalAligment;
   {* ������������ ����������� ������ �� ��������� }
  function InsertRows(NumRows: Integer): Boolean;
   {* �������� NumRows ����� � ������� ����� ������� }
  function Split(const anIndicator: InevProgress): Boolean;
   {* ��������� ������� �� ���, � ������� ����� }
  function Merge(const anIndicator: InevProgress): Boolean; overload;
   {* ���������� ������� �� ��������� }
  function FirstRowID: Integer;
   {* ���������� ����� ������ ���������� ������ }
  function Delete: Boolean;
   {* ������� ������� }
  function RowCount: Integer;
   {* ���������� ���������� ����� � ������� }
  function Cell: IedCell;
   {* ������� ������ ������� }
  function Cells: IedCells;
   {* �������� ����� ������� ��� ��������� }
  function Column: IedColumn;
   {* ������� ������� ������� }
  function ColumnsIterator: IedColumnsIterator;
  function RowsIterator: IedRowsIterator;
  function OldNSRC: Boolean;
  procedure Translate2Text;
   {* ����������� �������� ����� � �����. }
  function GetTagCell(aRow: Tl3Variant;
   const aCell: InevPara;
   aTagIndex: LongInt;
   const aLocation: InevLocation;
   anInitNeighbours: Boolean): IedCell;
   {* �������� �� �������� �� ������ evParaUtilClasses �� ������. }
  function GetTag: Tl3Variant;
 end;//TevTable
 
implementation

uses
 l3ImplUses
;

end.
