unit vtStatusBar;

interface

uses
 l3IntfUses
 , ComCtrls
;

type
 TvtCustomStatusBar = class(TCustomStatusBar)
 end;//TvtCustomStatusBar
 
 TvtStatusPanel = class
 end;//TvtStatusPanel
 
 TvtStatusBar = class(TvtCustomStatusBar)
 end;//TvtStatusBar
 
implementation

uses
 l3ImplUses
 , afwDrawing
 , TtfwClassRef_Proxy
 , StatusBarWordsPack
 , StatusPanelWordsPack
;

end.
