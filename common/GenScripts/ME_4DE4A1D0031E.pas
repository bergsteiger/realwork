program ArchiTest;
 {* ����� ���� }

// ������: "w:\archi\source\projects\Archi\ArchiTest.dpr"
// ���������: "TestTarget"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
