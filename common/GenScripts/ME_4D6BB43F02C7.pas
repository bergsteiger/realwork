unit NemesisTest_Editor_TestUnit;

// ������: "w:\common\components\gui\Garant\Nemesis\NemesisTest_Editor_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "Editor" MUID: (4D6BB43F02C7)

{$Include w:\common\components\gui\Garant\Nemesis\l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

implementation

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3ImplUses
 , nscSimpleEditor_p
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
