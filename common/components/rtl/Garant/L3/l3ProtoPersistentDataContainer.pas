unit l3ProtoPersistentDataContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoPersistentDataContainer.pas"
// Начат: 18.05.2011 16:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProtoPersistentDataContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoPersistent,
  l3PureMixIns,
  l3IID,
  l3Interfaces
  ;

type
 _l3DataContainer_Parent_ = Tl3ProtoPersistent;
 {$Include ..\L3\l3DataContainer.imp.pas}
 _l3Changing_Parent_ = _l3DataContainer_;
 {$Include ..\L3\l3Changing.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3Changing_;
 {$Include ..\L3\l3COMQueryInterface.imp.pas}
 Tl3ProtoPersistentDataContainer = {abstract} class(_l3COMQueryInterface_)
 end;//Tl3ProtoPersistentDataContainer

implementation

uses
  l3InterfacesMisc
  ;

{$Include ..\L3\l3DataContainer.imp.pas}

{$Include ..\L3\l3Changing.imp.pas}

{$Include ..\L3\l3COMQueryInterface.imp.pas}

end.