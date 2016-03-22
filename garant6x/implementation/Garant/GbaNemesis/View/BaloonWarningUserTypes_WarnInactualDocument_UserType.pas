unit BaloonWarningUserTypes_WarnInactualDocument_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnInactualDocument_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnInactualDocument" MUID: (4DA8298B020E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnOnControl_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы WarnInactualDocument }
 WarnInactualDocumentName = 'WarnInactualDocument';
  {* Строковый идентификатор пользовательского типа "" }
 WarnInactualDocument = TvcmUserType(WarnOnControl + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_WarnInactualDocument = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnInactualDocument }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnInactualDocument
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnInactualDocument.GetInteger: Integer;
begin
 Result := WarnInactualDocument;
end;//Tkw_FormUserType_WarnInactualDocument.GetInteger

class function Tkw_FormUserType_WarnInactualDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnInactualDocument';
end;//Tkw_FormUserType_WarnInactualDocument.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnInactualDocument.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnInactualDocument }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
