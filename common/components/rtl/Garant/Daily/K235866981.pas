unit K235866981;
 {* [RequestLink:235866981] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235866981.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235866981" MUID: (4CAA05800080)
// Имя типа: "TK235866981"

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
 TK235866981 = class(TPreviewTestBefore235875079)
  {* [RequestLink:235866981] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235866981
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
function TK235866981.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CAA05800080_var*
//#UC END# *51AF49E5001B_4CAA05800080_var*
begin
//#UC START# *51AF49E5001B_4CAA05800080_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CAA05800080_impl*
end;//TK235866981.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK235866981.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235866981.GetFolder

function TK235866981.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CAA05800080';
end;//TK235866981.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235866981.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
