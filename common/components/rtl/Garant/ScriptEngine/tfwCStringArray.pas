unit tfwCStringArray;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwCStringArray" MUID: (4F4D384500A3)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , tfwCStringList
 , l3Interfaces
;

type
 _ItemType_ = Il3CString;
 _l3OpenArray_Parent_ = TtfwCStringList;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 TtfwCStringArray = class(_l3OpenArray_)
 end;//TtfwCStringArray

implementation

uses
 l3ImplUses
 , l3Base
 , l3Memory
 //#UC START# *4F4D384500A3impl_uses*
 //#UC END# *4F4D384500A3impl_uses*
;

type _Instance_R_ = TtfwCStringArray;

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

end.
