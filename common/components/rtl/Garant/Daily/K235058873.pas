unit K235058873;
 {* [$235058873] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235058873.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235058873" MUID: (4CA2DC560112)
// Имя типа: "TK235058873"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK235058873 = class(TEVDtoNSRCPlusWriterTest)
  {* [$235058873] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235058873
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4CA2DC560112impl_uses*
 //#UC END# *4CA2DC560112impl_uses*
;

function TK235058873.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235058873.GetFolder

function TK235058873.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA2DC560112';
end;//TK235058873.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235058873.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
