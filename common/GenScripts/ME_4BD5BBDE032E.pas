unit PrimSaveLoadUserTypes_slqtLegislationReview_UserType;
 {* Поиск: ПРАЙМ. Обзор изменений законодательства }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtFilters_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtLegislationReview = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtLegislationReview }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtLegislationReview
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtLegislationReview';
end;//Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister

function Tkw_FormUserType_slqtLegislationReview.GetInteger: Integer;
begin
 Result := slqtLegislationReview;
end;//Tkw_FormUserType_slqtLegislationReview.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtLegislationReview.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtLegislationReview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
