unit K165514106;
 {* [RequestLink:165514106] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K165514106.pas"
// Стереотип: "TestCase"
// Элемент модели: "K165514106" MUID: (4C288F1F0017)
// Имя типа: "TK165514106"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TwoEmptyParaForOneReplacerTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK165514106 = class({$If NOT Defined(NoVCM)}
 TTwoEmptyParaForOneReplacerTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:165514106] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK165514106
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
;

{$If NOT Defined(NoVCM)}
function TK165514106.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK165514106.GetFolder

function TK165514106.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C288F1F0017';
end;//TK165514106.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK165514106.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
