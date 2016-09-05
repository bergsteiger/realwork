unit K206079241;
 {* [RequestLink:206079241]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K206079241.pas"
// Стереотип: "TestCase"
// Элемент модели: "K206079241" MUID: (4C1A582D009F)
// Имя типа: "TK206079241"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
;

type
 TK206079241 = class({$If NOT Defined(NoVCM)}
 TScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:206079241]. }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK206079241
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
 //#UC START# *4C1A582D009Fimpl_uses*
 //#UC END# *4C1A582D009Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TK206079241.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C1A582D009F_var*
//#UC END# *4C08CF700318_4C1A582D009F_var*
begin
//#UC START# *4C08CF700318_4C1A582D009F_impl*
 Result.X := 1024;
 Result.Y := 768;
//#UC END# *4C08CF700318_4C1A582D009F_impl*
end;//TK206079241.FormExtent

function TK206079241.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK206079241.GetFolder

function TK206079241.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1A582D009F';
end;//TK206079241.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206079241.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
