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
 , l3Interfaces
 , bsTypesNew
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
 Tfs_AbstractDocument = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
  public
   function AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function WarningChildWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Warning }
   function RelatedChildDftRelatedDocNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Related }
   function AnnotationChildDftAnnotationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Annotation }
   function TranslationChildDftTranslationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Translation }
   function TranslationWarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TranslationWarnJuror }
   function ContentsNavigatorUtContentsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Contents }
   function RespondentChildLftRespondentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Respondent }
   function CorrespondentChildLftCorrespondentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Correspondent }
   function RedactionsNavigatorUtRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Redactions }
   function SimilarDocumentsChildLftSimilarDocumentsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SimilarDocuments }
   function UserCR1ChildLftUserCR1NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR1 }
   function RemListModifiedUserCR1ChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListModifiedUserCR1 }
   function UserCR2ChildLftUserCR2NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR2 }
   function RemListModifiedUserCR2ChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListModifiedUserCR2 }
   function CToPartChildLftCToPartNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для CToPart }
   function RToPartChildLftRToPartNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для RToPart }
   function ChronologyChildDftChronologyNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Chronology }
   function SimilarDocumentsToFragmentChildLftSimilarDocumentsToFragmentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
 , SysUtils
 //#UC START# *5009367A01C3impl_uses*
 //#UC END# *5009367A01C3impl_uses*
;

{$If NOT Defined(NoVCM)}
function Tfs_AbstractDocument.AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
var
 l_UseCase : IsdsBaseDocumentWithAttributes;
begin
 if Supports(aDataSource, IsdsBaseDocumentWithAttributes, l_UseCase) then
  try
   aNew := l_UseCase.dsAttributes;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.AttributesChildFDocAttributeNeedMakeForm

function Tfs_AbstractDocument.WarningChildWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Warning }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.WarningChildWarningNeedMakeForm

function Tfs_AbstractDocument.RelatedChildDftRelatedDocNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Related }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsRelatedDoc;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.RelatedChildDftRelatedDocNeedMakeForm

function Tfs_AbstractDocument.AnnotationChildDftAnnotationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Annotation }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsAnnotation;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.AnnotationChildDftAnnotationNeedMakeForm

function Tfs_AbstractDocument.TranslationChildDftTranslationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Translation }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsTranslation;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.TranslationChildDftTranslationNeedMakeForm

function Tfs_AbstractDocument.TranslationWarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TranslationWarnJuror }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsTranslationWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.TranslationWarnJurorChildWarnJurorNeedMakeForm

function Tfs_AbstractDocument.ContentsNavigatorUtContentsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Contents }
var
 l_UseCase : IucpDocumentWithContents;
begin
 if Supports(aDataSource, IucpDocumentWithContents, l_UseCase) then
  try
   aNew := l_UseCase.dsContents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.ContentsNavigatorUtContentsNeedMakeForm

function Tfs_AbstractDocument.RespondentChildLftRespondentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Respondent }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsRespondents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.RespondentChildLftRespondentNeedMakeForm

function Tfs_AbstractDocument.CorrespondentChildLftCorrespondentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Correspondent }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsCorrespondents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.CorrespondentChildLftCorrespondentNeedMakeForm

function Tfs_AbstractDocument.RedactionsNavigatorUtRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Redactions }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsEditions;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.RedactionsNavigatorUtRedactionNeedMakeForm

function Tfs_AbstractDocument.SimilarDocumentsChildLftSimilarDocumentsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SimilarDocuments }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsSimilarDocuments;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.SimilarDocumentsChildLftSimilarDocumentsNeedMakeForm

function Tfs_AbstractDocument.UserCR1ChildLftUserCR1NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserCR1 }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsUserCR1;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.UserCR1ChildLftUserCR1NeedMakeForm

function Tfs_AbstractDocument.RemListModifiedUserCR1ChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModifiedUserCR1 }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsCRBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.RemListModifiedUserCR1ChildRemListModifiedNeedMakeForm

function Tfs_AbstractDocument.UserCR2ChildLftUserCR2NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserCR2 }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsUserCR2;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.UserCR2ChildLftUserCR2NeedMakeForm

function Tfs_AbstractDocument.RemListModifiedUserCR2ChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModifiedUserCR2 }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsCRBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.RemListModifiedUserCR2ChildRemListModifiedNeedMakeForm

function Tfs_AbstractDocument.CToPartChildLftCToPartNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для CToPart }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
  //#UC START# *4FF66DF301FBNeedMake_impl*
   aNew := l_UseCase.dsIncomingLinksToPart;
  //#UC END# *4FF66DF301FBNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.CToPartChildLftCToPartNeedMakeForm

function Tfs_AbstractDocument.RToPartChildLftRToPartNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для RToPart }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsOutgoingLinksFromPart;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.RToPartChildLftRToPartNeedMakeForm

