unit vcmGlassForm.imp;

interface

uses
 l3IntfUses
 , vcmGlassFrame
 , Types
 , Classes
 , Messages
 , Windows
 , Controls
;

type
 _vcmGlassForm_ = class(MvcmEntityForm)
  {* Форма с расширяемой неклиентской областью }
  procedure UpdateGlassFrame(aSender: TObject);
  procedure UpdateGlassFrameControls(const aRect: TRect);
  function NeedShowSystemContextMenuOnPoint(const aPoint: TPoint): Boolean;
 end;//_vcmGlassForm_
 
implementation

uses
 l3ImplUses
 , l3DwmApi
 , l3Base
 , SysUtils
;

end.
