unit K255975907;
 {* [$255975907] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K255975907.pas"
// Стереотип: "TestCase"
// Элемент модели: "K255975907" MUID: (4D7A25F90063)
// Имя типа: "TK255975907"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK255975907 = class({$If NOT Defined(NoVCM)}
 TPreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$255975907] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK255975907
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
 //#UC START# *4D7A25F90063impl_uses*
 //#UC END# *4D7A25F90063impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK255975907.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK255975907.GetFolder

function TK255975907.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D7A25F90063';
end;//TK255975907.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK255975907.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