function Tfs_AbstractDocument.ChronologyChildDftChronologyNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Chronology }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsChronology;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.ChronologyChildDftChronologyNeedMakeForm

function Tfs_AbstractDocument.SimilarDocumentsToFragmentChildLftSimilarDocumentsToFragmentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SimilarDocumentsToFragment }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsSimilarDocumentsToFragment;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AbstractDocument.SimilarDocumentsToFragmentChildLftSimilarDocumentsToFragmentNeedMakeForm

procedure Tfs_AbstractDocument.InitFields;
begin
 inherited;
 with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
 begin
  UserType := fDocAttribute;
  OnNeedMakeForm := AttributesChildFDocAttributeNeedMakeForm;
 end;
 with AddZone('Warning', vcm_ztChild, fm_WarningForm) do
 begin
  UserType := Warning;
  ActivateIfUpdate := wafAlways;
  OnNeedMakeForm := WarningChildWarningNeedMakeForm;
 end;
 with AddZone('Related', vcm_ztChild, fm_TextForm) do
 begin
  UserType := dftRelatedDoc;
  OnNeedMakeForm := RelatedChildDftRelatedDocNeedMakeForm;
 end;
 with AddZone('Annotation', vcm_ztChild, fm_TextForm) do
 begin
  UserType := dftAnnotation;
  OnNeedMakeForm := AnnotationChildDftAnnotationNeedMakeForm;
 end;
 with AddZone('Translation', vcm_ztChild, fm_TextForm) do
 begin
  UserType := dftTranslation;
 with AddZone('TranslationWarnJuror', vcm_ztChild, fm_Translation_WarningBaloonForm) do
 begin
  UserType := WarnJuror;
  OnNeedMakeForm := TranslationWarnJurorChildWarnJurorNeedMakeForm;
 end;
  OnNeedMakeForm := TranslationChildDftTranslationNeedMakeForm;
 end;
 with AddZone('Contents', vcm_ztNavigator, fm_ContentsForm) do
 begin
  UserType := utContents;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := ContentsNavigatorUtContentsNeedMakeForm;
 end;
 with AddZone('Respondent', vcm_ztChild, fm_efList) do
 begin
  UserType := lftRespondent;
  OnNeedMakeForm := RespondentChildLftRespondentNeedMakeForm;
 end;
 with AddZone('Correspondent', vcm_ztChild, fm_efList) do
 begin
  UserType := lftCorrespondent;
  OnNeedMakeForm := CorrespondentChildLftCorrespondentNeedMakeForm;
 end;
 with AddZone('Redactions', vcm_ztNavigator, fm_RedactionsForm) do
 begin
  UserType := utRedaction;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := RedactionsNavigatorUtRedactionNeedMakeForm;
 end;
 with AddZone('SimilarDocuments', vcm_ztChild, fm_efList) do
 begin
  UserType := lftSimilarDocuments;
  OnNeedMakeForm := SimilarDocumentsChildLftSimilarDocumentsNeedMakeForm;
 end;
 with AddZone('UserCR1', vcm_ztChild, fm_efList) do
 begin
  UserType := lftUserCR1;
 with AddZone('remListModifiedUserCR1', vcm_ztChild, fm_UserCR1_WarningBaloonForm) do
 begin
  UserType := remListModified;
  OnNeedMakeForm := RemListModifiedUserCR1ChildRemListModifiedNeedMakeForm;
 end;
  OnNeedMakeForm := UserCR1ChildLftUserCR1NeedMakeForm;
 end;
 with AddZone('UserCR2', vcm_ztChild, fm_efList) do
 begin
  UserType := lftUserCR2;
 with AddZone('remListModifiedUserCR2', vcm_ztChild, fm_UserCR2_WarningBaloonForm) do
 begin
  UserType := remListModified;
  OnNeedMakeForm := RemListModifiedUserCR2ChildRemListModifiedNeedMakeForm;
 end;
  OnNeedMakeForm := UserCR2ChildLftUserCR2NeedMakeForm;
 end;
 with AddZone('CToPart', vcm_ztChild, fm_efList) do
 begin
  UserType := lftCToPart;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := CToPartChildLftCToPartNeedMakeForm;
 end;
 with AddZone('RToPart', vcm_ztChild, fm_efList) do
 begin
  UserType := lftRToPart;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := RToPartChildLftRToPartNeedMakeForm;
 end;
 with AddZone('Chronology', vcm_ztChild, fm_TextForm) do
 begin
  UserType := dftChronology;
  OnNeedMakeForm := ChronologyChildDftChronologyNeedMakeForm;
 end;
 with AddZone('SimilarDocumentsToFragment', vcm_ztChild, fm_efList) do
 begin
  UserType := lftSimilarDocumentsToFragment;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := SimilarDocumentsToFragmentChildLftSimilarDocumentsToFragmentNeedMakeForm;
 end;
 OwnerForm := 0;
end;//Tfs_AbstractDocument.InitFields
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
