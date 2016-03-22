unit K228689782;
 {* [$228689782] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K228689782.pas"
// Стереотип: "TestCase"
// Элемент модели: "K228689782" MUID: (4C5FAB6C00EE)
// Имя типа: "TK228689782"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK228689782 = class(TPreviewTestBefore235875079)
  {* [$228689782] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK228689782
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
function TK228689782.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C5FAB6C00EE_var*
//#UC END# *4C07AC6F036D_4C5FAB6C00EE_var*
begin
//#UC START# *4C07AC6F036D_4C5FAB6C00EE_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C5FAB6C00EE_impl*
end;//TK228689782.GetNormalFontSize

function TK228689782.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK228689782.GetFolder

function TK228689782.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C5FAB6C00EE';
end;//TK228689782.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK228689782.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C5FAB6C00EE_var*
//#UC END# *51AF49E5001B_4C5FAB6C00EE_var*
begin
//#UC START# *51AF49E5001B_4C5FAB6C00EE_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C5FAB6C00EE_impl*
end;//TK228689782.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK228689782.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
