unit NOT_FINISHED_fsList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\NOT_FINISHED_fsList.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "List" MUID: (4AA4D6C7036F)
// Имя типа: "Tfs_List"

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
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSet
 {$IfEnd} // NOT Defined(NoVCM)
 , ListUserTypes_lftNone_UserType
 , Common_FormDefinitions_Controls
 , WorkWithListInterfaces
 , bsTypes
 , l3Interfaces
 , l3Tree_TLB
 , afwInterfaces
 , DynamicDocListUnit
 , l3TreeInterfaces
 , PrimPrimListInterfaces
 , DynamicTreeUnit
 , DocumentUnit
 , PreviewInterfaces
 , l3InternalInterfaces
 , PrimListInterfaces
 , FiltersUnit
 , DocumentInterfaces
 , nsTypesNew
 , nsTypes
 , ListInfoUserTypes_liListInfo_UserType
 , FiltersUserTypes_utFilters_UserType
 , SimpleListInterfaces
 , SynchroViewUserTypes_svSynchroView_UserType
 , nevTools
 , evdInterfaces
 , DocumentAndListInterfaces
 , FoldersDomainInterfaces
 , bsTypesNew
 , ListAnalizeUserTypes_Analize_UserType
 , BaloonWarningUserTypes_remListModified_UserType
 , nevBase
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , DocumentUserTypes_dftDocSynchroView_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 , BaseDocumentWithAttributesInterfaces
 , DocumentUserTypes_dftRelatedSynchroView_UserType
 , DocInfoInterfaces
 , DocumentUserTypes_dftAnnotationSynchroView_UserType
 , ListUserTypes_lftSimilarDocumentsSynchroView_UserType
 , ListUserTypes_lftUserCRList1_SynchorForm_UserType
 , ListUserTypes_lftUserCRList2_SynchorForm_UserType
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType
 , ListUserTypes_lftRespondentsSynchroForm_UserType
 , DocumentWithFlashUserTypes_dwftSynchro_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
;

type
 Tfs_List = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetFormSetImplementation: RvcmFormSet; override;
    {* Возвращает класс реализации сборки }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitForms(const aParams: IvcmFormSetRefreshParams); override;
    {* Вызывается при создании сборки перед Refresh для инициализации нужных флажков на сборке. }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function ListParentLftNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function RemListModifiedChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListModified }
   function RemListFilteredChildRemListFilteredNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListFiltered }
   function RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
   function ListInfoChildLiListInfoNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для ListInfo }
   function FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Filters }
   function SynchroViewChildSvSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SynchroView }
   function TextChildDftDocSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnJuror }
   function WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnPreActive }
   function WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnIsAbolished }
   function WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnOnControl }
   function WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnInactualDocument }
   function WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnRedaction }
   function AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function RelatedChildDftRelatedSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Related }
   function AnnotationChildDftAnnotationSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Annotation }
   function SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Similar }
   function UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR1 }
   function UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR2 }
   function CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Correspondents }
   function RespondentsChildLftRespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Respondents }
   function DocumentWithFlashChildDwftSynchroNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для DocumentWithFlash }
   function ListAnalizeChildAnalizeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для ListAnalize }
   class function Instance: Tfs_List;
    {* Метод получения экземпляра синглетона Tfs_List }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_List
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , fstList
 , SysUtils
 , l3Base
 //#UC START# *4AA4D6C7036Fimpl_uses*
 //#UC END# *4AA4D6C7036Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_List: Tfs_List = nil;
 {* Экземпляр синглетона Tfs_List }

const
 {* Локализуемые строки List }
 str_fsListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsListCaption'; rValue : 'Список');
  {* Заголовок фабрики сборки форм "List$FSF" }

procedure Tfs_ListFree;
 {* Метод освобождения экземпляра синглетона Tfs_List }
begin
 l3Free(g_Tfs_List);
end;//Tfs_ListFree

function Tfs_List.ListParentLftNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsList;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.ListParentLftNoneNeedMakeForm

