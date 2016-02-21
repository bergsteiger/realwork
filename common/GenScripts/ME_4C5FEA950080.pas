unit K228688660;
 {* [$228688660] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K228688660.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK228688660 = class(TScrollTest)
  {* [$228688660] }
  protected
   {$If NOT Defined(NoVCM)}
   function ScrollByPage: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK228688660
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
function TK228688660.ScrollByPage: Boolean;
//#UC START# *4BEBFE020080_4C5FEA950080_var*
//#UC END# *4BEBFE020080_4C5FEA950080_var*
begin
//#UC START# *4BEBFE020080_4C5FEA950080_impl*
 Result := False;
//#UC END# *4BEBFE020080_4C5FEA950080_impl*
end;//TK228688660.ScrollByPage
{$IfEnd} // NOT Defined(NoVCM)

function TK228688660.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK228688660.GetFolder

function TK228688660.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C5FEA950080';
end;//TK228688660.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228688660.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
