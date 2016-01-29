unit evTableColumn;

interface

uses
 l3IntfUses
 , evColumnBorderMarker
 , evEditorInterfaces
 , nevBase
 , nevTools
 , l3Variant
;

type
 TevColumn = class(TevColumnBorderMarker, IedCellsIterator, IedColumn)
  {* ��������� ��������� IedColumn ��� ������� �������. }
  procedure Create(const aView: InevView;
   aPara: Tl3Variant;
   aColumnID: LongInt;
   const aProcessor: InevProcessor);
  function Make(const aView: InevView;
   aPara: Tl3Variant;
   aColumnID: LongInt;
   const aProcessor: InevProcessor): IedColumn;
  function BackIterator: IedBackCellsIterator;
  function First(aNeedNeighbours: Boolean): IedCell;
   {* ���������� ������ ������ � �������� ������� }
  function Next: IedCell;
   {* ���������� ��������� ������ ��� nil, ���� ������� �������� }
  function CellsCount: Integer;
   {* ���������� ����� }
  function CellsIterator: IedCellsIterator;
   {* �������� ����� ������� }
  function Width: Integer;
   {* ������ ������� }
  function ID: Integer;
   {* ����� ������� �� ������� �� ������ ���� ������� (������� � 0) }
  function Processor: Ik2Processor;
 end;//TevColumn
 
implementation

uses
 l3ImplUses
 , l3Base
 , k2Tags
 , k2OpMisc
 , evMsgCode
 , l3InterfacesMisc
 , l3IID
 , evParaTools
;

end.
