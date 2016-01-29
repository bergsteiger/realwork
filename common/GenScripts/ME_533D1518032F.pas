unit ChromeLikeThemedWindowCaptionButtons;

interface

uses
 l3IntfUses
 , ChromeLikeBaseThemedWindowCaptionButton
 , l3Interfaces
;

type
 TChromeLikeThemedCloseCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
 end;//TChromeLikeThemedCloseCaptionButton
 
 TChromeLikeThemedMaximizeCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
 end;//TChromeLikeThemedMaximizeCaptionButton
 
 TChromeLikeThemedMinimizeCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
 end;//TChromeLikeThemedMinimizeCaptionButton
 
implementation

uses
 l3ImplUses
 , UxTheme
 , Forms
 , ChromeLikeBaseWindowCaptionButton
 , ChromeLikeWindowCaptionButtonsRes
 , TtfwClassRef_Proxy
;

end.
