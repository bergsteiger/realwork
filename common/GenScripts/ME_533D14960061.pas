unit ChromeLikeLegacyWindowCaptionButtons;

interface

uses
 l3IntfUses
 , ChromeLikeBaseWindowCaptionButton
 , Windows
 , l3Interfaces
;

type
 TChromeLikeLegacyWindowCaptionButton = class(TChromeLikeBaseWindowCaptionButton)
  function GetButtonStateFlag: UINT;
 end;//TChromeLikeLegacyWindowCaptionButton
 
 TChromeLikeLegacyMinimizeCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
 end;//TChromeLikeLegacyMinimizeCaptionButton
 
 TChromeLikeLegacyMaximizeCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
 end;//TChromeLikeLegacyMaximizeCaptionButton
 
 TChromeLikeLegacyCloseCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
 end;//TChromeLikeLegacyCloseCaptionButton
 
implementation

uses
 l3ImplUses
 , Controls
 , Forms
 , ChromeLikeWindowCaptionButtonsRes
 , TtfwClassRef_Proxy
;

end.
