unit afwCustomCommonTextControlPrim;

interface

uses
 l3IntfUses
 , afwTextControl
 , l3InternalInterfaces
;

type
 TafwCustomCommonTextControlPrim = class(TafwTextControl)
  procedure DoPaint;
 end;//TafwCustomCommonTextControlPrim
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
