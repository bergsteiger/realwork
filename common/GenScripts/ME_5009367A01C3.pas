unit fsAbstractDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\fsAbstractDocument.pas"
// Стереотип: "VCMAbstractFormSetFactory"
// Элемент модели: "AbstractDocument" MUID: (5009367A01C3)
// Имя типа: "Tfs_AbstractDocument"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , AttributesUserTypes_fDocAttribute_UserType
 , Common_FormDefinitions_Controls
 , BaseDocumentWithAttributesInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , DocumentInterfaces
 , WarningUserTypes_Warning_UserType
 , WorkWithDocumentInterfaces
 , nsTypes
 , nevBase
 , DocumentUserTypes_dftRelatedDoc_UserType
 , DocInfoInterfaces
 , nevTools
 , bsTypes
 , evdInterfaces
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
 , DocumentUserTypes_dftAnnotation_UserType
 , DocumentUserTypes_dftTranslation_UserType
 , ContentsUserTypes_utContents_UserType
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , F1TagDataProviderInterface
 , nsTypesNew
 , ListUserTypes_lftRespondent_UserType
 , l3Tree_TLB
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , DynamicTreeUnit
 , PreviewInterfaces
 , PrimListInterfaces
 , FiltersUnit
 , ListUserTypes_lftCorrespondent_UserType
 , RedactionsUserTypes_utRedaction_UserType
 , ListUserTypes_lftSimilarDocuments_UserType
 , ListUserTypes_lftUserCR1_UserType
 , ListUserTypes_lftUserCR2_UserType
 , ListUserTypes_lftCToPart_UserType
 , ExternalObjectUnit
 , ListUserTypes_lftRToPart_UserType
 , DocumentUserTypes_dftChronology_UserType
 , ListUserTypes_lftSimilarDocumentsToFragment_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_remListModified_UserType
;

type
 // Attributes

 // Warning

 // Related

 // Annotation

 // TranslationWarnJuror

 // Translation

 // Contents

 // Respondent

 // Correspondent

 // Redactions

 // SimilarDocuments

 // remListModifiedUserCR1

 // UserCR1

 // remListModifiedUserCR2

 // UserCR2

 // CToPart

 // RToPart

 // Chronology

 // SimilarDocumentsToFragment

 Tfs_AbstractDocument = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
  public
   function Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function Warning_Child_Warning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Warning }
   function Related_Child_dftRelatedDoc_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Related }
   function Annotation_Child_dftAnnotation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Annotation }
   function Translation_Child_dftTranslation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Translation }
   function TranslationWarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TranslationWarnJuror }
   function Contents_Navigator_utContents_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Contents }
   function Respondent_Child_lftRespondent_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Respondent }
   function Correspondent_Child_lftCorrespondent_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Correspondent }
   function Redactions_Navigator_utRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Redactions }
   function SimilarDocuments_Child_lftSimilarDocuments_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SimilarDocuments }
   function UserCR1_Child_lftUserCR1_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR1 }
   function remListModifiedUserCR1_Child_remListModified_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListModifiedUserCR1 }
   function UserCR2_Child_lftUserCR2_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR2 }
   function remListModifiedUserCR2_Child_remListModified_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListModifiedUserCR2 }
   function CToPart_Child_lftCToPart_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для CToPart }
   function RToPart_Child_lftRToPart_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для RToPart }
   function Chronology_Child_dftChronology_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Chronology }
   function SimilarDocumentsToFragment_Child_lftSimilarDocumentsToFragment_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SimilarDocumentsToFragment }
 end;//Tfs_AbstractDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , bsUtils
;

{$If NOT Defined(NoVCM)}
function Tfs_AbstractDocument.Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *D4A6BAE758F9_5009367A01C3_var*
//#UC END# *D4A6BAE758F9_5009367A01C3_var*
begin
//#UC START# *D4A6BAE758F9_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *D4A6BAE758F9_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Attributes_Child_fDocAttribute_NeedMakeForm

