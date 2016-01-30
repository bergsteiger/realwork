unit K210437198;
 {* [RequestLink:210437198] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210437198.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK210437198 = class(TPreviewTestBefore235875079)
  {* [RequestLink:210437198] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK210437198
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210437198.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210437198.GetFolder

function TK210437198.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE42A8503AA';
end;//TK210437198.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK210437198.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4BE42A8503AA_var*
//#UC END# *51AF49E5001B_4BE42A8503AA_var*
begin
//#UC START# *51AF49E5001B_4BE42A8503AA_impl*
 Result := true;
//#UC END# *51AF49E5001B_4BE42A8503AA_impl*
end;//TK210437198.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK210437198.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
