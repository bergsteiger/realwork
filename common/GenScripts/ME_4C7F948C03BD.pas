unit eeSubPanel;

interface

uses
 l3IntfUses
 , eeSubPanelExport
 , eeInterfaces
;

type
 TeeCustomSubPanel = class(TeeSubPanelExport)
 end;//TeeCustomSubPanel
 
 TeeSubPanel = class(TeeCustomSubPanel)
 end;//TeeSubPanel
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
