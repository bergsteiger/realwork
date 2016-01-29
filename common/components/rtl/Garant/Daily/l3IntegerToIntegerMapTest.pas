unit l3IntegerToIntegerMapTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/l3IntegerToIntegerMapTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::Tl3IntegerToIntegerMapTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 Tl3IntegerToIntegerMapTest = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//Tl3IntegerToIntegerMapTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  l3IntegerToIntegerMap,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class Tl3IntegerToIntegerMapTest

procedure Tl3IntegerToIntegerMapTest.DoIt;
//#UC START# *56090B0D03D1_56090AF902FF_var*
var
 l_M : Tl3IntegerToIntegerMap;
//#UC END# *56090B0D03D1_56090AF902FF_var*
begin
//#UC START# *56090B0D03D1_56090AF902FF_impl*
 l_M := Tl3IntegerToIntegerMap.Create;
 try
  l_M.Add(1, 100);
  l_M.Add(2, 200);
  l_M.Add(3, 300);
  CheckTrue(l_M.Has(1));
  CheckTrue(l_M.Has(2));
  CheckTrue(l_M.Has(3));
  CheckFalse(l_M.Has(4));

  CheckTrue(l_M.IndexByKey(1) = 0);
  CheckTrue(l_M.IndexByKey(2) = 1);
  CheckTrue(l_M.IndexByKey(3) = 2);
  CheckTrue(l_M.IndexByKey(4) = -1);

  CheckTrue(l_M.ValueByKey(1) = 100);
  CheckTrue(l_M.ValueByKey(2) = 200);
  CheckTrue(l_M.ValueByKey(3) = 300);

  CheckTrue(l_M.ValueSlotByKey(1)^ = 100);
  CheckTrue(l_M.ValueSlotByKey(2)^ = 200);
  CheckTrue(l_M.ValueSlotByKey(3)^ = 300);
 finally
  FreeAndNil(l_M);
 end;//try..finally
//#UC END# *56090B0D03D1_56090AF902FF_impl*
end;//Tl3IntegerToIntegerMapTest.DoIt

function Tl3IntegerToIntegerMapTest.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//Tl3IntegerToIntegerMapTest.GetFolder

function Tl3IntegerToIntegerMapTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '56090AF902FF';
end;//Tl3IntegerToIntegerMapTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(Tl3IntegerToIntegerMapTest.Suite);

end.