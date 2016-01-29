unit vcmChromeLikeTabbedContainerForm;

interface

uses
 l3IntfUses
 , vcmChromeLikeTabbedContainerFormPrim
 , FormFrameDecorator
 , Messages
 , Controls
;

type
 TvcmChromeLikeTabbedContainerForm = class(TvcmChromeLikeTabbedContainerFormPrim)
  procedure RecreateButtons;
  function GetClientControl: TWinControl;
  procedure DoOnNeedRecreateButtons(aDecorator: TFormFrameDecorator);
  procedure WMSysCommand(var aMessage: TWMSysCommand);
 end;//TvcmChromeLikeTabbedContainerForm
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ChromeLikeTabSetRes
 , vcmEntityForm
 , ChromeLikeFormFramePainter
 , ChromeLikeBaseWindowCaptionButton
 , Forms
 , Windows
 , Classes
 , TtfwClassRef_Proxy
 , Types
 , ChromeLikeTabSetTypes
 , afwFacade
 , l3TabbedContainersDispatcher
;

end.
