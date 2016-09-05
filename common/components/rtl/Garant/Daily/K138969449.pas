unit K138969449;
 {* [Requestlink:138969449] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K138969449.pas"
// Стереотип: "TestCase"
// Элемент модели: "K138969449" MUID: (562F5F4703A6)
// Имя типа: "TK138969449"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK138969449 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:138969449] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK138969449
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *562F5F4703A6impl_uses*
 //#UC END# *562F5F4703A6impl_uses*
;

function TK138969449.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK138969449.GetFolder

function TK138969449.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '562F5F4703A6';
end;//TK138969449.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK138969449.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
