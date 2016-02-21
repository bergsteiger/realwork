unit kwIntegerArray;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwIntegerArray.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIntegerList
;

type
 _l3OpenArray_Parent_ = TkwIntegerList;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 TkwIntegerArray = class(_l3OpenArray_)
 end;//TkwIntegerArray
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , kwInteger
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = TkwInteger;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TkwIntegerArray;

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
