unit K227477421;
 {* [$227477421] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K227477421.pas"
// Стереотип: "TestCase"
// Элемент модели: "K227477421" MUID: (4C46BCC6031B)
// Имя типа: "TK227477421"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackByLineWithCheckTopAnchoTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK227477421 = class({$If NOT Defined(NoVCM)}
 TScrollBackByLineWithCheckTopAnchoTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$227477421] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK227477421
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
 //#UC START# *4C46BCC6031Bimpl_uses*
 //#UC END# *4C46BCC6031Bimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TK227477421.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C46BCC6031B_var*
//#UC END# *4C07AC6F036D_4C46BCC6031B_var*
begin
//#UC START# *4C07AC6F036D_4C46BCC6031B_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C46BCC6031B_impl*
end;//TK227477421.GetNormalFontSize

function TK227477421.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK227477421.GetFolder

function TK227477421.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C46BCC6031B';
end;//TK227477421.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227477421.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
