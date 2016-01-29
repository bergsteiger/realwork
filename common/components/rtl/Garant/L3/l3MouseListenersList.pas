unit l3MouseListenersList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3MouseListenersList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Listeners::Tl3MouseListenersList
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
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Il3MouseListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3InterfacePtrList.imp.pas}
 Tl3MouseListenersList = class(_l3InterfacePtrList_)
 end;//Tl3MouseListenersList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3MouseListenersList;

{$Include ..\L3\l3InterfacePtrList.imp.pas}

end.