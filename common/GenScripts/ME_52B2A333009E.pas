unit nevTable;

interface

uses
 l3IntfUses
 , nevParaList
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevTable = class(TnevParaList, InevTable)
  function Make(aTag: Tl3Variant): InevTable;
  procedure AddRow(aColCount: Integer;
   aColumnWidth: Integer;
   aFramed: Boolean);
   {* Добавляет в таблицу строку с колонками одинаковой ширины aColumnWidth. 
         Если aFramed выставлен, то для каждой ячейки добавляются рамки. }
 end;//TnevTable
 
implementation

uses
 l3ImplUses
 , k2Base
 , evdFrame_Const
 , k2Tags
 , k2Const
;

end.
