unit ImageEnViewRegistrator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ImageEnViewRegistrator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TImageEnViewRegistrator" MUID: (54F47ECF0071)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3IntfUses
 , imageenview
;

type
 TImageEnViewRegistrator = {abstract} class(TImageEnView)
 end;//TImageEnViewRegistrator
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3ImplUses
 , TtfwClassRef_Proxy
 //#UC START# *54F47ECF0071impl_uses*
 //#UC END# *54F47ECF0071impl_uses*
;

initialization
 TtfwClassRef.Register(TImageEnViewRegistrator);
 {* Регистрация TImageEnViewRegistrator }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

end.
