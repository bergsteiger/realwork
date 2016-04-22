unit VCMTest_Profilers_TestUnit;
 {* Профилирование }

// Модуль: "w:\common\components\gui\Garant\VCM\VCMTest_Profilers_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "Profilers" MUID: (499AA4590080)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmProfilersCollection_p
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

end.
