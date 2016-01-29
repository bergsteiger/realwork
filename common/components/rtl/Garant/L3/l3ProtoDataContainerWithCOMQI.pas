unit l3ProtoDataContainerWithCOMQI;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoDataContainerWithCOMQI.pas"
// Начат: 15.12.2009 15:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProtoDataContainerWithCOMQI
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoDataContainer,
  l3IID,
  l3Interfaces
  ;

type
 _l3COMQueryInterface_Parent_ = Tl3ProtoDataContainer;
 {$Include ..\L3\l3COMQueryInterface.imp.pas}
 Tl3ProtoDataContainerWithCOMQI = class(_l3COMQueryInterface_)
 end;//Tl3ProtoDataContainerWithCOMQI

implementation

uses
  l3InterfacesMisc
  ;

{$Include ..\L3\l3COMQueryInterface.imp.pas}

end.