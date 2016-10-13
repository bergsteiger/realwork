unit K631435596;
 {* [Requestlink:631435596] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K631435596.pas"
// Стереотип: "TestCase"
// Элемент модели: "K631435596" MUID: (57F62EDA0266)
// Имя типа: "TK631435596"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK631435596 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:631435596] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK631435596
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *57F62EDA0266impl_uses*
 //#UC END# *57F62EDA0266impl_uses*
;

function TK631435596.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK631435596.GetFolder

function TK631435596.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '57F62EDA0266';
end;//TK631435596.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK631435596.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
