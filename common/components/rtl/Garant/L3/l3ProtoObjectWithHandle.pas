unit l3ProtoObjectWithHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoObjectWithHandle.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Garbage::Tl3ProtoObjectWithHandle
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
  l3ProtoObject
  ;

type
 Tl3ProtoObjectWithHandle = class(Tl3ProtoObject)
 protected
 // property methods
   function pm_GetHandle: Tl3Handle; virtual; abstract;
   procedure pm_SetHandle(aValue: Tl3Handle); virtual; abstract;
 public
 // public methods
   function CompareWith(anOther: Tl3ProtoObjectWithHandle): Integer; virtual; abstract;
 public
 // public properties
   property Handle: Tl3Handle
     read pm_GetHandle
     write pm_SetHandle;
 end;//Tl3ProtoObjectWithHandle

implementation

end.