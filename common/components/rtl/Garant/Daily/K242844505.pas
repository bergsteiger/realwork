unit K242844505;
 {* [$242844505] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K242844505.pas"
// Стереотип: "TestCase"
// Элемент модели: "K242844505" MUID: (4CF77CF103CB)
// Имя типа: "TK242844505"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewTestBefore235875079WithRowCmp
;

type
 TK242844505 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$242844505] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK242844505
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
 //#UC START# *4CF77CF103CBimpl_uses*
 //#UC END# *4CF77CF103CBimpl_uses*
;

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK242844505.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CF77CF103CB_var*
//#UC END# *51AF49E5001B_4CF77CF103CB_var*
begin
//#UC START# *51AF49E5001B_4CF77CF103CB_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CF77CF103CB_impl*
end;//TK242844505.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK242844505.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK242844505.GetFolder

function TK242844505.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CF77CF103CB';
end;//TK242844505.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK242844505.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
