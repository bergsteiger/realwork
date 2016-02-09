unit tfwUsedDictionariesIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwUsedDictionariesIterator.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryPtrListIterator
;

type
 TtfwUsedDictionariesIterator = class(TtfwDictionaryPtrListIterator)
  protected
   function ListToIterate: _ListType_; override;
 end;//TtfwUsedDictionariesIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TtfwUsedDictionariesIterator.ListToIterate: _ListType_;
//#UC START# *55AE64E00011_55AE651402AA_var*
//#UC END# *55AE64E00011_55AE651402AA_var*
begin
//#UC START# *55AE64E00011_55AE651402AA_impl*
 Result := Dictionary.UsedDictionaries;
//#UC END# *55AE64E00011_55AE651402AA_impl*
end;//TtfwUsedDictionariesIterator.ListToIterate
{$IfEnd} // NOT Defined(NoScripts)

end.
