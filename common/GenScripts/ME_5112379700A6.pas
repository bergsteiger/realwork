unit evRowAndTableTypeSupport;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evEditorInterfaces
 , evCellsOffsetsPair
;

type
 TevRowAndTableTypeSupport = class(Tl3ProtoObject)
  {* ������� ��� ������������� ������ � ����� }
  procedure AnalizeTableStyle;
  procedure AnalizeRowType(const aRow: IedRow);
  procedure SaveRowType(const aPairList: TevCellsOffsetsPair);
  function GetPrevRowType: TedRowType;
  procedure CheckRowType(const aRow: IedRow);
  function GetCellsCountInPreviousRow: Integer;
   {* ���������� ����� ����� � ��������� ����������� ������ }
 end;//TevRowAndTableTypeSupport
 
implementation

uses
 l3ImplUses
;

end.
