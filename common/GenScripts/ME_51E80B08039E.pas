unit IUnknownRefListTest;

// Модуль: "w:\common\components\SandBox\IUnknownRefListTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , IUnknownRefList
;

type
 _ListType_ = TIUnknownRefList;
 {$Include w:\common\components\SandBox\ListTest.imp.pas}
 TIUnknownRefListTest = class(_ListTest_)
  public
   procedure DoIt;
 end;//TIUnknownRefListTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
;

{$Include w:\common\components\SandBox\ListTest.imp.pas}

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

initialization
 TestFramework.RegisterTest(TIUnknownRefListTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
