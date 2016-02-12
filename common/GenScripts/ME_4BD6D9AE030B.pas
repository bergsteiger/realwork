unit PrimTasksPanel_tpMain_UserType;
 {* Панель задач }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_tpMain_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы tpMain }
 tpMainName = 'tpMain';
  {* Строковый идентификатор пользовательского типа "Панель задач" }
 tpMain = TvcmUserType(0);
  {* Панель задач }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_tpMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы tpMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_tpMain
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_tpMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::tpMain';
end;//Tkw_FormUserType_tpMain.GetWordNameForRegister

function Tkw_FormUserType_tpMain.GetInteger: Integer;
begin
 Result := tpMain;
end;//Tkw_FormUserType_tpMain.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_tpMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_tpMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
