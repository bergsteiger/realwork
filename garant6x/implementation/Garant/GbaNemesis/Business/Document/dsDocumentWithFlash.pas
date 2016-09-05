unit dsDocumentWithFlash;
 {* БОФ документа-схемы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentWithFlash.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsDocumentWithFlash" MUID: (493D480502CF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , WorkWithDocumentInterfaces
 , evdInterfaces
 , l3IID
 , DynamicDocListUnit
 , l3TreeInterfaces
 , nevTools
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
   ucp_IDocument: IDocument;
  protected
   {$If NOT Defined(NoVCM)}
   function MakeDisplayName: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
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
 , Common_F1CommonServices_Contracts
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
 //#UC START# *493D480502CFimpl_uses*
 //#UC END# *493D480502CFimpl_uses*
;

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

{$If NOT Defined(NoVCM)}
procedure TdsDocumentWithFlash.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 ucp_IDocument := aDS As IDocument;
end;//TdsDocumentWithFlash.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsDocumentWithFlash.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 ucp_IDocument := nil;
end;//TdsDocumentWithFlash.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