function Tfs_List.RemListModifiedChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModified }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RemListModifiedChildRemListModifiedNeedMakeForm

function Tfs_List.RemListFilteredChildRemListFilteredNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListFiltered }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RemListFilteredChildRemListFilteredNeedMakeForm

function Tfs_List.RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm

function Tfs_List.ListInfoChildLiListInfoNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для ListInfo }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsListInfo;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.ListInfoChildLiListInfoNeedMakeForm

function Tfs_List.FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Filters }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsFilters;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.FiltersNavigatorUtFiltersNeedMakeForm

function Tfs_List.SynchroViewChildSvSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SynchroView }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsSynchroView;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.SynchroViewChildSvSynchroViewNeedMakeForm

function Tfs_List.TextChildDftDocSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsDocument;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.TextChildDftDocSynchroViewNeedMakeForm

function Tfs_List.WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnJuror }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnJurorChildWarnJurorNeedMakeForm

function Tfs_List.WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnPreActive }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnPreActiveChildWarnPreActiveNeedMakeForm

function Tfs_List.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnIsAbolished }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm

function Tfs_List.WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnOnControl }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnOnControlChildWarnOnControlNeedMakeForm

function Tfs_List.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnInactualDocument }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm

function Tfs_List.WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnRedaction }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnRedactionChildWarnRedactionNeedMakeForm

function Tfs_List.AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_List.AttributesChildFAttributeSynchroViewNeedMakeForm

function Tfs_List.RelatedChildDftRelatedSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_List.RelatedChildDftRelatedSynchroViewNeedMakeForm

function Tfs_List.AnnotationChildDftAnnotationSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_List.AnnotationChildDftAnnotationSynchroViewNeedMakeForm

function Tfs_List.SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Similar }
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
end;//Tfs_List.SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm

function Tfs_List.UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_List.UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm

function Tfs_List.UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_List.UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm

function Tfs_List.CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Correspondents }
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
end;//Tfs_List.CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm

function Tfs_List.RespondentsChildLftRespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Respondents }
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
end;//Tfs_List.RespondentsChildLftRespondentsSynchroFormNeedMakeForm

function Tfs_List.DocumentWithFlashChildDwftSynchroNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DocumentWithFlash }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsDocumentWithFlash;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.DocumentWithFlashChildDwftSynchroNeedMakeForm

function Tfs_List.ListAnalizeChildAnalizeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для ListAnalize }
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsListAnalize;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.ListAnalizeChildAnalizeNeedMakeForm

class function Tfs_List.Instance: Tfs_List;
 {* Метод получения экземпляра синглетона Tfs_List }
begin
 if (g_Tfs_List = nil) then
 begin
  l3System.AddExitProc(Tfs_ListFree);
  g_Tfs_List := Create;
 end;
 Result := g_Tfs_List;
end;//Tfs_List.Instance

class function Tfs_List.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_List <> nil;
end;//Tfs_List.Exists

