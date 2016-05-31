unit PrimGroupList_admGroupList_UserType;
 {* Группы пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupList_admGroupList_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "admGroupList" MUID: (4BD71DC30222)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки admGroupListLocalConstants }
 str_admGroupListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListCaption'; rValue : 'Группы пользователей');
  {* Заголовок пользовательского типа "Группы пользователей" }
 str_admGroupListSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListSettingsCaption'; rValue : 'Группы пользователей (вкладка)');
  {* Заголовок пользовательского типа "Группы пользователей" для настройки панелей инструментов }
 {* Константы для типа формы admGroupList }
 admGroupListName = 'admGroupList';
  {* Строковый идентификатор пользовательского типа "Группы пользователей" }
 admGroupList = TvcmUserType(0);
  {* Группы пользователей }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_admGroupList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы admGroupList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_admGroupList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_admGroupList.GetInteger: Integer;
begin
 Result := admGroupList;
end;//Tkw_FormUserType_admGroupList.GetInteger

class function Tkw_FormUserType_admGroupList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::admGroupList';
end;//Tkw_FormUserType_admGroupList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_admGroupListCaption.Init;
 {* Инициализация str_admGroupListCaption }
 str_admGroupListSettingsCaption.Init;
 {* Инициализация str_admGroupListSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admGroupList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_admGroupList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
