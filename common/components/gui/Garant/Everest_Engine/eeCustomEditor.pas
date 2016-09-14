unit eeCustomEditor;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeCustomEditor.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "eeCustomEditor" MUID: (54C24DE1010C)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , eeEditor
;

type
 TeeCustomEditor = eeEditor.TeeCustomEditor;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *54C24DE1010Cimpl_uses*
 //#UC END# *54C24DE1010Cimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeCustomEditor));
 {* Регистрация типа TeeCustomEditor }
{$IfEnd} // NOT Defined(NoScripts)

end.
