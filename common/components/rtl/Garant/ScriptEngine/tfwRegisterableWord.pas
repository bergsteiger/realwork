unit tfwRegisterableWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWord.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWordPrim
;

type
 TtfwRegisterableWord = {abstract} class(TtfwRegisterableWordPrim)
  public
   class function NameForRegister: AnsiString; override;
 end;//TtfwRegisterableWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAutoregisteredDiction
;

class function TtfwRegisterableWord.NameForRegister: AnsiString;
//#UC START# *52D7B67501CE_53EDC0E701BC_var*
//#UC END# *52D7B67501CE_53EDC0E701BC_var*
begin
//#UC START# *52D7B67501CE_53EDC0E701BC_impl*
 Result := GetWordNameForRegister;
//#UC END# *52D7B67501CE_53EDC0E701BC_impl*
end;//TtfwRegisterableWord.NameForRegister

initialization
 TtfwRegisterableWord.RegisterClass;
 {* Регистрация TtfwRegisterableWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
