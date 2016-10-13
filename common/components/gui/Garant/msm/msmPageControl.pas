unit msmPageControl;

// Модуль: "w:\common\components\gui\Garant\msm\msmPageControl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmPageControl" MUID: (57B4437D02DC)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , ElPgCtl
 , Classes
 //#UC START# *57B4437D02DCintf_uses*
 //#UC END# *57B4437D02DCintf_uses*
;

type
 TmsmTabSheet = TElTabSheet;

 //#UC START# *57B4437D02DCci*
 //#UC END# *57B4437D02DCci*
 //#UC START# *57B4437D02DCcit*
 //#UC END# *57B4437D02DCcit*
 TmsmPageControl = class(TElCustomPageControl)
  public
   constructor Create(AOwner: TComponent); override;
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

constructor TmsmPageControl.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57B4437D02DC_var*
//#UC END# *47D1602000C6_57B4437D02DC_var*
begin
//#UC START# *47D1602000C6_57B4437D02DC_impl*
 inherited;
//#UC END# *47D1602000C6_57B4437D02DC_impl*
end;//TmsmPageControl.Create

//#UC START# *57B4437D02DCimpl*
//#UC END# *57B4437D02DCimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmPageControl);
 {* Регистрация TmsmPageControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
