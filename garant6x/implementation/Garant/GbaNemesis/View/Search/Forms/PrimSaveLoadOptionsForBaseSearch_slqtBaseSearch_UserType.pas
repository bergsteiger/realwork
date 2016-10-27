unit PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType;
 {* Базовый поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtBaseSearch" MUID: (4D7A26C701BE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtBaseSearchLocalConstants }
 str_slqtBaseSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtBaseSearchCaption'; rValue : 'Базовый поиск');
  {* Заголовок пользовательского типа "Базовый поиск" }
 {* Константы для типа формы slqtBaseSearch }
 slqtBaseSearchName = 'slqtBaseSearch';
  {* Строковый идентификатор пользовательского типа "Базовый поиск" }
 slqtBaseSearch = TvcmUserType(0);
  {* Базовый поиск }
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
 Tkw_FormUserType_slqtBaseSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtBaseSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtBaseSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtBaseSearch.GetInteger: Integer;
begin
 Result := slqtBaseSearch;
end;//Tkw_FormUserType_slqtBaseSearch.GetInteger

class function Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtBaseSearch';
end;//Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtBaseSearchCaption.Init;
 {* Инициализация str_slqtBaseSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtBaseSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtBaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
