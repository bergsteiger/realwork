unit DocumentUserTypes_dftRelatedSynchroView_UserType;
 {* Справка к документу (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftRelatedSynchroView_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftRelatedSynchroView" MUID: (4B040E560333)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDocSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dftRelatedSynchroViewLocalConstants }
 str_dftRelatedSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewCaption'; rValue : 'Справка к документу (синхронный просмотр)');
  {* Заголовок пользовательского типа "Справка к документу (синхронный просмотр)" }
 str_dftRelatedSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Справка к документу');
  {* Заголовок пользовательского типа "Справка к документу (синхронный просмотр)" для настройки панелей инструментов }
 {* Константы для типа формы dftRelatedSynchroView }
 dftRelatedSynchroViewName = 'dftRelatedSynchroView';
  {* Строковый идентификатор пользовательского типа "Справка к документу (синхронный просмотр)" }
 dftRelatedSynchroView = TvcmUserType(dftDocSynchroView + 1);
  {* Справка к документу (синхронный просмотр) }
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
 Tkw_FormUserType_dftRelatedSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftRelatedSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftRelatedSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftRelatedSynchroView.GetInteger: Integer;
begin
 Result := dftRelatedSynchroView;
end;//Tkw_FormUserType_dftRelatedSynchroView.GetInteger

class function Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftRelatedSynchroView';
end;//Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftRelatedSynchroViewCaption.Init;
 {* Инициализация str_dftRelatedSynchroViewCaption }
 str_dftRelatedSynchroViewSettingsCaption.Init;
 {* Инициализация str_dftRelatedSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftRelatedSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftRelatedSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
