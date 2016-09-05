unit NOT_FINISHED_nscFormsPageControl;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscFormsPageControl.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscFormsPageControl" MUID: (4AF296620379)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TnscFormsPageControl = class
 end;//TnscFormsPageControl
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4AF296620379impl_uses*
 //#UC END# *4AF296620379impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscFormsPageControl);
 {* Регистрация TnscFormsPageControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
