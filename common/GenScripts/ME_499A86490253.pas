unit VTTest;
 {* ����� ��� VT }

// ������: "w:\common\components\gui\Garant\VT\VTTest.pas"
// ���������: "TestLibrary"
// ������� ������: "VTTest" MUID: (499A86490253)

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
 , VTTest_ComboTree_TestUnit
 , VTTest_NewReminders_TestUnit
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE)

end.
