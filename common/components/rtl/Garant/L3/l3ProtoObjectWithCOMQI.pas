unit l3ProtoObjectWithCOMQI;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoObjectWithCOMQI.pas"
// Начат: 17.05.2011 16:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProtoObjectWithCOMQI
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject,
  l3IID,
  l3Interfaces
  ;

type
 _l3COMQueryInterface_Parent_ = Tl3ProtoObject;
 {$Include ..\L3\l3COMQueryInterface.imp.pas}
 Tl3ProtoObjectWithCOMQI = class(_l3COMQueryInterface_)
 end;//Tl3ProtoObjectWithCOMQI

implementation

uses
  l3InterfacesMisc
  ;

{$Include ..\L3\l3COMQueryInterface.imp.pas}

end.