unit tfwCStringArray;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas"
// Стереотип: "SimpleClass"

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
;

{$If not Declared(_FindDataType_)}type _FindDataType_ = Tl3WString;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

type _Instance_R_ = TtfwCStringArray;

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

end.
