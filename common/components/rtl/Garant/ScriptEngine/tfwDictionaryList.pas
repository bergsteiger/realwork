unit tfwDictionaryList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwDictionaryList" MUID: (55A4E71403B3)

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
 , SyncObjs
;

type
 _ItemType_ = TtfwDictionaryEx;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.imp.pas}
 _tfwNamedDictionaryList_Parent_ = _tfwDictionaryList_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwNamedDictionaryList.imp.pas}
 TtfwDictionaryList = class(_tfwNamedDictionaryList_)
 end;//TtfwDictionaryList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3String
 //#UC START# *55A4E71403B3impl_uses*
 //#UC END# *55A4E71403B3impl_uses*
;

type _Instance_R_ = TtfwDictionaryList;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwNamedDictionaryList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
