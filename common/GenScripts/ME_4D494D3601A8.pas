unit vtVGButton;

interface

uses
 l3IntfUses
 , vg_controls
 , StdCtrls
 , Controls
 , Classes
;

type
 TvtVGButton = class(TvgButton)
  procedure UpdateDuplicateButton;
 end;//TvtVGButton
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
