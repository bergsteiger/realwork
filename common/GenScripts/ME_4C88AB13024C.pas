unit K234363360;
 {* [$234363360] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K234363360.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PasteColumnTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK234363360 = class(TPasteColumnTest)
  {* [$234363360] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK234363360
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

function TK234363360.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK234363360.GetFolder

function TK234363360.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C88AB13024C';
end;//TK234363360.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234363360.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
