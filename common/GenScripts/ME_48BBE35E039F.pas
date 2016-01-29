unit afwCustomCommonControlPrim;

interface

uses
 l3IntfUses
 , afwControl
 , l3InternalInterfaces
;

type
 TafwCustomCommonControlPrim = class(TafwControl)
  procedure DoPaint;
 end;//TafwCustomCommonControlPrim
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
