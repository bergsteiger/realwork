unit EverestTest_Editors_TestUnit;
 {* ����� ���������� }

// ������: "w:\common\components\gui\Garant\Everest\EverestTest_Editors_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "Editors" MUID: (49997B6803BC)

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
 , nevSelection_p
 , afwCaret_p
 , evTunedEditor_p
 , afwCustomCaretType_p
;
{$IfEnd} // NOT Defined(XE)

end.
