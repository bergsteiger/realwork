unit Tasks_TestLibrary;

// Модуль: "w:\archi\source\projects\Archi\Tests\Tasks_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "Tasks" MUID: (53BBFFDF0108)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

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
 , Tasks_Registering_TestUnit
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
