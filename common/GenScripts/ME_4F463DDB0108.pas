unit tfwDictionaryPrimPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwDictionaryPrimPrim" MUID: (4F463DDB0108)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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

type _Instance_R_ = TtfwDictionaryPrimPrim;

{$Include w:\common\components\rtl\Garant\L3\l3DelphiStringSearcher.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
