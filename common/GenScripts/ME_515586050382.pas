program SandBoxTest;

// Модуль: "w:\common\components\SandBoxTest\SandBoxTest.dpr"
// Стереотип: "TestTarget"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest)

end.
