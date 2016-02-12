unit DocumentUserTypes_dftMedDictEntry_UserType;
 {* Описание медицинского термина }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedDictEntry_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftTips_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftMedDictEntry }
 dftMedDictEntryName = 'dftMedDictEntry';
  {* Строковый идентификатор пользовательского типа "Описание медицинского термина" }
 dftMedDictEntry = TvcmUserType(dftTips + 1);
  {* Описание медицинского термина }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedDictEntry = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftMedDictEntry }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftMedDictEntry
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftMedDictEntry';
end;//Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister

function Tkw_FormUserType_dftMedDictEntry.GetInteger: Integer;
begin
 Result := dftMedDictEntry;
end;//Tkw_FormUserType_dftMedDictEntry.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedDictEntry.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftMedDictEntry }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
