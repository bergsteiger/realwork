unit K224789639;
 {* [$224789639] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K224789639.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewTestBefore235875079WithRowCmp
;

type
 TK224789639 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$224789639] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK224789639
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , PrintRowHeightsSpy
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
function TK224789639.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4CBC1CA70020_var*
//#UC END# *4C07AC6F036D_4CBC1CA70020_var*
begin
//#UC START# *4C07AC6F036D_4CBC1CA70020_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4CBC1CA70020_impl*
end;//TK224789639.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK224789639.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK224789639.GetFolder

function TK224789639.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CBC1CA70020';
end;//TK224789639.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224789639.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
