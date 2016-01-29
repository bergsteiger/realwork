unit vcmGlassFrame;

interface

uses
 l3IntfUses
 , Types
 , Classes
 , vcmEntityForm
 , Controls
;

type
 TvcmGlassFrameNeedUpdateGlassFrameControls = procedure(const aRect: TRect) of object;
 
 TvcmGlassFrame = class
  function FrameExtended: Boolean;
  function IntersectsControl(aControl: TControl): Boolean;
  procedure Create(aForm: TvcmEntityForm);
  procedure Assign(aSource: TvcmGlassFrame);
  procedure Changed;
 end;//TvcmGlassFrame
 
implementation

uses
 l3ImplUses
 , l3DwmApi
;

end.
