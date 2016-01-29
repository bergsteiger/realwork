unit ElPgCtl;

interface

uses
 l3IntfUses
 , ElXPThemedControl
;

type
 TElTabPosition = (
 );//TElTabPosition
 
 TElTabSheet = class
 end;//TElTabSheet
 
 TElCustomPageControl = class(TElXPThemedControl)
  procedure RequestTabPosition;
  procedure DoActivePrevPage;
 end;//TElCustomPageControl
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , PageControlWordsPack
;

end.
