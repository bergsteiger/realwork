unit SandBoxTest_TestLibrary;

// Модуль: "w:\common\components\SandBox\SandBoxTest_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "SandBoxTest" MUID: (5155865B01B6)

{$Include w:\common\components\SandBox\sbtDefine.inc}

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
 {$If NOT Defined(NoScripts)}
 , ScriptTestLibrary_TestLibrary
 {$IfEnd} // NOT Defined(NoScripts)
 , IntStackTest
 , StringStackTest
 , IntStackTestViaMixIn
 , StringStackTestViaMixIn
 , RefcountedTest
 , myInterfacedObjectTest
 , myReferenceCountGuardTest
 , ServiceTest
 , ReallocMemTest
 , RoundedControlsTest
 , MemorySizeTest
 , Int64ListTest
 , IntegerListTest
 , IUnknownRefListTest
 , ByteListTest
;
{$IfEnd} // Defined(nsTest)

end.
