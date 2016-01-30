unit myInterfacedObjectTest;

// Модуль: "w:\common\components\SandBox\myInterfacedObjectTest.pas"
// Стереотип: "TestCase"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TmyInterfacedObjectTest = class(TTestCase)
  public
   procedure DoIt;
 end;//TmyInterfacedObjectTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , myInterfacedObject
 , SysUtils
;

procedure TmyInterfacedObjectTest.DoIt;
//#UC START# *516D4FDE0133_516D4FB9038C_var*
var
 l_O : TmyInterfacedObject;
 l_AnotherRef : TmyInterfacedObject;
 l_A : IUnknown;
 l_B : IUnknown;
//#UC END# *516D4FDE0133_516D4FB9038C_var*
begin
//#UC START# *516D4FDE0133_516D4FB9038C_impl*
 l_AnotherRef := nil;
 try
  l_O := TmyInterfacedObject.Create;
  try
   Check(l_O.RefCount = 1);
   l_A := l_O;
   Check(l_O.RefCount = 2);
   l_A := nil;
   Check(l_O.RefCount = 1);
   l_AnotherRef := l_O.Use;
   Check(l_O.RefCount = 2);
   l_B := l_O;
   Check(l_O.RefCount = 3);
  finally
   FreeAndNil(l_O);
  end;//try..finally
  Check(l_AnotherRef.RefCount = 2);
  l_B := nil;
  Check(l_AnotherRef.RefCount = 1);
 finally
  FreeAndNil(l_AnotherRef);
 end;//try..finally
//#UC END# *516D4FDE0133_516D4FB9038C_impl*
end;//TmyInterfacedObjectTest.DoIt

initialization
 TestFramework.RegisterTest(TmyInterfacedObjectTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
