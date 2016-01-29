unit l3CastablePersistent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3CastablePersistent.pas"
// Начат: 30.01.2008 22:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CastablePersistent
//
// TPersistent с методом QueryInterface.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes,
  l3Interfaces
  ;

type
 _l3Castable_Parent_ = TPersistent;
 {$Include ..\L3\l3Castable.imp.pas}
 Tl3CastablePersistent = {abstract} class(_l3Castable_)
  {* TPersistent с методом QueryInterface. }
 end;//Tl3CastablePersistent

implementation

{$Include ..\L3\l3Castable.imp.pas}

end.