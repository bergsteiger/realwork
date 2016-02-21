unit dsSynchroView;
 {* Бизнес объект формы "fcSynchroView" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsSynchroView.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithListInterfaces
 , DocumentAndListInterfaces
 , bsTypes
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _UseCaseControllerType_ = IsdsList;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 TdsSynchroView = {final} class(_vcmFormDataSourcePrimWithFlexUseCaseControllerType_, IdsSynchroView)
  {* Бизнес объект формы "fcSynchroView" }
  protected
   function pm_GetIsAnnotationActive: Boolean;
   function pm_GetIsRelatedDocActive: Boolean;
   function pm_GetHasAnnotation: Boolean;
   function pm_GetIsSimilarDocumentsActive: Boolean;
   procedure OpenDocument;
    {* Открыть документ. }
   function pm_GetHasDocument: Boolean;
   function pm_GetIsDocumentActive: Boolean;
   function pm_GetHasAttributes: Boolean;
   function pm_GetIsAttributesActive: Boolean;
   procedure OpenAttributes;
    {* Открыть атрибуты. }
   function pm_GetUserCRListInfo(aId: TnsUserCRListId): IbsUserCRListInfo;
   procedure OpenUserCR2;
    {* Открывает ViewArea "БОФ пользовательский СКР2" }
   procedure OpenRelatedDoc;
    {* Открывает ViewArea "справка к документу" }
   function pm_GetHasUserCR1: Boolean;
   function pm_GetHasRelatedDoc: Boolean;
   function pm_GetIsUserCR2Active: Boolean;
   function pm_GetIsUserCR1Active: Boolean;
   function pm_GetHasSimilarDocuments: Boolean;
   procedure OpenUserCR1;
    {* Открывает ViewArea "БОФ пользовательский СКР1" }
   procedure OpenAnnotation;
    {* Открывает ViewArea "аннотация к документу" }
   function pm_GetHasUserCR2: Boolean;
   procedure OpenSimilarDocuments;
    {* Открывает ViewArea "БОФ похожие документы" }
 end;//TdsSynchroView
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3InterfacesMisc
 , l3Base
;

type _Instance_R_ = TdsSynchroView;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}

function TdsSynchroView.pm_GetIsAnnotationActive: Boolean;
//#UC START# *29FB34EB69B7_4922B4F803ACget_var*
//#UC END# *29FB34EB69B7_4922B4F803ACget_var*
begin
//#UC START# *29FB34EB69B7_4922B4F803ACget_impl*
 Result := UseCaseController.IsAnnotationActive;
//#UC END# *29FB34EB69B7_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetIsAnnotationActive

function TdsSynchroView.pm_GetIsRelatedDocActive: Boolean;
//#UC START# *373C115F3AFE_4922B4F803ACget_var*
//#UC END# *373C115F3AFE_4922B4F803ACget_var*
begin
//#UC START# *373C115F3AFE_4922B4F803ACget_impl*
 Result := UseCaseController.IsRelatedDocActive;
//#UC END# *373C115F3AFE_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetIsRelatedDocActive

function TdsSynchroView.pm_GetHasAnnotation: Boolean;
//#UC START# *3C61AE5A0421_4922B4F803ACget_var*
//#UC END# *3C61AE5A0421_4922B4F803ACget_var*
begin
//#UC START# *3C61AE5A0421_4922B4F803ACget_impl*
 Result := UseCaseController.HasAnnotation;
//#UC END# *3C61AE5A0421_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetHasAnnotation

function TdsSynchroView.pm_GetIsSimilarDocumentsActive: Boolean;
//#UC START# *42EFA4B2ADEC_4922B4F803ACget_var*
//#UC END# *42EFA4B2ADEC_4922B4F803ACget_var*
begin
//#UC START# *42EFA4B2ADEC_4922B4F803ACget_impl*
 Result := UseCaseController.IsSimilarDocumentsActive;
//#UC END# *42EFA4B2ADEC_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetIsSimilarDocumentsActive

procedure TdsSynchroView.OpenDocument;
 {* Открыть документ. }
