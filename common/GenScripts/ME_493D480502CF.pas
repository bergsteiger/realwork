unit dsDocumentWithFlash;
 {* БОФ документа-схемы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentWithFlash.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , WorkWithDocumentInterfaces
 , evdInterfaces
 , DynamicDocListUnit
 , l3TreeInterfaces
 , nevTools
 , l3IID
 , l3Types
 , DocumentInterfaces
 , WorkWithListInterfaces
 , nsDocumentLikeStateHolder
 , afwInterfaces
 , l3Interfaces
 , bsTypes
 , FoldersDomainInterfaces
 , UnderControlUnit
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , UnderControlInterfaces
 , PrimPrimListInterfaces
;

type
 _FormDataSourceType_ = IdsDocumentWithFlash;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocument.imp.pas}
 TdsDocumentWithFlash = class(_dsDocument_, IdsDocumentWithFlash)
  {* БОФ документа-схемы }
  private
   : IDocument;
  protected
   {$If NOT Defined(NoVCM)}
   function MakeDisplayName: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsDocumentWithFlash
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocumentTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3String
 , l3Base
 , deListSet
 , evdHyperlinkInfo
 , afwNavigation
 , bsUtils
 , BaseTypesUnit
 , bsConvert
 , l3Utils
 , deDocInfo
 , nsTypes
 , nsDocInfoHAFMacroReplacer
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsFolderFilterInfo
 , l3InterfacesMisc
 , afwFacade
 , IOUnit
 , deSearchInfo
 , DynamicTreeUnit
 , nsINodeWrap
;

{$If not Declared(_InitDataType_)}type _InitDataType_ = IdeDocInfo;{$IfEnd}

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsDocumentWithFlash;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocument.imp.pas}

{$If NOT Defined(NoVCM)}
function TdsDocumentWithFlash.MakeDisplayName: IvcmCString;
//#UC START# *491476B001D3_493D480502CF_var*
//#UC END# *491476B001D3_493D480502CF_var*
begin
//#UC START# *491476B001D3_493D480502CF_impl*
 Result := nsGetDocumentShortName(ucp_IDocument);
//#UC END# *491476B001D3_493D480502CF_impl*
end;//TdsDocumentWithFlash.MakeDisplayName
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
