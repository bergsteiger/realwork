unit k2TypedSimpleTagListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypedSimpleTagListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TypedSimpleTagListPrim
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

 {$Define l3Items_NoSort}

type
 _k2SimpleTagListPrim_Parent_ = Tk2ListTag;
 {$Define l3Items_IsProto}
 {$Include ..\K2\k2SimpleTagListPrim.imp.pas}
 Tk2TypedSimpleTagListPrim = class(_k2SimpleTagListPrim_)
 protected
 // overridden protected methods
   function ExpandSize(aTargetSize: Integer): Integer; override;
 end;//Tk2TypedSimpleTagListPrim

implementation

uses
  k2BaseTypes,
  SysUtils,
  l3Base,
  l3MinMax,
  RTLConsts
  ;

type _Instance_R_ = Tk2TypedSimpleTagListPrim;

{$Include ..\K2\k2SimpleTagListPrim.imp.pas}

// start class Tk2TypedSimpleTagListPrim

function Tk2TypedSimpleTagListPrim.ExpandSize(aTargetSize: Integer): Integer;
//#UC START# *47B975AF02ED_527D14900028_var*
//#UC END# *47B975AF02ED_527D14900028_var*
begin
//#UC START# *47B975AF02ED_527D14900028_impl*
 if aTargetSize = 0 then
  Result := Succ(Capacity)
 else
  Result := aTargetSize;
//#UC END# *47B975AF02ED_527D14900028_impl*
end;//Tk2TypedSimpleTagListPrim.ExpandSize

end.