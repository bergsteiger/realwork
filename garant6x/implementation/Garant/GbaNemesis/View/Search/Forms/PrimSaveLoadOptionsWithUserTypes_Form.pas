unit PrimSaveLoadOptionsWithUserTypes_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadOptionsWithUserTypes_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadOptionsWithUserTypes
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
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  SearchLite_Strange_Controls,
  Search_Strange_Controls,
  PrimSaveLoadUserTypes_slqtAttribute_UserType,
  PrimSaveLoadUserTypes_slqtKW_UserType,
  PrimSaveLoadUserTypes_slqtOldKW_UserType,
  PrimSaveLoadUserTypes_slqtPublishSource_UserType,
  PrimSaveLoadUserTypes_slqtFilters_UserType,
  PrimSaveLoadUserTypes_slqtLegislationReview_UserType,
  PrimSaveLoadUserTypes_slqtPostingOrder_UserType,
  PrimSaveLoadUserTypes_slqtConsult_UserType,
  PrimSaveLoadUserTypes_slqtInpharmSearch_UserType,
  PrimSaveLoadOptions_Form
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _PrimSaveLoadUserTypes_Parent_ = TPrimSaveLoadOptionsForm;
 {$Include ..\Forms\PrimSaveLoadUserTypes.imp.pas}
 TPrimSaveLoadOptionsWithUserTypesForm = {form} class(_PrimSaveLoadUserTypes_)
 protected
  procedure InitEntities; override;
 end;//TPrimSaveLoadOptionsWithUserTypesForm

 TvcmContainerFormRef = TPrimSaveLoadOptionsWithUserTypesForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

{$Include ..\Forms\PrimSaveLoadUserTypes.imp.pas}

// start class TPrimSaveLoadOptionsWithUserTypesForm

procedure TPrimSaveLoadOptionsWithUserTypesForm.InitEntities;
begin
 inherited;
 {$If not defined(NoVCM)}
 AddUserTypeExclude(slqtPostingOrderName, en_Result, op_Cancel, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(slqtFiltersName, en_File, op_SaveToFolder, false);
 AddUserTypeExclude(slqtFiltersName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_GetOldQuery, false);
 AddUserTypeExclude(slqtPostingOrderName, en_File, op_SaveToFolder, false);
 AddUserTypeExclude(slqtPostingOrderName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_GetOldQuery, false);
 AddUserTypeExclude(slqtConsultName, en_File, op_SaveToFolder, false);
 AddUserTypeExclude(slqtConsultName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(slqtConsultName, en_Query, op_GetOldQuery, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_Filterable, op_Add, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_Filterable, op_Delete, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Filterable, op_Add, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Filterable, op_Delete, false);
 AddUserTypeExclude(slqtOldKWName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtFiltersName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtConsultName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_SetList, false);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_GetList, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_Query, op_SetList, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_Query, op_GetList, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_SetList, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_GetList, false);
 AddUserTypeExclude(slqtConsultName, en_Query, op_SetList, false);
 AddUserTypeExclude(slqtConsultName, en_Query, op_GetList, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Loadable, op_Load, false);
 AddUserTypeExclude(slqtAttributeName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtAttributeName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtAttributeName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtKWName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtKWName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtKWName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtPublishSourceName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtPublishSourceName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtPublishSourceName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtFiltersName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtFiltersName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtFiltersName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtPostingOrderName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtPostingOrderName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtPostingOrderName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtConsultName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtConsultName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtConsultName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtInpharmSearchName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtInpharmSearchName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtInpharmSearchName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtKWName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtOldKWName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtLegislationReviewName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtConsultName, en_Query, op_SearchType, false);
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin)}
 {$Include ..\Forms\PrimSaveLoadUserTypes.imp.pas}
{$IfEnd} //not Admin
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimSaveLoadOptionsWithUserTypes
 TtfwClassRef.Register(TPrimSaveLoadOptionsWithUserTypesForm);
{$IfEnd} //not Admin AND not NoScripts

end.