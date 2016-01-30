program NewGenTest;
 {* Тесты для НИР по новому генератору }

// Модуль: "w:\MDProcess\NewGenTest\NewGenTest.dpr"
// Стереотип: "TestTarget"

{$Include NewGenTest.inc}

interface

{$If Defined(NewGen) AND Defined(nsTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(NewGen) AND Defined(nsTest)

implementation

{$If Defined(NewGen) AND Defined(nsTest)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(NewGen) AND Defined(nsTest)

end.
