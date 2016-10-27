unit ListUserTypes_lftUserCRList1_SynchorForm_UserType;
 {* Синхронный просмотр (настраиваемая вкладка связанных документов 1) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCRList1_SynchorForm_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftUserCRList1_SynchorForm" MUID: (4BD58AB1025D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftRespondentsSynchroForm_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки lftUserCRList1_SynchorFormLocalConstants }
 str_lftUserCRList1_SynchorFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormCaption'; rValue : 'Синхронный просмотр (настраиваемая вкладка связанных документов 1)');
  {* Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" }
 str_lftUserCRList1_SynchorFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormSettingsCaption'; rValue : 'Синхронный просмотр: Первая пользовательская вкладка списка ссылкок на документ\из документа');
  {* Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" для настройки панелей инструментов }
 {* Константы для типа формы lftUserCRList1_SynchorForm }
 lftUserCRList1_SynchorFormName = 'lftUserCRList1_SynchorForm';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" }
 lftUserCRList1_SynchorForm = TvcmUserType(lftRespondentsSynchroForm + 1);
  {* Синхронный просмотр (настраиваемая вкладка связанных документов 1) }
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
 Tkw_FormUserType_lftUserCRList1_SynchorForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftUserCRList1_SynchorForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftUserCRList1_SynchorForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftUserCRList1_SynchorForm.GetInteger: Integer;
begin
 Result := lftUserCRList1_SynchorForm;
end;//Tkw_FormUserType_lftUserCRList1_SynchorForm.GetInteger

class function Tkw_FormUserType_lftUserCRList1_SynchorForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftUserCRList1_SynchorForm';
end;//Tkw_FormUserType_lftUserCRList1_SynchorForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftUserCRList1_SynchorFormCaption.Init;
 {* Инициализация str_lftUserCRList1_SynchorFormCaption }
 str_lftUserCRList1_SynchorFormSettingsCaption.Init;
 {* Инициализация str_lftUserCRList1_SynchorFormSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCRList1_SynchorForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftUserCRList1_SynchorForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
