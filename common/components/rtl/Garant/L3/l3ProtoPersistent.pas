unit l3ProtoPersistent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoPersistent.pas"
// Начат: 16.04.2009 22:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProtoPersistent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3CastablePersistent,
  l3PureMixIns
  ;

type
 _l3Unknown_Parent_ = Tl3CastablePersistent;
 {$Include ..\L3\l3Unknown.imp.pas}
 Tl3ProtoPersistent = {abstract} class(_l3Unknown_)
 end;//Tl3ProtoPersistent

implementation

uses
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  Classes,
  l3MemUtils,
  l3Interlocked
  ;

{$Include ..\L3\l3Unknown.imp.pas}

end.