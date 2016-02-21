unit ChatTypes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\ChatTypes.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseTypesUnit
;

type
 TnsContactType = (
  {* Тип активности контакта }
  ctActive
   {* Залогинен }
  , ctInactive
   {* Отлогинен }
 );//TnsContactType

 TContactListFilterTypes = (
  {* Тип фильтра списка контактов }
  clftNone
   {* Все контакты }
  , clftActive
   {* Только залогиненные }
 );//TContactListFilterTypes

 TbsUserID = TUid;
  {* ID пользователя }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
