unit K235869064;
 {* [$235869064] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235869064.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewTestBefore235875079WithRowCmp
;

type
 TK235869064 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$235869064] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK235869064
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

function TK235869064.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235869064.GetFolder

function TK235869064.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CD80FD90017';
end;//TK235869064.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK235869064.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CD80FD90017_var*
//#UC END# *51AF49E5001B_4CD80FD90017_var*
begin
//#UC START# *51AF49E5001B_4CD80FD90017_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CD80FD90017_impl*
end;//TK235869064.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK235869064.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
