unit ListUserTypes_lftConsultation_UserType;
 {* Консультация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftConsultation_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCR2_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы lftConsultation }
 lftConsultationName = 'lftConsultation';
  {* Строковый идентификатор пользовательского типа "Консультация" }
 lftConsultation = TvcmUserType(lftUserCR2 + 1);
  {* Консультация }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftConsultation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftConsultation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftConsultation
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftConsultation';
end;//Tkw_FormUserType_lftConsultation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftConsultation.GetInteger: Integer;
begin
 Result := lftConsultation;
end;//Tkw_FormUserType_lftConsultation.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftConsultation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftConsultation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
