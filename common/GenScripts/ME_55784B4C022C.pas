unit tfwParserTokenListTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\tfwParserTokenListTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtfwParserTokenListTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure TestAddAndDelete;
 end;//TtfwParserTokenListTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwParser
 , SysUtils
 , l3InterfacedString
 , l3Base
 , l3Parser
 , testCConstDelphiString
 , l3Interfaces
 , TestFrameWork
;

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
 {* Папка в которую входит тест }
begin
 Result := 'Containers';
end;//TtfwParserTokenListTest.GetFolder

function TtfwParserTokenListTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55784B4C022C';
end;//TtfwParserTokenListTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TtfwParserTokenListTest.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
