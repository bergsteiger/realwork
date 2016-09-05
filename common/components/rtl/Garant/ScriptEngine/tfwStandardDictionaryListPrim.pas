unit tfwStandardDictionaryListPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwStandardDictionaryListPrim" MUID: (55B0FF1501FC)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 //#UC START# *55B0FF1501FCimpl_uses*
 //#UC END# *55B0FF1501FCimpl_uses*
;

type _Instance_R_ = TtfwStandardDictionaryListPrim;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
