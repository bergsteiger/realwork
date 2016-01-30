unit ContentsUserTypes_utContents_UserType;
 {* Структура документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes_utContents_UserType.pas"
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
 {* Константы для типа формы utContents }
 utContentsName = 'utContents';
  {* Строковый идентификатор пользовательского типа "Структура документа" }
 utContents = TvcmUserType(0);
  {* Структура документа }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utContents = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utContents }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utContents
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utContents.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utContents';
end;//Tkw_FormUserType_utContents.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utContents.GetInteger: Integer;
begin
 Result := utContents;
end;//Tkw_FormUserType_utContents.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utContents.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utContents }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
