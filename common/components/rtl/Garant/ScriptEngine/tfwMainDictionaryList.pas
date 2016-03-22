unit tfwMainDictionaryList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwMainDictionaryList" MUID: (55A63D16038C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwMainDictionary
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
 _ItemType_ = TtfwMainDictionary;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas}
 _tfwNamedDictionaryList_Parent_ = _tfwSortedDictionaryList_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwNamedDictionaryList.imp.pas}
 TtfwMainDictionaryList = class(_tfwNamedDictionaryList_)
 end;//TtfwMainDictionaryList
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

type _Instance_R_ = TtfwMainDictionaryList;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwNamedDictionaryList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
