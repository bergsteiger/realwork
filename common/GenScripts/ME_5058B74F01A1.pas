unit nscStatusBarSep;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscStatusBarSep.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , TB97Tlbr
 {$IfEnd} // NOT Defined(NoTB97)
 , StatusBarUtils
 , nscNewInterfaces
 , Messages
;

type
 _nscStatusBarItemNotification_Parent_ = TToolbarSep97;
 {$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}
 TnscStatusBarSep = class(_nscStatusBarItemNotification_)
 end;//TnscStatusBarSep
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscStatusBarSep);
 {* Регистрация TnscStatusBarSep }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
