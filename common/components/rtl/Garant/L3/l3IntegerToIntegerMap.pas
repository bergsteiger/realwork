unit l3IntegerToIntegerMap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3IntegerToIntegerMap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3IntegerToIntegerMap
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
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 _KeyType_ = Integer;
 _ValueType_ = Integer;
 {$Include ..\L3\l3Map.imp.pas}
 Tl3IntegerToIntegerMap = class(_l3Map_)
 end;//Tl3IntegerToIntegerMap

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tl3IntegerToIntegerMap

function CompareKeys(const aA: _KeyType_;
  const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_56090A5401A5_var*
//#UC END# *5609091B00C0_56090A5401A5_var*
begin
//#UC START# *5609091B00C0_56090A5401A5_impl*
 Result := aA - aB;
//#UC END# *5609091B00C0_56090A5401A5_impl*
end;//CompareKeys

type _Instance_R_ = Tl3IntegerToIntegerMap;

{$Include ..\L3\l3Map.imp.pas}

end.