//#UC START# *47ECD5280007_4922B4F803AC_var*
//#UC END# *47ECD5280007_4922B4F803AC_var*
begin
//#UC START# *47ECD5280007_4922B4F803AC_impl*
 UseCaseController.OpenDocument;
//#UC END# *47ECD5280007_4922B4F803AC_impl*
end;//TdsSynchroView.OpenDocument

function TdsSynchroView.pm_GetHasDocument: Boolean;
//#UC START# *47ECD54803CB_4922B4F803ACget_var*
//#UC END# *47ECD54803CB_4922B4F803ACget_var*
begin
//#UC START# *47ECD54803CB_4922B4F803ACget_impl*
 Result := UseCaseController.HasDocument;
//#UC END# *47ECD54803CB_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetHasDocument

function TdsSynchroView.pm_GetIsDocumentActive: Boolean;
//#UC START# *47ECD5490012_4922B4F803ACget_var*
//#UC END# *47ECD5490012_4922B4F803ACget_var*
begin
//#UC START# *47ECD5490012_4922B4F803ACget_impl*
 Result := UseCaseController.IsDocumentActive;
//#UC END# *47ECD5490012_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetIsDocumentActive

function TdsSynchroView.pm_GetHasAttributes: Boolean;
//#UC START# *47F08A0E035F_4922B4F803ACget_var*
//#UC END# *47F08A0E035F_4922B4F803ACget_var*
begin
//#UC START# *47F08A0E035F_4922B4F803ACget_impl*
 Result := UseCaseController.HasAttributes;
//#UC END# *47F08A0E035F_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetHasAttributes

function TdsSynchroView.pm_GetIsAttributesActive: Boolean;
//#UC START# *47F08A2A03E6_4922B4F803ACget_var*
//#UC END# *47F08A2A03E6_4922B4F803ACget_var*
begin
//#UC START# *47F08A2A03E6_4922B4F803ACget_impl*
 Result := UseCaseController.IsAttributesActive;
//#UC END# *47F08A2A03E6_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetIsAttributesActive

procedure TdsSynchroView.OpenAttributes;
 {* Открыть атрибуты. }
//#UC START# *47F08A7F0108_4922B4F803AC_var*
//#UC END# *47F08A7F0108_4922B4F803AC_var*
begin
//#UC START# *47F08A7F0108_4922B4F803AC_impl*
 UseCaseController.OpenAttributes;
//#UC END# *47F08A7F0108_4922B4F803AC_impl*
end;//TdsSynchroView.OpenAttributes

function TdsSynchroView.pm_GetUserCRListInfo(aId: TnsUserCRListId): IbsUserCRListInfo;
//#UC START# *4922AD950294_4922B4F803ACget_var*
//#UC END# *4922AD950294_4922B4F803ACget_var*
begin
//#UC START# *4922AD950294_4922B4F803ACget_impl*
 Result := UseCaseController.UserCRListInfo[aId];
//#UC END# *4922AD950294_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetUserCRListInfo

procedure TdsSynchroView.OpenUserCR2;
 {* Открывает ViewArea "БОФ пользовательский СКР2" }
//#UC START# *49BAD288AA03_4922B4F803AC_var*
//#UC END# *49BAD288AA03_4922B4F803AC_var*
begin
//#UC START# *49BAD288AA03_4922B4F803AC_impl*
 UseCaseController.OpenUserCR2;
//#UC END# *49BAD288AA03_4922B4F803AC_impl*
end;//TdsSynchroView.OpenUserCR2

procedure TdsSynchroView.OpenRelatedDoc;
 {* Открывает ViewArea "справка к документу" }
//#UC START# *75D79769A7B5_4922B4F803AC_var*
//#UC END# *75D79769A7B5_4922B4F803AC_var*
begin
//#UC START# *75D79769A7B5_4922B4F803AC_impl*
 UseCaseController.OpenRelatedDoc;
//#UC END# *75D79769A7B5_4922B4F803AC_impl*
end;//TdsSynchroView.OpenRelatedDoc

function TdsSynchroView.pm_GetHasUserCR1: Boolean;
//#UC START# *9CD4919A8B42_4922B4F803ACget_var*
//#UC END# *9CD4919A8B42_4922B4F803ACget_var*
begin
//#UC START# *9CD4919A8B42_4922B4F803ACget_impl*
 Result := UseCaseController.HasUserCRList1;
