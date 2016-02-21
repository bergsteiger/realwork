unit K321983051;
 {* [RequestLink:321983051] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K321983051.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , FormulaRender
;

type
 TK321983051 = class(TFormulaRender)
  {* [RequestLink:321983051] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function GetZoom: Integer; override;
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK321983051
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

function TK321983051.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK321983051.GetFolder

function TK321983051.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EF0A00F0280';
end;//TK321983051.GetModelElementGUID

function TK321983051.GetZoom: Integer;
//#UC START# *4EF0A04A0286_4EF0A00F0280_var*
//#UC END# *4EF0A04A0286_4EF0A00F0280_var*
begin
//#UC START# *4EF0A04A0286_4EF0A00F0280_impl*
 Result := 80;
//#UC END# *4EF0A04A0286_4EF0A00F0280_impl*
end;//TK321983051.GetZoom

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK321983051.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4EF0A00F0280_var*
//#UC END# *51AF49E5001B_4EF0A00F0280_var*
begin
//#UC START# *51AF49E5001B_4EF0A00F0280_impl*
 Result := true;
//#UC END# *51AF49E5001B_4EF0A00F0280_impl*
end;//TK321983051.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK321983051.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
