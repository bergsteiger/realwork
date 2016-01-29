unit k2TypedSimpleSortableTagListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypedSimpleSortableTagListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TypedSimpleSortableTagListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2ListTag,
  l3Variant,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_HasCustomSort}

type
 _k2SimpleTagListPrim_Parent_ = Tk2ListTag;
 {$Define l3Items_IsProto}
 {$Include ..\K2\k2SimpleTagListPrim.imp.pas}
 Tk2TypedSimpleSortableTagListPrim = class(_k2SimpleTagListPrim_)
 protected
 // overridden protected methods
   function ExpandSize(aTargetSize: Integer): Integer; override;
 end;//Tk2TypedSimpleSortableTagListPrim

implementation

uses
  k2BaseTypes,
  SysUtils,
  l3Base,
  l3MinMax,
  RTLConsts
  ;

type _Instance_R_ = Tk2TypedSimpleSortableTagListPrim;

{$Include ..\K2\k2SimpleTagListPrim.imp.pas}

// start class Tk2TypedSimpleSortableTagListPrim

function Tk2TypedSimpleSortableTagListPrim.ExpandSize(aTargetSize: Integer): Integer;
//#UC START# *47B975AF02ED_527D1B86018D_var*
//#UC END# *47B975AF02ED_527D1B86018D_var*
begin
//#UC START# *47B975AF02ED_527D1B86018D_impl*
 if aTargetSize = 0 then
  Result := Succ(Capacity)
 else
  Result := aTargetSize;
//#UC END# *47B975AF02ED_527D1B86018D_impl*
end;//Tk2TypedSimpleSortableTagListPrim.ExpandSize

end.