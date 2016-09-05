unit K249333540;
 {* [$249333540] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K249333540.pas"
// Стереотип: "TestCase"
// Элемент модели: "K249333540" MUID: (4D1C43DD0156)
// Имя типа: "TK249333540"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewWithRowCompare
;

type
 TK249333540 = class(TPreviewWithRowCompare)
  {* [$249333540] }
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
 end;//TK249333540
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
 //#UC START# *4D1C43DD0156impl_uses*
 //#UC END# *4D1C43DD0156impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK249333540.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4D1C43DD0156_var*
//#UC END# *4C07AC6F036D_4D1C43DD0156_var*
begin
//#UC START# *4C07AC6F036D_4D1C43DD0156_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D1C43DD0156_impl*
end;//TK249333540.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK249333540.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D1C43DD0156_var*
//#UC END# *51AF49E5001B_4D1C43DD0156_var*
begin
//#UC START# *51AF49E5001B_4D1C43DD0156_impl*
 Result := true;
//#UC END# *51AF49E5001B_4D1C43DD0156_impl*
end;//TK249333540.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK249333540.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK249333540.GetFolder

function TK249333540.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D1C43DD0156';
end;//TK249333540.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK249333540.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
