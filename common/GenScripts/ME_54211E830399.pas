unit FormFrameDecorator;

interface

uses
 l3IntfUses
;

type
 TFormFrameDecoratorNeedRecreateButtonsEvent = procedure(aDecorator: TFormFrameDecorator) of object;
 
 TFormFrameDecorator = class
 end;//TFormFrameDecorator
 
implementation

uses
 l3ImplUses
 , ChromeLikeFormFramePainter
 , ChromeLikeWindowCaptionButtonsRes
 , ChromeLikeFormCaptionData
 , ChromeLikeBaseWindowCaptionButton
 , ChromeLikeTypes
 , ChromeLikeLegacyWindowCaptionButtons
 , ChromeLikeThemedWindowCaptionButtons
;

end.
