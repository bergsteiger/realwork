unit ListUserTypes_lftDrugInternationalNameSynonyms_UserType;
 {* Синонимы по международному названию }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugInternationalNameSynonyms_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftDrugList_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы lftDrugInternationalNameSynonyms }
 lftDrugInternationalNameSynonymsName = 'lftDrugInternationalNameSynonyms';
  {* Строковый идентификатор пользовательского типа "Синонимы по международному названию" }
 lftDrugInternationalNameSynonyms = TvcmUserType(lftDrugList + 1);
  {* Синонимы по международному названию }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugInternationalNameSynonyms = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftDrugInternationalNameSynonyms }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftDrugInternationalNameSynonyms';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister

function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger: Integer;
begin
 Result := lftDrugInternationalNameSynonyms;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugInternationalNameSynonyms.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftDrugInternationalNameSynonyms }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
