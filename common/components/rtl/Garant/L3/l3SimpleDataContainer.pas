unit l3SimpleDataContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3SimpleDataContainer.pas"
// Начат: 20.02.2008 17:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3SimpleDataContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleObject
  ;

type
 _l3DataContainer_Parent_ = Tl3SimpleObject;
 {$Include ..\L3\l3DataContainer.imp.pas}
 Tl3SimpleDataContainer = {abstract} class(_l3DataContainer_)
 end;//Tl3SimpleDataContainer

implementation

{$Include ..\L3\l3DataContainer.imp.pas}

end.