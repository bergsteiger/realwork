unit K264902374;
 {* [$264902374] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K264902374.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SelectCommentAndDelete
;

type
 TK264902374 = class(TSelectCommentAndDelete)
  {* [$264902374] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK264902374
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK264902374.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK264902374.GetFolder

function TK264902374.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DD6003B0093';
end;//TK264902374.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK264902374.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
