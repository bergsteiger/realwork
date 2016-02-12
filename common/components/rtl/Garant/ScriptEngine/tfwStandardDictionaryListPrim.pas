unit tfwStandardDictionaryListPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListPrim.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwStandardDictionary
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TtfwStandardDictionary;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas}
 TtfwStandardDictionaryListPrim = class(_tfwSortedDictionaryList_)
 end;//TtfwStandardDictionaryListPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TtfwStandardDictionaryListPrim;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
