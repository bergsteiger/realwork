unit tfwCStringArray;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

uses
 l3IntfUses
 , tfwCStringList
 , l3Interfaces
;

type
 _ItemType_ = Il3CString;
 _l3OpenArray_Parent_ = TtfwCStringList;
 {$Include l3OpenArray.imp.pas}
 TtfwCStringArray = class(_l3OpenArray_)
 end;//TtfwCStringArray

implementation

uses
 l3ImplUses
 , l3Base
;

type _Instance_R_ = TtfwCStringArray;

{$Include l3OpenArray.imp.pas}

end.
