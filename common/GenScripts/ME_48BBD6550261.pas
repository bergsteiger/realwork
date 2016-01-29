unit afwCustomCommonTextControl;

interface

uses
 l3IntfUses
 , afwCustomCommonTextControlPrim
 , l3PrinterInterfaces
;

type
 TafwCustomCommonTextControl = class(TafwCustomCommonTextControlPrim)
  procedure Paint;
  procedure DoPaint;
 end;//TafwCustomCommonTextControl
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
