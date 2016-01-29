unit l3InterfacedInterfaceList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3InterfacedInterfaceList.pas"
// Начат: 03.03.2008 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3InterfacedInterfaceList
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
  l3InterfaceList,
  l3PureMixIns
  ;

type
 _ListType_ = Il3InterfaceList;
 _l3InterfacedList_Parent_ = Tl3InterfaceList;
 {$Include ..\L3\l3InterfacedList.imp.pas}
 Tl3InterfacedInterfaceList = class(_l3InterfacedList_)
 end;//Tl3InterfacedInterfaceList

implementation

type _Instance_R_ = Tl3InterfacedInterfaceList;

{$Include ..\L3\l3InterfacedList.imp.pas}

end.