procedure Tfs_List.InitFields;
begin
 inherited;
 with AddZone('List', vcm_ztParent, fm_efList) do
 begin
  UserType := lftNone;
  with AddZone('remListModified', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := remListModified;
   OnNeedMakeForm := RemListModifiedChildRemListModifiedNeedMakeForm;
  end;
  with AddZone('remListFiltered', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := remListFiltered;
   OnNeedMakeForm := RemListFilteredChildRemListFilteredNeedMakeForm;
  end;
  with AddZone('remTimeMachineWarning', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := remTimeMachineWarning;
   OnNeedMakeForm := RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm;
  end;
  OnNeedMakeForm := ListParentLftNoneNeedMakeForm;
 end;
 with AddZone('ListInfo', vcm_ztChild, fm_efListInfo) do
 begin
  UserType := liListInfo;
  OnNeedMakeForm := ListInfoChildLiListInfoNeedMakeForm;
 end;
 with AddZone('Filters', vcm_ztNavigator, fm_enFilters) do
 begin
  UserType := utFilters;
  ActivateIfUpdate := wafAlways;
  OnNeedMakeForm := FiltersNavigatorUtFiltersNeedMakeForm;
 end;
 with AddZone('SynchroView', vcm_ztChild, fm_fcSynchroView) do
 begin
  UserType := svSynchroView;
  with AddZone('Text', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftDocSynchroView;
   with AddZone('WarnJuror', vcm_ztChild, fm_SynchroView_WarningBaloonForm) do
   begin
    UserType := WarnJuror;
    OnNeedMakeForm := WarnJurorChildWarnJurorNeedMakeForm;
   end;
   with AddZone('WarnPreActive', vcm_ztChild, fm_SynchroView_WarningBaloonForm) do
   begin
    UserType := WarnPreActive;
    OnNeedMakeForm := WarnPreActiveChildWarnPreActiveNeedMakeForm;
   end;
   with AddZone('WarnIsAbolished', vcm_ztChild, fm_SynchroView_WarningBaloonForm) do
   begin
    UserType := WarnIsAbolished;
    OnNeedMakeForm := WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm;
   end;
   with AddZone('WarnOnControl', vcm_ztChild, fm_SynchroView_WarningBaloonForm) do
   begin
    UserType := WarnOnControl;
    OnNeedMakeForm := WarnOnControlChildWarnOnControlNeedMakeForm;
   end;
   with AddZone('WarnInactualDocument', vcm_ztChild, fm_SynchroView_WarningBaloonForm) do
   begin
    UserType := WarnInactualDocument;
    OnNeedMakeForm := WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm;
   end;
   with AddZone('WarnRedaction', vcm_ztChild, fm_SynchroView_WarningBaloonForm) do
   begin
    UserType := WarnRedaction;
    OnNeedMakeForm := WarnRedactionChildWarnRedactionNeedMakeForm;
   end;
   OnNeedMakeForm := TextChildDftDocSynchroViewNeedMakeForm;
  end;
  with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
  begin
   UserType := fAttributeSynchroView;
   OnNeedMakeForm := AttributesChildFAttributeSynchroViewNeedMakeForm;
  end;
  with AddZone('Related', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftRelatedSynchroView;
   OnNeedMakeForm := RelatedChildDftRelatedSynchroViewNeedMakeForm;
  end;
  with AddZone('Annotation', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftAnnotationSynchroView;
   OnNeedMakeForm := AnnotationChildDftAnnotationSynchroViewNeedMakeForm;
  end;
  with AddZone('Similar', vcm_ztChild, fm_efList) do
  begin
   UserType := lftSimilarDocumentsSynchroView;
   OnNeedMakeForm := SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm;
  end;
  with AddZone('UserCR1', vcm_ztChild, fm_efList) do
  begin
   UserType := lftUserCRList1_SynchorForm;
   OnNeedMakeForm := UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm;
  end;
  with AddZone('UserCR2', vcm_ztChild, fm_efList) do
  begin
   UserType := lftUserCRList2_SynchorForm;
   OnNeedMakeForm := UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm;
  end;
  with AddZone('Correspondents', vcm_ztChild, fm_efList) do
  begin
   UserType := lftCorrespondentsSynchroForm;
   OnNeedMakeForm := CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm;
  end;
  with AddZone('Respondents', vcm_ztChild, fm_efList) do
  begin
   UserType := lftRespondentsSynchroForm;
   OnNeedMakeForm := RespondentsChildLftRespondentsSynchroFormNeedMakeForm;
  end;
  with AddZone('DocumentWithFlash', vcm_ztChild, fm_DocumentWithFlashForm) do
  begin
   UserType := dwftSynchro;
   OnNeedMakeForm := DocumentWithFlashChildDwftSynchroNeedMakeForm;
  end;
  OnNeedMakeForm := SynchroViewChildSvSynchroViewNeedMakeForm;
 end;
 with AddZone('ListAnalize', vcm_ztChild, fm_ListAnalizeForm) do
 begin
  UserType := Analize;
  OnNeedMakeForm := ListAnalizeChildAnalizeNeedMakeForm;
 end;
 Caption := str_fsListCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_List.InitFields

class function Tfs_List.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_List.GetInstance

function Tfs_List.GetFormSetImplementation: RvcmFormSet;
 {* Возвращает класс реализации сборки }
//#UC START# *52973E60005E_4AA4D6C7036F_var*
//#UC END# *52973E60005E_4AA4D6C7036F_var*
begin
//#UC START# *52973E60005E_4AA4D6C7036F_impl*
 Result := TfstList;
//#UC END# *52973E60005E_4AA4D6C7036F_impl*
end;//Tfs_List.GetFormSetImplementation

procedure Tfs_List.InitForms(const aParams: IvcmFormSetRefreshParams);
 {* Вызывается при создании сборки перед Refresh для инициализации нужных флажков на сборке. }
//#UC START# *52EA619F02FA_4AA4D6C7036F_var*
var
 l_FormSet: IfstList;
 l_SetData: IdList;
 l_SDS: IsdsList;
 
 function lp_IsOrdinalCRSelected(aCRType: TlstCRType;
   out aId: TnsUserCRListId): Boolean;
 var
  I: TnsUserCRListId;
 begin
  for I := Low(TnsUserCRListId) to High(TnsUserCRListId) do
  begin
   with l_SetData.UserCRListInfo[I] do
    Result := (ListType = aCRType) and not bsIsCRNodeAreNotAllDocuments(Node);
   if Result then
   begin
    aId := I;
    Break;
   end;//if Result then
  end;//for I := Low(TnsUserCRListId) to
 end;//lp_IsOrdinalCRSelected

  function lpCRNeedMake(const aDSRef : IvcmFormDataSourceRef;
                        const aType  : TlstCRType;
                        const aNeedMake: TvcmNeedMakeDS): TvcmNeedMakeDS;
  var
   l_List             : TnsUserCRListId;
   l_IsFullCRSelected : Boolean;
  begin
   Result := aNeedMake;
   with aDSRef do
   begin
    l_IsFullCRSelected := lp_IsOrdinalCRSelected(aType, l_List);
    // Отметим, что вместо пользовательской вкладки показывается полный СКР:
    if l_IsFullCRSelected then
     l_SetData.UserCRListInfo[l_List].wKindOfList := bs_ulFullCR;
    // Откроем нормальную СКР вместо пользовательской
    if (aNeedMake = vcm_nmNo) and l_IsFullCRSelected then
    begin
     Result := {StateIfNeedShowFullCRList}vcm_nmYes;
     // Закроем пользовательскую вкладку
     case l_List of
      ulFirst:
       begin
        l_SetData.dsUserCR1Ref.Referred := nil;
        Result := vcm_nmYes;
       end;
      ulSecond:
       begin
        l_SetData.dsUserCR2Ref.Referred := nil;
        Result := vcm_nmYes;
       end;
     end;//case l_List of
    end//if (NeedMake = vcm_nmNo) ...
    else
     // Закроем форму СКР потому, что она была открыта по причине установки
     // пользовательской вкладки в настройках с типом "Все документы", а теперь
     // пользователь установил другой тип
     if (aNeedMake = {StateIfNeedShowFullCRList}vcm_nmYes) and not l_IsFullCRSelected then
     begin
      aDSRef.Referred := nil;
      Result := vcm_nmNo;
     end;
   end;//with aDSRef do
  end;//lpCRNeedMake

  procedure lp_InitUserCRList(const aValue: TnsUserCRListId);
  var
   l_Temp: IbsUserCRListInfoModify;

   function lp_IsUserCRListChanged: Boolean;
   begin
    l_Temp.Assign(l_SetData.UserCRListInfo[aValue]);
     // - скопируем, чтобы позднее сравнить изменились ли параметры
     //   пользовательской вкладки:
    with l_SetData.UserCRListInfo[aValue] do
    begin
     wListType := bsUserCRList(aValue);
     wNode := bsUserCRNode(aValue);
     wHas := l_SDS.IsTypedCRSelected(aValue) and (ListType <> crtNone) and
      l_SDS.HasTypedCRinBigBase(aValue);
     wKindOfList := bs_ulUserCR;
    end;//with SetData.UserCRListInfo[ulSecond] do
    Result := not l_Temp.IsSame(l_SetData.UserCRListInfo[aValue]);
     // - проверим изменились ли данные;
   end;//lp_ReadSettings

   procedure lp_UpdateDSUserCRList;
   begin
    // Инициируем переполучение бизнес объекта для вкладки:
    with l_SetData do
     case aValue of
      ulFirst:
       begin
        dsUserCR1Ref.Referred := nil;
        l_FormSet.UserCR1NeedMakeDS := vcm_nmNo;
       end;
      ulSecond:
       begin
        dsUserCR2Ref.Referred := nil;
        l_FormSet.UserCR2NeedMakeDS := vcm_nmNo;
       end;
      else
       Assert(False);
     end;//case aValue of
   end;//lp_UpdateDSUserCRList

  begin
   l_Temp := TbsUserCRListInfo.Make;
   try
    // Проверим изменились ли параметры:
    if lp_IsUserCRListChanged then
     // Инициируем переполучение бизнес объктов:
     lp_UpdateDSUserCRList;
   finally
    l_Temp := nil;
   end;//try..finally
  end;//lp_InitUserCRList

const
 cNeedMakeDSArr: array[Boolean] of TvcmNeedMakeDS = (vcm_nmNo, vcm_nmYes);

  function lp_CheckRelatedDocNeedMakeDS: TvcmNeedMakeDS;
  begin
   Result := cNeedMakeDSArr[l_SDS.IsRelatedDocActive];
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=565006651
  end;

  function lp_CheckAttributesNeedMakeDS: TvcmNeedMakeDS;
  begin
   Result := cNeedMakeDSArr[l_SDS.IsAttributesActive];
  end;

//#UC END# *52EA619F02FA_4AA4D6C7036F_var*
begin
//#UC START# *52EA619F02FA_4AA4D6C7036F_impl*
 inherited;
 // Для инициализации флажков на сборке нужен реальный SDS, его SetData и
 // сам FormSet, т.к. эта инициализация вызывается перед Refresh, при уже
 // существующей сборке. Получить SDS и его SetData нужно как-то цивилизованнее
 if Supports(aParams.DataSource, IsdsList, l_SDS) then
 try
  if Supports(aParams.DataSource.DataForSave, IdList, l_SetData) then
  try
   if Supports(aParams.FormSet, IfstList, l_FormSet) then
   try
     if not afw.Settings.LoadBoolean(pi_Document_Sheets_Translation,
      dv_Document_Sheets_Translation) then
     l_SetData.dsTranslationRef.Clear;
     // Первый пользовательский список КР:
     lp_InitUserCRList(ulFirst);
     // Второй список КР:
     lp_InitUserCRList(ulSecond);
     // Если в качестве пользовательского СР выбраны "Все документы", то открывается
     // обычный СКР, который можно типизировать:
     l_FormSet.RespondentsNeedMakeDS := lpCRNeedMake(l_SDS.DsRespondentsRef, crtRespondents,
      l_FormSet.RespondentsNeedMakeDS);
     l_FormSet.CorrespondentsNeedMakeDS := lpCRNeedMake(l_SDS.DsCorrespondentsRef, crtCorrespondents,
      l_FormSet.CorrespondentsNeedMakeDS);
     l_FormSet.FiltersNeedMakeDS := CheckNeedMakeFilters(l_FormSet.FiltersNeedMakeDS);

    l_FormSet.RelatedDocNeedMakeDS := lp_CheckRelatedDocNeedMakeDS;

    l_FormSet.AttributesNeedMakeDS := lp_CheckAttributesNeedMakeDS;

   finally
    l_FormSet := nil;
   end;
  finally
   l_SetData := nil;
  end;
 finally
  l_SDS := nil;
 end;
//#UC END# *52EA619F02FA_4AA4D6C7036F_impl*
end;//Tfs_List.InitForms

initialization
 str_fsListCaption.Init;
 {* Инициализация str_fsListCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
