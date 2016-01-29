unit evTablePainter;

interface

uses
 l3IntfUses
 , evFramedParaListPainter
 , nevRealTools
 , evCellsOffsets
 , l3Variant
 , nevTools
;

type
 TevTablePainter = class(TevFramedParaListPainter, IevTablePainter)
  {* ���������� ���������� IevPainter ��� ������� }
  function CellsOffsets: TevCellsOffsets;
  procedure CheckCell(aPara: Tl3Tag;
   aCheckType: TnevCheckType);
  procedure CalcOffset;
   {* ����������� �������� ��� ��������� ������ }
  function WasPainted(aPara: Tl3Tag;
   anPID: Integer;
   aForLines: Boolean): Boolean;
   {* �������� ���� �� ���������� ��������� ������ �����������. }
  function NeedLog: Boolean;
   {* ������������ �� ��������� ������ ������ � ��� ��� ������. }
  function HasOwnStyle: Boolean;
 end;//TevTablePainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , SysUtils
 , evParaTools
;

end.
