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
 , l3StringIDEx
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // ExcludeAll

 // ExcludeCancelForPostingOrder

 // ExcludeFile

 // ExcludeFilterableAddDelete

 // ExcludeFiltersListOpen

 // ExcludeGetAndSetList

 // ExcludeLoadable

 // ExcludeLogicOperations

 // ExcludeSearchType

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadOptionsWithUserTypesForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
end;//TPrimSaveLoadOptionsWithUserTypesForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadOptionsWithUserTypesForm);
 {* Регистрация PrimSaveLoadOptionsWithUserTypes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
