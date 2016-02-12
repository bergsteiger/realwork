unit PrimMonitoringsMain_utEmptyMainWindow_UserType;
 {* Главное окно }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\PrimMonitoringsMain_utEmptyMainWindow_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
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
 {* Константы для типа формы utEmptyMainWindow }
 utEmptyMainWindowName = 'utEmptyMainWindow';
  {* Строковый идентификатор пользовательского типа "Главное окно" }
 utEmptyMainWindow = TvcmUserType(0);
  {* Главное окно }
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utEmptyMainWindow = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utEmptyMainWindow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utEmptyMainWindow
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utEmptyMainWindow';
end;//Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister

function Tkw_FormUserType_utEmptyMainWindow.GetInteger: Integer;
begin
 Result := utEmptyMainWindow;
end;//Tkw_FormUserType_utEmptyMainWindow.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utEmptyMainWindow.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utEmptyMainWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
