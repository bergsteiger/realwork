unit NOT_FINISHED_l3Units;
 {* Модуль описывающий работу с различными единицами измерения. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Units.pas"
// Стереотип: "Interfaces"
// Элемент модели: "l3Units" MUID: (472745450206)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tl3Point = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Точка с координатами в дюймах (мировые координаты). }
 end;//Tl3Point

 Tl3SPoint = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Точка с координатами в пикселях (на экране). }
 end;//Tl3SPoint

 Tl3Rect = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Прямоугольник с координатами в дюймах (мировые координаты). }
 end;//Tl3Rect

 Tl3SRect = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Прямоугольник с координатами в пикселях (на экране). }
 end;//Tl3SRect

implementation

uses
 l3ImplUses
;

end.
