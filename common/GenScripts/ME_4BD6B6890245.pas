unit ListInfoUserTypes_liListInfo_UserType;
 {* Справка к списку }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes_liListInfo_UserType.pas"
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
 {* Константы для типа формы liListInfo }
 liListInfoName = 'liListInfo';
  {* Строковый идентификатор пользовательского типа "Справка к списку" }
 liListInfo = TvcmUserType(0);
  {* Справка к списку }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_liListInfo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы liListInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_liListInfo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_liListInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::liListInfo';
end;//Tkw_FormUserType_liListInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_liListInfo.GetInteger: Integer;
begin
 Result := liListInfo;
end;//Tkw_FormUserType_liListInfo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_liListInfo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_liListInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