//#UC END# *9CD4919A8B42_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetHasUserCR1

function TdsSynchroView.pm_GetHasRelatedDoc: Boolean;
//#UC START# *AC36781982C2_4922B4F803ACget_var*
//#UC END# *AC36781982C2_4922B4F803ACget_var*
begin
//#UC START# *AC36781982C2_4922B4F803ACget_impl*
 Result := UseCaseController.HasRelatedDoc;
//#UC END# *AC36781982C2_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetHasRelatedDoc

function TdsSynchroView.pm_GetIsUserCR2Active: Boolean;
//#UC START# *ACF8AED74764_4922B4F803ACget_var*
//#UC END# *ACF8AED74764_4922B4F803ACget_var*
begin
//#UC START# *ACF8AED74764_4922B4F803ACget_impl*
 Result := UseCaseController.IsUserCR2Active;
//#UC END# *ACF8AED74764_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetIsUserCR2Active

function TdsSynchroView.pm_GetIsUserCR1Active: Boolean;
//#UC START# *AF7C3B1F66A1_4922B4F803ACget_var*
//#UC END# *AF7C3B1F66A1_4922B4F803ACget_var*
begin
//#UC START# *AF7C3B1F66A1_4922B4F803ACget_impl*
 Result := UseCaseController.IsUserCR1Active;
//#UC END# *AF7C3B1F66A1_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetIsUserCR1Active

function TdsSynchroView.pm_GetHasSimilarDocuments: Boolean;
//#UC START# *B3FF3DCB306E_4922B4F803ACget_var*
//#UC END# *B3FF3DCB306E_4922B4F803ACget_var*
begin
//#UC START# *B3FF3DCB306E_4922B4F803ACget_impl*
 Result := UseCaseController.HasSimilarDocuments;
//#UC END# *B3FF3DCB306E_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetHasSimilarDocuments

procedure TdsSynchroView.OpenUserCR1;
 {* Открывает ViewArea "БОФ пользовательский СКР1" }
//#UC START# *B92D4E5C4AF7_4922B4F803AC_var*
//#UC END# *B92D4E5C4AF7_4922B4F803AC_var*
begin
//#UC START# *B92D4E5C4AF7_4922B4F803AC_impl*
 UseCaseController.OpenUserCR1;
//#UC END# *B92D4E5C4AF7_4922B4F803AC_impl*
end;//TdsSynchroView.OpenUserCR1

procedure TdsSynchroView.OpenAnnotation;
 {* Открывает ViewArea "аннотация к документу" }
//#UC START# *C90DF8D59396_4922B4F803AC_var*
//#UC END# *C90DF8D59396_4922B4F803AC_var*
begin
//#UC START# *C90DF8D59396_4922B4F803AC_impl*
 UseCaseController.OpenAnnotation;
//#UC END# *C90DF8D59396_4922B4F803AC_impl*
end;//TdsSynchroView.OpenAnnotation

function TdsSynchroView.pm_GetHasUserCR2: Boolean;
//#UC START# *DF69147C5AF9_4922B4F803ACget_var*
//#UC END# *DF69147C5AF9_4922B4F803ACget_var*
begin
//#UC START# *DF69147C5AF9_4922B4F803ACget_impl*
 Result := UseCaseController.HasUserCRList2;
//#UC END# *DF69147C5AF9_4922B4F803ACget_impl*
end;//TdsSynchroView.pm_GetHasUserCR2

procedure TdsSynchroView.OpenSimilarDocuments;
 {* Открывает ViewArea "БОФ похожие документы" }
//#UC START# *EB3722A70D75_4922B4F803AC_var*
//#UC END# *EB3722A70D75_4922B4F803AC_var*
begin
//#UC START# *EB3722A70D75_4922B4F803AC_impl*
 UseCaseController.OpenSimilarDocuments;
//#UC END# *EB3722A70D75_4922B4F803AC_impl*
end;//TdsSynchroView.OpenSimilarDocuments
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
