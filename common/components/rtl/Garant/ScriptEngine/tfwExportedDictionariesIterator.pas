unit tfwExportedDictionariesIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwExportedDictionariesIterator.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryPtrListIterator
;

type
 TtfwExportedDictionariesIterator = class(TtfwDictionaryPtrListIterator)
  protected
   function ListToIterate: _ListType_; override;
 end;//TtfwExportedDictionariesIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TtfwExportedDictionariesIterator.ListToIterate: _ListType_;
//#UC START# *55AE64E00011_55AE650002D8_var*
//#UC END# *55AE64E00011_55AE650002D8_var*
begin
//#UC START# *55AE64E00011_55AE650002D8_impl*
 Result := Dictionary.ExportedDictionaries;
//#UC END# *55AE64E00011_55AE650002D8_impl*
end;//TtfwExportedDictionariesIterator.ListToIterate
{$IfEnd} // NOT Defined(NoScripts)

end.
