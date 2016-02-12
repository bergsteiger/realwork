unit tfwDictionaryPrimPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrim.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryPrimPrimPrim
 , l3Interfaces
 , l3Types
;

type
 _l3DelphiStringSearcher_Parent_ = TtfwDictionaryPrimPrimPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3DelphiStringSearcher.imp.pas}
 TtfwDictionaryPrimPrim = {abstract} class(_l3DelphiStringSearcher_)
 end;//TtfwDictionaryPrimPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Variant
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3PrimString;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TtfwDictionaryPrimPrim;

{$Include w:\common\components\rtl\Garant\L3\l3DelphiStringSearcher.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
