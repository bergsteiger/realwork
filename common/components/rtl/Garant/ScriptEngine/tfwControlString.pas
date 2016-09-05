unit tfwControlString;
 {* Слово для регистрации контрола и его класса }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwControlString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwControlString" MUID: (508527F30183)

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
 //#UC START# *508527F30183impl_uses*
 //#UC END# *508527F30183impl_uses*
;

initialization
 TtfwControlString.RegisterClass;
 {* Регистрация TtfwControlString }
{$IfEnd} // NOT Defined(NoScripts)

end.
