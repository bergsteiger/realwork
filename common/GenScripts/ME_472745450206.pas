unit l3Units;

interface

uses
 l3IntfUses
;

type
 Tl3Point = object
  {* Точка с координатами в дюймах (мировые координаты). }
 end;//Tl3Point
 
 Tl3SPoint = object
  {* Точка с координатами в пикселях (на экране). }
 end;//Tl3SPoint
 
 Tl3Rect = object
  {* Прямоугольник с координатами в дюймах (мировые координаты). }
 end;//Tl3Rect
 
 Tl3SRect = object
  {* Прямоугольник с координатами в пикселях (на экране). }
 end;//Tl3SRect
 
implementation

uses
 l3ImplUses
;

end.
