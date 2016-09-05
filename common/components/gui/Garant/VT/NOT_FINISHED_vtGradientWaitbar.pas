unit NOT_FINISHED_vtGradientWaitbar;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtGradientWaitbar.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtGradientWaitbar" MUID: (525FBBD50077)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TvtGradientWaitbar = class
 end;//TvtGradientWaitbar

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *525FBBD50077impl_uses*
 //#UC END# *525FBBD50077impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtGradientWaitbar);
 {* Регистрация TvtGradientWaitbar }
{$IfEnd} // NOT Defined(NoScripts)

end.
