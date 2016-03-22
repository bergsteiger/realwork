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
;

type
 _PrimSaveLoadUserTypes_Parent_ = TPrimSaveLoadOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes.imp.pas}
 TPrimSaveLoadOptionsWithUserTypesForm = class(_PrimSaveLoadUserTypes_)
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
 , l3StringIDEx
 , l3MessageID
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadOptionsWithUserTypesForm);
 {* Регистрация PrimSaveLoadOptionsWithUserTypes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
