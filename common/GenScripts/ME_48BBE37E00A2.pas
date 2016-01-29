unit afwCustomCommonControl;

interface

uses
 l3IntfUses
 , afwCustomCommonControlPrim
 , l3PrinterInterfaces
;

type
 TafwCustomCommonControl = class(TafwCustomCommonControlPrim)
  procedure Paint;
  procedure DoPaint;
 end;//TafwCustomCommonControl
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
