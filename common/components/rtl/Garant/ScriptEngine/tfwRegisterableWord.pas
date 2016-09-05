unit tfwRegisterableWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwRegisterableWord" MUID: (53EDC0E701BC)

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
 //#UC START# *53EDC0E701BCimpl_uses*
 //#UC END# *53EDC0E701BCimpl_uses*
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
