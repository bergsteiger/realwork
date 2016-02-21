unit FromWithPanel_ut_FromWithPanel_UserType;
 {* FromWithPanel }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\FromWithPanel_ut_FromWithPanel_UserType.pas"
// Стереотип: "UserType"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* Константы для типа формы ut_FromWithPanel }
 ut_FromWithPanelName = 'ut_FromWithPanel';
  {* Строковый идентификатор пользовательского типа "FromWithPanel" }
 ut_FromWithPanel = TvcmUserType(0);
  {* FromWithPanel }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_FromWithPanel = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_FromWithPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_FromWithPanel
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_FromWithPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_FromWithPanel';
end;//Tkw_FormUserType_ut_FromWithPanel.GetWordNameForRegister

function Tkw_FormUserType_ut_FromWithPanel.GetInteger: Integer;
begin
 Result := ut_FromWithPanel;
end;//Tkw_FormUserType_ut_FromWithPanel.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_FromWithPanel.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_FromWithPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
