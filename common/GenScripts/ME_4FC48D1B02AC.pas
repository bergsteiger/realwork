unit evCellsIterator;

interface

uses
 l3IntfUses
 , evCustomParaListUtils
 , evEditorInterfaces
 , nevTools
 , l3Variant
 , nevBase
;

type
 TevCellsIterator = class(TevRowChild, IedBackCellsIterator, IedCellsIterator)
  function Make(const aView: InevView;
   const aRow: IedRow;
   aTagWrap: Tl3Variant;
   const aProcessor: InevProcessor;
   const aLocation: InevLocation): IedCellsIterator;
  function Last(aNeedNeighbours: Boolean): IedCell;
   {* ���������� ��������� ������ � �������� ������� }
  function Prev: IedCell;
   {* ���������� ���������� ������ ��� nil, ���� ������� �������� }
  function BackIterator: IedBackCellsIterator;
  function First(aNeedNeighbours: Boolean): IedCell;
   {* ���������� ������ ������ � �������� ������� }
  function Next: IedCell;
   {* ���������� ��������� ������ ��� nil, ���� ������� �������� }
  function CellsCount: Integer;
   {* ���������� ����� }
 end;//TevCellsIterator
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , nevFacade
;

end.
