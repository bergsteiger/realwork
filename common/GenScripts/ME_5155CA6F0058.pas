unit StringStackTest;

// Модуль: "w:\common\components\SandBox\StringStackTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TStringStackTest = class(TTestCase)
  public
   procedure DoIt;
 end;//TStringStackTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , StringStack
 , SysUtils
;

procedure TStringStackTest.DoIt;
//#UC START# *5155CA990036_5155CA6F0058_var*
const
 cEtalons : array [0..3] of String = ('мама', 'мыла', 'раму', 'весело');
var
 l_S : TStringStack;
 l_I : Integer;
//#UC END# *5155CA990036_5155CA6F0058_var*
begin
//#UC START# *5155CA990036_5155CA6F0058_impl*
 l_S := TStringStack.Create;
 try
  for l_I := Low(cEtalons) to High(cEtalons) do
   l_S.Push(cEtalons[l_I]);
  for l_I := High(cEtalons) downto Low(cEtalons) do
   Check(l_S.Pop = cEtalons[l_I]);
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *5155CA990036_5155CA6F0058_impl*
end;//TStringStackTest.DoIt

initialization
 TestFramework.RegisterTest(TStringStackTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
