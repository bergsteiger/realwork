unit PrimQueryCard_utqcSendConsultation_UserType;
 {* Правовая поддержка онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcSendConsultation_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utqcSendConsultation" MUID: (4BD5C37D030C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcLegislationReview_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки utqcSendConsultationLocalConstants }
 str_utqcSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcSendConsultationCaption'; rValue : 'Правовая поддержка онлайн');
  {* Заголовок пользовательского типа "Правовая поддержка онлайн" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utqcSendConsultation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utqcSendConsultation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcSendConsultation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcSendConsultation.GetInteger: Integer;
begin
 Result := utqcSendConsultation;
end;//Tkw_FormUserType_utqcSendConsultation.GetInteger

class function Tkw_FormUserType_utqcSendConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utqcSendConsultation';
end;//Tkw_FormUserType_utqcSendConsultation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utqcSendConsultationCaption.Init;
 {* Инициализация str_utqcSendConsultationCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcSendConsultation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utqcSendConsultation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
