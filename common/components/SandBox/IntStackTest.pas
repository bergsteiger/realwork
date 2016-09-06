unit IntStackTest;

// Модуль: "w:\common\components\SandBox\IntStackTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TIntStackTest" MUID: (5155CA4E0028)

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TIntStackTest = {final} class(TTestCase)
  published
   procedure DoIt;
 end;//TIntStackTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , IntStack
 , SysUtils
 //#UC START# *5155CA4E0028impl_uses*
 //#UC END# *5155CA4E0028impl_uses*
;

procedure TIntStackTest.DoIt;
//#UC START# *5155CA8A02A6_5155CA4E0028_var*
const
 cEtalons : array [0..3] of integer = (10, 20, 3, 5);
var
 l_S : TIntStack;
 l_I : Integer;
//#UC END# *5155CA8A02A6_5155CA4E0028_var*
begin
//#UC START# *5155CA8A02A6_5155CA4E0028_impl*
 l_S := TIntStack.Create;
 try
  for l_I := Low(cEtalons) to High(cEtalons) do
   l_S.Push(cEtalons[l_I]);
  for l_I := High(cEtalons) downto Low(cEtalons) do
   Check(l_S.Pop = cEtalons[l_I]);
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *5155CA8A02A6_5155CA4E0028_impl*
end;//TIntStackTest.DoIt

initialization
 TestFramework.RegisterTest(TIntStackTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
