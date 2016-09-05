unit tfwDictionaryListPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwDictionaryListPrim" MUID: (559E758B01BB)

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
;

type
 _ItemType_ = TtfwDictionaryEx;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.imp.pas}
 TtfwDictionaryListPrim = class(_tfwDictionaryList_)
 end;//TtfwDictionaryListPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *559E758B01BBimpl_uses*
 //#UC END# *559E758B01BBimpl_uses*
;

type _Instance_R_ = TtfwDictionaryListPrim;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
