unit K245204495;
 {* [$245204495] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K245204495.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewWithLinesTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK245204495 = class(TPreviewWithLinesTestBefore235875079)
  {* [$245204495] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK245204495
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

function TK245204495.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK245204495.GetFolder

function TK245204495.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D0097F601C2';
end;//TK245204495.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK245204495.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
