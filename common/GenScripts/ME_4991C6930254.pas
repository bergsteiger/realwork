unit DayTipsInterfaces;
 {* Интерфейсы работы с советами дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DayTips\DayTipsInterfaces.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
;

type
 InsStartupTips = interface
  ['{620A7D19-668A-40BC-8A2F-F4AE63DE6C6A}']
  function pm_GetDontShow: Boolean;
  procedure pm_SetDontShow(aValue: Boolean);
  function pm_GetTipCaption: Il3CString;
  procedure Next;
  procedure Prev;
  procedure ShowDetails;
  procedure GotoWeb;
  property DontShow: Boolean
   read pm_GetDontShow
   write pm_SetDontShow;
  property TipCaption: Il3CString
   read pm_GetTipCaption;
 end;//InsStartupTips
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
