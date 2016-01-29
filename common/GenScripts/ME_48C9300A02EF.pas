unit evFramedParaListPainter;

interface

uses
 l3IntfUses
 , evParaListPainter
 , l3Interfaces
 , l3InternalInterfaces
 , nevRealTools
;

type
 TevFramedParaListPainter = class(_evDelayedPainters_)
  {* общая функциональность для рисователей таблиц }
  function GetFameObjectBehaviur: Tl3FrameObjectBehaviour;
  function GetColorArray: Tl3LinesColorArray;
  function NeedLog: Boolean;
   {* Поддерживает ли табличный объект запись в лог для тестов. }
 end;//TevFramedParaListPainter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Graphics
 , k2Base
 , k2Tags
 , l3Units
 , l3Base
 , evDelayedPaintersSpy
;

end.
