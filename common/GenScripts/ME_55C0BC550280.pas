unit tfwDictionaryCachePrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCachePrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryEx
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , tfwDictionaryExPrim
;

type
 _ItemType_ = TtfwDictionaryEx;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas}
 _tfwNamedDictionaryList_Parent_ = _tfwSortedDictionaryList_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwNamedDictionaryList.imp.pas}
 TtfwDictionaryCachePrim = class(_tfwNamedDictionaryList_)
 end;//TtfwDictionaryCachePrim
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

type _Instance_R_ = TtfwDictionaryCachePrim;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwNamedDictionaryList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
