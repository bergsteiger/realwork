unit K627385907;
 {* [Requestlink:627385907] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K627385907.pas"
// Стереотип: "TestCase"
// Элемент модели: "K627385907" MUID: (578E1F0A02DF)
// Имя типа: "TK627385907"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK627385907 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:627385907] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK627385907
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *578E1F0A02DFimpl_uses*
 //#UC END# *578E1F0A02DFimpl_uses*
;

function TK627385907.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK627385907.GetFolder

function TK627385907.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '578E1F0A02DF';
end;//TK627385907.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK627385907.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
