unit K206079417;
 {* [RequestLink:206079417] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K206079417.pas"
// Стереотип: "TestCase"
// Элемент модели: "K206079417" MUID: (4D076ADA00B9)
// Имя типа: "TK206079417"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsAfterCopyPasteTest
;

type
 TK206079417 = class(TTextMetricsAfterCopyPasteTest)
  {* [RequestLink:206079417] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK206079417
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , evTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4D076ADA00B9impl_uses*
 //#UC END# *4D076ADA00B9impl_uses*
;

function TK206079417.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK206079417.GetFolder

function TK206079417.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D076ADA00B9';
end;//TK206079417.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206079417.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
