unit afwTextControl;

interface

uses
 l3IntfUses
 , afwTextControlPrim
 , afwInterfaces
 , Controls
;

type
 TafwTextControl = class(TafwTextControlPrim, IafwTextControl)
  function CaptionStored: Boolean;
  function CCaption: IafwCString;
 end;//TafwTextControl
 
implementation

uses
 l3ImplUses
 , l3String
 , TtfwClassRef_Proxy
;

type
 THackLink = class(TControlActionLink)
 end;//THackLink
 
end.
