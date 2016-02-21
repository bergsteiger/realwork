unit PrimCommonDiction_utMedicDiction_UserType;
 {* Словарь медицинских терминов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utMedicDiction_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCommonDiction_utTips_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы utMedicDiction }
 utMedicDictionName = 'utMedicDiction';
  {* Строковый идентификатор пользовательского типа "Словарь медицинских терминов" }
 utMedicDiction = TvcmUserType(utTips + 1);
  {* Словарь медицинских терминов }
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
 Tkw_FormUserType_utMedicDiction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utMedicDiction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utMedicDiction
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utMedicDiction';
end;//Tkw_FormUserType_utMedicDiction.GetWordNameForRegister

function Tkw_FormUserType_utMedicDiction.GetInteger: Integer;
begin
 Result := utMedicDiction;
end;//Tkw_FormUserType_utMedicDiction.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMedicDiction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utMedicDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
