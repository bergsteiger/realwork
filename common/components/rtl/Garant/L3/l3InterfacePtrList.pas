unit l3InterfacePtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3InterfacePtrList.pas"
// Начат: 08.02.2008 21:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3InterfacePtrList
//
// Список УКАЗАТЕЛЕЙ на интерфейсы. Не владеет ими.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IUnknown;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3InterfacePtrList.imp.pas}
 Tl3InterfacePtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на интерфейсы. Не владеет ими. }
 end;//Tl3InterfacePtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3InterfacePtrList;

{$Include ..\L3\l3InterfacePtrList.imp.pas}

end.