unit tfwDictionaryPtrList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrList.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwDictionaryExPrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

 {$Define l3Items_NoChanging}

type
 _ItemType_ = TtfwDictionaryExPrim;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TtfwDictionaryPtrList = class(_l3ObjectPtrList_)
 end;//TtfwDictionaryPtrList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TtfwDictionaryPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
