unit PrimSaveLoadUserTypes_slqtLegislationReview_UserType;
 {* Поиск: ПРАЙМ. Обзор изменений законодательства }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtLegislationReview" MUID: (4BD5BBDE032E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtFilters_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtLegislationReviewLocalConstants }
 str_slqtLegislationReviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtLegislationReviewCaption'; rValue : 'Поиск: ПРАЙМ. Обзор изменений законодательства');
  {* Заголовок пользовательского типа "Поиск: ПРАЙМ. Обзор изменений законодательства" }
 {* Константы для типа формы slqtLegislationReview }
 slqtLegislationReviewName = 'slqtLegislationReview';
  {* Строковый идентификатор пользовательского типа "Поиск: ПРАЙМ. Обзор изменений законодательства" }
 slqtLegislationReview = TvcmUserType(slqtFilters + 1);
  {* Поиск: ПРАЙМ. Обзор изменений законодательства }
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
 Tkw_FormUserType_slqtLegislationReview = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtLegislationReview }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtLegislationReview
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtLegislationReview.GetInteger: Integer;
begin
 Result := slqtLegislationReview;
end;//Tkw_FormUserType_slqtLegislationReview.GetInteger

class function Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtLegislationReview';
end;//Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtLegislationReviewCaption.Init;
 {* Инициализация str_slqtLegislationReviewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtLegislationReview.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtLegislationReview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
