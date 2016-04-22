unit AFWTest_VCL_TestUnit;
 {* Сюда складываем тесты для стандартных компонент от Borland }

// Модуль: "w:\common\components\gui\Garant\AFW\AFWTest_VCL_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "VCL" MUID: (499AF1EA03DB)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , MenuItem_p
 , Menu_p
 , Control_p
 , WinControl_p
;
{$IfEnd} // NOT Defined(XE)

end.