function Tfs_AbstractDocument.Warning_Child_Warning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Warning }
//#UC START# *8CD5B9BE0897_5009367A01C3_var*
//#UC END# *8CD5B9BE0897_5009367A01C3_var*
begin
//#UC START# *8CD5B9BE0897_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CD5B9BE0897_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Warning_Child_Warning_NeedMakeForm

function Tfs_AbstractDocument.Related_Child_dftRelatedDoc_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Related }
//#UC START# *4C13947FBAA0_5009367A01C3_var*
//#UC END# *4C13947FBAA0_5009367A01C3_var*
begin
//#UC START# *4C13947FBAA0_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C13947FBAA0_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Related_Child_dftRelatedDoc_NeedMakeForm

function Tfs_AbstractDocument.Annotation_Child_dftAnnotation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Annotation }
//#UC START# *3194A0365B23_5009367A01C3_var*
//#UC END# *3194A0365B23_5009367A01C3_var*
begin
//#UC START# *3194A0365B23_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *3194A0365B23_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Annotation_Child_dftAnnotation_NeedMakeForm

function Tfs_AbstractDocument.Translation_Child_dftTranslation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Translation }
//#UC START# *F2180FA35764_5009367A01C3_var*
//#UC END# *F2180FA35764_5009367A01C3_var*
begin
//#UC START# *F2180FA35764_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *F2180FA35764_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Translation_Child_dftTranslation_NeedMakeForm

function Tfs_AbstractDocument.TranslationWarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TranslationWarnJuror }
//#UC START# *83D14E05DE8A_5009367A01C3_var*
//#UC END# *83D14E05DE8A_5009367A01C3_var*
begin
//#UC START# *83D14E05DE8A_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *83D14E05DE8A_5009367A01C3_impl*
end;//Tfs_AbstractDocument.TranslationWarnJuror_Child_WarnJuror_NeedMakeForm

function Tfs_AbstractDocument.Contents_Navigator_utContents_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Contents }
//#UC START# *50E17AE128E0_5009367A01C3_var*
//#UC END# *50E17AE128E0_5009367A01C3_var*
begin
//#UC START# *50E17AE128E0_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *50E17AE128E0_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Contents_Navigator_utContents_NeedMakeForm

function Tfs_AbstractDocument.Respondent_Child_lftRespondent_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Respondent }
//#UC START# *2D8624736BF4_5009367A01C3_var*
//#UC END# *2D8624736BF4_5009367A01C3_var*
begin
//#UC START# *2D8624736BF4_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *2D8624736BF4_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Respondent_Child_lftRespondent_NeedMakeForm

function Tfs_AbstractDocument.Correspondent_Child_lftCorrespondent_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Correspondent }
//#UC START# *82183C1EB242_5009367A01C3_var*
//#UC END# *82183C1EB242_5009367A01C3_var*
begin
//#UC START# *82183C1EB242_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *82183C1EB242_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Correspondent_Child_lftCorrespondent_NeedMakeForm

function Tfs_AbstractDocument.Redactions_Navigator_utRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Redactions }
//#UC START# *45BF0E881CD3_5009367A01C3_var*
//#UC END# *45BF0E881CD3_5009367A01C3_var*
begin
//#UC START# *45BF0E881CD3_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *45BF0E881CD3_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Redactions_Navigator_utRedaction_NeedMakeForm

function Tfs_AbstractDocument.SimilarDocuments_Child_lftSimilarDocuments_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SimilarDocuments }
//#UC START# *4BCABC351E44_5009367A01C3_var*
//#UC END# *4BCABC351E44_5009367A01C3_var*
begin
//#UC START# *4BCABC351E44_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BCABC351E44_5009367A01C3_impl*
end;//Tfs_AbstractDocument.SimilarDocuments_Child_lftSimilarDocuments_NeedMakeForm

