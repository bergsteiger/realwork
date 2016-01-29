unit evTableImplementation;

interface

uses
 l3IntfUses
 , k2ProcTagTool
 , nevBase
 , nevTools
;

type
 TevTableImplementation = class(Tk2ProcTagTool, IevTable)
  procedure DoCloneSegments(const aOldRow: Tl3Variant;
   const aNewRow: Tl3Variant;
   const anOp: InevOp);
  function GetClearMode4Clone: TevClearMode;
  procedure Create(const aView: InevView;
   const aLoc: InevBasePoint;
   const aProcessor: InevProcessor);
  function Make(const aView: InevView;
   const aLoc: InevBasePoint;
   const aProcessor: InevProcessor): IevTable;
  procedure InsertRows(NumRows: Integer;
   aAtEnd: Boolean);
   {* ��������� NumRows ����� � ������� ����� �������. }
  procedure InsertColumns(NumColumns: Integer);
   {* ��������� NumColumns �������� � ������� ����� �������. }
  procedure DeleteRow;
   {* ������� ������� ������ �������. }
  procedure DeleteColumn;
   {* ������� ������� �������. }
 end;//TevTableImplementation
 
implementation

uses
 l3ImplUses
 , evOp
 , evParaTools
 , evCursorTools
 , l3MinMax
 , l3Base
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 , k2Tags
 , k2Base
 , evdTypes
 , l3Variant
 , evTableCellUtils
;

end.
