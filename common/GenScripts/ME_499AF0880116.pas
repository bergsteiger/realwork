unit AFWTest;
 {* Тесты для AFW и стандартных библиотек }

// Модуль: "w:\common\components\gui\Garant\AFW\AFWTest.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "AFWTest" MUID: (499AF0880116)

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
 , Component_p
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE)

end.
