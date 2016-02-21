unit K228693150;
 {* [RequestLink:228693150] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K228693150.pas"
// Стереотип: "TestCase"

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
 TK228693150 = class(TTwoEmptyParaForOneReplacerTest)
  {* [RequestLink:228693150] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK228693150
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

function TK228693150.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK228693150.GetFolder

function TK228693150.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C5147EC013F';
end;//TK228693150.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228693150.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
