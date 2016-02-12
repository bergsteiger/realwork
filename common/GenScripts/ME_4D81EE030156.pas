unit DictionContainerUserTypes_slqtMedicDiction_UserType;
 {* Словарь медицинских терминов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes_slqtMedicDiction_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionContainerUserTypes_slqtDiction_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы slqtMedicDiction }
 slqtMedicDictionName = 'slqtMedicDiction';
  {* Строковый идентификатор пользовательского типа "Словарь медицинских терминов" }
 slqtMedicDiction = TvcmUserType(slqtDiction + 1);
  {* Словарь медицинских терминов }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtMedicDiction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtMedicDiction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtMedicDiction
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtMedicDiction';
end;//Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister

function Tkw_FormUserType_slqtMedicDiction.GetInteger: Integer;
begin
 Result := slqtMedicDiction;
end;//Tkw_FormUserType_slqtMedicDiction.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtMedicDiction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtMedicDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
