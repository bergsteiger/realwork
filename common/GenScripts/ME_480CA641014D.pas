unit evSectionBreakPainter;

interface

uses
 l3IntfUses
 , evPageBreakPainter
 , l3Interfaces
 , l3Units
 , l3StringIDEx
;

type
 TevSectionBreakPainter = class(TevPageBreakPainter)
  {* Реализация инструмента рисования для разрыва секций. }
 end;//TevSectionBreakPainter
 
implementation

uses
 l3ImplUses
 , nevInterfaces
 , k2Tags
 , l3String
 , evdTypes
 , evSectionPara
 , l3Defaults
 , l3Variant
 , l3MessageID
;

end.
