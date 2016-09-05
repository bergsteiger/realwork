unit K622840683;
 {* [Requestlink:622840683] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K622840683.pas"
// Стереотип: "TestCase"
// Элемент модели: "K622840683" MUID: (57342D1B03C8)
// Имя типа: "TK622840683"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK622840683 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:622840683] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK622840683
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *57342D1B03C8impl_uses*
 //#UC END# *57342D1B03C8impl_uses*
;

function TK622840683.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK622840683.GetFolder

function TK622840683.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '57342D1B03C8';
end;//TK622840683.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK622840683.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
