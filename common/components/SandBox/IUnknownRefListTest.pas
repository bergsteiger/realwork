unit IUnknownRefListTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "IUnknownRefListTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::FinalContainersTests::IUnknownRefListTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork,
  IUnknownRefList
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 _ListType_ = TIUnknownRefList;
 {$Include ..\SandBox\ListTest.imp.pas}
 TIUnknownRefListTest = class(_ListTest_)
 published
 // published methods
   procedure DoIt;
 end;//TIUnknownRefListTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

{$Include ..\SandBox\ListTest.imp.pas}

// start class TIUnknownRefListTest

procedure TIUnknownRefListTest.DoIt;
//#UC START# *51E80B2F02CF_51E80B08039E_var*
var
 l_List : _ListType_;
//#UC END# *51E80B2F02CF_51E80B08039E_var*
begin
//#UC START# *51E80B2F02CF_51E80B08039E_impl*
 l_List := CreateList;
 try
  // - Пока больше ничего не делаем
 finally
  FreeAndNil(l_List);
 end;//try..finally
//#UC END# *51E80B2F02CF_51E80B08039E_impl*
end;//TIUnknownRefListTest.DoIt

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TIUnknownRefListTest.Suite);

end.