unit NemesisTest_Navigator_TestUnit;
 {* ����� ���������� }

// ������: "w:\common\components\gui\Garant\Nemesis\NemesisTest_Navigator_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "Navigator" MUID: (499ABFC003E5)

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
 , nscNavigatorPageControl_p
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
