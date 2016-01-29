unit InsContextSearchHistoryNotifierList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ContextHistory"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/rtl/Garant/ContextHistory/InsContextSearchHistoryNotifierList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::ContextHistory::ContextHistory::TInsContextSearchHistoryNotifierList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3SimpleDataContainer,
  ContextHistoryInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _ItemType_ = InsContextSearchHistoryNotifier;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TInsContextSearchHistoryNotifierList = class(_l3InterfacePtrList_)
 end;//TInsContextSearchHistoryNotifierList
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

type _Instance_R_ = TInsContextSearchHistoryNotifierList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}


{$IfEnd} //not Admin
end.