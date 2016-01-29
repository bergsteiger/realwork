unit NOT_FINISHED_l3Units;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3$Domain"
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Units.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Требования к низкоуровневым библиотекам::L3$Domain::l3Units
//
// Модуль описывающий работу с различными единицами измерения.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

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

end.