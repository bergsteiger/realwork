program EverestLiteTest;
 {* ����� �������� }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestLiteTest.dpr"
// ���������: "TestTarget"

{$Include EverestLite.inc}

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
