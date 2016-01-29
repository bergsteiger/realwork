unit vtPanel;

interface

uses
 l3IntfUses
 , afwTextControl
 , ExtCtrls
 , Classes
 , Controls
 , l3Defaults
 , Graphics
 , Messages
 , l3InternalInterfaces
 , Types
;

type
 TvtCustomPanelPrim = class(TafwTextControl)
 end;//TvtCustomPanelPrim
 
 TvtCustomPanel = class(_afwShortcutsHandler_)
  procedure Resize;
  procedure DrawFrame(const CN: Il3Canvas;
   var Rect: TRect);
  procedure CMTextChanged(var Message: TMessage);
  procedure WMSize(var Message: TWMSize);
  procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
 end;//TvtCustomPanel
 
 TvtPanel = class(TvtCustomPanel)
 end;//TvtPanel
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , l3String
 , afwFacade
 , Themes
 , Windows
 , Forms
;

end.
