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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *54211E830399impl_uses*
 //#UC END# *54211E830399impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TFormFrameDecorator);
 {* Регистрация TFormFrameDecorator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
