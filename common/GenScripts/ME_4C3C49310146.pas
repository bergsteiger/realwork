unit K226001269;
 {* [$226001269] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K226001269.pas"
// Стереотип: "TestCase"
// Элемент модели: "K226001269" MUID: (4C3C49310146)
// Имя типа: "TK226001269"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TwoSpaceForOneReplacerTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK226001269 = class(TTwoSpaceForOneReplacerTest)
  {* [$226001269] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK226001269
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
function TK226001269.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK226001269.GetFolder

function TK226001269.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3C49310146';
end;//TK226001269.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226001269.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
