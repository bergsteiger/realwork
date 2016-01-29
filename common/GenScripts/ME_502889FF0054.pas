unit TB97;

interface

uses
 l3IntfUses
 , tb97Control
;

type
 TCustomToolWindow97 = class(Ttb97Control)
  procedure UpdateEmpty(aUpdateVisibility: Boolean);
  procedure BeginUpdate;
  procedure EndUpdate;
  function NeedActivateMainForm: Boolean;
  procedure ActivateMainForm;
 end;//TCustomToolWindow97
 
 TDock97 = class(Ttb97Control)
  function SizeGripWidth: Integer;
 end;//TDock97
 
implementation

uses
 l3ImplUses
 , Forms
 , TtfwClassRef_Proxy
;

end.
