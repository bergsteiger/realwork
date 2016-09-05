unit tfwStandardDictionary;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionary.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwStandardDictionary" MUID: (55B0EF37007C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryEx
;

type
 TtfwStandardDictionary = class(TtfwDictionaryEx)
  protected
   function IsAxiom: Boolean; override;
 end;//TtfwStandardDictionary
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *55B0EF37007Cimpl_uses*
 //#UC END# *55B0EF37007Cimpl_uses*
;

function TtfwStandardDictionary.IsAxiom: Boolean;
//#UC START# *55A7ECD8020D_55B0EF37007C_var*
//#UC END# *55A7ECD8020D_55B0EF37007C_var*
begin
//#UC START# *55A7ECD8020D_55B0EF37007C_impl*
 Result := true;
//#UC END# *55A7ECD8020D_55B0EF37007C_impl*
end;//TtfwStandardDictionary.IsAxiom
{$IfEnd} // NOT Defined(NoScripts)

end.
