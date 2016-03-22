unit NOT_FINISHED_evButton;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evButton.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevButton" MUID: (52A085A703D4)

interface

uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
;

type
 TevCustomButton = class(TCustomToolbarButton97)
  protected
   function HackCheck: Boolean; virtual;
 end;//TevCustomButton

 TevCustomButtonActionLink = class(TToolbarButton97ActionLink)
 end;//TevCustomButtonActionLink

 TevButton = class(TevCustomButton)
 end;//TevButton

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TevCustomButton.HackCheck: Boolean;
//#UC START# *52A08AF5004B_52A085CE03AC_var*
//#UC END# *52A08AF5004B_52A085CE03AC_var*
begin
//#UC START# *52A08AF5004B_52A085CE03AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A08AF5004B_52A085CE03AC_impl*
end;//TevCustomButton.HackCheck

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomButton);
 {* Регистрация TevCustomButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevButton);
 {* Регистрация TevButton }
{$IfEnd} // NOT Defined(NoScripts)

end.
