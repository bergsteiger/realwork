unit PrimQueryCard_utqcLegislationReview_UserType;
 {* Обзор изменений законодательства }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcLegislationReview_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utqcLegislationReview" MUID: (4BD5C36A01B2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcPostingOrder_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки utqcLegislationReviewLocalConstants }
 str_utqcLegislationReviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcLegislationReviewCaption'; rValue : 'Обзор изменений законодательства');
  {* Заголовок пользовательского типа "Обзор изменений законодательства" }
 {* Константы для типа формы utqcLegislationReview }
 utqcLegislationReviewName = 'utqcLegislationReview';
  {* Строковый идентификатор пользовательского типа "Обзор изменений законодательства" }
 utqcLegislationReview = TvcmUserType(utqcPostingOrder + 1);
  {* Обзор изменений законодательства }
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
 Tkw_FormUserType_utqcLegislationReview = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utqcLegislationReview }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcLegislationReview
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcLegislationReview.GetInteger: Integer;
begin
 Result := utqcLegislationReview;
end;//Tkw_FormUserType_utqcLegislationReview.GetInteger

class function Tkw_FormUserType_utqcLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utqcLegislationReview';
end;//Tkw_FormUserType_utqcLegislationReview.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utqcLegislationReviewCaption.Init;
 {* Инициализация str_utqcLegislationReviewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcLegislationReview.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utqcLegislationReview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
