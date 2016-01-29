unit evDelayedPainters.imp;

interface

uses
 l3IntfUses
 , nevRealTools
 , evSelectedParts
 , l3LongintList
 , nevTools
;

type
 _evDelayedPainters_ = class(InevPaintersHolder)
  function GetRowHeights: Tl3LongintList;
  procedure PaintSelectionParts;
  procedure Release;
  procedure BeforeAddToCache;
  procedure RemeberSelPart(const aChildMap: InevMap;
   aSelection: Boolean);
   {* Запомнить прямоугольник для отрисовки. }
  procedure SetHeight(aHeight: Integer);
 end;//_evDelayedPainters_
 
implementation

uses
 l3ImplUses
 , l3Units
 , l3Base
 , evDelayedPaintersSpy
;

end.
