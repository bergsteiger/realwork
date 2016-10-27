unit ListUserTypes_lftConsultation_UserType;
 {* Консультация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftConsultation_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftConsultation" MUID: (4BD589B50312)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCR2_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки lftConsultationLocalConstants }
 str_lftConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationCaption'; rValue : 'Консультация');
  {* Заголовок пользовательского типа "Консультация" }
 str_lftConsultationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationSettingsCaption'; rValue : 'Список: Консультация');
  {* Заголовок пользовательского типа "Консультация" для настройки панелей инструментов }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftConsultation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftConsultation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftConsultation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftConsultation.GetInteger: Integer;
begin
 Result := lftConsultation;
end;//Tkw_FormUserType_lftConsultation.GetInteger

class function Tkw_FormUserType_lftConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftConsultation';
end;//Tkw_FormUserType_lftConsultation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftConsultationCaption.Init;
 {* Инициализация str_lftConsultationCaption }
 str_lftConsultationSettingsCaption.Init;
 {* Инициализация str_lftConsultationSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftConsultation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftConsultation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
