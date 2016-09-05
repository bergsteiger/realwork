unit tb97Control;

// Модуль: "w:\common\components\rtl\external\tb97\tb97Control.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Ttb97Control" MUID: (50288ABF02F4)

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
 , afwCustomCommonControl
;

type
 Ttb97Control = class(TafwCustomCommonControl)
 end;//Ttb97Control
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *50288ABF02F4impl_uses*
 //#UC END# *50288ABF02F4impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ttb97Control);
 {* Регистрация Ttb97Control }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

end.
