unit vg_controls;

interface

uses
 l3IntfUses
 , vg_scene
 , Controls
;

type
 TvgPathButton = class
 end;//TvgPathButton
 
 TvgCloseButton = class
 end;//TvgCloseButton
 
 TvgRadioButton = class
 end;//TvgRadioButton
 
 TvgTextControl = class(TvgControl)
  procedure SetText(const Value: WideString);
 end;//TvgTextControl
 
 TvgCustomButton = class(TvgTextControl)
 end;//TvgCustomButton
 
 TvgButton = class(TvgCustomButton)
 end;//TvgButton
 
 TvgCheckBox = class
 end;//TvgCheckBox
 
 TvgPanel = class(TvgControl)
 end;//TvgPanel
 
 TvgCalloutPanel = class(TvgPanel)
 end;//TvgCalloutPanel
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , VGSceneWordsPack
;

end.
