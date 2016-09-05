unit K571646843;
 {* [Requestlink:571646843] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K571646843.pas"
// Стереотип: "TestCase"
// Элемент модели: "K571646843" MUID: (54609BED0186)
// Имя типа: "TK571646843"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK571646843 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:571646843] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK571646843
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54609BED0186impl_uses*
 //#UC END# *54609BED0186impl_uses*
;

function TK571646843.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK571646843.GetFolder

function TK571646843.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54609BED0186';
end;//TK571646843.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK571646843.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
