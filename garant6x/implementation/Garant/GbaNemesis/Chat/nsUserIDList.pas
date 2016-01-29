unit nsUserIDList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/nsUserIDList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Chat::Chat::ChatImpl::TnsUserIDList
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
  l3SimpleDataContainer,
  ChatTypes,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _ItemType_ = TbsUserID;
 _l3AtomicList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}
 TnsUserIDList = class(_l3AtomicList_)
 end;//TnsUserIDList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TnsUserIDList;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.