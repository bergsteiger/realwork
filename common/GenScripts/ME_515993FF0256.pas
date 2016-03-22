unit IntStackTestViaMixIn;

// Модуль: "w:\common\components\SandBox\IntStackTestViaMixIn.pas"
// Стереотип: "TestCase"
// Элемент модели: "TIntStackTestViaMixIn" MUID: (515993FF0256)

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , IntStack
;

type
 _StackType_ = TIntStack;
 {$Include w:\common\components\SandBox\StackTest.imp.pas}
 TIntStackTestViaMixIn = class(_StackTest_)
  protected
   function GetEtalonData: TEtalonData; override;
 end;//TIntStackTestViaMixIn
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
;

{$Include w:\common\components\SandBox\StackTest.imp.pas}

function TIntStackTestViaMixIn.GetEtalonData: TEtalonData;
//#UC START# *515993A0015B_515993FF0256_var*
//#UC END# *515993A0015B_515993FF0256_var*
begin
//#UC START# *515993A0015B_515993FF0256_impl*
 Result := ArrayToEtalon([10, 20, 3, 5, 6, 19, 21]);
//#UC END# *515993A0015B_515993FF0256_impl*
end;//TIntStackTestViaMixIn.GetEtalonData

initialization
 TestFramework.RegisterTest(TIntStackTestViaMixIn.Suite);
{$IfEnd} // Defined(nsTest)

end.
