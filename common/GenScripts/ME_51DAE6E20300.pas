unit MemorySizeTest;

// Модуль: "w:\common\components\SandBox\MemorySizeTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "MemorySizeTest" MUID: (51DAE6E20300)
// Имя типа: "TMemorySizeTest"

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TMemorySizeTest = class(TTestCase)
  published
   procedure DoIt;
 end;//TMemorySizeTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , l3MemorySizeUtils
 , SysUtils
;

procedure TMemorySizeTest.DoIt;
//#UC START# *51DAE7030012_51DAE6E20300_var*
var
 l_Index : Integer;
 l_Size  : Integer;
 l_RealSize : Integer;
 l_P     : Pointer;
//#UC END# *51DAE7030012_51DAE6E20300_var*
begin
//#UC START# *51DAE7030012_51DAE6E20300_impl*
 for l_Index := 1 to 4 * 1024 do
 begin
  l_Size := l_Index * 2;
  System.GetMem(l_P, l_Size);
  try
   l_RealSize := l3MemorySize(l_P);
   Check(l_RealSize >= l_Size, Format('Выделяли %d. Выделилось %d.', [l_Size, l_RealSize]));
  finally
   System.FreeMem(l_P);
  end;//try..finally
 end;//form l_Index
//#UC END# *51DAE7030012_51DAE6E20300_impl*
end;//TMemorySizeTest.DoIt

initialization
 TestFramework.RegisterTest(TMemorySizeTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
