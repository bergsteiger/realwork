unit fsAbstractDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/fsAbstractDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMAbstractFormSetFactory::Class>> F1 Контроллер работы с документом и абстрактная фабрика документа::F1 Document Processing::View::AbstractDocumentFormSetFactory::AbstractDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftRelatedDoc_UserType,
  DocumentUserTypes_dftAnnotation_UserType,
  DocumentUserTypes_dftTranslation_UserType,
  ListUserTypes_lftRespondent_UserType,
  ListUserTypes_lftCorrespondent_UserType,
  ListUserTypes_lftCToPart_UserType,
  ListUserTypes_lftUserCR1_UserType,
  ListUserTypes_lftUserCR2_UserType,
  ListUserTypes_lftSimilarDocuments_UserType,
  AttributesUserTypes_fDocAttribute_UserType,
  RedactionsUserTypes_utRedaction_UserType,
  WarningUserTypes_Warning_UserType,
  ContentsUserTypes_utContents_UserType,
  Common_FormDefinitions_Controls,
  WorkWithDocumentInterfaces,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_remListModified_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  ListUserTypes_lftRToPart_UserType,
  DocumentUserTypes_dftChronology_UserType,
  ListUserTypes_lftSimilarDocumentsToFragment_UserType,
  l3InternalInterfaces,
  l3TreeInterfaces,
  DocumentInterfaces,
  nevBase,
  nsTypes,
  nevTools,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  evdInterfaces,
  DocumentAndListInterfaces,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3Interfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  F1TagDataProviderInterface,
  nsTypesNew,
  l3Tree_TLB,
  DynamicDocListUnit,
  PrimPrimListInterfaces,
  FiltersUnit,
  DynamicTreeUnit,
  PreviewInterfaces,
  PrimListInterfaces,
  ExternalObjectUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 Tfs_AbstractDocument = {abstract fsf} class(TvcmFormSetFactory)
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsUtils,
  SysUtils {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class Tfs_AbstractDocument

function Tfs_AbstractDocument.AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
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
 {-}
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

{$IfEnd} //not Admin AND not Monitorings

end.