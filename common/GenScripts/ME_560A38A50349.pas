unit ddExportFilerMap;

// Модуль: "w:\common\components\rtl\Garant\dd\PipeOut\ddExportFilerMap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddExportFilerMap" MUID: (560A38A50349)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddPipeOutInterfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _KeyType_ = TddFilerDispatcherMapKeyRecord;
 _ValueType_ = IddExportFilerDispatcherElem;
 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 TddExportFilerMap = class(_l3Map_)
 end;//TddExportFilerMap

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_560A38A50349_var*
//#UC END# *5609091B00C0_560A38A50349_var*
begin
//#UC START# *5609091B00C0_560A38A50349_impl*
 if aA.rPart > aB.rPart then
  Result := 1
 else
 if aA.rPart < aB.rPart then
  Result := -1
 else
 Result := l3Compare(aA.rAccGroup.AsWStr, aB.rAccGroup.AsWStr);
//#UC END# *5609091B00C0_560A38A50349_impl*
end;//CompareKeys

type _Instance_R_ = TddExportFilerMap;

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

end.
