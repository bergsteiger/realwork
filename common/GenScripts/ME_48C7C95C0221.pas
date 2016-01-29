unit ExtCtrls;

interface

uses
 l3IntfUses
 , Controls
;

type
 TTimer = class
 end;//TTimer
 
 TPaintBox = class
 end;//TPaintBox
 
 TCustomPanel = class(TCustomControl)
 end;//TCustomPanel
 
 TPanel = class(TCustomPanel)
 end;//TPanel
 
 TRadioGroup = class
 end;//TRadioGroup
 
 TPanelBevel = TBevelCut;
 
 TImage = class
 end;//TImage
 
 TBevel = class
 end;//TBevel
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , PanelProcessingPack
 , RadioGroupWordsPack
;

end.
