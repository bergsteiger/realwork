unit ChromeLikeBaseWindowCaptionButton;

interface

uses
 l3IntfUses
 , Controls
 , Forms
 , Classes
 , Messages
 , l3Interfaces
;

type
 TChromeLikeWindowCaptionButtonState = (
  cbsDisabled
  , cbsHot
  , cbsNormal
  , cbsPushed
 );//TChromeLikeWindowCaptionButtonState
 
 RChromeLikeWindowCaptionbuttonClass = class of TChromeLikeBaseWindowCaptionButton;
 
 TChromeLikeBaseWindowCaptionButton = class(TCustomControl)
  procedure NotifyFormResized;
  function NeedUpdateHint: Boolean;
  function GetHintText: Il3CString;
  procedure CMMouseEnter(var aMessage: TMessage);
  procedure CMMouseLeave(var aMessage: TMessage);
  procedure WMEraseBkgnd(var aMessage: TWMEraseBkgnd);
  procedure CMEnabledChanged(var aMessage: TMessage);
 end;//TChromeLikeBaseWindowCaptionButton
 
implementation

uses
 l3ImplUses
 , Windows
 , UxTheme
 , l3String
 , TtfwClassRef_Proxy
;

end.
