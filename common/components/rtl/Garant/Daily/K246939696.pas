unit K246939696;
 {* [RequestLink:246939696] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K246939696.pas"
// Стереотип: "TestCase"
// Элемент модели: "K246939696" MUID: (4D05FBFF02C3)
// Имя типа: "TK246939696"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoBlockTest
;

type
 TK246939696 = class(TAutoBlockTest)
  {* [RequestLink:246939696] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK246939696
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

function TK246939696.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK246939696.GetFolder

function TK246939696.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D05FBFF02C3';
end;//TK246939696.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK246939696.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
