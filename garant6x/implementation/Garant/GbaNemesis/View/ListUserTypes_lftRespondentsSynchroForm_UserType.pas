unit ListUserTypes_lftRespondentsSynchroForm_UserType;
 {* Синхронный просмотр (ссылка из документа) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondentsSynchroForm_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftRespondentsSynchroForm" MUID: (4BD58A780204)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки lftRespondentsSynchroFormLocalConstants }
 str_lftRespondentsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormCaption'; rValue : 'Синхронный просмотр (ссылка из документа)');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылка из документа)" }
 str_lftRespondentsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок из документа');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылка из документа)" для настройки панелей инструментов }
 {* Константы для типа формы lftRespondentsSynchroForm }
 lftRespondentsSynchroFormName = 'lftRespondentsSynchroForm';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр (ссылка из документа)" }
 lftRespondentsSynchroForm = TvcmUserType(lftCorrespondentsSynchroForm + 1);
  {* Синхронный просмотр (ссылка из документа) }
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
 Tkw_FormUserType_lftRespondentsSynchroForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftRespondentsSynchroForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftRespondentsSynchroForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger: Integer;
begin
 Result := lftRespondentsSynchroForm;
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger

class function Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftRespondentsSynchroForm';
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftRespondentsSynchroFormCaption.Init;
 {* Инициализация str_lftRespondentsSynchroFormCaption }
 str_lftRespondentsSynchroFormSettingsCaption.Init;
 {* Инициализация str_lftRespondentsSynchroFormSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondentsSynchroForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftRespondentsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