function Tfs_AbstractDocument.UserCR1_Child_lftUserCR1_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserCR1 }
//#UC START# *DB705238EFDE_5009367A01C3_var*
//#UC END# *DB705238EFDE_5009367A01C3_var*
begin
//#UC START# *DB705238EFDE_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *DB705238EFDE_5009367A01C3_impl*
end;//Tfs_AbstractDocument.UserCR1_Child_lftUserCR1_NeedMakeForm

function Tfs_AbstractDocument.remListModifiedUserCR1_Child_remListModified_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModifiedUserCR1 }
//#UC START# *D2D46DE2205C_5009367A01C3_var*
//#UC END# *D2D46DE2205C_5009367A01C3_var*
begin
//#UC START# *D2D46DE2205C_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *D2D46DE2205C_5009367A01C3_impl*
end;//Tfs_AbstractDocument.remListModifiedUserCR1_Child_remListModified_NeedMakeForm

function Tfs_AbstractDocument.UserCR2_Child_lftUserCR2_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserCR2 }
//#UC START# *40569514E17D_5009367A01C3_var*
//#UC END# *40569514E17D_5009367A01C3_var*
begin
//#UC START# *40569514E17D_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *40569514E17D_5009367A01C3_impl*
end;//Tfs_AbstractDocument.UserCR2_Child_lftUserCR2_NeedMakeForm

function Tfs_AbstractDocument.remListModifiedUserCR2_Child_remListModified_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModifiedUserCR2 }
//#UC START# *0A8AF18FE5A2_5009367A01C3_var*
//#UC END# *0A8AF18FE5A2_5009367A01C3_var*
begin
//#UC START# *0A8AF18FE5A2_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *0A8AF18FE5A2_5009367A01C3_impl*
end;//Tfs_AbstractDocument.remListModifiedUserCR2_Child_remListModified_NeedMakeForm

function Tfs_AbstractDocument.CToPart_Child_lftCToPart_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для CToPart }
//#UC START# *6C795EA9FD5A_5009367A01C3_var*
//#UC END# *6C795EA9FD5A_5009367A01C3_var*
begin
//#UC START# *6C795EA9FD5A_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *6C795EA9FD5A_5009367A01C3_impl*
end;//Tfs_AbstractDocument.CToPart_Child_lftCToPart_NeedMakeForm

function Tfs_AbstractDocument.RToPart_Child_lftRToPart_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для RToPart }
//#UC START# *3F6C09EB9F34_5009367A01C3_var*
//#UC END# *3F6C09EB9F34_5009367A01C3_var*
begin
//#UC START# *3F6C09EB9F34_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *3F6C09EB9F34_5009367A01C3_impl*
end;//Tfs_AbstractDocument.RToPart_Child_lftRToPart_NeedMakeForm

function Tfs_AbstractDocument.Chronology_Child_dftChronology_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Chronology }
//#UC START# *E0961DFFC1EB_5009367A01C3_var*
//#UC END# *E0961DFFC1EB_5009367A01C3_var*
begin
//#UC START# *E0961DFFC1EB_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *E0961DFFC1EB_5009367A01C3_impl*
end;//Tfs_AbstractDocument.Chronology_Child_dftChronology_NeedMakeForm

function Tfs_AbstractDocument.SimilarDocumentsToFragment_Child_lftSimilarDocumentsToFragment_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SimilarDocumentsToFragment }
//#UC START# *C5AA9536AC66_5009367A01C3_var*
//#UC END# *C5AA9536AC66_5009367A01C3_var*
begin
//#UC START# *C5AA9536AC66_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *C5AA9536AC66_5009367A01C3_impl*
end;//Tfs_AbstractDocument.SimilarDocumentsToFragment_Child_lftSimilarDocumentsToFragment_NeedMakeForm

procedure Tfs_AbstractDocument.InitFields;
//#UC START# *47A042E100E2_5009367A01C3_var*
//#UC END# *47A042E100E2_5009367A01C3_var*
begin
//#UC START# *47A042E100E2_5009367A01C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_5009367A01C3_impl*
end;//Tfs_AbstractDocument.InitFields
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
