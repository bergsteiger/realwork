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
  {* –еализует интерфейс IedColumn дл€ колонки таблицы. }
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
   {* возвращает первую €чейку и начинает перебор }
  function Next: IedCell;
   {* возвращает следующую €чейку или nil, если перебор закончен }
  function CellsCount: Integer;
   {*  оличество €чеек }
  function CellsIterator: IedCellsIterator;
   {* итератор €чеек колонки }
  function Width: Integer;
   {* ширина колонки }
  function ID: Integer;
   {* номер колонки по пор€дку от левого кра€ таблицы (начина€ с 0) }
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
