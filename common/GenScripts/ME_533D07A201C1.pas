unit ChromeLikeBaseThemedWindowCaptionButton;

interface

uses
 l3IntfUses
 , ChromeLikeBaseWindowCaptionButton
 , UxTheme
 , Messages
 , Classes
;

type
 TChromeLikeThemedWindowCaptionButtonPaintParams = record
  {* параметры отрисовки кнопок }
 end;//TChromeLikeThemedWindowCaptionButtonPaintParams
 
 TChromeLikeBaseThemedWindowCaptionButton = class(TChromeLikeBaseWindowCaptionButton)
  function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams;
  procedure WMThemeChanged(var aMessage: TMessage);
 end;//TChromeLikeBaseThemedWindowCaptionButton
 
implementation

uses
 l3ImplUses
 , Windows
 , SysUtils
 , Controls
 , Graphics
 , l3Base
 , TtfwClassRef_Proxy
;

end.
