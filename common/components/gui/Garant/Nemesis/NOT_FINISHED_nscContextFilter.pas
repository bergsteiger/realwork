unit NOT_FINISHED_nscContextFilter;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscContextFilter.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscContextFilter" MUID: (49F0314802E7)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , Classes
;

type
 TnscContextFilter = class
  private
   f_OnChange: TNotifyEvent;
   f_OnWrongContext: TNotifyEvent;
  public
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
   property OnWrongContext: TNotifyEvent
    read f_OnWrongContext
    write f_OnWrongContext;
 end;//TnscContextFilter
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscContextFilterRes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *49F0314802E7impl_uses*
 //#UC END# *49F0314802E7impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscContextFilter);
 {* Регистрация TnscContextFilter }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
