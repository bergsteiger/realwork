unit nscStatusBarPanel;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscStatusBarPanel.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
 , StatusBarUtils
 , nscNewInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
;

type
 //#UC START# *503DEACA03BBci*
 //#UC END# *503DEACA03BBci*
 _nscStatusBarItemNotification_Parent_ = TCustomToolbarPanel97;
 {$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}
 //#UC START# *503DEACA03BBcit*
 //#UC END# *503DEACA03BBcit*
 TnscStatusBarPanel = class(_nscStatusBarItemNotification_)
 //#UC START# *503DEACA03BBpubl*
 public
  property AutoSize;
 //#UC END# *503DEACA03BBpubl*
 end;//TnscStatusBarPanel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
;

{$If NOT Defined(NoTB97)}
{$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}

//#UC START# *503DEACA03BBimpl*
//#UC END# *503DEACA03BBimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscStatusBarPanel);
 {* Регистрация TnscStatusBarPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

{$IfEnd} // Defined(Nemesis)
end.
