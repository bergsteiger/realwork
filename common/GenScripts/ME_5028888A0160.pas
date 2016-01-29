unit TB97Tlbr;

interface

uses
 l3IntfUses
 , TB97
 , Types
 , tb97GraphicControl
;

type
 TCustomToolbar97 = class(TCustomToolWindow97)
  procedure ExecuteHandler(Sender: TObject);
  procedure ExecuteDefered;
  function IsGToolbarSizeNeeded: Boolean;
  procedure LockResize;
  procedure UnlockResize;
  procedure AdjustSizeForPanels;
 end;//TCustomToolbar97
 
 TToolbar97 = class(TCustomToolbar97)
 end;//TToolbar97
 
 TToolbarSep97 = class(Ttb97CustomGraphicControl)
 end;//TToolbarSep97
 
 Ttb97MoreButton = class
 end;//Ttb97MoreButton
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
