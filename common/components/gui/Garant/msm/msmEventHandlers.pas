unit msmEventHandlers;

// Модуль: "w:\common\components\gui\Garant\msm\msmEventHandlers.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmEventHandlers" MUID: (57CE887A00A0)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmEvents
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _KeyType_ = TmsmEvent;
 _ValueType_ = TmsmEventHandler;
 {$Include w:\common\components\rtl\Garant\L3\l3ReplacingMap.imp.pas}
 TmsmEventHandlers = class(_l3ReplacingMap_)
 end;//TmsmEventHandlers

implementation

uses
 l3ImplUses
 , l3PointerUtils
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57CE887A00A0impl_uses*
 //#UC END# *57CE887A00A0impl_uses*
;

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_57CE887A00A0_var*
//#UC END# *5609091B00C0_57CE887A00A0_var*
begin
//#UC START# *5609091B00C0_57CE887A00A0_impl*
 Result := l3ComparePointers(aA, aB);
//#UC END# *5609091B00C0_57CE887A00A0_impl*
end;//CompareKeys

type _Instance_R_ = TmsmEventHandlers;

{$Include w:\common\components\rtl\Garant\L3\l3ReplacingMap.imp.pas}

end.
