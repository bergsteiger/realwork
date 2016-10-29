unit PrimSaveLoadUserTypes_slqtOldKW_UserType;
 {* Поиск: По ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtOldKW_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtOldKW" MUID: (4BD5BB9E0201)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtKW_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtOldKWLocalConstants }
 str_slqtOldKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWCaption'; rValue : 'Поиск: По ситуации');
  {* Заголовок пользовательского типа "Поиск: По ситуации" }
 str_slqtOldKWSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWSettingsCaption'; rValue : 'Поиск: По ситуации (Преемственный)');
  {* Заголовок пользовательского типа "Поиск: По ситуации" для настройки панелей инструментов }
 {* Константы для типа формы slqtOldKW }
 slqtOldKWName = 'slqtOldKW';
  {* Строковый идентификатор пользовательского типа "Поиск: По ситуации" }
 slqtOldKW = TvcmUserType(slqtKW + 1);
  {* Поиск: По ситуации }
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
 Tkw_FormUserType_slqtOldKW = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtOldKW }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtOldKW
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtOldKW.GetInteger: Integer;
begin
 Result := slqtOldKW;
end;//Tkw_FormUserType_slqtOldKW.GetInteger

class function Tkw_FormUserType_slqtOldKW.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtOldKW';
end;//Tkw_FormUserType_slqtOldKW.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtOldKWCaption.Init;
 {* Инициализация str_slqtOldKWCaption }
 str_slqtOldKWSettingsCaption.Init;
 {* Инициализация str_slqtOldKWSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtOldKW.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtOldKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
