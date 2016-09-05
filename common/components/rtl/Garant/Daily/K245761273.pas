unit K245761273;
 {* [RequestLink:245761273] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K245761273.pas"
// Стереотип: "TestCase"
// Элемент модели: "K245761273" MUID: (4D02576200E5)
// Имя типа: "TK245761273"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoBlockTest
;

type
 TK245761273 = class(TAutoBlockTest)
  {* [RequestLink:245761273] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK245761273
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4D02576200E5impl_uses*
 //#UC END# *4D02576200E5impl_uses*
;

function TK245761273.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK245761273.GetFolder

function TK245761273.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D02576200E5';
end;//TK245761273.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK245761273.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
