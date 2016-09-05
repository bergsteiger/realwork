unit K245761265;
 {* [RequestLink:245761265] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K245761265.pas"
// Стереотип: "TestCase"
// Элемент модели: "K245761265" MUID: (4D02731B0161)
// Имя типа: "TK245761265"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoBlockTest
;

type
 TK245761265 = class(TAutoBlockTest)
  {* [RequestLink:245761265] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK245761265
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
 //#UC START# *4D02731B0161impl_uses*
 //#UC END# *4D02731B0161impl_uses*
;

function TK245761265.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK245761265.GetFolder

function TK245761265.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D02731B0161';
end;//TK245761265.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK245761265.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
