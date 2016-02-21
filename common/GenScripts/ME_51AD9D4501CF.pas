unit K459282006;
 {* [Requestlink:459282006] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K459282006.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PageCountTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK459282006 = class(TPageCountTest)
  {* [Requestlink:459282006] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK459282006
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

function TK459282006.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK459282006.GetFolder

function TK459282006.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51AD9D4501CF';
end;//TK459282006.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK459282006.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
