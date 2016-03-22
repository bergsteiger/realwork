unit NOT_FINISHED_FormFrameDecorator;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\NOT_FINISHED_FormFrameDecorator.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TFormFrameDecorator" MUID: (54211E830399)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
;

type
 TFormFrameDecoratorNeedRecreateButtonsEvent = procedure(aDecorator: TFormFrameDecorator) of object;

 TFormFrameDecorator = class
 end;//TFormFrameDecorator
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
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
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
