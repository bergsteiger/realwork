unit nsBaseSearchWindowDataListenerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsBaseSearchWindowDataListenerList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::Search$Lib::BaseSearch::TnsBaseSearchWindowDataListenerList
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
  l3ProtoDataContainer,
  BaseSearchInterfaces,
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
 _ItemType_ = InsBaseSearchWindowDataListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsBaseSearchWindowDataListenerList = class(_l3InterfacePtrList_)
 end;//TnsBaseSearchWindowDataListenerList
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

type _Instance_R_ = TnsBaseSearchWindowDataListenerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.