unit vcmGlassForm;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmGlassForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmGlassForm" MUID: (533BDEE602B6)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , vcmEntityForm
 , vcmGlassFrame
 , Types
 , Classes
 , Messages
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _vcmGlassForm_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmGlassForm.imp.pas}
 TvcmGlassForm = class(_vcmGlassForm_)
 end;//TvcmGlassForm
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3DwmApi
 , l3Base
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *533BDEE602B6impl_uses*
 //#UC END# *533BDEE602B6impl_uses*
;

type _Instance_R_ = TvcmGlassForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmGlassForm.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmGlassForm);
 {* Регистрация TvcmGlassForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
