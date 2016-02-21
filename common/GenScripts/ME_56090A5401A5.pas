unit l3IntegerToIntegerMap;

// Модуль: "w:\common\components\rtl\Garant\L3\l3IntegerToIntegerMap.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _KeyType_ = Integer;
 _ValueType_ = Integer;
 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 Tl3IntegerToIntegerMap = class(_l3Map_)
 end;//Tl3IntegerToIntegerMap

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

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

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

end.
