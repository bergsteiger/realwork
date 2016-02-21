unit DocumentUserTypes_dftDictSubEntry_UserType;
 {* Перевод словарной статьи }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDictSubEntry_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDictEntry_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы dftDictSubEntry }
 dftDictSubEntryName = 'dftDictSubEntry';
  {* Строковый идентификатор пользовательского типа "Перевод словарной статьи" }
 dftDictSubEntry = TvcmUserType(dftDictEntry + 1);
  {* Перевод словарной статьи }
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
 Tkw_FormUserType_dftDictSubEntry = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftDictSubEntry }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftDictSubEntry
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftDictSubEntry.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftDictSubEntry';
end;//Tkw_FormUserType_dftDictSubEntry.GetWordNameForRegister

function Tkw_FormUserType_dftDictSubEntry.GetInteger: Integer;
begin
 Result := dftDictSubEntry;
end;//Tkw_FormUserType_dftDictSubEntry.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDictSubEntry.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftDictSubEntry }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
