unit MouseClickSupport.imp;

interface

uses
 l3IntfUses
 , Controls
;

type
 _MouseClickSupport_ = class
  {* Поддержка щелканья мышью на компоненте }
  function GetKeyData: Integer;
  procedure MakeClick(aControl: TWinControl);
  procedure GetDeltaXY(var X: Integer;
   var Y: Integer);
   {* Получить кординаты "щелчка" относительно левого верхнего угла контрола. }
 end;//_MouseClickSupport_
 
implementation

uses
 l3ImplUses
 , Types
 , Messages
 , Windows
;

end.
