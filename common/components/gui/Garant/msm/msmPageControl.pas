unit msmPageControl;

// Модуль: "w:\common\components\gui\Garant\msm\msmPageControl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmPageControl" MUID: (57B4437D02DC)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , ElPgCtl
 //#UC START# *57B4437D02DCintf_uses*
 //#UC END# *57B4437D02DCintf_uses*
;

type
 //#UC START# *57B4437D02DCci*
 //#UC END# *57B4437D02DCci*
 //#UC START# *57B4437D02DCcit*
 //#UC END# *57B4437D02DCcit*
 TmsmPageControl = class(TElCustomPageControl)
 //#UC START# *57B4437D02DCpubl*
  public
   property ParentColor;
   property UseXPThemes;
 //#UC END# *57B4437D02DCpubl*
 end;//TmsmPageControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B4437D02DCimpl_uses*
 //#UC END# *57B4437D02DCimpl_uses*
;

//#UC START# *57B4437D02DCimpl*
//#UC END# *57B4437D02DCimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmPageControl);
 {* Регистрация TmsmPageControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
