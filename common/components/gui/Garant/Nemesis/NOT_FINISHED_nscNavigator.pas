unit NOT_FINISHED_nscNavigator;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscNavigator.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscNavigator" MUID: (499ABF3D031B)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnscNavigatorPageControl = class
 end;//TnscNavigatorPageControl

 TnscNavigator = class({$If NOT Defined(NoVCM)}
 IvcmMainFormDependent
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   procedure MainFormChanged(aForm: TControl);
    {* Вызывается при измении главной формы }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TnscNavigator
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TnscNavigator.MainFormChanged(aForm: TControl);
 {* Вызывается при измении главной формы }
//#UC START# *53CF7DD00066_499ABF3D031B_var*
//#UC END# *53CF7DD00066_499ABF3D031B_var*
begin
//#UC START# *53CF7DD00066_499ABF3D031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CF7DD00066_499ABF3D031B_impl*
end;//TnscNavigator.MainFormChanged
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscNavigator);
 {* Регистрация TnscNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
