unit afwTextControlPrim;

interface

uses
 l3IntfUses
 , afwControl
 , afwInterfaces
 , l3Interfaces
 , Messages
;

type
 TafwTextControlPrim = class(TafwControl)
  procedure WMGetText(var Msg: TMessage);
  procedure WMGetTextLength(var Msg: TMessage);
  procedure WMSetText(var Msg: TMessage);
 end;//TafwTextControlPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 , TtfwClassRef_Proxy
;

end.
