unit EverestTest;
 {* ����� ���������� ������� }

// ������: "w:\common\components\gui\Garant\Everest\EverestTest.pas"
// ���������: "TestLibrary"
// ������� ������: "EverestTest" MUID: (49997AF300BA)

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
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE)

end.
