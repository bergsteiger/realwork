unit DocumentUserTypes_dftTranslation_UserType;
 {* Перевод }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTranslation_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftTranslation" MUID: (4B040F7C030A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftConsultation_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки dftTranslationLocalConstants }
 str_dftTranslationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationCaption'; rValue : 'Перевод');
  {* Заголовок пользовательского типа "Перевод" }
 str_dftTranslationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationSettingsCaption'; rValue : 'Документ: Перевод');
  {* Заголовок пользовательского типа "Перевод" для настройки панелей инструментов }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftTranslation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftTranslation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftTranslation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftTranslation.GetInteger: Integer;
begin
 Result := dftTranslation;
end;//Tkw_FormUserType_dftTranslation.GetInteger

class function Tkw_FormUserType_dftTranslation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftTranslation';
end;//Tkw_FormUserType_dftTranslation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftTranslationCaption.Init;
 {* Инициализация str_dftTranslationCaption }
 str_dftTranslationSettingsCaption.Init;
 {* Инициализация str_dftTranslationSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTranslation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftTranslation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
