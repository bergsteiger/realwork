unit K91850237;
 {* [$91850237] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K91850237.pas"
// Стереотип: "TestCase"
// Элемент модели: "K91850237" MUID: (4D79E21C03A5)
// Имя типа: "TK91850237"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , VerticalCursorMovingTest
;

type
 TK91850237 = class(TVerticalCursorMovingTest)
  {* [$91850237] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK91850237
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK91850237.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK91850237.GetFolder

function TK91850237.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D79E21C03A5';
end;//TK91850237.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK91850237.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
