unit tfwDictionaryListPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListPrim.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

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
 {$Include tfwDictionaryList.imp.pas}
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
;

type _Instance_R_ = TtfwDictionaryListPrim;

{$Include tfwDictionaryList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
