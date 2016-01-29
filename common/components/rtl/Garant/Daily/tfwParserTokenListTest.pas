unit tfwParserTokenListTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/tfwParserTokenListTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Containers::TtfwParserTokenListTest
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
 TtfwParserTokenListTest = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure TestAddAndDelete;
 end;//TtfwParserTokenListTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  tfwParser,
  SysUtils,
  l3InterfacedString,
  l3Base,
  l3Parser,
  testCConstDelphiString,
  l3Interfaces,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TtfwParserTokenListTest

procedure TtfwParserTokenListTest.TestAddAndDelete;
//#UC START# *55784B710001_55784B4C022C_var*

 procedure DoTest(const aStr: Il3CString);
 var
  l_L : TtfwParserTokenList;
 begin//DoTest
  l_L := TtfwParserTokenList.Create;
  try
   l_L.Add(TtfwParserToken_C(aStr, l3_ttString));
   l_L.Add(TtfwParserToken_C(aStr, l3_ttString));
   l_L.Delete(0);
   l_L.Delete(0);

   l_L.Add(TtfwParserToken_C(aStr, l3_ttString));
   l_L.Add(TtfwParserToken_C(aStr, l3_ttString));
   l_L.Delete(0);
   l_L.Delete(0);
  finally
   FreeAndNil(l_L);
  end;//try..finally
 end;//DoTest

var
 l_S1 : Tl3InterfacedString;
 l_S2 : TtestCConstDelphiString;
//#UC END# *55784B710001_55784B4C022C_var*
begin
//#UC START# *55784B710001_55784B4C022C_impl*
 l_S1 := Tl3InterfacedString.Create;
 try
  Check(l_S1.RefCount = 1);
  DoTest(l_S1);
  Check(l_S1.RefCount = 1);
 finally
  FreeAndNil(l_S1);
 end;//try..finally
 l_S2 := TtestCConstDelphiString.Create;
 try
  Check(l_S2.RefCount = 1);
  DoTest(l_S2);
  Check(l_S2.RefCount = 1);
 finally
  FreeAndNil(l_S2);
 end;//try..finally
//#UC END# *55784B710001_55784B4C022C_impl*
end;//TtfwParserTokenListTest.TestAddAndDelete

function TtfwParserTokenListTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Containers';
end;//TtfwParserTokenListTest.GetFolder

function TtfwParserTokenListTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55784B4C022C';
end;//TtfwParserTokenListTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TtfwParserTokenListTest.Suite);

end.