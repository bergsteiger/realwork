unit ChatTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/ChatTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Встроенные продукты::Chat::Chat::ChatTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit,
  SecurityUnit
  ;

type
 TnsContactType = (
  {* Тип активности контакта }
   ctActive // Залогинен
 , ctInactive // Отлогинен
 );//TnsContactType

 TContactListFilterTypes = (
  {* Тип фильтра списка контактов }
   clftNone // Все контакты
 , clftActive // Только залогиненные
 );//TContactListFilterTypes

 TbsUserID = BaseTypesUnit.TUid;
  {* ID пользователя }
{$IfEnd} //not Admin AND not Monitorings

implementation

end.