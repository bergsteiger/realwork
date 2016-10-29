unit ListUserTypes_lftSynchroView_UserType;
 {* Синхронный просмотр (ссылки из документа, ссылки на документ) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSynchroView_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftSynchroView" MUID: (4BD5888802BA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCorrespondent_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки lftSynchroViewLocalConstants }
 str_lftSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewCaption'; rValue : 'Синхронный просмотр (ссылки из документа, ссылки на документ)');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" }
 str_lftSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок из документа/на документ');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" для настройки панелей инструментов }
 {* Константы для типа формы lftSynchroView }
 lftSynchroViewName = 'lftSynchroView';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" }
 lftSynchroView = TvcmUserType(lftCorrespondent + 1);
  {* Синхронный просмотр (ссылки из документа, ссылки на документ) }
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
 Tkw_FormUserType_lftSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSynchroView.GetInteger: Integer;
begin
 Result := lftSynchroView;
end;//Tkw_FormUserType_lftSynchroView.GetInteger

class function Tkw_FormUserType_lftSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftSynchroView';
end;//Tkw_FormUserType_lftSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftSynchroViewCaption.Init;
 {* Инициализация str_lftSynchroViewCaption }
 str_lftSynchroViewSettingsCaption.Init;
 {* Инициализация str_lftSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
