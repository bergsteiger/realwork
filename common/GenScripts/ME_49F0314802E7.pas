unit NOT_FINISHED_nscContextFilter;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscContextFilter.pas"
// Стереотип: "GuiControl"

{$Include nscDefine.inc}

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
    {* Поле для свойства OnChange }
   f_OnWrongContext: TNotifyEvent;
    {* Поле для свойства OnWrongContext }
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
;
{$IfEnd} // Defined(Nemesis)

end.
