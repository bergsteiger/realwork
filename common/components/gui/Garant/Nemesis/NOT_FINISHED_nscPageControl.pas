unit NOT_FINISHED_nscPageControl;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscPageControl.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscPageControl" MUID: (4AC60C4B00AA)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TnscPageControl = class
 end;//TnscPageControl
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscPageControl);
 {* Регистрация TnscPageControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
