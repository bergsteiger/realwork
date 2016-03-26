unit K282693895;
 {* [RequestLink:282693895] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K282693895.pas"
// Стереотип: "TestCase"
// Элемент модели: "K282693895" MUID: (4EEF59E700E3)
// Имя типа: "TK282693895"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , FormulaRender
;

type
 TK282693895 = class(TFormulaRender)
  {* [RequestLink:282693895] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK282693895
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

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK282693895.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4EEF59E700E3_var*
//#UC END# *51AF49E5001B_4EEF59E700E3_var*
begin
//#UC START# *51AF49E5001B_4EEF59E700E3_impl*
 Result := true;
//#UC END# *51AF49E5001B_4EEF59E700E3_impl*
end;//TK282693895.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK282693895.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK282693895.GetFolder

function TK282693895.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EEF59E700E3';
end;//TK282693895.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK282693895.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
