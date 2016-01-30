unit PrimConsultationMark_utcmMain_UserType;
 {* Оценка ответа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMark_utcmMain_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы utcmMain }
 utcmMainName = 'utcmMain';
  {* Строковый идентификатор пользовательского типа "Оценка ответа" }
 utcmMain = TvcmUserType(0);
  {* Оценка ответа }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utcmMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utcmMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utcmMain
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utcmMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utcmMain';
end;//Tkw_FormUserType_utcmMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utcmMain.GetInteger: Integer;
begin
 Result := utcmMain;
end;//Tkw_FormUserType_utcmMain.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utcmMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utcmMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
