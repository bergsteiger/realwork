program ReleaseNewGenTest;
 {* Тесты для НИР по новому генератору (релизный вариант) }

// Модуль: "w:\MDProcess\NewGenTest\ReleaseNewGenTest.dpr"
// Стереотип: "TestTarget"

{$Include NewGenTest.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(NewGen)

end.
