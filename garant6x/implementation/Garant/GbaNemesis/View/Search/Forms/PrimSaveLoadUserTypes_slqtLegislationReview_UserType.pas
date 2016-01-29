unit PrimSaveLoadUserTypes_slqtLegislationReview_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtLegislationReview
//
// Поиск: ПРАЙМ. Обзор изменений законодательства
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimSaveLoadUserTypes_slqtFilters_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы slqtLegislationReview }
  slqtLegislationReviewName = 'slqtLegislationReview';
   { Строковый идентификатор пользовательского типа "Поиск: ПРАЙМ. Обзор изменений законодательства" }
  slqtLegislationReview = TvcmUserType(slqtFilters + 1);
   { Поиск: ПРАЙМ. Обзор изменений законодательства }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtLegislationReview = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtLegislationReview }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtLegislationReview
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtLegislationReview

class function Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtLegislationReview';
end;//Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister

function Tkw_FormUserType_slqtLegislationReview.GetInteger: Integer;
 {-}
begin
 Result := slqtLegislationReview;
end;//Tkw_FormUserType_slqtLegislationReview.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtLegislationReview
 Tkw_FormUserType_slqtLegislationReview.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.