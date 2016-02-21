unit CustomizeTools_ut_CustomizeTools_UserType;
 {* CustomizeTools }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeTools_ut_CustomizeTools_UserType.pas"
// Стереотип: "UserType"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* Константы для типа формы ut_CustomizeTools }
 ut_CustomizeToolsName = 'ut_CustomizeTools';
  {* Строковый идентификатор пользовательского типа "CustomizeTools" }
 ut_CustomizeTools = TvcmUserType(0);
  {* CustomizeTools }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTools = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_CustomizeTools }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_CustomizeTools
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_CustomizeTools';
end;//Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister

function Tkw_FormUserType_ut_CustomizeTools.GetInteger: Integer;
begin
 Result := ut_CustomizeTools;
end;//Tkw_FormUserType_ut_CustomizeTools.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTools.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_CustomizeTools }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
