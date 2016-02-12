unit DocumentUserTypes_dftTranslation_UserType;
 {* Перевод }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTranslation_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftConsultation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftTranslation }
 dftTranslationName = 'dftTranslation';
  {* Строковый идентификатор пользовательского типа "Перевод" }
 dftTranslation = TvcmUserType(dftConsultation + 1);
  {* Перевод }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTranslation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftTranslation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftTranslation
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftTranslation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftTranslation';
end;//Tkw_FormUserType_dftTranslation.GetWordNameForRegister

function Tkw_FormUserType_dftTranslation.GetInteger: Integer;
begin
 Result := dftTranslation;
end;//Tkw_FormUserType_dftTranslation.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTranslation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftTranslation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
