unit PrimStyleEditorNavigator_utStyleEditorNavigator_UserType;
 {* Дерево стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorNavigator_utStyleEditorNavigator_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utStyleEditorNavigator" MUID: (50F562DF02DB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utStyleEditorNavigatorLocalConstants }
 str_utStyleEditorNavigatorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorNavigatorCaption'; rValue : 'Дерево стилей');
  {* Заголовок пользовательского типа "Дерево стилей" }
 str_utStyleEditorNavigatorSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorNavigatorSettingsCaption'; rValue : 'Дерево стилей');
  {* Заголовок пользовательского типа "Дерево стилей" для настройки панелей инструментов }
 {* Константы для типа формы utStyleEditorNavigator }
 utStyleEditorNavigatorName = 'utStyleEditorNavigator';
  {* Строковый идентификатор пользовательского типа "Дерево стилей" }
 utStyleEditorNavigator = TvcmUserType(0);
  {* Дерево стилей }
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
 Tkw_FormUserType_utStyleEditorNavigator = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utStyleEditorNavigator }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utStyleEditorNavigator
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utStyleEditorNavigator.GetInteger: Integer;
begin
 Result := utStyleEditorNavigator;
end;//Tkw_FormUserType_utStyleEditorNavigator.GetInteger

class function Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utStyleEditorNavigator';
end;//Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utStyleEditorNavigatorCaption.Init;
 {* Инициализация str_utStyleEditorNavigatorCaption }
 str_utStyleEditorNavigatorSettingsCaption.Init;
 {* Инициализация str_utStyleEditorNavigatorSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorNavigator.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utStyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
