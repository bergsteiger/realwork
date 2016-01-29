unit l3DynamicArray;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3DynamicArray.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::RecLists::Tl3DynamicArray
//
// Базовый класс для динамических массовов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Memory,
  l3SimpleDataContainer,
  l3Interfaces,
  l3Types,
  l3Except,
  Classes
  ;

 {$Define _l3Items_NeedsBeforeFreeItem}

type
 _DataType_ = Tl3Ptr;
 _l3UntypedList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3UntypedList.imp.pas}
 Tl3DynamicArray = class(_l3UntypedList_)
  {* Базовый класс для динамических массовов. }
 protected
 // property methods
   function pm_GetItems(anIndex: Integer): Pointer;
 public
 // public properties
   property Items[anIndex: Integer]: Pointer
     read pm_GetItems;
     default;
 end;//Tl3DynamicArray

implementation

uses
  l3Base,
  RTLConsts,
  SysUtils,
  l3MinMax
  ;

type _Instance_R_ = Tl3DynamicArray;

{$Include ..\L3\l3UntypedList.imp.pas}

// start class Tl3DynamicArray

function Tl3DynamicArray.pm_GetItems(anIndex: Integer): Pointer;
//#UC START# *479DFDBE0123_479DFD5300C5get_var*
//#UC END# *479DFDBE0123_479DFD5300C5get_var*
begin
//#UC START# *479DFDBE0123_479DFD5300C5get_impl*
 Result := ItemSlot(anIndex);
//#UC END# *479DFDBE0123_479DFD5300C5get_impl*
end;//Tl3DynamicArray.pm_GetItems

end.