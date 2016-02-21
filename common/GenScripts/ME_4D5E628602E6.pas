unit vgScenePrim;

// Модуль: "w:\common\components\rtl\external\VGScene\vgScenePrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgCustomControl
 , Messages
 , OvcController
;

type
 _afwShortcutsHandler_Parent_ = TvgCustomControl;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwShortcutsHandler.imp.pas}
 TvgScenePrim = class(_afwShortcutsHandler_)
 end;//TvgScenePrim
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , OvcConst
;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwShortcutsHandler.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgScenePrim);
 {* Регистрация TvgScenePrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
