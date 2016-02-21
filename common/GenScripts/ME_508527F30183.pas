unit tfwControlString;
 {* Слово для регистрации контрола и его класса }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwControlString.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwString
;

type
 TtfwControlString = {abstract} class(TtfwString)
  {* Слово для регистрации контрола и его класса }
  public
   class procedure Register(const aName: AnsiString;
    aClass: TClass);
 end;//TtfwControlString
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3Except
 , tfwClassRef
 , SysUtils
 , StrUtils
;

class procedure TtfwControlString.Register(const aName: AnsiString;
 aClass: TClass);
//#UC START# *508528490090_508527F30183_var*
//#UC END# *508528490090_508527F30183_var*
begin
//#UC START# *508528490090_508527F30183_impl*
 inherited Register(aName);
 TtfwClassRef.Register(aClass);
//#UC END# *508528490090_508527F30183_impl*
end;//TtfwControlString.Register

initialization
 TtfwControlString.RegisterClass;
 {* Регистрация TtfwControlString }
{$IfEnd} // NOT Defined(NoScripts)

end.
