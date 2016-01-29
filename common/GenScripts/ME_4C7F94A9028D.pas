unit eeSubPanelExport;

interface

uses
 l3IntfUses
 , evSubPanel
 , eeInterfaces
;

type
 TeeSubPanelExport = class(TevCustomSubPanel, IeeSubPanel)
  function GetHotSpot(aSubType: Integer;
   aSubHandle: Integer): IeeHotSpot;
  function CheckSubOnPoint(aX: Integer;
   aY: Integer;
   out theSub: IeeSub): Boolean;
  function SubViewDescriptors: IeeSubViewDescriptors;
 end;//TeeSubPanelExport
 
implementation

uses
 l3ImplUses
 , nevTools
 , eeInterfacesEx
 , eeSubDescriptorsExport
 , SysUtils
 , eeSub
 , eeHotSpot
 , TtfwClassRef_Proxy
;

end.
