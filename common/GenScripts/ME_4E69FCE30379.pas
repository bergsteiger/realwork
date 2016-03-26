unit K283149108;
 {* [RequestLink:283149108] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K283149108.pas"
// Стереотип: "TestCase"
// Элемент модели: "K283149108" MUID: (4E69FCE30379)
// Имя типа: "TK283149108"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK283149108 = class(TPreviewTest)
  {* [RequestLink:283149108] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK283149108
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
function TK283149108.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4E69FCE30379_var*
//#UC END# *4C07AC6F036D_4E69FCE30379_var*
begin
//#UC START# *4C07AC6F036D_4E69FCE30379_impl*
 Result := 30;
//#UC END# *4C07AC6F036D_4E69FCE30379_impl*
end;//TK283149108.GetNormalFontSize

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK283149108.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4E69FCE30379_var*
//#UC END# *51AF49E5001B_4E69FCE30379_var*
begin
//#UC START# *51AF49E5001B_4E69FCE30379_impl*
 Result := true;
//#UC END# *51AF49E5001B_4E69FCE30379_impl*
end;//TK283149108.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK283149108.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK283149108.GetFolder

function TK283149108.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E69FCE30379';
end;//TK283149108.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK283149108.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
