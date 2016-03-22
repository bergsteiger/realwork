unit StringStackTestViaMixIn;

// Модуль: "w:\common\components\SandBox\StringStackTestViaMixIn.pas"
// Стереотип: "TestCase"
// Элемент модели: "TStringStackTestViaMixIn" MUID: (515994210223)

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , StringStack
;

type
 _StackType_ = TStringStack;
 {$Include w:\common\components\SandBox\StackTest.imp.pas}
 TStringStackTestViaMixIn = class(_StackTest_)
  protected
   function GetEtalonData: TEtalonData; override;
 end;//TStringStackTestViaMixIn
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
;

{$Include w:\common\components\SandBox\StackTest.imp.pas}

function TStringStackTestViaMixIn.GetEtalonData: TEtalonData;
//#UC START# *515993A0015B_515994210223_var*
//#UC END# *515993A0015B_515994210223_var*
begin
//#UC START# *515993A0015B_515994210223_impl*
 Result := ArrayToEtalon(['мама', 'мыла', 'раму', 'весело', 'и', 'споро']);
//#UC END# *515993A0015B_515994210223_impl*
end;//TStringStackTestViaMixIn.GetEtalonData

initialization
 TestFramework.RegisterTest(TStringStackTestViaMixIn.Suite);
{$IfEnd} // Defined(nsTest)

end.
