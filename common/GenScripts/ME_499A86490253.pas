unit VTTest;
 {* Тесты для VT }

// Модуль: "w:\common\components\gui\Garant\VT\VTTest.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "VTTest" MUID: (499A86490253)

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
 , FakeBox_p
 , SubTree_p
 , vgRemindersLine_p
 , vgReminder_p
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE)

end.
