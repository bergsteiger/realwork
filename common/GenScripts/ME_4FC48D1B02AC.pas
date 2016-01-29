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
   {* возвращает последнюю €чейку и начинает перебор }
  function Prev: IedCell;
   {* возвращает предыдущую €чейку или nil, если перебор закончен }
  function BackIterator: IedBackCellsIterator;
  function First(aNeedNeighbours: Boolean): IedCell;
   {* возвращает первую €чейку и начинает перебор }
  function Next: IedCell;
   {* возвращает следующую €чейку или nil, если перебор закончен }
  function CellsCount: Integer;
   {*  оличество €чеек }
 end;//TevCellsIterator
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , nevFacade
;

end.
