unit vcmScrollableFormWithWheelSupport.imp;

interface

uses
 l3IntfUses
 , Messages
;

type
 _vcmScrollableFormWithWheelSupport_ = class(MScrollingWinControl)
  {* Обеспечивает возможность скроллирования колесом мыши как самой формы. так и вложенных контролов, имеющих скроллбары }
 end;//_vcmScrollableFormWithWheelSupport_
 
implementation

uses
 l3ImplUses
 , Windows
 , l3Base
;

end.
