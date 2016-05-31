unit PrimSaveLoadOptionsWithUserTypes_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsWithUserTypes_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimSaveLoadOptionsWithUserTypes" MUID: (4F5D9FFA031B)
// Имя типа: "TPrimSaveLoadOptionsWithUserTypesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _PrimSaveLoadUserTypes_Parent_ = TPrimSaveLoadOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes.imp.pas}
 TPrimSaveLoadOptionsWithUserTypesForm = class(_PrimSaveLoadUserTypes_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimSaveLoadOptionsWithUserTypesForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , PrimPrimListInterfaces
 , bsTypes
 , eeInterfaces
 , nsTypes
 , FiltersUnit
 , PrimSaveLoadUserTypes_slqtPostingOrder_UserType
 , PrimSaveLoadUserTypes_slqtFilters_UserType
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 , PrimSaveLoadUserTypes_slqtLegislationReview_UserType
 , PrimSaveLoadUserTypes_slqtOldKW_UserType
 , PrimSaveLoadUserTypes_slqtAttribute_UserType
 , PrimSaveLoadUserTypes_slqtKW_UserType
 , PrimSaveLoadUserTypes_slqtPublishSource_UserType
 , PrimSaveLoadUserTypes_slqtInpharmSearch_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4F5D9FFA031Bimpl_uses*
 //#UC END# *4F5D9FFA031Bimpl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadOptionsWithUserTypesForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 AddUserTypeExclude(slqtPostingOrderName, en_Result, op_Cancel, False);
 AddUserTypeExclude(slqtFiltersName, en_File, op_SaveToFolder, False);
 AddUserTypeExclude(slqtFiltersName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_GetOldQuery, False);
 AddUserTypeExclude(slqtPostingOrderName, en_File, op_SaveToFolder, False);
 AddUserTypeExclude(slqtPostingOrderName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_GetOldQuery, False);
 AddUserTypeExclude(slqtConsultName, en_File, op_SaveToFolder, False);
 AddUserTypeExclude(slqtConsultName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(slqtConsultName, en_Query, op_GetOldQuery, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_Filterable, op_Add, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_Filterable, op_Delete, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Filterable, op_Add, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Filterable, op_Delete, False);
 AddUserTypeExclude(slqtOldKWName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtFiltersName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtConsultName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_SetList, False);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_GetList, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_Query, op_SetList, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_Query, op_GetList, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_SetList, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_GetList, False);
 AddUserTypeExclude(slqtConsultName, en_Query, op_SetList, False);
 AddUserTypeExclude(slqtConsultName, en_Query, op_GetList, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Loadable, op_Load, False);
 AddUserTypeExclude(slqtAttributeName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtAttributeName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtAttributeName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtKWName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtKWName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtKWName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtPublishSourceName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtPublishSourceName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtPublishSourceName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtFiltersName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtFiltersName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtFiltersName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtPostingOrderName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtPostingOrderName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtPostingOrderName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtConsultName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtConsultName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtConsultName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtInpharmSearchName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtInpharmSearchName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtInpharmSearchName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtKWName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtOldKWName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtFiltersName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtLegislationReviewName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtPostingOrderName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtConsultName, en_Query, op_SearchType, False);
end;//TPrimSaveLoadOptionsWithUserTypesForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadOptionsWithUserTypesForm);
 {* Регистрация PrimSaveLoadOptionsWithUserTypes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
