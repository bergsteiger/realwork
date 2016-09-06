unit NOT_FINISHED_GUITestRunner;

// Модуль: "w:\common\components\rtl\external\DUnit\src\NOT_FINISHED_GUITestRunner.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "GUITestRunner" MUID: (4B2A0D9401CC)

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
;

type
 TGUITestRunner = class
 end;//TGUITestRunner

procedure RunRegisteredTests;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , vtComboBoxQS
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwKeyWordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 //#UC START# *4B2A0D9401CCimpl_uses*
 //#UC END# *4B2A0D9401CCimpl_uses*
;

procedure RunRegisteredTests;
//#UC START# *4B2A0DAC0037_4B2A0D9401CC_var*
//#UC END# *4B2A0DAC0037_4B2A0D9401CC_var*
begin
//#UC START# *4B2A0DAC0037_4B2A0D9401CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2A0DAC0037_4B2A0D9401CC_impl*
end;//RunRegisteredTests
{$IfEnd} // Defined(nsTest)

end.
