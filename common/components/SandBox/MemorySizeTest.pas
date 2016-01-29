unit MemorySizeTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "MemorySizeTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::Memory::MemorySizeTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TMemorySizeTest = class(TTestCase)
 published
 // published methods
   procedure DoIt;
 end;//TMemorySizeTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  l3MemorySizeUtils,
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TMemorySizeTest

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

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TMemorySizeTest.Suite);

end.