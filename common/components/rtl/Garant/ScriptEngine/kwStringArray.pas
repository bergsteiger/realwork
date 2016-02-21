unit kwStringArray;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStringArray.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwStringListPrim
;

type
 _l3OpenArray_Parent_ = TkwStringListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 TkwStringArray = class(_l3OpenArray_)
 end;//TkwStringArray
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , kwString
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = TkwString;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TkwStringArray;

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
