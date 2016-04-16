unit K235875079;
 {* [RequestLink:235875079] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235875079.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235875079" MUID: (4D1897A20249)
// Имя типа: "TK235875079"

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
 TK235875079 = class({$If NOT Defined(NoVCM)}
 TPreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:235875079] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235875079
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
{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK235875079.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D1897A20249_var*
//#UC END# *51AF49E5001B_4D1897A20249_var*
begin
//#UC START# *51AF49E5001B_4D1897A20249_impl*
 Result := true;
//#UC END# *51AF49E5001B_4D1897A20249_impl*
end;//TK235875079.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK235875079.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK235875079.GetFolder

function TK235875079.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D1897A20249';
end;//TK235875079.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235875079.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
