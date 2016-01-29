unit l3NotifyPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3NotifyPtrList.pas"
// Начат: 31.03.2008 09:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3NotifyPtrList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3DataContainerWithoutIUnknownPrim,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes
  ;

type
//#UC START# *47F07C1B03E4ci*
 {$Define l3Items_NoChanging}
 {.$Define l3Items_NoSort}
 {$Define l3Items_NoOwner}
//#UC END# *47F07C1B03E4ci*
 _ItemType_ = Il3Notify;
 _l3InterfacePtrList_Parent_ = Tl3DataContainerWithoutIUnknownPrim;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3InterfacePtrList.imp.pas}
//#UC START# *47F07C1B03E4cit*
//#UC END# *47F07C1B03E4cit*
 Tl3NotifyPtrList = class(_l3InterfacePtrList_)
//#UC START# *47F07C1B03E4publ*
//#UC END# *47F07C1B03E4publ*
 end;//Tl3NotifyPtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3NotifyPtrList;

{$Include ..\L3\l3InterfacePtrList.imp.pas}


//#UC START# *47F07C1B03E4impl*
//#UC END# *47F07C1B03E4impl*
end.