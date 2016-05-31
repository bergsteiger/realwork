unit PrimSaveLoadUserTypes_slqtInpharmSearch_UserType;
 {* Поиск лекарственных средств }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtInpharmSearch_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtInpharmSearch" MUID: (4BD5BC86008F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtInpharmSearchLocalConstants }
 str_slqtInpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtInpharmSearchCaption'; rValue : 'Поиск лекарственных средств');
  {* Заголовок пользовательского типа "Поиск лекарственных средств" }
 {* Константы для типа формы slqtInpharmSearch }
 slqtInpharmSearchName = 'slqtInpharmSearch';
  {* Строковый идентификатор пользовательского типа "Поиск лекарственных средств" }
 slqtInpharmSearch = TvcmUserType(slqtConsult + 1);
  {* Поиск лекарственных средств }
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
 Tkw_FormUserType_slqtInpharmSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtInpharmSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtInpharmSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtInpharmSearch.GetInteger: Integer;
begin
 Result := slqtInpharmSearch;
end;//Tkw_FormUserType_slqtInpharmSearch.GetInteger

class function Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtInpharmSearch';
end;//Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtInpharmSearchCaption.Init;
 {* Инициализация str_slqtInpharmSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtInpharmSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtInpharmSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
