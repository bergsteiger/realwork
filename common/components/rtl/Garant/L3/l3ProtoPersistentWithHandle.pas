unit l3ProtoPersistentWithHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoPersistentWithHandle.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Garbage::Tl3ProtoPersistentWithHandle
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Types,
  l3ProtoPersistent
  ;

type
 Tl3ProtoPersistentWithHandle = class(Tl3ProtoPersistent)
 protected
 // property methods
   function pm_GetHandle: Tl3Handle; virtual; abstract;
   procedure pm_SetHandle(aValue: Tl3Handle); virtual; abstract;
 public
 // public methods
   function CompareWith(anOther: Tl3ProtoPersistentWithHandle): Integer; virtual; abstract;
 public
 // public properties
   property Handle: Tl3Handle
     read pm_GetHandle
     write pm_SetHandle;
 end;//Tl3ProtoPersistentWithHandle

implementation

end.