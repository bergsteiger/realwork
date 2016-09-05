unit vtComboTree;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\vtComboTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvtComboTree" MUID: (55B780E60398)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , FakeBox
;

type
 TvtComboTree = class(TFakeBox)
 end;//TvtComboTree

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , vtComboTreeWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtComboBoxWordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *55B780E60398impl_uses*
 //#UC END# *55B780E60398impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtComboTree);
 {* Регистрация TvtComboTree }
{$IfEnd} // NOT Defined(NoScripts)

end.
