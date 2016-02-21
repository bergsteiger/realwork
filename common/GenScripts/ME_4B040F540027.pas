unit DocumentUserTypes_dftConsultation_UserType;
 {* Консультация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftConsultation_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAutoreferatAfterSearch_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы dftConsultation }
 dftConsultationName = 'dftConsultation';
  {* Строковый идентификатор пользовательского типа "Консультация" }
 dftConsultation = TvcmUserType(dftAutoreferatAfterSearch + 1);
  {* Консультация }
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
 Tkw_FormUserType_dftConsultation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftConsultation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftConsultation
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftConsultation';
end;//Tkw_FormUserType_dftConsultation.GetWordNameForRegister

function Tkw_FormUserType_dftConsultation.GetInteger: Integer;
begin
 Result := dftConsultation;
end;//Tkw_FormUserType_dftConsultation.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftConsultation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftConsultation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
