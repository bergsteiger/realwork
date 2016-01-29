unit evRow;

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
 TevRow = class(TevTableChild, IedRow)
  function Make(const aView: InevView;
   const aTable: IedTable;
   aTagWrap: Tl3Variant;
   const aProcessor: InevProcessor;
   const aLocation: InevLocation): IedRow;
  function Table: IedTable;
   {* таблица, которой принадлежит строка }
  function CellsIterator: IedCellsIterator;
  function AnalizeRowCells: TedRowType;
 end;//TevRow
 
implementation

uses
 l3ImplUses
 , evCellsIterator
 , l3Base
 , evdTypes
 , evTableCellUtils
;

end.
