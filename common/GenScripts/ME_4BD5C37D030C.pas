unit PrimQueryCard_utqcSendConsultation_UserType;
 {* Правовая поддержка онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcSendConsultation_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcLegislationReview_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы utqcSendConsultation }
 utqcSendConsultationName = 'utqcSendConsultation';
  {* Строковый идентификатор пользовательского типа "Правовая поддержка онлайн" }
 utqcSendConsultation = TvcmUserType(utqcLegislationReview + 1);
  {* Правовая поддержка онлайн }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcSendConsultation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utqcSendConsultation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utqcSendConsultation
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utqcSendConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utqcSendConsultation';
end;//Tkw_FormUserType_utqcSendConsultation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcSendConsultation.GetInteger: Integer;
begin
 Result := utqcSendConsultation;
end;//Tkw_FormUserType_utqcSendConsultation.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcSendConsultation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utqcSendConsultation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
